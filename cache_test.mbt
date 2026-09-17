///|
test "clearing parsed code retains variables and procedures" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("set x 1; proc p {} {global x; incr x}; p"), "2")
  assert_eq(t.eval("p"), "3")
  assert_true(t.cache_stats().script_hits > 0)
  t.clear_cache()
  assert_eq(t.cache_stats().scripts, 0)
  assert_eq(t.cache_stats().expressions, 0)
  assert_eq(t.eval("p"), "4")
}

///|
test "cache hits retain execution budget accounting" {
  let t = @tcl.Interpreter::new()
  let source = "set x 0; while {1} {incr x}"
  assert_true(
    try {
      ignore(t.eval(source, budget=60))
      false
    } catch {
      _ => true
    },
  )
  let first = t.eval("set x")
  assert_true(
    try {
      ignore(t.eval(source, budget=60))
      false
    } catch {
      _ => true
    },
  )
  assert_eq(t.eval("set x"), first)
}

///|
test "dynamic source eviction stays bounded and keeps state" {
  let t = @tcl.Interpreter::new()
  for i in 0..<600 {
    assert_eq(t.eval("set n " + i.to_string()), i.to_string())
    ignore(t.eval("expr {" + i.to_string() + " + 1}"))
  }
  assert_true(t.cache_stats().scripts <= 256)
  assert_true(t.cache_stats().expressions <= 256)
  assert_true(t.cache_stats().source_units <= 393216)
  assert_eq(t.eval("set n"), "599")
}

///|
test "lazy collection limits reject without losing previous value" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("set x {}; foreach i {1 2} {lappend x $i}; set x"), "1 2")
  assert_true(
    try {
      ignore(t.eval("lappend x [string repeat z 1000000]"))
      false
    } catch {
      _ => true
    },
  )
  assert_eq(t.eval("set x"), "1 2")
  assert_eq(t.eval("dict set d a 1"), "a 1")
  assert_true(
    try {
      ignore(t.eval("dict set d b [string repeat z 1000000]"))
      false
    } catch {
      _ => true
    },
  )
  assert_eq(t.eval("set d"), "a 1")
}
