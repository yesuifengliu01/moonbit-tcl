"""Original switch programs. Expected data is obtained only from native Tcl."""
import random
cases=[]
def add(name,source):cases.append(dict(name=name+'-'+str(len(cases)),source=source))
def q(s):
    return '"'+''.join({'\\':'\\\\','"':'\\"','$':'\\$','[':'\\[',']':'\\]','\n':'\\n','\r':'\\r','\t':'\\t','\0':'\\x00'}.get(c,c) for c in s)+'"'
def rex(pattern,text,flags=''):
    return 'set m OLD;set ix OLD;set r [switch -regexp '+flags+' -matchvar m -indexvar ix -- '+q(text)+' '+q(pattern)+' {list matched} default {list default}];list $r $m $ix'
for mode in ['', '-exact ', '-glob ', '-nocase ', '-exact -nocase ', '-glob -nocase ']:
    for text in ['', 'a', 'A', 'abc', 'a*b', 'default', 'DEFAULT', '-glob', '汉字', 'ÉCOLE', 'k', 'K', 'Σ', 'ς', '\0']:
        for grouped in [False,True]:
            arms=' '.join(q(x) for x in ['a','list first','a*','list star','default','list fallback'])
            if grouped:arms='[list '+arms+']'
            add('branch-order', 'switch '+mode+'-- '+q(text)+' '+arms)
for src in [
 'switch a {a {expr 7}}','switch -x {-x {expr 3}}','switch -nocase {-nocase {expr 4}}',
 'switch x a {error untouched}', 'switch a a - b - c {expr 9}',
 'switch a default {error untouched} a {expr 5}',
 'switch default default {expr 8} a {error untouched}',
 'switch x a {} default {}', 'switch x a {error no} default {list yes}',
 'proc f x {switch $x a {return found} default {return none};error unreachable};list [f a] [f b]',
 'set r {};foreach x {0 1 2 3} {switch $x 1 continue 3 break default {lappend r $x}};set r',
 'set r {};for {set i 0} {$i<4} {incr i} {switch $i 1 continue 3 break default {lappend r $i}};set r',
 'namespace eval n {variable v 7;proc f x {variable v;switch $x a {incr v} default {set v}}};list [n::f a] [n::f b]',
 'rename switch choose;namespace eval n {namespace path ::;choose x x {expr 3}}',
 'set m old;set i old;switch -regexp -matchvar m -indexvar i x a {};list $m $i',
 'set m old;set i old;switch -regexp -matchvar m -indexvar i x a {} default {};list $m $i',
 'switch -regexp -matchvar m -indexvar m abc {(a)(b*)} {set m}',
 'switch -regexp -matchvar m abc {(a)} - {(?invalid} {set m}',
 'switch -regexp x x {list yes} {(?invalid} {error ignored}',
 'switch -regexp -matchvar m -matchvar n abc {(a)} {list [info exists m] $n}',
 'array set a {};switch -regexp -matchvar a(m) -indexvar a(i) abc {(a)(b*)} {list $a(m) $a(i)}',
 'set a 0;set m old;catch {switch -regexp -indexvar a(i) -matchvar m abc a {error no}} r;list $a $m',
 'set a 0;set ix old;catch {switch -regexp -indexvar ix -matchvar a(m) abc a {error no}} r;list $a $ix',
 'scan 18446744073709551616 %f v;format %.17g [switch a a [list list $v]]',
 'scan 18446744073709551616 %f v;format %.17g [lindex [switch a [list a [list list $v]]] 0]',
 'set effect 0;catch {switch x x {incr effect;error bad}} r o;list $effect $r [string match {*"x" arm line 1*} [dict get $o -errorinfo]]',
 'catch {switch a a - b {error bad}} r o;list $r [string match {*"a" arm line 1*} [dict get $o -errorinfo]]',
 'catch {switch x x {return -code 7 -note custom yes}} r o;list $r [dict get $o -code] [dict get $o -level] [dict get $o -note]',
]:add('control-and-values',src)
errors=[
 'switch','switch x','switch x {}','switch x {x}','switch x x {} z',
 'switch x x {} z -','switch x a {} z -','switch -exact -glob x x {}',
 'switch -exact -exact x x {}','switch -matchvar m x x {}','switch -indexvar i x x {}',
 'switch -matchvar m -indexvar i x x {}','switch -bad x x {}','switch - x x {}',
 'switch -regexp -indexvar','switch -regexp -matchvar m','switch --','switch -- x',
]
for src in errors:
    add('syntax-rejection',src)
    if '-bad' not in src and 'switch - x' not in src:
        add('error-code','catch {'+src+'} r o;list $r [dict get $o -errorcode]')
patterns=[
 '', 'a', '.', '^$', '^a', 'a$', '^a$', 'a|ab', 'ab|a', '(a|ab)(b?)',
 'a*','a+','a?','a{2}','a{1,3}','a{1,}','a*?','a+?','a??','a{1,3}?',
 '(a*)a*','(a*?)a*','(a*)*','(a+)*','(a?)*','(a|b)+','((a)(b)?)','(a)?b',
 '(?:a|b)+','a(?=b)','a(?!b)','(?=(a))a','(ab|a)\\1','(a*)\\1',
 '[]a]','[-a]','[a-]','[^a]','[a-c]','[[:digit:]]+','[[:alpha:]]+',
 '[[:word:]]+','[[:blank:]]','[[:space:]]+','[[:cntrl:]]','[[:upper:]]+',
 '[[:lower:]]+','[[:xdigit:]]+','[[.a.]-[.c.]]','[[=a=]]','[[:<:]]a[[:>:]]',
 '\\d+','\\s+','\\w+','\\D+','\\S+','\\W+','[a\\d]+',
 '\\ma\\M','\\ya\\y','\\Ya','\\Aa\\Z','\\b','\\B','\\cA','\\x41','\\u0041','\\141',
 '(?i)a','(?c)a','(?n)^a.$','(?p)a.b','(?w)^a','(?s)a.b',
 '(?x) a # comment\n b','a(?#comment)b','***=a.b','***:a+','(?q)a.b',
 '(?e)(a|b)+','(?b)\\(a*\\)\\1','(?b)a+','(?b)\\<a\\>',
 '.*(b|a).*','(.+?)(.+)','(.*?)(.*)','(a|aa)*','((ab)*)*',
]
texts=['','a','b','A','aa','ab','abc','aba','aab','aaab','baaa','a\nb','1a2','汉字','éΣ',' a ','a.b','\0']
for pat in patterns:
    for text in texts:add('regexp-matrix',rex(pat,text))
for pat in ['a','[a-z]','[A-Z]','[K-Å]','[[:upper:]]','[[:lower:]]','(a)\\1','(?c)a']:
    for text in ['a','A','k','K','K','Å','å','Σ','σ','ς','Aa','aA','é','É']:
        add('regexp-nocase',rex(pat,text,'-nocase'))
for pat in ['(',')','[','[a','[z-a]','[a-c-e]','[[:bad:]]','[[.ch.]]','[\\D]','[\\y]',
            '\\','\\j','\\1','(a\\1)','(?=a)\\1','(?=(a)\\1)','a**','a+*','^*','a{256}','a{3,2}',
            '(?z)a','a(?i)b','(?i:a)','***x','(?b)\\1','(?e)(?:a)','\\x','\\u']:
    add('invalid-regexp',rex(pat,'aa'))
for pat,text in [('a{0}','a'),('a{0,0}','a'),('a{0,0}?','a'),('(){2}','x'),('(a*){2}','aa'),
                 ('(a*){2}?','aa'),('(a*){1,1}?','aa'),('(a+?){1,1}','aaa'),
                 ('a(?!((b)))','ac'),('a{1,1}?b.*c','abcXXc'),('(week|wee)(night|knights)','weeknights')]:
    add('preference',rex(pat,text))
rng=random.Random(20260918)
atoms=['a','b','[ab]','[^a]','.', '(ab|a)', '(a?)','(?:a|b)']
for i in range(180):
    pat=''.join(rng.choice(atoms)+rng.choice(['','?','*','+','{1,2}','??']) for _ in range(rng.randrange(1,4)))
    text=''.join(rng.choice('abc') for _ in range(rng.randrange(0,7)))
    add('seeded-composition',rex(pat,text))

# Broader parser/Unicode/nullable/backreference boundary coverage, still generated
# from the native interpreter rather than a second hand-written matcher.
for mode in ['', '-nocase','-glob','-glob -nocase','-regexp','-regexp -nocase']:
    for where in ['subject','pattern']:
        for matched in [True,False]:
            pat='.*' if 'regexp' in mode else '*'
            subject='$v' if where=='subject' else ('[format %s $v]' if matched else 'x')
            pat='$v' if where=='pattern' else pat
            add('numeric-representation','scan 18446744073709551616 %f v;switch '+mode+' -- '+subject+' '+pat+' {};format %.17g $v')
for src in ['switch -matchvar m x','switch -indexvar i x','switch -exact x {}','switch -exact -- x',
            'switch -regexp -matchvar m -- x','switch -nocase -nocase x x {expr 1}',
            'switch -g -r x x {}','switch -i q x x {}']:
    add('option-boundary','catch {'+src+'} r o;list $r [dict get $o -code] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]')
for pat in ['(','[','[z-a]','[[:word:]]','[[.ch.]]','\\','\\q','\\1','^*','a{256}','a{3,2}','a{3','(?z)a','***x']:
    add('regexp-diagnostics','catch {switch -regexp x '+q(pat)+' {}} r o;list $r [dict get $o -errorcode]')
special=['\0','\x01','\x07','\x08','\t','\n','\x0b','\x0c','\r','\x1b',' ','#','-','[',']','\\','a','A','0','9','_',
         'é','É','中','Σ','σ','ς','K','Å','Å','å','ſ','S','İ','ı','i','\u00a0','\u2003','\u2028','\u203f','\uff3f',
         '\u0661','\uff11','\u01c4','\u01c5','\u01c6']
for pat in ['\\w','\\W','\\s','\\S','\\d','\\D','[[:alnum:]]','[[:alpha:]]','[[:blank:]]','[[:lower:]]',
            '[[:upper:]]','[[:punct:]]','[[:xdigit:]]','[[:cntrl:]]','[[:graph:]]','[[:print:]]',
            '[[:ascii:]]','[[:word:]]','[a-z]','[A-Z]','[k]','[K]','[Σ]','[ς]']:
    for text in special:
        for flags in ['', '-nocase']:add('unicode-class',rex(pat,text,flags))
for pat in ['b(a*)*','b(a*)?','b(a*)+','b(a*){0,1}','(a*)?\\1','(a*)*\\1','(a*)+\\1',
            '(?=((a)))','(?=(a)(b))','(?=(a(b)))','(?=(?:(a)))','(?=(a(b)))(a)',
            '(a(b)?)+','((a?)+)+','(a*?)(a*)','(?:(a*?))(a*)',
            '(?b)\\(ab\\)\\{1,2\\}','(?b)^*','(?b)a^b','(?b)a$b','(?b)\\d',
            '(?e)\\d','(?e)[\\d]','(?e)a*?','(?q)(?i)a','***=(?i)a',
            '(?n)[^x]+','(?p)^a$','(?w).+','(?x)[ #]','(?x)a\\ b',
            '\\012','\\123','\\77','\\400','\\10','(a)\\10','(a)\\01','(a)\\11',
            '\\x123','\\u1','\\U0001F600','\\Uffffffff']:
    for text in ['', 'a','b','aa','ab','aba','aab','baaa','ababa','a\nb','a b','d','*','a^b','a$b','\n','S','?',' 0','�']:
        add('regex-boundary',rex(pat,text))
for name in ['NUL','SOH','BEL','BS','HT','LF','VT','FF','CR','ESC','DEL','alert','backspace','tab','newline','vertical-tab',
             'form-feed','carriage-return','space','exclamation-mark','quotation-mark','number-sign','dollar-sign','percent-sign',
             'ampersand','apostrophe','left-parenthesis','right-parenthesis','asterisk','plus-sign','comma','hyphen','hyphen-minus',
             'period','full-stop','slash','solidus','colon','semicolon','less-than-sign','equals-sign','greater-than-sign',
             'question-mark','commercial-at','left-square-bracket','backslash','reverse-solidus','right-square-bracket',
             'circumflex','circumflex-accent','underscore','low-line','grave-accent','left-brace','left-curly-bracket','vertical-line',
             'right-brace','right-curly-bracket','tilde']:
    add('collating-name',rex('[[.'+name+'.]]',''.join(chr(i) for i in range(128))))
for i in range(420):
    base=rng.choice(['(a|ab)','(a*)','(a?)','(?:a*)','a','b','(.)','[ab]'])
    pat=base+rng.choice(['','*','+','?','{0,2}','{1,2}','*?','+?','??'])
    if rng.randrange(2):pat='('+pat+')'+rng.choice(['','*','+','?','{1,2}'])
    pat+=rng.choice(['a*','(a*)','(a*?)','b?','(?:a|b)',''])
    text=''.join(rng.choice('aab') for _ in range(rng.randrange(0,7)))
    add('nested-composition',rex(pat,text))

# Repetition rewrite regressions: only the final iteration owns captures;
# atoms containing backreferences must retain sequential capture dependencies.
for pat in [r'(?:(a)|(b))+',r'(?:(a)|(b))*',r'((a|aa)+)\2',r'(a(b)?)+\2',
            r'((a)\2)+',r'((a)\2)*',r'(a)(?:\1){1,2}',r'(a)?\1*',r'(a?)\1+',r'()\1*',
            r'(a+){2,3}',r'(a+?){2,3}',r'(a*){0,2}',r'(a*){1,2}?']:
    for text in ['', 'a','b','aa','ab','aab','aba','aaaa']:
        add('repeat-capture-regression',rex(pat,text))
