///|
test "UTF16 slices preserve isolated units and rejoin without replacement" {
  let t = @tcl.Interpreter::new()
  let high = String::from_array([(55296).unsafe_to_char()])
  let low = String::from_array([(56320).unsafe_to_char()])
  assert_eq(t.eval("set x 𐀀;string index $x 0"), high)
  assert_eq(t.eval("string index $x 1"), low)
  assert_eq(
    t.eval("set h [string index $x 0];set l [string index $x 1];set y $h$l"),
    "𐀀",
  )
  assert_eq(t.eval("string replace $x 0 0 X"), "X" + low)
  assert_eq(t.eval("string map [list $h X] $x"), "X" + low)
  assert_eq(@tcl.parse_list(@tcl.format_list([high, low])), [high, low])
}

///|
test "supplementary case conversion is bounded and retains UTF16 pairs" {
  // The pinned Windows Tcl reference crashes on supplementary case conversion.
  // These are local API guarantees, not independent native oracle results.
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("string tolower 𐐀AB😀"), "𐐀ab😀")
  assert_eq(t.eval("string toupper 𐐨ab😀"), "𐐨AB😀")
  assert_eq(t.eval("string totitle 😀AB"), "😀ab")
  assert_eq(t.eval("string tolower A😀B 1 1"), "A😀B")
  assert_eq(t.eval("string toupper Ab end+1"), "Ab")
  assert_eq(t.eval("string toupper Ab -1"), "Ab")
}

///|
test "failindex follows aliases and only changes on failed classification" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set f old;proc check {x} {upvar #0 f out;string is alpha -failindex out $x};check abc",
    ),
    "1",
  )
  assert_eq(t.eval("set f"), "old")
  assert_eq(t.eval("check 中1;set f"), "1")
  assert_eq(t.eval("check abc;set f"), "1")
  assert_eq(t.eval("set x 𐁁!;string is alpha -failindex f $x;set f"), "1")
  assert_eq(
    t.eval("set x \"😀 {bad\";string is list -failindex f $x;set f"),
    "3",
  )
}

///|
test "simple mappings preserve length across repeated cached commands" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("set x İßǳ;string toupper $x"), "İßǱ")
  assert_eq(t.eval("set x ȺᲐ;string tolower $x"), "Ⱥა")
  assert_eq(t.eval("set x İßǳ;string tolower $x"), "ißǳ")
  assert_eq(t.eval("string map -nocase {İ X ß Y} iİßSS"), "XXYSS")
  assert_eq(t.eval("string match ?? 😀"), "1")
  assert_eq(t.eval("string match ? 😀"), "0")
}

///|
test "Unicode command extensions retain execution and output limits" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("while 1 {string is alpha 中}", budget=20))
      false
    } catch {
      _ => true
    },
  )
  assert_true(
    try {
      ignore(t.eval("string map [list 中 [string repeat x 1000000]] 中中"))
      false
    } catch {
      _ => true
    },
  )
  assert_eq(t.eval("string is alpha 中"), "1")
}
