"""Original public-command fixtures; expected values come only from native Tcl."""
from pathlib import Path
import re,itertools
cases=[]
def add(name,source):cases.append({'name':name,'source':source})
def word(s):
    return '"'+''.join('\\'+c if c in '\\"$[]' else '\\n' if c=='\n' else '\\r' if c=='\r' else c for c in s)+'"'
classes=['alnum','alpha','ascii','control','digit','graph','lower','print','punct','space','upper','wordchar','xdigit']
source=(Path(__file__).resolve().parents[1]/'unicode_data.mbt').read_text(encoding='utf-8')
points={0,127,128,65535};mapping=[]
for row in re.findall(r'\(([\d, ]+)\)',source):
    values=[int(v.strip()) for v in row.split(',')]
    if len(values)==3:
        a,b,_=values
        points.update(p for p in [a-1,a,b,b+1] if 0<=p<=65535)
    elif len(values)==4:mapping.append(values)
points=sorted(points)
for batch in range(0,len(points),32):
    commands=['set out {}']
    for cp in points[batch:batch+32]:
        commands.append('set c "\\u%04x"'%cp)
        commands.append('lappend out '+' '.join('[string is '+kind+' -strict $c]' for kind in classes))
    add('bmp-class-boundaries-'+str(batch//32),';'.join(commands)+';set out')
for batch in range(0,len(mapping),32):
    commands=['set out {}']
    for cp,lower,upper,title in mapping[batch:batch+32]:
        commands.append('set c "\\u%04x"'%cp)
        commands.append('lappend out [string tolower $c] [string toupper $c] [string totitle $c] [string equal -nocase $c "\\u%04x"] [lsearch -nocase -exact [list $c] "\\u%04x"]'%(lower,lower))
    add('bmp-simple-case-'+str(batch//32),';'.join(commands)+';set out')
values=['','abc','éΩ中','²','Ⅻ','\u0301','\u200b','\ufeff','\ue000','a\U00010041z','\U00010041!','\U00010061!','\U00010000','\U00010400','\U00010428','\U0001d400','\U0001f600','\U00020000',' \t\n','Ab1!']
for kind,value,strict in itertools.product(classes+['boolean','true','false','list','integer','wideinteger','entier','double'],values,[False,True]):
    add('class-matrix-'+str(len(cases)),'set f untouched;set ok [string is '+kind+(' -strict' if strict else '')+' -failindex f '+word(value)+'];list $ok $f')
numeric=['-','+','0x','0xg','0XFF','0o77','0o9','0b102','0b','00','09','09.0','09e1','09eX','1.2','1e','1e+','1e-2','.5','.','1_2','12x','12 x','12 \tX','  12x','\u00a01','1\u2000','1e9999','Infinit','Infinity','-Infinity','NaN','+NaN','-NaN','NaN(0)','NaN(abc)','NaN()','NaN(foo)','NaN(fffffffffffff)','NaN(10000000000000)','NaN(0x12)']
numeric += [str(sign*(2**bits+delta)) for bits in [31,32,63,64,100] for delta in [-1,0,1] for sign in [-1,1]]
for kind,value in itertools.product(['integer','wideinteger','entier','double'],numeric):
    add('numeric-failure-'+str(len(cases)),'set f untouched;list [string is '+kind+' -failindex f '+word(value)+'] $f')
for value in ['a {bad','😀 {bad','a "b"tail','  {a}tail','x \\','a b','\t"bad','{a {b}} c']:
    add('list-failure-'+str(len(cases)),'set f untouched;list [string is list -failindex f '+word(value)+'] $f')
for kind in ['a','al','alph','as','b','c','d','e','f','g','i','l','li','lo','p','pr','pu','s','t','u','w','wi','wo','x','missing','']:
    add('class-option-'+str(len(cases)),'string is '+word(kind)+' -s -f f {}')
for options in ['-s','-f f','-s -f f','-f f -s','-s -s','-f f -f g','-','-bad','-f','--','-strict extra']:
    add('flag-option-'+str(len(cases)),'set f untouched;set g untouched;list [string is alpha '+options+' 1] $f $g')
add('valid-preserves-scalar','set f original;list [string is alpha -failindex f abc] $f')
add('valid-preserves-array','array set f {x y};list [string is alpha -failindex f abc] [array get f]')
add('invalid-array-write-errors','array set f {x y};string is alpha -failindex f 1')
add('alias-failindex','set f old;proc check {} {upvar #0 f destination;string is alpha -failindex destination {ab1}};list [check] $f')
for text,first,last in itertools.product(['AbC','ǳİß','ᲐᲑᲒ',''],['-5','0','1','end','end+1'],['-1','0','2','end']):
    for op in ['tolower','toupper','totitle']:
        # Compare lengths and equality with the original to keep isolated
        # surrogate output out of the tkinter transport.
        add('case-range-'+str(len(cases)),'set x '+word(text)+';set y [string '+op+' $x '+first+' '+last+'];list [string length $y] [string equal $y $x] [string equal $y [string '+op+' $x]]')
for cp in [9,32,0x85,0xa0,0x180e,0x2000,0x200b,0x2028,0x202f,0x2060,0x3000,0xfeff,0x12000]:
    for op in ['trim','trimleft','trimright']:
        add('trim-'+str(len(cases)),'string '+op+' '+word(chr(cp)+'x'+chr(cp)))
for pattern,value in itertools.product(['?','??','*?','?*?','[A-Z]','[a-z]','[İ]','[Ǳ]','[😀]','😀?','*ß*','*SS*'],['😀','a','A','i','İ','ǳ','ß','SS','😀x']):
    for flag in ['', '-nocase ']:add('glob-'+str(len(cases)),'string match '+flag+word(pattern)+' '+word(value))
for escape in ['ud800','udfff','U0000d800','U0001f600','U00110000','Uffffffff','U0010ffff','U10000000']:
    add('escape-'+escape,'set c "\\'+escape+'";list [string length $c] [string range $c 1 end] [string equal [string index $c 0] "\\ufffd"]')
add('surrogate-roundtrip','set x 😀;set a [string index $x 0];set b [string index $x 1];list [string length $a] [string length $b] [string equal $a$b $x] [string equal [string range $x 0 0] $a] [string equal [string reverse A${x}B] B${x}A]')
add('surrogate-replace','set x 😀;set a [string index $x 0];set b [string index $x 1];list [string equal [string replace $x 0 0 X] X$b] [string equal [string map [list $a X] $x] X$b] [string first $b $x 1] [string last $a $x 0] [string equal -length 1 $x $a]')
add('surrogate-trim','set x 😀;set a [string index $x 0];set b [string index $x 1];list [string equal [string trim $x $a] $b] [string equal [string reverse $a] $a]')
add('case-mapping-no-expansion','list [string toupper ßﬀ] [string tolower İ] [string totitle ǳABC] [string map -nocase {İ X ß Y} iİßSS] [lsort -nocase {İ i ß ss SS}] [lsearch -nocase -exact {SS ß İ} i]')
add('georgian-title','list [string totitle ᲐᲑᲒ] [string totitle აᲑᲒ] [string tolower ᲐᲑᲒ]')
add('case-byte-growth','list [string toupper ɐɜ] [string tolower ȺȾ] [string equal -nocase Ⱥ ⱥ] [string match -nocase Ⱥ ⱥ] [string map -nocase {Ⱥ X} ⱥ]')
add('unicode-variable-names','set 中文 3;set a(中) 4;list [subst {$中文}] [subst {${中文}}] [subst {$a(中)}] [expr {${中文}+1}]')
add('first-end-index','list [string first x axbx end-1] [string first x axbx end]')
