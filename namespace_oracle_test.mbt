// Original programs, expected results evaluated by Tcl 8.6.15. Do not hand-edit.

///|
test "Tcl namespace ensemble-map-whitespace" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace ensemble create -map { x {::list old} x {::list new} } -parameters { a  b } -subcommands { x  y } -unknown { ::list  a }};namespace ensemble configure a",
      budget=100000,
    ),
    "-map { x {::list old} x {::list new} } -namespace ::a -parameters { a  b } -prefixes 1 -subcommands { x  y } -unknown { ::list  a }",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace ensemble-map-relative-duplicates" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace ensemble create -map {x {list old} x {list new}}};namespace ensemble configure a -map",
      budget=100000,
    ),
    "x {::a::list new}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace unknown-global-custom" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc h args {return custom};namespace unknown h;namespace eval a {list [namespace unknown] [missing]}",
      budget=100000,
    ),
    "{} custom",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace unknown-root-reset" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc unknown args {return yes};namespace unknown {};list [namespace unknown] [missing]",
      budget=100000,
    ),
    "::unknown yes",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace export-default" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("namespace eval a {namespace export}", budget=100000), "")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace export-duplicates" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export a a b a; namespace export}",
      budget=100000,
    ),
    "a b",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace export-clear" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export a; namespace export -clear b c; namespace export}",
      budget=100000,
    ),
    "b c",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace export-empty-clear" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export a; namespace export -clear; namespace export}",
      budget=100000,
    ),
    "",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace export-partial-error" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export a; catch {namespace export -clear b ::bad}; namespace export}",
      budget=100000,
    ),
    "b",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace export-future" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export p}; namespace import a::*; proc a::p {} {return yes}; list [namespace import] [a::p]",
      budget=100000,
    ),
    "{} yes",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace export-not-private" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export p; variable x 10; proc p {{v 1}} {variable x; incr x $v}; proc private {} {return hidden}};namespace import a::*;list [p 2] [catch {private}] [lsort [namespace import]]",
      budget=100000,
    ),
    "12 1 p",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace import-repeat" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export p; variable x 10; proc p {{v 1}} {variable x; incr x $v}; proc private {} {return hidden}};namespace import a::*;namespace import a::*;list [p] [p] [namespace import]",
      budget=100000,
    ),
    "11 12 p",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace import-force-query" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export p; variable x 10; proc p {{v 1}} {variable x; incr x $v}; proc private {} {return hidden}};namespace import a::*;namespace import -force",
      budget=100000,
    ),
    "",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace import-conflict" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export p; variable x 10; proc p {{v 1}} {variable x; incr x $v}; proc private {} {return hidden}};proc p {} {return local};list [catch {namespace import a::*}] [p]",
      budget=100000,
    ),
    "1 local",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace import-force" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export p; variable x 10; proc p {{v 1}} {variable x; incr x $v}; proc private {} {return hidden}};proc p {} {return local};namespace import -force a::*;p 4",
      budget=100000,
    ),
    "14",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace import-partial" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export p; variable x 10; proc p {{v 1}} {variable x; incr x $v}; proc private {} {return hidden}};catch {namespace import a::p missing::*};list [namespace import] [p]",
      budget=100000,
    ),
    "p 11",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace import-no-export" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {proc p {} {return yes}};namespace import a::*;list [namespace import] [catch {p}]",
      budget=100000,
    ),
    "{} 1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace import-origin" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export p; variable x 10; proc p {{v 1}} {variable x; incr x $v}; proc private {} {return hidden}};namespace eval b {namespace import ::a::*;namespace export *};namespace import b::*;list [p 3] [namespace origin p] [namespace which p] [namespace origin a::p]",
      budget=100000,
    ),
    "13 ::a::p ::p ::a::p",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace import-redefine-origin" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export p; variable x 10; proc p {{v 1}} {variable x; incr x $v}; proc private {} {return hidden}};namespace import a::*;proc a::p args {return changed};list [p] [namespace origin p]",
      budget=100000,
    ),
    "changed ::a::p",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace import-redefine-alias" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export p; variable x 10; proc p {{v 1}} {variable x; incr x $v}; proc private {} {return hidden}};namespace eval b {namespace import ::a::*;namespace export *};namespace import b::*;proc b::p {} {return replaced};list [p] [namespace origin p] [a::p]",
      budget=100000,
    ),
    "replaced ::b::p 11",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace import-force-alias" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export p; variable x 10; proc p {{v 1}} {variable x; incr x $v}; proc private {} {return hidden}};namespace import a::*;namespace export p;namespace eval c {namespace import ::p};namespace eval b {namespace export *;proc p {} {return replaced}};namespace import -force b::*;list [p] [c::p] [namespace origin c::p]",
      budget=100000,
    ),
    "replaced replaced ::b::p",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace import-cycle" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export p; variable x 10; proc p {{v 1}} {variable x; incr x $v}; proc private {} {return hidden}};namespace eval b {namespace import ::a::*;namespace export *};list [catch {namespace eval a {namespace import -force ::b::*}}] [b::p]",
      budget=100000,
    ),
    "1 11",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace import-info" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export p; variable x 10; proc p {{v 1}} {variable x; incr x $v}; proc private {} {return hidden}};namespace import a::*;list [info args p] [info body p] [info default p v result] $result [info procs p]",
      budget=100000,
    ),
    "v {variable x; incr x $v} 1 1 p",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace import-rename-original" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export p; variable x 10; proc p {{v 1}} {variable x; incr x $v}; proc private {} {return hidden}};namespace import a::*;rename a::p a::q;list [p] [namespace origin p] [catch {a::p}] [a::q]",
      budget=100000,
    ),
    "11 ::a::q 1 12",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace import-rename-other-space" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export p; variable x 10; proc p {{v 1}} {variable x; incr x $v}; proc private {} {return hidden}};namespace eval b {variable x 100};namespace import a::*;rename a::p b::q;list [p] [namespace origin p]",
      budget=100000,
    ),
    "101 ::b::q",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace import-rename-alias" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export p; variable x 10; proc p {{v 1}} {variable x; incr x $v}; proc private {} {return hidden}};namespace import a::*;rename p q;list [q] [namespace import] [namespace origin q]",
      budget=100000,
    ),
    "11 q ::a::p",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace import-delete-original" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export p; variable x 10; proc p {{v 1}} {variable x; incr x $v}; proc private {} {return hidden}};namespace eval b {namespace import ::a::*;namespace export *};namespace import b::*;rename a::p {};list [namespace import] [namespace eval b {namespace import}] [catch {p}]",
      budget=100000,
    ),
    "{} {} 1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace import-delete-middle" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export p; variable x 10; proc p {{v 1}} {variable x; incr x $v}; proc private {} {return hidden}};namespace eval b {namespace import ::a::*;namespace export *};namespace import b::*;rename b::p {};list [catch {p}] [a::p]",
      budget=100000,
    ),
    "1 11",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace import-delete-alias" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export p; variable x 10; proc p {{v 1}} {variable x; incr x $v}; proc private {} {return hidden}};namespace import a::*;rename p {};a::p",
      budget=100000,
    ),
    "11",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace import-delete-space" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export p; variable x 10; proc p {{v 1}} {variable x; incr x $v}; proc private {} {return hidden}};namespace import a::*;namespace delete a;list [namespace import] [catch {p}]",
      budget=100000,
    ),
    "{} 1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace import-recreate-space" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export p; variable x 10; proc p {{v 1}} {variable x; incr x $v}; proc private {} {return hidden}};namespace import a::*;namespace delete a;namespace eval a {proc p {} {return fresh};namespace export *};list [namespace import] [catch {p}];namespace import a::*;p",
      budget=100000,
    ),
    "fresh",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace forget-simple" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export p; variable x 10; proc p {{v 1}} {variable x; incr x $v}; proc private {} {return hidden}};namespace import a::*;namespace forget p;list [namespace import] [a::p]",
      budget=100000,
    ),
    "{} 11",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace forget-pattern" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export p; variable x 10; proc p {{v 1}} {variable x; incr x $v}; proc private {} {return hidden}};namespace import a::*;namespace forget p*;list [namespace import] [a::p]",
      budget=100000,
    ),
    "{} 11",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace forget-qualified" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export p; variable x 10; proc p {{v 1}} {variable x; incr x $v}; proc private {} {return hidden}};namespace import a::*;namespace forget a::*;list [namespace import] [a::p]",
      budget=100000,
    ),
    "{} 11",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace forget-renamed-alias" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export p; variable x 10; proc p {{v 1}} {variable x; incr x $v}; proc private {} {return hidden}};namespace import a::*;rename p q;namespace forget a::p;list [namespace import] [catch {q}]",
      budget=100000,
    ),
    "{} 1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace forget-renamed-original" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export p; variable x 10; proc p {{v 1}} {variable x; incr x $v}; proc private {} {return hidden}};namespace import a::*;rename a::p a::q;namespace forget a::p;set first [namespace import];namespace forget a::q;list $first [namespace import]",
      budget=100000,
    ),
    "p {}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace forget-no-longer-exported" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export p; variable x 10; proc p {{v 1}} {variable x; incr x $v}; proc private {} {return hidden}};namespace import a::*;namespace eval a {namespace export -clear};namespace forget a::*;namespace import",
      budget=100000,
    ),
    "",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace forget-keeps-local" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export p; variable x 10; proc p {{v 1}} {variable x; incr x $v}; proc private {} {return hidden}};namespace import a::*;proc p {} {return local};namespace forget *;p",
      budget=100000,
    ),
    "local",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace forget-chain-original" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export p; variable x 10; proc p {{v 1}} {variable x; incr x $v}; proc private {} {return hidden}};namespace eval b {namespace import ::a::*;namespace export *};namespace import b::*;namespace forget a::*;namespace import",
      budget=100000,
    ),
    "",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace forget-chain-immediate" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export p; variable x 10; proc p {{v 1}} {variable x; incr x $v}; proc private {} {return hidden}};namespace eval b {namespace import ::a::*;namespace export *};namespace import b::*;namespace forget b::*;namespace import",
      budget=100000,
    ),
    "",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace forget-transitive" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export p; variable x 10; proc p {{v 1}} {variable x; incr x $v}; proc private {} {return hidden}};namespace eval b {namespace import ::a::*;namespace export *};namespace import b::*;namespace eval b {namespace forget *};list [namespace import] [a::p]",
      budget=100000,
    ),
    "{} 11",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace path-default" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("namespace eval a {namespace path}", budget=100000), "")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace path-duplicates" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {namespace path {::a ::a ::};namespace path}",
      budget=100000,
    ),
    "::a ::a ::",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace path-atomic" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace path ::a;catch {namespace path {::b ::bad}};namespace path",
      budget=100000,
    ),
    "::a",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace path-relative" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace eval b {};namespace path b;namespace path}",
      budget=100000,
    ),
    "::a::b",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace path-no-inheritance" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace path ::;namespace eval b {namespace path}}",
      budget=100000,
    ),
    "",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace path-redefinition" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {proc p {} {return old}};namespace path a;set first [p];proc a::p {} {return new};list $first [p]",
      budget=100000,
    ),
    "old new",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace path-delete-recreate" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {proc p {} {return old}};namespace path a;namespace delete a;namespace eval a {proc p {} {return new}};list [namespace path] [catch {p}]",
      budget=100000,
    ),
    "{} 1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace path-no-chaining" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {proc p {} {return A}};namespace eval b {namespace path ::a};namespace path b;catch {p}",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace path-info-procs" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {proc p {} {return a}};namespace eval b {namespace path ::a;list [info commands p] [info procs p] [namespace which p]}",
      budget=100000,
    ),
    "p {} ::a::p",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace path-subspace" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a::sub {proc p {} {return A}};namespace path a;sub::p",
      budget=100000,
    ),
    "A",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace path-variable-independent" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x global;namespace eval a {variable x A};namespace eval b {namespace path ::a;set x}",
      budget=100000,
    ),
    "global",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace native-rename" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("rename list collect;list [collect x y]", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl namespace native-renamed-invoke" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("rename list collect;collect a {b c}", budget=100000),
    "a {b c}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace native-rename-import" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};rename join a::calculate;namespace eval a {namespace export *};namespace import a::*;calculate {a b} -",
      budget=100000,
    ),
    "a-b",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace native-delete" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("rename list {};catch {list x}", budget=100000), "1")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace native-shadow-delete" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc list args {return local};rename list {};catch {list x}",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace empty-command" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};proc {} {} {return root};proc a:: {} {return child};list [{}] [a::] [namespace which a::]",
      budget=100000,
    ),
    "root child ::a::",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace inscope-safe" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {proc p args {return $args}};namespace inscope a p {a b} {$x} {[error nope]} {; error nope}",
      budget=100000,
    ),
    "{a b} {$x} {[error nope]} {; error nope}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace code-callback" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {proc p args {return $args};set ::callback [namespace code p]};eval $callback [list {a b} {x;y}]",
      budget=100000,
    ),
    "{a b} {x;y}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace code-idempotent" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace code [namespace code p]}",
      budget=100000,
    ),
    "::namespace inscope ::a p",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace upvar-namespace" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {variable x 4};proc p {} {namespace upvar ::a x y;incr y};list [p] $a::x",
      budget=100000,
    ),
    "5 5",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace upvar-array" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {array set x {key 4}};proc p {} {namespace upvar ::a x z;incr z(key)};list [p] $a::x(key)",
      budget=100000,
    ),
    "5 5",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace upvar-missing" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};proc p {} {namespace upvar ::a x y;set y 8};list [p] $a::x",
      budget=100000,
    ),
    "8 8",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace upvar-relative" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace eval b {variable x 3};namespace upvar b x y;incr y};set a::b::x",
      budget=100000,
    ),
    "4",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace unknown-default" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("namespace eval a {namespace unknown}", budget=100000), "")
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace unknown-custom" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc h args {return $args};namespace eval a {namespace unknown {::h prefix};missing {a b} x}",
      budget=100000,
    ),
    "prefix missing {a b} x",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace unknown-scope" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {proc h args {list [namespace current] $args};namespace unknown h;missing x}",
      budget=100000,
    ),
    "::a {missing x}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace unknown-reset" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc unknown args {return global};namespace eval a {namespace unknown {};missing x}",
      budget=100000,
    ),
    "global",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace unknown-not-inherited" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {proc h args {return custom};namespace unknown h;namespace eval b {catch {missing}}}",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace ensemble-default" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export p;proc p args {return $args};namespace ensemble create};a p 1 {two words}",
      budget=100000,
    ),
    "1 {two words}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace ensemble-config-default" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace ensemble create -command ::e};namespace ensemble configure e",
      budget=100000,
    ),
    "-map {} -namespace ::a -parameters {} -prefixes 1 -subcommands {} -unknown {}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace ensemble-dynamic" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return P};namespace ensemble create};set first [a p];proc a::q {} {return Q};list $first [a q]",
      budget=100000,
    ),
    "P Q",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace ensemble-map" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace ensemble create -command ::e -map {p {::list prefix} q ::string}};list [e p {a b}] [e q length abc]",
      budget=100000,
    ),
    "{prefix {a b}} 3",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace ensemble-map-relative" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {proc p args {return $args};namespace ensemble create -map {go {p fixed}}};list [a go x] [namespace ensemble configure a -map]",
      budget=100000,
    ),
    "{fixed x} {go {::a::p fixed}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace ensemble-map-duplicates" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace ensemble create -map {x {::list old} x {::list new}}};list [a x A] [namespace ensemble configure a -map]",
      budget=100000,
    ),
    "{new A} {x {::list old} x {::list new}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace ensemble-config-scope" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace ensemble create -command ::e};namespace eval b {proc p {} {namespace current};namespace ensemble configure ::e -map {go p}};list [e go] [namespace ensemble configure e -namespace]",
      budget=100000,
    ),
    "::b ::a",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace ensemble-prefix" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace ensemble create -map {alpha {::list A} beta {::list B}}};list [a al x] [a b y]",
      budget=100000,
    ),
    "{A x} {B y}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace ensemble-ambiguous" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace ensemble create -map {aa ::list ab ::list}};catch {a a x}",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace ensemble-exact-wins" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace ensemble create -map {a {::list A} ab {::list AB}}};a a x",
      budget=100000,
    ),
    "A x",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace ensemble-prefix-disable" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace ensemble create -prefixes 0 -map {alpha ::list}};list [catch {a al x}] [a alpha x]",
      budget=100000,
    ),
    "1 x",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace ensemble-subcommands" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {proc p {} {return P};namespace ensemble create -subcommands {p q} -map {q {::list Q} hidden ::list}};list [a p] [a q] [catch {a hidden}]",
      budget=100000,
    ),
    "P Q 1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace ensemble-parameters" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace ensemble create -command ::e -parameters {x y} -map {go {::list fixed}}};e A B go C",
      budget=100000,
    ),
    "fixed A B C",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace ensemble-unknown-prefix" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc h {command sub args} {return {::list fallback}};namespace eval a {namespace ensemble create -command ::e -unknown ::h};e nope A {B C}",
      budget=100000,
    ),
    "fallback A {B C}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace ensemble-unknown-reconfigure" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc h args {namespace ensemble configure ::e -map {go {::list fixed}};return {}};namespace eval a {namespace ensemble create -command ::e -unknown ::h};e go A",
      budget=100000,
    ),
    "fixed A",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace ensemble-unknown-once" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set calls 0;proc h args {global calls;incr calls;return {}};namespace eval a {namespace ensemble create -unknown ::h};list [catch {a missing}] $calls",
      budget=100000,
    ),
    "1 1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace ensemble-unknown-arguments" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set seen {};proc h args {set ::seen $args;return {::list fixed}};namespace eval a {namespace ensemble create -command ::e -parameters X -unknown ::h};list [e A missing B] $seen",
      budget=100000,
    ),
    "{fixed A B} {::e A missing B}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace ensemble-no-frame" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace ensemble create -map {go {::set local}}};proc p {} {set local 3;a go 9;return $local};p",
      budget=100000,
    ),
    "9",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace ensemble-proc-frame" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {proc p {} {uplevel 1 {incr x}};namespace export p;namespace ensemble create};proc caller {} {set x 2;a p;return $x};caller",
      budget=100000,
    ),
    "3",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace ensemble-rename" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {proc p {} {namespace current};namespace export *;namespace ensemble create};rename a renamed;list [renamed p] [namespace ensemble configure renamed -namespace]",
      budget=100000,
    ),
    "::a ::a",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace ensemble-delete-space" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace ensemble create -command ::e};namespace delete a;list [namespace ensemble exists e] [catch {e x}]",
      budget=100000,
    ),
    "0 1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace ensemble-import" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace ensemble create -command e -map {p ::list};namespace export e};namespace import a::*;list [e p x] [namespace ensemble exists e] [namespace ensemble configure e -namespace]",
      budget=100000,
    ),
    "x 1 ::a",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace ensemble-config-atomic" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace ensemble create -command ::e};catch {namespace ensemble configure e -prefixes 0 -bad 1};namespace ensemble configure e -prefixes",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace ensemble-config-abbreviated" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace ens cr -comm ::e -pref 0};namespace ens conf e -pref",
      budget=100000,
    ),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace ensemble-unknown-abnormal" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc h args {error bad};namespace eval a {namespace ensemble create -unknown ::h};catch {a missing}",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace ensemble-nested" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace ensemble create -map {go {::b run}}};namespace eval b {namespace ensemble create -map {run {::list fixed}}};a go x",
      budget=100000,
    ),
    "fixed x",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-False-False-False-False-::a ::b" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};namespace eval c {namespace path {::a ::b};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "1 {} missing",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-False-False-False-False-::b ::a" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};namespace eval c {namespace path {::b ::a};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "1 {} missing",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-False-False-False-False-:: ::a ::b" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};namespace eval c {namespace path {:: ::a ::b};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "1 {} missing",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-False-False-False-True-::a ::b" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc p {} {return global};namespace eval c {namespace path {::a ::b};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::p global",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-False-False-False-True-::b ::a" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc p {} {return global};namespace eval c {namespace path {::b ::a};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::p global",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-False-False-False-True-:: ::a ::b" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc p {} {return global};namespace eval c {namespace path {:: ::a ::b};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::p global",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-False-False-True-False-::a ::b" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc b::p {} {return second};namespace eval c {namespace path {::a ::b};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::b::p second",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-False-False-True-False-::b ::a" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc b::p {} {return second};namespace eval c {namespace path {::b ::a};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::b::p second",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-False-False-True-False-:: ::a ::b" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc b::p {} {return second};namespace eval c {namespace path {:: ::a ::b};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::b::p second",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-False-False-True-True-::a ::b" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc b::p {} {return second};proc p {} {return global};namespace eval c {namespace path {::a ::b};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::b::p second",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-False-False-True-True-::b ::a" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc b::p {} {return second};proc p {} {return global};namespace eval c {namespace path {::b ::a};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::b::p second",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-False-False-True-True-:: ::a ::b" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc b::p {} {return second};proc p {} {return global};namespace eval c {namespace path {:: ::a ::b};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::p global",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-False-True-False-False-::a ::b" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc a::p {} {return first};namespace eval c {namespace path {::a ::b};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::a::p first",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-False-True-False-False-::b ::a" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc a::p {} {return first};namespace eval c {namespace path {::b ::a};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::a::p first",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-False-True-False-False-:: ::a ::b" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc a::p {} {return first};namespace eval c {namespace path {:: ::a ::b};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::a::p first",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-False-True-False-True-::a ::b" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc a::p {} {return first};proc p {} {return global};namespace eval c {namespace path {::a ::b};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::a::p first",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-False-True-False-True-::b ::a" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc a::p {} {return first};proc p {} {return global};namespace eval c {namespace path {::b ::a};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::a::p first",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-False-True-False-True-:: ::a ::b" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc a::p {} {return first};proc p {} {return global};namespace eval c {namespace path {:: ::a ::b};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::p global",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-False-True-True-False-::a ::b" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc a::p {} {return first};proc b::p {} {return second};namespace eval c {namespace path {::a ::b};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::a::p first",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-False-True-True-False-::b ::a" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc a::p {} {return first};proc b::p {} {return second};namespace eval c {namespace path {::b ::a};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::b::p second",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-False-True-True-False-:: ::a ::b" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc a::p {} {return first};proc b::p {} {return second};namespace eval c {namespace path {:: ::a ::b};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::a::p first",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-False-True-True-True-::a ::b" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc a::p {} {return first};proc b::p {} {return second};proc p {} {return global};namespace eval c {namespace path {::a ::b};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::a::p first",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-False-True-True-True-::b ::a" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc a::p {} {return first};proc b::p {} {return second};proc p {} {return global};namespace eval c {namespace path {::b ::a};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::b::p second",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-False-True-True-True-:: ::a ::b" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc a::p {} {return first};proc b::p {} {return second};proc p {} {return global};namespace eval c {namespace path {:: ::a ::b};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::p global",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-True-False-False-False-::a ::b" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc c::p {} {return local};namespace eval c {namespace path {::a ::b};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::c::p local",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-True-False-False-False-::b ::a" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc c::p {} {return local};namespace eval c {namespace path {::b ::a};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::c::p local",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-True-False-False-False-:: ::a ::b" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc c::p {} {return local};namespace eval c {namespace path {:: ::a ::b};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::c::p local",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-True-False-False-True-::a ::b" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc c::p {} {return local};proc p {} {return global};namespace eval c {namespace path {::a ::b};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::c::p local",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-True-False-False-True-::b ::a" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc c::p {} {return local};proc p {} {return global};namespace eval c {namespace path {::b ::a};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::c::p local",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-True-False-False-True-:: ::a ::b" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc c::p {} {return local};proc p {} {return global};namespace eval c {namespace path {:: ::a ::b};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::c::p local",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-True-False-True-False-::a ::b" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc c::p {} {return local};proc b::p {} {return second};namespace eval c {namespace path {::a ::b};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::c::p local",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-True-False-True-False-::b ::a" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc c::p {} {return local};proc b::p {} {return second};namespace eval c {namespace path {::b ::a};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::c::p local",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-True-False-True-False-:: ::a ::b" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc c::p {} {return local};proc b::p {} {return second};namespace eval c {namespace path {:: ::a ::b};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::c::p local",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-True-False-True-True-::a ::b" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc c::p {} {return local};proc b::p {} {return second};proc p {} {return global};namespace eval c {namespace path {::a ::b};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::c::p local",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-True-False-True-True-::b ::a" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc c::p {} {return local};proc b::p {} {return second};proc p {} {return global};namespace eval c {namespace path {::b ::a};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::c::p local",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-True-False-True-True-:: ::a ::b" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc c::p {} {return local};proc b::p {} {return second};proc p {} {return global};namespace eval c {namespace path {:: ::a ::b};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::c::p local",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-True-True-False-False-::a ::b" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc c::p {} {return local};proc a::p {} {return first};namespace eval c {namespace path {::a ::b};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::c::p local",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-True-True-False-False-::b ::a" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc c::p {} {return local};proc a::p {} {return first};namespace eval c {namespace path {::b ::a};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::c::p local",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-True-True-False-False-:: ::a ::b" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc c::p {} {return local};proc a::p {} {return first};namespace eval c {namespace path {:: ::a ::b};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::c::p local",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-True-True-False-True-::a ::b" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc c::p {} {return local};proc a::p {} {return first};proc p {} {return global};namespace eval c {namespace path {::a ::b};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::c::p local",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-True-True-False-True-::b ::a" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc c::p {} {return local};proc a::p {} {return first};proc p {} {return global};namespace eval c {namespace path {::b ::a};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::c::p local",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-True-True-False-True-:: ::a ::b" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc c::p {} {return local};proc a::p {} {return first};proc p {} {return global};namespace eval c {namespace path {:: ::a ::b};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::c::p local",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-True-True-True-False-::a ::b" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc c::p {} {return local};proc a::p {} {return first};proc b::p {} {return second};namespace eval c {namespace path {::a ::b};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::c::p local",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-True-True-True-False-::b ::a" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc c::p {} {return local};proc a::p {} {return first};proc b::p {} {return second};namespace eval c {namespace path {::b ::a};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::c::p local",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-True-True-True-False-:: ::a ::b" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc c::p {} {return local};proc a::p {} {return first};proc b::p {} {return second};namespace eval c {namespace path {:: ::a ::b};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::c::p local",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-True-True-True-True-::a ::b" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc c::p {} {return local};proc a::p {} {return first};proc b::p {} {return second};proc p {} {return global};namespace eval c {namespace path {::a ::b};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::c::p local",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-True-True-True-True-::b ::a" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc c::p {} {return local};proc a::p {} {return first};proc b::p {} {return second};proc p {} {return global};namespace eval c {namespace path {::b ::a};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::c::p local",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace resolution-True-True-True-True-:: ::a ::b" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {};namespace eval b {};namespace eval c {};proc c::p {} {return local};proc a::p {} {return first};proc b::p {} {return second};proc p {} {return global};namespace eval c {namespace path {:: ::a ::b};list [catch {p} result] [namespace which p] [expr {[namespace which p] eq \"\" ? \"missing\" : $result}]}",
      budget=100000,
    ),
    "0 ::c::p local",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace import-glob-p" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export p; variable x 10; proc p {{v 1}} {variable x; incr x $v}; proc private {} {return hidden}};namespace import a::p;lsort [namespace import]",
      budget=100000,
    ),
    "p",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace import-glob-p*" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export p; variable x 10; proc p {{v 1}} {variable x; incr x $v}; proc private {} {return hidden}};namespace import a::p*;lsort [namespace import]",
      budget=100000,
    ),
    "p",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace import-glob-?" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export p; variable x 10; proc p {{v 1}} {variable x; incr x $v}; proc private {} {return hidden}};namespace import a::?;lsort [namespace import]",
      budget=100000,
    ),
    "p",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace import-glob-[pq]" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(
        t.eval(
          "namespace eval a {namespace export p; variable x 10; proc p {{v 1}} {variable x; incr x $v}; proc private {} {return hidden}};namespace import a::[pq];lsort [namespace import]",
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
test "Tcl namespace import-glob-z*" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export p; variable x 10; proc p {{v 1}} {variable x; incr x $v}; proc private {} {return hidden}};namespace import a::z*;lsort [namespace import]",
      budget=100000,
    ),
    "",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace import-glob-*" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export p; variable x 10; proc p {{v 1}} {variable x; incr x $v}; proc private {} {return hidden}};namespace import a::*;lsort [namespace import]",
      budget=100000,
    ),
    "p",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace import-glob-private" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export p; variable x 10; proc p {{v 1}} {variable x; incr x $v}; proc private {} {return hidden}};namespace import a::private;lsort [namespace import]",
      budget=100000,
    ),
    "",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace ensemble-literal-''" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace ensemble create -map {go {::list fixed}}};a go {}",
      budget=100000,
    ),
    "fixed {}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace ensemble-literal-'a b'" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace ensemble create -map {go {::list fixed}}};a go {a b}",
      budget=100000,
    ),
    "fixed {a b}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace ensemble-literal-'$x'" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace ensemble create -map {go {::list fixed}}};a go {$x}",
      budget=100000,
    ),
    "fixed {$x}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace ensemble-literal-'[error no]'" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace ensemble create -map {go {::list fixed}}};a go {[error no]}",
      budget=100000,
    ),
    "fixed {[error no]}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace ensemble-literal-'; error no'" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace ensemble create -map {go {::list fixed}}};a go {; error no}",
      budget=100000,
    ),
    "fixed {; error no}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace ensemble-literal-'{braces}'" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace ensemble create -map {go {::list fixed}}};a go {{braces}}",
      budget=100000,
    ),
    "fixed {{braces}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace ensemble-literal-'line\\nnext'" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace ensemble create -map {go {::list fixed}}};a go {line\nnext}",
      budget=100000,
    ),
    "fixed {line\nnext}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace ensemble-literal-'\\\\path'" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace ensemble create -map {go {::list fixed}}};a go {\\path}",
      budget=100000,
    ),
    "fixed {\\path}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace ensemble-literal-'中文'" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace ensemble create -map {go {::list fixed}}};a go {中文}",
      budget=100000,
    ),
    "fixed 中文",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace boundary-0" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("namespace import p", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl namespace boundary-1" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("namespace import missing::*", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl namespace boundary-2" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("namespace import ::*", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl namespace boundary-3" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("namespace export ::p", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl namespace boundary-4" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(
        t.eval("namespace eval a {namespace import ::a::*}", budget=100000),
      )
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl namespace boundary-5" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("namespace forget missing::*", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl namespace boundary-6" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("namespace origin missing", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl namespace boundary-7" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("namespace origin", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl namespace boundary-8" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("namespace path ::missing", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl namespace boundary-9" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("namespace path a b", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl namespace boundary-10" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("namespace upvar ::missing x y", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl namespace boundary-11" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("namespace upvar :: x", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl namespace boundary-12" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("namespace which -invalid p", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl namespace boundary-13" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("namespace unknown a b", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl namespace boundary-14" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("namespace ensemble", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl namespace boundary-15" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("namespace ensemble exists", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl namespace boundary-16" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("namespace ensemble configure missing", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl namespace boundary-17" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(
        t.eval(
          "namespace eval a {namespace ensemble create -map {x {}}}",
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
test "Tcl namespace boundary-18" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(
        t.eval(
          "namespace eval a {namespace ensemble create -map {x}}",
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
test "Tcl namespace boundary-19" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(
        t.eval(
          "namespace eval a {namespace ensemble create -prefixes maybe}",
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
test "Tcl namespace boundary-20" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(
        t.eval(
          "namespace eval a {namespace ensemble create -namespace ::}",
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
test "Tcl namespace boundary-21" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace ensemble create -command ::missing::x}",
      budget=100000,
    ),
    "::missing::x",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace boundary-22" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(
        t.eval(
          "namespace eval a {namespace ensemble create -map {x ::list}};a",
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
test "Tcl namespace boundary-23" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(
        t.eval(
          "namespace eval a {namespace ensemble create -parameters {x y} -map {go ::list}};a A go",
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
test "Tcl namespace boundary-24" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(
        t.eval(
          "namespace eval a {namespace ensemble create};namespace ensemble configure a -namespace ::",
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
test "Tcl namespace boundary-25" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace ensemble create};namespace ensemble configure a -parameters",
      budget=100000,
    ),
    "",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace boundary-26" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(
        t.eval(
          "namespace eval a {namespace ensemble create -subcommands p};a p",
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
test "Tcl namespace boundary-27" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(
        t.eval(
          "namespace eval a {namespace ensemble create -map {p ::missing}};a p",
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
test "Tcl namespace mutation-trace-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export -clear}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export *;proc p {} {return fresh}}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 ::a::p} {0 original} {0 {}} {0 {}} {0 ::a::p} {0 {}} {1 {}} {1 {}} {0 {}} {1 {}} {0 {}} {0 {}} {0 fresh} {1 {}} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p b::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {0 original} {0 {}} {0 {}} {1 {}} {1 {}} {1 {}} {0 {}} {0 {}} {0 {}} {0 {}} {1 {}} {0 original} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export -clear}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace forget *}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {1 {}} {0 {}} {0 {}} {1 {}} {0 {}} {1 {}} {1 {}} {0 local} {1 {}} {0 local}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc a::p {} {return changed}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc a::p {} {return changed}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace forget *}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{1 {}} {0 {}} {0 {}} {1 {}} {1 {}} {0 {}} {1 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {1 {}} {1 {}} {0 local} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-4" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p b::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p b::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace forget *}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p b::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export -clear}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 original} {0 {}} {1 {}} {0 {}} {0 {}} {0 {}} {1 {}} {0 {}} {1 {}} {0 {}} {0 {}} {1 {}} {0 original} {1 {}} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-5" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc a::p {} {return changed}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace forget *}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc a::p {} {return changed}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 original} {0 {}} {0 {}} {1 {}} {0 {}} {1 {}} {1 {}} {1 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 changed} {1 {}} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-6" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export -clear}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p b::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {1 {}} {0 {}} {0 {}} {0 {}} {1 {}} {1 {}} {0 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-7" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export *;proc p {} {return fresh}}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p b::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export -clear}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 original} {0 {}} {0 fresh} {0 {}} {0 fresh} {0 {}} {1 {}} {1 {}} {0 {}} {1 {}} {0 {}} {0 fresh} {1 {}} {1 {}} {0 fresh} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-8" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace forget *}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 original} {1 {}} {0 {}} {0 {}} {0 local} {0 {}} {0 ::b::p} {0 {}} {0 {}} {0 local} {0 local} {0 local} {1 {}} {0 original} {0 local} {1 {}} {0 local}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-9" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc a::p {} {return changed}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export *;proc p {} {return fresh}}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {0 {}} {1 {}} {0 {}} {0 {}} {1 {}} {0 {}} {0 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-10" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p b::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p b::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p b::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace forget *}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 ::a::p} {0 {}} {0 {}} {1 {}} {1 {}} {0 {}} {1 {}} {1 {}} {1 {}} {0 {}} {0 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-11" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {0 {}} {0 {}} {1 {}} {0 ::a::p} {1 {}} {0 {}} {1 {}} {1 {}} {0 original} {0 {}} {1 {}} {0 original} {0 original} {0 original} {0 original}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-12" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 original} {0 {}} {0 {}} {1 {}} {1 {}} {1 {}} {0 {}} {0 local} {0 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {0 local} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-13" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {proc a::p {} {return changed}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc a::p {} {return changed}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export *;proc p {} {return fresh}}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {0 {}} {0 {}} {0 ::a::p} {0 {}} {0 {}} {0 {}} {1 {}} {0 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-14" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {0 {}} {1 {}} {1 {}} {0 {}} {0 {}} {0 local} {0 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {0 local} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-15" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export -clear}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export *;proc p {} {return fresh}}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{1 {}} {0 {}} {0 original} {0 {}} {0 {}} {0 {}} {1 {}} {1 {}} {1 {}} {0 {}} {0 {}} {0 {}} {0 fresh} {1 {}} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-16" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export *;proc p {} {return fresh}}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p b::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {1 {}} {0 {}} {0 {}} {1 {}} {0 {}} {0 {}} {1 {}} {0 {}} {1 {}} {1 {}} {0 {}} {0 fresh} {1 {}} {0 fresh} {0 fresh} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-17" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export *;proc p {} {return fresh}}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {0 {}} {0 {}} {1 {}} {1 {}} {0 {}} {1 {}} {0 {}} {0 {}} {1 {}} {0 {}} {1 {}} {0 fresh} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-18" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export *;proc p {} {return fresh}}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 original} {0 {}} {0 ::a::p} {0 {}} {1 {}} {1 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 fresh} {1 {}} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-19" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc a::p {} {return changed}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {0 {}} {0 {}} {1 {}} {1 {}} {0 {}} {0 {}} {1 {}} {0 {}} {0 {}} {0 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-20" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc a::p {} {return changed}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {1 {}} {1 {}} {0 {}} {1 {}} {0 {}} {0 {}} {1 {}} {0 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-21" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export -clear}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {0 original} {0 original} {0 {}} {0 {}} {0 original} {0 {}} {0 {}} {0 {}} {0 {}} {1 {}} {1 {}} {0 original} {0 original} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-22" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export -clear}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 original} {0 {}} {1 {}} {0 local} {0 {}} {1 {}} {0 local} {0 original} {0 {}} {0 {}} {0 local} {0 {}} {1 {}} {1 {}} {0 local} {1 {}} {0 local}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-23" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval b {namespace forget *}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {1 {}} {1 {}} {1 {}} {1 {}} {0 local} {1 {}} {1 {}} {1 {}} {1 {}} {0 local} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-24" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p b::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 original} {0 {}} {0 {}} {0 {}} {0 local} {0 {}} {1 {}} {0 {}} {0 {}} {0 original} {1 {}} {0 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-25" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace forget *}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export -clear}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace forget *}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export *;proc p {} {return fresh}}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 original} {0 {}} {0 {}} {0 {}} {0 {}} {1 {}} {0 original} {0 {}} {0 {}} {1 {}} {1 {}} {0 {}} {0 fresh} {1 {}} {0 local} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-26" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export *;proc p {} {return fresh}}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace forget *}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {0 {}} {1 {}} {0 {}} {0 {}} {1 {}} {1 {}} {1 {}} {0 {}} {0 {}} {0 {}} {1 {}} {0 fresh} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-27" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export *;proc p {} {return fresh}}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {1 {}} {1 {}} {1 {}} {0 {}} {0 {}} {0 {}} {1 {}} {1 {}} {0 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-28" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export -clear}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace forget *}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {1 {}} {0 {}} {1 {}} {0 {}} {1 {}} {1 {}} {1 {}} {1 {}} {0 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-29" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {1 {}} {0 {}} {0 {}} {0 original} {0 {}} {0 {}} {0 {}} {1 {}} {0 {}} {0 {}} {0 original} {1 {}} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-30" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc a::p {} {return changed}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p b::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{1 {}} {0 {}} {0 {}} {0 {}} {1 {}} {0 {}} {0 {}} {0 {}} {1 {}} {0 {}} {0 {}} {1 {}} {1 {}} {0 changed} {1 {}} {0 changed} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-31" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export -clear}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc a::p {} {return changed}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export *;proc p {} {return fresh}}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc a::p {} {return changed}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{1 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 changed} {0 {}} {0 {}} {0 {}} {1 {}} {0 ::b::p} {0 changed} {0 original} {0 local} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-32" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace forget *}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export *;proc p {} {return fresh}}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 original} {0 {}} {0 {}} {0 {}} {1 {}} {0 {}} {1 {}} {0 {}} {0 {}} {1 {}} {1 {}} {0 {}} {0 fresh} {0 original} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-33" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace forget *}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace forget *}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {0 {}} {1 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 ::a::p} {0 {}} {0 original} {0 original} {1 {}} {0 original} {1 {}} {0 original}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-34" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace forget *}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export -clear}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {1 {}} {0 {}} {0 {}} {0 {}} {0 ::b::p} {0 {}} {1 {}} {0 original} {0 local} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-35" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval a {namespace export -clear}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export *;proc p {} {return fresh}}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace forget *}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p b::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p b::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {0 {}} {1 {}} {0 {}} {1 {}} {0 {}} {1 {}} {1 {}} {1 {}} {0 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-36" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export *;proc p {} {return fresh}}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p b::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 original} {0 {}} {0 {}} {0 {}} {1 {}} {0 {}} {0 {}} {0 {}} {1 {}} {1 {}} {1 {}} {1 {}} {0 fresh} {1 {}} {0 fresh} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-37" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace forget *}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export -clear}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export -clear}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {0 original} {0 original} {0 {}} {0 {}} {1 {}} {0 {}} {0 {}} {1 {}} {0 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-38" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {proc a::p {} {return changed}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export -clear}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p b::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export *;proc p {} {return fresh}}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p b::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {0 {}} {0 ::a::p} {1 {}} {0 {}} {0 {}} {1 {}} {0 {}} {1 {}} {0 {}} {1 {}} {0 fresh} {0 changed} {1 {}} {0 changed} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-39" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc a::p {} {return changed}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc a::p {} {return changed}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 ::a::p} {0 original} {0 {}} {0 local} {0 ::b::p} {0 {}} {0 {}} {0 {}} {1 {}} {0 {}} {1 {}} {0 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-40" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval a {namespace export *;proc p {} {return fresh}}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export *;proc p {} {return fresh}}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export -clear}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 ::a::p} {0 {}} {0 {}} {0 ::a::p} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {1 {}} {1 {}} {1 {}} {0 local} {1 {}} {0 local}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-41" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace forget *}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {0 {}} {1 {}} {1 {}} {0 {}} {0 {}} {1 {}} {1 {}} {0 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-42" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 original} {0 {}} {0 {}} {0 ::b::p} {0 {}} {0 local} {0 {}} {1 {}} {0 {}} {1 {}} {1 {}} {0 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-43" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc a::p {} {return changed}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p b::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 ::a::p} {0 {}} {0 {}} {1 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 changed} {0 {}} {1 {}} {0 {}} {0 changed} {1 {}} {1 {}} {0 changed} {0 changed}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-44" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc a::p {} {return changed}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc a::p {} {return changed}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 changed} {1 {}} {0 changed} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-45" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p b::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace forget *}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 original} {0 {}} {0 original} {0 {}} {0 original} {0 original} {1 {}} {0 ::a::p} {0 {}} {0 {}} {0 {}} {0 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-46" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export *;proc p {} {return fresh}}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export *;proc p {} {return fresh}}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {1 {}} {1 {}} {1 {}} {1 {}} {0 {}} {0 {}} {1 {}} {0 {}} {1 {}} {0 {}} {1 {}} {0 fresh} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-47" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {proc a::p {} {return changed}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export *;proc p {} {return fresh}}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export *;proc p {} {return fresh}}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {1 {}} {1 {}} {0 {}} {0 changed} {0 {}} {0 {}} {0 {}} {0 changed} {0 {}} {1 {}} {1 {}} {0 changed} {0 changed} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-48" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export *;proc p {} {return fresh}}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace forget *}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export -clear}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p b::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p b::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 original} {0 {}} {0 {}} {0 {}} {0 {}} {0 fresh} {1 {}} {1 {}} {0 {}} {1 {}} {1 {}} {0 {}} {0 fresh} {1 {}} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-49" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {1 {}} {1 {}} {0 {}} {1 {}} {0 {}} {1 {}} {1 {}} {0 {}} {1 {}} {1 {}} {0 ::b::p} {1 {}} {1 {}} {0 local} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-50" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {proc a::p {} {return changed}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p b::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export *;proc p {} {return fresh}}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export *;proc p {} {return fresh}}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {1 {}} {1 {}} {0 {}} {0 {}} {1 {}} {0 {}} {1 {}} {0 fresh} {0 {}} {0 {}} {1 {}} {0 fresh} {1 {}} {1 {}} {0 fresh} {0 fresh}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-51" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export *;proc p {} {return fresh}}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace forget *}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {1 {}} {0 {}} {1 {}} {1 {}} {0 {}} {1 {}} {0 {}} {0 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-52" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval a {namespace export *;proc p {} {return fresh}}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export -clear}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export -clear}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {0 {}} {0 {}} {1 {}} {0 {}} {1 {}} {0 fresh} {0 {}} {0 local} {0 {}} {0 ::b::p} {1 {}} {0 fresh} {0 local} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-53" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval a {namespace export *;proc p {} {return fresh}}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace forget *}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace forget *}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 local} {0 {}} {1 {}} {1 {}} {0 local} {1 {}} {0 local}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-54" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p b::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {1 {}} {0 {}} {0 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-55" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval b {namespace forget *}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export -clear}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {0 {}} {0 {}} {1 {}} {0 {}} {1 {}} {1 {}} {0 {}} {0 {}} {0 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-56" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {0 ::a::p} {0 {}} {0 ::b::p} {1 {}} {0 {}} {0 {}} {0 {}} {1 {}} {0 {}} {0 {}} {0 original} {1 {}} {0 local} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-57" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc a::p {} {return changed}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 changed} {1 {}} {0 ::a::q} {0 changed} {0 ::a::q} {0 {}} {1 {}} {1 {}} {0 changed} {0 changed} {1 {}} {0 changed}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-58" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {rename b::p b::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace forget *}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p b::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace forget *}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {0 {}} {0 original} {0 {}} {0 {}} {1 {}} {0 {}} {1 {}} {0 {}} {0 local} {0 {}} {1 {}} {1 {}} {0 local} {1 {}} {0 local}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-59" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval b {namespace forget *}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {0 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {0 {}} {1 {}} {0 {}} {0 original} {1 {}} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-60" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 original} {0 ::a::p} {0 ::a::p} {0 {}} {0 {}} {0 {}} {1 {}} {0 {}} {0 {}} {1 {}} {0 {}} {1 {}} {1 {}} {1 {}} {0 local} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-61" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export *;proc p {} {return fresh}}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc a::p {} {return changed}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {1 {}} {1 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {1 {}} {1 {}} {0 {}} {0 changed} {0 changed} {1 {}} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-62" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {proc a::p {} {return changed}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export -clear}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export *;proc p {} {return fresh}}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export *;proc p {} {return fresh}}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export *;proc p {} {return fresh}}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {0 {}} {0 fresh} {0 {}} {0 {}} {0 fresh} {0 {}} {0 {}} {1 {}} {0 {}} {0 {}} {0 fresh} {1 {}} {0 fresh} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-63" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export -clear}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export -clear}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p b::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 ::a::p} {0 {}} {0 {}} {1 {}} {0 {}} {1 {}} {0 {}} {1 {}} {1 {}} {1 {}} {1 {}} {0 original} {1 {}} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-64" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval c {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export -clear}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 original} {0 {}} {0 {}} {0 {}} {0 {}} {1 {}} {1 {}} {0 {}} {1 {}} {0 {}} {0 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-65" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace forget *}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc a::p {} {return changed}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export *;proc p {} {return fresh}}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export -clear}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 original} {0 {}} {0 {}} {1 {}} {0 {}} {0 {}} {1 {}} {0 {}} {0 {}} {0 {}} {0 {}} {1 {}} {0 fresh} {1 {}} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-66" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc a::p {} {return changed}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc a::p {} {return changed}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export *;proc p {} {return fresh}}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export -clear}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {0 {}} {0 ::a::p} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {1 {}} {0 {}} {0 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-67" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export -clear}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {0 {}} {0 original} {0 {}} {0 {}} {0 original} {0 {}} {0 {}} {0 {}} {0 {}} {0 local} {1 {}} {1 {}} {0 local} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-68" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export -clear}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc a::p {} {return changed}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {1 {}} {0 {}} {0 {}} {1 {}} {0 changed} {1 {}} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-69" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {rename b::p b::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace forget *}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export -clear}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {1 {}} {0 {}} {0 local} {1 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 local} {1 {}} {0 original} {0 local} {0 original} {0 local}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-70" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p b::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc a::p {} {return changed}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {1 {}} {0 {}} {1 {}} {1 {}} {0 {}} {0 {}} {0 {}} {1 {}} {0 changed} {0 local} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-71" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p b::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p b::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {1 {}} {0 {}} {0 {}} {1 {}} {1 {}} {1 {}} {1 {}} {0 {}} {1 {}} {0 {}} {1 {}} {1 {}} {1 {}} {0 local} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-72" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p b::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p b::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export *;proc p {} {return fresh}}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 ::a::p} {0 ::a::p} {0 original} {0 original} {0 {}} {0 original} {1 {}} {0 original} {0 {}} {1 {}} {0 {}} {0 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-73" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export -clear}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 original} {0 ::a::p} {0 ::a::p} {0 {}} {0 {}} {1 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {1 {}} {1 {}} {0 local} {1 {}} {0 local}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-74" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc a::p {} {return changed}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p b::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 ::a::p} {0 {}} {0 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {0 {}} {0 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-75" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc a::p {} {return changed}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p b::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace forget *}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {0 {}} {0 changed} {0 {}} {1 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {1 {}} {1 {}} {0 local} {1 {}} {0 local}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-76" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc a::p {} {return changed}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 original} {0 original} {0 ::a::p} {0 {}} {0 original} {0 original} {0 original} {0 {}} {0 {}} {1 {}} {0 ::b::p} {0 {}} {0 changed} {1 {}} {0 local} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-77" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export -clear}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export *;proc p {} {return fresh}}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export -clear}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace forget *}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {0 original} {0 {}} {0 ::a::p} {0 ::a::p} {0 {}} {0 {}} {0 {}} {1 {}} {0 {}} {1 {}} {0 fresh} {1 {}} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-78" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {0 ::a::q} {0 ::a::q} {0 {}} {0 {}} {0 original} {0 {}} {1 {}} {0 {}} {0 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-79" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export *;proc p {} {return fresh}}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc a::p {} {return changed}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 original} {0 {}} {1 {}} {0 {}} {0 {}} {0 {}} {1 {}} {0 {}} {0 {}} {0 {}} {0 changed} {0 changed} {0 changed} {1 {}} {0 changed} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-80" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export *;proc p {} {return fresh}}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export -clear}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc a::p {} {return changed}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 original} {0 {}} {0 ::a::p} {0 fresh} {0 fresh} {0 {}} {0 ::a::p} {0 {}} {0 {}} {0 {}} {0 {}} {1 {}} {1 {}} {1 {}} {0 local} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-81" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace forget *}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export -clear}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {1 {}} {1 {}} {1 {}} {0 {}} {0 {}} {0 {}} {1 {}} {1 {}} {0 {}} {0 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-82" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace forget *}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {0 original} {0 original} {0 {}} {0 {}} {1 {}} {0 {}} {0 {}} {1 {}} {0 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-83" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace forget *}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace forget *}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 ::a::p} {1 {}} {0 {}} {1 {}} {0 {}} {0 original} {0 {}} {1 {}} {0 {}} {0 {}} {0 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-84" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval c {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 original} {0 {}} {0 {}} {1 {}} {0 {}} {0 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-85" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc a::p {} {return changed}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace forget *}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace forget *}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 original} {0 {}} {0 changed} {0 {}} {0 {}} {0 {}} {1 {}} {0 {}} {1 {}} {0 {}} {0 {}} {0 {}} {1 {}} {0 changed} {0 local} {0 changed} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-86" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export -clear}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export -clear}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {1 {}} {0 original} {0 {}} {0 {}} {0 {}} {0 {}} {1 {}} {1 {}} {0 local} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-87" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval a {namespace export *;proc p {} {return fresh}}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc a::p {} {return changed}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {1 {}} {0 {}} {0 {}} {1 {}} {1 {}} {1 {}} {0 {}} {0 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-88" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval a {namespace export *;proc p {} {return fresh}}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace import -force ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 fresh} {0 fresh} {0 {}} {0 {}} {0 {}} {0 {}} {1 {}} {1 {}} {0 fresh} {0 local} {0 fresh} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-89" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export *;proc p {} {return fresh}}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc a::p {} {return changed}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace forget *}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace forget *}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 original} {0 {}} {0 fresh} {0 {}} {1 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {1 {}} {1 {}} {0 local} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-90" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace path ::b}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc a::p {} {return changed}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p b::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {1 {}} {1 {}} {0 {}} {1 {}} {0 local} {0 {}} {0 {}} {0 {}} {0 ::b::p} {0 {}} {0 {}} {0 changed} {1 {}} {1 {}} {0 local} {0 local}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-91" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export -clear}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {0 {}} {0 ::b::p} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {1 {}} {1 {}} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-92" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export -clear}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p b::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace export -clear}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc a::p {} {return changed}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 original} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 local} {0 original} {1 {}} {0 {}} {0 {}} {1 {}} {0 changed} {1 {}} {0 local} {0 changed} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-93" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p b::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::p a::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace forget *}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace forget *}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {0 {}} {1 {}} {0 {}} {1 {}} {1 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {1 {}} {0 original} {1 {}} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-94" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc a::p {} {return changed}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace delete a} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename a::q a::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {proc b::p {} {return local}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 original} {0 {}} {0 {}} {1 {}} {0 {}} {1 {}} {0 {}} {1 {}} {1 {}} {1 {}} {1 {}} {0 {}} {1 {}} {1 {}} {0 local} {1 {}} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace mutation-trace-95" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "namespace eval a {namespace export *;proc p {} {return original}};namespace eval b {namespace export *;namespace import ::a::*};namespace eval c {namespace import ::b::*;namespace export *};set out {};set status [catch {rename b::p b::q} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::a::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace origin b::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval a {namespace import -force ::c::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {c::p} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace forget ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {p}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {rename b::p {}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval c {namespace import -force ::b::*}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];set status [catch {namespace eval b {namespace path ::a}} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]];foreach command {a::p a::q b::p b::q c::p} {set status [catch {$command} result];lappend out [list $status [expr {$status == 0 ? $result : \"\"}]]};set out",
      budget=100000,
    ),
    "{0 {}} {0 {}} {1 {}} {1 {}} {0 {}} {1 {}} {0 {}} {1 {}} {1 {}} {1 {}} {0 {}} {0 {}} {0 original} {1 {}} {1 {}} {0 original} {1 {}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace empty-exists" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("namespace eval a {namespace exists {}}", budget=100000),
    "0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace empty-parent" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("namespace eval a {namespace parent {}}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl namespace empty-children" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("namespace eval a {namespace children {}}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl namespace empty-path" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("namespace eval a {namespace path {{}}}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl namespace empty-upvar" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("namespace eval a {namespace upvar {} x y}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl namespace empty-delete" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("namespace eval a {namespace delete {}}", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl namespace missing-parent" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("namespace parent missing", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl namespace missing-children" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("namespace children missing", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl namespace auto-import-observed" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc auto_import p {set ::seen $p};namespace eval a {};namespace import a::*;set seen",
      budget=100000,
    ),
    "a::*",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace auto-import-create" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc auto_import p {namespace eval a {proc p {} {return yes};namespace export *}};namespace import a::*;p",
      budget=100000,
    ),
    "yes",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace auto-import-error" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(
        t.eval(
          "proc auto_import p {error loadfail};namespace eval a {};namespace import a::*",
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
test "Tcl namespace auto-import-context" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc auto_import p {set ::seen [uplevel 1 {namespace current}]};namespace eval a {};namespace eval b {namespace import ::a::*};set seen",
      budget=100000,
    ),
    "::b",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace same-origin-import" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(
        t.eval(
          "namespace eval a {proc p {} {return A};namespace export *};namespace eval b {namespace import ::a::*;namespace export *};namespace import a::*;namespace import b::*;namespace origin p",
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
test "Tcl namespace same-origin-reimport" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(
        t.eval(
          "namespace eval a {proc p {} {return A};namespace export *};namespace eval b {namespace import ::a::*;namespace export *};namespace import b::*;namespace import a::*;namespace origin p",
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
test "Tcl namespace ensemble-unknown-delete" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(
        t.eval(
          "proc h args {rename ::e {};return {::list fixed}};namespace eval a {namespace ensemble create -command ::e -unknown h};e missing X",
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
test "Tcl namespace ensemble-unknown-delete-space" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(
        t.eval(
          "proc h args {namespace delete ::a;return {::list fixed}};namespace eval a {namespace ensemble create -command ::e -unknown h};e missing X",
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
test "Tcl namespace ensemble-unknown-replace" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(
        t.eval(
          "proc h args {proc ::e args {return replacement};return {::list fixed}};namespace eval a {namespace ensemble create -command ::e -unknown h};e missing X",
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
test "Tcl namespace ensemble-unknown-reconfigure-params" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc h args {namespace ensemble configure ::e -parameters X -map {go ::list};return {}};namespace eval a {namespace ensemble create -command ::e -unknown h};e A go B",
      budget=100000,
    ),
    "A B",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace ensemble-unknown-reconfigure-short" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc h args {namespace ensemble configure ::e -parameters {X Y Z};return {::list fixed}};namespace eval a {namespace ensemble create -command ::e -unknown h};e A B",
      budget=100000,
    ),
    "fixed A",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace ensemble-unknown-rename" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc h args {rename ::e ::f;return {::list fixed}};namespace eval a {namespace ensemble create -command ::e -unknown h};e missing X",
      budget=100000,
    ),
    "fixed X",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace unknown-parameter-rewrite-0-A B" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc h args {namespace ensemble configure ::e -parameters {};return {::list fixed}};namespace eval a {namespace ensemble create -command ::e -unknown h};e A B",
      budget=100000,
    ),
    "fixed B",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace unknown-parameter-rewrite-0-A B C D E" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc h args {namespace ensemble configure ::e -parameters {};return {::list fixed}};namespace eval a {namespace ensemble create -command ::e -unknown h};e A B C D E",
      budget=100000,
    ),
    "fixed B C D E",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace unknown-parameter-rewrite-1-A B" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc h args {namespace ensemble configure ::e -parameters {X};return {::list fixed}};namespace eval a {namespace ensemble create -command ::e -unknown h};e A B",
      budget=100000,
    ),
    "fixed A",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace unknown-parameter-rewrite-1-A B C D E" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc h args {namespace ensemble configure ::e -parameters {X};return {::list fixed}};namespace eval a {namespace ensemble create -command ::e -unknown h};e A B C D E",
      budget=100000,
    ),
    "fixed A C D E",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace unknown-parameter-rewrite-2-A B" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc h args {namespace ensemble configure ::e -parameters {X Y};return {::list fixed}};namespace eval a {namespace ensemble create -command ::e -unknown h};e A B",
      budget=100000,
    ),
    "fixed A",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace unknown-parameter-rewrite-2-A B C D E" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc h args {namespace ensemble configure ::e -parameters {X Y};return {::list fixed}};namespace eval a {namespace ensemble create -command ::e -unknown h};e A B C D E",
      budget=100000,
    ),
    "fixed A B D E",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace unknown-parameter-rewrite-3-A B" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc h args {namespace ensemble configure ::e -parameters {X Y Z};return {::list fixed}};namespace eval a {namespace ensemble create -command ::e -unknown h};e A B",
      budget=100000,
    ),
    "fixed A",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl namespace unknown-parameter-rewrite-3-A B C D E" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc h args {namespace ensemble configure ::e -parameters {X Y Z};return {::list fixed}};namespace eval a {namespace ensemble create -command ::e -unknown h};e A B C D E",
      budget=100000,
    ),
    "fixed A B C E",
  )
  assert_eq(t.output_text(), "")
}
