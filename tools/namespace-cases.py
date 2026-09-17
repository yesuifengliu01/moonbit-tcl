"""Original namespace/lifecycle programs, evaluated by unmodified Tcl semantics."""
cases=[]
def add(name,source):cases.append(dict(name=name,source=source))
base='namespace eval a {namespace export p; variable x 10; proc p {{v 1}} {variable x; incr x $v}; proc private {} {return hidden}};'
programs={
 'ensemble-map-whitespace':'namespace eval a {namespace ensemble create -map { x {::list old} x {::list new} } -parameters { a  b } -subcommands { x  y } -unknown { ::list  a }};namespace ensemble configure a',
 'ensemble-map-relative-duplicates':'namespace eval a {namespace ensemble create -map {x {list old} x {list new}}};namespace ensemble configure a -map',
 'unknown-global-custom':'proc h args {return custom};namespace unknown h;namespace eval a {list [namespace unknown] [missing]}',
 'unknown-root-reset':'proc unknown args {return yes};namespace unknown {};list [namespace unknown] [missing]',
 'export-default':'namespace eval a {namespace export}',
 'export-duplicates':'namespace eval a {namespace export a a b a; namespace export}',
 'export-clear':'namespace eval a {namespace export a; namespace export -clear b c; namespace export}',
 'export-empty-clear':'namespace eval a {namespace export a; namespace export -clear; namespace export}',
 'export-partial-error':'namespace eval a {namespace export a; catch {namespace export -clear b ::bad}; namespace export}',
 'export-future':'namespace eval a {namespace export p}; namespace import a::*; proc a::p {} {return yes}; list [namespace import] [a::p]',
 'export-not-private':base+'namespace import a::*;list [p 2] [catch {private}] [lsort [namespace import]]',
 'import-repeat':base+'namespace import a::*;namespace import a::*;list [p] [p] [namespace import]',
 'import-force-query':base+'namespace import a::*;namespace import -force',
 'import-conflict':base+'proc p {} {return local};list [catch {namespace import a::*}] [p]',
 'import-force':base+'proc p {} {return local};namespace import -force a::*;p 4',
 'import-partial':base+'catch {namespace import a::p missing::*};list [namespace import] [p]',
 'import-no-export':'namespace eval a {proc p {} {return yes}};namespace import a::*;list [namespace import] [catch {p}]',
 'import-origin':base+'namespace eval b {namespace import ::a::*;namespace export *};namespace import b::*;list [p 3] [namespace origin p] [namespace which p] [namespace origin a::p]',
 'import-redefine-origin':base+'namespace import a::*;proc a::p args {return changed};list [p] [namespace origin p]',
 'import-redefine-alias':base+'namespace eval b {namespace import ::a::*;namespace export *};namespace import b::*;proc b::p {} {return replaced};list [p] [namespace origin p] [a::p]',
 'import-force-alias':base+'namespace import a::*;namespace export p;namespace eval c {namespace import ::p};namespace eval b {namespace export *;proc p {} {return replaced}};namespace import -force b::*;list [p] [c::p] [namespace origin c::p]',
 'import-cycle':base+'namespace eval b {namespace import ::a::*;namespace export *};list [catch {namespace eval a {namespace import -force ::b::*}}] [b::p]',
 'import-info':base+'namespace import a::*;list [info args p] [info body p] [info default p v result] $result [info procs p]',
 'import-rename-original':base+'namespace import a::*;rename a::p a::q;list [p] [namespace origin p] [catch {a::p}] [a::q]',
 'import-rename-other-space':base+'namespace eval b {variable x 100};namespace import a::*;rename a::p b::q;list [p] [namespace origin p]',
 'import-rename-alias':base+'namespace import a::*;rename p q;list [q] [namespace import] [namespace origin q]',
 'import-delete-original':base+'namespace eval b {namespace import ::a::*;namespace export *};namespace import b::*;rename a::p {};list [namespace import] [namespace eval b {namespace import}] [catch {p}]',
 'import-delete-middle':base+'namespace eval b {namespace import ::a::*;namespace export *};namespace import b::*;rename b::p {};list [catch {p}] [a::p]',
 'import-delete-alias':base+'namespace import a::*;rename p {};a::p',
 'import-delete-space':base+'namespace import a::*;namespace delete a;list [namespace import] [catch {p}]',
 'import-recreate-space':base+'namespace import a::*;namespace delete a;namespace eval a {proc p {} {return fresh};namespace export *};list [namespace import] [catch {p}];namespace import a::*;p',
 'forget-simple':base+'namespace import a::*;namespace forget p;list [namespace import] [a::p]',
 'forget-pattern':base+'namespace import a::*;namespace forget p*;list [namespace import] [a::p]',
 'forget-qualified':base+'namespace import a::*;namespace forget a::*;list [namespace import] [a::p]',
 'forget-renamed-alias':base+'namespace import a::*;rename p q;namespace forget a::p;list [namespace import] [catch {q}]',
 'forget-renamed-original':base+'namespace import a::*;rename a::p a::q;namespace forget a::p;set first [namespace import];namespace forget a::q;list $first [namespace import]',
 'forget-no-longer-exported':base+'namespace import a::*;namespace eval a {namespace export -clear};namespace forget a::*;namespace import',
 'forget-keeps-local':base+'namespace import a::*;proc p {} {return local};namespace forget *;p',
 'forget-chain-original':base+'namespace eval b {namespace import ::a::*;namespace export *};namespace import b::*;namespace forget a::*;namespace import',
 'forget-chain-immediate':base+'namespace eval b {namespace import ::a::*;namespace export *};namespace import b::*;namespace forget b::*;namespace import',
 'forget-transitive':base+'namespace eval b {namespace import ::a::*;namespace export *};namespace import b::*;namespace eval b {namespace forget *};list [namespace import] [a::p]',
 'path-default':'namespace eval a {namespace path}',
 'path-duplicates':'namespace eval a {};namespace eval b {namespace path {::a ::a ::};namespace path}',
 'path-atomic':'namespace eval a {};namespace eval b {};namespace path ::a;catch {namespace path {::b ::bad}};namespace path',
 'path-relative':'namespace eval a {namespace eval b {};namespace path b;namespace path}',
 'path-no-inheritance':'namespace eval a {namespace path ::;namespace eval b {namespace path}}',
 'path-redefinition':'namespace eval a {proc p {} {return old}};namespace path a;set first [p];proc a::p {} {return new};list $first [p]',
 'path-delete-recreate':'namespace eval a {proc p {} {return old}};namespace path a;namespace delete a;namespace eval a {proc p {} {return new}};list [namespace path] [catch {p}]',
 'path-no-chaining':'namespace eval a {proc p {} {return A}};namespace eval b {namespace path ::a};namespace path b;catch {p}',
 'path-info-procs':'namespace eval a {proc p {} {return a}};namespace eval b {namespace path ::a;list [info commands p] [info procs p] [namespace which p]}',
 'path-subspace':'namespace eval a::sub {proc p {} {return A}};namespace path a;sub::p',
 'path-variable-independent':'set x global;namespace eval a {variable x A};namespace eval b {namespace path ::a;set x}',
 'native-rename':'rename list collect;list [collect x y]',
 'native-renamed-invoke':'rename list collect;collect a {b c}',
 'native-rename-import':'namespace eval a {};rename join a::calculate;namespace eval a {namespace export *};namespace import a::*;calculate {a b} -',
 'native-delete':'rename list {};catch {list x}',
 'native-shadow-delete':'proc list args {return local};rename list {};catch {list x}',
 'empty-command':'namespace eval a {};proc {} {} {return root};proc a:: {} {return child};list [{}] [a::] [namespace which a::]',
 'inscope-safe':'namespace eval a {proc p args {return $args}};namespace inscope a p {a b} {$x} {[error nope]} {; error nope}',
 'code-callback':'namespace eval a {proc p args {return $args};set ::callback [namespace code p]};eval $callback [list {a b} {x;y}]',
 'code-idempotent':'namespace eval a {namespace code [namespace code p]}',
 'upvar-namespace':'namespace eval a {variable x 4};proc p {} {namespace upvar ::a x y;incr y};list [p] $a::x',
 'upvar-array':'namespace eval a {array set x {key 4}};proc p {} {namespace upvar ::a x z;incr z(key)};list [p] $a::x(key)',
 'upvar-missing':'namespace eval a {};proc p {} {namespace upvar ::a x y;set y 8};list [p] $a::x',
 'upvar-relative':'namespace eval a {namespace eval b {variable x 3};namespace upvar b x y;incr y};set a::b::x',
 'unknown-default':'namespace eval a {namespace unknown}',
 'unknown-custom':'proc h args {return $args};namespace eval a {namespace unknown {::h prefix};missing {a b} x}',
 'unknown-scope':'namespace eval a {proc h args {list [namespace current] $args};namespace unknown h;missing x}',
 'unknown-reset':'proc unknown args {return global};namespace eval a {namespace unknown {};missing x}',
 'unknown-not-inherited':'namespace eval a {proc h args {return custom};namespace unknown h;namespace eval b {catch {missing}}}',
 'ensemble-default':'namespace eval a {namespace export p;proc p args {return $args};namespace ensemble create};a p 1 {two words}',
 'ensemble-config-default':'namespace eval a {namespace ensemble create -command ::e};namespace ensemble configure e',
 'ensemble-dynamic':'namespace eval a {namespace export *;proc p {} {return P};namespace ensemble create};set first [a p];proc a::q {} {return Q};list $first [a q]',
 'ensemble-map':'namespace eval a {namespace ensemble create -command ::e -map {p {::list prefix} q ::string}};list [e p {a b}] [e q length abc]',
 'ensemble-map-relative':'namespace eval a {proc p args {return $args};namespace ensemble create -map {go {p fixed}}};list [a go x] [namespace ensemble configure a -map]',
 'ensemble-map-duplicates':'namespace eval a {namespace ensemble create -map {x {::list old} x {::list new}}};list [a x A] [namespace ensemble configure a -map]',
 'ensemble-config-scope':'namespace eval a {namespace ensemble create -command ::e};namespace eval b {proc p {} {namespace current};namespace ensemble configure ::e -map {go p}};list [e go] [namespace ensemble configure e -namespace]',
 'ensemble-prefix':'namespace eval a {namespace ensemble create -map {alpha {::list A} beta {::list B}}};list [a al x] [a b y]',
 'ensemble-ambiguous':'namespace eval a {namespace ensemble create -map {aa ::list ab ::list}};catch {a a x}',
 'ensemble-exact-wins':'namespace eval a {namespace ensemble create -map {a {::list A} ab {::list AB}}};a a x',
 'ensemble-prefix-disable':'namespace eval a {namespace ensemble create -prefixes 0 -map {alpha ::list}};list [catch {a al x}] [a alpha x]',
 'ensemble-subcommands':'namespace eval a {proc p {} {return P};namespace ensemble create -subcommands {p q} -map {q {::list Q} hidden ::list}};list [a p] [a q] [catch {a hidden}]',
 'ensemble-parameters':'namespace eval a {namespace ensemble create -command ::e -parameters {x y} -map {go {::list fixed}}};e A B go C',
 'ensemble-unknown-prefix':'proc h {command sub args} {return {::list fallback}};namespace eval a {namespace ensemble create -command ::e -unknown ::h};e nope A {B C}',
 'ensemble-unknown-reconfigure':'proc h args {namespace ensemble configure ::e -map {go {::list fixed}};return {}};namespace eval a {namespace ensemble create -command ::e -unknown ::h};e go A',
 'ensemble-unknown-once':'set calls 0;proc h args {global calls;incr calls;return {}};namespace eval a {namespace ensemble create -unknown ::h};list [catch {a missing}] $calls',
 'ensemble-unknown-arguments':'set seen {};proc h args {set ::seen $args;return {::list fixed}};namespace eval a {namespace ensemble create -command ::e -parameters X -unknown ::h};list [e A missing B] $seen',
 'ensemble-no-frame':'namespace eval a {namespace ensemble create -map {go {::set local}}};proc p {} {set local 3;a go 9;return $local};p',
 'ensemble-proc-frame':'namespace eval a {proc p {} {uplevel 1 {incr x}};namespace export p;namespace ensemble create};proc caller {} {set x 2;a p;return $x};caller',
 'ensemble-rename':'namespace eval a {proc p {} {namespace current};namespace export *;namespace ensemble create};rename a renamed;list [renamed p] [namespace ensemble configure renamed -namespace]',
 'ensemble-delete-space':'namespace eval a {namespace ensemble create -command ::e};namespace delete a;list [namespace ensemble exists e] [catch {e x}]',
 'ensemble-import':'namespace eval a {namespace ensemble create -command e -map {p ::list};namespace export e};namespace import a::*;list [e p x] [namespace ensemble exists e] [namespace ensemble configure e -namespace]',
 'ensemble-config-atomic':'namespace eval a {namespace ensemble create -command ::e};catch {namespace ensemble configure e -prefixes 0 -bad 1};namespace ensemble configure e -prefixes',
 'ensemble-config-abbreviated':'namespace eval a {namespace ens cr -comm ::e -pref 0};namespace ens conf e -pref',
 'ensemble-unknown-abnormal':'proc h args {error bad};namespace eval a {namespace ensemble create -unknown ::h};catch {a missing}',
 'ensemble-nested':'namespace eval a {namespace ensemble create -map {go {::b run}}};namespace eval b {namespace ensemble create -map {run {::list fixed}}};a go x',
}
for name,source in programs.items():add(name,source)

# Resolution order varies independently across local/path/global definitions.
for local in [False,True]:
 for path1 in [False,True]:
  for path2 in [False,True]:
   for global_ in [False,True]:
    setup='namespace eval a {};namespace eval b {};namespace eval c {};'
    for flag,name,value in [(local,'c::p','local'),(path1,'a::p','first'),(path2,'b::p','second'),(global_,'p','global')]:
     if flag:setup+=f'proc {name} {{}} {{return {value}}};'
    for order in ['::a ::b','::b ::a',':: ::a ::b']:
     add(f'resolution-{local}-{path1}-{path2}-{global_}-{order}',setup+f'namespace eval c {{namespace path {{{order}}};list [catch {{p}} result] [namespace which p] [expr {{[namespace which p] eq "" ? "missing" : $result}}]}}')

for pattern in ['p','p*','?','[pq]','z*','*','private']:
 add('import-glob-'+pattern,base+f'namespace import a::{pattern};lsort [namespace import]')
for text in ['','a b','$x','[error no]','; error no','{braces}','line\nnext','\\path','中文']:
 # A braced literal is safe for these balanced fixture strings.
 add('ensemble-literal-'+repr(text),'namespace eval a {namespace ensemble create -map {go {::list fixed}}};a go {'+text+'}')

invalid=[
 'namespace import p','namespace import missing::*','namespace import ::*',
 'namespace export ::p','namespace eval a {namespace import ::a::*}',
 'namespace forget missing::*','namespace origin missing','namespace origin',
 'namespace path ::missing','namespace path a b','namespace upvar ::missing x y',
 'namespace upvar :: x','namespace which -invalid p','namespace unknown a b',
 'namespace ensemble','namespace ensemble exists','namespace ensemble configure missing',
 'namespace eval a {namespace ensemble create -map {x {}}}',
 'namespace eval a {namespace ensemble create -map {x}}',
 'namespace eval a {namespace ensemble create -prefixes maybe}',
 'namespace eval a {namespace ensemble create -namespace ::}',
 'namespace eval a {namespace ensemble create -command ::missing::x}',
 'namespace eval a {namespace ensemble create -map {x ::list}};a',
 'namespace eval a {namespace ensemble create -parameters {x y} -map {go ::list}};a A go',
 'namespace eval a {namespace ensemble create};namespace ensemble configure a -namespace ::',
 'namespace eval a {namespace ensemble create};namespace ensemble configure a -parameters',
 'namespace eval a {namespace ensemble create -subcommands p};a p',
 'namespace eval a {namespace ensemble create -map {p ::missing}};a p',
]
for i,source in enumerate(invalid):add('boundary-'+str(i),source)


# Stateful mutation traces stress references instead of only isolated syntax.
import random
rng=random.Random(20260918)
mutations=[
 'proc a::p {} {return changed}', 'proc b::p {} {return local}',
 'namespace eval b {namespace import -force ::a::*}',
 'namespace eval c {namespace import -force ::b::*}',
 'namespace eval a {namespace import -force ::c::*}',
 'rename a::p a::q', 'rename a::q a::p', 'rename b::p b::q',
 'rename b::p {}', 'rename a::p {}', 'namespace eval b {namespace forget *}',
 'namespace eval c {namespace forget ::a::*}',
 'namespace eval c {namespace forget ::b::*}',
 'namespace delete a', 'namespace eval a {namespace export *;proc p {} {return fresh}}',
 'namespace eval b {namespace path ::a}', 'namespace eval c {namespace path ::b}',
 'namespace eval b {p}', 'namespace eval c {p}', 'a::p', 'b::p', 'c::p',
 'namespace origin b::p', 'namespace origin c::p',
 'namespace eval a {namespace export -clear}',
]
for i in range(96):
 setup='namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};'
 for op in rng.choices(mutations,k=12):
  setup+='set status [catch {'+op+'} result];lappend out [list $status [expr {$status == 0 ? $result : ""}]];'
 setup+='foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : ""}]]};set out'
 add('mutation-trace-'+str(i),setup)

for name,source in {
 'empty-exists':'namespace eval a {namespace exists {}}',
 'empty-parent':'namespace eval a {namespace parent {}}',
 'empty-children':'namespace eval a {namespace children {}}',
 'empty-path':'namespace eval a {namespace path {{}}}',
 'empty-upvar':'namespace eval a {namespace upvar {} x y}',
 'empty-delete':'namespace eval a {namespace delete {}}',
 'missing-parent':'namespace parent missing',
 'missing-children':'namespace children missing',
 'auto-import-observed':'proc auto_import p {set ::seen $p};namespace eval a {};namespace import a::*;set seen',
 'auto-import-create':'proc auto_import p {namespace eval a {proc p {} {return yes};namespace export *}};namespace import a::*;p',
 'auto-import-error':'proc auto_import p {error loadfail};namespace eval a {};namespace import a::*',
 'auto-import-context':'proc auto_import p {set ::seen [uplevel 1 {namespace current}]};namespace eval a {};namespace eval b {namespace import ::a::*};set seen',
}.items():add(name,source)

for name,source in {
 'same-origin-import':'namespace eval a {proc p {} {return A};namespace export *};namespace eval b {namespace import ::a::*;namespace export *};namespace import a::*;namespace import b::*;namespace origin p',
 'same-origin-reimport':'namespace eval a {proc p {} {return A};namespace export *};namespace eval b {namespace import ::a::*;namespace export *};namespace import b::*;namespace import a::*;namespace origin p',
 'ensemble-unknown-delete':'proc h args {rename ::e {};return {::list fixed}};namespace eval a {namespace ensemble create -command ::e -unknown h};e missing X',
 'ensemble-unknown-delete-space':'proc h args {namespace delete ::a;return {::list fixed}};namespace eval a {namespace ensemble create -command ::e -unknown h};e missing X',
 'ensemble-unknown-replace':'proc h args {proc ::e args {return replacement};return {::list fixed}};namespace eval a {namespace ensemble create -command ::e -unknown h};e missing X',
 'ensemble-unknown-reconfigure-params':'proc h args {namespace ensemble configure ::e -parameters X -map {go ::list};return {}};namespace eval a {namespace ensemble create -command ::e -unknown h};e A go B',
 'ensemble-unknown-reconfigure-short':'proc h args {namespace ensemble configure ::e -parameters {X Y Z};return {::list fixed}};namespace eval a {namespace ensemble create -command ::e -unknown h};e A B',
 'ensemble-unknown-rename':'proc h args {rename ::e ::f;return {::list fixed}};namespace eval a {namespace ensemble create -command ::e -unknown h};e missing X',
}.items():add(name,source)

for count in range(4):
 for args in ['A B','A B C D E']:
  source='proc h args {namespace ensemble configure ::e -parameters {'+' '.join('XYZ'[:count])+'};return {::list fixed}};namespace eval a {namespace ensemble create -command ::e -unknown h};e '+args
  add('unknown-parameter-rewrite-'+str(count)+'-'+args,source)
