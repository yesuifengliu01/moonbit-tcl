import assert from 'node:assert/strict';
import {spawnSync} from 'node:child_process';
import {Worker} from 'node:worker_threads';
import {once} from 'node:events';
import fs from 'node:fs';
import {new_session,session_eval,reset_session,close_session,evaluate} from '../web/engine.mjs';
let checks=0;
const same=(actual,expected)=>{assert.deepEqual(actual,expected);checks++};
const a=new_session(),b=new_session();
const run=(id,source)=>JSON.parse(session_eval(id,source));
same(run(a,'set x 4; puts -nonewline A'),{ok:true,result:'',output:'A'});
same(run(a,'incr x; puts B; set x'),{ok:true,result:'5',output:'B\n'});
same(run(b,'info exists x').result,'0');
same(run(a,'set x 6; puts before; error bad').ok,false);
same(run(a,'set x').result,'6');
same(run(a,'set x 7; set bad {').ok,false);
same(run(a,'set x').result,'7');
same(run(a,'namespace eval n {variable d {x 1}; proc bump {} {variable d; dict incr d x}}; n::bump').result,'x 2');
same(run(a,'n::bump').result,'x 3');
same(reset_session(a),true);
same(run(a,'info exists x').result,'0');
close_session(a);close_session(b);
same(run(a,'set x 1').ok,false);
same(JSON.parse(evaluate('set x 1')).result,'1');
same(JSON.parse(evaluate('info exists x')).result,'0');
const cli=new URL('./cli.mjs',import.meta.url);
// fileURLToPath also supports Unix and percent-escaped paths.
const {fileURLToPath}=await import('node:url');
function command(args,input){return spawnSync(process.execPath,[fileURLToPath(cli),...args],{input,encoding:'utf8',timeout:15000})}
const requests=[{source:'set x 10'},{source:'incr x'},{source:'puts note; error bad'},{source:'set x'},{reset:true},{source:'info exists x'}];
const result=command(['--session'],requests.map(r=>JSON.stringify(r)).join('\n'));
same(result.status,2);
const rows=result.stdout.trim().split('\n').map(JSON.parse);
same(rows.map(r=>r.ok),[true,true,false,true,true,true]);
same(rows.map(r=>r.result??null),['10','11',null,'11',null,'0']);
same(rows[2].output,'note\n');
same(command(['--eval-json','--input','puts -nonewline hi; expr {2**64}']).status,0);
same(JSON.parse(command(['--eval-json','--input','puts -nonewline hi; expr {2**64}']).stdout),{ok:true,result:'18446744073709551616',output:'hi'});
same(command(['--session','--json'],'').status,1);
same(command(['--session'],'{"wrong":true}').status,1);
const workerURL=new URL('../web/worker.mjs',import.meta.url).href;
const wrapper='const {parentPort}=await import("node:worker_threads");globalThis.postMessage=m=>parentPort.postMessage(m);await import('+JSON.stringify(workerURL)+');parentPort.on("message",data=>globalThis.onmessage({data}));parentPort.postMessage({ready:true});';
const worker=new Worker(wrapper,{eval:true});
try{
 await once(worker,'message');
 async function send(request){worker.postMessage(request);const [result]=await once(worker,'message');return result}
 same((await send({id:1,source:'set x 4'})).result,'4');
 same((await send({id:2,source:'incr x'})).result,'5');
 same((await send({id:3,source:'puts oops; error broken'})).output,'oops\n');
 same((await send({id:4,source:'set x'})).result,'5');
 same((await send({id:5,reset:true})).reset,true);
 same((await send({id:6,source:'info exists x'})).result,'0');
 same((await send({id:7,source:42})).ok,false);
}finally{await worker.terminate()}
fs.writeFileSync(new URL('../evidence/session-validation.json',import.meta.url),JSON.stringify({checks,passed:checks,scope:'Independent module sessions, real JSON-lines CLI, actual browser Worker module through Node message adapter'},null,2)+'\n');
console.log(JSON.stringify({sessionChecks:checks,passed:checks}));
