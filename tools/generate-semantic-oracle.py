"""Run original programs on the system Tcl core; capture stdout at puts."""
from pathlib import Path
import tkinter,json,runpy
root=Path(__file__).resolve().parents[1]
cases=runpy.run_path(str(root/'tools/semantic-cases.py'))['cases']
rows=[]
for case in cases:
    t=tkinter.Tcl()
    version=t.eval('info patchlevel')
    if version!='8.6.15':raise RuntimeError('Expected fixed Tcl 8.6.15, found '+version)
    output=[]
    def capture(*args):
        newline=True
        if args and args[0]=='-nonewline':newline=False;args=args[1:]
        if len(args)==2 and args[0]=='stdout':args=args[1:]
        if len(args)!=1:raise RuntimeError('unsupported output channel in fixture')
        output.append(args[0]+('\n' if newline else ''))
        return ''
    t.createcommand('puts',capture)
    try:result=t.eval(case['source']);error=False
    except tkinter.TclError as exc:result=str(exc);error=True
    rows.append({**case,'result':result,'output':''.join(output),'error':error})
record={'reference':'System Tcl 8.6.15 through Python tkinter','cases':len(rows),
 'adapter':'Only puts is replaced to collect standard output; expression, variable, collection and procedure semantics use the native Tcl implementation. Errors retain messages but compare rejection, not text.',
 'rows':rows}
(root/'evidence/semantic-reference.json').write_text(json.dumps(record,ensure_ascii=True,indent=2)+'\n',encoding='utf-8',newline='\n')
print('Generated',len(rows),'independent system Tcl cases')
def lit(text):
    return json.dumps(text,ensure_ascii=False)
lines=['// Original programs, expected results evaluated by Tcl 8.6.15. Do not hand-edit.']
for row in rows:
    lines+=['///|',f'test {lit("Tcl semantic "+row["name"])} {{',' let t=@tcl.Interpreter::new()']
    call=f't.eval({lit(row["source"])},budget=100000)'
    if row['error']:
        lines+=[f' assert_true(try{{ignore({call});false}}catch{{_=>true}})']
    else:
        lines+=[f' assert_eq({call},{lit(row["result"])})',f' assert_eq(t.output_text(),{lit(row["output"])})']
    lines+=['}']
(root/'semantic_oracle_test.mbt').write_text('\n'.join(lines)+'\n',encoding='utf-8',newline='\n')
