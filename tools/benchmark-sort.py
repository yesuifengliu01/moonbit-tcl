"""Same-host new-command workloads; exact results, separate native/Node timings."""
from pathlib import Path
import tkinter,time,statistics,json,subprocess,hashlib,sys,re
root=Path(__file__).resolve().parents[1]
output=sys.argv[1] if len(sys.argv)>1 else 'sort-workloads.json'
assert re.fullmatch(r'[a-z0-9-]+\.json',output),'Pass an evidence JSON basename'
t=tkinter.Tcl()
assert t.eval('info patchlevel')=='8.6.15'
workloads=[
 ('sort-integer-1000','set v {};for {set i 1000} {$i>0} {incr i -1} {lappend v $i};lindex [lsort -integer $v] end'),
 ('sort-stride-200','set v {};for {set i 200} {$i>0} {incr i -1} {lappend v rack$i $i};lindex [lsort -stride 2 -index 1 -integer $v] end'),
 ('sort-indices-500','set v {};for {set i 500} {$i>0} {incr i -1} {lappend v $i};lindex [lsort -integer -indices $v] end'),
 ('sort-nested-100','set v {};for {set i 100} {$i>0} {incr i -1} {lappend v [list rack$i [list value $i]]};lindex [lsort -integer -index {1 1} $v] 0'),
 ('sort-command-100','proc cmp {a b} {expr {$a-$b}};set v {};for {set i 100} {$i>0} {incr i -1} {lappend v $i};lindex [lsort -command cmp $v] end'),
 ('sort-unique-200','set v {};for {set i 200} {$i>0} {incr i -1} {lappend v row$i [expr {$i%10}]};llength [lsort -stride 2 -index 1 -integer -unique $v]'),
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
report.update(reference='Windows Tcl 8.6.15',warmups=10,measurements=30,engineSHA256=hashlib.sha256((root/'web/engine.mjs').read_bytes()).hexdigest(),scope='Six small warm-session sorting workloads, native and Node measured separately on one host; exact results verified. Different host adapters; no full application, peak memory or cross-platform acceptance.')
(root/'evidence'/output).write_text(json.dumps(report,indent=2)+'\n',encoding='utf-8',newline='\n')
print(json.dumps({r['name']:r['systemTclRatio'] for r in report['rows']}))
