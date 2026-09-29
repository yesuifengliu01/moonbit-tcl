///|
test "alternative package requirements match any compatible released major" {
  let t = @tcl.Interpreter::new()
  ignore(t.eval("package provide Tcl 8.6"))
  assert_eq(t.eval("package require Tcl 8.5 9"), "8.6")
  assert_eq(t.eval("package present Tcl 9 8.5"), "8.6")
  assert_eq(t.eval("catch {package require Tcl 7 9}"), "1")
  assert_eq(t.eval("catch {package require Tcl 8.5 bad}"), "1")
  assert_eq(t.eval("catch {package require -exact Tcl 8.6 9}"), "1")
}

///|
test "package loading chooses highest alternative and does not reload" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set hits 0; package ifneeded demo 1.8 {incr hits; package provide demo 1.8}; package ifneeded demo 2.3 {incr hits; package provide demo 2.3}; list [package require demo 1.0 2.0] [package present demo 1.0 2.0] [package require demo 2.1] $hits",
    ),
    "2.3 2.3 2.3 1",
  )
  assert_eq(t.eval("catch {package present demo 1.0}"), "1")
}
