///|
fn conversion_decimal(
  cs : Array[Char],
  cursor : Ref[Int],
) -> Int raise TclError {
  let mut value = 0
  while cursor.val < cs.length() &&
        cs[cursor.val] >= '0' &&
        cs[cursor.val] <= '9' {
    value = value * 10 + cs[cursor.val].to_int() - 48
    if value > 1000000 {
      raise Invalid("conversion size limit")
    }
    cursor.val += 1
  }
  value
}

///|
fn conversion_argument(
  args : Array[TclValue],
  cursor : Ref[Int],
) -> TclValue raise TclError {
  if cursor.val < 2 || cursor.val >= args.length() {
    raise Invalid("not enough arguments for format")
  }
  let value = args[cursor.val]
  cursor.val += 1
  value
}

///|
fn conversion_trim(text : String) -> String {
  let cs = utf16_units(text)
  let mut a = 0
  let mut b = cs.length()
  while a < b && list_space(cs[a]) {
    a += 1
  }
  while b > a && list_space(cs[b - 1]) {
    b -= 1
  }
  unit_slice(text, a, b)
}

///|
fn conversion_integer(text : String) -> @bigint.BigInt raise TclError {
  let trimmed = conversion_trim(text)
  if trimmed.is_empty() || numeric_prefix(trimmed, false) != trimmed.length() {
    raise Invalid("expected integer")
  }
  whole(trimmed)
}

///|
fn conversion_wrap(
  value : @bigint.BigInt,
  bits : Int,
  signed : Bool,
) -> @bigint.BigInt {
  let modulus = 1N << bits
  let raw = value & (modulus - 1N)
  if signed && raw >= modulus >> 1 {
    raw - modulus
  } else {
    raw
  }
}

///|
fn conversion_int32(text : String) -> Int raise TclError {
  let value = conversion_integer(text)
  if value < -4294967295N || value > 4294967295N {
    raise Invalid("integer value too large to represent")
  }
  conversion_wrap(value, 32, true).to_int()
}

///|
fn format_command(args : Array[TclValue]) -> String raise TclError {
  if args.length() < 2 {
    raise Invalid("format arity")
  }
  let cs = utf16_units(args[1].text)
  let cursor = Ref(0)
  let next = Ref(2)
  let mut positional = None
  let out = StringBuilder()
  let mut total = 0
  while cursor.val < cs.length() {
    if cs[cursor.val] != '%' {
      out.write_char(cs[cursor.val])
      cursor.val += 1
      total += 1
      if total > 1000000 {
        raise Invalid("format output size limit")
      }
      continue
    }
    cursor.val += 1
    if cursor.val < cs.length() && cs[cursor.val] == '%' {
      out.write_char('%')
      cursor.val += 1
      total += 1
      if total > 1000000 {
        raise Invalid("format output size limit")
      }
      continue
    }
    let saved = cursor.val
    let position = conversion_decimal(cs, cursor)
    let uses_position = cursor.val < cs.length() && cs[cursor.val] == '$'
    if positional is Some(previous) && previous != uses_position {
      raise Invalid("cannot mix positional and sequential format specifiers")
    }
    positional = Some(uses_position)
    if uses_position {
      if position < 1 || position + 1 >= args.length() {
        raise Invalid("format argument index out of range")
      }
      next.val = position + 1
      cursor.val += 1
    } else {
      cursor.val = saved
    }
    let mut left = false
    let mut plus = false
    let mut space = false
    let mut zero = false
    let mut alternate = false
    while cursor.val < cs.length() {
      match cs[cursor.val] {
        '-' => left = true
        '+' => plus = true
        ' ' => space = true
        '0' => zero = true
        '#' => alternate = true
        _ => break
      }
      cursor.val += 1
    }
    let mut width = if cursor.val < cs.length() && cs[cursor.val] == '*' {
      cursor.val += 1
      conversion_int32(conversion_argument(args, next).text)
    } else {
      conversion_decimal(cs, cursor)
    }
    if width < -1000000 || width > 1000000 {
      raise Invalid("format width limit")
    }
    if width < 0 {
      width = -width
      left = true
    }
    let precision = if cursor.val < cs.length() && cs[cursor.val] == '.' {
      cursor.val += 1
      let p = if cursor.val < cs.length() && cs[cursor.val] == '*' {
        cursor.val += 1
        conversion_int32(conversion_argument(args, next).text).max(0)
      } else {
        conversion_decimal(cs, cursor)
      }
      if p > 1000000 {
        raise Invalid("format precision limit")
      }
      Some(p)
    } else {
      None
    }
    let mut bits = 32
    if cursor.val < cs.length() && cs[cursor.val] == 'h' {
      bits = 16
      cursor.val += 1
    } else if cursor.val < cs.length() && cs[cursor.val] == 'l' {
      bits = 64
      cursor.val += 1
      if cursor.val < cs.length() && cs[cursor.val] == 'l' {
        bits = 0
        cursor.val += 1
      }
    }
    if cursor.val >= cs.length() {
      raise Invalid("incomplete format conversion")
    }
    let kind = cs[cursor.val]
    cursor.val += 1
    if !['d', 'i', 'u', 'o', 'x', 'X', 'b', 'c', 's', 'f', 'e', 'E', 'g', 'G'].contains(
        kind,
      ) {
      raise Invalid("invalid format conversion")
    }
    let value = conversion_argument(args, next)
    let mut prefix = ""
    let body = if kind == 's' {
      match precision {
        Some(p) => unit_slice(value.text, 0, p.min(value.text.length()))
        None => value.text
      }
    } else if kind == 'c' {
      let raw = conversion_integer(value.text)
      if raw < -4294967295N || raw > 4294967295N {
        raise Invalid("character integer out of range")
      }
      let cp = conversion_wrap(raw, 32, true).to_int()
      unit_text(if cp >= 0 && cp <= 65535 { cp } else { 65533 })
    } else if ['f', 'e', 'E', 'g', 'G'].contains(kind) {
      let text = conversion_trim(value.text)
      if text.is_empty() || numeric_prefix(text, true) != text.length() {
        raise Invalid("expected floating-point number")
      }
      let x = match value.as_number() {
        Some(n) => n.double()
        None => {
          let (length, value, _) = scan_real_prefix(text)
          if length != text.length() {
            raise Invalid("expected floating-point number")
          }
          value
        }
      }
      if x.is_nan() {
        raise Invalid("floating point value is Not a Number")
      }
      prefix = if x.reinterpret_as_uint64() >> 63 == 1UL {
        "-"
      } else if plus {
        "+"
      } else if space {
        " "
      } else {
        ""
      }
      if x.is_inf() {
        zero = false
        if kind == 'E' || kind == 'G' {
          "INF"
        } else {
          "inf"
        }
      } else {
        format_real(x.abs(), kind, precision.unwrap_or(6), alternate)
      }
    } else {
      if kind == 'u' && bits == 0 {
        raise Invalid("unsigned bignum format is invalid")
      }
      let signed = kind == 'd' || kind == 'i' || bits == 0
      let raw = conversion_integer(value.text)
      let value = if bits == 0 {
        raw
      } else {
        conversion_wrap(raw, bits, signed)
      }
      let magnitude = if value < 0N { -value } else { value }
      prefix = if value < 0N {
        "-"
      } else if signed && plus {
        "+"
      } else if signed && space {
        " "
      } else {
        ""
      }
      let radix = if kind == 'x' || kind == 'X' {
        16
      } else if kind == 'o' {
        8
      } else if kind == 'b' {
        2
      } else {
        10
      }
      let raw_digits = magnitude.to_string(radix~)
      let raw_digits = if kind == 'X' {
        unicode_case(raw_digits, 1)
      } else {
        raw_digits
      }
      let digits = "0".repeat(
          precision.unwrap_or(0).max(raw_digits.length()) - raw_digits.length(),
        ) +
        raw_digits
      if alternate {
        if kind == 'x' {
          prefix += "0x"
        } else if kind == 'X' {
          prefix += "0X"
        } else if kind == 'b' {
          prefix += "0b"
        } else if kind == 'o' && !digits.has_prefix("0") {
          prefix += "0"
        }
      }
      if precision is Some(_) {
        zero = false
      }
      digits
    }
    if ['f', 'e', 'E', 'g', 'G'].contains(kind) && left {
      zero = false
    }
    if !['s', 'c', 'f', 'e', 'E', 'g', 'G'].contains(kind) && zero {
      left = false
    }
    let padding = (width - prefix.length() - body.length()).max(0)
    let piece = if left {
      prefix + body + (if zero { "0" } else { " " }).repeat(padding)
    } else if zero {
      prefix + "0".repeat(padding) + body
    } else {
      " ".repeat(padding) + prefix + body
    }
    total += piece.length()
    if total > 1000000 {
      raise Invalid("format output size limit")
    }
    out.write_string(piece)
  }
  out.to_string()
}
