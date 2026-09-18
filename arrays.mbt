///|
priv struct ArrayCursor {
  mut bucket : Int
  mut entry : Int
} derive(Debug)

///|
struct ArrayObject {
  values : Map[String, TclValue]
  hashes : Map[String, Int]
  pins : Map[String, Int]
  mut alive : Bool
  mut buckets : Array[Array[String]]
  searches : Map[Int, ArrayCursor]
} derive(Debug)

///|
fn ArrayObject::new() -> ArrayObject {
  {
    values: Map([]),
    hashes: Map([]),
    pins: Map([]),
    alive: true,
    buckets: Array::makei(4, _ => []),
    searches: Map([]),
  }
}

///|
// Tcl 8.6 variable tables hash the modified UTF-8 representation, unsigned
// times-nine accumulation, with the low bits selecting a power-of-four table.
fn array_hash(key : String) -> Int {
  let mut hash = 0
  let mut i = 0
  while i < key.length() {
    let mut cp = key.get(i).unwrap().to_int()
    i += 1
    if cp >= 55296 && cp <= 56319 && i < key.length() {
      let low = key.get(i).unwrap().to_int()
      if low >= 56320 && low <= 57343 {
        cp = 65536 + (cp - 55296) * 1024 + low - 56320
        i += 1
      }
    }
    if cp > 0 && cp < 128 {
      hash = hash * 9 + cp
    } else if cp < 2048 {
      hash = (hash * 9 + (192 | (cp >> 6))) * 9 + (128 | (cp & 63))
    } else if cp < 65536 {
      hash = ((hash * 9 + (224 | (cp >> 12))) * 9 + (128 | ((cp >> 6) & 63))) *
        9 +
        (128 | (cp & 63))
    } else {
      hash = (
          ((hash * 9 + (240 | (cp >> 18))) * 9 + (128 | ((cp >> 12) & 63))) * 9 +
          (128 | ((cp >> 6) & 63))
        ) *
        9 +
        (128 | (cp & 63))
    }
  }
  hash
}

///|
fn ArrayObject::length(self : ArrayObject) -> Int {
  self.values.length()
}

///|
fn ArrayObject::contains(self : ArrayObject, key : String) -> Bool {
  self.values.contains(key)
}

///|
fn ArrayObject::get(self : ArrayObject, key : String) -> TclValue? {
  self.values.get(key)
}

///|
fn ArrayObject::ensure_key(
  self : ArrayObject,
  key : String,
) -> Unit raise TclError {
  if !self.hashes.contains(key) {
    if self.hashes.length() >= 10000 {
      raise Invalid("array size limit")
    }
    self.searches.clear()
    let hash = array_hash(key)
    self.hashes[key] = hash
    let index = hash & (self.buckets.length() - 1)
    self.buckets[index] = [key] + self.buckets[index]
    if self.hashes.length() >= self.buckets.length() * 3 {
      let buckets = Array::makei(self.buckets.length() * 4, _ => [])
      for bucket in self.buckets {
        for key in bucket {
          let index = self.hashes.get(key).unwrap() & (buckets.length() - 1)
          buckets[index] = [key] + buckets[index]
        }
      }
      self.buckets = buckets
    }
  }
}

///|
fn ArrayObject::put(
  self : ArrayObject,
  key : String,
  value : TclValue,
) -> Unit raise TclError {
  self.ensure_key(key)
  self.values[key] = value
}

///|
fn ArrayObject::cleanup_key(self : ArrayObject, key : String) -> Unit {
  if self.hashes.contains(key) &&
    !self.values.contains(key) &&
    !self.pins.contains(key) {
    let index = self.hashes.get(key).unwrap() & (self.buckets.length() - 1)
    let old = self.buckets[index]
    let mut removed = 0
    for at, candidate in old {
      if candidate == key {
        removed = at
        break
      }
    }
    self.buckets[index] = old.filter(item => item != key)
    self.hashes.remove(key)
    for cursor in self.searches.values() {
      if cursor.bucket == index && cursor.entry > removed {
        cursor.entry -= 1
      }
    }
  }
}

///|
fn ArrayObject::remove(
  self : ArrayObject,
  key : String,
  invalidate? : Bool = true,
) -> Unit {
  if self.hashes.contains(key) {
    if invalidate {
      self.searches.clear()
    }
    self.values.remove(key)
    self.cleanup_key(key)
  }
}

///|
fn ArrayObject::unpin(self : ArrayObject, key : String) -> Unit {
  let n = self.pins.get(key).unwrap_or(0)
  if n > 1 {
    self.pins[key] = n - 1
  } else {
    self.pins.remove(key)
    self.cleanup_key(key)
  }
}

///|
fn ArrayObject::destroy(self : ArrayObject) -> Unit {
  self.alive = false
  self.values.clear()
  self.hashes.clear()
  self.buckets = Array::makei(4, _ => [])
  self.searches.clear()
}

///|
fn ArrayObject::keys(self : ArrayObject) -> Array[String] {
  let keys = []
  for bucket in self.buckets {
    for key in bucket {
      if self.values.contains(key) {
        keys.push(key)
      }
    }
  }
  keys
}

///|
fn ArrayObject::statistics(self : ArrayObject) -> String {
  let counts = Array::make(11, 0)
  let mut average = 0.0
  for bucket in self.buckets {
    let n = bucket.length()
    counts[n.min(10)] += 1
    if self.hashes.length() > 0 {
      average += (n.to_double() + 1.0) *
        (n.to_double() / self.hashes.length().to_double()) /
        2.0
    }
  }
  let out = StringBuilder()
  out.write_string(
    self.hashes.length().to_string() +
    " entries in table, " +
    self.buckets.length().to_string() +
    " buckets\n",
  )
  for i in 0..<10 {
    out.write_string(
      "number of buckets with " +
      i.to_string() +
      " entries: " +
      counts[i].to_string() +
      "\n",
    )
  }
  out.write_string(
    "number of buckets with 10 or more entries: " +
    counts[10].to_string() +
    "\naverage search distance for entry: " +
    format_real(average, 'f', 1, false),
  )
  out.to_string()
}

///|
fn ArrayObject::start_search(
  self : ArrayObject,
  name : String,
) -> String raise TclError {
  if self.searches.length() >= 10000 {
    raise Invalid("array search limit")
  }
  let mut id = 1
  for key in self.searches.keys() {
    id = id.max(key + 1)
  }
  self.searches[id] = { bucket: 0, entry: 0, }
  "s-" + id.to_string() + "-" + name
}

///|
fn array_search_error(handle : String, message : String) -> Unit raise TclError {
  switch_error(message, format_list(["TCL", "LOOKUP", "ARRAYSEARCH", handle]))
}

///|
fn ArrayObject::search_id(
  self : ArrayObject,
  name : String,
  handle : String,
) -> Int raise TclError {
  let mut at = 2
  let mut valid = handle.has_prefix("s-")
  // Windows Tcl's strtoul accepts ASCII whitespace/signs and saturates at
  // ULONG_MAX (32 bits), then stores the identifier as a signed int.
  while at < handle.length() &&
        " \t\n\r\u000b\u000c".contains(unit_slice(handle, at, at + 1)) {
    at += 1
  }
  let mut negative = false
  if at < handle.length() &&
    (handle.get(at) == Some(43) || handle.get(at) == Some(45)) {
    negative = handle.get(at) == Some(45)
    at += 1
  }
  let start = at
  let mut value = 0L
  let mut overflow = false
  while at < handle.length() {
    let cp = handle.get(at).unwrap().to_int()
    if cp < 48 || cp > 57 {
      break
    }
    if value > 429496729L || (value == 429496729L && cp > 53) {
      overflow = true
    }
    if !overflow {
      value = value * 10L + (cp - 48).to_int64()
    }
    at += 1
  }
  valid = valid &&
    at > start &&
    at < handle.length() &&
    handle.get(at) == Some(45)
  if !valid {
    array_search_error(handle, "illegal search identifier \"" + handle + "\"")
  }
  if unit_slice(handle, at + 1, handle.length()) != name {
    array_search_error(
      handle,
      "search identifier \"" + handle + "\" isn't for variable \"" + name + "\"",
    )
  }
  let id = if overflow {
    -1
  } else if negative {
    -value.to_int()
  } else {
    value.to_int()
  }
  if !self.searches.contains(id) {
    array_search_error(handle, "couldn't find search \"" + handle + "\"")
  }
  id
}

///|
fn ArrayObject::search_more(self : ArrayObject, id : Int) -> Bool {
  let cursor = self.searches.get(id).unwrap()
  while cursor.bucket < self.buckets.length() {
    while cursor.entry < self.buckets[cursor.bucket].length() {
      if self.values.contains(self.buckets[cursor.bucket][cursor.entry]) {
        return true
      }
      cursor.entry += 1
    }
    cursor.bucket += 1
    cursor.entry = 0
  }
  false
}

///|
fn ArrayObject::search_next(self : ArrayObject, id : Int) -> String {
  if !self.search_more(id) {
    return ""
  }
  let cursor = self.searches.get(id).unwrap()
  let key = self.buckets[cursor.bucket][cursor.entry]
  cursor.entry += 1
  key
}

///|
fn Interpreter::array_command(
  self : Interpreter,
  input : Array[TclValue],
) -> TclValue raise TclError {
  let n = input.length()
  if n < 2 {
    switch_error(
      "wrong # args: should be \"" + input[0].text + " subcommand ?arg ...?\"",
      "TCL WRONGARGS",
    )
  }
  let choices = [
    "anymore", "donesearch", "exists", "get", "names", "nextelement", "set", "size",
    "startsearch", "statistics", "unset",
  ]
  let op = select_keyword(input[1].text, choices) catch {
    _ => {
      switch_error(
        "unknown or ambiguous subcommand \"" +
        input[1].text +
        "\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset",
        format_list(["TCL", "LOOKUP", "SUBCOMMAND", input[1].text]),
      )
      ""
    }
  }
  let suffix = match op {
    "set" => "arrayName list"
    "get" | "unset" => "arrayName ?pattern?"
    "names" => "arrayName ?mode? ?pattern?"
    "anymore" | "nextelement" | "donesearch" => "arrayName searchId"
    _ => "arrayName"
  }
  let correct_arity = match op {
    "set" | "anymore" | "nextelement" | "donesearch" => n == 4
    "get" | "unset" => n == 3 || n == 4
    "names" => n >= 3 && n <= 5
    _ => n == 3
  }
  if !correct_arity {
    switch_error(
      "wrong # args: should be \"" +
      input[0].text +
      " " +
      op +
      " " +
      suffix +
      "\"",
      "TCL WRONGARGS",
    )
  }
  let name = input[2].text
  let binding = self.binding(name, op == "set") catch {
    _ => {
      if op == "set" {
        switch_error(
          "can't set \"" +
          name +
          "\": " +
          (if !self.state.namespaces.contains(
              namespace_parent(
                qualified_name(
                  self.frame.namespace_name,
                  variable_parts(name).0,
                ),
              ),
            ) {
            "parent namespace doesn't exist"
          } else {
            "variable isn't array"
          }),
          format_list(["TCL", "LOOKUP", "VARNAME", name]),
        )
      }
      None
    }
  }
  let values = match binding {
    Some(b) if b.index is None =>
      match b.cell.value {
        Some(Elements(v)) => Some(v)
        _ => None
      }
    _ => None
  }
  let text = match op {
    "exists" => boolean_text(values is Some(_))
    "size" => values.map(v => v.length()).unwrap_or(0).to_string()
    "set" => {
      let binding = binding.unwrap()
      if binding.index is Some(_) {
        // Native lookup creates an empty containing array even when array set
        // subsequently rejects the element as its destination.
        if binding.cell.value is None {
          binding.cell.value = Some(Elements(ArrayObject::new()))
        }
        switch_error(
          "can't set \"" + name + "\": variable isn't array",
          format_list([
            "TCL",
            "LOOKUP",
            "VARNAME",
            if binding.cell.value is Some(Elements(_)) {
              name
            } else {
              variable_parts(name).0
            },
          ]),
        )
      }
      let pairs = input[3].collection_list()
      if pairs.length() % 2 != 0 {
        switch_error(
          "list must have an even number of elements", "TCL ARGUMENT FORMAT",
        )
      }
      if binding.cell.value is Some(_) && values is None {
        if pairs.is_empty() {
          switch_error(
            "can't array set \"" + name + "\": variable isn't array",
            "TCL WRITE ARRAY",
          )
        } else {
          switch_error(
            "can't set \"" +
            name +
            "(" +
            pairs[0].text +
            ")\": variable isn't array",
            format_list(["TCL", "LOOKUP", "VARNAME", name]),
          )
        }
      }
      let values = match values {
        Some(v) => v
        None => {
          let v = ArrayObject::new()
          binding.cell.value = Some(Elements(v))
          v
        }
      }
      for i = 0; i < pairs.length(); i = i + 2 {
        self.tick()
        if values.length() >= 10000 && !values.contains(pairs[i].text) {
          raise Invalid("array size limit")
        }
        values.put(pairs[i].text, pairs[i + 1])
      }
      ""
    }
    "names" | "get" => {
      let mode = if n == 5 {
        collection_option(input[3].text, ["-exact", "-glob", "-regexp"])
      } else {
        "-glob"
      }
      let pattern = if n == 3 { "*" } else { input[n - 1].text }
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
      let result = []
      for key in values.keys() {
        self.tick()
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
      return if op == "get" {
        dictionary_value(
          Array::makei(result.length() / 2, i => {
            (result[i * 2], result[i * 2 + 1])
          }),
        )
      } else {
        list_value(result)
      }
    }
    "unset" => {
      if values is Some(values) {
        if n == 3 {
          self.unset_var(name, true)
        } else {
          for key in values.keys() {
            self.tick()
            if glob_match(input[3].text, key, false, codepoints=true) {
              values.remove(key)
            }
          }
        }
      }
      ""
    }
    _ => {
      let values = match values {
        Some(values) => values
        None => {
          switch_error(
            "\"" + name + "\" isn't an array",
            format_list(["TCL", "LOOKUP", "ARRAY", name]),
          )
          ArrayObject::new()
        }
      }
      if op == "startsearch" {
        values.start_search(name)
      } else if op == "statistics" {
        values.statistics()
      } else {
        let id = values.search_id(name, input[3].text)
        if op == "anymore" {
          boolean_text(values.search_more(id))
        } else if op == "nextelement" {
          values.search_next(id)
        } else {
          values.searches.remove(id)
          ""
        }
      }
    }
  }
  text_value(text)
}
