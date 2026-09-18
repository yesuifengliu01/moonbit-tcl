///|
test "stored double survives API calls cache clearing and command failure" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("scan 18446744073709551616 %f v"), "1")
  assert_eq(t.eval("set v"), "1.844674407370955e+19")
  t.clear_cache()
  assert_eq(t.eval("format %.17g $v"), "1.8446744073709552e+19")
  assert_eq(t.eval_catch("error failed").code, 1)
  assert_eq(
    t.eval("format %.17g [expr {($v+0.0)*1.0}]"),
    "1.8446744073709552e+19",
  )
}

///|
test "same display text does not merge distinct numeric objects" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set text [format %s $v];list [expr {$v eq $text}] [expr {$v == $text}]",
    ),
    "1 0",
  )
  assert_eq(
    t.eval("list [format %.17g $v] [format %.17g $text]"),
    "1.8446744073709552e+19 1.844674407370955e+19",
  )
}

///|
test "copied nested collections keep independent mutations and numeric elements" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set a [list [list $v]];set b $a;lset b 0 0 0;format %.17g [lindex $a 0 0]",
    ),
    "1.8446744073709552e+19",
  )
  assert_eq(
    t.eval(
      "dict set d a b $v;set e $d;dict set e a b 0;format %.17g [dict get $d a b]",
    ),
    "1.8446744073709552e+19",
  )
  assert_eq(
    t.eval(
      "for {set i 0} {$i<3} {incr i} {lappend items $v};set copy $items;lappend items 0;list [llength $copy] [llength $items] [format %.17g [lindex $copy 2]]",
    ),
    "3 4 1.8446744073709552e+19",
  )
}

///|
test "completion values and custom options preserve internal numbers" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;catch [list error $v] x;format %.17g $x",
    ),
    "1.8446744073709552e+19",
  )
  assert_eq(
    t.eval("catch {return -foo $v ok} r o;format %.17g [dict get $o -foo]"),
    "1.8446744073709552e+19",
  )
  assert_eq(
    t.eval(
      "catch {try {return -foo $v bad} finally {error cleanup}} r o;format %.17g [dict get $o -during -foo]",
    ),
    "1.8446744073709552e+19",
  )
}

///|
test "type conversion affects shared values but copies isolate later writes" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set copy $v;string length $copy;format %.17g $v",
    ),
    "1.844674407370955e+19",
  )
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;set items [list $v];string length $items;list [format %.17g [lindex $items 0]] [format %.17g $v]",
    ),
    "1.844674407370955e+19 1.8446744073709552e+19",
  )
}

///|
test "typed script execution retains source argument and budget bounds" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("eval [list set destination [string repeat x 100000]]"))
      false
    } catch {
      _ => true
    },
  )
  assert_eq(t.eval("info exists destination"), "0")
  assert_true(
    try {
      ignore(t.eval("eval [linsert [lrepeat 4096 a] 0 list]"))
      false
    } catch {
      _ => true
    },
  )
  assert_true(
    try {
      ignore(t.eval("while 1 [list set x 1]", budget=20))
      false
    } catch {
      _ => true
    },
  )
  assert_eq(t.eval("scan -0.0 %f v;format %.1f $v"), "-0.0")
}
