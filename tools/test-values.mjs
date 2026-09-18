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
 ['scan 18446744073709551616 %f v','1'],
 ['set v','1.844674407370955e+19'],
 ['format %.17g $v','1.8446744073709552e+19'],
 ['set text [format %s $v];expr {$v==$text}','0'],
 ['proc identity x {return $x};format %.17g [identity $v]','1.8446744073709552e+19'],
 ['dict set a nested value $v;set b $a;dict set b nested value 0;format %.17g [dict get $a nested value]','1.8446744073709552e+19'],
 ['set items [list $v];set copy $items;lset copy 0 0;format %.17g [lindex $items 0]','1.8446744073709552e+19'],
 ['catch [list error $v] result;format %.17g $result','1.8446744073709552e+19'],
 ['catch {return -amount $v ok} result options;format %.17g [dict get $options -amount]','1.8446744073709552e+19'],
 ['set alias $v;string length $alias;format %.17g $v','1.844674407370955e+19'],
 ['scan -0.0 %f zero;format %.1f [expr {$zero*1.0}]','-0.0'],
];
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
 same((await send({source:'set touched kept;array set target {x y};scan {12 34} {%d%d} written target'})).ok,false);
 same((await send({source:'list after failure $touched'})).result,'after failure kept');
 same((await send({reset:true})).ok,true);
 same((await send({source:'info exists v'})).result,'0');
}finally{clearTimeout(timeout);await worker.terminate()}
const report={checks,passed:checks,engineSHA256:createHash('sha256').update(fs.readFileSync(new URL('../web/engine.mjs',import.meta.url))).digest('hex'),scope:'Persistent module sessions, real JSONL CLI and actual web Worker module with a Node message adapter; exact double identity, separate same-text objects, procedure/collection/completion transport, copy isolation, string conversion, negative zero, recovery and reset. Separate browser evidence required.'};
fs.writeFileSync(new URL('../evidence/value-hosts.json',import.meta.url),JSON.stringify(report,null,2)+'\n');
console.log(JSON.stringify(report));
