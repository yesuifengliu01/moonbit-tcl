///|
priv struct SearchIndex {
  relative : Bool
  value : Int
}

///|
fn collection_option(
  value : String,
  choices : Array[String],
) -> String raise TclError {
  if choices.contains(value) {
    return value
  }
  let candidates = choices.filter(choice => choice.has_prefix(value))
  if candidates.length() == 1 {
    return candidates[0]
  }
  switch_error(
    (if candidates.is_empty() { "bad" } else { "ambiguous" }) +
    " option \"" +
    value +
    "\": must be " +
    choices[:choices.length() - 1].to_owned().join(", ") +
    ", or " +
    choices[choices.length() - 1],
    format_list(["TCL", "LOOKUP", "INDEX", "option", value]),
  )
  ""
}

///|
fn search_indices(value : TclValue) -> Array[SearchIndex] raise TclError {
  value
  .as_list()
  .map(index => {
    let relative = index.text.has_prefix("end")
    let value = re_start_index(index.text, 0)
    if (relative && (value > 0 || value <= -2147483647)) ||
      (!relative && (value < 0 || value >= 2147483647)) {
      switch_error(
        "index \"" + index.text + "\" cannot select an element from any list",
        "TCL VALUE INDEXOUTOFRANGE",
      )
    }
    { relative, value, }
  })
}

///|
fn search_key(
  value : TclValue,
  indices : Array[SearchIndex],
) -> TclValue raise TclError {
  let mut value = value
  for index in indices {
    let values = value.as_list()
    let at = if index.relative {
      values.length() - 1 + index.value
    } else {
      index.value
    }
    if at < 0 || at >= values.length() {
      switch_error(
        "element " +
        at.to_string() +
        " missing from sublist \"" +
        value.text +
        "\"",
        "TCL OPERATION LSORT INDEXFAILED",
      )
    }
    value = values[at]
  }
  value
}

///|
fn search_wide(value : TclValue) -> Int64 raise TclError {
  let n = value.as_whole() catch {
    _ => {
      switch_error(
        "expected integer but got \"" + value.text + "\"",
        if value.payload is Numeric(Real(_)) {
          "TCL VALUE INTEGER"
        } else {
          "TCL VALUE NUMBER"
        },
      )
      0N
    }
  }
  if n < -18446744073709551615N || n > 18446744073709551615N {
    switch_error(
      "integer value too large to represent", "ARITH IOVERFLOW {integer value too large to represent}",
    )
  }
  value.payload = Numeric(Whole(n))
  n.to_int64()
}

///|
fn search_real(value : TclValue) -> Double raise TclError {
  let n = match value.as_number() {
    Some(n) => n.double()
    None => {
      switch_error(
        "expected floating-point number but got \"" +
        value.text +
        "\"" +
        (if re_bad_octal_index(value.text) {
          " (looks like invalid octal number)"
        } else {
          ""
        }),
        "TCL VALUE NUMBER",
      )
      0.0
    }
  }
  if n.is_nan() {
    switch_error("floating point value is Not a Number", "TCL VALUE DOUBLE NAN")
  }
  n
}

///|
// Dictionary and case-sensitive sorted searches decode paired UTF-16 units.
// Simple case conversion itself remains the pinned Tcl 8.6 BMP mapping.
fn collection_codepoint(text : String, at : Int) -> (Int, Int) {
  let first = text.at(at).to_int()
  if first >= 55296 && first <= 56319 && at + 1 < text.length() {
    let second = text.at(at + 1).to_int()
    if second >= 56320 && second <= 57343 {
      return (65536 + (first - 55296) * 1024 + second - 56320, at + 2)
    }
  }
  (first, at + 1)
}

///|
fn collection_codepoints(text : String) -> Array[Char] {
  let result = []
  let mut at = 0
  while at < text.length() {
    let (cp, next) = collection_codepoint(text, at)
    result.push(cp.unsafe_to_char())
    at = next
  }
  result
}

///|
// Tcl's no-capture regexp entry can use a restricted glob equivalent. Keep
// the original source restrictions: embedded flags and general groups do
// not qualify, and more than one internal star disables the shortcut.
fn search_regexp_glob(source : String) -> String? {
  let out = StringBuilder()
  let mut at = 0
  if source.has_prefix("***=") {
    out.write_char('*')
    for c in utf16_units(source[4:].to_owned()) {
      if c == '\\' || c == '*' || c == '[' || c == ']' || c == '?' {
        out.write_char('\\')
      }
      out.write_char(c)
    }
    out.write_char('*')
    return Some(out.to_string())
  }
  let mut last_star = false
  let mut stars = 0
  let mut right = false
  if source.has_prefix("^") {
    at = 1
  } else {
    out.write_char('*')
    last_star = true
  }
  while at < source.length() {
    let c = source.at(at).to_int().unsafe_to_char()
    at += 1
    if c == '\\' {
      if at == source.length() {
        return None
      }
      let c = source.at(at).to_int().unsafe_to_char()
      at += 1
      match c {
        'a' => out.write_char((7).unsafe_to_char())
        'b' => out.write_char((8).unsafe_to_char())
        'f' => out.write_char((12).unsafe_to_char())
        'n' => out.write_char('\n')
        'r' => out.write_char('\r')
        't' => out.write_char('\t')
        'v' => out.write_char((11).unsafe_to_char())
        'B' | '\\' => out.write_string("\\\\")
        '*' | '[' | ']' | '?' => {
          out.write_char('\\')
          out.write_char(c)
        }
        '{' | '}' | '(' | ')' | '+' | '.' | '|' | '^' | '$' => out.write_char(c)
        _ => return None
      }
    } else if c == '.' {
      if at < source.length() && source.at(at) == '*' {
        at += 1
        if !last_star {
          out.write_char('*')
          stars += 1
          last_star = true
        }
        continue
      } else if at < source.length() && source.at(at) == '+' {
        at += 1
        out.write_string("?*")
        stars += 1
        last_star = true
        continue
      }
      out.write_char('?')
    } else if c == '$' {
      if at != source.length() {
        return None
      }
      right = true
    } else if "*+?|^{}()[]".contains(c.to_string()) {
      return None
    } else {
      out.write_char(c)
    }
    last_star = false
  }
  if stars > 1 {
    return None
  }
  if !right && !last_star {
    out.write_char('*')
  }
  Some(out.to_string())
}

///|
fn dictionary_sort(
  values : Array[TclValue],
  compare : (TclValue, TclValue) -> Int raise TclError,
  unique : Bool,
) -> Array[TclValue] raise TclError {
  let merge = fn(
    left : Array[TclValue],
    right : Array[TclValue],
  ) -> Array[TclValue] raise TclError {
    let out = []
    let mut i = 0
    let mut j = 0
    while i < left.length() && j < right.length() {
      let order = compare(left[i], right[j])
      if order > 0 || (order == 0 && unique) {
        if order == 0 {
          i += 1
        }
        out.push(right[j])
        j += 1
      } else {
        out.push(left[i])
        i += 1
      }
    }
    out + left[i:].to_owned() + right[j:].to_owned()
  }
  let runs : Array[Array[TclValue]?] = []
  for value in values {
    let mut run = [value]
    let mut at = 0
    while at < runs.length() {
      match runs[at] {
        Some(left) => {
          run = merge(left, run)
          runs[at] = None
          at += 1
        }
        None => break
      }
    }
    if at == runs.length() {
      runs.push(Some(run))
    } else {
      runs[at] = Some(run)
    }
  }
  let mut result = []
  for run in runs {
    if run is Some(left) {
      result = merge(left, result)
    }
  }
  result
}

///|
fn collection_ascii_compare(a : String, b : String) -> Int {
  let mut i = 0
  let mut j = 0
  while i < a.length() && j < b.length() {
    let (x, next_i) = collection_codepoint(a, i)
    let (y, next_j) = collection_codepoint(b, j)
    // Modified UTF-8 encodes NUL after ASCII and before U+0080.
    let x = if x == 0 { 128 } else if x >= 128 { x + 1 } else { x }
    let y = if y == 0 { 128 } else if y >= 128 { y + 1 } else { y }
    if x != y {
      return x - y
    }
    i = next_i
    j = next_j
  }
  (a.length() - i).compare(b.length() - j)
}

///|
fn collection_digit(text : String, at : Int) -> Bool {
  at < text.length() && text.at(at) >= '0' && text.at(at) <= '9'
}

///|
fn dictionary_compare(a : String, b : String) -> Int {
  let mut i = 0
  let mut j = 0
  let mut secondary = 0
  while i < a.length() && j < b.length() {
    if collection_digit(a, i) && collection_digit(b, j) {
      let mut zeros = 0
      while a.at(i) == '0' && collection_digit(a, i + 1) {
        i += 1
        zeros += 1
      }
      while b.at(j) == '0' && collection_digit(b, j + 1) {
        j += 1
        zeros -= 1
      }
      if secondary == 0 {
        secondary = zeros
      }
      let mut digits = 0
      while collection_digit(a, i) && collection_digit(b, j) {
        if digits == 0 {
          digits = a.at(i).to_int() - b.at(j).to_int()
        }
        i += 1
        j += 1
      }
      if collection_digit(a, i) {
        return 1
      }
      if collection_digit(b, j) {
        return -1
      }
      if digits != 0 {
        return digits
      }
    } else {
      let (x, next_i) = collection_codepoint(a, i)
      let (y, next_j) = collection_codepoint(b, j)
      let difference = unicode_case_unit(x, 0) - unicode_case_unit(y, 0)
      if difference != 0 {
        return difference
      }
      if secondary == 0 {
        if (unicode_mask(x) & 1024) != 0 && (unicode_mask(y) & 64) != 0 {
          secondary = -1
        } else if (unicode_mask(y) & 1024) != 0 && (unicode_mask(x) & 64) != 0 {
          secondary = 1
        }
      }
      i = next_i
      j = next_j
    }
  }
  if i < a.length() {
    1
  } else if j < b.length() {
    -1
  } else {
    secondary
  }
}

///|
fn search_result_index(
  at : Int,
  indices : Array[SearchIndex],
  subindices : Bool,
  length : Int,
) -> TclValue raise TclError {
  let result = text_value(at.to_string())
  if !subindices {
    return result
  }
  // Tcl 8.6.15 formats end-relative subindices against the outer length.
  list_value(
    [result] +
    indices.map(index => {
      text_value(
        (if index.relative { length + index.value } else { index.value }).to_string(),
      )
    }),
  )
}

///|
fn Interpreter::lsearch_command(
  self : Interpreter,
  input : Array[TclValue],
) -> TclValue raise TclError {
  let n = input.length()
  if n < 3 {
    switch_error(
      "wrong # args: should be \"lsearch ?-option value ...? list pattern\"", "TCL WRONGARGS",
    )
  }
  let options = [
    "-all", "-ascii", "-bisect", "-decreasing", "-dictionary", "-exact", "-glob",
    "-increasing", "-index", "-inline", "-integer", "-nocase", "-not", "-real", "-regexp",
    "-sorted", "-start", "-subindices",
  ]
  let mut mode = "-glob"
  let mut datatype = "-ascii"
  let mut all = false
  let mut inline = false
  let mut negate = false
  let mut nocase = false
  let mut decreasing = false
  let mut bisect = false
  let mut subindices = false
  let mut indices : Array[SearchIndex] = []
  let mut start : String? = None
  let mut at = 1
  while at < n - 2 {
    let option = collection_option(input[at].text, options)
    at += 1
    match option {
      "-all" => all = true
      "-inline" => inline = true
      "-not" => negate = true
      "-nocase" => nocase = true
      "-subindices" => subindices = true
      "-decreasing" => decreasing = true
      "-increasing" => decreasing = false
      "-bisect" => {
        bisect = true
        mode = "-sorted"
      }
      "-exact" | "-glob" | "-regexp" | "-sorted" => mode = option
      "-ascii" | "-dictionary" | "-integer" | "-real" => datatype = option
      "-start" | "-index" => {
        if at >= n - 2 {
          switch_error(
            if option == "-start" {
              "missing starting index"
            } else {
              "\"-index\" option must be followed by list index"
            },
            "TCL ARGUMENT MISSING",
          )
        }
        if option == "-start" {
          start = Some(input[at].text)
        } else {
          indices = search_indices(input[at])
        }
        at += 1
      }
      _ => ()
    }
  }
  if subindices && indices.is_empty() {
    switch_error(
      "-subindices cannot be used without -index option", "TCL OPERATION LSEARCH BAD_OPTION_MIX",
    )
  }
  if bisect && (all || negate) {
    switch_error(
      "-bisect is not compatible with -all or -not", "TCL OPERATION LSEARCH BAD_OPTION_MIX",
    )
  }
  let pattern = input[n - 1]
  let compiled = if mode == "-regexp" {
    let compiled = re_compile(pattern.text, nocase)
    pattern.payload = Plain
    Some(compiled)
  } else {
    None
  }
  let fast_glob = if compiled is Some(_) {
    search_regexp_glob(pattern.text)
  } else {
    None
  }
  let values = input[n - 2].as_list()
  let offset = match start {
    Some(start) => re_start_index(start, values.length() - 1).max(0)
    None => 0
  }
  if start is Some(_) && offset >= values.length() {
    return text_value(if all || inline { "" } else { "-1" })
  }
  let numeric = mode == "-exact" || mode == "-sorted"
  let wide = if numeric && datatype == "-integer" {
    search_wide(pattern)
  } else {
    0L
  }
  let real = if numeric && datatype == "-real" {
    search_real(pattern)
  } else {
    0.0
  }
  let folded = if nocase { unicode_case(pattern.text, 0) } else { pattern.text }
  let compare = fn(value : TclValue) -> Int raise TclError {
    if datatype == "-integer" {
      wide.compare(search_wide(value))
    } else if datatype == "-real" {
      let value = search_real(value)
      if real < value {
        -1
      } else if real > value {
        1
      } else {
        0
      }
    } else if datatype == "-dictionary" {
      dictionary_compare(pattern.text, value.text)
    } else if nocase {
      tcl_string_compare(folded, unicode_case(value.text, 0))
    } else {
      collection_ascii_compare(pattern.text, value.text)
    }
  }
  let mut found = -1
  if mode == "-sorted" && !all && !negate {
    let mut lower = offset - 1
    let mut upper = values.length()
    while lower + 1 < upper {
      self.tick()
      let i = lower + (upper - lower) / 2
      let order = compare(search_key(values[i], indices))
      if order == 0 {
        found = i
        if bisect {
          lower = i
        } else {
          upper = i
        }
      } else if (order > 0) != decreasing {
        lower = i
      } else {
        upper = i
      }
    }
    if bisect && found < 0 {
      found = lower
    }
  } else {
    let results = []
    for i in offset..<values.length() {
      self.tick()
      let key = search_key(values[i], indices)
      let matched = if fast_glob is Some(glob) {
        glob_match(glob, key.text, nocase, codepoints=!(key.payload is Plain))
      } else if compiled is Some(compiled) {
        key.payload = Plain
        self.regexp_find(compiled, key.text, 0) is Some(_)
      } else if mode == "-glob" {
        glob_match(pattern.text, key.text, nocase, codepoints=true)
      } else {
        compare(key) == 0 &&
        (
          datatype != "-ascii" ||
          tcl_utf8_length(pattern.text) == tcl_utf8_length(key.text)
        )
      }
      if matched != negate {
        if !all {
          found = i
          break
        }
        results.push(
          if inline {
            if subindices {
              key
            } else {
              values[i]
            }
          } else {
            search_result_index(i, indices, subindices, values.length())
          },
        )
      }
    }
    if all {
      return list_value(results)
    }
  }
  if inline {
    if found >= 0 {
      values[found]
    } else {
      text_value("")
    }
  } else {
    search_result_index(found, indices, subindices, values.length())
  }
}
