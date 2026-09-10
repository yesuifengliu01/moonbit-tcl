///|
fn Interpreter::tick(self : Interpreter) -> Unit raise TclError {
  self.budget -= 1
  if self.budget < 0 {
    raise Invalid("execution budget")
  }
}

///|
fn Interpreter::invoke_procedure(
  self : Interpreter,
  args : Array[String],
  depth : Int,
) -> String raise TclError {
  let (parameters, body) = match self.procs.get(args[0]) {
    Some(p) => p
    None => raise Invalid("procedure missing")
  }
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
  let vars : Map[String, String] = Map([])
  for i in 0..<fixed {
    let (name, default) = parameters[i]
    let value = if i < supplied {
      args[i + 1]
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
    vars["args"] = format_list(
      if supplied > fixed {
        args[fixed + 1:].to_owned()
      } else {
        []
      },
    )
  }
  let child = Interpreter::{
    vars,
    procs: self.procs,
    output: self.output,
    output_size: self.output_size,
    budget: self.budget,
  }
  defer {
    self.budget = child.budget
  }
  child.execute(body, depth + 1) catch {
    Return(value) => value
    Break => raise Invalid("invoked break outside of a loop")
    Continue => raise Invalid("invoked continue outside of a loop")
    Invalid(message) => raise Invalid(message)
  }
}

///|
// 0 normal, 1 continue, 2 break; return and errors propagate across loop bodies.
fn Interpreter::loop_body(
  self : Interpreter,
  source : String,
  depth : Int,
) -> Int raise TclError {
  try {
    ignore(self.execute(source, depth + 1))
    0
  } catch {
    Break => 2
    Continue => 1
    Return(v) => raise Return(v)
    Invalid(v) => raise Invalid(v)
  }
}

///|
fn Interpreter::control_command(
  self : Interpreter,
  args : Array[String],
  depth : Int,
) -> String raise TclError {
  let n = args.length()
  match args[0] {
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
    "error" => {
      if n != 2 {
        raise Invalid("error arity")
      }
      raise Invalid(args[1])
    }
    "catch" => {
      if n != 2 && n != 3 {
        raise Invalid("catch arity")
      }
      let (code, result) = (0, self.execute(args[1], depth + 1)) catch {
        Invalid(v) => (1, v)
        Return(v) => (2, v)
        Break => (3, "")
        Continue => (4, "")
      }
      if n == 3 {
        self.vars[args[2]] = result
      }
      code.to_string()
    }
    "while" => {
      if n != 3 {
        raise Invalid("while arity")
      }
      while self.math(args[1], depth) != 0 {
        self.tick()
        if self.loop_body(args[2], depth) == 2 {
          break
        }
      }
      ""
    }
    "for" => {
      if n != 5 {
        raise Invalid("for arity")
      }
      ignore(self.execute(args[1], depth + 1))
      while self.math(args[2], depth) != 0 {
        self.tick()
        if self.loop_body(args[4], depth) == 2 {
          break
        }
        let code = self.loop_body(args[3], depth)
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
    "foreach" => {
      if n < 4 || n % 2 != 0 {
        raise Invalid("foreach arity")
      }
      let groups : Array[(Array[String], Array[String])] = []
      let mut count = 0
      let mut i = 1
      while i < n - 1 {
        let names = parse_list(args[i])
        let values = parse_list(args[i + 1])
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
            self.vars[names[j]] = if at < values.length() {
              values[at]
            } else {
              ""
            }
          }
        }
        if self.loop_body(args[n - 1], depth) == 2 {
          break
        }
      }
      ""
    }
    _ => raise Invalid("unsupported control command")
  }
}
