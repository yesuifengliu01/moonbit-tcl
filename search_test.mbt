///|
test "search preserves nested values and pinned end-relative subindices" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("set v {{x a} {y z a}};lsearch -all -index end -subindices $v a"),
    "{0 2} {1 2}",
  )
  t.clear_cache()
  assert_eq(t.eval("lsearch -all -inline -index end -subindices $v a"), "a a")
  assert_eq(t.eval("lsearch -inline -index end -subindices $v a"), "x a")
  assert_eq(t.eval("lsearch -index end -subindices $v z"), "-1 2")
  assert_eq(t.eval("lsearch -start 100 -index end -subindices $v a"), "-1")
}

///|
test "search binary boundaries and numeric wide comparisons remain distinct" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "list [lsearch -sorted {a b b d} b] [lsearch -bisect {a b b d} b] [lsearch -bisect -start 1 {b d f} a]",
    ),
    "1 2 0",
  )
  assert_eq(t.eval("lsearch -exact -integer {18446744073709551615} -1"), "0")
  assert_eq(t.eval("lsearch -sorted -integer {bad 1 2} 2"), "2")
  assert_eq(
    t.eval_catch("lsearch -exact -integer {18446744073709551616} 0").result,
    "integer value too large to represent",
  )
  assert_eq(t.eval("lsearch -exact -integer -start 100 {1} bad"), "-1")
}

///|
test "array regexp validation remains lazy and survives aliases" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("array set a {};array names a -regexp {(}"), "")
  assert_eq(
    t.eval(
      "array set a {a1 x a2 y b3 z};proc names {} {upvar #0 a alias;lsort [array names alias -reg {^a}]} ;names",
    ),
    "a1 a2",
  )
  assert_eq(t.eval_catch("array names a -regexp {(}").code, 1)
  assert_eq(t.eval("names"), "a1 a2")
  assert_eq(t.eval_catch("lsearch -regexp {} {(}").code, 1)
}

///|
test "search regexp fast paths retain observable numeric representations" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;lsearch -regexp [list $v] .*;format %.17g $v",
    ),
    "1.8446744073709552e+19",
  )
  assert_eq(
    t.eval("lsearch -regexp [list $v] {(1)};format %.17g $v"),
    "1.844674407370955e+19",
  )
  assert_eq(
    t.eval(
      "list [lsearch -glob [list 😀] ?] [lsearch -regexp [list 😀] {^.$}] [lsearch -regexp [list [list 😀]] {^.$}]",
    ),
    "0 -1 0",
  )
}

///|
test "dictionary order and merge-time uniqueness preserve native equivalence" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("lsort -dictionary {a01 a1 a001 a10 a2 A1}"),
    "A1 a1 a01 a001 a2 a10",
  )
  assert_eq(t.eval("lsort -dictionary -decreasing -unique {Ǆ ǅ ǆ}"), "ǆ")
  assert_eq(t.eval("lsearch -dictionary -exact {K K k} k"), "2")
  assert_eq(t.eval("lsort -ascii {😀  ￿ a}"), "a  ￿ 😀")
}

///|
test "search options retain errors and dispatch through renamed commands" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("rename lsearch find;set option -reg;find $option -all {a b aa} a"),
    "0 2",
  )
  assert_eq(
    t.eval_catch("find -bisect -all {} a").result,
    "-bisect is not compatible with -all or -not",
  )
  assert_eq(
    t.eval_catch("find -subindices {} a").result,
    "-subindices cannot be used without -index option",
  )
  assert_eq(t.eval("find -start bad -start end {a b a} a"), "2")
}

///|
test "search execution budget and regexp limits allow subsequent recovery" {
  let t = @tcl.Interpreter::new()
  ignore(t.eval("set values [lrepeat 200 a]"))
  assert_true(
    try {
      ignore(t.eval("lsearch -all $values a", budget=20))
      false
    } catch {
      _ => true
    },
  )
  assert_eq(t.eval("lsearch -all {a b a} a"), "0 2")
  assert_eq(t.eval_catch("lsearch -regexp {a} [string repeat a 4097]").code, 1)
  assert_eq(t.eval("lsearch -regexp {a b} a"), "0")
}
