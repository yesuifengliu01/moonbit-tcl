///|
priv struct HostIO {
  mut invoke : ((String, Array[String]) -> Result[String, String])?
}

///|
impl Debug for HostIO with fn to_repr(_self) {
  Repr("HostIO")
}

///|
/// Install a synchronous host filesystem/channel adapter. The core never
/// accesses operating-system files unless the embedding application supplies it.
pub fn Interpreter::set_io(
  self : Interpreter,
  callback : (String, Array[String]) -> Result[String, String],
) -> Unit {
  self.state.host_io.invoke = Some(callback)
}

///|
fn Interpreter::host_call(
  self : Interpreter,
  name : String,
  args : Array[String],
) -> String raise TclError {
  match self.state.host_io.invoke {
    Some(invoke) =>
      match invoke(name, args) {
        Ok(value) => value
        Err(message) => raise Invalid(message)
      }
    None => raise Invalid("filesystem adapter is not configured")
  }
}

///|
fn Interpreter::io_command(
  self : Interpreter,
  values : Array[TclValue],
  depth : Int,
) -> TclValue raise TclError {
  let args = values.map(v => v.text)
  let name = args[0]
  if name == "source" {
    let filename = if args.length() == 2 {
      args[1]
    } else if args.length() == 4 && args[1] == "-encoding" {
      args[3]
    } else {
      raise Invalid("source ?-encoding name? fileName")
    }
    let source = self.host_call("source", args[1:].to_owned())
    let previous = self.state.script_name.val
    self.state.script_name.val = filename
    defer {
      self.state.script_name.val = previous
    }
    let result = self.capture(source, depth + 1)
    let result = if result.level > 0 {
      { ..result, level: result.level - 1, }
    } else {
      result
    }
    return self.propagate_value(result)
  }
  if name == "gets" {
    if args.length() != 2 && args.length() != 3 {
      raise Invalid("gets channelId ?varName?")
    }
    // Prefix 0 is a line, prefix 1 is EOF. This preserves an empty final line.
    let result = self.host_call("gets", [args[1]])
    if !result.has_prefix("0") && result != "1" {
      raise Invalid("invalid host line response")
    }
    let eof = result == "1"
    let line = if eof { "" } else { result[1:].to_owned() }
    if args.length() == 3 {
      self.set_var(args[2], line)
      return text_value(if eof { "-1" } else { line.length().to_string() })
    }
    return text_value(line)
  }
  text_value(self.host_call(name, args[1:].to_owned()))
}
