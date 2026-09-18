///|
pub suberror TclError {
  Invalid(String)
  Return(String)
  Break
  Continue
  Signal(Completion)
} derive(Debug)

///|
pub struct Interpreter {
  state : State
  frame : Frame
  output : Array[String]
  output_size : Array[Int]
  budget : Ref[Int]
} derive(Debug)

///|
pub fn Interpreter::new() -> Interpreter {
  let commands : Map[String, Command] = Map([])
  for name in builtin_names() {
    let key = "::" + name
    commands[key] = { name: key, body: Native(name), }
  }
  {
    state: {
      globals: Map([]),
      aliases: Map([]),
      commands,
      exports: Map([]),
      namespace_paths: Map([]),
      unknown_handlers: Map([]),
      namespaces: Map([("::", true)]),
      cache: ParseCache::new(),
      return_options: Ref([]),
      error_stack: Ref(""),
    },
    frame: {
      vars: Map([]),
      namespace_name: "::",
      procedure: false,
      parent: None,
    },
    output: [],
    output_size: [0],
    budget: Ref(10000),
  }
}

///|
pub fn Interpreter::printed(self : Interpreter) -> String {
  let value = self.output.join("")
  if value.has_suffix("\n") {
    value[:value.length() - 1].to_owned()
  } else {
    value
  }
}

///|
pub fn Interpreter::output_text(self : Interpreter) -> String {
  self.output.join("")
}

///|
pub fn Interpreter::clear_output(self : Interpreter) -> Unit {
  self.output.clear()
  self.output_size[0] = 0
}

///|
fn integer(s : String) -> Int raise TclError {
  if small_decimal(s) is Some(value) {
    return value
  }
  let n = whole(s)
  if n < -2147483648N || n > 2147483647N {
    raise Invalid("bounded integer required")
  }
  n.to_int()
}

///|
fn builtin_names() -> Array[String] {
  [
    "set", "unset", "incr", "append", "expr", "puts", "if", "proc", "return", "list",
    "llength", "lindex", "lappend", "join", "split", "concat", "lrange", "lreverse",
    "lrepeat", "lset", "linsert", "lreplace", "lsearch", "lsort", "while", "for",
    "foreach", "lmap", "break", "continue", "catch", "error", "namespace", "global",
    "variable", "upvar", "uplevel", "array", "dict", "string", "info", "eval", "subst",
    "rename", "try", "throw", "format", "scan",
  ]
}

///|
fn Interpreter::command(
  self : Interpreter,
  input : Array[String],
  depth : Int,
  discard_result? : Bool = false,
) -> String raise TclError {
  self.tick()
  if depth > 64 {
    raise Invalid("command recursion limit")
  }
  let command = match self.find_command(input[0]) {
    Some(command) => command.origin()
    None => {
      let local_handler = self.state.unknown_handlers
        .get(self.frame.namespace_name)
        .unwrap_or("")
      let global_handler = self.state.unknown_handlers
        .get("::")
        .unwrap_or("::unknown")
      let handler = if !local_handler.is_empty() {
        local_handler
      } else if !global_handler.is_empty() {
        global_handler
      } else {
        "::unknown"
      }
      let words = parse_list(handler)
      if words.is_empty() ||
        (words[0] == "::unknown" && self.find_command("::unknown") is None) {
        raise Signal(
          completion_error(
            "invalid command name \"" + input[0] + "\"",
            errorcode=format_list(["TCL", "LOOKUP", "COMMAND", input[0]]),
          ),
        )
      }
      return self.command(words + input, depth + 1, discard_result~)
    }
  }
  let name = match command.body {
    Script(definition) => return self.invoke_procedure(definition, input, depth)
    EnsembleCommand(ensemble) =>
      return self.invoke_ensemble(
        command,
        ensemble,
        input,
        depth,
        discard_result~,
      )
    Native(name) => name
    Imported(_) => raise Invalid("invalid command import")
  }
  let args = if input[0] == name {
    input
  } else {
    let args = input.copy()
    args[0] = name
    args
  }
  let n = args.length()
  match args[0] {
    "list"
    | "llength"
    | "lindex"
    | "lappend"
    | "join"
    | "split"
    | "concat"
    | "lrange"
    | "lreverse"
    | "lrepeat" => self.list_command(args, discard_result~)
    "lset" | "linsert" | "lreplace" | "lsearch" | "lsort" =>
      self.extended_list_command(args, depth)
    "while"
    | "for"
    | "foreach"
    | "lmap"
    | "break"
    | "continue"
    | "catch"
    | "error"
    | "try"
    | "throw" => self.control_command(args, depth)
    "namespace" => self.namespace_command(args, depth)
    "global" | "variable" | "upvar" | "uplevel" =>
      self.scope_command(args, depth)
    "array" => self.array_command(args)
    "dict" => self.dict_command(args, depth, discard_result~)
    "format" => format_command(args)
    "scan" => self.scan_command(args)
    "string" => self.string_command(args)
    "info" => self.info_command(args)
    "set" =>
      if n == 2 {
        self.read_var(args[1])
      } else if n == 3 {
        self.set_var(args[1], args[2])
        args[2]
      } else {
        raise Invalid("set arity")
      }
    "unset" => {
      let mut i = 1
      let mut quiet = false
      if i < n && args[i] == "-nocomplain" {
        quiet = true
        i += 1
      }
      if i < n && args[i] == "--" {
        i += 1
      }
      if i == n && !quiet {
        raise Invalid("unset arity")
      }
      for name in args[i:] {
        self.unset_var(name, quiet)
      }
      ""
    }
    "incr" => {
      if n != 2 && n != 3 {
        raise Invalid("incr arity")
      }
      let text = integer_add(
        self.get_var(args[1]).unwrap_or("0"),
        if n == 3 {
          args[2]
        } else {
          "1"
        },
      )
      self.set_var(args[1], text)
      text
    }
    "append" => {
      if n < 2 {
        raise Invalid("append arity")
      }
      let previous = self.get_var(args[1]).unwrap_or("")
      let values = [previous] + args[2:].to_owned()
      let mut size = 0
      for value in values {
        size += value.length()
        if size > 1000000 {
          raise Invalid("append size limit")
        }
      }
      let result = values.join("")
      self.set_var(args[1], result)
      result
    }
    "expr" => {
      if n < 2 {
        raise Invalid("expr arity")
      }
      self.expression_value(args[1:].to_owned().join(" "), depth)
    }
    "puts" => {
      let nonewline = n >= 2 && args[1] == "-nonewline"
      let start = if nonewline { 2 } else { 1 }
      let value = if n == start + 1 {
        args[start]
      } else if n == start + 2 && args[start] == "stdout" {
        args[start + 1]
      } else {
        raise Invalid("puts arity or unsupported channel")
      }
      let text = value + (if nonewline { "" } else { "\n" })
      if text.length() > 1000000 - self.output_size[0] {
        raise Invalid("printed output size limit")
      }
      self.output_size[0] += text.length()
      self.output.push(text)
      ""
    }
    "if" => {
      let mut i = 1
      while i < n {
        let expression = args[i]
        i += 1
        if i < n && args[i] == "then" {
          i += 1
        }
        if i >= n {
          raise Invalid("if missing body")
        }
        let body = args[i]
        i += 1
        if boolean(self.expression_value(expression, depth)) {
          return self.execute(body, depth + 1, discard_result~)
        }
        if i == n {
          return ""
        }
        if args[i] == "elseif" {
          i += 1
          continue
        }
        if args[i] == "else" {
          i += 1
        }
        if i != n - 1 {
          raise Invalid("if malformed else")
        }
        return self.execute(args[i], depth + 1, discard_result~)
      }
      raise Invalid("if arity")
    }
    "proc" => {
      if n != 4 {
        raise Invalid("proc name parameters body")
      }
      let key = command_name(self.frame.namespace_name, args[1])
      let owner = command_parent(key)
      if !self.state.namespaces.contains(owner) {
        raise Invalid("procedure namespace missing")
      }
      let parameters = []
      for spec in parse_list(args[2]) {
        let parts = parse_list(spec)
        if parts.is_empty() || parts.length() > 2 {
          raise Invalid("invalid procedure parameter")
        }
        parameters.push(
          (parts[0], if parts.length() == 2 { Some(parts[1]) } else { None }),
        )
      }
      self.define_command(
        key,
        Script({ parameters, body: args[3], namespace_name: owner, }),
      )
      ""
    }
    "return" => self.return_command(args)
    "eval" => {
      if n < 2 {
        raise Invalid("eval arity")
      }
      self.execute(args[1:].to_owned().join(" "), depth + 1, discard_result~)
    }
    "subst" => self.subst_command(args, depth)
    "rename" => {
      if n != 3 {
        raise Invalid("rename arity")
      }
      self.rename_command(args[1], args[2])
    }
    _ => raise Invalid("unsupported command " + args[0])
  }
}

///|
pub fn Interpreter::eval(
  self : Interpreter,
  source : String,
  budget? : Int = 10000,
) -> String raise TclError {
  if budget < 1 || budget > 1000000 {
    raise Invalid("budget range")
  }
  self.budget.val = budget
  let result = self.capture(source, 0)
  let result = if result.level != 0 {
    { ..result, level: result.level - 1, }
  } else {
    result
  }
  match result.actual_code() {
    0 => {
      self.state.return_options.val = result.options
      result.value
    }
    1 => {
      self.record_error(result)
      raise Invalid(result.value)
    }
    3 => raise Invalid("invoked break outside of a loop")
    4 => raise Invalid("invoked continue outside of a loop")
    code => raise Invalid("command returned bad code: " + code.to_string())
  }
}
