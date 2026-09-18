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
    "rename", "try", "throw", "format", "scan", "switch",
  ]
}

///|
fn Interpreter::command_value(
  self : Interpreter,
  values : Array[TclValue],
  depth : Int,
  discard_result? : Bool = false,
) -> TclValue raise TclError {
  let requested = values[0].text
  self.tick()
  if depth > 64 {
    raise Invalid("command recursion limit")
  }
  let command = match self.find_command(requested) {
    Some(command) => command.origin()
    None => {
      let local_handler = self.state.unknown_handlers
        .get(self.frame.namespace_name)
        .unwrap_or(text_value(""))
      let global_handler = self.state.unknown_handlers
        .get("::")
        .unwrap_or(text_value("::unknown"))
      let handler = if !local_handler.text.is_empty() {
        local_handler
      } else if !global_handler.text.is_empty() {
        global_handler
      } else {
        text_value("::unknown")
      }
      let words = handler.as_list()
      if words.is_empty() ||
        (words[0].text == "::unknown" && self.find_command("::unknown") is None) {
        raise Signal(
          completion_error(
            "invalid command name \"" + requested + "\"",
            errorcode=format_list(["TCL", "LOOKUP", "COMMAND", requested]),
          ),
        )
      }
      return self.command_value(words + values, depth + 1, discard_result~)
    }
  }
  let name = match command.body {
    Script(definition) =>
      return self.invoke_procedure(definition, values, depth)
    EnsembleCommand(ensemble) =>
      return self.invoke_ensemble(
        command,
        ensemble,
        values,
        depth,
        discard_result~,
      )
    Native(name) => name
    Imported(_) => raise Invalid("invalid command import")
  }
  // Only renamed/qualified native commands need a canonical command word.
  // The caller owns the array, so normalize a copy only in that case.
  let values = if requested == name {
    values
  } else {
    let normalized = values.copy()
    normalized[0] = text_value(name)
    normalized
  }
  let n = values.length()
  let text = match name {
    "list"
    | "llength"
    | "lindex"
    | "lappend"
    | "join"
    | "split"
    | "concat"
    | "lrange"
    | "lreverse"
    | "lrepeat" => return self.list_command(values, discard_result~)
    "lset" | "linsert" | "lreplace" | "lsearch" | "lsort" =>
      return self.extended_list_command(values, depth)
    "while"
    | "for"
    | "foreach"
    | "lmap"
    | "break"
    | "continue"
    | "catch"
    | "error"
    | "try"
    | "throw" => return self.control_command(values, depth)
    "namespace" => return self.namespace_command(values, depth)
    "switch" => return self.switch_command(values, depth, discard_result~)
    "global" | "variable" | "upvar" | "uplevel" =>
      return self.scope_command(values, depth)
    "array" => return self.array_command(values)
    "dict" => return self.dict_command(values, depth, discard_result~)
    "format" => format_command(values)
    "scan" => return self.scan_command(values.map(v => v.text))
    "string" => return self.string_command(values)
    "info" => self.info_command(values.map(v => v.text))
    "set" =>
      if n == 2 {
        return self.read_value(values[1].text)
      } else if n == 3 {
        self.set_value(values[1].text, values[2])
        return values[2]
      } else {
        raise Invalid("set arity")
      }
    "unset" => {
      let mut i = 1
      let mut quiet = false
      if i < n && values[i].text == "-nocomplain" {
        quiet = true
        i += 1
      }
      if i < n && values[i].text == "--" {
        i += 1
      }
      if i == n && !quiet {
        raise Invalid("unset arity")
      }
      for name in values[i:] {
        self.unset_var(name.text, quiet)
      }
      ""
    }
    "incr" => {
      if n != 2 && n != 3 {
        raise Invalid("incr arity")
      }
      let text = integer_add(
        self.get_var(values[1].text).unwrap_or("0"),
        if n == 3 {
          values[2].text
        } else {
          "1"
        },
      )
      self.set_var(values[1].text, text)
      text
    }
    "append" => {
      if n < 2 {
        raise Invalid("append arity")
      }
      let original = self.get_value(values[1].text).unwrap_or(text_value(""))
      if values[2:].iter().all(v => v.text.is_empty()) {
        self.set_value(values[1].text, original)
        return original
      }
      let previous = original.text
      let pieces = [previous] + values[2:].iter().map(v => v.text).collect()
      let mut size = 0
      for value in pieces {
        size += value.length()
        if size > 1000000 {
          raise Invalid("append size limit")
        }
      }
      let result = pieces.join("")
      self.set_var(values[1].text, result)
      result
    }
    "expr" => {
      if n < 2 {
        raise Invalid("expr arity")
      }
      let source = if n == 2 {
        values[1].text
      } else {
        values[1:].iter().map(v => v.text).collect().join(" ")
      }
      return self.expression_object(source, depth)
    }
    "puts" => {
      let nonewline = n >= 2 && values[1].text == "-nonewline"
      let start = if nonewline { 2 } else { 1 }
      let value = if n == start + 1 {
        values[start].text
      } else if n == start + 2 && values[start].text == "stdout" {
        values[start + 1].text
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
        let expression = values[i].text
        i += 1
        if i < n && values[i].text == "then" {
          i += 1
        }
        if i >= n {
          raise Invalid("if missing body")
        }
        i += 1
        if boolean(self.expression_value(expression, depth)) {
          return self.execute_value_script(
            values[i - 1],
            depth + 1,
            discard_result~,
          )
        }
        if i == n {
          return text_value("")
        }
        if values[i].text == "elseif" {
          i += 1
          continue
        }
        if values[i].text == "else" {
          i += 1
        }
        if i != n - 1 {
          raise Invalid("if malformed else")
        }
        return self.execute_value_script(values[i], depth + 1, discard_result~)
      }
      raise Invalid("if arity")
    }
    "proc" => {
      if n != 4 {
        raise Invalid("proc name parameters body")
      }
      let key = command_name(self.frame.namespace_name, values[1].text)
      let owner = command_parent(key)
      if !self.state.namespaces.contains(owner) {
        raise Invalid("procedure namespace missing")
      }
      let parameters = []
      for spec in values[2].as_list() {
        let parts = spec.as_list()
        if parts.is_empty() || parts.length() > 2 {
          raise Invalid("invalid procedure parameter")
        }
        parameters.push(
          (
            parts[0].text,
            if parts.length() == 2 {
              Some(parts[1])
            } else {
              None
            },
          ),
        )
      }
      self.define_command(
        key,
        Script({ parameters, body: values[3].text, namespace_name: owner, }),
      )
      ""
    }
    "return" => return self.return_command(values)
    "eval" => {
      if n < 2 {
        raise Invalid("eval arity")
      }
      return self.execute_value_script(
        script_arguments(values[1:].to_owned()),
        depth + 1,
        discard_result~,
      )
    }
    "subst" => self.subst_command(values.map(v => v.text), depth)
    "rename" => {
      if n != 3 {
        raise Invalid("rename arity")
      }
      self.rename_command(values[1].text, values[2].text)
    }
    _ => raise Invalid("unsupported command " + name)
  }
  text_value(text)
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
      result.value.text
    }
    1 => {
      self.record_error(result)
      raise Invalid(result.value.text)
    }
    3 => raise Invalid("invoked break outside of a loop")
    4 => raise Invalid("invoked continue outside of a loop")
    code => raise Invalid("command returned bad code: " + code.to_string())
  }
}

///|
fn Interpreter::command(
  self : Interpreter,
  args : Array[String],
  depth : Int,
) -> String raise TclError {
  self.command_value(args.map(text_value), depth).text
}
