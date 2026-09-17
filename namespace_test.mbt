///|
test "persistent cached scripts resolve imported command identity after replacement" {
  let t = @tcl.Interpreter::new()
  ignore(
    t.eval(
      "namespace eval a {namespace export p;proc p {} {return old}};namespace import a::*",
    ),
  )
  assert_eq(t.eval("p"), "old")
  ignore(t.eval("rename a::p a::q;proc a::q {} {return new}"))
  assert_eq(t.eval("p"), "new")
  t.clear_cache()
  assert_eq(t.eval("namespace origin p"), "::a::q")
  ignore(t.eval("rename a::q {}"))
  assert_eq(t.eval("list [catch {p}] [namespace import]"), "1 {}")
}

///|
test "import cycles fail without corrupting existing command graph" {
  let t = @tcl.Interpreter::new()
  ignore(
    t.eval(
      "namespace eval a {namespace export p;proc p {} {return original}};namespace eval b {namespace import ::a::*;namespace export p}",
    ),
  )
  assert_eq(
    t.eval("catch {namespace eval a {namespace import -force ::b::*}}"),
    "1",
  )
  assert_eq(
    t.eval("list [a::p] [b::p] [namespace origin b::p]"),
    "original original ::a::p",
  )
}

///|
test "ensemble and unknown recursion stops at resource boundary" {
  let t = @tcl.Interpreter::new()
  ignore(
    t.eval(
      "namespace eval a {namespace ensemble create -map {loop {::a loop}}}",
    ),
  )
  assert_true(
    try {
      ignore(t.eval("a loop", budget=500))
      false
    } catch {
      _ => true
    },
  )
  ignore(t.eval("namespace eval n {namespace unknown missing_handler}"))
  assert_true(
    try {
      ignore(t.eval("namespace eval n {missing}", budget=500))
      false
    } catch {
      _ => true
    },
  )
  assert_eq(t.eval("list still usable"), "still usable")
}

///|
test "command count overflow preserves definitions and supports recovery" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(
        t.eval(
          "for {set i 0} {$i<11000} {incr i} {proc p$i {} {return kept}}",
          budget=1000000,
        ),
      )
      false
    } catch {
      _ => true
    },
  )
  assert_eq(t.eval("p0"), "kept")
  ignore(t.eval("rename p0 {};proc replacement {} {return recovered}"))
  assert_eq(t.eval("replacement"), "recovered")
}

///|
test "ensemble configuration failure leaves previous dispatch intact" {
  let t = @tcl.Interpreter::new()
  ignore(
    t.eval(
      "namespace eval a {namespace ensemble create -map {go {::list fixed}}}",
    ),
  )
  assert_eq(
    t.eval("catch {namespace ensemble configure a -prefixes 0 -map {go {}}}"),
    "1",
  )
  assert_eq(
    t.eval("a g {two words} {$unexpanded} {[error no]}"),
    "fixed {two words} {$unexpanded} {[error no]}",
  )
  assert_eq(t.eval("namespace ensemble configure a -prefixes"), "1")
}
