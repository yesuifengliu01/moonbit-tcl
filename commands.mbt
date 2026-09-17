///|
enum CommandBody {
  Native(String)
  Script(Procedure)
  Imported(Command)
  EnsembleCommand(Ensemble)
} derive(Debug)

///|
// Imports retain command identity across rename and replacement. Deletion
// removes the command and every import that depends on it.
struct Command {
  mut name : String
  mut body : CommandBody
} derive(Debug)

///|
fn command_name(prefix : String, name : String) -> String {
  let result = qualified_name(prefix, name)
  if name.is_empty() || name.has_suffix("::") {
    if result == "::" {
      result
    } else {
      result + "::"
    }
  } else {
    result
  }
}

///|
fn command_parent(name : String) -> String {
  if name.has_suffix("::") && name != "::" {
    name[:name.length() - 2].to_owned()
  } else {
    namespace_parent(name)
  }
}

///|
fn Command::origin(self : Command) -> Command {
  let mut cursor = self
  while cursor.body is Imported(target) {
    cursor = target
  }
  cursor
}

///|
fn Command::depends_on(self : Command, target : Command) -> Bool {
  let mut cursor = self
  while true {
    if physical_equal(cursor, target) {
      return true
    }
    match cursor.body {
      Imported(parent) => cursor = parent
      _ => return false
    }
  } nobreak {
    false
  }
}

///|
fn Interpreter::find_command(self : Interpreter, name : String) -> Command? {
  let key = command_name(self.frame.namespace_name, name)
  if self.state.commands.get(key) is Some(command) {
    return Some(command)
  }
  if !name.has_prefix("::") {
    if self.state.namespace_paths.get(self.frame.namespace_name) is Some(path) {
      for space in path {
        if self.state.commands.get(command_name(space, name)) is Some(command) {
          return Some(command)
        }
      }
    }
    return self.state.commands.get(command_name("::", name))
  }
  None
}

///|
fn Interpreter::define_command(
  self : Interpreter,
  name : String,
  body : CommandBody,
) -> Unit raise TclError {
  match self.state.commands.get(name) {
    Some(command) => command.body = body
    None => {
      if self.state.commands.length() >= 10000 {
        raise Invalid("command count limit")
      }
      self.state.commands[name] = { name, body, }
    }
  }
}

///|
fn Interpreter::delete_command(self : Interpreter, command : Command) -> Unit {
  let doomed = self.state.commands
    .values()
    .filter(c => c.depends_on(command))
    .to_array()
  for item in doomed {
    self.state.commands.remove(item.name)
  }
}

///|
fn Interpreter::rename_command(
  self : Interpreter,
  old : String,
  new : String,
) -> String raise TclError {
  let command = match self.find_command(old) {
    Some(command) => command
    None => raise Invalid("unknown command")
  }
  if new.is_empty() {
    self.delete_command(command)
  } else {
    let target = command_name(self.frame.namespace_name, new)
    if self.state.commands.contains(target) {
      raise Invalid("target command exists")
    }
    let owner = command_parent(target)
    if !self.state.namespaces.contains(owner) {
      raise Invalid("target namespace does not exist")
    }
    self.state.commands.remove(command.name)
    command.name = target
    if command.body is Script(definition) {
      command.body = Script({ ..definition, namespace_name: owner, })
    }
    self.state.commands[target] = command
  }
  ""
}

///|
fn Interpreter::exported_commands(
  self : Interpreter,
  space : String,
) -> Array[Command] raise TclError {
  let patterns = self.state.exports.get(space).unwrap_or([])
  let result = []
  for command in self.state.commands.values() {
    if command_parent(command.name) == space {
      for pattern in patterns {
        if glob_match(pattern, namespace_tail(command.name), false) {
          result.push(command)
          break
        }
      }
    }
  }
  result
}

///|
fn Interpreter::command_pattern(
  self : Interpreter,
  pattern : String,
) -> (String, String) raise TclError {
  let full = command_name(self.frame.namespace_name, pattern)
  let space = command_parent(full)
  if !self.state.namespaces.contains(space) {
    raise Invalid("unknown namespace in command pattern")
  }
  (space, namespace_tail(full))
}

///|
fn Interpreter::namespace_import(
  self : Interpreter,
  args : Array[String],
  depth : Int,
) -> String raise TclError {
  let force = args.length() > 2 && args[2] == "-force"
  let start = if force { 3 } else { 2 }
  if args.length() == start {
    if force {
      return ""
    }
    let names = self.state.commands
      .values()
      .filter(c => {
        command_parent(c.name) == self.frame.namespace_name &&
        c.body is Imported(_)
      })
      .map(c => namespace_tail(c.name))
      .to_array()
    names.sort()
    return format_list(names)
  }
  for pattern in args[start:] {
    if self.state.commands.contains("::auto_import") {
      ignore(self.command(["::auto_import", pattern], depth + 1))
    }
    if !pattern.contains("::") {
      raise Invalid("import pattern requires namespace")
    }
    let (space, tail) = self.command_pattern(pattern)
    if space == self.frame.namespace_name {
      raise Invalid("cannot import from own namespace")
    }
    for command in self.exported_commands(space) {
      self.tick()
      if !glob_match(tail, namespace_tail(command.name), false) {
        continue
      }
      let target = command_name(
        self.frame.namespace_name,
        namespace_tail(command.name),
      )
      if self.state.commands.get(target) is Some(existing) {
        if existing.body is Imported(previous) &&
          physical_equal(previous, command) {
          continue
        }
        if !force {
          raise Invalid("import command conflict")
        }
        if command.depends_on(existing) {
          raise Invalid("import cycle")
        }
      }
      self.define_command(target, Imported(command))
    }
  }
  ""
}

///|
fn Interpreter::namespace_forget(
  self : Interpreter,
  args : Array[String],
) -> String raise TclError {
  for pattern in args[2:] {
    let qualified = pattern.contains("::")
    let (space, tail) = if qualified {
      self.command_pattern(pattern)
    } else {
      ("", pattern)
    }
    for command in self.state.commands.values().to_array() {
      if command_parent(command.name) != self.frame.namespace_name {
        continue
      }
      if command.body is Imported(parent) {
        let mut matched = !qualified &&
          glob_match(tail, namespace_tail(command.name), false)
        let mut cursor = parent
        while qualified {
          if command_parent(cursor.name) == space &&
            glob_match(tail, namespace_tail(cursor.name), false) {
            matched = true
            break
          }
          match cursor.body {
            Imported(next) => cursor = next
            _ => break
          }
        }
        if matched {
          self.delete_command(command)
        }
      }
    }
  }
  ""
}

///|
fn Interpreter::command_names(
  self : Interpreter,
  pattern : String,
  procedures_only : Bool,
) -> Array[String] raise TclError {
  let qualified = pattern.contains("::")
  let full = command_name(self.frame.namespace_name, pattern)
  let space = command_parent(full)
  let tail = if qualified { namespace_tail(full) } else { pattern }
  let scopes = if qualified {
    [space]
  } else {
    let scopes = [self.frame.namespace_name]
    if !procedures_only {
      for
        item in self.state.namespace_paths
        .get(self.frame.namespace_name)
        .unwrap_or([]) {
        scopes.push(item)
      }
      scopes.push("::")
    }
    scopes
  }
  let values : Array[String] = []
  for command in self.state.commands.values() {
    if scopes.contains(command_parent(command.name)) &&
      (!procedures_only || command.origin().body is Script(_)) &&
      glob_match(tail, namespace_tail(command.name), false) {
      let value = if qualified {
        command.name
      } else {
        namespace_tail(command.name)
      }
      if !values.contains(value) {
        values.push(value)
      }
    }
  }
  values.sort()
  values
}

///|
fn select_keyword(
  value : String,
  choices : Array[String],
) -> String raise TclError {
  if choices.contains(value) {
    return value
  }
  let matches = choices.filter(choice => choice.has_prefix(value))
  if matches.length() != 1 {
    raise Invalid("unknown or ambiguous subcommand or option")
  }
  matches[0]
}
