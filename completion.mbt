///|
struct Completion {
  code : Int
  level : Int
  value : TclValue
  options : Array[(String, TclValue)]
  skip_trace : Bool
} derive(Debug)

///|
pub struct Evaluation {
  code : Int
  result : String
  options : String
} derive(Debug)

///|
fn Completion::actual_code(self : Completion) -> Int {
  if self.level != 0 {
    2
  } else {
    self.code
  }
}

///|
fn option_get(options : Array[(String, TclValue)], name : String) -> String? {
  for (key, value) in options {
    if key == name {
      return Some(value.text)
    }
  }
  None
}

///|
fn option_set_value(
  options : Array[(String, TclValue)],
  name : String,
  value : TclValue,
) -> Unit {
  for i in 0..<options.length() {
    if options[i].0 == name {
      options[i] = (name, value)
      return
    }
  }
  options.push((name, value))
}

///|
fn Completion::option_value(self : Completion) -> TclValue raise TclError {
  let options = self.options.copy()
  option_set(options, "-code", self.code.to_string())
  option_set(options, "-level", self.level.to_string())
  dictionary_value(options.map(p => (text_value(p.0), p.1)))
}

///|
fn completion(
  code : Int,
  value : String,
  level? : Int = 0,
  options? : Array[(String, TclValue)] = [],
  skip_trace? : Bool = false,
) -> Completion {
  { code, level, value: text_value(value), options, skip_trace, }
}

///|
fn completion_error(
  message : String,
  errorcode? : String = "NONE",
) -> Completion {
  completion(1, message, options=[("-errorcode", text_value(errorcode))])
}

///|
fn outcome(error : TclError) -> Completion {
  match error {
    Signal(result) => result
    Invalid(message) => completion_error(message)
    Return(value) => completion(0, value, level=1)
    Break => completion(3, "")
    Continue => completion(4, "")
  }
}

///|
fn completion_code(value : String) -> Int raise TclError {
  match value {
    "ok" => 0
    "error" => 1
    "return" => 2
    "break" => 3
    "continue" => 4
    _ =>
      integer(value) catch {
        _ =>
          raise Signal(
            completion_error(
              "bad completion code \"" +
              value +
              "\": must be ok, error, return, break, continue, or an integer",
              errorcode="TCL RESULT ILLEGAL_CODE",
            ),
          )
      }
  }
}

///|
fn Interpreter::propagate_value(
  self : Interpreter,
  result : Completion,
) -> TclValue raise TclError {
  if result.actual_code() == 0 {
    self.state.return_options.val = result.options
    result.value
  } else {
    raise Signal(result)
  }
}

///|
fn Interpreter::record_error(self : Interpreter, result : Completion) -> Unit {
  if result.actual_code() != 1 {
    return
  }
  let info = option_get(result.options, "-errorinfo").unwrap_or(
    result.value.text,
  )
  let code = option_get(result.options, "-errorcode").unwrap_or("NONE")
  self.state.error_stack.val = option_get(result.options, "-errorstack").unwrap_or(
    "",
  )
  for (name, value) in [("::errorInfo", info), ("::errorCode", code)] {
    match self.state.globals.get(name) {
      Some(cell) => cell.value = Some(Scalar(text_value(value)))
      None =>
        self.state.globals[name] = {
          value: Some(Scalar(text_value(value))),
          declared: false,
        }
    }
  }
}

///|
fn Interpreter::annotate_error(
  self : Interpreter,
  result : Completion,
  source : String,
  line : Int,
  args : Array[String],
) -> Completion raise TclError {
  if result.actual_code() != 1 {
    return result
  }
  let options = result.options.copy()
  let previous = option_get(options, "-errorinfo").unwrap_or("")
  let text = if result.skip_trace && !previous.is_empty() {
    previous
  } else if previous.is_empty() {
    result.value.text + "\n    while executing\n\"" + source + "\""
  } else {
    previous + "\n    invoked from within\n\"" + source + "\""
  }
  // Limit diagnostics independently of the value and output quotas.
  if text.length() > 1000000 {
    raise Invalid("error diagnostic size limit")
  }
  option_set(options, "-errorinfo", text)
  option_set(options, "-errorline", line.to_string())
  if option_get(options, "-errorcode") is None {
    option_set(options, "-errorcode", "NONE")
  }
  if option_get(options, "-errorstack") is None {
    option_set(
      options,
      "-errorstack",
      if result.skip_trace {
        ""
      } else {
        format_list(["INNER", format_list(args)])
      },
    )
  }
  let annotated = { ..result, options, skip_trace: false, }
  self.record_error(annotated)
  annotated
}

///|
fn Interpreter::capture_value(
  self : Interpreter,
  source : TclValue,
  depth : Int,
) -> Completion {
  self.state.return_options.val = []
  let result = try {
    let value = self.execute_value_script(source, depth)
    {
      ..completion(0, value.text, options=self.state.return_options.val),
      value,
    }
  } catch {
    error => outcome(error)
  }
  self.state.return_options.val = []
  if result.actual_code() == 1 {
    if option_get(result.options, "-errorinfo") is None {
      option_set(result.options, "-errorinfo", result.value.text)
    }
    if option_get(result.options, "-errorline") is None {
      option_set(result.options, "-errorline", "1")
    }
    if option_get(result.options, "-errorstack") is None {
      option_set(result.options, "-errorstack", "")
    }
  }
  self.record_error(result)
  result
}

///|
// Raw script completion, like Tcl catch, without consuming a return level.
// An invalid budget still raises an API usage error.
pub fn Interpreter::eval_catch(
  self : Interpreter,
  source : String,
  budget? : Int = 10000,
) -> Evaluation raise TclError {
  if budget < 1 || budget > 1000000 {
    raise Invalid("budget range")
  }
  self.budget.val = budget
  let result = self.capture(source, 0)
  {
    code: result.actual_code(),
    result: result.value.text,
    options: result.option_text(),
  }
}

///|
fn merge_return_options(
  target : Array[(String, TclValue)],
  values : Array[(String, TclValue)],
  depth : Int,
) -> Unit raise TclError {
  if depth > 64 {
    raise Invalid("return option nesting limit")
  }
  for (key, value) in values {
    if key == "-options" {
      merge_return_options(
        target,
        dictionary_values(value).map(p => (p.0.text, p.1)),
        depth + 1,
      )
    } else {
      option_set_value(target, key, value)
    }
  }
}

///|
fn Interpreter::return_command(
  self : Interpreter,
  values : Array[TclValue],
) -> TclValue raise TclError {
  let args = values.map(v => v.text)
  if args.length() <= 2 {
    if args.length() == 1 {
      raise Return("")
    }
    raise Signal({
      ..completion(0, "", level=1),
      value: if values.length() == 2 {
        values[1]
      } else {
        text_value("")
      },
    })
  }
  let count = args.length() - 1
  let value = if count % 2 == 1 {
    values[values.length() - 1]
  } else {
    text_value("")
  }
  let pairs = []
  for i = 1; i + 1 < args.length(); i = i + 2 {
    pairs.push((args[i], values[i + 1]))
  }
  let options = []
  merge_return_options(options, pairs, 0)
  let mut code = completion_code(option_get(options, "-code").unwrap_or("0"))
  let level_text = option_get(options, "-level").unwrap_or("1")
  let mut level = try {
    let parsed = integer(level_text)
    if parsed < 0 {
      raise Invalid("negative level")
    }
    parsed
  } catch {
    _ =>
      raise Signal(
        completion_error(
          "bad -level value: expected non-negative integer but got \"" +
          level_text +
          "\"",
          errorcode="TCL RESULT ILLEGAL_LEVEL",
        ),
      )
  }
  if code == 2 {
    code = 0
    level += 1
  }
  let extras = options.filter(pair => pair.0 != "-code" && pair.0 != "-level")
  if option_get(extras, "-errorcode") is Some(text) {
    ignore(parse_list(text))
  }
  if option_get(extras, "-errorstack") is Some(text) {
    if parse_list(text).length() % 2 != 0 {
      raise Invalid("errorstack requires token/value pairs")
    }
  }
  if code == 1 {
    if option_get(extras, "-errorcode") is None {
      option_set(extras, "-errorcode", "NONE")
    }
    if option_get(extras, "-errorinfo") is Some(text) &&
      !text.is_empty() &&
      option_get(extras, "-errorline") is None {
      option_set(extras, "-errorline", "1")
    }
  }
  self.propagate_value({
    ..completion(
      code,
      value.text,
      level~,
      options=extras,
      skip_trace=level == 0 &&
        option_get(extras, "-errorinfo").unwrap_or("") != "",
    ),
    value,
  })
}

///|
fn Interpreter::error_command(
  self : Interpreter,
  values : Array[TclValue],
) -> TclValue raise TclError {
  let args = values.map(v => v.text)
  self.state.return_options.val = []
  let n = args.length()
  if args[0] == "throw" {
    if n != 3 {
      raise Invalid("throw requires error type and message")
    }
    if parse_list(args[1]).is_empty() {
      raise Signal(
        completion_error(
          "type must be non-empty list",
          errorcode="TCL OPERATION THROW BADEXCEPTION",
        ),
      )
    }
    raise Signal({
      ..completion_error(args[2], errorcode=args[1]),
      value: values[2],
    })
  }
  if n < 2 || n > 4 {
    raise Invalid("error arity")
  }
  let options = []
  if n >= 3 {
    options.push(("-errorinfo", values[2]))
  }
  options.push(
    ("-errorcode", if n == 4 { values[3] } else { text_value("NONE") }),
  )
  raise Signal({
    ..completion(1, args[1], options~, skip_trace=n >= 3 && !args[2].is_empty()),
    value: values[1],
  })
}

///|
fn Interpreter::catch_command(
  self : Interpreter,
  input : Array[TclValue],
  depth : Int,
) -> String raise TclError {
  let args = input.map(v => v.text)
  if args.length() < 2 || args.length() > 4 {
    raise Invalid("catch arity")
  }
  let result = self.capture_value(input[1], depth + 1)
  if args.length() >= 3 {
    self.set_value(args[2], result.value)
  }
  if args.length() == 4 {
    self.set_value(args[3], result.option_value())
  }
  result.actual_code().to_string()
}

///|
fn Interpreter::capture(
  self : Interpreter,
  source : String,
  depth : Int,
) -> Completion {
  self.capture_value(text_value(source), depth)
}

///|
fn option_set(
  options : Array[(String, TclValue)],
  name : String,
  value : String,
) -> Unit {
  option_set_value(options, name, text_value(value))
}

///|
fn Completion::option_text(self : Completion) -> String raise TclError {
  self.option_value().text
}
