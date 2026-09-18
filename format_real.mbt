///|
// Work on the exact IEEE-754 rational value. Decimal rounding uses ties to
// even and does not depend on JS/host printf or a shortest-decimal heuristic.
fn double_fraction(value : Double) -> (@bigint.BigInt, @bigint.BigInt) {
  let bits = value.reinterpret_as_uint64()
  let exponent = ((bits >> 52) & 2047UL).to_int()
  let fraction = bits & 4503599627370495UL
  let mantissa = if exponent == 0 {
    fraction
  } else {
    fraction | 4503599627370496UL
  }
  let shift = (if exponent == 0 { -1022 } else { exponent - 1023 }) - 52
  let n = @bigint.BigInt::from_uint64(mantissa)
  if shift >= 0 {
    (n << shift, 1N)
  } else {
    (n, 1N << -shift)
  }
}

///|
fn decimal_power(exponent : Int) -> @bigint.BigInt {
  10N.pow(@bigint.BigInt::from_int(exponent))
}

///|
// The caller has already recognized a decimal number. Core parsing reports
// extreme exponents as errors; Tcl accepts signed overflow/underflow values.
fn conversion_parse_double(text : String) -> Double {
  @strconv.parse_double(text) catch {
    _ => {
      let cs = utf16_units(text)
      let negative = cs.length() > 0 && cs[0] == '-'
      let mut i = if cs.length() > 0 && (cs[0] == '-' || cs[0] == '+') {
        1
      } else {
        0
      }
      let mut digits = 0
      let mut before_point = 0
      let mut first_nonzero = -1
      let mut fractional = false
      while i < cs.length() && cs[i] != 'e' && cs[i] != 'E' {
        if cs[i] == '.' {
          fractional = true
        } else {
          if cs[i] != '0' && first_nonzero < 0 {
            first_nonzero = digits
          }
          digits += 1
          if !fractional {
            before_point += 1
          }
        }
        i += 1
      }
      let mut exponent = 0
      if i < cs.length() {
        i += 1
        let sign = if i < cs.length() && cs[i] == '-' { -1 } else { 1 }
        if i < cs.length() && (cs[i] == '-' || cs[i] == '+') {
          i += 1
        }
        while i < cs.length() {
          exponent = (exponent * 10 + cs[i].to_int() - 48).min(1000000)
          i += 1
        }
        exponent *= sign
      }
      let value = if first_nonzero >= 0 &&
        before_point - first_nonzero - 1 + exponent >= 308 {
        1.0 / 0.0
      } else {
        0.0
      }
      if negative {
        -value
      } else {
        value
      }
    }
  }
}

///|
// Tcl 8.6 applies the power-of-two asymmetric interval in reversed order
// when shortening (larger tolerance below, smaller above). Preserve that
// observable text choice; typed object identity and
// its subsequent coercions remain a separate interpreter concern.
fn tcl_shortest_power(value : Double) -> String {
  let bits = value.reinterpret_as_uint64()
  let biased = ((bits >> 52) & 2047UL).to_int()
  if biased == 0 || (bits & 4503599627370495UL) != 0 {
    return value.to_string()
  }
  let (n, d) = double_fraction(value)
  let exponent = decimal_exponent(n, d)
  let half_shift = biased - 1023 - 53
  let en = if half_shift >= 0 { 1N << half_shift } else { 1N }
  let ed = if half_shift < 0 { 1N << -half_shift } else { 1N }
  for precision in 1..<=17 {
    let scale = precision - 1 - exponent
    let scale_n = if scale >= 0 { decimal_power(scale) } else { 1N }
    let scale_d = if scale < 0 { decimal_power(-scale) } else { 1N }
    let denominator = d * scale_d
    let remainder = n * scale_n % denominator
    // Tcl first tests the truncated candidate, then rounds it to nearest
    // even. That rounded candidate need not satisfy the other-side bound.
    if remainder * ed <= en * d * scale_n ||
      (denominator - remainder) * ed * 2N <= en * d * scale_n {
      return format_real(value, 'g', precision, false)
    }
  }
  value.to_string()
}

///|
fn decimal_round(
  n : @bigint.BigInt,
  d : @bigint.BigInt,
  scale : Int,
) -> @bigint.BigInt {
  let a = if scale >= 0 { n * decimal_power(scale) } else { n }
  let b = if scale < 0 { d * decimal_power(-scale) } else { d }
  let q = a / b
  let twice = a % b * 2N
  if twice > b || (twice == b && (q & 1N) == 1N) {
    q + 1N
  } else {
    q
  }
}

///|
fn decimal_exponent(n : @bigint.BigInt, d : @bigint.BigInt) -> Int {
  if n == 0N {
    return 0
  }
  if n >= d {
    return (n / d).to_string().length() - 1
  }
  let mut scaled = n
  let mut exponent = 0
  while scaled < d {
    scaled *= 10N
    exponent -= 1
  }
  exponent
}

///|
fn decimal_place(digits : String, point : Int, force_point : Bool) -> String {
  if point <= 0 {
    "0." + "0".repeat(-point) + digits
  } else if point >= digits.length() {
    digits +
    "0".repeat(point - digits.length()) +
    (if force_point { "." } else { "" })
  } else {
    unit_slice(digits, 0, point) +
    "." +
    unit_slice(digits, point, digits.length())
  }
}

///|
fn decimal_scientific(
  digits : String,
  exponent : Int,
  uppercase : Bool,
  force_point : Bool,
) -> String {
  let sign = if exponent < 0 { "-" } else { "+" }
  let exp = (if exponent < 0 { -exponent } else { exponent }).to_string()
  unit_slice(digits, 0, 1) +
  (if digits.length() > 1 || force_point { "." } else { "" }) +
  unit_slice(digits, 1, digits.length()) +
  (if uppercase { "E" } else { "e" }) +
  sign +
  (if exp.length() < 2 { "0" } else { "" }) +
  exp
}

///|
fn format_real(
  value : Double,
  kind : Char,
  precision : Int,
  alternate : Bool,
) -> String {
  let (n, d) = double_fraction(value)
  if kind == 'f' {
    // Binary64 fractions terminate within 1074 decimal fractional digits.
    let effective = precision.min(1074)
    let raw = decimal_round(n, d, effective).to_string()
    let digits = "0".repeat((effective + 1 - raw.length()).max(0)) + raw
    let point = digits.length() - effective
    return decimal_place(
      digits + "0".repeat(precision - effective),
      point,
      alternate,
    )
  }
  let general = kind == 'g' || kind == 'G'
  let significant = if general { precision.max(1) } else { precision + 1 }
  let effective = significant.min(1100)
  let mut exponent = decimal_exponent(n, d)
  let mut rounded = decimal_round(n, d, effective - 1 - exponent)
  if rounded.to_string().length() > effective {
    rounded = rounded / 10N
    exponent += 1
  }
  let raw = rounded.to_string()
  let mut digits = "0".repeat((effective - raw.length()).max(0)) +
    raw +
    "0".repeat(significant - effective)
  if general && !alternate {
    let mut end = digits.length()
    while end > 1 && digits.get(end - 1).unwrap().to_int() == 48 {
      end -= 1
    }
    digits = unit_slice(digits, 0, end)
  }
  if !general || exponent < -4 || exponent >= significant {
    decimal_scientific(digits, exponent, kind == 'E' || kind == 'G', alternate)
  } else {
    decimal_place(digits, exponent + 1, alternate)
  }
}
