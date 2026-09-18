///|
fn Interpreter::array_command(
  self : Interpreter,
  input : Array[TclValue],
) -> TclValue raise TclError {
  let args = input.map(v => v.text)
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
  let text = match op {
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
      let pairs = input[3].as_list()
      if pairs.length() % 2 != 0 {
        raise Invalid("array set expects pairs")
      }
      let binding = binding.unwrap()
      if binding.index is Some(_) ||
        (binding.cell.value is Some(_) && values is None) {
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
        if values.length() >= 10000 && !values.contains(pairs[i].text) {
          raise Invalid("array size limit")
        }
        values[pairs[i].text] = pairs[i + 1]
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
        mode = collection_option(args[3], ["-exact", "-glob", "-regexp"])
        args[4]
      } else {
        raise Invalid("array names/get arity")
      }
      let values = match values {
        Some(v) => v
        None => return text_value("")
      }
      let compiled = if mode == "-regexp" && values.length() > 0 {
        let compiled = re_compile(pattern, false)
        input[n - 1].payload = Plain
        Some(compiled)
      } else {
        None
      }
      let keys = values.keys().to_array()
      keys.sort()
      let result = []
      for key in keys {
        if (if mode == "-exact" {
            key == pattern
          } else if compiled is Some(compiled) {
            self.regexp_find(compiled, key, 0) is Some(_)
          } else {
            glob_match(pattern, key, false, codepoints=true)
          }) {
          result.push(text_value(key))
          if op == "get" {
            result.push(values.get(key).unwrap())
          }
        }
      }
      return list_value(result)
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
  text_value(text)
}

///|
fn Interpreter::dict_command(
  self : Interpreter,
  input : Array[TclValue],
  depth : Int,
  discard_result? : Bool = false,
  object_path? : Bool = true,
) -> TclValue raise TclError {
  let args = input.map(v => v.text)
  let n = args.length()
  if n < 2 {
    raise Invalid("dict arity")
  }
  if object_path &&
    (
      (args[1] == "set" && n == 5) ||
      (args[1] == "incr" && (n == 4 || n == 5)) ||
      (["append", "lappend"].contains(args[1]) && n >= 4)
    ) {
    return self.update_dictionary(input, depth, discard_result)
  }
  let text = match args[1] {
    "create" =>
      return dictionary_value(
        dictionary_values(list_value(input[2:].to_owned())),
      )
    "get" => {
      if n < 3 {
        raise Invalid("dict get arity")
      }
      if n == 3 {
        return dictionary_value(dictionary_values(input[2]))
      } else {
        return dictionary_get_value(input[2], input[3:].to_owned())
      }
    }
    "exists" => {
      if n < 4 {
        raise Invalid("dict exists arity")
      }
      ignore(dictionary_values(input[2]))
      boolean_text(
        try {
          ignore(dictionary_get_value(input[2], input[3:].to_owned()))
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
      dictionary_values(input[2]).length().to_string()
    }
    "keys" | "values" => {
      if n != 3 && n != 4 {
        raise Invalid("dict keys/values arity")
      }
      let result = []
      for (key, value) in dictionary_values(input[2]) {
        let item = if args[1] == "keys" { key } else { value }
        if n == 3 || glob_match(args[3], item.text, false) {
          result.push(item)
        }
      }
      return list_value(result)
    }
    "merge" => {
      let mut result = text_value("")
      for value in input[2:] {
        for (key, value) in dictionary_values(value) {
          result = dictionary_edit_value(result, [key], Some(value), 0)
        }
      }
      return result
    }
    "replace" | "remove" => {
      if n < 3 {
        raise Invalid("dict replace/remove arity")
      }
      let mut result = dictionary_value(dictionary_values(input[2]))
      if args[1] == "replace" {
        if (n - 3) % 2 != 0 {
          raise Invalid("dict replace expects pairs")
        }
        let mut i = 3
        while i < n {
          result = dictionary_edit_value(
            result,
            [input[i]],
            Some(input[i + 1]),
            0,
          )
          i += 2
        }
      } else {
        for key in input[3:] {
          result = dictionary_edit_value(result, [key], None, 0)
        }
      }
      return result
    }
    "set" | "unset" => {
      if n < (if args[1] == "set" { 5 } else { 4 }) {
        raise Invalid("dict set/unset arity")
      }
      let last = if args[1] == "set" { n - 1 } else { n }
      let previous = if args[1] == "set" {
        self.get_value(args[2]).unwrap_or(text_value(""))
      } else {
        self.read_value(args[2])
      }
      let result = dictionary_edit_value(
        previous,
        input[3:last].to_owned(),
        if args[1] == "set" {
          Some(input[n - 1])
        } else {
          None
        },
        0,
      )
      self.set_value(args[2], result)
      return result
    }
    "incr" | "append" | "lappend" => {
      if n < 4 || (args[1] == "incr" && n > 5) {
        raise Invalid("dict update arity")
      }
      let previous = self.get_value(args[2]).unwrap_or(text_value(""))
      ignore(dictionary_values(previous))
      let current = dictionary_get_value(previous, [input[3]]) catch {
        _ => text_value("")
      }
      let value = if args[1] == "incr" {
        let exists = dictionary_values(previous)
          .iter()
          .any(p => p.0.text == args[3])
        text_value(
          integer_add(
            if exists {
              current.text
            } else {
              "0"
            },
            if n == 5 {
              args[4]
            } else {
              "1"
            },
          ),
        )
      } else if args[1] == "append" {
        text_value(current.text + args[4:].to_owned().join(""))
      } else {
        list_value(current.as_list() + input[4:].to_owned())
      }
      if value.text.length() > 1000000 {
        raise Invalid("dictionary value size")
      }
      let result = dictionary_edit_value(previous, [input[3]], Some(value), 0)
      self.set_value(args[2], result)
      return result
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
      for (key, value) in dictionary_values(input[3]) {
        self.tick()
        self.set_value(names[0], key)
        self.set_value(names[1], value)
        try {
          let computed = self.execute_value_script(input[4], depth + 1)
          if args[1] == "map" {
            result.push((self.read_value(names[0]), computed))
          }
        } catch {
          Continue => continue
          Break => break
          Signal(result) if result.actual_code() == 4 => continue
          Signal(result) if result.actual_code() == 3 => break
          error => raise error
        }
      }
      if args[1] == "map" {
        return dictionary_value(dictionary_values(dictionary_value(result)))
      } else {
        ""
      }
    }
    "filter" => {
      if n < 5 {
        raise Invalid("dict filter arity")
      }
      let result = []
      for (key, value) in dictionary_values(input[2]) {
        self.tick()
        let keep = if args[3] == "key" || args[3] == "value" {
          let item = if args[3] == "key" { key } else { value }
          let mut matched = false
          for pattern in args[4:] {
            if glob_match(pattern, item.text, false) {
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
          self.set_value(names[0], key)
          self.set_value(names[1], value)
          self.execute_value_script(input[5], depth + 1).truth() catch {
            Continue => continue
            Break => break
            Signal(result) if result.actual_code() == 4 => continue
            Signal(result) if result.actual_code() == 3 => break
            error => raise error
          }
        } else {
          raise Invalid("dict filter mode")
        }
        if keep {
          result.push((key, value))
        }
      }
      return dictionary_value(result)
    }
    "update" => {
      if n < 6 || n % 2 != 0 {
        raise Invalid("dict update arity")
      }
      let original = self.read_value(args[2])
      ignore(dictionary_values(original))
      let mut i = 3
      while i < n - 1 {
        if (Some(dictionary_get_value(original, [input[i]])) catch {
            _ => None
          })
          is Some(value) {
          self.set_value(args[i + 1], value)
        } else {
          self.unset_var(args[i + 1], true)
        }
        i += 2
      }
      defer (if self.get_value(args[2]) is Some(current) {
        let mut updated = current
        let mut i = 3
        while i < n - 1 {
          updated = dictionary_edit_value(
            updated,
            [input[i]],
            self.get_value(args[i + 1]),
            0,
          )
          i += 2
        }
        self.set_value(args[2], updated)
      })
      return self.execute_value_script(input[n - 1], depth + 1)
    }
    "with" => {
      if n < 4 {
        raise Invalid("dict with arity")
      }
      let original = self.read_value(args[2])
      let keys = input[3:n - 1].to_owned()
      let selected = dictionary_get_value(original, keys)
      let pairs = dictionary_values(selected)
      for (key, value) in pairs {
        self.set_value(key.text, value)
      }
      defer (if self.get_value(args[2]) is Some(current) {
        let mut updated = dictionary_get_value(current, keys)
        for (key, _) in pairs {
          updated = dictionary_edit_value(
            updated,
            [key],
            self.get_value(key.text),
            0,
          )
        }
        self.set_value(
          args[2],
          if keys.is_empty() {
            updated
          } else {
            dictionary_edit_value(current, keys, Some(updated), 0)
          },
        )
      })
      return self.execute_value_script(input[n - 1], depth + 1)
    }
    _ => raise Invalid("unsupported dict subcommand")
  }
  text_value(text)
}

///|
fn dictionary_values(
  text : TclValue,
) -> Array[(TclValue, TclValue)] raise TclError {
  if text.payload is Pairs(pairs) {
    return pairs.copy()
  }
  let words = text.as_list()
  if words.length() % 2 != 0 {
    raise Invalid("missing dictionary value")
  }
  let result = []
  let seen : Map[String, Int] = Map([])
  let mut i = 0
  while i < words.length() {
    if seen.get(words[i].text) is Some(index) {
      result[index] = (result[index].0, words[i + 1])
    } else {
      seen[words[i].text] = result.length()
      result.push((words[i], words[i + 1]))
    }
    i += 2
  }
  text.payload = Pairs(result.copy())
  result
}

///|
fn dictionary_value(
  pairs : Array[(TclValue, TclValue)],
) -> TclValue raise TclError {
  let values = []
  for (key, value) in pairs {
    values.push(key)
    values.push(value)
  }
  { text: format_list(values.map(v => v.text)), payload: Pairs(pairs.copy()), }
}

///|
fn dictionary_get_value(
  text : TclValue,
  path : Array[TclValue],
) -> TclValue raise TclError {
  let mut value = text
  for key in path {
    let pairs = dictionary_values(value)
    let found = pairs.filter(p => p.0.text == key.text).get(0)
    value = match found {
      Some((_, v)) => v
      None => raise Invalid("dictionary key not found")
    }
  }
  value
}

///|
fn dictionary_edit_value(
  text : TclValue,
  keys : Array[TclValue],
  value : TclValue?,
  depth : Int,
) -> TclValue raise TclError {
  if depth > 64 {
    raise Invalid("dictionary nesting limit")
  }
  if keys.is_empty() {
    raise Invalid("dictionary key required")
  }
  let pairs = dictionary_values(text)
  let mut index = -1
  for i in 0..<pairs.length() {
    if pairs[i].0.text == keys[0].text {
      index = i
      break
    }
  }
  let value = if keys.length() > 1 {
    if index < 0 && value is None {
      raise Invalid("dictionary path not found")
    }
    Some(
      dictionary_edit_value(
        if index < 0 {
          text_value("")
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
        pairs[index] = (pairs[index].0, v)
      }
    None => if index >= 0 { ignore(pairs.remove(index)) }
  }
  dictionary_value(pairs)
}

///|
