import {new_session,session_eval,reset_session} from './engine.mjs';
const session=new_session();
globalThis.onmessage=({data})=>{
 const {id,source,reset}=data;
 if(reset){globalThis.postMessage({id,ok:reset_session(session),reset:true});return}
 if(typeof source!=='string'){globalThis.postMessage({id,ok:false,error:'Script must be text',output:''});return}
 const start=performance.now();
 try{globalThis.postMessage({id,...JSON.parse(session_eval(session,source)),milliseconds:performance.now()-start})}
 catch(error){globalThis.postMessage({id,ok:false,error:String(error),output:''})}
};
