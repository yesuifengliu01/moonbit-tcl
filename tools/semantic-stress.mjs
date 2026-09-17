import assert from 'node:assert/strict';
import fs from 'node:fs';
import {Worker,isMainThread,parentPort} from 'node:worker_threads';
import {evaluate} from '../web/engine.mjs';
const cases=[
 ['integer-power','expr {2**1000000000}',false],
 ['integer-shift','expr {1 << 1000000000}',false],
 ['negative-shift','expr {1 << -1}',false],
 ['string-growth','string repeat x 1000001',false],
 ['nested-growth','set s [string repeat x 500000]; append s $s x',false],
 ['array-value-growth','set a(x) [string repeat x 1000000]; append a(x) x',false],
 ['dictionary-growth','dict set d x [string repeat x 1000000]',false],
 ['glob-work','string match [string repeat ? 2000] [string repeat x 2000]',false],
 ['execution-budget','while {1} {}',false],
 ['recursive-procedure','proc p {} {p}; p',false],
 ['expression-depth','expr {'+'('.repeat(90)+'1'+')'.repeat(90)+'}',false],
 ['script-size',' '.repeat(100001),false],
 ['signed-input','incr a --1',false],
 ['precise-comparison','expr {9007199254740993 > 9007199254740992.0}',true,'1'],
 ['lazy-rejection','expr {0 && [error not-run]}',true,'0'],
 ['alias-lifetime','set a(x) 1; upvar #0 a(x) y; unset a; set y 7; set a(x)',true,'7'],
 ['writeback-error','set d {x 1}; catch {dict with d {incr x; error bad}}; set d',true,'x 2'],
];
if(isMainThread){
 const worker=new Worker(new URL(import.meta.url));
 const timer=setTimeout(()=>{worker.terminate();console.error('Semantic resource tests exceeded 20 seconds');process.exitCode=1},20000);
 worker.on('message',report=>{clearTimeout(timer);fs.writeFileSync(new URL('../evidence/semantic-stress.json',import.meta.url),JSON.stringify(report,null,2)+'\n');console.log(JSON.stringify({stressChecks:report.cases,passed:report.passed}))});
 worker.on('error',error=>{clearTimeout(timer);console.error(error);process.exitCode=1});
}else{
 const start=performance.now();const rows=[];
 for(const [name,source,ok,result] of cases){
  const actual=JSON.parse(evaluate(source));assert.equal(actual.ok,ok,name+': '+JSON.stringify(actual));
  if(result!==undefined)assert.equal(actual.result,result,name);
  rows.push({name,passed:true});
 }
 parentPort.postMessage({cases:rows.length,passed:rows.length,milliseconds:performance.now()-start,scope:'Bounded resource rejection and recovery cases; not a multi-tenant isolation guarantee',rows});
}
