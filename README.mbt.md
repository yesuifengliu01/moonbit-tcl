# 可执行 API 示例

增加 proc、默认/可变参数、局部变量、共享输出、递归与 return。这些例子调用公开 API，并随 `moon test` 执行。

```mbt check
///|
test "procedures have local variables and shared output" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("set x outer; proc twice {x} {expr {$x * 2}}; twice 21"),
    "42",
  )
  assert_eq(t.eval("set x"), "outer")
  assert_eq(
    t.eval("proc greet {who} {puts $who; return done; missing}; greet hello"),
    "done",
  )
  assert_eq(t.printed(), "hello")
}

///|
test "recursive factorial" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc fact {n} {if {$n <= 1} {return 1}; expr {$n * [fact [expr {$n - 1}]]}}; fact 6",
    ),
    "720",
  )
}

///|
test "procedure errors and depth budgets" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("proc p {{a b c}} {}"))
      false
    } catch {
      _ => true
    },
  )
  assert_true(
    try {
      ignore(t.eval("proc p {a} {}; p"))
      false
    } catch {
      _ => true
    },
  )
  assert_true(
    try {
      ignore(t.eval("proc p {} {p}; p", budget=20))
      false
    } catch {
      _ => true
    },
  )
}
```

限制：命名空间、完整列表/字符串命令、数组变量或外部 I/O 尚未完成；整数为 32 位。

## 过程、列表和通用循环

```mbt check
///|
test "documented default arguments and foreach" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc scale {values {factor 2}} {set result {}; foreach n $values {lappend result [expr {$n * $factor}]}; return $result}; scale {1 2 3}",
    ),
    "2 4 6",
  )
  assert_eq(t.eval("scale {1 2 3} 3"), "3 6 9")
}
```
