///|
test "switch captures persist across evaluations and cache clearing" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "switch -regexp -matchvar m -indexvar ix -- xxabbbz {a(b+)} {list found}",
    ),
    "found",
  )
  t.clear_cache()
  assert_eq(t.eval("list $m $ix"), "{abbb bbb} {{2 5} {3 5}}")
  assert_eq(
    t.eval(
      "switch -regexp -matchvar m -indexvar ix -- x nomatch {};list $m $ix",
    ),
    "{abbb bbb} {{2 5} {3 5}}",
  )
  assert_eq(
    t.eval(
      "switch -regexp -matchvar m -indexvar ix -- x nomatch {} default {};list $m $ix",
    ),
    "{} {}",
  )
}

///|
test "switch does not compile skipped patterns and preserves numeric bodies" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("scan 18446744073709551616 %f v;set body [list set saved $v]"),
    "set saved 1.844674407370955e+19",
  )
  assert_eq(
    t.eval("switch -regexp a a - {(invalid} $body;format %.17g $saved"),
    "1.8446744073709552e+19",
  )
  assert_eq(
    t.eval(
      "switch -regexp a a {set hit yes} {(invalid} {error skipped};set hit",
    ),
    "yes",
  )
  assert_eq(t.eval("format %.17g [lindex $body 2]"), "1.8446744073709552e+19")
}

///|
test "switch capture assignment failures preserve native write order" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("set scalar 0;set m old;set ix old"), "old")
  assert_eq(
    t.eval_catch(
      "switch -regexp -indexvar scalar(i) -matchvar m abc {(a)} {error unreachable}",
    ).code,
    1,
  )
  assert_eq(t.eval("list $scalar $m"), "0 old")
  assert_eq(
    t.eval_catch(
      "switch -regexp -indexvar ix -matchvar scalar(m) abc {(a)} {error unreachable}",
    ).code,
    1,
  )
  assert_eq(t.eval("set ix"), "{0 0} {0 0}")
  assert_eq(
    t.eval("switch -regexp -indexvar both -matchvar both abc {(a)} {set both}"),
    "a a",
  )
}

///|
test "switch preserves completion options and caller variable scope" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc f x {switch $x a {return -tag kept yes} default {return no}};f a",
    ),
    "yes",
  )
  let caught = t.eval_catch("switch a a {return -code 7 -note custom result}")
  assert_eq(caught.code, 2)
  assert_eq(caught.result, "result")
  assert_eq(@tcl.parse_list(caught.options), [
    "-note", "custom", "-code", "7", "-level", "1",
  ])
  assert_eq(
    t.eval(
      "namespace eval n {variable v 2;proc run {} {variable v;switch -glob abc a* {incr v}}};n::run",
    ),
    "3",
  )
}

///|
test "regex compilation replaces pattern representation only" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "scan 18446744073709551616 %f v;switch -regexp -- $v .* {};format %.17g $v",
    ),
    "1.8446744073709552e+19",
  )
  assert_eq(
    t.eval("switch -regexp -- x $v {};format %.17g $v"),
    "1.844674407370955e+19",
  )
}

///|
test "switch resource failures preserve session and recover on next evaluation" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("set touched original;set m old"), "old")
  assert_eq(
    t.eval_catch(
      "switch -regexp -matchvar m a [string repeat a 4097] {set touched changed}",
    ).code,
    1,
  )
  assert_eq(t.eval("list $touched $m"), "original old")
  assert_true(
    try {
      ignore(
        t.eval(
          "switch -regexp [string repeat a 40] {(a+)+$} {set touched changed}",
          budget=1000,
        ),
      )
      false
    } catch {
      _ => true
    },
  )
  assert_eq(t.eval("set touched"), "original")
  assert_eq(t.eval("switch -exact -- a a {set touched recovered}"), "recovered")
}

///|
test "deep quantified patterns stay bounded during compilation and recover" {
  let t = @tcl.Interpreter::new()
  // Previously, constructing uncaptured prefixes copied nested ASTs repeatedly.
  // This 48-level pattern is below the parser limit; its execution must remain
  // bounded without host memory exhaustion or a corrupt interpreter session.
  assert_eq(t.eval("set marker safe"), "safe")
  let source = "set p a;for {set i 0} {$i<48} {incr i} {set p ($p)+};switch -regexp a $p {set marker wrong}"
  assert_eq(t.eval_catch(source).code, 1)
  assert_eq(
    t.eval("list $marker [switch -regexp abc {a.c} {list recovered}]"),
    "safe recovered",
  )
}
