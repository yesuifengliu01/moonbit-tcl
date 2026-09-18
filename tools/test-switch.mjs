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
 ['set value abc;switch $value a {error no} abc {list exact} default {error no}','exact'],
 ['switch -glob -nocase ABC a* - b* {list shared} default {error no}','shared'],
 ['switch -regexp -matchvar m -indexvar ix xxabbbz {a(b+)} {list matched}','matched'],
 ['list $m $ix','{abbb bbb} {{2 5} {3 5}}'],
 ['switch -regexp -matchvar m -indexvar ix x a {};list $m $ix','{abbb bbb} {{2 5} {3 5}}'],
 ['switch -regexp -matchvar m -indexvar ix x a {} default {};list $m $ix','{} {}'],
 ['switch -regexp -matchvar m aa {(a|aa)} {set m}','aa aa'],
 ['switch -regexp -matchvar m abab {(ab)\\1} {set m}','abab ab'],
 ['switch -regexp -matchvar m ac {a(?!b)} {set m}','a'],
 ['proc dispatch x {switch $x a {return yes} default {return no}};list [dispatch a] [dispatch b]','yes no'],
 ['scan 18446744073709551616 %f v;switch a a [list set saved $v];format %.17g $saved','1.8446744073709552e+19'],
 ['switch -regexp -matchvar m abc {(a)} - {(invalid} {set m}','a a'],
 ['set data kept;catch {switch -regexp x {(} {error unreachable}} r o;list $data [lindex [dict get $o -errorcode] 1]','kept REG_EPAREN'],
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
 same((await send({source:'set touched kept;switch -regexp abc {(a)} {puts before;error failed}'})).ok,false);
 same((await send({source:'list after failure $touched'})).result,'after failure kept');
 same((await send({reset:true})).ok,true);
 same((await send({source:'info exists v'})).result,'0');
}finally{clearTimeout(timeout);await worker.terminate()}
const report={checks,passed:checks,engineSHA256:createHash('sha256').update(fs.readFileSync(new URL('../web/engine.mjs',import.meta.url))).digest('hex'),scope:'Persistent module sessions, real JSONL CLI and actual web Worker module with a Node message adapter; exact/glob/regexp dispatch, captures and inclusive indices, no-match/default write semantics, greedy alternation, backreferences/lookahead, procedure completion, typed body values, fallthrough without compiling skipped patterns, structured regex errors, recovery and reset. Separate browser evidence required.'};
fs.writeFileSync(new URL('../evidence/switch-hosts.json',import.meta.url),JSON.stringify(report,null,2)+'\n');
console.log(JSON.stringify(report));
