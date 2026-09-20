import fs from 'node:fs';
import {FileSession} from './file-session.mjs';
import {run,evaluate,new_session,session_eval,reset_session,close_session} from '../web/engine.mjs';
const args=process.argv.slice(2);let input, json=false,structured=false,session=false,fsRoot,fileSession;
try {
 for(let i=0;i<args.length;i++){
  const a=args[i];
  if(a==='--help'){process.stdout.write('Usage: node tools/cli.mjs [--input TEXT | --file PATH] [--json | --eval-json] [--fs-root DIRECTORY]\n--fs-root enables real files and source beneath DIRECTORY.\nWithout a source, reads UTF-8 stdin. --eval-json separates result/output. --session reads JSON lines: {"source":"Tcl script"} or {"reset":true}. Exit: 0 success, 2 invalid script, 1 host error.\n');process.exit(0)}
  else if(a==='--json')json=true;
  else if(a==='--eval-json')structured=true;
  else if(a==='--session')session=true;
  else if(a==='--fs-root'){if(fsRoot!==undefined||i+1>=args.length)throw Error('Expected one filesystem root');fsRoot=args[++i];}
  else if(a==='--input'||a==='--file'){
   if(input!==undefined||i+1>=args.length)throw new Error('Exactly one input source is required');
   const value=args[++i];
   if(a==='--file'){if(fs.statSync(value).size>2097152)throw new Error('Input exceeds 2 MiB');input=fs.readFileSync(value,'utf8')}else input=value;
  }else throw new Error('Unknown argument: '+a);
 }
 if((json&&structured)||(session&&(input!==undefined||json||structured)))throw new Error('Conflicting output/input modes');
 if(fsRoot!==undefined)fileSession=new FileSession(fsRoot);
 if(session){
  const id=fileSession?null:new_session();let pending='';
  const consume=line=>{
   const request=JSON.parse(line);let response;
   if(request?.reset===true){if(fileSession){fileSession.close();fileSession=new FileSession(fsRoot);response={ok:true,reset:true};}else response={ok:reset_session(id),reset:true};}
   else if(typeof request?.source==='string')response=fileSession?fileSession.eval(request.source):JSON.parse(session_eval(id,request.source));
   else throw new Error('Session request requires source or reset');
   if(!response.ok)process.exitCode=2;
   process.stdout.write(JSON.stringify(response)+'\n');
  };
  process.stdin.setEncoding('utf8');
  try{for await(const chunk of process.stdin){
   pending+=chunk;let end;
   while((end=pending.indexOf('\n'))!==-1){if(end>2097152)throw new Error('Session line exceeds 2 MiB');const line=pending.slice(0,end);pending=pending.slice(end+1);if(line.trim())consume(line)}
   if(pending.length>2097152)throw new Error('Session line exceeds 2 MiB');
  }if(pending.trim())consume(pending)}finally{if(fileSession)fileSession.close();else close_session(id)}
  process.exit(process.exitCode||0);
 }
 if(input===undefined){let size=0;const chunks=[];for await(const chunk of process.stdin){size+=chunk.length;if(size>2097152)throw new Error('Input exceeds 2 MiB');chunks.push(chunk)}input=Buffer.concat(chunks).toString('utf8')}
 if(Buffer.byteLength(input)>2097152)throw new Error('Input exceeds 2 MiB');
 if(structured){const result=fileSession?JSON.stringify(fileSession.eval(input)):evaluate(input);fileSession?.close();process.stdout.write(result+'\n');process.exit(JSON.parse(result).ok?0:2)}
 const hostResult=fileSession?.eval(input);
 const output=hostResult?(hostResult.ok?'Result: '+hostResult.result+'\nOutput:\n'+hostResult.output:'ERROR: '+hostResult.error):run(input),ok=!output.startsWith('ERROR:');
 process.stdout.write(json?JSON.stringify({ok,output})+'\n':output+(output.endsWith('\n')?'':'\n'));
 process.exitCode=ok?0:2;
}catch(e){process.stderr.write(JSON.stringify({ok:false,error:String(e.message||e)})+'\n');process.exitCode=1}finally{fileSession?.close()}
