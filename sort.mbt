///|
priv enum SortKey {
  SortText(String)
  SortInteger(Int64)
  SortReal(Double)
  SortCommand(TclValue)
}

///|
priv struct SortItem {
  key : SortKey
  offset : Int
  mut next : Int
}

///|
fn sort_int32(value : TclValue) -> Int raise TclError {
  let n = value.as_whole() catch {
    _ => {
      switch_error(
        "expected integer but got \"" + value.text + "\"",
        if value.payload is Numeric(Real(_)) {
          "TCL VALUE INTEGER"
        } else {
          "TCL VALUE NUMBER"
        },
      )
      0N
    }
  }
  if n < -4294967295N || n > 4294967295N {
    switch_error(
      "integer value too large to represent", "ARITH IOVERFLOW {integer value too large to represent}",
    )
  }
  value.payload = Numeric(Whole(n))
  n.to_int()
}

///|
fn sort_merge(
  items : Array[SortItem],
  left : Int,
  right : Int,
  compare : (SortKey, SortKey) -> Int raise TclError,
  unique : Bool,
) -> Int raise TclError {
  let mut left = left
  let mut right = right
  let mut head = -1
  let mut tail = -1
  while left >= 0 && right >= 0 {
    let order = compare(items[left].key, items[right].key)
    let selected = if order > 0 || (order == 0 && unique) {
      if order == 0 {
        left = items[left].next
      }
      let selected = right
      right = items[right].next
      selected
    } else {
      let selected = left
      left = items[left].next
      selected
    }
    if tail < 0 {
      head = selected
    } else {
      items[tail].next = selected
    }
    tail = selected
  }
  let rest = if left >= 0 { left } else { right }
  if tail < 0 {
    rest
  } else {
    items[tail].next = rest
    head
  }
}

///|
fn Interpreter::lsort_command(
  self : Interpreter,
  input : Array[TclValue],
  depth : Int,
) -> TclValue raise TclError {
  let n = input.length()
  if n < 2 {
    switch_error(
      "wrong # args: should be \"lsort ?-option value ...? list\"", "TCL WRONGARGS",
    )
  }
  let options = [
    "-ascii", "-command", "-decreasing", "-dictionary", "-increasing", "-index",
    "-indices", "-integer", "-nocase", "-real", "-stride", "-unique",
  ]
  let mut at = 1
  let mut mode = "-ascii"
  let mut reverse = false
  let mut nocase = false
  let mut unique = false
  let mut output_indices = false
  let mut indices : Array[SearchIndex] = []
  let mut command = text_value("")
  let mut stride = 1
  while at < n - 1 {
    let option = collection_option(input[at].text, options)
    at += 1
    match option {
      "-ascii" | "-dictionary" | "-integer" | "-real" => mode = option
      "-decreasing" => reverse = true
      "-increasing" => reverse = false
      "-nocase" => nocase = true
      "-unique" => unique = true
      "-indices" => output_indices = true
      "-command" | "-index" | "-stride" => {
        if at >= n - 1 {
          switch_error(
            "\"" +
            option +
            "\" option must be followed by " +
            (if option == "-command" {
              "comparison command"
            } else if option == "-index" {
              "list index"
            } else {
              "stride length"
            }),
            "TCL ARGUMENT MISSING",
          )
        }
        if option == "-command" {
          mode = option
          command = input[at]
        } else if option == "-index" {
          indices = search_indices(input[at])
        } else {
          stride = sort_int32(input[at])
          if stride < 2 {
            switch_error(
              "stride length must be at least 2", "TCL OPERATION LSORT BADSTRIDE",
            )
          }
        }
        at += 1
      }
      _ => ()
    }
  }
  // Copy the outer list before the comparator prefix can shimmer aliases.
  let values = input[n - 1].collection_list()
  let prefix = if mode == "-command" { command.collection_list() } else { [] }
  if values.is_empty() {
    return text_value("")
  }
  let mut group_offset = 0
  if stride != 1 {
    if values.length() % stride != 0 {
      switch_error(
        "list size must be a multiple of the stride length", "TCL OPERATION LSORT BADSTRIDE",
      )
    }
    if !indices.is_empty() {
      let index = indices[0]
      group_offset = if index.relative {
        stride - 1 + index.value
      } else {
        index.value
      }
      if group_offset < 0 || group_offset >= stride {
        switch_error(
          "when used with \"-stride\", the leading \"-index\" value must be within the group",
          "TCL OPERATION LSORT BADINDEX",
        )
      }
      indices = indices[1:].to_owned()
    }
  }
  let failure : Ref[Completion?] = Ref(None)
  let compare = fn(a : SortKey, b : SortKey) -> Int raise TclError {
    self.tick()
    let order = match (a, b) {
      (SortInteger(a), SortInteger(b)) => a.compare(b)
      (SortReal(a), SortReal(b)) =>
        if a < b {
          -1
        } else if a > b {
          1
        } else {
          0
        }
      (SortText(a), SortText(b)) =>
        if mode == "-dictionary" {
          dictionary_compare(a, b)
        } else if nocase {
          tcl_string_compare(a, b)
        } else {
          collection_ascii_compare(a, b)
        }
      (SortCommand(a), SortCommand(b)) => {
        if failure.val is Some(_) {
          return 0
        }
        let result = Some(self.command_value(prefix + [a, b], depth + 1)) catch {
          error => {
            let result = outcome(error)
            option_set(
              result.options,
              "-errorinfo",
              (if result.actual_code() == 1 {
                option_get(result.options, "-errorinfo").unwrap_or(
                  result.value.text,
                )
              } else {
                result.value.text
              }) +
              "\n    (-compare command)",
            )
            if result.actual_code() != 1 {
              option_set(result.options, "-errorcode", "NONE")
              option_set(result.options, "-errorline", "1")
            }
            self.record_error({ ..result, code: 1, level: 0, })
            failure.val = Some(result)
            None
          }
        }
        match result {
          Some(result) =>
            sort_int32(result) catch {
              _ => {
                failure.val = Some(
                  completion_error(
                    "-compare command returned non-integer result",
                    errorcode="TCL OPERATION LSORT COMPARISONFAILED",
                  ),
                )
                0
              }
            }
          None => 0
        }
      }
      _ => raise Invalid("inconsistent sort key")
    }
    // Native comparison results negate as signed int32, including MIN_INT.
    if reverse {
      -order
    } else {
      order
    }
  }
  let items : Array[SortItem] = []
  let runs : Array[Int] = []
  for offset = 0; offset < values.length(); offset = offset + stride {
    self.tick()
    let value = search_key(values[offset + group_offset], indices)
    // A comparator failure still allows extraction of the next indexed key;
    // that key's error can replace it. A successful extraction then stops.
    if !indices.is_empty() {
      if failure.val is Some(result) {
        raise Signal(result)
      }
    }
    let key = if mode == "-integer" {
      SortInteger(search_wide(value))
    } else if mode == "-real" {
      SortReal(search_real(value))
    } else if mode == "-command" {
      SortCommand(value)
    } else {
      SortText(
        if nocase && mode == "-ascii" {
          unicode_case(value.text, 0)
        } else {
          value.text
        },
      )
    }
    let mut run = items.length()
    items.push({ key, offset, next: -1, })
    let mut level = 0
    while level < runs.length() && runs[level] >= 0 {
      run = sort_merge(items, runs[level], run, compare, unique)
      runs[level] = -1
      level += 1
    }
    if level == runs.length() {
      runs.push(run)
    } else {
      runs[level] = run
    }
  }
  let mut head = -1
  for run in runs {
    head = sort_merge(items, run, head, compare, unique)
  }
  if failure.val is Some(result) {
    raise Signal(result)
  }
  let output = []
  while head >= 0 {
    let offset = items[head].offset
    for j in 0..<stride {
      output.push(
        if output_indices {
          number_value(Small(offset + j))
        } else {
          values[offset + j]
        },
      )
    }
    head = items[head].next
  }
  list_value(output)
}
