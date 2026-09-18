import fs from 'node:fs';
import {createHash} from 'node:crypto';
import {pathToFileURL} from 'node:url';
import {execFileSync} from 'node:child_process';
import assert from 'node:assert/strict';
import os from 'node:os';
import * as current from '../web/engine.mjs';
const baselineCommit=process.argv[3]||'8c161948071003589cb203f1032e152ee26a1810';
const outputName=process.argv[4]||'performance-comparison.json';
if(!/^[a-z0-9-]+\.json$/.test(outputName))throw new Error('Output must be an evidence JSON basename');
const referenceName=process.argv[5]||'semantic-benchmark-reference.json';
if(!/^[a-z0-9-]+\.json$/.test(referenceName))throw new Error('Reference must be an evidence JSON basename');
const baselinePath=process.argv[2];
if(!baselinePath)throw new Error('Pass a local baseline-engine.mjs extracted from '+baselineCommit);
const sha=data=>createHash('sha256').update(data).digest('hex');
const expected=sha(execFileSync('git',['show',baselineCommit+':web/engine.mjs'],{maxBuffer:10000000}));
assert.equal(sha(fs.readFileSync(baselinePath)),expected,'Baseline must match committed engine');
const baseline=await import(pathToFileURL(baselinePath).href);
const referenceBytes=fs.readFileSync(new URL('../evidence/'+referenceName,import.meta.url));
const reference=JSON.parse(referenceBytes);
const rows=[];
for(const row of reference.rows){
 const engines=[baseline,current],ids=engines.map(engine=>engine.new_session()),samples=[[],[]];
 try{
  for(let iteration=0;iteration<50;iteration++){
   // Alternate order to reduce systematic clock/load bias between versions.
   for(const index of iteration%2?[1,0]:[0,1]){
    const start=performance.now(),actual=JSON.parse(engines[index].session_eval(ids[index],row.source)),elapsed=performance.now()-start;
    assert.equal(actual.ok,true,row.name+': '+JSON.stringify(actual));assert.equal(actual.result,row.result,row.name);assert.equal(actual.output,'',row.name);
    if(iteration>=20)samples[index].push(elapsed);
   }
  }
 }finally{engines.forEach((engine,index)=>engine.close_session(ids[index]))}
 samples.forEach(values=>values.sort((a,b)=>a-b));
 const med=values=>(values[14]+values[15])/2;
 const nativeMedian=row.sessionMedianMs??row.nativeMedianMs;
 assert.ok(Number.isFinite(nativeMedian)&&nativeMedian>0,row.name+': missing native median');
 rows.push({name:row.name,baselineMedianMs:med(samples[0]),currentMedianMs:med(samples[1]),baselineP95Ms:samples[0][28],currentP95Ms:samples[1][28],speedup:med(samples[0])/med(samples[1]),systemTclMedianMs:nativeMedian,systemTclRatio:med(samples[1])/nativeMedian,resultMatched:true});
}
const report={baselineCommit,baselineEngineSHA256:expected,currentEngineSHA256:sha(fs.readFileSync(new URL('../web/engine.mjs',import.meta.url))),referenceName,referenceSHA256:sha(referenceBytes),runtime:process.version,cpu:os.cpus()[0].model,warmups:20,measurements:30,rows,scope:'Same-process interleaved version comparison using independent Tcl outputs. System Tcl is timed separately on the same host. Warm interpreter sessions; no full upstream or cross-platform performance claim.'};
fs.writeFileSync(new URL('../evidence/'+outputName,import.meta.url),JSON.stringify(report,null,2)+'\n');
console.log(JSON.stringify(rows));
