///|
test "completeness distinguishes incomplete syntax from complete invalid commands" {
  for source in ["list [", "list \"open", "list $a(", "list \\" + "\n"] {
    assert_false(@tcl.is_complete(source))
  }
  for source in ["", "# ignored [", "list {a}b [", "list a{", "list $"] {
    assert_true(@tcl.is_complete(source))
  }
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete {[set touched yes]}"), "1")
  assert_eq(t.eval("info exists touched"), "0")
}

///|
test "substitution errors preserve earlier side effects across cached calls" {
  let t = @tcl.Interpreter::new()
  ignore(t.eval("set x 0"))
  let source = "subst " + @tcl.format_list(["[incr x]$" + "{unclosed"])
  assert_eq(t.eval_catch(source).code, 1)
  assert_eq(t.eval("set x"), "1")
  assert_eq(t.eval_catch(source).code, 1)
  assert_eq(t.eval("set x"), "2")
  t.clear_cache()
  assert_eq(t.eval_catch(source).code, 1)
  assert_eq(t.eval("set x"), "3")
  assert_eq(
    t.eval("subst " + @tcl.format_list(["kept[break]$" + "{unclosed"])),
    "kept",
  )
}

///|
test "substitution catches entire array variable exceptions and clears return options" {
  let t = @tcl.Interpreter::new()
  let result = t.eval_catch(
    "subst {before$a([return -level 0 -code 9 -tag custom VALUE])after}",
  )
  assert_eq(result.code, 0)
  assert_eq(result.result, "beforeVALUEafter")
  assert_eq(result.options, "-code 0 -level 0")
  assert_eq(t.eval("set x 0;subst -novariables {$x [incr x]}"), "$x 1")
  assert_eq(
    t.eval("array set a {1 VALUE};subst -nocommands {[incr x] $a([set x 1])}"),
    "[incr x] VALUE",
  )
}

///|
test "substitution command budgeting stops work and supports later recovery" {
  let t = @tcl.Interpreter::new()
  ignore(t.eval("set x 0;set template [string repeat {[incr x]} 100]"))
  assert_eq(t.eval_catch("subst $template", budget=40).code, 1)
  assert_eq(t.eval("expr {$x > 0 && $x < 100}"), "1")
  assert_eq(t.eval("subst {still [list usable]}"), "still usable")
}

///|
test "substitution output and completeness nesting stay bounded" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval_catch("set x [string repeat a 600000];subst {$x$x}").code, 1)
  assert_eq(t.eval("string length $x"), "600000")
  let nested = String::from_array(Array::make(80, '[')) +
    String::from_array(Array::make(80, ']'))
  assert_true(
    try {
      ignore(@tcl.is_complete(nested))
      false
    } catch {
      _ => true
    },
  )
  assert_eq(t.eval("subst {recovered}"), "recovered")
}

///|
test "multiline fragments can be checked without executing before completion" {
  let first = "set total 0\nforeach n {1 2 3} {\n"
  let second = first + "incr total $n\n"
  assert_false(@tcl.is_complete(first))
  assert_false(@tcl.is_complete(second))
  let complete = second + "}\nset total"
  assert_true(@tcl.is_complete(complete))
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval(complete), "6")
}
