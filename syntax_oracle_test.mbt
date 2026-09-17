// Original programs, expected results evaluated by Tcl 8.6.15. Do not hand-edit.

///|
test "Tcl syntax flags-0-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template plain;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 plain 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-0-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template quotes\\ \\\"\\ \\$x\\ \\\"\\ braces\\ \\{\\ \\$x\\ \\};set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {quotes \" 0 \" braces { 0 }} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-0-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$x:\\$x;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 0:0 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-0-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template one\\\\ntwo\\\\tthree;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {one\ntwo\tthree} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-0-4" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\\\\\$x\\ \\\\\\[incr\\ x\\\\\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$x [incr x]} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-0-5" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(index);set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 VALUE 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-0-6" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[incr\\ x\\]);set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 ONE 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-0-7" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[set\\ x\\ 3\\]\\ \\$x;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {3 3} 3 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-0-8" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[set\\ x\\ 3\\;\\]\\ \\$x;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {3 3} 3 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-0-9" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\\\x69ndex);set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 VALUE 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-0-10" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\$x);set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-0-11" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\$\\{x\\});set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-0-12" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[list\\ \\[incr\\ x\\]\\ \\[incr\\ x\\]\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {1 2} 2 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-0-13" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[break\\]after\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 before 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-0-14" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[continue\\]after\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeafter1 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-0-15" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[return\\ VALUE\\]after\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeVALUEafter1 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-0-16" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[return\\ -code\\ error\\ bad\\]\\ tail;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {bad tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-0-17" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[return\\ -level\\ 0\\ -code\\ error\\ bad\\]\\ tail;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-0-18" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[return\\ -level\\ 0\\ -code\\ 9\\ VALUE\\]tail;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 VALUEtail 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-0-19" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[return\\ -level\\ 2\\ -tag\\ X\\ VALUE\\]tail;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 VALUEtail 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-0-20" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[return\\ -level\\ 0\\ -tag\\ X\\ VALUE\\]tail;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 VALUEtail 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-0-21" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[error\\ bad\\]tail;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-0-22" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template text\\ \\$missing\\ tail;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-0-23" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[incr\\ x\\]\\$\\{unclosed;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 1 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-0-24" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[break\\]\\$\\{unclosed;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-0-25" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[continue\\]\\$\\{unclosed;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-0-26" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template backslash\\\\;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 backslash\\\\ 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-0-27" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template 中文\\$x\\ \\[list\\ 😀\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {中文0 😀} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-0-28" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template empty\\[\\]word;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 emptyword 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-0-29" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template bracket\\]literal;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 bracket\\]literal 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-0-30" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[\\;#comment\\n\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-1-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template plain;set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 plain 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-1-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template quotes\\ \\\"\\ \\$x\\ \\\"\\ braces\\ \\{\\ \\$x\\ \\};set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {quotes \" 0 \" braces { 0 }} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-1-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$x:\\$x;set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 0:0 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-1-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template one\\\\ntwo\\\\tthree;set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {one\\ntwo\\tthree} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-1-4" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\\\\\$x\\ \\\\\\[incr\\ x\\\\\\];set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-1-5" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(index);set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 VALUE 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-1-6" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[incr\\ x\\]);set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 ONE 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-1-7" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[set\\ x\\ 3\\]\\ \\$x;set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {3 3} 3 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-1-8" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[set\\ x\\ 3\\;\\]\\ \\$x;set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {3 3} 3 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-1-9" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\\\x69ndex);set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 VALUE 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-1-10" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\$x);set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-1-11" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\$\\{x\\});set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-1-12" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[list\\ \\[incr\\ x\\]\\ \\[incr\\ x\\]\\];set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {1 2} 2 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-1-13" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[break\\]after\\[incr\\ x\\];set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 before 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-1-14" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[continue\\]after\\[incr\\ x\\];set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeafter1 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-1-15" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[return\\ VALUE\\]after\\[incr\\ x\\];set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeVALUEafter1 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-1-16" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[return\\ -code\\ error\\ bad\\]\\ tail;set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {bad tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-1-17" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[return\\ -level\\ 0\\ -code\\ error\\ bad\\]\\ tail;set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-1-18" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[return\\ -level\\ 0\\ -code\\ 9\\ VALUE\\]tail;set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 VALUEtail 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-1-19" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[return\\ -level\\ 2\\ -tag\\ X\\ VALUE\\]tail;set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 VALUEtail 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-1-20" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[return\\ -level\\ 0\\ -tag\\ X\\ VALUE\\]tail;set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 VALUEtail 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-1-21" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[error\\ bad\\]tail;set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-1-22" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template text\\ \\$missing\\ tail;set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-1-23" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[incr\\ x\\]\\$\\{unclosed;set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 1 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-1-24" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[break\\]\\$\\{unclosed;set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-1-25" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[continue\\]\\$\\{unclosed;set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-1-26" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template backslash\\\\;set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 backslash\\\\ 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-1-27" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template 中文\\$x\\ \\[list\\ 😀\\];set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {中文0 😀} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-1-28" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template empty\\[\\]word;set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 emptyword 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-1-29" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template bracket\\]literal;set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 bracket\\]literal 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-1-30" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[\\;#comment\\n\\];set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-2-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template plain;set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 plain 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-2-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template quotes\\ \\\"\\ \\$x\\ \\\"\\ braces\\ \\{\\ \\$x\\ \\};set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {quotes \" 0 \" braces { 0 }} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-2-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$x:\\$x;set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 0:0 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-2-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template one\\\\ntwo\\\\tthree;set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {one\ntwo\tthree} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-2-4" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\\\\\$x\\ \\\\\\[incr\\ x\\\\\\];set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$x [incr x]} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-2-5" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(index);set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 VALUE 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-2-6" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[incr\\ x\\]);set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 ONE 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-2-7" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[set\\ x\\ 3\\]\\ \\$x;set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {[set x 3] 0} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-2-8" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[set\\ x\\ 3\\;\\]\\ \\$x;set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {[set x 3;] 0} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-2-9" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\\\x69ndex);set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 VALUE 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-2-10" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\$x);set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-2-11" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\$\\{x\\});set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-2-12" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[list\\ \\[incr\\ x\\]\\ \\[incr\\ x\\]\\];set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {[list [incr x] [incr x]]} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-2-13" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[break\\]after\\[incr\\ x\\];set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before[break]after[incr x]} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-2-14" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[continue\\]after\\[incr\\ x\\];set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before[continue]after[incr x]} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-2-15" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[return\\ VALUE\\]after\\[incr\\ x\\];set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before[return VALUE]after[incr x]} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-2-16" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[return\\ -code\\ error\\ bad\\]\\ tail;set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {[return -code error bad] tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-2-17" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[return\\ -level\\ 0\\ -code\\ error\\ bad\\]\\ tail;set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {[return -level 0 -code error bad] tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-2-18" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[return\\ -level\\ 0\\ -code\\ 9\\ VALUE\\]tail;set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {[return -level 0 -code 9 VALUE]tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-2-19" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[return\\ -level\\ 2\\ -tag\\ X\\ VALUE\\]tail;set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {[return -level 2 -tag X VALUE]tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-2-20" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[return\\ -level\\ 0\\ -tag\\ X\\ VALUE\\]tail;set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {[return -level 0 -tag X VALUE]tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-2-21" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[error\\ bad\\]tail;set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {[error bad]tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-2-22" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template text\\ \\$missing\\ tail;set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-2-23" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[incr\\ x\\]\\$\\{unclosed;set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-2-24" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[break\\]\\$\\{unclosed;set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-2-25" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[continue\\]\\$\\{unclosed;set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-2-26" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template backslash\\\\;set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 backslash\\\\ 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-2-27" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template 中文\\$x\\ \\[list\\ 😀\\];set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {中文0 [list 😀]} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-2-28" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template empty\\[\\]word;set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {empty[]word} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-2-29" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template bracket\\]literal;set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 bracket\\]literal 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-2-30" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[\\;#comment\\n\\];set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {[;#comment\n]} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-3-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template plain;set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 plain 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-3-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template quotes\\ \\\"\\ \\$x\\ \\\"\\ braces\\ \\{\\ \\$x\\ \\};set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {quotes \" 0 \" braces { 0 }} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-3-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$x:\\$x;set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 0:0 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-3-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template one\\\\ntwo\\\\tthree;set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {one\\ntwo\\tthree} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-3-4" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\\\\\$x\\ \\\\\\[incr\\ x\\\\\\];set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {\\0 \\[incr x\\]} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-3-5" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(index);set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 VALUE 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-3-6" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[incr\\ x\\]);set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 ONE 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-3-7" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[set\\ x\\ 3\\]\\ \\$x;set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {[set x 3] 0} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-3-8" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[set\\ x\\ 3\\;\\]\\ \\$x;set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {[set x 3;] 0} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-3-9" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\\\x69ndex);set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 VALUE 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-3-10" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\$x);set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-3-11" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\$\\{x\\});set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-3-12" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[list\\ \\[incr\\ x\\]\\ \\[incr\\ x\\]\\];set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {[list [incr x] [incr x]]} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-3-13" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[break\\]after\\[incr\\ x\\];set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before[break]after[incr x]} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-3-14" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[continue\\]after\\[incr\\ x\\];set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before[continue]after[incr x]} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-3-15" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[return\\ VALUE\\]after\\[incr\\ x\\];set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before[return VALUE]after[incr x]} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-3-16" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[return\\ -code\\ error\\ bad\\]\\ tail;set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {[return -code error bad] tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-3-17" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[return\\ -level\\ 0\\ -code\\ error\\ bad\\]\\ tail;set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {[return -level 0 -code error bad] tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-3-18" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[return\\ -level\\ 0\\ -code\\ 9\\ VALUE\\]tail;set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {[return -level 0 -code 9 VALUE]tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-3-19" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[return\\ -level\\ 2\\ -tag\\ X\\ VALUE\\]tail;set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {[return -level 2 -tag X VALUE]tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-3-20" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[return\\ -level\\ 0\\ -tag\\ X\\ VALUE\\]tail;set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {[return -level 0 -tag X VALUE]tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-3-21" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[error\\ bad\\]tail;set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {[error bad]tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-3-22" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template text\\ \\$missing\\ tail;set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-3-23" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[incr\\ x\\]\\$\\{unclosed;set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-3-24" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[break\\]\\$\\{unclosed;set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-3-25" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[continue\\]\\$\\{unclosed;set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-3-26" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template backslash\\\\;set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 backslash\\\\ 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-3-27" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template 中文\\$x\\ \\[list\\ 😀\\];set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {中文0 [list 😀]} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-3-28" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template empty\\[\\]word;set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {empty[]word} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-3-29" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template bracket\\]literal;set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 bracket\\]literal 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-3-30" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[\\;#comment\\n\\];set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {[;#comment\n]} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-4-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template plain;set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 plain 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-4-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template quotes\\ \\\"\\ \\$x\\ \\\"\\ braces\\ \\{\\ \\$x\\ \\};set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {quotes \" $x \" braces { $x }} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-4-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$x:\\$x;set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$x:$x} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-4-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template one\\\\ntwo\\\\tthree;set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {one\ntwo\tthree} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-4-4" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\\\\\$x\\ \\\\\\[incr\\ x\\\\\\];set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$x [incr x]} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-4-5" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(index);set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$a(index)} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-4-6" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[incr\\ x\\]);set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$a(1)} 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-4-7" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[set\\ x\\ 3\\]\\ \\$x;set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {3 $x} 3 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-4-8" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[set\\ x\\ 3\\;\\]\\ \\$x;set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {3 $x} 3 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-4-9" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\\\x69ndex);set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$a(index)} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-4-10" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\$x);set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$a($x)} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-4-11" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\$\\{x\\});set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$a(${x})} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-4-12" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[list\\ \\[incr\\ x\\]\\ \\[incr\\ x\\]\\];set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {1 2} 2 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-4-13" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[break\\]after\\[incr\\ x\\];set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 before 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-4-14" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[continue\\]after\\[incr\\ x\\];set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeafter1 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-4-15" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[return\\ VALUE\\]after\\[incr\\ x\\];set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeVALUEafter1 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-4-16" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[return\\ -code\\ error\\ bad\\]\\ tail;set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {bad tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-4-17" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[return\\ -level\\ 0\\ -code\\ error\\ bad\\]\\ tail;set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-4-18" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[return\\ -level\\ 0\\ -code\\ 9\\ VALUE\\]tail;set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 VALUEtail 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-4-19" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[return\\ -level\\ 2\\ -tag\\ X\\ VALUE\\]tail;set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 VALUEtail 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-4-20" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[return\\ -level\\ 0\\ -tag\\ X\\ VALUE\\]tail;set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 VALUEtail 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-4-21" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[error\\ bad\\]tail;set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-4-22" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template text\\ \\$missing\\ tail;set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {text $missing tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-4-23" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[incr\\ x\\]\\$\\{unclosed;set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 1\\$\\{unclosed 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-4-24" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[break\\]\\$\\{unclosed;set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-4-25" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[continue\\]\\$\\{unclosed;set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 \\$\\{unclosed 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-4-26" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template backslash\\\\;set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 backslash\\\\ 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-4-27" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template 中文\\$x\\ \\[list\\ 😀\\];set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {中文$x 😀} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-4-28" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template empty\\[\\]word;set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 emptyword 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-4-29" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template bracket\\]literal;set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 bracket\\]literal 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-4-30" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[\\;#comment\\n\\];set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-5-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template plain;set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 plain 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-5-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template quotes\\ \\\"\\ \\$x\\ \\\"\\ braces\\ \\{\\ \\$x\\ \\};set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {quotes \" $x \" braces { $x }} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-5-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$x:\\$x;set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$x:$x} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-5-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template one\\\\ntwo\\\\tthree;set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {one\\ntwo\\tthree} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-5-4" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\\\\\$x\\ \\\\\\[incr\\ x\\\\\\];set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-5-5" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(index);set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$a(index)} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-5-6" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[incr\\ x\\]);set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$a(1)} 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-5-7" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[set\\ x\\ 3\\]\\ \\$x;set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {3 $x} 3 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-5-8" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[set\\ x\\ 3\\;\\]\\ \\$x;set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {3 $x} 3 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-5-9" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\\\x69ndex);set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$a(\\x69ndex)} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-5-10" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\$x);set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$a($x)} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-5-11" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\$\\{x\\});set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$a(${x})} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-5-12" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[list\\ \\[incr\\ x\\]\\ \\[incr\\ x\\]\\];set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {1 2} 2 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-5-13" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[break\\]after\\[incr\\ x\\];set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 before 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-5-14" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[continue\\]after\\[incr\\ x\\];set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeafter1 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-5-15" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[return\\ VALUE\\]after\\[incr\\ x\\];set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeVALUEafter1 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-5-16" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[return\\ -code\\ error\\ bad\\]\\ tail;set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {bad tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-5-17" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[return\\ -level\\ 0\\ -code\\ error\\ bad\\]\\ tail;set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-5-18" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[return\\ -level\\ 0\\ -code\\ 9\\ VALUE\\]tail;set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 VALUEtail 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-5-19" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[return\\ -level\\ 2\\ -tag\\ X\\ VALUE\\]tail;set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 VALUEtail 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-5-20" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[return\\ -level\\ 0\\ -tag\\ X\\ VALUE\\]tail;set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 VALUEtail 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-5-21" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[error\\ bad\\]tail;set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-5-22" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template text\\ \\$missing\\ tail;set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {text $missing tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-5-23" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[incr\\ x\\]\\$\\{unclosed;set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 1\\$\\{unclosed 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-5-24" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[break\\]\\$\\{unclosed;set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-5-25" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[continue\\]\\$\\{unclosed;set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 \\$\\{unclosed 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-5-26" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template backslash\\\\;set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 backslash\\\\ 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-5-27" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template 中文\\$x\\ \\[list\\ 😀\\];set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {中文$x 😀} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-5-28" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template empty\\[\\]word;set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 emptyword 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-5-29" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template bracket\\]literal;set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 bracket\\]literal 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-5-30" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[\\;#comment\\n\\];set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-6-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template plain;set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 plain 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-6-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template quotes\\ \\\"\\ \\$x\\ \\\"\\ braces\\ \\{\\ \\$x\\ \\};set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {quotes \" $x \" braces { $x }} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-6-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$x:\\$x;set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$x:$x} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-6-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template one\\\\ntwo\\\\tthree;set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {one\ntwo\tthree} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-6-4" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\\\\\$x\\ \\\\\\[incr\\ x\\\\\\];set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$x [incr x]} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-6-5" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(index);set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$a(index)} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-6-6" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[incr\\ x\\]);set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$a([incr x])} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-6-7" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[set\\ x\\ 3\\]\\ \\$x;set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {[set x 3] $x} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-6-8" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[set\\ x\\ 3\\;\\]\\ \\$x;set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {[set x 3;] $x} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-6-9" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\\\x69ndex);set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$a(index)} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-6-10" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\$x);set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$a($x)} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-6-11" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\$\\{x\\});set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$a(${x})} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-6-12" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[list\\ \\[incr\\ x\\]\\ \\[incr\\ x\\]\\];set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {[list [incr x] [incr x]]} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-6-13" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[break\\]after\\[incr\\ x\\];set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before[break]after[incr x]} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-6-14" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[continue\\]after\\[incr\\ x\\];set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before[continue]after[incr x]} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-6-15" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[return\\ VALUE\\]after\\[incr\\ x\\];set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before[return VALUE]after[incr x]} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-6-16" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[return\\ -code\\ error\\ bad\\]\\ tail;set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {[return -code error bad] tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-6-17" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[return\\ -level\\ 0\\ -code\\ error\\ bad\\]\\ tail;set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {[return -level 0 -code error bad] tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-6-18" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[return\\ -level\\ 0\\ -code\\ 9\\ VALUE\\]tail;set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {[return -level 0 -code 9 VALUE]tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-6-19" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[return\\ -level\\ 2\\ -tag\\ X\\ VALUE\\]tail;set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {[return -level 2 -tag X VALUE]tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-6-20" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[return\\ -level\\ 0\\ -tag\\ X\\ VALUE\\]tail;set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {[return -level 0 -tag X VALUE]tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-6-21" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[error\\ bad\\]tail;set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {[error bad]tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-6-22" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template text\\ \\$missing\\ tail;set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {text $missing tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-6-23" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[incr\\ x\\]\\$\\{unclosed;set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 \\[incr\\ x\\]\\$\\{unclosed 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-6-24" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[break\\]\\$\\{unclosed;set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 \\[break\\]\\$\\{unclosed 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-6-25" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[continue\\]\\$\\{unclosed;set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 \\[continue\\]\\$\\{unclosed 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-6-26" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template backslash\\\\;set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 backslash\\\\ 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-6-27" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template 中文\\$x\\ \\[list\\ 😀\\];set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {中文$x [list 😀]} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-6-28" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template empty\\[\\]word;set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {empty[]word} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-6-29" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template bracket\\]literal;set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 bracket\\]literal 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-6-30" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[\\;#comment\\n\\];set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {[;#comment\n]} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-7-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template plain;set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 plain 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-7-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template quotes\\ \\\"\\ \\$x\\ \\\"\\ braces\\ \\{\\ \\$x\\ \\};set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {quotes \" $x \" braces { $x }} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-7-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$x:\\$x;set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$x:$x} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-7-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template one\\\\ntwo\\\\tthree;set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {one\\ntwo\\tthree} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-7-4" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\\\\\$x\\ \\\\\\[incr\\ x\\\\\\];set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {\\$x \\[incr x\\]} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-7-5" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(index);set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$a(index)} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-7-6" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[incr\\ x\\]);set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$a([incr x])} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-7-7" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[set\\ x\\ 3\\]\\ \\$x;set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {[set x 3] $x} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-7-8" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[set\\ x\\ 3\\;\\]\\ \\$x;set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {[set x 3;] $x} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-7-9" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\\\x69ndex);set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$a(\\x69ndex)} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-7-10" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\$x);set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$a($x)} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-7-11" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\$\\{x\\});set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$a(${x})} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-7-12" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[list\\ \\[incr\\ x\\]\\ \\[incr\\ x\\]\\];set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {[list [incr x] [incr x]]} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-7-13" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[break\\]after\\[incr\\ x\\];set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before[break]after[incr x]} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-7-14" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[continue\\]after\\[incr\\ x\\];set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before[continue]after[incr x]} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-7-15" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[return\\ VALUE\\]after\\[incr\\ x\\];set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before[return VALUE]after[incr x]} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-7-16" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[return\\ -code\\ error\\ bad\\]\\ tail;set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {[return -code error bad] tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-7-17" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[return\\ -level\\ 0\\ -code\\ error\\ bad\\]\\ tail;set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {[return -level 0 -code error bad] tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-7-18" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[return\\ -level\\ 0\\ -code\\ 9\\ VALUE\\]tail;set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {[return -level 0 -code 9 VALUE]tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-7-19" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[return\\ -level\\ 2\\ -tag\\ X\\ VALUE\\]tail;set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {[return -level 2 -tag X VALUE]tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-7-20" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[return\\ -level\\ 0\\ -tag\\ X\\ VALUE\\]tail;set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {[return -level 0 -tag X VALUE]tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-7-21" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[error\\ bad\\]tail;set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {[error bad]tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-7-22" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template text\\ \\$missing\\ tail;set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {text $missing tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-7-23" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[incr\\ x\\]\\$\\{unclosed;set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 \\[incr\\ x\\]\\$\\{unclosed 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-7-24" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[break\\]\\$\\{unclosed;set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 \\[break\\]\\$\\{unclosed 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-7-25" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[continue\\]\\$\\{unclosed;set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 \\[continue\\]\\$\\{unclosed 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-7-26" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template backslash\\\\;set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 backslash\\\\ 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-7-27" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template 中文\\$x\\ \\[list\\ 😀\\];set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {中文$x [list 😀]} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-7-28" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template empty\\[\\]word;set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {empty[]word} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-7-29" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template bracket\\]literal;set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 bracket\\]literal 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax flags-7-30" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\[\\;#comment\\n\\];set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {[;#comment\n]} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-incr x-0-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[incr\\ x;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-incr x-0-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[incr\\ x\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 prefix1tail2 2 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-incr x-1-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[incr\\ x\\;;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 1 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-incr x-1-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[incr\\ x\\;\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 prefix1tail2 2 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-incr x-2-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[incr\\ x\\;set\\ x\\ 9;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 1 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-incr x-2-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[incr\\ x\\;set\\ x\\ 9\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 prefix9tail10 10 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-incr x-3-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[incr\\ x\\;set\\ z\\ \\{bad;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 1 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-incr x-3-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[incr\\ x\\;set\\ z\\ \\{bad\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 1 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-incr x-4-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[incr\\ x\\;set\\ z\\ \\\"bad;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 1 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-incr x-4-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[incr\\ x\\;set\\ z\\ \\\"bad\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 1 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-incr x-5-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[incr\\ x\\;list\\ \\$\\{bad;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 1 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-incr x-5-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[incr\\ x\\;list\\ \\$\\{bad\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 1 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-incr x-6-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[incr\\ x\\;list\\ \\$a(;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 1 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-incr x-6-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[incr\\ x\\;list\\ \\$a(\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 1 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-incr x-7-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[incr\\ x\\;list\\ \\{bad\\}tail;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 1 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-incr x-7-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[incr\\ x\\;list\\ \\{bad\\}tail\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 1 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-incr x-8-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[incr\\ x\\;\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 1 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-incr x-8-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[incr\\ x\\;\\[incr\\ x\\]\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 2 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-break-0-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[break;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-break-0-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[break\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 prefix 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-break-1-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[break\\;;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 prefix 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-break-1-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[break\\;\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 prefix 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-break-2-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[break\\;set\\ x\\ 9;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 prefix 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-break-2-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[break\\;set\\ x\\ 9\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 prefix 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-break-3-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[break\\;set\\ z\\ \\{bad;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 prefix 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-break-3-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[break\\;set\\ z\\ \\{bad\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 prefix 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-break-4-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[break\\;set\\ z\\ \\\"bad;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 prefix 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-break-4-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[break\\;set\\ z\\ \\\"bad\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 prefix 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-break-5-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[break\\;list\\ \\$\\{bad;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 prefix 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-break-5-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[break\\;list\\ \\$\\{bad\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 prefix 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-break-6-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[break\\;list\\ \\$a(;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 prefix 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-break-6-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[break\\;list\\ \\$a(\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 prefix 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-break-7-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[break\\;list\\ \\{bad\\}tail;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 prefix 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-break-7-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[break\\;list\\ \\{bad\\}tail\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 prefix 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-break-8-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[break\\;\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 prefix 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-break-8-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[break\\;\\[incr\\ x\\]\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 prefix 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-continue-0-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[continue;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-continue-0-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[continue\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 prefixtail1 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-continue-1-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[continue\\;;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-continue-1-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[continue\\;\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 prefixtail1 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-continue-2-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[continue\\;set\\ x\\ 9;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-continue-2-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[continue\\;set\\ x\\ 9\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 prefixtail1 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-continue-3-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[continue\\;set\\ z\\ \\{bad;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-continue-3-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[continue\\;set\\ z\\ \\{bad\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-continue-4-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[continue\\;set\\ z\\ \\\"bad;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-continue-4-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[continue\\;set\\ z\\ \\\"bad\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-continue-5-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[continue\\;list\\ \\$\\{bad;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-continue-5-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[continue\\;list\\ \\$\\{bad\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-continue-6-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[continue\\;list\\ \\$a(;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-continue-6-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[continue\\;list\\ \\$a(\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-continue-7-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[continue\\;list\\ \\{bad\\}tail;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-continue-7-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[continue\\;list\\ \\{bad\\}tail\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-continue-8-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[continue\\;\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-continue-8-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[continue\\;\\[incr\\ x\\]\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 prefixtail1 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-return VALUE-0-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[return\\ VALUE;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-return VALUE-0-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[return\\ VALUE\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 prefixVALUEtail1 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-return VALUE-1-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[return\\ VALUE\\;;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-return VALUE-1-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[return\\ VALUE\\;\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 prefixVALUEtail1 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-return VALUE-2-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[return\\ VALUE\\;set\\ x\\ 9;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-return VALUE-2-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[return\\ VALUE\\;set\\ x\\ 9\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 prefixVALUEtail1 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-return VALUE-3-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[return\\ VALUE\\;set\\ z\\ \\{bad;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-return VALUE-3-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[return\\ VALUE\\;set\\ z\\ \\{bad\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-return VALUE-4-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[return\\ VALUE\\;set\\ z\\ \\\"bad;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-return VALUE-4-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[return\\ VALUE\\;set\\ z\\ \\\"bad\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-return VALUE-5-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[return\\ VALUE\\;list\\ \\$\\{bad;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-return VALUE-5-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[return\\ VALUE\\;list\\ \\$\\{bad\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-return VALUE-6-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[return\\ VALUE\\;list\\ \\$a(;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-return VALUE-6-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[return\\ VALUE\\;list\\ \\$a(\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-return VALUE-7-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[return\\ VALUE\\;list\\ \\{bad\\}tail;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-return VALUE-7-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[return\\ VALUE\\;list\\ \\{bad\\}tail\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-return VALUE-8-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[return\\ VALUE\\;\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-return VALUE-8-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[return\\ VALUE\\;\\[incr\\ x\\]\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 prefixVALUEtail1 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-return -level 0 -code 9 VALUE-0-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[return\\ -level\\ 0\\ -code\\ 9\\ VALUE;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-return -level 0 -code 9 VALUE-0-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[return\\ -level\\ 0\\ -code\\ 9\\ VALUE\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 prefixVALUEtail1 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-return -level 0 -code 9 VALUE-1-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[return\\ -level\\ 0\\ -code\\ 9\\ VALUE\\;;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-return -level 0 -code 9 VALUE-1-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[return\\ -level\\ 0\\ -code\\ 9\\ VALUE\\;\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 prefixVALUEtail1 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-return -level 0 -code 9 VALUE-2-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[return\\ -level\\ 0\\ -code\\ 9\\ VALUE\\;set\\ x\\ 9;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-return -level 0 -code 9 VALUE-2-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[return\\ -level\\ 0\\ -code\\ 9\\ VALUE\\;set\\ x\\ 9\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 prefixVALUEtail1 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-return -level 0 -code 9 VALUE-3-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[return\\ -level\\ 0\\ -code\\ 9\\ VALUE\\;set\\ z\\ \\{bad;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-return -level 0 -code 9 VALUE-3-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[return\\ -level\\ 0\\ -code\\ 9\\ VALUE\\;set\\ z\\ \\{bad\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-return -level 0 -code 9 VALUE-4-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[return\\ -level\\ 0\\ -code\\ 9\\ VALUE\\;set\\ z\\ \\\"bad;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-return -level 0 -code 9 VALUE-4-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[return\\ -level\\ 0\\ -code\\ 9\\ VALUE\\;set\\ z\\ \\\"bad\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-return -level 0 -code 9 VALUE-5-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[return\\ -level\\ 0\\ -code\\ 9\\ VALUE\\;list\\ \\$\\{bad;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-return -level 0 -code 9 VALUE-5-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[return\\ -level\\ 0\\ -code\\ 9\\ VALUE\\;list\\ \\$\\{bad\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-return -level 0 -code 9 VALUE-6-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[return\\ -level\\ 0\\ -code\\ 9\\ VALUE\\;list\\ \\$a(;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-return -level 0 -code 9 VALUE-6-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[return\\ -level\\ 0\\ -code\\ 9\\ VALUE\\;list\\ \\$a(\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-return -level 0 -code 9 VALUE-7-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[return\\ -level\\ 0\\ -code\\ 9\\ VALUE\\;list\\ \\{bad\\}tail;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-return -level 0 -code 9 VALUE-7-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[return\\ -level\\ 0\\ -code\\ 9\\ VALUE\\;list\\ \\{bad\\}tail\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-return -level 0 -code 9 VALUE-8-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[return\\ -level\\ 0\\ -code\\ 9\\ VALUE\\;\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-return -level 0 -code 9 VALUE-8-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[return\\ -level\\ 0\\ -code\\ 9\\ VALUE\\;\\[incr\\ x\\]\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 prefixVALUEtail1 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-error bad-0-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[error\\ bad;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-error bad-0-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[error\\ bad\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-error bad-1-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[error\\ bad\\;;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-error bad-1-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[error\\ bad\\;\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-error bad-2-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[error\\ bad\\;set\\ x\\ 9;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-error bad-2-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[error\\ bad\\;set\\ x\\ 9\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-error bad-3-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[error\\ bad\\;set\\ z\\ \\{bad;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-error bad-3-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[error\\ bad\\;set\\ z\\ \\{bad\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-error bad-4-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[error\\ bad\\;set\\ z\\ \\\"bad;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-error bad-4-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[error\\ bad\\;set\\ z\\ \\\"bad\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-error bad-5-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[error\\ bad\\;list\\ \\$\\{bad;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-error bad-5-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[error\\ bad\\;list\\ \\$\\{bad\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-error bad-6-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[error\\ bad\\;list\\ \\$a(;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-error bad-6-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[error\\ bad\\;list\\ \\$a(\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-error bad-7-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[error\\ bad\\;list\\ \\{bad\\}tail;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-error bad-7-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[error\\ bad\\;list\\ \\{bad\\}tail\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-error bad-8-False" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[error\\ bad\\;\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax bracket-error bad-8-True" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template prefix\\[error\\ bad\\;\\[incr\\ x\\]\\]tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax variable-incr x-" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax variable-incr x-)" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[incr\\ x\\]);set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeONE 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax variable-incr x-[incr x])" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[incr\\ x\\]\\[incr\\ x\\]);set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 2 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax variable-incr x-${bad)" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[incr\\ x\\]\\$\\{bad);set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax variable-incr x-[set z {bad])" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[incr\\ x\\]\\[set\\ z\\ \\{bad\\]);set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax variable-incr x-)tail[incr x]" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[incr\\ x\\])tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeONEtail2 2 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax variable-break-" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[break\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax variable-break-)" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[break\\]);set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 before 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax variable-break-[incr x])" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[break\\]\\[incr\\ x\\]);set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 before 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax variable-break-${bad)" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[break\\]\\$\\{bad);set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax variable-break-[set z {bad])" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[break\\]\\[set\\ z\\ \\{bad\\]);set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax variable-break-)tail[incr x]" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[break\\])tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 before 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax variable-continue-" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[continue\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax variable-continue-)" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[continue\\]);set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 before 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax variable-continue-[incr x])" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[continue\\]\\[incr\\ x\\]);set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 before 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax variable-continue-${bad)" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[continue\\]\\$\\{bad);set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax variable-continue-[set z {bad])" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[continue\\]\\[set\\ z\\ \\{bad\\]);set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax variable-continue-)tail[incr x]" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[continue\\])tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforetail1 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax variable-return index-" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[return\\ index\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax variable-return index-)" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[return\\ index\\]);set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeindex 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax variable-return index-[incr x])" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[return\\ index\\]\\[incr\\ x\\]);set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeindex 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax variable-return index-${bad)" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[return\\ index\\]\\$\\{bad);set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax variable-return index-[set z {bad])" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[return\\ index\\]\\[set\\ z\\ \\{bad\\]);set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax variable-return index-)tail[incr x]" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[return\\ index\\])tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeindextail1 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax variable-return -level 0 -code 9 index-" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[return\\ -level\\ 0\\ -code\\ 9\\ index\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax variable-return -level 0 -code 9 index-)" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[return\\ -level\\ 0\\ -code\\ 9\\ index\\]);set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeindex 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax variable-return -level 0 -code 9 index-[incr x])" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[return\\ -level\\ 0\\ -code\\ 9\\ index\\]\\[incr\\ x\\]);set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeindex 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax variable-return -level 0 -code 9 index-${bad)" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[return\\ -level\\ 0\\ -code\\ 9\\ index\\]\\$\\{bad);set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax variable-return -level 0 -code 9 index-[set z {bad])" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[return\\ -level\\ 0\\ -code\\ 9\\ index\\]\\[set\\ z\\ \\{bad\\]);set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax variable-return -level 0 -code 9 index-)tail[incr x]" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[return\\ -level\\ 0\\ -code\\ 9\\ index\\])tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeindextail1 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax variable-error bad-" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[error\\ bad\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax variable-error bad-)" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[error\\ bad\\]);set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax variable-error bad-[incr x])" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[error\\ bad\\]\\[incr\\ x\\]);set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax variable-error bad-${bad)" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[error\\ bad\\]\\$\\{bad);set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax variable-error bad-[set z {bad])" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[error\\ bad\\]\\[set\\ z\\ \\{bad\\]);set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax variable-error bad-)tail[incr x]" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[error\\ bad\\])tail\\[incr\\ x\\];set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax option--nob" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$x\\ \\[incr\\ x\\]\\ \\\\n;set code [catch {subst -nob $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {0 1 \\n} 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax option--noc" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$x\\ \\[incr\\ x\\]\\ \\\\n;set code [catch {subst -noc $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {0 [incr x] \n} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax option--nov" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$x\\ \\[incr\\ x\\]\\ \\\\n;set code [catch {subst -nov $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$x 1 \n} 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax option--noback" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$x\\ \\[incr\\ x\\]\\ \\\\n;set code [catch {subst -noback $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {0 1 \\n} 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax option--nob -nob" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$x\\ \\[incr\\ x\\]\\ \\\\n;set code [catch {subst -nob -nob $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {0 1 \\n} 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax option--nov -noc" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$x\\ \\[incr\\ x\\]\\ \\\\n;set code [catch {subst -nov -noc $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$x [incr x] \n} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax option--n" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$x\\ \\[incr\\ x\\]\\ \\\\n;set code [catch {subst -n $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax option--no" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$x\\ \\[incr\\ x\\]\\ \\\\n;set code [catch {subst -no $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax option---" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$x\\ \\[incr\\ x\\]\\ \\\\n;set code [catch {subst -- $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax option--bad" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$x\\ \\[incr\\ x\\]\\ \\\\n;set code [catch {subst -bad $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax option-{}" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$x\\ \\[incr\\ x\\]\\ \\\\n;set code [catch {subst {} $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax last-argument--nocommands" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("subst -nocommands", budget=100000), "-nocommands")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax last-argument---" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("subst --", budget=100000), "--")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax last-argument--" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("subst -", budget=100000), "-")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax last-argument-\\" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("subst \\\\", budget=100000), "\\")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax last-argument-\\\n" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("subst \\\\\\n", budget=100000), " ")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-explicit-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete {}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-explicit-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\\\", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-explicit-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete abc\\\\", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-explicit-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete abc\\\\\\n", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-explicit-4" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete abc\\\\\\n\\ \\ ", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-explicit-5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete #\\ x\\\\", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-explicit-6" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\[", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-explicit-7" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\{", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-explicit-8" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete list\\ \\{a\\}b\\ \\{", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-explicit-9" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete list\\ \\\"a\\\"b\\ \\[", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-explicit-10" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete list\\ a\\{", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-explicit-11" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete list\\ a\\\"", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-explicit-12" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete list\\ \\$a(", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-explicit-13" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete list\\ \\$", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-explicit-14" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete list\\ \\$(", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-explicit-15" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete list\\ \\$\\{a", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-explicit-16" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete list\\ #\\ \\[", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-explicit-17" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete list\\ \\[#\\ a\\]", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-explicit-18" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\[#\\ a\\n\\]", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-explicit-19" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete set\\ x\\ \\{\\[foo\\]\\}", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-explicit-20" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete set\\ x\\ \\[list\\ \\{\\]\\}\\]", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-explicit-21" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete set\\ x\\ \\\"a\\\\\\nb\\\"", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-explicit-22" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete list\\ \\{*\\}\\[list\\ a\\ b\\]", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-explicit-23" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete list\\ \\{*\\}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-explicit-24" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete list\\ \\{*\\}\\{\\}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-explicit-25" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete list\\ \\{*\\}\\\"a\\\"b", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-explicit-26" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete list\\ a\\\\\\n", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-explicit-27" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete #\\ x\\\\\\n", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-explicit-28" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete #\\ x\\\\\\\\\\n", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-explicit-29" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete list\\ a\\\\\\\\\\n", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-explicit-30" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete list\\ a\\\\\\\\\\\\\\n", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete list\\ \\;\\$\\{", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\$\\{)\\;)\\\"\\n\\]\\$a(*)set\\ x\\ ",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\$\\{#commentlist\\ a\\$\\{", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete #comment\\[", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-4" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\;\\\\\\n\\$xlist\\ \\\"\\ \\$a(\\\"\\\\a",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-5" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\\")set\\ x\\ \\\\**\\ \\ \\\\\\n\\$x",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-6" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\$x)\\$\\{\\ \\;a*\\\\\\n\\}\\;aset\\ x\\ ",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-7" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\\\\\$\\{\\$x\\\\\\n\\ \\}#commentlist\\ a\\{",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-8" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete *\\$xlist\\ \\\\\\n\\ #comment\\}*list\\ *",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-9" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\])))\\]", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-10" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\[\\$x\\$x", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-11" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete a\\nlist\\ #comment", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-12" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete set\\ x\\ \\ )\\}\\{\\}\\;", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-13" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\$a(\\{\\\\\\\"\\ \\{\\{\\[", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-14" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\\"", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-15" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\}\\[\\{\\\\\\n\\ *\\}\\n\\\\\\n\\ ", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-16" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\$a(\\$\\{\\ )", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-17" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\\\\\n\\ \\n\\\\a\\\\\\\\\\n*", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-18" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete set\\ x\\ )\\ \\$\\{", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-19" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\\\\\n\\ set\\ x\\ \\}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-20" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\{*\\$x\\n\\\")\\\\\\n", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-21" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete #comment\\{)\\]\\$x\\]set\\ x\\ ", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-22" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete *\\[", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-23" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete )\\$x)a\\\\*", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-24" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete aset\\ x\\ #comment\\$\\{", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-25" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\$x\\[\\{\\\"\\[\\$x\\]\\\\\\n\\ \\}\\$x\\$a(",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-26" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\$\\{\\[\\]", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-27" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\[", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-28" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete *\\]\\\\#comment\\}*#comment\\\\\\n", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-29" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\;#comment", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-30" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\\")\\n\\\\\\n\\$\\{\\;\\{\\$\\{", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-31" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\\"\\\\\\n\\ \\{#comment\\\\#comment\\n\\}\\;list\\ \\;",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-32" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\{\\$a(\\$x\\}\\\"", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-33" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\$a(a#commenta\\\"\\\\\\n\\ \\ \\\"list\\ \\\"\\$a(",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-34" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\$a(\\$\\{\\$a(list\\ \\}set\\ x\\ ", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-35" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\$\\{set\\ x\\ \\\"\\\"", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-36" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\{)list\\ *\\$x\\$\\{)a\\[aa\\{", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-37" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\\\", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-38" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\}\\$a(\\{*", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-39" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\;\\\\\\nset\\ x\\ \\\\a*#comment\\\"\\[set\\ x\\ \\;set\\ x\\ ",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-40" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\[", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-41" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\}\\\\\\n\\{\\\\\\n\\ \\\\*\\{", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-42" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete *\\n\\\\\\n", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-43" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\;#comment#comment\\$a(\\\"\\n\\\\\\n\\ \\{\\]\\$\\{\\ ",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-44" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete list\\ *\\;", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-45" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\$a(#comment\\]\\ \\$a(*\\\\\\n\\ *\\;list\\ set\\ x\\ \\;",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-46" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete *)\\nlist\\ \\ \\$x\\}\\ list\\ ", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-47" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\$x\\\"\\n", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-48" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\n\\]\\\\\\nlist\\ \\\"\\\\\\\\\\$a(\\\\\\n\\[",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-49" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete ***\\[\\\\\\\\\\n\\ \\$xset\\ x\\ ", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-50" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\\"\\$\\{*\\$\\{list\\ \\$x#comment", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-51" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete #comment\\}\\\\\\n*\\n#comment\\[", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-52" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\ \\\\\\nset\\ x\\ \\]", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-53" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\{\\{\\ \\\"\\;\\\\)\\{", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-54" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete set\\ x\\ set\\ x\\ list\\ \\;)\\$a(*", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-55" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\\\\\n", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-56" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\$x#comment\\}#comment#commentlist\\ \\}\\$\\{\\\\\\}",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-57" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete )\\$a(\\$a(", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-58" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete *\\{*\\]\\ \\$\\{\\\"a\\$a(", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-59" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\\\\\n\\$a(\\$x\\ \\n\\\"*list\\ \\[\\n\\\\\\nset\\ x\\ ",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-60" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\{\\\\set\\ x\\ \\[\\{\\[\\\\\\n", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-61" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\$x\\$\\{)\\{\\n\\n\\$x", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-62" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\\\\\n\\ \\;\\\\\\n\\ )", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-63" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\}\\\\\\n", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-64" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\ \\}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-65" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\\"\\;", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-66" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\\\\\n\\ \\n\\}*#comment\\[\\\"\\$a(set\\ x\\ list\\ \\}",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-67" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\\"a\\\\\\$x", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-68" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\ \\ \\\\\\$\\{\\ \\{a\\]\\[\\\\\\n\\ ",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-69" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete *#comment\\$x\\$a(\\$x\\$x\\\"", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-70" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete list\\ \\n\\;set\\ x\\ \\\\\\n\\ #comment\\]\\;\\\\\\n\\ \\$x\\n\\\"\\$\\{",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-71" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete #comment\\$\\{#comment\\\\\\n\\ \\$x)\\{\\{#comment\\;\\\"\\[",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-72" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete *\\}\\{aset\\ x\\ ", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-73" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\{\\;\\\\\\n\\ \\ \\$\\{*", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-74" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\\\\\n\\ ", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-75" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\}\\n\\\\\\{set\\ x\\ \\\"list\\ set\\ x\\ \\\\\\n\\ \\ \\\"\\\\\\n\\ ",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-76" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\\\\\n\\ \\\\\\n)\\{*\\\\\\nset\\ x\\ \\\\\\n",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-77" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\$\\{list\\ ", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-78" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\{\\$a(\\ \\$x\\[\\\\\\na", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-79" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete #comment)#comment\\$\\{\\ \\nlist\\ \\\\\\n\\[",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-80" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\$x\\[", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-81" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\}\\\\\\$a(\\$\\{\\[\\{a)list\\ ", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-82" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete )\\$a(\\$\\{\\\\\\n*\\\\\\n\\ set\\ x\\ \\$x\\$\\{",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-83" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\[list\\ \\{set\\ x\\ #comment\\;\\\\\\]\\{\\\\",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-84" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete )list\\ ", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-85" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\}\\[\\}\\{\\\\\\n\\\\\\n)\\n\\\"", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-86" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\$x\\\\\\n\\$x\\$\\{\\\\\\n\\ \\\"#comment\\$\\{",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-87" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\}\\ \\\\\\n\\\\\\[\\ *\\\"\\}\\$x", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-88" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\}\\\\\\\\\\\"\\]\\nlist\\ \\\"\\\"\\$x\\;\\}\\n",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-89" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\\"\\$x*\\ \\$\\{", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-90" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete *)\\ \\;\\]", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-91" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete )", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-92" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\]\\$x\\\"\\\"\\$x\\{\\ \\n\\}\\ )\\$x",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-93" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete set\\ x\\ \\\"\\{set\\ x\\ ", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-94" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete list\\ \\}\\{\\}\\$\\{\\$\\{\\n", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-95" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete a#comment\\ a\\$\\{\\$x", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-96" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\ \\n\\\\\\n\\n\\\"\\\"\\\"", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-97" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete a\\$x\\$a(\\\")\\[\\{\\{a", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-98" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete list\\ \\n)\\n*\\ \\$x\\$a(", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-99" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete *\\\\\\n\\]\\]\\}\\$a(\\\\\\ \\$x", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-100" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete *\\\\\\n\\[\\])*\\\\\\n\\ \\n\\]*", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-101" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete set\\ x\\ \\]", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-102" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\$x\\\\\\n#comment\\ \\$a(\\$a(", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-103" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\\\", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-104" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete list\\ \\\\\\n\\ \\$\\{\\}\\$x\\\\", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-105" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\$x\\\"\\\\\\n)\\;set\\ x\\ a\\\\\\\\\\n\\$\\{",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-106" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete #comment\\\\\\n\\}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-107" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\$\\{\\]\\}\\]\\}#comment", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-108" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\$a(\\[\\n\\]\\$\\{\\{\\;\\}\\\\\\n\\ ",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-109" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\\\\\n\\\\\\nlist\\ *\\\\\\$\\{alist\\ )*",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-110" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\$xlist\\ ", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-111" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\$\\{\\{\\$x\\$x*\\\\\\n", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-112" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\ ", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-113" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete )\\{\\n", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-114" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\$x\\ \\{a\\\"\\[\\\\\\n\\;\\$x\\;", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-115" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\$a(\\\"list\\ ", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-116" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\;\\$\\{\\\\\\nset\\ x\\ \\$\\{list\\ \\{\\$\\{\\\\\\n\\$\\{\\\\",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-117" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\ #comment", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-118" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\\\\\\"", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-119" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\}\\\\\\n\\$x\\}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-120" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\{\\$a(list\\ \\\")\\ *", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-121" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\;a\\nset\\ x\\ \\;\\$x#commentset\\ x\\ ",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-122" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\$\\{set\\ x\\ )", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-123" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete )\\$x\\\\\\ \\}\\\\\\n", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-124" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete )", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-125" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\\"*)", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-126" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\\\\\n\\ \\}\\$x\\\\\\n\\]", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-127" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\{", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-128" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete *\\\\\\n\\{\\n\\[\\nlist\\ \\$x", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-129" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\$\\{", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-130" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\$\\{a\\;#comment", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-131" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\]", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-132" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\\\\\}list\\ ", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-133" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete a)\\$a(\\{\\{\\ \\n*\\n\\\\\\nset\\ x\\ ",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-134" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete *\\$\\{\\$x", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-135" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\{\\]\\\"\\]\\$x*\\]", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-136" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\;\\;\\;\\{\\{\\]#comment\\;\\$x", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-137" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete a\\\\\\n\\ \\\\\\n\\ \\$xset\\ x\\ *\\}\\\\",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-138" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\$x\\\\\\n#comment\\n\\$a(", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-139" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete )a\\\"", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-140" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\n\\}\\$\\{\\ ", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-141" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete aset\\ x\\ #comment\\ \\\\\\n\\ aset\\ x\\ list\\ *set\\ x\\ ",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-142" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete a\\{list\\ \\}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-143" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\}\\ \\$a(a", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-144" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\}\\n\\$x\\ \\\\\\n\\ **)", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-145" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete #comment\\{set\\ x\\ )list\\ a\\\"\\\\\\n\\ ",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-146" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\\"\\$x#comment\\n\\\\)\\\\\\n\\ \\\\\\\\\\n)\\]list\\ \\\\",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-147" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\ \\\\\\\\\\n\\{\\]", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-148" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\\"\\$a()\\[))*\\$x\\\"\\{", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-149" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\$a(*\\}\\\\\\nset\\ x\\ \\\"\\\\\\$x",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-150" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\\\\\n\\ \\\\\\n\\}\\[\\$a(\\$x*\\]\\\\\\na\\}",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-151" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\ \\\\*\\\\\\}\\$a(\\{*\\$a(\\[*\\{\\\\\\n",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-152" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\;\\;\\\\\\n\\ set\\ x\\ \\\\\\n", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-153" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\{", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-154" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete set\\ x\\ \\]\\\"\\]*a#comment*\\ \\$\\{\\\\\\n\\ set\\ x\\ ",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-155" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete *\\[", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-156" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete set\\ x\\ \\;a#comment", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-157" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\;\\\\\\n\\ set\\ x\\ \\\\\\n\\ \\\\\\{\\;list\\ \\n\\{*\\[",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-158" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete list\\ a*\\]\\[\\$a(", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-159" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\$a(#comment\\$x\\$x\\}\\]set\\ x\\ \\n)\\\"\\\\\\n\\\\",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-160" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete set\\ x\\ \\;\\\\\\n\\\\\\n", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-161" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\ list\\ ", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-162" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\$\\{#comment\\]\\$x*\\\\\\n\\ \\\\\\n\\$a(*list\\ ",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-163" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\\"\\\"\\;\\$xlist\\ list\\ #commenta\\\\\\n",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-164" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete #comment\\;a\\\\\\n\\$x\\{aset\\ x\\ \\\"\\$\\{\\\\\\n",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-165" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\$\\{\\{\\\"\\]\\\\\\n\\ \\\\\\]\\\\\\$a(\\$a(\\ \\[#comment",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-166" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\[\\ ", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-167" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\{\\$a(list\\ \\]\\n", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-168" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\;list\\ list\\ a\\$a()\\[\\{", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-169" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\{\\\\\\n\\\"\\\\\\n\\ \\ \\[", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-170" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\$\\{\\\\\\\\\\n*\\\\\\n\\ \\}\\\\\\n\\ *",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-171" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete a\\\"\\ \\[list\\ aa", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-172" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\nset\\ x\\ \\[\\}list\\ ", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-173" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-174" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete list\\ \\{set\\ x\\ \\\\\\$x\\}#comment",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-175" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\$x\\n", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-176" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete list\\ list\\ \\ \\$x)\\ *\\$\\{\\;\\\\\\n\\ \\$x",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-177" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\{\\\\\\]\\{\\}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-178" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete list\\ \\[*\\ #comment\\$\\{\\\\\\n\\ \\[",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-179" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\}\\\"list\\ **set\\ x\\ \\\\\\$\\{\\\\#comment\\]",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-180" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\ \\{\\{)\\{\\$\\{list\\ \\ \\\\\\n\\{",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-181" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete #comment\\]\\$a(\\\\\\n)\\{)\\\\\\n\\ *",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-182" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete list\\ list\\ ", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-183" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\\"\\\\\\\\\\n\\{\\ \\[\\ ", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-184" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete )a*\\\\\\n\\\\\\n\\ #comment", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-185" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete *\\\\\\n\\ \\]set\\ x\\ *\\$x\\$x\\;\\\\\\n\\ \\{",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-186" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\{", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-187" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\\"\\$a(\\}\\[\\$\\{*a\\$x\\n\\\\\\n", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-188" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\\\\\n\\ #comment\\$\\{list\\ \\\\\\n\\ \\\\\\n\\$a(\\{\\\\\\n\\ list\\ ",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-189" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\;\\ \\\\\\n\\ \\\\\\n\\ \\[\\n", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-190" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\na\\{\\ \\$\\{\\$x\\$a()", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-191" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\$x\\$\\{)\\]\\$a(", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-192" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete #comment#commentset\\ x\\ \\\"\\$\\{\\n",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-193" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\\\\\n\\ \\{", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-194" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete list\\ \\})a\\\\\\;#comment\\ \\\\\\n\\ \\[",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-195" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\\")\\\\\\[)\\\\list\\ ", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-196" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\$\\{list\\ \\$a(\\\\\\n\\ \\\\\\}\\\\\\n\\{\\[",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-197" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\\\)\\$a(\\ \\\"\\[\\[\\$x", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-198" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\\\\\n\\ ", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-199" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\[)\\$x\\]\\]set\\ x\\ \\\\\\{\\$\\{\\{\\$xset\\ x\\ ",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-200" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete )\\{\\\\\\n", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-201" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\$a(", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-202" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\[\\;\\\\\\n\\\\\\n\\$a(\\$\\{\\$\\{\\}list\\ ",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-203" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\}\\\"\\}\\{set\\ x\\ )\\$\\{\\{\\n", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-204" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\nlist\\ \\}\\\\\\n\\]\\[\\\\\\n\\ \\}",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-205" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\\"\\\\\\n\\[\\ \\\\\\n\\ \\$a(\\\\\\n\\ #comment)",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-206" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete set\\ x\\ \\\\\\n\\{list\\ \\\"\\[\\]set\\ x\\ ",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-207" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\;*aset\\ x\\ \\\\set\\ x\\ ", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-208" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\\"\\\\*\\$\\{\\}\\}\\\\\\n\\}set\\ x\\ set\\ x\\ \\\"\\\\\\n\\ \\\\\\n",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-209" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\$a(\\\\\\n\\ ", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-210" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete aset\\ x\\ \\;\\n", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-211" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\$a(\\n\\$x\\$\\{\\}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-212" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\$a(\\\\\\n\\ set\\ x\\ list\\ )\\\\\\nlist\\ \\{",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-213" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete #comment\\{a\\$x", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-214" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\$xlist\\ \\;\\]\\$x#comment\\$a(\\}list\\ \\$\\{\\}\\\\",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-215" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete )\\n\\;\\{", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-216" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\\"set\\ x\\ ", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-217" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete #comment\\\\\\n\\\\\\n\\\"a\\;\\$x\\$a(\\]\\{",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-218" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete #comment\\[\\ \\{#comment\\\"", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-219" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete #commenta)\\n\\\"\\{set\\ x\\ \\[set\\ x\\ list\\ ",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-220" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\$x\\$x\\;\\]*\\\\\\n\\\\\\n\\n*\\$\\{\\$xlist\\ ",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-221" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\$x\\]\\[\\\\\\n\\{\\\\\\n\\ \\\\\\\"\\\\\\$x\\ ",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-222" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\n\\\\\\n\\ ", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-223" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\\\\\n", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-224" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete )\\\")*a\\}*\\$x", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-225" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete set\\ x\\ \\\"\\{\\}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-226" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\{a\\ \\n\\\\\\n\\ \\;", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-227" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete )", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-228" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\\\\\n\\ \\ *\\n\\$\\{\\\\", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-229" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\]\\}list\\ \\;\\$a()\\$\\{", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-230" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete *", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-231" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\}*\\\\\\n\\ \\$x\\$x\\[\\{\\\\\\n\\]",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-232" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete *\\]#comment\\]\\na\\\\\\n", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-233" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\\\\\n\\ \\$x\\;\\\\\\$a(\\]\\$x\\$a()\\\"",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-234" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\{\\ \\\\\\n\\ *", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-235" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\{\\$\\{\\;\\$a(\\{a\\\\\\nset\\ x\\ \\$x\\$x",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-236" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\n#comment", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-237" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete set\\ x\\ set\\ x\\ )\\$x\\;\\;a\\ \\\\\\\\\\]set\\ x\\ ",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-238" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\$a(\\n)#comment\\$a(\\\\\\n#comment\\ \\}\\}\\;",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-239" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\]list\\ \\\\\\\\\\n\\;\\$x\\\\", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-240" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\$x\\[\\{\\n\\\\\\n\\ #comment#comment*set\\ x\\ )\\n",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-241" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\[\\;set\\ x\\ \\ \\na)*\\]\\]\\\\\\n",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-242" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete list\\ \\ list\\ a\\[\\])\\{\\\\\\$a(", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-243" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\ \\{list\\ ", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-244" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\}\\[a\\ list\\ #comment*\\\\list\\ \\\\\\$\\{",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-245" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\;\\\\\\$\\{\\$x\\\\\\;\\[\\}", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-246" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\{\\\\\\nlist\\ *\\\"", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-247" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\}\\]#comment\\n\\\")\\$x\\]", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-248" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\\\\\n\\ list\\ set\\ x\\ \\\\\\nset\\ x\\ )\\}set\\ x\\ ",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-249" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\\\\\$xlist\\ ", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-250" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete set\\ x\\ ", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-251" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\$x\\\\\\]\\\\\\n\\\\\\n\\ set\\ x\\ \\]\\\\\\n\\ set\\ x\\ \\$\\{\\ \\{",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-252" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\ \\]\\})", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-253" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\ \\\"\\nset\\ x\\ \\}\\\\\\n\\$x", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-254" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete )", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-255" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\\"#comment\\na", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-256" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete a\\\\\\n\\ #comment\\\"\\[", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-257" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\\\\\}\\\\set\\ x\\ \\\"#comment\\\\\\n\\ ",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-258" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\$a(a\\$xa\\]a*\\}\\;\\$x\\$a(", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-259" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\]\\$x\\\\\\n\\ #comment\\$x*\\n\\\"\\$x\\\\",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-260" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete set\\ x\\ *", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-261" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete #commentlist\\ \\\\\\n\\[set\\ x\\ \\$x\\;",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-262" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete list\\ \\n\\\\\\n\\[list\\ \\;", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-263" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\}\\{", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-264" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\{\\n\\{\\\\\\nset\\ x\\ \\ **\\[\\\\\\n",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-265" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\$a(\\$\\{\\]set\\ x\\ #comment\\[\\}",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-266" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\$xaset\\ x\\ set\\ x\\ \\{\\$x\\$a(*#comment",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-267" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete *\\n\\$\\{set\\ x\\ a\\\"#comment\\$a(\\}",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-268" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\\\\\n\\ \\\"\\\\\\nset\\ x\\ \\$\\{\\[\\$a(\\\\\\n\\[\\\\\\nlist\\ \\$a(",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-269" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\}a\\$\\{)*a", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-270" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\]\\$\\{", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-271" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\}a\\]\\\\\\n)\\;#comment", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-272" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete )#comment\\[#commentlist\\ )\\$x\\\\\\n\\]#comment",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-273" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\{\\ set\\ x\\ \\$\\{\\{set\\ x\\ ", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-274" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\]", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-275" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete *a#commentset\\ x\\ #comment\\ \\$\\{\\\\\\n\\ \\}",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-276" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\n\\[", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-277" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\ \\$\\{list\\ \\$x\\$a(\\\\\\\\\\n\\ )\\;",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-278" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\ *\\}\\]\\\\\\n\\ )\\ list\\ \\$x\\\"\\;\\\\",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-279" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\]#commentset\\ x\\ \\$\\{\\\"\\\\\\n\\ ",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-280" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete set\\ x\\ \\$a(\\$\\{\\]\\}list\\ \\n\\n\\$a(\\[\\\\\\n\\;)",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-281" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete #comment\\ \\$\\{\\;\\n\\\\\\n*\\[", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-282" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\;list\\ alist\\ \\ ", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-283" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete )\\$x\\]\\n)\\$x\\;\\n\\\"\\$a(a", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-284" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\$a(#commentlist\\ \\}\\$\\{", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-285" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete )list\\ )\\[\\\\\\n\\\\\\nlist\\ ", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-286" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete a#comment", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-287" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\\\\\n\\ )\\n\\{\\\\\\\\\\n\\ \\\\\\n\\ set\\ x\\ \\\\\\n\\\\",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-288" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete *\\\\\\n\\ \\$a(#comment\\nset\\ x\\ \\[\\$\\{\\$x\\\"\\}",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-289" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\\\\\}\\\\\\ list\\ \\$a(\\]\\}\\[\\$x\\;",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-290" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete #comment\\$x\\$a(", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-291" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\\\\\$x", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-292" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete a\\{\\{\\{\\\\\\]\\]\\[\\ *\\\\\\$\\{", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-293" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\;\\$x\\\\\\n\\ *\\\\\\n\\ \\ \\ set\\ x\\ ",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-294" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\\\\\$x\\\\\\$a(\\{", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-295" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\;\\\\\\n\\]\\$\\{\\]\\$\\{*\\[\\\\\\n\\ \\$x\\\"",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-296" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\;\\;\\$\\{\\\\\\n\\ ", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-297" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\\\\\n)list\\ \\}\\]\\\\\\n\\ #comment\\ #comment\\;\\}*list\\ ",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-298" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete *\\\\", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-299" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete *\\\\\\n\\]list\\ \\\\\\n\\}\\\"*\\\\\\}a",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-300" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\[", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-301" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\$x\\;\\\\\\n\\ \\$\\{set\\ x\\ )\\$\\{\\]a\\$\\{\\ \\}",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-302" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete list\\ \\\")\\\"\\ \\$x", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-303" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\$a(list\\ *\\]\\;\\{list\\ #comment\\n",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-304" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete set\\ x\\ \\\"\\n#comment\\\\\\n\\ \\\\\\$a(\\;\\ ",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-305" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\[\\;", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-306" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\;set\\ x\\ \\$\\{#comment\\$\\{#comment\\]\\\\",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-307" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete set\\ x\\ )\\;*\\\\\\n\\\"\\\\\\nset\\ x\\ set\\ x\\ *list\\ \\$\\{",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-308" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\]#comment", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-309" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete #comment)\\ aset\\ x\\ \\\\\\n\\ ", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-310" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\;", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-311" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete )\\ set\\ x\\ \\;\\]\\\\\\n\\$x", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-312" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\$\\{\\ a", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-313" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\\\\\n\\ \\\\\\n\\ ", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-314" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\[\\ )*\\}\\\"", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-315" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\;a\\$a(a", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-316" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\\\\\nset\\ x\\ \\;list\\ \\;\\]\\$\\{list\\ *\\n",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-317" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\\\\\n#comment#comment", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-318" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\ \\$x#comment)\\$x", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-319" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\$x\\\\*\\{set\\ x\\ ", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-320" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\\\\\n\\}\\$xa#comment\\\\\\\"*\\ \\\"\\$a(set\\ x\\ ",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-321" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\$\\{\\ a\\[\\\\\\n\\$a(\\\"\\[\\\\\\\\",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-322" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\ \\;\\\\\\n\\ list\\ \\$\\{#comment)\\$\\{\\$x\\$x",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-323" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\{\\\\\\n\\nlist\\ \\\\\\n\\\\\\n", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-324" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete *\\;\\{a)\\]\\\")\\\\", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-325" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\\\\\n\\ )\\$a()***\\\\\\n\\ set\\ x\\ \\$\\{",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-326" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\$x\\$x\\]", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-327" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\ \\$a(\\{\\ \\\"a\\\\\\n\\ alist\\ \\]\\;\\$a(",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-328" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\ \\$a(list\\ \\n\\[\\\"list\\ \\$x\\$x",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-329" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete a\\$x\\[set\\ x\\ list\\ list\\ ))\\}a\\$a(*",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-330" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete a\\[set\\ x\\ \\\"\\$x\\\\\\n\\ \\\"\\$x*a\\\\\\}",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-331" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\{\\}\\$\\{\\})\\ ", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-332" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\\\\\\\\\n\\ ", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-333" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete *list\\ *#comment\\$\\{*\\\\\\n\\ \\]\\[",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-334" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\\\\\n\\ \\\"#commentset\\ x\\ \\$a(\\;",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-335" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\$xset\\ x\\ \\\\\\n\\ #comment\\[\\$x\\\"list\\ a\\\\\\n#comment\\$\\{",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-336" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\\"\\\\\\nset\\ x\\ a\\n", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-337" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\\"\\\\\\n\\ \\\\\\\"list\\ \\\\\\n\\ ",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-338" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\ \\\\\\n\\ \\\\\\nlist\\ \\$a(\\ ", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-339" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\]\\$\\{\\$a(\\\"a\\{\\ set\\ x\\ \\}\\\\\\\\\\n\\ \\{list\\ ",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-340" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\$x\\]\\}\\{\\}\\]", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-341" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\[)\\ list\\ )\\[\\;\\ \\$\\{", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-342" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\$x\\;\\\\\\n\\\"\\na\\{\\\\\\n", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-343" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete *)\\$\\{\\n\\ \\\\\\n\\ \\\")\\$a(\\$a(\\}*",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-344" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\{\\;\\})list\\ \\$x\\$\\{*", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-345" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\$a(\\naa\\]#comment\\$a(\\\"\\\\\\{a*\\\\\\n",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-346" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\ *\\$\\{\\\"", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-347" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\$x)\\\\\\n\\ \\]\\n\\\\\\n\\\"\\$\\{",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-348" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\;\\ a\\]\\{\\n\\n\\;\\}\\}set\\ x\\ \\$a(",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-349" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\n\\{\\\")\\{\\$a(a\\$\\{\\\\\\\"#comment*",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-350" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete set\\ x\\ #comment\\}*a\\\"\\ ", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-351" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete *a\\\"\\{\\;\\n\\$a(\\$a(\\$a(\\ \\$\\{",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-352" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete set\\ x\\ \\[", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-353" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete )#comment\\[\\n", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-354" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\\"\\]\\\"", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-355" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\$x\\\\\\}\\\\\\n\\ ", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-356" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\;", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-357" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\[\\\\\\n\\ \\;\\{\\$x\\]\\\\\\\"\\n", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-358" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\$a(\\$\\{list\\ \\}\\\\\\n\\{", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-359" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\;)\\[\\$xa\\])set\\ x\\ aa\\\\*\\$a(",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-360" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\\\\\n\\ \\]\\$x\\]", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-361" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete )", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-362" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\n\\\\\\n\\ \\;\\$\\{set\\ x\\ *\\;\\[\\$\\{\\\\\\n\\}\\;",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-363" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete *\\$x\\}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-364" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\}a\\ \\n#comment", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-365" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\$\\{)\\ \\$a(#comment\\\\\\}\\\\\\n\\\\\\n",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-366" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete #comment\\;*\\$x*\\]a", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-367" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete list\\ \\{\\$a(a\\$\\{*\\\\\\n\\{", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-368" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete set\\ x\\ \\\\\\n\\ \\$\\{set\\ x\\ ", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-369" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete a\\;)\\$\\{\\}\\n\\]\\$x\\$a(", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-370" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\\\\\n\\\\\\\"\\}\\n", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-371" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete *a\\\"\\n", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-372" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete #comment\\ \\{\\$\\{list\\ \\{list\\ ", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-373" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete )\\[\\n)\\\\\\n\\}", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-374" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete *\\$a(\\]\\\\\\n\\ \\{\\$a(\\;set\\ x\\ \\$a(",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-375" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete )", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-376" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete #comment", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-377" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\\\\\n\\$x\\\\\\n\\ \\[\\n#comment\\;\\$\\{#comment\\\"",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-378" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete list\\ \\{\\;", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-379" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete *set\\ x\\ list\\ \\}*list\\ list\\ \\}\\ \\$a(#comment\\ ",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-380" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete set\\ x\\ \\\"*\\ \\]\\\\\\n\\{a#comment\\\\\\}\\\\\\\\\\n",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-381" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete )\\}\\ \\\\\\n\\$a(", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-382" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\$\\{))\\$x", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-383" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete a\\}list\\ \\\"\\\\\\})\\ \\$\\{\\})\\ \\$x",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-384" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\nlist\\ ", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-385" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete set\\ x\\ *aset\\ x\\ set\\ x\\ *\\\\\\ \\[\\\\\\n\\ ",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-386" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\\\\\n*", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-387" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete *\\ \\n\\\\\\n", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-388" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\]", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-389" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete *\\}\\[list\\ aset\\ x\\ ", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-390" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\]\\]a)set\\ x\\ *list\\ *\\\\\\n\\$x",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-391" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete list\\ set\\ x\\ \\\\", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-392" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\\"a\\\\", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-393" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete \\$\\{\\{\\}\\ \\ \\$x\\\\", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-394" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\$\\{\\$x\\]\\]", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-395" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\n\\$\\{a\\n#comment\\$xlist\\ \\\\\\n\\]\\}",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-396" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\}a\\$a(\\;#comment\\[", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-397" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete )\\{a\\\\\\n\\na\\ \\\"\\{", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-398" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("info complete \\\\#comment\\[\\[\\{", budget=100000), "0")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax complete-generated-399" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete \\[\\\"\\{list\\ \\;\\[\\[\\\\\\n\\ \\\\\\n\\ ",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax ordinary-command-order-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;set source list\\ \\[incr\\ x\\]\\ \\{bad\\}tail;set code [catch {eval $source}];list $code $x",
      budget=100000,
    ),
    "1 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax ordinary-command-order-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;set source list\\ \\[incr\\ x\\;set\\ y\\ \\{bad\\];set code [catch {eval $source}];list $code $x",
      budget=100000,
    ),
    "1 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax ordinary-command-order-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;set source list\\ \\[incr\\ x\\]\\ \\$a(;set code [catch {eval $source}];list $code $x",
      budget=100000,
    ),
    "1 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax ordinary-command-order-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;set source list\\ \\[incr\\ x\\]\\ \\[error\\ boom\\];set code [catch {eval $source}];list $code $x",
      budget=100000,
    ),
    "1 1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax ordinary-command-order-4" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;set source list\\ \\[incr\\ x\\]\\ \\[set\\ y\\ \\{bad\\];set code [catch {eval $source}];list $code $x",
      budget=100000,
    ),
    "1 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax ordinary-command-order-5" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;set source incr\\ x\\;list\\ \\{bad\\}tail;set code [catch {eval $source}];list $code $x",
      budget=100000,
    ),
    "1 1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax ordinary-command-order-6" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;set source list\\ \\[incr\\ x\\;\\]\\;incr\\ x;set code [catch {eval $source}];list $code $x",
      budget=100000,
    ),
    "0 2",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax ordinary-command-order-7" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;set source list\\ \\[incr\\ x\\;#comment\\n\\]\\;incr\\ x;set code [catch {eval $source}];list $code $x",
      budget=100000,
    ),
    "0 2",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax arity-subst" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("subst", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl syntax arity-subst -bogus text" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("subst -bogus text", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl syntax arity-info complete" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("info complete", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl syntax arity-info complete a b" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("info complete a b", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl syntax group-complete-{value}-\\\n" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete list\\ \\{value\\}\\\\\\n", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax group-eval-{value}-\\\n" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("eval list\\ \\{value\\}\\\\\\n", budget=100000), "value")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax group-complete-{value}-\\\n " {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete list\\ \\{value\\}\\\\\\n\\ ", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax group-eval-{value}-\\\n " {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("eval list\\ \\{value\\}\\\\\\n\\ ", budget=100000), "value")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax group-complete-{value}-\\\n next" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete list\\ \\{value\\}\\\\\\n\\ next", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax group-eval-{value}-\\\n next" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("eval list\\ \\{value\\}\\\\\\n\\ next", budget=100000),
    "value next",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax group-complete-\"value\"-\\\n" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete list\\ \\\"value\\\"\\\\\\n", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax group-eval-\"value\"-\\\n" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("eval list\\ \\\"value\\\"\\\\\\n", budget=100000), "value")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax group-complete-\"value\"-\\\n " {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete list\\ \\\"value\\\"\\\\\\n\\ ", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax group-eval-\"value\"-\\\n " {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("eval list\\ \\\"value\\\"\\\\\\n\\ ", budget=100000),
    "value",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax group-complete-\"value\"-\\\n next" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete list\\ \\\"value\\\"\\\\\\n\\ next", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax group-eval-\"value\"-\\\n next" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("eval list\\ \\\"value\\\"\\\\\\n\\ next", budget=100000),
    "value next",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax group-complete-[list value]-\\\n" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete list\\ \\[list\\ value\\]\\\\\\n", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax group-eval-[list value]-\\\n" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("eval list\\ \\[list\\ value\\]\\\\\\n", budget=100000),
    "value",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax group-complete-[list value]-\\\n " {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("info complete list\\ \\[list\\ value\\]\\\\\\n\\ ", budget=100000),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax group-eval-[list value]-\\\n " {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("eval list\\ \\[list\\ value\\]\\\\\\n\\ ", budget=100000),
    "value",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax group-complete-[list value]-\\\n next" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "info complete list\\ \\[list\\ value\\]\\\\\\n\\ next",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax group-eval-[list value]-\\\n next" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("eval list\\ \\[list\\ value\\]\\\\\\n\\ next", budget=100000),
    "value next",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax comment-continuation-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x before;eval #\\ comment\\\\\\nset\\ x\\ after\\nset\\ x",
      budget=100000,
    ),
    "before",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax comment-continuation-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x before;eval #\\ comment\\\\\\\\\\nset\\ x\\ after\\nset\\ x",
      budget=100000,
    ),
    "after",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax comment-continuation-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x before;eval #\\ comment\\\\\\\\\\\\\\nset\\ x\\ after\\nset\\ x",
      budget=100000,
    ),
    "before",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax comment-continuation-4" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x before;eval #\\ comment\\\\\\\\\\\\\\\\\\nset\\ x\\ after\\nset\\ x",
      budget=100000,
    ),
    "after",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax comment-continuation-5" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x before;eval #\\ comment\\\\\\\\\\\\\\\\\\\\\\nset\\ x\\ after\\nset\\ x",
      budget=100000,
    ),
    "before",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax comment-continuation-6" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x before;eval #\\ comment\\\\\\\\\\\\\\\\\\\\\\\\\\nset\\ x\\ after\\nset\\ x",
      budget=100000,
    ),
    "after",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-incr x-0-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[incr\\ x\\]after;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 before1after 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-incr x-0-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[incr\\ x\\])after;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeONEafter 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-incr x-0-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[incr\\ x\\]\\[incr\\ x\\])tail;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 2 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-incr x-1-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[incr\\ x\\]after;set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 before1after 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-incr x-1-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[incr\\ x\\])after;set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeONEafter 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-incr x-1-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[incr\\ x\\]\\[incr\\ x\\])tail;set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 2 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-incr x-2-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[incr\\ x\\]after;set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before[incr x]after} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-incr x-2-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[incr\\ x\\])after;set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeONEafter 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-incr x-2-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[incr\\ x\\]\\[incr\\ x\\])tail;set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 2 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-incr x-3-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[incr\\ x\\]after;set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before[incr x]after} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-incr x-3-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[incr\\ x\\])after;set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeONEafter 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-incr x-3-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[incr\\ x\\]\\[incr\\ x\\])tail;set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 2 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-incr x-4-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[incr\\ x\\]after;set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 before1after 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-incr x-4-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[incr\\ x\\])after;set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before$a(1)after} 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-incr x-4-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[incr\\ x\\]\\[incr\\ x\\])tail;set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$a(12)tail} 2 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-incr x-5-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[incr\\ x\\]after;set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 before1after 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-incr x-5-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[incr\\ x\\])after;set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before$a(1)after} 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-incr x-5-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[incr\\ x\\]\\[incr\\ x\\])tail;set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$a(12)tail} 2 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-incr x-6-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[incr\\ x\\]after;set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before[incr x]after} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-incr x-6-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[incr\\ x\\])after;set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before$a([incr x])after} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-incr x-6-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[incr\\ x\\]\\[incr\\ x\\])tail;set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$a([incr x][incr x])tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-incr x-7-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[incr\\ x\\]after;set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before[incr x]after} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-incr x-7-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[incr\\ x\\])after;set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before$a([incr x])after} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-incr x-7-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[incr\\ x\\]\\[incr\\ x\\])tail;set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$a([incr x][incr x])tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-break-0-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[break\\]after;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 before 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-break-0-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[break\\])after;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 before 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-break-0-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[break\\]\\[incr\\ x\\])tail;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-break-1-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[break\\]after;set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 before 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-break-1-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[break\\])after;set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 before 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-break-1-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[break\\]\\[incr\\ x\\])tail;set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-break-2-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[break\\]after;set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before[break]after} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-break-2-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[break\\])after;set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 before 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-break-2-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[break\\]\\[incr\\ x\\])tail;set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-break-3-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[break\\]after;set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before[break]after} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-break-3-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[break\\])after;set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 before 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-break-3-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[break\\]\\[incr\\ x\\])tail;set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-break-4-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[break\\]after;set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 before 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-break-4-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[break\\])after;set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before$a(} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-break-4-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[break\\]\\[incr\\ x\\])tail;set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$a(} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-break-5-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[break\\]after;set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 before 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-break-5-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[break\\])after;set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before$a(} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-break-5-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[break\\]\\[incr\\ x\\])tail;set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$a(} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-break-6-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[break\\]after;set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before[break]after} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-break-6-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[break\\])after;set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before$a([break])after} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-break-6-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[break\\]\\[incr\\ x\\])tail;set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$a([break][incr x])tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-break-7-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[break\\]after;set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before[break]after} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-break-7-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[break\\])after;set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before$a([break])after} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-break-7-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[break\\]\\[incr\\ x\\])tail;set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$a([break][incr x])tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-continue-0-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[continue\\]after;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeafter 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-continue-0-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[continue\\])after;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeafter 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-continue-0-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[continue\\]\\[incr\\ x\\])tail;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 tail 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-continue-1-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[continue\\]after;set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeafter 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-continue-1-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[continue\\])after;set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeafter 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-continue-1-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[continue\\]\\[incr\\ x\\])tail;set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 tail 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-continue-2-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[continue\\]after;set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before[continue]after} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-continue-2-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[continue\\])after;set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeafter 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-continue-2-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[continue\\]\\[incr\\ x\\])tail;set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 tail 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-continue-3-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[continue\\]after;set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before[continue]after} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-continue-3-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[continue\\])after;set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeafter 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-continue-3-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[continue\\]\\[incr\\ x\\])tail;set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 tail 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-continue-4-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[continue\\]after;set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeafter 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-continue-4-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[continue\\])after;set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before$a()after} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-continue-4-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[continue\\]\\[incr\\ x\\])tail;set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$a(1)tail} 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-continue-5-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[continue\\]after;set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeafter 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-continue-5-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[continue\\])after;set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before$a()after} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-continue-5-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[continue\\]\\[incr\\ x\\])tail;set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$a(1)tail} 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-continue-6-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[continue\\]after;set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before[continue]after} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-continue-6-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[continue\\])after;set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before$a([continue])after} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-continue-6-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[continue\\]\\[incr\\ x\\])tail;set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$a([continue][incr x])tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-continue-7-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[continue\\]after;set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before[continue]after} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-continue-7-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[continue\\])after;set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before$a([continue])after} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-continue-7-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[continue\\]\\[incr\\ x\\])tail;set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$a([continue][incr x])tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return index-0-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[return\\ index\\]after;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeindexafter 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return index-0-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[return\\ index\\])after;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeindexafter 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return index-0-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[return\\ index\\]\\[incr\\ x\\])tail;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 indextail 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return index-1-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[return\\ index\\]after;set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeindexafter 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return index-1-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[return\\ index\\])after;set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeindexafter 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return index-1-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[return\\ index\\]\\[incr\\ x\\])tail;set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 indextail 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return index-2-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[return\\ index\\]after;set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before[return index]after} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return index-2-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[return\\ index\\])after;set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeindexafter 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return index-2-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[return\\ index\\]\\[incr\\ x\\])tail;set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 indextail 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return index-3-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[return\\ index\\]after;set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before[return index]after} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return index-3-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[return\\ index\\])after;set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeindexafter 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return index-3-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[return\\ index\\]\\[incr\\ x\\])tail;set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 indextail 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return index-4-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[return\\ index\\]after;set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeindexafter 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return index-4-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[return\\ index\\])after;set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before$a(index)after} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return index-4-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[return\\ index\\]\\[incr\\ x\\])tail;set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$a(index1)tail} 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return index-5-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[return\\ index\\]after;set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeindexafter 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return index-5-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[return\\ index\\])after;set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before$a(index)after} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return index-5-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[return\\ index\\]\\[incr\\ x\\])tail;set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$a(index1)tail} 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return index-6-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[return\\ index\\]after;set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before[return index]after} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return index-6-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[return\\ index\\])after;set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before$a([return index])after} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return index-6-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[return\\ index\\]\\[incr\\ x\\])tail;set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$a([return index][incr x])tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return index-7-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[return\\ index\\]after;set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before[return index]after} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return index-7-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[return\\ index\\])after;set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before$a([return index])after} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return index-7-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[return\\ index\\]\\[incr\\ x\\])tail;set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$a([return index][incr x])tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return -level 0 -code 9 index-0-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[return\\ -level\\ 0\\ -code\\ 9\\ index\\]after;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeindexafter 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return -level 0 -code 9 index-0-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[return\\ -level\\ 0\\ -code\\ 9\\ index\\])after;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeindexafter 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return -level 0 -code 9 index-0-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[return\\ -level\\ 0\\ -code\\ 9\\ index\\]\\[incr\\ x\\])tail;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 indextail 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return -level 0 -code 9 index-1-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[return\\ -level\\ 0\\ -code\\ 9\\ index\\]after;set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeindexafter 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return -level 0 -code 9 index-1-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[return\\ -level\\ 0\\ -code\\ 9\\ index\\])after;set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeindexafter 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return -level 0 -code 9 index-1-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[return\\ -level\\ 0\\ -code\\ 9\\ index\\]\\[incr\\ x\\])tail;set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 indextail 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return -level 0 -code 9 index-2-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[return\\ -level\\ 0\\ -code\\ 9\\ index\\]after;set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before[return -level 0 -code 9 index]after} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return -level 0 -code 9 index-2-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[return\\ -level\\ 0\\ -code\\ 9\\ index\\])after;set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeindexafter 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return -level 0 -code 9 index-2-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[return\\ -level\\ 0\\ -code\\ 9\\ index\\]\\[incr\\ x\\])tail;set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 indextail 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return -level 0 -code 9 index-3-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[return\\ -level\\ 0\\ -code\\ 9\\ index\\]after;set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before[return -level 0 -code 9 index]after} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return -level 0 -code 9 index-3-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[return\\ -level\\ 0\\ -code\\ 9\\ index\\])after;set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeindexafter 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return -level 0 -code 9 index-3-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[return\\ -level\\ 0\\ -code\\ 9\\ index\\]\\[incr\\ x\\])tail;set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 indextail 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return -level 0 -code 9 index-4-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[return\\ -level\\ 0\\ -code\\ 9\\ index\\]after;set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeindexafter 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return -level 0 -code 9 index-4-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[return\\ -level\\ 0\\ -code\\ 9\\ index\\])after;set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before$a(index)after} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return -level 0 -code 9 index-4-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[return\\ -level\\ 0\\ -code\\ 9\\ index\\]\\[incr\\ x\\])tail;set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$a(index1)tail} 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return -level 0 -code 9 index-5-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[return\\ -level\\ 0\\ -code\\ 9\\ index\\]after;set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 beforeindexafter 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return -level 0 -code 9 index-5-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[return\\ -level\\ 0\\ -code\\ 9\\ index\\])after;set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before$a(index)after} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return -level 0 -code 9 index-5-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[return\\ -level\\ 0\\ -code\\ 9\\ index\\]\\[incr\\ x\\])tail;set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$a(index1)tail} 1 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return -level 0 -code 9 index-6-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[return\\ -level\\ 0\\ -code\\ 9\\ index\\]after;set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before[return -level 0 -code 9 index]after} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return -level 0 -code 9 index-6-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[return\\ -level\\ 0\\ -code\\ 9\\ index\\])after;set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before$a([return -level 0 -code 9 index])after} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return -level 0 -code 9 index-6-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[return\\ -level\\ 0\\ -code\\ 9\\ index\\]\\[incr\\ x\\])tail;set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$a([return -level 0 -code 9 index][incr x])tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return -level 0 -code 9 index-7-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[return\\ -level\\ 0\\ -code\\ 9\\ index\\]after;set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before[return -level 0 -code 9 index]after} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return -level 0 -code 9 index-7-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[return\\ -level\\ 0\\ -code\\ 9\\ index\\])after;set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before$a([return -level 0 -code 9 index])after} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-return -level 0 -code 9 index-7-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[return\\ -level\\ 0\\ -code\\ 9\\ index\\]\\[incr\\ x\\])tail;set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$a([return -level 0 -code 9 index][incr x])tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-error bad-0-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[error\\ bad\\]after;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-error bad-0-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[error\\ bad\\])after;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-error bad-0-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[error\\ bad\\]\\[incr\\ x\\])tail;set code [catch {subst  $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-error bad-1-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[error\\ bad\\]after;set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-error bad-1-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[error\\ bad\\])after;set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-error bad-1-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[error\\ bad\\]\\[incr\\ x\\])tail;set code [catch {subst -nobackslashes $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-error bad-2-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[error\\ bad\\]after;set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before[error bad]after} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-error bad-2-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[error\\ bad\\])after;set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-error bad-2-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[error\\ bad\\]\\[incr\\ x\\])tail;set code [catch {subst -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-error bad-3-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[error\\ bad\\]after;set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before[error bad]after} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-error bad-3-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[error\\ bad\\])after;set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-error bad-3-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[error\\ bad\\]\\[incr\\ x\\])tail;set code [catch {subst -nobackslashes -nocommands $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-error bad-4-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[error\\ bad\\]after;set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-error bad-4-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[error\\ bad\\])after;set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-error bad-4-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[error\\ bad\\]\\[incr\\ x\\])tail;set code [catch {subst -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-error bad-5-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[error\\ bad\\]after;set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-error bad-5-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[error\\ bad\\])after;set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-error bad-5-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[error\\ bad\\]\\[incr\\ x\\])tail;set code [catch {subst -nobackslashes -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "1 <error> 0 1 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-error bad-6-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[error\\ bad\\]after;set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before[error bad]after} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-error bad-6-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[error\\ bad\\])after;set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before$a([error bad])after} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-error bad-6-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[error\\ bad\\]\\[incr\\ x\\])tail;set code [catch {subst -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$a([error bad][incr x])tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-error bad-7-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\[error\\ bad\\]after;set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before[error bad]after} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-error bad-7-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template before\\$a(\\[error\\ bad\\])after;set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {before$a([error bad])after} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl syntax cross-kind-error bad-7-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;array set a {index VALUE value LOOKUP 1 ONE 2 TWO};set template \\$a(\\[error\\ bad\\]\\[incr\\ x\\])tail;set code [catch {subst -nobackslashes -nocommands -novariables $template} result options];if {$code==1} {set result <error>};list $code $result $x [dict get $options -code] [dict get $options -level] [dict exists $options -tag]",
      budget=100000,
    ),
    "0 {$a([error bad][incr x])tail} 0 0 0 0",
  )
  assert_eq(t.output_text(), "")
}
