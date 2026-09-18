import assert from 'node:assert/strict';
import fs from 'node:fs';
import {createHash} from 'node:crypto';
import {spawnSync} from 'node:child_process';
import {Worker} from 'node:worker_threads';
import {once} from 'node:events';
import {fileURLToPath} from 'node:url';
import {new_session,session_eval,close_session} from '../web/engine.mjs';
let checks=0;
const same=(actual,expected)=>{assert.deepEqual(actual,expected);checks++};
const steps=JSON.parse(fs.readFileSync(new URL('./regexp-host-cases.json',import.meta.url),'utf8'));
const a=new_session(),b=new_session();
try{
 for(const [source,result] of steps){same(JSON.parse(session_eval(a,source)),{ok:true,result,output:''})}
 same(JSON.parse(session_eval(b,'info exists v')).result,'0');
}finally{close_session(a);close_session(b)}

const cli=spawnSync(process.execPath,[fileURLToPath(new URL('./cli.mjs',import.meta.url)),'--session'],{
 input:steps.map(([source])=>JSON.stringify({source})).join('\n'),encoding:'utf8',timeout:15000,
});
same(cli.status,0);
const cliRows=cli.stdout.trim().split('\n').map(JSON.parse);
same(cliRows.map(r=>r.result),steps.map(r=>r[1]));
same(cliRows.every(r=>r.ok&&r.output===''),true);

const workerURL=new URL('../web/worker.mjs',import.meta.url).href;
const wrapper='const {parentPort}=await import("node:worker_threads");globalThis.postMessage=m=>parentPort.postMessage(m);await import('+JSON.stringify(workerURL)+');parentPort.on("message",data=>globalThis.onmessage({data}));parentPort.postMessage({ready:true});';
const worker=new Worker(wrapper,{eval:true});
const controller=new AbortController();
const timeout=setTimeout(()=>controller.abort(),15000);
try{
 await once(worker,'message',{signal:controller.signal});
 let id=0;
 async function send(request){const response=once(worker,'message',{signal:controller.signal});worker.postMessage({id:++id,...request});return (await response)[0]}
 for(const [source,result] of steps){const row=await send({source});same([row.ok,row.result,row.output],[true,result,''])}
 same((await send({source:'set touched kept;regsub {(} abc X'})).ok,false);
 same((await send({source:'list after failure $touched'})).result,'after failure kept');
 same((await send({reset:true})).ok,true);
 same((await send({source:'info exists v'})).result,'0');
}finally{clearTimeout(timeout);await worker.terminate()}
const report={checks,passed:checks,engineSHA256:createHash('sha256').update(fs.readFileSync(new URL('../web/engine.mjs',import.meta.url))).digest('hex'),scope:'Persistent module sessions, real JSONL CLI and actual web Worker module through a Node message adapter. Global captures and indices, start/empty boundaries, substitution references, literal optimization, options, metadata, scope, numeric representations, failure recovery and reset. Browser checks are separate.'};
fs.writeFileSync(new URL('../evidence/regexp-hosts.json',import.meta.url),JSON.stringify(report,null,2)+'\n');
console.log(JSON.stringify(report));
