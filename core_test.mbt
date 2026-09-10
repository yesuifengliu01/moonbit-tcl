///|
test "variable and nested substitution" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("set x 3; set y [expr {$x * (2 + 4)}]; set y"), "18")
}

///|
test "braces defer substitutions" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("set x 7; set literal {$x}; set literal"), "$x")
}

///|
test "loop and output" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set n 0; set i 0; while {$i < 10} {incr n $i; incr i}; puts \"sum=$n\"; set n",
    ),
    "45",
  )
  assert_eq(t.printed(), "sum=45")
}

///|
test "if else lazy body" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("if {0} {missing} else {set x good}"), "good")
}

///|
test "comments and escaped separators" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("# comment\nset x hello\\ world; set x"), "hello world")
}

///|
test "budget stops empty infinite loop" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("while {1} {}", budget=20))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "syntax unknown command and undefined variable" {
  for
    s in [
      "set x {unclosed", "set x \"missing", "set x $missing", "exec whoami", "expr {1/0}",
      "set x {a}b",
    ] {
    let t = @tcl.Interpreter::new()
    assert_true(
      try {
        ignore(t.eval(s))
        false
      } catch {
        _ => true
      },
    )
  }
}

///|
test "expression precedence comparisons" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2 + 3 * 4 == 14}"), "1")
  assert_eq(t.eval("expr {-7 + 2}"), "-5")
}
