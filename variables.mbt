///|
enum VariableValue {
  Scalar(String)
  Sequence(ListObject)
  Mapping(DictObject)
  Elements(Map[String, String])
} derive(Debug)

///|
struct Cell {
  mut value : VariableValue?
  mut declared : Bool
} derive(Debug)

///|
struct Binding {
  cell : Cell
  index : String?
  linked : Bool
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
  parameters : Array[(String, String?)]
  body : String
  namespace_name : String
} derive(Debug)

///|
struct State {
  globals : Map[String, Cell]
  aliases : Map[String, Binding]
  procedures : Map[String, Procedure]
  namespaces : Map[String, Bool]
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
    (name[:at].to_owned(), Some(name[at + 1:name.length() - 1].to_owned()))
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
          cell: { value: None, declared: false, },
          index: None,
          linked: false,
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
      let cell = Cell::{ value: None, declared: false, }
      self.state.globals[key] = cell
      cell
    }
  }
  Some({ cell, index, linked: false, })
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
  let previous = self.binding(name, false)
  if previous is Some(old) &&
    old.cell.value is Some(_) &&
    (!physical_equal(old.cell, binding.cell) || old.index != binding.index) {
    raise Invalid("variable already exists")
  }
  let linked = { ..binding, linked: true, }
  if self.frame.procedure {
    self.frame.vars[name] = linked
  } else {
    self.state.aliases[qualified_name(self.frame.namespace_name, name)] = linked
  }
}

///|
fn Binding::read(self : Binding) -> String? raise TclError {
  match (self.cell.value, self.index) {
    (Some(Scalar(value)), None) => Some(value)
    (Some(Sequence(value)), None) => Some(value.text())
    (Some(Mapping(value)), None) => Some(value.text())
    (Some(Elements(values)), Some(index)) => values.get(index)
    (Some(Elements(_)), None) => raise Invalid("variable is array")
    (Some(_), Some(_)) => raise Invalid("variable is not an array")
    _ => None
  }
}

///|
fn Interpreter::get_var(
  self : Interpreter,
  name : String,
) -> String? raise TclError {
  match self.binding(name, false) {
    Some(binding) => binding.read()
    None => None
  }
}

///|
fn Interpreter::read_var(
  self : Interpreter,
  name : String,
) -> String raise TclError {
  match self.get_var(name) {
    Some(value) => value
    None => raise Invalid("undefined variable " + name)
  }
}

///|
fn Interpreter::set_var(
  self : Interpreter,
  name : String,
  value : String,
) -> Unit raise TclError {
  if value.length() > 1000000 {
    raise Invalid("variable size limit")
  }
  let binding = self.binding(name, true).unwrap()
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
          let values = Map([])
          binding.cell.value = Some(Elements(values))
          values
        }
      }
      if values.length() >= 10000 && !values.contains(index) {
        raise Invalid("array size limit")
      }
      values[index] = value
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
  match binding.index {
    None => {
      if binding.cell.value is None && !quiet {
        raise Invalid("undefined variable " + name)
      }
      binding.cell.value = None
      binding.cell.declared = false
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
fn Interpreter::find_procedure(self : Interpreter, name : String) -> String? {
  let key = qualified_name(self.frame.namespace_name, name)
  if self.state.procedures.contains(key) {
    Some(key)
  } else if !name.has_prefix("::") &&
    self.state.procedures.contains(qualified_name("::", name)) {
    Some(qualified_name("::", name))
  } else {
    None
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
  args : Array[String],
  depth : Int,
) -> String raise TclError {
  if args.length() < 2 {
    raise Invalid("namespace arity")
  }
  let n = args.length()
  match args[1] {
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
      self.with_frame(frame).execute(args[3:].to_owned().join(" "), depth + 1)
    }
    "exists" => {
      if n != 3 {
        raise Invalid("namespace exists arity")
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
        qualified_name(self.frame.namespace_name, args[2])
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
        qualified_name(self.frame.namespace_name, args[2])
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
        self
        .find_procedure(name)
        .unwrap_or(
          if builtin_name(name) {
            qualified_name("::", name)
          } else {
            ""
          },
        )
      }
    }
    "delete" => {
      for name in args[2:] {
        let target = qualified_name(self.frame.namespace_name, name)
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
              cell.value = None
            }
            self.state.globals.remove(key)
          }
        }
        for key in self.state.procedures.keys().to_array() {
          if key.has_prefix(target + "::") {
            self.state.procedures.remove(key)
          }
        }
        for key in self.state.aliases.keys().to_array() {
          if key.has_prefix(target + "::") {
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
      format_list(["::namespace", "inscope", self.frame.namespace_name, args[2]])
    }
    _ => raise Invalid("unsupported namespace subcommand")
  }
}

///|
fn Interpreter::scope_command(
  self : Interpreter,
  args : Array[String],
  depth : Int,
) -> String raise TclError {
  let n = args.length()
  match args[0] {
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
          .set_var(target, args[i])
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
      self
      .with_frame(self.level_frame(if explicit { args[1] } else { "1" }))
      .execute(args[start:].to_owned().join(" "), depth + 1)
    }
    _ => raise Invalid("unsupported scope command")
  }
}
