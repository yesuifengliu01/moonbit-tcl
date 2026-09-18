///|
fn Interpreter::tick(self : Interpreter) -> Unit raise TclError {
  self.budget.val -= 1
  if self.budget.val < 0 {
    raise Invalid("execution budget")
  }
}

///|
fn Interpreter::invoke_procedure(
  self : Interpreter,
  definition : Procedure,
  values : Array[TclValue],
  depth : Int,
) -> TclValue raise TclError {
  let args = values.map(v => v.text)
  let parameters = definition.parameters
  let body = definition.body
  let variadic = !parameters.is_empty() &&
    parameters[parameters.length() - 1].0 == "args"
  let fixed = parameters.length() - (if variadic { 1 } else { 0 })
  let supplied = args.length() - 1
  if !variadic && supplied > fixed {
    raise Invalid("procedure arity")
  }
  let mut required = 0
  for i in 0..<fixed {
    if parameters[i].1 is None {
      required = i + 1
    }
  }
  if supplied < required {
    raise Invalid("procedure arity")
  }
  let vars : Map[String, TclValue] = Map([])
  for i in 0..<fixed {
    let (name, default) = parameters[i]
    let value = if i < supplied {
      values[i + 1]
    } else {
      match default {
        Some(v) => v
        None => raise Invalid("procedure arity")
      }
    }
    // Tcl 8.x duplicate formal names refer to the first slot.
    if !vars.contains(name) {
      vars[name] = value
    }
  }
  if variadic && !vars.contains("args") {
    vars["args"] = list_value(
      if supplied > fixed {
        values[fixed + 1:].to_owned()
      } else {
        []
      },
    )
  }
  let bindings : Map[String, Binding] = Map([])
  for name, value in vars {
    bindings[name] = {
      cell: { value: Some(Scalar(value)), declared: false, },
      index: None,
      linked: false,
    }
  }
  let child = self.with_frame({
    vars: bindings,
    namespace_name: definition.namespace_name,
    procedure: true,
    parent: Some(self.frame),
  })
  child.execute_value(body, depth + 1) catch {
    error => {
      let result = outcome(error)
      if result.level != 0 {
        self.propagate_value({ ..result, level: result.level - 1, })
      } else if result.code == 3 || result.code == 4 {
        let options = result.options.copy()
        option_set(options, "-errorcode", "TCL RESULT UNEXPECTED")
        raise Signal(
          completion(
            1,
            "invoked " +
            (if result.code == 3 { "break" } else { "continue" }) +
            " outside of a loop",
            options~,
          ),
        )
      } else if result.code == 1 {
        let options = result.options.copy()
        let line = option_get(options, "-errorline").unwrap_or("1")
        let info = option_get(options, "-errorinfo").unwrap_or(
          result.value.text,
        )
        option_set(
          options,
          "-errorinfo",
          info + "\n    (procedure \"" + args[0] + "\" line " + line + ")",
        )
        let stack = option_get(options, "-errorstack").unwrap_or("")
        option_set(
          options,
          "-errorstack",
          stack +
          (if stack.is_empty() { "" } else { " " }) +
          format_list(["CALL", format_list(args)]),
        )
        raise Signal({ ..result, options, })
      } else {
        raise Signal(result)
      }
    }
  }
}

///|
// 0 normal, 1 continue, 2 break; return and errors propagate across loop bodies.
fn Interpreter::loop_body(
  self : Interpreter,
  source : TclValue,
  depth : Int,
) -> Int raise TclError {
  try {
    ignore(self.execute_value_script(source, depth + 1, discard_result=true))
    0
  } catch {
    Break => 2
    Continue => 1
    Signal(result) if result.actual_code() == 3 => 2
    Signal(result) if result.actual_code() == 4 => 1
    error => raise error
  }
}

///|
fn Interpreter::control_command(
  self : Interpreter,
  values : Array[TclValue],
  depth : Int,
) -> TclValue raise TclError {
  let args = values.map(v => v.text)
  let n = args.length()
  let text = match args[0] {
    "break" => {
      if n != 1 {
        raise Invalid("break arity")
      }
      raise Break
    }
    "continue" => {
      if n != 1 {
        raise Invalid("continue arity")
      }
      raise Continue
    }
    "error" | "throw" => return self.error_command(values)
    "return" => return self.return_command(values)
    "catch" => self.catch_command(values, depth)
    "try" => return self.try_command(values, depth)
    "while" => {
      if n != 3 {
        raise Invalid("while arity")
      }
      while self.math(args[1], depth) != 0 {
        self.tick()
        if self.loop_body(values[2], depth) == 2 {
          break
        }
      }
      ""
    }
    "for" => {
      if n != 5 {
        raise Invalid("for arity")
      }
      ignore(
        self.execute_value_script(values[1], depth + 1, discard_result=true),
      )
      while self.math(args[2], depth) != 0 {
        self.tick()
        if self.loop_body(values[4], depth) == 2 {
          break
        }
        let code = self.loop_body(values[3], depth)
        if code == 2 {
          break
        }
        // Tcl forbids continue from the loop's next script.
        if code == 1 {
          raise Continue
        }
      }
      ""
    }
    "foreach" | "lmap" => {
      let collected = []
      if n < 4 || n % 2 != 0 {
        raise Invalid("foreach arity")
      }
      let groups : Array[(Array[String], Array[TclValue])] = []
      let mut count = 0
      let mut i = 1
      while i < n - 1 {
        let names = parse_list(args[i])
        let values = values[i + 1].as_list()
        if names.is_empty() {
          raise Invalid("foreach variable list is empty")
        }
        count = count.max(
          (values.length() + names.length() - 1) / names.length(),
        )
        groups.push((names, values))
        i += 2
      }
      for iteration in 0..<count {
        self.tick()
        for (names, values) in groups {
          for j in 0..<names.length() {
            let at = iteration * names.length() + j
            self.set_value(
              names[j],
              if at < values.length() {
                values[at]
              } else {
                text_value("")
              },
            )
          }
        }
        if args[0] == "lmap" {
          collected.push(self.execute_value_script(values[n - 1], depth + 1)) catch {
            Continue => continue
            Break => break
            Signal(result) if result.actual_code() == 4 => continue
            Signal(result) if result.actual_code() == 3 => break
            error => raise error
          }
        } else if self.loop_body(values[n - 1], depth) == 2 {
          break
        }
      }
      if args[0] == "lmap" {
        return list_value(collected)
      } else {
        self.state.return_options.val = []
        ""
      }
    }
    _ => raise Invalid("unsupported control command")
  }
  text_value(text)
}
