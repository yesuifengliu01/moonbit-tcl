///|
test "regexp global captures persist through cache clearing and failed searches" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("regexp -all -indices {(a)(b?)} ab a b c;list $a $b $c"),
    "{0 1} {0 0} {1 1}",
  )
  t.clear_cache()
  assert_eq(t.eval("regexp z abc a b;list $a $b $c"), "{0 1} {0 0} {1 1}")
  assert_eq(
    t.eval("regexp -all -inline -indices {(a)(b?)} aba"),
    "{0 1} {0 0} {1 1} {2 2} {2 2} {3 2}",
  )
}

///|
test "regexp options remain strict through dynamic and renamed dispatch" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("regexp -nocase a A"), "1")
  assert_eq(t.eval_catch("set opt -no;regexp $opt a A").code, 1)
  assert_eq(t.eval_catch("set cmd regexp;$cmd -no a A").code, 1)
  assert_eq(t.eval("rename regexp search;search -nocase a A"), "1")
}

///|
test "regexp start and empty iteration preserve inclusive index conventions" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("regexp -all -inline -indices {} abc"), "{0 -1} {1 0} {2 1}")
  assert_eq(t.eval("regexp -start end -inline -indices {} abc"), "{3 2}")
  assert_eq(t.eval("regexp -start 100 -inline -indices {} abc"), "{100 99}")
  assert_eq(
    t.eval("regexp -start -4294967295 -inline -indices {} abc"),
    "{1 0}",
  )
  // Native Tcl returns once even at the largest signed index; adding one
  // before the termination test would wrap negative on both local backends.
  for pattern in ["{}", "{a*}", "{$}"] {
    assert_eq(
      t.eval(
        "regexp -all -start 2147483647 -inline -indices " + pattern + " abc",
      ),
      "{2147483647 2147483646}",
    )
  }
  assert_eq(
    t.eval("regexp -all -start 2147483646 -inline -indices {} abc"),
    "{2147483646 2147483645}",
  )
}

///|
test "regsub empty literal optimization and general replacement have distinct end behavior" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("regsub -all {} abc X"), "XaXbXc")
  assert_eq(t.eval("regsub -all {()} abc X"), "XaXbXcX")
  assert_eq(
    t.eval("regsub -all {(a)(b?)} aba {<\\2:&:\\1:foo\\n>} out;set out"),
    "<b:ab:a:foo\\n><:a:a:foo\\n>",
  )
  assert_eq(t.eval("regsub -all -expanded {a b} {a b} X"), "X")
}

///|
test "regexp writes captures in order and regsub preserves output variables on failure" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("set scalar 0;set match OLD;set tail OLD"), "OLD")
  assert_eq(t.eval_catch("regexp {(a)} a match scalar(x) tail").code, 1)
  assert_eq(t.eval("list $match $scalar $tail"), "a 0 OLD")
  assert_eq(t.eval_catch("regsub {(} abc X tail").code, 1)
  assert_eq(t.eval("set tail"), "OLD")
  assert_eq(
    t.eval(
      "proc f name {upvar 1 $name v;regsub -all a aba X v};f tail;set tail",
    ),
    "XbX",
  )
}

///|
test "regexp compile failures preserve numeric values while successful conversion shimmers" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;catch {regexp {(} $v};format %.17g $v",
    ),
    "1.8446744073709552e+19",
  )
  assert_eq(t.eval("regexp .* $v;format %.17g $v"), "1.844674407370955e+19")
  assert_eq(
    t.eval("scan 18446744073709551616 %f v;regsub -all {} $v X;format %.17g $v"),
    "1.844674407370955e+19",
  )
}

///|
test "regex metadata analysis and replacement honor budgets and recover" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("set kept safe;set p [string repeat {[[:digit:]]} 200]"),
    "[[:digit:]]".repeat(200),
  )
  assert_true(
    try {
      ignore(t.eval("regexp -about $p", budget=100))
      false
    } catch {
      _ => true
    },
  )
  assert_eq(
    t.eval(
      "set s [string repeat a 2000];set p [string repeat a 1000];append p b;set out kept",
    ),
    "kept",
  )
  assert_true(
    try {
      ignore(t.eval("regsub -all $p $s X out", budget=100))
      false
    } catch {
      _ => true
    },
  )
  assert_eq(
    t.eval("list $out $kept [regexp -inline {(a)} abc]"),
    "kept safe {a a}",
  )
}

///|
test "regex metadata shares deep quantified analysis and replacement caps output" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set p a;for {set i 0} {$i<48} {incr i} {set p (?:$p)+};regexp -about $p",
    ),
    "0 REG_UNONPOSIX",
  )
  assert_eq(
    t.eval("set out OLD;set large [string repeat x 600000];list ready"),
    "ready",
  )
  assert_eq(t.eval_catch("regsub -all a aa $large out").code, 1)
  assert_eq(t.eval("list $out [regsub a abc X]"), "OLD Xbc")
}
