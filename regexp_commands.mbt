///|
priv struct ReOutput {
  builder : StringBuilder
  mut size : Int
}

///|
fn ReOutput::append(self : ReOutput, text : String) -> Unit raise TclError {
  if text.length() > 1000000 - self.size {
    raise Invalid("regsub output size limit")
  }
  self.size += text.length()
  self.builder.write_string(text)
}

///|
fn re_index_integer(text : String) -> Int raise TclError {
  let value = whole(text)
  if value < whole("-4294967295") || value > whole("4294967295") {
    raise Invalid("regexp index integer range")
  }
  value.to_int()
}

///|
fn re_start_index(text : String, end : Int) -> Int raise TclError {
  let parsed = try {
    if (text.has_prefix("end+") || text.has_prefix("end-")) &&
      text.length() > 4 &&
      (unicode_mask(text.at(4).to_int()) & 512) != 0 {
      raise Invalid("spaced index")
    }
    if text == "end" {
      Some(end)
    } else if text.has_prefix("end+") {
      Some(end + re_index_integer(text[4:].to_owned()))
    } else if text.has_prefix("end-") {
      Some(end - re_index_integer(text[4:].to_owned()))
    } else {
      match (Some(re_index_integer(text)) catch { _ => None }) {
        Some(value) => Some(value)
        None => {
          let mut value : Int? = None
          for at in 1..<text.length() {
            let c = text.at(at)
            if (c == '+' || c == '-') &&
              (unicode_mask(text.at(at - 1).to_int()) & 512) == 0 &&
              at + 1 < text.length() &&
              (unicode_mask(text.at(at + 1).to_int()) & 512) == 0 {
              let left = re_index_integer(text[:at].to_owned())
              let right = re_index_integer(text[at + 1:].to_owned())
              value = Some(if c == '+' { left + right } else { left - right })
              break
            }
          }
          value
        }
      }
    }
  } catch {
    _ => None
  }
  match parsed {
    Some(value) => value
    None => {
      switch_error(
        "bad index \"" +
        text +
        "\": must be integer?[+-]integer? or end?[+-]integer?" +
        (if re_bad_octal_index(text) {
          " (looks like invalid octal number)"
        } else {
          ""
        }),
        "TCL VALUE INDEX",
      )
      0
    }
  }
}

///|
fn re_capture_value(
  text : String,
  span : (Int, Int),
  indices : Bool,
  delta : Int,
) -> TclValue raise TclError {
  if indices {
    if span.0 < 0 {
      return list_value([text_value("-1"), text_value("-1")])
    }
    return list_value([
      text_value((span.0 + delta).to_string()),
      text_value((span.1 + delta - 1).to_string()),
    ])
  }
  text_value(
    if span.0 < 0 || span.1 <= span.0 {
      ""
    } else {
      unit_slice(text, span.0, span.1)
    },
  )
}

///|
fn Interpreter::regexp_command(
  self : Interpreter,
  values : Array[TclValue],
) -> TclValue raise TclError {
  let replace = values[0].text == "regsub"
  let options = if replace {
    [
      "-all", "-nocase", "-expanded", "-line", "-linestop", "-lineanchor", "-start",
      "--",
    ]
  } else {
    [
      "-all", "-about", "-indices", "-inline", "-expanded", "-line", "-linestop",
      "-lineanchor", "-nocase", "-start", "--",
    ]
  }
  let mut at = 1
  let mut all = false
  let mut about = false
  let mut indices = false
  let mut inline = false
  let mut nocase = false
  let mut expanded = false
  let mut line_stop = false
  let mut line_anchor = false
  let mut start_index : String? = None
  while at < values.length() && values[at].text.has_prefix("-") {
    let option = values[at].text
    if !options.contains(option) {
      switch_error(
        "bad option \"" +
        option +
        "\": must be " +
        options[:options.length() - 1].to_owned().join(", ") +
        ", or --",
        format_list(["TCL", "LOOKUP", "INDEX", "option", option]),
      )
    }
    at += 1
    match option {
      "--" => break
      "-all" => all = true
      "-about" => about = true
      "-indices" => indices = true
      "-inline" => inline = true
      "-nocase" => nocase = true
      "-expanded" => expanded = true
      "-line" => {
        line_stop = true
        line_anchor = true
      }
      "-linestop" => line_stop = true
      "-lineanchor" => line_anchor = true
      "-start" => {
        if at == values.length() {
          break
        }
        let text = values[at].text
        ignore(re_start_index(text, 0))
        start_index = Some(text)
        at += 1
      }
      _ => ()
    }
  }
  let remaining = values.length() - at
  if (replace && (remaining < 3 || remaining > 4)) ||
    (!replace && remaining < (if about { 1 } else { 2 })) {
    switch_error(
      "wrong # args: should be \"" +
      values[0].text +
      (if replace {
        " ?-option ...? exp string subSpec ?varName?"
      } else {
        " ?-option ...? exp string ?matchVar? ?subMatchVar ...?"
      }) +
      "\"",
      "TCL WRONGARGS",
    )
  }
  if inline && remaining != 2 {
    switch_error(
      "regexp match variables not allowed when using -inline", "TCL OPERATION REGEXP MIX_VAR_INLINE",
    )
  }
  let source = values[at]
  if about {
    let pattern = re_compile(
      source.text,
      nocase,
      expanded~,
      line_stop~,
      line_anchor~,
    )
    source.payload = Plain
    return self.re_about(pattern)
  }
  let subject = values[at + 1]
  let text = subject.text
  let n = text.length()
  let offset = match start_index {
    Some(index) => re_start_index(index, n).max(0)
    None => 0
  }
  if replace {
    return self.regsub_apply(
      source,
      subject,
      values[at + 2],
      if remaining == 4 {
        Some(values[at + 3].text)
      } else {
        None
      },
      offset,
      all,
      nocase,
      expanded,
      line_stop,
      line_anchor,
    )
  }
  // Character length alone does not discard the native numeric representation.
  let pattern = re_compile(
    source.text,
    nocase,
    expanded~,
    line_stop~,
    line_anchor~,
  )
  source.payload = Plain
  subject.payload = Plain
  let mut offset = offset
  let flat = []
  let mut count = 0
  while true {
    self.tick()
    let spans = match self.regexp_find(pattern, text, offset) {
      Some(spans) => spans
      None => break
    }
    let delta = (offset - n).max(0)
    let slots = if inline { spans.length() } else { remaining - 2 }
    for i in 0..<slots {
      let value = re_capture_value(
        text,
        spans.get(i).unwrap_or((-1, -1)),
        indices,
        delta,
      )
      if inline {
        if flat.length() >= 100000 {
          raise Invalid("regexp result element limit")
        }
        flat.push(value)
      } else {
        self.re_set_value(values[at + 2 + i].text, value)
      }
    }
    count += 1
    // Stop before incrementing an out-of-range signed index.
    if !all || offset >= n {
      break
    }
    offset = spans[0].1 + delta + (if spans[0].0 == spans[0].1 { 1 } else { 0 })
    if offset >= n {
      break
    }
  }
  if inline {
    list_value(flat)
  } else {
    text_value(count.to_string())
  }
}

///|
fn Interpreter::regsub_apply(
  self : Interpreter,
  source : TclValue,
  subject : TclValue,
  substitution : TclValue,
  variable : String?,
  offset : Int,
  all : Bool,
  nocase : Bool,
  expanded : Bool,
  line_stop : Bool,
  line_anchor : Bool,
) -> TclValue raise TclError {
  let text = subject.text
  let replacement = substitution.text
  let simple = all &&
    offset == 0 &&
    !utf16_units(replacement).iter().any(c => c == '&' || c == '\\') &&
    !utf16_units(source.text)
    .iter()
    .any(c => "*+?{}()[].\\|^$".contains(c.to_string()))
  let pattern = if simple {
    None
  } else {
    Some(re_compile(source.text, nocase, expanded~, line_stop~, line_anchor~))
  }
  source.payload = Plain
  subject.payload = Plain
  substitution.payload = Plain
  let out = ReOutput::{ builder: StringBuilder(), size: 0, }
  let mut count = 0
  let mut offset = offset
  let mut copied = 0
  let n = text.length()
  if simple {
    let needle = source.text
    let width = needle.length()
    while offset < n && width <= n - offset {
      self.tick()
      let mut found = true
      for i in 0..<width {
        if (i & 127) == 0 {
          self.tick()
        }
        let a = needle.at(i).to_int()
        let b = text.at(offset + i).to_int()
        if (if nocase {
            unicode_case_unit(a, 0) != unicode_case_unit(b, 0)
          } else {
            a != b
          }) {
          found = false
          break
        }
      }
      if found {
        out.append(unit_slice(text, copied, offset))
        out.append(replacement)
        count += 1
        copied = offset + width
        offset += width.max(1)
      } else {
        offset += 1
      }
    }
  } else if pattern is Some(compiled) {
    while offset <= n {
      self.tick()
      let spans = match self.regexp_find(compiled, text, offset) {
        Some(spans) => spans
        None => break
      }
      let (start, end) = spans[0]
      out.append(unit_slice(text, copied, start))
      let mut i = 0
      while i < replacement.length() {
        if (i & 127) == 0 {
          self.tick()
        }
        let c = replacement.at(i)
        let next = if i + 1 < replacement.length() {
          replacement.at(i + 1)
        } else {
          '\u0000'
        }
        let group = if c == '&' {
          0
        } else if c == '\\' && next >= '0' && next <= '9' {
          i += 1
          next.to_int() - 48
        } else {
          -1
        }
        if group >= 0 {
          if spans.get(group) is Some((a, b)) && a >= 0 {
            out.append(unit_slice(text, a, b))
          }
        } else if c == '\\' && (next == '\\' || next == '&') {
          out.append(unit_slice(replacement, i + 1, i + 2))
          i += 1
        } else {
          out.append(unit_slice(replacement, i, i + 1))
        }
        i += 1
      }
      count += 1
      copied = end
      offset = end + (if start == end { 1 } else { 0 })
      if !all {
        break
      }
    }
  }
  let result = if count == 0 {
    subject
  } else {
    out.append(unit_slice(text, copied, n))
    text_value(out.builder.to_string())
  }
  match variable {
    Some(name) => {
      self.re_set_value(name, result)
      text_value(count.to_string())
    }
    None => result
  }
}

///|
fn re_bad_octal_index(text : String) -> Bool {
  let trimmed = text.trim().to_owned()
  let value = if trimmed.has_prefix("+") || trimmed.has_prefix("-") {
    trimmed[1:].to_owned()
  } else {
    trimmed
  }
  value.length() > 1 &&
  value.has_prefix("0") &&
  value.to_array().iter().all(c => c >= '0' && c <= '9') &&
  value.to_array().iter().any(c => c == '8' || c == '9')
}

///|
fn Interpreter::re_set_value(
  self : Interpreter,
  name : String,
  value : TclValue,
) -> Unit raise TclError {
  self.set_value(name, value) catch {
    Invalid(message) if message == "variable is not an array" ||
      message == "variable is array" => {
      let (base, _) = variable_parts(name)
      switch_error(
        "can't set \"" +
        name +
        "\": " +
        (if message == "variable is array" {
          "variable is array"
        } else {
          "variable isn't array"
        }),
        if message == "variable is array" {
          "TCL WRITE VARNAME"
        } else {
          format_list(["TCL", "LOOKUP", "VARNAME", base])
        },
      )
    }
    error => raise error
  }
}
