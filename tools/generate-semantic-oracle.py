"""Run original programs on the system Tcl core; capture stdout at puts."""
from pathlib import Path
import tkinter,json,runpy,sys,re,gc
root=Path(__file__).resolve().parents[1]
suite=sys.argv[1] if len(sys.argv)>1 else 'semantic'
if suite not in {'semantic','cache','namespace','completion','syntax','unicode','conversion','value'}:raise SystemExit('suite must be semantic, cache, namespace, completion, syntax, unicode, conversion or value')
cases=runpy.run_path(str(root/f'tools/{suite}-cases.py'))['cases']
rows=[]
def normalize_transport(text):
    # tkinter exposes Tcl CESU-8 encoded isolated units as surrogateescape
    # byte triples. Decode only valid three-byte surrogate sequences.
    return re.sub(r'[\udced][\udca0-\udcbf][\udc80-\udcbf]',lambda m:m.group().encode('utf-8','surrogateescape').decode('utf-8','surrogatepass'),text)

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
    row={**case,'result':normalize_transport(result),'output':normalize_transport(''.join(output)),'error':error}
    if difference:=case.get('knownDifference'):
        assert not error and not row['output'] and row['result']==difference['referenceResult'], 'Reference difference changed: '+difference['id']
        assert difference['localResult']!=row['result'], 'Resolved difference must be removed: '+difference['id']
    rows.append(row)
    t.tk.deletecommand('puts')
    del t
    if len(rows)%100==0:gc.collect()
record={'reference':'System Tcl 8.6.15 through Python tkinter','cases':len(rows),
 'adapter':'Only puts is replaced to collect standard output; expression, variable, collection and procedure semantics use the native Tcl implementation. Errors retain messages but compare rejection, not text.',
 'rows':rows}
if suite=='completion':record['completionScope']='Matrix helpers normalize generated diagnostic fields and error text; selected metadata, locations and native messages/codes compare directly. See TESTING.md.'
if suite=='conversion':record['conversionScope']='Canonical Tcl string results and stdout; default integers follow the pinned Windows 32-bit word/64-bit wide profile. Valid CESU-8 surrogateescape triples from tkinter are normalized to their UTF-16 units. Known raw-object byte-representation differences are recorded separately.'
if suite=='syntax':record['syntaxScope']='Substitution fixtures compare status, normalized error result, side effects and selected completion options. Completeness fixtures compare exact booleans; other successes compare exact values/stdout. Not complete error-message or upstream-suite coverage.'
(root/f'evidence/{suite}-reference.json').write_text(json.dumps(record,ensure_ascii=True,indent=2)+'\n',encoding='utf-8',newline='\n')
print('Generated',len(rows),'independent system Tcl cases')
def lit(text):
    if any(0xd800<=ord(c)<=0xdfff for c in text):
        return 'String::from_array(['+', '.join('('+str(ord(c))+').unsafe_to_char()' for c in text)+'])'
    return json.dumps(text,ensure_ascii=False)
lines=['// Original programs, expected results evaluated by Tcl 8.6.15. Do not hand-edit.']
for row in rows:
    known=row.get('knownDifference')
    label=('Known difference local contract ' if known else 'Tcl ')+suite+' '+row['name']
    lines+=['///|',f'test {lit(label)} {{',' let t=@tcl.Interpreter::new()']
    call=f't.eval({lit(row["source"])},budget=100000)'
    if row['error']:
        lines+=[f' assert_true(try{{ignore({call});false}}catch{{_=>true}})']
    else:
        expected=known['localResult'] if known else row['result']
        lines+=[f' assert_eq({call},{lit(expected)})',f' assert_eq(t.output_text(),{lit(row["output"])})']
    lines+=['}']
(root/f'{suite}_oracle_test.mbt').write_text('\n'.join(lines)+'\n',encoding='utf-8',newline='\n')
