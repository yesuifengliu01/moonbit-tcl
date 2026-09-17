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
const steps=[
 ['namespace eval Counter {variable n 0;proc bump {{by 1}} {variable n;incr n $by};namespace export bump;namespace ensemble create};namespace import Counter::bump;list [bump 2] [Counter b 3]','2 5'],
 ['proc Counter::bump {{by 1}} {variable n;incr n [expr {$by*2}]};list [bump 2] [Counter b 1]','9 11'],
 ['rename Counter::bump Counter::add;namespace ensemble configure Counter -map {bump ::Counter::add};list [bump 3] [Counter b 2] [namespace origin bump]','17 21 ::Counter::add'],
 ['namespace eval Client {namespace path ::Counter;add 2}','25'],
 ['namespace forget Counter::add;list [catch {bump}] [Counter b 1]','1 27'],
 ['namespace delete Counter;list [catch {Counter b 1}] [namespace eval Client {namespace path}]','1 {}'],
];
const a=new_session(),b=new_session();
try{
 for(const [source,result] of steps){same(JSON.parse(session_eval(a,source)),{ok:true,result,output:''})}
 same(JSON.parse(session_eval(b,'namespace exists Client')).result,'0');
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
 same((await send({source:'namespace eval loop {namespace ensemble create -map {go {::loop go}}};loop go'})).ok,false);
 same((await send({source:'list after failure'})).result,'after failure');
 same((await send({reset:true})).ok,true);
 same((await send({source:'namespace exists Client'})).result,'0');
}finally{clearTimeout(timeout);await worker.terminate()}
const report={checks,passed:checks,engineSHA256:createHash('sha256').update(fs.readFileSync(new URL('../web/engine.mjs',import.meta.url))).digest('hex'),scope:'Persistent module sessions, real JSONL CLI and the actual web Worker module with a Node message adapter; separate browser evidence required.'};
fs.writeFileSync(new URL('../evidence/namespace-hosts.json',import.meta.url),JSON.stringify(report,null,2)+'\n');
console.log(JSON.stringify(report));
