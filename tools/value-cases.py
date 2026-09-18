"""Original value-transport programs; expected results come only from native Tcl."""
import math,random,struct
cases=[]
def add(name,source):cases.append({'name':name+'-'+str(len(cases)),'source':source})
paths={
 'direct':'set x $v', 'quoted':'set x "$v"',
 'empty-prefix':'set e {};set x "$e$v"', 'empty-suffix':'set e {};set x "$v$e"',
 'format-s':'set x [format %s $v]', 'append-empty':'set x $v;append x {}',
 'append-no-args':'set x $v;append x', 'string-cat':'set x [string cat $v]',
 'string-range':'set x [string range $v 0 end]', 'string-trim':'set x [string trim $v]',
 'subst':'set x [subst {$v}]', 'list':'set x [lindex [list $v] 0]',
 'join':'set x [join [list $v] {}]',
 'concat-list':'set x [lindex [concat [list $v] [list a]] 0]',
 'concat-text':'set x [lindex [concat [list $v] a] 0]',
 'concat-one':'set x [lindex [concat [list $v]] 0]',
 'lrange':'set x [lindex [lrange [list $v a] 0 0] 0]',
 'lreverse':'set x [lindex [lreverse [list a $v]] 0]',
 'lrepeat':'set x [lindex [lrepeat 3 $v] 2]',
 'lappend':'lappend a $v;set x [lindex $a 0]',
 'lset':'set a [list 0];lset a 0 $v;set x [lindex $a 0]',
 'linsert':'set x [lindex [linsert {} 0 $v] 0]',
 'lreplace':'set x [lindex [lreplace {a} 0 0 $v] 0]',
 'lsearch':'set x [lsearch -inline -glob [list 0 $v] *e*]',
 'lsort':'set x [lindex [lsort -real [list $v $v]] 0]',
 'lsort-command':'proc cmp {a b} {expr {$a>$b ? 1 : $a<$b ? -1 : 0}};set x [lindex [lsort -command cmp [list $v $v]] 0]',
 'eval-list':'set x [eval [list set z $v]]',
 'eval-concat':'set x [eval [list set] [list z $v]]',
 'if':'set x [if 1 {set v}]',
 'expand':'set x [set {*}[list z $v]]',
 'expr':'set x [expr {$v}]', 'expr-plus':'set x [expr {$v+0.0}]',
 'expr-conditional':'set x [expr {1 ? $v : 0}]',
 'expr-min':'set x [expr {min($v,$v)}]',
 'proc':'proc f x {return $x};set x [f $v]',
 'proc-fallthrough':'proc f x {set x};set x [f $v]',
 'proc-default':'proc f [list [list p $v]] {return $p};set x [f]',
 'proc-default-info':'proc f [list [list p $v]] {};info default f p x',
 'proc-args':'proc f args {lindex $args 1};set x [f 0 $v]',
 'upvar':'proc f {} {upvar 1 v a;return $a};set x [f]',
 'global':'proc f {} {global v;set v};set x [f]',
 'uplevel':'proc f {} {uplevel 1 {set v}};set x [f]',
 'uplevel-list':'proc f a {uplevel 1 [list set z $a]};set x [f $v]',
 'namespace':'namespace eval n {};set x [namespace eval n [list set z $v]]',
 'namespace-inscope':'namespace eval n {};set x [namespace inscope n [list set z] $v]',
 'namespace-variable':'namespace eval n [list variable z $v];set x $n::z',
 'rename':'rename set store;store x [store v]',
 'import':'namespace eval n {proc f x {return $x};namespace export f};namespace import n::f;set x [f $v]',
 'ensemble':'namespace eval n {proc f x {return $x};namespace ensemble create -map {get f}};set x [n get $v]',
 'unknown':'proc unknown {name args} {lindex $args 0};set x [missing $v]',
 'catch-ok':'catch {set v} x', 'catch-return':'catch {return $v} x',
 'catch-error':'catch {error $v} x', 'catch-throw':'catch {throw CODE $v} x',
 'return-level':'proc f a {return -level 0 $a};set x [f $v]',
 'return-options':'proc f a {return -options {-code 0 -level 1} $a};set x [f $v]',
 'try':'set x [try {set v} finally {set done 1}]',
 'try-handler':'set x [try {error $v} on error {r o} {set r}]',
 'try-return':'proc f a {try {return $a} finally {set b 1}};set x [f $v]',
 'foreach':'foreach x [list $v] {}',
 'lmap':'set x [lindex [lmap p [list $v] {set p}] 0]',
 'array-element':'set a(k) $v;set x $a(k)',
 'array-set':'array set a [list k $v];set x $a(k)',
 'array-get':'set a(k) $v;set x [lindex [array get a] 1]',
 'dict-get':'set x [dict get [dict create k $v] k]',
 'dict-key':'set x [lindex [dict keys [dict create $v a]] 0]',
 'dict-value':'set x [lindex [dict values [dict create k $v]] 0]',
 'dict-set':'dict set d k $v;set x [dict get $d k]',
 'dict-nested':'dict set d a b $v;set x [dict get $d a b]',
 'dict-lappend':'dict lappend d k $v;set x [lindex [dict get $d k] 0]',
 'dict-append-empty':'dict set d k $v;dict append d k {};set x [dict get $d k]',
 'dict-merge':'set x [dict get [dict merge [dict create k $v] {b 0}] k]',
 'dict-replace':'set x [dict get [dict replace {} k $v] k]',
 'dict-remove':'set x [dict get [dict remove [dict create a 0 k $v] a] k]',
 'dict-for':'dict for {k x} [dict create k $v] {}',
 'dict-map':'set x [dict get [dict map {k p} [dict create k $v] {set p}] k]',
 'dict-filter':'set x [dict get [dict filter [dict create k $v] key k] k]',
 'dict-filter-script':'set x [dict get [dict filter [dict create k $v] script {k p} {expr 1}] k]',
 'dict-update':'dict set d k $v;dict update d k x {}',
 'dict-with':'dict set d x $v;dict with d {}',
 'same-text':'set copy $v;set text [format %s $v];set x $copy',
 'copy-list':'set a [list $v];set b $a;lset b 0 0;set x [lindex $a 0]',
 'copy-list-append':'lappend a $v;set b $a;lappend b 0;set x [lindex $a 0]',
 'copy-nested':'set a [list [list $v]];set b $a;lset b 0 0 0;set x [lindex $a 0 0]',
 'copy-dict':'dict set a k $v;set b $a;dict set b k 0;set x [dict get $a k]',
 'copy-dict-nested':'dict set a k l $v;set b $a;dict set b k l 0;set x [dict get $a k l]',
 'list-string-length':'set a [list $v];string length $a;set x [lindex $a 0]',
 'list-append-empty':'set a [list $v];append a {};set x [lindex $a 0]',
 'numeric-list-conversion':'set copy $v;llength $v;set x $copy',
 'nested-expr':'set x [expr {($v*1.0)+0.0}]',
 'math-proc':'namespace eval ::tcl::mathfunc {};proc ::tcl::mathfunc::identity x {return $x};set x [expr {identity($v)}]',
}
numbers=['18446744073709551616',repr(2.0**83),repr(2.0**-24),repr(2.0**100),'-18446744073709551616','1.25','-0.0']
for value in numbers:
 for name,body in paths.items():
  add('transport-'+name,'scan '+value+' %f v;'+body+';list [format %.17g $x] $x [format %.17g $v]')

# The same decimal spelling must not make distinct objects share a double.
for body in [
 'set a $v;set b [format %s $v]',
 'set a [lindex [list $v] 0];set b [lindex [list [format %s $v]] 0]',
 'dict set d a $v;dict set d b [format %s $v];set a [dict get $d a];set b [dict get $d b]',
 'set ar(a) $v;set ar(b) [format %s $v];set a $ar(a);set b $ar(b)',
]:add('same-text-distinct','scan 18446744073709551616 %f v;'+body+';list [expr {$a==$b}] [format %.17g $a] [format %.17g $b]')

operations=[
 'string length $a','string index $a 0','string range $a 0 end',
 'string equal $a $a','string compare $a $a','string equal -nocase $a $a',
 'string compare -length 2 $a $a','string first 1 $a','string last 1 $a',
 'string toupper $a','string tolower $a','string totitle $a',
 'string trim $a','string trimleft $a','string trimright $a',
 'string repeat $a 1','string reverse $a','string replace $a 0 0 x',
 'string match * $a','string match -nocase * $a','string map {1 2} $a',
 'string is double $a','string is integer $a','string is list $a',
 'format %s $a','puts -nonewline $a','llength $a','lindex $a 0',
]
for operation in operations:
 for container in ['set a $v','set a [list $v]']:
  read='set a' if container=='set a $v' else 'lindex $a 0'
  add('representation','scan 18446744073709551616 %f v;'+container+';'+operation+';list [format %.17g ['+read+']] [format %.17g $v]')

rng=random.Random(20260918)
for i in range(120):
 x=struct.unpack('>d',rng.getrandbits(64).to_bytes(8,'big'))[0]
 if not math.isfinite(x):continue
 source='scan '+repr(x)+' %f v;'
 add('arithmetic',source+'list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]')

# A later type conversion reveals whether an operation returned the same value.
for name in ['direct','quoted','expr','expr-conditional','expr-min','proc','proc-default','proc-args','list','array-element','dict-get','catch-ok','try']:
 add('shared-'+name,'scan 18446744073709551616 %f v;'+paths[name]+';string length $x;list [format %.17g $x] [format %.17g $v]')
for op in ['+$v','abs($v)','double($v)','min($v,$v)','max($v,$v)']:
 add('shared-expression','scan 18446744073709551616 %f v;set x [expr {'+op+'}];string length $x;list [format %.17g $x] [format %.17g $v]')
for script in [
 'catch [list set z $v] x',
 'set x [try [list set z $v] finally {}]',
 'catch [list error $v] x',
 'set x [if 1 [list set z $v]]',
 'foreach p 1 [list set x $v]',
 'set x [lindex [lmap p 1 [list set z $v]] 0]',
 'namespace eval n {proc f x {return $x}};namespace ensemble create -command ens -map [list get [list n::f $v]];set x [ens get]',
 'proc handler {v args} {return $v};namespace unknown [list handler $v];set x [missing]',
]:add('script-value','scan 18446744073709551616 %f v;'+script+';list [format %.17g $x] [format %.17g $v]')
for script in ['string cat $v {}','string cat {} $v','string repeat $v 1','string map {} $v']:
 add('unchanged-string','scan 18446744073709551616 %f v;set x ['+script+'];list [format %.17g $x] [format %.17g $v]')

for script in [
 'set a [dict create k $v];set x [lindex $a 1]',
 'set a [list k $v];set x [dict get $a k]',
 'set a [dict create k $v];set b [concat $a];set x [dict get $b k]',
 'catch {return -foo $v ok} r o;set x [dict get $o -foo]',
 'catch {return -options [dict create -foo $v] ok} r o;set x [dict get $o -foo]',
 'set x [try {return -code error -foo $v bad} on return {r o} {dict get $o -foo}]',
 'catch {try {return -code error -foo $v bad} finally {error broken}} r o;set x [dict get $o -during -foo]',
 'proc f {} [list return $v];set x [f]',
]:add('object-representations','scan 18446744073709551616 %f v;'+script+';list [format %.17g $x] [format %.17g $v]')
