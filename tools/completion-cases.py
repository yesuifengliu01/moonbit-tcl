"""Original completion/cleanup programs. Native Tcl computes all expectations."""
cases=[]
def add(name,source):cases.append(dict(name=name,source=source))
helpers='''
proc normalized {options} {
 set out {}
 foreach key [lsort [dict keys $options]] {
  if {$key in {-errorinfo -errorline -errorstack}} {continue}
  set value [dict get $options $key]
  if {$key eq "-during"} {set value [normalized $value]}
  lappend out $key $value
 }
 return $out
}
proc observed {script} {
 set code [catch {uplevel 1 $script} value options]
 if {$code == 1} {set value <error>}
 list $code $value [normalized $options]
}
'''
def observe(name,source):add(name,helpers+'observed {'+source+'}')

for code in ['ok','error','return','break','continue','7','-1']:
 for level in range(5):
  for nesting in range(3):
   body=f'return -code {code} -level {level} -tag custom value;set reached after'
   if nesting==1:body='proc p {} {'+body+'};p;set outer after'
   if nesting==2:body='proc p {} {'+body+'};proc q {} {p;set inner after};q;set outer after'
   observe(f'return-{code}-{level}-nest-{nesting}',body)

programs={
 'plain-return':'return result',
 'plain-empty-return':'return',
 'pairs-without-result':'return -tag payload',
 'arbitrary-option-name':'return foo bar value',
 'double-dash-option':'return -- value',
 'abbreviation-is-custom':'return -c error result',
 'sticky-success-options':'return -level 0 -tag value first;set next second',
 'nested-return-options':'return -options {-options {-code error -level 0 -errorcode {APP FAIL}} -tag A} bad',
 'options-order':'return -code error -options {-code 7 -level 0 -tag a} -code ok x',
 'multiple-options':'return -options {-code error -tag old} -options {-level 0 -tag new} bad',
 'duplicate-options':'return -tag old -tag new -level 0 x',
 'unused-error-options':'return -code ok -level 0 -errorcode {APP OK} -errorinfo custom x',
 'error-default':'error bad',
 'error-explicit':'error bad custom {APP FAIL}',
 'throw-explicit':'throw {APP FAIL detail} bad',
 'error-clears-options':'return -level 0 -tag X value;error bad',
 'catch-clears-options':'return -level 0 -tag X value;catch {set x 2};set x',
 'catch-empty-clears':'return -level 0 -tag X value;catch {};set x 2',
 'catch-result-options-same':'catch {return -level 0 -tag X value} x x;normalized $x',
 'catch-result-array':'array set a {};catch {return -code 7 X} a(result) a(options);list $a(result) [normalized $a(options)]',
 'rethrow-error':'catch {throw {APP FAIL} bad} value options;return -options $options $value',
 'rethrow-custom':'catch {return -level 0 -code 8 -tag custom result} value options;return -options $options $value',
 'rethrow-return':'catch {return -level 2 -tag custom result} value options;return -options $options $value',
 'rethrow-as-success':'catch {throw APP bad} value options;dict set options -code 0;return -options $options recovered',
 'if-options':'if 1 {return -level 0 -tag X value}',
 'eval-options':'eval {return -level 0 -tag X value}',
 'namespace-options':'namespace eval n {return -level 0 -tag X value}',
 'substitution-options':'list [return -level 0 -tag X value]',
 'expression-options':'expr {[return -level 0 -tag X 4]+1}',
 'while-options':'set i 0;while {[incr i]<2} {return -level 0 -tag X value}',
 'for-options':'for {set i 0} {$i<1} {incr i} {return -level 0 -tag X value}',
 'foreach-options':'foreach x {1} {return -level 0 -tag X value}',
 'lmap-options':'lmap x {1 2} {return -level 0 -tag X $x}',
 'procedure-options':'proc p {} {return -tag X value};p',
 'try-ok':'try {set x 3}',
 'try-error':'try {error bad}',
 'try-on-ok':'try {set x 3} on ok {value options} {list $value [normalized $options]}',
 'try-trap':'try {throw {APP FAIL detail} bad} trap {APP FAIL} {value options} {list $value [dict get $options -errorcode]}',
 'try-trap-whitespace':'try {throw { APP   FAIL detail } bad} trap { APP FAIL } {value} {return -level 0 recovered}',
 'try-trap-not-glob':'try {throw {APP FAIL} bad} trap {APP *} {} {set result wrong}',
 'try-trap-empty':'try {error bad} trap {} {value} {list matched $value}',
 'try-first-wins':'try {throw {APP FAIL} bad} on error {} {set result first} trap {APP} {} {set result second}',
 'try-fallthrough':'try {error bad} on error {a} - on ok {b c ignored} {list [info exists a] $b [dict get $c -code]}',
 'try-multiple-fallthrough':'try {return value} on return {a} - on ok {} - on error {x y} {list $x [dict get $y -level]}',
 'try-empty-variable-names':'set value untouched;try {error bad} on error {{} options} {list $value [dict get $options -code]}',
 'try-handler-rethrow':'try {throw {APP FAIL} bad} on error {value options} {return -options $options $value}',
 'try-handler-return':'try {error first} on error {} {return -code error second}',
 'try-handler-error':'try {error first} on error {} {error second}',
 'try-handler-failure-finally':'set cleaned 0;catch {try {error first} on error {} {error second} finally {set cleaned 1}};set cleaned',
 'try-finally-success-options':'try {return -level 0 -tag original value} finally {return -level 0 -tag cleanup discarded}',
 'try-finally-custom-options':'try {set x 3} finally {return -level 0 -tag cleanup discarded}',
 'try-nested-during':'try {try {error A} on error {} {error B}} finally {error C}',
 'try-error-global':'catch {try {error A} on error {} {error B} finally {error C}} value options;list $value $::errorCode [dict get $options -during -errorcode]',
 'dict-update-return':'set d {x 1};proc p {} {global d;dict update d x value {set value 9;return done}};list [p] $d',
 'dict-with-error':'set d {x 1};catch {dict with d {set x 7;throw APP bad}} value options;list $d $value [dict get $options -errorcode]',
 'dict-map-continue':'dict map {k v} {a 1 b 2 c 3} {if {$v==2} {return -level 0 -code continue};expr {$v*2}}',
 'dict-for-break':'set seen {};dict for {k v} {a 1 b 2 c 3} {lappend seen $k;if {$v==2} {return -level 0 -code break}};set seen',
 'dict-filter-continue':'dict filter {a 1 b 2 c 3} script {k v} {if {$v==2} {return -level 0 -code continue};expr {1}}',
 'lmap-break':'lmap x {1 2 3} {if {$x==3} {return -level 0 -code break};expr {$x*2}}',
 'lmap-continue':'lmap x {1 2 3} {if {$x==2} {return -level 0 -code continue};expr {$x*2}}',
 'proc-break-loop':'proc stop {} {return -code break};set seen {};foreach x {1 2 3} {lappend seen $x;stop};set seen',
 'proc-continue-loop':'proc skip {} {return -code continue};set seen {};foreach x {1 2} {lappend seen $x;skip;lappend seen wrong};set seen',
 'try-finally-break-loop':'set seen {};foreach x {1 2 3} {try {if {$x==2} {break};lappend seen $x} finally {lappend seen F}};set seen',
 'try-finally-return-proc':'set seen {};proc p {} {global seen;try {return done} finally {lappend seen clean}};list [p] $seen',
 'uplevel-return':'proc inner {} {uplevel 1 {return -level 1 done}};proc outer {} {inner;return after};outer',
 'namespace-return':'proc p {} {namespace eval n {return done};return after};p',
 'ensemble-return':'namespace eval a {proc p {} {return -code 7 custom};namespace export p;namespace ensemble create};a p',
}
for name,source in programs.items():observe(name,source)

scripts={'ok':'set result body','error':'error body','return':'return body','break':'break','continue':'continue','custom':'return -level 0 -code 7 body'}
for name,body in scripts.items():
 for final_name,final in scripts.items():
  observe('finally-'+name+'-'+final_name,'try {'+body+'} finally {'+final.replace('body','final')+'}')
 for handler in ['ok','error','return','break','continue','7']:
  observe('handler-'+name+'-'+handler,'try {'+body+'} on '+handler+' {value options} {list handled $value [normalized $options]}')

# Locations and explicitly supplied error metadata are compared directly.
metadata={
 'explicit-info':'catch {error bad custom {APP FAIL}} value options;list $value [dict get $options -errorinfo] [dict get $options -errorcode] [dict get $options -errorstack] $::errorInfo $::errorCode',
 'explicit-stack':'catch {return -level 0 -code error -errorinfo custom -errorstack {INNER here} bad} value options;list [dict get $options -errorinfo] [dict get $options -errorstack] [info errorstack]',
 'return-proc-explicit-info':'proc p {} {return -code error -errorinfo custom -errorstack {INNER here} -errorcode APP bad};catch {p} value options;list [dict get $options -errorinfo] [dict get $options -errorstack] [dict get $options -errorline]',
 'simple-error-info':'catch {error bad} value options;dict get $options -errorinfo',
 'line-number':'catch {\nset x 1\nerror bad\n} value options;dict get $options -errorline',
 'line-semicolon':'catch {set x 1; error bad} value options;dict get $options -errorline',
 'line-comments':'catch {# comment\n\n  error bad} value options;dict get $options -errorline',
 'line-outer':'proc p {} {\nerror bad\n};catch {\n\np} value options;dict get $options -errorline',
 'cached-error-position':'set source {\nset x 1\nerror bad};set out {};foreach i {1 2} {catch $source value options;lappend out [dict get $options -errorline]};set out',
 'repeated-error-globals':'catch {error A infoA CODE_A};set first [list $::errorInfo $::errorCode];catch {error B infoB CODE_B};list $first $::errorInfo $::errorCode',
}
for name,source in metadata.items():add(name,source)

for clause in ['on bad {} {}','trap \\{ {} {}','on error \\{ {}','on error {} -','finally {} extra','finally','bad value','on error']:
 add('validation-'+clause,'set x 0;set code [catch {try {incr x} '+clause+'}];list $code $x')
for name,source in {
 'catch-result-write-failure':'array set a {};list [catch {catch {set x 9} a}] $x',
 'catch-options-write-failure':'array set a {};list [catch {catch {set x 9} result a}] $result $x',
 'handler-variable-write-finally':'array set a {};set cleaned 0;set code [catch {try {error bad} on error {a} {set reached 1} finally {set cleaned 1}}];list $code $cleaned [info exists reached]',
 'bad-finally-validates-first':'set x 0;set code [catch {try {incr x} finally {incr x} on ok {} {incr x}}];list $code $x',
}.items():add(name,source)

invalid=['catch','catch a b c d','error','error a b c d','throw {} bad','throw APP','return -code bad X','return -level -1 X','return -level 1.5 X','return -options odd X','return -errorcode \\{ X','return -errorstack odd X','return -errorstack \\{ X','return -level 2147483648 X','try']
for i,source in enumerate(invalid):add('invalid-'+str(i),source)

for a,b in [('z','aa'),('long','x'),('-tag','-code'),('ab','abc'),('','a'),('中','中文'),('😀','中')]:
 add('lexical-'+a+'-'+b,'list [string compare {'+a+'} {'+b+'}] [expr {{'+a+'} < {'+b+'}}] [lsort [list {'+a+'} {'+b+'}]]')

# Exact message and error-code comparisons for common native failures.
for i,source in enumerate([
 'missing_command x','{two words} x','set absent','set a(x)',
 'set a 1;set a(x)','array set a {};set a','array set a {};set a(x)',
 'set x 1;unset x;set x','namespace eval n {set missing}',
 'variable x;set x','proc p {} {variable x;set x};p',
 'variable x;set x(a)',
 'proc p {} {upvar #0 absent alias;set alias(z)};p',
 'set x 1;proc p {} {upvar #0 x alias;set alias(z)};p',
 'proc p {} {upvar #0 absent(x) alias;set alias};p',
 'array set a {};proc p {} {upvar #0 a(x) alias;set alias};p',
 'proc p {} {upvar #0 missing alias;set alias};p',
 'expr {1/0}','expr {100000000000000000000/0}','expr {1%0}',
 'expr {0**-1}','expr {sqrt(-1)}','throw {} X',
 'return -code BAD X','try {} on BAD {} {}',
 'return -level -1 X','return -level abc X','return -level 1.5 X',
 'return -level 2147483648 X',
]):
 add('native-error-'+str(i),'catch {'+source+'} value options;list $value [dict get $options -errorcode]')
for name,source in {
 'trap-variable':'try {set absent} trap {TCL LOOKUP VARNAME} {value options} {dict get $options -errorcode}',
 'trap-command':'try {missing_command} trap {TCL LOOKUP COMMAND} {} {set recovered yes}',
 'trap-arithmetic':'try {expr {1/0}} trap {ARITH DIVZERO} {} {set recovered yes}',
 'trap-read':'array set a {};try {set a(missing)} trap {TCL READ VARNAME} {} {set recovered yes}',
}.items():add(name,source)
