///|
fn string_choice(
  value : String,
  choices : Array[String],
) -> String raise TclError {
  if choices.contains(value) {
    return value
  }
  let matches = choices.filter(choice => {
    !value.is_empty() && choice.has_prefix(value)
  })
  if matches.length() != 1 {
    raise Invalid("unknown or ambiguous string option/class: " + value)
  }
  matches[0]
}

///|
// Return the end of the longest legal numeric prefix, including surrounding
// ASCII whitespace. A missing prefix fails at zero, including after a sign.
fn numeric_prefix(text : String, real : Bool) -> Int {
  let cs = utf16_units(text)
  let n = cs.length()
  let mut start = 0
  while start < n && list_space(cs[start]) {
    start += 1
  }
  if start < n && (cs[start] == '+' || cs[start] == '-') {
    start += 1
  }
  let mut end = 0
  if start < n && cs[start] >= '0' && cs[start] <= '9' {
    let mut base = 10
    let mut i = start
    if cs[start] == '0' {
      end = start + 1
      base = 8
      if start + 1 < n {
        match cs[start + 1] {
          'x' | 'X' => {
            base = 16
            i = start + 2
          }
          'b' | 'B' => {
            base = 2
            i = start + 2
          }
          'o' | 'O' => {
            base = 8
            i = start + 2
          }
          _ => ()
        }
      }
    }
    while i < n && hex_digit(cs[i]) >= 0 && hex_digit(cs[i]) < base {
      i += 1
      end = i
    }
  }
  if real {
    let mut i = start
    while i < n && cs[i] >= '0' && cs[i] <= '9' {
      i += 1
    }
    let mut digits = i - start
    let mut floating = false
    if i < n && cs[i] == '.' {
      floating = true
      i += 1
      while i < n && cs[i] >= '0' && cs[i] <= '9' {
        i += 1
        digits += 1
      }
    }
    if digits > 0 {
      if floating {
        end = end.max(i)
      }
      if i < n && (cs[i] == 'e' || cs[i] == 'E') {
        i += 1
        if i < n && (cs[i] == '+' || cs[i] == '-') {
          i += 1
        }
        let exponent = i
        while i < n && cs[i] >= '0' && cs[i] <= '9' {
          i += 1
        }
        if i > exponent {
          end = end.max(i)
        }
      }
    }
    let rest = unicode_case(unit_slice(text, start, n), 0)
    if rest.has_prefix("inf") {
      end = start + (if rest.has_prefix("infinity") { 8 } else { 3 })
    } else if rest.has_prefix("nan") {
      end = start + 3
      if end < n && cs[end] == '(' {
        let mut i = end + 1
        while i < n && hex_digit(cs[i]) >= 0 {
          i += 1
        }
        let count = i - end - 1
        if count > 0 && count <= 13 && i < n && cs[i] == ')' {
          end = i + 1
        }
      }
    }
  }
  if end > 0 {
    while end < n && list_space(cs[end]) {
      end += 1
    }
  }
  end
}

///|
fn Interpreter::string_is(
  self : Interpreter,
  input : Array[TclValue],
) -> String raise TclError {
  let args = input.map(v => v.text)
  let n = args.length()
  if n < 4 || n > 7 {
    raise Invalid("string is arity")
  }
  let classes = [
    "alnum", "alpha", "ascii", "control", "digit", "graph", "lower", "print", "punct",
    "space", "upper", "wordchar", "xdigit",
  ]
  let kind = string_choice(
    args[2],
    classes +
    [
      "integer", "wideinteger", "entier", "double", "boolean", "true", "false", "list",
    ],
  )
  let mut strict = false
  let mut failure = None
  let mut i = 3
  while i < n - 1 {
    match string_choice(args[i], ["-strict", "-failindex"]) {
      "-strict" => {
        strict = true
        i += 1
      }
      _ => {
        if i + 1 >= n - 1 {
          raise Invalid("missing string is failure variable")
        }
        failure = Some(args[i + 1])
        i += 2
      }
    }
  }
  let value = args[n - 1]
  let position = Ref(0)
  let valid = if value.is_empty() {
    !strict || kind == "list"
  } else if classes.search(kind) is Some(bit) {
    input[n - 1].payload = Plain
    let mut valid = true
    for c in value.to_array() {
      if (unicode_mask(c.to_int()) & (1 << bit)) == 0 {
        valid = false
        break
      }
      position.val += 1
    }
    valid
  } else {
    match kind {
      "integer" | "wideinteger" | "entier" | "double" => {
        position.val = numeric_prefix(value, kind == "double")
        if position.val != value.length() {
          false
        } else if kind == "double" {
          true
        } else {
          position.val = -1
          try {
            let v = whole(value)
            if kind == "integer" {
              v >= -4294967295N && v <= 4294967295N
            } else if kind == "wideinteger" {
              v >= -18446744073709551615N && v <= 18446744073709551615N
            } else {
              true
            }
          } catch {
            _ => false
          }
        }
      }
      "boolean" | "true" | "false" =>
        try {
          let v = string_boolean(value)
          kind == "boolean" || v == (kind == "true")
        } catch {
          _ => false
        }
      "list" =>
        try {
          ignore(parse_list_at(value, Some(position)))
          true
        } catch {
          _ => false
        }
      _ => false
    }
  }
  if !valid && failure is Some(name) {
    self.set_var(name, position.val.to_string())
  }
  if valid && kind == "list" {
    ignore(input[n - 1].as_list())
  }
  if valid && ["integer", "wideinteger", "entier", "double"].contains(kind) {
    ignore(input[n - 1].as_number())
  }
  boolean_text(valid)
}
