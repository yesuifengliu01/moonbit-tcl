"""Original stateful scripts for parser/object optimization, evaluated by Tcl."""
cases=[]
def add(name,source):cases.append(dict(name=name,source=source))
programs=[
 ('expr-variable','set x 1; set out {}; foreach x {1 2 3} {lappend out [expr {$x+3}]}; set out'),
 ('dynamic-command','proc p {} {return old}; set code p; set out [eval $code]; proc p {} {return new}; list $out [eval $code]'),
 ('rename-command','proc p {} {return old}; set code p; eval $code; rename p q; proc p {} {return new}; list [eval $code] [q]'),
 ('namespace-context','namespace eval a {variable x 1; proc p {} {variable x; incr x}}; namespace eval b {variable x 5; proc p {} {variable x; incr x}}; set code {p}; list [namespace eval a $code] [namespace eval b $code] [namespace eval a $code]'),
 ('recursive-cache','proc f {n} {if {$n<2} {return $n}; expr {[f [expr {$n-1}]]+[f [expr {$n-2}]]}}; f 10'),
 ('recursive-mutate','proc p {n} {global x; incr x; if {$n>0} {p [expr {$n-1}]}; return $x}; set x 0; list [p 4] [p 2]'),
 ('parse-error-repeat',r'set code "incr x; set y \{"; set x 0; list [catch {eval $code}] [catch {eval $code}] $x'),
 ('early-return-invalid',r'set code "return yes; set y \{"; list [catch {eval $code} result] $result [catch {eval $code} result] $result'),
 ('lazy-variable-change','set x 0; set out {}; foreach flag {0 1 0 1} {lappend out [expr {$flag && [incr x]}]}; list $out $x'),
 ('command-replacement','set code {set x 3}; eval $code; proc set args {return changed}; eval $code'),
 ('list-copy','set xs {}; for {set i 0} {$i<5} {incr i} {lappend xs $i}; set copy $xs; lappend xs X; list $copy $xs'),
 ('list-alias','set xs {}; upvar #0 xs ys; for {set i 0} {$i<5} {incr i} {lappend ys $i}; list $xs $ys'),
 ('list-alias-unset','set xs {}; upvar #0 xs ys; foreach i {1 2} {lappend ys $i}; unset xs; lappend ys 3; list $xs $ys'),
 ('list-self','set xs {a}; foreach i {1 2} {lappend xs $xs}; set xs'),
 ('list-to-dict','set x {}; foreach item {a 1 b 2} {lappend x $item}; dict incr x a; list $x [dict get $x b]'),
 ('dict-to-list','dict set x a 1; foreach item {b 2} {lappend x $item}; set x'),
 ('list-set-invalidate','set x {}; foreach i {1 2} {lappend x $i}; set x {new}; foreach i {3 4} {lappend x $i}; set x'),
 ('dict-copy','set d {}; foreach i {a b c} {dict set d $i $i}; set copy $d; dict set d a changed; list $copy $d'),
 ('dict-alias','set d {}; upvar #0 d e; foreach i {a b c} {dict set e $i $i}; list $d $e'),
 ('dict-replace','set d {}; foreach i {a b c} {dict set d $i $i}; set d {x 2}; dict incr d x; set d'),
 ('dict-self','set d {}; dict set d x 1; foreach i {y z} {dict set d $i $d}; set d'),
 ('dict-nested-fallback','set d {}; foreach i {a b c} {dict set d $i 1}; dict set d a x 2; dict set d b 3; set d'),
 ('dict-with-cache','set d {}; foreach i {a b c} {dict set d $i 1}; dict with d {incr a; unset b}; dict incr d c; set d'),
 ('dict-update-error','set d {}; foreach i {a b c} {dict set d $i 1}; catch {dict update d a x {incr x; error bad}}; dict set d z 3; set d'),
 ('array-list','array set a {}; foreach i {1 2 3} {lappend a(x) $i}; set a(x)'),
 ('array-dict','array set a {}; foreach i {a b c} {dict set a(x) $i 1}; dict incr a(x) a; set a(x)'),
 ('list-array-collision','foreach i {1 2} {lappend x $i}; array set x {}'),
 ('dict-array-collision','foreach i {a b} {dict set x $i 1}; set x(0) 4'),
 ('loop-if-result','set xs {}; foreach x {0 1 2} {if {$x>0} {lappend xs $x}}; set xs'),
 ('lmap-result','set xs {}; lmap x {1 2 3} {lappend xs $x}'),
 ('catch-result','set xs {}; foreach x {1 2} {lappend xs $x}; list [catch {lappend xs 3} result] $result $xs'),
 ('proc-result','proc p {} {set xs {}; foreach x {1 2} {lappend xs $x}; lappend xs 3}; p'),
 ('empty-namespace','namespace eval n {variable x 3; namespace eval {} {namespace current}}'),
 ('dict-duplicates','set d {a 1 b 2 a 3}; dict append d a; set d'),
 ('list-whitespace','set x { a   b }; foreach item {c d} {lappend x $item}; set x'),
 ('dict-zero-append','set d { a 1   b 2 }; dict append d a; set d'),
 ('increment-prefix','set x 010; for {set i 0} {$i<3} {incr i} {incr x}; set x'),
 ('dynamic-script-eviction','set out 0; for {set i 0} {$i<300} {incr i} {eval [list set x $i]; incr out}; list $x $out'),
 ('empty-tail-comments','set code "set x 3; # tail\\n"; list [eval $code] [eval $code]'),
]
for name,source in programs:add('cache-'+name,source)
for a in ['-999999999','999999999','1000000000','-1000000000','2147483647','-2147483648','999999998']:
    for b in ['-3','0','3','999999999']:
        for op in ['+','-','*','/','%','&','|','^','==','<','**']:
            # Avoid enormous reference exponents, independently of MoonBit limits.
            if op=='**' and b=='999999999':continue
            add(f'small-{a}-{op}-{b}',f'expr {{{a} {op} {b}}}')
