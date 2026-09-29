import fs from 'node:fs';
import path from 'node:path';
import os from 'node:os';
import assert from 'node:assert/strict';
import {fileURLToPath} from 'node:url';
import {spawnSync} from 'node:child_process';
import {createHash} from 'node:crypto';
import {evaluate} from '../web/engine.mjs';
import {FileSession} from './file-session.mjs';

const root=fileURLToPath(new URL('../',import.meta.url)),fixture=path.join(root,'examples/tcllib-csv');
const hash=bytes=>createHash('sha256').update(bytes).digest('hex');
const manifest=JSON.parse(fs.readFileSync(path.join(fixture,'SOURCE.json'),'utf8'));
for(const [file,digest] of Object.entries(manifest.files))assert.equal(hash(fs.readFileSync(path.join(fixture,file))),digest,file);
const library=fs.readFileSync(path.join(fixture,'csv.tcl'),'utf8');
const cases=[
 ['plain','::csv::split {a,b,c}'],
 ['quoted separators','::csv::split {"a,b","c""d",}'],
 ['empty fields','::csv::split {,,}'],
 ['unicode','::csv::split {名字,数据,中文}'],
 ['multiline field','::csv::split {"first\nsecond",tail}'],
 ['semicolon','::csv::split {a;"b;c"} {;}'],
 ['alternate','::csv::split -alternate {a,"b,c","d""e"}'],
 ['custom delimiter',"::csv::split {a;'b;c'} {;} {'}"],
 ['join','::csv::join [list {a,b} {c"d} {}]'],
 ['always quote','::csv::join [list a {}] , \\" always'],
 ['roundtrip','::csv::split [::csv::join [list {a b} {c,d} {e"f} {} 中文]]'],
 ['joinlist','::csv::joinlist [list [list a b] [list {c,d} {e"f}]]'],
 ['incomplete record','list [::csv::iscomplete {"a}] [::csv::iscomplete {"a"}]'],
 ['invalid separator','catch {::csv::split {a,b} {::}}'],
 ['invalid delimiter','catch {::csv::split {a,b} , {::}}'],
 ['alternative package selection','package ifneeded demo 1.8 {package provide demo 1.8}; package ifneeded demo 2.3 {package provide demo 2.3}; list [package require demo 1.0 2.0] [package present demo 1.0 2.0]'],
 ['invalid later requirement','package provide demo 1.8; catch {package require demo 1.0 bad}'],
].map(([name,source])=>({name,source}));
const reference=spawnSync(process.env.PYTHON??(process.platform==='win32'?'python':'python3'),[path.join(root,'tools/tcllib-reference.py')],{input:JSON.stringify({library,cases}),encoding:'utf8',windowsHide:true,timeout:30000,maxBuffer:4*1024*1024});
assert.equal(reference.status,0,reference.stderr||String(reference.error));
const expected=JSON.parse(reference.stdout);assert.equal(expected.results.length,cases.length);
const results=cases.map((test,i)=>{
 const actual=JSON.parse(evaluate('package provide Tcl 8.6\n'+library+'\n'+test.source));
 assert.equal(actual.ok,expected.results[i].ok,test.name+': '+actual.error);
 assert.equal(actual.result,expected.results[i].result,test.name);
 return {name:test.name,matched:true};
});
const temp=fs.mkdtempSync(path.join(os.tmpdir(),'moon-tcl-csv-'));
let consumer;
try{
 fs.cpSync(fixture,temp,{recursive:true});
 const session=new FileSession(temp);
 try{consumer=session.eval('source filter.tcl');}finally{session.close();}
 assert(consumer.ok,consumer.error);assert.equal(consumer.result,'2');
 const output=fs.readFileSync(path.join(temp,'output.csv'),'utf8');
 assert.equal(output,'"part,one",src/a b.mbt,keep\n"line\ntwo","a""b",keep\n');
 consumer={rows:2,outputSha256:hash(Buffer.from(output)),retainsQuotedSeparator:true,retainsMultiline:true};
}finally{assert(path.resolve(temp).startsWith(path.resolve(os.tmpdir())+path.sep));fs.rmSync(temp,{recursive:true,force:true});}
const receipt={utc:new Date().toISOString(),upstream:manifest,referenceVersion:expected.referenceVersion,results,consumer,engineSha256:hash(fs.readFileSync(path.join(root,'web/engine.mjs'))),limits:['application explicitly opts into tested Tcl 8.6 package profile','not all Tcllib csv APIs; matrix/queue adapters untested','no Tcl/EDA completeness or customer adoption claim']};
const output=process.env.TCL_CSV_EVIDENCE??path.join(root,'evidence/tcllib-csv.json');
fs.mkdirSync(path.dirname(output),{recursive:true});fs.writeFileSync(output,JSON.stringify(receipt,null,2)+'\n');console.log(`${results.length} live Tcl comparisons and public-library file consumer passed (${expected.referenceVersion})`);
