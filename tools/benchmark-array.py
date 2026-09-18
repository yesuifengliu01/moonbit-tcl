"""Same-host new-command workloads; exact results, separate native/Node timings."""
from pathlib import Path
import tkinter,time,statistics,json,subprocess,hashlib,sys,re
root=Path(__file__).resolve().parents[1]
output=sys.argv[1] if len(sys.argv)>1 else 'array-workloads.json'
assert re.fullmatch(r'[a-z0-9-]+\.json',output),'Pass an evidence JSON basename'
t=tkinter.Tcl()
assert t.eval('info patchlevel')=='8.6.15'
workloads=[
 ('array-populate-1000','array unset a;array set a {};for {set i 0} {$i<1000} {incr i} {set a($i) $i};array size a'),
 ('array-cursor-500','array unset a;array set a {};for {set i 0} {$i<500} {incr i} {set a($i) $i};set s [array startsearch a];set total 0;while {[array anymore a $s]} {set k [array nextelement a $s];incr total $a($k)};array donesearch a $s;set total'),
 ('array-statistics-500','array unset a;array set a {};for {set i 0} {$i<500} {incr i} {set a($i) $i};lindex [split [array statistics a] \\n] 0'),
 ('array-retained-100','array unset a;array set a {};proc p {} {for {set i 0} {$i<100} {incr i} {upvar #0 a($i) slot$i};array size ::a};p;lindex [split [array statistics a] \\n] 0'),
 ('array-glob-500','array unset a;array set a {};for {set i 0} {$i<500} {incr i} {set a(key$i) $i};llength [array names a *5*]'),
 ('array-mutate-200','array unset a;array set a {};set total 0;for {set i 0} {$i<200} {incr i} {set s [array startsearch a];set a($i) $i;incr total [catch {array anymore a $s}]};set total'),
]

rows=[]
for name,source in workloads:
    samples=[]
    for i in range(40):
        start=time.perf_counter_ns();result=t.eval(source);elapsed=(time.perf_counter_ns()-start)/1e6
        if i>=10:samples.append(elapsed)
    rows.append(dict(name=name,source=source,result=result,nativeMedianMs=statistics.median(samples)))
script='''import {new_session,session_eval,close_session} from './web/engine.mjs';
import assert from 'node:assert/strict';
const rows=ROWS;
for(const row of rows){const id=new_session(),samples=[];
 try{for(let i=0;i<40;i++){
  const start=performance.now(),value=JSON.parse(session_eval(id,row.source)),elapsed=performance.now()-start;
  assert.equal(value.ok,true,row.name+': '+JSON.stringify(value));assert.equal(value.result,row.result);assert.equal(value.output,'');
  if(i>=10)samples.push(elapsed);
 }}finally{close_session(id)}
 samples.sort((a,b)=>a-b);row.currentMedianMs=(samples[14]+samples[15])/2;
 row.currentP95Ms=samples[28];row.systemTclRatio=row.currentMedianMs/row.nativeMedianMs;row.resultMatched=true;
}
console.log(JSON.stringify({runtime:process.version,rows}));'''.replace('ROWS',json.dumps(rows,ensure_ascii=True))
result=subprocess.run(['node','--input-type=module','-'],input=script,text=True,encoding='utf-8',cwd=root,capture_output=True,check=True)
report=json.loads(result.stdout)
report.update(reference='Windows Tcl 8.6.15',warmups=10,measurements=30,engineSHA256=hashlib.sha256((root/'web/engine.mjs').read_bytes()).hexdigest(),scope='Six small warm-session array workloads, native and Node measured separately on one host; exact results verified. Different host adapters; no full application, peak memory or cross-platform acceptance.')
(root/'evidence'/output).write_text(json.dumps(report,indent=2)+'\n',encoding='utf-8',newline='\n')
print(json.dumps({r['name']:r['systemTclRatio'] for r in report['rows']}))
