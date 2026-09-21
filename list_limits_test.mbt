///|
test "list format preserves NUL and BEL controls" {
  let leading = ["\u0000", "\u0007", "after"]
  assert_eq(@tcl.format_list(leading), "\u0000 \u0007 after")
  assert_eq(@tcl.parse_list("\u0000 \u0007 after"), leading)

  let middle = ["before", "\u0000", "\u0007", "after"]
  assert_eq(@tcl.format_list(middle), "before \u0000 \u0007 after")
  assert_eq(@tcl.parse_list("before \u0000 \u0007 after"), middle)

  let trailing = ["before", "\u0007", "\u0000"]
  assert_eq(@tcl.format_list(trailing), "before \u0007 \u0000")
  assert_eq(@tcl.parse_list("before \u0007 \u0000"), trailing)
  // Controls inside an element must not truncate its suffix or later items.
  for
    value in [
      "\u0000abc", "a\u0000bc", "abc\u0000", "\u0007abc", "a\u0007bc", "abc\u0007",
    ] {
    assert_eq(@tcl.format_list([value, "after"]), value + " after")
    assert_eq(@tcl.parse_list(value + " after"), [value, "after"])
  }
}

///|
test "large list element and bounded list growth" {
  let text = Array::make(100000, "汉").join("")
  assert_eq(@tcl.parse_list("{" + text + "}"), [text])
  assert_eq(@tcl.parse_list(@tcl.format_list([text, "a b"])), [text, "a b"])
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("lrepeat 100001 a"))
      false
    } catch {
      _ => true
    },
  )
  assert_true(
    try {
      ignore(t.eval("foreach x [lrepeat 100 a] {}", budget=20))
      false
    } catch {
      _ => true
    },
  )
  assert_true(
    try {
      ignore(t.eval("for {} {1} {} {}", budget=20))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "list construction does not evaluate metacharacters" {
  let data = [
    "[error injected]", "$missing", "a; error injected", "{unbalanced", "\\",
  ]
  assert_eq(@tcl.parse_list(@tcl.format_list(data)), data)
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("set x [list {[error injected]} {$missing}]; lindex $x 0"),
    "[error injected]",
  )
}

///|
test "exact list limit and bounded expansion and shared output" {
  let text = "x".repeat(1000000)
  assert_eq(@tcl.format_list([text]), text)
  assert_true(
    try {
      ignore(@tcl.format_list([text, "y"]))
      false
    } catch {
      _ => true
    },
  )
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x [lrepeat 60000 abcdefghij]; proc output {} {puts [lrepeat 60000 abcdefghij]}; puts $x; catch {output}",
    ),
    "1",
  )
  assert_true(t.printed().length() < 1000000)
  assert_eq(t.eval("catch {set x \"$x$x\"}"), "1")
}
