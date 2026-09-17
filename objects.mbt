///|
struct ListObject {
  values : Array[String]
  encoded : Array[String]
  mut units : Int
  mut representation : String?
} derive(Debug)

///|
fn ListObject::from_text(text : String) -> ListObject raise TclError {
  let object = ListObject::{
    values: [],
    encoded: [],
    units: 0,
    representation: Some(text),
  }
  object.append(parse_list(text))
  object.representation = Some(text)
  object
}

///|
fn ListObject::append(
  self : ListObject,
  items : Array[String],
) -> Unit raise TclError {
  if items.is_empty() {
    return
  }
  if self.values.length() + items.length() > 100000 {
    raise Invalid("list element limit")
  }
  let encoded = []
  let mut units = self.units
  for i in 0..<items.length() {
    let text = quote_element(items[i], self.values.is_empty() && i == 0)
    units += text.length() +
      (if self.values.is_empty() && i == 0 { 0 } else { 1 })
    if units > 1000000 {
      raise Invalid("list size limit")
    }
    encoded.push(text)
  }
  for item in items {
    self.values.push(item)
  }
  for text in encoded {
    self.encoded.push(text)
  }
  self.units = units
  self.representation = None
}

///|
fn ListObject::text(self : ListObject) -> String {
  match self.representation {
    Some(text) => text
    None => {
      let text = self.encoded.join(" ")
      self.representation = Some(text)
      text
    }
  }
}

///|
struct DictObject {
  keys : Array[String]
  values : Array[String]
  index : Map[String, Int]
  encoded : Array[String]
  mut units : Int
  mut representation : String?
} derive(Debug)

///|
fn DictObject::from_text(text : String) -> DictObject raise TclError {
  let object = DictObject::{
    keys: [],
    values: [],
    index: Map([]),
    encoded: [],
    units: 0,
    representation: Some(text),
  }
  for (key, value) in dictionary(text) {
    object.put(key, value)
  }
  object.representation = Some(text)
  object
}

///|
fn DictObject::get(self : DictObject, key : String) -> String? {
  self.index.get(key).map(i => self.values[i])
}

///|
fn DictObject::put(
  self : DictObject,
  key : String,
  value : String,
) -> Unit raise TclError {
  let index = self.index.get(key)
  let encoded = quote_element(value, false)
  let (units, encoded_key) = match index {
    Some(i) =>
      (self.units - self.encoded[i * 2 + 1].length() + encoded.length(), "")
    None => {
      if self.keys.length() >= 50000 {
        raise Invalid("dictionary element limit")
      }
      let k = quote_element(key, self.keys.is_empty())
      (
        self.units +
        k.length() +
        encoded.length() +
        (if self.keys.is_empty() { 1 } else { 2 }),
        k,
      )
    }
  }
  if units > 1000000 {
    raise Invalid("dictionary size limit")
  }
  match index {
    Some(i) => {
      self.values[i] = value
      self.encoded[i * 2 + 1] = encoded
    }
    None => {
      self.index[key] = self.keys.length()
      self.keys.push(key)
      self.values.push(value)
      self.encoded.push(encoded_key)
      self.encoded.push(encoded)
    }
  }
  self.units = units
  self.representation = None
}

///|
fn DictObject::text(self : DictObject) -> String {
  match self.representation {
    Some(text) => text
    None => {
      let text = self.encoded.join(" ")
      self.representation = Some(text)
      text
    }
  }
}

///|
fn Interpreter::append_list(
  self : Interpreter,
  name : String,
  items : Array[String],
  discard_result : Bool,
) -> String raise TclError {
  let binding = self.binding(name, true).unwrap()
  if binding.index is Some(_) {
    let values = parse_list(binding.read().unwrap_or("")) + items
    let result = format_list(values)
    self.set_var(name, result)
    return if discard_result { "" } else { result }
  }
  let object = match binding.cell.value {
    Some(Sequence(object)) => object
    Some(Elements(_)) => raise Invalid("variable is array")
    _ => ListObject::from_text(binding.read().unwrap_or(""))
  }
  object.append(items)
  binding.cell.value = Some(Sequence(object))
  if discard_result {
    ""
  } else {
    object.text()
  }
}

///|
fn Interpreter::update_dictionary(
  self : Interpreter,
  args : Array[String],
  depth : Int,
  discard_result : Bool,
) -> String raise TclError {
  let name = args[2]
  let key = args[3]
  let binding = self.binding(name, true).unwrap()
  if binding.index is Some(_) {
    return self.dict_command(args, depth, object_path=false)
  }
  let object = match binding.cell.value {
    Some(Mapping(object)) => object
    Some(Elements(_)) => raise Invalid("variable is array")
    _ => DictObject::from_text(binding.read().unwrap_or(""))
  }
  let previous = object.get(key)
  let value = match args[1] {
    "set" => args[4]
    "incr" =>
      integer_add(
        previous.unwrap_or("0"),
        if args.length() == 5 {
          args[4]
        } else {
          "1"
        },
      )
    "append" => previous.unwrap_or("") + args[4:].to_owned().join("")
    "lappend" =>
      format_list(parse_list(previous.unwrap_or("")) + args[4:].to_owned())
    _ => raise Invalid("dictionary update operation")
  }
  object.put(key, value)
  binding.cell.value = Some(Mapping(object))
  if discard_result {
    ""
  } else {
    object.text()
  }
}
