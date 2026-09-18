///|
struct Ensemble {
  namespace_name : String
  mut mapping : Array[(String, Array[TclValue])]
  mut parameters : Array[String]
  mut prefixes : Bool
  mut subcommands : Array[String]
  mut unknown : Array[TclValue]
  mut option_text : Map[String, TclValue]
} derive(Debug)

///|
fn Ensemble::option(
  self : Ensemble,
  option : String,
) -> TclValue raise TclError {
  match
    select_keyword(option, [
      "-namespace", "-map", "-parameters", "-prefixes", "-subcommands", "-unknown",
    ]) {
    "-namespace" => text_value(self.namespace_name)
    "-prefixes" => text_value(boolean_text(self.prefixes))
    key => self.option_text.get(key).unwrap_or(text_value(""))
  }
}

///|
fn Interpreter::configure_ensemble(
  self : Interpreter,
  ensemble : Ensemble,
  options : Array[TclValue],
) -> Unit raise TclError {
  if options.length() % 2 != 0 {
    raise Invalid("ensemble option value required")
  }
  // Tcl validates all options before changing an existing ensemble.
  let candidate = {
    ..ensemble,
    option_text: Map::from_iter(ensemble.option_text.iter()),
  }
  for i = 0; i < options.length(); i = i + 2 {
    let object = options[i + 1]
    let value = object.text
    let key = select_keyword(options[i].text, [
      "-namespace", "-map", "-parameters", "-prefixes", "-subcommands", "-unknown",
    ])
    candidate.option_text[key] = object
    match key {
      "-map" => {
        let parts = object.as_list()
        if parts.length() % 2 != 0 {
          raise Invalid("ensemble map must be dictionary")
        }
        let mapping : Array[(String, Array[TclValue])] = []
        let mut changed = false
        for j = 0; j < parts.length(); j = j + 2 {
          let words = parts[j + 1].as_list()
          if words.is_empty() {
            raise Invalid("ensemble command prefix must not be empty")
          }
          if !words[0].text.has_prefix("::") {
            changed = true
            words[0] = text_value(
              command_name(self.frame.namespace_name, words[0].text),
            )
          }
          let mut previous = -1
          for k in 0..<mapping.length() {
            if mapping[k].0 == parts[j].text {
              previous = k
            }
          }
          if previous < 0 {
            mapping.push((parts[j].text, words))
          } else {
            mapping[previous] = (parts[j].text, words)
          }
        }
        candidate.mapping = mapping
        if changed {
          let values = []
          for (key, words) in mapping {
            values.push(text_value(key))
            values.push(list_value(words))
          }
          candidate.option_text["-map"] = list_value(values)
        }
      }
      "-parameters" => candidate.parameters = parse_list(value)
      "-prefixes" => candidate.prefixes = boolean(value)
      "-subcommands" => candidate.subcommands = parse_list(value)
      "-unknown" => candidate.unknown = object.as_list()
      _ => raise Invalid("unknown or read-only ensemble option")
    }
  }
  ensemble.option_text = candidate.option_text
  ensemble.mapping = candidate.mapping
  ensemble.parameters = candidate.parameters
  ensemble.prefixes = candidate.prefixes
  ensemble.subcommands = candidate.subcommands
  ensemble.unknown = candidate.unknown
}

///|
fn Interpreter::ensemble_command(
  self : Interpreter,
  input : Array[TclValue],
) -> TclValue raise TclError {
  let args = input.map(v => v.text)
  let n = args.length()
  if n < 3 {
    raise Invalid("namespace ensemble arity")
  }
  let text = match select_keyword(args[2], ["create", "exists", "configure"]) {
    "create" => {
      if n % 2 != 1 {
        raise Invalid("ensemble option value required")
      }
      let mut name = self.frame.namespace_name
      let options = []
      for i = 3; i < n; i = i + 2 {
        let option = select_keyword(args[i], [
          "-command", "-map", "-parameters", "-prefixes", "-subcommands", "-unknown",
        ])
        if option == "-command" {
          name = command_name(self.frame.namespace_name, args[i + 1])
        } else {
          options.push(text_value(option))
          options.push(input[i + 1])
        }
      }
      let ensemble = Ensemble::{
        namespace_name: self.frame.namespace_name,
        mapping: [],
        parameters: [],
        prefixes: true,
        subcommands: [],
        unknown: [],
        option_text: Map([]),
      }
      self.configure_ensemble(ensemble, options)
      let parts = command_parent(name)
        .split("::")
        .filter(s => !s.is_empty())
        .to_array()
      let mut prefix = "::"
      for part in parts {
        prefix = qualified_name(prefix, part.to_owned())
        self.state.namespaces[prefix] = true
      }
      self.define_command(name, EnsembleCommand(ensemble))
      name
    }
    "exists" => {
      if n != 4 {
        raise Invalid("namespace ensemble exists arity")
      }
      boolean_text(
        match self.find_command(args[3]) {
          Some(command) => command.origin().body is EnsembleCommand(_)
          None => false
        },
      )
    }
    "configure" => {
      if n < 4 {
        raise Invalid("namespace ensemble configure arity")
      }
      let ensemble = match self.find_command(args[3]) {
        Some(command) =>
          match command.origin().body {
            EnsembleCommand(ensemble) => ensemble
            _ => raise Invalid("command is not an ensemble")
          }
        None => raise Invalid("unknown ensemble")
      }
      if n == 4 {
        let values = []
        for
          option in [
            "-map", "-namespace", "-parameters", "-prefixes", "-subcommands", "-unknown",
          ] {
          values.push(text_value(option))
          values.push(ensemble.option(option))
        }
        return list_value(values)
      } else if n == 5 {
        return ensemble.option(args[4])
      } else {
        self.configure_ensemble(ensemble, input[4:].to_owned())
        ""
      }
    }
    _ => raise Invalid("unsupported ensemble subcommand")
  }
  text_value(text)
}

///|
fn Interpreter::ensemble_prefix(
  self : Interpreter,
  ensemble : Ensemble,
  name : String,
) -> Array[TclValue]? raise TclError {
  let candidates = if !ensemble.subcommands.is_empty() {
    ensemble.subcommands
  } else if !ensemble.mapping.is_empty() {
    ensemble.mapping.map(pair => pair.0)
  } else {
    self
    .exported_commands(ensemble.namespace_name)
    .map(c => namespace_tail(c.name))
  }
  let mut selected : String? = None
  if candidates.contains(name) {
    selected = Some(name)
  } else if ensemble.prefixes {
    for candidate in candidates {
      if candidate.has_prefix(name) {
        match selected {
          Some(old) => if old != candidate { return None }
          None => selected = Some(candidate)
        }
      }
    }
  }
  match selected {
    None => None
    Some(key) => {
      for (mapped, words) in ensemble.mapping {
        if mapped == key {
          return Some(words)
        }
      }
      Some([text_value(command_name(ensemble.namespace_name, key))])
    }
  }
}

///|
fn Interpreter::invoke_ensemble(
  self : Interpreter,
  command : Command,
  ensemble : Ensemble,
  input : Array[TclValue],
  depth : Int,
  discard_result? : Bool = false,
) -> TclValue raise TclError {
  let mut index = 1 + ensemble.parameters.length()
  if input.length() <= index {
    raise Invalid("ensemble subcommand required")
  }
  let mut prefix = self.ensemble_prefix(ensemble, input[index].text)
  if prefix is None && !ensemble.unknown.is_empty() {
    let value = self.command_value(
      ensemble.unknown + [text_value(command.name)] + input[1:].to_owned(),
      depth + 1,
    ) catch {
      Invalid(message) => raise Invalid(message)
      Signal(result) if result.actual_code() == 1 => raise Signal(result)
      _ => raise Invalid("invalid completion from ensemble unknown handler")
    }
    let still_live = match self.state.commands.get(command.name) {
      Some(current) =>
        physical_equal(current, command) &&
        (match current.body {
          EnsembleCommand(active) => physical_equal(active, ensemble)
          _ => false
        })
      None => false
    }
    if !still_live {
      raise Invalid("unknown handler deleted its ensemble")
    }
    index = 1 + ensemble.parameters.length()
    let words = value.as_list()
    if !words.is_empty() {
      // A supplied rewrite bypasses reparsing. Tcl retains the original
      // invocation word count even when this callback changed parameters.
      // Clamp the removed subcommand position to the available invocation.
      if index >= input.length() {
        index = input.length() - 1
      }
      prefix = Some(words)
    } else {
      if input.length() <= index {
        raise Invalid("ensemble subcommand required")
      }
      prefix = self.ensemble_prefix(ensemble, input[index].text)
    }
  }
  let words = match prefix {
    Some(words) => words
    None => raise Invalid("unknown or ambiguous ensemble subcommand")
  }
  self.command_value(
    words + input[1:index].to_owned() + input[index + 1:].to_owned(),
    depth + 1,
    discard_result~,
  )
}
