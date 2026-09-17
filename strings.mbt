///|
priv enum GlobToken {
  Many
  One
  Character(Char)
  Range(Array[(Char, Char)])
}

///|
fn glob_match(
  pattern : String,
  value : String,
  nocase : Bool,
) -> Bool raise TclError {
  let p = (if nocase { pattern.to_lower() } else { pattern }).to_array()
  let s = (if nocase { value.to_lower() } else { value }).to_array()
  if p.length() > 4096 ||
    s.length() > 100000 ||
    p.length() > 1000000 / (s.length() + 1) {
    raise Invalid("glob work limit")
  }
  let tokens = []
  let mut i = 0
  while i < p.length() {
    let c = p[i]
    i += 1
    if c == '*' {
      tokens.push(Many)
    } else if c == '?' {
      tokens.push(One)
    } else if c == '\\' {
      if i == p.length() {
        return false
      }
      tokens.push(Character(p[i]))
      i += 1
    } else if c == '[' {
      let ranges = []
      let mut closed = false
      while i < p.length() {
        if p[i] == ']' {
          i += 1
          closed = true
          break
        }
        let first = p[i]
        i += 1
        if i + 1 < p.length() && p[i] == '-' && p[i + 1] != ']' {
          ranges.push((first, p[i + 1]))
          i += 2
        } else {
          ranges.push((first, first))
        }
      }
      if !closed {
        return false
      }
      tokens.push(Range(ranges))
    } else {
      tokens.push(Character(c))
    }
  }
  let mut previous = Array::make(s.length() + 1, false)
  previous[0] = true
  for token in tokens {
    let next = Array::make(s.length() + 1, false)
    if token is Many {
      next[0] = previous[0]
    }
    for j in 1..<=s.length() {
      next[j] = match token {
        Many => previous[j] || next[j - 1]
        One => previous[j - 1]
        Character(c) => previous[j - 1] && s[j - 1] == c
        Range(ranges) =>
          previous[j - 1] &&
          ranges
          .iter()
          .any(pair => {
            (s[j - 1] >= pair.0 && s[j - 1] <= pair.1) ||
            (s[j - 1] >= pair.1 && s[j - 1] <= pair.0)
          })
      }
    }
    previous = next
  }
  previous[s.length()]
}

///|
fn Interpreter::string_command(
  _self : Interpreter,
  args : Array[String],
) -> String raise TclError {
  let n = args.length()
  if n < 2 {
    raise Invalid("string arity")
  }
  let op = args[1]
  match op {
    "length" => {
      if n != 3 {
        raise Invalid("string length arity")
      }
      args[2].length().to_string()
    }
    "index" | "range" => {
      if n != (if op == "index" { 4 } else { 5 }) {
        raise Invalid("string index/range arity")
      }
      let text = args[2]
      let first = list_index(args[3], text.length())
      let last = if op == "index" {
        first
      } else {
        list_index(args[4], text.length())
      }
      if (op == "index" && first < 0) ||
        first >= text.length() ||
        last < first ||
        last < 0 {
        ""
      } else {
        text[first.max(0):(last + 1).min(text.length())].to_owned()
      }
    }
    "compare" | "equal" => {
      let mut i = 2
      let mut nocase = false
      let mut limit = None
      while i < n - 2 {
        if args[i] == "-nocase" {
          nocase = true
          i += 1
        } else if args[i] == "-length" && i + 1 < n - 2 {
          limit = Some(integer(args[i + 1]))
          i += 2
        } else {
          raise Invalid("string compare option")
        }
      }
      if i != n - 2 {
        raise Invalid("string compare arity")
      }
      let a = if nocase { args[i].to_lower() } else { args[i] }
      let b = if nocase { args[i + 1].to_lower() } else { args[i + 1] }
      let a = match limit {
        Some(v) if v >= 0 => a[:v.min(a.length())].to_owned()
        _ => a
      }
      let b = match limit {
        Some(v) if v >= 0 => b[:v.min(b.length())].to_owned()
        _ => b
      }
      let cmp = a.compare(b)
      if op == "equal" {
        boolean_text(cmp == 0)
      } else if cmp < 0 {
        "-1"
      } else if cmp > 0 {
        "1"
      } else {
        "0"
      }
    }
    "first" | "last" => {
      if n != 4 && n != 5 {
        raise Invalid("string search arity")
      }
      let needle = args[2]
      let text = args[3]
      if needle.is_empty() {
        return "-1"
      }
      if op == "first" {
        let start = if n == 5 { integer(args[4]).max(0) } else { 0 }
        if start > text.length() {
          return "-1"
        }
        match text[start:].to_owned().find(needle) {
          Some(i) => (i + start).to_string()
          None => "-1"
        }
      } else {
        let last = if n == 5 {
          list_index(args[4], text.length()).min(text.length() - 1)
        } else {
          text.length() - 1
        }
        if last < 0 {
          return "-1"
        }
        text[:last + 1].to_owned().rev_find(needle).unwrap_or(-1).to_string()
      }
    }
    "tolower" | "toupper" | "totitle" => {
      if n < 3 || n > 5 {
        raise Invalid("string case arity")
      }
      let text = args[2]
      let first = if n >= 4 {
        list_index(args[3], text.length()).max(0).min(text.length())
      } else {
        0
      }
      let last = if n == 5 {
        list_index(args[4], text.length()).min(text.length() - 1)
      } else if n == 4 {
        first
      } else {
        text.length() - 1
      }
      if last < first {
        return text
      }
      let part = text[first:last + 1].to_owned()
      let converted = if op == "tolower" {
        part.to_lower()
      } else if op == "toupper" {
        part.to_upper()
      } else {
        let cs = part.to_array()
        if cs.is_empty() {
          ""
        } else {
          cs[0].to_string().to_upper() + String::from_array(cs[1:]).to_lower()
        }
      }
      text[:first].to_owned() + converted + text[last + 1:].to_owned()
    }
    "trim" | "trimleft" | "trimright" => {
      if n != 3 && n != 4 {
        raise Invalid("string trim arity")
      }
      let text = args[2].to_array()
      let chars = if n == 4 {
        args[3].to_array()
      } else {
        " \t\r\n\u000b\u000c\u0085\u00a0".to_array()
      }
      let mut first = 0
      let mut last = text.length()
      if op != "trimright" {
        while first < last && chars.contains(text[first]) {
          first += 1
        }
      }
      if op != "trimleft" {
        while last > first && chars.contains(text[last - 1]) {
          last -= 1
        }
      }
      String::from_array(text[first:last])
    }
    "repeat" => {
      if n != 4 {
        raise Invalid("string repeat arity")
      }
      let count = integer(args[3]).max(0)
      if !args[2].is_empty() && count > 1000000 / args[2].length() {
        raise Invalid("string repeat size")
      }
      args[2].repeat(count)
    }
    "reverse" => {
      if n != 3 {
        raise Invalid("string reverse arity")
      }
      args[2].rev()
    }
    "replace" => {
      if n != 5 && n != 6 {
        raise Invalid("string replace arity")
      }
      let text = args[2]
      let first = list_index(args[3], text.length()).max(0)
      let last = list_index(args[4], text.length()).min(text.length() - 1)
      if first >= text.length() || last < first {
        return text
      }
      text[:first].to_owned() +
      (if n == 6 { args[5] } else { "" }) +
      text[last + 1:].to_owned()
    }
    "match" => {
      let nocase = n == 5 && args[2] == "-nocase"
      if n != (if nocase { 5 } else { 4 }) {
        raise Invalid("string match arity")
      }
      boolean_text(glob_match(args[n - 2], args[n - 1], nocase))
    }
    "map" => {
      let nocase = n == 5 && args[2] == "-nocase"
      if n != (if nocase { 5 } else { 4 }) {
        raise Invalid("string map arity")
      }
      let mapping = parse_list(args[n - 2])
      if mapping.length() % 2 != 0 {
        raise Invalid("string map expects pairs")
      }
      let source = args[n - 1]
      let subject = if nocase { source.to_lower() } else { source }
      let out = StringBuilder()
      let mut i = 0
      let mut size = 0
      while i < source.length() {
        let mut matched = false
        let mut j = 0
        while j < mapping.length() {
          let key = if nocase { mapping[j].to_lower() } else { mapping[j] }
          if !key.is_empty() && subject[i:].has_prefix(key) {
            size += mapping[j + 1].length()
            if size > 1000000 {
              raise Invalid("string map size limit")
            }
            out.write_string(mapping[j + 1])
            i += key.length()
            matched = true
            break
          }
          j += 2
        }
        if !matched {
          out.write_string(source[i:i + 1].to_owned())
          i += 1
          size += 1
        }
      }
      out.to_string()
    }
    "is" => {
      if n < 4 {
        raise Invalid("string is arity")
      }
      let strict = n == 5 && args[3] == "-strict"
      if n != (if strict { 5 } else { 4 }) {
        raise Invalid("string is options")
      }
      let value = args[n - 1]
      let kind = args[2]
      let valid = if value.is_empty() {
        !strict || kind == "list"
      } else {
        match kind {
          "integer" =>
            try {
              let v = whole(value)
              v >= -2147483648N && v <= 4294967295N
            } catch {
              _ => false
            }
          "wideinteger" =>
            try {
              let v = whole(value)
              v >= -9223372036854775808N && v <= 18446744073709551615N
            } catch {
              _ => false
            }
          "entier" =>
            try {
              ignore(whole(value))
              true
            } catch {
              _ => false
            }
          "double" => number(value) is Some(_)
          "boolean" =>
            try {
              ignore(string_boolean(value))
              true
            } catch {
              _ => false
            }
          "true" => string_boolean(value) catch { _ => false }
          "false" =>
            try !string_boolean(value) catch {
              _ => false
            }
          "list" =>
            try {
              ignore(parse_list(value))
              true
            } catch {
              _ => false
            }
          "digit" => value.to_array().iter().all(c => c >= '0' && c <= '9')
          "xdigit" => value.to_array().iter().all(c => hex_digit(c) >= 0)
          "space" => value.to_array().iter().all(list_space)
          "ascii" => value.to_array().iter().all(c => c.to_int() < 128)
          "alpha" =>
            value
            .to_array()
            .iter()
            .all(c => (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z'))
          "alnum" =>
            value
            .to_array()
            .iter()
            .all(c => {
              (c >= 'a' && c <= 'z') ||
              (c >= 'A' && c <= 'Z') ||
              (c >= '0' && c <= '9')
            })
          _ => raise Invalid("unsupported string class")
        }
      }
      boolean_text(valid)
    }
    _ => raise Invalid("unsupported string subcommand " + op)
  }
}

///|
fn string_boolean(value : String) -> Bool raise TclError {
  let text = value.to_lower()
  if text == "0" {
    return false
  }
  if text == "1" {
    return true
  }
  if text.is_empty() || text == "o" {
    raise Invalid("expected boolean")
  }
  for word in ["true", "yes", "on"] {
    if word.has_prefix(text) {
      return true
    }
  }
  for word in ["false", "no", "off"] {
    if word.has_prefix(text) {
      return false
    }
  }
  raise Invalid("expected boolean")
}

///|
fn Interpreter::info_command(
  self : Interpreter,
  args : Array[String],
) -> String raise TclError {
  let n = args.length()
  if n < 2 {
    raise Invalid("info arity")
  }
  match args[1] {
    "exists" => {
      if n != 3 {
        raise Invalid("info exists arity")
      }
      let exists = match self.binding(args[2], false) {
        Some(binding) =>
          if binding.index is None {
            binding.cell.value is Some(_)
          } else {
            try (binding.read() is Some(_)) catch {
              _ => false
            }
          }
        None => false
      }
      boolean_text(exists)
    }
    "vars" | "globals" | "locals" => {
      if n > 3 {
        raise Invalid("info vars arity")
      }
      let values = []
      if self.frame.procedure && args[1] != "globals" {
        for key, binding in self.frame.vars {
          if binding.cell.value is Some(_) &&
            (args[1] != "locals" || !binding.linked) {
            values.push(key)
          }
        }
      } else {
        let prefix = if args[1] == "globals" {
          "::"
        } else {
          self.frame.namespace_name
        }
        for key, cell in self.state.globals {
          if (cell.value is Some(_) || cell.declared) &&
            namespace_parent(key) == prefix {
            values.push(namespace_tail(key))
          }
        }
        for key, binding in self.state.aliases {
          if binding.cell.value is Some(_) &&
            namespace_parent(key) == prefix &&
            !values.contains(namespace_tail(key)) {
            values.push(namespace_tail(key))
          }
        }
      }
      values.sort()
      format_list(
        if n == 3 {
          values.filter(key => glob_match(args[2], key, false))
        } else {
          values
        },
      )
    }
    "procs" | "commands" => {
      if n > 3 {
        raise Invalid("info commands arity")
      }
      format_list(
        self.command_names(
          if n == 3 {
            args[2]
          } else {
            "*"
          },
          args[1] == "procs",
        ),
      )
    }
    "body" | "args" | "default" => {
      if n != (if args[1] == "default" { 5 } else { 3 }) {
        raise Invalid("info procedure arity")
      }
      let definition = match self.find_command(args[2]) {
        Some(command) =>
          match command.origin().body {
            Script(p) => p
            _ => raise Invalid("not a procedure")
          }
        None => raise Invalid("unknown procedure")
      }
      if args[1] == "body" {
        definition.body
      } else if args[1] == "args" {
        format_list(definition.parameters.map(p => p.0))
      } else {
        for (name, value) in definition.parameters {
          if name == args[3] {
            self.set_var(args[4], value.unwrap_or(""))
            return boolean_text(value is Some(_))
          }
        }
        raise Invalid("unknown argument")
      }
    }
    "level" => {
      if n != 2 {
        raise Invalid("info level argument not implemented")
      }
      let mut level = 0
      let mut frame = self.frame
      while frame.parent is Some(parent) {
        level += 1
        frame = parent
      }
      level.to_string()
    }
    "patchlevel" => {
      if n != 2 {
        raise Invalid("info patchlevel arity")
      }
      "0.6.0"
    }
    "tclversion" => {
      if n != 2 {
        raise Invalid("info tclversion arity")
      }
      "8.6"
    }
    _ => raise Invalid("unsupported info subcommand")
  }
}
