"""Run original programs on the system Tcl core; capture stdout at puts."""
from pathlib import Path
import tkinter,json,runpy,sys
root=Path(__file__).resolve().parents[1]
suite=sys.argv[1] if len(sys.argv)>1 else 'semantic'
if suite not in {'semantic','cache','namespace','completion','syntax','unicode'}:raise SystemExit('suite must be semantic, cache, namespace, completion, syntax or unicode')
cases=runpy.run_path(str(root/f'tools/{suite}-cases.py'))['cases']
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
if suite=='completion':record['completionScope']='Matrix helpers normalize generated diagnostic fields and error text; selected metadata, locations and native messages/codes compare directly. See TESTING.md.'
if suite=='syntax':record['syntaxScope']='Substitution fixtures compare status, normalized error result, side effects and selected completion options. Completeness fixtures compare exact booleans; other successes compare exact values/stdout. Not complete error-message or upstream-suite coverage.'
(root/f'evidence/{suite}-reference.json').write_text(json.dumps(record,ensure_ascii=True,indent=2)+'\n',encoding='utf-8',newline='\n')
print('Generated',len(rows),'independent system Tcl cases')
def lit(text):
    return json.dumps(text,ensure_ascii=False)
lines=['// Original programs, expected results evaluated by Tcl 8.6.15. Do not hand-edit.']
for row in rows:
    lines+=['///|',f'test {lit("Tcl "+suite+" "+row["name"])} {{',' let t=@tcl.Interpreter::new()']
    call=f't.eval({lit(row["source"])},budget=100000)'
    if row['error']:
        lines+=[f' assert_true(try{{ignore({call});false}}catch{{_=>true}})']
    else:
        lines+=[f' assert_eq({call},{lit(row["result"])})',f' assert_eq(t.output_text(),{lit(row["output"])})']
    lines+=['}']
(root/f'{suite}_oracle_test.mbt').write_text('\n'.join(lines)+'\n',encoding='utf-8',newline='\n')
