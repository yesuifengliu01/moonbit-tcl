///|
fn list_edit(
  text : TclValue,
  indices : Array[String],
  replacement : TclValue,
  depth : Int,
) -> TclValue raise TclError {
  if depth > 64 {
    raise Invalid("nested list limit")
  }
  if indices.is_empty() {
    return replacement
  }
  let values = text.as_list()
  let index = list_index(indices[0], values.length())
  if index < 0 || index > values.length() {
    raise Invalid("list index out of range")
  }
  if index == values.length() {
    values.push(text_value(""))
  }
  values[index] = list_edit(
    values[index],
    indices[1:].to_owned(),
    replacement,
    depth + 1,
  )
  list_value(values)
}

///|
fn Interpreter::extended_list_command(
  self : Interpreter,
  input : Array[TclValue],
  depth : Int,
) -> TclValue raise TclError {
  let args = input.map(v => v.text)
  let n = args.length()
  match args[0] {
    "lset" => {
      if n < 3 {
        raise Invalid("lset arity")
      }
      let indices = if n == 4 {
        parse_list(args[2])
      } else {
        args[2:n - 1].to_owned()
      }
      let result = list_edit(self.read_value(args[1]), indices, input[n - 1], 0)
      self.set_value(args[1], result)
      return result
    }
    "linsert" => {
      if n < 3 {
        raise Invalid("linsert arity")
      }
      let values = input[1].as_list()
      let index = list_index(args[2], values.length() + 1)
        .max(0)
        .min(values.length())
      return list_value(
        values[:index].to_owned() +
        input[3:].to_owned() +
        values[index:].to_owned(),
      )
    }
    "lreplace" => {
      if n < 4 {
        raise Invalid("lreplace arity")
      }
      let values = input[1].as_list()
      let first = list_index(args[2], values.length())
        .max(0)
        .min(values.length())
      let last = list_index(args[3], values.length())
        .max(first - 1)
        .min(values.length() - 1)
      return list_value(
        values[:first].to_owned() +
        input[4:].to_owned() +
        values[last + 1:].to_owned(),
      )
    }
    "lsearch" => return self.lsearch_command(input)
    "lsort" => return self.lsort_command(input, depth)
    _ => raise Invalid("unsupported list command")
  }
}
