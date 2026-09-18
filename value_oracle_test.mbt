// Original programs, expected results evaluated by Tcl 8.6.15. Do not hand-edit.

///|
test "Tcl value transport-direct-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x $v;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-quoted-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x \"$v\";list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-empty-prefix-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set e {};set x \"$e$v\";list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-empty-suffix-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set e {};set x \"$v$e\";list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-format-s-4" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [format %s $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-append-empty-5" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x $v;append x {};list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-append-no-args-6" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x $v;append x;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-string-cat-7" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [string cat $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-string-range-8" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [string range $v 0 end];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.844674407370955e+19 1.844674407370955e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-string-trim-9" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [string trim $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-subst-10" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [subst {$v}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-list-11" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [lindex [list $v] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-join-12" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [join [list $v] {}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-concat-list-13" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [lindex [concat [list $v] [list a]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-concat-text-14" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [lindex [concat [list $v] a] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-concat-one-15" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [lindex [concat [list $v]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lrange-16" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [lindex [lrange [list $v a] 0 0] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lreverse-17" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [lindex [lreverse [list a $v]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lrepeat-18" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [lindex [lrepeat 3 $v] 2];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lappend-19" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;lappend a $v;set x [lindex $a 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lset-20" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a [list 0];lset a 0 $v;set x [lindex $a 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-linsert-21" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [lindex [linsert {} 0 $v] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lreplace-22" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [lindex [lreplace {a} 0 0 $v] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lsearch-23" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [lsearch -inline -glob [list 0 $v] *e*];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lsort-24" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [lindex [lsort -real [list $v $v]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lsort-command-25" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;proc cmp {a b} {expr {$a>$b ? 1 : $a<$b ? -1 : 0}};set x [lindex [lsort -command cmp [list $v $v]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-eval-list-26" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [eval [list set z $v]];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-eval-concat-27" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [eval [list set] [list z $v]];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-if-28" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [if 1 {set v}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-expand-29" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [set {*}[list z $v]];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-expr-30" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [expr {$v}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-expr-plus-31" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [expr {$v+0.0}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-expr-conditional-32" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [expr {1 ? $v : 0}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-expr-min-33" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [expr {min($v,$v)}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-proc-34" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;proc f x {return $x};set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-proc-fallthrough-35" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;proc f x {set x};set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-proc-default-36" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;proc f [list [list p $v]] {return $p};set x [f];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-proc-default-info-37" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;proc f [list [list p $v]] {};info default f p x;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-proc-args-38" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;proc f args {lindex $args 1};set x [f 0 $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-upvar-39" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;proc f {} {upvar 1 v a;return $a};set x [f];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-global-40" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;proc f {} {global v;set v};set x [f];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-uplevel-41" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;proc f {} {uplevel 1 {set v}};set x [f];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-uplevel-list-42" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;proc f a {uplevel 1 [list set z $a]};set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-namespace-43" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;namespace eval n {};set x [namespace eval n [list set z $v]];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-namespace-inscope-44" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;namespace eval n {};set x [namespace inscope n [list set z] $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-namespace-variable-45" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;namespace eval n [list variable z $v];set x $n::z;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-rename-46" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;rename set store;store x [store v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-import-47" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;namespace eval n {proc f x {return $x};namespace export f};namespace import n::f;set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-ensemble-48" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;namespace eval n {proc f x {return $x};namespace ensemble create -map {get f}};set x [n get $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-unknown-49" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;proc unknown {name args} {lindex $args 0};set x [missing $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-catch-ok-50" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;catch {set v} x;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-catch-return-51" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;catch {return $v} x;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-catch-error-52" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;catch {error $v} x;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-catch-throw-53" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;catch {throw CODE $v} x;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-return-level-54" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;proc f a {return -level 0 $a};set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-return-options-55" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;proc f a {return -options {-code 0 -level 1} $a};set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-try-56" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [try {set v} finally {set done 1}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-try-handler-57" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [try {error $v} on error {r o} {set r}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-try-return-58" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;proc f a {try {return $a} finally {set b 1}};set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-foreach-59" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;foreach x [list $v] {};list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lmap-60" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [lindex [lmap p [list $v] {set p}] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-array-element-61" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a(k) $v;set x $a(k);list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-array-set-62" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;array set a [list k $v];set x $a(k);list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-array-get-63" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a(k) $v;set x [lindex [array get a] 1];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-get-64" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [dict get [dict create k $v] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-key-65" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [lindex [dict keys [dict create $v a]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-value-66" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [lindex [dict values [dict create k $v]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-set-67" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;dict set d k $v;set x [dict get $d k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-nested-68" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;dict set d a b $v;set x [dict get $d a b];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-lappend-69" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;dict lappend d k $v;set x [lindex [dict get $d k] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-append-empty-70" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;dict set d k $v;dict append d k {};set x [dict get $d k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-merge-71" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [dict get [dict merge [dict create k $v] {b 0}] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-replace-72" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [dict get [dict replace {} k $v] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-remove-73" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [dict get [dict remove [dict create a 0 k $v] a] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-for-74" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;dict for {k x} [dict create k $v] {};list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-map-75" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [dict get [dict map {k p} [dict create k $v] {set p}] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-filter-76" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [dict get [dict filter [dict create k $v] key k] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-filter-script-77" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [dict get [dict filter [dict create k $v] script {k p} {expr 1}] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-update-78" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;dict set d k $v;dict update d k x {};list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-with-79" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;dict set d x $v;dict with d {};list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-same-text-80" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set copy $v;set text [format %s $v];set x $copy;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-copy-list-81" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a [list $v];set b $a;lset b 0 0;set x [lindex $a 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-copy-list-append-82" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;lappend a $v;set b $a;lappend b 0;set x [lindex $a 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-copy-nested-83" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a [list [list $v]];set b $a;lset b 0 0 0;set x [lindex $a 0 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-copy-dict-84" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;dict set a k $v;set b $a;dict set b k 0;set x [dict get $a k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-copy-dict-nested-85" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;dict set a k l $v;set b $a;dict set b k l 0;set x [dict get $a k l];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-list-string-length-86" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a [list $v];string length $a;set x [lindex $a 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-list-append-empty-87" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a [list $v];append a {};set x [lindex $a 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-numeric-list-conversion-88" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set copy $v;llength $v;set x $copy;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.844674407370955e+19 1.844674407370955e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-nested-expr-89" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [expr {($v*1.0)+0.0}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-math-proc-90" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;namespace eval ::tcl::mathfunc {};proc ::tcl::mathfunc::identity x {return $x};set x [expr {identity($v)}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-direct-91" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set x $v;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-quoted-92" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set x \"$v\";list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-empty-prefix-93" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set e {};set x \"$e$v\";list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-empty-suffix-94" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set e {};set x \"$v$e\";list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-format-s-95" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set x [format %s $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-append-empty-96" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set x $v;append x {};list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-append-no-args-97" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set x $v;append x;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-string-cat-98" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set x [string cat $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-string-range-99" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set x [string range $v 0 end];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-string-trim-100" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set x [string trim $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-subst-101" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set x [subst {$v}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-list-102" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set x [lindex [list $v] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-join-103" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set x [join [list $v] {}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-concat-list-104" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set x [lindex [concat [list $v] [list a]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-concat-text-105" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set x [lindex [concat [list $v] a] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-concat-one-106" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set x [lindex [concat [list $v]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lrange-107" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set x [lindex [lrange [list $v a] 0 0] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lreverse-108" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set x [lindex [lreverse [list a $v]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lrepeat-109" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set x [lindex [lrepeat 3 $v] 2];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lappend-110" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;lappend a $v;set x [lindex $a 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lset-111" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set a [list 0];lset a 0 $v;set x [lindex $a 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-linsert-112" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set x [lindex [linsert {} 0 $v] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lreplace-113" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set x [lindex [lreplace {a} 0 0 $v] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lsearch-114" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set x [lsearch -inline -glob [list 0 $v] *e*];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lsort-115" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set x [lindex [lsort -real [list $v $v]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lsort-command-116" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;proc cmp {a b} {expr {$a>$b ? 1 : $a<$b ? -1 : 0}};set x [lindex [lsort -command cmp [list $v $v]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-eval-list-117" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set x [eval [list set z $v]];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-eval-concat-118" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set x [eval [list set] [list z $v]];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-if-119" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set x [if 1 {set v}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-expand-120" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set x [set {*}[list z $v]];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-expr-121" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set x [expr {$v}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-expr-plus-122" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set x [expr {$v+0.0}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-expr-conditional-123" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set x [expr {1 ? $v : 0}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-expr-min-124" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set x [expr {min($v,$v)}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-proc-125" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;proc f x {return $x};set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-proc-fallthrough-126" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;proc f x {set x};set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-proc-default-127" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;proc f [list [list p $v]] {return $p};set x [f];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-proc-default-info-128" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;proc f [list [list p $v]] {};info default f p x;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-proc-args-129" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;proc f args {lindex $args 1};set x [f 0 $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-upvar-130" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;proc f {} {upvar 1 v a;return $a};set x [f];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-global-131" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;proc f {} {global v;set v};set x [f];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-uplevel-132" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;proc f {} {uplevel 1 {set v}};set x [f];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-uplevel-list-133" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;proc f a {uplevel 1 [list set z $a]};set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-namespace-134" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;namespace eval n {};set x [namespace eval n [list set z $v]];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-namespace-inscope-135" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;namespace eval n {};set x [namespace inscope n [list set z] $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-namespace-variable-136" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;namespace eval n [list variable z $v];set x $n::z;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-rename-137" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;rename set store;store x [store v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-import-138" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;namespace eval n {proc f x {return $x};namespace export f};namespace import n::f;set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-ensemble-139" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;namespace eval n {proc f x {return $x};namespace ensemble create -map {get f}};set x [n get $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-unknown-140" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;proc unknown {name args} {lindex $args 0};set x [missing $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-catch-ok-141" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;catch {set v} x;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-catch-return-142" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;catch {return $v} x;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-catch-error-143" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;catch {error $v} x;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-catch-throw-144" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;catch {throw CODE $v} x;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-return-level-145" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;proc f a {return -level 0 $a};set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-return-options-146" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;proc f a {return -options {-code 0 -level 1} $a};set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-try-147" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set x [try {set v} finally {set done 1}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-try-handler-148" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set x [try {error $v} on error {r o} {set r}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-try-return-149" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;proc f a {try {return $a} finally {set b 1}};set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-foreach-150" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;foreach x [list $v] {};list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lmap-151" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set x [lindex [lmap p [list $v] {set p}] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-array-element-152" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set a(k) $v;set x $a(k);list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-array-set-153" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;array set a [list k $v];set x $a(k);list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-array-get-154" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set a(k) $v;set x [lindex [array get a] 1];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-get-155" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set x [dict get [dict create k $v] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-key-156" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set x [lindex [dict keys [dict create $v a]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-value-157" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set x [lindex [dict values [dict create k $v]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-set-158" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;dict set d k $v;set x [dict get $d k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-nested-159" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;dict set d a b $v;set x [dict get $d a b];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-lappend-160" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;dict lappend d k $v;set x [lindex [dict get $d k] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-append-empty-161" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;dict set d k $v;dict append d k {};set x [dict get $d k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-merge-162" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set x [dict get [dict merge [dict create k $v] {b 0}] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-replace-163" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set x [dict get [dict replace {} k $v] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-remove-164" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set x [dict get [dict remove [dict create a 0 k $v] a] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-for-165" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;dict for {k x} [dict create k $v] {};list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-map-166" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set x [dict get [dict map {k p} [dict create k $v] {set p}] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-filter-167" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set x [dict get [dict filter [dict create k $v] key k] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-filter-script-168" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set x [dict get [dict filter [dict create k $v] script {k p} {expr 1}] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-update-169" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;dict set d k $v;dict update d k x {};list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-with-170" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;dict set d x $v;dict with d {};list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-same-text-171" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set copy $v;set text [format %s $v];set x $copy;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-copy-list-172" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set a [list $v];set b $a;lset b 0 0;set x [lindex $a 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-copy-list-append-173" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;lappend a $v;set b $a;lappend b 0;set x [lindex $a 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-copy-nested-174" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set a [list [list $v]];set b $a;lset b 0 0 0;set x [lindex $a 0 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-copy-dict-175" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;dict set a k $v;set b $a;dict set b k 0;set x [dict get $a k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-copy-dict-nested-176" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;dict set a k l $v;set b $a;dict set b k l 0;set x [dict get $a k l];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-list-string-length-177" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set a [list $v];string length $a;set x [lindex $a 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-list-append-empty-178" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set a [list $v];append a {};set x [lindex $a 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-numeric-list-conversion-179" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set copy $v;llength $v;set x $copy;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-nested-expr-180" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;set x [expr {($v*1.0)+0.0}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-math-proc-181" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.671406556917033e+24 %f v;namespace eval ::tcl::mathfunc {};proc ::tcl::mathfunc::identity x {return $x};set x [expr {identity($v)}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "9.6714065569170334e+24 9.671406556917033e+24 9.6714065569170334e+24",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-direct-182" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set x $v;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-quoted-183" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set x \"$v\";list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-empty-prefix-184" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set e {};set x \"$e$v\";list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390618e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-empty-suffix-185" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set e {};set x \"$v$e\";list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-format-s-186" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set x [format %s $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390618e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-append-empty-187" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set x $v;append x {};list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-append-no-args-188" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set x $v;append x;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-string-cat-189" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set x [string cat $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-string-range-190" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set x [string range $v 0 end];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390618e-08 5.960464477539062e-8 5.9604644775390618e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-string-trim-191" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set x [string trim $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390618e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-subst-192" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set x [subst {$v}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390618e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-list-193" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set x [lindex [list $v] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-join-194" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set x [join [list $v] {}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390618e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-concat-list-195" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set x [lindex [concat [list $v] [list a]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-concat-text-196" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set x [lindex [concat [list $v] a] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390618e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-concat-one-197" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set x [lindex [concat [list $v]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lrange-198" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set x [lindex [lrange [list $v a] 0 0] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lreverse-199" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set x [lindex [lreverse [list a $v]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lrepeat-200" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set x [lindex [lrepeat 3 $v] 2];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lappend-201" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;lappend a $v;set x [lindex $a 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lset-202" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set a [list 0];lset a 0 $v;set x [lindex $a 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-linsert-203" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set x [lindex [linsert {} 0 $v] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lreplace-204" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set x [lindex [lreplace {a} 0 0 $v] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lsearch-205" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set x [lsearch -inline -glob [list 0 $v] *e*];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lsort-206" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set x [lindex [lsort -real [list $v $v]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lsort-command-207" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;proc cmp {a b} {expr {$a>$b ? 1 : $a<$b ? -1 : 0}};set x [lindex [lsort -command cmp [list $v $v]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-eval-list-208" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set x [eval [list set z $v]];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-eval-concat-209" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set x [eval [list set] [list z $v]];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-if-210" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set x [if 1 {set v}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-expand-211" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set x [set {*}[list z $v]];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-expr-212" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set x [expr {$v}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-expr-plus-213" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set x [expr {$v+0.0}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-expr-conditional-214" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set x [expr {1 ? $v : 0}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-expr-min-215" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set x [expr {min($v,$v)}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-proc-216" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;proc f x {return $x};set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-proc-fallthrough-217" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;proc f x {set x};set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-proc-default-218" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;proc f [list [list p $v]] {return $p};set x [f];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-proc-default-info-219" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;proc f [list [list p $v]] {};info default f p x;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-proc-args-220" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;proc f args {lindex $args 1};set x [f 0 $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-upvar-221" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;proc f {} {upvar 1 v a;return $a};set x [f];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-global-222" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;proc f {} {global v;set v};set x [f];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-uplevel-223" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;proc f {} {uplevel 1 {set v}};set x [f];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-uplevel-list-224" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;proc f a {uplevel 1 [list set z $a]};set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-namespace-225" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;namespace eval n {};set x [namespace eval n [list set z $v]];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-namespace-inscope-226" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;namespace eval n {};set x [namespace inscope n [list set z] $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-namespace-variable-227" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;namespace eval n [list variable z $v];set x $n::z;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-rename-228" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;rename set store;store x [store v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-import-229" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;namespace eval n {proc f x {return $x};namespace export f};namespace import n::f;set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-ensemble-230" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;namespace eval n {proc f x {return $x};namespace ensemble create -map {get f}};set x [n get $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-unknown-231" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;proc unknown {name args} {lindex $args 0};set x [missing $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-catch-ok-232" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;catch {set v} x;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-catch-return-233" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;catch {return $v} x;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-catch-error-234" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;catch {error $v} x;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-catch-throw-235" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;catch {throw CODE $v} x;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-return-level-236" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;proc f a {return -level 0 $a};set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-return-options-237" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;proc f a {return -options {-code 0 -level 1} $a};set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-try-238" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set x [try {set v} finally {set done 1}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-try-handler-239" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set x [try {error $v} on error {r o} {set r}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-try-return-240" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;proc f a {try {return $a} finally {set b 1}};set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-foreach-241" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;foreach x [list $v] {};list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lmap-242" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set x [lindex [lmap p [list $v] {set p}] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-array-element-243" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set a(k) $v;set x $a(k);list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-array-set-244" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;array set a [list k $v];set x $a(k);list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-array-get-245" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set a(k) $v;set x [lindex [array get a] 1];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-get-246" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set x [dict get [dict create k $v] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-key-247" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set x [lindex [dict keys [dict create $v a]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-value-248" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set x [lindex [dict values [dict create k $v]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-set-249" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;dict set d k $v;set x [dict get $d k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-nested-250" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;dict set d a b $v;set x [dict get $d a b];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-lappend-251" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;dict lappend d k $v;set x [lindex [dict get $d k] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-append-empty-252" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;dict set d k $v;dict append d k {};set x [dict get $d k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-merge-253" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set x [dict get [dict merge [dict create k $v] {b 0}] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-replace-254" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set x [dict get [dict replace {} k $v] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-remove-255" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set x [dict get [dict remove [dict create a 0 k $v] a] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-for-256" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;dict for {k x} [dict create k $v] {};list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-map-257" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set x [dict get [dict map {k p} [dict create k $v] {set p}] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-filter-258" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set x [dict get [dict filter [dict create k $v] key k] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-filter-script-259" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set x [dict get [dict filter [dict create k $v] script {k p} {expr 1}] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-update-260" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;dict set d k $v;dict update d k x {};list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-with-261" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;dict set d x $v;dict with d {};list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-same-text-262" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set copy $v;set text [format %s $v];set x $copy;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-copy-list-263" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set a [list $v];set b $a;lset b 0 0;set x [lindex $a 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-copy-list-append-264" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;lappend a $v;set b $a;lappend b 0;set x [lindex $a 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-copy-nested-265" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set a [list [list $v]];set b $a;lset b 0 0 0;set x [lindex $a 0 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-copy-dict-266" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;dict set a k $v;set b $a;dict set b k 0;set x [dict get $a k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-copy-dict-nested-267" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;dict set a k l $v;set b $a;dict set b k l 0;set x [dict get $a k l];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-list-string-length-268" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set a [list $v];string length $a;set x [lindex $a 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390618e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-list-append-empty-269" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set a [list $v];append a {};set x [lindex $a 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-numeric-list-conversion-270" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set copy $v;llength $v;set x $copy;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390618e-08 5.960464477539062e-8 5.9604644775390618e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-nested-expr-271" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;set x [expr {($v*1.0)+0.0}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-math-proc-272" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.960464477539063e-08 %f v;namespace eval ::tcl::mathfunc {};proc ::tcl::mathfunc::identity x {return $x};set x [expr {identity($v)}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "5.9604644775390625e-08 5.960464477539062e-8 5.9604644775390625e-08",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-direct-273" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set x $v;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-quoted-274" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set x \"$v\";list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-empty-prefix-275" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set e {};set x \"$e$v\";list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-empty-suffix-276" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set e {};set x \"$v$e\";list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-format-s-277" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set x [format %s $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-append-empty-278" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set x $v;append x {};list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-append-no-args-279" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set x $v;append x;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-string-cat-280" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set x [string cat $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-string-range-281" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set x [string range $v 0 end];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-string-trim-282" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set x [string trim $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-subst-283" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set x [subst {$v}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-list-284" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set x [lindex [list $v] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-join-285" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set x [join [list $v] {}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-concat-list-286" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set x [lindex [concat [list $v] [list a]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-concat-text-287" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set x [lindex [concat [list $v] a] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-concat-one-288" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set x [lindex [concat [list $v]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lrange-289" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set x [lindex [lrange [list $v a] 0 0] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lreverse-290" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set x [lindex [lreverse [list a $v]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lrepeat-291" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set x [lindex [lrepeat 3 $v] 2];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lappend-292" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;lappend a $v;set x [lindex $a 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lset-293" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set a [list 0];lset a 0 $v;set x [lindex $a 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-linsert-294" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set x [lindex [linsert {} 0 $v] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lreplace-295" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set x [lindex [lreplace {a} 0 0 $v] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lsearch-296" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set x [lsearch -inline -glob [list 0 $v] *e*];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lsort-297" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set x [lindex [lsort -real [list $v $v]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lsort-command-298" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;proc cmp {a b} {expr {$a>$b ? 1 : $a<$b ? -1 : 0}};set x [lindex [lsort -command cmp [list $v $v]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-eval-list-299" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set x [eval [list set z $v]];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-eval-concat-300" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set x [eval [list set] [list z $v]];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-if-301" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set x [if 1 {set v}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-expand-302" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set x [set {*}[list z $v]];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-expr-303" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set x [expr {$v}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-expr-plus-304" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set x [expr {$v+0.0}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-expr-conditional-305" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set x [expr {1 ? $v : 0}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-expr-min-306" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set x [expr {min($v,$v)}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-proc-307" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;proc f x {return $x};set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-proc-fallthrough-308" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;proc f x {set x};set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-proc-default-309" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;proc f [list [list p $v]] {return $p};set x [f];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-proc-default-info-310" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;proc f [list [list p $v]] {};info default f p x;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-proc-args-311" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;proc f args {lindex $args 1};set x [f 0 $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-upvar-312" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;proc f {} {upvar 1 v a;return $a};set x [f];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-global-313" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;proc f {} {global v;set v};set x [f];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-uplevel-314" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;proc f {} {uplevel 1 {set v}};set x [f];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-uplevel-list-315" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;proc f a {uplevel 1 [list set z $a]};set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-namespace-316" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;namespace eval n {};set x [namespace eval n [list set z $v]];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-namespace-inscope-317" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;namespace eval n {};set x [namespace inscope n [list set z] $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-namespace-variable-318" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;namespace eval n [list variable z $v];set x $n::z;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-rename-319" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;rename set store;store x [store v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-import-320" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;namespace eval n {proc f x {return $x};namespace export f};namespace import n::f;set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-ensemble-321" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;namespace eval n {proc f x {return $x};namespace ensemble create -map {get f}};set x [n get $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-unknown-322" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;proc unknown {name args} {lindex $args 0};set x [missing $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-catch-ok-323" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;catch {set v} x;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-catch-return-324" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;catch {return $v} x;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-catch-error-325" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;catch {error $v} x;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-catch-throw-326" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;catch {throw CODE $v} x;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-return-level-327" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;proc f a {return -level 0 $a};set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-return-options-328" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;proc f a {return -options {-code 0 -level 1} $a};set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-try-329" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set x [try {set v} finally {set done 1}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-try-handler-330" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set x [try {error $v} on error {r o} {set r}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-try-return-331" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;proc f a {try {return $a} finally {set b 1}};set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-foreach-332" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;foreach x [list $v] {};list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lmap-333" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set x [lindex [lmap p [list $v] {set p}] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-array-element-334" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set a(k) $v;set x $a(k);list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-array-set-335" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;array set a [list k $v];set x $a(k);list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-array-get-336" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set a(k) $v;set x [lindex [array get a] 1];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-get-337" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set x [dict get [dict create k $v] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-key-338" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set x [lindex [dict keys [dict create $v a]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-value-339" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set x [lindex [dict values [dict create k $v]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-set-340" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;dict set d k $v;set x [dict get $d k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-nested-341" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;dict set d a b $v;set x [dict get $d a b];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-lappend-342" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;dict lappend d k $v;set x [lindex [dict get $d k] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-append-empty-343" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;dict set d k $v;dict append d k {};set x [dict get $d k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-merge-344" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set x [dict get [dict merge [dict create k $v] {b 0}] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-replace-345" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set x [dict get [dict replace {} k $v] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-remove-346" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set x [dict get [dict remove [dict create a 0 k $v] a] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-for-347" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;dict for {k x} [dict create k $v] {};list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-map-348" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set x [dict get [dict map {k p} [dict create k $v] {set p}] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-filter-349" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set x [dict get [dict filter [dict create k $v] key k] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-filter-script-350" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set x [dict get [dict filter [dict create k $v] script {k p} {expr 1}] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-update-351" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;dict set d k $v;dict update d k x {};list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-with-352" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;dict set d x $v;dict with d {};list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-same-text-353" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set copy $v;set text [format %s $v];set x $copy;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-copy-list-354" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set a [list $v];set b $a;lset b 0 0;set x [lindex $a 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-copy-list-append-355" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;lappend a $v;set b $a;lappend b 0;set x [lindex $a 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-copy-nested-356" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set a [list [list $v]];set b $a;lset b 0 0 0;set x [lindex $a 0 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-copy-dict-357" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;dict set a k $v;set b $a;dict set b k 0;set x [dict get $a k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-copy-dict-nested-358" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;dict set a k l $v;set b $a;dict set b k l 0;set x [dict get $a k l];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-list-string-length-359" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set a [list $v];string length $a;set x [lindex $a 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-list-append-empty-360" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set a [list $v];append a {};set x [lindex $a 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-numeric-list-conversion-361" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set copy $v;llength $v;set x $copy;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-nested-expr-362" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;set x [expr {($v*1.0)+0.0}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-math-proc-363" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2676506002282294e+30 %f v;namespace eval ::tcl::mathfunc {};proc ::tcl::mathfunc::identity x {return $x};set x [expr {identity($v)}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.2676506002282294e+30 1.2676506002282294e+30 1.2676506002282294e+30",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-direct-364" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set x $v;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-quoted-365" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set x \"$v\";list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-empty-prefix-366" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set e {};set x \"$e$v\";list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.844674407370955e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-empty-suffix-367" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set e {};set x \"$v$e\";list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-format-s-368" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set x [format %s $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.844674407370955e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-append-empty-369" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set x $v;append x {};list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-append-no-args-370" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set x $v;append x;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-string-cat-371" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set x [string cat $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-string-range-372" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set x [string range $v 0 end];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.844674407370955e+19 -1.844674407370955e+19 -1.844674407370955e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-string-trim-373" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set x [string trim $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.844674407370955e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-subst-374" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set x [subst {$v}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.844674407370955e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-list-375" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set x [lindex [list $v] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-join-376" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set x [join [list $v] {}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.844674407370955e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-concat-list-377" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set x [lindex [concat [list $v] [list a]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-concat-text-378" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set x [lindex [concat [list $v] a] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.844674407370955e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-concat-one-379" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set x [lindex [concat [list $v]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lrange-380" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set x [lindex [lrange [list $v a] 0 0] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lreverse-381" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set x [lindex [lreverse [list a $v]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lrepeat-382" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set x [lindex [lrepeat 3 $v] 2];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lappend-383" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;lappend a $v;set x [lindex $a 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lset-384" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set a [list 0];lset a 0 $v;set x [lindex $a 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-linsert-385" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set x [lindex [linsert {} 0 $v] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lreplace-386" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set x [lindex [lreplace {a} 0 0 $v] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lsearch-387" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set x [lsearch -inline -glob [list 0 $v] *e*];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lsort-388" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set x [lindex [lsort -real [list $v $v]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lsort-command-389" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;proc cmp {a b} {expr {$a>$b ? 1 : $a<$b ? -1 : 0}};set x [lindex [lsort -command cmp [list $v $v]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-eval-list-390" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set x [eval [list set z $v]];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-eval-concat-391" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set x [eval [list set] [list z $v]];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-if-392" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set x [if 1 {set v}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-expand-393" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set x [set {*}[list z $v]];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-expr-394" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set x [expr {$v}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-expr-plus-395" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set x [expr {$v+0.0}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-expr-conditional-396" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set x [expr {1 ? $v : 0}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-expr-min-397" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set x [expr {min($v,$v)}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-proc-398" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;proc f x {return $x};set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-proc-fallthrough-399" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;proc f x {set x};set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-proc-default-400" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;proc f [list [list p $v]] {return $p};set x [f];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-proc-default-info-401" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;proc f [list [list p $v]] {};info default f p x;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-proc-args-402" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;proc f args {lindex $args 1};set x [f 0 $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-upvar-403" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;proc f {} {upvar 1 v a;return $a};set x [f];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-global-404" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;proc f {} {global v;set v};set x [f];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-uplevel-405" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;proc f {} {uplevel 1 {set v}};set x [f];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-uplevel-list-406" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;proc f a {uplevel 1 [list set z $a]};set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-namespace-407" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;namespace eval n {};set x [namespace eval n [list set z $v]];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-namespace-inscope-408" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;namespace eval n {};set x [namespace inscope n [list set z] $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-namespace-variable-409" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;namespace eval n [list variable z $v];set x $n::z;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-rename-410" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;rename set store;store x [store v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-import-411" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;namespace eval n {proc f x {return $x};namespace export f};namespace import n::f;set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-ensemble-412" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;namespace eval n {proc f x {return $x};namespace ensemble create -map {get f}};set x [n get $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-unknown-413" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;proc unknown {name args} {lindex $args 0};set x [missing $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-catch-ok-414" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;catch {set v} x;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-catch-return-415" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;catch {return $v} x;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-catch-error-416" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;catch {error $v} x;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-catch-throw-417" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;catch {throw CODE $v} x;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-return-level-418" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;proc f a {return -level 0 $a};set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-return-options-419" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;proc f a {return -options {-code 0 -level 1} $a};set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-try-420" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set x [try {set v} finally {set done 1}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-try-handler-421" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set x [try {error $v} on error {r o} {set r}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-try-return-422" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;proc f a {try {return $a} finally {set b 1}};set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-foreach-423" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;foreach x [list $v] {};list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lmap-424" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set x [lindex [lmap p [list $v] {set p}] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-array-element-425" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set a(k) $v;set x $a(k);list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-array-set-426" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;array set a [list k $v];set x $a(k);list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-array-get-427" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set a(k) $v;set x [lindex [array get a] 1];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-get-428" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set x [dict get [dict create k $v] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-key-429" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set x [lindex [dict keys [dict create $v a]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-value-430" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set x [lindex [dict values [dict create k $v]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-set-431" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;dict set d k $v;set x [dict get $d k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-nested-432" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;dict set d a b $v;set x [dict get $d a b];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-lappend-433" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;dict lappend d k $v;set x [lindex [dict get $d k] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-append-empty-434" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;dict set d k $v;dict append d k {};set x [dict get $d k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-merge-435" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set x [dict get [dict merge [dict create k $v] {b 0}] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-replace-436" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set x [dict get [dict replace {} k $v] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-remove-437" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set x [dict get [dict remove [dict create a 0 k $v] a] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-for-438" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;dict for {k x} [dict create k $v] {};list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-map-439" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set x [dict get [dict map {k p} [dict create k $v] {set p}] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-filter-440" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set x [dict get [dict filter [dict create k $v] key k] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-filter-script-441" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set x [dict get [dict filter [dict create k $v] script {k p} {expr 1}] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-update-442" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;dict set d k $v;dict update d k x {};list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-with-443" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;dict set d x $v;dict with d {};list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-same-text-444" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set copy $v;set text [format %s $v];set x $copy;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-copy-list-445" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set a [list $v];set b $a;lset b 0 0;set x [lindex $a 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-copy-list-append-446" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;lappend a $v;set b $a;lappend b 0;set x [lindex $a 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-copy-nested-447" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set a [list [list $v]];set b $a;lset b 0 0 0;set x [lindex $a 0 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-copy-dict-448" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;dict set a k $v;set b $a;dict set b k 0;set x [dict get $a k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-copy-dict-nested-449" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;dict set a k l $v;set b $a;dict set b k l 0;set x [dict get $a k l];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-list-string-length-450" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set a [list $v];string length $a;set x [lindex $a 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.844674407370955e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-list-append-empty-451" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set a [list $v];append a {};set x [lindex $a 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-numeric-list-conversion-452" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set copy $v;llength $v;set x $copy;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.844674407370955e+19 -1.844674407370955e+19 -1.844674407370955e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-nested-expr-453" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;set x [expr {($v*1.0)+0.0}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-math-proc-454" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -18446744073709551616 %f v;namespace eval ::tcl::mathfunc {};proc ::tcl::mathfunc::identity x {return $x};set x [expr {identity($v)}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-1.8446744073709552e+19 -1.844674407370955e+19 -1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-direct-455" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set x $v;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-quoted-456" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set x \"$v\";list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-empty-prefix-457" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set e {};set x \"$e$v\";list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-empty-suffix-458" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set e {};set x \"$v$e\";list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-format-s-459" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set x [format %s $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-append-empty-460" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set x $v;append x {};list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-append-no-args-461" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set x $v;append x;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-string-cat-462" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set x [string cat $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-string-range-463" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set x [string range $v 0 end];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-string-trim-464" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set x [string trim $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-subst-465" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set x [subst {$v}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-list-466" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set x [lindex [list $v] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-join-467" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set x [join [list $v] {}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-concat-list-468" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set x [lindex [concat [list $v] [list a]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-concat-text-469" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set x [lindex [concat [list $v] a] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-concat-one-470" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set x [lindex [concat [list $v]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lrange-471" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set x [lindex [lrange [list $v a] 0 0] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lreverse-472" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set x [lindex [lreverse [list a $v]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lrepeat-473" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set x [lindex [lrepeat 3 $v] 2];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lappend-474" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;lappend a $v;set x [lindex $a 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lset-475" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set a [list 0];lset a 0 $v;set x [lindex $a 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-linsert-476" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set x [lindex [linsert {} 0 $v] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lreplace-477" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set x [lindex [lreplace {a} 0 0 $v] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lsearch-478" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(
        t.eval(
          "scan 1.25 %f v;set x [lsearch -inline -glob [list 0 $v] *e*];list [format %.17g $x] $x [format %.17g $v]",
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
test "Tcl value transport-lsort-479" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set x [lindex [lsort -real [list $v $v]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lsort-command-480" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;proc cmp {a b} {expr {$a>$b ? 1 : $a<$b ? -1 : 0}};set x [lindex [lsort -command cmp [list $v $v]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-eval-list-481" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set x [eval [list set z $v]];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-eval-concat-482" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set x [eval [list set] [list z $v]];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-if-483" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set x [if 1 {set v}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-expand-484" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set x [set {*}[list z $v]];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-expr-485" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set x [expr {$v}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-expr-plus-486" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set x [expr {$v+0.0}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-expr-conditional-487" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set x [expr {1 ? $v : 0}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-expr-min-488" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set x [expr {min($v,$v)}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-proc-489" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;proc f x {return $x};set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-proc-fallthrough-490" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;proc f x {set x};set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-proc-default-491" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;proc f [list [list p $v]] {return $p};set x [f];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-proc-default-info-492" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;proc f [list [list p $v]] {};info default f p x;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-proc-args-493" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;proc f args {lindex $args 1};set x [f 0 $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-upvar-494" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;proc f {} {upvar 1 v a;return $a};set x [f];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-global-495" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;proc f {} {global v;set v};set x [f];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-uplevel-496" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;proc f {} {uplevel 1 {set v}};set x [f];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-uplevel-list-497" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;proc f a {uplevel 1 [list set z $a]};set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-namespace-498" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;namespace eval n {};set x [namespace eval n [list set z $v]];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-namespace-inscope-499" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;namespace eval n {};set x [namespace inscope n [list set z] $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-namespace-variable-500" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;namespace eval n [list variable z $v];set x $n::z;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-rename-501" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;rename set store;store x [store v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-import-502" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;namespace eval n {proc f x {return $x};namespace export f};namespace import n::f;set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-ensemble-503" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;namespace eval n {proc f x {return $x};namespace ensemble create -map {get f}};set x [n get $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-unknown-504" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;proc unknown {name args} {lindex $args 0};set x [missing $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-catch-ok-505" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;catch {set v} x;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-catch-return-506" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;catch {return $v} x;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-catch-error-507" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;catch {error $v} x;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-catch-throw-508" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;catch {throw CODE $v} x;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-return-level-509" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;proc f a {return -level 0 $a};set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-return-options-510" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;proc f a {return -options {-code 0 -level 1} $a};set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-try-511" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set x [try {set v} finally {set done 1}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-try-handler-512" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set x [try {error $v} on error {r o} {set r}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-try-return-513" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;proc f a {try {return $a} finally {set b 1}};set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-foreach-514" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;foreach x [list $v] {};list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lmap-515" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set x [lindex [lmap p [list $v] {set p}] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-array-element-516" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set a(k) $v;set x $a(k);list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-array-set-517" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;array set a [list k $v];set x $a(k);list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-array-get-518" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set a(k) $v;set x [lindex [array get a] 1];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-get-519" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set x [dict get [dict create k $v] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-key-520" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set x [lindex [dict keys [dict create $v a]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-value-521" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set x [lindex [dict values [dict create k $v]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-set-522" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;dict set d k $v;set x [dict get $d k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-nested-523" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;dict set d a b $v;set x [dict get $d a b];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-lappend-524" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;dict lappend d k $v;set x [lindex [dict get $d k] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-append-empty-525" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;dict set d k $v;dict append d k {};set x [dict get $d k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-merge-526" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set x [dict get [dict merge [dict create k $v] {b 0}] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-replace-527" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set x [dict get [dict replace {} k $v] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-remove-528" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set x [dict get [dict remove [dict create a 0 k $v] a] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-for-529" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;dict for {k x} [dict create k $v] {};list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-map-530" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set x [dict get [dict map {k p} [dict create k $v] {set p}] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-filter-531" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set x [dict get [dict filter [dict create k $v] key k] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-filter-script-532" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set x [dict get [dict filter [dict create k $v] script {k p} {expr 1}] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-update-533" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;dict set d k $v;dict update d k x {};list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-with-534" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;dict set d x $v;dict with d {};list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-same-text-535" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set copy $v;set text [format %s $v];set x $copy;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-copy-list-536" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set a [list $v];set b $a;lset b 0 0;set x [lindex $a 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-copy-list-append-537" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;lappend a $v;set b $a;lappend b 0;set x [lindex $a 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-copy-nested-538" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set a [list [list $v]];set b $a;lset b 0 0 0;set x [lindex $a 0 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-copy-dict-539" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;dict set a k $v;set b $a;dict set b k 0;set x [dict get $a k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-copy-dict-nested-540" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;dict set a k l $v;set b $a;dict set b k l 0;set x [dict get $a k l];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-list-string-length-541" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set a [list $v];string length $a;set x [lindex $a 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-list-append-empty-542" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set a [list $v];append a {};set x [lindex $a 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-numeric-list-conversion-543" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set copy $v;llength $v;set x $copy;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-nested-expr-544" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;set x [expr {($v*1.0)+0.0}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-math-proc-545" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.25 %f v;namespace eval ::tcl::mathfunc {};proc ::tcl::mathfunc::identity x {return $x};set x [expr {identity($v)}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "1.25 1.25 1.25",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-direct-546" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set x $v;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-quoted-547" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set x \"$v\";list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-empty-prefix-548" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set e {};set x \"$e$v\";list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-empty-suffix-549" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set e {};set x \"$v$e\";list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-format-s-550" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set x [format %s $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-append-empty-551" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set x $v;append x {};list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-append-no-args-552" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set x $v;append x;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-string-cat-553" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set x [string cat $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-string-range-554" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set x [string range $v 0 end];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-string-trim-555" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set x [string trim $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-subst-556" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set x [subst {$v}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-list-557" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set x [lindex [list $v] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-join-558" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set x [join [list $v] {}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-concat-list-559" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set x [lindex [concat [list $v] [list a]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-concat-text-560" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set x [lindex [concat [list $v] a] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-concat-one-561" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set x [lindex [concat [list $v]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lrange-562" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set x [lindex [lrange [list $v a] 0 0] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lreverse-563" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set x [lindex [lreverse [list a $v]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lrepeat-564" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set x [lindex [lrepeat 3 $v] 2];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lappend-565" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;lappend a $v;set x [lindex $a 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lset-566" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set a [list 0];lset a 0 $v;set x [lindex $a 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-linsert-567" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set x [lindex [linsert {} 0 $v] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lreplace-568" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set x [lindex [lreplace {a} 0 0 $v] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lsearch-569" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(
        t.eval(
          "scan -0.0 %f v;set x [lsearch -inline -glob [list 0 $v] *e*];list [format %.17g $x] $x [format %.17g $v]",
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
test "Tcl value transport-lsort-570" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set x [lindex [lsort -real [list $v $v]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lsort-command-571" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;proc cmp {a b} {expr {$a>$b ? 1 : $a<$b ? -1 : 0}};set x [lindex [lsort -command cmp [list $v $v]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-eval-list-572" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set x [eval [list set z $v]];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-eval-concat-573" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set x [eval [list set] [list z $v]];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-if-574" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set x [if 1 {set v}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-expand-575" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set x [set {*}[list z $v]];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-expr-576" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set x [expr {$v}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-expr-plus-577" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set x [expr {$v+0.0}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "0 0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-expr-conditional-578" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set x [expr {1 ? $v : 0}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-expr-min-579" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set x [expr {min($v,$v)}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-proc-580" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;proc f x {return $x};set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-proc-fallthrough-581" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;proc f x {set x};set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-proc-default-582" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;proc f [list [list p $v]] {return $p};set x [f];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-proc-default-info-583" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;proc f [list [list p $v]] {};info default f p x;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-proc-args-584" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;proc f args {lindex $args 1};set x [f 0 $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-upvar-585" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;proc f {} {upvar 1 v a;return $a};set x [f];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-global-586" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;proc f {} {global v;set v};set x [f];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-uplevel-587" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;proc f {} {uplevel 1 {set v}};set x [f];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-uplevel-list-588" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;proc f a {uplevel 1 [list set z $a]};set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-namespace-589" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;namespace eval n {};set x [namespace eval n [list set z $v]];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-namespace-inscope-590" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;namespace eval n {};set x [namespace inscope n [list set z] $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-namespace-variable-591" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;namespace eval n [list variable z $v];set x $n::z;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-rename-592" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;rename set store;store x [store v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-import-593" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;namespace eval n {proc f x {return $x};namespace export f};namespace import n::f;set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-ensemble-594" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;namespace eval n {proc f x {return $x};namespace ensemble create -map {get f}};set x [n get $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-unknown-595" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;proc unknown {name args} {lindex $args 0};set x [missing $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-catch-ok-596" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;catch {set v} x;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-catch-return-597" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;catch {return $v} x;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-catch-error-598" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;catch {error $v} x;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-catch-throw-599" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;catch {throw CODE $v} x;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-return-level-600" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;proc f a {return -level 0 $a};set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-return-options-601" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;proc f a {return -options {-code 0 -level 1} $a};set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-try-602" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set x [try {set v} finally {set done 1}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-try-handler-603" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set x [try {error $v} on error {r o} {set r}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-try-return-604" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;proc f a {try {return $a} finally {set b 1}};set x [f $v];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-foreach-605" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;foreach x [list $v] {};list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-lmap-606" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set x [lindex [lmap p [list $v] {set p}] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-array-element-607" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set a(k) $v;set x $a(k);list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-array-set-608" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;array set a [list k $v];set x $a(k);list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-array-get-609" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set a(k) $v;set x [lindex [array get a] 1];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-get-610" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set x [dict get [dict create k $v] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-key-611" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set x [lindex [dict keys [dict create $v a]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-value-612" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set x [lindex [dict values [dict create k $v]] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-set-613" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;dict set d k $v;set x [dict get $d k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-nested-614" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;dict set d a b $v;set x [dict get $d a b];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-lappend-615" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;dict lappend d k $v;set x [lindex [dict get $d k] 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-append-empty-616" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;dict set d k $v;dict append d k {};set x [dict get $d k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-merge-617" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set x [dict get [dict merge [dict create k $v] {b 0}] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-replace-618" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set x [dict get [dict replace {} k $v] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-remove-619" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set x [dict get [dict remove [dict create a 0 k $v] a] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-for-620" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;dict for {k x} [dict create k $v] {};list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-map-621" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set x [dict get [dict map {k p} [dict create k $v] {set p}] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-filter-622" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set x [dict get [dict filter [dict create k $v] key k] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-filter-script-623" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set x [dict get [dict filter [dict create k $v] script {k p} {expr 1}] k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-update-624" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;dict set d k $v;dict update d k x {};list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-dict-with-625" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;dict set d x $v;dict with d {};list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-same-text-626" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set copy $v;set text [format %s $v];set x $copy;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-copy-list-627" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set a [list $v];set b $a;lset b 0 0;set x [lindex $a 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-copy-list-append-628" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;lappend a $v;set b $a;lappend b 0;set x [lindex $a 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-copy-nested-629" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set a [list [list $v]];set b $a;lset b 0 0 0;set x [lindex $a 0 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-copy-dict-630" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;dict set a k $v;set b $a;dict set b k 0;set x [dict get $a k];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-copy-dict-nested-631" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;dict set a k l $v;set b $a;dict set b k l 0;set x [dict get $a k l];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-list-string-length-632" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set a [list $v];string length $a;set x [lindex $a 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-list-append-empty-633" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set a [list $v];append a {};set x [lindex $a 0];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-numeric-list-conversion-634" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set copy $v;llength $v;set x $copy;list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-nested-expr-635" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;set x [expr {($v*1.0)+0.0}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "0 0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value transport-math-proc-636" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -0.0 %f v;namespace eval ::tcl::mathfunc {};proc ::tcl::mathfunc::identity x {return $x};set x [expr {identity($v)}];list [format %.17g $x] $x [format %.17g $v]",
      budget=100000,
    ),
    "-0 -0.0 -0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value same-text-distinct-637" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a $v;set b [format %s $v];list [expr {$a==$b}] [format %.17g $a] [format %.17g $b]",
      budget=100000,
    ),
    "0 1.8446744073709552e+19 1.844674407370955e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value same-text-distinct-638" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a [lindex [list $v] 0];set b [lindex [list [format %s $v]] 0];list [expr {$a==$b}] [format %.17g $a] [format %.17g $b]",
      budget=100000,
    ),
    "0 1.8446744073709552e+19 1.844674407370955e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value same-text-distinct-639" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;dict set d a $v;dict set d b [format %s $v];set a [dict get $d a];set b [dict get $d b];list [expr {$a==$b}] [format %.17g $a] [format %.17g $b]",
      budget=100000,
    ),
    "0 1.8446744073709552e+19 1.844674407370955e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value same-text-distinct-640" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set ar(a) $v;set ar(b) [format %s $v];set a $ar(a);set b $ar(b);list [expr {$a==$b}] [format %.17g $a] [format %.17g $b]",
      budget=100000,
    ),
    "0 1.8446744073709552e+19 1.844674407370955e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-641" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a $v;string length $a;list [format %.17g [set a]] [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.844674407370955e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-642" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a [list $v];string length $a;list [format %.17g [lindex $a 0]] [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-643" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a $v;string index $a 0;list [format %.17g [set a]] [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.844674407370955e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-644" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a [list $v];string index $a 0;list [format %.17g [lindex $a 0]] [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-645" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a $v;string range $a 0 end;list [format %.17g [set a]] [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.844674407370955e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-646" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a [list $v];string range $a 0 end;list [format %.17g [lindex $a 0]] [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-647" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a $v;string equal $a $a;list [format %.17g [set a]] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-648" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a [list $v];string equal $a $a;list [format %.17g [lindex $a 0]] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-649" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a $v;string compare $a $a;list [format %.17g [set a]] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-650" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a [list $v];string compare $a $a;list [format %.17g [lindex $a 0]] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-651" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a $v;string equal -nocase $a $a;list [format %.17g [set a]] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-652" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a [list $v];string equal -nocase $a $a;list [format %.17g [lindex $a 0]] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-653" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a $v;string compare -length 2 $a $a;list [format %.17g [set a]] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-654" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a [list $v];string compare -length 2 $a $a;list [format %.17g [lindex $a 0]] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-655" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a $v;string first 1 $a;list [format %.17g [set a]] [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.844674407370955e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-656" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a [list $v];string first 1 $a;list [format %.17g [lindex $a 0]] [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-657" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a $v;string last 1 $a;list [format %.17g [set a]] [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.844674407370955e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-658" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a [list $v];string last 1 $a;list [format %.17g [lindex $a 0]] [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-659" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a $v;string toupper $a;list [format %.17g [set a]] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-660" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a [list $v];string toupper $a;list [format %.17g [lindex $a 0]] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-661" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a $v;string tolower $a;list [format %.17g [set a]] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-662" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a [list $v];string tolower $a;list [format %.17g [lindex $a 0]] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-663" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a $v;string totitle $a;list [format %.17g [set a]] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-664" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a [list $v];string totitle $a;list [format %.17g [lindex $a 0]] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-665" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a $v;string trim $a;list [format %.17g [set a]] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-666" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a [list $v];string trim $a;list [format %.17g [lindex $a 0]] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-667" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a $v;string trimleft $a;list [format %.17g [set a]] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-668" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a [list $v];string trimleft $a;list [format %.17g [lindex $a 0]] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-669" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a $v;string trimright $a;list [format %.17g [set a]] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-670" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a [list $v];string trimright $a;list [format %.17g [lindex $a 0]] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-671" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a $v;string repeat $a 1;list [format %.17g [set a]] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-672" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a [list $v];string repeat $a 1;list [format %.17g [lindex $a 0]] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-673" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a $v;string reverse $a;list [format %.17g [set a]] [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.844674407370955e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-674" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a [list $v];string reverse $a;list [format %.17g [lindex $a 0]] [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-675" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a $v;string replace $a 0 0 x;list [format %.17g [set a]] [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.844674407370955e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-676" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a [list $v];string replace $a 0 0 x;list [format %.17g [lindex $a 0]] [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-677" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a $v;string match * $a;list [format %.17g [set a]] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-678" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a [list $v];string match * $a;list [format %.17g [lindex $a 0]] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-679" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a $v;string match -nocase * $a;list [format %.17g [set a]] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-680" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a [list $v];string match -nocase * $a;list [format %.17g [lindex $a 0]] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-681" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a $v;string map {1 2} $a;list [format %.17g [set a]] [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.844674407370955e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-682" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a [list $v];string map {1 2} $a;list [format %.17g [lindex $a 0]] [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-683" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a $v;string is double $a;list [format %.17g [set a]] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-684" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a [list $v];string is double $a;list [format %.17g [lindex $a 0]] [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-685" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a $v;string is integer $a;list [format %.17g [set a]] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-686" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a [list $v];string is integer $a;list [format %.17g [lindex $a 0]] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-687" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a $v;string is list $a;list [format %.17g [set a]] [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.844674407370955e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-688" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a [list $v];string is list $a;list [format %.17g [lindex $a 0]] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-689" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a $v;format %s $a;list [format %.17g [set a]] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-690" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a [list $v];format %s $a;list [format %.17g [lindex $a 0]] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-691" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a $v;puts -nonewline $a;list [format %.17g [set a]] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "1.844674407370955e+19")
}

///|
test "Tcl value representation-692" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a [list $v];puts -nonewline $a;list [format %.17g [lindex $a 0]] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "1.844674407370955e+19")
}

///|
test "Tcl value representation-693" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a $v;llength $a;list [format %.17g [set a]] [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.844674407370955e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-694" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a [list $v];llength $a;list [format %.17g [lindex $a 0]] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-695" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a $v;lindex $a 0;list [format %.17g [set a]] [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.844674407370955e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value representation-696" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a [list $v];lindex $a 0;list [format %.17g [lindex $a 0]] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-697" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 8.108810055808411e+71 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "8.1088100558084112e+71 810881005580841116587245869550674021007069974402887784962729762413871104",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-698" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.119364248413211e-118 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "1.119364248413211e-118 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-699" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.8643145600032928e-246 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "1.8643145600032928e-246 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-700" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -3.724380527961818e-177 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-3.7243805279618179e-177 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-701" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.71889264606699e+223 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "5.7188926460669901e+223 57188926460669900685153119927690317487004562088292568595598985668181857419175516640541910335637890090524324903326314095015924659681420418669045340380134690848470713442789826818963879714133264377921570445318525644703726043136",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-702" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -7.157996320079462e+87 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-7.1579963200794616e+87 -7157996320079461622856501214345083048626240373014936835518068591375768014166455312449536",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-703" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -2.1304887852759246e-150 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-2.1304887852759246e-150 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-704" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -2.844926375227869e-112 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-2.8449263752278692e-112 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-705" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 4.131052904344375e+133 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "4.1310529043443749e+133 41310529043443748704946364814908869588169696526094558675647366863790705579953541866442305472793196677455809676270706385658494570201088",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-706" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -8.502969565110225e-15 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-8.5029695651102254e-15 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-707" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -1.8348519912135007e-248 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-1.8348519912135007e-248 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-708" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 4.459724460496257e+147 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "4.4597244604962573e+147 4459724460496257303339346832080912857080763850183730467471993700590516034968490965988647094259015097434151140237102565093647284850793598346432872448",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-709" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.0913214016507677e-188 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "5.0913214016507677e-188 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-710" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.719792518006848e-74 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "5.7197925180068479e-74 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-711" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 2.587674620108257e-251 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "2.5876746201082569e-251 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-712" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -1.31899240177276e+113 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-1.31899240177276e+113 -131899240177275997706902135785696654319599879122995642739652426876699363748805034211424924711646441916616172109824",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-713" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -4.866235726789775e-103 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-4.8662357267897752e-103 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-714" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -1.291604870934941e-181 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-1.2916048709349411e-181 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-715" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -2.9887214071984715e+267 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-2.9887214071984715e+267 -2988721407198471509859497461015784348970065240340763118107208793981258555093971261008626425040036700960664295892624790125079889154820342349186213324979225379934132649103094105190162127957040490620708177514919017222570155974561386661555965337455902273510068616467316736",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-716" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -7.463409964844018e-178 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-7.4634099648440185e-178 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-717" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -850179458644.0769 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-850179458644.0769 -850179458644",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-718" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -3.485544750253912e-80 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-3.4855447502539121e-80 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-719" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -1.4449696682086796e-239 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-1.4449696682086796e-239 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-720" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -4.979354379575983e-102 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-4.9793543795759831e-102 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-721" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 7.185327776908188e+301 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "7.1853277769081877e+301 71853277769081876765041935747535566373025622929998185210868446360164129471633623675766877791942541796422331031990379744973358844024690526104105472195054561866440166888212754569890801662475399966864686883210768495014039586559438442756664646259492613681058402073026584955233335322793623452174443276664832",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-722" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -8.73039230303011e-301 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-8.7303923030301099e-301 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-723" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -5.524681434654126e-240 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-5.5246814346541258e-240 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-724" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.1684534430182891e-60 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "1.1684534430182891e-60 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-725" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 7.162821607789361e-07 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "7.1628216077893606e-07 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-726" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -3.920088407284217e-188 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-3.9200884072842173e-188 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-727" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 4.4820601123657386e-167 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "4.4820601123657386e-167 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-728" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1566757230783222.5 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "1566757230783222.5 1566757230783222",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-729" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 310300225306484.75 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "310300225306484.75 310300225306484",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-730" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -2.248578141572659e+200 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-2.2485781415726591e+200 -224857814157265908231067328147473485012913423420892303712296793999523578684812591608499635945077260750143328791604732807890454596802883296477560488488270650588083368336426565126464325368781118600380416",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-731" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -2.3705930331926588e-294 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-2.3705930331926588e-294 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-732" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.4646989700611046e-10 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "1.4646989700611046e-10 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-733" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 343218933847423.6 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "343218933847423.62 343218933847423",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-734" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -2.2339855987330997e+189 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-2.2339855987330997e+189 -2233985598733099655240250067553102567350513346361548905780716437812618627123809955360250793133214884836263886755643602836407029287229250088885291091765499121513545256892501152778062147878912",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-735" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -2.0511467630805256e-155 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-2.0511467630805256e-155 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-736" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 7.379531770339171e-102 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "7.379531770339171e-102 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-737" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.8126039290418276e-288 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "1.8126039290418276e-288 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-738" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 2.441379196239034e-236 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "2.4413791962390341e-236 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-739" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -6.206076186912715e+152 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-6.2060761869127146e+152 -620607618691271459937390498016967845132775865572481432017019573028778357343177573240260423540020406726494825920420496898268405638902262377635046777421824",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-740" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -2521.791337610753 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-2521.7913376107531 -2521",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-741" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -7.042127376480022e-39 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-7.0421273764800218e-39 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-742" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 7.580232582567281e-271 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "7.5802325825672808e-271 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-743" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 4.970439855348868e-169 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "4.9704398553488681e-169 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-744" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -9.701858777731555e+175 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-9.7018587777315546e+175 -97018587777315545544980680414663171718772139175172753634813938636584169817387609659750674630478087852055740405690526887462555736390804711495929283979468618434558932056583176192",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-745" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -3.0491317416329796e+121 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-3.0491317416329796e+121 -30491317416329796381323068817474191101753269747578051632327945591279517964679854621430398925636853260257130748699106869248",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-746" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -2.9429060101996175e-154 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-2.9429060101996175e-154 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-747" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -1.236790337344897e+190 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-1.2367903373448971e+190 -12367903373448970592109429046458593710672338722514146984162298371091085291688903182778459825897681766155098181699442337464198152523456944162944849589460490712548176235617366570300591648538624",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-748" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 4.645060282123811e-06 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "4.6450602821238112e-06 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-749" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -2.1436546674032816e-54 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-2.1436546674032816e-54 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-750" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -1.0992307902229197e+62 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-1.0992307902229197e+62 -109923079022291967234370320796404975362721659413464191520997376",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-751" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -3.473169366632548e-49 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-3.4731693666325483e-49 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-752" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 6.744003632124437e-260 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "6.7440036321244366e-260 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-753" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.2659049184034872e+227 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "1.2659049184034872e+227 126590491840348721409096219167886963339636725815327351419426576652572995694171310732555678942169216836974659120008984646186111001109696046687030259283138847035028753791404127766253697994921437133316501242918373498033359101624320",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-754" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -5.38321046311381e+244 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-5.3832104631138097e+244 -53832104631138097246420630745406612178965595733155805047019906385011083040389362977235572383539362999346334757138504006439353710185059977378136076845687587674784834553096336168124464719824948067862205418753429710827412545950618678064783074263040",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-755" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -4.259698140541347e+140 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-4.2596981405413469e+140 -425969814054134690933232334660542728540300966453168939847155386975866759143222793080527907726829116228820311261452652340810922857268261158912",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-756" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 5.000133931896181e+190 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "5.000133931896181e+190 50001339318961809580817095822131245251121484800299466545063239995050347507972558449307390310542316148717680507995110367232584805310280729683664008512020151177750277905978231981931369427107840",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-757" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -1.4609868296648451e-146 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-1.4609868296648451e-146 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-758" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.8158619161708048e-55 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "1.8158619161708048e-55 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-759" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 2.805125134977569e-50 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "2.8051251349775691e-50 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-760" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.417021608150376e-306 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "9.4170216081503761e-306 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-761" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 3.7042307497991666e+140 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "3.7042307497991666e+140 370423074979916660040341478898420977607009824534517848036092812815663567812941641883011243538332286282557145718921208360148562306976167493632",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-762" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -3.601072720311017e-150 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-3.6010727203110168e-150 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-763" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.9763591280470994e+148 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "1.9763591280470994e+148 19763591280470993995397306503421696462561978518653348139263810704681845784542847057534304410667049277948300035437064056252970450504745707025406623744",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-764" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -3.322391244342625e-289 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-3.3223912443426249e-289 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-765" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -3.8935971717859394e-159 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-3.8935971717859394e-159 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-766" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.748917203787192e+301 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "9.7489172037871918e+301 97489172037871917900356736017792681015881642243525360999614965169313357741908273581815075882897527020759092588160686671820629767641379994692694293732958525860920117255564374006088698989110106985698744158134318496107648589776407230013140131736750038619381016183943511006522840474938250232011680770949120",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-767" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.31307334364847e-226 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "1.3130733436484699e-226 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-768" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 7.457782417352394e+150 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "7.4577824173523943e+150 7457782417352394267620276722961582360185629970624989294896312656265074237399527400275263235080403330156461197090365373496983510945674081194616868044800",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-769" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -2.253241302964025e+116 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-2.253241302964025e+116 -225324130296402504345558513748232449745047254940039084037195826352452247689286093834683798789118270148645964943982592",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-770" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -1.6533887645487647e-270 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-1.6533887645487647e-270 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-771" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.8633436810858762e-67 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "1.8633436810858762e-67 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-772" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.1115501152617486e+231 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "1.1115501152617486e+231 1111550115261748623165047424991814348544081841110894477804091218645389707401802585627543335304957355957224681302816422475618188932434517848271568043950263181876720364098873215427046092179105108933594887312411840890530909383951384576",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-773" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -1.9091125229012588e+190 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-1.9091125229012588e+190 -19091125229012587850138554349217598129351588160017487404691151948308430609540312561899455358017068497926039544118796416579302165621077413862622654599378024535118926867344487331083714987819008",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-774" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -1.5998068871478134e+249 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-1.5998068871478134e+249 -1599806887147813433922725922604976750406572692635127674536571006129924484513880876603916355436281898076775767846950576373501536119349490354693490991086584227164078254209606886981524994213061861709146909819466268703209691588545832953782644423828439040",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-775" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -1.1272863000081778e-225 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-1.1272863000081778e-225 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-776" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 2.0499289678549392e-36 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "2.0499289678549392e-36 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-777" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -3.014306194132154e+178 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-3.0143061941321539e+178 -30143061941321538971140010261897099041328824231692465245446937336894841542395017336701893296047408829118180345218455339468951136184062137807531549466418352660826625335664482189312",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-778" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -9.073304394753252e-209 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-9.0733043947532525e-209 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-779" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 2.438136663629129e+28 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "2.4381366636291289e+28 24381366636291288571070906368",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-780" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 6.424986785361354e-61 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "6.4249867853613538e-61 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-781" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -1.1811615959684898e+184 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-1.1811615959684898e+184 -11811615959684897867121727586073617776229073564074900098786906565345785345066677609428560196625445939791337522290463841201122322949161656172673268518992676648766009447941469432293883904",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-782" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 4.371674836569708e+118 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "4.3716748365697077e+118 43716748365697077293953256748284553053934313048321538862132570670482785346384659703004265814467443096263957550353874944",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-783" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -4.2051227688374437e-41 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-4.2051227688374437e-41 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-784" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 8.29319004749852e-89 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "8.2931900474985194e-89 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-785" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -8.619981896318953e-36 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-8.6199818963189526e-36 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-786" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 2.2765281836880262e+112 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "2.2765281836880262e+112 22765281836880262482851679751001394469126854058262936251976342362851254397884171027560059661484701925256839823360",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-787" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -2.4392329278839523e+177 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-2.4392329278839523e+177 -2439232927883952299229686111514624660951363316141822493905388255919759613746167291145846523295598611882438703632053364112299221255104945153877277632804548965456310463293162520576",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-788" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 2.938062810071566e+143 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "2.9380628100715662e+143 293806281007156619563626135827093367690016872792497272475274487968180403017587564533591168405817541800242439396797880268188622975153411694002176",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-789" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 9.41276574052963e-28 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "9.4127657405296295e-28 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-790" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 3.1210749924059417e+59 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "3.1210749924059417e+59 312107499240594173150638696056520475254185985683493230739456",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-791" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 4.050585062282251e+295 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "4.0505850622822511e+295 40505850622822511009397285744720996486484325838008829928977749670180388081891014574143909952725269979883036303876062265975130964907389415738574797515573588041408567162830599127252289929293819754561272774452607964532479040717761171089436812879465868716378193293160248732924399442712573233143480320",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-792" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -5.59587610993659e+36 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-5.59587610993659e+36 -5595876109936589996491363925733933056",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-793" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -6.472941803212697e-50 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-6.4729418032126966e-50 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-794" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 3.614387226417391e+128 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "3.614387226417391e+128 361438722641739101298592706825108908425891779714565733848810080248676356199822672103574965118089552306718350266687617060713791488",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-795" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 6.1985113346894905e-171 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "6.1985113346894905e-171 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-796" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 4.159269034512135e+178 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "4.1592690345121348e+178 41592690345121348316769798519213110858237368449647716914304910761757046729764002607835150822702644212595327633225548524266564894427715990539298907161499001491717769042189980008448",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-797" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -1.709187644674715e-223 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-1.709187644674715e-223 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-798" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 8.127299848057423e-221 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "8.1272998480574232e-221 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-799" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -2.026095422214587e+121 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-2.026095422214587e+121 -20260954222145869745074878102682349753212444865496156166665623761581198778731619909816344065247531352955284750049914912768",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-800" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -5.595357232767919e-177 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-5.5953572327679187e-177 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-801" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 3.576051761221916e-286 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "3.5760517612219161e-286 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-802" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 3.089517745166413e-253 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "3.0895177451664133e-253 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-803" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 336047823.10774124 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "336047823.10774124 336047823",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-804" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -2.089662961939162e-247 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-2.0896629619391621e-247 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-805" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -1.5268195231993556e-33 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-1.5268195231993556e-33 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-806" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 7.409256049090701e+263 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "7.4092560490907012e+263 740925604909070121523375367909788715566422962395481434958224399196757226289880415161543167864078189175932526894139920177007050379463068477479477506735816513294098720610582699668870035257990291168609502714186562135138237657981549240809945991111954469522851724525568",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-807" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 3.039725770483368e-243 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "3.039725770483368e-243 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-808" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -2.5889726060097577e+190 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-2.5889726060097577e+190 -25889726060097576802753025679588082296815352180474747519911923282620898965394662881181990626555525156281639348914667957659435894371304010644765476251900196208024934745857185600046031729328128",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-809" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -1.5004401707503325e+29 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-1.5004401707503325e+29 -150044017075033252197585387520",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-810" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -1.9372439985398918e+31 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-1.9372439985398918e+31 -19372439985398917865680637263872",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-811" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -1.8033691246339858e-08 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-1.8033691246339858e-08 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-812" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -1.0720112487840826e-113 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-1.0720112487840826e-113 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-813" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 1.9327601175359237e-41 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "1.9327601175359237e-41 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-814" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan -7.888809597504996e-266 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "-7.8888095975049956e-266 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-815" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 3.4670013901849123e-131 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "3.4670013901849123e-131 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value arithmetic-816" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 2.592858992539611e-225 %f v;list [format %.17g [expr {($v+0.0)*1.0}]] [expr {entier($v)}]",
      budget=100000,
    ),
    "2.5928589925396109e-225 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value shared-direct-817" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x $v;string length $x;list [format %.17g $x] [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.844674407370955e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value shared-quoted-818" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x \"$v\";string length $x;list [format %.17g $x] [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.844674407370955e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value shared-expr-819" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [expr {$v}];string length $x;list [format %.17g $x] [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value shared-expr-conditional-820" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [expr {1 ? $v : 0}];string length $x;list [format %.17g $x] [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value shared-expr-min-821" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [expr {min($v,$v)}];string length $x;list [format %.17g $x] [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value shared-proc-822" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;proc f x {return $x};set x [f $v];string length $x;list [format %.17g $x] [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.844674407370955e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value shared-proc-default-823" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;proc f [list [list p $v]] {return $p};set x [f];string length $x;list [format %.17g $x] [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.844674407370955e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value shared-proc-args-824" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;proc f args {lindex $args 1};set x [f 0 $v];string length $x;list [format %.17g $x] [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.844674407370955e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value shared-list-825" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [lindex [list $v] 0];string length $x;list [format %.17g $x] [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.844674407370955e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value shared-array-element-826" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a(k) $v;set x $a(k);string length $x;list [format %.17g $x] [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.844674407370955e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value shared-dict-get-827" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [dict get [dict create k $v] k];string length $x;list [format %.17g $x] [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.844674407370955e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value shared-catch-ok-828" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;catch {set v} x;string length $x;list [format %.17g $x] [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.844674407370955e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value shared-try-829" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [try {set v} finally {set done 1}];string length $x;list [format %.17g $x] [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.844674407370955e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value shared-expression-830" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [expr {+$v}];string length $x;list [format %.17g $x] [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value shared-expression-831" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [expr {abs($v)}];string length $x;list [format %.17g $x] [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value shared-expression-832" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [expr {double($v)}];string length $x;list [format %.17g $x] [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value shared-expression-833" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [expr {min($v,$v)}];string length $x;list [format %.17g $x] [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value shared-expression-834" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [expr {max($v,$v)}];string length $x;list [format %.17g $x] [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value script-value-835" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;catch [list set z $v] x;list [format %.17g $x] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value script-value-836" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [try [list set z $v] finally {}];list [format %.17g $x] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value script-value-837" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;catch [list error $v] x;list [format %.17g $x] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value script-value-838" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [if 1 [list set z $v]];list [format %.17g $x] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value script-value-839" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;foreach p 1 [list set x $v];list [format %.17g $x] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value script-value-840" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [lindex [lmap p 1 [list set z $v]] 0];list [format %.17g $x] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value script-value-841" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;namespace eval n {proc f x {return $x}};namespace ensemble create -command ens -map [list get [list n::f $v]];set x [ens get];list [format %.17g $x] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value script-value-842" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;proc handler {v args} {return $v};namespace unknown [list handler $v];set x [missing];list [format %.17g $x] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value unchanged-string-843" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [string cat $v {}];list [format %.17g $x] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value unchanged-string-844" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [string cat {} $v];list [format %.17g $x] [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value unchanged-string-845" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [string repeat $v 1];list [format %.17g $x] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value unchanged-string-846" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [string map {} $v];list [format %.17g $x] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value object-representations-847" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a [dict create k $v];set x [lindex $a 1];list [format %.17g $x] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value object-representations-848" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a [list k $v];set x [dict get $a k];list [format %.17g $x] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value object-representations-849" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a [dict create k $v];set b [concat $a];set x [dict get $b k];list [format %.17g $x] [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value object-representations-850" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;catch {return -foo $v ok} r o;set x [dict get $o -foo];list [format %.17g $x] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value object-representations-851" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;catch {return -options [dict create -foo $v] ok} r o;set x [dict get $o -foo];list [format %.17g $x] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value object-representations-852" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set x [try {return -code error -foo $v bad} on return {r o} {dict get $o -foo}];list [format %.17g $x] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value object-representations-853" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;catch {try {return -code error -foo $v bad} finally {error broken}} r o;set x [dict get $o -during -foo];list [format %.17g $x] [format %.17g $v]",
      budget=100000,
    ),
    "1.8446744073709552e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl value object-representations-854" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;proc f {} [list return $v];set x [f];list [format %.17g $x] [format %.17g $v]",
      budget=100000,
    ),
    "1.844674407370955e+19 1.8446744073709552e+19",
  )
  assert_eq(t.output_text(), "")
}
