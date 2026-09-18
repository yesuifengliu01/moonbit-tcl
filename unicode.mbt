///|
fn unicode_mask(code : Int) -> Int {
  let cp = code & 65535
  let mut low = 0
  let mut high = unicode_properties.length()
  while low < high {
    let mid = (low + high) / 2
    let (first, last, mask) = unicode_properties[mid]
    if cp < first {
      high = mid
    } else if cp > last {
      low = mid + 1
    } else {
      // Tcl 8.6's category predicates use the low 16 bits of a decoded
      // codepoint. Its ASCII and hexadecimal predicates check the full value.
      return if code > 65535 { mask & 4091 } else { mask }
    }
  }
  0
}

///|
fn unicode_case_unit(code : Int, mode : Int) -> Int {
  if code < 128 {
    if mode == 0 && code >= 65 && code <= 90 {
      return code + 32
    }
    if mode != 0 && code >= 97 && code <= 122 {
      return code - 32
    }
    return code
  }
  let mut low = 0
  let mut high = unicode_cases.length()
  while low < high {
    let mid = (low + high) / 2
    let (cp, lower, upper, title) = unicode_cases[mid]
    if code < cp {
      high = mid
    } else if code > cp {
      low = mid + 1
    } else {
      return if mode == 0 { lower } else if mode == 1 { upper } else { title }
    }
  }
  code
}

///|
fn unicode_case(
  text : String,
  mode : Int,
  conversion? : Bool = false,
) -> String {
  let out = StringBuilder()
  for i in 0..<text.length() {
    let cp = text.get(i).unwrap().to_int()
    let selected = if mode == 2 && i > 0 { 0 } else { mode }
    let mapped = if mode == 2 && i > 0 && cp >= 7312 && cp < 7360 {
      cp
    } else {
      unicode_case_unit(cp, selected)
    }
    // Tcl's in-place UTF-8 conversion never grows a character's byte width.
    // Nocase comparisons use the unrestricted simple lowercase mapping.
    let mapped = if conversion && cp < 2048 && mapped >= 2048 {
      cp
    } else {
      mapped
    }
    out.write_char(mapped.unsafe_to_char())
  }
  out.to_string()
}

///|
fn unit_text(code : Int) -> String {
  String::from_array([code.unsafe_to_char()])
}

///|
// Tcl's exact lsearch checks encoded length before its nocase comparison.
fn tcl_utf8_length(text : String) -> Int {
  let mut length = 0
  for i in 0..<text.length() {
    let cp = text.get(i).unwrap().to_int()
    length += if cp > 0 && cp < 128 { 1 } else if cp < 2048 { 2 } else { 3 }
  }
  length
}

///|
fn utf16_units(text : String) -> Array[Char] {
  Array::makei(text.length(), i => {
    text.get(i).unwrap().to_int().unsafe_to_char()
  })
}

///|
// Callers have checked both offsets. Tcl permits splitting surrogate pairs;
// MoonBit's ordinary StringView slicing requires codepoint boundaries.
fn unit_slice(text : String, start : Int, end : Int) -> String {
  String::unsafe_substring(text, start~, end~)
}

///|
fn unicode_reverse(text : String) -> String {
  let out = StringBuilder()
  let mut i = text.length()
  while i > 0 {
    let last = text.get(i - 1).unwrap().to_int()
    if last >= 56320 && last <= 57343 && i >= 2 {
      let first = text.get(i - 2).unwrap().to_int()
      if first >= 55296 && first <= 56319 {
        out.write_string(unit_slice(text, i - 2, i))
        i -= 2
        continue
      }
    }
    out.write_string(unit_slice(text, i - 1, i))
    i -= 1
  }
  out.to_string()
}
