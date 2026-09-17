///|
pub fn run(input : String) -> String {
  try {
    let t = @lib.Interpreter::new()
    let result = t.eval(input)
    "Result: " + result + "\nOutput:\n" + t.printed()
  } catch {
    e => "ERROR: " + host_error(e)
  }
}

///|
pub fn evaluate(input : String) -> String {
  let t = @lib.Interpreter::new()
  evaluate_interpreter(t, input)
}

///|
fn evaluate_interpreter(t : @lib.Interpreter, input : String) -> String {
  t.clear_output()
  try {
    let result = t.eval(input, budget=100000)
    Json::object({
      "ok": Json::boolean(true),
      "result": Json::string(result),
      "output": Json::string(t.output_text()),
    }).stringify()
  } catch {
    error =>
      Json::object({
        "ok": Json::boolean(false),
        "error": Json::string(host_error(error)),
        "output": Json::string(t.output_text()),
      }).stringify()
  }
}

///|
// Debug's string formatter can panic on isolated UTF-16 surrogate units.
// Preserve script messages with the code-unit-aware JSON string serializer.
fn host_error(error : @lib.TclError) -> String {
  match error {
    @lib.Invalid(message) =>
      "Invalid(" + Json::string(message).stringify() + ")"
    other => Repr(other).to_string()
  }
}

///|
let sessions : Map[Int, @lib.Interpreter] = Map([])

///|
let next_session : Ref[Int] = Ref(0)

///|
pub fn new_session() -> Int {
  if sessions.length() >= 32 {
    return -1
  }
  next_session.val += 1
  sessions[next_session.val] = @lib.Interpreter::new()
  next_session.val
}

///|
pub fn session_eval(id : Int, input : String) -> String {
  match sessions.get(id) {
    Some(t) => evaluate_interpreter(t, input)
    None =>
      "{\"ok\":false,\"error\":\"Unknown or closed session\",\"output\":\"\"}"
  }
}

///|
pub fn reset_session(id : Int) -> Bool {
  if !sessions.contains(id) {
    return false
  }
  sessions[id] = @lib.Interpreter::new()
  true
}

///|
pub fn close_session(id : Int) -> Unit {
  sessions.remove(id)
}

///|
fn main {

}
