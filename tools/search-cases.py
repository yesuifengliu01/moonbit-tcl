"""Original collection programs, evaluated independently by pinned native Tcl."""
import itertools, random
cases=[]
def add(name,source):cases.append({'name':name+'-'+str(len(cases)), 'source':source})
def q(s):return '"'+''.join({'\\':'\\\\','"':'\\"','$':'\\$','[':'\\[',']':'\\]','\n':'\\n','\r':'\\r','\t':'\\t','\0':'\\x00'}.get(c,c) for c in s)+'"'
def listing(xs):return '[list '+' '.join(q(x) for x in xs)+']'
def search(xs,p,flags=''):return 'lsearch '+flags+' '+listing(xs)+' '+q(p)
def caught(s):return 'set code [catch {'+s+'} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]'

texts=['','a','A','ab','a b','ba','10','02','汉字','K','K','k','İ','i','a\nb','a\0b','😀']
patterns=['','a','A','a*','*a*','?','[a-b]','^a','a$','(a)(b?)','(a)\\1','\\w+','(?i)a','(?n)^b','汉','\0','😀','K']
for mode,p,flags in itertools.product(['-exact','-glob','-regexp'],patterns,['','-all','-inline','-all -inline','-not','-not -all -inline','-nocase','-nocase -all']):
    add('match',search(texts,p,mode+' '+flags))
for mode,flags,index in itertools.product(['-exact','-glob','-regexp','-sorted'],['','-all -inline','-not','-nocase'],['-3','0','1','end','end-1','end+1','100','1+2','2-1','2147483647','2147483648','4294967295','-4294967295','end+4294967295']):
    add('start',search(['a','b','a','c'],'a',mode+' '+flags+' -start '+q(index)))
for datatype,xs,patterns in [
    ('-ascii',['','A','a','b','c','aa'],['','A','a','b','ba','z']),
    ('-dictionary',['a01','a1','a001','a10','a2','A1','a000','a0'],['a1','A1','a01','a0','a3','a100']),
    ('-integer',['0','-1','1','10','0x10','16','010','+2'],['-2','-1','0','2','8','16','100']),
    ('-real',['-Inf','-2.5','-0.0','0','1','1.0','3e2','Inf'],['-Inf','-3','-0','1.0','2','300','Inf']),
]:
    for p,reverse,flags in itertools.product(patterns,['-increasing','-decreasing'],['','-all','-inline','-all -inline','-not -all','-bisect','-bisect -inline','-start 1','-bisect -start 2','-nocase','-all -nocase']):
        add('sorted','set v [lsort '+datatype+' '+reverse+' '+listing(xs)+'];lsearch -sorted '+datatype+' '+reverse+' '+flags+' $v '+q(p))
    for p,flags in itertools.product(patterns,['','-all','-not -all -inline','-nocase -all']):
        add('content',search(xs,p,'-exact '+datatype+' '+flags))

for indices,values in [
    ('0','{{a x} {b y} {a z}}'),('1','{{x a} {y b} {z a}}'),
    ('end','{{x a} {y z a} {b}}'),('end-1','{{a x} {y a z} {b x}}'),
    ('0 end','{{{x a} b} {{z b} c} {{a} d}}'),('1 0','{{x {a b}} {y {b}} {z {a}}}'),
    ('','{a b a}'),
]:
    for mode,flags,pattern in itertools.product(['-exact','-glob','-regexp','-sorted'],['','-all','-inline','-all -inline','-subindices','-all -subindices','-inline -subindices','-all -inline -subindices','-not -all -subindices','-start 1 -subindices','-start 100 -subindices'],['a','z']):
        add('nested','lsearch '+mode+' '+flags+' -index '+q(indices)+' '+values+' '+q(pattern))

for source in [
    'lsearch','lsearch a','lsearch -bad {} a','lsearch -a {} a','lsearch -- {} a','lsearch - {} a','lsearch nope {} a',
    'lsearch -start {} a','lsearch -index {} a','lsearch -subindices {} a','lsearch -index {} -subindices {} a',
    'lsearch -bisect -all {} a','lsearch -bisect -not -glob {} a','lsearch -stride 2 {} a',
    'lsearch -regexp {} {(}','lsearch -regexp -start bad {} {(}','lsearch -regexp -start 100 {} {(}',
    'lsearch -regexp -subindices {} {(}','lsearch -index bad -regexp {} {(}',
    'lsearch -start bad -start 0 {a b} a','lsearch -index bad -index 0 {a b} a',
    'lsearch -exact -integer {} bad','lsearch -exact -integer -start 0 {} bad',
    'lsearch -exact -real -start 10 {1} NaN','lsearch -exact -real {} NaN',
    'lsearch -index 1 {{x a} x} a','lsearch -all -index 1 {{x a} x} a',
    'lsearch -sorted -integer {bad 1 2} 2','lsearch -sorted -integer {0 1 bad} 0',
    'lsearch -bisect -glob {a b c} b*','lsearch -glob -bisect {a b c} b*',
    'lsearch -exact -integer -ascii {bad 2} bad','lsearch -exact -ascii -integer {bad 2} bad',
]:add('selected-errors',caught(source))

for index in ['-1','2147483647','2147483646','-2147483648','end+1','end-2147483647','end-2147483648','end+4294967295','end--1','0+1','1-1','08','bad',' 1 ','end ','1+ 1']:
    add('index-errors',caught('lsearch -index '+q(index)+' {} a'))
for index in ['bad','08','4294967296','end ','1+ 1','2147483647']:
    add('start-errors',caught('lsearch -start '+q(index)+' {a b} a'))
for flag in ['-ex','-gl','-reg','-so','-al','-as','-bi','-dec','-di','-inc','-inl','-int','-noc','-not','-rea','-star 0','-ind 0','-sub -index 0']:
    add('abbreviations','lsearch '+flag+' {1 2 3} 2')

for val in ['-18446744073709551616','-18446744073709551615','-9223372036854775809','-9223372036854775808','-1','0','9223372036854775807','9223372036854775808','18446744073709551615','18446744073709551616','08','1.0','NaN','Inf','bad',' 16 ','0x10']:
    for kind in ['-integer','-real']:
        for p in ['-1','0','1','16']:
            add('numeric-boundaries',caught(search([val],p,'-exact '+kind)))
for command in ['lsearch -exact -integer [list $v] $v','lsearch -exact -real [list $v] $v','lsearch -regexp [list $v] .*','lsearch -regexp [list 1] $v','lsearch -exact $v $v','lsearch -exact -integer $v $v','lsearch -start $v $v $v']:
    for setup in ['set v 2','set v [expr {2.0}]','scan 18446744073709551616 %f v','set v [expr {18446744073709551615}]']:
        add('representations',setup+';catch {'+command+'} r;list $r [format %.17g $v]')

dictionary_sets=[['a01','a1','a001','a10','a2','A1'],['K','K','k'],['İ','i','I','ı'],['Ǆ','ǅ','ǆ'],['𐐨','𐐀','𐐩','𐐁'],['😀','\ue000','\uffff','a'],['a','a\0b','a\0A','a\0'],['x9','x100','x000100','X100','x01z9','x1z10'],['2','２','٢','10','010'],['x'+'9'*100,'x1'+'0'*100,'x0001','X1']]
rng=random.Random(86015)
for _ in range(70):dictionary_sets.append([''.join(rng.choice(['a','A','b','B','0','1','2','9','K','k','_','-']) for _ in range(rng.randrange(0,16))) for _ in range(18)])
for xs,flags in itertools.product(dictionary_sets,['','-nocase','-unique','-decreasing','-decreasing -unique']):
    add('dictionary-sort','lsort -dictionary '+flags+' '+listing(xs))
for xs in dictionary_sets[:10]:
    for pattern in xs:
        add('dictionary-search',search(xs,pattern,'-all -exact -dictionary'))
        add('ascii-search','set v [lsort -ascii '+listing(xs)+'];lsearch -sorted $v '+q(pattern))
        add('nocase-sorted','set v [lsort -ascii -nocase '+listing(xs)+'];lsearch -sorted -nocase $v '+q(pattern))

keys=['a','ab','aa','A','b','12','a b','a\nb','汉字','K','k','😀','a\0b']
for pattern,mode in itertools.product(['','a','a*','^a','(a)\\1','(?i)a','(?n)^b','[0-9]+','汉','\0','😀'],['-regexp','-reg','-glob','-exact']):
    add('array-regexp','array set a '+listing([x for key in keys for x in (key,'value')])+';lsort [array names a '+mode+' '+q(pattern)+']')
for setup,option in itertools.product(['','set a scalar','array set a {}','array set a {x 1}'],['-regexp {(}','-reg {(}','-bad a','- a','-regexp {}']):
    add('array-validation',caught(setup+';array names a '+option))
for source in [
    'namespace eval n {variable a;array set a {a1 x a2 y b3 z}};proc f {} {upvar #0 n::a v;lsort [array names v -regexp {^a}]} ;f',
    'rename lsearch find;find -regexp -all {a b aa} {a+}',
    'set cmd lsearch;set option -reg;$cmd $option {b aa c} {a+}',
    'lsort -dictionary -index 1 {{first a10} {second a2} {third a01} {fourth a1}}',
    'puts [lsearch -all -regexp {a b aa} a];puts [lsort -dictionary {a10 a2 a1}];set done yes',
]:add('dispatch-scope',source)
assert len({case['name'] for case in cases})==len(cases)

# The native no-capture regexp fast path dispatches by the subject object's
# internal representation. General regexps always request UTF-16 text.
for pattern in ['', '.', '.*', '.+', '^.$', '^.*$', 'a.*b', 'a.*b.*c', '.*a.*', '(.)', '(?i).', '[a-z]', r'\.', r'\B', r'\n', r'\x31', '***=.', '^1', '1$']:
    for subject in ['set v 😀','set v [list 😀]','scan 18446744073709551616 %f v','set v [list 1]']:
        for flag in ['', '-nocase']:
            suffix='[format %.17g $v]' if subject.startswith('scan') else '[llength $v]'
            add('regexp-fast-representation',subject+';set r [lsearch -regexp '+flag+' [list $v] '+q(pattern)+'];list $r '+suffix)
for xs in itertools.permutations(['Ǆ','ǅ','ǆ','K','K']):
    for flags in ['', '-unique', '-decreasing -unique']:
        add('dictionary-equivalence','lsort -dictionary '+flags+' '+listing(xs))
for pattern in ['?','??','[😀]','[😀-🙏]','[🙏-😀]','*😀*']:
    add('glob-codepoints',search(['😀','🙏','x😀x','\ue000'],pattern,'-all -glob'))
    add('array-glob-codepoints','array set a '+listing(['😀','1','🙏','2','x😀x','3','\ue000','4'])+';lsort [array names a '+q(pattern)+']')
