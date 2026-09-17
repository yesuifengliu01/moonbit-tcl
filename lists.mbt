///|
fn list_space(c : Char) -> Bool {
  c == ' ' ||
  c == '\t' ||
  c == '\r' ||
  c == '\n' ||
  c == '\u000b' ||
  c == '\u000c'
}

///|
fn hex_digit(c : Char) -> Int {
  if c >= '0' && c <= '9' {
    c.to_int() - 48
  } else if c >= 'a' && c <= 'f' {
    c.to_int() - 87
  } else if c >= 'A' && c <= 'F' {
    c.to_int() - 55
  } else {
    -1
  }
}

///|
// Tcl 8.x backslash substitution, shared by scripts and list parsing.
fn backslash(cs : Array[Char], start : Int) -> (String, Int) {
  let mut i = start + 1
  if i >= cs.length() {
    return ("\\", i)
  }
  let c = cs[i]
  i += 1
  let result = match c {
    'a' => "\u0007"
    'b' => "\u0008"
    'f' => "\u000c"
    'n' => "\n"
    'r' => "\r"
    't' => "\t"
    'v' => "\u000b"
    '\n' => {
      while i < cs.length() && (cs[i] == ' ' || cs[i] == '\t') {
        i += 1
      }
      " "
    }
    'x' | 'u' | 'U' => {
      let limit = if c == 'x' { 2 } else if c == 'u' { 4 } else { 8 }
      let mut value = 0UL
      let mut count = 0
      while i < cs.length() && count < limit {
        let digit = hex_digit(cs[i])
        if digit < 0 {
          break
        }
        value = value * 16UL + digit.to_uint64()
        count += 1
        i += 1
      }
      if count == 0 {
        c.to_string()
      } else if value > 65535UL {
        "\ufffd"
      } else {
        value.to_int().to_char().unwrap_or('\ufffd').to_string()
      }
    }
    _ =>
      if c >= '0' && c <= '7' {
        let mut value = c.to_int() - 48
        let mut count = 1
        let limit = if c <= '3' { 3 } else { 2 }
        while i < cs.length() && count < limit && cs[i] >= '0' && cs[i] <= '7' {
          value = value * 8 + cs[i].to_int() - 48
          i += 1
          count += 1
        }
        value.to_char().unwrap_or('\ufffd').to_string()
      } else {
        c.to_string()
      }
  }
  (result, i)
}

///|
/// Parse Tcl lists without variable or command substitution.
pub fn parse_list(text : String) -> Array[String] raise TclError {
  if text.length() > 1000000 {
    raise Invalid("list size limit")
  }
  let cs = text.to_array()
  let values = []
  let mut i = 0
  while i < cs.length() {
    while i < cs.length() && list_space(cs[i]) {
      i += 1
    }
    if i == cs.length() {
      break
    }
    let out = StringBuilder()
    if cs[i] == '{' {
      i += 1
      let mut level = 1
      while i < cs.length() && level > 0 {
        let c = cs[i]
        i += 1
        if c == '\\' && i < cs.length() {
          out.write_char('\\')
          out.write_char(cs[i])
          i += 1
        } else if c == '{' {
          level += 1
          out.write_char('{')
        } else if c == '}' {
          level -= 1
          if level > 0 {
            out.write_char('}')
          }
        } else {
          out.write_char(c)
        }
      }
      if level != 0 {
        raise Invalid("unmatched open brace in list")
      }
      if i < cs.length() && !list_space(cs[i]) {
        raise Invalid("characters after braced list element")
      }
    } else if cs[i] == '"' {
      i += 1
      let mut closed = false
      while i < cs.length() {
        let c = cs[i]
        if c == '"' {
          i += 1
          closed = true
          break
        }
        if c == '\\' {
          let (v, next) = backslash(cs, i)
          out.write_string(v)
          i = next
        } else {
          out.write_char(c)
          i += 1
        }
      }
      if !closed {
        raise Invalid("unmatched quote in list")
      }
      if i < cs.length() && !list_space(cs[i]) {
        raise Invalid("characters after quoted list element")
      }
    } else {
      while i < cs.length() && !list_space(cs[i]) {
        if cs[i] == '\\' {
          let (v, next) = backslash(cs, i)
          out.write_string(v)
          i = next
        } else {
          out.write_char(cs[i])
          i += 1
        }
      }
    }
    values.push(out.to_string())
    if values.length() > 100000 {
      raise Invalid("list element limit")
    }
  }
  values
}

///|
fn quote_element(text : String, first : Bool) -> String {
  if text.is_empty() {
    return "{}"
  }
  let cs = text.to_array()
  let mut use_braces = cs[0] == '{' || cs[0] == '"' || (first && cs[0] == '#')
  let mut escape = false
  let mut balanced = true
  let mut level = 0
  let mut i = 0
  while i < cs.length() {
    let c = cs[i]
    if list_space(c) || c == '$' || c == '[' || c == ';' || c == '\\' {
      use_braces = true
    }
    if c == ']' || c == '"' {
      escape = true
    }
    if c == '\\' {
      i += 1
      if i == cs.length() || cs[i] == '\n' {
        balanced = false
      }
    } else if c == '{' {
      level += 1
    } else if c == '}' {
      level -= 1
      if level < 0 {
        balanced = false
      }
    }
    i += 1
  }
  balanced = balanced && level == 0
  if use_braces && balanced {
    return "{" + text + "}"
  }
  if !use_braces && !escape && balanced {
    return text
  }
  let out = []
  for i in 0..<cs.length() {
    let c = cs[i]
    out.push(
      match c {
        '\n' => "\\n"
        '\r' => "\\r"
        '\t' => "\\t"
        '\u000b' => "\\v"
        '\u000c' => "\\f"
        ' ' | '{' | '}' | '[' | ']' | '$' | ';' | '"' | '\\' =>
          "\\" + c.to_string()
        '#' => if first && i == 0 { "\\#" } else { "#" }
        _ => c.to_string()
      },
    )
  }
  out.join("")
}

///|
/// Construct a Tcl list with escaping that preserves every input element.
pub fn format_list(values : Array[String]) -> String raise TclError {
  if values.length() > 100000 {
    raise Invalid("list element limit")
  }
  let out = []
  let mut size = 0
  for i in 0..<values.length() {
    if values[i].length() > 1000000 {
      raise Invalid("list size limit")
    }
    let value = quote_element(values[i], i == 0)
    size += value.length() + (if i > 0 { 1 } else { 0 })
    if size > 1000000 {
      raise Invalid("list size limit")
    }
    out.push(value)
  }
  out.join(" ")
}

///|
fn list_index(text : String, length : Int) -> Int raise TclError {
  if text == "end" {
    return length - 1
  }
  if text.has_prefix("end-") {
    return length - 1 - integer(text[4:].to_owned())
  }
  if text.has_prefix("end+") {
    return length - 1 + integer(text[4:].to_owned())
  }
  integer(text)
}

///|
fn Interpreter::list_command(
  self : Interpreter,
  args : Array[String],
) -> String raise TclError {
  let n = args.length()
  match args[0] {
    "list" => format_list(args[1:].to_owned())
    "llength" => {
      if n != 2 {
        raise Invalid("llength arity")
      }
      parse_list(args[1]).length().to_string()
    }
    "lindex" => {
      if n < 2 {
        raise Invalid("lindex arity")
      }
      let indices = if n == 3 {
        parse_list(args[2])
      } else {
        args[2:].to_owned()
      }
      let mut value = args[1]
      for index in indices {
        let values = parse_list(value)
        let i = list_index(index, values.length())
        value = if i >= 0 && i < values.length() { values[i] } else { "" }
      }
      value
    }
    "lappend" => {
      if n < 2 {
        raise Invalid("lappend arity")
      }
      if n == 2 {
        let value = self.get_var(args[1]).unwrap_or("")
        ignore(parse_list(value))
        self.set_var(args[1], value)
        return value
      }
      let values = parse_list(self.get_var(args[1]).unwrap_or(""))
      for item in args[2:] {
        values.push(item)
      }
      let result = format_list(values)
      self.set_var(args[1], result)
      result
    }
    "join" => {
      if n != 2 && n != 3 {
        raise Invalid("join arity")
      }
      let values = parse_list(args[1])
      let sep = if n == 3 { args[2] } else { " " }
      let mut size = 0
      for value in values {
        size += value.length()
        if size > 1000000 {
          raise Invalid("join size limit")
        }
      }
      if values.length() > 1 &&
        sep.length() > (1000000 - size) / (values.length() - 1) {
        raise Invalid("join size limit")
      }
      values.join(sep)
    }
    "split" => {
      if n != 2 && n != 3 {
        raise Invalid("split arity")
      }
      let separators = (if n == 3 { args[2] } else { " \n\t\r" }).to_array()
      let chars = args[1].to_array()
      let values = []
      if separators.is_empty() {
        for c in chars {
          values.push(c.to_string())
        }
      } else if !chars.is_empty() {
        let mut word = ""
        for c in chars {
          if separators.contains(c) {
            values.push(word)
            word = ""
          } else {
            word += c.to_string()
          }
        }
        values.push(word)
      }
      format_list(values)
    }
    "concat" => {
      let values = []
      let mut size = 0
      for part in args[1:] {
        let chars = part.to_array()
        let mut first = 0
        let mut last = chars.length()
        while first < last && list_space(chars[first]) {
          first += 1
        }
        while last > first && list_space(chars[last - 1]) {
          last -= 1
        }
        if first < last {
          let value = String::from_array(chars[first:last])
          size += value.length() + 1
          if size > 1000000 {
            raise Invalid("concat size limit")
          }
          values.push(value)
        }
      }
      values.join(" ")
    }
    "lrange" => {
      if n != 4 {
        raise Invalid("lrange arity")
      }
      let values = parse_list(args[1])
      let first = list_index(args[2], values.length()).max(0)
      let last = list_index(args[3], values.length()).min(values.length() - 1)
      if first > last {
        ""
      } else {
        format_list(values[first:last + 1].to_owned())
      }
    }
    "lreverse" => {
      if n != 2 {
        raise Invalid("lreverse arity")
      }
      let values = parse_list(args[1])
      values.rev_in_place()
      format_list(values)
    }
    "lrepeat" => {
      if n < 3 {
        raise Invalid("lrepeat arity")
      }
      let count = integer(args[1])
      if count < 0 || count > 100000 / (n - 2) {
        raise Invalid("lrepeat count limit")
      }
      let values = []
      for _ in 0..<count {
        for value in args[2:] {
          values.push(value)
        }
      }
      format_list(values)
    }
    _ => raise Invalid("list command not implemented")
  }
}
