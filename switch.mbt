///|
fn switch_error(message : String, code : String) -> Unit raise TclError {
  raise Signal(completion_error(message, errorcode=code))
}

///|
fn Interpreter::switch_command(
  self : Interpreter,
  values : Array[TclValue],
  depth : Int,
  discard_result? : Bool = false,
) -> TclValue raise TclError {
  let n = values.length()
  if n < 3 {
    switch_error(
      "wrong # args: should be \"switch ?-option ...? string ?pattern body ...? ?default body?\"",
      "TCL WRONGARGS",
    )
  }
  let mut at = 1
  let mut mode = ""
  let mut nocase = false
  let mut matchvar : String? = None
  let mut indexvar : String? = None
  let choices = [
    "-exact", "-glob", "-indexvar", "-matchvar", "-nocase", "-regexp", "--",
  ]
  while at < n - 2 && values[at].text.has_prefix("-") {
    let option = values[at].text
    let selected = select_keyword(option, choices) catch {
      _ => {
        switch_error(
          "bad option \"" +
          option +
          "\": must be -exact, -glob, -indexvar, -matchvar, -nocase, -regexp, or --",
          format_list(["TCL", "LOOKUP", "INDEX", "option", option]),
        )
        ""
      }
    }
    at += 1
    match selected {
      "--" => break
      "-exact" | "-glob" | "-regexp" => {
        if !mode.is_empty() {
          switch_error(
            "bad option \"" + option + "\": " + mode + " option already found",
            "TCL OPERATION SWITCH DOUBLEOPT",
          )
        }
        mode = selected
      }
      "-nocase" => nocase = true
      "-matchvar" | "-indexvar" => {
        if at >= n - 2 {
          switch_error(
            "missing variable name argument to " + selected + " option",
            "TCL OPERATION SWITCH NOVAR",
          )
        }
        if selected == "-matchvar" {
          matchvar = Some(values[at].text)
        } else {
          indexvar = Some(values[at].text)
        }
        at += 1
      }
      _ => ()
    }
  }
  if mode != "-regexp" && (matchvar is Some(_) || indexvar is Some(_)) {
    switch_error(
      (if indexvar is Some(_) { "-indexvar" } else { "-matchvar" }) +
      " option requires -regexp option",
      "TCL OPERATION SWITCH MODERESTRICTION",
    )
  }
  let usage = "wrong # args: should be \"switch ?-option ...? string {?pattern body ...? ?default body?}\""
  if at >= n - 1 {
    switch_error(usage, "TCL WRONGARGS")
  }
  let subject = values[at]
  at += 1
  let arms = if at == n - 1 {
    values[at].as_list()
  } else {
    values[at:].to_owned()
  }
  if arms.is_empty() {
    switch_error(usage, "TCL WRONGARGS")
  }
  if arms.length() % 2 != 0 {
    switch_error(
      "extra switch pattern with no body", "TCL OPERATION SWITCH BADARM",
    )
  }
  if arms[arms.length() - 1].text == "-" {
    switch_error(
      "no body specified for pattern \"" + arms[arms.length() - 2].text + "\"",
      "TCL OPERATION SWITCH BADARM FALLTHROUGH",
    )
  }
  let mut i = 0
  while i < arms.length() {
    self.tick()
    let pattern = arms[i].text
    let fallback = i == arms.length() - 2 && pattern == "default"
    let mut captures : Array[(Int, Int)] = []
    let matched = if fallback {
      true
    } else if mode == "-regexp" {
      match self.regexp_matches(arms[i], subject.text, nocase) {
        Some(result) => {
          captures = result
          true
        }
        None => false
      }
    } else if mode == "-glob" {
      glob_match(pattern, subject.text, nocase)
    } else if nocase {
      unicode_case(pattern, 0) == unicode_case(subject.text, 0)
    } else {
      pattern == subject.text
    }
    if matched {
      // Native Tcl writes indices first, then substrings, including when both
      // options name the same variable. A failing first write stops the second.
      if indexvar is Some(name) {
        self.set_value(
          name,
          list_value(
            captures.map(pair => {
              list_value([
                text_value((if pair.1 == 0 { -1 } else { pair.0 }).to_string()),
                text_value(
                  (if pair.1 < 0 { -1 } else { pair.1 - 1 }).to_string(),
                ),
              ])
            }),
          ),
        )
      }
      if matchvar is Some(name) {
        self.set_value(
          name,
          list_value(
            captures.map(pair => {
              text_value(
                if pair.0 < 0 {
                  ""
                } else {
                  unit_slice(subject.text, pair.0, pair.1)
                },
              )
            }),
          ),
        )
      }
      let mut body = i + 1
      while arms[body].text == "-" {
        body += 2
      }
      return self.execute_value_script(arms[body], depth + 1, discard_result~) catch {
        error => {
          let result = outcome(error)
          if result.actual_code() == 1 {
            let options = result.options.copy()
            let line = option_get(options, "-errorline").unwrap_or("1")
            let info = option_get(options, "-errorinfo").unwrap_or(
              result.value.text,
            )
            option_set(
              options,
              "-errorinfo",
              info + "\n    (\"" + pattern + "\" arm line " + line + ")",
            )
            raise Signal({ ..result, options, })
          }
          raise Signal(result)
        }
      }
    }
    i += 2
  }
  text_value("")
}
