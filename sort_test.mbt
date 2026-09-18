///|
test "sort stride keeps groups intact and reports original indices" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("set v {c 3 a 1 b 2};lsort -stride 2 -index end -integer $v"),
    "a 1 b 2 c 3",
  )
  t.clear_cache()
  assert_eq(
    t.eval("lsort -stride 2 -index end -integer -indices $v"),
    "2 3 4 5 0 1",
  )
  assert_eq(
    t.eval("lsort -stride 2 -index {1 end} -integer {c {z 3} a {x 1} b {y 2}}"),
    "a {x 1} b {y 2} c {z 3}",
  )
}

///|
test "sort uniqueness keeps the last equal group and source positions" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("lsort -stride 2 -index 1 -integer -unique {a 1 b 2 c 1}"),
    "c 1 b 2",
  )
  assert_eq(
    t.eval("lsort -stride 2 -index 1 -integer -unique -indices {a 1 b 2 c 1}"),
    "4 5 2 3",
  )
  assert_eq(t.eval("lsort -dictionary -decreasing -unique {Ǆ ǅ ǆ}"), "ǆ")
}

///|
test "sort conversion and validation include empty and singleton inputs" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval_catch("lsort -integer {bad}").result,
    "expected integer but got \"bad\"",
  )
  assert_eq(
    t.eval_catch("lsort -real {NaN}").result,
    "floating point value is Not a Number",
  )
  assert_eq(t.eval("lsort -stride 2 -index 2 {}"), "")
  assert_eq(t.eval_catch("lsort -stride 2 -index 2 {a b}").code, 1)
  assert_eq(
    t.eval("lsort -integer -indices {18446744073709551615 0 -1}"),
    "0 2 1",
  )
}

///|
test "sort command options preserve argument case and native comparison order" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp {e d c b a}];list $result $calls",
    ),
    "{a b c d e} {{e d} {c b} {d b} {d c} {b a}}",
  )
  assert_eq(
    t.eval(
      "proc cmp {a b} {lappend ::calls [list $a $b];return 0};set calls {};lsort -nocase -command cmp {A B C};set calls",
    ),
    "{A B} {A C} {B C}",
  )
  assert_eq(t.eval("lsort -command missing -integer {2 1}"), "1 2")
  assert_eq(
    t.eval(
      "proc cmp {a b} {return -2147483648};lsort -command cmp -decreasing {a b}",
    ),
    "a b",
  )
}

///|
test "sort comparator failures preserve completion and next-index precedence" {
  let t = @tcl.Interpreter::new()
  ignore(t.eval("proc cmp {a b} {return -code break STOP}"))
  let result = t.eval_catch("lsort -command cmp {a b}")
  assert_eq(result.code, 3)
  assert_eq(result.result, "STOP")
  assert_eq(
    t.eval("list [info exists ::errorInfo] [info exists ::errorCode]"),
    "1 1",
  )
  assert_eq(
    t.eval_catch("lsort -index 1 -command cmp {{a x} {b y} z}").result,
    "element 1 missing from sublist \"z\"",
  )
  assert_eq(
    t.eval_catch("lsort -index 1 -command cmp {{a x} {b y} {c z} q}").result,
    "STOP",
  )
}

///|
test "sort reentrant comparison retains the input snapshot and namespace" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc cmp {a b} {set ::v changed;lsort -integer {3 1 2};string compare $a $b};set v {c a b};list [lsort -command cmp $v] $v",
    ),
    "{a b c} changed",
  )
  assert_eq(
    t.eval(
      "namespace eval n {proc cmp {a b} {string compare $a $b};proc run {} {lsort -command cmp {c a b}}};n::run",
    ),
    "a b c",
  )
  assert_eq(
    t.eval("rename lsort order;order -str 2 -inde 1 -int -indic {x 3 y 1 z 2}"),
    "2 3 4 5 0 1",
  )
}

///|
test "sort keeps numeric values and collection list error metadata" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set r [lsort -real [list $v 0]];format %.17g [lindex $r end]",
    ),
    "1.8446744073709552e+19",
  )
  assert_eq(
    t.eval("catch {lsort -command \\{ {}} r o;list $r [dict get $o -errorcode]"),
    "{unmatched open brace in list} {TCL VALUE LIST BRACE}",
  )
  assert_eq(
    t.eval("catch {lsort -index {0} [list \\{]} r o;dict get $o -errorcode"),
    "TCL VALUE LIST BRACE",
  )
}

///|
test "sort budget exhaustion permits another call without damaged input" {
  let t = @tcl.Interpreter::new()
  ignore(t.eval("set v [lrepeat 200 1]"))
  assert_true(
    try {
      ignore(t.eval("lsort -integer $v", budget=30))
      false
    } catch {
      _ => true
    },
  )
  assert_eq(t.eval("llength $v"), "200")
  assert_eq(t.eval("lsort -integer -unique $v"), "1")
  assert_eq(t.eval("lsort -stride 2 -index 1 -integer {b 2 a 1}"), "a 1 b 2")
}
