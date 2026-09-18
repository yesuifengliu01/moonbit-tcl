///|
priv enum ScanToken {
  Literal(Char)
  Space
  Field(Char, Int, Int, Int, Array[(Char, Char)], Bool)
}

///|
fn scan_format(
  text : String,
  variables : Int,
) -> (Array[ScanToken], Int) raise TclError {
  let cs = utf16_units(text)
  let cursor = Ref(0)
  let tokens = []
  let used : Map[Int, Bool] = Map([])
  let mut mode = None
  let mut next = 0
  let mut slots = 0
  while cursor.val < cs.length() {
    let c = cs[cursor.val]
    cursor.val += 1
    if c != '%' {
      tokens.push(
        if (unicode_mask(c.to_int()) & 512) != 0 {
          Space
        } else {
          Literal(c)
        },
      )
      continue
    }
    if cursor.val < cs.length() && cs[cursor.val] == '%' {
      tokens.push(Literal('%'))
      cursor.val += 1
      continue
    }
    let discard = cursor.val < cs.length() && cs[cursor.val] == '*'
    if discard {
      cursor.val += 1
    }
    let saved = cursor.val
    let position = conversion_decimal(cs, cursor)
    let positional = !discard &&
      cursor.val < cs.length() &&
      cs[cursor.val] == '$'
    if positional {
      cursor.val += 1
    } else {
      cursor.val = saved
    }
    let slot = if discard {
      -1
    } else {
      if mode is Some(previous) && previous != positional {
        raise Invalid("mixed scan positional specifiers")
      }
      mode = Some(positional)
      let index = if positional {
        position - 1
      } else {
        let index = next
        next += 1
        index
      }
      if index < 0 || index >= 100000 || (variables > 0 && index >= variables) {
        raise Invalid("scan variable index out of range")
      }
      if used.contains(index) {
        raise Invalid("scan position assigned more than once")
      }
      used[index] = true
      slots = slots.max(index + 1)
      index
    }
    let before_width = cursor.val
    let width = conversion_decimal(cs, cursor)
    let has_width = cursor.val != before_width
    let mut bits = 32
    if cursor.val < cs.length() && cs[cursor.val] == 'h' {
      cursor.val += 1
    } else if cursor.val < cs.length() &&
      (cs[cursor.val] == 'l' || cs[cursor.val] == 'L') {
      let first = cs[cursor.val]
      bits = 64
      cursor.val += 1
      if first == 'l' && cursor.val < cs.length() && cs[cursor.val] == 'l' {
        bits = 0
        cursor.val += 1
      }
    }
    if cursor.val >= cs.length() {
      raise Invalid("incomplete scan conversion")
    }
    let kind = cs[cursor.val]
    cursor.val += 1
    if ![
        'd', 'i', 'u', 'o', 'x', 'X', 'b', 'c', 's', 'f', 'e', 'E', 'g', 'G', '[',
        'n',
      ].contains(kind) {
      raise Invalid("invalid scan conversion")
    }
    if kind == 'u' && bits == 0 {
      raise Invalid("unsigned bignum scans are invalid")
    }
    if ['c', 's', '[', 'n'].contains(kind) && bits != 32 {
      raise Invalid("invalid scan size modifier")
    }
    if kind == 'c' && has_width {
      raise Invalid("scan character width is forbidden")
    }
    let ranges = []
    let mut invert = false
    if kind == '[' {
      if cursor.val < cs.length() && cs[cursor.val] == '^' {
        invert = true
        cursor.val += 1
      }
      if cursor.val < cs.length() && cs[cursor.val] == ']' {
        ranges.push((']', ']'))
        cursor.val += 1
      }
      while cursor.val < cs.length() && cs[cursor.val] != ']' {
        let first = cs[cursor.val]
        cursor.val += 1
        if cursor.val + 1 < cs.length() &&
          cs[cursor.val] == '-' &&
          cs[cursor.val + 1] != ']' {
          ranges.push((first, cs[cursor.val + 1]))
          cursor.val += 2
        } else {
          ranges.push((first, first))
        }
      }
      if cursor.val == cs.length() {
        raise Invalid("unmatched scan character set")
      }
      cursor.val += 1
    }
    tokens.push(
      Field(
        kind,
        bits,
        if width == 0 {
          1000000
        } else {
          width
        },
        slot,
        ranges,
        invert,
      ),
    )
  }
  if variables > 0 && used.length() != variables {
    raise Invalid("scan variable count mismatch")
  }
  (tokens, slots)
}

///|
fn scan_integer_prefix(
  text : String,
  kind : Char,
) -> (Int, @bigint.BigInt, Bool) raise TclError {
  let cs = utf16_units(text)
  let n = cs.length()
  let negative = n > 0 && cs[0] == '-'
  let mut start = if n > 0 && (cs[0] == '-' || cs[0] == '+') { 1 } else { 0 }
  if start == n {
    return (0, 0N, true)
  }
  let mut base = if kind == 'x' || kind == 'X' {
    16
  } else if kind == 'o' {
    8
  } else if kind == 'b' {
    2
  } else {
    10
  }
  if kind == 'i' && cs[start] == '0' {
    base = 8
  }
  let mut end = start
  let mut value = 0N
  if cs[start] == '0' {
    end = start + 1
    if start + 2 < n {
      let marker = cs[start + 1]
      let prefixed = (
          (base == 16 || kind == 'i') && (marker == 'x' || marker == 'X')
        ) ||
        (base == 2 && (marker == 'b' || marker == 'B'))
      let proposed = if kind == 'i' { 16 } else { base }
      if prefixed &&
        hex_digit(cs[start + 2]) >= 0 &&
        hex_digit(cs[start + 2]) < proposed {
        base = proposed
        start += 2
        end = start
      }
    }
  }
  let mut i = start
  while i < n && hex_digit(cs[i]) >= 0 && hex_digit(cs[i]) < base {
    i += 1
    end = i
  }
  if end == start {
    return (0, 0N, false)
  }
  if end - start > 5000 {
    raise Invalid("scan integer size limit")
  }
  value = @strconv.parse_bigint(unit_slice(text, start, end), base~) catch {
    _ => raise Invalid("scan integer conversion")
  }
  if value.bit_length() > 16384 {
    raise Invalid("scan integer bit limit")
  }
  (end, if negative { -value } else { value }, false)
}

///|
fn scan_real_prefix(
  text : String,
  discard? : Bool = false,
) -> (Int, Double, Bool) {
  let cs = utf16_units(text)
  let n = cs.length()
  let mut i = if n > 0 && (cs[0] == '+' || cs[0] == '-') { 1 } else { 0 }
  let start = i
  let rest = unicode_case(unit_slice(text, start, n), 0)
  if rest.has_prefix("inf") {
    return (
      start + (if rest.has_prefix("infinity") { 8 } else { 3 }),
      if n > 0 && cs[0] == '-' {
        -1.0 / 0.0
      } else {
        1.0 / 0.0
      },
      false,
    )
  }
  if discard && rest.has_prefix("nan") {
    let mut end = start + 3
    if end < n && cs[end] == '(' {
      let mut i = end + 1
      while i < n && hex_digit(cs[i]) >= 0 {
        i += 1
      }
      if i > end + 1 && i - end - 1 <= 13 && i < n && cs[i] == ')' {
        end = i + 1
      }
    }
    return (end, 0.0, false)
  }
  let mut digits = 0
  while i < n && cs[i] >= '0' && cs[i] <= '9' {
    digits += 1
    i += 1
  }
  if i < n && cs[i] == '.' {
    i += 1
    while i < n && cs[i] >= '0' && cs[i] <= '9' {
      digits += 1
      i += 1
    }
  }
  if digits == 0 {
    return (0, 0.0, i == n)
  }
  let mut end = i
  if i < n && (cs[i] == 'e' || cs[i] == 'E') {
    i += 1
    if i < n && (cs[i] == '+' || cs[i] == '-') {
      i += 1
    }
    let before = i
    while i < n && cs[i] >= '0' && cs[i] <= '9' {
      i += 1
    }
    if i > before {
      end = i
    }
  }
  let value = conversion_parse_double(unit_slice(text, 0, end))
  (end, value, false)
}

///|
// Unlike UTF-16 indices, scan %n reports the byte offset in Tcl's string.
// This path measures canonical UTF-8 plus Tcl's two-byte NUL encoding.
fn scan_byte_offset(text : String, units : Int) -> Int {
  let mut bytes = 0
  for c in unit_slice(text, 0, units).to_array() {
    let cp = c.to_int()
    bytes += if cp > 65535 {
      4
    } else if cp > 0 && cp < 128 {
      1
    } else if cp < 2048 {
      2
    } else {
      3
    }
  }
  bytes
}

///|
fn Interpreter::scan_command(
  self : Interpreter,
  args : Array[String],
) -> TclValue raise TclError {
  if args.length() < 3 {
    raise Invalid("scan arity")
  }
  let variables = args.length() - 3
  let (tokens, slots) = scan_format(args[2], variables)
  let text = args[1]
  let cs = utf16_units(text)
  let values : Array[TclValue] = Array::makei(slots, _ => text_value(""))
  let mut at = 0
  let mut converted = 0
  let matched = Array::make(slots, false)
  let mut assigned = 0
  let mut eof = false
  for token in tokens {
    match token {
      Space =>
        while at < cs.length() && (unicode_mask(cs[at].to_int()) & 512) != 0 {
          at += 1
        }
      Literal(c) => {
        if at >= cs.length() {
          eof = true
          break
        }
        if cs[at] != c {
          break
        }
        at += 1
      }
      Field(kind, bits, width, slot, ranges, invert) => {
        if kind != 'c' && kind != '[' && kind != 'n' {
          while at < cs.length() && (unicode_mask(cs[at].to_int()) & 512) != 0 {
            at += 1
          }
        }
        if at >= cs.length() && kind != 'n' {
          eof = true
          break
        }
        let value = if kind == 'n' {
          number_value(Small(scan_byte_offset(text, at)))
        } else if kind == 'c' {
          let first = cs[at].to_int()
          at += 1
          if first >= 55296 &&
            first <= 56319 &&
            at < cs.length() &&
            cs[at].to_int() >= 56320 &&
            cs[at].to_int() <= 57343 {
            let cp = 65536 + (first - 55296) * 1024 + cs[at].to_int() - 56320
            at += 1
            number_value(Small(cp))
          } else {
            number_value(Small(first))
          }
        } else if kind == 's' || kind == '[' {
          let start = at
          let end = (at + width).min(cs.length())
          while at < end {
            let matches = if kind == 's' {
              (unicode_mask(cs[at].to_int()) & 512) == 0
            } else {
              ranges
              .iter()
              .any(pair => {
                (cs[at] >= pair.0 && cs[at] <= pair.1) ||
                (cs[at] >= pair.1 && cs[at] <= pair.0)
              }) !=
              invert
            }
            if !matches {
              break
            }
            at += 1
          }
          if at == start {
            break
          }
          text_value(unit_slice(text, start, at))
        } else if ['f', 'e', 'E', 'g', 'G'].contains(kind) {
          let (length, real, exhausted) = scan_real_prefix(
            unit_slice(text, at, (at + width).min(cs.length())),
            discard=slot < 0,
          )
          if length == 0 {
            eof = exhausted
            break
          }
          at += length
          if slot < 0 {
            text_value("")
          } else {
            number_value(Real(real))
          }
        } else {
          let (length, raw, exhausted) = scan_integer_prefix(
            unit_slice(text, at, (at + width).min(cs.length())),
            kind,
          )
          if length == 0 {
            eof = exhausted
            break
          }
          at += length
          let value = if bits == 0 {
            raw
          } else {
            let maximum = (1N << bits) - 1N
            let limited = if raw > maximum {
              maximum >> 1
            } else if raw < -maximum {
              -(1N << (bits - 1))
            } else {
              raw
            }
            conversion_wrap(limited, bits, kind != 'u')
          }
          number_value(Whole(value))
        }
        converted += 1
        if slot >= 0 {
          values[slot] = value
          matched[slot] = true
          assigned += 1
        }
      }
    }
  }
  if variables > 0 {
    for i in 0..<slots {
      if matched[i] {
        self.set_value(args[i + 3], values[i])
      }
    }
  }
  if variables == 0 {
    if eof && converted == 0 {
      text_value("")
    } else {
      list_value(values)
    }
  } else if eof && converted == 0 {
    text_value("-1")
  } else {
    text_value(assigned.to_string())
  }
}
