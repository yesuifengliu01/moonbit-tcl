import fs from 'node:fs';
import inspector from 'node:inspector/promises';
import assert from 'node:assert/strict';
import {createHash} from 'node:crypto';
import {new_session,session_eval,close_session} from '../web/engine.mjs';
const output=process.argv[2];
if(!/^[a-z0-9-]+\.json$/.test(output||''))throw new Error('Pass an evidence JSON basename');
const cases=JSON.parse(fs.readFileSync(new URL('../evidence/conversion-workloads.json',import.meta.url),'utf8')).rows;
const rows=[];
for(const row of cases){
 const profiler=new inspector.Session();profiler.connect();
 await profiler.post('Profiler.enable');await profiler.post('Profiler.setSamplingInterval',{interval:500});
 const id=new_session();let profile;
 try{
  for(let i=0;i<20;i++)assert.equal(JSON.parse(session_eval(id,row.source)).result,row.result);
  await profiler.post('Profiler.start');
  for(let i=0;i<150;i++){
   const result=JSON.parse(session_eval(id,row.source));
   assert.equal(result.ok,true);assert.equal(result.result,row.result);assert.equal(result.output,'');
  }
  ({profile}=await profiler.post('Profiler.stop'));
 }finally{profiler.disconnect();close_session(id)}
 const nodes=new Map(profile.nodes.map(n=>[n.id,n])),costs=new Map();
 let total=0;
 for(let i=0;i<profile.samples.length;i++){
  const node=nodes.get(profile.samples[i]),key=node.callFrame.functionName;
  const duration=profile.timeDeltas[i]||0;total+=duration;
  costs.set(key,(costs.get(key)||0)+duration);
 }
 rows.push({name:row.name,samples:profile.samples.length,sampledMicroseconds:total,
  top:[...costs].sort((a,b)=>b[1]-a[1]).slice(0,30).map(([functionName,microseconds])=>({functionName,microseconds,fraction:microseconds/total}))});
}
const report={engineSHA256:createHash('sha256').update(fs.readFileSync(new URL('../web/engine.mjs',import.meta.url))).digest('hex'),runtime:process.version,warmups:20,iterations:150,samplingIntervalMicroseconds:500,rows,scope:'V8 statistical CPU self-time samples in three warm-session workloads, including profiler overhead. Results checked against independently generated native outputs. Sampling identifies hotspots; use separate interleaved timings for performance claims.'};
fs.writeFileSync(new URL('../evidence/'+output,import.meta.url),JSON.stringify(report,null,2)+'\n');
console.log(JSON.stringify(rows.map(r=>({name:r.name,samples:r.samples,top:r.top.slice(0,3)}))));
