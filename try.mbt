///|
struct Handler {
  code : Int
  pattern : Array[String]?
  variables : Array[String]
  script : TclValue
} derive(Debug)

///|
fn Interpreter::try_command(
  self : Interpreter,
  input : Array[TclValue],
  depth : Int,
) -> TclValue raise TclError {
  let args = input.map(v => v.text)
  if args.length() < 2 {
    raise Invalid("try body required")
  }
  let handlers : Array[Handler] = []
  let mut finalizer : TclValue? = None
  let mut index = 2
  while index < args.length() {
    let kind = args[index]
    if kind == "finally" {
      if index != args.length() - 2 {
        raise Invalid("finally must be last with one script")
      }
      finalizer = Some(input[index + 1])
      break
    }
    if (kind != "on" && kind != "trap") || index + 3 >= args.length() {
      raise Invalid("invalid try handler")
    }
    let code = if kind == "on" { completion_code(args[index + 1]) } else { 1 }
    let pattern = if kind == "trap" {
      Some(parse_list(args[index + 1]))
    } else {
      None
    }
    let variables = parse_list(args[index + 2])
    handlers.push({ code, pattern, variables, script: input[index + 3], })
    index += 4
  }
  if handlers.last() is Some(handler) && handler.script.text == "-" {
    raise Invalid("last try handler has no script")
  }
  let original = self.capture_value(input[1], depth + 1)
  let mut result = original
  try {
    let mut selected = -1
    for i in 0..<handlers.length() {
      let handler = handlers[i]
      if handler.code != original.actual_code() {
        continue
      }
      let matched = match handler.pattern {
        None => true
        Some(pattern) => {
          let code = parse_list(
            option_get(original.options, "-errorcode").unwrap_or("NONE"),
          )
          let mut matched = pattern.length() <= code.length()
          if matched {
            for j in 0..<pattern.length() {
              if pattern[j] != code[j] {
                matched = false
                break
              }
            }
          }
          matched
        }
      }
      if matched {
        selected = i
        break
      }
    }
    if selected >= 0 {
      while handlers[selected].script.text == "-" {
        selected += 1
      }
      let handler = handlers[selected]
      if handler.variables.length() >= 1 && !handler.variables[0].is_empty() {
        self.set_value(handler.variables[0], original.value)
      }
      if handler.variables.length() >= 2 && !handler.variables[1].is_empty() {
        self.set_value(handler.variables[1], original.option_value())
      }
      result = self.capture_value(handler.script, depth + 1)
      if result.actual_code() == 1 {
        let options = result.options.copy()
        option_set_value(options, "-during", original.option_value())
        result = { ..result, options, }
      }
    }
  } catch {
    error => {
      result = outcome(error)
      if result.actual_code() == 1 {
        let options = result.options.copy()
        option_set_value(options, "-during", original.option_value())
        result = { ..result, options, }
      }
    }
  }
  if finalizer is Some(script) {
    let finished = self.capture_value(script, depth + 1)
    if finished.actual_code() != 0 {
      if finished.actual_code() == 1 {
        let options = finished.options.copy()
        option_set_value(options, "-during", result.option_value())
        result = { ..finished, options, }
      } else {
        result = finished
      }
    }
  }
  self.propagate_value(result)
}
