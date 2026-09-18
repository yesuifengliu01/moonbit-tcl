"""Isolate known native reference hazards; never count them as passing oracles."""
from pathlib import Path
import json,platform,subprocess,sys
root=Path(__file__).resolve().parents[1]
programs=['string tolower 😀Ab','string toupper 😀Ab','string totitle 😀Ab','string trim "𐀠x𐀠"','string trimright "𐀠x𐀠"']
rows=[]
for source in programs:
    code='''import sys,tkinter,json
if sys.platform=='win32':
 import ctypes
 ctypes.windll.kernel32.SetErrorMode(0x8003)
t=tkinter.Tcl()
assert t.eval('info patchlevel')=='8.6.15'
result=t.eval('''+repr(source)+''')
print(json.dumps({'result':result,'codepoints':[ord(c) for c in result]},ensure_ascii=True),flush=True)
'''
    try:
        child=subprocess.run([sys.executable,'-c',code],capture_output=True,timeout=30)
        rows.append({'source':source,'exitCode':child.returncode,'stdout':child.stdout.decode('ascii','backslashreplace'),'stderr':child.stderr.decode('ascii','backslashreplace')})
    except subprocess.TimeoutExpired:rows.append({'source':source,'timeoutSeconds':30})
report={'reference':'System Tcl 8.6.15 through tkinter','platform':platform.platform(),'python':sys.version,'rows':rows,'scope':'Known excluded reference hazards. Supplementary case-conversion crashes and invalid UTF-8 trim outputs are not counted as passing compatibility cases. Local UTF-16 preservation guarantees have separate API tests.'}
(root/'evidence/unicode-reference-limits.json').write_text(json.dumps(report,ensure_ascii=True,indent=2)+'\n',encoding='utf-8',newline='\n')
print(json.dumps(rows,ensure_ascii=True))
