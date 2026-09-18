///|
test "format rounds the exact binary value with ties to even" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("list [format %.0f 2.5] [format %.0f 3.5] [format %.2f 2.675]"),
    "2 4 2.67",
  )
  assert_eq(
    t.eval("list [format %.1e 9.99] [format %.1g 9.99] [format %.0f -0.0]"),
    "1.0e+01 1e+01 -0",
  )
  assert_eq(t.eval("string length [format %.1200f 0.1]"), "1202")
}

///|
test "format and scan preserve arbitrary integers within interpreter limits" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set v [expr {2**96+7}];set text [format %llx $v];scan $text %llx parsed;expr {$v == $parsed}",
    ),
    "1",
  )
  assert_eq(
    t.eval(
      "list [format %d 4294967296] [scan 4294967296 %d] [format %ld 4294967296]",
    ),
    "0 2147483647 4294967296",
  )
  assert_eq(
    t.eval("format {%2$s:%1$04d:%3$*.*f} 7 key 8 2 1.25"),
    "key:0007:    1.25",
  )
}

///|
test "scan validates all fields before writes and retains partial write failures" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("set a old;set b old;catch {scan {12 34} {%d%q} a b};list $a $b"),
    "old old",
  )
  assert_eq(
    t.eval(
      "array set target {k kept};catch {scan {12 34} {%d%d} a target};list $a [array get target]",
    ),
    "12 {k kept}",
  )
  assert_eq(t.eval("scan {12 x} {%d%d} a b;list $a $b"), "12 old")
  assert_eq(t.eval("scan {} %d a"), "-1")
  assert_eq(t.eval("scan x %d a"), "0")
}

///|
test "scan writes aliases and array elements across cached evaluations" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set source {12 34};set a old;proc read {} {global source;upvar #0 a out;scan $source {%d %d} out box(中);list $out $box(中)};read",
    ),
    "12 34",
  )
  assert_eq(t.eval("set source {56 78};read"), "56 78")
  assert_eq(t.eval("set a"), "56")
  assert_eq(t.eval("scan {1 2} {%2$d %1$d} x y;list $x $y"), "2 1")
}

///|
test "conversion size bounds fail without exposing partial formatted output" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("format {%1000000s%%} x"))
      false
    } catch {
      _ => true
    },
  )
  assert_true(
    try {
      ignore(t.eval("format {%*s} 2147483647 x"))
      false
    } catch {
      _ => true
    },
  )
  assert_true(
    try {
      ignore(t.eval("scan x {%100001$s}"))
      false
    } catch {
      _ => true
    },
  )
  assert_true(
    try {
      ignore(t.eval("while 1 {format %d 1}", budget=20))
      false
    } catch {
      _ => true
    },
  )
  assert_eq(t.output_text(), "")
  assert_eq(t.eval("format %s recovered"), "recovered")
}

///|
test "string format precision preserves individual UTF16 units" {
  let t = @tcl.Interpreter::new()
  let high = String::from_array([(55357).unsafe_to_char()])
  assert_eq(t.eval("format %.1s 😀"), high)
  assert_eq(
    t.eval(
      "set a [format %.1s 😀];set b [string index 😀 1];string equal $a$b 😀",
    ),
    "1",
  )
  assert_eq(t.eval("scan 中文 {%c%n%s} a b c;list $a $b $c"), "20013 3 文")
}
