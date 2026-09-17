///|
fn Interpreter::subst_command(
  self : Interpreter,
  args : Array[String],
  depth : Int,
) -> String raise TclError {
  if args.length() < 2 {
    raise Invalid("subst string required")
  }
  let mut variables = true
  let mut commands = true
  let mut escapes = true
  for option in args[1:args.length() - 1] {
    let matches = ["-nobackslashes", "-nocommands", "-novariables"].filter(name => {
      name.has_prefix(option)
    })
    if matches.length() != 1 {
      raise Invalid("unknown or ambiguous subst option")
    }
    match matches[0] {
      "-nobackslashes" => escapes = false
      "-nocommands" => commands = false
      _ => variables = false
    }
  }
  let result = self.substitute(
    args[args.length() - 1],
    depth,
    variables,
    commands,
    escapes,
  )
  self.state.return_options.val = []
  result
}

///|
fn Interpreter::substitute(
  self : Interpreter,
  source : String,
  depth : Int,
  variables : Bool,
  commands : Bool,
  escapes : Bool,
) -> String raise TclError {
  if source.length() > 1000000 {
    raise Invalid("substitution input size limit")
  }
  let parser = ScriptParser::new(source)
  let output = StringBuilder()
  let mut size = 0
  while parser.pos < parser.chars.length() {
    let c = parser.peek()
    let value = try {
      if c == '$' && variables {
        // A variable token must parse completely before any index substitutions.
        // Index substitutions always use all three substitution kinds.
        self.expand_parts([parser.variable(0)], depth + 1)
      } else if c == '[' && commands {
        parser.pos += 1
        self.subst_bracket(parser, depth + 1)
      } else if c == '\\' && escapes {
        let (value, next) = backslash(parser.chars, parser.pos)
        parser.pos = next
        value
      } else {
        parser.pos += 1
        c.to_string()
      }
    } catch {
      error => {
        let result = outcome(error)
        match result.actual_code() {
          1 => raise Signal(result)
          3 => return output.to_string()
          4 => ""
          _ => result.value
        }
      }
    }
    size += value.length()
    if size > 1000000 {
      raise Invalid("substitution result size limit")
    }
    output.write_string(value)
  }
  output.to_string()
}

///|
fn Interpreter::subst_bracket(
  self : Interpreter,
  parser : ScriptParser,
  depth : Int,
) -> String raise TclError {
  let mut value = ""
  while true {
    let commands = parser.script(true, 0, one=true)
    let closed = parser.pos > 0 && parser.chars[parser.pos - 1] == ']'
    if !commands.is_empty() {
      value = self.execute_commands(commands, depth) catch {
        error => {
          let code = outcome(error).actual_code()
          // Error and break stop immediately. Other exceptional completions
          // still require a syntactically complete remaining bracket script.
          if code != 1 && code != 3 && !closed {
            ignore(parser.script(true, 0))
          }
          raise Signal(outcome(error))
        }
      }
    }
    if closed {
      break value
    }
  } nobreak {
    ""
  }
}

///|
pub fn is_complete(source : String) -> Bool raise TclError {
  if source.length() > 1000000 {
    raise Invalid("script completeness size limit")
  }
  let parser = ScriptParser::new(source)
  try {
    ignore(parser.script(false, 0))
    !parser.trailing_continuation
  } catch {
    Invalid(message) => {
      if message.has_suffix("limit") || message.has_suffix("depth") {
        raise Invalid(message)
      }
      !message.has_prefix("missing")
    }
    error => raise error
  }
}
