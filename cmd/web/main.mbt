///|
pub fn run(input : String) -> String {
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

}
