///|
// Original UTF-16 regular-expression evaluator. AST preferences preserve Tcl's
// earliest-start / longest-or-shortest selection independently of host regexes.
priv enum ReKind {
  Empty
  Literal(Int)
  Any
  Set(ReSet)
  Anchor(Int)
  Sequence(Array[ReNode])
  Alternate(Array[ReNode])
  Repeat(ReNode, Int, Int)
  Capture(Int, ReNode)
  Uncaptured(ReNode)
  Backref(Int)
  Look(ReNode, Bool)
}

///|
priv struct ReNode {
  kind : ReKind
  preference : Int
  mut analysis : ReAnalysis?
}

///|
priv struct ReSet {
  ranges : Array[(Int, Int)]
  classes : Array[String]
  negated : Bool
}

///|
priv struct ReParser {
  chars : Array[Char]
  mut pos : Int
  mut groups : Int
  mut look_level : Int
  closed : Map[Int, Bool]
  mut notes : Int
  mode : Int // 0 ARE, 1 ERE, 2 BRE, 3 literal
  nocase : Bool
  expanded : Bool
}

///|
priv struct RePattern {
  node : ReNode
  groups : Int
  nocase : Bool
  line_stop : Bool
  line_anchor : Bool
  origin : Int
  not_bol : Bool
  notes : Int
}

///|
priv struct ReState {
  pos : Int
  captures : Array[(Int, Int)] // exclusive end; -1 denotes no participating group
}

///|
fn re_error(message : String, code : String) -> Unit raise TclError {
  raise Signal(
    completion_error(
      "couldn't compile regular expression pattern: " + message,
      errorcode=format_list(["REGEXP", "REG_" + code, message]),
    ),
  )
}

///|
fn re_node(kind : ReKind, preference? : Int = 0) -> ReNode {
  { kind, preference, analysis: None, }
}

///|
fn ReParser::peek(self : ReParser, offset? : Int = 0) -> Char {
  self.chars.get(self.pos + offset).unwrap_or('\u0000')
}

///|
fn ReParser::skip(self : ReParser) -> Unit raise TclError {
  while self.pos < self.chars.length() {
    if self.expanded && (unicode_mask(self.peek().to_int()) & 512) != 0 {
      self.notes = self.notes | 128
      self.pos += 1
    } else if self.expanded && self.peek() == '#' {
      self.notes = self.notes | 128
      while self.pos < self.chars.length() && self.peek() != '\n' {
        self.pos += 1
      }
    } else if self.mode == 0 &&
      self.peek() == '(' &&
      self.peek(offset=1) == '?' &&
      self.peek(offset=2) == '#' {
      self.notes = self.notes | 128
      self.pos += 3
      while self.pos < self.chars.length() && self.peek() != ')' {
        self.pos += 1
      }
      if self.pos == self.chars.length() {
        re_error("parentheses () not balanced", "EPAREN")
      }
      self.pos += 1
    } else {
      break
    }
  }
}

///|
fn ReParser::closing(self : ReParser) -> Bool {
  if self.mode == 2 {
    self.peek() == '\\' && self.peek(offset=1) == ')'
  } else {
    self.peek() == ')'
  }
}

///|
fn ReParser::expression(
  self : ReParser,
  depth : Int,
  look : Bool,
) -> ReNode raise TclError {
  if depth > 64 {
    raise Invalid("regexp nesting limit")
  }
  let branches = []
  while true {
    let nodes : Array[ReNode] = []
    let mut preference = 0
    while true {
      self.skip()
      if self.pos == self.chars.length() ||
        (self.closing() && !(self.mode == 1 && depth == 0)) ||
        (self.mode != 2 && self.peek() == '|') {
        break
      }
      let first = nodes.is_empty() ||
        (self.mode == 2 && nodes.length() == 1 && nodes[0].kind is Anchor(0))
      let atom = self.atom(depth, look, first)
      self.skip()
      let mut min = -1
      let mut max = -1
      let mut exact = false
      if self.peek() == '*' && !(self.mode == 2 && atom.kind is Anchor(0)) {
        min = 0
        self.pos += 1
      } else if self.mode != 2 && self.peek() == '+' {
        min = 1
        self.pos += 1
      } else if self.mode != 2 && self.peek() == '?' {
        min = 0
        max = 1
        self.pos += 1
      } else if (
          self.mode != 2 &&
          self.peek() == '{' &&
          self.peek(offset=1) >= '0' &&
          self.peek(offset=1) <= '9'
        ) ||
        (self.mode == 2 && self.peek() == '\\' && self.peek(offset=1) == '{') {
        self.notes = self.notes | 4
        self.pos += if self.mode == 2 { 2 } else { 1 }
        min = self.bound()
        max = min
        exact = true
        if self.peek() == ',' {
          exact = false
          self.pos += 1
          max = if self.peek() >= '0' && self.peek() <= '9' {
            self.bound()
          } else {
            -1
          }
        }
        if self.mode == 2 {
          if self.peek() != '\\' || self.peek(offset=1) != '}' {
            re_error("braces {} not balanced", "EBRACE")
          }
          self.pos += 2
        } else {
          if self.peek() != '}' {
            re_error("braces {} not balanced", "EBRACE")
          }
          self.pos += 1
        }
        if max >= 0 && max < min {
          re_error("invalid repetition count(s)", "BADBR")
        }
      }
      let node = if min >= 0 {
        match atom.kind {
          Anchor(_) | Look(_, _) =>
            re_error("quantifier operand invalid", "BADRPT")
          _ => ()
        }
        let mut reluctant = false
        if self.mode == 0 && self.peek() == '?' {
          self.notes = self.notes | 128
          self.notes = self.notes | 128
          reluctant = true
          self.pos += 1
        }
        re_quantified(
          atom,
          min,
          max,
          if exact {
            atom.preference
          } else if reluctant {
            -1
          } else {
            1
          },
        )
      } else {
        atom
      }
      if preference == 0 {
        preference = node.preference
      }
      nodes.push(node)
    }
    if nodes.is_empty() {
      self.notes = self.notes | 256
    }
    branches.push(
      if nodes.length() == 1 {
        nodes[0]
      } else {
        re_node(Sequence(nodes), preference~)
      },
    )
    if self.mode == 2 || self.peek() != '|' {
      break
    }
    self.pos += 1
  }
  if branches.length() == 1 {
    branches[0]
  } else {
    re_node(Alternate(branches), preference=1)
  }
}

///|
fn re_has_backref(node : ReNode) -> Bool {
  match node.kind {
    Backref(_) => true
    Sequence(nodes) | Alternate(nodes) => nodes.iter().any(re_has_backref)
    Capture(_, child) | Repeat(child, _, _) | Look(child, _) =>
      re_has_backref(child)
    _ => false
  }
}

///|
fn re_quantified(
  atom : ReNode,
  min : Int,
  max : Int,
  preference : Int,
) -> ReNode {
  if min == 1 && max == 1 {
    return re_node(Sequence([atom]), preference~)
  }
  // The mandatory final iteration owns captures. The preceding repetitions
  // choose their combined span using the quantifier's length preference.
  if min > 0 && !re_has_backref(atom) {
    let prefix = re_node(
      Repeat(
        re_node(Uncaptured(atom)),
        min - 1,
        if max < 0 {
          -1
        } else {
          max - 1
        },
      ),
      preference~,
    )
    return re_node(Sequence([prefix, atom]), preference~)
  }
  re_node(Repeat(atom, min, max), preference~)
}

///|
fn ReParser::bound(self : ReParser) -> Int raise TclError {
  let start = self.pos
  let mut result = 0
  while self.peek() >= '0' &&
        self.peek() <= '9' &&
        self.pos < self.chars.length() {
    result = result * 10 + self.peek().to_int() - 48
    if result > 255 {
      re_error("invalid repetition count(s)", "BADBR")
    }
    self.pos += 1
  }
  if self.pos == start {
    re_error("invalid repetition count(s)", "BADBR")
  }
  result
}

///|
fn ReParser::atom(
  self : ReParser,
  depth : Int,
  look : Bool,
  first : Bool,
) -> ReNode raise TclError {
  let c = self.peek()
  self.pos += 1
  if (self.mode != 2 && c == '(') ||
    (self.mode == 2 && c == '\\' && self.peek() == '(') {
    if self.mode == 2 {
      self.pos += 1
    }
    let mut capture = !look
    let mut assertion = 0
    if self.mode == 0 && self.peek() == '?' {
      self.notes = self.notes | 128
      self.pos += 1
      match self.peek() {
        ':' => capture = false
        '=' => {
          capture = false
          assertion = 1
        }
        '!' => {
          capture = false
          assertion = -1
        }
        _ => re_error("quantifier operand invalid", "BADRPT")
      }
      self.pos += 1
    }
    let group = if capture {
      self.groups += 1
      self.groups
    } else {
      0
    }
    if self.groups > 64 {
      raise Invalid("regexp capture limit")
    }
    if assertion != 0 {
      self.notes = self.notes | 2
      self.look_level += 1
    }
    let inner = self.expression(depth + 1, assertion != 0)
    if assertion != 0 {
      self.look_level -= 1
    }
    if !self.closing() {
      re_error("parentheses () not balanced", "EPAREN")
    }
    self.pos += if self.mode == 2 { 2 } else { 1 }
    if assertion != 0 {
      return re_node(Look(inner, assertion > 0))
    }
    if capture {
      self.closed[group] = true
      return re_node(Capture(group, inner), preference=inner.preference)
    }
    return inner
  }
  if self.mode == 2 &&
    ((c == '^' && first && depth > 0) || (c == '$' && self.closing())) {
    self.notes = self.notes | 256
  }
  if self.mode != 2 && c == '{' {
    self.notes = self.notes | 8 | 256
  }
  if self.mode == 1 && c == ')' {
    self.notes = self.notes | 32
  }
  match c {
    '[' => self.bracket()
    '.' => re_node(Any)
    '^' if self.mode != 2 || first => re_node(Anchor(0))
    '$' if self.mode != 2 || self.pos == self.chars.length() || self.closing() =>
      re_node(Anchor(1))
    '\\' => self.escape(false, self.look_level > 0)
    '*' if self.mode == 2 && first => re_node(Literal(42))
    '*' | '+' | '?' if self.mode != 2 || c == '*' => {
      re_error("quantifier operand invalid", "BADRPT")
      re_node(Empty)
    }
    '{' if self.mode != 2 && self.peek() >= '0' && self.peek() <= '9' => {
      re_error("quantifier operand invalid", "BADRPT")
      re_node(Empty)
    }
    _ => re_node(Literal(c.to_int()))
  }
}

///|
fn ReParser::escape(
  self : ReParser,
  bracket : Bool,
  look : Bool,
) -> ReNode raise TclError {
  if self.pos == self.chars.length() {
    re_error("invalid escape \\ sequence", "EESCAPE")
  }
  let c = self.peek()
  self.pos += 1
  let alnum = (unicode_mask(c.to_int()) & 1) != 0
  if self.mode == 0 && alnum {
    self.notes = self.notes | 128
  }
  if self.mode != 0 {
    if self.mode == 2 && !bracket {
      if c == '<' {
        self.notes = self.notes | 128 | 1024
        return re_node(Anchor(4))
      }
      if c == '>' {
        self.notes = self.notes | 128 | 1024
        return re_node(Anchor(5))
      }
      if c >= '1' && c <= '9' {
        let number = c.to_int() - 48
        if !self.closed.contains(number) {
          re_error("invalid backreference number", "ESUBREG")
        }
        self.notes = self.notes | 1
        return re_node(Backref(number))
      }
    }
    if alnum {
      self.notes = self.notes | 16 | 256
    }
    return re_node(Literal(c.to_int()))
  }
  if c >= '0' && c <= '9' {
    let start = self.pos - 1
    let mut end = self.pos
    let mut number = c.to_int() - 48
    while end < self.chars.length() &&
          self.chars[end] >= '0' &&
          self.chars[end] <= '9' {
      number = (number * 10 + self.chars[end].to_int() - 48).min(100000)
      end += 1
    }
    if c != '0' && (end == self.pos || self.closed.contains(number)) {
      if bracket || look || !self.closed.contains(number) {
        re_error("invalid backreference number", "ESUBREG")
      }
      self.notes = self.notes | 1
      self.pos = end
      return re_node(Backref(number))
    }
    self.notes = self.notes | 512
    self.pos = start
    number = 0
    let limit = if c <= '3' { 3 } else { 2 }
    while self.pos < start + limit &&
          self.pos < self.chars.length() &&
          self.peek() >= '0' &&
          self.peek() <= '7' {
      number = number * 8 + self.peek().to_int() - 48
      self.pos += 1
    }
    if self.pos == start {
      re_error("invalid escape \\ sequence", "EESCAPE")
    }
    return re_node(Literal(number))
  }
  if c == 'c' || c == 'e' || c == 'x' {
    self.notes = self.notes | 512
  }
  if "dDsSwWmMyY".contains(c.to_string()) {
    self.notes = self.notes | 1024
  }
  match c {
    'a' => re_node(Literal(7))
    'b' => re_node(Literal(8))
    'B' => re_node(Literal(92))
    'e' => re_node(Literal(27))
    'f' => re_node(Literal(12))
    'n' => re_node(Literal(10))
    'r' => re_node(Literal(13))
    't' => re_node(Literal(9))
    'v' => re_node(Literal(11))
    'c' => {
      if self.pos == self.chars.length() {
        re_error("invalid escape \\ sequence", "EESCAPE")
      }
      let value = self.peek().to_int() & 31
      self.pos += 1
      re_node(Literal(value))
    }
    'x' | 'u' | 'U' => {
      let start = self.pos
      let limit = if c == 'x' { 2 } else if c == 'u' { 4 } else { 8 }
      let mut value = 0
      while self.pos < start + limit &&
            self.pos < self.chars.length() &&
            hex_digit(self.peek()) >= 0 {
        let next = value * 16 + hex_digit(self.peek())
        if next > 1114111 {
          break
        }
        value = next
        self.pos += 1
      }
      if self.pos == start {
        re_error("invalid escape \\ sequence", "EESCAPE")
      }
      re_node(Literal(if value > 65535 { 65533 } else { value }))
    }
    'd' | 's' | 'w' | 'D' | 'S' | 'W' => {
      let negative = c == 'D' || c == 'S' || c == 'W'
      if bracket && negative {
        re_error("invalid escape \\ sequence", "EESCAPE")
      }
      re_node(
        Set({
          ranges: [],
          classes: [
            if c == 'd' || c == 'D' {
              "digit"
            } else if c == 's' || c == 'S' {
              "space"
            } else {
              "word"
            },
          ],
          negated: negative,
        }),
      )
    }
    'A' | 'Z' | 'm' | 'M' | 'y' | 'Y' => {
      if bracket {
        re_error("invalid escape \\ sequence", "EESCAPE")
      }
      re_node(
        Anchor(
          match c {
            'A' => 2
            'Z' => 3
            'm' => 4
            'M' => 5
            'y' => 6
            _ => 7
          },
        ),
      )
    }
    _ => {
      if (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') {
        re_error("invalid escape \\ sequence", "EESCAPE")
      }
      re_node(Literal(c.to_int()))
    }
  }
}

///|
fn re_collating(name : String) -> Int raise TclError {
  if name.length() == 1 {
    return name.at(0).to_int()
  }
  let controls = [
    "NUL", "SOH", "STX", "ETX", "EOT", "ENQ", "ACK", "BEL", "BS", "HT", "LF", "VT",
    "FF", "CR", "SO", "SI", "DLE", "DC1", "DC2", "DC3", "DC4", "NAK", "SYN", "ETB",
    "CAN", "EM", "SUB", "ESC", "IS4", "IS3", "IS2", "IS1",
  ]
  if controls.search(name) is Some(i) {
    return i
  }
  match name {
    "alert" => 7
    "backspace" => 8
    "tab" => 9
    "newline" => 10
    "vertical-tab" => 11
    "form-feed" => 12
    "carriage-return" => 13
    "space" => 32
    "hyphen" | "hyphen-minus" => 45
    "exclamation-mark" => 33
    "quotation-mark" => 34
    "number-sign" => 35
    "dollar-sign" => 36
    "percent-sign" => 37
    "ampersand" => 38
    "apostrophe" => 39
    "left-parenthesis" => 40
    "right-parenthesis" => 41
    "asterisk" => 42
    "plus-sign" => 43
    "comma" => 44
    "period" | "full-stop" => 46
    "slash" | "solidus" => 47
    "colon" => 58
    "semicolon" => 59
    "less-than-sign" => 60
    "equals-sign" => 61
    "greater-than-sign" => 62
    "question-mark" => 63
    "commercial-at" => 64
    "left-square-bracket" => 91
    "backslash" | "reverse-solidus" => 92
    "right-square-bracket" => 93
    "circumflex" | "circumflex-accent" => 94
    "underscore" | "low-line" => 95
    "grave-accent" => 96
    "left-brace" | "left-curly-bracket" => 123
    "vertical-line" => 124
    "right-brace" | "right-curly-bracket" => 125
    "tilde" => 126
    "DEL" => 127
    _ => {
      re_error("invalid collating element", "ECOLLATE")
      0
    }
  }
}

///|
fn ReParser::class_item(self : ReParser) -> ReNode raise TclError {
  if self.pos == self.chars.length() {
    re_error("brackets [] not balanced", "EBRACK")
  }
  let c = self.peek()
  self.pos += 1
  if c == '[' &&
    (self.peek() == ':' || self.peek() == '.' || self.peek() == '=') {
    let kind = self.peek()
    self.pos += 1
    let start = self.pos
    while self.pos < self.chars.length() &&
          !(self.peek() == kind && self.peek(offset=1) == ']') {
      self.pos += 1
    }
    if self.pos == self.chars.length() {
      re_error("brackets [] not balanced", "EBRACK")
    }
    let name = String::from_array(self.chars[start:self.pos])
    self.pos += 2
    if kind == ':' || kind == '=' {
      self.notes = self.notes | 1024
    }
    if kind == ':' {
      if ![
          "alnum", "alpha", "ascii", "blank", "cntrl", "digit", "graph", "lower",
          "print", "punct", "space", "upper", "xdigit",
        ].contains(name) {
        re_error("invalid character class", "ECTYPE")
      }
      return re_node(Set({ ranges: [], classes: [name], negated: false, }))
    }
    let value = re_collating(name)
    return if kind == '=' {
      re_node(Set({ ranges: [(value, value)], classes: [], negated: false, }))
    } else {
      re_node(Literal(value))
    }
  }
  if c == '\\' {
    self.notes = self.notes | 64
    if self.mode == 0 {
      self.notes = self.notes | 128
    }
  }
  if c == '\\' && self.mode == 0 {
    self.escape(true, false)
  } else {
    re_node(Literal(c.to_int()))
  }
}

///|
fn ReParser::bracket(self : ReParser) -> ReNode raise TclError {
  if self.peek() == '[' &&
    self.peek(offset=1) == ':' &&
    (self.peek(offset=2) == '<' || self.peek(offset=2) == '>') &&
    self.peek(offset=3) == ':' &&
    self.peek(offset=4) == ']' &&
    self.peek(offset=5) == ']' {
    self.notes = self.notes | 128 | 1024
    let direction = self.peek(offset=2)
    self.pos += 6
    return re_node(Anchor(if direction == '<' { 4 } else { 5 }))
  }
  let negated = self.peek() == '^'
  if negated {
    self.pos += 1
  }
  let ranges = []
  let classes = []
  let mut first = true
  while self.pos < self.chars.length() && (first || self.peek() != ']') {
    let atom = self.class_item()
    first = false
    if self.peek() == '-' && self.peek(offset=1) != ']' {
      self.pos += 1
      let last = self.class_item()
      match (atom.kind, last.kind) {
        (Literal(a), Literal(b)) if a <= b => {
          if a != b {
            self.notes = self.notes | 512
          }
          ranges.push((a, b))
          if self.peek() == '-' && self.peek(offset=1) != ']' {
            re_error("invalid character range", "ERANGE")
          }
        }
        _ => re_error("invalid character range", "ERANGE")
      }
    } else {
      match atom.kind {
        Literal(c) => ranges.push((c, c))
        Set(set) => {
          for pair in set.ranges {
            ranges.push(pair)
          }
          for name in set.classes {
            classes.push(name)
          }
        }
        _ => re_error("invalid character range", "ERANGE")
      }
    }
  }
  if self.pos == self.chars.length() {
    re_error("brackets [] not balanced", "EBRACK")
  }
  self.pos += 1
  if self.nocase {
    let originals = ranges.copy()
    for cp in 65..<=90 {
      if originals.iter().any(r => cp >= r.0 && cp <= r.1) {
        ranges.push((cp + 32, cp + 32))
      }
    }
    for cp in 97..<=122 {
      if originals.iter().any(r => cp >= r.0 && cp <= r.1) {
        ranges.push((cp - 32, cp - 32))
      }
    }
    for (cp, lower, upper, title) in unicode_cases {
      if originals.iter().any(r => cp >= r.0 && cp <= r.1) {
        ranges.push((lower, lower))
        ranges.push((upper, upper))
        ranges.push((title, title))
      }
    }
  }
  re_node(Set({ ranges, classes, negated, }))
}

///|
fn re_compile(
  source : String,
  nocase : Bool,
  expanded? : Bool = false,
  line_stop? : Bool = false,
  line_anchor? : Bool = false,
) -> RePattern raise TclError {
  if source.length() > 4096 {
    raise Invalid("regexp pattern size limit")
  }
  let chars = utf16_units(source)
  let mut pos = 0
  let mut mode = 0
  let mut nocase = nocase
  let mut expanded = expanded
  let mut line_stop = line_stop
  let mut line_anchor = line_anchor
  if source.has_prefix("***=") {
    pos = 4
    mode = 3
  } else if source.has_prefix("***:") {
    pos = 4
  } else if source.has_prefix("***") {
    re_error("quantifier operand invalid", "BADRPT")
  }
  if mode == 0 &&
    pos + 2 < chars.length() &&
    chars[pos] == '(' &&
    chars[pos + 1] == '?' &&
    chars[pos + 2] >= 'a' &&
    chars[pos + 2] <= 'z' {
    pos += 2
    while pos < chars.length() && chars[pos] != ')' {
      match chars[pos] {
        'b' => mode = 2
        'e' => mode = 1
        'q' => mode = 3
        'i' => nocase = true
        'c' => nocase = false
        'x' => expanded = true
        't' => expanded = false
        'n' | 'm' => {
          line_stop = true
          line_anchor = true
        }
        'p' => {
          line_stop = true
          line_anchor = false
        }
        'w' => {
          line_stop = false
          line_anchor = true
        }
        's' => {
          line_stop = false
          line_anchor = false
        }
        _ => re_error("invalid embedded option", "BADOPT")
      }
      pos += 1
    }
    if pos == chars.length() {
      re_error("invalid embedded option", "BADOPT")
    }
    pos += 1
  }
  let parser = {
    chars,
    pos,
    groups: 0,
    look_level: 0,
    closed: Map([]),
    notes: if pos > 0 {
      128
    } else {
      0
    },
    mode,
    nocase,
    expanded,
  }
  if pos == chars.length() {
    parser.notes = parser.notes | 256
  }
  let node = if mode == 3 {
    re_node(
      Sequence(
        chars[pos:].iter().map(c => re_node(Literal(c.to_int()))).collect(),
      ),
    )
  } else {
    parser.expression(0, false)
  }
  if mode != 3 && parser.pos != chars.length() {
    re_error("parentheses () not balanced", "EPAREN")
  }
  {
    node,
    groups: parser.groups,
    nocase,
    line_stop,
    line_anchor,
    origin: 0,
    not_bol: false,
    notes: parser.notes,
  }
}
