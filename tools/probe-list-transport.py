import tkinter,sys,json,platform,subprocess
tcl=tkinter.Tcl()
values=['\x00','a"b','a#b','a\\','']
for j,value in enumerate(values):tcl.setvar('v'+str(j),value)
result=tcl.eval('list '+' '.join('$v'+str(j) for j in range(len(values))))
try:parsed=list(tcl.splitlist(result));error=None
except Exception as e:parsed=None;error=type(e).__name__+': '+str(e)
print(json.dumps(dict(python=sys.version,tcl=tcl.eval('info patchlevel'),platform=platform.platform(),osRelease=open('/etc/os-release').read(),packages=subprocess.check_output(['dpkg-query','-W','python3','python3-tk','tcl8.6','libtcl8.6']).decode(),nulProbe=dict(values=values,result=result,parsed=parsed,error=error,roundTrip=parsed==values)),ensure_ascii=True,indent=2))
