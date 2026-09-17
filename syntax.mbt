///|
enum Part {
  Text(String)
  Variable(String, Array[Part]?)
  Command(Array[Array[Word]])
} derive(Debug)

///|
struct Word {
  parts : Array[Part]
  expand : Bool
} derive(Debug)

///|
struct ScriptParser {
  chars : Array[Char]
  mut pos : Int
} derive(Debug)

///|
fn ScriptParser::peek(self : ScriptParser, offset? : Int = 0) -> Char {
  self.chars.get(self.pos + offset).unwrap_or('\u0000')
}

///|
fn namechar(c : Char) -> Bool {
  (c >= 'a' && c <= 'z') ||
  (c >= 'A' && c <= 'Z') ||
  (c >= '0' && c <= '9') ||
  c == '_' ||
  c == ':'
}

///|
fn ScriptParser::braces(self : ScriptParser) -> String raise TclError {
  self.pos += 1
  let mut level = 1
  let out = StringBuilder()
  while self.pos < self.chars.length() {
    let c = self.peek()
    self.pos += 1
    if c == '\\' && self.pos < self.chars.length() {
      if self.peek() == '\n' {
        let (text, next) = backslash(self.chars, self.pos - 1)
        out.write_string(text)
        self.pos = next
      } else {
        out.write_char(c)
        out.write_char(self.peek())
        self.pos += 1
      }
      continue
    }
    if c == '{' {
      level += 1
    }
    if c == '}' {
      level -= 1
      if level == 0 {
        return out.to_string()
      }
    }
    out.write_char(c)
  }
  raise Invalid("missing close-brace")
}

///|
fn ScriptParser::variable(
  self : ScriptParser,
  depth : Int,
) -> Part raise TclError {
  self.pos += 1
  if self.peek() == '{' {
    self.pos += 1
    let start = self.pos
    while self.pos < self.chars.length() && self.peek() != '}' {
      self.pos += 1
    }
    if self.pos == self.chars.length() {
      raise Invalid("missing variable close-brace")
    }
    let name = String::from_array(self.chars[start:self.pos])
    self.pos += 1
    return Variable(name, None)
  }
  let start = self.pos
  while namechar(self.peek()) {
    if self.peek() == ':' {
      if self.peek(offset=1) != ':' {
        break
      }
      while self.peek() == ':' {
        self.pos += 1
      }
    } else {
      self.pos += 1
    }
  }
  let name = String::from_array(self.chars[start:self.pos])
  if self.peek() == '(' {
    self.pos += 1
    return Variable(name, Some(self.parts(')', false, depth + 1)))
  }
  if name.is_empty() {
    Text("$")
  } else {
    Variable(name, None)
  }
}

///|
fn ScriptParser::parts(
  self : ScriptParser,
  stop : Char,
  raw : Bool,
  depth : Int,
  bracket? : Bool = false,
) -> Array[Part] raise TclError {
  if depth > 64 {
    raise Invalid("substitution depth")
  }
  let parts = []
  let mut text = StringBuilder()
  while self.pos < self.chars.length() {
    let c = self.peek()
    if stop != '\u0000' && c == stop {
      self.pos += 1
      parts.push(Text(text.to_string()))
      return parts
    }
    if raw && (list_space(c) || c == ';' || (bracket && c == ']')) {
      break
    }
    if raw && c == '\\' && self.peek(offset=1) == '\n' {
      break
    }
    if c == '$' || c == '[' {
      parts.push(Text(text.to_string()))
      text = StringBuilder()
      if c == '$' {
        parts.push(self.variable(depth))
      } else {
        self.pos += 1
        parts.push(Command(self.script(true, depth + 1)))
      }
    } else if c == '\\' {
      let (value, next) = backslash(self.chars, self.pos)
      text.write_string(value)
      self.pos = next
    } else {
      text.write_char(c)
      self.pos += 1
    }
  }
  if stop != '\u0000' {
    raise Invalid("missing closing substitution delimiter")
  }
  parts.push(Text(text.to_string()))
  parts
}

///|
fn ScriptParser::word(
  self : ScriptParser,
  depth : Int,
  bracket : Bool,
) -> Word raise TclError {
  let mut expand = false
  if self.peek() == '{' &&
    self.peek(offset=1) == '*' &&
    self.peek(offset=2) == '}' &&
    self.pos + 3 < self.chars.length() &&
    !list_space(self.peek(offset=3)) &&
    self.peek(offset=3) != ';' &&
    (!bracket || self.peek(offset=3) != ']') {
    expand = true
    self.pos += 3
  }
  let grouped = self.peek() == '{' || self.peek() == '"'
  let parts = if self.peek() == '{' {
    [Text(self.braces())]
  } else if self.peek() == '"' {
    self.pos += 1
    self.parts('"', false, depth)
  } else {
    self.parts('\u0000', true, depth, bracket~)
  }
  if grouped &&
    self.pos < self.chars.length() &&
    !list_space(self.peek()) &&
    self.peek() != ';' &&
    (!bracket || self.peek() != ']') {
    raise Invalid("extra characters after grouped word")
  }
  { parts, expand, }
}

///|
fn ScriptParser::script(
  self : ScriptParser,
  bracket : Bool,
  depth : Int,
  one? : Bool = false,
) -> Array[Array[Word]] raise TclError {
  if depth > 64 {
    raise Invalid("script nesting limit")
  }
  let commands = []
  let mut words = []
  while self.pos < self.chars.length() {
    let c = self.peek()
    if c == ']' && bracket {
      self.pos += 1
      if !words.is_empty() {
        commands.push(words)
      }
      return commands
    }
    if c == '\\' && self.peek(offset=1) == '\n' {
      let (_, next) = backslash(self.chars, self.pos)
      self.pos = next
      continue
    }
    if c == ';' || c == '\n' {
      self.pos += 1
      if !words.is_empty() {
        commands.push(words)
        words = []
      }
      if one && !commands.is_empty() {
        return commands
      }
    } else if list_space(c) {
      self.pos += 1
    } else if c == '#' && words.is_empty() {
      while self.pos < self.chars.length() && self.peek() != '\n' {
        if self.peek() == '\\' && self.peek(offset=1) == '\n' {
          let (_, next) = backslash(self.chars, self.pos)
          self.pos = next
        } else {
          self.pos += 1
        }
      }
    } else {
      words.push(self.word(depth, bracket))
      if words.length() > 4096 {
        raise Invalid("command argument limit")
      }
    }
    if commands.length() > 10000 {
      raise Invalid("script command limit")
    }
  }
  if bracket {
    raise Invalid("missing close-bracket")
  }
  if !words.is_empty() {
    commands.push(words)
  }
  commands
}

///|
fn Interpreter::expand_parts(
  self : Interpreter,
  parts : Array[Part],
  depth : Int,
) -> String raise TclError {
  if depth > 64 {
    raise Invalid("substitution depth")
  }
  let mut first = ""
  let mut out : StringBuilder? = None
  let mut length = 0
  for part in parts {
    self.tick()
    let value = match part {
      Text(text) => text
      Variable(name, index) => {
        let name = match index {
          Some(parts) => name + "(" + self.expand_parts(parts, depth + 1) + ")"
          None => name
        }
        self.read_var(name)
      }
      Command(commands) => self.execute_commands(commands, depth + 1)
    }
    let previous = length
    length += value.length()
    if length > 1000000 {
      raise Invalid("substitution result size limit")
    }
    if previous == 0 {
      first = value
    } else if !value.is_empty() {
      match out {
        Some(builder) => builder.write_string(value)
        None => {
          let builder = StringBuilder()
          builder.write_string(first)
          builder.write_string(value)
          out = Some(builder)
        }
      }
    }
  }
  match out {
    Some(builder) => builder.to_string()
    None => first
  }
}

///|
fn Interpreter::execute_commands(
  self : Interpreter,
  commands : Array[Array[Word]],
  depth : Int,
  discard_result? : Bool = false,
) -> String raise TclError {
  if depth > 64 {
    raise Invalid("execution nesting limit")
  }
  let mut result = ""
  for words in commands {
    let args = []
    for word in words {
      let value = self.expand_parts(word.parts, depth + 1)
      if word.expand {
        for item in parse_list(value) {
          args.push(item)
        }
      } else {
        args.push(value)
      }
      if args.length() > 4096 {
        raise Invalid("expanded argument limit")
      }
    }
    if !args.is_empty() {
      result = self.command(args, depth, discard_result~)
    }
    if result.length() > 1000000 {
      raise Invalid("command result size limit")
    }
  }
  result
}

///|
fn Interpreter::execute(
  self : Interpreter,
  source : String,
  depth : Int,
  discard_result? : Bool = false,
) -> String raise TclError {
  if source.length() > 100000 {
    raise Invalid("script size limit")
  }
  let program = self.cached_script(source)
  let mut result = ""
  let mut index = 0
  while true {
    if index == program.commands.length() {
      if program.failure is Some(message) {
        raise Invalid(message)
      }
      if program.parser.pos == program.parser.chars.length() {
        break
      }
      try {
        let commands = program.parser.script(false, 0, one=true)
        for command in commands {
          program.commands.push(command)
        }
      } catch {
        Invalid(message) => {
          program.failure = Some(message)
          raise Invalid(message)
        }
        error => raise error
      }
      if index == program.commands.length() {
        continue
      }
    }
    result = self.execute_commands(
      [program.commands[index]],
      depth,
      discard_result~,
    )
    index += 1
  }
  result
}
