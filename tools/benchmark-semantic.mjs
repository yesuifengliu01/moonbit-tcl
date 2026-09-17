import fs from 'node:fs';
import assert from 'node:assert/strict';
import {evaluate,new_session,session_eval,close_session} from '../web/engine.mjs';
const reference=JSON.parse(fs.readFileSync(new URL('../evidence/semantic-benchmark-reference.json',import.meta.url),'utf8'));
const rows=reference.rows.map(row=>{
 const samples=[];
 for(let i=0;i<25;i++){
  const start=performance.now(),actual=JSON.parse(evaluate(row.source)),elapsed=performance.now()-start;
  assert.equal(actual.ok,true,row.name+JSON.stringify(actual));assert.equal(actual.result,row.result,row.name);
  if(i>=5)samples.push(elapsed);
 }
 samples.sort((a,b)=>a-b);const medianMs=(samples[9]+samples[10])/2;
 const id=new_session(),hot=[];
 try{for(let i=0;i<25;i++){
  const start=performance.now(),actual=JSON.parse(session_eval(id,row.source)),elapsed=performance.now()-start;
  assert.equal(actual.result,row.result,row.name);if(i>=5)hot.push(elapsed);
 }}finally{close_session(id)}
 hot.sort((a,b)=>a-b);const sessionMedianMs=(hot[9]+hot[10])/2;
 return {name:row.name,medianMs,p95Ms:samples[18],referenceMedianMs:row.medianMs,medianRatio:medianMs/row.medianMs,sessionMedianMs,sessionP95Ms:hot[18],referenceSessionMedianMs:row.sessionMedianMs,sessionMedianRatio:sessionMedianMs/row.sessionMedianMs};
});
fs.writeFileSync(new URL('../evidence/semantic-benchmark.json',import.meta.url),JSON.stringify({warmups:5,measurements:20,scope:reference.scope,rows},null,2)+'\n');
console.log(JSON.stringify(rows));
