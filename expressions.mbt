///|
enum Expr {
  Value(String)
  Substitute(Array[Part])
  Unary(String, Expr)
  Binary(String, Expr, Expr)
  Conditional(Expr, Expr, Expr)
  Function(String, Array[Expr])
} derive(Debug)

///|
fn ScriptParser::expr_space(self : ScriptParser) -> Unit {
  while list_space(self.peek()) {
    self.pos += 1
  }
}

///|
fn ScriptParser::expression(
  self : ScriptParser,
  minimum : Int,
  depth : Int,
) -> Expr raise TclError {
  if depth > 64 {
    raise Invalid("expression nesting limit")
  }
  self.expr_space()
  let mut left = self.operand(depth + 1)
  while true {
    self.expr_space()
    if self.peek() == '?' && minimum <= 1 {
      self.pos += 1
      let yes = self.expression(1, depth + 1)
      self.expr_space()
      if self.peek() != ':' {
        raise Invalid("missing expression colon")
      }
      self.pos += 1
      left = Conditional(left, yes, self.expression(1, depth + 1))
      continue
    }
    let mut found = ("", 0)
    for
      (op, precedence) in [
        ("||", 2),
        ("&&", 3),
        ("|", 4),
        ("^", 5),
        ("&", 6),
        ("in", 7),
        ("ni", 7),
        ("eq", 8),
        ("ne", 8),
        ("==", 9),
        ("!=", 9),
        ("<=", 10),
        (">=", 10),
        ("<<", 11),
        (">>", 11),
        ("<", 10),
        (">", 10),
        ("+", 12),
        ("-", 12),
        ("**", 14),
        ("*", 13),
        ("/", 13),
        ("%", 13),
      ] {
      let cs = op.to_array()
      if self.pos + cs.length() <= self.chars.length() &&
        self.chars[self.pos:self.pos + cs.length()].to_owned() == cs {
        if namechar(cs[0]) && namechar(self.peek(offset=cs.length())) {
          continue
        }
        found = (op, precedence)
        break
      }
    }
    let (op, precedence) = found
    if precedence == 0 || precedence < minimum {
      break
    }
    self.pos += op.length()
    left = Binary(
      op,
      left,
      self.expression(
        if op == "**" {
          precedence
        } else {
          precedence + 1
        },
        depth + 1,
      ),
    )
  }
  left
}

///|
fn ScriptParser::operand(
  self : ScriptParser,
  depth : Int,
) -> Expr raise TclError {
  if depth > 64 {
    raise Invalid("expression nesting limit")
  }
  self.expr_space()
  let c = self.peek()
  if ['+', '-', '!', '~'].contains(c) {
    self.pos += 1
    return Unary(c.to_string(), self.operand(depth + 1))
  }
  if c == '(' {
    self.pos += 1
    let value = self.expression(1, depth + 1)
    self.expr_space()
    if self.peek() != ')' {
      raise Invalid("missing expression close-parenthesis")
    }
    self.pos += 1
    return value
  }
  if c == '{' {
    return Value(self.braces())
  }
  if c == '"' {
    self.pos += 1
    return Substitute(self.parts('"', false, depth + 1))
  }
  if c == '$' {
    return Substitute([self.variable(depth + 1)])
  }
  if c == '[' {
    self.pos += 1
    return Substitute([Command(self.script(true, depth + 1))])
  }
  let start = self.pos
  while self.pos < self.chars.length() {
    let x = self.peek()
    if list_space(x) ||
      [
        '(', ')', ',', '?', ':', '*', '/', '%', '<', '>', '=', '!', '&', '^', '|',
        '~',
      ].contains(x) {
      break
    }
    if x == '+' || x == '-' {
      let hex = self.pos >= start + 2 &&
        self.chars[start] == '0' &&
        ['x', 'X'].contains(self.chars[start + 1])
      if self.pos == start ||
        hex ||
        !['e', 'E'].contains(self.chars[self.pos - 1]) {
        break
      }
    }
    self.pos += 1
  }
  if start == self.pos {
    raise Invalid("expected expression operand")
  }
  let text = String::from_array(self.chars[start:self.pos])
  self.expr_space()
  if self.peek() == '(' {
    self.pos += 1
    self.expr_space()
    let args = []
    if self.peek() != ')' {
      while true {
        args.push(self.expression(1, depth + 1))
        self.expr_space()
        if self.peek() != ',' {
          break
        }
        self.pos += 1
      }
    }
    if self.peek() != ')' {
      raise Invalid("missing math function close-parenthesis")
    }
    self.pos += 1
    return Function(text, args)
  }
  if number(text) is None &&
    !(try {
      ignore(boolean(text))
      true
    } catch {
      _ => false
    }) {
    raise Invalid("invalid bareword " + text)
  }
  Value(text)
}

///|
fn Interpreter::eval_expr(
  self : Interpreter,
  expr : Expr,
  depth : Int,
) -> TclValue raise TclError {
  self.tick()
  if depth > 64 {
    raise Invalid("expression evaluation depth")
  }
  match expr {
    Value(value) => text_value(value)
    Substitute(parts) => self.expand_values(parts, depth + 1)
    Conditional(condition, yes, no) =>
      self.eval_expr(
        if self.eval_expr(condition, depth + 1).truth() {
          yes
        } else {
          no
        },
        depth + 1,
      )
    Unary(op, value) => {
      let v = self.eval_expr(value, depth + 1)
      if op == "!" {
        return text_value(boolean_text(!v.truth()))
      }
      if op == "~" {
        return number_value(Whole(-v.as_whole() - 1N))
      }
      let n = match v.as_number() {
        Some(n) => n
        None => raise Invalid("expected numeric operand")
      }
      match n {
        Small(x) => number_value(Small(if op == "-" { -x } else { x }))
        Whole(x) => number_value(Whole(if op == "-" { -x } else { x }))
        Real(x) => number_value(Real(if op == "-" { -x } else { x }))
      }
    }
    Binary(op, a, b) => {
      let left = self.eval_expr(a, depth + 1)
      if op == "&&" {
        return text_value(
          boolean_text(left.truth() && self.eval_expr(b, depth + 1).truth()),
        )
      }
      if op == "||" {
        return text_value(
          boolean_text(left.truth() || self.eval_expr(b, depth + 1).truth()),
        )
      }
      let right = self.eval_expr(b, depth + 1)
      if op == "/" {
        numeric_divide(left, right)
      } else {
        numeric_binary(op, left, right)
      }
    }
    Function(name, args) => {
      let values = args.map(arg => self.eval_expr(arg, depth + 1))
      self.math_function(name, values, depth + 1)
    }
  }
}

///|
fn Interpreter::expression_object(
  self : Interpreter,
  source : String,
  depth : Int,
) -> TclValue raise TclError {
  let expr = self.cached_expression(source)
  let value = self.eval_expr(expr, depth + 1)
  match value.as_number() {
    Some(n) => number_value(n)
    None => value
  }
}

///|
fn Interpreter::math(
  self : Interpreter,
  source : String,
  depth : Int,
) -> Int raise TclError {
  if boolean(self.expression_value(source, depth)) {
    1
  } else {
    0
  }
}

///|
fn Interpreter::math_function(
  self : Interpreter,
  name : String,
  args : Array[TclValue],
  depth : Int,
) -> TclValue raise TclError {
  if self.find_command("tcl::mathfunc::" + name) is Some(command) {
    return self.command_value([text_value(command.name)] + args, depth)
  }
  if name == "bool" {
    if args.length() != 1 {
      raise Invalid("math function arity")
    }
    return text_value(boolean_text(args[0].truth()))
  }
  let values = args.map(v => {
    match v.as_number() {
      Some(n) => n
      None => raise Invalid("math function requires number")
    }
  })
  if name == "min" || name == "max" {
    if values.is_empty() {
      raise Invalid("math function arity")
    }
    let mut best = args[0]
    for value in args[1:] {
      if numeric_binary(if name == "min" { "<" } else { ">" }, value, best).text ==
        "1" {
        best = value
      }
    }
    return match best.as_number() {
      Some(n) => number_value(n)
      None => best
    }
  }
  let two = ["pow", "atan2", "hypot", "fmod"].contains(name)
  if values.length() != (if two { 2 } else { 1 }) {
    raise Invalid("math function arity")
  }
  let x = values[0].double()
  let y = if two { values[1].double() } else { 0.0 }
  if name == "abs" {
    return match values[0] {
      Small(n) => number_value(Small(n.abs()))
      Whole(n) => number_value(Whole(if n < 0N { -n } else { n }))
      Real(n) => number_value(Real(n.abs()))
    }
  }
  if ["int", "wide", "entier", "round"].contains(name) {
    let n = match values[0] {
      Small(n) => @bigint.BigInt::from_int(n)
      Whole(n) => n
      Real(_) => {
        if x.is_inf() || x.is_nan() {
          raise Invalid("cannot convert non-finite integer")
        }
        let value = if name == "round" {
          if x < 0.0 {
            -(x.abs() + 0.5).floor()
          } else {
            (x + 0.5).floor()
          }
        } else if x < 0.0 {
          x.ceil()
        } else {
          x.floor()
        }
        double_integer(value)
      }
    }
    if name == "int" || name == "wide" {
      let modulus = 1N << 64
      let masked = n & (modulus - 1N)
      return number_value(
        Whole(if masked >= 1N << 63 { masked - modulus } else { masked }),
      )
    }
    return number_value(Whole(n))
  }
  let value = match name {
    "double" => x
    "ceil" => x.ceil()
    "floor" => x.floor()
    "sqrt" => x.sqrt()
    "sin" => @math.sin(x)
    "cos" => @math.cos(x)
    "tan" => @math.tan(x)
    "asin" => @math.asin(x)
    "acos" => @math.acos(x)
    "atan" => @math.atan(x)
    "sinh" => @math.sinh(x)
    "cosh" => @math.cosh(x)
    "tanh" => @math.tanh(x)
    "exp" => @math.exp(x)
    "log" => @math.ln(x)
    "log10" => @math.log10(x)
    "pow" => @math.pow(x, y)
    "atan2" => @math.atan2(x, y)
    "hypot" => @math.hypot(x, y)
    "fmod" =>
      x - y * (if x / y < 0.0 { (x / y).ceil() } else { (x / y).floor() })
    _ => raise Invalid("unknown math function " + name)
  }
  number_value(Real(value))
}

///|
fn double_integer(value : Double) -> @bigint.BigInt raise TclError {
  if value.is_nan() || value.is_inf() {
    raise Invalid("cannot convert non-finite integer")
  }
  let bits = value.reinterpret_as_uint64()
  let exponent = ((bits >> 52) & 2047UL).to_int() - 1023
  if exponent < 0 {
    return 0N
  }
  let mantissa = (bits & 4503599627370495UL) | 4503599627370496UL
  let n = @strconv.parse_bigint(mantissa.to_string()) catch {
    _ => raise Invalid("integer conversion")
  }
  let magnitude = if exponent >= 52 {
    n << (exponent - 52)
  } else {
    n >> (52 - exponent)
  }
  if value < 0.0 {
    -magnitude
  } else {
    magnitude
  }
}

///|
fn Interpreter::expression_value(
  self : Interpreter,
  source : String,
  depth : Int,
) -> String raise TclError {
  self.expression_object(source, depth).text
}
