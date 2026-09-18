"""Bound native ARE probes individually; a native timeout is not a passing case."""
from pathlib import Path
import concurrent.futures,json,subprocess,sys

def generate(cases):
    worker=None
    rows=[];limits=[]
    def stop():
        nonlocal worker
        if worker is not None:
            if worker.poll() is None:worker.kill()
            worker.wait(timeout=5)
            worker.stdin.close();worker.stdout.close()
            worker=None
    with concurrent.futures.ThreadPoolExecutor(max_workers=1) as reader:
        try:
            for i,case in enumerate(cases):
                if worker is None:
                    worker=subprocess.Popen([sys.executable,'-u',str(Path(__file__).resolve()),'--worker'],stdin=subprocess.PIPE,stdout=subprocess.PIPE,stderr=subprocess.DEVNULL,text=True,encoding='utf-8')
                worker.stdin.write(json.dumps(case,ensure_ascii=True)+'\n');worker.stdin.flush()
                response=reader.submit(worker.stdout.readline)
                try:line=response.result(timeout=2)
                except concurrent.futures.TimeoutError:
                    stop();response.result(timeout=5)
                    limits.append({**case,'reason':'native evaluation exceeded per-case deadline','timeoutSeconds':2})
                    print('Native timeout: '+case['name'],flush=True)
                    continue
                if not line:
                    exit_code=worker.wait(timeout=5);stop()
                    limits.append({**case,'reason':'native worker exited without a result','exitCode':exit_code})
                    continue
                row=json.loads(line)
                if 'referenceFailure' in row:
                    limits.append(row)
                    stop()
                    continue
                rows.append(row)
                if (i+1)%1000==0:print('Native switch probes: '+str(i+1),flush=True)
        finally:stop()
    return rows,limits

def worker_main():
    import tkinter,re,gc
    def normalize(text):
        return re.sub(r'[\udced][\udca0-\udcbf][\udc80-\udcbf]',lambda m:m.group().encode('utf-8','surrogateescape').decode('utf-8','surrogatepass'),text)
    for line in sys.stdin:
        case=json.loads(line);t=tkinter.Tcl();output=[]
        assert t.eval('info patchlevel')=='8.6.15'
        def capture(*args):
            newline=True
            if args and args[0]=='-nonewline':newline=False;args=args[1:]
            if len(args)==2 and args[0]=='stdout':args=args[1:]
            if len(args)!=1:raise RuntimeError('unsupported fixture output channel')
            output.append(args[0]+('\n' if newline else ''));return ''
        t.createcommand('puts',capture)
        try:
            try:result=t.eval(case['source']);error=False
            except tkinter.TclError as exc:result=str(exc);error=True
            row={**case,'result':normalize(result),'output':normalize(''.join(output)),'error':error}
        except Exception as exc:row={**case,'referenceFailure':type(exc).__name__+': '+str(exc)}
        finally:t.tk.deletecommand('puts');del t
        print(json.dumps(row,ensure_ascii=True),flush=True)
        gc.collect()

if __name__=='__main__':
    assert sys.argv[1:]==['--worker']
    worker_main()
