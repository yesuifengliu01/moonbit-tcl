import config from './config.mjs';
const $=id=>document.getElementById(id);
$('title').textContent=config.title;
$('scope').textContent=config.scope;
$('limits').textContent=config.limitations;
$('input').value=config.example;
let worker,sequence=0,pending=null,timer;
function ready(){return new Worker(new URL('./worker.mjs',import.meta.url),{type:'module'})}
function idle(){clearTimeout(timer);pending=null;$('run').disabled=false;$('cancel').disabled=true}
function replaceWorker(){worker?.terminate();worker=ready();worker.onmessage=receive;worker.onerror=()=>{idle();$('status').textContent='执行器加载失败，请刷新页面。'}}
function receive({data}){
 if(data.id!==pending)return;
 idle();
 $('result').textContent=data.result??'';
 $('output').textContent=data.output??'';
 $('error').textContent=data.error??'';
 $('status').textContent=data.reset?'会话已清空。':data.ok?'已完成 · '+data.milliseconds.toFixed(2)+' ms':'脚本报错；此前执行的变量修改仍保留。';
}
function send(request){
 if(pending!==null)return;
 pending=++sequence;$('run').disabled=true;$('cancel').disabled=false;$('error').textContent='';
 $('result').textContent='';$('output').textContent='';
 $('status').textContent='运行中…';
 worker.postMessage({id:pending,...request});
 timer=setTimeout(()=>{replaceWorker();idle();$('status').textContent='超过 5 秒，执行已终止并清空会话。'},5000);
}
function cancel(){replaceWorker();idle();$('status').textContent='已停止执行并清空会话。'}
$('run').onclick=()=>send({source:$('input').value});
$('cancel').onclick=cancel;
$('reset').onclick=()=>{if(pending!==null)cancel();send({reset:true})};
$('example').onclick=()=>{$('input').value=config.example};
$('input').onkeydown=e=>{if((e.ctrlKey||e.metaKey)&&e.key==='Enter'){e.preventDefault();send({source:$('input').value})}};
$('import').onchange=async event=>{
 const file=event.target.files[0];if(!file)return;
 if(file.size>400000){$('status').textContent='文件过大，请导入 400 KB 以内的脚本。';return}
 $('input').value=await file.text();$('status').textContent='脚本已载入，运行后才会修改会话。';event.target.value='';
};

replaceWorker();
