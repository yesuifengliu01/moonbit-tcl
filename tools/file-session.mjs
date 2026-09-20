import fs from 'node:fs';
import path from 'node:path';
import {new_session,session_io,session_eval,close_session} from '../web/engine.mjs';

const limit=8*1024*1024;
const word=value=>value===''?'{}':value.replace(/[\\\s{}[\]$;"]/g,c=>({'\n':'\\n','\r':'\\r','\t':'\\t'}[c]??'\\'+c));
const list=values=>values.map(String).map(word).join(' ');
const portable=value=>value.replaceAll('\\','/');
function arity(args,min,max=min){if(args.length<min||args.length>max)throw Error('wrong number of arguments');}
function integer(value){if(!/^[+-]?\d+$/.test(value)||!Number.isSafeInteger(Number(value)))throw Error('expected a bounded integer');return Number(value);}
function encoding(value){if(['utf-8','utf8'].includes(value))return 'utf8';if(['binary','iso8859-1','latin1'].includes(value))return 'latin1';throw Error('unsupported channel encoding');}

/** Tcl interpreter with real synchronous files under one caller-selected root. */
export class FileSession {
 #id;#root;#cwd;#channels=new Map();#next=0;
 constructor(root){
  this.#root=fs.realpathSync(path.resolve(root));this.#cwd=this.#root;
  if(!fs.statSync(this.#root).isDirectory())throw Error('Filesystem root must be a directory');
  this.#id=new_session();if(this.#id<0)throw Error('Session limit exceeded');
  session_io(this.#id,input=>{try{const {command,args}=JSON.parse(input);return JSON.stringify({ok:true,value:this.#command(command,args)});}catch(error){return JSON.stringify({ok:false,error:error.message});}});
 }
 eval(source){if(this.#id===undefined)throw Error('Session closed');return JSON.parse(session_eval(this.#id,source));}
 close(){for(const channel of this.#channels.values())try{fs.closeSync(channel.fd);}catch{}this.#channels.clear();if(this.#id!==undefined)close_session(this.#id);this.#id=undefined;}
 #inside(value){const relative=path.relative(this.#root,value);return relative===''||(!relative.startsWith('..'+path.sep)&&relative!=='..'&&!path.isAbsolute(relative));}
 #resolve(value,mutating=false){
  if(typeof value!=='string'||value.includes('\0')||value.startsWith('|'))throw Error('invalid file path');
  const resolved=path.resolve(this.#cwd,value);
  if(!this.#inside(resolved)||(mutating&&resolved===this.#root))throw Error('path leaves the configured filesystem root');
  let parent=resolved;
  while(!fs.existsSync(parent)){const next=path.dirname(parent);if(next===parent)throw Error('missing filesystem root');parent=next;}
  if(!this.#inside(fs.realpathSync(parent)))throw Error('symbolic link leaves the configured filesystem root');
  return resolved;
 }
 #channel(name){const channel=this.#channels.get(name);if(!channel)throw Error('can not find channel named "'+name+'"');return channel;}
 #read(channel,count=null,line=false){
  if(!channel.readable)throw Error('channel was not opened for reading');
  const remaining=Math.max(0,fs.fstatSync(channel.fd).size-channel.position);
  if(remaining>limit)throw Error('file read exceeds 8 MiB');
  const data=Buffer.alloc(remaining),got=fs.readSync(channel.fd,data,0,remaining,channel.position);
  const raw=data.subarray(0,got).toString(channel.encoding);let end=0,text='',terminated=false;
  while(end<raw.length&&(count===null||text.length<count)){
   let c=String.fromCodePoint(raw.codePointAt(end));end+=c.length;
   if(channel.translation==='auto'&&c==='\r'){if(raw[end]==='\n')end++;c='\n';}
   else if(channel.translation==='crlf'&&c==='\r'&&raw[end]==='\n'){end++;c='\n';}
   if(line&&c==='\n'){terminated=true;break;}text+=c;
  }
  channel.position+=Buffer.byteLength(raw.slice(0,end),channel.encoding);
  channel.eof=end===raw.length&&!terminated&&(line||count===null||text.length<count);
  return {text,eof:channel.eof&&text.length===0&&!terminated};
 }
 #write(channel,text){
  if(!channel.writable)throw Error('channel was not opened for writing');
  if(channel.translation==='crlf'||(channel.translation==='auto'&&process.platform==='win32'))text=text.replaceAll('\n','\r\n');
  const data=Buffer.from(text,channel.encoding);if(data.length>limit)throw Error('write exceeds 8 MiB');
  let done=0;while(done<data.length){const written=fs.writeSync(channel.fd,data,done,data.length-done,channel.append?null:channel.position+done);if(!written)throw Error('file write made no progress');done+=written;}
  channel.position=channel.append?fs.fstatSync(channel.fd).size:channel.position+done;channel.eof=false;
 }
 #command(name,args){
  switch(name){
   case 'open':{
    arity(args,1,3);if(this.#channels.size>=128)throw Error('channel limit exceeded');
    const mode=args[1]??'r';if(!['r','r+','w','w+','a','a+'].includes(mode))throw Error('unsupported file access mode');
    const writable=mode!=='r',filename=this.#resolve(args[0],writable);
    const permissions=args[2]===undefined?0o666:Number.parseInt(args[2],8);
    if(args[2]!==undefined&&!/^[0-7]{1,4}$/.test(args[2]))throw Error('invalid file permissions');
    if(fs.existsSync(filename)&&!fs.statSync(filename).isFile())throw Error('expected a regular file');
    const fd=fs.openSync(filename,mode,permissions),key='file'+(++this.#next);
    this.#channels.set(key,{fd,position:mode.startsWith('a')?fs.fstatSync(fd).size:0,append:mode.startsWith('a'),readable:mode==='r'||mode.includes('+'),writable,encoding:'utf8',translation:'auto',eof:false});return key;
   }
   case 'close':{arity(args,1);const channel=this.#channel(args[0]);fs.closeSync(channel.fd);this.#channels.delete(args[0]);return '';}
   case 'read':{
    arity(args,1,3);let noNewline=false;if(args[0]==='-nonewline'){noNewline=true;args=args.slice(1);}arity(args,1,2);
    const count=args.length===2?integer(args[1]):null;if(count!==null&&(count<0||count>limit))throw Error('invalid read count');
    let {text}=this.#read(this.#channel(args[0]),count);if(noNewline&&text.endsWith('\n'))text=text.slice(0,-1);return text;
   }
   case 'gets':{arity(args,1);const result=this.#read(this.#channel(args[0]),null,true);return result.eof?'1':'0'+result.text;}
   case 'puts':{
    let newline=true;if(args[0]==='-nonewline'){newline=false;args=args.slice(1);}arity(args,2);
    this.#write(this.#channel(args[0]),args[1]+(newline?'\n':''));return '';
   }
   case 'seek':{
    arity(args,2,3);const channel=this.#channel(args[0]),offset=integer(args[1]),origin=args[2]??'start';
    if(!['start','current','end'].includes(origin))throw Error('invalid seek origin');
    const base=origin==='start'?0:origin==='current'?channel.position:fs.fstatSync(channel.fd).size;
    if(base+offset<0||!Number.isSafeInteger(base+offset))throw Error('invalid seek position');channel.position=base+offset;channel.eof=false;return '';
   }
   case 'tell':arity(args,1);return String(this.#channel(args[0]).position);
   case 'eof':arity(args,1);return this.#channel(args[0]).eof?'1':'0';
   case 'flush':arity(args,1);fs.fsyncSync(this.#channel(args[0]).fd);return '';
   case 'fconfigure':{
    arity(args,1,9);const channel=this.#channel(args[0]);
    const get=key=>{if(key==='-encoding')return channel.encoding==='utf8'?'utf-8':'iso8859-1';if(key==='-translation')return channel.translation;if(key==='-blocking')return '1';if(key==='-buffering')return 'none';throw Error('unsupported channel option');};
    if(args.length===1)return list(['-blocking','1','-buffering','none','-encoding',get('-encoding'),'-translation',get('-translation')]);
    if(args.length===2)return get(args[1]);if(args.length%2!==1)throw Error('channel options require values');
    for(let i=1;i<args.length;i+=2){const key=args[i],value=args[i+1];if(key==='-encoding')channel.encoding=encoding(value);
     else if(key==='-translation'){if(!['auto','lf','crlf','binary'].includes(value))throw Error('unsupported translation');channel.translation=value;if(value==='binary')channel.encoding='latin1';}
     else if(key==='-blocking'&&value==='1'){}else if(key==='-buffering'&&['none','line','full'].includes(value)){}else throw Error('unsupported channel option');}
    return '';
   }
   case 'source':{
    let codec='utf8';if(args.length===3&&args[0]==='-encoding'){codec=encoding(args[1]);args=args.slice(2);}arity(args,1);
    const filename=this.#resolve(args[0]);if(fs.statSync(filename).size>limit)throw Error('source exceeds 8 MiB');return fs.readFileSync(filename).toString(codec).replaceAll('\r\n','\n');
   }
   case 'pwd':arity(args,0);return portable(this.#cwd);
   case 'cd':arity(args,1);{const next=this.#resolve(args[0]);if(!fs.statSync(next).isDirectory())throw Error('not a directory');this.#cwd=next;return '';}
   case 'file':return this.#file(args);
   default:throw Error('unsupported filesystem command '+name);
  }
 }
 #file(args){
  if(!args.length)throw Error('file requires a subcommand');const [name,...values]=args;
  if(name==='join'){if(!values.length)return '';return portable(path.join(...values));}
  if(['dirname','tail','extension','rootname','split','pathtype'].includes(name)){
   arity(values,1);const value=values[0];if(name==='dirname')return portable(path.dirname(value));if(name==='tail')return path.basename(value);
   if(name==='extension')return path.extname(value);if(name==='rootname')return value.slice(0,value.length-path.extname(value).length);
   if(name==='pathtype')return path.isAbsolute(value)?'absolute':'relative';
   const parsed=path.parse(value);return list([...(parsed.root?[portable(parsed.root)]:[]),...value.slice(parsed.root.length).split(/[\\/]+/).filter(Boolean)]);
  }
  if(['exists','isfile','isdirectory','size','normalize','readable','writable'].includes(name)){
   arity(values,1);const filename=this.#resolve(values[0]);if(name==='normalize')return portable(filename);
   if(name==='exists')return fs.existsSync(filename)?'1':'0';
   if(name==='readable'||name==='writable'){try{fs.accessSync(filename,name==='readable'?fs.constants.R_OK:fs.constants.W_OK);return '1';}catch{return '0';}}
   if(name!=='size'&&!fs.existsSync(filename))return '0';const stat=fs.statSync(filename);
   return name==='size'?String(stat.size):(name==='isfile'?stat.isFile():stat.isDirectory())?'1':'0';
  }
  if(name==='mkdir'){if(!values.length)throw Error('file mkdir requires a path');for(const value of values)fs.mkdirSync(this.#resolve(value,true),{recursive:true});return '';}
  if(name==='delete'){let force=false;if(values[0]==='-force'){force=true;values.shift();}if(values[0]==='--')values.shift();if(!values.length)throw Error('file delete requires a path');for(const value of values){const filename=this.#resolve(value,true);fs.rmSync(filename,{force:true,recursive:force});}return '';}
  if(name==='rename'||name==='copy'){
   let force=false;if(values[0]==='-force'){force=true;values.shift();}if(values[0]==='--')values.shift();arity(values,2);
   const from=this.#resolve(values[0],name==='rename'),to=this.#resolve(values[1],true);if(fs.existsSync(to)&&!force)throw Error('target already exists');
   if(name==='copy')fs.copyFileSync(from,to,force?0:fs.constants.COPYFILE_EXCL);else fs.renameSync(from,to);return '';
  }
  throw Error('unsupported file subcommand '+name);
 }
}
