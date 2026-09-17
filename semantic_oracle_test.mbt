// Original programs, expected results evaluated by Tcl 8.6.15. Do not hand-edit.

///|
test "Tcl semantic numeric-0-+-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 + 2}", budget=100000), "2")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-0---2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 - 2}", budget=100000), "-2")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-0-*-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 * 2}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-0-/-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 / 2}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-0-%-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 % 2}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-0-==-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 == 2}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-0-!=-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 != 2}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-0-<-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 < 2}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-0->=-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 >= 2}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-0-&-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 & 2}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-0-|-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 | 2}", budget=100000), "2")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-0-^-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 ^ 2}", budget=100000), "2")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-0-+--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 + -3}", budget=100000), "-3")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-0----3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 - -3}", budget=100000), "3")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-0-*--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 * -3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-0-/--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 / -3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-0-%--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 % -3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-0-==--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 == -3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-0-!=--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 != -3}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-0-<--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 < -3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-0->=--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 >= -3}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-0-&--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 & -3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-0-|--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 | -3}", budget=100000), "-3")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-0-^--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 ^ -3}", budget=100000), "-3")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-0-+-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 + 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-0---0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 - 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-0-*-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 * 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-0-/-0" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {0 / 0}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-0-%-0" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {0 % 0}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-0-==-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 == 0}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-0-!=-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 != 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-0-<-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 < 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-0->=-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 >= 0}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-0-&-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 & 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-0-|-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 | 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-0-^-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 ^ 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-0-+-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 + 0.5}", budget=100000), "0.5")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-0---0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 - 0.5}", budget=100000), "-0.5")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-0-*-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 * 0.5}", budget=100000), "0.0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-0-/-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 / 0.5}", budget=100000), "0.0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-0-%-0.5" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {0 % 0.5}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-0-==-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 == 0.5}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-0-!=-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 != 0.5}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-0-<-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 < 0.5}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-0->=-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 >= 0.5}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-0-&-0.5" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {0 & 0.5}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-0-|-0.5" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {0 | 0.5}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-0-^-0.5" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {0 ^ 0.5}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-1-+-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 + 2}", budget=100000), "3")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-1---2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 - 2}", budget=100000), "-1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-1-*-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 * 2}", budget=100000), "2")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-1-/-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 / 2}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-1-%-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 % 2}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-1-==-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 == 2}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-1-!=-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 != 2}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-1-<-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 < 2}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-1->=-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 >= 2}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-1-&-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 & 2}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-1-|-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 | 2}", budget=100000), "3")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-1-^-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 ^ 2}", budget=100000), "3")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-1-+--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 + -3}", budget=100000), "-2")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-1----3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 - -3}", budget=100000), "4")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-1-*--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 * -3}", budget=100000), "-3")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-1-/--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 / -3}", budget=100000), "-1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-1-%--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 % -3}", budget=100000), "-2")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-1-==--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 == -3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-1-!=--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 != -3}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-1-<--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 < -3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-1->=--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 >= -3}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-1-&--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 & -3}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-1-|--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 | -3}", budget=100000), "-3")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-1-^--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 ^ -3}", budget=100000), "-4")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-1-+-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 + 0}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-1---0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 - 0}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-1-*-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 * 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-1-/-0" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {1 / 0}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-1-%-0" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {1 % 0}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-1-==-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 == 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-1-!=-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 != 0}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-1-<-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 < 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-1->=-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 >= 0}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-1-&-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 & 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-1-|-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 | 0}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-1-^-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 ^ 0}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-1-+-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 + 0.5}", budget=100000), "1.5")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-1---0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 - 0.5}", budget=100000), "0.5")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-1-*-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 * 0.5}", budget=100000), "0.5")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-1-/-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 / 0.5}", budget=100000), "2.0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-1-%-0.5" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {1 % 0.5}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-1-==-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 == 0.5}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-1-!=-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 != 0.5}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-1-<-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 < 0.5}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-1->=-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 >= 0.5}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-1-&-0.5" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {1 & 0.5}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-1-|-0.5" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {1 | 0.5}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-1-^-0.5" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {1 ^ 0.5}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric--3-+-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-3 + 2}", budget=100000), "-1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric--3---2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-3 - 2}", budget=100000), "-5")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric--3-*-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-3 * 2}", budget=100000), "-6")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric--3-/-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-3 / 2}", budget=100000), "-2")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric--3-%-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-3 % 2}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric--3-==-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-3 == 2}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric--3-!=-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-3 != 2}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric--3-<-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-3 < 2}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric--3->=-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-3 >= 2}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric--3-&-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-3 & 2}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric--3-|-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-3 | 2}", budget=100000), "-1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric--3-^-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-3 ^ 2}", budget=100000), "-1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric--3-+--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-3 + -3}", budget=100000), "-6")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric--3----3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-3 - -3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric--3-*--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-3 * -3}", budget=100000), "9")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric--3-/--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-3 / -3}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric--3-%--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-3 % -3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric--3-==--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-3 == -3}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric--3-!=--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-3 != -3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric--3-<--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-3 < -3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric--3->=--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-3 >= -3}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric--3-&--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-3 & -3}", budget=100000), "-3")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric--3-|--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-3 | -3}", budget=100000), "-3")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric--3-^--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-3 ^ -3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric--3-+-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-3 + 0}", budget=100000), "-3")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric--3---0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-3 - 0}", budget=100000), "-3")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric--3-*-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-3 * 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric--3-/-0" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {-3 / 0}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric--3-%-0" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {-3 % 0}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric--3-==-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-3 == 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric--3-!=-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-3 != 0}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric--3-<-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-3 < 0}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric--3->=-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-3 >= 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric--3-&-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-3 & 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric--3-|-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-3 | 0}", budget=100000), "-3")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric--3-^-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-3 ^ 0}", budget=100000), "-3")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric--3-+-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-3 + 0.5}", budget=100000), "-2.5")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric--3---0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-3 - 0.5}", budget=100000), "-3.5")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric--3-*-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-3 * 0.5}", budget=100000), "-1.5")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric--3-/-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-3 / 0.5}", budget=100000), "-6.0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric--3-%-0.5" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {-3 % 0.5}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric--3-==-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-3 == 0.5}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric--3-!=-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-3 != 0.5}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric--3-<-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-3 < 0.5}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric--3->=-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-3 >= 0.5}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric--3-&-0.5" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {-3 & 0.5}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric--3-|-0.5" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {-3 | 0.5}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric--3-^-0.5" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {-3 ^ 0.5}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-2147483647-+-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 + 2}", budget=100000), "2147483649")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2147483647---2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 - 2}", budget=100000), "2147483645")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2147483647-*-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 * 2}", budget=100000), "4294967294")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2147483647-/-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 / 2}", budget=100000), "1073741823")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2147483647-%-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 % 2}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2147483647-==-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 == 2}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2147483647-!=-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 != 2}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2147483647-<-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 < 2}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2147483647->=-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 >= 2}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2147483647-&-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 & 2}", budget=100000), "2")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2147483647-|-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 | 2}", budget=100000), "2147483647")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2147483647-^-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 ^ 2}", budget=100000), "2147483645")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2147483647-+--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 + -3}", budget=100000), "2147483644")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2147483647----3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 - -3}", budget=100000), "2147483650")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2147483647-*--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 * -3}", budget=100000), "-6442450941")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2147483647-/--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 / -3}", budget=100000), "-715827883")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2147483647-%--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 % -3}", budget=100000), "-2")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2147483647-==--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 == -3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2147483647-!=--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 != -3}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2147483647-<--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 < -3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2147483647->=--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 >= -3}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2147483647-&--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 & -3}", budget=100000), "2147483645")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2147483647-|--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 | -3}", budget=100000), "-1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2147483647-^--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 ^ -3}", budget=100000), "-2147483646")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2147483647-+-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 + 0}", budget=100000), "2147483647")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2147483647---0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 - 0}", budget=100000), "2147483647")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2147483647-*-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 * 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2147483647-/-0" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {2147483647 / 0}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-2147483647-%-0" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {2147483647 % 0}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-2147483647-==-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 == 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2147483647-!=-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 != 0}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2147483647-<-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 < 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2147483647->=-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 >= 0}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2147483647-&-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 & 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2147483647-|-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 | 0}", budget=100000), "2147483647")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2147483647-^-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 ^ 0}", budget=100000), "2147483647")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2147483647-+-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 + 0.5}", budget=100000), "2147483647.5")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2147483647---0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 - 0.5}", budget=100000), "2147483646.5")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2147483647-*-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 * 0.5}", budget=100000), "1073741823.5")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2147483647-/-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 / 0.5}", budget=100000), "4294967294.0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2147483647-%-0.5" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {2147483647 % 0.5}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-2147483647-==-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 == 0.5}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2147483647-!=-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 != 0.5}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2147483647-<-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 < 0.5}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2147483647->=-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2147483647 >= 0.5}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2147483647-&-0.5" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {2147483647 & 0.5}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-2147483647-|-0.5" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {2147483647 | 0.5}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-2147483647-^-0.5" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {2147483647 ^ 0.5}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-9007199254740993-+-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {9007199254740993 + 2}", budget=100000),
    "9007199254740995",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-9007199254740993---2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {9007199254740993 - 2}", budget=100000),
    "9007199254740991",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-9007199254740993-*-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {9007199254740993 * 2}", budget=100000),
    "18014398509481986",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-9007199254740993-/-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {9007199254740993 / 2}", budget=100000),
    "4503599627370496",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-9007199254740993-%-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {9007199254740993 % 2}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-9007199254740993-==-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {9007199254740993 == 2}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-9007199254740993-!=-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {9007199254740993 != 2}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-9007199254740993-<-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {9007199254740993 < 2}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-9007199254740993->=-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {9007199254740993 >= 2}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-9007199254740993-&-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {9007199254740993 & 2}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-9007199254740993-|-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {9007199254740993 | 2}", budget=100000),
    "9007199254740995",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-9007199254740993-^-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {9007199254740993 ^ 2}", budget=100000),
    "9007199254740995",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-9007199254740993-+--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {9007199254740993 + -3}", budget=100000),
    "9007199254740990",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-9007199254740993----3" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {9007199254740993 - -3}", budget=100000),
    "9007199254740996",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-9007199254740993-*--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {9007199254740993 * -3}", budget=100000),
    "-27021597764222979",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-9007199254740993-/--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {9007199254740993 / -3}", budget=100000),
    "-3002399751580331",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-9007199254740993-%--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {9007199254740993 % -3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-9007199254740993-==--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {9007199254740993 == -3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-9007199254740993-!=--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {9007199254740993 != -3}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-9007199254740993-<--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {9007199254740993 < -3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-9007199254740993->=--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {9007199254740993 >= -3}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-9007199254740993-&--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {9007199254740993 & -3}", budget=100000),
    "9007199254740993",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-9007199254740993-|--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {9007199254740993 | -3}", budget=100000), "-3")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-9007199254740993-^--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {9007199254740993 ^ -3}", budget=100000),
    "-9007199254740996",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-9007199254740993-+-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {9007199254740993 + 0}", budget=100000),
    "9007199254740993",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-9007199254740993---0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {9007199254740993 - 0}", budget=100000),
    "9007199254740993",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-9007199254740993-*-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {9007199254740993 * 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-9007199254740993-/-0" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {9007199254740993 / 0}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-9007199254740993-%-0" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {9007199254740993 % 0}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-9007199254740993-==-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {9007199254740993 == 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-9007199254740993-!=-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {9007199254740993 != 0}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-9007199254740993-<-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {9007199254740993 < 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-9007199254740993->=-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {9007199254740993 >= 0}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-9007199254740993-&-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {9007199254740993 & 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-9007199254740993-|-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {9007199254740993 | 0}", budget=100000),
    "9007199254740993",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-9007199254740993-^-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {9007199254740993 ^ 0}", budget=100000),
    "9007199254740993",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-9007199254740993-+-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {9007199254740993 + 0.5}", budget=100000),
    "9007199254740992.0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-9007199254740993---0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {9007199254740993 - 0.5}", budget=100000),
    "9007199254740992.0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-9007199254740993-*-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {9007199254740993 * 0.5}", budget=100000),
    "4503599627370496.0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-9007199254740993-/-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {9007199254740993 / 0.5}", budget=100000),
    "18014398509481984.0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-9007199254740993-%-0.5" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {9007199254740993 % 0.5}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-9007199254740993-==-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {9007199254740993 == 0.5}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-9007199254740993-!=-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {9007199254740993 != 0.5}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-9007199254740993-<-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {9007199254740993 < 0.5}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-9007199254740993->=-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {9007199254740993 >= 0.5}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-9007199254740993-&-0.5" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {9007199254740993 & 0.5}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-9007199254740993-|-0.5" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {9007199254740993 | 0.5}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-9007199254740993-^-0.5" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {9007199254740993 ^ 0.5}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-123456789012345678901234567890-+-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {123456789012345678901234567890 + 2}", budget=100000),
    "123456789012345678901234567892",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-123456789012345678901234567890---2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {123456789012345678901234567890 - 2}", budget=100000),
    "123456789012345678901234567888",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-123456789012345678901234567890-*-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {123456789012345678901234567890 * 2}", budget=100000),
    "246913578024691357802469135780",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-123456789012345678901234567890-/-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {123456789012345678901234567890 / 2}", budget=100000),
    "61728394506172839450617283945",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-123456789012345678901234567890-%-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {123456789012345678901234567890 % 2}", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-123456789012345678901234567890-==-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {123456789012345678901234567890 == 2}", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-123456789012345678901234567890-!=-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {123456789012345678901234567890 != 2}", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-123456789012345678901234567890-<-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {123456789012345678901234567890 < 2}", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-123456789012345678901234567890->=-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {123456789012345678901234567890 >= 2}", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-123456789012345678901234567890-&-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {123456789012345678901234567890 & 2}", budget=100000),
    "2",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-123456789012345678901234567890-|-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {123456789012345678901234567890 | 2}", budget=100000),
    "123456789012345678901234567890",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-123456789012345678901234567890-^-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {123456789012345678901234567890 ^ 2}", budget=100000),
    "123456789012345678901234567888",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-123456789012345678901234567890-+--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {123456789012345678901234567890 + -3}", budget=100000),
    "123456789012345678901234567887",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-123456789012345678901234567890----3" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {123456789012345678901234567890 - -3}", budget=100000),
    "123456789012345678901234567893",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-123456789012345678901234567890-*--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {123456789012345678901234567890 * -3}", budget=100000),
    "-370370367037037036703703703670",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-123456789012345678901234567890-/--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {123456789012345678901234567890 / -3}", budget=100000),
    "-41152263004115226300411522630",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-123456789012345678901234567890-%--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {123456789012345678901234567890 % -3}", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-123456789012345678901234567890-==--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {123456789012345678901234567890 == -3}", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-123456789012345678901234567890-!=--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {123456789012345678901234567890 != -3}", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-123456789012345678901234567890-<--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {123456789012345678901234567890 < -3}", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-123456789012345678901234567890->=--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {123456789012345678901234567890 >= -3}", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-123456789012345678901234567890-&--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {123456789012345678901234567890 & -3}", budget=100000),
    "123456789012345678901234567888",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-123456789012345678901234567890-|--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {123456789012345678901234567890 | -3}", budget=100000),
    "-1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-123456789012345678901234567890-^--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {123456789012345678901234567890 ^ -3}", budget=100000),
    "-123456789012345678901234567889",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-123456789012345678901234567890-+-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {123456789012345678901234567890 + 0}", budget=100000),
    "123456789012345678901234567890",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-123456789012345678901234567890---0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {123456789012345678901234567890 - 0}", budget=100000),
    "123456789012345678901234567890",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-123456789012345678901234567890-*-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {123456789012345678901234567890 * 0}", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-123456789012345678901234567890-/-0" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {123456789012345678901234567890 / 0}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-123456789012345678901234567890-%-0" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {123456789012345678901234567890 % 0}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-123456789012345678901234567890-==-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {123456789012345678901234567890 == 0}", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-123456789012345678901234567890-!=-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {123456789012345678901234567890 != 0}", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-123456789012345678901234567890-<-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {123456789012345678901234567890 < 0}", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-123456789012345678901234567890->=-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {123456789012345678901234567890 >= 0}", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-123456789012345678901234567890-&-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {123456789012345678901234567890 & 0}", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-123456789012345678901234567890-|-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {123456789012345678901234567890 | 0}", budget=100000),
    "123456789012345678901234567890",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-123456789012345678901234567890-^-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {123456789012345678901234567890 ^ 0}", budget=100000),
    "123456789012345678901234567890",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-123456789012345678901234567890-+-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {123456789012345678901234567890 + 0.5}", budget=100000),
    "1.2345678901234568e+29",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-123456789012345678901234567890---0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {123456789012345678901234567890 - 0.5}", budget=100000),
    "1.2345678901234568e+29",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-123456789012345678901234567890-*-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {123456789012345678901234567890 * 0.5}", budget=100000),
    "6.172839450617284e+28",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-123456789012345678901234567890-/-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {123456789012345678901234567890 / 0.5}", budget=100000),
    "2.4691357802469136e+29",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-123456789012345678901234567890-%-0.5" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(
        t.eval("expr {123456789012345678901234567890 % 0.5}", budget=100000),
      )
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-123456789012345678901234567890-==-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {123456789012345678901234567890 == 0.5}", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-123456789012345678901234567890-!=-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {123456789012345678901234567890 != 0.5}", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-123456789012345678901234567890-<-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {123456789012345678901234567890 < 0.5}", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-123456789012345678901234567890->=-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {123456789012345678901234567890 >= 0.5}", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-123456789012345678901234567890-&-0.5" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(
        t.eval("expr {123456789012345678901234567890 & 0.5}", budget=100000),
      )
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-123456789012345678901234567890-|-0.5" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(
        t.eval("expr {123456789012345678901234567890 | 0.5}", budget=100000),
      )
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-123456789012345678901234567890-^-0.5" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(
        t.eval("expr {123456789012345678901234567890 ^ 0.5}", budget=100000),
      )
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-2.5-+-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2.5 + 2}", budget=100000), "4.5")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2.5---2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2.5 - 2}", budget=100000), "0.5")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2.5-*-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2.5 * 2}", budget=100000), "5.0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2.5-/-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2.5 / 2}", budget=100000), "1.25")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2.5-%-2" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {2.5 % 2}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-2.5-==-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2.5 == 2}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2.5-!=-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2.5 != 2}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2.5-<-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2.5 < 2}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2.5->=-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2.5 >= 2}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2.5-&-2" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {2.5 & 2}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-2.5-|-2" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {2.5 | 2}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-2.5-^-2" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {2.5 ^ 2}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-2.5-+--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2.5 + -3}", budget=100000), "-0.5")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2.5----3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2.5 - -3}", budget=100000), "5.5")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2.5-*--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2.5 * -3}", budget=100000), "-7.5")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2.5-/--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2.5 / -3}", budget=100000), "-0.8333333333333334")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2.5-%--3" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {2.5 % -3}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-2.5-==--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2.5 == -3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2.5-!=--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2.5 != -3}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2.5-<--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2.5 < -3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2.5->=--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2.5 >= -3}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2.5-&--3" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {2.5 & -3}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-2.5-|--3" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {2.5 | -3}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-2.5-^--3" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {2.5 ^ -3}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-2.5-+-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2.5 + 0}", budget=100000), "2.5")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2.5---0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2.5 - 0}", budget=100000), "2.5")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2.5-*-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2.5 * 0}", budget=100000), "0.0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2.5-/-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2.5 / 0}", budget=100000), "Inf")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2.5-%-0" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {2.5 % 0}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-2.5-==-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2.5 == 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2.5-!=-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2.5 != 0}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2.5-<-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2.5 < 0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2.5->=-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2.5 >= 0}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2.5-&-0" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {2.5 & 0}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-2.5-|-0" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {2.5 | 0}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-2.5-^-0" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {2.5 ^ 0}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-2.5-+-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2.5 + 0.5}", budget=100000), "3.0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2.5---0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2.5 - 0.5}", budget=100000), "2.0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2.5-*-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2.5 * 0.5}", budget=100000), "1.25")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2.5-/-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2.5 / 0.5}", budget=100000), "5.0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2.5-%-0.5" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {2.5 % 0.5}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-2.5-==-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2.5 == 0.5}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2.5-!=-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2.5 != 0.5}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2.5-<-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2.5 < 0.5}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2.5->=-0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2.5 >= 0.5}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic numeric-2.5-&-0.5" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {2.5 & 0.5}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-2.5-|-0.5" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {2.5 | 0.5}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic numeric-2.5-^-0.5" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {2.5 ^ 0.5}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic expression-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0x1e+2}", budget=100000), "32")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0b101 + 0o7}", budget=100000), "12")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {010}", budget=100000), "8")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-3" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {08}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic expression-4" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {08.0}", budget=100000), "8.0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2**3**2}", budget=100000), "512")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-6" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-2**2}", budget=100000), "4")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-7" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2**-2}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-8" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-2**-3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-9" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {(-1)**-3}", budget=100000), "-1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-10" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {0**-1}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic expression-11" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {12345678901234567890 << 60}", budget=100000),
    "14233598694204363376410106750713200640",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-12" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {-12345678901234567890 >> 5}", budget=100000),
    "-385802465663580247",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-13" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {~12345678901234567890}", budget=100000),
    "-12345678901234567891",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-14" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {2 + 3 * 4 > 12 && 4 << 1 == 8}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-15" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 && [error bad]}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-16" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 || [error bad]}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-17" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 ? 2 : [error bad]}", budget=100000), "2")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-18" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 ? [error bad] : 3}", budget=100000), "3")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-19" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {false ? noSuch() : 2}", budget=100000), "2")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-20" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {1 ? 2 : bareword}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic expression-21" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0 ? 1 : 1 ? 3 : 4}", budget=100000), "3")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-22" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {true}", budget=100000), "true")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-23" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {on}", budget=100000), "on")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-24" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {!off}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-25" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {\"0x03\" eq \"3\"}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-26" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {0x03 eq 3}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-27" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {001 eq 1}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-28" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {001 == 1}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-29" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {\"a\" < \"b\"}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-30" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {\"a b\" in {a {a b} c}}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-31" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {3 ni {1 2 3}}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-32" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {\"001\"}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-33" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {\"abc\"}", budget=100000), "abc")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-34" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {NaN == NaN}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-35" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {NaN != NaN}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-36" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {Inf > 100}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-37" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {-Inf + Inf}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic expression-38" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1.0/0}", budget=100000), "Inf")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-39" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {0.0/0.0}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic expression-40" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {abs(-12345678901234567890)}", budget=100000),
    "12345678901234567890",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-41" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {double(3)}", budget=100000), "3.0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-42" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {int(-3.9)}", budget=100000), "-3")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-43" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {entier(1e25)}", budget=100000),
    "10000000000000000905969664",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-44" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {wide(18446744073709551617)}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-45" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {round(-1.5)}", budget=100000), "-2")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-46" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {round(2.5)}", budget=100000), "3")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-47" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {ceil(-1.1)}", budget=100000), "-1.0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-48" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {floor(-1.1)}", budget=100000), "-2.0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-49" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {sqrt(4)}", budget=100000), "2.0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-50" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {sqrt(-1)}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic expression-51" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {pow(2,3)}", budget=100000), "8.0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-52" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {sin(0)}", budget=100000), "0.0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-53" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {cos(0)}", budget=100000), "1.0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-54" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {atan2(0,1)}", budget=100000), "0.0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-55" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {hypot(3,4)}", budget=100000), "5.0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-56" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {log(1)}", budget=100000), "0.0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-57" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {exp(0)}", budget=100000), "1.0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-58" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {log10(100)}", budget=100000), "2.0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-59" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {fmod(-5,2)}", budget=100000), "-1.0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-60" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {min(3,1.5,-2)}", budget=100000), "-2")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-61" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {max(12345678901234567890,3)}", budget=100000),
    "12345678901234567890",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-62" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {abs()}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic expression-63" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {bool(true)}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-64" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {bool(off)}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-65" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {bool(0.2)}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expression-66" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {int(Inf)}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic expression-67" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {double(NaN)}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic lazy-side-effects" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0; expr {0 && [incr x]}; expr {1 || [incr x]}; expr {1 ? 3 : [incr x]}; set x",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic eager-unbraced-expr" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("set x 0; expr 0 && [incr x]; set x", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic no-injected-expression" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("set x {1+2}; catch {expr {$x * 3}}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic variable-braced" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("set {a b} 4; set x ${a b}", budget=100000), "4")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic variable-empty" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("set {} empty; set x ${}", budget=100000), "empty")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic variable-array-braced" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("set a(x) 4; set x ${a(x)}", budget=100000), "4")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic array-index-variable" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("set i x; set a(x) 7; set x $a($i)", budget=100000), "7")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic array-index-command" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("set a(3) 8; set x $a([expr {1+2}])", budget=100000), "8")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic literal-brackets" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("list a]b ]", budget=100000), "a\\]b \\]")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic nested-brackets" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("set x [list {]} {[}]; lindex $x 0", budget=100000), "]")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expansion-variable" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("set xs {1 {2 3}}; list start {*}$xs end", budget=100000),
    "start 1 {2 3} end",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic expansion-braced" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("list {*}{1 {2 3}} 4", budget=100000), "1 {2 3} 4")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic if-then" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("if {1} then {set x yes} else {error no}", budget=100000),
    "yes",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic if-elseif" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "if {0} {error no} elseif {1} then {set x yes} else {error no}",
      budget=100000,
    ),
    "yes",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic if-implicit-else" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("if {0} {error no} {set x yes}", budget=100000), "yes")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic namespace-variable" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval n {variable x 2; proc get {} {variable x; incr x}}; list [n::get] $::n::x",
      budget=100000,
    ),
    "3 3",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic namespace-lexical" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval n {proc helper {} {return yes}; proc main {} {helper}}; namespace eval m {proc helper {} {return no}; n::main}",
      budget=100000,
    ),
    "yes",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic namespace-fallback" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 1; namespace eval n {set x 2}; list $x [info exists ::n::x]",
      budget=100000,
    ),
    "2 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic namespace-qualified" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval n {set ::x 4; set y 5}; list $x $::n::y",
      budget=100000,
    ),
    "4 5",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic namespace-metadata" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a::b {}; list [namespace parent ::a::b] [namespace tail a::b] [namespace qualifiers a::b] [namespace exists a::b]",
      budget=100000,
    ),
    "::a b a 1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic namespace-delete" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a::b {variable x 2; proc f {} {return 3}}; namespace delete a; list [namespace exists a::b] [info exists ::a::b::x]",
      budget=100000,
    ),
    "0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic namespace-code" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval n {variable x 4; set code [namespace code {set x}]}; eval $::n::code",
      budget=100000,
    ),
    "4",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic global-link" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("set x 3; proc p {} {global x; incr x}; list [p] $x", budget=100000),
    "4 4",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic global-qualified" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval n {variable x 2}; proc p {} {global ::n::x; incr x}; list [p] $::n::x",
      budget=100000,
    ),
    "3 3",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic upvar-scalar" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc change {name} {upvar 1 $name x; incr x}; proc p {} {set y 4; change y; return $y}; p",
      budget=100000,
    ),
    "5",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic upvar-array" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc change {name} {upvar 1 $name a; set a(x) 4}; proc p {} {change z; return $z(x)}; p",
      budget=100000,
    ),
    "4",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic upvar-element" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc change {name} {upvar 1 $name x; incr x}; set a(x) 4; change a(x); set a(x)",
      budget=100000,
    ),
    "5",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic upvar-recreate" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc p {} {upvar #0 x alias; unset alias; set alias 7}; set x 3; p; set x",
      budget=100000,
    ),
    "7",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic upvar-root" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("set x 2; upvar #0 x y; incr y; set x", budget=100000), "3")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic uplevel-relative" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc p {} {set x 3; q; return $x}; proc q {} {uplevel 1 {incr x}}; p",
      budget=100000,
    ),
    "4",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic uplevel-root" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 2; proc p {} {set x 99; uplevel #0 {incr x}}; list [p] $x",
      budget=100000,
    ),
    "3 3",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic proc-introspection" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc p {a {b 2} args} {return $a}; list [info args p] [info default p b d] $d [info body p]",
      budget=100000,
    ),
    "{a b args} 1 2 {return $a}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic rename-namespace" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(
        t.eval(
          "namespace eval a {variable x 3; proc p {} {variable x; return $x}}; rename a::p q; q",
          budget=100000,
        ),
      )
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic array-empty" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "array set a {}; list [array exists a] [array size a] [info exists a]",
      budget=100000,
    ),
    "1 0 1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic array-values" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "array set a {x 1 y 2}; set a(x) 3; list [array size a] [lsort [array names a]] $a(x)",
      budget=100000,
    ),
    "2 {x y} 3",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic array-collision" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("set a 1; array set a {x 2}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic array-unset" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "array set a {x1 1 x2 2 y 3}; array unset a x*; list [array names a] $a(y)",
      budget=100000,
    ),
    "y 3",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic array-exact" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("array set a {* 1 abc 2}; array names a -exact *", budget=100000),
    "*",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic array-missing" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "list [array exists no] [array size no] [array names no] [array get no]",
      budget=100000,
    ),
    "0 0 {} {}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic incr-big" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("set n 9223372036854775807; incr n", budget=100000),
    "9223372036854775808",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic stdout" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "puts -nonewline hello; puts world; puts last; set x done",
      budget=100000,
    ),
    "done",
  )
  assert_eq(t.output_text(), "helloworld\nlast\n")
}

///|
test "Tcl semantic lmap-control" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "lmap x {1 2 3 4 5} {if {$x == 2} {continue}; if {$x == 5} {break}; expr {$x * 2}}",
      budget=100000,
    ),
    "2 6 8",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic lset-nested" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("set v {{a b} {c d}}; lset v {1 0} X", budget=100000),
    "{a b} {X d}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic lset-append" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("set v {a b}; lset v end+1 c", budget=100000), "a b c")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic lset-root" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("set v {a b}; lset v {} c", budget=100000), "c")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic linsert-end" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("linsert {a b c} end X", budget=100000), "a b c X")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic linsert-before-last" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("linsert {a b c} end-1 X", budget=100000), "a b X c")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic lreplace-insert" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("lreplace {a b c} 1 0 X", budget=100000), "a X b c")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic lreplace-beyond" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("lreplace {a b} 9 10 X", budget=100000), "a b X")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic lsearch-all" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("lsearch -all -inline -not -exact {a b a c} a", budget=100000),
    "b c",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic lsearch-start" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("lsearch -start 2 {abc ax abc} a*", budget=100000), "2")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic lsort-big" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "lsort -integer {9007199254740993 -1 9007199254740992}",
      budget=100000,
    ),
    "-1 9007199254740992 9007199254740993",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic lsort-index" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("lsort -integer -index 1 {{a 3} {b 1} {c 2}}", budget=100000),
    "{b 1} {c 2} {a 3}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic lsort-unique" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("lsort -nocase -unique {B a A b c}", budget=100000), "A b c")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic lsort-command" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc cmp {a b} {expr {$b - $a}}; lsort -command cmp {1 4 2 3}",
      budget=100000,
    ),
    "4 3 2 1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic dict-create" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("dict create a 1 b 2 a 3", budget=100000), "a 3 b 2")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic dict-nested-get" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("dict get {a {b {c 4}}} a b c", budget=100000), "4")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic dict-exists" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "list [dict exists {a 1} a] [dict exists {a 1} x] [dict exists {a 1} a b]",
      budget=100000,
    ),
    "1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic dict-invalid" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("dict size {a 1 b}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic dict-keys-values" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "list [dict keys {x 1 y 2}] [dict values {x 1 y 2}] [dict size {x 1 x 2}]",
      budget=100000,
    ),
    "{x y} {1 2} 1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic dict-merge" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("dict merge {a 1 b 2} {a 3 c 4}", budget=100000),
    "a 3 b 2 c 4",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic dict-replace-remove" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "dict remove [dict replace {a 1 b 2} a 4 c 3] b missing",
      budget=100000,
    ),
    "a 4 c 3",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic dict-set" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("dict set d a b 4; dict set d a c 5; set d", budget=100000),
    "a {b 4 c 5}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic dict-unset" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("set d {a {b 4 c 5}}; dict unset d a b; set d", budget=100000),
    "a {c 5}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic dict-incr" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set d {a 9223372036854775807}; dict incr d a 2; set d",
      budget=100000,
    ),
    "a 9223372036854775809",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic dict-append" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "dict append d a x y; dict lappend d b {a b} c; set d",
      budget=100000,
    ),
    "a xy b {{a b} c}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic dict-for" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set out {}; dict for {k v} {a 1 b 2 c 3} {if {$v == 2} {continue}; lappend out $k $v}; set out",
      budget=100000,
    ),
    "a 1 c 3",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic dict-map" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "dict map {k v} {a 1 b 2} {set k ${k}x; expr {$v * 2}}",
      budget=100000,
    ),
    "ax 2 bx 4",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic dict-filter-key" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("dict filter {aa 1 ab 2 b 3} key a*", budget=100000),
    "aa 1 ab 2",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic dict-filter-value" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("dict filter {a 10 b 20 c 11} value 1*", budget=100000),
    "a 10 c 11",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic dict-filter-script" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "dict filter {a 1 b 2 c 3} script {k v} {expr {$v > 1}}",
      budget=100000,
    ),
    "b 2 c 3",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic dict-update" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set d {a 1 b 2}; dict update d a x b y {incr x; unset y}; set d",
      budget=100000,
    ),
    "a 2",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic dict-update-error" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set d {a 1}; catch {dict update d a x {incr x; error bad}}; set d",
      budget=100000,
    ),
    "a 2",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic dict-with" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set d {a {x 1 y 2}}; dict with d a {incr x; unset y}; set d",
      budget=100000,
    ),
    "a {x 2}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic dict-with-delete" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set d {x 1}; dict with d {unset d; incr x}; info exists d",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-utf16" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "list [string length a😀中] [string range a😀中 1 2]",
      budget=100000,
    ),
    "4 😀",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-empty-search" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("list [string first {} abc] [string last {} abc]", budget=100000),
    "-1 -1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-search" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "list [string first bc abcabc 2] [string last bc abcabc 3]",
      budget=100000,
    ),
    "4 1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-compare" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "list [string compare -nocase Ab aB] [string equal -length 2 abc abx]",
      budget=100000,
    ),
    "0 1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-case" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "list [string tolower ABCDEF 1 3] [string toupper abcdef 2 end-1] [string totitle hELLO]",
      budget=100000,
    ),
    "AbcdEF abCDEf Hello",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-trim" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "list [string trim {  a b  }] [string trimleft xxabc x] [string trimright abcyyy y]",
      budget=100000,
    ),
    "{a b} abc abc",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-replace" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "list [string replace abcdef 2 3 XY] [string replace abc 9 10 X]",
      budget=100000,
    ),
    "abXYef abc",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-repeat" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("list [string repeat ab 3] [string repeat x -2]", budget=100000),
    "ababab {}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-reverse" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string reverse abc中", budget=100000), "中cba")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-glob" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "list [string match {a[0-9]?*} a2xy] [string match -nocase A* abc] [string match {a\\*} a*]",
      budget=100000,
    ),
    "1 1 1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-map" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "list [string map {ab X a Y} abac] [string map -nocase {A x B y} aBc]",
      budget=100000,
    ),
    "XYc xyc",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic boundary-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {9007199254740993 == 9007199254740992.0}", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic boundary-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {-9007199254740993 < -9007199254740992.0}", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic boundary-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 < 1.5}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic boundary-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1 > -1.5}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic boundary-4" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1 > Inf}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic boundary-5" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {100000000000000010.0}", budget=100000),
    "1.0000000000000002e+17",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic boundary-6" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-0.0}", budget=100000), "-0.0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic boundary-7" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("expr {bool({ true })}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic boundary-8" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval n {variable x}; list [info exists ::n::x] [namespace which -variable ::n::x]",
      budget=100000,
    ),
    "0 ::n::x",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic boundary-9" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 1; namespace eval n {namespace which -variable x}",
      budget=100000,
    ),
    "::x",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic boundary-10" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 1; unset x; namespace eval n {set x 2}; list [info exists ::x] [info exists ::n::x]",
      budget=100000,
    ),
    "0 1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic boundary-11" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval n {set x 1; unset x}; set x 2; namespace eval n {set x}",
      budget=100000,
    ),
    "2",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic boundary-12" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("set x 1; set y 2; upvar #0 x y", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic boundary-13" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("proc p {} {set a 2; global a}; p", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic boundary-14" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 1; upvar #0 x y; proc p {} {global y; incr y}; list [p] $x $::y",
      budget=100000,
    ),
    "2 2 2",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic boundary-15" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set a(x) 2; upvar #0 a(x) y; proc p {} {global y; incr y}; list [p] $a(x) $::y",
      budget=100000,
    ),
    "3 3 3",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic boundary-16" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval n {upvar #0 x y; set y 4}; list $x $::n::y",
      budget=100000,
    ),
    "4 4",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic boundary-17" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc p {} {global x; set a 1; variable y; info locals}; p",
      budget=100000,
    ),
    "a",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic boundary-18" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("namespace eval n {variable x; info vars x}", budget=100000),
    "x",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic boundary-19" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 2; namespace eval n {variable x; catch {set x}}",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic boundary-20" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval n {variable x; unset -nocomplain x}; namespace which -variable ::n::x",
      budget=100000,
    ),
    "",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic boundary-21" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("lset a {} x", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic boundary-22" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("set a {}; lset a 0 0 x", budget=100000), "x")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic boundary-23" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(
        t.eval(
          "namespace eval n {proc a {} {return 7}; proc b {} {a}}; rename n::b ::b; b",
          budget=100000,
        ),
      )
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic boundary-24" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("dict with d {}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic boundary-25" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set d {a 1}; dict update d a x {set d {z 2}; incr x}; set d",
      budget=100000,
    ),
    "z 2 a 2",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic boundary-26" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set d {a {x 1}}; catch {dict with d a {dict unset d a}}; set d",
      budget=100000,
    ),
    "",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic boundary-27" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("set name tea; set total 20; puts \"$name: $total\"", budget=100000),
    "",
  )
  assert_eq(t.output_text(), "tea: 20\n")
}

///|
test "Tcl semantic boundary-28" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("namespace eval n {set x 3}; set y $:::n:::x", budget=100000),
    "3",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic boundary-29" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("set x --1; incr x", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic boundary-30" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("set x +-1; incr x", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl semantic float-display-1--308" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1e-308}", budget=100000), "1e-308")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display--1--308" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1e-308}", budget=100000), "-1e-308")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display-1.2345678901234567--308" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {1.2345678901234567e-308}", budget=100000),
    "1.2345678901234567e-308",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display-1--100" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1e-100}", budget=100000), "1e-100")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display--1--100" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1e-100}", budget=100000), "-1e-100")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display-1.2345678901234567--100" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {1.2345678901234567e-100}", budget=100000),
    "1.2345678901234567e-100",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display-1--7" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1e-7}", budget=100000), "1e-7")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display--1--7" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1e-7}", budget=100000), "-1e-7")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display-1.2345678901234567--7" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {1.2345678901234567e-7}", budget=100000),
    "1.2345678901234566e-7",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display-1--6" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1e-6}", budget=100000), "1e-6")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display--1--6" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1e-6}", budget=100000), "-1e-6")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display-1.2345678901234567--6" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {1.2345678901234567e-6}", budget=100000),
    "1.2345678901234567e-6",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display-1--5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1e-5}", budget=100000), "1e-5")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display--1--5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1e-5}", budget=100000), "-1e-5")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display-1.2345678901234567--5" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {1.2345678901234567e-5}", budget=100000),
    "1.2345678901234568e-5",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display-1--4" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1e-4}", budget=100000), "0.0001")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display--1--4" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1e-4}", budget=100000), "-0.0001")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display-1.2345678901234567--4" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {1.2345678901234567e-4}", budget=100000),
    "0.00012345678901234567",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display-1--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1e-3}", budget=100000), "0.001")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display--1--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1e-3}", budget=100000), "-0.001")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display-1.2345678901234567--3" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {1.2345678901234567e-3}", budget=100000),
    "0.0012345678901234567",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display-1-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1e0}", budget=100000), "1.0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display--1-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1e0}", budget=100000), "-1.0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display-1.2345678901234567-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {1.2345678901234567e0}", budget=100000),
    "1.2345678901234567",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display-1-15" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1e15}", budget=100000), "1000000000000000.0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display--1-15" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1e15}", budget=100000), "-1000000000000000.0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display-1.2345678901234567-15" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {1.2345678901234567e15}", budget=100000),
    "1234567890123456.8",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display-1-16" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1e16}", budget=100000), "10000000000000000.0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display--1-16" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1e16}", budget=100000), "-10000000000000000.0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display-1.2345678901234567-16" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {1.2345678901234567e16}", budget=100000),
    "12345678901234568.0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display-1-17" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1e17}", budget=100000), "1e+17")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display--1-17" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1e17}", budget=100000), "-1e+17")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display-1.2345678901234567-17" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {1.2345678901234567e17}", budget=100000),
    "1.2345678901234566e+17",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display-1-20" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1e20}", budget=100000), "1e+20")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display--1-20" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1e20}", budget=100000), "-1e+20")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display-1.2345678901234567-20" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {1.2345678901234567e20}", budget=100000),
    "1.2345678901234567e+20",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display-1-21" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1e21}", budget=100000), "1e+21")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display--1-21" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1e21}", budget=100000), "-1e+21")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display-1.2345678901234567-21" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {1.2345678901234567e21}", budget=100000),
    "1.2345678901234568e+21",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display-1-100" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1e100}", budget=100000), "1e+100")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display--1-100" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1e100}", budget=100000), "-1e+100")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display-1.2345678901234567-100" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {1.2345678901234567e100}", budget=100000),
    "1.2345678901234567e+100",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display-1-308" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {1e308}", budget=100000), "1e+308")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display--1-308" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {-1e308}", budget=100000), "-1e+308")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-display-1.2345678901234567-308" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {1.2345678901234567e308}", budget=100000),
    "1.2345678901234567e+308",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-entier-1e25" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {entier(1e25)}", budget=100000),
    "10000000000000000905969664",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-entier--1e25" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {entier(-1e25)}", budget=100000),
    "-10000000000000000905969664",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-entier-1e100" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {entier(1e100)}", budget=100000),
    "10000000000000000159028911097599180468360808563945281389781327557747838772170381060813469985856815104",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-entier--1e100" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("expr {entier(-1e100)}", budget=100000),
    "-10000000000000000159028911097599180468360808563945281389781327557747838772170381060813469985856815104",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-entier-1.9999999999999998" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {entier(1.9999999999999998)}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic float-entier--0.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("expr {entier(-0.5)}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-integer-" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is integer -strict {}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-integer-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is integer -strict {0}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-integer-08" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is integer -strict {08}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-integer-1.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is integer -strict {1.5}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-integer-true" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is integer -strict {true}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-integer-_" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is integer -strict {_}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-integer-abc" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is integer -strict {abc}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-integer-4294967295" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("string is integer -strict {4294967295}", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-integer-4294967296" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("string is integer -strict {4294967296}", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-integer-18446744073709551615" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("string is integer -strict {18446744073709551615}", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-integer-18446744073709551616" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("string is integer -strict {18446744073709551616}", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-wideinteger-" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is wideinteger -strict {}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-wideinteger-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is wideinteger -strict {0}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-wideinteger-08" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is wideinteger -strict {08}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-wideinteger-1.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is wideinteger -strict {1.5}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-wideinteger-true" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is wideinteger -strict {true}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-wideinteger-_" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is wideinteger -strict {_}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-wideinteger-abc" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is wideinteger -strict {abc}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-wideinteger-4294967295" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("string is wideinteger -strict {4294967295}", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-wideinteger-4294967296" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("string is wideinteger -strict {4294967296}", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-wideinteger-18446744073709551615" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "string is wideinteger -strict {18446744073709551615}",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-wideinteger-18446744073709551616" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "string is wideinteger -strict {18446744073709551616}",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-entier-" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is entier -strict {}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-entier-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is entier -strict {0}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-entier-08" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is entier -strict {08}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-entier-1.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is entier -strict {1.5}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-entier-true" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is entier -strict {true}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-entier-_" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is entier -strict {_}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-entier-abc" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is entier -strict {abc}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-entier-4294967295" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is entier -strict {4294967295}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-entier-4294967296" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is entier -strict {4294967296}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-entier-18446744073709551615" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("string is entier -strict {18446744073709551615}", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-entier-18446744073709551616" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("string is entier -strict {18446744073709551616}", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-double-" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is double -strict {}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-double-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is double -strict {0}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-double-08" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is double -strict {08}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-double-1.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is double -strict {1.5}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-double-true" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is double -strict {true}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-double-_" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is double -strict {_}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-double-abc" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is double -strict {abc}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-double-4294967295" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is double -strict {4294967295}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-double-4294967296" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is double -strict {4294967296}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-double-18446744073709551615" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("string is double -strict {18446744073709551615}", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-double-18446744073709551616" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("string is double -strict {18446744073709551616}", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-boolean-" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is boolean -strict {}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-boolean-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is boolean -strict {0}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-boolean-08" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is boolean -strict {08}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-boolean-1.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is boolean -strict {1.5}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-boolean-true" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is boolean -strict {true}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-boolean-_" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is boolean -strict {_}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-boolean-abc" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is boolean -strict {abc}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-boolean-4294967295" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("string is boolean -strict {4294967295}", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-boolean-4294967296" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("string is boolean -strict {4294967296}", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-boolean-18446744073709551615" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("string is boolean -strict {18446744073709551615}", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-boolean-18446744073709551616" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("string is boolean -strict {18446744073709551616}", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-true-" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is true -strict {}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-true-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is true -strict {0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-true-08" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is true -strict {08}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-true-1.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is true -strict {1.5}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-true-true" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is true -strict {true}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-true-_" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is true -strict {_}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-true-abc" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is true -strict {abc}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-true-4294967295" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is true -strict {4294967295}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-true-4294967296" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is true -strict {4294967296}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-true-18446744073709551615" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("string is true -strict {18446744073709551615}", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-true-18446744073709551616" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("string is true -strict {18446744073709551616}", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-false-" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is false -strict {}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-false-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is false -strict {0}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-false-08" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is false -strict {08}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-false-1.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is false -strict {1.5}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-false-true" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is false -strict {true}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-false-_" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is false -strict {_}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-false-abc" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is false -strict {abc}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-false-4294967295" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is false -strict {4294967295}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-false-4294967296" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is false -strict {4294967296}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-false-18446744073709551615" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("string is false -strict {18446744073709551615}", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-false-18446744073709551616" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("string is false -strict {18446744073709551616}", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-list-" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is list -strict {}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-list-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is list -strict {0}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-list-08" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is list -strict {08}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-list-1.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is list -strict {1.5}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-list-true" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is list -strict {true}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-list-_" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is list -strict {_}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-list-abc" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is list -strict {abc}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-list-4294967295" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is list -strict {4294967295}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-list-4294967296" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is list -strict {4294967296}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-list-18446744073709551615" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("string is list -strict {18446744073709551615}", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-list-18446744073709551616" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("string is list -strict {18446744073709551616}", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-digit-" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is digit -strict {}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-digit-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is digit -strict {0}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-digit-08" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is digit -strict {08}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-digit-1.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is digit -strict {1.5}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-digit-true" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is digit -strict {true}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-digit-_" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is digit -strict {_}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-digit-abc" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is digit -strict {abc}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-digit-4294967295" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is digit -strict {4294967295}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-digit-4294967296" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is digit -strict {4294967296}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-digit-18446744073709551615" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("string is digit -strict {18446744073709551615}", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-digit-18446744073709551616" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("string is digit -strict {18446744073709551616}", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-xdigit-" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is xdigit -strict {}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-xdigit-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is xdigit -strict {0}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-xdigit-08" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is xdigit -strict {08}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-xdigit-1.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is xdigit -strict {1.5}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-xdigit-true" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is xdigit -strict {true}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-xdigit-_" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is xdigit -strict {_}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-xdigit-abc" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is xdigit -strict {abc}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-xdigit-4294967295" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is xdigit -strict {4294967295}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-xdigit-4294967296" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is xdigit -strict {4294967296}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-xdigit-18446744073709551615" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("string is xdigit -strict {18446744073709551615}", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-xdigit-18446744073709551616" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("string is xdigit -strict {18446744073709551616}", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-space-" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is space -strict {}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-space-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is space -strict {0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-space-08" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is space -strict {08}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-space-1.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is space -strict {1.5}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-space-true" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is space -strict {true}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-space-_" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is space -strict {_}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-space-abc" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is space -strict {abc}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-space-4294967295" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is space -strict {4294967295}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-space-4294967296" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is space -strict {4294967296}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-space-18446744073709551615" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("string is space -strict {18446744073709551615}", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-space-18446744073709551616" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("string is space -strict {18446744073709551616}", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-ascii-" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is ascii -strict {}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-ascii-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is ascii -strict {0}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-ascii-08" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is ascii -strict {08}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-ascii-1.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is ascii -strict {1.5}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-ascii-true" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is ascii -strict {true}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-ascii-_" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is ascii -strict {_}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-ascii-abc" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is ascii -strict {abc}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-ascii-4294967295" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is ascii -strict {4294967295}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-ascii-4294967296" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is ascii -strict {4294967296}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-ascii-18446744073709551615" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("string is ascii -strict {18446744073709551615}", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-ascii-18446744073709551616" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("string is ascii -strict {18446744073709551616}", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-alpha-" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is alpha -strict {}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-alpha-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is alpha -strict {0}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-alpha-08" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is alpha -strict {08}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-alpha-1.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is alpha -strict {1.5}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-alpha-true" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is alpha -strict {true}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-alpha-_" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is alpha -strict {_}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-alpha-abc" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is alpha -strict {abc}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-alpha-4294967295" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is alpha -strict {4294967295}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-alpha-4294967296" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is alpha -strict {4294967296}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-alpha-18446744073709551615" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("string is alpha -strict {18446744073709551615}", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-alpha-18446744073709551616" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("string is alpha -strict {18446744073709551616}", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-alnum-" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is alnum -strict {}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-alnum-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is alnum -strict {0}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-alnum-08" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is alnum -strict {08}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-alnum-1.5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is alnum -strict {1.5}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-alnum-true" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is alnum -strict {true}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-alnum-_" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is alnum -strict {_}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-alnum-abc" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is alnum -strict {abc}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-alnum-4294967295" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is alnum -strict {4294967295}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-alnum-4294967296" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string is alnum -strict {4294967296}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-alnum-18446744073709551615" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("string is alnum -strict {18446744073709551615}", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl semantic string-is-alnum-18446744073709551616" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("string is alnum -strict {18446744073709551616}", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}
