///|
// A finite relation over adjacent character categories. This analyzes the
// regular approximation of captures/backreferences, not execution results.
// Categories: boundary, newline, word character, other character.
priv struct ReAnalysis {
  possible : Array[Int]
  empty : Array[Int]
}

///|
fn re_identity() -> Array[Int] {
  Array::makei(16, i => 1 << i)
}

///|
fn re_union(a : Array[Int], b : Array[Int]) -> Array[Int] {
  Array::makei(16, i => a[i] | b[i])
}

///|
fn re_compose(a : Array[Int], b : Array[Int]) -> Array[Int] {
  Array::makei(16, i => {
    let mut row = 0
    for k in 0..<16 {
      if (a[i] & (1 << k)) != 0 {
        row = row | b[k]
      }
    }
    row
  })
}

///|
fn re_power(a : Array[Int], count : Int) -> Array[Int] {
  let mut result = re_identity()
  let mut base = a
  let mut count = count
  while count > 0 {
    if (count & 1) != 0 {
      result = re_compose(result, base)
    }
    count = count >> 1
    if count > 0 {
      base = re_compose(base, base)
    }
  }
  result
}

///|
fn re_repeat_relation(a : Array[Int], min : Int, max : Int) -> Array[Int] {
  let mut tail = re_identity()
  if max < 0 {
    tail = re_union(tail, a)
    for k in 0..<16 {
      for i in 0..<16 {
        if (tail[i] & (1 << k)) != 0 {
          tail[i] = tail[i] | tail[k]
        }
      }
    }
  } else {
    let mut step = re_identity()
    for _ in min..<max {
      step = re_compose(step, a)
      tail = re_union(tail, step)
    }
  }
  re_compose(re_power(a, min), tail)
}

///|
fn re_category(cp : Int) -> Int {
  if cp == 10 {
    1
  } else if re_class("word", cp, false) {
    2
  } else {
    3
  }
}

///|
fn Interpreter::re_analyze(
  self : Interpreter,
  node : ReNode,
  pattern : RePattern,
  groups : Map[Int, ReAnalysis],
) -> ReAnalysis raise TclError {
  self.tick()
  if node.analysis is Some(cached) {
    return cached
  }
  let zero = Array::make(16, 0)
  let result = match node.kind {
    Empty => { possible: re_identity(), empty: re_identity(), }
    Literal(_) | Any | Set(_) => {
      let mut categories = 0
      match node.kind {
        Literal(cp) => categories = 1 << re_category(cp)
        Any => categories = if pattern.line_stop { 12 } else { 14 }
        Set(set) => categories = self.re_set_categories(set, pattern)
        _ => ()
      }
      let possible = Array::makei(16, i => {
        let next = i % 4
        if (categories & (1 << next)) != 0 {
          15 << (next * 4)
        } else {
          0
        }
      })
      { possible, empty: zero, }
    }
    Anchor(kind) => {
      let relation = Array::makei(16, i => {
        let previous = i / 4
        let next = i % 4
        let valid = match kind {
          0 => previous == 0 || (pattern.line_anchor && previous == 1)
          1 => next == 0 || (pattern.line_anchor && next == 1)
          2 => previous == 0
          3 => next == 0
          4 => previous != 2 && next == 2
          5 => previous == 2 && next != 2
          6 => (previous == 2) != (next == 2)
          _ => (previous == 2) == (next == 2)
        }
        if valid {
          1 << i
        } else {
          0
        }
      })
      { possible: relation, empty: relation, }
    }
    Sequence(nodes) => {
      let mut possible = re_identity()
      let mut empty = re_identity()
      for child in nodes {
        let info = self.re_analyze(child, pattern, groups)
        possible = re_compose(possible, info.possible)
        empty = re_compose(empty, info.empty)
      }
      { possible, empty, }
    }
    Alternate(nodes) => {
      let mut possible = zero
      let mut empty = zero
      for child in nodes {
        let info = self.re_analyze(child, pattern, groups)
        possible = re_union(possible, info.possible)
        empty = re_union(empty, info.empty)
      }
      { possible, empty, }
    }
    Repeat(child, min, max) => {
      let info = self.re_analyze(child, pattern, groups)
      {
        possible: re_repeat_relation(info.possible, min, max),
        empty: re_repeat_relation(info.empty, min, max),
      }
    }
    Capture(group, child) => {
      let info = self.re_analyze(child, pattern, groups)
      groups[group] = info
      info
    }
    Uncaptured(child) => self.re_analyze(child, pattern, groups)
    Backref(group) =>
      groups.get(group).unwrap_or({ possible: zero, empty: zero, })
    Look(child, _) => {
      ignore(self.re_analyze(child, pattern, groups))
      // Lookahead remains an opaque assertion edge in native compile metadata.
      { possible: re_identity(), empty: zero, }
    }
  }
  node.analysis = Some(result)
  result
}

///|
fn Interpreter::re_about(
  self : Interpreter,
  pattern : RePattern,
) -> TclValue raise TclError {
  let info = self.re_analyze(pattern.node, pattern, Map([]))
  let mut notes = pattern.notes
  if !info.possible.iter().any(row => row != 0) {
    notes = notes | 4096
  } else if info.empty.iter().any(row => row != 0) {
    notes = notes | 2048
  }
  if pattern.node.preference < 0 {
    notes = notes | 8192
  }
  let names = [
    "REG_UBACKREF", "REG_ULOOKAHEAD", "REG_UBOUNDS", "REG_UBRACES", "REG_UBSALNUM",
    "REG_UPBOTCH", "REG_UBBS", "REG_UNONPOSIX", "REG_UUNSPEC", "REG_UUNPORT", "REG_ULOCALE",
    "REG_UEMPTYMATCH", "REG_UIMPOSSIBLE", "REG_USHORTEST",
  ]
  let properties = []
  for i in 0..<names.length() {
    if (notes & (1 << i)) != 0 {
      properties.push(text_value(names[i]))
    }
  }
  list_value([text_value(pattern.groups.to_string()), list_value(properties)])
}

///|
fn re_range_categories(first : Int, last : Int) -> Int {
  if first > last {
    return 0
  }
  let mut categories = if first <= 10 && last >= 10 { 2 } else { 0 }
  for (low, high, mask) in unicode_properties {
    if high < first {
      continue
    }
    if low > last {
      break
    }
    let a = low.max(first)
    let b = high.min(last)
    if (mask & 2048) != 0 {
      categories = categories | 4
    } else if a != 10 || b != 10 {
      categories = categories | 8
    }
    if categories == 14 {
      break
    }
  }
  categories
}

///|
fn Interpreter::re_set_categories(
  self : Interpreter,
  set : ReSet,
  pattern : RePattern,
) -> Int raise TclError {
  if !set.negated {
    let mut categories = 0
    for (first, last) in set.ranges {
      self.tick()
      categories = categories | re_range_categories(first, last)
    }
    for name in set.classes {
      categories = categories |
        (match name {
          "alnum" | "alpha" | "digit" | "lower" | "upper" | "word" | "xdigit" =>
            4
          "space" | "cntrl" => 10
          "blank" | "punct" => 8
          "graph" | "print" => 12
          _ => 14
        })
    }
    return categories
  }
  let excluded = set.ranges.copy()
  if pattern.line_stop {
    excluded.push((10, 10))
  }
  for name in set.classes {
    if name == "blank" {
      excluded.push((9, 9))
      excluded.push((32, 32))
    } else {
      for (low, high, _) in unicode_properties {
        self.tick()
        if re_class(name, low, pattern.nocase) {
          excluded.push((low, high))
        }
      }
    }
  }
  excluded.sort_by((a, b) => a.0.compare(b.0))
  let mut next = 0
  let mut categories = 0
  for (low, high) in excluded {
    self.tick()
    if low > next {
      categories = categories | re_range_categories(next, low - 1)
    }
    next = next.max(high + 1)
  }
  categories = categories | re_range_categories(next, 65535)
  // The native color alphabet retains an unused color beyond the BMP.
  if categories == 0 {
    8
  } else {
    categories
  }
}
