///|
pub suberror TclError {
  Invalid(String)
  Return(String)
} derive(Debug)

///|
pub struct Interpreter {
  vars : Map[String, String]
  procs : Map[String, (Array[String], String)]
  output : Array[String]
  mut budget : Int
} derive(Debug)

///|
pub fn Interpreter::new() -> Interpreter {
  { vars: Map([]), procs: Map([]), output: [], budget: 10000, }
}

///|
pub fn Interpreter::printed(self : Interpreter) -> String {
  self.output.join("\n")
}

///|
fn namechar(c : Char) -> Bool {
  (c >= 'a' && c <= 'z') ||
  (c >= 'A' && c <= 'Z') ||
  (c >= '0' && c <= '9') ||
  c == '_'
}

///|
fn Interpreter::substitute(
  self : Interpreter,
  cs : Array[Char],
  start : Int,
  stop : Char,
  depth : Int,
) -> (String, Int) raise TclError {
  if depth > 64 {
    raise Invalid("substitution depth")
  }
  let mut i = start
  let mut out = ""
  while i < cs.length() {
    let c = cs[i]
    if c == stop {
      return (out, i + 1)
    }
    if c == '$' {
      i += 1
      let mut key = ""
      while i < cs.length() && namechar(cs[i]) {
        key += cs[i].to_string()
        i += 1
      }
      out += match self.vars.get(key) {
        Some(v) => v
        None => raise Invalid("undefined variable " + key)
      }
    } else if c == '[' {
      let mut n = 1
      let mut script = ""
      i += 1
      let mut braces = 0
      let mut quoted = false
      while i < cs.length() {
        let x = cs[i]
        i += 1
        if x == '\\' && i < cs.length() {
          script += x.to_string() + cs[i].to_string()
          i += 1
          continue
        }
        if x == '{' {
          braces += 1
        }
        if x == '}' {
          braces -= 1
        }
        if braces == 0 && x == '"' {
          quoted = !quoted
        }
        if braces == 0 && !quoted {
          if x == '[' {
            n += 1
          }
          if x == ']' {
            n -= 1
          }
        }
        if n == 0 {
          break
        }
        script += x.to_string()
      }
      if n != 0 {
        raise Invalid("missing ]")
      }
      out += self.execute(script, depth + 1)
    } else if c == '\\' {
      i += 1
      if i >= cs.length() {
        raise Invalid("trailing escape")
      }
      out += match cs[i] {
        'n' => "\n"
        't' => "\t"
        'r' => "\r"
        '\n' => " "
        _ => cs[i].to_string()
      }
      i += 1
    } else {
      out += c.to_string()
      i += 1
    }
  }
  if stop != '\u0000' {
    raise Invalid("missing quote")
  }
  (out, i)
}

///|
fn integer(s : String) -> Int raise TclError {
  @strconv.parse_int(s) catch {
    _ => raise Invalid("expected integer: " + s)
  }
}

///|
priv struct Math {
  tokens : Array[String]
  mut pos : Int
}

///|
fn Math::expr(self : Math, min : Int, depth : Int) -> Int raise TclError {
  if depth > 64 || self.pos >= self.tokens.length() {
    raise Invalid("invalid expression")
  }
  let t = self.tokens[self.pos]
  self.pos += 1
  let mut left = if t == "(" {
    let v = self.expr(1, depth + 1)
    if self.pos >= self.tokens.length() || self.tokens[self.pos] != ")" {
      raise Invalid("missing )")
    }
    self.pos += 1
    v
  } else if t == "-" {
    0 - self.expr(4, depth + 1)
  } else {
    integer(t)
  }
  while self.pos < self.tokens.length() {
    let op = self.tokens[self.pos]
    let p = match op {
      "==" | "!=" | "<" | ">" | "<=" | ">=" => 1
      "+" | "-" => 2
      "*" | "/" | "%" => 3
      _ => 0
    }
    if p < min {
      break
    }
    self.pos += 1
    let r = self.expr(p + 1, depth + 1)
    left = match op {
      "+" => left + r
      "-" => left - r
      "*" => left * r
      "/" => {
        if r == 0 {
          raise Invalid("division by zero")
        }
        let q = left / r
        if left % r != 0 && (left < 0) != (r < 0) {
          q - 1
        } else {
          q
        }
      }
      "%" => {
        if r == 0 {
          raise Invalid("division by zero")
        }
        let rem = left % r
        if rem != 0 && (rem < 0) != (r < 0) {
          rem + r
        } else {
          rem
        }
      }
      "==" => if left == r { 1 } else { 0 }
      "!=" => if left != r { 1 } else { 0 }
      "<" => if left < r { 1 } else { 0 }
      ">" => if left > r { 1 } else { 0 }
      "<=" => if left <= r { 1 } else { 0 }
      _ => if left >= r { 1 } else { 0 }
    }
  }
  left
}

///|
fn Interpreter::math(
  self : Interpreter,
  text : String,
  depth : Int,
) -> Int raise TclError {
  let (expanded, _) = self.substitute(text.to_array(), 0, '\u0000', depth + 1)
  let cs = expanded.to_array()
  let tokens : Array[String] = []
  let mut i = 0
  while i < cs.length() {
    let c = cs[i]
    i += 1
    if c == ' ' || c == '\t' || c == '\n' {
      continue
    }
    let mut t = c.to_string()
    if c >= '0' && c <= '9' {
      while i < cs.length() && cs[i] >= '0' && cs[i] <= '9' {
        t += cs[i].to_string()
        i += 1
      }
    } else if i < cs.length() &&
      cs[i] == '=' &&
      (c == '=' || c == '!' || c == '<' || c == '>') {
      t += "="
      i += 1
    }
    tokens.push(t)
  }
  let m = Math::{ tokens, pos: 0, }
  let v = m.expr(1, 0)
  if m.pos != tokens.length() {
    raise Invalid("trailing expression")
  }
  v
}

///|
fn Interpreter::command(
  self : Interpreter,
  args : Array[String],
  depth : Int,
) -> String raise TclError {
  self.budget -= 1
  if self.budget < 0 {
    raise Invalid("execution budget")
  }
  let n = args.length()
  match args[0] {
    "set" =>
      if n == 2 {
        match self.vars.get(args[1]) {
          Some(v) => v
          None => raise Invalid("undefined variable")
        }
      } else if n == 3 {
        self.vars[args[1]] = args[2]
        args[2]
      } else {
        raise Invalid("set arity")
      }
    "incr" => {
      if n != 2 && n != 3 {
        raise Invalid("incr arity")
      }
      let v = integer(self.vars.get(args[1]).unwrap_or("0")) +
        (if n == 3 { integer(args[2]) } else { 1 })
      self.vars[args[1]] = v.to_string()
      v.to_string()
    }
    "expr" => {
      if n != 2 {
        raise Invalid("expr requires one grouped expression")
      }
      self.math(args[1], depth).to_string()
    }
    "puts" => {
      if n != 2 {
        raise Invalid("puts arity")
      }
      self.output.push(args[1])
      ""
    }
    "if" => {
      if n != 3 && !(n == 5 && args[3] == "else") {
        raise Invalid("if arity")
      }
      if self.math(args[1], depth) != 0 {
        self.execute(args[2], depth + 1)
      } else if n == 5 {
        self.execute(args[4], depth + 1)
      } else {
        ""
      }
    }
    "while" => {
      if n != 3 {
        raise Invalid("while arity")
      }
      while self.math(args[1], depth) != 0 {
        self.budget -= 1
        if self.budget < 0 {
          raise Invalid("execution budget")
        }
        ignore(self.execute(args[2], depth + 1))
      }
      ""
    }
    "proc" => {
      if n != 4 {
        raise Invalid("proc name parameters body")
      }
      if ["set", "incr", "expr", "puts", "if", "while", "proc", "return"].contains(
          args[1],
        ) {
        raise Invalid("cannot override builtin in this subset")
      }
      let parameters = args[2]
        .split(" ")
        .flat_map(x => x.split("\t"))
        .filter(x => !x.is_empty())
        .map(x => x.to_owned())
        .collect()
      let seen : Map[String, Bool] = Map([])
      for param in parameters {
        if param.is_empty() ||
          !param.to_array().iter().all(namechar) ||
          seen.contains(param) {
          raise Invalid("invalid or duplicate procedure parameter")
        }
        seen[param] = true
      }
      self.procs[args[1]] = (parameters, args[3])
      ""
    }
    "return" => {
      if n > 2 {
        raise Invalid("return arity")
      }
      raise Return(if n == 2 { args[1] } else { "" })
    }
    _ => {
      let (parameters, body) = match self.procs.get(args[0]) {
        Some(p) => p
        None => raise Invalid("unsupported command " + args[0])
      }
      if parameters.length() != n - 1 {
        raise Invalid("procedure arity")
      }
      let vars = Map([])
      for i in 0..<parameters.length() {
        vars[parameters[i]] = args[i + 1]
      }
      let child = Interpreter::{
        vars,
        procs: self.procs,
        output: self.output,
        budget: self.budget,
      }
      let result = child.execute(body, depth + 1) catch {
        Return(v) => v
        Invalid(message) => {
          self.budget = child.budget
          raise Invalid(message)
        }
      }
      self.budget = child.budget
      result
    }
  }
}

///|
fn Interpreter::execute(
  self : Interpreter,
  source : String,
  depth : Int,
) -> String raise TclError {
  if depth > 64 || source.length() > 100000 {
    raise Invalid("script/depth limit")
  }
  let cs = source.to_array()
  let mut i = 0
  let args : Array[String] = []
  let mut result = ""
  while i < cs.length() {
    let c = cs[i]
    if c == ' ' || c == '\t' || c == '\r' {
      i += 1
      continue
    }
    if c == ';' || c == '\n' {
      if !args.is_empty() {
        result = self.command(args, depth)
        args.clear()
      }
      i += 1
      continue
    }
    if c == '#' && args.is_empty() {
      while i < cs.length() && cs[i] != '\n' {
        i += 1
      }
      continue
    }
    if c == '{' {
      i += 1
      let mut level = 1
      let mut out = ""
      while i < cs.length() {
        let x = cs[i]
        i += 1
        if x == '\\' && i < cs.length() {
          out += x.to_string() + cs[i].to_string()
          i += 1
          continue
        }
        if x == '{' {
          level += 1
        }
        if x == '}' {
          level -= 1
        }
        if level == 0 {
          break
        }
        out += x.to_string()
      }
      if level != 0 {
        raise Invalid("missing }")
      }
      args.push(out)
    } else if c == '"' {
      let (v, next) = self.substitute(cs, i + 1, '"', depth)
      args.push(v)
      i = next
    } else {
      let mut raw = ""
      let mut brackets = 0
      while i < cs.length() {
        let x = cs[i]
        if brackets == 0 && (x == ' ' || x == '\t' || x == '\n' || x == ';') {
          break
        }
        if x == '[' {
          brackets += 1
        }
        if x == ']' {
          brackets -= 1
        }
        raw += x.to_string()
        i += 1
        if x == '\\' && i < cs.length() {
          raw += cs[i].to_string()
          i += 1
        }
      }
      let (v, _) = self.substitute(raw.to_array(), 0, '\u0000', depth)
      args.push(v)
    }
    if i < cs.length() &&
      cs[i] != ' ' &&
      cs[i] != '\t' &&
      cs[i] != '\r' &&
      cs[i] != '\n' &&
      cs[i] != ';' {
      raise Invalid("extra characters after grouped word")
    }
  }
  if !args.is_empty() {
    result = self.command(args, depth)
  }
  result
}

///|
pub fn Interpreter::eval(
  self : Interpreter,
  source : String,
  budget? : Int = 10000,
) -> String raise TclError {
  if budget < 1 || budget > 1000000 {
    raise Invalid("budget range")
  }
  self.budget = budget
  self.execute(source, 0) catch {
    Return(v) => v
    Invalid(message) => raise Invalid(message)
  }
}
