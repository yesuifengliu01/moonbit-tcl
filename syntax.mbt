///|
enum Part {
  Text(String)
  Variable(String, Array[Part]?)
  Command(Array[ParsedCommand])
} derive(Debug)

///|
struct Word {
  parts : Array[Part]
  expand : Bool
} derive(Debug)

///|
struct ParsedCommand {
  words : Array[Word]
  source : String
  line : Int
} derive(Debug)

///|
struct ScriptParser {
  chars : Array[Char]
  mut pos : Int
  mut line_pos : Int
  mut line : Int
  mut command_start : Int
  mut command_line : Int
  mut trailing_continuation : Bool
} derive(Debug)

///|
fn ScriptParser::new(source : String) -> ScriptParser {
  {
    chars: source.to_array(),
    pos: 0,
    line_pos: 0,
    line: 1,
    command_start: 0,
    command_line: 1,
    trailing_continuation: false,
  }
}

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
    !(self.peek() == '\\' && self.peek(offset=1) == '\n') &&
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
) -> Array[ParsedCommand] raise TclError {
  if depth > 64 {
    raise Invalid("script nesting limit")
  }
  let commands = []
  let mut words = []
  let mut start = self.pos
  let mut line = self.source_line()
  while self.pos < self.chars.length() {
    let c = self.peek()
    if c == ']' && bracket {
      self.pos += 1
      if !words.is_empty() {
        commands.push(self.parsed_command(words, start, line, self.pos - 1))
      }
      return commands
    }
    if c == '\\' && self.peek(offset=1) == '\n' {
      if self.pos + 2 == self.chars.length() {
        self.trailing_continuation = true
      }
      let (_, next) = backslash(self.chars, self.pos)
      self.pos = next
      continue
    }
    if c == ';' || c == '\n' {
      self.pos += 1
      if !words.is_empty() {
        commands.push(self.parsed_command(words, start, line, self.pos - 1))
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
          if self.pos + 2 == self.chars.length() {
            self.trailing_continuation = true
          }
          let (_, next) = backslash(self.chars, self.pos)
          self.pos = next
        } else if self.peek() == '\\' && self.pos + 1 < self.chars.length() {
          self.pos += 2
        } else {
          self.pos += 1
        }
      }
    } else {
      if words.is_empty() {
        start = self.pos
        line = self.source_line()
        self.command_start = start
        self.command_line = line
      }
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
    commands.push(self.parsed_command(words, start, line, self.pos))
  }
  commands
}

///|
fn Interpreter::expand_values(
  self : Interpreter,
  parts : Array[Part],
  depth : Int,
) -> TclValue raise TclError {
  if depth > 64 {
    raise Invalid("substitution depth")
  }
  let mut result : TclValue? = None
  let mut size = 0
  let mut builder : StringBuilder? = None
  for part in parts {
    self.tick()
    let value = match part {
      Text(text) if text.is_empty() => continue
      Text(text) => text_value(text)
      Variable(name, index) => {
        let name = match index {
          Some(parts) => name + "(" + self.expand_parts(parts, depth + 1) + ")"
          None => name
        }
        self.read_value(name)
      }
      Command(commands) => self.execute_command_values(commands, depth + 1)
    }
    size += value.text.length()
    if size > 1000000 {
      raise Invalid("substitution result size limit")
    }
    match result {
      None => result = Some(value)
      Some(first) =>
        if !value.text.is_empty() {
          match builder {
            Some(out) => out.write_string(value.text)
            None => {
              let out = StringBuilder()
              out.write_string(first.text)
              out.write_string(value.text)
              builder = Some(out)
            }
          }
        }
    }
  }
  match builder {
    Some(out) => text_value(out.to_string())
    None =>
      match result {
        Some(value) => value
        None => text_value("")
      }
  }
}

///|
// None denotes a command whose words all expanded away. The caller chooses
// the surrounding script's existing empty-command result behavior.
fn Interpreter::execute_parsed_command(
  self : Interpreter,
  parsed : ParsedCommand,
  depth : Int,
  discard_result? : Bool = false,
) -> TclValue? raise TclError {
  if depth > 64 {
    raise Invalid("execution nesting limit")
  }
  let args = []
  try {
    for word in parsed.words {
      let value = self.expand_values(word.parts, depth + 1)
      if word.expand {
        for item in value.as_list() {
          args.push(item)
        }
      } else {
        args.push(value)
      }
      if args.length() > 4096 {
        raise Invalid("expanded argument limit")
      }
    }
    if args.is_empty() {
      return None
    }
    let result = self.command_value(args, depth, discard_result~)
    if result.text.length() > 1000000 {
      raise Invalid("command result size limit")
    }
    Some(result)
  } catch {
    error =>
      raise Signal(
        self.annotate_error(
          outcome(error),
          parsed.source,
          parsed.line,
          args.map(v => v.text),
        ),
      )
  }
}

///|
fn Interpreter::execute_command_values(
  self : Interpreter,
  commands : Array[ParsedCommand],
  depth : Int,
  discard_result? : Bool = false,
) -> TclValue raise TclError {
  if depth > 64 {
    raise Invalid("execution nesting limit")
  }
  let mut result : TclValue? = None
  for parsed in commands {
    if self.execute_parsed_command(parsed, depth, discard_result~)
      is Some(value) {
      result = Some(value)
    }
  }
  match result {
    Some(value) => value
    None => text_value("")
  }
}

///|
fn Interpreter::execute_value(
  self : Interpreter,
  source : String,
  depth : Int,
  discard_result? : Bool = false,
) -> TclValue raise TclError {
  if source.length() > 100000 {
    raise Invalid("script size limit")
  }
  let program = self.cached_script(source)
  let mut result : TclValue? = None
  let mut index = 0
  while true {
    if index == program.commands.length() {
      if program.failure is Some(message) {
        raise Signal(
          self.annotate_error(
            completion_error(message),
            String::from_array(
              program.parser.chars[program.parser.command_start:],
            ),
            program.parser.command_line,
            [],
          ),
        )
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
          raise Signal(
            self.annotate_error(
              completion_error(message),
              String::from_array(
                program.parser.chars[program.parser.command_start:],
              ),
              program.parser.command_line,
              [],
            ),
          )
        }
        error => raise error
      }
      if index == program.commands.length() {
        continue
      }
    }
    result = self.execute_parsed_command(
      program.commands[index],
      depth,
      discard_result~,
    )
    index += 1
  }
  match result {
    Some(value) => value
    None => text_value("")
  }
}

///|
fn ScriptParser::source_line(self : ScriptParser) -> Int {
  while self.line_pos < self.pos {
    if self.chars[self.line_pos] == '\n' {
      self.line += 1
    }
    self.line_pos += 1
  }
  self.line
}

///|
fn ScriptParser::parsed_command(
  self : ScriptParser,
  words : Array[Word],
  start : Int,
  line : Int,
  end : Int,
) -> ParsedCommand {
  {
    words,
    source: String::from_array(self.chars[start:end]).trim_end().to_owned(),
    line,
  }
}

///|
fn Interpreter::expand_parts(
  self : Interpreter,
  parts : Array[Part],
  depth : Int,
) -> String raise TclError {
  self.expand_values(parts, depth).text
}

///|
fn Interpreter::execute_commands(
  self : Interpreter,
  commands : Array[ParsedCommand],
  depth : Int,
) -> String raise TclError {
  self.execute_command_values(commands, depth).text
}
