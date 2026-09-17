///|
fn list_edit(
  text : String,
  indices : Array[String],
  replacement : String,
  depth : Int,
) -> String raise TclError {
  if depth > 64 {
    raise Invalid("nested list limit")
  }
  if indices.is_empty() {
    return replacement
  }
  let values = parse_list(text)
  let index = list_index(indices[0], values.length())
  if index < 0 || index > values.length() {
    raise Invalid("list index out of range")
  }
  if index == values.length() {
    values.push("")
  }
  values[index] = list_edit(
    values[index],
    indices[1:].to_owned(),
    replacement,
    depth + 1,
  )
  format_list(values)
}

///|
fn Interpreter::extended_list_command(
  self : Interpreter,
  args : Array[String],
  depth : Int,
) -> String raise TclError {
  let n = args.length()
  match args[0] {
    "lset" => {
      if n < 3 {
        raise Invalid("lset arity")
      }
      let indices = if n == 4 {
        parse_list(args[2])
      } else {
        args[2:n - 1].to_owned()
      }
      let result = list_edit(self.read_var(args[1]), indices, args[n - 1], 0)
      self.set_var(args[1], result)
      result
    }
    "linsert" => {
      if n < 3 {
        raise Invalid("linsert arity")
      }
      let values = parse_list(args[1])
      let index = list_index(args[2], values.length() + 1)
        .max(0)
        .min(values.length())
      format_list(
        values[:index].to_owned() +
        args[3:].to_owned() +
        values[index:].to_owned(),
      )
    }
    "lreplace" => {
      if n < 4 {
        raise Invalid("lreplace arity")
      }
      let values = parse_list(args[1])
      let first = list_index(args[2], values.length())
        .max(0)
        .min(values.length())
      let last = list_index(args[3], values.length())
        .max(first - 1)
        .min(values.length() - 1)
      format_list(
        values[:first].to_owned() +
        args[4:].to_owned() +
        values[last + 1:].to_owned(),
      )
    }
    "lsearch" => {
      let mut i = 1
      let mut exact = false
      let mut nocase = false
      let mut all = false
      let mut inline = false
      let mut negate = false
      let mut start = 0
      while i < n - 2 {
        match args[i] {
          "-exact" => exact = true
          "-glob" => exact = false
          "-nocase" => nocase = true
          "-all" => all = true
          "-inline" => inline = true
          "-not" => negate = true
          "-start" => {
            i += 1
            if i >= n - 2 {
              raise Invalid("lsearch start")
            }
            start = integer(args[i]).max(0)
          }
          _ => raise Invalid("unsupported lsearch option")
        }
        i += 1
      }
      if i != n - 2 {
        raise Invalid("lsearch arity")
      }
      let values = parse_list(args[i])
      let pattern = if nocase { args[i + 1].to_lower() } else { args[i + 1] }
      let result = []
      for j in start..<values.length() {
        let value = if nocase { values[j].to_lower() } else { values[j] }
        let matched = if exact {
          value == pattern
        } else {
          glob_match(pattern, value, false)
        }
        if matched != negate {
          let item = if inline { values[j] } else { j.to_string() }
          if !all {
            return item
          }
          result.push(item)
        }
      }
      if all {
        format_list(result)
      } else if inline {
        ""
      } else {
        "-1"
      }
    }
    "lsort" => {
      if n < 2 {
        raise Invalid("lsort arity")
      }
      let mut i = 1
      let mut mode = "-ascii"
      let mut reverse = false
      let mut nocase = false
      let mut unique = false
      let mut index : String? = None
      let mut command : String? = None
      while i < n - 1 {
        match args[i] {
          "-ascii" | "-integer" | "-real" => mode = args[i]
          "-decreasing" => reverse = true
          "-increasing" => reverse = false
          "-nocase" => nocase = true
          "-unique" => unique = true
          "-index" => {
            i += 1
            if i >= n - 1 {
              raise Invalid("lsort index")
            }
            index = Some(args[i])
          }
          "-command" => {
            i += 1
            if i >= n - 1 {
              raise Invalid("lsort command")
            }
            command = Some(args[i])
          }
          _ => raise Invalid("unsupported lsort option")
        }
        i += 1
      }
      let values = parse_list(args[n - 1])
      let key = fn(value : String) -> String raise TclError {
        let raw = match index {
          Some(index) => {
            let values = parse_list(value)
            let at = list_index(index, values.length())
            if at < 0 || at >= values.length() {
              raise Invalid("lsort index range")
            }
            values[at]
          }
          None => value
        }
        if nocase {
          raw.to_lower()
        } else {
          raw
        }
      }
      let compare = fn(a : String, b : String) -> Int raise TclError {
        self.tick()
        let a = key(a)
        let b = key(b)
        let result = if command is Some(script) {
          integer(self.command(parse_list(script) + [a, b], depth + 1))
        } else if mode == "-integer" {
          integer_compare(a, b)
        } else if mode == "-real" {
          let a = match number(a) {
            Some(n) => n.double()
            None => raise Invalid("expected real")
          }
          let b = match number(b) {
            Some(n) => n.double()
            None => raise Invalid("expected real")
          }
          if a.is_nan() || b.is_nan() {
            raise Invalid("cannot sort NaN")
          }
          if a < b {
            -1
          } else if a > b {
            1
          } else {
            0
          }
        } else {
          a.compare(b)
        }
        let sign = if result < 0 { -1 } else if result > 0 { 1 } else { 0 }
        if reverse {
          -sign
        } else {
          sign
        }
      }
      sort_strings(values, compare)
      if unique {
        let result = []
        for value in values {
          if !result.is_empty() &&
            compare(result[result.length() - 1], value) == 0 {
            result[result.length() - 1] = value
          } else {
            result.push(value)
          }
        }
        format_list(result)
      } else {
        format_list(values)
      }
    }
    _ => raise Invalid("unsupported list command")
  }
}

///|
/// Stable merge sort permits Tcl comparator errors and shared budget accounting.
fn sort_strings(
  values : Array[String],
  compare : (String, String) -> Int raise TclError,
) -> Unit raise TclError {
  let buffer = values.copy()
  let mut width = 1
  while width < values.length() {
    let mut start = 0
    while start < values.length() {
      let middle = (start + width).min(values.length())
      let end = (start + 2 * width).min(values.length())
      let mut a = start
      let mut b = middle
      let mut i = start
      while i < end {
        if b >= end || (a < middle && compare(values[a], values[b]) <= 0) {
          buffer[i] = values[a]
          a += 1
        } else {
          buffer[i] = values[b]
          b += 1
        }
        i += 1
      }
      start = end
    }
    for i in 0..<values.length() {
      values[i] = buffer[i]
    }
    width *= 2
  }
}
