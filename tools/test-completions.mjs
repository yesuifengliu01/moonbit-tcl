import assert from 'node:assert/strict';
import fs from 'node:fs';
import {createHash} from 'node:crypto';
import {spawnSync} from 'node:child_process';
import {Worker} from 'node:worker_threads';
import {once} from 'node:events';
import {fileURLToPath} from 'node:url';
import {new_session,session_eval,close_session,evaluate,run} from '../web/engine.mjs';
let checks=0;
const same=(actual,expected)=>{assert.deepEqual(actual,expected);checks++};
const steps=[
 ['set events {};proc work {} {global events;try {throw {APP RETRY detail} unavailable} trap {APP RETRY} {value options} {lappend events [dict get $options -errorcode];return recovered} finally {lappend events cleaned}};list [work] $events','recovered {{APP RETRY detail} cleaned}'],
 ['set rc [catch {return -level 2 -code error -tag kept result} value options];list $rc $value [dict get $options -code] [dict get $options -level] [dict get $options -tag]','2 result 1 2 kept'],
 ['set rc [catch {try {throw FIRST a} finally {throw FINAL b}} value options];list $rc $value [dict get $options -errorcode] [dict get $options -during -errorcode]','1 b FINAL FIRST'],
 ['set seen {};proc stop {} {return -code break};foreach n {1 2 3} {try {lappend seen $n;stop} finally {lappend seen clean}};set seen','1 clean'],
 ['try {expr {1/0}} trap {ARITH DIVZERO} {} {set recovered yes}','yes'],
 ['return top;error unreachable','top'],
 ['list $recovered [info exists events]','yes 1'],
];
const a=new_session(),b=new_session();
try{
 for(const [source,result] of steps){same(JSON.parse(session_eval(a,source)),{ok:true,result,output:''})}
 same(JSON.parse(session_eval(b,'info exists events')).result,'0');
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
 same((await send({source:'try {throw APP uncaught} finally {set survived yes}'})).ok,false);
 same((await send({source:'list after failure $survived'})).result,'after failure yes');
 same((await send({reset:true})).ok,true);
 same((await send({source:'info exists events'})).result,'0');
}finally{clearTimeout(timeout);await worker.terminate()}
// Diagnostic serialization must retain malformed UTF-16 without host panics.
for(const source of ['\udfff','error \udfff','puts before;error \ud800','set \udfff']){
 const response=JSON.parse(evaluate(source));
 same(response.ok,false);
 same(response.error.startsWith('Invalid('),true);
 same(run(source).startsWith('ERROR: Invalid('),true);
}
const report={checks,passed:checks,engineSHA256:createHash('sha256').update(fs.readFileSync(new URL('../web/engine.mjs',import.meta.url))).digest('hex'),scope:'Persistent module sessions, real JSONL CLI and the actual web Worker module with a Node message adapter; completion options, trap/finally, rethrow, loop control, top-level return and recovery; separate browser evidence required.'};
fs.writeFileSync(new URL('../evidence/completion-hosts.json',import.meta.url),JSON.stringify(report,null,2)+'\n');
console.log(JSON.stringify(report));
