"""Check every generated BMP table entry against independent native Tcl 8.6.15.

This is a data audit, separate from the compiled public command fixtures.
"""
from pathlib import Path
import hashlib,json,re,tkinter
root=Path(__file__).resolve().parents[1]
source=(root/'unicode_data.mbt').read_text(encoding='utf-8')
props=[0]*65536
cases={}
for row in re.findall(r'\(([\d, ]+)\)',source):
    values=[int(v.strip()) for v in row.split(',')]
    if len(values)==3:
        a,b,mask=values
        props[a:b+1]=[mask]*(b-a+1)
    elif len(values)==4:cases[values[0]]=values[1:]
classes=['alnum','alpha','ascii','control','digit','graph','lower','print','punct','space','upper','wordchar','xdigit']
t=tkinter.Tcl()
assert t.eval('info patchlevel')=='8.6.15'
t.eval('proc audit {cp} {set c [format %c $cp];set mask 0;set bit 1;foreach kind {'+' '.join(classes)+'} {if {[string is $kind -strict $c]} {set mask [expr {$mask | $bit}]};set bit [expr {$bit << 1}]};list $mask [scan [string tolower $c] %c] [scan [string toupper $c] %c] [scan [string totitle $c] %c]}')
mismatches=[]
for cp in range(65536):
    actual=list(map(int,t.eval('audit '+str(cp)).split()))
    expected=[props[cp],*[cp if cp<2048 and mapped>=2048 else mapped for mapped in cases.get(cp,[cp,cp,cp])]]
    if actual!=expected:mismatches.append({'codepoint':cp,'native':actual,'generated':expected})
report={'reference':'System Tcl 8.6.15 through tkinter','unicodeVersion':'16.0.0','codepoints':65536,'propertiesPerCodepoint':13,'caseMappingsPerCodepoint':3,'checks':65536*16,'mismatches':mismatches,'scope':'Exhaustive BMP category and public simple-case conversion audit (including Tcl UTF-8 non-growth behavior); separate compiled command and host fixtures verify use of the tables. Does not imply full Tcl or Unicode compatibility.','unicodeDataSHA256':hashlib.sha256((root/'vendor/ucd-16.0.0/UnicodeData.txt').read_bytes()).hexdigest()}
(root/'evidence/unicode-data-audit.json').write_text(json.dumps(report,indent=2)+'\n',encoding='utf-8',newline='\n')
print(json.dumps({k:report[k] for k in ['codepoints','checks']}), 'mismatches',len(mismatches))
if mismatches:print(json.dumps(mismatches[:20]));raise SystemExit(1)
