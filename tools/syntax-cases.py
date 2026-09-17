"""Original substitution and syntax programs; system Tcl supplies expectations."""
import itertools,random
cases=[]
def add(name,source):cases.append({'name':name,'source':source})
def word(text):
 if not text:return '{}'
 escapes={'\n':r'\n','\r':r'\r','\t':r'\t','\v':r'\v','\f':r'\f'}
 return ''.join(escapes.get(c,'\\'+c if c in '\\ []${};"' else c) for c in text)

def subst(name,text,flags=''):
 source='set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template '+word(text)+';'
 source+='set code [catch {subst '+flags+' $template} result options];'
 source+='if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]'
 add(name,source)
texts=['plain','quotes " $x " braces { $x }','$x:$x',r'one\ntwo\tthree',r'\$x \[incr x\]',r'$a(index)',r'$a([incr x])','[set x 3] $x','[set x 3;] $x',r'$a(\x69ndex)',r'$a($x)',r'$a(${x})','[list [incr x] [incr x]]','before[break]after[incr x]','before[continue]after[incr x]','before[return VALUE]after[incr x]','[return -code error bad] tail','[return -level 0 -code error bad] tail','[return -level 0 -code 9 VALUE]tail','[return -level 2 -tag X VALUE]tail','[return -level 0 -tag X VALUE]tail','[error bad]tail','text $missing tail','[incr x]${unclosed','[break]${unclosed','[continue]${unclosed','backslash\\', '中文$x [list 😀]', 'empty[]word', 'bracket]literal','[;#comment\n]']
for mask in range(8):
 flags=' '.join(flag for bit,flag in enumerate(['-nobackslashes','-nocommands','-novariables']) if mask&(1<<bit))
 for i,text in enumerate(texts):subst('flags-'+str(mask)+'-'+str(i),text,flags)

suffixes=['', ';', ';set x 9', ';set z {bad', ';set z "bad', ';list ${bad', ';list $a(', ';list {bad}tail', ';[incr x]']
for action in ['incr x','break','continue','return VALUE','return -level 0 -code 9 VALUE','error bad']:
 for i,suffix in enumerate(suffixes):
  for closed in [False,True]:
   text='prefix['+action+suffix+(']tail[incr x]' if closed else '')
   subst('bracket-'+action+'-'+str(i)+'-'+str(closed),text)

for action in ['incr x','break','continue','return index','return -level 0 -code 9 index','error bad']:
 for suffix in ['',')','[incr x])','${bad)', '[set z {bad])', ')tail[incr x]']:
  subst('variable-'+action+'-'+suffix,'before$a(['+action+']'+suffix)
for flags in ['-nob','-noc','-nov','-noback','-nob -nob','-nov -noc','-n','-no','--','-bad', '{}']:
 subst('option-'+flags,r'$x [incr x] \n',flags)
for text in ['-nocommands','--','-','\\','\\\n']:
 add('last-argument-'+text,'subst '+word(text))

samples=['', '\\','abc\\','abc\\\n','abc\\\n  ','# x\\','[','{','list {a}b {','list "a"b [','list a{','list a"','list $a(','list $','list $(', 'list ${a','list # [','list [# a]', '[# a\n]', 'set x {[foo]}','set x [list {]}]','set x "a\\\nb"','list {*}[list a b]', 'list {*}','list {*}{}','list {*}"a"b', 'list a\\\n', '# x\\\n', '# x\\\\\n', 'list a\\\\\n','list a\\\\\\\n']
for i,text in enumerate(samples):add('complete-explicit-'+str(i),'info complete '+word(text))
randomizer=random.Random(86015)
atoms=['set x ','list ','',';','[',']','{','}','"','\\','\n','$a(',')','$x','${',' ', '#comment', '*','a','\\\n','\\\n ']
for i in range(400):
 text=''.join(randomizer.choice(atoms) for _ in range(randomizer.randrange(1,14)))
 add('complete-generated-'+str(i),'info complete '+word(text))

for i,source in enumerate(['list [incr x] {bad}tail','list [incr x;set y {bad]','list [incr x] $a(','list [incr x] [error boom]','list [incr x] [set y {bad]','incr x;list {bad}tail','list [incr x;];incr x','list [incr x;#comment\n];incr x']):
 add('ordinary-command-order-'+str(i),'set x 0;set source '+word(source)+';set code [catch {eval $source}];list $code $x')
for source in ['subst','subst -bogus text','info complete','info complete a b']:
 add('arity-'+source,source)

# Grouped-word continuation and escaped comment newline regressions.
for group in ['{value}','"value"','[list value]']:
 for tail in ['\\\n','\\\n ','\\\n next']:
  text='list '+group+tail
  add('group-complete-'+group+'-'+tail,'info complete '+word(text))
  add('group-eval-'+group+'-'+tail,'eval '+word(text))
for slashes in range(1,7):
 source='# comment'+('\\'*slashes)+'\nset x after\nset x'
 add('comment-continuation-'+str(slashes),'set x before;eval '+word(source))

for action in ['incr x','break','continue','return index','return -level 0 -code 9 index','error bad']:
 for mask in range(8):
  flags=' '.join(flag for bit,flag in enumerate(['-nobackslashes','-nocommands','-novariables']) if mask&(1<<bit))
  for i,text in enumerate(['before['+action+']after','before$a(['+action+'])after','$a(['+action+'][incr x])tail']):
   subst('cross-kind-'+action+'-'+str(mask)+'-'+str(i),text,flags)
