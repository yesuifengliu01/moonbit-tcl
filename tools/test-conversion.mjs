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
 ['set line [format {%04d|%.2f|%-6s} 23 1.375 apple];set line','0023|1.38|apple '],
 ['scan $line {%d|%f|%s} id amount item;list $id $amount $item','23 1.38 apple'],
 ['format {%2$s:%1$04d:%3$*.*f} 7 key 8 2 1.25','key:0007:    1.25'],
 ['set n [expr {2**96+7}];set hex [format %llx $n];scan $hex %llx copy;expr {$n==$copy}','1'],
 ['scan {12 34} {%2$d %1$d} a a;set a','12'],
 ['scan {NaN(abc) 7} {%*f%d%n}','7 10'],
 ['list [format %.0f 2.5] [format %.0f 3.5] [format %.2f 2.675]','2 4 2.67'],
 ['scan 中文 {%c%n%s}','20013 3 文'],
 ['format %.1s 😀','\ud83d'],
 ['set a old;set b kept;scan {12 x} {%d%d} a b;list $a $b','12 kept'],
 ['catch {scan {12 34} {%d%q} a b};list $a $b','12 kept'],
 ['list [scan {} %d a] [scan x %d a]','-1 0'],
 ['scan 1e9999 %f','Inf'],
 ['format {%-010d|%-010s} 12 x','0000000012|x000000000'],
];
const a=new_session(),b=new_session();
try{
 for(const [source,result] of steps){same(JSON.parse(session_eval(a,source)),{ok:true,result,output:''})}
 same(JSON.parse(session_eval(b,'info exists line')).result,'0');
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
 same((await send({source:'info exists line'})).result,'0');
}finally{clearTimeout(timeout);await worker.terminate()}
const report={checks,passed:checks,engineSHA256:createHash('sha256').update(fs.readFileSync(new URL('../web/engine.mjs',import.meta.url))).digest('hex'),scope:'Persistent module sessions, real JSONL CLI and actual web Worker module with a Node message adapter; Format/scan precision, arbitrary integers, positional assignment order, suppression, Unicode JSON, partial writes and recovery. Separate browser evidence required.'};
fs.writeFileSync(new URL('../evidence/conversion-hosts.json',import.meta.url),JSON.stringify(report,null,2)+'\n');
console.log(JSON.stringify(report));
