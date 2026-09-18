///|
struct ListObject {
  values : Array[TclValue]
  encoded : Array[String]
  mut units : Int
  mut representation : String?
} derive(Debug)

///|
fn ListObject::from_value(value : TclValue) -> ListObject raise TclError {
  let object = ListObject::{
    values: [],
    encoded: [],
    units: 0,
    representation: Some(value.text),
  }
  object.append(value.as_list())
  object.representation = Some(value.text)
  object
}

///|
fn ListObject::append(
  self : ListObject,
  items : Array[TclValue],
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
    let text = quote_element(items[i].text, self.values.is_empty() && i == 0)
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
  keys : Array[TclValue]
  values : Array[TclValue]
  index : Map[String, Int]
  encoded : Array[String]
  mut units : Int
  mut representation : String?
} derive(Debug)

///|
fn DictObject::from_value(value : TclValue) -> DictObject raise TclError {
  let object = DictObject::{
    keys: [],
    values: [],
    index: Map([]),
    encoded: [],
    units: 0,
    representation: Some(value.text),
  }
  for (key, value) in dictionary_values(value) {
    object.put(key, value)
  }
  object.representation = Some(value.text)
  object
}

///|
fn DictObject::get(self : DictObject, key : String) -> TclValue? {
  self.index.get(key).map(i => self.values[i])
}

///|
fn DictObject::put(
  self : DictObject,
  key : TclValue,
  value : TclValue,
) -> Unit raise TclError {
  let index = self.index.get(key.text)
  let encoded = quote_element(value.text, false)
  let (units, encoded_key) = match index {
    Some(i) =>
      (self.units - self.encoded[i * 2 + 1].length() + encoded.length(), "")
    None => {
      if self.keys.length() >= 50000 {
        raise Invalid("dictionary element limit")
      }
      let k = quote_element(key.text, self.keys.is_empty())
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
      self.index[key.text] = self.keys.length()
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
  items : Array[TclValue],
  discard_result : Bool,
) -> TclValue raise TclError {
  let binding = self.binding(name, true).unwrap()
  if binding.index is Some(_) {
    let values = binding.read_value().unwrap_or(text_value("")).as_list() +
      items
    let result = list_value(values)
    self.set_value(name, result)
    return if discard_result { text_value("") } else { result }
  }
  let object = match binding.cell.value {
    Some(Sequence(object)) => object
    Some(Elements(_)) => raise Invalid("variable is array")
    _ => ListObject::from_value(binding.read_value().unwrap_or(text_value("")))
  }
  object.append(items)
  binding.cell.value = Some(Sequence(object))
  if discard_result {
    text_value("")
  } else {
    binding.read_value().unwrap()
  }
}

///|
fn Interpreter::update_dictionary(
  self : Interpreter,
  input : Array[TclValue],
  depth : Int,
  discard_result : Bool,
) -> TclValue raise TclError {
  let args = input.map(v => v.text)
  let name = args[2]
  let key = args[3]
  let binding = self.binding(name, true).unwrap()
  if binding.index is Some(_) {
    return self.dict_command(input, depth, object_path=false)
  }
  let object = match binding.cell.value {
    Some(Mapping(object)) => object
    Some(Elements(_)) => raise Invalid("variable is array")
    _ => DictObject::from_value(binding.read_value().unwrap_or(text_value("")))
  }
  let previous = object.get(key)
  let value = match args[1] {
    "set" => input[4]
    "incr" =>
      text_value(
        integer_add(
          previous.map(v => v.text).unwrap_or("0"),
          if args.length() == 5 {
            args[4]
          } else {
            "1"
          },
        ),
      )
    "append" =>
      if args[4:].iter().all(v => v.is_empty()) {
        previous.unwrap_or(text_value(""))
      } else {
        text_value(
          previous.map(v => v.text).unwrap_or("") + args[4:].to_owned().join(""),
        )
      }
    "lappend" =>
      list_value(
        previous.unwrap_or(text_value("")).as_list() + input[4:].to_owned(),
      )
    _ => raise Invalid("dictionary update operation")
  }
  object.put(input[3], value)
  binding.cell.value = Some(Mapping(object))
  if discard_result {
    text_value("")
  } else {
    binding.read_value().unwrap()
  }
}

///|
fn ListObject::snapshot(self : ListObject) -> TclValue {
  { text: self.text(), payload: Items(self.values.copy()), }
}

///|
fn DictObject::snapshot(self : DictObject) -> TclValue {
  let pairs = []
  for i in 0..<self.keys.length() {
    pairs.push((self.keys[i], self.values[i]))
  }
  { text: self.text(), payload: Pairs(pairs), }
}
