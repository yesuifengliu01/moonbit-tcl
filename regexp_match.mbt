///|
fn re_class(name : String, cp : Int, nocase : Bool) -> Bool {
  if name == "blank" {
    return cp == 9 || cp == 32
  }
  let bit = match name {
    "alnum" => 1
    "alpha" => 2
    "ascii" => 4
    "cntrl" => 8
    "digit" => 16
    "graph" => 32
    "lower" => 64
    "print" => 128
    "punct" => 256
    "space" => 512
    "upper" => 1024
    "word" => 2048
    "xdigit" => 4096
    _ => 0
  }
  let mask = unicode_mask(cp)
  if nocase && (name == "lower" || name == "upper") {
    (mask & 1) != 0
  } else {
    (mask & bit) != 0
  }
}

///|
fn re_order(states : Array[ReState], preference : Int) -> Array[ReState] {
  // Explicit sequence number makes ties stable on both JS and WasmGC.
  let indexed = Array::makei(states.length(), i => (i, states[i]))
  indexed.sort_by((a, b) => {
    let order = if preference < 0 {
      a.1.pos.compare(b.1.pos)
    } else {
      b.1.pos.compare(a.1.pos)
    }
    if order == 0 {
      a.0.compare(b.0)
    } else {
      order
    }
  })
  indexed.map(p => p.1)
}

///|
fn re_clear_captures(node : ReNode, captures : Array[(Int, Int)]) -> Unit {
  match node.kind {
    Capture(group, child) => {
      captures[group] = (-1, -1)
      re_clear_captures(child, captures)
    }
    Sequence(nodes) | Alternate(nodes) =>
      for child in nodes {
        re_clear_captures(child, captures)
      }
    Repeat(child, _, _) | Look(child, _) => re_clear_captures(child, captures)
    _ => ()
  }
}

///|
fn Interpreter::re_states(
  self : Interpreter,
  pattern : RePattern,
  node : ReNode,
  text : String,
  state : ReState,
  depth : Int,
) -> Array[ReState] raise TclError {
  self.tick()
  if depth > 128 {
    raise Invalid("regexp execution nesting limit")
  }
  let at = state.pos
  let n = text.length()
  let result = match node.kind {
    Empty => [state]
    Literal(cp) => {
      let equal = at < n &&
        (if pattern.nocase {
          unicode_case_unit(text.at(at).to_int(), 0) == unicode_case_unit(cp, 0)
        } else {
          text.at(at).to_int() == cp
        })
      if equal {
        [{ ..state, pos: at + 1, }]
      } else {
        []
      }
    }
    Any =>
      if at < n && (!pattern.line_stop || text.at(at).to_int() != 10) {
        [{ ..state, pos: at + 1, }]
      } else {
        []
      }
    Set(set) => {
      if at >= n {
        return []
      }
      let raw = text.at(at).to_int()
      let cp = raw
      let included = set.ranges.iter().any(r => cp >= r.0 && cp <= r.1) ||
        set.classes.iter().any(c => re_class(c, cp, pattern.nocase))
      if included != set.negated &&
        !(set.negated && pattern.line_stop && raw == 10) {
        [{ ..state, pos: at + 1, }]
      } else {
        []
      }
    }
    Anchor(kind) => {
      let previous = at > pattern.origin &&
        re_class("word", text.at(at - 1).to_int(), false)
      let next = at < n && re_class("word", text.at(at).to_int(), false)
      let valid = match kind {
        0 =>
          (at == pattern.origin && !pattern.not_bol) ||
          (
            pattern.line_anchor &&
            at > pattern.origin &&
            text.at(at - 1).to_int() == 10
          )
        1 =>
          at == n ||
          (pattern.line_anchor && at < n && text.at(at).to_int() == 10)
        2 => at == pattern.origin
        3 => at == n
        4 => !previous && next
        5 => previous && !next
        6 => previous != next
        _ => previous == next
      }
      if valid {
        [state]
      } else {
        []
      }
    }
    Sequence(nodes) => {
      let mut current = [state]
      for child in nodes {
        let next = []
        for candidate in current {
          for
            matched in self.re_states(
              pattern,
              child,
              text,
              candidate,
              depth + 1,
            ) {
            next.push(matched)
            if next.length() > 16384 {
              raise Invalid("regexp state limit")
            }
          }
        }
        current = next
        if current.is_empty() {
          break
        }
      }
      current
    }
    Alternate(nodes) => {
      let result = []
      for child in nodes {
        for matched in self.re_states(pattern, child, text, state, depth + 1) {
          result.push(matched)
          if result.length() > 16384 {
            raise Invalid("regexp state limit")
          }
        }
      }
      result
    }
    Capture(group, child) => {
      let cleared = state.captures.copy()
      re_clear_captures(node, cleared)
      self
      .re_states(
        pattern,
        child,
        text,
        { ..state, captures: cleared, },
        depth + 1,
      )
      .map(matched => {
        let captures = matched.captures.copy()
        captures[group] = (at, matched.pos)
        { ..matched, captures, }
      })
    }
    Uncaptured(child) =>
      self
      .re_states(pattern, child, text, state, depth + 1)
      .map(matched => { ..matched, captures: state.captures, })
    Backref(group) => {
      let (start, end) = state.captures[group]
      if start < 0 || end - start > n - at {
        return []
      }
      let mut equal = true
      for i in 0..<(end - start) {
        let a = text.at(start + i).to_int()
        let b = text.at(at + i).to_int()
        if (if pattern.nocase {
            unicode_case_unit(a, 0) != unicode_case_unit(b, 0)
          } else {
            a != b
          }) {
          equal = false
          break
        }
      }
      if equal {
        [{ ..state, pos: at + end - start, }]
      } else {
        []
      }
    }
    Look(child, positive) => {
      let found = !self
        .re_states(pattern, child, text, state, depth + 1)
        .is_empty()
      if found == positive {
        [state]
      } else {
        []
      }
    }
    Repeat(child, min, max) => {
      if child.kind is Backref(group) && max != 0 && state.captures[group].0 < 0 {
        return []
      }
      let result = []
      let pending : Array[(ReState, Int)] = [(state, 0)]
      while !pending.is_empty() {
        let (candidate, count) = pending.pop().unwrap()
        if count >= min {
          result.push(candidate)
        }
        if result.length() > 16384 {
          raise Invalid("regexp state limit")
        }
        if max >= 0 && count >= max {
          continue
        }
        let captures = candidate.captures.copy()
        re_clear_captures(child, captures)
        let matches = self.re_states(
          pattern,
          child,
          text,
          { ..candidate, captures, },
          depth + 1,
        )
        // Depth-first traversal retains the child's preference between equal
        // overall spans. Optional empty iterations never create captures.
        for i = matches.length() - 1; i >= 0; i = i - 1 {
          let matched = matches[i]
          if matched.pos != candidate.pos || count < min {
            pending.push((matched, count + 1))
          }
        }
        if pending.length() > 16384 {
          raise Invalid("regexp state limit")
        }
      }
      result
    }
  }
  if result.length() > 16384 {
    raise Invalid("regexp state limit")
  }
  if result.length() > 1 {
    re_order(result, node.preference)
  } else {
    result
  }
}

///|
fn Interpreter::regexp_matches(
  self : Interpreter,
  source : TclValue,
  text : String,
  nocase : Bool,
) -> Array[(Int, Int)]? raise TclError {
  let pattern = re_compile(source.text, nocase)
  source.payload = Plain
  self.regexp_find(pattern, text, 0)
}

///|
fn Interpreter::regexp_find(
  self : Interpreter,
  compiled : RePattern,
  text : String,
  offset : Int,
) -> Array[(Int, Int)]? raise TclError {
  let origin = offset.min(text.length())
  let not_bol = offset > 0 &&
    (offset > text.length() || text.at(offset - 1).to_int() != 10)
  let pattern = { ..compiled, origin, not_bol, }
  for start in origin..<=text.length() {
    let state = {
      pos: start,
      captures: Array::make(pattern.groups + 1, (-1, -1)),
    }
    let matches = self.re_states(pattern, pattern.node, text, state, 0)
    if !matches.is_empty() {
      let found = matches[0]
      found.captures[0] = (start, found.pos)
      return Some(found.captures)
    }
  }
  None
}
