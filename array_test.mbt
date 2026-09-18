///|
test "array cursors persist across evaluations and include the empty key" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("array set a {z 1 a 2 {} 3};set s [array startsearch a]"),
    "s-1-a",
  )
  t.clear_cache()
  assert_eq(t.eval("array anymore a $s"), "1")
  assert_eq(
    t.eval(
      "set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};lsort $out",
    ),
    "{} a z",
  )
  assert_eq(
    t.eval(
      "list [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    ),
    "0 {} {}",
  )
}

///|
test "array additions invalidate all cursors while replacements preserve them" {
  let t = @tcl.Interpreter::new()
  ignore(
    t.eval(
      "array set a {x 1};set s [array startsearch a];set other [array startsearch a];incr a(x)",
    ),
  )
  assert_eq(t.eval("list [array anymore a $s] [array anymore a $other]"), "1 1")
  ignore(t.eval("set a(y) 2"))
  assert_eq(
    t.eval_catch("array anymore a $s").result,
    "couldn't find search \"s-1-a\"",
  )
  assert_eq(t.eval_catch("array anymore a $other").code, 1)
  assert_eq(t.eval("array startsearch a"), "s-1-a")
}

///|
test "array search identity combines the shared array and supplied spelling" {
  let t = @tcl.Interpreter::new()
  ignore(t.eval("array set a {x 1};upvar #0 a b;array startsearch a"))
  assert_eq(
    t.eval_catch("array anymore b s-1-a").result,
    "search identifier \"s-1-a\" isn't for variable \"b\"",
  )
  assert_eq(t.eval("array nextelement b s-01-b"), "x")
  assert_eq(t.eval("array done b s-1-b;array startsearch a"), "s-1-a")
}

///|
test "array statistics count retained undefined entries and release procedure links" {
  let t = @tcl.Interpreter::new()
  ignore(t.eval("array set a {};upvar #0 a(x) b"))
  assert_eq(
    t.eval("list [array size a] [lindex [split [array statistics a] \\n] 0]"),
    "0 {1 entries in table, 4 buckets}",
  )
  ignore(t.eval("proc p {} {upvar #0 a(y) c};p"))
  assert_eq(
    t.eval("lindex [split [array statistics a] \\n] 0"),
    "1 entries in table, 4 buckets",
  )
  assert_eq(
    t.eval(
      "set s [array startsearch a];set b 2;list [array anymore a $s] [array nextelement a $s]",
    ),
    "1 x",
  )
}

///|
test "array deletion keeps old element aliases detached from replacement arrays" {
  let t = @tcl.Interpreter::new()
  ignore(t.eval("array set a {x 1};upvar #0 a(x) b;unset a;array set a {x 2}"))
  assert_eq(t.eval_catch("set b").result, "can't read \"b\": no such variable")
  assert_eq(
    t.eval_catch("set b 3").result,
    "can't set \"b\": upvar refers to element in deleted array",
  )
  assert_eq(t.eval("set a(x)"), "2")
}

///|
test "array hash expansion and deletion keep independent native ordering" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "array set a {};for {set i 0} {$i<12} {incr i} {set a($i) $i};array names a",
    ),
    "0 1 2 3 4 5 6 7 8 9 10 11",
  )
  assert_eq(
    t.eval("lindex [split [array statistics a] \\n] 0"),
    "12 entries in table, 16 buckets",
  )
  ignore(t.eval("array unset a *"))
  assert_eq(
    t.eval("lindex [split [array statistics a] \\n] 0"),
    "0 entries in table, 16 buckets",
  )
}

///|
test "array abbreviations and validation expose Tcl completion metadata" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("array se a {x 1};list [array si a] [array ex a] [array na a]"),
    "1 1 x",
  )
  assert_eq(
    t.eval("catch {array st a} r o;dict get $o -errorcode"),
    "TCL LOOKUP SUBCOMMAND st",
  )
  assert_eq(
    t.eval_catch("array any a").result,
    "wrong # args: should be \"array anymore arrayName searchId\"",
  )
  assert_eq(
    t.eval("catch {array set a {x}} r o;list $r [dict get $o -errorcode]"),
    "{list must have an even number of elements} {TCL ARGUMENT FORMAT}",
  )
}

///|
test "array isolated UTF16 keys avoid host panics" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set k \\ud800;array set a {};set a($k) 7;list [array size a] [set a($k)] [string length [lindex [array names a] 0]]",
    ),
    "1 7 1",
  )
}

///|
test "array capacity rejection preserves existing values and cursors" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "array set a {};for {set i 0} {$i<10000} {incr i} {set a($i) $i};set s [array startsearch a];catch {set a(extra) 1};list [array size a] [info exists a(extra)] [array anymore a $s] $a(9999)",
      budget=250000,
    ),
    "10000 0 1 9999",
  )
}
