"""Same-host new-command workloads; exact results, separate native/Node timings."""
from pathlib import Path
import tkinter,time,statistics,json,subprocess,hashlib,sys,re
root=Path(__file__).resolve().parents[1]
output=sys.argv[1] if len(sys.argv)>1 else 'switch-workloads.json'
assert re.fullmatch(r'[a-z0-9-]+\.json',output),'Pass an evidence JSON basename'
t=tkinter.Tcl()
assert t.eval('info patchlevel')=='8.6.15'
workloads=[
 ('switch-exact-200','set total 0;for {set i 0} {$i<200} {incr i} {switch [expr {$i%3}] {0 {incr total 1} 1 {incr total 2} default {incr total 3}}};set total'),
 ('switch-glob-200','set total 0;for {set i 0} {$i<200} {incr i} {switch -glob -nocase {LOG/ready.txt} {*.csv {error wrong} log/* {incr total} default {error missing}}};set total'),
 ('switch-regexp-capture-50',r'set total 0;for {set i 0} {$i<50} {incr i} {switch -regexp -matchvar m -indexvar ix {ADD tea 42} {^ADD ([a-z]+) ([0-9]+)$} {incr total [lindex $m 2]} default {error missing}};list $total $ix'),
 ('switch-regexp-backref-50',r'set total 0;for {set i 0} {$i<50} {incr i} {switch -regexp -matchvar m {abab} {(ab)\1} {incr total} default {error missing}};list $total $m'),
 ('switch-regexp-nested-50','set total 0;for {set i 0} {$i<50} {incr i} {switch -regexp -matchvar m aaabbb {((.)+?)*b?} {incr total} default {error missing}};list $total $m'),
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
report.update(reference='Windows Tcl 8.6.15',warmups=10,measurements=30,engineSHA256=hashlib.sha256((root/'web/engine.mjs').read_bytes()).hexdigest(),scope='Five small warm-session switch workloads, native and Node measured separately on one host; exact results verified. Different host adapters; no full application, peak memory or cross-platform acceptance.')
(root/'evidence'/output).write_text(json.dumps(report,indent=2)+'\n',encoding='utf-8',newline='\n')
print(json.dumps({r['name']:r['systemTclRatio'] for r in report['rows']}))
