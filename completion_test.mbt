///|
test "raw completion retains return levels while eval consumes one boundary" {
  let t = @tcl.Interpreter::new()
  let result = t.eval_catch("return -level 2 -code error -tag kept message")
  assert_eq(result.code, 2)
  assert_eq(result.result, "message")
  assert_eq(@tcl.parse_list(result.options), [
    "-tag", "kept", "-errorcode", "NONE", "-code", "1", "-level", "2",
  ])
  assert_eq(t.eval("return result"), "result")
  let custom = t.eval_catch("return -level 0 -code 9 custom")
  assert_eq(custom.code, 9)
  assert_eq(custom.result, "custom")
  assert_true(
    try {
      ignore(t.eval("return -level 0 -code 9 custom"))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "completion snapshots survive later errors and reset normal options" {
  let t = @tcl.Interpreter::new()
  let first = t.eval_catch("error first infoA CODE_A")
  let snapshot = first.options
  let second = t.eval_catch("error second infoB CODE_B")
  assert_eq(first.options, snapshot)
  assert_true(first.options.contains("CODE_A"))
  assert_true(second.options.contains("CODE_B"))
  assert_eq(t.eval("list $::errorInfo $::errorCode"), "infoB CODE_B")
  assert_eq(t.eval_catch("return -level 0 -tag kept value").code, 0)
  assert_eq(t.eval_catch("set x clean").options, "-code 0 -level 0")
}

///|
test "finally preserves side effects and associates overridden errors" {
  let t = @tcl.Interpreter::new()
  let result = t.eval_catch(
    "set cleaned 0;try {throw APP first} on error {} {throw HANDLER second} finally {set cleaned 1;throw FINAL third}",
  )
  assert_eq(result.code, 1)
  assert_eq(result.result, "third")
  assert_eq(t.eval("set cleaned"), "1")
  assert_true(result.options.contains("-during"))
  assert_true(result.options.contains("APP"))
  assert_true(result.options.contains("HANDLER"))
  assert_true(result.options.contains("FINAL"))
  assert_eq(
    t.eval(
      "proc p {} {try {return done} finally {set ::cleaned 2}};list [p] $cleaned",
    ),
    "done 2",
  )
}

///|
test "cached failure locations stay correct after cache clearing" {
  let t = @tcl.Interpreter::new()
  let source = "# comment\nset x 1\nerror bad"
  let first = t.eval_catch(source)
  let second = t.eval_catch(source)
  assert_eq(first.options, second.options)
  assert_true(second.options.contains("-errorline 3"))
  assert_true(t.cache_stats().script_hits > 0)
  t.clear_cache()
  assert_eq(t.eval_catch(source).options, first.options)
}

///|
test "caught budget exhaustion remains bounded and next call recovers" {
  let t = @tcl.Interpreter::new()
  let result = t.eval_catch("while {1} {catch {while {1} {}}}", budget=60)
  assert_eq(result.code, 1)
  assert_eq(result.result, "execution budget")
  assert_eq(
    t.eval("try {expr {1/0}} trap {ARITH DIVZERO} {} {set recovered yes}"),
    "yes",
  )
}

///|
test "raw completion keeps preceding output and checks API budget" {
  let t = @tcl.Interpreter::new()
  let result = t.eval_catch("puts before;throw APP bad")
  assert_eq(result.code, 1)
  assert_eq(t.output_text(), "before\n")
  t.clear_output()
  for budget in [0, -1, 1000001] {
    assert_true(
      try {
        ignore(t.eval_catch("set touched yes", budget~))
        false
      } catch {
        _ => true
      },
    )
  }
  assert_eq(t.eval("info exists touched"), "0")
  assert_eq(t.output_text(), "")
}

///|
test "portable generated stack records command and procedure without growing across calls" {
  let t = @tcl.Interpreter::new()
  ignore(t.eval("proc p {} {error bad}"))
  let first = t.eval_catch("p")
  assert_true(first.options.contains("INNER"))
  assert_true(first.options.contains("CALL"))
  assert_eq(t.eval_catch("p").options, first.options)
  assert_eq(t.eval("info errorstack"), "INNER {error bad} CALL p")
}
