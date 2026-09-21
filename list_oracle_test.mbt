// Original scenarios; independent oracle: Tcl 8.6.

///|
test "Tcl canonical list fixture 0" {
  let values = ["a\\"]
  assert_eq(@tcl.format_list(values), "a\\\\")
  assert_eq(@tcl.parse_list("a\\\\"), values)
}

///|
test "Tcl canonical list fixture 1" {
  let values = ["a{b}c"]
  assert_eq(@tcl.format_list(values), "a{b}c")
  assert_eq(@tcl.parse_list("a{b}c"), values)
}

///|
test "Tcl canonical list fixture 2" {
  let values = ["a\\ b", "a\"b", "a#b", "a\\", ""]
  assert_eq(@tcl.format_list(values), "{a\\ b} a\\\"b a#b a\\\\ {}")
  assert_eq(@tcl.parse_list("{a\\ b} a\\\"b a#b a\\\\ {}"), values)
}

///|
test "Tcl canonical list fixture 3" {
  let values = ["a{b}c"]
  assert_eq(@tcl.format_list(values), "a{b}c")
  assert_eq(@tcl.parse_list("a{b}c"), values)
}

///|
test "Tcl canonical list fixture 4" {
  let values = ["a\\ b", "a}b"]
  assert_eq(@tcl.format_list(values), "{a\\ b} a\\}b")
  assert_eq(@tcl.parse_list("{a\\ b} a\\}b"), values)
}

///|
test "Tcl canonical list fixture 5" {
  let values = ["a\\ b", "a\t b", "#name", "a\"b", ";x", "a b"]
  assert_eq(@tcl.format_list(values), "{a\\ b} {a\t b} #name a\\\"b {;x} {a b}")
  assert_eq(@tcl.parse_list("{a\\ b} {a\t b} #name a\\\"b {;x} {a b}"), values)
}

///|
test "Tcl canonical list fixture 6" {
  let values = ["a\\", "a#b", "a}b", "a\t b", "a\\", "a{b", "a\\{b"]
  assert_eq(
    @tcl.format_list(values),
    "a\\\\ a#b a\\}b {a\t b} a\\\\ a\\{b {a\\{b}",
  )
  assert_eq(
    @tcl.parse_list("a\\\\ a#b a\\}b {a\t b} a\\\\ a\\{b {a\\{b}"),
    values,
  )
}

///|
test "Tcl canonical list fixture 7" {
  let values = ["a[b", "{a}", "$x", "a b", "#name"]
  assert_eq(@tcl.format_list(values), "{a[b} {{a}} {$x} a b #name")
  assert_eq(@tcl.parse_list("{a[b} {{a}} {$x} a b #name"), values)
}

///|
test "Tcl canonical list fixture 8" {
  let values = ["汉字🚀", ";x", "a#b", "a\t b", "a{b}c", "a]b", "a\t b"]
  assert_eq(
    @tcl.format_list(values),
    "汉字🚀 {;x} a#b {a\t b} a{b}c a\\]b {a\t b}",
  )
  assert_eq(
    @tcl.parse_list("汉字🚀 {;x} a#b {a\t b} a{b}c a\\]b {a\t b}"),
    values,
  )
}

///|
test "Tcl canonical list fixture 9" {
  let values = ["a\nb", "", "simple", "\"a\""]
  assert_eq(@tcl.format_list(values), "{a\nb} {} simple {\"a\"}")
  assert_eq(@tcl.parse_list("{a\nb} {} simple {\"a\"}"), values)
}

///|
test "Tcl canonical list fixture 10" {
  let values = ["a[b", "{a}", "a}b", "a]b"]
  assert_eq(@tcl.format_list(values), "{a[b} {{a}} a\\}b a\\]b")
  assert_eq(@tcl.parse_list("{a[b} {{a}} a\\}b a\\]b"), values)
}

///|
test "Tcl canonical list fixture 11" {
  let values = [";x"]
  assert_eq(@tcl.format_list(values), "{;x}")
  assert_eq(@tcl.parse_list("{;x}"), values)
}

///|
test "Tcl canonical list fixture 12" {
  let values = ["a\\{b", ";x", "$x", "#name", "a b"]
  assert_eq(@tcl.format_list(values), "{a\\{b} {;x} {$x} #name a b")
  assert_eq(@tcl.parse_list("{a\\{b} {;x} {$x} #name a b"), values)
}

///|
test "Tcl canonical list fixture 13" {
  let values = ["#name", ";x", "a b"]
  assert_eq(@tcl.format_list(values), "{#name} {;x} a b")
  assert_eq(@tcl.parse_list("{#name} {;x} a b"), values)
}

///|
test "Tcl canonical list fixture 14" {
  let values = ["", "\"a\"", "a[b", "汉字🚀"]
  assert_eq(@tcl.format_list(values), "{} {\"a\"} {a[b} 汉字🚀")
  assert_eq(@tcl.parse_list("{} {\"a\"} {a[b} 汉字🚀"), values)
}

///|
test "Tcl canonical list fixture 15" {
  let values = ["a\\{b", "a\nb", "a{b"]
  assert_eq(@tcl.format_list(values), "{a\\{b} {a\nb} a\\{b")
  assert_eq(@tcl.parse_list("{a\\{b} {a\nb} a\\{b"), values)
}

///|
test "Tcl canonical list fixture 16" {
  let values = [";x", ";x", "a\\{b", "a\nb", "a\\\nb", "a\\{b", "a{b}c"]
  assert_eq(
    @tcl.format_list(values),
    "{;x} {;x} {a\\{b} {a\nb} a\\\\\\nb {a\\{b} a{b}c",
  )
  assert_eq(
    @tcl.parse_list("{;x} {;x} {a\\{b} {a\nb} a\\\\\\nb {a\\{b} a{b}c"),
    values,
  )
}

///|
test "Tcl canonical list fixture 17" {
  let values = ["a}b", "a\rb"]
  assert_eq(@tcl.format_list(values), "a\\}b {a\rb}")
  assert_eq(@tcl.parse_list("a\\}b {a\rb}"), values)
}

///|
test "Tcl canonical list fixture 18" {
  let values = ["a\\\nb", "a}b", "simple", "a\\"]
  assert_eq(@tcl.format_list(values), "a\\\\\\nb a\\}b simple a\\\\")
  assert_eq(@tcl.parse_list("a\\\\\\nb a\\}b simple a\\\\"), values)
}

///|
test "Tcl canonical list fixture 19" {
  let values = ["a\\{b", "a\nb", "a b"]
  assert_eq(@tcl.format_list(values), "{a\\{b} {a\nb} {a b}")
  assert_eq(@tcl.parse_list("{a\\{b} {a\nb} {a b}"), values)
}

///|
test "Tcl canonical list fixture 20" {
  let values = ["#name", "a\rb", "a]b", "a\rb", "a\nb", "a\nb", "a{b}c"]
  assert_eq(
    @tcl.format_list(values),
    "{#name} {a\rb} a\\]b {a\rb} {a\nb} {a\nb} a{b}c",
  )
  assert_eq(
    @tcl.parse_list("{#name} {a\rb} a\\]b {a\rb} {a\nb} {a\nb} a{b}c"),
    values,
  )
}

///|
test "Tcl canonical list fixture 21" {
  let values = ["simple", ";x", ";x", ";x", "#name", "a\rb", ";x"]
  assert_eq(@tcl.format_list(values), "simple {;x} {;x} {;x} #name {a\rb} {;x}")
  assert_eq(@tcl.parse_list("simple {;x} {;x} {;x} #name {a\rb} {;x}"), values)
}

///|
test "Tcl canonical list fixture 22" {
  let values = [""]
  assert_eq(@tcl.format_list(values), "{}")
  assert_eq(@tcl.parse_list("{}"), values)
}

///|
test "Tcl canonical list fixture 23" {
  let values = ["simple", "a\rb", "a\t b", "a\"b", "{a}"]
  assert_eq(@tcl.format_list(values), "simple {a\rb} {a\t b} a\\\"b {{a}}")
  assert_eq(@tcl.parse_list("simple {a\rb} {a\t b} a\\\"b {{a}}"), values)
}

///|
test "Tcl canonical list fixture 24" {
  let values = ["a\nb", "a\rb", "$x"]
  assert_eq(@tcl.format_list(values), "{a\nb} {a\rb} {$x}")
  assert_eq(@tcl.parse_list("{a\nb} {a\rb} {$x}"), values)
}

///|
test "Tcl canonical list fixture 25" {
  let values = ["a{b", "$x", "a\\{b"]
  assert_eq(@tcl.format_list(values), "a\\{b {$x} {a\\{b}")
  assert_eq(@tcl.parse_list("a\\{b {$x} {a\\{b}"), values)
}

///|
test "Tcl canonical list fixture 26" {
  let values = ["a\\{b", "a\\{b", "a}b", "a\"b", "汉字🚀"]
  assert_eq(@tcl.format_list(values), "{a\\{b} {a\\{b} a\\}b a\\\"b 汉字🚀")
  assert_eq(@tcl.parse_list("{a\\{b} {a\\{b} a\\}b a\\\"b 汉字🚀"), values)
}

///|
test "Tcl canonical list fixture 27" {
  let values = ["a#b", "a[b", "a}b", "a\rb", "汉字🚀"]
  assert_eq(@tcl.format_list(values), "a#b {a[b} a\\}b {a\rb} 汉字🚀")
  assert_eq(@tcl.parse_list("a#b {a[b} a\\}b {a\rb} 汉字🚀"), values)
}

///|
test "Tcl canonical list fixture 28" {
  let values = ["a\\\nb", "a{b}c", "a\\\nb", "simple", "", "a\nb"]
  assert_eq(
    @tcl.format_list(values),
    "a\\\\\\nb a{b}c a\\\\\\nb simple {} {a\nb}",
  )
  assert_eq(
    @tcl.parse_list("a\\\\\\nb a{b}c a\\\\\\nb simple {} {a\nb}"),
    values,
  )
}

///|
test "Tcl canonical list fixture 29" {
  let values = ["simple", "a b", "$x", "a\\\nb", "a b", "a\\ b"]
  assert_eq(
    @tcl.format_list(values),
    "simple {a b} {$x} a\\\\\\nb {a b} {a\\ b}",
  )
  assert_eq(
    @tcl.parse_list("simple {a b} {$x} a\\\\\\nb {a b} {a\\ b}"),
    values,
  )
}

///|
test "Tcl canonical list fixture 30" {
  let values = ["a#b", "a\nb"]
  assert_eq(@tcl.format_list(values), "a#b {a\nb}")
  assert_eq(@tcl.parse_list("a#b {a\nb}"), values)
}

///|
test "Tcl canonical list fixture 31" {
  let values = ["a]b", "a{b}c", "a\\"]
  assert_eq(@tcl.format_list(values), "a\\]b a{b}c a\\\\")
  assert_eq(@tcl.parse_list("a\\]b a{b}c a\\\\"), values)
}

///|
test "Tcl canonical list fixture 32" {
  let values = ["a\\"]
  assert_eq(@tcl.format_list(values), "a\\\\")
  assert_eq(@tcl.parse_list("a\\\\"), values)
}

///|
test "Tcl canonical list fixture 33" {
  let values = ["a\"b", "a\\", "汉字🚀", "a\\\nb"]
  assert_eq(@tcl.format_list(values), "a\\\"b a\\\\ 汉字🚀 a\\\\\\nb")
  assert_eq(@tcl.parse_list("a\\\"b a\\\\ 汉字🚀 a\\\\\\nb"), values)
}

///|
test "Tcl canonical list fixture 34" {
  let values = ["a b"]
  assert_eq(@tcl.format_list(values), "a b")
  assert_eq(@tcl.parse_list("a b"), values)
}

///|
test "Tcl canonical list fixture 35" {
  let values = ["a\\\nb", "a{b", "a b", "a\\ b"]
  assert_eq(@tcl.format_list(values), "a\\\\\\nb a\\{b a b {a\\ b}")
  assert_eq(@tcl.parse_list("a\\\\\\nb a\\{b a b {a\\ b}"), values)
}

///|
test "Tcl canonical list fixture 36" {
  let values = []
  assert_eq(@tcl.format_list(values), "")
  assert_eq(@tcl.parse_list(""), values)
}

///|
test "Tcl canonical list fixture 37" {
  let values = ["a\nb", "", "a[b"]
  assert_eq(@tcl.format_list(values), "{a\nb} {} {a[b}")
  assert_eq(@tcl.parse_list("{a\nb} {} {a[b}"), values)
}

///|
test "Tcl canonical list fixture 38" {
  let values = ["a{b}c", "#name"]
  assert_eq(@tcl.format_list(values), "a{b}c #name")
  assert_eq(@tcl.parse_list("a{b}c #name"), values)
}

///|
test "Tcl canonical list fixture 39" {
  let values = []
  assert_eq(@tcl.format_list(values), "")
  assert_eq(@tcl.parse_list(""), values)
}

///|
test "Tcl canonical list fixture 40" {
  let values = ["a\\ b", "a b"]
  assert_eq(@tcl.format_list(values), "{a\\ b} {a b}")
  assert_eq(@tcl.parse_list("{a\\ b} {a b}"), values)
}

///|
test "Tcl canonical list fixture 41" {
  let values = ["a]b", "a[b", "a\\\nb", "a b", "a{b", "a\"b"]
  assert_eq(@tcl.format_list(values), "a\\]b {a[b} a\\\\\\nb a b a\\{b a\\\"b")
  assert_eq(@tcl.parse_list("a\\]b {a[b} a\\\\\\nb a b a\\{b a\\\"b"), values)
}

///|
test "Tcl canonical list fixture 42" {
  let values = ["a}b", "a\"b", "a\\"]
  assert_eq(@tcl.format_list(values), "a\\}b a\\\"b a\\\\")
  assert_eq(@tcl.parse_list("a\\}b a\\\"b a\\\\"), values)
}

///|
test "Tcl canonical list fixture 43" {
  let values = ["simple", "$x", "a b", "a#b", "a[b"]
  assert_eq(@tcl.format_list(values), "simple {$x} {a b} a#b {a[b}")
  assert_eq(@tcl.parse_list("simple {$x} {a b} a#b {a[b}"), values)
}

///|
test "Tcl canonical list fixture 44" {
  let values = ["a\t b", "a}b"]
  assert_eq(@tcl.format_list(values), "{a\t b} a\\}b")
  assert_eq(@tcl.parse_list("{a\t b} a\\}b"), values)
}

///|
test "Tcl canonical list fixture 45" {
  let values = ["a\"b", "a\rb", "a\\\nb", "a[b", "a b", "#name", "a\"b"]
  assert_eq(
    @tcl.format_list(values),
    "a\\\"b {a\rb} a\\\\\\nb {a[b} a b #name a\\\"b",
  )
  assert_eq(
    @tcl.parse_list("a\\\"b {a\rb} a\\\\\\nb {a[b} a b #name a\\\"b"),
    values,
  )
}

///|
test "Tcl canonical list fixture 46" {
  let values = []
  assert_eq(@tcl.format_list(values), "")
  assert_eq(@tcl.parse_list(""), values)
}

///|
test "Tcl canonical list fixture 47" {
  let values = ["a\\", "a#b"]
  assert_eq(@tcl.format_list(values), "a\\\\ a#b")
  assert_eq(@tcl.parse_list("a\\\\ a#b"), values)
}

///|
test "Tcl canonical list fixture 48" {
  let values = ["a b", "a\\ b", "汉字🚀", "{a}", "a\nb"]
  assert_eq(@tcl.format_list(values), "a b {a\\ b} 汉字🚀 {{a}} {a\nb}")
  assert_eq(@tcl.parse_list("a b {a\\ b} 汉字🚀 {{a}} {a\nb}"), values)
}

///|
test "Tcl canonical list fixture 49" {
  let values = ["#name", "a#b"]
  assert_eq(@tcl.format_list(values), "{#name} a#b")
  assert_eq(@tcl.parse_list("{#name} a#b"), values)
}

///|
test "Tcl canonical list fixture 50" {
  let values = ["\"a\"", "a{b}c", "simple", "a\t b", "a[b", "a]b"]
  assert_eq(
    @tcl.format_list(values),
    "{\"a\"} a{b}c simple {a\t b} {a[b} a\\]b",
  )
  assert_eq(@tcl.parse_list("{\"a\"} a{b}c simple {a\t b} {a[b} a\\]b"), values)
}

///|
test "Tcl canonical list fixture 51" {
  let values = []
  assert_eq(@tcl.format_list(values), "")
  assert_eq(@tcl.parse_list(""), values)
}

///|
test "Tcl canonical list fixture 52" {
  let values = ["#name", "a\t b"]
  assert_eq(@tcl.format_list(values), "{#name} {a\t b}")
  assert_eq(@tcl.parse_list("{#name} {a\t b}"), values)
}

///|
test "Tcl canonical list fixture 53" {
  let values = ["a\nb", "a\\{b", "simple", "a[b"]
  assert_eq(@tcl.format_list(values), "{a\nb} {a\\{b} simple {a[b}")
  assert_eq(@tcl.parse_list("{a\nb} {a\\{b} simple {a[b}"), values)
}

///|
test "Tcl canonical list fixture 54" {
  let values = ["", "a\rb", "a b", "a\\{b", "a\"b"]
  assert_eq(@tcl.format_list(values), "{} {a\rb} a b {a\\{b} a\\\"b")
  assert_eq(@tcl.parse_list("{} {a\rb} a b {a\\{b} a\\\"b"), values)
}

///|
test "Tcl canonical list fixture 55" {
  let values = ["a]b", "a\\", "a}b", "a\nb", "a\\", "a\\"]
  assert_eq(@tcl.format_list(values), "a\\]b a\\\\ a\\}b {a\nb} a\\\\ a\\\\")
  assert_eq(@tcl.parse_list("a\\]b a\\\\ a\\}b {a\nb} a\\\\ a\\\\"), values)
}

///|
test "Tcl canonical list fixture 56" {
  let values = ["\"a\"", "a\rb", "#name", "a\\"]
  assert_eq(@tcl.format_list(values), "{\"a\"} {a\rb} #name a\\\\")
  assert_eq(@tcl.parse_list("{\"a\"} {a\rb} #name a\\\\"), values)
}

///|
test "Tcl canonical list fixture 57" {
  let values = [";x", "a}b", "a{b", "simple", "a\\ b", "a b"]
  assert_eq(@tcl.format_list(values), "{;x} a\\}b a\\{b simple {a\\ b} {a b}")
  assert_eq(@tcl.parse_list("{;x} a\\}b a\\{b simple {a\\ b} {a b}"), values)
}

///|
test "Tcl canonical list fixture 58" {
  let values = ["a{b}c", "a}b", "a{b}c", "a\nb"]
  assert_eq(@tcl.format_list(values), "a{b}c a\\}b a{b}c {a\nb}")
  assert_eq(@tcl.parse_list("a{b}c a\\}b a{b}c {a\nb}"), values)
}

///|
test "Tcl canonical list fixture 59" {
  let values = ["", "simple", "汉字🚀", "a{b}c", ";x", "$x"]
  assert_eq(@tcl.format_list(values), "{} simple 汉字🚀 a{b}c {;x} {$x}")
  assert_eq(@tcl.parse_list("{} simple 汉字🚀 a{b}c {;x} {$x}"), values)
}

///|
test "Tcl canonical list fixture 60" {
  let values = ["\"a\""]
  assert_eq(@tcl.format_list(values), "{\"a\"}")
  assert_eq(@tcl.parse_list("{\"a\"}"), values)
}

///|
test "Tcl canonical list fixture 61" {
  let values = ["\"a\"", "a\\{b", "a[b", "a b", "simple", "a\nb"]
  assert_eq(
    @tcl.format_list(values),
    "{\"a\"} {a\\{b} {a[b} {a b} simple {a\nb}",
  )
  assert_eq(
    @tcl.parse_list("{\"a\"} {a\\{b} {a[b} {a b} simple {a\nb}"),
    values,
  )
}

///|
test "Tcl canonical list fixture 62" {
  let values = ["a\"b", "simple", "a\t b"]
  assert_eq(@tcl.format_list(values), "a\\\"b simple {a\t b}")
  assert_eq(@tcl.parse_list("a\\\"b simple {a\t b}"), values)
}

///|
test "Tcl canonical list fixture 63" {
  let values = ["a[b"]
  assert_eq(@tcl.format_list(values), "{a[b}")
  assert_eq(@tcl.parse_list("{a[b}"), values)
}

///|
test "Tcl canonical list fixture 64" {
  let values = ["a b", "a\\ b", "a\\"]
  assert_eq(@tcl.format_list(values), "{a b} {a\\ b} a\\\\")
  assert_eq(@tcl.parse_list("{a b} {a\\ b} a\\\\"), values)
}

///|
test "Tcl canonical list fixture 65" {
  let values = ["a\\{b", "a\\", "a}b", "a[b"]
  assert_eq(@tcl.format_list(values), "{a\\{b} a\\\\ a\\}b {a[b}")
  assert_eq(@tcl.parse_list("{a\\{b} a\\\\ a\\}b {a[b}"), values)
}

///|
test "Tcl canonical list fixture 66" {
  let values = ["\"a\"", "a b", "a\\ b", "a b"]
  assert_eq(@tcl.format_list(values), "{\"a\"} a b {a\\ b} {a b}")
  assert_eq(@tcl.parse_list("{\"a\"} a b {a\\ b} {a b}"), values)
}

///|
test "Tcl canonical list fixture 67" {
  let values = []
  assert_eq(@tcl.format_list(values), "")
  assert_eq(@tcl.parse_list(""), values)
}

///|
test "Tcl canonical list fixture 68" {
  let values = ["a\"b", "a\\", "simple", "a b", "$x", ";x"]
  assert_eq(@tcl.format_list(values), "a\\\"b a\\\\ simple a b {$x} {;x}")
  assert_eq(@tcl.parse_list("a\\\"b a\\\\ simple a b {$x} {;x}"), values)
}

///|
test "Tcl canonical list fixture 69" {
  let values = ["a\nb", "a{b}c", "a\"b", ";x", "a\\\nb", "a\rb"]
  assert_eq(
    @tcl.format_list(values),
    "{a\nb} a{b}c a\\\"b {;x} a\\\\\\nb {a\rb}",
  )
  assert_eq(
    @tcl.parse_list("{a\nb} a{b}c a\\\"b {;x} a\\\\\\nb {a\rb}"),
    values,
  )
}

///|
test "Tcl canonical list fixture 70" {
  let values = ["a{b", "", "simple"]
  assert_eq(@tcl.format_list(values), "a\\{b {} simple")
  assert_eq(@tcl.parse_list("a\\{b {} simple"), values)
}

///|
test "Tcl canonical list fixture 71" {
  let values = ["a#b"]
  assert_eq(@tcl.format_list(values), "a#b")
  assert_eq(@tcl.parse_list("a#b"), values)
}

///|
test "Tcl canonical list fixture 72" {
  let values = ["simple", "a\\\nb", ";x", ";x", "a#b", "a\t b", "a\\{b"]
  assert_eq(
    @tcl.format_list(values),
    "simple a\\\\\\nb {;x} {;x} a#b {a\t b} {a\\{b}",
  )
  assert_eq(
    @tcl.parse_list("simple a\\\\\\nb {;x} {;x} a#b {a\t b} {a\\{b}"),
    values,
  )
}

///|
test "Tcl canonical list fixture 73" {
  let values = ["a[b", "汉字🚀", "{a}", "a\rb", "a\\", "a{b"]
  assert_eq(
    @tcl.format_list(values),
    "{a[b} 汉字🚀 {{a}} {a\rb} a\\\\ a\\{b",
  )
  assert_eq(
    @tcl.parse_list("{a[b} 汉字🚀 {{a}} {a\rb} a\\\\ a\\{b"),
    values,
  )
}

///|
test "Tcl canonical list fixture 74" {
  let values = ["a}b"]
  assert_eq(@tcl.format_list(values), "a\\}b")
  assert_eq(@tcl.parse_list("a\\}b"), values)
}

///|
test "Tcl canonical list fixture 75" {
  let values = ["a{b", ";x", "a\\", "a{b", "#name", "a}b"]
  assert_eq(@tcl.format_list(values), "a\\{b {;x} a\\\\ a\\{b #name a\\}b")
  assert_eq(@tcl.parse_list("a\\{b {;x} a\\\\ a\\{b #name a\\}b"), values)
}

///|
test "Tcl canonical list fixture 76" {
  let values = ["$x", "", "a b", "$x", "a\\ b", "$x", "汉字🚀"]
  assert_eq(
    @tcl.format_list(values),
    "{$x} {} {a b} {$x} {a\\ b} {$x} 汉字🚀",
  )
  assert_eq(
    @tcl.parse_list("{$x} {} {a b} {$x} {a\\ b} {$x} 汉字🚀"),
    values,
  )
}

///|
test "Tcl canonical list fixture 77" {
  let values = ["a\\", "a\\", "汉字🚀", "a\\ b", "a b"]
  assert_eq(@tcl.format_list(values), "a\\\\ a\\\\ 汉字🚀 {a\\ b} {a b}")
  assert_eq(@tcl.parse_list("a\\\\ a\\\\ 汉字🚀 {a\\ b} {a b}"), values)
}

///|
test "Tcl canonical list fixture 78" {
  let values = ["a\t b", "a}b"]
  assert_eq(@tcl.format_list(values), "{a\t b} a\\}b")
  assert_eq(@tcl.parse_list("{a\t b} a\\}b"), values)
}

///|
test "Tcl canonical list fixture 79" {
  let values = ["a]b", "a\nb", "汉字🚀", "\"a\""]
  assert_eq(@tcl.format_list(values), "a\\]b {a\nb} 汉字🚀 {\"a\"}")
  assert_eq(@tcl.parse_list("a\\]b {a\nb} 汉字🚀 {\"a\"}"), values)
}

///|
test "Tcl canonical list fixture 80" {
  let values = ["a{b", "simple"]
  assert_eq(@tcl.format_list(values), "a\\{b simple")
  assert_eq(@tcl.parse_list("a\\{b simple"), values)
}

///|
test "Tcl canonical list fixture 81" {
  let values = ["a[b", "simple", "a\"b", "a\\ b", "a]b", "a{b}c", "汉字🚀"]
  assert_eq(
    @tcl.format_list(values),
    "{a[b} simple a\\\"b {a\\ b} a\\]b a{b}c 汉字🚀",
  )
  assert_eq(
    @tcl.parse_list("{a[b} simple a\\\"b {a\\ b} a\\]b a{b}c 汉字🚀"),
    values,
  )
}

///|
test "Tcl canonical list fixture 82" {
  let values = ["", "a\rb"]
  assert_eq(@tcl.format_list(values), "{} {a\rb}")
  assert_eq(@tcl.parse_list("{} {a\rb}"), values)
}

///|
test "Tcl canonical list fixture 83" {
  let values = []
  assert_eq(@tcl.format_list(values), "")
  assert_eq(@tcl.parse_list(""), values)
}

///|
test "Tcl canonical list fixture 84" {
  let values = ["a\\\nb", "#name", "a{b"]
  assert_eq(@tcl.format_list(values), "a\\\\\\nb #name a\\{b")
  assert_eq(@tcl.parse_list("a\\\\\\nb #name a\\{b"), values)
}

///|
test "Tcl canonical list fixture 85" {
  let values = []
  assert_eq(@tcl.format_list(values), "")
  assert_eq(@tcl.parse_list(""), values)
}

///|
test "Tcl canonical list fixture 86" {
  let values = ["a{b"]
  assert_eq(@tcl.format_list(values), "a\\{b")
  assert_eq(@tcl.parse_list("a\\{b"), values)
}

///|
test "Tcl canonical list fixture 87" {
  let values = ["a]b", "a\"b"]
  assert_eq(@tcl.format_list(values), "a\\]b a\\\"b")
  assert_eq(@tcl.parse_list("a\\]b a\\\"b"), values)
}

///|
test "Tcl canonical list fixture 88" {
  let values = ["a\\ b"]
  assert_eq(@tcl.format_list(values), "{a\\ b}")
  assert_eq(@tcl.parse_list("{a\\ b}"), values)
}

///|
test "Tcl canonical list fixture 89" {
  let values = ["", "a}b"]
  assert_eq(@tcl.format_list(values), "{} a\\}b")
  assert_eq(@tcl.parse_list("{} a\\}b"), values)
}

///|
test "Tcl canonical list fixture 90" {
  let values = ["a\\", "a}b", "$x", "a{b", "a\\{b", "a b"]
  assert_eq(@tcl.format_list(values), "a\\\\ a\\}b {$x} a\\{b {a\\{b} {a b}")
  assert_eq(@tcl.parse_list("a\\\\ a\\}b {$x} a\\{b {a\\{b} {a b}"), values)
}

///|
test "Tcl canonical list fixture 91" {
  let values = ["a\nb", "汉字🚀", "a b", "a\nb", "a\\\nb", "a#b"]
  assert_eq(
    @tcl.format_list(values),
    "{a\nb} 汉字🚀 a b {a\nb} a\\\\\\nb a#b",
  )
  assert_eq(
    @tcl.parse_list("{a\nb} 汉字🚀 a b {a\nb} a\\\\\\nb a#b"),
    values,
  )
}

///|
test "Tcl canonical list fixture 92" {
  let values = ["a\\", "a\\", ";x", "a b", "#name", "a b", "$x"]
  assert_eq(@tcl.format_list(values), "a\\\\ a\\\\ {;x} a b #name a b {$x}")
  assert_eq(@tcl.parse_list("a\\\\ a\\\\ {;x} a b #name a b {$x}"), values)
}

///|
test "Tcl canonical list fixture 93" {
  let values = ["simple", "a\t b", ""]
  assert_eq(@tcl.format_list(values), "simple {a\t b} {}")
  assert_eq(@tcl.parse_list("simple {a\t b} {}"), values)
}

///|
test "Tcl canonical list fixture 94" {
  let values = ["汉字🚀", "a\rb", "a{b}c", "a]b"]
  assert_eq(@tcl.format_list(values), "汉字🚀 {a\rb} a{b}c a\\]b")
  assert_eq(@tcl.parse_list("汉字🚀 {a\rb} a{b}c a\\]b"), values)
}

///|
test "Tcl canonical list fixture 95" {
  let values = []
  assert_eq(@tcl.format_list(values), "")
  assert_eq(@tcl.parse_list(""), values)
}

///|
test "Tcl canonical list fixture 96" {
  let values = ["", "a}b", ";x", "a\rb", "a\\", "a\t b"]
  assert_eq(@tcl.format_list(values), "{} a\\}b {;x} {a\rb} a\\\\ {a\t b}")
  assert_eq(@tcl.parse_list("{} a\\}b {;x} {a\rb} a\\\\ {a\t b}"), values)
}

///|
test "Tcl canonical list fixture 97" {
  let values = ["a#b", "a]b", "a{b", "a\t b", "a\t b", "a#b"]
  assert_eq(@tcl.format_list(values), "a#b a\\]b a\\{b {a\t b} {a\t b} a#b")
  assert_eq(@tcl.parse_list("a#b a\\]b a\\{b {a\t b} {a\t b} a#b"), values)
}

///|
test "Tcl canonical list fixture 98" {
  let values = []
  assert_eq(@tcl.format_list(values), "")
  assert_eq(@tcl.parse_list(""), values)
}

///|
test "Tcl canonical list fixture 99" {
  let values = ["#name", "a#b", "a b", "a\\ b", "a#b"]
  assert_eq(@tcl.format_list(values), "{#name} a#b {a b} {a\\ b} a#b")
  assert_eq(@tcl.parse_list("{#name} a#b {a b} {a\\ b} a#b"), values)
}

///|
test "Tcl canonical list fixture 100" {
  let values = []
  assert_eq(@tcl.format_list(values), "")
  assert_eq(@tcl.parse_list(""), values)
}

///|
test "Tcl canonical list fixture 101" {
  let values = ["a\t b", "a\t b", "a b", "\"a\"", "a\\\nb", "a]b"]
  assert_eq(
    @tcl.format_list(values),
    "{a\t b} {a\t b} {a b} {\"a\"} a\\\\\\nb a\\]b",
  )
  assert_eq(
    @tcl.parse_list("{a\t b} {a\t b} {a b} {\"a\"} a\\\\\\nb a\\]b"),
    values,
  )
}

///|
test "Tcl canonical list fixture 102" {
  let values = ["a\\{b", ";x", "a}b", "a}b"]
  assert_eq(@tcl.format_list(values), "{a\\{b} {;x} a\\}b a\\}b")
  assert_eq(@tcl.parse_list("{a\\{b} {;x} a\\}b a\\}b"), values)
}

///|
test "Tcl canonical list fixture 103" {
  let values = ["", "a{b}c", "a\\\nb", "simple", "a\\\nb", "a b", "a[b"]
  assert_eq(
    @tcl.format_list(values),
    "{} a{b}c a\\\\\\nb simple a\\\\\\nb {a b} {a[b}",
  )
  assert_eq(
    @tcl.parse_list("{} a{b}c a\\\\\\nb simple a\\\\\\nb {a b} {a[b}"),
    values,
  )
}

///|
test "Tcl canonical list fixture 104" {
  let values = ["$x", "a[b", "汉字🚀", "a\t b", "a b", "a}b", "$x"]
  assert_eq(
    @tcl.format_list(values),
    "{$x} {a[b} 汉字🚀 {a\t b} {a b} a\\}b {$x}",
  )
  assert_eq(
    @tcl.parse_list("{$x} {a[b} 汉字🚀 {a\t b} {a b} a\\}b {$x}"),
    values,
  )
}

///|
test "Tcl canonical list fixture 105" {
  let values = ["a]b", "汉字🚀", "a\rb", "a]b"]
  assert_eq(@tcl.format_list(values), "a\\]b 汉字🚀 {a\rb} a\\]b")
  assert_eq(@tcl.parse_list("a\\]b 汉字🚀 {a\rb} a\\]b"), values)
}

///|
test "Tcl canonical list fixture 106" {
  let values = ["a{b}c"]
  assert_eq(@tcl.format_list(values), "a{b}c")
  assert_eq(@tcl.parse_list("a{b}c"), values)
}

///|
test "Tcl canonical list fixture 107" {
  let values = ["a\nb", "汉字🚀", "汉字🚀", "a]b", "a#b", "a]b", "a\nb"]
  assert_eq(
    @tcl.format_list(values),
    "{a\nb} 汉字🚀 汉字🚀 a\\]b a#b a\\]b {a\nb}",
  )
  assert_eq(
    @tcl.parse_list("{a\nb} 汉字🚀 汉字🚀 a\\]b a#b a\\]b {a\nb}"),
    values,
  )
}

///|
test "Tcl canonical list fixture 108" {
  let values = [";x", "a[b", "a]b", "simple", "\"a\"", "a\\{b", "a\\"]
  assert_eq(
    @tcl.format_list(values),
    "{;x} {a[b} a\\]b simple {\"a\"} {a\\{b} a\\\\",
  )
  assert_eq(
    @tcl.parse_list("{;x} {a[b} a\\]b simple {\"a\"} {a\\{b} a\\\\"),
    values,
  )
}

///|
test "Tcl canonical list fixture 109" {
  let values = ["$x", "a\\", "a]b", "汉字🚀", "汉字🚀"]
  assert_eq(@tcl.format_list(values), "{$x} a\\\\ a\\]b 汉字🚀 汉字🚀")
  assert_eq(@tcl.parse_list("{$x} a\\\\ a\\]b 汉字🚀 汉字🚀"), values)
}

///|
test "Tcl canonical list fixture 110" {
  let values = ["a\\{b"]
  assert_eq(@tcl.format_list(values), "{a\\{b}")
  assert_eq(@tcl.parse_list("{a\\{b}"), values)
}

///|
test "Tcl canonical list fixture 111" {
  let values = ["a{b}c", "#name"]
  assert_eq(@tcl.format_list(values), "a{b}c #name")
  assert_eq(@tcl.parse_list("a{b}c #name"), values)
}

///|
test "Tcl canonical list fixture 112" {
  let values = ["a\\\nb", "a\rb", ";x", "a]b", "a\\{b", "a#b", "a\rb"]
  assert_eq(
    @tcl.format_list(values),
    "a\\\\\\nb {a\rb} {;x} a\\]b {a\\{b} a#b {a\rb}",
  )
  assert_eq(
    @tcl.parse_list("a\\\\\\nb {a\rb} {;x} a\\]b {a\\{b} a#b {a\rb}"),
    values,
  )
}

///|
test "Tcl canonical list fixture 113" {
  let values = ["汉字🚀", ";x", "a\\", "a[b", "汉字🚀"]
  assert_eq(@tcl.format_list(values), "汉字🚀 {;x} a\\\\ {a[b} 汉字🚀")
  assert_eq(@tcl.parse_list("汉字🚀 {;x} a\\\\ {a[b} 汉字🚀"), values)
}

///|
test "Tcl canonical list fixture 114" {
  let values = []
  assert_eq(@tcl.format_list(values), "")
  assert_eq(@tcl.parse_list(""), values)
}

///|
test "Tcl canonical list fixture 115" {
  let values = ["a\rb"]
  assert_eq(@tcl.format_list(values), "{a\rb}")
  assert_eq(@tcl.parse_list("{a\rb}"), values)
}

///|
test "Tcl canonical list fixture 116" {
  let values = ["a\\"]
  assert_eq(@tcl.format_list(values), "a\\\\")
  assert_eq(@tcl.parse_list("a\\\\"), values)
}

///|
test "Tcl canonical list fixture 117" {
  let values = ["a\t b", "汉字🚀", "a#b"]
  assert_eq(@tcl.format_list(values), "{a\t b} 汉字🚀 a#b")
  assert_eq(@tcl.parse_list("{a\t b} 汉字🚀 a#b"), values)
}

///|
test "Tcl canonical list fixture 118" {
  let values = ["a}b"]
  assert_eq(@tcl.format_list(values), "a\\}b")
  assert_eq(@tcl.parse_list("a\\}b"), values)
}

///|
test "Tcl canonical list fixture 119" {
  let values = ["#name"]
  assert_eq(@tcl.format_list(values), "{#name}")
  assert_eq(@tcl.parse_list("{#name}"), values)
}

///|
test "Tcl canonical list fixture 120" {
  let values = ["a]b"]
  assert_eq(@tcl.format_list(values), "a\\]b")
  assert_eq(@tcl.parse_list("a\\]b"), values)
}

///|
test "Tcl canonical list fixture 121" {
  let values = ["汉字🚀", "a}b", "\"a\"", "a\t b", "a\\", "a\rb", "a[b"]
  assert_eq(
    @tcl.format_list(values),
    "汉字🚀 a\\}b {\"a\"} {a\t b} a\\\\ {a\rb} {a[b}",
  )
  assert_eq(
    @tcl.parse_list("汉字🚀 a\\}b {\"a\"} {a\t b} a\\\\ {a\rb} {a[b}"),
    values,
  )
}

///|
test "Tcl canonical list fixture 122" {
  let values = ["a\\", "a{b", ";x", "汉字🚀", "a[b", "a\\ b", "a}b"]
  assert_eq(
    @tcl.format_list(values),
    "a\\\\ a\\{b {;x} 汉字🚀 {a[b} {a\\ b} a\\}b",
  )
  assert_eq(
    @tcl.parse_list("a\\\\ a\\{b {;x} 汉字🚀 {a[b} {a\\ b} a\\}b"),
    values,
  )
}

///|
test "Tcl canonical list fixture 123" {
  let values = ["a\nb", "a#b", "汉字🚀", "a\\{b", "a\\\nb", "a[b", "a b"]
  assert_eq(
    @tcl.format_list(values),
    "{a\nb} a#b 汉字🚀 {a\\{b} a\\\\\\nb {a[b} {a b}",
  )
  assert_eq(
    @tcl.parse_list("{a\nb} a#b 汉字🚀 {a\\{b} a\\\\\\nb {a[b} {a b}"),
    values,
  )
}

///|
test "Tcl canonical list fixture 124" {
  let values = []
  assert_eq(@tcl.format_list(values), "")
  assert_eq(@tcl.parse_list(""), values)
}

///|
test "Tcl canonical list fixture 125" {
  let values = ["$x", "a}b", "\"a\"", "a\\", "a\nb", "a\\\nb"]
  assert_eq(
    @tcl.format_list(values),
    "{$x} a\\}b {\"a\"} a\\\\ {a\nb} a\\\\\\nb",
  )
  assert_eq(
    @tcl.parse_list("{$x} a\\}b {\"a\"} a\\\\ {a\nb} a\\\\\\nb"),
    values,
  )
}

///|
test "Tcl canonical list fixture 126" {
  let values = [";x", "a\\\nb", "a b", "a b"]
  assert_eq(@tcl.format_list(values), "{;x} a\\\\\\nb a b a b")
  assert_eq(@tcl.parse_list("{;x} a\\\\\\nb a b a b"), values)
}

///|
test "Tcl canonical list fixture 127" {
  let values = ["a\\ b", "a\\{b", "a\"b", "a\rb", "汉字🚀", "汉字🚀"]
  assert_eq(
    @tcl.format_list(values),
    "{a\\ b} {a\\{b} a\\\"b {a\rb} 汉字🚀 汉字🚀",
  )
  assert_eq(
    @tcl.parse_list("{a\\ b} {a\\{b} a\\\"b {a\rb} 汉字🚀 汉字🚀"),
    values,
  )
}

///|
test "Tcl canonical list fixture 128" {
  let values = ["a b", "a]b", "a b", "a\nb", "\"a\"", ""]
  assert_eq(@tcl.format_list(values), "a b a\\]b a b {a\nb} {\"a\"} {}")
  assert_eq(@tcl.parse_list("a b a\\]b a b {a\nb} {\"a\"} {}"), values)
}

///|
test "Tcl canonical list fixture 129" {
  let values = ["a\\{b", "$x", "a b"]
  assert_eq(@tcl.format_list(values), "{a\\{b} {$x} {a b}")
  assert_eq(@tcl.parse_list("{a\\{b} {$x} {a b}"), values)
}

///|
test "Tcl canonical list fixture 130" {
  let values = ["a{b", "a b"]
  assert_eq(@tcl.format_list(values), "a\\{b {a b}")
  assert_eq(@tcl.parse_list("a\\{b {a b}"), values)
}

///|
test "Tcl canonical list fixture 131" {
  let values = [
    "汉字🚀", "#name", "a\rb", "a\\", "#name", "a\\\nb", "#name",
  ]
  assert_eq(
    @tcl.format_list(values),
    "汉字🚀 #name {a\rb} a\\\\ #name a\\\\\\nb #name",
  )
  assert_eq(
    @tcl.parse_list("汉字🚀 #name {a\rb} a\\\\ #name a\\\\\\nb #name"),
    values,
  )
}

///|
test "Tcl canonical list fixture 132" {
  let values = ["a{b", "a b", "\"a\"", "a[b"]
  assert_eq(@tcl.format_list(values), "a\\{b {a b} {\"a\"} {a[b}")
  assert_eq(@tcl.parse_list("a\\{b {a b} {\"a\"} {a[b}"), values)
}

///|
test "Tcl canonical list fixture 133" {
  let values = ["$x", "$x"]
  assert_eq(@tcl.format_list(values), "{$x} {$x}")
  assert_eq(@tcl.parse_list("{$x} {$x}"), values)
}

///|
test "Tcl canonical list fixture 134" {
  let values = ["a\"b", "a#b"]
  assert_eq(@tcl.format_list(values), "a\\\"b a#b")
  assert_eq(@tcl.parse_list("a\\\"b a#b"), values)
}

///|
test "Tcl canonical list fixture 135" {
  let values = []
  assert_eq(@tcl.format_list(values), "")
  assert_eq(@tcl.parse_list(""), values)
}

///|
test "Tcl canonical list fixture 136" {
  let values = ["a\\\nb", "a{b", "", "$x", "{a}", "a[b", "a\\{b"]
  assert_eq(
    @tcl.format_list(values),
    "a\\\\\\nb a\\{b {} {$x} {{a}} {a[b} {a\\{b}",
  )
  assert_eq(
    @tcl.parse_list("a\\\\\\nb a\\{b {} {$x} {{a}} {a[b} {a\\{b}"),
    values,
  )
}

///|
test "Tcl canonical list fixture 137" {
  let values = ["a}b", "a b", "a\\"]
  assert_eq(@tcl.format_list(values), "a\\}b {a b} a\\\\")
  assert_eq(@tcl.parse_list("a\\}b {a b} a\\\\"), values)
}

///|
test "Tcl canonical list fixture 138" {
  let values = ["a{b}c"]
  assert_eq(@tcl.format_list(values), "a{b}c")
  assert_eq(@tcl.parse_list("a{b}c"), values)
}

///|
test "Tcl canonical list fixture 139" {
  let values = ["汉字🚀", "a\nb", "\"a\""]
  assert_eq(@tcl.format_list(values), "汉字🚀 {a\nb} {\"a\"}")
  assert_eq(@tcl.parse_list("汉字🚀 {a\nb} {\"a\"}"), values)
}

///|
test "Tcl canonical list fixture 140" {
  let values = ["", "$x", "", "a}b", "a\nb"]
  assert_eq(@tcl.format_list(values), "{} {$x} {} a\\}b {a\nb}")
  assert_eq(@tcl.parse_list("{} {$x} {} a\\}b {a\nb}"), values)
}

///|
test "Tcl canonical list fixture 141" {
  let values = ["a\nb", ""]
  assert_eq(@tcl.format_list(values), "{a\nb} {}")
  assert_eq(@tcl.parse_list("{a\nb} {}"), values)
}

///|
test "Tcl canonical list fixture 142" {
  let values = ["a[b", "a{b", "a\\ b", "a]b", "a\\\nb", "{a}"]
  assert_eq(
    @tcl.format_list(values),
    "{a[b} a\\{b {a\\ b} a\\]b a\\\\\\nb {{a}}",
  )
  assert_eq(
    @tcl.parse_list("{a[b} a\\{b {a\\ b} a\\]b a\\\\\\nb {{a}}"),
    values,
  )
}

///|
test "Tcl canonical list fixture 143" {
  let values = ["\"a\"", "$x", "a\"b", "a\t b"]
  assert_eq(@tcl.format_list(values), "{\"a\"} {$x} a\\\"b {a\t b}")
  assert_eq(@tcl.parse_list("{\"a\"} {$x} a\\\"b {a\t b}"), values)
}

///|
test "Tcl canonical list fixture 144" {
  let values = ["a{b}c", ";x", "simple", "a\nb"]
  assert_eq(@tcl.format_list(values), "a{b}c {;x} simple {a\nb}")
  assert_eq(@tcl.parse_list("a{b}c {;x} simple {a\nb}"), values)
}

///|
test "Tcl canonical list fixture 145" {
  let values = ["a\nb", "{a}", "a\rb", "a}b", "a]b", "simple"]
  assert_eq(@tcl.format_list(values), "{a\nb} {{a}} {a\rb} a\\}b a\\]b simple")
  assert_eq(@tcl.parse_list("{a\nb} {{a}} {a\rb} a\\}b a\\]b simple"), values)
}

///|
test "Tcl canonical list fixture 146" {
  let values = ["a]b"]
  assert_eq(@tcl.format_list(values), "a\\]b")
  assert_eq(@tcl.parse_list("a\\]b"), values)
}

///|
test "Tcl canonical list fixture 147" {
  let values = ["a{b", "a b", "a}b", "汉字🚀", "a{b"]
  assert_eq(@tcl.format_list(values), "a\\{b a b a\\}b 汉字🚀 a\\{b")
  assert_eq(@tcl.parse_list("a\\{b a b a\\}b 汉字🚀 a\\{b"), values)
}

///|
test "Tcl canonical list fixture 148" {
  let values = [";x", "#name", "a\rb"]
  assert_eq(@tcl.format_list(values), "{;x} #name {a\rb}")
  assert_eq(@tcl.parse_list("{;x} #name {a\rb}"), values)
}

///|
test "Tcl canonical list fixture 149" {
  let values = ["a#b", "a[b", ";x", "a{b}c", "a\rb", "a b"]
  assert_eq(@tcl.format_list(values), "a#b {a[b} {;x} a{b}c {a\rb} a b")
  assert_eq(@tcl.parse_list("a#b {a[b} {;x} a{b}c {a\rb} a b"), values)
}

///|
test "Tcl canonical list fixture 150" {
  let values = ["{a}", "{a}", "a\"b", "$x", "a\"b", "a\"b", "a}b"]
  assert_eq(
    @tcl.format_list(values),
    "{{a}} {{a}} a\\\"b {$x} a\\\"b a\\\"b a\\}b",
  )
  assert_eq(
    @tcl.parse_list("{{a}} {{a}} a\\\"b {$x} a\\\"b a\\\"b a\\}b"),
    values,
  )
}

///|
test "Tcl canonical list fixture 151" {
  let values = ["a\\\nb"]
  assert_eq(@tcl.format_list(values), "a\\\\\\nb")
  assert_eq(@tcl.parse_list("a\\\\\\nb"), values)
}

///|
test "Tcl canonical list fixture 152" {
  let values = ["a{b}c"]
  assert_eq(@tcl.format_list(values), "a{b}c")
  assert_eq(@tcl.parse_list("a{b}c"), values)
}

///|
test "Tcl canonical list fixture 153" {
  let values = ["\"a\""]
  assert_eq(@tcl.format_list(values), "{\"a\"}")
  assert_eq(@tcl.parse_list("{\"a\"}"), values)
}

///|
test "Tcl canonical list fixture 154" {
  let values = ["{a}", "\"a\""]
  assert_eq(@tcl.format_list(values), "{{a}} {\"a\"}")
  assert_eq(@tcl.parse_list("{{a}} {\"a\"}"), values)
}

///|
test "Tcl canonical list fixture 155" {
  let values = ["汉字🚀", "a{b", "a\nb", "a\\ b", "$x"]
  assert_eq(@tcl.format_list(values), "汉字🚀 a\\{b {a\nb} {a\\ b} {$x}")
  assert_eq(@tcl.parse_list("汉字🚀 a\\{b {a\nb} {a\\ b} {$x}"), values)
}

///|
test "Tcl canonical list fixture 156" {
  let values = ["a b", "$x", "a\\{b", "a\"b", ";x", ";x"]
  assert_eq(@tcl.format_list(values), "{a b} {$x} {a\\{b} a\\\"b {;x} {;x}")
  assert_eq(@tcl.parse_list("{a b} {$x} {a\\{b} a\\\"b {;x} {;x}"), values)
}

///|
test "Tcl canonical list fixture 157" {
  let values = ["a\nb", "a}b"]
  assert_eq(@tcl.format_list(values), "{a\nb} a\\}b")
  assert_eq(@tcl.parse_list("{a\nb} a\\}b"), values)
}

///|
test "Tcl canonical list fixture 158" {
  let values = ["a\\", "a b", "a\nb", "a b", "a\rb", "a[b"]
  assert_eq(@tcl.format_list(values), "a\\\\ {a b} {a\nb} {a b} {a\rb} {a[b}")
  assert_eq(@tcl.parse_list("a\\\\ {a b} {a\nb} {a b} {a\rb} {a[b}"), values)
}

///|
test "Tcl canonical list fixture 159" {
  let values = ["a\t b", "a\rb", ";x", "a b"]
  assert_eq(@tcl.format_list(values), "{a\t b} {a\rb} {;x} {a b}")
  assert_eq(@tcl.parse_list("{a\t b} {a\rb} {;x} {a b}"), values)
}

///|
test "Tcl canonical list fixture 160" {
  let values = ["a b", "a]b", "$x", "汉字🚀"]
  assert_eq(@tcl.format_list(values), "a b a\\]b {$x} 汉字🚀")
  assert_eq(@tcl.parse_list("a b a\\]b {$x} 汉字🚀"), values)
}

///|
test "Tcl canonical list fixture 161" {
  let values = ["汉字🚀", "a\\", "a b", "a\"b", "a[b"]
  assert_eq(@tcl.format_list(values), "汉字🚀 a\\\\ a b a\\\"b {a[b}")
  assert_eq(@tcl.parse_list("汉字🚀 a\\\\ a b a\\\"b {a[b}"), values)
}

///|
test "Tcl canonical list fixture 162" {
  let values = []
  assert_eq(@tcl.format_list(values), "")
  assert_eq(@tcl.parse_list(""), values)
}

///|
test "Tcl canonical list fixture 163" {
  let values = ["$x", "a\\\nb", "汉字🚀"]
  assert_eq(@tcl.format_list(values), "{$x} a\\\\\\nb 汉字🚀")
  assert_eq(@tcl.parse_list("{$x} a\\\\\\nb 汉字🚀"), values)
}

///|
test "Tcl canonical list fixture 164" {
  let values = ["汉字🚀", "a\"b", "a\t b", ""]
  assert_eq(@tcl.format_list(values), "汉字🚀 a\\\"b {a\t b} {}")
  assert_eq(@tcl.parse_list("汉字🚀 a\\\"b {a\t b} {}"), values)
}

///|
test "Tcl canonical list fixture 165" {
  let values = ["a\nb"]
  assert_eq(@tcl.format_list(values), "{a\nb}")
  assert_eq(@tcl.parse_list("{a\nb}"), values)
}

///|
test "Tcl canonical list fixture 166" {
  let values = ["a\\ b"]
  assert_eq(@tcl.format_list(values), "{a\\ b}")
  assert_eq(@tcl.parse_list("{a\\ b}"), values)
}

///|
test "Tcl canonical list fixture 167" {
  let values = ["simple", "a]b"]
  assert_eq(@tcl.format_list(values), "simple a\\]b")
  assert_eq(@tcl.parse_list("simple a\\]b"), values)
}

///|
test "Tcl canonical list fixture 168" {
  let values = ["a\\\nb", "\"a\""]
  assert_eq(@tcl.format_list(values), "a\\\\\\nb {\"a\"}")
  assert_eq(@tcl.parse_list("a\\\\\\nb {\"a\"}"), values)
}

///|
test "Tcl canonical list fixture 169" {
  let values = ["$x", "a b", "a\"b", "simple", "$x"]
  assert_eq(@tcl.format_list(values), "{$x} a b a\\\"b simple {$x}")
  assert_eq(@tcl.parse_list("{$x} a b a\\\"b simple {$x}"), values)
}

///|
test "Tcl canonical list fixture 170" {
  let values = ["$x", "a\rb", "a b", "a b"]
  assert_eq(@tcl.format_list(values), "{$x} {a\rb} {a b} a b")
  assert_eq(@tcl.parse_list("{$x} {a\rb} {a b} a b"), values)
}

///|
test "Tcl canonical list fixture 171" {
  let values = ["a\\ b", "a}b", "a\\{b"]
  assert_eq(@tcl.format_list(values), "{a\\ b} a\\}b {a\\{b}")
  assert_eq(@tcl.parse_list("{a\\ b} a\\}b {a\\{b}"), values)
}

///|
test "Tcl canonical list fixture 172" {
  let values = ["{a}", "{a}", "a\t b", "a[b", "", "汉字🚀", "a\nb"]
  assert_eq(
    @tcl.format_list(values),
    "{{a}} {{a}} {a\t b} {a[b} {} 汉字🚀 {a\nb}",
  )
  assert_eq(
    @tcl.parse_list("{{a}} {{a}} {a\t b} {a[b} {} 汉字🚀 {a\nb}"),
    values,
  )
}

///|
test "Tcl canonical list fixture 173" {
  let values = ["a}b"]
  assert_eq(@tcl.format_list(values), "a\\}b")
  assert_eq(@tcl.parse_list("a\\}b"), values)
}

///|
test "Tcl canonical list fixture 174" {
  let values = ["a b", "a\t b", "a\\ b", "a\"b", "a\"b", "a b", "a\"b"]
  assert_eq(
    @tcl.format_list(values),
    "{a b} {a\t b} {a\\ b} a\\\"b a\\\"b a b a\\\"b",
  )
  assert_eq(
    @tcl.parse_list("{a b} {a\t b} {a\\ b} a\\\"b a\\\"b a b a\\\"b"),
    values,
  )
}

///|
test "Tcl canonical list fixture 175" {
  let values = ["a\\{b", "a]b", "a b", "a}b", "{a}", "a{b}c", "汉字🚀"]
  assert_eq(
    @tcl.format_list(values),
    "{a\\{b} a\\]b {a b} a\\}b {{a}} a{b}c 汉字🚀",
  )
  assert_eq(
    @tcl.parse_list("{a\\{b} a\\]b {a b} a\\}b {{a}} a{b}c 汉字🚀"),
    values,
  )
}

///|
test "Tcl canonical list fixture 176" {
  let values = ["a{b}c", "a{b}c", "a\\{b"]
  assert_eq(@tcl.format_list(values), "a{b}c a{b}c {a\\{b}")
  assert_eq(@tcl.parse_list("a{b}c a{b}c {a\\{b}"), values)
}

///|
test "Tcl canonical list fixture 177" {
  let values = ["a b", "a\"b"]
  assert_eq(@tcl.format_list(values), "{a b} a\\\"b")
  assert_eq(@tcl.parse_list("{a b} a\\\"b"), values)
}

///|
test "Tcl canonical list fixture 178" {
  let values = ["a]b", "a\\", "{a}", "汉字🚀", "", ""]
  assert_eq(@tcl.format_list(values), "a\\]b a\\\\ {{a}} 汉字🚀 {} {}")
  assert_eq(@tcl.parse_list("a\\]b a\\\\ {{a}} 汉字🚀 {} {}"), values)
}

///|
test "Tcl canonical list fixture 179" {
  let values = ["a\\ b", "a\nb", "a[b", "a\t b", "a b", "a\rb"]
  assert_eq(
    @tcl.format_list(values),
    "{a\\ b} {a\nb} {a[b} {a\t b} {a b} {a\rb}",
  )
  assert_eq(
    @tcl.parse_list("{a\\ b} {a\nb} {a[b} {a\t b} {a b} {a\rb}"),
    values,
  )
}

///|
test "Tcl list parser fixture 0" {
  assert_eq(@tcl.parse_list("{a\\\n b}"), ["a\\\n b"])
}

///|
test "Tcl list parser fixture 1" {
  assert_eq(@tcl.parse_list("\"a\\\n b\""), ["a b"])
}

///|
test "Tcl list parser fixture 2" {
  assert_eq(@tcl.parse_list("a\\\n b"), ["a b"])
}

///|
test "Tcl list parser fixture 3" {
  assert_eq(@tcl.parse_list("a\\"), ["a\\"])
}

///|
test "Tcl list parser fixture 4" {
  assert_eq(@tcl.parse_list("\\x41 \\u20ac \\U0001f680 \\777 \\400"), [
    "A", "€", "�", "?7", " 0",
  ])
}

///|
test "Tcl list parser fixture 5" {
  assert_eq(@tcl.parse_list("{a\\{b} \"quoted word\" simple"), [
    "a\\{b", "quoted word", "simple",
  ])
}

///|
test "Tcl list parser fixture 6" {
  assert_eq(@tcl.parse_list("{} \"\" { {nested} }"), ["", "", " {nested} "])
}

///|
test "Tcl list parser fixture 7" {
  assert_eq(@tcl.parse_list("a\"b a{b"), ["a\"b", "a{b"])
}

///|
test "Tcl list parser fixture 8" {
  assert_true(
    try {
      ignore(@tcl.parse_list("{unterminated"))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl list parser fixture 9" {
  assert_true(
    try {
      ignore(@tcl.parse_list("\"unterminated"))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl list parser fixture 10" {
  assert_true(
    try {
      ignore(@tcl.parse_list("{a}b"))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl list parser fixture 11" {
  assert_true(
    try {
      ignore(@tcl.parse_list("\"a\"b"))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl list control procedure script 0" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("list a b {c d} {  f {g h}}"), "a b {c d} {  f {g h}}")
}

///|
test "Tcl list control procedure script 1" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("llength {a {b c} {}}"), "3")
}

///|
test "Tcl list control procedure script 2" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("lindex {{a b} {c d}} 1 0"), "c")
}

///|
test "Tcl list control procedure script 3" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("lindex {{a b} {c d}} {1 0}"), "c")
}

///|
test "Tcl list control procedure script 4" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("lindex {a b c} end-1"), "b")
}

///|
test "Tcl list control procedure script 5" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("lindex {a b c} end+1"), "")
}

///|
test "Tcl list control procedure script 6" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("lindex {a b c} -1"), "")
}

///|
test "Tcl list control procedure script 7" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("lindex { a   b } {}"), " a   b ")
}

///|
test "Tcl list control procedure script 8" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("set x {a b}; lappend x {c d} {}; set x"), "a b {c d} {}")
}

///|
test "Tcl list control procedure script 9" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("lappend missing"), "")
}

///|
test "Tcl list control procedure script 10" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("split {a,,b,} ,"), "a {} b {}")
}

///|
test "Tcl list control procedure script 11" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("split {} ,"), "")
}

///|
test "Tcl list control procedure script 12" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("split {a b} {}"), "a { } b")
}

///|
test "Tcl list control procedure script 13" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("join {a {b c} {}} ,"), "a,b c,")
}

///|
test "Tcl list control procedure script 14" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("concat {a b} {{c d} e}"), "a b {c d} e")
}

///|
test "Tcl list control procedure script 15" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("lrange {a b c d} 1 end-1"), "b c")
}

///|
test "Tcl list control procedure script 16" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("lrange {a b c} -5 9"), "a b c")
}

///|
test "Tcl list control procedure script 17" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("lreverse {a {b c} {}}"), "{} {b c} a")
}

///|
test "Tcl list control procedure script 18" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("lrepeat 3 x {y z}"), "x {y z} x {y z} x {y z}")
}

///|
test "Tcl list control procedure script 19" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("lrepeat 0 x"), "")
}

///|
test "Tcl list control procedure script 20" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set out {}; foreach x {1 2 3 4} {lappend out [expr {$x * $x}]}; set out",
    ),
    "1 4 9 16",
  )
}

///|
test "Tcl list control procedure script 21" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("set out {}; foreach {i j} {a b c d e} {lappend out $j $i}; set out"),
    "b a d c {} e",
  )
}

///|
test "Tcl list control procedure script 22" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set out {}; foreach i {a b c} j {d e f g} {lappend out $i $j}; set out",
    ),
    "a d b e c f {} g",
  )
}

///|
test "Tcl list control procedure script 23" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set out {}; foreach i {a b c} {j k} {d e f g} {lappend out $i $j $k}; set out",
    ),
    "a d e b f g c {} {}",
  )
}

///|
test "Tcl list control procedure script 24" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set out {}; foreach x {1 2 3 4 5} {if {$x == 2} {continue}; if {$x == 4} {break}; lappend out $x}; set out",
    ),
    "1 3",
  )
}

///|
test "Tcl list control procedure script 25" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set out {}; for {set i 0} {$i < 6} {incr i} {if {$i == 2} {continue}; if {$i == 5} {break}; lappend out $i}; set out",
    ),
    "0 1 3 4",
  )
}

///|
test "Tcl list control procedure script 26" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set i 0; while {$i < 5} {incr i; if {$i == 2} {continue}; if {$i == 4} {break}}; set i",
    ),
    "4",
  )
}

///|
test "Tcl list control procedure script 27" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("proc p {a {b 2} args} {list $a $b $args}; p 1"), "1 2 {}")
}

///|
test "Tcl list control procedure script 28" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("proc p {a {b 2} args} {list $a $b $args}; p 1 3 x {y z}"),
    "1 3 {x {y z}}",
  )
}

///|
test "Tcl list control procedure script 29" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("proc p {a {b {x y}}} {list $a $b}; p hello"), "hello {x y}")
}

///|
test "Tcl list control procedure script 30" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("proc p {{a x} b} {list $a $b}; p 1 2"), "1 2")
}

///|
test "Tcl list control procedure script 31" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("proc p {a a} {set a}; p 1 2"), "1")
}

///|
test "Tcl list control procedure script 32" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("proc p args {llength $args}; p a {b c} d"), "3")
}

///|
test "Tcl list control procedure script 33" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("proc p {{args x}} {set args}; p 1 2"), "1 2")
}

///|
test "Tcl list control procedure script 34" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("proc set {x} {return $x}; set ok"), "ok")
}

///|
test "Tcl list control procedure script 35" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc p {} {foreach x {1 2 3} {if {$x == 2} {return yes}}; return no}; p",
    ),
    "yes",
  )
}

///|
test "Tcl list control procedure script 36" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("list [catch {set x ok} v] $v [catch {error broken} v] $v"),
    "0 ok 1 broken",
  )
}

///|
test "Tcl list control procedure script 37" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "list [catch {return result} v] $v [catch {break}] [catch {continue}]",
    ),
    "2 result 3 4",
  )
}

///|
test "Tcl list control procedure script 38" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("catch {for {set i 0} {$i < 1} {continue} {incr i}}"), "4")
}

///|
test "Tcl list control procedure script 39" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("catch {for {set i 0} {$i < 1} {break} {incr i}}"), "0")
}

///|
test "Tcl list control procedure script 40" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "list \\a \\b \\f \\n \\r \\t \\v \\x41 \\u20ac \\U0001f680 \\777 \\400",
    ),
    "\u0007 \b {\f} {\n} {\r} {\t} {\u000b} A € � ?7 { 0}",
  )
}

///|
test "Tcl list control procedure script 41" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("set x {a\\\n   b}; set x"), "a b")
}

///|
test "Tcl list control procedure script 42" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("set x a\\\n   b; set x"))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl list control procedure script 43" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("proc p {{a x} b} {}; p 1"))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl list control procedure script 44" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("proc p {{a b c}} {}"))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl list control procedure script 45" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("foreach {} {1 2} {}"))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl list control procedure script 46" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("break"))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl list control procedure script 47" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("continue"))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl list control procedure script 48" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("proc p {} {break}; while {1} {p}"))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl list control procedure script 49" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("lrepeat -1 x"))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl list control procedure script 50" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("llength {a} extra"))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl list control procedure script 51" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("set x { a   b }; lappend x"), " a   b ")
}

///|
test "Tcl list control procedure script 52" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("concat { a   b } { \"quoted word\"  x }"),
    "a   b \"quoted word\"  x",
  )
}

///|
test "Tcl list control procedure script 53" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("concat { } {} {x}"), "x")
}

///|
test "Tcl list control procedure script 54" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("lrange {a b c} 0 end+2147483647"), "")
}

///|
test "Tcl list control procedure script 55" {
  let t = @tcl.Interpreter::new()
  assert_eq(t.eval("lrange {a b c} end-2147483647 end"), "a b c")
}
