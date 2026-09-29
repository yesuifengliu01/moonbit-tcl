"""Live independent Tcl interpreter; no generated golden results."""
import json, sys, tkinter
request = json.loads(sys.stdin.buffer.read().decode('utf-8'))
results = []
version = tkinter.Tcl().eval('info patchlevel')
for case in request['cases']:
    tcl = tkinter.Tcl()
    tcl.eval(request['library'])
    try:
        results.append({'name': case['name'], 'ok': True, 'result': tcl.eval(case['source'])})
    except tkinter.TclError as error:
        results.append({'name': case['name'], 'ok': False, 'error': str(error)})
json.dump({'referenceVersion': version, 'results': results}, sys.stdout, ensure_ascii=True)
