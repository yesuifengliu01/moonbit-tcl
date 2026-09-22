import test from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import {FileSession} from './file-session.mjs';
const word=p=>'{'+p.replaceAll('\\','/')+'}';
function fixture(t){
 const temp=fs.mkdtempSync(path.join(os.tmpdir(),'tcl-root-guard-')),root=path.join(temp,'RootCase'),outside=path.join(temp,'Outside');fs.mkdirSync(root);fs.mkdirSync(outside);fs.writeFileSync(path.join(root,'keep.txt'),'preserve');fs.writeFileSync(path.join(outside,'keep.txt'),'outside');
 assert.equal(path.dirname(path.resolve(temp)).toLowerCase(),path.resolve(os.tmpdir()).toLowerCase());
 t.after(()=>fs.rmSync(temp,{recursive:true,force:true}));const session=new FileSession(root);t.after(()=>session.close());return {temp,root,outside,session};
}
test('configured root remains protected for dot absolute and Windows case aliases',t=>{
 const f=fixture(t),targets=['.',f.root];if(process.platform==='win32')targets.push(path.join(f.temp,'ROOTCASE'),f.root.toLowerCase());
 for(const target of targets){
  const resolved=path.resolve(f.root,target);assert.equal(path.relative(f.root,resolved),'');
  const result=f.session.eval('file delete -force '+word(target));assert.equal(result.ok,false,JSON.stringify({target,result}));assert.equal(fs.readFileSync(path.join(f.root,'keep.txt'),'utf8'),'preserve');
 }
});
test('parent traversal and an outside directory link are rejected before mutation',t=>{
 const f=fixture(t),link=path.join(f.root,'escape');fs.symlinkSync(f.outside,link,process.platform==='win32'?'junction':'dir');
 for(const source of ['open ../Outside/keep.txt w','open escape/keep.txt w','file delete -force escape','file mkdir escape/new']){
  assert.equal(f.session.eval(source).ok,false,source);assert.equal(fs.readFileSync(path.join(f.outside,'keep.txt'),'utf8'),'outside');assert(!fs.existsSync(path.join(f.outside,'new')));
 }
});
test('dangling links do not become missing-path ancestors',t=>{
 const f=fixture(t),target=path.join(f.outside,'missing-directory'),link=path.join(f.root,'dangling');fs.symlinkSync(target,link,process.platform==='win32'?'junction':'dir');
 const result=f.session.eval('file mkdir dangling/new');assert.equal(result.ok,false);assert(!fs.existsSync(target));assert(fs.lstatSync(link).isSymbolicLink());
 if(process.platform!=='win32'){
  const file=path.join(f.outside,'missing-file');fs.symlinkSync(file,path.join(f.root,'dangling-file'));
  assert.equal(f.session.eval('open dangling-file w').ok,false);assert(!fs.existsSync(file));
 }
});
test('ordinary in-root nested creation and deletion remain available',t=>{
 const f=fixture(t);assert.equal(f.session.eval('file mkdir nested/deeper; set f [open nested/deeper/out.txt w]; puts -nonewline $f hello; close $f').ok,true);
 assert.equal(fs.readFileSync(path.join(f.root,'nested/deeper/out.txt'),'utf8'),'hello');assert.equal(f.session.eval('file delete -force nested').ok,true);assert(!fs.existsSync(path.join(f.root,'nested')));assert.equal(fs.readFileSync(path.join(f.root,'keep.txt'),'utf8'),'preserve');
});
