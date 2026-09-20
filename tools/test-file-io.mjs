import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import os from 'node:os';
import {spawnSync} from 'node:child_process';
import {fileURLToPath} from 'node:url';
import {createHash} from 'node:crypto';
import {FileSession} from './file-session.mjs';
import cases from './file-io-cases.mjs';
const python=String.raw`
import json,sys,os,tempfile,tkinter,pathlib
inputs=json.load(sys.stdin);rows=[];base=os.getcwd()
for case in inputs:
 with tempfile.TemporaryDirectory(prefix='moonbit-tcl-reference-') as folder:
  assert pathlib.Path(folder).resolve().parent==pathlib.Path(tempfile.gettempdir()).resolve()
  for name,content in case.get('files',{}).items():
   p=pathlib.Path(folder)/name;p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(content.encode('utf-8'))
  interp=tkinter.Tcl();interp.call('cd',folder)
  code=int(interp.call('catch',case['source'],'result'))
  rows.append(dict(name=case['name'],ok=code==0,result=interp.eval('set result'),version=interp.eval('info patchlevel')))
  interp.call('cd',base);del interp
json.dump(rows,sys.stdout,ensure_ascii=True)
`;
const reference=spawnSync('python',['-c',python],{input:JSON.stringify(cases),encoding:'utf8',env:{...process.env,PYTHONIOENCODING:'utf-8'},timeout:30000});
assert.equal(reference.status,0,reference.stderr);const expected=JSON.parse(reference.stdout),rows=[];
const base=fs.mkdtempSync(path.join(os.tmpdir(),'moonbit-tcl-files-'));
assert.equal(path.dirname(path.resolve(base)),path.resolve(os.tmpdir()));
try{
 for(const [index,input] of cases.entries()){
  const folder=path.join(base,String(index));fs.mkdirSync(folder);
  for(const [name,content]of Object.entries(input.files??{})){const file=path.join(folder,name);fs.mkdirSync(path.dirname(file),{recursive:true});fs.writeFileSync(file,content);}
  const session=new FileSession(folder);let actual;
  try{actual=session.eval(input.source);}finally{session.close();}
  const reference=expected[index],matched=actual.ok===reference.ok&&(!reference.ok||actual.result===reference.result);
  rows.push({name:input.name,source:input.source,reference,actual,matched});if(!matched)console.error(JSON.stringify(rows.at(-1)));
 }
 const session=new FileSession(base);
 try{
  assert.equal(session.eval('catch {open ../outside.txt w}').result,'1');
  assert.equal(session.eval('catch {open {|echo example} r}').result,'1');
  assert.equal(session.eval('catch {file delete -force .}').result,'1');
  assert.equal(session.eval('catch {source missing.tcl}; set after 42').result,'42');
 }finally{session.close();}
 assert.throws(()=>session.eval('set x 1'),/closed/);
 const cli=spawnSync(process.execPath,[fileURLToPath(new URL('./cli.mjs',import.meta.url)),'--fs-root',base,'--eval-json','--input','set f [open cli.txt w+]; fconfigure $f -translation lf; puts $f hello; seek $f 0; set s [read -nonewline $f]; close $f; set s'],{encoding:'utf8',timeout:10000});
 assert.equal(cli.status,0,cli.stderr);assert.equal(JSON.parse(cli.stdout).result,'hello');assert.equal(fs.readFileSync(path.join(base,'cli.txt'),'utf8'),'hello\n');
}finally{fs.rmSync(base,{recursive:true,force:true});}
const files=['io.mbt','packages.mbt','runtime.mbt','variables.mbt','strings.mbt','cmd/web/main.mbt','cmd/web/moon.pkg','web/engine.mjs','tools/file-session.mjs','tools/cli.mjs','tools/file-io-cases.mjs','tools/test-file-io.mjs'];
const sources=Object.fromEntries(files.map(name=>[name,createHash('sha256').update(fs.readFileSync(new URL('../'+name,import.meta.url))).digest('hex')]));
const report={utc:new Date().toISOString(),reference:'Unmodified local Tcl '+expected[0].version+' via Python tkinter',cases:rows.length,matched:rows.filter(r=>r.matched).length,hostChecks:6,sources,rows};
fs.writeFileSync(new URL('../evidence/file-io-comparison.json',import.meta.url),JSON.stringify(report,null,2)+'\n');
console.log(JSON.stringify({cases:report.cases,matched:report.matched,hostChecks:report.hostChecks}));process.exitCode=report.matched===report.cases?0:1;
