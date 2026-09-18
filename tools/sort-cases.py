"""Original lsort programs; native Tcl 8.6.15 alone supplies expectations."""
import itertools,random
cases=[]
def add(name,source):cases.append({'name':name+'-'+str(len(cases)),'source':source})
def q(s):return '"'+''.join({'\\':'\\\\','"':'\\"','$':'\\$','[':'\\[',']':'\\]','\n':'\\n','\r':'\\r','\t':'\\t','\0':'\\x00'}.get(c,c) for c in s)+'"'
def listing(xs):return '[list '+' '.join(q(x) for x in xs)+']'
def caught(s):return 'set code [catch '+q(s)+' r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]'
def sort(xs,flags=''):return 'lsort '+flags+' '+listing(xs)

corpora=[[],['a'],['c','a','b','a'],['A','a','B','b'],['a01','a1','A1','a0001','a10','a2'],['0','-0','-1','2','0x10','010','+2'],['Inf','-Inf','-0.0','1','1.0','0.5','3e2'],['K','K','k','İ','I','i','Ǆ','ǅ','ǆ'],['😀','\ue000','\uffff','a'],['a\0','a\0b','a','a\0A']]
for xs,mode,flags in itertools.product(corpora,['-ascii','-dictionary','-integer','-real'],['','-indices','-unique','-unique -indices','-decreasing','-decreasing -unique -indices','-nocase','-nocase -unique','-nocase -indices']):
    add('content',sort(xs,mode+' '+flags))
for xs in [['18446744073709551615','-1','0','1'],['-18446744073709551615','1','0'],['-9223372036854775809','9223372036854775807'],['18446744073709551616'],['-18446744073709551616'],['NaN'],['1.0'],['08'],['bad']]:
    for mode,flags in itertools.product(['-integer','-real'],['','-indices','-unique','-decreasing']):
        add('number-boundaries',caught(sort(xs,mode+' '+flags)))
for xs,idx in [(['{a 3} x','{b 1} y','{c 2} z'],'0 1'),(['x {a 3}','y {b 1}','z {c 2}'],'1 end'),(['x a','y b','z a'],'end'),(['a x','b y','a z'],'end-1'),(['a','b','a'],'')]:
    for flags in ['','-indices','-unique','-unique -indices','-decreasing','-nocase','-dictionary','-dictionary -unique -indices']:
        add('nested',sort(xs,'-index '+q(idx)+' '+flags))
for stride in [2,3,4]:
    for offset in range(stride):
        xs=[]
        for key in [3,1,2,1,4]:
            xs.extend(str(key) if j==offset else 'payload'+str(j)+str(len(xs)) for j in range(stride))
        for index,flags in itertools.product([str(offset),'end-'+str(stride-1-offset)],['','-indices','-unique','-unique -indices','-decreasing','-decreasing -unique -indices','-increasing -nocase']):
            add('stride',sort(xs,'-stride '+str(stride)+' -index '+q(index)+' -integer '+flags))
        nested=[('tag '+x if i%stride==offset else x) for i,x in enumerate(xs)]
        for flags in ['','-indices','-unique','-decreasing -unique -indices']:
            add('stride-nested',sort(nested,'-stride '+str(stride)+' -index '+q(str(offset)+' end')+' -integer '+flags))

for source in [
'lsort','lsort -bad {}','lsort -i {}','lsort - {}','lsort -- {}','lsort nope {}','lsort -command {}','lsort -index {}','lsort -stride {}',
'lsort -stride 1 {}','lsort -stride 0 {}','lsort -stride -1 {}','lsort -stride 2 {a}','lsort -stride 2 -index 2 {a b}',
'lsort -stride 2 -index 2 {}','lsort -stride 2 -index end+1 {}','lsort -stride 2 -index {1 0} {a x b {}}',
'lsort -index 1 {x}','lsort -index bad {}','lsort -index bad -index 0 {}','lsort -index 1 -index {} {a b}',
'lsort -command noSuch {}','lsort -command noSuch {x}','lsort -command noSuch {x y}',
'lsort -command '+q('{')+' {}','lsort -command '+q('{')+' '+q('{'),
'lsort -command noSuch -integer {2 1}','lsort -integer -command noSuch {}',
]:add('selected-errors',caught(source))
for index in ['-1','2147483647','2147483646','-2147483648','end+1','end-2147483647','end-2147483648','end+4294967295','end--1','0+1','1-1','08','bad',' 1 ','end ','1+ 1']:
    for v in ['{}','{x}','{{a b}}']:
        add('index-validation',caught('lsort -index '+q(index)+' '+v))
for stride in ['2147483647','2147483648','4294967295','4294967296','-4294967295','-4294967296','2.0','08','NaN','bad','0x2',' 2 ']:
    add('stride-validation',caught('lsort -stride '+q(stride)+' {}'))
for option in ['-as','-com {string compare}','-dec','-di','-inc','-ind','-inde 0','-indic','-int','-noc','-rea','-str 2','-un']:
    add('abbreviations',caught('lsort '+option+' {2 1 4 3}'))
for first,second in itertools.product(['-ascii','-dictionary','-integer','-real','-command {string compare}'],repeat=2):
    add('mode-order','lsort '+first+' '+second+' -nocase {10 2 01 1}')

trace='proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};'
for xs,flags in itertools.product(itertools.permutations(['e','d','c','b','a']),['','-decreasing','-unique','-decreasing -unique']):
    add('comparison-order',trace+'set result ['+sort(xs,'-command cmp '+flags)+'];list $result $calls')
for xs,flags in itertools.product([['a','b','a','c','a'],['A','b','C'],['x','y','z','w','v'],['1','2','1','3','2']],['','-unique','-nocase','-indices','-decreasing -unique -indices']):
    for body in ['return 0','return -1','return 1','return -2147483648','expr {[string length $a]-[string length $b]}']:
        add('custom-order','proc cmp {a b} {lappend ::calls [list $a $b];'+body+'};set calls {};set result ['+sort(xs,'-command cmp '+flags)+'];list $result $calls')
for result,flags in itertools.product(['0','-1','1','2147483647','2147483648','4294967295','4294967296','-4294967295','-4294967296','1.0','NaN','bad',' 1 ','0x1'],['','-decreasing','-unique']):
    add('comparison-result',caught('proc cmp {a b} {return '+q(result)+'};lsort -command cmp '+flags+' {b a}'))
for body in ['error FIRST','return -code break FIRST','return -code continue FIRST','return -code 8 FIRST','return -level 2 FIRST','return bad','return -code error -errorcode {CUSTOM FAIL} FIRST']:
    for values,flags in itertools.product(['{a b}','{a b c d e}','{{a x} {b y} z}','{{a x} {b y} {c z} q}','{{a x} {b y} {c z} {d q} r}'],['','-index 1']):
        add('comparison-completion',caught('proc cmp {a b} {incr ::calls;'+body+'};set calls 0;lsort -command cmp '+flags+' '+values)+';list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]')
for source in [
'namespace eval n {variable calls 0;proc cmp {a b} {variable calls;incr calls;string compare $a $b};proc run {} {lsort -command cmp {c a b}}};list [n::run] $n::calls',
'proc cmp {prefix a b} {lappend ::calls [list $prefix $a $b];string compare $a $b};set calls {};list [lsort -command {cmp MARK} {c a b}] $calls',
'proc cmp {a b} {set ::v changed;string compare $a $b};set v {c a b};list [lsort -command cmp $v] $v',
'proc cmp {a b} {set ::prefix bad;string compare $a $b};set prefix cmp;list [lsort -command $prefix {c a b}] $prefix',
'proc cmp {a b} {set inner [lsort -integer {3 1 2}];string compare $a $b};lsort -command cmp {c a b}',
'proc cmp {a b} {rename cmp {};proc cmp {a b} {expr {-[string compare $a $b]}};string compare $a $b};lsort -command cmp {d c b a}',
'rename lsort order;order -str 2 -ind 1 -int -indic {x 3 y 1 z 2}',
'proc cmp {a b} {puts [list $a $b];string compare $a $b};lsort -command cmp {c b a}',
]:add('reentrancy-scope',source)
for setup in ['set v 2','set v [expr {2.0}]','scan 18446744073709551616 %f v','set v [expr {18446744073709551615}]']:
    for flags,target in itertools.product(['-ascii','-nocase','-dictionary','-integer','-real','-command {string compare}','-indices -real'],['[list $v]','$v','[list $v 0]']):
        add('representations',setup+';catch {lsort '+flags+' '+target+'} r;list $r [format %.17g $v]')
rng=random.Random(861500)
for _ in range(120):
    xs=[str(rng.randrange(-12,13)) for _ in range(rng.randrange(0,45))]
    for flags in ['-integer -unique -indices','-integer -decreasing','-command {string compare} -indices']:
        add('seeded-sort',sort(xs,flags))
assert len({case['name'] for case in cases})==len(cases)

for malformed in ['{','"','{a}x','"a"x','{a}'+'x'*30,'"a"'+'汉字','{a}'+'a'*17+'汉Z']:
    for prefix in ['lsort ', 'lsort -command ', 'lsort -index ']:
        suffix=' {}' if prefix!='lsort ' else ''
        add('list-diagnostics',caught(prefix+q(malformed)+suffix))
for ch in ['汉','😀','\0','é']:
    for size in range(17,21):
        junk='{x}'+'a'*size+ch+'Z'
        source='catch {lsort '+q(junk)+'} r o;list $r [dict get $o -errorcode]'
        add('byte-limited-diagnostic',source)
        if ch=='😀' and size in (17,18):
            fragment='\udcf0\udc9f' if size==17 else '\udcf0'
            before='{list element in braces followed by "'+'a'*size
            after='" instead of space} {TCL VALUE LIST JUNK}'
            cases[-1]['knownDifference']={'id':'list-diagnostic-raw-utf8-'+str(size),'referenceResult':before+fragment+after,'localResult':before+after,'reason':'Native diagnostic retains an invalid raw UTF-8 prefix of a supplementary character. Local text values preserve complete Unicode characters; raw object bytes remain a broader tracked gap, not a compatibility pass.'}
for body in ['return -code break x','return -code continue x','return -code 8 -errorinfo CUSTOM -errorcode {A B} x','return -level 2 -errorinfo CUSTOM -errorcode {A B} x','return -code error -errorinfo CUSTOM -errorcode {A B} x']:
    add('completion-metadata','proc cmp {a b} {'+body+'};catch {lsort -command cmp {b a}} r o;list $r [dict get $o -code] [dict get $o -level] [dict get $o -errorcode] [string match {*(-compare command)*} [dict get $o -errorinfo]] [dict get $o -errorline] [info exists ::errorInfo] [info exists ::errorCode]')
    add('completion-text','proc cmp {a b} {'+body+'};catch {lsort -command cmp {b a}} r o;string range [dict get $o -errorinfo] 0 5')
