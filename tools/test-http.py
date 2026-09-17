"""Exercise the actual loopback handler on an ephemeral port."""
import importlib.util,threading,urllib.request,urllib.error,urllib.parse,json
from pathlib import Path
from functools import partial
from http.server import ThreadingHTTPServer
root=Path(__file__).resolve().parents[1]
spec=importlib.util.spec_from_file_location('review_server',root/'tools/serve.py')
module=importlib.util.module_from_spec(spec);spec.loader.exec_module(module)
server=ThreadingHTTPServer(('127.0.0.1',0),partial(module.Handler,directory=str(root)))
thread=threading.Thread(target=server.serve_forever,daemon=True);thread.start()
base='http://127.0.0.1:'+str(server.server_port)
checks=[]
def request(path,data=None,content_type=None):
    headers={} if content_type is None else {'Content-Type':content_type}
    try:
        with urllib.request.urlopen(urllib.request.Request(base+path,data=data,headers=headers)) as r:
            return r.status,dict(r.headers),r.read()
    except urllib.error.HTTPError as e:return e.code,dict(e.headers),e.read()
try:
    for path in ['/web/','/web/worker.mjs','/web/engine.mjs']:
        status,headers,data=request(path);assert status==200 and data;checks.append(path)
    for path in ['/.git/config','/_build/','/tools/']:
        assert request(path)[0]==404;checks.append('blocked '+path)
    text='set 名 {a&b + c}\nputs $名\n'
    data=urllib.parse.urlencode({'source':text}).encode()
    status,headers,body=request('/download.tcl',data,'application/x-www-form-urlencoded')
    assert status==200 and body==text.encode('utf-8')
    assert headers['Content-Disposition']=='attachment; filename="script.tcl"'
    checks.append('download UTF-8 exact bytes')
    assert request('/download.tcl',b'x','application/json')[0]==415;checks.append('download MIME rejection')
    assert request('/download.tcl',b'x=1','application/x-www-form-urlencoded')[0]==400;checks.append('download fields rejection')
    assert request('/download.tcl',b'source='+b'x'*400001,'application/x-www-form-urlencoded')[0]==413;checks.append('download size rejection')
    assert request('/other',data,'application/x-www-form-urlencoded')[0]==404;checks.append('unknown endpoint')
finally:server.shutdown();server.server_close();thread.join()
(root/'evidence/http-validation.json').write_text(json.dumps({'checks':len(checks),'passed':len(checks),'rows':checks},indent=2)+'\n',encoding='utf-8',newline='\n')
print('HTTP checks passed:',len(checks))
