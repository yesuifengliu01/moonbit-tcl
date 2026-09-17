"""Regenerate independent fixtures/API/engine twice and detect artifact drift."""
from pathlib import Path
import hashlib,json,os,shutil,subprocess,sys
root=Path(__file__).resolve().parents[1]
moon=Path(sys.argv[1] if len(sys.argv)>1 else shutil.which('moon') or 'moon').resolve()
env={**os.environ,'MOON_HOME':str(moon.parent.parent),'PATH':str(moon.parent)+os.pathsep+os.environ.get('PATH','')}
def run(*args):subprocess.run(args,cwd=root,env=env,check=True,stdout=subprocess.DEVNULL)
paths=subprocess.check_output(['git','ls-files','--cached','--others','--exclude-standard','-z'],cwd=root).decode().split('\0')
paths=sorted({p for p in paths if p and not p.startswith('evidence/')})
paths+=['evidence/'+suite+'-reference.json' for suite in ['semantic','cache','namespace','completion']]
def snapshot():
    return {p:hashlib.sha256((root/p).read_bytes().replace(b'\r\n',b'\n')).hexdigest() for p in paths}
baseline=snapshot()
cycles=[]
for cycle in range(2):
    run(sys.executable,'tools/generate_list_oracle.py')
    for suite in ['semantic','cache','namespace','completion']:run(sys.executable,'tools/generate-semantic-oracle.py',suite)
    for args in [('fmt',),('info',),('build','--target','js','--deny-warn')]:run(str(moon),*args)
    candidates=[p for p in (root/'_build/js').rglob('*.js') if p.parent.name=='web' and p.name in ['main.js','web.js']]
    if not candidates:raise SystemExit('Generated web engine not found')
    shutil.copyfile(max(candidates,key=lambda p:p.stat().st_mtime),root/'web/engine.mjs')
    after=snapshot()
    drift=[p for p in paths if baseline[p]!=after[p]]
    if drift:raise SystemExit('Generation drift: '+', '.join(drift))
    cycles.append({'cycle':cycle+1,'files':len(paths),'unchanged':True})
report={'cycles':cycles,'scope':'Two independent Tcl fixture regeneration, MoonBit fmt/info/build and shipped-engine refresh cycles; LF-normalized file digests. Timing reports are excluded.','files':baseline}
(root/'evidence/generation-completion.json').write_text(json.dumps(report,indent=2)+'\n',encoding='utf-8',newline='\n')
print(json.dumps({'cycles':len(cycles),'files':len(paths),'unchanged':True}))
