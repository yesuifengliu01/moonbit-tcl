///|
priv enum Number {
  Small(Int)
  Whole(@bigint.BigInt)
  Real(Double)
}

///|
fn whole(text : String) -> @bigint.BigInt raise TclError {
  if small_decimal(text) is Some(value) {
    return @bigint.BigInt::from_int(value)
  }
  let text = text.trim().to_owned()
  if text.length() > 5000 {
    raise Invalid("integer size limit")
  }
  let negative = text.has_prefix("-")
  let s = if negative || text.has_prefix("+") {
    text[1:].to_owned()
  } else {
    text
  }
  let (digits, base) = if s.has_prefix("0x") || s.has_prefix("0X") {
    (s[2:].to_owned(), 16)
  } else if s.has_prefix("0b") || s.has_prefix("0B") {
    (s[2:].to_owned(), 2)
  } else if s.has_prefix("0o") || s.has_prefix("0O") {
    (s[2:].to_owned(), 8)
  } else if s.length() > 1 && s.has_prefix("0") {
    (s, 8)
  } else {
    (s, 10)
  }
  if digits.has_prefix("-") || digits.has_prefix("+") {
    raise Invalid("expected integer: " + text)
  }
  let value = @strconv.parse_bigint(digits, base~) catch {
    _ => raise Invalid("expected integer: " + text)
  }
  if value.bit_length() > 16384 {
    raise Invalid("integer bit limit")
  }
  if negative {
    -value
  } else {
    value
  }
}

///|
fn number(text : String) -> Number? {
  if small_decimal(text) is Some(value) {
    return Some(Small(value))
  }
  if (Some(whole(text)) catch { _ => None }) is Some(value) {
    return Some(Whole(value))
  }
  let text = text.trim().to_owned()
  let lower = text.to_lower()
  if lower == "inf" ||
    lower == "+inf" ||
    lower == "infinity" ||
    lower == "+infinity" {
    return Some(Real(1.0 / 0.0))
  }
  if lower == "-inf" || lower == "-infinity" {
    return Some(Real(-1.0 / 0.0))
  }
  if lower == "nan" {
    return Some(Real(0.0 / 0.0))
  }
  if !text.contains(".") && !lower.contains("e") {
    return None
  }
  Some(Real(@strconv.parse_double(text))) catch {
    _ => None
  }
}

///|
fn Number::double(self : Number) -> Double {
  match self {
    Small(x) => x.to_double()
    Real(x) => x
    Whole(x) =>
      @strconv.parse_double(x.to_string()) catch {
        _ => if x < 0N { -1.0 / 0.0 } else { 1.0 / 0.0 }
      }
  }
}

///|
fn Number::text(self : Number) -> String raise TclError {
  match self {
    Small(x) => x.to_string()
    Whole(value) => {
      if value.bit_length() > 16384 {
        raise Invalid("integer bit limit")
      }
      value.to_string()
    }
    Real(value) => {
      if value.is_nan() {
        raise Invalid("domain error: argument not in valid range")
      }
      if value.is_inf() {
        return if value < 0.0 { "-Inf" } else { "Inf" }
      }
      float_text(value)
    }
  }
}

///|
fn boolean(text : String) -> Bool raise TclError {
  if number(text) is Some(n) {
    let value = n.double()
    if value.is_nan() {
      raise Invalid("expected boolean")
    }
    return value != 0.0
  }
  let text = text.to_lower()
  if text.is_empty() {
    raise Invalid("expected boolean")
  }
  if ["true", "yes", "on"].iter().any(s => s.has_prefix(text)) && text != "o" {
    return true
  }
  if ["false", "no", "off"].iter().any(s => s.has_prefix(text)) && text != "o" {
    return false
  }
  raise Invalid("expected boolean")
}

///|
fn boolean_text(value : Bool) -> String {
  if value {
    "1"
  } else {
    "0"
  }
}

///|
fn numeric_binary(
  operator : String,
  left : String,
  right : String,
) -> String raise TclError {
  if operator == "eq" || operator == "ne" {
    return boolean_text((left == right) == (operator == "eq"))
  }
  if operator == "in" || operator == "ni" {
    return boolean_text(parse_list(right).contains(left) == (operator == "in"))
  }
  let a = number(left)
  let b = number(right)
  if (a, b) is (Some(Small(x)), Some(Small(y))) {
    if small_operation(operator, x, y) is Some(result) {
      return result
    }
  }
  let a = a.map(Number::promote)
  let b = b.map(Number::promote)
  if ["==", "!=", "<", ">", "<=", ">="].contains(operator) {
    let comparison = match (a, b) {
      (Some(Whole(a)), Some(Whole(b))) => a.compare(b)
      (Some(Whole(a)), Some(Real(b))) => {
        if b.is_nan() {
          return boolean_text(operator == "!=")
        }
        integer_double_compare(a, b)
      }
      (Some(Real(a)), Some(Whole(b))) => {
        if a.is_nan() {
          return boolean_text(operator == "!=")
        }
        -integer_double_compare(b, a)
      }
      (Some(a), Some(b)) => {
        let x = a.double()
        let y = b.double()
        if x.is_nan() || y.is_nan() {
          return boolean_text(operator == "!=")
        }
        if x < y {
          -1
        } else if x > y {
          1
        } else {
          0
        }
      }
      _ => left.compare(right)
    }
    return boolean_text(
      match operator {
        "==" => comparison == 0
        "!=" => comparison != 0
        "<" => comparison < 0
        ">" => comparison > 0
        "<=" => comparison <= 0
        _ => comparison >= 0
      },
    )
  }
  guard a is Some(a) && b is Some(b) else {
    raise Invalid("expected numeric operand")
  }
  if (a, b) is (Whole(x), Whole(y)) {
    let value = match operator {
      "+" => x + y
      "-" => x - y
      "*" => {
        if x.bit_length() + y.bit_length() > 16384 {
          raise Invalid("integer bit limit")
        }
        x * y
      }
      "%" => {
        if y == 0N {
          raise Invalid("divide by zero")
        }
        let r = x % y
        if r != 0N && (r < 0N) != (y < 0N) {
          r + y
        } else {
          r
        }
      }
      "**" =>
        if y < 0N {
          if x == 0N {
            raise Invalid("exponentiation of zero by negative power")
          }
          if x == 1N {
            1N
          } else if x == -1N {
            if y % 2N == 0N {
              1N
            } else {
              -1N
            }
          } else {
            0N
          }
        } else {
          if y > 16384N ||
            (
              x.bit_length() > 1 &&
              y > @bigint.BigInt::from_int(16384 / x.bit_length())
            ) {
            raise Invalid("exponent limit")
          }
          x.pow(y)
        }
      "<<" | ">>" => {
        if y < 0N || y > 16384N {
          raise Invalid("shift limit")
        }
        if operator == "<<" {
          if x.bit_length() + y.to_int() > 16384 {
            raise Invalid("integer bit limit")
          }
          x << y.to_int()
        } else {
          x >> y.to_int()
        }
      }
      "&" => x & y
      "|" => x | y
      "^" => x ^ y
      _ => raise Invalid("unsupported integer operator")
    }
    return Whole(value).text()
  }
  if ["%", "<<", ">>", "&", "|", "^"].contains(operator) {
    raise Invalid("integer operand required")
  }
  let x = a.double()
  let y = b.double()
  let result = match operator {
    "+" => x + y
    "-" => x - y
    "*" => x * y
    "/" => x / y
    "**" => @math.pow(x, y)
    _ => raise Invalid("unsupported arithmetic operator")
  }
  Real(result).text()
}

///|
fn integer_double_compare(a : @bigint.BigInt, b : Double) -> Int raise TclError {
  if b.is_inf() {
    return if b < 0.0 { 1 } else { -1 }
  }
  let integral = double_integer(b)
  let order = a.compare(integral)
  if order != 0 {
    return order
  }
  if b == b.floor() {
    0
  } else if b < 0.0 {
    1
  } else {
    -1
  }
}

///|
fn float_text(value : Double) -> String raise TclError {
  if value == 0.0 {
    return if value.reinterpret_as_uint64() >> 63 == 1UL {
      "-0.0"
    } else {
      "0.0"
    }
  }
  let negative = value < 0.0
  let raw = value.abs().to_string()
  let parts = raw.split("e").to_array()
  let mantissa = parts[0].to_owned()
  let decimal = mantissa.split(".").to_array()
  let mut exponent = if parts.length() == 2 {
    integer(parts[1].to_owned())
  } else {
    0
  }
  exponent += decimal[0].length() - 1
  let mut digits = mantissa.replace_all(old=".", new="")
  while digits.has_prefix("0") {
    digits = digits[1:].to_owned()
    exponent -= 1
  }
  while digits.length() > 1 && digits.has_suffix("0") {
    digits = digits[:digits.length() - 1].to_owned()
  }
  let result = if exponent < -4 || exponent >= 17 {
    digits[:1].to_owned() +
    (if digits.length() > 1 { "." + digits[1:].to_owned() } else { "" }) +
    "e" +
    (if exponent >= 0 { "+" } else { "" }) +
    exponent.to_string()
  } else if exponent < 0 {
    "0." + String::from_array(Array::make(-exponent - 1, '0')) + digits
  } else if exponent + 1 >= digits.length() {
    digits +
    String::from_array(Array::make(exponent + 1 - digits.length(), '0')) +
    ".0"
  } else {
    digits[:exponent + 1].to_owned() + "." + digits[exponent + 1:].to_owned()
  }
  (if negative { "-" } else { "" }) + result
}

///|
fn numeric_divide(left : String, right : String) -> String raise TclError {
  let a = number(left)
  let b = number(right)
  if (a, b) is (Some(Small(x)), Some(Small(y))) {
    return small_operation("/", x, y).unwrap()
  }
  match (a.map(Number::promote), b.map(Number::promote)) {
    (Some(Whole(x)), Some(Whole(y))) => {
      if y == 0N {
        raise Invalid("divide by zero")
      }
      let q = x / y
      let r = x % y
      Whole(if r != 0N && (x < 0N) != (y < 0N) { q - 1N } else { q }).text()
    }
    _ => numeric_binary("/", left, right)
  }
}

///|
// A conservative decimal fast path. Leading-zero, base-prefixed, whitespace,
// and larger operands continue through the full Tcl integer parser.
fn small_decimal(text : String) -> Int? {
  let length = text.length()
  if length == 0 || length > 10 {
    return None
  }
  let initial = text.get(0).unwrap().to_int()
  let negative = initial == 45
  let start = if negative || initial == 43 { 1 } else { 0 }
  if length == start || length - start > 9 {
    return None
  }
  if length - start > 1 && text.get(start).unwrap().to_int() == 48 {
    return None
  }
  let mut value = 0
  for i in start..<length {
    let digit = text.get(i).unwrap().to_int() - 48
    if digit < 0 || digit > 9 {
      return None
    }
    value = value * 10 + digit
  }
  Some(if negative { -value } else { value })
}

///|
fn Number::promote(self : Number) -> Number {
  match self {
    Small(x) => Whole(@bigint.BigInt::from_int(x))
    other => other
  }
}

///|
fn small_operation(
  operator : String,
  x : Int,
  y : Int,
) -> String? raise TclError {
  // Nine decimal digits fit exactly in Int64 even after multiplication.
  let a = x.to_int64()
  let b = y.to_int64()
  let result = match operator {
    "+" => (a + b).to_string()
    "-" => (a - b).to_string()
    "*" => (a * b).to_string()
    "/" | "%" => {
      if y == 0 {
        raise Invalid("divide by zero")
      }
      let q = a / b
      let r = a % b
      if operator == "/" {
        (if r != 0L && (x < 0) != (y < 0) { q - 1L } else { q }).to_string()
      } else {
        (if r != 0L && (r < 0L) != (y < 0) { r + b } else { r }).to_string()
      }
    }
    "&" => (x & y).to_string()
    "|" => (x | y).to_string()
    "^" => (x ^ y).to_string()
    "==" => boolean_text(x == y)
    "!=" => boolean_text(x != y)
    "<" => boolean_text(x < y)
    ">" => boolean_text(x > y)
    "<=" => boolean_text(x <= y)
    ">=" => boolean_text(x >= y)
    _ => return None
  }
  Some(result)
}

///|
fn integer_add(left : String, right : String) -> String raise TclError {
  if (small_decimal(left), small_decimal(right)) is (Some(x), Some(y)) {
    return (x.to_int64() + y.to_int64()).to_string()
  }
  Whole(whole(left) + whole(right)).text()
}

///|
fn integer_compare(left : String, right : String) -> Int raise TclError {
  if (small_decimal(left), small_decimal(right)) is (Some(x), Some(y)) {
    return x.compare(y)
  }
  whole(left).compare(whole(right))
}
