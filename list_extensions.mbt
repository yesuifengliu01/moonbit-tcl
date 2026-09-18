///|
fn list_edit(
  text : TclValue,
  indices : Array[String],
  replacement : TclValue,
  depth : Int,
) -> TclValue raise TclError {
  if depth > 64 {
    raise Invalid("nested list limit")
  }
  if indices.is_empty() {
    return replacement
  }
  let values = text.as_list()
  let index = list_index(indices[0], values.length())
  if index < 0 || index > values.length() {
    raise Invalid("list index out of range")
  }
  if index == values.length() {
    values.push(text_value(""))
  }
  values[index] = list_edit(
    values[index],
    indices[1:].to_owned(),
    replacement,
    depth + 1,
  )
  list_value(values)
}

///|
fn Interpreter::extended_list_command(
  self : Interpreter,
  input : Array[TclValue],
  depth : Int,
) -> TclValue raise TclError {
  let args = input.map(v => v.text)
  let n = args.length()
  let text = match args[0] {
    "lset" => {
      if n < 3 {
        raise Invalid("lset arity")
      }
      let indices = if n == 4 {
        parse_list(args[2])
      } else {
        args[2:n - 1].to_owned()
      }
      let result = list_edit(self.read_value(args[1]), indices, input[n - 1], 0)
      self.set_value(args[1], result)
      return result
    }
    "linsert" => {
      if n < 3 {
        raise Invalid("linsert arity")
      }
      let values = input[1].as_list()
      let index = list_index(args[2], values.length() + 1)
        .max(0)
        .min(values.length())
      return list_value(
        values[:index].to_owned() +
        input[3:].to_owned() +
        values[index:].to_owned(),
      )
    }
    "lreplace" => {
      if n < 4 {
        raise Invalid("lreplace arity")
      }
      let values = input[1].as_list()
      let first = list_index(args[2], values.length())
        .max(0)
        .min(values.length())
      let last = list_index(args[3], values.length())
        .max(first - 1)
        .min(values.length() - 1)
      return list_value(
        values[:first].to_owned() +
        input[4:].to_owned() +
        values[last + 1:].to_owned(),
      )
    }
    "lsearch" => return self.lsearch_command(input)
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
          "-ascii" | "-dictionary" | "-integer" | "-real" => mode = args[i]
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
      let values = input[n - 1].as_list()
      let key = fn(value : TclValue) -> TclValue raise TclError {
        let raw = match index {
          Some(index) => {
            let values = value.as_list()
            let at = list_index(index, values.length())
            if at < 0 || at >= values.length() {
              raise Invalid("lsort index range")
            }
            values[at]
          }
          None => value
        }
        if nocase && mode != "-dictionary" {
          text_value(unicode_case(raw.text, 0))
        } else {
          raw
        }
      }
      let compare = fn(a : TclValue, b : TclValue) -> Int raise TclError {
        self.tick()
        let a = key(a)
        let b = key(b)
        let result = if command is Some(script) {
          integer(
            self.command_value(
              parse_list(script).map(text_value) + [a, b],
              depth + 1,
            ).text,
          )
        } else if mode == "-integer" {
          a.as_whole().compare(b.as_whole())
        } else if mode == "-real" {
          let a = match a.as_number() {
            Some(n) => n.double()
            None => raise Invalid("expected real")
          }
          let b = match b.as_number() {
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
        } else if mode == "-dictionary" {
          dictionary_compare(a.text, b.text)
        } else if nocase {
          tcl_string_compare(a.text, b.text)
        } else {
          collection_ascii_compare(a.text, b.text)
        }
        let sign = if result < 0 { -1 } else if result > 0 { 1 } else { 0 }
        if reverse {
          -sign
        } else {
          sign
        }
      }
      if mode == "-dictionary" && command is None {
        for value in values {
          ignore(key(value))
        }
        return list_value(dictionary_sort(values, compare, unique))
      }
      sort_values(values, compare)
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
        return list_value(result)
      } else {
        return list_value(values)
      }
    }
    _ => raise Invalid("unsupported list command")
  }
  text_value(text)
}

///|
fn sort_values(
  values : Array[TclValue],
  compare : (TclValue, TclValue) -> Int raise TclError,
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
