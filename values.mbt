///|
// A value owns its textual representation and optional internal representation.
// Reading text does not round-trip a numeric payload through that text. Lists
// hold values, not encodings, and mutations always build a separate container.
struct TclValue {
  text : String
  mut payload : ValuePayload
} derive(Debug)

///|
enum ValuePayload {
  Plain
  Numeric(Number)
  Items(Array[TclValue])
  Pairs(Array[(TclValue, TclValue)])
} derive(Debug)

///|
fn text_value(text : String) -> TclValue {
  { text, payload: Plain, }
}

///|
fn number_value(value : Number) -> TclValue raise TclError {
  { text: value.text(), payload: Numeric(value), }
}

///|
fn list_value(values : Array[TclValue]) -> TclValue raise TclError {
  { text: format_list(values.map(v => v.text)), payload: Items(values.copy()), }
}

///|
fn TclValue::as_list(self : TclValue) -> Array[TclValue] raise TclError {
  match self.payload {
    Items(values) => values.copy()
    Pairs(pairs) => {
      let values = []
      for (key, value) in pairs {
        values.push(key)
        values.push(value)
      }
      self.payload = Items(values)
      values.copy()
    }
    _ => {
      let values = parse_list(self.text).map(text_value)
      self.payload = Items(values)
      values.copy()
    }
  }
}

///|
fn TclValue::as_number(self : TclValue) -> Number? {
  match self.payload {
    Numeric(value) => Some(value)
    _ => {
      let value = number(self.text)
      if value is Some(n) {
        self.payload = Numeric(n)
      }
      value
    }
  }
}

///|
fn TclValue::truth(self : TclValue) -> Bool raise TclError {
  match self.as_number() {
    Some(n) => {
      let value = n.double()
      if value.is_nan() {
        raise Invalid("expected boolean")
      }
      value != 0.0
    }
    None => boolean(self.text)
  }
}

///|
fn TclValue::as_whole(self : TclValue) -> @bigint.BigInt raise TclError {
  match self.payload {
    Numeric(Small(n)) => @bigint.BigInt::from_int(n)
    Numeric(Whole(n)) => n
    Numeric(Real(_)) => raise Invalid("expected integer")
    _ => whole(self.text)
  }
}

///|
fn Interpreter::execute_value_script(
  self : Interpreter,
  value : TclValue,
  depth : Int,
  discard_result? : Bool = false,
) -> TclValue raise TclError {
  if value.text.length() > 100000 {
    raise Invalid("script size limit")
  }
  if depth > 64 {
    raise Invalid("execution nesting limit")
  }
  match value.payload {
    Items(items) => {
      if items.is_empty() {
        return text_value("")
      }
      if items.length() > 4096 {
        raise Invalid("expanded argument limit")
      }
      self.command_value(items, depth, discard_result~) catch {
        error =>
          raise Signal(
            self.annotate_error(
              outcome(error),
              value.text,
              1,
              items.map(v => v.text),
            ),
          )
      }
    }
    _ => self.execute_value(value.text, depth, discard_result~)
  }
}

///|
fn script_arguments(values : Array[TclValue]) -> TclValue raise TclError {
  if values.length() == 1 {
    values[0]
  } else {
    concat_values(values)
  }
}
