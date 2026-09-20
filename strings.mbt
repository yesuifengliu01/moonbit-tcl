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
  codepoints? : Bool = false,
) -> Bool raise TclError {
  let units = if codepoints { collection_codepoints } else { utf16_units }
  let p = units(if nocase { unicode_case(pattern, 0) } else { pattern })
  let s = units(if nocase { unicode_case(value, 0) } else { value })
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
  self : Interpreter,
  input : Array[TclValue],
) -> TclValue raise TclError {
  let args = input.map(v => v.text)
  let n = args.length()
  if n < 2 {
    raise Invalid("string arity")
  }
  let op = args[1]
  let text = match op {
    "cat" => {
      if n == 2 {
        return text_value("")
      }
      let mut result = input[2]
      for item in input[3:] {
        if !item.text.is_empty() {
          if item.text.length() > 1000000 - result.text.length() {
            raise Invalid("string cat size limit")
          }
          result = text_value(result.text + item.text)
        }
      }
      return result
    }
    "length" => {
      if n != 3 {
        raise Invalid("string length arity")
      }
      input[2].payload = Plain
      args[2].length().to_string()
    }
    "index" | "range" => {
      if n != (if op == "index" { 4 } else { 5 }) {
        raise Invalid("string index/range arity")
      }
      input[2].payload = Plain
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
        unit_slice(text, first.max(0), last.min(text.length() - 1) + 1)
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
      let a = if nocase { unicode_case(args[i], 0) } else { args[i] }
      let b = if nocase { unicode_case(args[i + 1], 0) } else { args[i + 1] }
      let a = match limit {
        Some(v) if v >= 0 => unit_slice(a, 0, v.min(a.length()))
        _ => a
      }
      let b = match limit {
        Some(v) if v >= 0 => unit_slice(b, 0, v.min(b.length()))
        _ => b
      }
      let cmp = tcl_string_compare(a, b)
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
      input[2].payload = Plain
      input[3].payload = Plain
      let needle = args[2]
      let text = args[3]
      if needle.is_empty() {
        return text_value("-1")
      }
      if op == "first" {
        let start = if n == 5 {
          list_index(args[4], text.length()).max(0)
        } else {
          0
        }
        if start > text.length() {
          return text_value("-1")
        }
        match unit_slice(text, start, text.length()).find(needle) {
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
          return text_value("-1")
        }
        unit_slice(text, 0, last + 1).rev_find(needle).unwrap_or(-1).to_string()
      }
    }
    "tolower" | "toupper" | "totitle" => {
      if n < 3 || n > 5 {
        raise Invalid("string case arity")
      }
      let text = args[2]
      let first = if n >= 4 { list_index(args[3], text.length()) } else { 0 }
      let last = if n == 5 {
        list_index(args[4], text.length()).min(text.length() - 1)
      } else if n == 4 {
        first.min(text.length() - 1)
      } else {
        text.length() - 1
      }
      let first = first.max(0).min(text.length())
      if last < first {
        return text_value(text)
      }
      let part = unit_slice(text, first, last + 1)
      let converted = unicode_case(
        part,
        if op == "tolower" {
          0
        } else if op == "toupper" {
          1
        } else {
          2
        },
        conversion=true,
      )
      unit_slice(text, 0, first) +
      converted +
      unit_slice(text, last + 1, text.length())
    }
    "trim" | "trimleft" | "trimright" => {
      if n != 3 && n != 4 {
        raise Invalid("string trim arity")
      }
      let text = args[2].to_array()
      let chars = if n == 4 { Some(args[3].to_array()) } else { None }
      let matches = fn(c) {
        match chars {
          Some(values) => values.contains(c)
          None => c.to_int() <= 65535 && (unicode_mask(c.to_int()) & 512) != 0
        }
      }
      let mut first = 0
      let mut last = text.length()
      if op != "trimright" {
        while first < last && matches(text[first]) {
          first += 1
        }
      }
      if op != "trimleft" {
        while last > first && matches(text[last - 1]) {
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
      if count == 1 {
        return input[2]
      }
      if !args[2].is_empty() && count > 1000000 / args[2].length() {
        raise Invalid("string repeat size")
      }
      args[2].repeat(count)
    }
    "reverse" => {
      if n != 3 {
        raise Invalid("string reverse arity")
      }
      input[2].payload = Plain
      unicode_reverse(args[2])
    }
    "replace" => {
      if n != 5 && n != 6 {
        raise Invalid("string replace arity")
      }
      input[2].payload = Plain
      let text = args[2]
      let first = list_index(args[3], text.length()).max(0)
      let last = list_index(args[4], text.length()).min(text.length() - 1)
      if first >= text.length() || last < first {
        return text_value(text)
      }
      unit_slice(text, 0, first) +
      (if n == 6 { args[5] } else { "" }) +
      unit_slice(text, last + 1, text.length())
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
      if mapping.is_empty() {
        return input[n - 1]
      }
      input[n - 1].payload = Plain
      let source = args[n - 1]
      let subject = if nocase { unicode_case(source, 0) } else { source }
      let out = StringBuilder()
      let mut i = 0
      let mut size = 0
      while i < source.length() {
        let mut matched = false
        let mut j = 0
        while j < mapping.length() {
          let key = if nocase {
            unicode_case(mapping[j], 0)
          } else {
            mapping[j]
          }
          if !key.is_empty() &&
            unit_slice(subject, i, subject.length()).has_prefix(key) {
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
          out.write_string(unit_slice(source, i, i + 1))
          i += 1
          size += 1
          if size > 1000000 {
            raise Invalid("string map size limit")
          }
        }
      }
      out.to_string()
    }
    "is" => self.string_is(input)
    _ => raise Invalid("unsupported string subcommand " + op)
  }
  text_value(text)
}

///|
fn string_boolean(value : String) -> Bool raise TclError {
  let text = unicode_case(value, 0)
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
    "script" => {
      if n == 3 {
        self.state.script_name.val = args[2]
      } else if n != 2 {
        raise Invalid("info script ?filename?")
      }
      self.state.script_name.val
    }
    "complete" => {
      if n != 3 {
        raise Invalid("info complete arity")
      }
      boolean_text(is_complete(args[2]))
    }
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
            self.set_value(args[4], value.unwrap_or(text_value("")))
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
    "errorstack" => {
      if n != 2 && !(n == 3 && args[2].is_empty()) {
        raise Invalid("info errorstack arity or unsupported interpreter")
      }
      self.state.error_stack.val
    }
    "patchlevel" => {
      if n != 2 {
        raise Invalid("info patchlevel arity")
      }
      "0.9.0"
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

///|
// MoonBit String.compare is shortlex. Tcl uses lexicographic UTF-16 units.
fn tcl_string_compare(a : String, b : String) -> Int {
  for i in 0..<a.length().min(b.length()) {
    let x = a.get(i).unwrap()
    let y = b.get(i).unwrap()
    if x < y {
      return -1
    }
    if x > y {
      return 1
    }
  }
  a.length().compare(b.length())
}
