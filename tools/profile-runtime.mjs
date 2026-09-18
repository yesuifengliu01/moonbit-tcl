import fs from 'node:fs';
import inspector from 'node:inspector/promises';
import assert from 'node:assert/strict';
import {createHash} from 'node:crypto';
import * as engine from '../web/engine.mjs';
const output=process.argv[2];
if(!/^[a-z0-9-]+\.json$/.test(output||''))throw new Error('Pass an evidence JSON basename');
const references=['semantic-benchmark-reference.json','conversion-workloads.json'];
const sha=bytes=>createHash('sha256').update(bytes).digest('hex');
const sources=references.map(name=>{
 const bytes=fs.readFileSync(new URL('../evidence/'+name,import.meta.url));
 return {name,sha256:sha(bytes),rows:JSON.parse(bytes).rows};
});
const rows=[];
for(const row of sources.flatMap(reference=>reference.rows)){
 const profiler=new inspector.Session();profiler.connect();
 await profiler.post('Profiler.enable');await profiler.post('Profiler.setSamplingInterval',{interval:500});
 const id=engine.new_session();let profile;
 try{
  for(let i=0;i<20;i++)assert.equal(JSON.parse(engine.session_eval(id,row.source)).result,row.result);
  await profiler.post('Profiler.start');
  for(let i=0;i<1000;i++){
   const result=JSON.parse(engine.session_eval(id,row.source));
   assert.equal(result.ok,true);assert.equal(result.result,row.result);assert.equal(result.output,'');
  }
  ({profile}=await profiler.post('Profiler.stop'));
 }finally{profiler.disconnect();engine.close_session(id)}
 const nodes=new Map(profile.nodes.map(n=>[n.id,n])),costs=new Map();
 let total=0;
 for(let i=0;i<profile.samples.length;i++){
  const frame=nodes.get(profile.samples[i]).callFrame;
  const key=frame.functionName||'(anonymous)';
  const duration=profile.timeDeltas[i]||0;total+=duration;
  costs.set(key,(costs.get(key)||0)+duration);
 }
 rows.push({name:row.name,samples:profile.samples.length,sampledMicroseconds:total,
  top:[...costs].sort((a,b)=>b[1]-a[1]).slice(0,40).map(([functionName,microseconds])=>({functionName,microseconds,fraction:microseconds/total}))});
}
const report={engineSHA256:sha(fs.readFileSync(new URL('../web/engine.mjs',import.meta.url))),references:sources.map(({name,sha256})=>({name,sha256})),runtime:process.version,warmups:20,iterations:1000,samplingIntervalMicroseconds:500,rows,scope:'V8 statistical CPU self-time samples on ten fixed warm-session workloads, with profiler overhead and independent native result/stdout assertions. These are hotspot diagnostics, not timing comparisons or allocation counts.'};
fs.writeFileSync(new URL('../evidence/'+output,import.meta.url),JSON.stringify(report,null,2)+'\n');
console.log(JSON.stringify(rows.map(r=>({name:r.name,samples:r.samples,top:r.top.slice(0,4)}))));
