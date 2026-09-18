///|
enum VariableValue {
  Scalar(TclValue)
  Sequence(ListObject)
  Mapping(DictObject)
  Elements(ArrayObject)
} derive(Debug)

///|
struct Cell {
  mut value : VariableValue?
  mut declared : Bool
  frame_local : Bool
} derive(Debug)

///|
struct Binding {
  cell : Cell
  index : String?
  linked : Bool
  array : ArrayObject?
} derive(Debug)

///|
struct Frame {
  vars : Map[String, Binding]
  namespace_name : String
  procedure : Bool
  parent : Frame?
} derive(Debug)

///|
struct Procedure {
  parameters : Array[(String, TclValue?)]
  body : String
  namespace_name : String
} derive(Debug)

///|
struct State {
  globals : Map[String, Cell]
  aliases : Map[String, Binding]
  commands : Map[String, Command]
  exports : Map[String, Array[String]]
  namespace_paths : Map[String, Array[String]]
  unknown_handlers : Map[String, TclValue]
  namespaces : Map[String, Bool]
  return_options : Ref[Array[(String, TclValue)]]
  error_stack : Ref[String]
  cache : ParseCache
} derive(Debug)

///|
fn qualified_name(prefix : String, name : String) -> String {
  if !name.is_empty() && !name.contains("::") {
    return if prefix == "::" { "::" + name } else { prefix + "::" + name }
  }
  if name.has_prefix("::") && !name.contains(":::") && !name.has_suffix("::") {
    return name
  }
  let value = if name.has_prefix("::") { name } else { prefix + "::" + name }
  let chars = value.to_array()
  let out = StringBuilder()
  let mut i = 0
  while i < chars.length() {
    if chars[i] == ':' && i + 1 < chars.length() && chars[i + 1] == ':' {
      out.write_string("::")
      while i < chars.length() && chars[i] == ':' {
        i += 1
      }
    } else {
      out.write_char(chars[i])
      i += 1
    }
  }
  let normalized = out.to_string()
  "::" + normalized.split("::").filter(s => !s.is_empty()).to_array().join("::")
}

///|
fn namespace_parent(name : String) -> String {
  if name.has_prefix("::") && !name.contains(":::") && !name.has_suffix("::") {
    let index = name.rev_find("::").unwrap_or(0)
    return if index == 0 { "::" } else { name[:index].to_owned() }
  }
  let parts = name.split("::").filter(s => !s.is_empty()).to_array()
  if parts.length() < 2 {
    "::"
  } else {
    "::" + parts[:parts.length() - 1].to_owned().join("::")
  }
}

///|
fn namespace_tail(name : String) -> String {
  name.split("::").to_array().last().unwrap_or("").to_owned()
}

///|
fn variable_parts(name : String) -> (String, String?) {
  if name.has_suffix(")") && name.find("(") is Some(at) {
    (unit_slice(name, 0, at), Some(unit_slice(name, at + 1, name.length() - 1)))
  } else {
    (name, None)
  }
}

///|
fn Interpreter::binding(
  self : Interpreter,
  name : String,
  create : Bool,
) -> Binding? raise TclError {
  let (base, index) = variable_parts(name)
  if !base.contains("::") &&
    (self.frame.procedure || self.frame.vars.contains(base)) {
    let binding = match self.frame.vars.get(base) {
      Some(binding) => binding
      None => {
        if !create {
          return None
        }
        let binding = Binding::{
          cell: {
            value: None,
            declared: false,
            frame_local: self.frame.procedure,
          },
          index: None,
          linked: false,
          array: None,
        }
        self.frame.vars[base] = binding
        binding
      }
    }
    if index is Some(_) && binding.index is Some(_) {
      raise Invalid("variable is not an array")
    }
    return Some({
      ..binding,
      index: match index {
        Some(_) => index
        None => binding.index
      },
    })
  }
  let mut key = qualified_name(self.frame.namespace_name, base)
  if self.frame.namespace_name != "::" &&
    !base.contains("::") &&
    !self.global_defined(key) &&
    self.global_defined("::" + base) {
    key = "::" + base
  }
  if self.state.aliases.get(key) is Some(binding) {
    if index is Some(_) && binding.index is Some(_) {
      raise Invalid("variable is not an array")
    }
    return Some({
      ..binding,
      index: match index {
        Some(_) => index
        None => binding.index
      },
    })
  }
  let cell = match self.state.globals.get(key) {
    Some(cell) => cell
    None => {
      if !create {
        return None
      }
      if !self.state.namespaces.contains(namespace_parent(key)) {
        raise Invalid("parent namespace does not exist")
      }
      let cell = Cell::{ value: None, declared: false, frame_local: false, }
      self.state.globals[key] = cell
      cell
    }
  }
  Some({ cell, index, linked: false, array: None, })
}

///|
fn Interpreter::global_defined(self : Interpreter, name : String) -> Bool {
  if self.state.aliases.contains(name) {
    return true
  }
  match self.state.globals.get(name) {
    Some(cell) => cell.value is Some(_) || cell.declared
    None => false
  }
}

///|
fn Interpreter::link_variable(
  self : Interpreter,
  name : String,
  binding : Binding,
) -> Unit raise TclError {
  if !self.frame.procedure && binding.cell.frame_local {
    raise Invalid(
      "can't create namespace variable that refers to procedure variable",
    )
  }
  let previous = self.binding(name, false)
  if previous is Some(old) &&
    !old.linked &&
    old.cell.value is Some(_) &&
    (!physical_equal(old.cell, binding.cell) || old.index != binding.index) {
    raise Invalid("variable already exists")
  }
  let array = match binding.index {
    None => None
    Some(index) => {
      let array = match binding.array {
        Some(v) => v
        None =>
          match binding.cell.value {
            Some(Elements(v)) => v
            None => {
              let v = ArrayObject::new()
              binding.cell.value = Some(Elements(v))
              v
            }
            _ => raise Invalid("variable is not an array")
          }
      }
      if array.alive {
        array.ensure_key(index)
      }
      array.pins[index] = array.pins.get(index).unwrap_or(0) + 1
      Some(array)
    }
  }
  if previous is Some(old) {
    old.release_link()
  }
  let linked = { ..binding, linked: true, array, }
  if self.frame.procedure {
    self.frame.vars[name] = linked
  } else {
    self.state.aliases[qualified_name(self.frame.namespace_name, name)] = linked
  }
}

///|
fn Binding::release_link(self : Binding) -> Unit {
  if self.linked {
    if self.array is Some(array) && self.index is Some(index) {
      array.unpin(index)
    }
  }
}

///|
fn Cell::unset(self : Cell) -> Unit {
  if self.value is Some(Elements(array)) {
    array.destroy()
  }
  self.value = None
  self.declared = false
}

///|
fn Frame::release_variables(self : Frame) -> Unit {
  for binding in self.vars.values() {
    if binding.linked {
      binding.release_link()
    } else {
      binding.cell.unset()
    }
  }
}

///|
fn Binding::read_value(self : Binding) -> TclValue? raise TclError {
  if self.array is Some(array) && self.index is Some(index) {
    return array.get(index)
  }
  match (self.cell.value, self.index) {
    (Some(Scalar(value)), None) => Some(value)
    (Some(Sequence(value)), None) => {
      let result = value.snapshot()
      self.cell.value = Some(Scalar(result))
      Some(result)
    }
    (Some(Mapping(value)), None) => {
      let result = value.snapshot()
      self.cell.value = Some(Scalar(result))
      Some(result)
    }
    (Some(Elements(values)), Some(index)) => values.get(index)
    (Some(Elements(_)), None) => raise Invalid("variable is array")
    (Some(_), Some(_)) => raise Invalid("variable is not an array")
    _ => None
  }
}

///|
fn Interpreter::get_value(
  self : Interpreter,
  name : String,
) -> TclValue? raise TclError {
  match self.binding(name, false) {
    Some(binding) => binding.read_value()
    None => None
  }
}

///|
fn Interpreter::read_value(
  self : Interpreter,
  name : String,
) -> TclValue raise TclError {
  let binding = self.binding(name, false)
  if binding is Some(b) && b.array is Some(array) && b.index is Some(index) {
    if array.get(index) is Some(value) {
      return value
    }
    switch_error(
      "can't read \"" + name + "\": no such variable",
      "TCL READ VARNAME",
    )
  }
  let (reason, code) = match binding {
    None => ("no such variable", "")
    Some(binding) =>
      match (binding.cell.value, binding.index) {
        (Some(Elements(_)), None) => ("variable is array", "TCL READ VARNAME")
        (Some(Elements(values)), Some(index)) =>
          match values.get(index) {
            Some(value) => return value
            None =>
              (
                if binding.linked && variable_parts(name).1 is None {
                  "no such variable"
                } else {
                  "no such element in array"
                },
                "TCL READ VARNAME",
              )
          }
        (Some(_), Some(_)) =>
          (
            "variable isn't array",
            if binding.linked {
              "TCL LOOKUP VARNAME"
            } else {
              ""
            },
          )
        _ =>
          match binding.read_value() {
            Some(value) => return value
            None =>
              (
                "no such variable",
                if binding.linked && variable_parts(name).1 is Some(_) {
                  "TCL LOOKUP VARNAME"
                } else if binding.linked ||
                  (binding.cell.declared && binding.index is None) {
                  "TCL READ VARNAME"
                } else {
                  ""
                },
              )
          }
      }
  }
  let code = if code.is_empty() {
    let (base, _) = variable_parts(name)
    format_list(["TCL", "LOOKUP", "VARNAME", base])
  } else {
    code
  }
  raise Signal(
    completion_error("can't read \"" + name + "\": " + reason, errorcode=code),
  )
}

///|
fn Interpreter::set_value(
  self : Interpreter,
  name : String,
  value : TclValue,
) -> Unit raise TclError {
  if value.text.length() > 1000000 {
    raise Invalid("variable size limit")
  }
  let binding = self.binding(name, true).unwrap()
  if binding.array is Some(array) && binding.index is Some(index) {
    if !array.alive {
      switch_error(
        "can't set \"" + name + "\": upvar refers to element in deleted array",
        "TCL WRITE VARNAME",
      )
    }
    array.put(index, value)
    return
  }
  match binding.index {
    None => {
      if binding.cell.value is Some(Elements(_)) {
        raise Invalid("variable is array")
      }
      binding.cell.value = Some(Scalar(value))
    }
    Some(index) => {
      let values = match binding.cell.value {
        Some(Scalar(_)) | Some(Sequence(_)) | Some(Mapping(_)) =>
          raise Invalid("variable is not an array")
        Some(Elements(values)) => values
        None => {
          let values = ArrayObject::new()
          binding.cell.value = Some(Elements(values))
          values
        }
      }
      if values.length() >= 10000 && !values.contains(index) {
        raise Invalid("array size limit")
      }
      values.put(index, value)
    }
  }
}

///|
fn Interpreter::unset_var(
  self : Interpreter,
  name : String,
  quiet : Bool,
) -> Unit raise TclError {
  let binding = match self.binding(name, false) {
    Some(binding) => binding
    None => {
      if quiet {
        return
      }
      raise Invalid("undefined variable " + name)
    }
  }
  if binding.array is Some(array) && binding.index is Some(index) {
    if !array.contains(index) && !quiet {
      raise Invalid("undefined variable " + name)
    }
    array.remove(index, invalidate=false)
    return
  }
  match binding.index {
    None => {
      if binding.cell.value is None && !quiet {
        raise Invalid("undefined variable " + name)
      }
      binding.cell.unset()
    }
    Some(index) =>
      match binding.cell.value {
        Some(Elements(values)) => {
          if !values.contains(index) && !quiet {
            raise Invalid("undefined array element")
          }
          values.remove(index)
        }
        _ => if !quiet { raise Invalid("variable is not an array") }
      }
  }
}

///|
fn Interpreter::with_frame(self : Interpreter, frame : Frame) -> Interpreter {
  { ..self, frame, }
}

///|
fn Interpreter::level_frame(
  self : Interpreter,
  level : String,
) -> Frame raise TclError {
  let frames = [self.frame]
  let mut cursor = self.frame
  while cursor.parent is Some(parent) {
    frames.push(parent)
    cursor = parent
  }
  let index = if level.has_prefix("#") {
    frames.length() - 1 - integer(level[1:].to_owned())
  } else {
    integer(level)
  }
  if index < 0 || index >= frames.length() {
    raise Invalid("bad level")
  }
  frames[index]
}

///|
fn Interpreter::namespace_command(
  self : Interpreter,
  input : Array[TclValue],
  depth : Int,
) -> TclValue raise TclError {
  let args = input.map(v => v.text)
  if args.length() < 2 {
    raise Invalid("namespace arity")
  }
  let args = args.copy()
  args[1] = select_keyword(args[1], [
    "children", "code", "current", "delete", "ensemble", "eval", "exists", "export",
    "forget", "import", "inscope", "origin", "parent", "path", "qualifiers", "tail",
    "unknown", "upvar", "which",
  ])
  let n = args.length()
  let text = match args[1] {
    "export" => {
      let clear = n > 2 && args[2] == "-clear"
      let patterns = if clear {
        []
      } else {
        self.state.exports.get(self.frame.namespace_name).unwrap_or([])
      }
      self.state.exports[self.frame.namespace_name] = patterns
      let start = if clear { 3 } else { 2 }
      if n == 2 {
        return text_value(format_list(patterns))
      }
      for pattern in args[start:] {
        if pattern.contains("::") {
          raise Invalid("export pattern must not contain namespace")
        }
        if !patterns.contains(pattern) {
          patterns.push(pattern)
        }
      }
      ""
    }
    "import" => self.namespace_import(args, depth)
    "forget" => self.namespace_forget(args)
    "origin" => {
      if n != 3 {
        raise Invalid("namespace origin arity")
      }
      match self.find_command(args[2]) {
        Some(command) => command.origin().name
        None => raise Invalid("unknown command")
      }
    }
    "path" => {
      if n > 3 {
        raise Invalid("namespace path arity")
      }
      if n == 2 {
        return text_value(
          format_list(
            self.state.namespace_paths
            .get(self.frame.namespace_name)
            .unwrap_or([]),
          ),
        )
      }
      let path = []
      for name in parse_list(args[2]) {
        let space = self.namespace_target(name)
        path.push(space)
      }
      self.state.namespace_paths[self.frame.namespace_name] = path
      ""
    }
    "unknown" => {
      if n > 3 {
        raise Invalid("namespace unknown arity")
      }
      if n == 3 {
        self.state.unknown_handlers[self.frame.namespace_name] = input[2]
      }
      let handler = self.state.unknown_handlers
        .get(self.frame.namespace_name)
        .unwrap_or(text_value(""))
      if handler.text.is_empty() && self.frame.namespace_name == "::" {
        "::unknown"
      } else {
        return handler
      }
    }
    "upvar" => {
      if n < 3 || n % 2 != 1 {
        raise Invalid("namespace upvar arity")
      }
      let space = self.namespace_target(args[2])
      for i = 3; i < n; i = i + 2 {
        let binding = self.binding(command_name(space, args[i]), true).unwrap()
        self.link_variable(args[i + 1], binding)
      }
      ""
    }
    "ensemble" => return self.ensemble_command(input)
    "current" => {
      if n != 2 {
        raise Invalid("namespace current arity")
      }
      self.frame.namespace_name
    }
    "eval" | "inscope" => {
      if n < 4 {
        raise Invalid("namespace eval arity")
      }
      if args[2].is_empty() && self.frame.namespace_name != "::" {
        raise Invalid("empty namespace name")
      }
      let target = qualified_name(self.frame.namespace_name, args[2])
      if args[1] == "inscope" && !self.state.namespaces.contains(target) {
        raise Invalid("unknown namespace")
      }
      let parts = target.split("::").filter(s => !s.is_empty()).to_array()
      let mut prefix = "::"
      for part in parts {
        prefix = qualified_name(prefix, part.to_owned())
        self.state.namespaces[prefix] = true
      }
      let frame = Frame::{
        vars: Map([]),
        namespace_name: target,
        procedure: false,
        parent: Some(self.frame),
      }
      return self
        .with_frame(frame)
        .execute_value_script(
          if args[1] == "inscope" && n > 4 {
            concat_values([input[3], list_value(input[4:].to_owned())])
          } else {
            script_arguments(input[3:].to_owned())
          },
          depth + 1,
        )
    }
    "exists" => {
      if n != 3 {
        raise Invalid("namespace exists arity")
      }
      if args[2].is_empty() && self.frame.namespace_name != "::" {
        return text_value("0")
      }
      boolean_text(
        self.state.namespaces.contains(
          qualified_name(self.frame.namespace_name, args[2]),
        ),
      )
    }
    "parent" => {
      if n > 3 {
        raise Invalid("namespace parent arity")
      }
      let target = if n == 3 {
        self.namespace_target(args[2])
      } else {
        self.frame.namespace_name
      }
      if target == "::" {
        ""
      } else {
        namespace_parent(target)
      }
    }
    "tail" => {
      if n != 3 {
        raise Invalid("namespace tail arity")
      }
      namespace_tail(args[2])
    }
    "qualifiers" => {
      if n != 3 {
        raise Invalid("namespace qualifiers arity")
      }
      let parts = args[2].split("::").to_array()
      if parts.length() < 2 {
        ""
      } else {
        parts[:parts.length() - 1].to_owned().join("::")
      }
    }
    "children" => {
      if n > 4 {
        raise Invalid("namespace children arity")
      }
      let target = if n >= 3 {
        self.namespace_target(args[2])
      } else {
        self.frame.namespace_name
      }
      let names = self.state.namespaces
        .keys()
        .filter(name => name != target && namespace_parent(name) == target)
        .to_array()
      names.sort()
      format_list(
        if n == 4 {
          names.filter(name => {
            glob_match(
              if args[3].has_prefix("::") {
                args[3]
              } else {
                qualified_name(target, args[3])
              },
              name,
              false,
            )
          })
        } else {
          names
        },
      )
    }
    "which" => {
      let variable = n == 4 && args[2] == "-variable"
      let name = if n == 3 {
        args[2]
      } else if n == 4 && (variable || args[2] == "-command") {
        args[3]
      } else {
        raise Invalid("namespace which arity")
      }
      if variable {
        let mut key = qualified_name(self.frame.namespace_name, name)
        if !name.contains("::") &&
          !self.global_defined(key) &&
          self.global_defined("::" + name) {
          key = "::" + name
        }
        if self.global_defined(key) {
          key
        } else {
          ""
        }
      } else {
        self.find_command(name).map(c => c.name).unwrap_or("")
      }
    }
    "delete" => {
      for name in args[2:] {
        let target = self.namespace_target(name)
        if target == "::" {
          raise Invalid("root namespace deletion not supported")
        }
        if !self.state.namespaces.contains(target) {
          raise Invalid("unknown namespace")
        }
        for key in self.state.namespaces.keys().to_array() {
          if key == target || key.has_prefix(target + "::") {
            self.state.namespaces.remove(key)
          }
        }
        for key in self.state.globals.keys().to_array() {
          if key.has_prefix(target + "::") {
            if self.state.globals.get(key) is Some(cell) {
              cell.unset()
            }
            self.state.globals.remove(key)
          }
        }
        for command in self.state.commands.values().to_array() {
          let linked = match command.body {
            EnsembleCommand(ensemble) =>
              ensemble.namespace_name == target ||
              ensemble.namespace_name.has_prefix(target + "::")
            _ => false
          }
          if linked || command.name.has_prefix(target + "::") {
            self.delete_command(command)
          }
        }
        for key in self.state.exports.keys().to_array() {
          if key == target || key.has_prefix(target + "::") {
            self.state.exports.remove(key)
          }
        }
        for key in self.state.unknown_handlers.keys().to_array() {
          if key == target || key.has_prefix(target + "::") {
            self.state.unknown_handlers.remove(key)
          }
        }
        for key in self.state.namespace_paths.keys().to_array() {
          if key == target || key.has_prefix(target + "::") {
            self.state.namespace_paths.remove(key)
          } else {
            self.state.namespace_paths[key] = self.state.namespace_paths[key].filter(s => {
                s != target && !s.has_prefix(target + "::")
              },
            )
          }
        }
        for key in self.state.aliases.keys().to_array() {
          if key.has_prefix(target + "::") {
            self.state.aliases.get(key).unwrap().release_link()
            self.state.aliases.remove(key)
          }
        }
      }
      ""
    }
    "code" => {
      if n != 3 {
        raise Invalid("namespace code arity")
      }
      let words = parse_list(args[2]) catch { _ => [] }
      if words.length() == 4 &&
        words[0] == "::namespace" &&
        words[1] == "inscope" {
        args[2]
      } else {
        format_list([
          "::namespace",
          "inscope",
          self.frame.namespace_name,
          args[2],
        ])
      }
    }
    _ => raise Invalid("unsupported namespace subcommand")
  }
  text_value(text)
}

///|
fn Interpreter::scope_command(
  self : Interpreter,
  input : Array[TclValue],
  depth : Int,
) -> TclValue raise TclError {
  let args = input.map(v => v.text)
  let n = args.length()
  let text = match args[0] {
    "global" | "variable" => {
      let mut i = 1
      while i < n {
        let name = args[i]
        i += 1
        let target = qualified_name(
          if args[0] == "global" {
            "::"
          } else {
            self.frame.namespace_name
          },
          name,
        )
        let binding = self
          .with_frame({ ..self.frame, procedure: false, })
          .binding(target, true)
          .unwrap()
        if args[0] == "variable" {
          binding.cell.declared = true
        }
        if self.frame.procedure {
          self.link_variable(namespace_tail(name), binding)
        }
        if args[0] == "variable" && i < n {
          self
          .with_frame({ ..self.frame, procedure: false, })
          .set_value(target, input[i])
          i += 1
        }
      }
      ""
    }
    "upvar" => {
      let explicit = n >= 2 &&
        (
          args[1].has_prefix("#") ||
          (try {
            ignore(integer(args[1]))
            true
          } catch {
            _ => false
          })
        )
      let start = if explicit { 2 } else { 1 }
      if n <= start || (n - start) % 2 != 0 {
        raise Invalid("upvar arity")
      }
      let target = self.with_frame(
        self.level_frame(if explicit { args[1] } else { "1" }),
      )
      let mut i = start
      while i < n {
        if args[i + 1].contains("::") || args[i + 1].contains("(") {
          raise Invalid("unsupported upvar local name")
        }
        let binding = target.binding(args[i], true).unwrap()
        self.link_variable(args[i + 1], binding)
        i += 2
      }
      ""
    }
    "uplevel" => {
      if n < 2 {
        raise Invalid("uplevel arity")
      }
      let explicit = args[1].has_prefix("#") ||
        (try {
          ignore(integer(args[1]))
          true
        } catch {
          _ => false
        })
      let start = if explicit { 2 } else { 1 }
      if n <= start {
        raise Invalid("uplevel script required")
      }
      return self
        .with_frame(self.level_frame(if explicit { args[1] } else { "1" }))
        .execute_value_script(
          script_arguments(input[start:].to_owned()),
          depth + 1,
        )
    }
    _ => raise Invalid("unsupported scope command")
  }
  text_value(text)
}

///|
fn Interpreter::namespace_target(
  self : Interpreter,
  name : String,
) -> String raise TclError {
  if name.is_empty() && self.frame.namespace_name != "::" {
    raise Invalid("empty namespace name")
  }
  let target = qualified_name(self.frame.namespace_name, name)
  if !self.state.namespaces.contains(target) {
    raise Invalid("unknown namespace")
  }
  target
}

///|
fn Binding::read(self : Binding) -> String? raise TclError {
  self.read_value().map(v => v.text)
}

///|
fn Interpreter::get_var(
  self : Interpreter,
  name : String,
) -> String? raise TclError {
  self.get_value(name).map(v => v.text)
}

///|
fn Interpreter::set_var(
  self : Interpreter,
  name : String,
  value : String,
) -> Unit raise TclError {
  self.set_value(name, text_value(value))
}
