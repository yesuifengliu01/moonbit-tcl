///|
fn run(input : String) -> String {
  try {
    let t = @lib.Interpreter::new()
    let result = t.eval(input)
    "Result: " + result + "\nOutput:\n" + t.printed()
  } catch {
    e => "ERROR: " + Repr(e).to_string()
  }
}

///|
fn main {
  println(
    run(
      "set total 0\nset i 1\nwhile {$i <= 5} {\n set total [expr {$total + $i}]\n incr i\n}\nputs \"sum=$total\"\nset total",
    ),
  )
}
