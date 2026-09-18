"""Original regexp/regsub programs; only native Tcl supplies expectations."""
import itertools,random
cases=[]
def add(name,source):cases.append(dict(name=name+'-'+str(len(cases)),source=source))
def q(s):return '"'+''.join({'\\':'\\\\','"':'\\"','$':'\\$','[':'\\[',']':'\\]','\n':'\\n','\r':'\\r','\t':'\\t','\0':'\\x00'}.get(c,c) for c in s)+'"'
def match(p,s,flags=''):
    return 'regexp '+flags+' -inline -indices -- '+q(p)+' '+q(s)
def replace(p,s,r,flags=''):
    return 'set out OLD;set n [regsub '+flags+' -- '+q(p)+' '+q(s)+' '+q(r)+' out];list $n $out'
patterns=['','a','a*','a+','a?','a*?','a+?','a??','a{0}','a{1,2}','a{1,2}?','(a*)','(a)?(b)?','(a|ab)(b*)','((a)(b)?)','(a*)*','(a+)*','(a|b)+','(?:a)','^','$','^$','^a','a$','a^','a$b','\\A','\\Z','\\m','\\M','\\y','\\Y','\\d+','\\w+','\\s+','\\D+','[^a]+','[a-c]','[[:upper:]]','[[:<:]]a[[:>:]]','a(?=b)','a(?!b)','(?=(a))a','(ab|a)\\1','(a*)\\1','(?i)a','(?n)^a.$','(?x)a b','(?q)a.b','***=a.b','(?b)\\(a\\)\\1','(?e)(a|b)+']
texts=['','a','b','ab','aba','aaab','xaba','a\nb','\na','a\n','A B','abc 12','姹夊瓧','馃榾a','a\0b']
for p,s in itertools.product(patterns,texts):
    for flags in ['','-all']:
        add('search',match(p,s,flags))
for p,s in itertools.product(['','()','a*','a*?','(a)?b','^','$','\\A','\\m','(a)(b?)'],['','a','aba','abc','a\nb','a\n']):
    for flags in ['','-all']:
        for start in ['-1','0','1','2','3','4','100','end','end-1','end+1']:
            add('start',match(p,s,flags+' -start '+q(start)))
for index in ['1+2','2-1','end--1','end+-1',' 2 ','+2','0x2','0o2','02','08','2+0x1','2 + 1','2147483647','2147483648','4294967295','4294967296','-2147483648','-2147483649','end+2147483647','end+4294967295','end+4294967296','1+-1','1--1',' 1+2','1+2 ','end ',' end','end+ 1','1+ 1','1+2+3','','NaN']:
    add('index', 'catch {'+match('', 'abcd','-start '+q(index))+'} r o;list $r [dict get $o -code] [dict get $o -level] [dict exists $o -errorcode]')
for p,s in itertools.product(['.','[^b]+','^a.*$','a.b','a b','(?x)a b','(?t)a b','(?i)a','(?c)a','(?n).','(?s).'],['a\nb','a\n','A','a b','ab']):
    for flags in ['-line','-lineanchor','-linestop','-expanded','-nocase','-line -nocase','-line -linestop','-lineanchor -linestop']:
        add('flags',match(p,s,flags))
for p,s,r,flags in itertools.product(['','()','a','(a)(b?)','a*','a*?','^','$','\\A','\\m'],['','abc','aba','a\nb'],['X','&','\\0','<\\1>','\\2-\\9',r'\&',r'\\',r'\n','x\\','&&'],['','-all']):
    add('replacement',replace(p,s,r,flags))
for p,s,r,flags in itertools.product(['','a','a b','\\w+','[a-z]+','(a)'],['','a b a','ABC','ab\nab','鈩猭K','姹夊瓧'],['X','<&>'],['-all -expanded','-all -nocase','-all -start 1','-all -start end','-start 100','-all -line']):
    add('replacement-options',replace(p,s,r,flags))
for source in [
'regexp','regexp a','regexp -start','regexp -start 0','regexp -about','regexp -inline -about a','regexp -inline a a v','regexp -inline -about a b c','regexp -a a a','regexp -i a a','regexp -bad a a','regexp - a a','regexp --','regexp -- -a -a',
'regsub','regsub a','regsub a a','regsub a a x v w','regsub -a a a x','regsub -about a a x','regsub -start','regsub -start bad','regsub -start 0','regexp -start bad','regexp -start bad a a','regexp -start bad -bad','regsub -start bad a a x',
]:add('command-errors','catch {'+source+'} r o;list $r [dict get $o -code] [dict get $o -level] [dict get $o -errorcode]')
for source in [
'set a OLD;set b OLD;set c OLD;set d OLD;set n [regexp {(a)?(b)} b a b c d];list $n $a $b $c $d',
'set a OLD;set b OLD;set n [regexp -all {(a)} abab a b];list $n $a $b',
'set a OLD;set b OLD;set n [regexp {(x)} abc a b];list $n $a $b',
'set v OLD;regexp {(a)(b)} ab v v v;set v',
'set a 0;set b OLD;catch {regexp {(a)} a b a(x)};list $a $b',
'set a 0;set b OLD;catch {regexp {(a)} a a(x) b};list $a $b',
'set a 0;catch {regsub a aba X a(x)} r;list $a $r',
'array set a {};regexp -indices {(a)(b?)} a a(m) a(x) a(y);list $a(m) $a(x) $a(y)',
'proc f {} {regexp {(a)} a m s;list $m $s};f',
'namespace eval n {variable v 1;proc f {} {variable v;regsub -all a aba X v;set v}};list [n::f] $n::v',
'proc f {name} {upvar 1 $name dest;regexp a abc dest};set v OLD;list [f v] $v',
'rename regexp search;search -inline {(a)} abc',
'rename regsub replace;replace -all a aba X',
'regexp -about a ignored extra arguments',
'regexp -inline -about a ignored',
]:add('state-and-aliases',source)
for command in ['regexp .* $v','regexp $v x','regsub x $v y','regsub -all x $v y','regsub -all {} $v y','regsub $v x y','regsub x y $v','regexp -about $v','catch {regexp {(} $v}','catch {regsub {(} $v x}']:
    add('numeric-representation','scan 18446744073709551616 %f v;'+command+';format %.17g $v')
about=['','a','a*','a+?','a{1}','a{0}','a{1,2}','{}','{a}','a{','[a-z]','[a-a]','[abc]','[[.a.]]','[^a]','[a-]','[-a]','[[:alpha:]]','[a[:alpha:]]','[[=a=]]','(a)','(?:a)','(a)\\1','(a*)\\1','(?=a)','(?!a)','(?=)','(?!)','(?!a)a','a(?=)','\\d','\\A','\\m','\\b','\\B','\\cA','\\x41','\\141','a(?#x)b','(?i)a','(?n)a','(?x)a b','(?e)a','(?b)a','(?q)a','***=a.b','a^','a$b','^$','^a$','(?e)\\d','(?e)[\\d]','(?b)\\(a\\)\\1','(?b)*','(?b)a^','(?b)a$b','a)','(?e)a)','a]','[[:<:]]','[.a.]','[:alpha:]','a|','|','()','(?n)a^','(?n)$a','(?n)a$','(?n)$\\n','(?n)\\n^','[^\\u0000-\\uffff]','(?q)','***=','(?b)\\(^a$\\)','[\\.]','[\\u0041]','a{1}?','(a+?){1}','(a+?){2}','a*?|b']
for p in about:
    for flag in ['','-nocase','-expanded']:
        add('about','regexp -about '+flag+' -- '+q(p))
for a,b in itertools.product(['^','$','\\A','\\Z','\\m','\\M','\\y','\\Y','a','\\n','.','[^a]','[a-z]','a*','a?','(?:)','(?=a)','(?!a)'],repeat=2):
    for flag in ['','-line']:
        add('about-analysis','regexp -about '+flag+' -- '+q(a+b))
assert len({c['name'] for c in cases})==len(cases)

# Source-level compiler optimization versus the ordinary command dispatcher.
for option in ['-n','-no','-noc','-nocas','-a','-al','-in','-l','-st']:
    for invocation in [
        'regexp '+option+' a a',
        'set p a;regexp '+option+' $p a',
        'set opt '+option+';regexp $opt a a',
        'set command regexp;$command '+option+' a a',
        'regexp '+option+' a a m',
        'rename regexp search;search '+option+' a a',
        'eval [list regexp '+option+' a a]',
        'regexp {*}[list '+option+' a a]',
        'regsub '+option+' a a x',
    ]:
        add('option-dispatch','set code [catch {'+invocation+'} result options];list $code $result')
for index in ['-4294967295','-4294967296','end+1 ','end+ 1','end+08','08+1','1+08','-08','09x','end+0x2','1+2 ']:
    add('index-extended','catch {'+match('','abcd','-start '+q(index))+'} r o;list $r [dict get $o -code]')
for source in [
'array set a {};catch {regexp a a a} r o;list $r [dict get $o -errorcode]',
'set a 0;catch {regexp a a a(x)} r o;list $r [dict get $o -errorcode]',
'array set a {};catch {regsub a a x a} r o;list $r [dict get $o -errorcode]',
]:add('write-errors',source)
rng=random.Random(618031)
atoms=['a','b','\\n','^','$','\\A','\\Z','\\m','\\M','\\y','\\Y','[ab]','[^a]','[[:digit:]]','[[:alpha:]]','.','(?:)','(?=a)','(?!b)']
for i in range(800):
    a,b,c=rng.choices(atoms,k=3)
    pattern=rng.choice([f'({a}|{b}){c}', f'(?:{a}{b})*{c}',f'({a}|{b}){{1,3}}',f'({a}{b})?{c}',f'({a})\\1{b}',f'({a})({b})\\2\\1',f'(?={a}{b}){c}'])
    add('about-generated','regexp -about '+rng.choice(['','-line'])+' -- '+q(pattern))

# Native bytecode-only prefixes are an explicit compatibility gap.
for row in cases:
    for option in ['-n','-no','-noc','-nocas']:
        if row['source'] in [
            'set code [catch {regexp '+option+' a a} result options];list $code $result',
            'set code [catch {set p a;regexp '+option+' $p a} result options];list $code $result',
        ]:
            row['knownDifference']={
                'id':'regexp-bytecode-nocase-prefix',
                'reason':'Native Tcl compiles this static command form and accepts a nocase prefix. Its runtime dispatcher rejects abbreviations; this interpreter does not reproduce that bytecode optimization.',
                'referenceResult':'0 1',
                'localResult':'1 {bad option "'+option+'": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}',
            }
