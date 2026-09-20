///|
test "filesystem source shares caller scope and restores script identity" {
  let t = @tcl.Interpreter::new()
  t.set_io((command, args) => {
    if command == "source" && args == ["part.tcl"] {
      Ok("set x 7; set script [info script]; return done")
    } else {
      Err("missing file")
    }
  })
  assert_eq(
    t.eval(
      "proc p {} {set x 1; set result [source part.tcl]; list $result $x $script}; p",
    ),
    "done 7 part.tcl",
  )
  assert_eq(t.eval("info script"), "")
  assert_eq(t.eval("catch {source missing}; set after 9"), "9")
}

///|
test "filesystem host line end state is distinct from empty line" {
  let t = @tcl.Interpreter::new()
  let replies = ["0", "0中文", "1"]
  let at = Ref(0)
  t.set_io((command, _) => {
    if command != "gets" {
      Err("unsupported")
    } else {
      let value = replies[at.val]
      at.val += 1
      Ok(value)
    }
  })
  assert_eq(
    t.eval(
      "set a [gets file1 x]; set b [gets file1 y]; set c [gets file1 z]; list $a $x $b $y $c $z",
    ),
    "0 {} 2 中文 -1 {}",
  )
}

///|
test "filesystem package loading is global and only happens once" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set count 0; package ifneeded demo 1.2 {incr count; package provide demo 1.2}; proc p {} {package require demo 1.0}; list [p] [p] $count",
    ),
    "1.2 1.2 1",
  )
  assert_eq(
    t.eval(
      "list [package vcompare 1.2 1.2.0] [catch {package require -exact demo 1.0}]",
    ),
    "0 1",
  )
}
