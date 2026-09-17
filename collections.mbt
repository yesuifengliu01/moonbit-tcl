///|
fn Interpreter::array_command(
  self : Interpreter,
  args : Array[String],
) -> String raise TclError {
  let n = args.length()
  if n < 3 {
    raise Invalid("array arity")
  }
  let op = args[1]
  let binding = self.binding(args[2], op == "set")
  let values = match binding {
    Some(b) if b.index is None =>
      match b.cell.value {
        Some(Elements(v)) => Some(v)
        _ => None
      }
    _ => None
  }
  match op {
    "exists" => {
      if n != 3 {
        raise Invalid("array exists arity")
      }
      boolean_text(values is Some(_))
    }
    "size" => {
      if n != 3 {
        raise Invalid("array size arity")
      }
      values.map(v => v.length()).unwrap_or(0).to_string()
    }
    "set" => {
      if n != 4 {
        raise Invalid("array set arity")
      }
      let pairs = parse_list(args[3])
      if pairs.length() % 2 != 0 {
        raise Invalid("array set expects pairs")
      }
      let binding = binding.unwrap()
      if binding.index is Some(_) || binding.cell.value is Some(Scalar(_)) {
        raise Invalid("variable is not array")
      }
      let values = match values {
        Some(v) => v
        None => {
          let v = Map([])
          binding.cell.value = Some(Elements(v))
          v
        }
      }
      let mut i = 0
      while i < pairs.length() {
        if values.length() >= 10000 && !values.contains(pairs[i]) {
          raise Invalid("array size limit")
        }
        values[pairs[i]] = pairs[i + 1]
        i += 2
      }
      ""
    }
    "names" | "get" => {
      let mut mode = "-glob"
      let pattern = if n == 3 {
        "*"
      } else if n == 4 {
        args[3]
      } else if n == 5 && op == "names" {
        mode = args[3]
        args[4]
      } else {
        raise Invalid("array names/get arity")
      }
      if mode != "-glob" && mode != "-exact" {
        raise Invalid("unsupported array match mode")
      }
      let values = match values {
        Some(v) => v
        None => return ""
      }
      let keys = values.keys().to_array()
      keys.sort()
      let result = []
      for key in keys {
        if (if mode == "-exact" {
            key == pattern
          } else {
            glob_match(pattern, key, false)
          }) {
          result.push(key)
          if op == "get" {
            result.push(values.get(key).unwrap())
          }
        }
      }
      format_list(result)
    }
    "unset" => {
      if n != 3 && n != 4 {
        raise Invalid("array unset arity")
      }
      if values is Some(values) {
        if n == 3 {
          self.unset_var(args[2], true)
        } else {
          for key in values.keys().to_array() {
            if glob_match(args[3], key, false) {
              values.remove(key)
            }
          }
        }
      }
      ""
    }
    _ => raise Invalid("unsupported array subcommand")
  }
}

///|
fn dictionary(text : String) -> Array[(String, String)] raise TclError {
  let words = parse_list(text)
  if words.length() % 2 != 0 {
    raise Invalid("missing dictionary value")
  }
  let result = []
  let seen : Map[String, Int] = Map([])
  let mut i = 0
  while i < words.length() {
    if seen.get(words[i]) is Some(index) {
      result[index] = (words[i], words[i + 1])
    } else {
      seen[words[i]] = result.length()
      result.push((words[i], words[i + 1]))
    }
    i += 2
  }
  result
}

///|
fn dictionary_text(pairs : Array[(String, String)]) -> String raise TclError {
  let values = []
  for (key, value) in pairs {
    values.push(key)
    values.push(value)
  }
  format_list(values)
}

///|
fn dictionary_get(text : String, path : Array[String]) -> String raise TclError {
  let mut value = text
  for key in path {
    let pairs = dictionary(value)
    let found = pairs.filter(p => p.0 == key).get(0)
    value = match found {
      Some((_, v)) => v
      None => raise Invalid("dictionary key not found")
    }
  }
  value
}

///|
fn dictionary_edit(
  text : String,
  keys : Array[String],
  value : String?,
  depth : Int,
) -> String raise TclError {
  if depth > 64 {
    raise Invalid("dictionary nesting limit")
  }
  if keys.is_empty() {
    raise Invalid("dictionary key required")
  }
  let pairs = dictionary(text)
  let mut index = -1
  for i in 0..<pairs.length() {
    if pairs[i].0 == keys[0] {
      index = i
      break
    }
  }
  let value = if keys.length() > 1 {
    if index < 0 && value is None {
      raise Invalid("dictionary path not found")
    }
    Some(
      dictionary_edit(
        if index < 0 {
          ""
        } else {
          pairs[index].1
        },
        keys[1:].to_owned(),
        value,
        depth + 1,
      ),
    )
  } else {
    value
  }
  match value {
    Some(v) =>
      if index < 0 {
        pairs.push((keys[0], v))
      } else {
        pairs[index] = (keys[0], v)
      }
    None => if index >= 0 { ignore(pairs.remove(index)) }
  }
  dictionary_text(pairs)
}

///|
fn Interpreter::dict_command(
  self : Interpreter,
  args : Array[String],
  depth : Int,
) -> String raise TclError {
  let n = args.length()
  if n < 2 {
    raise Invalid("dict arity")
  }
  match args[1] {
    "create" => dictionary_text(dictionary(format_list(args[2:].to_owned())))
    "get" => {
      if n < 3 {
        raise Invalid("dict get arity")
      }
      if n == 3 {
        dictionary_text(dictionary(args[2]))
      } else {
        dictionary_get(args[2], args[3:].to_owned())
      }
    }
    "exists" => {
      if n < 4 {
        raise Invalid("dict exists arity")
      }
      ignore(dictionary(args[2]))
      boolean_text(
        try {
          ignore(dictionary_get(args[2], args[3:].to_owned()))
          true
        } catch {
          _ => false
        },
      )
    }
    "size" => {
      if n != 3 {
        raise Invalid("dict size arity")
      }
      dictionary(args[2]).length().to_string()
    }
    "keys" | "values" => {
      if n != 3 && n != 4 {
        raise Invalid("dict keys/values arity")
      }
      let result = []
      for (key, value) in dictionary(args[2]) {
        let item = if args[1] == "keys" { key } else { value }
        if n == 3 || glob_match(args[3], item, false) {
          result.push(item)
        }
      }
      format_list(result)
    }
    "merge" => {
      let mut result = ""
      for value in args[2:] {
        for (key, value) in dictionary(value) {
          result = dictionary_edit(result, [key], Some(value), 0)
        }
      }
      result
    }
    "replace" | "remove" => {
      if n < 3 {
        raise Invalid("dict replace/remove arity")
      }
      let mut result = dictionary_text(dictionary(args[2]))
      if args[1] == "replace" {
        if (n - 3) % 2 != 0 {
          raise Invalid("dict replace expects pairs")
        }
        let mut i = 3
        while i < n {
          result = dictionary_edit(result, [args[i]], Some(args[i + 1]), 0)
          i += 2
        }
      } else {
        for key in args[3:] {
          result = dictionary_edit(result, [key], None, 0)
        }
      }
      result
    }
    "set" | "unset" => {
      if n < (if args[1] == "set" { 5 } else { 4 }) {
        raise Invalid("dict set/unset arity")
      }
      let last = if args[1] == "set" { n - 1 } else { n }
      let previous = if args[1] == "set" {
        self.get_var(args[2]).unwrap_or("")
      } else {
        self.read_var(args[2])
      }
      let result = dictionary_edit(
        previous,
        args[3:last].to_owned(),
        if args[1] == "set" {
          Some(args[n - 1])
        } else {
          None
        },
        0,
      )
      self.set_var(args[2], result)
      result
    }
    "incr" | "append" | "lappend" => {
      if n < 4 || (args[1] == "incr" && n > 5) {
        raise Invalid("dict update arity")
      }
      let previous = self.get_var(args[2]).unwrap_or("")
      ignore(dictionary(previous))
      let current = dictionary_get(previous, [args[3]]) catch { _ => "" }
      let value = if args[1] == "incr" {
        let exists = dictionary(previous).iter().any(p => p.0 == args[3])
        Whole(
          whole(if exists { current } else { "0" }) +
          whole(if n == 5 { args[4] } else { "1" }),
        ).text()
      } else if args[1] == "append" {
        current + args[4:].to_owned().join("")
      } else {
        format_list(parse_list(current) + args[4:].to_owned())
      }
      if value.length() > 1000000 {
        raise Invalid("dictionary value size")
      }
      let result = dictionary_edit(previous, [args[3]], Some(value), 0)
      self.set_var(args[2], result)
      result
    }
    "for" | "map" => {
      if n != 5 {
        raise Invalid("dict for/map arity")
      }
      let names = parse_list(args[2])
      if names.length() != 2 {
        raise Invalid("dict loop requires two variables")
      }
      let result = []
      for (key, value) in dictionary(args[3]) {
        self.tick()
        self.set_var(names[0], key)
        self.set_var(names[1], value)
        try {
          let computed = self.execute(args[4], depth + 1)
          if args[1] == "map" {
            result.push((self.read_var(names[0]), computed))
          }
        } catch {
          Continue => continue
          Break => break
          Return(v) => raise Return(v)
          Invalid(v) => raise Invalid(v)
        }
      }
      if args[1] == "map" {
        dictionary_text(dictionary(dictionary_text(result)))
      } else {
        ""
      }
    }
    "filter" => {
      if n < 5 {
        raise Invalid("dict filter arity")
      }
      let result = []
      for (key, value) in dictionary(args[2]) {
        self.tick()
        let keep = if args[3] == "key" || args[3] == "value" {
          let item = if args[3] == "key" { key } else { value }
          let mut matched = false
          for pattern in args[4:] {
            if glob_match(pattern, item, false) {
              matched = true
              break
            }
          }
          matched
        } else if args[3] == "script" && n == 6 {
          let names = parse_list(args[4])
          if names.length() != 2 {
            raise Invalid("dict filter variable list")
          }
          self.set_var(names[0], key)
          self.set_var(names[1], value)
          boolean(self.execute(args[5], depth + 1)) catch {
            Continue => continue
            Break => break
            Return(v) => raise Return(v)
            Invalid(v) => raise Invalid(v)
          }
        } else {
          raise Invalid("dict filter mode")
        }
        if keep {
          result.push((key, value))
        }
      }
      dictionary_text(result)
    }
    "update" => {
      if n < 6 || n % 2 != 0 {
        raise Invalid("dict update arity")
      }
      let original = self.read_var(args[2])
      ignore(dictionary(original))
      let mut i = 3
      while i < n - 1 {
        if (Some(dictionary_get(original, [args[i]])) catch { _ => None })
          is Some(value) {
          self.set_var(args[i + 1], value)
        } else {
          self.unset_var(args[i + 1], true)
        }
        i += 2
      }
      defer (if self.get_var(args[2]) is Some(current) {
        let mut updated = current
        let mut i = 3
        while i < n - 1 {
          updated = dictionary_edit(
            updated,
            [args[i]],
            self.get_var(args[i + 1]),
            0,
          )
          i += 2
        }
        self.set_var(args[2], updated)
      })
      self.execute(args[n - 1], depth + 1)
    }
    "with" => {
      if n < 4 {
        raise Invalid("dict with arity")
      }
      let original = self.read_var(args[2])
      let keys = args[3:n - 1].to_owned()
      let selected = dictionary_get(original, keys)
      let pairs = dictionary(selected)
      for (key, value) in pairs {
        self.set_var(key, value)
      }
      defer (if self.get_var(args[2]) is Some(current) {
        let mut updated = dictionary_get(current, keys)
        for (key, _) in pairs {
          updated = dictionary_edit(updated, [key], self.get_var(key), 0)
        }
        self.set_var(
          args[2],
          if keys.is_empty() {
            updated
          } else {
            dictionary_edit(current, keys, Some(updated), 0)
          },
        )
      })
      self.execute(args[n - 1], depth + 1)
    }
    _ => raise Invalid("unsupported dict subcommand")
  }
}
