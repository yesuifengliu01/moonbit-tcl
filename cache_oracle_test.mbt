// Original programs, expected results evaluated by Tcl 8.6.15. Do not hand-edit.

///|
test "Tcl cache cache-expr-variable" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 1; set out {}; foreach x {1 2 3} {lappend out [expr {$x+3}]}; set out",
      budget=100000,
    ),
    "4 5 6",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache cache-dynamic-command" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc p {} {return old}; set code p; set out [eval $code]; proc p {} {return new}; list $out [eval $code]",
      budget=100000,
    ),
    "old new",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache cache-rename-command" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc p {} {return old}; set code p; eval $code; rename p q; proc p {} {return new}; list [eval $code] [q]",
      budget=100000,
    ),
    "new old",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache cache-namespace-context" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {variable x 1; proc p {} {variable x; incr x}}; namespace eval b {variable x 5; proc p {} {variable x; incr x}}; set code {p}; list [namespace eval a $code] [namespace eval b $code] [namespace eval a $code]",
      budget=100000,
    ),
    "2 6 3",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache cache-recursive-cache" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc f {n} {if {$n<2} {return $n}; expr {[f [expr {$n-1}]]+[f [expr {$n-2}]]}}; f 10",
      budget=100000,
    ),
    "55",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache cache-recursive-mutate" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc p {n} {global x; incr x; if {$n>0} {p [expr {$n-1}]}; return $x}; set x 0; list [p 4] [p 2]",
      budget=100000,
    ),
    "5 8",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache cache-parse-error-repeat" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set code \"incr x; set y \\{\"; set x 0; list [catch {eval $code}] [catch {eval $code}] $x",
      budget=100000,
    ),
    "1 1 2",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache cache-early-return-invalid" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set code \"return yes; set y \\{\"; list [catch {eval $code} result] $result [catch {eval $code} result] $result",
      budget=100000,
    ),
    "2 yes 2 yes",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache cache-lazy-variable-change" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0; set out {}; foreach flag {0 1 0 1} {lappend out [expr {$flag && [incr x]}]}; list $out $x",
      budget=100000,
    ),
    "{0 1 0 1} 2",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache cache-command-replacement" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set code {set x 3}; eval $code; proc set args {return changed}; eval $code",
      budget=100000,
    ),
    "changed",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache cache-list-copy" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set xs {}; for {set i 0} {$i<5} {incr i} {lappend xs $i}; set copy $xs; lappend xs X; list $copy $xs",
      budget=100000,
    ),
    "{0 1 2 3 4} {0 1 2 3 4 X}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache cache-list-alias" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set xs {}; upvar #0 xs ys; for {set i 0} {$i<5} {incr i} {lappend ys $i}; list $xs $ys",
      budget=100000,
    ),
    "{0 1 2 3 4} {0 1 2 3 4}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache cache-list-alias-unset" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set xs {}; upvar #0 xs ys; foreach i {1 2} {lappend ys $i}; unset xs; lappend ys 3; list $xs $ys",
      budget=100000,
    ),
    "3 3",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache cache-list-self" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set xs {a}; foreach i {1 2} {lappend xs $xs}; set xs",
      budget=100000,
    ),
    "a a {a a}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache cache-list-to-dict" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x {}; foreach item {a 1 b 2} {lappend x $item}; dict incr x a; list $x [dict get $x b]",
      budget=100000,
    ),
    "{a 2 b 2} 2",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache cache-dict-to-list" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "dict set x a 1; foreach item {b 2} {lappend x $item}; set x",
      budget=100000,
    ),
    "a 1 b 2",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache cache-list-set-invalidate" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x {}; foreach i {1 2} {lappend x $i}; set x {new}; foreach i {3 4} {lappend x $i}; set x",
      budget=100000,
    ),
    "new 3 4",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache cache-dict-copy" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set d {}; foreach i {a b c} {dict set d $i $i}; set copy $d; dict set d a changed; list $copy $d",
      budget=100000,
    ),
    "{a a b b c c} {a changed b b c c}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache cache-dict-alias" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set d {}; upvar #0 d e; foreach i {a b c} {dict set e $i $i}; list $d $e",
      budget=100000,
    ),
    "{a a b b c c} {a a b b c c}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache cache-dict-replace" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set d {}; foreach i {a b c} {dict set d $i $i}; set d {x 2}; dict incr d x; set d",
      budget=100000,
    ),
    "x 3",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache cache-dict-self" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set d {}; dict set d x 1; foreach i {y z} {dict set d $i $d}; set d",
      budget=100000,
    ),
    "x 1 y {x 1} z {x 1 y {x 1}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache cache-dict-nested-fallback" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(
        t.eval(
          "set d {}; foreach i {a b c} {dict set d $i 1}; dict set d a x 2; dict set d b 3; set d",
          budget=100000,
        ),
      )
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl cache cache-dict-with-cache" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set d {}; foreach i {a b c} {dict set d $i 1}; dict with d {incr a; unset b}; dict incr d c; set d",
      budget=100000,
    ),
    "a 2 c 2",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache cache-dict-update-error" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set d {}; foreach i {a b c} {dict set d $i 1}; catch {dict update d a x {incr x; error bad}}; dict set d z 3; set d",
      budget=100000,
    ),
    "a 2 b 1 c 1 z 3",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache cache-array-list" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "array set a {}; foreach i {1 2 3} {lappend a(x) $i}; set a(x)",
      budget=100000,
    ),
    "1 2 3",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache cache-array-dict" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "array set a {}; foreach i {a b c} {dict set a(x) $i 1}; dict incr a(x) a; set a(x)",
      budget=100000,
    ),
    "a 2 b 1 c 1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache cache-list-array-collision" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(
        t.eval("foreach i {1 2} {lappend x $i}; array set x {}", budget=100000),
      )
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl cache cache-dict-array-collision" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(
        t.eval("foreach i {a b} {dict set x $i 1}; set x(0) 4", budget=100000),
      )
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl cache cache-loop-if-result" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set xs {}; foreach x {0 1 2} {if {$x>0} {lappend xs $x}}; set xs",
      budget=100000,
    ),
    "1 2",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache cache-lmap-result" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("set xs {}; lmap x {1 2 3} {lappend xs $x}", budget=100000),
    "1 {1 2} {1 2 3}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache cache-catch-result" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set xs {}; foreach x {1 2} {lappend xs $x}; list [catch {lappend xs 3} result] $result $xs",
      budget=100000,
    ),
    "0 {1 2 3} {1 2 3}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache cache-proc-result" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc p {} {set xs {}; foreach x {1 2} {lappend xs $x}; lappend xs 3}; p",
      budget=100000,
    ),
    "1 2 3",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache cache-empty-namespace" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(
        t.eval(
          "namespace eval n {variable x 3; namespace eval {} {namespace current}}",
          budget=100000,
        ),
      )
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl cache cache-dict-duplicates" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("set d {a 1 b 2 a 3}; dict append d a; set d", budget=100000),
    "a 3 b 2",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache cache-list-whitespace" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x { a   b }; foreach item {c d} {lappend x $item}; set x",
      budget=100000,
    ),
    "a b c d",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache cache-dict-zero-append" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("set d { a 1   b 2 }; dict append d a; set d", budget=100000),
    "a 1 b 2",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache cache-increment-prefix" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 010; for {set i 0} {$i<3} {incr i} {incr x}; set x",
      budget=100000,
    ),
    "11",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache cache-dynamic-script-eviction" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set out 0; for {set i 0} {$i<300} {incr i} {eval [list set x $i]; incr out}; list $x $out",
      budget=100000,
    ),
    "299 300",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache cache-empty-tail-comments" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set code \"set x 3; # tail\\n\"; list [eval $code] [eval $code]",
      budget=100000,
    ),
    "3 3",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--999999999-+--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-999999999 + -3}", budget=100000), "-1000000002")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--999999999----3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-999999999 - -3}", budget=100000), "-999999996")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--999999999-*--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-999999999 * -3}", budget=100000), "2999999997")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--999999999-/--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-999999999 / -3}", budget=100000), "333333333")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--999999999-%--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-999999999 % -3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--999999999-&--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-999999999 & -3}", budget=100000), "-999999999")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--999999999-|--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-999999999 | -3}", budget=100000), "-3")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--999999999-^--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-999999999 ^ -3}", budget=100000), "999999996")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--999999999-==--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-999999999 == -3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--999999999-<--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-999999999 < -3}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--999999999-**--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-999999999 ** -3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--999999999-+-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-999999999 + 0}", budget=100000), "-999999999")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--999999999---0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-999999999 - 0}", budget=100000), "-999999999")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--999999999-*-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-999999999 * 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--999999999-/-0" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {-999999999 / 0}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl cache small--999999999-%-0" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {-999999999 % 0}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl cache small--999999999-&-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-999999999 & 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--999999999-|-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-999999999 | 0}", budget=100000), "-999999999")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--999999999-^-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-999999999 ^ 0}", budget=100000), "-999999999")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--999999999-==-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-999999999 == 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--999999999-<-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-999999999 < 0}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--999999999-**-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-999999999 ** 0}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--999999999-+-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-999999999 + 3}", budget=100000), "-999999996")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--999999999---3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-999999999 - 3}", budget=100000), "-1000000002")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--999999999-*-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-999999999 * 3}", budget=100000), "-2999999997")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--999999999-/-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-999999999 / 3}", budget=100000), "-333333333")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--999999999-%-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-999999999 % 3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--999999999-&-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-999999999 & 3}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--999999999-|-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-999999999 | 3}", budget=100000), "-999999997")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--999999999-^-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-999999999 ^ 3}", budget=100000), "-999999998")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--999999999-==-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-999999999 == 3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--999999999-<-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-999999999 < 3}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--999999999-**-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {-999999999 ** 3}", budget=100000),
    "-999999997000000002999999999",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--999999999-+-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-999999999 + 999999999}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--999999999---999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {-999999999 - 999999999}", budget=100000),
    "-1999999998",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--999999999-*-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {-999999999 * 999999999}", budget=100000),
    "-999999998000000001",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--999999999-/-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-999999999 / 999999999}", budget=100000), "-1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--999999999-%-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-999999999 % 999999999}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--999999999-&-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-999999999 & 999999999}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--999999999-|-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-999999999 | 999999999}", budget=100000), "-1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--999999999-^-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-999999999 ^ 999999999}", budget=100000), "-2")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--999999999-==-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-999999999 == 999999999}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--999999999-<-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-999999999 < 999999999}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999999-+--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999999 + -3}", budget=100000), "999999996")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999999----3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999999 - -3}", budget=100000), "1000000002")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999999-*--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999999 * -3}", budget=100000), "-2999999997")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999999-/--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999999 / -3}", budget=100000), "-333333333")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999999-%--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999999 % -3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999999-&--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999999 & -3}", budget=100000), "999999997")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999999-|--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999999 | -3}", budget=100000), "-1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999999-^--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999999 ^ -3}", budget=100000), "-999999998")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999999-==--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999999 == -3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999999-<--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999999 < -3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999999-**--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999999 ** -3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999999-+-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999999 + 0}", budget=100000), "999999999")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999999---0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999999 - 0}", budget=100000), "999999999")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999999-*-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999999 * 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999999-/-0" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {999999999 / 0}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl cache small-999999999-%-0" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {999999999 % 0}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl cache small-999999999-&-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999999 & 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999999-|-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999999 | 0}", budget=100000), "999999999")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999999-^-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999999 ^ 0}", budget=100000), "999999999")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999999-==-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999999 == 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999999-<-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999999 < 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999999-**-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999999 ** 0}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999999-+-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999999 + 3}", budget=100000), "1000000002")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999999---3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999999 - 3}", budget=100000), "999999996")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999999-*-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999999 * 3}", budget=100000), "2999999997")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999999-/-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999999 / 3}", budget=100000), "333333333")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999999-%-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999999 % 3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999999-&-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999999 & 3}", budget=100000), "3")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999999-|-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999999 | 3}", budget=100000), "999999999")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999999-^-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999999 ^ 3}", budget=100000), "999999996")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999999-==-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999999 == 3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999999-<-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999999 < 3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999999-**-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {999999999 ** 3}", budget=100000),
    "999999997000000002999999999",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999999-+-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999999 + 999999999}", budget=100000), "1999999998")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999999---999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999999 - 999999999}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999999-*-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {999999999 * 999999999}", budget=100000),
    "999999998000000001",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999999-/-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999999 / 999999999}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999999-%-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999999 % 999999999}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999999-&-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999999 & 999999999}", budget=100000), "999999999")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999999-|-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999999 | 999999999}", budget=100000), "999999999")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999999-^-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999999 ^ 999999999}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999999-==-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999999 == 999999999}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999999-<-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999999 < 999999999}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-1000000000-+--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1000000000 + -3}", budget=100000), "999999997")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-1000000000----3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1000000000 - -3}", budget=100000), "1000000003")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-1000000000-*--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1000000000 * -3}", budget=100000), "-3000000000")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-1000000000-/--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1000000000 / -3}", budget=100000), "-333333334")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-1000000000-%--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1000000000 % -3}", budget=100000), "-2")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-1000000000-&--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1000000000 & -3}", budget=100000), "1000000000")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-1000000000-|--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1000000000 | -3}", budget=100000), "-3")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-1000000000-^--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1000000000 ^ -3}", budget=100000), "-1000000003")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-1000000000-==--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1000000000 == -3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-1000000000-<--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1000000000 < -3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-1000000000-**--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1000000000 ** -3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-1000000000-+-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1000000000 + 0}", budget=100000), "1000000000")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-1000000000---0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1000000000 - 0}", budget=100000), "1000000000")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-1000000000-*-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1000000000 * 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-1000000000-/-0" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {1000000000 / 0}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl cache small-1000000000-%-0" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {1000000000 % 0}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl cache small-1000000000-&-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1000000000 & 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-1000000000-|-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1000000000 | 0}", budget=100000), "1000000000")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-1000000000-^-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1000000000 ^ 0}", budget=100000), "1000000000")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-1000000000-==-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1000000000 == 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-1000000000-<-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1000000000 < 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-1000000000-**-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1000000000 ** 0}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-1000000000-+-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1000000000 + 3}", budget=100000), "1000000003")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-1000000000---3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1000000000 - 3}", budget=100000), "999999997")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-1000000000-*-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1000000000 * 3}", budget=100000), "3000000000")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-1000000000-/-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1000000000 / 3}", budget=100000), "333333333")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-1000000000-%-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1000000000 % 3}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-1000000000-&-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1000000000 & 3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-1000000000-|-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1000000000 | 3}", budget=100000), "1000000003")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-1000000000-^-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1000000000 ^ 3}", budget=100000), "1000000003")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-1000000000-==-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1000000000 == 3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-1000000000-<-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1000000000 < 3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-1000000000-**-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {1000000000 ** 3}", budget=100000),
    "1000000000000000000000000000",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-1000000000-+-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {1000000000 + 999999999}", budget=100000),
    "1999999999",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-1000000000---999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1000000000 - 999999999}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-1000000000-*-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {1000000000 * 999999999}", budget=100000),
    "999999999000000000",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-1000000000-/-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1000000000 / 999999999}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-1000000000-%-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1000000000 % 999999999}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-1000000000-&-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1000000000 & 999999999}", budget=100000), "999999488")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-1000000000-|-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {1000000000 | 999999999}", budget=100000),
    "1000000511",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-1000000000-^-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1000000000 ^ 999999999}", budget=100000), "1023")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-1000000000-==-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1000000000 == 999999999}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-1000000000-<-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1000000000 < 999999999}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--1000000000-+--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1000000000 + -3}", budget=100000), "-1000000003")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--1000000000----3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1000000000 - -3}", budget=100000), "-999999997")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--1000000000-*--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1000000000 * -3}", budget=100000), "3000000000")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--1000000000-/--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1000000000 / -3}", budget=100000), "333333333")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--1000000000-%--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1000000000 % -3}", budget=100000), "-1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--1000000000-&--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1000000000 & -3}", budget=100000), "-1000000000")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--1000000000-|--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1000000000 | -3}", budget=100000), "-3")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--1000000000-^--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1000000000 ^ -3}", budget=100000), "999999997")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--1000000000-==--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1000000000 == -3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--1000000000-<--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1000000000 < -3}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--1000000000-**--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1000000000 ** -3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--1000000000-+-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1000000000 + 0}", budget=100000), "-1000000000")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--1000000000---0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1000000000 - 0}", budget=100000), "-1000000000")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--1000000000-*-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1000000000 * 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--1000000000-/-0" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {-1000000000 / 0}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl cache small--1000000000-%-0" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {-1000000000 % 0}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl cache small--1000000000-&-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1000000000 & 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--1000000000-|-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1000000000 | 0}", budget=100000), "-1000000000")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--1000000000-^-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1000000000 ^ 0}", budget=100000), "-1000000000")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--1000000000-==-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1000000000 == 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--1000000000-<-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1000000000 < 0}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--1000000000-**-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1000000000 ** 0}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--1000000000-+-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1000000000 + 3}", budget=100000), "-999999997")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--1000000000---3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1000000000 - 3}", budget=100000), "-1000000003")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--1000000000-*-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1000000000 * 3}", budget=100000), "-3000000000")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--1000000000-/-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1000000000 / 3}", budget=100000), "-333333334")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--1000000000-%-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1000000000 % 3}", budget=100000), "2")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--1000000000-&-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1000000000 & 3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--1000000000-|-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1000000000 | 3}", budget=100000), "-999999997")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--1000000000-^-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1000000000 ^ 3}", budget=100000), "-999999997")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--1000000000-==-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1000000000 == 3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--1000000000-<-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1000000000 < 3}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--1000000000-**-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {-1000000000 ** 3}", budget=100000),
    "-1000000000000000000000000000",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--1000000000-+-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1000000000 + 999999999}", budget=100000), "-1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--1000000000---999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {-1000000000 - 999999999}", budget=100000),
    "-1999999999",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--1000000000-*-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {-1000000000 * 999999999}", budget=100000),
    "-999999999000000000",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--1000000000-/-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1000000000 / 999999999}", budget=100000), "-2")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--1000000000-%-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {-1000000000 % 999999999}", budget=100000),
    "999999998",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--1000000000-&-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1000000000 & 999999999}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--1000000000-|-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1000000000 | 999999999}", budget=100000), "-1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--1000000000-^-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1000000000 ^ 999999999}", budget=100000), "-1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--1000000000-==-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1000000000 == 999999999}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--1000000000-<-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1000000000 < 999999999}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-2147483647-+--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 + -3}", budget=100000), "2147483644")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-2147483647----3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 - -3}", budget=100000), "2147483650")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-2147483647-*--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 * -3}", budget=100000), "-6442450941")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-2147483647-/--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 / -3}", budget=100000), "-715827883")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-2147483647-%--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 % -3}", budget=100000), "-2")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-2147483647-&--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 & -3}", budget=100000), "2147483645")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-2147483647-|--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 | -3}", budget=100000), "-1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-2147483647-^--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 ^ -3}", budget=100000), "-2147483646")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-2147483647-==--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 == -3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-2147483647-<--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 < -3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-2147483647-**--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 ** -3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-2147483647-+-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 + 0}", budget=100000), "2147483647")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-2147483647---0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 - 0}", budget=100000), "2147483647")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-2147483647-*-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 * 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-2147483647-/-0" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {2147483647 / 0}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl cache small-2147483647-%-0" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {2147483647 % 0}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl cache small-2147483647-&-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 & 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-2147483647-|-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 | 0}", budget=100000), "2147483647")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-2147483647-^-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 ^ 0}", budget=100000), "2147483647")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-2147483647-==-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 == 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-2147483647-<-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 < 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-2147483647-**-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 ** 0}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-2147483647-+-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 + 3}", budget=100000), "2147483650")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-2147483647---3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 - 3}", budget=100000), "2147483644")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-2147483647-*-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 * 3}", budget=100000), "6442450941")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-2147483647-/-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 / 3}", budget=100000), "715827882")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-2147483647-%-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 % 3}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-2147483647-&-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 & 3}", budget=100000), "3")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-2147483647-|-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 | 3}", budget=100000), "2147483647")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-2147483647-^-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 ^ 3}", budget=100000), "2147483644")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-2147483647-==-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 == 3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-2147483647-<-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 < 3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-2147483647-**-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {2147483647 ** 3}", budget=100000),
    "9903520300447984150353281023",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-2147483647-+-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {2147483647 + 999999999}", budget=100000),
    "3147483646",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-2147483647---999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {2147483647 - 999999999}", budget=100000),
    "1147483648",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-2147483647-*-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {2147483647 * 999999999}", budget=100000),
    "2147483644852516353",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-2147483647-/-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 / 999999999}", budget=100000), "2")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-2147483647-%-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 % 999999999}", budget=100000), "147483649")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-2147483647-&-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 & 999999999}", budget=100000), "999999999")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-2147483647-|-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {2147483647 | 999999999}", budget=100000),
    "2147483647",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-2147483647-^-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {2147483647 ^ 999999999}", budget=100000),
    "1147483648",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-2147483647-==-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 == 999999999}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-2147483647-<-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 < 999999999}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--2147483648-+--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-2147483648 + -3}", budget=100000), "-2147483651")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--2147483648----3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-2147483648 - -3}", budget=100000), "-2147483645")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--2147483648-*--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-2147483648 * -3}", budget=100000), "6442450944")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--2147483648-/--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-2147483648 / -3}", budget=100000), "715827882")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--2147483648-%--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-2147483648 % -3}", budget=100000), "-2")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--2147483648-&--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-2147483648 & -3}", budget=100000), "-2147483648")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--2147483648-|--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-2147483648 | -3}", budget=100000), "-3")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--2147483648-^--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-2147483648 ^ -3}", budget=100000), "2147483645")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--2147483648-==--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-2147483648 == -3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--2147483648-<--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-2147483648 < -3}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--2147483648-**--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-2147483648 ** -3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--2147483648-+-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-2147483648 + 0}", budget=100000), "-2147483648")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--2147483648---0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-2147483648 - 0}", budget=100000), "-2147483648")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--2147483648-*-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-2147483648 * 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--2147483648-/-0" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {-2147483648 / 0}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl cache small--2147483648-%-0" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {-2147483648 % 0}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl cache small--2147483648-&-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-2147483648 & 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--2147483648-|-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-2147483648 | 0}", budget=100000), "-2147483648")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--2147483648-^-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-2147483648 ^ 0}", budget=100000), "-2147483648")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--2147483648-==-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-2147483648 == 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--2147483648-<-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-2147483648 < 0}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--2147483648-**-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-2147483648 ** 0}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--2147483648-+-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-2147483648 + 3}", budget=100000), "-2147483645")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--2147483648---3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-2147483648 - 3}", budget=100000), "-2147483651")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--2147483648-*-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-2147483648 * 3}", budget=100000), "-6442450944")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--2147483648-/-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-2147483648 / 3}", budget=100000), "-715827883")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--2147483648-%-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-2147483648 % 3}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--2147483648-&-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-2147483648 & 3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--2147483648-|-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-2147483648 | 3}", budget=100000), "-2147483645")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--2147483648-^-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-2147483648 ^ 3}", budget=100000), "-2147483645")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--2147483648-==-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-2147483648 == 3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--2147483648-<-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-2147483648 < 3}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--2147483648-**-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {-2147483648 ** 3}", budget=100000),
    "-9903520314283042199192993792",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--2147483648-+-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {-2147483648 + 999999999}", budget=100000),
    "-1147483649",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--2147483648---999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {-2147483648 - 999999999}", budget=100000),
    "-3147483647",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--2147483648-*-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {-2147483648 * 999999999}", budget=100000),
    "-2147483645852516352",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--2147483648-/-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-2147483648 / 999999999}", budget=100000), "-3")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--2147483648-%-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {-2147483648 % 999999999}", budget=100000),
    "852516349",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--2147483648-&-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-2147483648 & 999999999}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--2147483648-|-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {-2147483648 | 999999999}", budget=100000),
    "-1147483649",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--2147483648-^-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {-2147483648 ^ 999999999}", budget=100000),
    "-1147483649",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--2147483648-==-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-2147483648 == 999999999}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small--2147483648-<-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-2147483648 < 999999999}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999998-+--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999998 + -3}", budget=100000), "999999995")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999998----3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999998 - -3}", budget=100000), "1000000001")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999998-*--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999998 * -3}", budget=100000), "-2999999994")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999998-/--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999998 / -3}", budget=100000), "-333333333")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999998-%--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999998 % -3}", budget=100000), "-1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999998-&--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999998 & -3}", budget=100000), "999999996")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999998-|--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999998 | -3}", budget=100000), "-1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999998-^--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999998 ^ -3}", budget=100000), "-999999997")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999998-==--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999998 == -3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999998-<--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999998 < -3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999998-**--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999998 ** -3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999998-+-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999998 + 0}", budget=100000), "999999998")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999998---0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999998 - 0}", budget=100000), "999999998")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999998-*-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999998 * 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999998-/-0" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {999999998 / 0}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl cache small-999999998-%-0" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {999999998 % 0}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl cache small-999999998-&-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999998 & 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999998-|-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999998 | 0}", budget=100000), "999999998")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999998-^-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999998 ^ 0}", budget=100000), "999999998")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999998-==-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999998 == 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999998-<-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999998 < 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999998-**-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999998 ** 0}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999998-+-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999998 + 3}", budget=100000), "1000000001")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999998---3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999998 - 3}", budget=100000), "999999995")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999998-*-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999998 * 3}", budget=100000), "2999999994")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999998-/-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999998 / 3}", budget=100000), "333333332")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999998-%-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999998 % 3}", budget=100000), "2")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999998-&-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999998 & 3}", budget=100000), "2")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999998-|-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999998 | 3}", budget=100000), "999999999")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999998-^-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999998 ^ 3}", budget=100000), "999999997")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999998-==-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999998 == 3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999998-<-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999998 < 3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999998-**-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {999999998 ** 3}", budget=100000),
    "999999994000000011999999992",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999998-+-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999998 + 999999999}", budget=100000), "1999999997")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999998---999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999998 - 999999999}", budget=100000), "-1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999998-*-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {999999998 * 999999999}", budget=100000),
    "999999997000000002",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999998-/-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999998 / 999999999}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999998-%-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999998 % 999999999}", budget=100000), "999999998")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999998-&-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999998 & 999999999}", budget=100000), "999999998")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999998-|-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999998 | 999999999}", budget=100000), "999999999")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999998-^-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999998 ^ 999999999}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999998-==-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999998 == 999999999}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl cache small-999999998-<-999999999" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {999999998 < 999999999}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}
