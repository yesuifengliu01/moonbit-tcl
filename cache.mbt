///|
struct ScriptProgram {
  parser : ScriptParser
  commands : Array[Array[Word]]
  mut failure : String?
} derive(Debug)

///|
struct ParseCache {
  scripts : Map[String, ScriptProgram]
  expressions : Map[String, Expr]
  mut script_units : Int
  mut expression_units : Int
  mut script_hits : Int
  mut expression_hits : Int
} derive(Debug)

///|
fn ParseCache::new() -> ParseCache {
  {
    scripts: Map([]),
    expressions: Map([]),
    script_units: 0,
    expression_units: 0,
    script_hits: 0,
    expression_hits: 0,
  }
}

///|
pub struct CacheStats {
  scripts : Int
  expressions : Int
  source_units : Int
  script_hits : Int
  expression_hits : Int
} derive(Debug)

///|
pub fn Interpreter::cache_stats(self : Interpreter) -> CacheStats {
  let cache = self.state.cache
  {
    scripts: cache.scripts.length(),
    expressions: cache.expressions.length(),
    source_units: cache.script_units + cache.expression_units,
    script_hits: cache.script_hits,
    expression_hits: cache.expression_hits,
  }
}

///|
pub fn Interpreter::clear_cache(self : Interpreter) -> Unit {
  let cache = self.state.cache
  cache.scripts.clear()
  cache.expressions.clear()
  cache.script_units = 0
  cache.expression_units = 0
}

///|
fn Interpreter::cached_script(
  self : Interpreter,
  source : String,
) -> ScriptProgram {
  let cache = self.state.cache
  if cache.scripts.get(source) is Some(program) {
    if cache.script_hits < 2147483647 {
      cache.script_hits += 1
    }
    return program
  }
  // Eviction affects only future lookups; an executing program retains its
  // own reference, including recursive calls and incremental parse errors.
  if cache.scripts.length() >= 256 ||
    cache.script_units + source.length() > 262144 {
    cache.scripts.clear()
    cache.script_units = 0
  }
  let program = ScriptProgram::{
    parser: { chars: source.to_array(), pos: 0, },
    commands: [],
    failure: None,
  }
  if source.length() <= 65536 {
    cache.scripts[source] = program
    cache.script_units += source.length()
  }
  program
}

///|
fn Interpreter::cached_expression(
  self : Interpreter,
  source : String,
) -> Expr raise TclError {
  let cache = self.state.cache
  if cache.expressions.get(source) is Some(expr) {
    if cache.expression_hits < 2147483647 {
      cache.expression_hits += 1
    }
    return expr
  }
  let parser = ScriptParser::{ chars: source.to_array(), pos: 0, }
  let expr = parser.expression(1, 0)
  parser.expr_space()
  if parser.pos != parser.chars.length() {
    raise Invalid("trailing expression token")
  }
  if cache.expressions.length() >= 256 ||
    cache.expression_units + source.length() > 131072 {
    cache.expressions.clear()
    cache.expression_units = 0
  }
  if source.length() <= 16384 {
    cache.expressions[source] = expr
    cache.expression_units += source.length()
  }
  expr
}
