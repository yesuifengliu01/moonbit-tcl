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
