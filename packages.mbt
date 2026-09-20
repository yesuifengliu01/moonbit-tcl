///|
fn package_version(text : String) -> Array[Int] raise TclError {
  let parts = text.split(".").to_array()
  if parts.is_empty() || parts.length() > 32 {
    raise Invalid("invalid package version")
  }
  let result = []
  for part in parts {
    if part.is_empty() || !part.iter().all(c => c >= '0' && c <= '9') {
      raise Invalid("expected a released numeric package version")
    }
    result.push(integer(part.to_owned()))
  }
  result
}

///|
fn compare_versions(left : String, right : String) -> Int raise TclError {
  let a = package_version(left)
  let b = package_version(right)
  for i in 0..<a.length().max(b.length()) {
    let x = a.get(i).unwrap_or(0)
    let y = b.get(i).unwrap_or(0)
    if x != y {
      return if x < y { -1 } else { 1 }
    }
  }
  0
}

///|
fn package_satisfies(
  version : String,
  requirement : String,
) -> Bool raise TclError {
  let actual = package_version(version)
  let required = package_version(requirement)
  actual[0] == required[0] && compare_versions(version, requirement) >= 0
}

///|
fn Interpreter::package_command(
  self : Interpreter,
  args : Array[TclValue],
  depth : Int,
) -> TclValue raise TclError {
  let values = args.map(v => v.text)
  if values.length() < 2 {
    raise Invalid("package requires a subcommand")
  }
  let n = values.length()
  let value = match values[1] {
    "vcompare" => {
      if n != 4 {
        raise Invalid("package vcompare version1 version2")
      }
      compare_versions(values[2], values[3]).to_string()
    }
    "vsatisfies" => {
      if n < 4 {
        raise Invalid("package vsatisfies version requirement")
      }
      let mut matched = false
      for requirement in values[3:] {
        if package_satisfies(values[2], requirement) {
          matched = true
        }
      }
      boolean_text(matched)
    }
    "provide" => {
      if n != 3 && n != 4 {
        raise Invalid("package provide name ?version?")
      }
      if n == 3 {
        self.state.packages.get(values[2]).unwrap_or("")
      } else {
        ignore(package_version(values[3]))
        if self.state.packages.get(values[2]) is Some(old) &&
          compare_versions(old, values[3]) != 0 {
          raise Invalid("conflicting package version")
        }
        self.state.packages[values[2]] = values[3]
        ""
      }
    }
    "ifneeded" => {
      if n != 4 && n != 5 {
        raise Invalid("package ifneeded name version ?script?")
      }
      ignore(package_version(values[3]))
      let versions = self.state.package_scripts.get_or_init(values[2], () => {
        Map([])
      })
      if n == 4 {
        versions.get(values[3]).unwrap_or("")
      } else {
        versions[values[3]] = values[4]
        ""
      }
    }
    "names" => {
      if n != 2 {
        raise Invalid("package names")
      }
      let names = self.state.packages.keys().to_array()
      for name in self.state.package_scripts.keys() {
        if !names.contains(name) {
          names.push(name)
        }
      }
      format_list(names)
    }
    "versions" => {
      if n != 3 {
        raise Invalid("package versions name")
      }
      match self.state.package_scripts.get(values[2]) {
        Some(versions) => format_list(versions.keys().to_array())
        None => ""
      }
    }
    "forget" => {
      for name in values[2:] {
        self.state.packages.remove(name)
        self.state.package_scripts.remove(name)
      }
      ""
    }
    "require" | "present" => {
      let exact = n > 2 && values[2] == "-exact"
      let start = if exact { 3 } else { 2 }
      if n < start + 1 || n > start + 2 || (exact && n != start + 2) {
        raise Invalid("package require ?-exact? name ?version?")
      }
      let name = values[start]
      let requested = values.get(start + 1)
      if requested is Some(version) {
        ignore(package_version(version))
      }
      let compatible = fn(version) raise TclError {
        match requested {
          None => true
          Some(required) =>
            if exact {
              compare_versions(version, required) == 0
            } else {
              package_satisfies(version, required)
            }
        }
      }
      if self.state.packages.get(name) is Some(version) {
        if !compatible(version) {
          raise Invalid("package version conflict")
        }
        return text_value(version)
      }
      if values[1] == "present" {
        raise Invalid("package is not present")
      }
      if self.state.package_loading.contains(name) {
        raise Invalid("circular package dependency")
      }
      let mut selected : (String, String)? = None
      if self.state.package_scripts.get(name) is Some(versions) {
        for version, script in versions {
          if compatible(version) &&
            (
              selected is None ||
              (selected is Some((old, _)) && compare_versions(version, old) > 0)
            ) {
            selected = Some((version, script))
          }
        }
      }
      guard selected is Some((version, script)) else {
        raise Invalid("cannot find package " + name)
      }
      self.state.package_loading.push(name)
      defer ignore(self.state.package_loading.pop())
      let global = {
        ..self,
        frame: {
          vars: Map([]),
          namespace_name: "::",
          procedure: false,
          parent: None,
        },
      }
      ignore(global.propagate_value(global.capture(script, depth + 1)))
      guard self.state.packages.get(name) is Some(provided) else {
        raise Invalid("package script did not provide " + name)
      }
      if compare_versions(provided, version) != 0 || !compatible(provided) {
        raise Invalid("package script provided a different version")
      }
      provided
    }
    _ => raise Invalid("unsupported package subcommand")
  }
  text_value(value)
}
