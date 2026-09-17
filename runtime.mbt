///|
pub suberror TclError {
  Invalid(String)
  Return(String)
  Break
  Continue
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
  {
    state: {
      globals: Map([]),
      aliases: Map([]),
      procedures: Map([]),
      namespaces: Map([("::", true)]),
      cache: ParseCache::new(),
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
    "rename",
  ]
}

///|
fn builtin_name(name : String) -> Bool {
  builtin_names().contains(name)
}

///|
fn Interpreter::command(
  self : Interpreter,
  input : Array[String],
  depth : Int,
  discard_result? : Bool = false,
) -> String raise TclError {
  self.tick()
  if self.find_procedure(input[0]) is Some(key) {
    return self.invoke_procedure([key] + input[1:].to_owned(), depth)
  }
  let args = if input[0].has_prefix("::") {
    let args = input.copy()
    args[0] = args[0][2:].to_owned()
    args
  } else {
    input
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
    | "error" => self.control_command(args, depth)
    "namespace" => self.namespace_command(args, depth)
    "global" | "variable" | "upvar" | "uplevel" =>
      self.scope_command(args, depth)
    "array" => self.array_command(args)
    "dict" => self.dict_command(args, depth, discard_result~)
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
      let key = qualified_name(self.frame.namespace_name, args[1])
      let owner = namespace_parent(key)
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
      self.state.procedures[key] = {
        parameters,
        body: args[3],
        namespace_name: owner,
      }
      ""
    }
    "return" => {
      if n > 2 {
        raise Invalid("return options not implemented")
      }
      raise Return(if n == 2 { args[1] } else { "" })
    }
    "eval" => {
      if n < 2 {
        raise Invalid("eval arity")
      }
      self.execute(args[1:].to_owned().join(" "), depth + 1, discard_result~)
    }
    "subst" => {
      if n != 2 {
        raise Invalid("subst options not implemented")
      }
      let parser = ScriptParser::{ chars: args[1].to_array(), pos: 0, }
      self.expand_parts(parser.parts('\u0000', false, 0), depth + 1)
    }
    "rename" => {
      if n != 3 {
        raise Invalid("rename arity")
      }
      let key = self.find_procedure(args[1]).unwrap_or("")
      if key.is_empty() {
        raise Invalid("only user procedures can be renamed")
      }
      let definition = self.state.procedures.get(key).unwrap()
      if !args[2].is_empty() {
        let target = qualified_name(self.frame.namespace_name, args[2])
        if self.state.procedures.contains(target) {
          raise Invalid("target command exists")
        }
        let destination = namespace_parent(target)
        if !self.state.namespaces.contains(destination) {
          raise Invalid("target namespace does not exist")
        }
        self.state.procedures[target] = {
          parameters: definition.parameters,
          body: definition.body,
          namespace_name: destination,
        }
      }
      self.state.procedures.remove(key)
      ""
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
  self.execute(source, 0) catch {
    Return(value) => value
    Invalid(message) => raise Invalid(message)
    Break => raise Invalid("invoked break outside of a loop")
    Continue => raise Invalid("invoked continue outside of a loop")
  }
}
