// Original programs, expected results evaluated by Tcl 8.6.15. Do not hand-edit.

///|
fn check_search_case(
  source : String,
  expected : String,
  output : String,
  rejected : Bool,
  label : String,
) -> Unit raise {
  let t = @tcl.Interpreter::new()
  if rejected {
    assert_true(
      try {
        ignore(t.eval(source, budget=100000))
        false
      } catch {
        _ => true
      },
      msg=label[:],
    )
  } else {
    assert_eq(t.eval(source, budget=100000), expected, msg=label)
    assert_eq(t.output_text(), output, msg=label)
  }
}

///|
test "Tcl search cases 1 through 40" {
  check_search_case(
    "lsearch -exact  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\"",
    "0", "", false, "match-0",
  )
  check_search_case(
    "lsearch -exact -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\"",
    "0", "", false, "match-1",
  )
  check_search_case(
    "lsearch -exact -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\"",
    "", "", false, "match-2",
  )
  check_search_case(
    "lsearch -exact -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\"",
    "{}", "", false, "match-3",
  )
  check_search_case(
    "lsearch -exact -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\"",
    "1", "", false, "match-4",
  )
  check_search_case(
    "lsearch -exact -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\"",
    "a A ab {a b} ba 10 02 汉字 K K k İ i {a\nb} a\u0000b 😀", "", false,
    "match-5",
  )
  check_search_case(
    "lsearch -exact -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\"",
    "0", "", false, "match-6",
  )
  check_search_case(
    "lsearch -exact -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\"",
    "0", "", false, "match-7",
  )
  check_search_case(
    "lsearch -exact  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\"",
    "1", "", false, "match-8",
  )
  check_search_case(
    "lsearch -exact -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\"",
    "1", "", false, "match-9",
  )
  check_search_case(
    "lsearch -exact -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\"",
    "a", "", false, "match-10",
  )
  check_search_case(
    "lsearch -exact -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\"",
    "a", "", false, "match-11",
  )
  check_search_case(
    "lsearch -exact -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\"",
    "0", "", false, "match-12",
  )
  check_search_case(
    "lsearch -exact -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\"",
    "{} A ab {a b} ba 10 02 汉字 K K k İ i {a\nb} a\u0000b 😀", "", false,
    "match-13",
  )
  check_search_case(
    "lsearch -exact -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\"",
    "1", "", false, "match-14",
  )
  check_search_case(
    "lsearch -exact -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\"",
    "1 2", "", false, "match-15",
  )
  check_search_case(
    "lsearch -exact  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"A\"",
    "2", "", false, "match-16",
  )
  check_search_case(
    "lsearch -exact -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"A\"",
    "2", "", false, "match-17",
  )
  check_search_case(
    "lsearch -exact -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"A\"",
    "A", "", false, "match-18",
  )
  check_search_case(
    "lsearch -exact -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"A\"",
    "A", "", false, "match-19",
  )
  check_search_case(
    "lsearch -exact -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"A\"",
    "0", "", false, "match-20",
  )
  check_search_case(
    "lsearch -exact -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"A\"",
    "{} a ab {a b} ba 10 02 汉字 K K k İ i {a\nb} a\u0000b 😀", "", false,
    "match-21",
  )
  check_search_case(
    "lsearch -exact -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"A\"",
    "1", "", false, "match-22",
  )
  check_search_case(
    "lsearch -exact -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"A\"",
    "1 2", "", false, "match-23",
  )
  check_search_case(
    "lsearch -exact  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a*\"",
    "-1", "", false, "match-24",
  )
  check_search_case(
    "lsearch -exact -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a*\"",
    "", "", false, "match-25",
  )
  check_search_case(
    "lsearch -exact -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a*\"",
    "", "", false, "match-26",
  )
  check_search_case(
    "lsearch -exact -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a*\"",
    "", "", false, "match-27",
  )
  check_search_case(
    "lsearch -exact -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a*\"",
    "0", "", false, "match-28",
  )
  check_search_case(
    "lsearch -exact -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a*\"",
    "{} a A ab {a b} ba 10 02 汉字 K K k İ i {a\nb} a\u0000b 😀", "", false,
    "match-29",
  )
  check_search_case(
    "lsearch -exact -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a*\"",
    "-1", "", false, "match-30",
  )
  check_search_case(
    "lsearch -exact -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a*\"",
    "", "", false, "match-31",
  )
  check_search_case(
    "lsearch -exact  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"*a*\"",
    "-1", "", false, "match-32",
  )
  check_search_case(
    "lsearch -exact -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"*a*\"",
    "", "", false, "match-33",
  )
  check_search_case(
    "lsearch -exact -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"*a*\"",
    "", "", false, "match-34",
  )
  check_search_case(
    "lsearch -exact -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"*a*\"",
    "", "", false, "match-35",
  )
  check_search_case(
    "lsearch -exact -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"*a*\"",
    "0", "", false, "match-36",
  )
  check_search_case(
    "lsearch -exact -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"*a*\"",
    "{} a A ab {a b} ba 10 02 汉字 K K k İ i {a\nb} a\u0000b 😀", "", false,
    "match-37",
  )
  check_search_case(
    "lsearch -exact -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"*a*\"",
    "-1", "", false, "match-38",
  )
  check_search_case(
    "lsearch -exact -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"*a*\"",
    "", "", false, "match-39",
  )
}

///|
test "Tcl search cases 41 through 80" {
  check_search_case(
    "lsearch -exact  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"?\"",
    "-1", "", false, "match-40",
  )
  check_search_case(
    "lsearch -exact -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"?\"",
    "", "", false, "match-41",
  )
  check_search_case(
    "lsearch -exact -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"?\"",
    "", "", false, "match-42",
  )
  check_search_case(
    "lsearch -exact -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"?\"",
    "", "", false, "match-43",
  )
  check_search_case(
    "lsearch -exact -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"?\"",
    "0", "", false, "match-44",
  )
  check_search_case(
    "lsearch -exact -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"?\"",
    "{} a A ab {a b} ba 10 02 汉字 K K k İ i {a\nb} a\u0000b 😀", "", false,
    "match-45",
  )
  check_search_case(
    "lsearch -exact -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"?\"",
    "-1", "", false, "match-46",
  )
  check_search_case(
    "lsearch -exact -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"?\"",
    "", "", false, "match-47",
  )
  check_search_case(
    "lsearch -exact  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\[a-b\\]\"",
    "-1", "", false, "match-48",
  )
  check_search_case(
    "lsearch -exact -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\[a-b\\]\"",
    "", "", false, "match-49",
  )
  check_search_case(
    "lsearch -exact -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\[a-b\\]\"",
    "", "", false, "match-50",
  )
  check_search_case(
    "lsearch -exact -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\[a-b\\]\"",
    "", "", false, "match-51",
  )
  check_search_case(
    "lsearch -exact -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\[a-b\\]\"",
    "0", "", false, "match-52",
  )
  check_search_case(
    "lsearch -exact -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\[a-b\\]\"",
    "{} a A ab {a b} ba 10 02 汉字 K K k İ i {a\nb} a\u0000b 😀", "", false,
    "match-53",
  )
  check_search_case(
    "lsearch -exact -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\[a-b\\]\"",
    "-1", "", false, "match-54",
  )
  check_search_case(
    "lsearch -exact -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\[a-b\\]\"",
    "", "", false, "match-55",
  )
  check_search_case(
    "lsearch -exact  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"^a\"",
    "-1", "", false, "match-56",
  )
  check_search_case(
    "lsearch -exact -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"^a\"",
    "", "", false, "match-57",
  )
  check_search_case(
    "lsearch -exact -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"^a\"",
    "", "", false, "match-58",
  )
  check_search_case(
    "lsearch -exact -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"^a\"",
    "", "", false, "match-59",
  )
  check_search_case(
    "lsearch -exact -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"^a\"",
    "0", "", false, "match-60",
  )
  check_search_case(
    "lsearch -exact -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"^a\"",
    "{} a A ab {a b} ba 10 02 汉字 K K k İ i {a\nb} a\u0000b 😀", "", false,
    "match-61",
  )
  check_search_case(
    "lsearch -exact -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"^a\"",
    "-1", "", false, "match-62",
  )
  check_search_case(
    "lsearch -exact -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"^a\"",
    "", "", false, "match-63",
  )
  check_search_case(
    "lsearch -exact  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\\$\"",
    "-1", "", false, "match-64",
  )
  check_search_case(
    "lsearch -exact -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\\$\"",
    "", "", false, "match-65",
  )
  check_search_case(
    "lsearch -exact -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\\$\"",
    "", "", false, "match-66",
  )
  check_search_case(
    "lsearch -exact -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\\$\"",
    "", "", false, "match-67",
  )
  check_search_case(
    "lsearch -exact -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\\$\"",
    "0", "", false, "match-68",
  )
  check_search_case(
    "lsearch -exact -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\\$\"",
    "{} a A ab {a b} ba 10 02 汉字 K K k İ i {a\nb} a\u0000b 😀", "", false,
    "match-69",
  )
  check_search_case(
    "lsearch -exact -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\\$\"",
    "-1", "", false, "match-70",
  )
  check_search_case(
    "lsearch -exact -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\\$\"",
    "", "", false, "match-71",
  )
  check_search_case(
    "lsearch -exact  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)(b?)\"",
    "-1", "", false, "match-72",
  )
  check_search_case(
    "lsearch -exact -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)(b?)\"",
    "", "", false, "match-73",
  )
  check_search_case(
    "lsearch -exact -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)(b?)\"",
    "", "", false, "match-74",
  )
  check_search_case(
    "lsearch -exact -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)(b?)\"",
    "", "", false, "match-75",
  )
  check_search_case(
    "lsearch -exact -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)(b?)\"",
    "0", "", false, "match-76",
  )
  check_search_case(
    "lsearch -exact -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)(b?)\"",
    "{} a A ab {a b} ba 10 02 汉字 K K k İ i {a\nb} a\u0000b 😀", "", false,
    "match-77",
  )
  check_search_case(
    "lsearch -exact -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)(b?)\"",
    "-1", "", false, "match-78",
  )
  check_search_case(
    "lsearch -exact -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)(b?)\"",
    "", "", false, "match-79",
  )
}

///|
test "Tcl search cases 81 through 120" {
  check_search_case(
    "lsearch -exact  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)\\\\1\"",
    "-1", "", false, "match-80",
  )
  check_search_case(
    "lsearch -exact -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)\\\\1\"",
    "", "", false, "match-81",
  )
  check_search_case(
    "lsearch -exact -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)\\\\1\"",
    "", "", false, "match-82",
  )
  check_search_case(
    "lsearch -exact -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)\\\\1\"",
    "", "", false, "match-83",
  )
  check_search_case(
    "lsearch -exact -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)\\\\1\"",
    "0", "", false, "match-84",
  )
  check_search_case(
    "lsearch -exact -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)\\\\1\"",
    "{} a A ab {a b} ba 10 02 汉字 K K k İ i {a\nb} a\u0000b 😀", "", false,
    "match-85",
  )
  check_search_case(
    "lsearch -exact -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)\\\\1\"",
    "-1", "", false, "match-86",
  )
  check_search_case(
    "lsearch -exact -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)\\\\1\"",
    "", "", false, "match-87",
  )
  check_search_case(
    "lsearch -exact  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\\\w+\"",
    "-1", "", false, "match-88",
  )
  check_search_case(
    "lsearch -exact -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\\\w+\"",
    "", "", false, "match-89",
  )
  check_search_case(
    "lsearch -exact -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\\\w+\"",
    "", "", false, "match-90",
  )
  check_search_case(
    "lsearch -exact -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\\\w+\"",
    "", "", false, "match-91",
  )
  check_search_case(
    "lsearch -exact -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\\\w+\"",
    "0", "", false, "match-92",
  )
  check_search_case(
    "lsearch -exact -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\\\w+\"",
    "{} a A ab {a b} ba 10 02 汉字 K K k İ i {a\nb} a\u0000b 😀", "", false,
    "match-93",
  )
  check_search_case(
    "lsearch -exact -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\\\w+\"",
    "-1", "", false, "match-94",
  )
  check_search_case(
    "lsearch -exact -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\\\w+\"",
    "", "", false, "match-95",
  )
  check_search_case(
    "lsearch -exact  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?i)a\"",
    "-1", "", false, "match-96",
  )
  check_search_case(
    "lsearch -exact -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?i)a\"",
    "", "", false, "match-97",
  )
  check_search_case(
    "lsearch -exact -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?i)a\"",
    "", "", false, "match-98",
  )
  check_search_case(
    "lsearch -exact -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?i)a\"",
    "", "", false, "match-99",
  )
  check_search_case(
    "lsearch -exact -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?i)a\"",
    "0", "", false, "match-100",
  )
  check_search_case(
    "lsearch -exact -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?i)a\"",
    "{} a A ab {a b} ba 10 02 汉字 K K k İ i {a\nb} a\u0000b 😀", "", false,
    "match-101",
  )
  check_search_case(
    "lsearch -exact -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?i)a\"",
    "-1", "", false, "match-102",
  )
  check_search_case(
    "lsearch -exact -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?i)a\"",
    "", "", false, "match-103",
  )
  check_search_case(
    "lsearch -exact  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?n)^b\"",
    "-1", "", false, "match-104",
  )
  check_search_case(
    "lsearch -exact -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?n)^b\"",
    "", "", false, "match-105",
  )
  check_search_case(
    "lsearch -exact -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?n)^b\"",
    "", "", false, "match-106",
  )
  check_search_case(
    "lsearch -exact -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?n)^b\"",
    "", "", false, "match-107",
  )
  check_search_case(
    "lsearch -exact -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?n)^b\"",
    "0", "", false, "match-108",
  )
  check_search_case(
    "lsearch -exact -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?n)^b\"",
    "{} a A ab {a b} ba 10 02 汉字 K K k İ i {a\nb} a\u0000b 😀", "", false,
    "match-109",
  )
  check_search_case(
    "lsearch -exact -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?n)^b\"",
    "-1", "", false, "match-110",
  )
  check_search_case(
    "lsearch -exact -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?n)^b\"",
    "", "", false, "match-111",
  )
  check_search_case(
    "lsearch -exact  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"汉\"",
    "-1", "", false, "match-112",
  )
  check_search_case(
    "lsearch -exact -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"汉\"",
    "", "", false, "match-113",
  )
  check_search_case(
    "lsearch -exact -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"汉\"",
    "", "", false, "match-114",
  )
  check_search_case(
    "lsearch -exact -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"汉\"",
    "", "", false, "match-115",
  )
  check_search_case(
    "lsearch -exact -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"汉\"",
    "0", "", false, "match-116",
  )
  check_search_case(
    "lsearch -exact -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"汉\"",
    "{} a A ab {a b} ba 10 02 汉字 K K k İ i {a\nb} a\u0000b 😀", "", false,
    "match-117",
  )
  check_search_case(
    "lsearch -exact -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"汉\"",
    "-1", "", false, "match-118",
  )
  check_search_case(
    "lsearch -exact -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"汉\"",
    "", "", false, "match-119",
  )
}

///|
test "Tcl search cases 121 through 160" {
  check_search_case(
    "lsearch -exact  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\x00\"",
    "-1", "", false, "match-120",
  )
  check_search_case(
    "lsearch -exact -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\x00\"",
    "", "", false, "match-121",
  )
  check_search_case(
    "lsearch -exact -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\x00\"",
    "", "", false, "match-122",
  )
  check_search_case(
    "lsearch -exact -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\x00\"",
    "", "", false, "match-123",
  )
  check_search_case(
    "lsearch -exact -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\x00\"",
    "0", "", false, "match-124",
  )
  check_search_case(
    "lsearch -exact -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\x00\"",
    "{} a A ab {a b} ba 10 02 汉字 K K k İ i {a\nb} a\u0000b 😀", "", false,
    "match-125",
  )
  check_search_case(
    "lsearch -exact -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\x00\"",
    "-1", "", false, "match-126",
  )
  check_search_case(
    "lsearch -exact -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\x00\"",
    "", "", false, "match-127",
  )
  check_search_case(
    "lsearch -exact  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"😀\"",
    "16", "", false, "match-128",
  )
  check_search_case(
    "lsearch -exact -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"😀\"",
    "16", "", false, "match-129",
  )
  check_search_case(
    "lsearch -exact -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"😀\"",
    "😀", "", false, "match-130",
  )
  check_search_case(
    "lsearch -exact -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"😀\"",
    "😀", "", false, "match-131",
  )
  check_search_case(
    "lsearch -exact -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"😀\"",
    "0", "", false, "match-132",
  )
  check_search_case(
    "lsearch -exact -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"😀\"",
    "{} a A ab {a b} ba 10 02 汉字 K K k İ i {a\nb} a\u0000b", "", false, "match-133",
  )
  check_search_case(
    "lsearch -exact -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"😀\"",
    "16", "", false, "match-134",
  )
  check_search_case(
    "lsearch -exact -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"😀\"",
    "16", "", false, "match-135",
  )
  check_search_case(
    "lsearch -exact  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"K\"",
    "9", "", false, "match-136",
  )
  check_search_case(
    "lsearch -exact -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"K\"",
    "9", "", false, "match-137",
  )
  check_search_case(
    "lsearch -exact -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"K\"",
    "K", "", false, "match-138",
  )
  check_search_case(
    "lsearch -exact -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"K\"",
    "K", "", false, "match-139",
  )
  check_search_case(
    "lsearch -exact -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"K\"",
    "0", "", false, "match-140",
  )
  check_search_case(
    "lsearch -exact -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"K\"",
    "{} a A ab {a b} ba 10 02 汉字 K k İ i {a\nb} a\u0000b 😀", "", false, "match-141",
  )
  check_search_case(
    "lsearch -exact -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"K\"",
    "9", "", false, "match-142",
  )
  check_search_case(
    "lsearch -exact -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"K\"",
    "9", "", false, "match-143",
  )
  check_search_case(
    "lsearch -glob  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\"",
    "0", "", false, "match-144",
  )
  check_search_case(
    "lsearch -glob -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\"",
    "0", "", false, "match-145",
  )
  check_search_case(
    "lsearch -glob -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\"",
    "", "", false, "match-146",
  )
  check_search_case(
    "lsearch -glob -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\"",
    "{}", "", false, "match-147",
  )
  check_search_case(
    "lsearch -glob -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\"",
    "1", "", false, "match-148",
  )
  check_search_case(
    "lsearch -glob -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\"",
    "a A ab {a b} ba 10 02 汉字 K K k İ i {a\nb} a\u0000b 😀", "", false,
    "match-149",
  )
  check_search_case(
    "lsearch -glob -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\"",
    "0", "", false, "match-150",
  )
  check_search_case(
    "lsearch -glob -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\"",
    "0", "", false, "match-151",
  )
  check_search_case(
    "lsearch -glob  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\"",
    "1", "", false, "match-152",
  )
  check_search_case(
    "lsearch -glob -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\"",
    "1", "", false, "match-153",
  )
  check_search_case(
    "lsearch -glob -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\"",
    "a", "", false, "match-154",
  )
  check_search_case(
    "lsearch -glob -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\"",
    "a", "", false, "match-155",
  )
  check_search_case(
    "lsearch -glob -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\"",
    "0", "", false, "match-156",
  )
  check_search_case(
    "lsearch -glob -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\"",
    "{} A ab {a b} ba 10 02 汉字 K K k İ i {a\nb} a\u0000b 😀", "", false,
    "match-157",
  )
  check_search_case(
    "lsearch -glob -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\"",
    "1", "", false, "match-158",
  )
  check_search_case(
    "lsearch -glob -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\"",
    "1 2", "", false, "match-159",
  )
}

///|
test "Tcl search cases 161 through 200" {
  check_search_case(
    "lsearch -glob  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"A\"",
    "2", "", false, "match-160",
  )
  check_search_case(
    "lsearch -glob -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"A\"",
    "2", "", false, "match-161",
  )
  check_search_case(
    "lsearch -glob -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"A\"",
    "A", "", false, "match-162",
  )
  check_search_case(
    "lsearch -glob -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"A\"",
    "A", "", false, "match-163",
  )
  check_search_case(
    "lsearch -glob -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"A\"",
    "0", "", false, "match-164",
  )
  check_search_case(
    "lsearch -glob -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"A\"",
    "{} a ab {a b} ba 10 02 汉字 K K k İ i {a\nb} a\u0000b 😀", "", false,
    "match-165",
  )
  check_search_case(
    "lsearch -glob -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"A\"",
    "1", "", false, "match-166",
  )
  check_search_case(
    "lsearch -glob -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"A\"",
    "1 2", "", false, "match-167",
  )
  check_search_case(
    "lsearch -glob  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a*\"",
    "1", "", false, "match-168",
  )
  check_search_case(
    "lsearch -glob -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a*\"",
    "1 3 4 14 15", "", false, "match-169",
  )
  check_search_case(
    "lsearch -glob -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a*\"",
    "a", "", false, "match-170",
  )
  check_search_case(
    "lsearch -glob -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a*\"",
    "a ab {a b} {a\nb} a\u0000b", "", false, "match-171",
  )
  check_search_case(
    "lsearch -glob -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a*\"",
    "0", "", false, "match-172",
  )
  check_search_case(
    "lsearch -glob -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a*\"",
    "{} A ba 10 02 汉字 K K k İ i 😀", "", false, "match-173",
  )
  check_search_case(
    "lsearch -glob -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a*\"",
    "1", "", false, "match-174",
  )
  check_search_case(
    "lsearch -glob -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a*\"",
    "1 2 3 4 14 15", "", false, "match-175",
  )
  check_search_case(
    "lsearch -glob  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"*a*\"",
    "1", "", false, "match-176",
  )
  check_search_case(
    "lsearch -glob -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"*a*\"",
    "1 3 4 5 14 15", "", false, "match-177",
  )
  check_search_case(
    "lsearch -glob -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"*a*\"",
    "a", "", false, "match-178",
  )
  check_search_case(
    "lsearch -glob -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"*a*\"",
    "a ab {a b} ba {a\nb} a\u0000b", "", false, "match-179",
  )
  check_search_case(
    "lsearch -glob -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"*a*\"",
    "0", "", false, "match-180",
  )
  check_search_case(
    "lsearch -glob -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"*a*\"",
    "{} A 10 02 汉字 K K k İ i 😀", "", false, "match-181",
  )
  check_search_case(
    "lsearch -glob -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"*a*\"",
    "1", "", false, "match-182",
  )
  check_search_case(
    "lsearch -glob -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"*a*\"",
    "1 2 3 4 5 14 15", "", false, "match-183",
  )
  check_search_case(
    "lsearch -glob  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"?\"",
    "1", "", false, "match-184",
  )
  check_search_case(
    "lsearch -glob -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"?\"",
    "1 2 9 10 11 12 13 16", "", false, "match-185",
  )
  check_search_case(
    "lsearch -glob -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"?\"",
    "a", "", false, "match-186",
  )
  check_search_case(
    "lsearch -glob -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"?\"",
    "a A K K k İ i 😀", "", false, "match-187",
  )
  check_search_case(
    "lsearch -glob -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"?\"",
    "0", "", false, "match-188",
  )
  check_search_case(
    "lsearch -glob -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"?\"",
    "{} ab {a b} ba 10 02 汉字 {a\nb} a\u0000b", "", false, "match-189",
  )
  check_search_case(
    "lsearch -glob -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"?\"",
    "1", "", false, "match-190",
  )
  check_search_case(
    "lsearch -glob -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"?\"",
    "1 2 9 10 11 12 13 16", "", false, "match-191",
  )
  check_search_case(
    "lsearch -glob  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\[a-b\\]\"",
    "1", "", false, "match-192",
  )
  check_search_case(
    "lsearch -glob -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\[a-b\\]\"",
    "1", "", false, "match-193",
  )
  check_search_case(
    "lsearch -glob -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\[a-b\\]\"",
    "a", "", false, "match-194",
  )
  check_search_case(
    "lsearch -glob -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\[a-b\\]\"",
    "a", "", false, "match-195",
  )
  check_search_case(
    "lsearch -glob -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\[a-b\\]\"",
    "0", "", false, "match-196",
  )
  check_search_case(
    "lsearch -glob -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\[a-b\\]\"",
    "{} A ab {a b} ba 10 02 汉字 K K k İ i {a\nb} a\u0000b 😀", "", false,
    "match-197",
  )
  check_search_case(
    "lsearch -glob -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\[a-b\\]\"",
    "1", "", false, "match-198",
  )
  check_search_case(
    "lsearch -glob -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\[a-b\\]\"",
    "1 2", "", false, "match-199",
  )
}

///|
test "Tcl search cases 201 through 240" {
  check_search_case(
    "lsearch -glob  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"^a\"",
    "-1", "", false, "match-200",
  )
  check_search_case(
    "lsearch -glob -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"^a\"",
    "", "", false, "match-201",
  )
  check_search_case(
    "lsearch -glob -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"^a\"",
    "", "", false, "match-202",
  )
  check_search_case(
    "lsearch -glob -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"^a\"",
    "", "", false, "match-203",
  )
  check_search_case(
    "lsearch -glob -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"^a\"",
    "0", "", false, "match-204",
  )
  check_search_case(
    "lsearch -glob -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"^a\"",
    "{} a A ab {a b} ba 10 02 汉字 K K k İ i {a\nb} a\u0000b 😀", "", false,
    "match-205",
  )
  check_search_case(
    "lsearch -glob -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"^a\"",
    "-1", "", false, "match-206",
  )
  check_search_case(
    "lsearch -glob -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"^a\"",
    "", "", false, "match-207",
  )
  check_search_case(
    "lsearch -glob  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\\$\"",
    "-1", "", false, "match-208",
  )
  check_search_case(
    "lsearch -glob -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\\$\"",
    "", "", false, "match-209",
  )
  check_search_case(
    "lsearch -glob -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\\$\"",
    "", "", false, "match-210",
  )
  check_search_case(
    "lsearch -glob -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\\$\"",
    "", "", false, "match-211",
  )
  check_search_case(
    "lsearch -glob -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\\$\"",
    "0", "", false, "match-212",
  )
  check_search_case(
    "lsearch -glob -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\\$\"",
    "{} a A ab {a b} ba 10 02 汉字 K K k İ i {a\nb} a\u0000b 😀", "", false,
    "match-213",
  )
  check_search_case(
    "lsearch -glob -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\\$\"",
    "-1", "", false, "match-214",
  )
  check_search_case(
    "lsearch -glob -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\\$\"",
    "", "", false, "match-215",
  )
  check_search_case(
    "lsearch -glob  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)(b?)\"",
    "-1", "", false, "match-216",
  )
  check_search_case(
    "lsearch -glob -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)(b?)\"",
    "", "", false, "match-217",
  )
  check_search_case(
    "lsearch -glob -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)(b?)\"",
    "", "", false, "match-218",
  )
  check_search_case(
    "lsearch -glob -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)(b?)\"",
    "", "", false, "match-219",
  )
  check_search_case(
    "lsearch -glob -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)(b?)\"",
    "0", "", false, "match-220",
  )
  check_search_case(
    "lsearch -glob -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)(b?)\"",
    "{} a A ab {a b} ba 10 02 汉字 K K k İ i {a\nb} a\u0000b 😀", "", false,
    "match-221",
  )
  check_search_case(
    "lsearch -glob -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)(b?)\"",
    "-1", "", false, "match-222",
  )
  check_search_case(
    "lsearch -glob -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)(b?)\"",
    "", "", false, "match-223",
  )
  check_search_case(
    "lsearch -glob  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)\\\\1\"",
    "-1", "", false, "match-224",
  )
  check_search_case(
    "lsearch -glob -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)\\\\1\"",
    "", "", false, "match-225",
  )
  check_search_case(
    "lsearch -glob -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)\\\\1\"",
    "", "", false, "match-226",
  )
  check_search_case(
    "lsearch -glob -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)\\\\1\"",
    "", "", false, "match-227",
  )
  check_search_case(
    "lsearch -glob -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)\\\\1\"",
    "0", "", false, "match-228",
  )
  check_search_case(
    "lsearch -glob -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)\\\\1\"",
    "{} a A ab {a b} ba 10 02 汉字 K K k İ i {a\nb} a\u0000b 😀", "", false,
    "match-229",
  )
  check_search_case(
    "lsearch -glob -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)\\\\1\"",
    "-1", "", false, "match-230",
  )
  check_search_case(
    "lsearch -glob -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)\\\\1\"",
    "", "", false, "match-231",
  )
  check_search_case(
    "lsearch -glob  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\\\w+\"",
    "-1", "", false, "match-232",
  )
  check_search_case(
    "lsearch -glob -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\\\w+\"",
    "", "", false, "match-233",
  )
  check_search_case(
    "lsearch -glob -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\\\w+\"",
    "", "", false, "match-234",
  )
  check_search_case(
    "lsearch -glob -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\\\w+\"",
    "", "", false, "match-235",
  )
  check_search_case(
    "lsearch -glob -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\\\w+\"",
    "0", "", false, "match-236",
  )
  check_search_case(
    "lsearch -glob -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\\\w+\"",
    "{} a A ab {a b} ba 10 02 汉字 K K k İ i {a\nb} a\u0000b 😀", "", false,
    "match-237",
  )
  check_search_case(
    "lsearch -glob -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\\\w+\"",
    "-1", "", false, "match-238",
  )
  check_search_case(
    "lsearch -glob -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\\\w+\"",
    "", "", false, "match-239",
  )
}

///|
test "Tcl search cases 241 through 280" {
  check_search_case(
    "lsearch -glob  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?i)a\"",
    "-1", "", false, "match-240",
  )
  check_search_case(
    "lsearch -glob -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?i)a\"",
    "", "", false, "match-241",
  )
  check_search_case(
    "lsearch -glob -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?i)a\"",
    "", "", false, "match-242",
  )
  check_search_case(
    "lsearch -glob -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?i)a\"",
    "", "", false, "match-243",
  )
  check_search_case(
    "lsearch -glob -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?i)a\"",
    "0", "", false, "match-244",
  )
  check_search_case(
    "lsearch -glob -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?i)a\"",
    "{} a A ab {a b} ba 10 02 汉字 K K k İ i {a\nb} a\u0000b 😀", "", false,
    "match-245",
  )
  check_search_case(
    "lsearch -glob -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?i)a\"",
    "-1", "", false, "match-246",
  )
  check_search_case(
    "lsearch -glob -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?i)a\"",
    "", "", false, "match-247",
  )
  check_search_case(
    "lsearch -glob  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?n)^b\"",
    "-1", "", false, "match-248",
  )
  check_search_case(
    "lsearch -glob -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?n)^b\"",
    "", "", false, "match-249",
  )
  check_search_case(
    "lsearch -glob -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?n)^b\"",
    "", "", false, "match-250",
  )
  check_search_case(
    "lsearch -glob -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?n)^b\"",
    "", "", false, "match-251",
  )
  check_search_case(
    "lsearch -glob -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?n)^b\"",
    "0", "", false, "match-252",
  )
  check_search_case(
    "lsearch -glob -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?n)^b\"",
    "{} a A ab {a b} ba 10 02 汉字 K K k İ i {a\nb} a\u0000b 😀", "", false,
    "match-253",
  )
  check_search_case(
    "lsearch -glob -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?n)^b\"",
    "-1", "", false, "match-254",
  )
  check_search_case(
    "lsearch -glob -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?n)^b\"",
    "", "", false, "match-255",
  )
  check_search_case(
    "lsearch -glob  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"汉\"",
    "-1", "", false, "match-256",
  )
  check_search_case(
    "lsearch -glob -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"汉\"",
    "", "", false, "match-257",
  )
  check_search_case(
    "lsearch -glob -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"汉\"",
    "", "", false, "match-258",
  )
  check_search_case(
    "lsearch -glob -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"汉\"",
    "", "", false, "match-259",
  )
  check_search_case(
    "lsearch -glob -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"汉\"",
    "0", "", false, "match-260",
  )
  check_search_case(
    "lsearch -glob -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"汉\"",
    "{} a A ab {a b} ba 10 02 汉字 K K k İ i {a\nb} a\u0000b 😀", "", false,
    "match-261",
  )
  check_search_case(
    "lsearch -glob -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"汉\"",
    "-1", "", false, "match-262",
  )
  check_search_case(
    "lsearch -glob -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"汉\"",
    "", "", false, "match-263",
  )
  check_search_case(
    "lsearch -glob  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\x00\"",
    "-1", "", false, "match-264",
  )
  check_search_case(
    "lsearch -glob -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\x00\"",
    "", "", false, "match-265",
  )
  check_search_case(
    "lsearch -glob -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\x00\"",
    "", "", false, "match-266",
  )
  check_search_case(
    "lsearch -glob -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\x00\"",
    "", "", false, "match-267",
  )
  check_search_case(
    "lsearch -glob -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\x00\"",
    "0", "", false, "match-268",
  )
  check_search_case(
    "lsearch -glob -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\x00\"",
    "{} a A ab {a b} ba 10 02 汉字 K K k İ i {a\nb} a\u0000b 😀", "", false,
    "match-269",
  )
  check_search_case(
    "lsearch -glob -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\x00\"",
    "-1", "", false, "match-270",
  )
  check_search_case(
    "lsearch -glob -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\x00\"",
    "", "", false, "match-271",
  )
  check_search_case(
    "lsearch -glob  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"😀\"",
    "16", "", false, "match-272",
  )
  check_search_case(
    "lsearch -glob -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"😀\"",
    "16", "", false, "match-273",
  )
  check_search_case(
    "lsearch -glob -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"😀\"",
    "😀", "", false, "match-274",
  )
  check_search_case(
    "lsearch -glob -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"😀\"",
    "😀", "", false, "match-275",
  )
  check_search_case(
    "lsearch -glob -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"😀\"",
    "0", "", false, "match-276",
  )
  check_search_case(
    "lsearch -glob -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"😀\"",
    "{} a A ab {a b} ba 10 02 汉字 K K k İ i {a\nb} a\u0000b", "", false, "match-277",
  )
  check_search_case(
    "lsearch -glob -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"😀\"",
    "16", "", false, "match-278",
  )
  check_search_case(
    "lsearch -glob -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"😀\"",
    "16", "", false, "match-279",
  )
}

///|
test "Tcl search cases 281 through 320" {
  check_search_case(
    "lsearch -glob  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"K\"",
    "9", "", false, "match-280",
  )
  check_search_case(
    "lsearch -glob -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"K\"",
    "9", "", false, "match-281",
  )
  check_search_case(
    "lsearch -glob -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"K\"",
    "K", "", false, "match-282",
  )
  check_search_case(
    "lsearch -glob -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"K\"",
    "K", "", false, "match-283",
  )
  check_search_case(
    "lsearch -glob -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"K\"",
    "0", "", false, "match-284",
  )
  check_search_case(
    "lsearch -glob -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"K\"",
    "{} a A ab {a b} ba 10 02 汉字 K k İ i {a\nb} a\u0000b 😀", "", false, "match-285",
  )
  check_search_case(
    "lsearch -glob -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"K\"",
    "9", "", false, "match-286",
  )
  check_search_case(
    "lsearch -glob -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"K\"",
    "9 10 11", "", false, "match-287",
  )
  check_search_case(
    "lsearch -regexp  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\"",
    "0", "", false, "match-288",
  )
  check_search_case(
    "lsearch -regexp -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\"",
    "0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16", "", false, "match-289",
  )
  check_search_case(
    "lsearch -regexp -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\"",
    "", "", false, "match-290",
  )
  check_search_case(
    "lsearch -regexp -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\"",
    "{} a A ab {a b} ba 10 02 汉字 K K k İ i {a\nb} a\u0000b 😀", "", false,
    "match-291",
  )
  check_search_case(
    "lsearch -regexp -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\"",
    "-1", "", false, "match-292",
  )
  check_search_case(
    "lsearch -regexp -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\"",
    "", "", false, "match-293",
  )
  check_search_case(
    "lsearch -regexp -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\"",
    "0", "", false, "match-294",
  )
  check_search_case(
    "lsearch -regexp -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\"",
    "0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16", "", false, "match-295",
  )
  check_search_case(
    "lsearch -regexp  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\"",
    "1", "", false, "match-296",
  )
  check_search_case(
    "lsearch -regexp -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\"",
    "1 3 4 5 14 15", "", false, "match-297",
  )
  check_search_case(
    "lsearch -regexp -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\"",
    "a", "", false, "match-298",
  )
  check_search_case(
    "lsearch -regexp -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\"",
    "a ab {a b} ba {a\nb} a\u0000b", "", false, "match-299",
  )
  check_search_case(
    "lsearch -regexp -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\"",
    "0", "", false, "match-300",
  )
  check_search_case(
    "lsearch -regexp -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\"",
    "{} A 10 02 汉字 K K k İ i 😀", "", false, "match-301",
  )
  check_search_case(
    "lsearch -regexp -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\"",
    "1", "", false, "match-302",
  )
  check_search_case(
    "lsearch -regexp -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\"",
    "1 2 3 4 5 14 15", "", false, "match-303",
  )
  check_search_case(
    "lsearch -regexp  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"A\"",
    "2", "", false, "match-304",
  )
  check_search_case(
    "lsearch -regexp -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"A\"",
    "2", "", false, "match-305",
  )
  check_search_case(
    "lsearch -regexp -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"A\"",
    "A", "", false, "match-306",
  )
  check_search_case(
    "lsearch -regexp -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"A\"",
    "A", "", false, "match-307",
  )
  check_search_case(
    "lsearch -regexp -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"A\"",
    "0", "", false, "match-308",
  )
  check_search_case(
    "lsearch -regexp -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"A\"",
    "{} a ab {a b} ba 10 02 汉字 K K k İ i {a\nb} a\u0000b 😀", "", false,
    "match-309",
  )
  check_search_case(
    "lsearch -regexp -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"A\"",
    "1", "", false, "match-310",
  )
  check_search_case(
    "lsearch -regexp -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"A\"",
    "1 2 3 4 5 14 15", "", false, "match-311",
  )
  check_search_case(
    "lsearch -regexp  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a*\"",
    "0", "", false, "match-312",
  )
  check_search_case(
    "lsearch -regexp -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a*\"",
    "0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16", "", false, "match-313",
  )
  check_search_case(
    "lsearch -regexp -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a*\"",
    "", "", false, "match-314",
  )
  check_search_case(
    "lsearch -regexp -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a*\"",
    "{} a A ab {a b} ba 10 02 汉字 K K k İ i {a\nb} a\u0000b 😀", "", false,
    "match-315",
  )
  check_search_case(
    "lsearch -regexp -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a*\"",
    "-1", "", false, "match-316",
  )
  check_search_case(
    "lsearch -regexp -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a*\"",
    "", "", false, "match-317",
  )
  check_search_case(
    "lsearch -regexp -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a*\"",
    "0", "", false, "match-318",
  )
  check_search_case(
    "lsearch -regexp -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a*\"",
    "0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16", "", false, "match-319",
  )
}

///|
test "Tcl search cases 321 through 360" {
  check_search_case(
    "lsearch -regexp  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"*a*\"",
    "couldn't compile regular expression pattern: quantifier operand invalid", "",
    true, "match-320",
  )
  check_search_case(
    "lsearch -regexp -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"*a*\"",
    "couldn't compile regular expression pattern: quantifier operand invalid", "",
    true, "match-321",
  )
  check_search_case(
    "lsearch -regexp -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"*a*\"",
    "couldn't compile regular expression pattern: quantifier operand invalid", "",
    true, "match-322",
  )
  check_search_case(
    "lsearch -regexp -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"*a*\"",
    "couldn't compile regular expression pattern: quantifier operand invalid", "",
    true, "match-323",
  )
  check_search_case(
    "lsearch -regexp -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"*a*\"",
    "couldn't compile regular expression pattern: quantifier operand invalid", "",
    true, "match-324",
  )
  check_search_case(
    "lsearch -regexp -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"*a*\"",
    "couldn't compile regular expression pattern: quantifier operand invalid", "",
    true, "match-325",
  )
  check_search_case(
    "lsearch -regexp -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"*a*\"",
    "couldn't compile regular expression pattern: quantifier operand invalid", "",
    true, "match-326",
  )
  check_search_case(
    "lsearch -regexp -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"*a*\"",
    "couldn't compile regular expression pattern: quantifier operand invalid", "",
    true, "match-327",
  )
  check_search_case(
    "lsearch -regexp  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"?\"",
    "couldn't compile regular expression pattern: quantifier operand invalid", "",
    true, "match-328",
  )
  check_search_case(
    "lsearch -regexp -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"?\"",
    "couldn't compile regular expression pattern: quantifier operand invalid", "",
    true, "match-329",
  )
  check_search_case(
    "lsearch -regexp -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"?\"",
    "couldn't compile regular expression pattern: quantifier operand invalid", "",
    true, "match-330",
  )
  check_search_case(
    "lsearch -regexp -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"?\"",
    "couldn't compile regular expression pattern: quantifier operand invalid", "",
    true, "match-331",
  )
  check_search_case(
    "lsearch -regexp -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"?\"",
    "couldn't compile regular expression pattern: quantifier operand invalid", "",
    true, "match-332",
  )
  check_search_case(
    "lsearch -regexp -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"?\"",
    "couldn't compile regular expression pattern: quantifier operand invalid", "",
    true, "match-333",
  )
  check_search_case(
    "lsearch -regexp -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"?\"",
    "couldn't compile regular expression pattern: quantifier operand invalid", "",
    true, "match-334",
  )
  check_search_case(
    "lsearch -regexp -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"?\"",
    "couldn't compile regular expression pattern: quantifier operand invalid", "",
    true, "match-335",
  )
  check_search_case(
    "lsearch -regexp  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\[a-b\\]\"",
    "1", "", false, "match-336",
  )
  check_search_case(
    "lsearch -regexp -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\[a-b\\]\"",
    "1 3 4 5 14 15", "", false, "match-337",
  )
  check_search_case(
    "lsearch -regexp -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\[a-b\\]\"",
    "a", "", false, "match-338",
  )
  check_search_case(
    "lsearch -regexp -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\[a-b\\]\"",
    "a ab {a b} ba {a\nb} a\u0000b", "", false, "match-339",
  )
  check_search_case(
    "lsearch -regexp -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\[a-b\\]\"",
    "0", "", false, "match-340",
  )
  check_search_case(
    "lsearch -regexp -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\[a-b\\]\"",
    "{} A 10 02 汉字 K K k İ i 😀", "", false, "match-341",
  )
  check_search_case(
    "lsearch -regexp -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\[a-b\\]\"",
    "1", "", false, "match-342",
  )
  check_search_case(
    "lsearch -regexp -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\[a-b\\]\"",
    "1 2 3 4 5 14 15", "", false, "match-343",
  )
  check_search_case(
    "lsearch -regexp  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"^a\"",
    "1", "", false, "match-344",
  )
  check_search_case(
    "lsearch -regexp -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"^a\"",
    "1 3 4 14 15", "", false, "match-345",
  )
  check_search_case(
    "lsearch -regexp -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"^a\"",
    "a", "", false, "match-346",
  )
  check_search_case(
    "lsearch -regexp -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"^a\"",
    "a ab {a b} {a\nb} a\u0000b", "", false, "match-347",
  )
  check_search_case(
    "lsearch -regexp -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"^a\"",
    "0", "", false, "match-348",
  )
  check_search_case(
    "lsearch -regexp -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"^a\"",
    "{} A ba 10 02 汉字 K K k İ i 😀", "", false, "match-349",
  )
  check_search_case(
    "lsearch -regexp -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"^a\"",
    "1", "", false, "match-350",
  )
  check_search_case(
    "lsearch -regexp -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"^a\"",
    "1 2 3 4 14 15", "", false, "match-351",
  )
  check_search_case(
    "lsearch -regexp  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\\$\"",
    "1", "", false, "match-352",
  )
  check_search_case(
    "lsearch -regexp -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\\$\"",
    "1 5", "", false, "match-353",
  )
  check_search_case(
    "lsearch -regexp -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\\$\"",
    "a", "", false, "match-354",
  )
  check_search_case(
    "lsearch -regexp -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\\$\"",
    "a ba", "", false, "match-355",
  )
  check_search_case(
    "lsearch -regexp -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\\$\"",
    "0", "", false, "match-356",
  )
  check_search_case(
    "lsearch -regexp -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\\$\"",
    "{} A ab {a b} 10 02 汉字 K K k İ i {a\nb} a\u0000b 😀", "", false, "match-357",
  )
  check_search_case(
    "lsearch -regexp -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\\$\"",
    "1", "", false, "match-358",
  )
  check_search_case(
    "lsearch -regexp -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"a\\$\"",
    "1 2 5", "", false, "match-359",
  )
}

///|
test "Tcl search cases 361 through 400" {
  check_search_case(
    "lsearch -regexp  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)(b?)\"",
    "1", "", false, "match-360",
  )
  check_search_case(
    "lsearch -regexp -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)(b?)\"",
    "1 3 4 5 14 15", "", false, "match-361",
  )
  check_search_case(
    "lsearch -regexp -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)(b?)\"",
    "a", "", false, "match-362",
  )
  check_search_case(
    "lsearch -regexp -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)(b?)\"",
    "a ab {a b} ba {a\nb} a\u0000b", "", false, "match-363",
  )
  check_search_case(
    "lsearch -regexp -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)(b?)\"",
    "0", "", false, "match-364",
  )
  check_search_case(
    "lsearch -regexp -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)(b?)\"",
    "{} A 10 02 汉字 K K k İ i 😀", "", false, "match-365",
  )
  check_search_case(
    "lsearch -regexp -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)(b?)\"",
    "1", "", false, "match-366",
  )
  check_search_case(
    "lsearch -regexp -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)(b?)\"",
    "1 2 3 4 5 14 15", "", false, "match-367",
  )
  check_search_case(
    "lsearch -regexp  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)\\\\1\"",
    "-1", "", false, "match-368",
  )
  check_search_case(
    "lsearch -regexp -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)\\\\1\"",
    "", "", false, "match-369",
  )
  check_search_case(
    "lsearch -regexp -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)\\\\1\"",
    "", "", false, "match-370",
  )
  check_search_case(
    "lsearch -regexp -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)\\\\1\"",
    "", "", false, "match-371",
  )
  check_search_case(
    "lsearch -regexp -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)\\\\1\"",
    "0", "", false, "match-372",
  )
  check_search_case(
    "lsearch -regexp -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)\\\\1\"",
    "{} a A ab {a b} ba 10 02 汉字 K K k İ i {a\nb} a\u0000b 😀", "", false,
    "match-373",
  )
  check_search_case(
    "lsearch -regexp -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)\\\\1\"",
    "-1", "", false, "match-374",
  )
  check_search_case(
    "lsearch -regexp -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(a)\\\\1\"",
    "", "", false, "match-375",
  )
  check_search_case(
    "lsearch -regexp  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\\\w+\"",
    "1", "", false, "match-376",
  )
  check_search_case(
    "lsearch -regexp -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\\\w+\"",
    "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15", "", false, "match-377",
  )
  check_search_case(
    "lsearch -regexp -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\\\w+\"",
    "a", "", false, "match-378",
  )
  check_search_case(
    "lsearch -regexp -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\\\w+\"",
    "a A ab {a b} ba 10 02 汉字 K K k İ i {a\nb} a\u0000b", "", false, "match-379",
  )
  check_search_case(
    "lsearch -regexp -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\\\w+\"",
    "0", "", false, "match-380",
  )
  check_search_case(
    "lsearch -regexp -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\\\w+\"",
    "{} 😀", "", false, "match-381",
  )
  check_search_case(
    "lsearch -regexp -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\\\w+\"",
    "1", "", false, "match-382",
  )
  check_search_case(
    "lsearch -regexp -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\\\w+\"",
    "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15", "", false, "match-383",
  )
  check_search_case(
    "lsearch -regexp  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?i)a\"",
    "1", "", false, "match-384",
  )
  check_search_case(
    "lsearch -regexp -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?i)a\"",
    "1 2 3 4 5 14 15", "", false, "match-385",
  )
  check_search_case(
    "lsearch -regexp -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?i)a\"",
    "a", "", false, "match-386",
  )
  check_search_case(
    "lsearch -regexp -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?i)a\"",
    "a A ab {a b} ba {a\nb} a\u0000b", "", false, "match-387",
  )
  check_search_case(
    "lsearch -regexp -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?i)a\"",
    "0", "", false, "match-388",
  )
  check_search_case(
    "lsearch -regexp -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?i)a\"",
    "{} 10 02 汉字 K K k İ i 😀", "", false, "match-389",
  )
  check_search_case(
    "lsearch -regexp -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?i)a\"",
    "1", "", false, "match-390",
  )
  check_search_case(
    "lsearch -regexp -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?i)a\"",
    "1 2 3 4 5 14 15", "", false, "match-391",
  )
  check_search_case(
    "lsearch -regexp  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?n)^b\"",
    "5", "", false, "match-392",
  )
  check_search_case(
    "lsearch -regexp -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?n)^b\"",
    "5 14", "", false, "match-393",
  )
  check_search_case(
    "lsearch -regexp -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?n)^b\"",
    "ba", "", false, "match-394",
  )
  check_search_case(
    "lsearch -regexp -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?n)^b\"",
    "ba {a\nb}", "", false, "match-395",
  )
  check_search_case(
    "lsearch -regexp -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?n)^b\"",
    "0", "", false, "match-396",
  )
  check_search_case(
    "lsearch -regexp -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?n)^b\"",
    "{} a A ab {a b} 10 02 汉字 K K k İ i a\u0000b 😀", "", false, "match-397",
  )
  check_search_case(
    "lsearch -regexp -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?n)^b\"",
    "5", "", false, "match-398",
  )
  check_search_case(
    "lsearch -regexp -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"(?n)^b\"",
    "5 14", "", false, "match-399",
  )
}

///|
test "Tcl search cases 401 through 440" {
  check_search_case(
    "lsearch -regexp  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"汉\"",
    "8", "", false, "match-400",
  )
  check_search_case(
    "lsearch -regexp -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"汉\"",
    "8", "", false, "match-401",
  )
  check_search_case(
    "lsearch -regexp -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"汉\"",
    "汉字", "", false, "match-402",
  )
  check_search_case(
    "lsearch -regexp -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"汉\"",
    "汉字", "", false, "match-403",
  )
  check_search_case(
    "lsearch -regexp -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"汉\"",
    "0", "", false, "match-404",
  )
  check_search_case(
    "lsearch -regexp -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"汉\"",
    "{} a A ab {a b} ba 10 02 K K k İ i {a\nb} a\u0000b 😀", "", false, "match-405",
  )
  check_search_case(
    "lsearch -regexp -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"汉\"",
    "8", "", false, "match-406",
  )
  check_search_case(
    "lsearch -regexp -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"汉\"",
    "8", "", false, "match-407",
  )
  check_search_case(
    "lsearch -regexp  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\x00\"",
    "15", "", false, "match-408",
  )
  check_search_case(
    "lsearch -regexp -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\x00\"",
    "15", "", false, "match-409",
  )
  check_search_case(
    "lsearch -regexp -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\x00\"",
    "a\u0000b", "", false, "match-410",
  )
  check_search_case(
    "lsearch -regexp -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\x00\"",
    "a\u0000b", "", false, "match-411",
  )
  check_search_case(
    "lsearch -regexp -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\x00\"",
    "0", "", false, "match-412",
  )
  check_search_case(
    "lsearch -regexp -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\x00\"",
    "{} a A ab {a b} ba 10 02 汉字 K K k İ i {a\nb} 😀", "", false, "match-413",
  )
  check_search_case(
    "lsearch -regexp -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\x00\"",
    "15", "", false, "match-414",
  )
  check_search_case(
    "lsearch -regexp -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"\\x00\"",
    "15", "", false, "match-415",
  )
  check_search_case(
    "lsearch -regexp  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"😀\"",
    "16", "", false, "match-416",
  )
  check_search_case(
    "lsearch -regexp -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"😀\"",
    "16", "", false, "match-417",
  )
  check_search_case(
    "lsearch -regexp -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"😀\"",
    "😀", "", false, "match-418",
  )
  check_search_case(
    "lsearch -regexp -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"😀\"",
    "😀", "", false, "match-419",
  )
  check_search_case(
    "lsearch -regexp -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"😀\"",
    "0", "", false, "match-420",
  )
  check_search_case(
    "lsearch -regexp -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"😀\"",
    "{} a A ab {a b} ba 10 02 汉字 K K k İ i {a\nb} a\u0000b", "", false, "match-421",
  )
  check_search_case(
    "lsearch -regexp -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"😀\"",
    "16", "", false, "match-422",
  )
  check_search_case(
    "lsearch -regexp -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"😀\"",
    "16", "", false, "match-423",
  )
  check_search_case(
    "lsearch -regexp  [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"K\"",
    "9", "", false, "match-424",
  )
  check_search_case(
    "lsearch -regexp -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"K\"",
    "9", "", false, "match-425",
  )
  check_search_case(
    "lsearch -regexp -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"K\"",
    "K", "", false, "match-426",
  )
  check_search_case(
    "lsearch -regexp -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"K\"",
    "K", "", false, "match-427",
  )
  check_search_case(
    "lsearch -regexp -not [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"K\"",
    "0", "", false, "match-428",
  )
  check_search_case(
    "lsearch -regexp -not -all -inline [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"K\"",
    "{} a A ab {a b} ba 10 02 汉字 K k İ i {a\nb} a\u0000b 😀", "", false, "match-429",
  )
  check_search_case(
    "lsearch -regexp -nocase [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"K\"",
    "9", "", false, "match-430",
  )
  check_search_case(
    "lsearch -regexp -nocase -all [list \"\" \"a\" \"A\" \"ab\" \"a b\" \"ba\" \"10\" \"02\" \"汉字\" \"K\" \"K\" \"k\" \"İ\" \"i\" \"a\\nb\" \"a\\x00b\" \"😀\"] \"K\"",
    "9 10 11", "", false, "match-431",
  )
  check_search_case(
    "lsearch -exact  -start \"-3\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "0", "",
    false, "start-432",
  )
  check_search_case(
    "lsearch -exact  -start \"0\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "0", "",
    false, "start-433",
  )
  check_search_case(
    "lsearch -exact  -start \"1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "2", "",
    false, "start-434",
  )
  check_search_case(
    "lsearch -exact  -start \"end\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "-1",
    "", false, "start-435",
  )
  check_search_case(
    "lsearch -exact  -start \"end-1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "2",
    "", false, "start-436",
  )
  check_search_case(
    "lsearch -exact  -start \"end+1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "-1",
    "", false, "start-437",
  )
  check_search_case(
    "lsearch -exact  -start \"100\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "-1",
    "", false, "start-438",
  )
  check_search_case(
    "lsearch -exact  -start \"1+2\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "-1",
    "", false, "start-439",
  )
}

///|
test "Tcl search cases 441 through 480" {
  check_search_case(
    "lsearch -exact  -start \"2-1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "2", "",
    false, "start-440",
  )
  check_search_case(
    "lsearch -exact  -start \"2147483647\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "-1", "", false, "start-441",
  )
  check_search_case(
    "lsearch -exact  -start \"2147483648\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "0", "", false, "start-442",
  )
  check_search_case(
    "lsearch -exact  -start \"4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "0", "", false, "start-443",
  )
  check_search_case(
    "lsearch -exact  -start \"-4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "2", "", false, "start-444",
  )
  check_search_case(
    "lsearch -exact  -start \"end+4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "2", "", false, "start-445",
  )
  check_search_case(
    "lsearch -exact -all -inline -start \"-3\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "a a", "", false, "start-446",
  )
  check_search_case(
    "lsearch -exact -all -inline -start \"0\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "a a", "", false, "start-447",
  )
  check_search_case(
    "lsearch -exact -all -inline -start \"1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "a", "", false, "start-448",
  )
  check_search_case(
    "lsearch -exact -all -inline -start \"end\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "", "", false, "start-449",
  )
  check_search_case(
    "lsearch -exact -all -inline -start \"end-1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "a", "", false, "start-450",
  )
  check_search_case(
    "lsearch -exact -all -inline -start \"end+1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "", "", false, "start-451",
  )
  check_search_case(
    "lsearch -exact -all -inline -start \"100\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "", "", false, "start-452",
  )
  check_search_case(
    "lsearch -exact -all -inline -start \"1+2\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "", "", false, "start-453",
  )
  check_search_case(
    "lsearch -exact -all -inline -start \"2-1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "a", "", false, "start-454",
  )
  check_search_case(
    "lsearch -exact -all -inline -start \"2147483647\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "", "", false, "start-455",
  )
  check_search_case(
    "lsearch -exact -all -inline -start \"2147483648\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "a a", "", false, "start-456",
  )
  check_search_case(
    "lsearch -exact -all -inline -start \"4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "a a", "", false, "start-457",
  )
  check_search_case(
    "lsearch -exact -all -inline -start \"-4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "a", "", false, "start-458",
  )
  check_search_case(
    "lsearch -exact -all -inline -start \"end+4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "a", "", false, "start-459",
  )
  check_search_case(
    "lsearch -exact -not -start \"-3\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "1",
    "", false, "start-460",
  )
  check_search_case(
    "lsearch -exact -not -start \"0\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "1",
    "", false, "start-461",
  )
  check_search_case(
    "lsearch -exact -not -start \"1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "1",
    "", false, "start-462",
  )
  check_search_case(
    "lsearch -exact -not -start \"end\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "3",
    "", false, "start-463",
  )
  check_search_case(
    "lsearch -exact -not -start \"end-1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "3", "", false, "start-464",
  )
  check_search_case(
    "lsearch -exact -not -start \"end+1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "-1", "", false, "start-465",
  )
  check_search_case(
    "lsearch -exact -not -start \"100\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "-1",
    "", false, "start-466",
  )
  check_search_case(
    "lsearch -exact -not -start \"1+2\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "3",
    "", false, "start-467",
  )
  check_search_case(
    "lsearch -exact -not -start \"2-1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "1",
    "", false, "start-468",
  )
  check_search_case(
    "lsearch -exact -not -start \"2147483647\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "-1", "", false, "start-469",
  )
  check_search_case(
    "lsearch -exact -not -start \"2147483648\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "1", "", false, "start-470",
  )
  check_search_case(
    "lsearch -exact -not -start \"4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "1", "", false, "start-471",
  )
  check_search_case(
    "lsearch -exact -not -start \"-4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "1", "", false, "start-472",
  )
  check_search_case(
    "lsearch -exact -not -start \"end+4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "3", "", false, "start-473",
  )
  check_search_case(
    "lsearch -exact -nocase -start \"-3\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "0", "", false, "start-474",
  )
  check_search_case(
    "lsearch -exact -nocase -start \"0\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "0",
    "", false, "start-475",
  )
  check_search_case(
    "lsearch -exact -nocase -start \"1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "2",
    "", false, "start-476",
  )
  check_search_case(
    "lsearch -exact -nocase -start \"end\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "-1", "", false, "start-477",
  )
  check_search_case(
    "lsearch -exact -nocase -start \"end-1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "2", "", false, "start-478",
  )
  check_search_case(
    "lsearch -exact -nocase -start \"end+1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "-1", "", false, "start-479",
  )
}

///|
test "Tcl search cases 481 through 520" {
  check_search_case(
    "lsearch -exact -nocase -start \"100\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "-1", "", false, "start-480",
  )
  check_search_case(
    "lsearch -exact -nocase -start \"1+2\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "-1", "", false, "start-481",
  )
  check_search_case(
    "lsearch -exact -nocase -start \"2-1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "2", "", false, "start-482",
  )
  check_search_case(
    "lsearch -exact -nocase -start \"2147483647\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "-1", "", false, "start-483",
  )
  check_search_case(
    "lsearch -exact -nocase -start \"2147483648\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "0", "", false, "start-484",
  )
  check_search_case(
    "lsearch -exact -nocase -start \"4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "0", "", false, "start-485",
  )
  check_search_case(
    "lsearch -exact -nocase -start \"-4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "2", "", false, "start-486",
  )
  check_search_case(
    "lsearch -exact -nocase -start \"end+4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "2", "", false, "start-487",
  )
  check_search_case(
    "lsearch -glob  -start \"-3\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "0", "",
    false, "start-488",
  )
  check_search_case(
    "lsearch -glob  -start \"0\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "0", "",
    false, "start-489",
  )
  check_search_case(
    "lsearch -glob  -start \"1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "2", "",
    false, "start-490",
  )
  check_search_case(
    "lsearch -glob  -start \"end\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "-1", "",
    false, "start-491",
  )
  check_search_case(
    "lsearch -glob  -start \"end-1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "2",
    "", false, "start-492",
  )
  check_search_case(
    "lsearch -glob  -start \"end+1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "-1",
    "", false, "start-493",
  )
  check_search_case(
    "lsearch -glob  -start \"100\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "-1", "",
    false, "start-494",
  )
  check_search_case(
    "lsearch -glob  -start \"1+2\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "-1", "",
    false, "start-495",
  )
  check_search_case(
    "lsearch -glob  -start \"2-1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "2", "",
    false, "start-496",
  )
  check_search_case(
    "lsearch -glob  -start \"2147483647\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "-1", "", false, "start-497",
  )
  check_search_case(
    "lsearch -glob  -start \"2147483648\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "0", "", false, "start-498",
  )
  check_search_case(
    "lsearch -glob  -start \"4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "0", "", false, "start-499",
  )
  check_search_case(
    "lsearch -glob  -start \"-4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "2", "", false, "start-500",
  )
  check_search_case(
    "lsearch -glob  -start \"end+4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "2", "", false, "start-501",
  )
  check_search_case(
    "lsearch -glob -all -inline -start \"-3\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "a a", "", false, "start-502",
  )
  check_search_case(
    "lsearch -glob -all -inline -start \"0\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "a a", "", false, "start-503",
  )
  check_search_case(
    "lsearch -glob -all -inline -start \"1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "a", "", false, "start-504",
  )
  check_search_case(
    "lsearch -glob -all -inline -start \"end\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "", "", false, "start-505",
  )
  check_search_case(
    "lsearch -glob -all -inline -start \"end-1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "a", "", false, "start-506",
  )
  check_search_case(
    "lsearch -glob -all -inline -start \"end+1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "", "", false, "start-507",
  )
  check_search_case(
    "lsearch -glob -all -inline -start \"100\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "", "", false, "start-508",
  )
  check_search_case(
    "lsearch -glob -all -inline -start \"1+2\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "", "", false, "start-509",
  )
  check_search_case(
    "lsearch -glob -all -inline -start \"2-1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "a", "", false, "start-510",
  )
  check_search_case(
    "lsearch -glob -all -inline -start \"2147483647\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "", "", false, "start-511",
  )
  check_search_case(
    "lsearch -glob -all -inline -start \"2147483648\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "a a", "", false, "start-512",
  )
  check_search_case(
    "lsearch -glob -all -inline -start \"4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "a a", "", false, "start-513",
  )
  check_search_case(
    "lsearch -glob -all -inline -start \"-4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "a", "", false, "start-514",
  )
  check_search_case(
    "lsearch -glob -all -inline -start \"end+4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "a", "", false, "start-515",
  )
  check_search_case(
    "lsearch -glob -not -start \"-3\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "1",
    "", false, "start-516",
  )
  check_search_case(
    "lsearch -glob -not -start \"0\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "1",
    "", false, "start-517",
  )
  check_search_case(
    "lsearch -glob -not -start \"1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "1",
    "", false, "start-518",
  )
  check_search_case(
    "lsearch -glob -not -start \"end\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "3",
    "", false, "start-519",
  )
}

///|
test "Tcl search cases 521 through 560" {
  check_search_case(
    "lsearch -glob -not -start \"end-1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "3",
    "", false, "start-520",
  )
  check_search_case(
    "lsearch -glob -not -start \"end+1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "-1",
    "", false, "start-521",
  )
  check_search_case(
    "lsearch -glob -not -start \"100\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "-1",
    "", false, "start-522",
  )
  check_search_case(
    "lsearch -glob -not -start \"1+2\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "3",
    "", false, "start-523",
  )
  check_search_case(
    "lsearch -glob -not -start \"2-1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "1",
    "", false, "start-524",
  )
  check_search_case(
    "lsearch -glob -not -start \"2147483647\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "-1", "", false, "start-525",
  )
  check_search_case(
    "lsearch -glob -not -start \"2147483648\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "1", "", false, "start-526",
  )
  check_search_case(
    "lsearch -glob -not -start \"4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "1", "", false, "start-527",
  )
  check_search_case(
    "lsearch -glob -not -start \"-4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "1", "", false, "start-528",
  )
  check_search_case(
    "lsearch -glob -not -start \"end+4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "3", "", false, "start-529",
  )
  check_search_case(
    "lsearch -glob -nocase -start \"-3\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "0",
    "", false, "start-530",
  )
  check_search_case(
    "lsearch -glob -nocase -start \"0\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "0",
    "", false, "start-531",
  )
  check_search_case(
    "lsearch -glob -nocase -start \"1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "2",
    "", false, "start-532",
  )
  check_search_case(
    "lsearch -glob -nocase -start \"end\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "-1", "", false, "start-533",
  )
  check_search_case(
    "lsearch -glob -nocase -start \"end-1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "2", "", false, "start-534",
  )
  check_search_case(
    "lsearch -glob -nocase -start \"end+1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "-1", "", false, "start-535",
  )
  check_search_case(
    "lsearch -glob -nocase -start \"100\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "-1", "", false, "start-536",
  )
  check_search_case(
    "lsearch -glob -nocase -start \"1+2\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "-1", "", false, "start-537",
  )
  check_search_case(
    "lsearch -glob -nocase -start \"2-1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "2", "", false, "start-538",
  )
  check_search_case(
    "lsearch -glob -nocase -start \"2147483647\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "-1", "", false, "start-539",
  )
  check_search_case(
    "lsearch -glob -nocase -start \"2147483648\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "0", "", false, "start-540",
  )
  check_search_case(
    "lsearch -glob -nocase -start \"4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "0", "", false, "start-541",
  )
  check_search_case(
    "lsearch -glob -nocase -start \"-4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "2", "", false, "start-542",
  )
  check_search_case(
    "lsearch -glob -nocase -start \"end+4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "2", "", false, "start-543",
  )
  check_search_case(
    "lsearch -regexp  -start \"-3\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "0", "",
    false, "start-544",
  )
  check_search_case(
    "lsearch -regexp  -start \"0\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "0", "",
    false, "start-545",
  )
  check_search_case(
    "lsearch -regexp  -start \"1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "2", "",
    false, "start-546",
  )
  check_search_case(
    "lsearch -regexp  -start \"end\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "-1",
    "", false, "start-547",
  )
  check_search_case(
    "lsearch -regexp  -start \"end-1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "2",
    "", false, "start-548",
  )
  check_search_case(
    "lsearch -regexp  -start \"end+1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "-1",
    "", false, "start-549",
  )
  check_search_case(
    "lsearch -regexp  -start \"100\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "-1",
    "", false, "start-550",
  )
  check_search_case(
    "lsearch -regexp  -start \"1+2\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "-1",
    "", false, "start-551",
  )
  check_search_case(
    "lsearch -regexp  -start \"2-1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "2",
    "", false, "start-552",
  )
  check_search_case(
    "lsearch -regexp  -start \"2147483647\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "-1", "", false, "start-553",
  )
  check_search_case(
    "lsearch -regexp  -start \"2147483648\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "0", "", false, "start-554",
  )
  check_search_case(
    "lsearch -regexp  -start \"4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "0", "", false, "start-555",
  )
  check_search_case(
    "lsearch -regexp  -start \"-4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "2", "", false, "start-556",
  )
  check_search_case(
    "lsearch -regexp  -start \"end+4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "2", "", false, "start-557",
  )
  check_search_case(
    "lsearch -regexp -all -inline -start \"-3\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "a a", "", false, "start-558",
  )
  check_search_case(
    "lsearch -regexp -all -inline -start \"0\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "a a", "", false, "start-559",
  )
}

///|
test "Tcl search cases 561 through 600" {
  check_search_case(
    "lsearch -regexp -all -inline -start \"1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "a", "", false, "start-560",
  )
  check_search_case(
    "lsearch -regexp -all -inline -start \"end\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "", "", false, "start-561",
  )
  check_search_case(
    "lsearch -regexp -all -inline -start \"end-1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "a", "", false, "start-562",
  )
  check_search_case(
    "lsearch -regexp -all -inline -start \"end+1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "", "", false, "start-563",
  )
  check_search_case(
    "lsearch -regexp -all -inline -start \"100\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "", "", false, "start-564",
  )
  check_search_case(
    "lsearch -regexp -all -inline -start \"1+2\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "", "", false, "start-565",
  )
  check_search_case(
    "lsearch -regexp -all -inline -start \"2-1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "a", "", false, "start-566",
  )
  check_search_case(
    "lsearch -regexp -all -inline -start \"2147483647\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "", "", false, "start-567",
  )
  check_search_case(
    "lsearch -regexp -all -inline -start \"2147483648\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "a a", "", false, "start-568",
  )
  check_search_case(
    "lsearch -regexp -all -inline -start \"4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "a a", "", false, "start-569",
  )
  check_search_case(
    "lsearch -regexp -all -inline -start \"-4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "a", "", false, "start-570",
  )
  check_search_case(
    "lsearch -regexp -all -inline -start \"end+4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "a", "", false, "start-571",
  )
  check_search_case(
    "lsearch -regexp -not -start \"-3\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "1",
    "", false, "start-572",
  )
  check_search_case(
    "lsearch -regexp -not -start \"0\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "1",
    "", false, "start-573",
  )
  check_search_case(
    "lsearch -regexp -not -start \"1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "1",
    "", false, "start-574",
  )
  check_search_case(
    "lsearch -regexp -not -start \"end\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "3",
    "", false, "start-575",
  )
  check_search_case(
    "lsearch -regexp -not -start \"end-1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "3", "", false, "start-576",
  )
  check_search_case(
    "lsearch -regexp -not -start \"end+1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "-1", "", false, "start-577",
  )
  check_search_case(
    "lsearch -regexp -not -start \"100\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "-1",
    "", false, "start-578",
  )
  check_search_case(
    "lsearch -regexp -not -start \"1+2\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "3",
    "", false, "start-579",
  )
  check_search_case(
    "lsearch -regexp -not -start \"2-1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "1",
    "", false, "start-580",
  )
  check_search_case(
    "lsearch -regexp -not -start \"2147483647\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "-1", "", false, "start-581",
  )
  check_search_case(
    "lsearch -regexp -not -start \"2147483648\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "1", "", false, "start-582",
  )
  check_search_case(
    "lsearch -regexp -not -start \"4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "1", "", false, "start-583",
  )
  check_search_case(
    "lsearch -regexp -not -start \"-4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "1", "", false, "start-584",
  )
  check_search_case(
    "lsearch -regexp -not -start \"end+4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "3", "", false, "start-585",
  )
  check_search_case(
    "lsearch -regexp -nocase -start \"-3\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "0", "", false, "start-586",
  )
  check_search_case(
    "lsearch -regexp -nocase -start \"0\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "0", "", false, "start-587",
  )
  check_search_case(
    "lsearch -regexp -nocase -start \"1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "2", "", false, "start-588",
  )
  check_search_case(
    "lsearch -regexp -nocase -start \"end\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "-1", "", false, "start-589",
  )
  check_search_case(
    "lsearch -regexp -nocase -start \"end-1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "2", "", false, "start-590",
  )
  check_search_case(
    "lsearch -regexp -nocase -start \"end+1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "-1", "", false, "start-591",
  )
  check_search_case(
    "lsearch -regexp -nocase -start \"100\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "-1", "", false, "start-592",
  )
  check_search_case(
    "lsearch -regexp -nocase -start \"1+2\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "-1", "", false, "start-593",
  )
  check_search_case(
    "lsearch -regexp -nocase -start \"2-1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "2", "", false, "start-594",
  )
  check_search_case(
    "lsearch -regexp -nocase -start \"2147483647\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "-1", "", false, "start-595",
  )
  check_search_case(
    "lsearch -regexp -nocase -start \"2147483648\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "0", "", false, "start-596",
  )
  check_search_case(
    "lsearch -regexp -nocase -start \"4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "0", "", false, "start-597",
  )
  check_search_case(
    "lsearch -regexp -nocase -start \"-4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "2", "", false, "start-598",
  )
  check_search_case(
    "lsearch -regexp -nocase -start \"end+4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "2", "", false, "start-599",
  )
}

///|
test "Tcl search cases 601 through 640" {
  check_search_case(
    "lsearch -sorted  -start \"-3\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "0", "",
    false, "start-600",
  )
  check_search_case(
    "lsearch -sorted  -start \"0\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "0", "",
    false, "start-601",
  )
  check_search_case(
    "lsearch -sorted  -start \"1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "2", "",
    false, "start-602",
  )
  check_search_case(
    "lsearch -sorted  -start \"end\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "-1",
    "", false, "start-603",
  )
  check_search_case(
    "lsearch -sorted  -start \"end-1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "2",
    "", false, "start-604",
  )
  check_search_case(
    "lsearch -sorted  -start \"end+1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "-1",
    "", false, "start-605",
  )
  check_search_case(
    "lsearch -sorted  -start \"100\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "-1",
    "", false, "start-606",
  )
  check_search_case(
    "lsearch -sorted  -start \"1+2\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "-1",
    "", false, "start-607",
  )
  check_search_case(
    "lsearch -sorted  -start \"2-1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "2",
    "", false, "start-608",
  )
  check_search_case(
    "lsearch -sorted  -start \"2147483647\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "-1", "", false, "start-609",
  )
  check_search_case(
    "lsearch -sorted  -start \"2147483648\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "0", "", false, "start-610",
  )
  check_search_case(
    "lsearch -sorted  -start \"4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "0", "", false, "start-611",
  )
  check_search_case(
    "lsearch -sorted  -start \"-4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "2", "", false, "start-612",
  )
  check_search_case(
    "lsearch -sorted  -start \"end+4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "2", "", false, "start-613",
  )
  check_search_case(
    "lsearch -sorted -all -inline -start \"-3\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "a a", "", false, "start-614",
  )
  check_search_case(
    "lsearch -sorted -all -inline -start \"0\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "a a", "", false, "start-615",
  )
  check_search_case(
    "lsearch -sorted -all -inline -start \"1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "a", "", false, "start-616",
  )
  check_search_case(
    "lsearch -sorted -all -inline -start \"end\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "", "", false, "start-617",
  )
  check_search_case(
    "lsearch -sorted -all -inline -start \"end-1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "a", "", false, "start-618",
  )
  check_search_case(
    "lsearch -sorted -all -inline -start \"end+1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "", "", false, "start-619",
  )
  check_search_case(
    "lsearch -sorted -all -inline -start \"100\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "", "", false, "start-620",
  )
  check_search_case(
    "lsearch -sorted -all -inline -start \"1+2\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "", "", false, "start-621",
  )
  check_search_case(
    "lsearch -sorted -all -inline -start \"2-1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "a", "", false, "start-622",
  )
  check_search_case(
    "lsearch -sorted -all -inline -start \"2147483647\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "", "", false, "start-623",
  )
  check_search_case(
    "lsearch -sorted -all -inline -start \"2147483648\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "a a", "", false, "start-624",
  )
  check_search_case(
    "lsearch -sorted -all -inline -start \"4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "a a", "", false, "start-625",
  )
  check_search_case(
    "lsearch -sorted -all -inline -start \"-4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "a", "", false, "start-626",
  )
  check_search_case(
    "lsearch -sorted -all -inline -start \"end+4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "a", "", false, "start-627",
  )
  check_search_case(
    "lsearch -sorted -not -start \"-3\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "1",
    "", false, "start-628",
  )
  check_search_case(
    "lsearch -sorted -not -start \"0\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "1",
    "", false, "start-629",
  )
  check_search_case(
    "lsearch -sorted -not -start \"1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "1",
    "", false, "start-630",
  )
  check_search_case(
    "lsearch -sorted -not -start \"end\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "3",
    "", false, "start-631",
  )
  check_search_case(
    "lsearch -sorted -not -start \"end-1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "3", "", false, "start-632",
  )
  check_search_case(
    "lsearch -sorted -not -start \"end+1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "-1", "", false, "start-633",
  )
  check_search_case(
    "lsearch -sorted -not -start \"100\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "-1",
    "", false, "start-634",
  )
  check_search_case(
    "lsearch -sorted -not -start \"1+2\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "3",
    "", false, "start-635",
  )
  check_search_case(
    "lsearch -sorted -not -start \"2-1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"", "1",
    "", false, "start-636",
  )
  check_search_case(
    "lsearch -sorted -not -start \"2147483647\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "-1", "", false, "start-637",
  )
  check_search_case(
    "lsearch -sorted -not -start \"2147483648\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "1", "", false, "start-638",
  )
  check_search_case(
    "lsearch -sorted -not -start \"4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "1", "", false, "start-639",
  )
}

///|
test "Tcl search cases 641 through 680" {
  check_search_case(
    "lsearch -sorted -not -start \"-4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "1", "", false, "start-640",
  )
  check_search_case(
    "lsearch -sorted -not -start \"end+4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "3", "", false, "start-641",
  )
  check_search_case(
    "lsearch -sorted -nocase -start \"-3\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "0", "", false, "start-642",
  )
  check_search_case(
    "lsearch -sorted -nocase -start \"0\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "0", "", false, "start-643",
  )
  check_search_case(
    "lsearch -sorted -nocase -start \"1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "2", "", false, "start-644",
  )
  check_search_case(
    "lsearch -sorted -nocase -start \"end\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "-1", "", false, "start-645",
  )
  check_search_case(
    "lsearch -sorted -nocase -start \"end-1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "2", "", false, "start-646",
  )
  check_search_case(
    "lsearch -sorted -nocase -start \"end+1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "-1", "", false, "start-647",
  )
  check_search_case(
    "lsearch -sorted -nocase -start \"100\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "-1", "", false, "start-648",
  )
  check_search_case(
    "lsearch -sorted -nocase -start \"1+2\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "-1", "", false, "start-649",
  )
  check_search_case(
    "lsearch -sorted -nocase -start \"2-1\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "2", "", false, "start-650",
  )
  check_search_case(
    "lsearch -sorted -nocase -start \"2147483647\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "-1", "", false, "start-651",
  )
  check_search_case(
    "lsearch -sorted -nocase -start \"2147483648\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "0", "", false, "start-652",
  )
  check_search_case(
    "lsearch -sorted -nocase -start \"4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "0", "", false, "start-653",
  )
  check_search_case(
    "lsearch -sorted -nocase -start \"-4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "2", "", false, "start-654",
  )
  check_search_case(
    "lsearch -sorted -nocase -start \"end+4294967295\" [list \"a\" \"b\" \"a\" \"c\"] \"a\"",
    "2", "", false, "start-655",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing  $v \"\"",
    "0", "", false, "sorted-656",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -all $v \"\"",
    "0", "", false, "sorted-657",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -inline $v \"\"",
    "", "", false, "sorted-658",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -all -inline $v \"\"",
    "{}", "", false, "sorted-659",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -not -all $v \"\"",
    "1 2 3 4 5", "", false, "sorted-660",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -bisect $v \"\"",
    "0", "", false, "sorted-661",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -bisect -inline $v \"\"",
    "", "", false, "sorted-662",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -start 1 $v \"\"",
    "-1", "", false, "sorted-663",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -bisect -start 2 $v \"\"",
    "1", "", false, "sorted-664",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -nocase $v \"\"",
    "0", "", false, "sorted-665",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -all -nocase $v \"\"",
    "0", "", false, "sorted-666",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing  $v \"\"",
    "5", "", false, "sorted-667",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -all $v \"\"",
    "5", "", false, "sorted-668",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -inline $v \"\"",
    "", "", false, "sorted-669",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -all -inline $v \"\"",
    "{}", "", false, "sorted-670",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -not -all $v \"\"",
    "0 1 2 3 4", "", false, "sorted-671",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -bisect $v \"\"",
    "5", "", false, "sorted-672",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -bisect -inline $v \"\"",
    "", "", false, "sorted-673",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -start 1 $v \"\"",
    "5", "", false, "sorted-674",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -bisect -start 2 $v \"\"",
    "5", "", false, "sorted-675",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -nocase $v \"\"",
    "5", "", false, "sorted-676",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -all -nocase $v \"\"",
    "5", "", false, "sorted-677",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing  $v \"A\"",
    "1", "", false, "sorted-678",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -all $v \"A\"",
    "1", "", false, "sorted-679",
  )
}

///|
test "Tcl search cases 681 through 720" {
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -inline $v \"A\"",
    "A", "", false, "sorted-680",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -all -inline $v \"A\"",
    "A", "", false, "sorted-681",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -not -all $v \"A\"",
    "0 2 3 4 5", "", false, "sorted-682",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -bisect $v \"A\"",
    "1", "", false, "sorted-683",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -bisect -inline $v \"A\"",
    "A", "", false, "sorted-684",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -start 1 $v \"A\"",
    "1", "", false, "sorted-685",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -bisect -start 2 $v \"A\"",
    "1", "", false, "sorted-686",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -nocase $v \"A\"",
    "1", "", false, "sorted-687",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -all -nocase $v \"A\"",
    "1 2", "", false, "sorted-688",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing  $v \"A\"",
    "4", "", false, "sorted-689",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -all $v \"A\"",
    "4", "", false, "sorted-690",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -inline $v \"A\"",
    "A", "", false, "sorted-691",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -all -inline $v \"A\"",
    "A", "", false, "sorted-692",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -not -all $v \"A\"",
    "0 1 2 3 5", "", false, "sorted-693",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -bisect $v \"A\"",
    "4", "", false, "sorted-694",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -bisect -inline $v \"A\"",
    "A", "", false, "sorted-695",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -start 1 $v \"A\"",
    "4", "", false, "sorted-696",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -bisect -start 2 $v \"A\"",
    "4", "", false, "sorted-697",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -nocase $v \"A\"",
    "3", "", false, "sorted-698",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -all -nocase $v \"A\"",
    "3 4", "", false, "sorted-699",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing  $v \"a\"",
    "2", "", false, "sorted-700",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -all $v \"a\"",
    "2", "", false, "sorted-701",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -inline $v \"a\"",
    "a", "", false, "sorted-702",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -all -inline $v \"a\"",
    "a", "", false, "sorted-703",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -not -all $v \"a\"",
    "0 1 3 4 5", "", false, "sorted-704",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -bisect $v \"a\"",
    "2", "", false, "sorted-705",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -bisect -inline $v \"a\"",
    "a", "", false, "sorted-706",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -start 1 $v \"a\"",
    "2", "", false, "sorted-707",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -bisect -start 2 $v \"a\"",
    "2", "", false, "sorted-708",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -nocase $v \"a\"",
    "1", "", false, "sorted-709",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -all -nocase $v \"a\"",
    "1 2", "", false, "sorted-710",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing  $v \"a\"",
    "3", "", false, "sorted-711",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -all $v \"a\"",
    "3", "", false, "sorted-712",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -inline $v \"a\"",
    "a", "", false, "sorted-713",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -all -inline $v \"a\"",
    "a", "", false, "sorted-714",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -not -all $v \"a\"",
    "0 1 2 4 5", "", false, "sorted-715",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -bisect $v \"a\"",
    "3", "", false, "sorted-716",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -bisect -inline $v \"a\"",
    "a", "", false, "sorted-717",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -start 1 $v \"a\"",
    "3", "", false, "sorted-718",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -bisect -start 2 $v \"a\"",
    "3", "", false, "sorted-719",
  )
}

///|
test "Tcl search cases 721 through 760" {
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -nocase $v \"a\"",
    "3", "", false, "sorted-720",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -all -nocase $v \"a\"",
    "3 4", "", false, "sorted-721",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing  $v \"b\"",
    "4", "", false, "sorted-722",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -all $v \"b\"",
    "4", "", false, "sorted-723",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -inline $v \"b\"",
    "b", "", false, "sorted-724",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -all -inline $v \"b\"",
    "b", "", false, "sorted-725",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -not -all $v \"b\"",
    "0 1 2 3 5", "", false, "sorted-726",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -bisect $v \"b\"",
    "4", "", false, "sorted-727",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -bisect -inline $v \"b\"",
    "b", "", false, "sorted-728",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -start 1 $v \"b\"",
    "4", "", false, "sorted-729",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -bisect -start 2 $v \"b\"",
    "4", "", false, "sorted-730",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -nocase $v \"b\"",
    "4", "", false, "sorted-731",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -all -nocase $v \"b\"",
    "4", "", false, "sorted-732",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing  $v \"b\"",
    "1", "", false, "sorted-733",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -all $v \"b\"",
    "1", "", false, "sorted-734",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -inline $v \"b\"",
    "b", "", false, "sorted-735",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -all -inline $v \"b\"",
    "b", "", false, "sorted-736",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -not -all $v \"b\"",
    "0 2 3 4 5", "", false, "sorted-737",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -bisect $v \"b\"",
    "1", "", false, "sorted-738",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -bisect -inline $v \"b\"",
    "b", "", false, "sorted-739",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -start 1 $v \"b\"",
    "1", "", false, "sorted-740",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -bisect -start 2 $v \"b\"",
    "1", "", false, "sorted-741",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -nocase $v \"b\"",
    "1", "", false, "sorted-742",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -all -nocase $v \"b\"",
    "1", "", false, "sorted-743",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing  $v \"ba\"",
    "-1", "", false, "sorted-744",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -all $v \"ba\"",
    "", "", false, "sorted-745",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -inline $v \"ba\"",
    "", "", false, "sorted-746",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -all -inline $v \"ba\"",
    "", "", false, "sorted-747",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -not -all $v \"ba\"",
    "0 1 2 3 4 5", "", false, "sorted-748",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -bisect $v \"ba\"",
    "4", "", false, "sorted-749",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -bisect -inline $v \"ba\"",
    "b", "", false, "sorted-750",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -start 1 $v \"ba\"",
    "-1", "", false, "sorted-751",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -bisect -start 2 $v \"ba\"",
    "4", "", false, "sorted-752",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -nocase $v \"ba\"",
    "-1", "", false, "sorted-753",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -all -nocase $v \"ba\"",
    "", "", false, "sorted-754",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing  $v \"ba\"",
    "-1", "", false, "sorted-755",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -all $v \"ba\"",
    "", "", false, "sorted-756",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -inline $v \"ba\"",
    "", "", false, "sorted-757",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -all -inline $v \"ba\"",
    "", "", false, "sorted-758",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -not -all $v \"ba\"",
    "0 1 2 3 4 5", "", false, "sorted-759",
  )
}

///|
test "Tcl search cases 761 through 800" {
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -bisect $v \"ba\"",
    "0", "", false, "sorted-760",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -bisect -inline $v \"ba\"",
    "c", "", false, "sorted-761",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -start 1 $v \"ba\"",
    "-1", "", false, "sorted-762",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -bisect -start 2 $v \"ba\"",
    "1", "", false, "sorted-763",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -nocase $v \"ba\"",
    "-1", "", false, "sorted-764",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -all -nocase $v \"ba\"",
    "", "", false, "sorted-765",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing  $v \"z\"",
    "-1", "", false, "sorted-766",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -all $v \"z\"",
    "", "", false, "sorted-767",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -inline $v \"z\"",
    "", "", false, "sorted-768",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -all -inline $v \"z\"",
    "", "", false, "sorted-769",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -not -all $v \"z\"",
    "0 1 2 3 4 5", "", false, "sorted-770",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -bisect $v \"z\"",
    "5", "", false, "sorted-771",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -bisect -inline $v \"z\"",
    "c", "", false, "sorted-772",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -start 1 $v \"z\"",
    "-1", "", false, "sorted-773",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -bisect -start 2 $v \"z\"",
    "5", "", false, "sorted-774",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -nocase $v \"z\"",
    "-1", "", false, "sorted-775",
  )
  check_search_case(
    "set v [lsort -ascii -increasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -increasing -all -nocase $v \"z\"",
    "", "", false, "sorted-776",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing  $v \"z\"",
    "-1", "", false, "sorted-777",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -all $v \"z\"",
    "", "", false, "sorted-778",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -inline $v \"z\"",
    "", "", false, "sorted-779",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -all -inline $v \"z\"",
    "", "", false, "sorted-780",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -not -all $v \"z\"",
    "0 1 2 3 4 5", "", false, "sorted-781",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -bisect $v \"z\"",
    "-1", "", false, "sorted-782",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -bisect -inline $v \"z\"",
    "", "", false, "sorted-783",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -start 1 $v \"z\"",
    "-1", "", false, "sorted-784",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -bisect -start 2 $v \"z\"",
    "1", "", false, "sorted-785",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -nocase $v \"z\"",
    "-1", "", false, "sorted-786",
  )
  check_search_case(
    "set v [lsort -ascii -decreasing [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"]];lsearch -sorted -ascii -decreasing -all -nocase $v \"z\"",
    "", "", false, "sorted-787",
  )
  check_search_case(
    "lsearch -exact -ascii  [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"] \"\"", "0",
    "", false, "content-788",
  )
  check_search_case(
    "lsearch -exact -ascii -all [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"] \"\"",
    "0", "", false, "content-789",
  )
  check_search_case(
    "lsearch -exact -ascii -not -all -inline [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"] \"\"",
    "A a b c aa", "", false, "content-790",
  )
  check_search_case(
    "lsearch -exact -ascii -nocase -all [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"] \"\"",
    "0", "", false, "content-791",
  )
  check_search_case(
    "lsearch -exact -ascii  [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"] \"A\"", "1",
    "", false, "content-792",
  )
  check_search_case(
    "lsearch -exact -ascii -all [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"] \"A\"",
    "1", "", false, "content-793",
  )
  check_search_case(
    "lsearch -exact -ascii -not -all -inline [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"] \"A\"",
    "{} a b c aa", "", false, "content-794",
  )
  check_search_case(
    "lsearch -exact -ascii -nocase -all [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"] \"A\"",
    "1 2", "", false, "content-795",
  )
  check_search_case(
    "lsearch -exact -ascii  [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"] \"a\"", "2",
    "", false, "content-796",
  )
  check_search_case(
    "lsearch -exact -ascii -all [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"] \"a\"",
    "2", "", false, "content-797",
  )
  check_search_case(
    "lsearch -exact -ascii -not -all -inline [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"] \"a\"",
    "{} A b c aa", "", false, "content-798",
  )
  check_search_case(
    "lsearch -exact -ascii -nocase -all [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"] \"a\"",
    "1 2", "", false, "content-799",
  )
}

///|
test "Tcl search cases 801 through 840" {
  check_search_case(
    "lsearch -exact -ascii  [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"] \"b\"", "3",
    "", false, "content-800",
  )
  check_search_case(
    "lsearch -exact -ascii -all [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"] \"b\"",
    "3", "", false, "content-801",
  )
  check_search_case(
    "lsearch -exact -ascii -not -all -inline [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"] \"b\"",
    "{} A a c aa", "", false, "content-802",
  )
  check_search_case(
    "lsearch -exact -ascii -nocase -all [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"] \"b\"",
    "3", "", false, "content-803",
  )
  check_search_case(
    "lsearch -exact -ascii  [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"] \"ba\"", "-1",
    "", false, "content-804",
  )
  check_search_case(
    "lsearch -exact -ascii -all [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"] \"ba\"",
    "", "", false, "content-805",
  )
  check_search_case(
    "lsearch -exact -ascii -not -all -inline [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"] \"ba\"",
    "{} A a b c aa", "", false, "content-806",
  )
  check_search_case(
    "lsearch -exact -ascii -nocase -all [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"] \"ba\"",
    "", "", false, "content-807",
  )
  check_search_case(
    "lsearch -exact -ascii  [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"] \"z\"", "-1",
    "", false, "content-808",
  )
  check_search_case(
    "lsearch -exact -ascii -all [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"] \"z\"",
    "", "", false, "content-809",
  )
  check_search_case(
    "lsearch -exact -ascii -not -all -inline [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"] \"z\"",
    "{} A a b c aa", "", false, "content-810",
  )
  check_search_case(
    "lsearch -exact -ascii -nocase -all [list \"\" \"A\" \"a\" \"b\" \"c\" \"aa\"] \"z\"",
    "", "", false, "content-811",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing  $v \"a1\"",
    "3", "", false, "sorted-812",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -all $v \"a1\"",
    "3", "", false, "sorted-813",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -inline $v \"a1\"",
    "a1", "", false, "sorted-814",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -all -inline $v \"a1\"",
    "a1", "", false, "sorted-815",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -not -all $v \"a1\"",
    "0 1 2 4 5 6 7", "", false, "sorted-816",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -bisect $v \"a1\"",
    "3", "", false, "sorted-817",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -bisect -inline $v \"a1\"",
    "a1", "", false, "sorted-818",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -start 1 $v \"a1\"",
    "3", "", false, "sorted-819",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -bisect -start 2 $v \"a1\"",
    "3", "", false, "sorted-820",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -nocase $v \"a1\"",
    "3", "", false, "sorted-821",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -all -nocase $v \"a1\"",
    "3", "", false, "sorted-822",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing  $v \"a1\"",
    "4", "", false, "sorted-823",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -all $v \"a1\"",
    "4", "", false, "sorted-824",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -inline $v \"a1\"",
    "a1", "", false, "sorted-825",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -all -inline $v \"a1\"",
    "a1", "", false, "sorted-826",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -not -all $v \"a1\"",
    "0 1 2 3 5 6 7", "", false, "sorted-827",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -bisect $v \"a1\"",
    "4", "", false, "sorted-828",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -bisect -inline $v \"a1\"",
    "a1", "", false, "sorted-829",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -start 1 $v \"a1\"",
    "4", "", false, "sorted-830",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -bisect -start 2 $v \"a1\"",
    "4", "", false, "sorted-831",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -nocase $v \"a1\"",
    "4", "", false, "sorted-832",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -all -nocase $v \"a1\"",
    "4", "", false, "sorted-833",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing  $v \"A1\"",
    "2", "", false, "sorted-834",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -all $v \"A1\"",
    "2", "", false, "sorted-835",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -inline $v \"A1\"",
    "A1", "", false, "sorted-836",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -all -inline $v \"A1\"",
    "A1", "", false, "sorted-837",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -not -all $v \"A1\"",
    "0 1 3 4 5 6 7", "", false, "sorted-838",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -bisect $v \"A1\"",
    "2", "", false, "sorted-839",
  )
}

///|
test "Tcl search cases 841 through 880" {
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -bisect -inline $v \"A1\"",
    "A1", "", false, "sorted-840",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -start 1 $v \"A1\"",
    "2", "", false, "sorted-841",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -bisect -start 2 $v \"A1\"",
    "2", "", false, "sorted-842",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -nocase $v \"A1\"",
    "2", "", false, "sorted-843",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -all -nocase $v \"A1\"",
    "2", "", false, "sorted-844",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing  $v \"A1\"",
    "5", "", false, "sorted-845",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -all $v \"A1\"",
    "5", "", false, "sorted-846",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -inline $v \"A1\"",
    "A1", "", false, "sorted-847",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -all -inline $v \"A1\"",
    "A1", "", false, "sorted-848",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -not -all $v \"A1\"",
    "0 1 2 3 4 6 7", "", false, "sorted-849",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -bisect $v \"A1\"",
    "5", "", false, "sorted-850",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -bisect -inline $v \"A1\"",
    "A1", "", false, "sorted-851",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -start 1 $v \"A1\"",
    "5", "", false, "sorted-852",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -bisect -start 2 $v \"A1\"",
    "5", "", false, "sorted-853",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -nocase $v \"A1\"",
    "5", "", false, "sorted-854",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -all -nocase $v \"A1\"",
    "5", "", false, "sorted-855",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing  $v \"a01\"",
    "4", "", false, "sorted-856",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -all $v \"a01\"",
    "4", "", false, "sorted-857",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -inline $v \"a01\"",
    "a01", "", false, "sorted-858",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -all -inline $v \"a01\"",
    "a01", "", false, "sorted-859",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -not -all $v \"a01\"",
    "0 1 2 3 5 6 7", "", false, "sorted-860",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -bisect $v \"a01\"",
    "4", "", false, "sorted-861",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -bisect -inline $v \"a01\"",
    "a01", "", false, "sorted-862",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -start 1 $v \"a01\"",
    "4", "", false, "sorted-863",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -bisect -start 2 $v \"a01\"",
    "4", "", false, "sorted-864",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -nocase $v \"a01\"",
    "4", "", false, "sorted-865",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -all -nocase $v \"a01\"",
    "4", "", false, "sorted-866",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing  $v \"a01\"",
    "3", "", false, "sorted-867",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -all $v \"a01\"",
    "3", "", false, "sorted-868",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -inline $v \"a01\"",
    "a01", "", false, "sorted-869",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -all -inline $v \"a01\"",
    "a01", "", false, "sorted-870",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -not -all $v \"a01\"",
    "0 1 2 4 5 6 7", "", false, "sorted-871",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -bisect $v \"a01\"",
    "3", "", false, "sorted-872",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -bisect -inline $v \"a01\"",
    "a01", "", false, "sorted-873",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -start 1 $v \"a01\"",
    "3", "", false, "sorted-874",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -bisect -start 2 $v \"a01\"",
    "3", "", false, "sorted-875",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -nocase $v \"a01\"",
    "3", "", false, "sorted-876",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -all -nocase $v \"a01\"",
    "3", "", false, "sorted-877",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing  $v \"a0\"",
    "0", "", false, "sorted-878",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -all $v \"a0\"",
    "0", "", false, "sorted-879",
  )
}

///|
test "Tcl search cases 881 through 920" {
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -inline $v \"a0\"",
    "a0", "", false, "sorted-880",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -all -inline $v \"a0\"",
    "a0", "", false, "sorted-881",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -not -all $v \"a0\"",
    "1 2 3 4 5 6 7", "", false, "sorted-882",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -bisect $v \"a0\"",
    "0", "", false, "sorted-883",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -bisect -inline $v \"a0\"",
    "a0", "", false, "sorted-884",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -start 1 $v \"a0\"",
    "-1", "", false, "sorted-885",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -bisect -start 2 $v \"a0\"",
    "1", "", false, "sorted-886",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -nocase $v \"a0\"",
    "0", "", false, "sorted-887",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -all -nocase $v \"a0\"",
    "0", "", false, "sorted-888",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing  $v \"a0\"",
    "7", "", false, "sorted-889",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -all $v \"a0\"",
    "7", "", false, "sorted-890",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -inline $v \"a0\"",
    "a0", "", false, "sorted-891",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -all -inline $v \"a0\"",
    "a0", "", false, "sorted-892",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -not -all $v \"a0\"",
    "0 1 2 3 4 5 6", "", false, "sorted-893",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -bisect $v \"a0\"",
    "7", "", false, "sorted-894",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -bisect -inline $v \"a0\"",
    "a0", "", false, "sorted-895",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -start 1 $v \"a0\"",
    "7", "", false, "sorted-896",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -bisect -start 2 $v \"a0\"",
    "7", "", false, "sorted-897",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -nocase $v \"a0\"",
    "7", "", false, "sorted-898",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -all -nocase $v \"a0\"",
    "7", "", false, "sorted-899",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing  $v \"a3\"",
    "-1", "", false, "sorted-900",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -all $v \"a3\"",
    "", "", false, "sorted-901",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -inline $v \"a3\"",
    "", "", false, "sorted-902",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -all -inline $v \"a3\"",
    "", "", false, "sorted-903",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -not -all $v \"a3\"",
    "0 1 2 3 4 5 6 7", "", false, "sorted-904",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -bisect $v \"a3\"",
    "6", "", false, "sorted-905",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -bisect -inline $v \"a3\"",
    "a2", "", false, "sorted-906",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -start 1 $v \"a3\"",
    "-1", "", false, "sorted-907",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -bisect -start 2 $v \"a3\"",
    "6", "", false, "sorted-908",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -nocase $v \"a3\"",
    "-1", "", false, "sorted-909",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -all -nocase $v \"a3\"",
    "", "", false, "sorted-910",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing  $v \"a3\"",
    "-1", "", false, "sorted-911",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -all $v \"a3\"",
    "", "", false, "sorted-912",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -inline $v \"a3\"",
    "", "", false, "sorted-913",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -all -inline $v \"a3\"",
    "", "", false, "sorted-914",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -not -all $v \"a3\"",
    "0 1 2 3 4 5 6 7", "", false, "sorted-915",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -bisect $v \"a3\"",
    "0", "", false, "sorted-916",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -bisect -inline $v \"a3\"",
    "a10", "", false, "sorted-917",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -start 1 $v \"a3\"",
    "-1", "", false, "sorted-918",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -bisect -start 2 $v \"a3\"",
    "1", "", false, "sorted-919",
  )
}

///|
test "Tcl search cases 921 through 960" {
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -nocase $v \"a3\"",
    "-1", "", false, "sorted-920",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -all -nocase $v \"a3\"",
    "", "", false, "sorted-921",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing  $v \"a100\"",
    "-1", "", false, "sorted-922",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -all $v \"a100\"",
    "", "", false, "sorted-923",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -inline $v \"a100\"",
    "", "", false, "sorted-924",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -all -inline $v \"a100\"",
    "", "", false, "sorted-925",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -not -all $v \"a100\"",
    "0 1 2 3 4 5 6 7", "", false, "sorted-926",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -bisect $v \"a100\"",
    "7", "", false, "sorted-927",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -bisect -inline $v \"a100\"",
    "a10", "", false, "sorted-928",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -start 1 $v \"a100\"",
    "-1", "", false, "sorted-929",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -bisect -start 2 $v \"a100\"",
    "7", "", false, "sorted-930",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -nocase $v \"a100\"",
    "-1", "", false, "sorted-931",
  )
  check_search_case(
    "set v [lsort -dictionary -increasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -increasing -all -nocase $v \"a100\"",
    "", "", false, "sorted-932",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing  $v \"a100\"",
    "-1", "", false, "sorted-933",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -all $v \"a100\"",
    "", "", false, "sorted-934",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -inline $v \"a100\"",
    "", "", false, "sorted-935",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -all -inline $v \"a100\"",
    "", "", false, "sorted-936",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -not -all $v \"a100\"",
    "0 1 2 3 4 5 6 7", "", false, "sorted-937",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -bisect $v \"a100\"",
    "-1", "", false, "sorted-938",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -bisect -inline $v \"a100\"",
    "", "", false, "sorted-939",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -start 1 $v \"a100\"",
    "-1", "", false, "sorted-940",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -bisect -start 2 $v \"a100\"",
    "1", "", false, "sorted-941",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -nocase $v \"a100\"",
    "-1", "", false, "sorted-942",
  )
  check_search_case(
    "set v [lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"]];lsearch -sorted -dictionary -decreasing -all -nocase $v \"a100\"",
    "", "", false, "sorted-943",
  )
  check_search_case(
    "lsearch -exact -dictionary  [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"] \"a1\"",
    "1", "", false, "content-944",
  )
  check_search_case(
    "lsearch -exact -dictionary -all [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"] \"a1\"",
    "1", "", false, "content-945",
  )
  check_search_case(
    "lsearch -exact -dictionary -not -all -inline [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"] \"a1\"",
    "a01 a001 a10 a2 A1 a000 a0", "", false, "content-946",
  )
  check_search_case(
    "lsearch -exact -dictionary -nocase -all [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"] \"a1\"",
    "1", "", false, "content-947",
  )
  check_search_case(
    "lsearch -exact -dictionary  [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"] \"A1\"",
    "5", "", false, "content-948",
  )
  check_search_case(
    "lsearch -exact -dictionary -all [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"] \"A1\"",
    "5", "", false, "content-949",
  )
  check_search_case(
    "lsearch -exact -dictionary -not -all -inline [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"] \"A1\"",
    "a01 a1 a001 a10 a2 a000 a0", "", false, "content-950",
  )
  check_search_case(
    "lsearch -exact -dictionary -nocase -all [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"] \"A1\"",
    "5", "", false, "content-951",
  )
  check_search_case(
    "lsearch -exact -dictionary  [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"] \"a01\"",
    "0", "", false, "content-952",
  )
  check_search_case(
    "lsearch -exact -dictionary -all [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"] \"a01\"",
    "0", "", false, "content-953",
  )
  check_search_case(
    "lsearch -exact -dictionary -not -all -inline [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"] \"a01\"",
    "a1 a001 a10 a2 A1 a000 a0", "", false, "content-954",
  )
  check_search_case(
    "lsearch -exact -dictionary -nocase -all [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"] \"a01\"",
    "0", "", false, "content-955",
  )
  check_search_case(
    "lsearch -exact -dictionary  [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"] \"a0\"",
    "7", "", false, "content-956",
  )
  check_search_case(
    "lsearch -exact -dictionary -all [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"] \"a0\"",
    "7", "", false, "content-957",
  )
  check_search_case(
    "lsearch -exact -dictionary -not -all -inline [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"] \"a0\"",
    "a01 a1 a001 a10 a2 A1 a000", "", false, "content-958",
  )
  check_search_case(
    "lsearch -exact -dictionary -nocase -all [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"] \"a0\"",
    "7", "", false, "content-959",
  )
}

///|
test "Tcl search cases 961 through 1000" {
  check_search_case(
    "lsearch -exact -dictionary  [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"] \"a3\"",
    "-1", "", false, "content-960",
  )
  check_search_case(
    "lsearch -exact -dictionary -all [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"] \"a3\"",
    "", "", false, "content-961",
  )
  check_search_case(
    "lsearch -exact -dictionary -not -all -inline [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"] \"a3\"",
    "a01 a1 a001 a10 a2 A1 a000 a0", "", false, "content-962",
  )
  check_search_case(
    "lsearch -exact -dictionary -nocase -all [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"] \"a3\"",
    "", "", false, "content-963",
  )
  check_search_case(
    "lsearch -exact -dictionary  [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"] \"a100\"",
    "-1", "", false, "content-964",
  )
  check_search_case(
    "lsearch -exact -dictionary -all [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"] \"a100\"",
    "", "", false, "content-965",
  )
  check_search_case(
    "lsearch -exact -dictionary -not -all -inline [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"] \"a100\"",
    "a01 a1 a001 a10 a2 A1 a000 a0", "", false, "content-966",
  )
  check_search_case(
    "lsearch -exact -dictionary -nocase -all [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\" \"a000\" \"a0\"] \"a100\"",
    "", "", false, "content-967",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing  $v \"-2\"",
    "-1", "", false, "sorted-968",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -all $v \"-2\"",
    "", "", false, "sorted-969",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -inline $v \"-2\"",
    "", "", false, "sorted-970",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -all -inline $v \"-2\"",
    "", "", false, "sorted-971",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -not -all $v \"-2\"",
    "0 1 2 3 4 5 6 7", "", false, "sorted-972",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -bisect $v \"-2\"",
    "-1", "", false, "sorted-973",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -bisect -inline $v \"-2\"",
    "", "", false, "sorted-974",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -start 1 $v \"-2\"",
    "-1", "", false, "sorted-975",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -bisect -start 2 $v \"-2\"",
    "1", "", false, "sorted-976",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -nocase $v \"-2\"",
    "-1", "", false, "sorted-977",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -all -nocase $v \"-2\"",
    "", "", false, "sorted-978",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing  $v \"-2\"",
    "-1", "", false, "sorted-979",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -all $v \"-2\"",
    "", "", false, "sorted-980",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -inline $v \"-2\"",
    "", "", false, "sorted-981",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -all -inline $v \"-2\"",
    "", "", false, "sorted-982",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -not -all $v \"-2\"",
    "0 1 2 3 4 5 6 7", "", false, "sorted-983",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -bisect $v \"-2\"",
    "7", "", false, "sorted-984",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -bisect -inline $v \"-2\"",
    "-1", "", false, "sorted-985",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -start 1 $v \"-2\"",
    "-1", "", false, "sorted-986",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -bisect -start 2 $v \"-2\"",
    "7", "", false, "sorted-987",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -nocase $v \"-2\"",
    "-1", "", false, "sorted-988",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -all -nocase $v \"-2\"",
    "", "", false, "sorted-989",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing  $v \"-1\"",
    "0", "", false, "sorted-990",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -all $v \"-1\"",
    "0", "", false, "sorted-991",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -inline $v \"-1\"",
    "-1", "", false, "sorted-992",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -all -inline $v \"-1\"",
    "-1", "", false, "sorted-993",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -not -all $v \"-1\"",
    "1 2 3 4 5 6 7", "", false, "sorted-994",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -bisect $v \"-1\"",
    "0", "", false, "sorted-995",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -bisect -inline $v \"-1\"",
    "-1", "", false, "sorted-996",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -start 1 $v \"-1\"",
    "-1", "", false, "sorted-997",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -bisect -start 2 $v \"-1\"",
    "1", "", false, "sorted-998",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -nocase $v \"-1\"",
    "0", "", false, "sorted-999",
  )
}

///|
test "Tcl search cases 1001 through 1040" {
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -all -nocase $v \"-1\"",
    "0", "", false, "sorted-1000",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing  $v \"-1\"",
    "7", "", false, "sorted-1001",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -all $v \"-1\"",
    "7", "", false, "sorted-1002",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -inline $v \"-1\"",
    "-1", "", false, "sorted-1003",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -all -inline $v \"-1\"",
    "-1", "", false, "sorted-1004",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -not -all $v \"-1\"",
    "0 1 2 3 4 5 6", "", false, "sorted-1005",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -bisect $v \"-1\"",
    "7", "", false, "sorted-1006",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -bisect -inline $v \"-1\"",
    "-1", "", false, "sorted-1007",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -start 1 $v \"-1\"",
    "7", "", false, "sorted-1008",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -bisect -start 2 $v \"-1\"",
    "7", "", false, "sorted-1009",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -nocase $v \"-1\"",
    "7", "", false, "sorted-1010",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -all -nocase $v \"-1\"",
    "7", "", false, "sorted-1011",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing  $v \"0\"",
    "1", "", false, "sorted-1012",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -all $v \"0\"",
    "1", "", false, "sorted-1013",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -inline $v \"0\"",
    "0", "", false, "sorted-1014",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -all -inline $v \"0\"",
    "0", "", false, "sorted-1015",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -not -all $v \"0\"",
    "0 2 3 4 5 6 7", "", false, "sorted-1016",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -bisect $v \"0\"",
    "1", "", false, "sorted-1017",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -bisect -inline $v \"0\"",
    "0", "", false, "sorted-1018",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -start 1 $v \"0\"",
    "1", "", false, "sorted-1019",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -bisect -start 2 $v \"0\"",
    "1", "", false, "sorted-1020",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -nocase $v \"0\"",
    "1", "", false, "sorted-1021",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -all -nocase $v \"0\"",
    "1", "", false, "sorted-1022",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing  $v \"0\"",
    "6", "", false, "sorted-1023",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -all $v \"0\"",
    "6", "", false, "sorted-1024",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -inline $v \"0\"",
    "0", "", false, "sorted-1025",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -all -inline $v \"0\"",
    "0", "", false, "sorted-1026",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -not -all $v \"0\"",
    "0 1 2 3 4 5 7", "", false, "sorted-1027",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -bisect $v \"0\"",
    "6", "", false, "sorted-1028",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -bisect -inline $v \"0\"",
    "0", "", false, "sorted-1029",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -start 1 $v \"0\"",
    "6", "", false, "sorted-1030",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -bisect -start 2 $v \"0\"",
    "6", "", false, "sorted-1031",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -nocase $v \"0\"",
    "6", "", false, "sorted-1032",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -all -nocase $v \"0\"",
    "6", "", false, "sorted-1033",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing  $v \"2\"",
    "3", "", false, "sorted-1034",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -all $v \"2\"",
    "3", "", false, "sorted-1035",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -inline $v \"2\"",
    "+2", "", false, "sorted-1036",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -all -inline $v \"2\"",
    "+2", "", false, "sorted-1037",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -not -all $v \"2\"",
    "0 1 2 4 5 6 7", "", false, "sorted-1038",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -bisect $v \"2\"",
    "3", "", false, "sorted-1039",
  )
}

///|
test "Tcl search cases 1041 through 1080" {
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -bisect -inline $v \"2\"",
    "+2", "", false, "sorted-1040",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -start 1 $v \"2\"",
    "3", "", false, "sorted-1041",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -bisect -start 2 $v \"2\"",
    "3", "", false, "sorted-1042",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -nocase $v \"2\"",
    "3", "", false, "sorted-1043",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -all -nocase $v \"2\"",
    "3", "", false, "sorted-1044",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing  $v \"2\"",
    "4", "", false, "sorted-1045",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -all $v \"2\"",
    "4", "", false, "sorted-1046",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -inline $v \"2\"",
    "+2", "", false, "sorted-1047",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -all -inline $v \"2\"",
    "+2", "", false, "sorted-1048",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -not -all $v \"2\"",
    "0 1 2 3 5 6 7", "", false, "sorted-1049",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -bisect $v \"2\"",
    "4", "", false, "sorted-1050",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -bisect -inline $v \"2\"",
    "+2", "", false, "sorted-1051",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -start 1 $v \"2\"",
    "4", "", false, "sorted-1052",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -bisect -start 2 $v \"2\"",
    "4", "", false, "sorted-1053",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -nocase $v \"2\"",
    "4", "", false, "sorted-1054",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -all -nocase $v \"2\"",
    "4", "", false, "sorted-1055",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing  $v \"8\"",
    "4", "", false, "sorted-1056",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -all $v \"8\"",
    "4", "", false, "sorted-1057",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -inline $v \"8\"",
    "010", "", false, "sorted-1058",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -all -inline $v \"8\"",
    "010", "", false, "sorted-1059",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -not -all $v \"8\"",
    "0 1 2 3 5 6 7", "", false, "sorted-1060",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -bisect $v \"8\"",
    "4", "", false, "sorted-1061",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -bisect -inline $v \"8\"",
    "010", "", false, "sorted-1062",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -start 1 $v \"8\"",
    "4", "", false, "sorted-1063",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -bisect -start 2 $v \"8\"",
    "4", "", false, "sorted-1064",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -nocase $v \"8\"",
    "4", "", false, "sorted-1065",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -all -nocase $v \"8\"",
    "4", "", false, "sorted-1066",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing  $v \"8\"",
    "3", "", false, "sorted-1067",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -all $v \"8\"",
    "3", "", false, "sorted-1068",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -inline $v \"8\"",
    "010", "", false, "sorted-1069",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -all -inline $v \"8\"",
    "010", "", false, "sorted-1070",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -not -all $v \"8\"",
    "0 1 2 4 5 6 7", "", false, "sorted-1071",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -bisect $v \"8\"",
    "3", "", false, "sorted-1072",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -bisect -inline $v \"8\"",
    "010", "", false, "sorted-1073",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -start 1 $v \"8\"",
    "3", "", false, "sorted-1074",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -bisect -start 2 $v \"8\"",
    "3", "", false, "sorted-1075",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -nocase $v \"8\"",
    "3", "", false, "sorted-1076",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -all -nocase $v \"8\"",
    "3", "", false, "sorted-1077",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing  $v \"16\"",
    "6", "", false, "sorted-1078",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -all $v \"16\"",
    "6 7", "", false, "sorted-1079",
  )
}

///|
test "Tcl search cases 1081 through 1120" {
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -inline $v \"16\"",
    "0x10", "", false, "sorted-1080",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -all -inline $v \"16\"",
    "0x10 16", "", false, "sorted-1081",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -not -all $v \"16\"",
    "0 1 2 3 4 5", "", false, "sorted-1082",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -bisect $v \"16\"",
    "7", "", false, "sorted-1083",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -bisect -inline $v \"16\"",
    "16", "", false, "sorted-1084",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -start 1 $v \"16\"",
    "6", "", false, "sorted-1085",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -bisect -start 2 $v \"16\"",
    "7", "", false, "sorted-1086",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -nocase $v \"16\"",
    "6", "", false, "sorted-1087",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -all -nocase $v \"16\"",
    "6 7", "", false, "sorted-1088",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing  $v \"16\"",
    "0", "", false, "sorted-1089",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -all $v \"16\"",
    "0 1", "", false, "sorted-1090",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -inline $v \"16\"",
    "0x10", "", false, "sorted-1091",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -all -inline $v \"16\"",
    "0x10 16", "", false, "sorted-1092",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -not -all $v \"16\"",
    "2 3 4 5 6 7", "", false, "sorted-1093",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -bisect $v \"16\"",
    "1", "", false, "sorted-1094",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -bisect -inline $v \"16\"",
    "16", "", false, "sorted-1095",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -start 1 $v \"16\"",
    "1", "", false, "sorted-1096",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -bisect -start 2 $v \"16\"",
    "1", "", false, "sorted-1097",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -nocase $v \"16\"",
    "0", "", false, "sorted-1098",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -all -nocase $v \"16\"",
    "0 1", "", false, "sorted-1099",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing  $v \"100\"",
    "-1", "", false, "sorted-1100",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -all $v \"100\"",
    "", "", false, "sorted-1101",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -inline $v \"100\"",
    "", "", false, "sorted-1102",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -all -inline $v \"100\"",
    "", "", false, "sorted-1103",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -not -all $v \"100\"",
    "0 1 2 3 4 5 6 7", "", false, "sorted-1104",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -bisect $v \"100\"",
    "7", "", false, "sorted-1105",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -bisect -inline $v \"100\"",
    "16", "", false, "sorted-1106",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -start 1 $v \"100\"",
    "-1", "", false, "sorted-1107",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -bisect -start 2 $v \"100\"",
    "7", "", false, "sorted-1108",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -nocase $v \"100\"",
    "-1", "", false, "sorted-1109",
  )
  check_search_case(
    "set v [lsort -integer -increasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -increasing -all -nocase $v \"100\"",
    "", "", false, "sorted-1110",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing  $v \"100\"",
    "-1", "", false, "sorted-1111",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -all $v \"100\"",
    "", "", false, "sorted-1112",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -inline $v \"100\"",
    "", "", false, "sorted-1113",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -all -inline $v \"100\"",
    "", "", false, "sorted-1114",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -not -all $v \"100\"",
    "0 1 2 3 4 5 6 7", "", false, "sorted-1115",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -bisect $v \"100\"",
    "-1", "", false, "sorted-1116",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -bisect -inline $v \"100\"",
    "", "", false, "sorted-1117",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -start 1 $v \"100\"",
    "-1", "", false, "sorted-1118",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -bisect -start 2 $v \"100\"",
    "1", "", false, "sorted-1119",
  )
}

///|
test "Tcl search cases 1121 through 1160" {
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -nocase $v \"100\"",
    "-1", "", false, "sorted-1120",
  )
  check_search_case(
    "set v [lsort -integer -decreasing [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"]];lsearch -sorted -integer -decreasing -all -nocase $v \"100\"",
    "", "", false, "sorted-1121",
  )
  check_search_case(
    "lsearch -exact -integer  [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"] \"-2\"",
    "-1", "", false, "content-1122",
  )
  check_search_case(
    "lsearch -exact -integer -all [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"] \"-2\"",
    "", "", false, "content-1123",
  )
  check_search_case(
    "lsearch -exact -integer -not -all -inline [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"] \"-2\"",
    "0 -1 1 10 0x10 16 010 +2", "", false, "content-1124",
  )
  check_search_case(
    "lsearch -exact -integer -nocase -all [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"] \"-2\"",
    "", "", false, "content-1125",
  )
  check_search_case(
    "lsearch -exact -integer  [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"] \"-1\"",
    "1", "", false, "content-1126",
  )
  check_search_case(
    "lsearch -exact -integer -all [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"] \"-1\"",
    "1", "", false, "content-1127",
  )
  check_search_case(
    "lsearch -exact -integer -not -all -inline [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"] \"-1\"",
    "0 1 10 0x10 16 010 +2", "", false, "content-1128",
  )
  check_search_case(
    "lsearch -exact -integer -nocase -all [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"] \"-1\"",
    "1", "", false, "content-1129",
  )
  check_search_case(
    "lsearch -exact -integer  [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"] \"0\"",
    "0", "", false, "content-1130",
  )
  check_search_case(
    "lsearch -exact -integer -all [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"] \"0\"",
    "0", "", false, "content-1131",
  )
  check_search_case(
    "lsearch -exact -integer -not -all -inline [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"] \"0\"",
    "-1 1 10 0x10 16 010 +2", "", false, "content-1132",
  )
  check_search_case(
    "lsearch -exact -integer -nocase -all [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"] \"0\"",
    "0", "", false, "content-1133",
  )
  check_search_case(
    "lsearch -exact -integer  [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"] \"2\"",
    "7", "", false, "content-1134",
  )
  check_search_case(
    "lsearch -exact -integer -all [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"] \"2\"",
    "7", "", false, "content-1135",
  )
  check_search_case(
    "lsearch -exact -integer -not -all -inline [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"] \"2\"",
    "0 -1 1 10 0x10 16 010", "", false, "content-1136",
  )
  check_search_case(
    "lsearch -exact -integer -nocase -all [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"] \"2\"",
    "7", "", false, "content-1137",
  )
  check_search_case(
    "lsearch -exact -integer  [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"] \"8\"",
    "6", "", false, "content-1138",
  )
  check_search_case(
    "lsearch -exact -integer -all [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"] \"8\"",
    "6", "", false, "content-1139",
  )
  check_search_case(
    "lsearch -exact -integer -not -all -inline [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"] \"8\"",
    "0 -1 1 10 0x10 16 +2", "", false, "content-1140",
  )
  check_search_case(
    "lsearch -exact -integer -nocase -all [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"] \"8\"",
    "6", "", false, "content-1141",
  )
  check_search_case(
    "lsearch -exact -integer  [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"] \"16\"",
    "4", "", false, "content-1142",
  )
  check_search_case(
    "lsearch -exact -integer -all [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"] \"16\"",
    "4 5", "", false, "content-1143",
  )
  check_search_case(
    "lsearch -exact -integer -not -all -inline [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"] \"16\"",
    "0 -1 1 10 010 +2", "", false, "content-1144",
  )
  check_search_case(
    "lsearch -exact -integer -nocase -all [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"] \"16\"",
    "4 5", "", false, "content-1145",
  )
  check_search_case(
    "lsearch -exact -integer  [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"] \"100\"",
    "-1", "", false, "content-1146",
  )
  check_search_case(
    "lsearch -exact -integer -all [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"] \"100\"",
    "", "", false, "content-1147",
  )
  check_search_case(
    "lsearch -exact -integer -not -all -inline [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"] \"100\"",
    "0 -1 1 10 0x10 16 010 +2", "", false, "content-1148",
  )
  check_search_case(
    "lsearch -exact -integer -nocase -all [list \"0\" \"-1\" \"1\" \"10\" \"0x10\" \"16\" \"010\" \"+2\"] \"100\"",
    "", "", false, "content-1149",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing  $v \"-Inf\"",
    "0", "", false, "sorted-1150",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -all $v \"-Inf\"",
    "0", "", false, "sorted-1151",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -inline $v \"-Inf\"",
    "-Inf", "", false, "sorted-1152",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -all -inline $v \"-Inf\"",
    "-Inf", "", false, "sorted-1153",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -not -all $v \"-Inf\"",
    "1 2 3 4 5 6 7", "", false, "sorted-1154",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -bisect $v \"-Inf\"",
    "0", "", false, "sorted-1155",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -bisect -inline $v \"-Inf\"",
    "-Inf", "", false, "sorted-1156",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -start 1 $v \"-Inf\"",
    "-1", "", false, "sorted-1157",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -bisect -start 2 $v \"-Inf\"",
    "1", "", false, "sorted-1158",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -nocase $v \"-Inf\"",
    "0", "", false, "sorted-1159",
  )
}

///|
test "Tcl search cases 1161 through 1200" {
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -all -nocase $v \"-Inf\"",
    "0", "", false, "sorted-1160",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing  $v \"-Inf\"",
    "7", "", false, "sorted-1161",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -all $v \"-Inf\"",
    "7", "", false, "sorted-1162",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -inline $v \"-Inf\"",
    "-Inf", "", false, "sorted-1163",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -all -inline $v \"-Inf\"",
    "-Inf", "", false, "sorted-1164",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -not -all $v \"-Inf\"",
    "0 1 2 3 4 5 6", "", false, "sorted-1165",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -bisect $v \"-Inf\"",
    "7", "", false, "sorted-1166",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -bisect -inline $v \"-Inf\"",
    "-Inf", "", false, "sorted-1167",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -start 1 $v \"-Inf\"",
    "7", "", false, "sorted-1168",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -bisect -start 2 $v \"-Inf\"",
    "7", "", false, "sorted-1169",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -nocase $v \"-Inf\"",
    "7", "", false, "sorted-1170",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -all -nocase $v \"-Inf\"",
    "7", "", false, "sorted-1171",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing  $v \"-3\"",
    "-1", "", false, "sorted-1172",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -all $v \"-3\"",
    "", "", false, "sorted-1173",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -inline $v \"-3\"",
    "", "", false, "sorted-1174",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -all -inline $v \"-3\"",
    "", "", false, "sorted-1175",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -not -all $v \"-3\"",
    "0 1 2 3 4 5 6 7", "", false, "sorted-1176",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -bisect $v \"-3\"",
    "0", "", false, "sorted-1177",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -bisect -inline $v \"-3\"",
    "-Inf", "", false, "sorted-1178",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -start 1 $v \"-3\"",
    "-1", "", false, "sorted-1179",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -bisect -start 2 $v \"-3\"",
    "1", "", false, "sorted-1180",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -nocase $v \"-3\"",
    "-1", "", false, "sorted-1181",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -all -nocase $v \"-3\"",
    "", "", false, "sorted-1182",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing  $v \"-3\"",
    "-1", "", false, "sorted-1183",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -all $v \"-3\"",
    "", "", false, "sorted-1184",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -inline $v \"-3\"",
    "", "", false, "sorted-1185",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -all -inline $v \"-3\"",
    "", "", false, "sorted-1186",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -not -all $v \"-3\"",
    "0 1 2 3 4 5 6 7", "", false, "sorted-1187",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -bisect $v \"-3\"",
    "6", "", false, "sorted-1188",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -bisect -inline $v \"-3\"",
    "-2.5", "", false, "sorted-1189",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -start 1 $v \"-3\"",
    "-1", "", false, "sorted-1190",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -bisect -start 2 $v \"-3\"",
    "6", "", false, "sorted-1191",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -nocase $v \"-3\"",
    "-1", "", false, "sorted-1192",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -all -nocase $v \"-3\"",
    "", "", false, "sorted-1193",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing  $v \"-0\"",
    "2", "", false, "sorted-1194",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -all $v \"-0\"",
    "2 3", "", false, "sorted-1195",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -inline $v \"-0\"",
    "-0.0", "", false, "sorted-1196",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -all -inline $v \"-0\"",
    "-0.0 0", "", false, "sorted-1197",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -not -all $v \"-0\"",
    "0 1 4 5 6 7", "", false, "sorted-1198",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -bisect $v \"-0\"",
    "3", "", false, "sorted-1199",
  )
}

///|
test "Tcl search cases 1201 through 1240" {
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -bisect -inline $v \"-0\"",
    "0", "", false, "sorted-1200",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -start 1 $v \"-0\"",
    "2", "", false, "sorted-1201",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -bisect -start 2 $v \"-0\"",
    "3", "", false, "sorted-1202",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -nocase $v \"-0\"",
    "2", "", false, "sorted-1203",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -all -nocase $v \"-0\"",
    "2 3", "", false, "sorted-1204",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing  $v \"-0\"",
    "4", "", false, "sorted-1205",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -all $v \"-0\"",
    "4 5", "", false, "sorted-1206",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -inline $v \"-0\"",
    "-0.0", "", false, "sorted-1207",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -all -inline $v \"-0\"",
    "-0.0 0", "", false, "sorted-1208",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -not -all $v \"-0\"",
    "0 1 2 3 6 7", "", false, "sorted-1209",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -bisect $v \"-0\"",
    "5", "", false, "sorted-1210",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -bisect -inline $v \"-0\"",
    "0", "", false, "sorted-1211",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -start 1 $v \"-0\"",
    "4", "", false, "sorted-1212",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -bisect -start 2 $v \"-0\"",
    "5", "", false, "sorted-1213",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -nocase $v \"-0\"",
    "4", "", false, "sorted-1214",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -all -nocase $v \"-0\"",
    "4 5", "", false, "sorted-1215",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing  $v \"1.0\"",
    "4", "", false, "sorted-1216",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -all $v \"1.0\"",
    "4 5", "", false, "sorted-1217",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -inline $v \"1.0\"",
    "1", "", false, "sorted-1218",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -all -inline $v \"1.0\"",
    "1 1.0", "", false, "sorted-1219",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -not -all $v \"1.0\"",
    "0 1 2 3 6 7", "", false, "sorted-1220",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -bisect $v \"1.0\"",
    "5", "", false, "sorted-1221",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -bisect -inline $v \"1.0\"",
    "1.0", "", false, "sorted-1222",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -start 1 $v \"1.0\"",
    "4", "", false, "sorted-1223",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -bisect -start 2 $v \"1.0\"",
    "5", "", false, "sorted-1224",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -nocase $v \"1.0\"",
    "4", "", false, "sorted-1225",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -all -nocase $v \"1.0\"",
    "4 5", "", false, "sorted-1226",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing  $v \"1.0\"",
    "2", "", false, "sorted-1227",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -all $v \"1.0\"",
    "2 3", "", false, "sorted-1228",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -inline $v \"1.0\"",
    "1", "", false, "sorted-1229",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -all -inline $v \"1.0\"",
    "1 1.0", "", false, "sorted-1230",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -not -all $v \"1.0\"",
    "0 1 4 5 6 7", "", false, "sorted-1231",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -bisect $v \"1.0\"",
    "3", "", false, "sorted-1232",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -bisect -inline $v \"1.0\"",
    "1.0", "", false, "sorted-1233",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -start 1 $v \"1.0\"",
    "2", "", false, "sorted-1234",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -bisect -start 2 $v \"1.0\"",
    "3", "", false, "sorted-1235",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -nocase $v \"1.0\"",
    "2", "", false, "sorted-1236",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -all -nocase $v \"1.0\"",
    "2 3", "", false, "sorted-1237",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing  $v \"2\"",
    "-1", "", false, "sorted-1238",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -all $v \"2\"",
    "", "", false, "sorted-1239",
  )
}

///|
test "Tcl search cases 1241 through 1280" {
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -inline $v \"2\"",
    "", "", false, "sorted-1240",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -all -inline $v \"2\"",
    "", "", false, "sorted-1241",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -not -all $v \"2\"",
    "0 1 2 3 4 5 6 7", "", false, "sorted-1242",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -bisect $v \"2\"",
    "5", "", false, "sorted-1243",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -bisect -inline $v \"2\"",
    "1.0", "", false, "sorted-1244",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -start 1 $v \"2\"",
    "-1", "", false, "sorted-1245",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -bisect -start 2 $v \"2\"",
    "5", "", false, "sorted-1246",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -nocase $v \"2\"",
    "-1", "", false, "sorted-1247",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -all -nocase $v \"2\"",
    "", "", false, "sorted-1248",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing  $v \"2\"",
    "-1", "", false, "sorted-1249",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -all $v \"2\"",
    "", "", false, "sorted-1250",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -inline $v \"2\"",
    "", "", false, "sorted-1251",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -all -inline $v \"2\"",
    "", "", false, "sorted-1252",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -not -all $v \"2\"",
    "0 1 2 3 4 5 6 7", "", false, "sorted-1253",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -bisect $v \"2\"",
    "1", "", false, "sorted-1254",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -bisect -inline $v \"2\"",
    "3e2", "", false, "sorted-1255",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -start 1 $v \"2\"",
    "-1", "", false, "sorted-1256",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -bisect -start 2 $v \"2\"",
    "1", "", false, "sorted-1257",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -nocase $v \"2\"",
    "-1", "", false, "sorted-1258",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -all -nocase $v \"2\"",
    "", "", false, "sorted-1259",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing  $v \"300\"",
    "6", "", false, "sorted-1260",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -all $v \"300\"",
    "6", "", false, "sorted-1261",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -inline $v \"300\"",
    "3e2", "", false, "sorted-1262",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -all -inline $v \"300\"",
    "3e2", "", false, "sorted-1263",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -not -all $v \"300\"",
    "0 1 2 3 4 5 7", "", false, "sorted-1264",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -bisect $v \"300\"",
    "6", "", false, "sorted-1265",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -bisect -inline $v \"300\"",
    "3e2", "", false, "sorted-1266",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -start 1 $v \"300\"",
    "6", "", false, "sorted-1267",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -bisect -start 2 $v \"300\"",
    "6", "", false, "sorted-1268",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -nocase $v \"300\"",
    "6", "", false, "sorted-1269",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -all -nocase $v \"300\"",
    "6", "", false, "sorted-1270",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing  $v \"300\"",
    "1", "", false, "sorted-1271",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -all $v \"300\"",
    "1", "", false, "sorted-1272",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -inline $v \"300\"",
    "3e2", "", false, "sorted-1273",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -all -inline $v \"300\"",
    "3e2", "", false, "sorted-1274",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -not -all $v \"300\"",
    "0 2 3 4 5 6 7", "", false, "sorted-1275",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -bisect $v \"300\"",
    "1", "", false, "sorted-1276",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -bisect -inline $v \"300\"",
    "3e2", "", false, "sorted-1277",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -start 1 $v \"300\"",
    "1", "", false, "sorted-1278",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -bisect -start 2 $v \"300\"",
    "1", "", false, "sorted-1279",
  )
}

///|
test "Tcl search cases 1281 through 1320" {
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -nocase $v \"300\"",
    "1", "", false, "sorted-1280",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -all -nocase $v \"300\"",
    "1", "", false, "sorted-1281",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing  $v \"Inf\"",
    "7", "", false, "sorted-1282",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -all $v \"Inf\"",
    "7", "", false, "sorted-1283",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -inline $v \"Inf\"",
    "Inf", "", false, "sorted-1284",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -all -inline $v \"Inf\"",
    "Inf", "", false, "sorted-1285",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -not -all $v \"Inf\"",
    "0 1 2 3 4 5 6", "", false, "sorted-1286",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -bisect $v \"Inf\"",
    "7", "", false, "sorted-1287",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -bisect -inline $v \"Inf\"",
    "Inf", "", false, "sorted-1288",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -start 1 $v \"Inf\"",
    "7", "", false, "sorted-1289",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -bisect -start 2 $v \"Inf\"",
    "7", "", false, "sorted-1290",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -nocase $v \"Inf\"",
    "7", "", false, "sorted-1291",
  )
  check_search_case(
    "set v [lsort -real -increasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -increasing -all -nocase $v \"Inf\"",
    "7", "", false, "sorted-1292",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing  $v \"Inf\"",
    "0", "", false, "sorted-1293",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -all $v \"Inf\"",
    "0", "", false, "sorted-1294",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -inline $v \"Inf\"",
    "Inf", "", false, "sorted-1295",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -all -inline $v \"Inf\"",
    "Inf", "", false, "sorted-1296",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -not -all $v \"Inf\"",
    "1 2 3 4 5 6 7", "", false, "sorted-1297",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -bisect $v \"Inf\"",
    "0", "", false, "sorted-1298",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -bisect -inline $v \"Inf\"",
    "Inf", "", false, "sorted-1299",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -start 1 $v \"Inf\"",
    "-1", "", false, "sorted-1300",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -bisect -start 2 $v \"Inf\"",
    "1", "", false, "sorted-1301",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -nocase $v \"Inf\"",
    "0", "", false, "sorted-1302",
  )
  check_search_case(
    "set v [lsort -real -decreasing [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"]];lsearch -sorted -real -decreasing -all -nocase $v \"Inf\"",
    "0", "", false, "sorted-1303",
  )
  check_search_case(
    "lsearch -exact -real  [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"] \"-Inf\"",
    "0", "", false, "content-1304",
  )
  check_search_case(
    "lsearch -exact -real -all [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"] \"-Inf\"",
    "0", "", false, "content-1305",
  )
  check_search_case(
    "lsearch -exact -real -not -all -inline [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"] \"-Inf\"",
    "-2.5 -0.0 0 1 1.0 3e2 Inf", "", false, "content-1306",
  )
  check_search_case(
    "lsearch -exact -real -nocase -all [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"] \"-Inf\"",
    "0", "", false, "content-1307",
  )
  check_search_case(
    "lsearch -exact -real  [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"] \"-3\"",
    "-1", "", false, "content-1308",
  )
  check_search_case(
    "lsearch -exact -real -all [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"] \"-3\"",
    "", "", false, "content-1309",
  )
  check_search_case(
    "lsearch -exact -real -not -all -inline [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"] \"-3\"",
    "-Inf -2.5 -0.0 0 1 1.0 3e2 Inf", "", false, "content-1310",
  )
  check_search_case(
    "lsearch -exact -real -nocase -all [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"] \"-3\"",
    "", "", false, "content-1311",
  )
  check_search_case(
    "lsearch -exact -real  [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"] \"-0\"",
    "2", "", false, "content-1312",
  )
  check_search_case(
    "lsearch -exact -real -all [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"] \"-0\"",
    "2 3", "", false, "content-1313",
  )
  check_search_case(
    "lsearch -exact -real -not -all -inline [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"] \"-0\"",
    "-Inf -2.5 1 1.0 3e2 Inf", "", false, "content-1314",
  )
  check_search_case(
    "lsearch -exact -real -nocase -all [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"] \"-0\"",
    "2 3", "", false, "content-1315",
  )
  check_search_case(
    "lsearch -exact -real  [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"] \"1.0\"",
    "4", "", false, "content-1316",
  )
  check_search_case(
    "lsearch -exact -real -all [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"] \"1.0\"",
    "4 5", "", false, "content-1317",
  )
  check_search_case(
    "lsearch -exact -real -not -all -inline [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"] \"1.0\"",
    "-Inf -2.5 -0.0 0 3e2 Inf", "", false, "content-1318",
  )
  check_search_case(
    "lsearch -exact -real -nocase -all [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"] \"1.0\"",
    "4 5", "", false, "content-1319",
  )
}

///|
test "Tcl search cases 1321 through 1360" {
  check_search_case(
    "lsearch -exact -real  [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"] \"2\"",
    "-1", "", false, "content-1320",
  )
  check_search_case(
    "lsearch -exact -real -all [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"] \"2\"",
    "", "", false, "content-1321",
  )
  check_search_case(
    "lsearch -exact -real -not -all -inline [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"] \"2\"",
    "-Inf -2.5 -0.0 0 1 1.0 3e2 Inf", "", false, "content-1322",
  )
  check_search_case(
    "lsearch -exact -real -nocase -all [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"] \"2\"",
    "", "", false, "content-1323",
  )
  check_search_case(
    "lsearch -exact -real  [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"] \"300\"",
    "6", "", false, "content-1324",
  )
  check_search_case(
    "lsearch -exact -real -all [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"] \"300\"",
    "6", "", false, "content-1325",
  )
  check_search_case(
    "lsearch -exact -real -not -all -inline [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"] \"300\"",
    "-Inf -2.5 -0.0 0 1 1.0 Inf", "", false, "content-1326",
  )
  check_search_case(
    "lsearch -exact -real -nocase -all [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"] \"300\"",
    "6", "", false, "content-1327",
  )
  check_search_case(
    "lsearch -exact -real  [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"] \"Inf\"",
    "7", "", false, "content-1328",
  )
  check_search_case(
    "lsearch -exact -real -all [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"] \"Inf\"",
    "7", "", false, "content-1329",
  )
  check_search_case(
    "lsearch -exact -real -not -all -inline [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"] \"Inf\"",
    "-Inf -2.5 -0.0 0 1 1.0 3e2", "", false, "content-1330",
  )
  check_search_case(
    "lsearch -exact -real -nocase -all [list \"-Inf\" \"-2.5\" \"-0.0\" \"0\" \"1\" \"1.0\" \"3e2\" \"Inf\"] \"Inf\"",
    "7", "", false, "content-1331",
  )
  check_search_case(
    "lsearch -exact  -index \"0\" {{a x} {b y} {a z}} \"a\"", "0", "", false, "nested-1332",
  )
  check_search_case(
    "lsearch -exact  -index \"0\" {{a x} {b y} {a z}} \"z\"", "-1", "", false, "nested-1333",
  )
  check_search_case(
    "lsearch -exact -all -index \"0\" {{a x} {b y} {a z}} \"a\"", "0 2", "", false,
    "nested-1334",
  )
  check_search_case(
    "lsearch -exact -all -index \"0\" {{a x} {b y} {a z}} \"z\"", "", "", false,
    "nested-1335",
  )
  check_search_case(
    "lsearch -exact -inline -index \"0\" {{a x} {b y} {a z}} \"a\"", "a x", "", false,
    "nested-1336",
  )
  check_search_case(
    "lsearch -exact -inline -index \"0\" {{a x} {b y} {a z}} \"z\"", "", "", false,
    "nested-1337",
  )
  check_search_case(
    "lsearch -exact -all -inline -index \"0\" {{a x} {b y} {a z}} \"a\"", "{a x} {a z}",
    "", false, "nested-1338",
  )
  check_search_case(
    "lsearch -exact -all -inline -index \"0\" {{a x} {b y} {a z}} \"z\"", "", "",
    false, "nested-1339",
  )
  check_search_case(
    "lsearch -exact -subindices -index \"0\" {{a x} {b y} {a z}} \"a\"", "0 0", "",
    false, "nested-1340",
  )
  check_search_case(
    "lsearch -exact -subindices -index \"0\" {{a x} {b y} {a z}} \"z\"", "-1 0",
    "", false, "nested-1341",
  )
  check_search_case(
    "lsearch -exact -all -subindices -index \"0\" {{a x} {b y} {a z}} \"a\"", "{0 0} {2 0}",
    "", false, "nested-1342",
  )
  check_search_case(
    "lsearch -exact -all -subindices -index \"0\" {{a x} {b y} {a z}} \"z\"", "",
    "", false, "nested-1343",
  )
  check_search_case(
    "lsearch -exact -inline -subindices -index \"0\" {{a x} {b y} {a z}} \"a\"",
    "a x", "", false, "nested-1344",
  )
  check_search_case(
    "lsearch -exact -inline -subindices -index \"0\" {{a x} {b y} {a z}} \"z\"",
    "", "", false, "nested-1345",
  )
  check_search_case(
    "lsearch -exact -all -inline -subindices -index \"0\" {{a x} {b y} {a z}} \"a\"",
    "a a", "", false, "nested-1346",
  )
  check_search_case(
    "lsearch -exact -all -inline -subindices -index \"0\" {{a x} {b y} {a z}} \"z\"",
    "", "", false, "nested-1347",
  )
  check_search_case(
    "lsearch -exact -not -all -subindices -index \"0\" {{a x} {b y} {a z}} \"a\"",
    "{1 0}", "", false, "nested-1348",
  )
  check_search_case(
    "lsearch -exact -not -all -subindices -index \"0\" {{a x} {b y} {a z}} \"z\"",
    "{0 0} {1 0} {2 0}", "", false, "nested-1349",
  )
  check_search_case(
    "lsearch -exact -start 1 -subindices -index \"0\" {{a x} {b y} {a z}} \"a\"",
    "2 0", "", false, "nested-1350",
  )
  check_search_case(
    "lsearch -exact -start 1 -subindices -index \"0\" {{a x} {b y} {a z}} \"z\"",
    "-1 0", "", false, "nested-1351",
  )
  check_search_case(
    "lsearch -exact -start 100 -subindices -index \"0\" {{a x} {b y} {a z}} \"a\"",
    "-1", "", false, "nested-1352",
  )
  check_search_case(
    "lsearch -exact -start 100 -subindices -index \"0\" {{a x} {b y} {a z}} \"z\"",
    "-1", "", false, "nested-1353",
  )
  check_search_case(
    "lsearch -glob  -index \"0\" {{a x} {b y} {a z}} \"a\"", "0", "", false, "nested-1354",
  )
  check_search_case(
    "lsearch -glob  -index \"0\" {{a x} {b y} {a z}} \"z\"", "-1", "", false, "nested-1355",
  )
  check_search_case(
    "lsearch -glob -all -index \"0\" {{a x} {b y} {a z}} \"a\"", "0 2", "", false,
    "nested-1356",
  )
  check_search_case(
    "lsearch -glob -all -index \"0\" {{a x} {b y} {a z}} \"z\"", "", "", false, "nested-1357",
  )
  check_search_case(
    "lsearch -glob -inline -index \"0\" {{a x} {b y} {a z}} \"a\"", "a x", "", false,
    "nested-1358",
  )
  check_search_case(
    "lsearch -glob -inline -index \"0\" {{a x} {b y} {a z}} \"z\"", "", "", false,
    "nested-1359",
  )
}

///|
test "Tcl search cases 1361 through 1400" {
  check_search_case(
    "lsearch -glob -all -inline -index \"0\" {{a x} {b y} {a z}} \"a\"", "{a x} {a z}",
    "", false, "nested-1360",
  )
  check_search_case(
    "lsearch -glob -all -inline -index \"0\" {{a x} {b y} {a z}} \"z\"", "", "",
    false, "nested-1361",
  )
  check_search_case(
    "lsearch -glob -subindices -index \"0\" {{a x} {b y} {a z}} \"a\"", "0 0", "",
    false, "nested-1362",
  )
  check_search_case(
    "lsearch -glob -subindices -index \"0\" {{a x} {b y} {a z}} \"z\"", "-1 0", "",
    false, "nested-1363",
  )
  check_search_case(
    "lsearch -glob -all -subindices -index \"0\" {{a x} {b y} {a z}} \"a\"", "{0 0} {2 0}",
    "", false, "nested-1364",
  )
  check_search_case(
    "lsearch -glob -all -subindices -index \"0\" {{a x} {b y} {a z}} \"z\"", "",
    "", false, "nested-1365",
  )
  check_search_case(
    "lsearch -glob -inline -subindices -index \"0\" {{a x} {b y} {a z}} \"a\"", "a x",
    "", false, "nested-1366",
  )
  check_search_case(
    "lsearch -glob -inline -subindices -index \"0\" {{a x} {b y} {a z}} \"z\"", "",
    "", false, "nested-1367",
  )
  check_search_case(
    "lsearch -glob -all -inline -subindices -index \"0\" {{a x} {b y} {a z}} \"a\"",
    "a a", "", false, "nested-1368",
  )
  check_search_case(
    "lsearch -glob -all -inline -subindices -index \"0\" {{a x} {b y} {a z}} \"z\"",
    "", "", false, "nested-1369",
  )
  check_search_case(
    "lsearch -glob -not -all -subindices -index \"0\" {{a x} {b y} {a z}} \"a\"",
    "{1 0}", "", false, "nested-1370",
  )
  check_search_case(
    "lsearch -glob -not -all -subindices -index \"0\" {{a x} {b y} {a z}} \"z\"",
    "{0 0} {1 0} {2 0}", "", false, "nested-1371",
  )
  check_search_case(
    "lsearch -glob -start 1 -subindices -index \"0\" {{a x} {b y} {a z}} \"a\"",
    "2 0", "", false, "nested-1372",
  )
  check_search_case(
    "lsearch -glob -start 1 -subindices -index \"0\" {{a x} {b y} {a z}} \"z\"",
    "-1 0", "", false, "nested-1373",
  )
  check_search_case(
    "lsearch -glob -start 100 -subindices -index \"0\" {{a x} {b y} {a z}} \"a\"",
    "-1", "", false, "nested-1374",
  )
  check_search_case(
    "lsearch -glob -start 100 -subindices -index \"0\" {{a x} {b y} {a z}} \"z\"",
    "-1", "", false, "nested-1375",
  )
  check_search_case(
    "lsearch -regexp  -index \"0\" {{a x} {b y} {a z}} \"a\"", "0", "", false, "nested-1376",
  )
  check_search_case(
    "lsearch -regexp  -index \"0\" {{a x} {b y} {a z}} \"z\"", "-1", "", false, "nested-1377",
  )
  check_search_case(
    "lsearch -regexp -all -index \"0\" {{a x} {b y} {a z}} \"a\"", "0 2", "", false,
    "nested-1378",
  )
  check_search_case(
    "lsearch -regexp -all -index \"0\" {{a x} {b y} {a z}} \"z\"", "", "", false,
    "nested-1379",
  )
  check_search_case(
    "lsearch -regexp -inline -index \"0\" {{a x} {b y} {a z}} \"a\"", "a x", "",
    false, "nested-1380",
  )
  check_search_case(
    "lsearch -regexp -inline -index \"0\" {{a x} {b y} {a z}} \"z\"", "", "", false,
    "nested-1381",
  )
  check_search_case(
    "lsearch -regexp -all -inline -index \"0\" {{a x} {b y} {a z}} \"a\"", "{a x} {a z}",
    "", false, "nested-1382",
  )
  check_search_case(
    "lsearch -regexp -all -inline -index \"0\" {{a x} {b y} {a z}} \"z\"", "", "",
    false, "nested-1383",
  )
  check_search_case(
    "lsearch -regexp -subindices -index \"0\" {{a x} {b y} {a z}} \"a\"", "0 0",
    "", false, "nested-1384",
  )
  check_search_case(
    "lsearch -regexp -subindices -index \"0\" {{a x} {b y} {a z}} \"z\"", "-1 0",
    "", false, "nested-1385",
  )
  check_search_case(
    "lsearch -regexp -all -subindices -index \"0\" {{a x} {b y} {a z}} \"a\"", "{0 0} {2 0}",
    "", false, "nested-1386",
  )
  check_search_case(
    "lsearch -regexp -all -subindices -index \"0\" {{a x} {b y} {a z}} \"z\"", "",
    "", false, "nested-1387",
  )
  check_search_case(
    "lsearch -regexp -inline -subindices -index \"0\" {{a x} {b y} {a z}} \"a\"",
    "a x", "", false, "nested-1388",
  )
  check_search_case(
    "lsearch -regexp -inline -subindices -index \"0\" {{a x} {b y} {a z}} \"z\"",
    "", "", false, "nested-1389",
  )
  check_search_case(
    "lsearch -regexp -all -inline -subindices -index \"0\" {{a x} {b y} {a z}} \"a\"",
    "a a", "", false, "nested-1390",
  )
  check_search_case(
    "lsearch -regexp -all -inline -subindices -index \"0\" {{a x} {b y} {a z}} \"z\"",
    "", "", false, "nested-1391",
  )
  check_search_case(
    "lsearch -regexp -not -all -subindices -index \"0\" {{a x} {b y} {a z}} \"a\"",
    "{1 0}", "", false, "nested-1392",
  )
  check_search_case(
    "lsearch -regexp -not -all -subindices -index \"0\" {{a x} {b y} {a z}} \"z\"",
    "{0 0} {1 0} {2 0}", "", false, "nested-1393",
  )
  check_search_case(
    "lsearch -regexp -start 1 -subindices -index \"0\" {{a x} {b y} {a z}} \"a\"",
    "2 0", "", false, "nested-1394",
  )
  check_search_case(
    "lsearch -regexp -start 1 -subindices -index \"0\" {{a x} {b y} {a z}} \"z\"",
    "-1 0", "", false, "nested-1395",
  )
  check_search_case(
    "lsearch -regexp -start 100 -subindices -index \"0\" {{a x} {b y} {a z}} \"a\"",
    "-1", "", false, "nested-1396",
  )
  check_search_case(
    "lsearch -regexp -start 100 -subindices -index \"0\" {{a x} {b y} {a z}} \"z\"",
    "-1", "", false, "nested-1397",
  )
  check_search_case(
    "lsearch -sorted  -index \"0\" {{a x} {b y} {a z}} \"a\"", "0", "", false, "nested-1398",
  )
  check_search_case(
    "lsearch -sorted  -index \"0\" {{a x} {b y} {a z}} \"z\"", "-1", "", false, "nested-1399",
  )
}

///|
test "Tcl search cases 1401 through 1440" {
  check_search_case(
    "lsearch -sorted -all -index \"0\" {{a x} {b y} {a z}} \"a\"", "0 2", "", false,
    "nested-1400",
  )
  check_search_case(
    "lsearch -sorted -all -index \"0\" {{a x} {b y} {a z}} \"z\"", "", "", false,
    "nested-1401",
  )
  check_search_case(
    "lsearch -sorted -inline -index \"0\" {{a x} {b y} {a z}} \"a\"", "a x", "",
    false, "nested-1402",
  )
  check_search_case(
    "lsearch -sorted -inline -index \"0\" {{a x} {b y} {a z}} \"z\"", "", "", false,
    "nested-1403",
  )
  check_search_case(
    "lsearch -sorted -all -inline -index \"0\" {{a x} {b y} {a z}} \"a\"", "{a x} {a z}",
    "", false, "nested-1404",
  )
  check_search_case(
    "lsearch -sorted -all -inline -index \"0\" {{a x} {b y} {a z}} \"z\"", "", "",
    false, "nested-1405",
  )
  check_search_case(
    "lsearch -sorted -subindices -index \"0\" {{a x} {b y} {a z}} \"a\"", "0 0",
    "", false, "nested-1406",
  )
  check_search_case(
    "lsearch -sorted -subindices -index \"0\" {{a x} {b y} {a z}} \"z\"", "-1 0",
    "", false, "nested-1407",
  )
  check_search_case(
    "lsearch -sorted -all -subindices -index \"0\" {{a x} {b y} {a z}} \"a\"", "{0 0} {2 0}",
    "", false, "nested-1408",
  )
  check_search_case(
    "lsearch -sorted -all -subindices -index \"0\" {{a x} {b y} {a z}} \"z\"", "",
    "", false, "nested-1409",
  )
  check_search_case(
    "lsearch -sorted -inline -subindices -index \"0\" {{a x} {b y} {a z}} \"a\"",
    "a x", "", false, "nested-1410",
  )
  check_search_case(
    "lsearch -sorted -inline -subindices -index \"0\" {{a x} {b y} {a z}} \"z\"",
    "", "", false, "nested-1411",
  )
  check_search_case(
    "lsearch -sorted -all -inline -subindices -index \"0\" {{a x} {b y} {a z}} \"a\"",
    "a a", "", false, "nested-1412",
  )
  check_search_case(
    "lsearch -sorted -all -inline -subindices -index \"0\" {{a x} {b y} {a z}} \"z\"",
    "", "", false, "nested-1413",
  )
  check_search_case(
    "lsearch -sorted -not -all -subindices -index \"0\" {{a x} {b y} {a z}} \"a\"",
    "{1 0}", "", false, "nested-1414",
  )
  check_search_case(
    "lsearch -sorted -not -all -subindices -index \"0\" {{a x} {b y} {a z}} \"z\"",
    "{0 0} {1 0} {2 0}", "", false, "nested-1415",
  )
  check_search_case(
    "lsearch -sorted -start 1 -subindices -index \"0\" {{a x} {b y} {a z}} \"a\"",
    "-1 0", "", false, "nested-1416",
  )
  check_search_case(
    "lsearch -sorted -start 1 -subindices -index \"0\" {{a x} {b y} {a z}} \"z\"",
    "-1 0", "", false, "nested-1417",
  )
  check_search_case(
    "lsearch -sorted -start 100 -subindices -index \"0\" {{a x} {b y} {a z}} \"a\"",
    "-1", "", false, "nested-1418",
  )
  check_search_case(
    "lsearch -sorted -start 100 -subindices -index \"0\" {{a x} {b y} {a z}} \"z\"",
    "-1", "", false, "nested-1419",
  )
  check_search_case(
    "lsearch -exact  -index \"1\" {{x a} {y b} {z a}} \"a\"", "0", "", false, "nested-1420",
  )
  check_search_case(
    "lsearch -exact  -index \"1\" {{x a} {y b} {z a}} \"z\"", "-1", "", false, "nested-1421",
  )
  check_search_case(
    "lsearch -exact -all -index \"1\" {{x a} {y b} {z a}} \"a\"", "0 2", "", false,
    "nested-1422",
  )
  check_search_case(
    "lsearch -exact -all -index \"1\" {{x a} {y b} {z a}} \"z\"", "", "", false,
    "nested-1423",
  )
  check_search_case(
    "lsearch -exact -inline -index \"1\" {{x a} {y b} {z a}} \"a\"", "x a", "", false,
    "nested-1424",
  )
  check_search_case(
    "lsearch -exact -inline -index \"1\" {{x a} {y b} {z a}} \"z\"", "", "", false,
    "nested-1425",
  )
  check_search_case(
    "lsearch -exact -all -inline -index \"1\" {{x a} {y b} {z a}} \"a\"", "{x a} {z a}",
    "", false, "nested-1426",
  )
  check_search_case(
    "lsearch -exact -all -inline -index \"1\" {{x a} {y b} {z a}} \"z\"", "", "",
    false, "nested-1427",
  )
  check_search_case(
    "lsearch -exact -subindices -index \"1\" {{x a} {y b} {z a}} \"a\"", "0 1", "",
    false, "nested-1428",
  )
  check_search_case(
    "lsearch -exact -subindices -index \"1\" {{x a} {y b} {z a}} \"z\"", "-1 1",
    "", false, "nested-1429",
  )
  check_search_case(
    "lsearch -exact -all -subindices -index \"1\" {{x a} {y b} {z a}} \"a\"", "{0 1} {2 1}",
    "", false, "nested-1430",
  )
  check_search_case(
    "lsearch -exact -all -subindices -index \"1\" {{x a} {y b} {z a}} \"z\"", "",
    "", false, "nested-1431",
  )
  check_search_case(
    "lsearch -exact -inline -subindices -index \"1\" {{x a} {y b} {z a}} \"a\"",
    "x a", "", false, "nested-1432",
  )
  check_search_case(
    "lsearch -exact -inline -subindices -index \"1\" {{x a} {y b} {z a}} \"z\"",
    "", "", false, "nested-1433",
  )
  check_search_case(
    "lsearch -exact -all -inline -subindices -index \"1\" {{x a} {y b} {z a}} \"a\"",
    "a a", "", false, "nested-1434",
  )
  check_search_case(
    "lsearch -exact -all -inline -subindices -index \"1\" {{x a} {y b} {z a}} \"z\"",
    "", "", false, "nested-1435",
  )
  check_search_case(
    "lsearch -exact -not -all -subindices -index \"1\" {{x a} {y b} {z a}} \"a\"",
    "{1 1}", "", false, "nested-1436",
  )
  check_search_case(
    "lsearch -exact -not -all -subindices -index \"1\" {{x a} {y b} {z a}} \"z\"",
    "{0 1} {1 1} {2 1}", "", false, "nested-1437",
  )
  check_search_case(
    "lsearch -exact -start 1 -subindices -index \"1\" {{x a} {y b} {z a}} \"a\"",
    "2 1", "", false, "nested-1438",
  )
  check_search_case(
    "lsearch -exact -start 1 -subindices -index \"1\" {{x a} {y b} {z a}} \"z\"",
    "-1 1", "", false, "nested-1439",
  )
}

///|
test "Tcl search cases 1441 through 1480" {
  check_search_case(
    "lsearch -exact -start 100 -subindices -index \"1\" {{x a} {y b} {z a}} \"a\"",
    "-1", "", false, "nested-1440",
  )
  check_search_case(
    "lsearch -exact -start 100 -subindices -index \"1\" {{x a} {y b} {z a}} \"z\"",
    "-1", "", false, "nested-1441",
  )
  check_search_case(
    "lsearch -glob  -index \"1\" {{x a} {y b} {z a}} \"a\"", "0", "", false, "nested-1442",
  )
  check_search_case(
    "lsearch -glob  -index \"1\" {{x a} {y b} {z a}} \"z\"", "-1", "", false, "nested-1443",
  )
  check_search_case(
    "lsearch -glob -all -index \"1\" {{x a} {y b} {z a}} \"a\"", "0 2", "", false,
    "nested-1444",
  )
  check_search_case(
    "lsearch -glob -all -index \"1\" {{x a} {y b} {z a}} \"z\"", "", "", false, "nested-1445",
  )
  check_search_case(
    "lsearch -glob -inline -index \"1\" {{x a} {y b} {z a}} \"a\"", "x a", "", false,
    "nested-1446",
  )
  check_search_case(
    "lsearch -glob -inline -index \"1\" {{x a} {y b} {z a}} \"z\"", "", "", false,
    "nested-1447",
  )
  check_search_case(
    "lsearch -glob -all -inline -index \"1\" {{x a} {y b} {z a}} \"a\"", "{x a} {z a}",
    "", false, "nested-1448",
  )
  check_search_case(
    "lsearch -glob -all -inline -index \"1\" {{x a} {y b} {z a}} \"z\"", "", "",
    false, "nested-1449",
  )
  check_search_case(
    "lsearch -glob -subindices -index \"1\" {{x a} {y b} {z a}} \"a\"", "0 1", "",
    false, "nested-1450",
  )
  check_search_case(
    "lsearch -glob -subindices -index \"1\" {{x a} {y b} {z a}} \"z\"", "-1 1", "",
    false, "nested-1451",
  )
  check_search_case(
    "lsearch -glob -all -subindices -index \"1\" {{x a} {y b} {z a}} \"a\"", "{0 1} {2 1}",
    "", false, "nested-1452",
  )
  check_search_case(
    "lsearch -glob -all -subindices -index \"1\" {{x a} {y b} {z a}} \"z\"", "",
    "", false, "nested-1453",
  )
  check_search_case(
    "lsearch -glob -inline -subindices -index \"1\" {{x a} {y b} {z a}} \"a\"", "x a",
    "", false, "nested-1454",
  )
  check_search_case(
    "lsearch -glob -inline -subindices -index \"1\" {{x a} {y b} {z a}} \"z\"", "",
    "", false, "nested-1455",
  )
  check_search_case(
    "lsearch -glob -all -inline -subindices -index \"1\" {{x a} {y b} {z a}} \"a\"",
    "a a", "", false, "nested-1456",
  )
  check_search_case(
    "lsearch -glob -all -inline -subindices -index \"1\" {{x a} {y b} {z a}} \"z\"",
    "", "", false, "nested-1457",
  )
  check_search_case(
    "lsearch -glob -not -all -subindices -index \"1\" {{x a} {y b} {z a}} \"a\"",
    "{1 1}", "", false, "nested-1458",
  )
  check_search_case(
    "lsearch -glob -not -all -subindices -index \"1\" {{x a} {y b} {z a}} \"z\"",
    "{0 1} {1 1} {2 1}", "", false, "nested-1459",
  )
  check_search_case(
    "lsearch -glob -start 1 -subindices -index \"1\" {{x a} {y b} {z a}} \"a\"",
    "2 1", "", false, "nested-1460",
  )
  check_search_case(
    "lsearch -glob -start 1 -subindices -index \"1\" {{x a} {y b} {z a}} \"z\"",
    "-1 1", "", false, "nested-1461",
  )
  check_search_case(
    "lsearch -glob -start 100 -subindices -index \"1\" {{x a} {y b} {z a}} \"a\"",
    "-1", "", false, "nested-1462",
  )
  check_search_case(
    "lsearch -glob -start 100 -subindices -index \"1\" {{x a} {y b} {z a}} \"z\"",
    "-1", "", false, "nested-1463",
  )
  check_search_case(
    "lsearch -regexp  -index \"1\" {{x a} {y b} {z a}} \"a\"", "0", "", false, "nested-1464",
  )
  check_search_case(
    "lsearch -regexp  -index \"1\" {{x a} {y b} {z a}} \"z\"", "-1", "", false, "nested-1465",
  )
  check_search_case(
    "lsearch -regexp -all -index \"1\" {{x a} {y b} {z a}} \"a\"", "0 2", "", false,
    "nested-1466",
  )
  check_search_case(
    "lsearch -regexp -all -index \"1\" {{x a} {y b} {z a}} \"z\"", "", "", false,
    "nested-1467",
  )
  check_search_case(
    "lsearch -regexp -inline -index \"1\" {{x a} {y b} {z a}} \"a\"", "x a", "",
    false, "nested-1468",
  )
  check_search_case(
    "lsearch -regexp -inline -index \"1\" {{x a} {y b} {z a}} \"z\"", "", "", false,
    "nested-1469",
  )
  check_search_case(
    "lsearch -regexp -all -inline -index \"1\" {{x a} {y b} {z a}} \"a\"", "{x a} {z a}",
    "", false, "nested-1470",
  )
  check_search_case(
    "lsearch -regexp -all -inline -index \"1\" {{x a} {y b} {z a}} \"z\"", "", "",
    false, "nested-1471",
  )
  check_search_case(
    "lsearch -regexp -subindices -index \"1\" {{x a} {y b} {z a}} \"a\"", "0 1",
    "", false, "nested-1472",
  )
  check_search_case(
    "lsearch -regexp -subindices -index \"1\" {{x a} {y b} {z a}} \"z\"", "-1 1",
    "", false, "nested-1473",
  )
  check_search_case(
    "lsearch -regexp -all -subindices -index \"1\" {{x a} {y b} {z a}} \"a\"", "{0 1} {2 1}",
    "", false, "nested-1474",
  )
  check_search_case(
    "lsearch -regexp -all -subindices -index \"1\" {{x a} {y b} {z a}} \"z\"", "",
    "", false, "nested-1475",
  )
  check_search_case(
    "lsearch -regexp -inline -subindices -index \"1\" {{x a} {y b} {z a}} \"a\"",
    "x a", "", false, "nested-1476",
  )
  check_search_case(
    "lsearch -regexp -inline -subindices -index \"1\" {{x a} {y b} {z a}} \"z\"",
    "", "", false, "nested-1477",
  )
  check_search_case(
    "lsearch -regexp -all -inline -subindices -index \"1\" {{x a} {y b} {z a}} \"a\"",
    "a a", "", false, "nested-1478",
  )
  check_search_case(
    "lsearch -regexp -all -inline -subindices -index \"1\" {{x a} {y b} {z a}} \"z\"",
    "", "", false, "nested-1479",
  )
}

///|
test "Tcl search cases 1481 through 1520" {
  check_search_case(
    "lsearch -regexp -not -all -subindices -index \"1\" {{x a} {y b} {z a}} \"a\"",
    "{1 1}", "", false, "nested-1480",
  )
  check_search_case(
    "lsearch -regexp -not -all -subindices -index \"1\" {{x a} {y b} {z a}} \"z\"",
    "{0 1} {1 1} {2 1}", "", false, "nested-1481",
  )
  check_search_case(
    "lsearch -regexp -start 1 -subindices -index \"1\" {{x a} {y b} {z a}} \"a\"",
    "2 1", "", false, "nested-1482",
  )
  check_search_case(
    "lsearch -regexp -start 1 -subindices -index \"1\" {{x a} {y b} {z a}} \"z\"",
    "-1 1", "", false, "nested-1483",
  )
  check_search_case(
    "lsearch -regexp -start 100 -subindices -index \"1\" {{x a} {y b} {z a}} \"a\"",
    "-1", "", false, "nested-1484",
  )
  check_search_case(
    "lsearch -regexp -start 100 -subindices -index \"1\" {{x a} {y b} {z a}} \"z\"",
    "-1", "", false, "nested-1485",
  )
  check_search_case(
    "lsearch -sorted  -index \"1\" {{x a} {y b} {z a}} \"a\"", "0", "", false, "nested-1486",
  )
  check_search_case(
    "lsearch -sorted  -index \"1\" {{x a} {y b} {z a}} \"z\"", "-1", "", false, "nested-1487",
  )
  check_search_case(
    "lsearch -sorted -all -index \"1\" {{x a} {y b} {z a}} \"a\"", "0 2", "", false,
    "nested-1488",
  )
  check_search_case(
    "lsearch -sorted -all -index \"1\" {{x a} {y b} {z a}} \"z\"", "", "", false,
    "nested-1489",
  )
  check_search_case(
    "lsearch -sorted -inline -index \"1\" {{x a} {y b} {z a}} \"a\"", "x a", "",
    false, "nested-1490",
  )
  check_search_case(
    "lsearch -sorted -inline -index \"1\" {{x a} {y b} {z a}} \"z\"", "", "", false,
    "nested-1491",
  )
  check_search_case(
    "lsearch -sorted -all -inline -index \"1\" {{x a} {y b} {z a}} \"a\"", "{x a} {z a}",
    "", false, "nested-1492",
  )
  check_search_case(
    "lsearch -sorted -all -inline -index \"1\" {{x a} {y b} {z a}} \"z\"", "", "",
    false, "nested-1493",
  )
  check_search_case(
    "lsearch -sorted -subindices -index \"1\" {{x a} {y b} {z a}} \"a\"", "0 1",
    "", false, "nested-1494",
  )
  check_search_case(
    "lsearch -sorted -subindices -index \"1\" {{x a} {y b} {z a}} \"z\"", "-1 1",
    "", false, "nested-1495",
  )
  check_search_case(
    "lsearch -sorted -all -subindices -index \"1\" {{x a} {y b} {z a}} \"a\"", "{0 1} {2 1}",
    "", false, "nested-1496",
  )
  check_search_case(
    "lsearch -sorted -all -subindices -index \"1\" {{x a} {y b} {z a}} \"z\"", "",
    "", false, "nested-1497",
  )
  check_search_case(
    "lsearch -sorted -inline -subindices -index \"1\" {{x a} {y b} {z a}} \"a\"",
    "x a", "", false, "nested-1498",
  )
  check_search_case(
    "lsearch -sorted -inline -subindices -index \"1\" {{x a} {y b} {z a}} \"z\"",
    "", "", false, "nested-1499",
  )
  check_search_case(
    "lsearch -sorted -all -inline -subindices -index \"1\" {{x a} {y b} {z a}} \"a\"",
    "a a", "", false, "nested-1500",
  )
  check_search_case(
    "lsearch -sorted -all -inline -subindices -index \"1\" {{x a} {y b} {z a}} \"z\"",
    "", "", false, "nested-1501",
  )
  check_search_case(
    "lsearch -sorted -not -all -subindices -index \"1\" {{x a} {y b} {z a}} \"a\"",
    "{1 1}", "", false, "nested-1502",
  )
  check_search_case(
    "lsearch -sorted -not -all -subindices -index \"1\" {{x a} {y b} {z a}} \"z\"",
    "{0 1} {1 1} {2 1}", "", false, "nested-1503",
  )
  check_search_case(
    "lsearch -sorted -start 1 -subindices -index \"1\" {{x a} {y b} {z a}} \"a\"",
    "-1 1", "", false, "nested-1504",
  )
  check_search_case(
    "lsearch -sorted -start 1 -subindices -index \"1\" {{x a} {y b} {z a}} \"z\"",
    "-1 1", "", false, "nested-1505",
  )
  check_search_case(
    "lsearch -sorted -start 100 -subindices -index \"1\" {{x a} {y b} {z a}} \"a\"",
    "-1", "", false, "nested-1506",
  )
  check_search_case(
    "lsearch -sorted -start 100 -subindices -index \"1\" {{x a} {y b} {z a}} \"z\"",
    "-1", "", false, "nested-1507",
  )
  check_search_case(
    "lsearch -exact  -index \"end\" {{x a} {y z a} {b}} \"a\"", "0", "", false, "nested-1508",
  )
  check_search_case(
    "lsearch -exact  -index \"end\" {{x a} {y z a} {b}} \"z\"", "-1", "", false,
    "nested-1509",
  )
  check_search_case(
    "lsearch -exact -all -index \"end\" {{x a} {y z a} {b}} \"a\"", "0 1", "", false,
    "nested-1510",
  )
  check_search_case(
    "lsearch -exact -all -index \"end\" {{x a} {y z a} {b}} \"z\"", "", "", false,
    "nested-1511",
  )
  check_search_case(
    "lsearch -exact -inline -index \"end\" {{x a} {y z a} {b}} \"a\"", "x a", "",
    false, "nested-1512",
  )
  check_search_case(
    "lsearch -exact -inline -index \"end\" {{x a} {y z a} {b}} \"z\"", "", "", false,
    "nested-1513",
  )
  check_search_case(
    "lsearch -exact -all -inline -index \"end\" {{x a} {y z a} {b}} \"a\"", "{x a} {y z a}",
    "", false, "nested-1514",
  )
  check_search_case(
    "lsearch -exact -all -inline -index \"end\" {{x a} {y z a} {b}} \"z\"", "", "",
    false, "nested-1515",
  )
  check_search_case(
    "lsearch -exact -subindices -index \"end\" {{x a} {y z a} {b}} \"a\"", "0 3",
    "", false, "nested-1516",
  )
  check_search_case(
    "lsearch -exact -subindices -index \"end\" {{x a} {y z a} {b}} \"z\"", "-1 3",
    "", false, "nested-1517",
  )
  check_search_case(
    "lsearch -exact -all -subindices -index \"end\" {{x a} {y z a} {b}} \"a\"", "{0 3} {1 3}",
    "", false, "nested-1518",
  )
  check_search_case(
    "lsearch -exact -all -subindices -index \"end\" {{x a} {y z a} {b}} \"z\"", "",
    "", false, "nested-1519",
  )
}

///|
test "Tcl search cases 1521 through 1560" {
  check_search_case(
    "lsearch -exact -inline -subindices -index \"end\" {{x a} {y z a} {b}} \"a\"",
    "x a", "", false, "nested-1520",
  )
  check_search_case(
    "lsearch -exact -inline -subindices -index \"end\" {{x a} {y z a} {b}} \"z\"",
    "", "", false, "nested-1521",
  )
  check_search_case(
    "lsearch -exact -all -inline -subindices -index \"end\" {{x a} {y z a} {b}} \"a\"",
    "a a", "", false, "nested-1522",
  )
  check_search_case(
    "lsearch -exact -all -inline -subindices -index \"end\" {{x a} {y z a} {b}} \"z\"",
    "", "", false, "nested-1523",
  )
  check_search_case(
    "lsearch -exact -not -all -subindices -index \"end\" {{x a} {y z a} {b}} \"a\"",
    "{2 3}", "", false, "nested-1524",
  )
  check_search_case(
    "lsearch -exact -not -all -subindices -index \"end\" {{x a} {y z a} {b}} \"z\"",
    "{0 3} {1 3} {2 3}", "", false, "nested-1525",
  )
  check_search_case(
    "lsearch -exact -start 1 -subindices -index \"end\" {{x a} {y z a} {b}} \"a\"",
    "1 3", "", false, "nested-1526",
  )
  check_search_case(
    "lsearch -exact -start 1 -subindices -index \"end\" {{x a} {y z a} {b}} \"z\"",
    "-1 3", "", false, "nested-1527",
  )
  check_search_case(
    "lsearch -exact -start 100 -subindices -index \"end\" {{x a} {y z a} {b}} \"a\"",
    "-1", "", false, "nested-1528",
  )
  check_search_case(
    "lsearch -exact -start 100 -subindices -index \"end\" {{x a} {y z a} {b}} \"z\"",
    "-1", "", false, "nested-1529",
  )
  check_search_case(
    "lsearch -glob  -index \"end\" {{x a} {y z a} {b}} \"a\"", "0", "", false, "nested-1530",
  )
  check_search_case(
    "lsearch -glob  -index \"end\" {{x a} {y z a} {b}} \"z\"", "-1", "", false, "nested-1531",
  )
  check_search_case(
    "lsearch -glob -all -index \"end\" {{x a} {y z a} {b}} \"a\"", "0 1", "", false,
    "nested-1532",
  )
  check_search_case(
    "lsearch -glob -all -index \"end\" {{x a} {y z a} {b}} \"z\"", "", "", false,
    "nested-1533",
  )
  check_search_case(
    "lsearch -glob -inline -index \"end\" {{x a} {y z a} {b}} \"a\"", "x a", "",
    false, "nested-1534",
  )
  check_search_case(
    "lsearch -glob -inline -index \"end\" {{x a} {y z a} {b}} \"z\"", "", "", false,
    "nested-1535",
  )
  check_search_case(
    "lsearch -glob -all -inline -index \"end\" {{x a} {y z a} {b}} \"a\"", "{x a} {y z a}",
    "", false, "nested-1536",
  )
  check_search_case(
    "lsearch -glob -all -inline -index \"end\" {{x a} {y z a} {b}} \"z\"", "", "",
    false, "nested-1537",
  )
  check_search_case(
    "lsearch -glob -subindices -index \"end\" {{x a} {y z a} {b}} \"a\"", "0 3",
    "", false, "nested-1538",
  )
  check_search_case(
    "lsearch -glob -subindices -index \"end\" {{x a} {y z a} {b}} \"z\"", "-1 3",
    "", false, "nested-1539",
  )
  check_search_case(
    "lsearch -glob -all -subindices -index \"end\" {{x a} {y z a} {b}} \"a\"", "{0 3} {1 3}",
    "", false, "nested-1540",
  )
  check_search_case(
    "lsearch -glob -all -subindices -index \"end\" {{x a} {y z a} {b}} \"z\"", "",
    "", false, "nested-1541",
  )
  check_search_case(
    "lsearch -glob -inline -subindices -index \"end\" {{x a} {y z a} {b}} \"a\"",
    "x a", "", false, "nested-1542",
  )
  check_search_case(
    "lsearch -glob -inline -subindices -index \"end\" {{x a} {y z a} {b}} \"z\"",
    "", "", false, "nested-1543",
  )
  check_search_case(
    "lsearch -glob -all -inline -subindices -index \"end\" {{x a} {y z a} {b}} \"a\"",
    "a a", "", false, "nested-1544",
  )
  check_search_case(
    "lsearch -glob -all -inline -subindices -index \"end\" {{x a} {y z a} {b}} \"z\"",
    "", "", false, "nested-1545",
  )
  check_search_case(
    "lsearch -glob -not -all -subindices -index \"end\" {{x a} {y z a} {b}} \"a\"",
    "{2 3}", "", false, "nested-1546",
  )
  check_search_case(
    "lsearch -glob -not -all -subindices -index \"end\" {{x a} {y z a} {b}} \"z\"",
    "{0 3} {1 3} {2 3}", "", false, "nested-1547",
  )
  check_search_case(
    "lsearch -glob -start 1 -subindices -index \"end\" {{x a} {y z a} {b}} \"a\"",
    "1 3", "", false, "nested-1548",
  )
  check_search_case(
    "lsearch -glob -start 1 -subindices -index \"end\" {{x a} {y z a} {b}} \"z\"",
    "-1 3", "", false, "nested-1549",
  )
  check_search_case(
    "lsearch -glob -start 100 -subindices -index \"end\" {{x a} {y z a} {b}} \"a\"",
    "-1", "", false, "nested-1550",
  )
  check_search_case(
    "lsearch -glob -start 100 -subindices -index \"end\" {{x a} {y z a} {b}} \"z\"",
    "-1", "", false, "nested-1551",
  )
  check_search_case(
    "lsearch -regexp  -index \"end\" {{x a} {y z a} {b}} \"a\"", "0", "", false,
    "nested-1552",
  )
  check_search_case(
    "lsearch -regexp  -index \"end\" {{x a} {y z a} {b}} \"z\"", "-1", "", false,
    "nested-1553",
  )
  check_search_case(
    "lsearch -regexp -all -index \"end\" {{x a} {y z a} {b}} \"a\"", "0 1", "", false,
    "nested-1554",
  )
  check_search_case(
    "lsearch -regexp -all -index \"end\" {{x a} {y z a} {b}} \"z\"", "", "", false,
    "nested-1555",
  )
  check_search_case(
    "lsearch -regexp -inline -index \"end\" {{x a} {y z a} {b}} \"a\"", "x a", "",
    false, "nested-1556",
  )
  check_search_case(
    "lsearch -regexp -inline -index \"end\" {{x a} {y z a} {b}} \"z\"", "", "", false,
    "nested-1557",
  )
  check_search_case(
    "lsearch -regexp -all -inline -index \"end\" {{x a} {y z a} {b}} \"a\"", "{x a} {y z a}",
    "", false, "nested-1558",
  )
  check_search_case(
    "lsearch -regexp -all -inline -index \"end\" {{x a} {y z a} {b}} \"z\"", "",
    "", false, "nested-1559",
  )
}

///|
test "Tcl search cases 1561 through 1600" {
  check_search_case(
    "lsearch -regexp -subindices -index \"end\" {{x a} {y z a} {b}} \"a\"", "0 3",
    "", false, "nested-1560",
  )
  check_search_case(
    "lsearch -regexp -subindices -index \"end\" {{x a} {y z a} {b}} \"z\"", "-1 3",
    "", false, "nested-1561",
  )
  check_search_case(
    "lsearch -regexp -all -subindices -index \"end\" {{x a} {y z a} {b}} \"a\"",
    "{0 3} {1 3}", "", false, "nested-1562",
  )
  check_search_case(
    "lsearch -regexp -all -subindices -index \"end\" {{x a} {y z a} {b}} \"z\"",
    "", "", false, "nested-1563",
  )
  check_search_case(
    "lsearch -regexp -inline -subindices -index \"end\" {{x a} {y z a} {b}} \"a\"",
    "x a", "", false, "nested-1564",
  )
  check_search_case(
    "lsearch -regexp -inline -subindices -index \"end\" {{x a} {y z a} {b}} \"z\"",
    "", "", false, "nested-1565",
  )
  check_search_case(
    "lsearch -regexp -all -inline -subindices -index \"end\" {{x a} {y z a} {b}} \"a\"",
    "a a", "", false, "nested-1566",
  )
  check_search_case(
    "lsearch -regexp -all -inline -subindices -index \"end\" {{x a} {y z a} {b}} \"z\"",
    "", "", false, "nested-1567",
  )
  check_search_case(
    "lsearch -regexp -not -all -subindices -index \"end\" {{x a} {y z a} {b}} \"a\"",
    "{2 3}", "", false, "nested-1568",
  )
  check_search_case(
    "lsearch -regexp -not -all -subindices -index \"end\" {{x a} {y z a} {b}} \"z\"",
    "{0 3} {1 3} {2 3}", "", false, "nested-1569",
  )
  check_search_case(
    "lsearch -regexp -start 1 -subindices -index \"end\" {{x a} {y z a} {b}} \"a\"",
    "1 3", "", false, "nested-1570",
  )
  check_search_case(
    "lsearch -regexp -start 1 -subindices -index \"end\" {{x a} {y z a} {b}} \"z\"",
    "-1 3", "", false, "nested-1571",
  )
  check_search_case(
    "lsearch -regexp -start 100 -subindices -index \"end\" {{x a} {y z a} {b}} \"a\"",
    "-1", "", false, "nested-1572",
  )
  check_search_case(
    "lsearch -regexp -start 100 -subindices -index \"end\" {{x a} {y z a} {b}} \"z\"",
    "-1", "", false, "nested-1573",
  )
  check_search_case(
    "lsearch -sorted  -index \"end\" {{x a} {y z a} {b}} \"a\"", "0", "", false,
    "nested-1574",
  )
  check_search_case(
    "lsearch -sorted  -index \"end\" {{x a} {y z a} {b}} \"z\"", "-1", "", false,
    "nested-1575",
  )
  check_search_case(
    "lsearch -sorted -all -index \"end\" {{x a} {y z a} {b}} \"a\"", "0 1", "", false,
    "nested-1576",
  )
  check_search_case(
    "lsearch -sorted -all -index \"end\" {{x a} {y z a} {b}} \"z\"", "", "", false,
    "nested-1577",
  )
  check_search_case(
    "lsearch -sorted -inline -index \"end\" {{x a} {y z a} {b}} \"a\"", "x a", "",
    false, "nested-1578",
  )
  check_search_case(
    "lsearch -sorted -inline -index \"end\" {{x a} {y z a} {b}} \"z\"", "", "", false,
    "nested-1579",
  )
  check_search_case(
    "lsearch -sorted -all -inline -index \"end\" {{x a} {y z a} {b}} \"a\"", "{x a} {y z a}",
    "", false, "nested-1580",
  )
  check_search_case(
    "lsearch -sorted -all -inline -index \"end\" {{x a} {y z a} {b}} \"z\"", "",
    "", false, "nested-1581",
  )
  check_search_case(
    "lsearch -sorted -subindices -index \"end\" {{x a} {y z a} {b}} \"a\"", "0 3",
    "", false, "nested-1582",
  )
  check_search_case(
    "lsearch -sorted -subindices -index \"end\" {{x a} {y z a} {b}} \"z\"", "-1 3",
    "", false, "nested-1583",
  )
  check_search_case(
    "lsearch -sorted -all -subindices -index \"end\" {{x a} {y z a} {b}} \"a\"",
    "{0 3} {1 3}", "", false, "nested-1584",
  )
  check_search_case(
    "lsearch -sorted -all -subindices -index \"end\" {{x a} {y z a} {b}} \"z\"",
    "", "", false, "nested-1585",
  )
  check_search_case(
    "lsearch -sorted -inline -subindices -index \"end\" {{x a} {y z a} {b}} \"a\"",
    "x a", "", false, "nested-1586",
  )
  check_search_case(
    "lsearch -sorted -inline -subindices -index \"end\" {{x a} {y z a} {b}} \"z\"",
    "", "", false, "nested-1587",
  )
  check_search_case(
    "lsearch -sorted -all -inline -subindices -index \"end\" {{x a} {y z a} {b}} \"a\"",
    "a a", "", false, "nested-1588",
  )
  check_search_case(
    "lsearch -sorted -all -inline -subindices -index \"end\" {{x a} {y z a} {b}} \"z\"",
    "", "", false, "nested-1589",
  )
  check_search_case(
    "lsearch -sorted -not -all -subindices -index \"end\" {{x a} {y z a} {b}} \"a\"",
    "{2 3}", "", false, "nested-1590",
  )
  check_search_case(
    "lsearch -sorted -not -all -subindices -index \"end\" {{x a} {y z a} {b}} \"z\"",
    "{0 3} {1 3} {2 3}", "", false, "nested-1591",
  )
  check_search_case(
    "lsearch -sorted -start 1 -subindices -index \"end\" {{x a} {y z a} {b}} \"a\"",
    "1 3", "", false, "nested-1592",
  )
  check_search_case(
    "lsearch -sorted -start 1 -subindices -index \"end\" {{x a} {y z a} {b}} \"z\"",
    "-1 3", "", false, "nested-1593",
  )
  check_search_case(
    "lsearch -sorted -start 100 -subindices -index \"end\" {{x a} {y z a} {b}} \"a\"",
    "-1", "", false, "nested-1594",
  )
  check_search_case(
    "lsearch -sorted -start 100 -subindices -index \"end\" {{x a} {y z a} {b}} \"z\"",
    "-1", "", false, "nested-1595",
  )
  check_search_case(
    "lsearch -exact  -index \"end-1\" {{a x} {y a z} {b x}} \"a\"", "0", "", false,
    "nested-1596",
  )
  check_search_case(
    "lsearch -exact  -index \"end-1\" {{a x} {y a z} {b x}} \"z\"", "-1", "", false,
    "nested-1597",
  )
  check_search_case(
    "lsearch -exact -all -index \"end-1\" {{a x} {y a z} {b x}} \"a\"", "0 1", "",
    false, "nested-1598",
  )
  check_search_case(
    "lsearch -exact -all -index \"end-1\" {{a x} {y a z} {b x}} \"z\"", "", "", false,
    "nested-1599",
  )
}

///|
test "Tcl search cases 1601 through 1640" {
  check_search_case(
    "lsearch -exact -inline -index \"end-1\" {{a x} {y a z} {b x}} \"a\"", "a x",
    "", false, "nested-1600",
  )
  check_search_case(
    "lsearch -exact -inline -index \"end-1\" {{a x} {y a z} {b x}} \"z\"", "", "",
    false, "nested-1601",
  )
  check_search_case(
    "lsearch -exact -all -inline -index \"end-1\" {{a x} {y a z} {b x}} \"a\"", "{a x} {y a z}",
    "", false, "nested-1602",
  )
  check_search_case(
    "lsearch -exact -all -inline -index \"end-1\" {{a x} {y a z} {b x}} \"z\"", "",
    "", false, "nested-1603",
  )
  check_search_case(
    "lsearch -exact -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"a\"", "0 2",
    "", false, "nested-1604",
  )
  check_search_case(
    "lsearch -exact -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"z\"", "-1 2",
    "", false, "nested-1605",
  )
  check_search_case(
    "lsearch -exact -all -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"a\"",
    "{0 2} {1 2}", "", false, "nested-1606",
  )
  check_search_case(
    "lsearch -exact -all -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"z\"",
    "", "", false, "nested-1607",
  )
  check_search_case(
    "lsearch -exact -inline -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"a\"",
    "a x", "", false, "nested-1608",
  )
  check_search_case(
    "lsearch -exact -inline -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"z\"",
    "", "", false, "nested-1609",
  )
  check_search_case(
    "lsearch -exact -all -inline -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"a\"",
    "a a", "", false, "nested-1610",
  )
  check_search_case(
    "lsearch -exact -all -inline -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"z\"",
    "", "", false, "nested-1611",
  )
  check_search_case(
    "lsearch -exact -not -all -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"a\"",
    "{2 2}", "", false, "nested-1612",
  )
  check_search_case(
    "lsearch -exact -not -all -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"z\"",
    "{0 2} {1 2} {2 2}", "", false, "nested-1613",
  )
  check_search_case(
    "lsearch -exact -start 1 -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"a\"",
    "1 2", "", false, "nested-1614",
  )
  check_search_case(
    "lsearch -exact -start 1 -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"z\"",
    "-1 2", "", false, "nested-1615",
  )
  check_search_case(
    "lsearch -exact -start 100 -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"a\"",
    "-1", "", false, "nested-1616",
  )
  check_search_case(
    "lsearch -exact -start 100 -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"z\"",
    "-1", "", false, "nested-1617",
  )
  check_search_case(
    "lsearch -glob  -index \"end-1\" {{a x} {y a z} {b x}} \"a\"", "0", "", false,
    "nested-1618",
  )
  check_search_case(
    "lsearch -glob  -index \"end-1\" {{a x} {y a z} {b x}} \"z\"", "-1", "", false,
    "nested-1619",
  )
  check_search_case(
    "lsearch -glob -all -index \"end-1\" {{a x} {y a z} {b x}} \"a\"", "0 1", "",
    false, "nested-1620",
  )
  check_search_case(
    "lsearch -glob -all -index \"end-1\" {{a x} {y a z} {b x}} \"z\"", "", "", false,
    "nested-1621",
  )
  check_search_case(
    "lsearch -glob -inline -index \"end-1\" {{a x} {y a z} {b x}} \"a\"", "a x",
    "", false, "nested-1622",
  )
  check_search_case(
    "lsearch -glob -inline -index \"end-1\" {{a x} {y a z} {b x}} \"z\"", "", "",
    false, "nested-1623",
  )
  check_search_case(
    "lsearch -glob -all -inline -index \"end-1\" {{a x} {y a z} {b x}} \"a\"", "{a x} {y a z}",
    "", false, "nested-1624",
  )
  check_search_case(
    "lsearch -glob -all -inline -index \"end-1\" {{a x} {y a z} {b x}} \"z\"", "",
    "", false, "nested-1625",
  )
  check_search_case(
    "lsearch -glob -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"a\"", "0 2",
    "", false, "nested-1626",
  )
  check_search_case(
    "lsearch -glob -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"z\"", "-1 2",
    "", false, "nested-1627",
  )
  check_search_case(
    "lsearch -glob -all -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"a\"",
    "{0 2} {1 2}", "", false, "nested-1628",
  )
  check_search_case(
    "lsearch -glob -all -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"z\"",
    "", "", false, "nested-1629",
  )
  check_search_case(
    "lsearch -glob -inline -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"a\"",
    "a x", "", false, "nested-1630",
  )
  check_search_case(
    "lsearch -glob -inline -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"z\"",
    "", "", false, "nested-1631",
  )
  check_search_case(
    "lsearch -glob -all -inline -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"a\"",
    "a a", "", false, "nested-1632",
  )
  check_search_case(
    "lsearch -glob -all -inline -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"z\"",
    "", "", false, "nested-1633",
  )
  check_search_case(
    "lsearch -glob -not -all -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"a\"",
    "{2 2}", "", false, "nested-1634",
  )
  check_search_case(
    "lsearch -glob -not -all -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"z\"",
    "{0 2} {1 2} {2 2}", "", false, "nested-1635",
  )
  check_search_case(
    "lsearch -glob -start 1 -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"a\"",
    "1 2", "", false, "nested-1636",
  )
  check_search_case(
    "lsearch -glob -start 1 -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"z\"",
    "-1 2", "", false, "nested-1637",
  )
  check_search_case(
    "lsearch -glob -start 100 -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"a\"",
    "-1", "", false, "nested-1638",
  )
  check_search_case(
    "lsearch -glob -start 100 -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"z\"",
    "-1", "", false, "nested-1639",
  )
}

///|
test "Tcl search cases 1641 through 1680" {
  check_search_case(
    "lsearch -regexp  -index \"end-1\" {{a x} {y a z} {b x}} \"a\"", "0", "", false,
    "nested-1640",
  )
  check_search_case(
    "lsearch -regexp  -index \"end-1\" {{a x} {y a z} {b x}} \"z\"", "-1", "", false,
    "nested-1641",
  )
  check_search_case(
    "lsearch -regexp -all -index \"end-1\" {{a x} {y a z} {b x}} \"a\"", "0 1", "",
    false, "nested-1642",
  )
  check_search_case(
    "lsearch -regexp -all -index \"end-1\" {{a x} {y a z} {b x}} \"z\"", "", "",
    false, "nested-1643",
  )
  check_search_case(
    "lsearch -regexp -inline -index \"end-1\" {{a x} {y a z} {b x}} \"a\"", "a x",
    "", false, "nested-1644",
  )
  check_search_case(
    "lsearch -regexp -inline -index \"end-1\" {{a x} {y a z} {b x}} \"z\"", "", "",
    false, "nested-1645",
  )
  check_search_case(
    "lsearch -regexp -all -inline -index \"end-1\" {{a x} {y a z} {b x}} \"a\"",
    "{a x} {y a z}", "", false, "nested-1646",
  )
  check_search_case(
    "lsearch -regexp -all -inline -index \"end-1\" {{a x} {y a z} {b x}} \"z\"",
    "", "", false, "nested-1647",
  )
  check_search_case(
    "lsearch -regexp -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"a\"", "0 2",
    "", false, "nested-1648",
  )
  check_search_case(
    "lsearch -regexp -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"z\"", "-1 2",
    "", false, "nested-1649",
  )
  check_search_case(
    "lsearch -regexp -all -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"a\"",
    "{0 2} {1 2}", "", false, "nested-1650",
  )
  check_search_case(
    "lsearch -regexp -all -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"z\"",
    "", "", false, "nested-1651",
  )
  check_search_case(
    "lsearch -regexp -inline -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"a\"",
    "a x", "", false, "nested-1652",
  )
  check_search_case(
    "lsearch -regexp -inline -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"z\"",
    "", "", false, "nested-1653",
  )
  check_search_case(
    "lsearch -regexp -all -inline -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"a\"",
    "a a", "", false, "nested-1654",
  )
  check_search_case(
    "lsearch -regexp -all -inline -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"z\"",
    "", "", false, "nested-1655",
  )
  check_search_case(
    "lsearch -regexp -not -all -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"a\"",
    "{2 2}", "", false, "nested-1656",
  )
  check_search_case(
    "lsearch -regexp -not -all -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"z\"",
    "{0 2} {1 2} {2 2}", "", false, "nested-1657",
  )
  check_search_case(
    "lsearch -regexp -start 1 -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"a\"",
    "1 2", "", false, "nested-1658",
  )
  check_search_case(
    "lsearch -regexp -start 1 -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"z\"",
    "-1 2", "", false, "nested-1659",
  )
  check_search_case(
    "lsearch -regexp -start 100 -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"a\"",
    "-1", "", false, "nested-1660",
  )
  check_search_case(
    "lsearch -regexp -start 100 -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"z\"",
    "-1", "", false, "nested-1661",
  )
  check_search_case(
    "lsearch -sorted  -index \"end-1\" {{a x} {y a z} {b x}} \"a\"", "0", "", false,
    "nested-1662",
  )
  check_search_case(
    "lsearch -sorted  -index \"end-1\" {{a x} {y a z} {b x}} \"z\"", "-1", "", false,
    "nested-1663",
  )
  check_search_case(
    "lsearch -sorted -all -index \"end-1\" {{a x} {y a z} {b x}} \"a\"", "0 1", "",
    false, "nested-1664",
  )
  check_search_case(
    "lsearch -sorted -all -index \"end-1\" {{a x} {y a z} {b x}} \"z\"", "", "",
    false, "nested-1665",
  )
  check_search_case(
    "lsearch -sorted -inline -index \"end-1\" {{a x} {y a z} {b x}} \"a\"", "a x",
    "", false, "nested-1666",
  )
  check_search_case(
    "lsearch -sorted -inline -index \"end-1\" {{a x} {y a z} {b x}} \"z\"", "", "",
    false, "nested-1667",
  )
  check_search_case(
    "lsearch -sorted -all -inline -index \"end-1\" {{a x} {y a z} {b x}} \"a\"",
    "{a x} {y a z}", "", false, "nested-1668",
  )
  check_search_case(
    "lsearch -sorted -all -inline -index \"end-1\" {{a x} {y a z} {b x}} \"z\"",
    "", "", false, "nested-1669",
  )
  check_search_case(
    "lsearch -sorted -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"a\"", "0 2",
    "", false, "nested-1670",
  )
  check_search_case(
    "lsearch -sorted -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"z\"", "-1 2",
    "", false, "nested-1671",
  )
  check_search_case(
    "lsearch -sorted -all -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"a\"",
    "{0 2} {1 2}", "", false, "nested-1672",
  )
  check_search_case(
    "lsearch -sorted -all -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"z\"",
    "", "", false, "nested-1673",
  )
  check_search_case(
    "lsearch -sorted -inline -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"a\"",
    "a x", "", false, "nested-1674",
  )
  check_search_case(
    "lsearch -sorted -inline -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"z\"",
    "", "", false, "nested-1675",
  )
  check_search_case(
    "lsearch -sorted -all -inline -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"a\"",
    "a a", "", false, "nested-1676",
  )
  check_search_case(
    "lsearch -sorted -all -inline -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"z\"",
    "", "", false, "nested-1677",
  )
  check_search_case(
    "lsearch -sorted -not -all -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"a\"",
    "{2 2}", "", false, "nested-1678",
  )
  check_search_case(
    "lsearch -sorted -not -all -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"z\"",
    "{0 2} {1 2} {2 2}", "", false, "nested-1679",
  )
}

///|
test "Tcl search cases 1681 through 1720" {
  check_search_case(
    "lsearch -sorted -start 1 -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"a\"",
    "1 2", "", false, "nested-1680",
  )
  check_search_case(
    "lsearch -sorted -start 1 -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"z\"",
    "-1 2", "", false, "nested-1681",
  )
  check_search_case(
    "lsearch -sorted -start 100 -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"a\"",
    "-1", "", false, "nested-1682",
  )
  check_search_case(
    "lsearch -sorted -start 100 -subindices -index \"end-1\" {{a x} {y a z} {b x}} \"z\"",
    "-1", "", false, "nested-1683",
  )
  check_search_case(
    "lsearch -exact  -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"", "0",
    "", false, "nested-1684",
  )
  check_search_case(
    "lsearch -exact  -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"", "-1",
    "", false, "nested-1685",
  )
  check_search_case(
    "lsearch -exact -all -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"", "0 2",
    "", false, "nested-1686",
  )
  check_search_case(
    "lsearch -exact -all -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"", "",
    "", false, "nested-1687",
  )
  check_search_case(
    "lsearch -exact -inline -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"",
    "{x a} b", "", false, "nested-1688",
  )
  check_search_case(
    "lsearch -exact -inline -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"",
    "", "", false, "nested-1689",
  )
  check_search_case(
    "lsearch -exact -all -inline -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"",
    "{{x a} b} {{a} d}", "", false, "nested-1690",
  )
  check_search_case(
    "lsearch -exact -all -inline -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"",
    "", "", false, "nested-1691",
  )
  check_search_case(
    "lsearch -exact -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"",
    "0 0 3", "", false, "nested-1692",
  )
  check_search_case(
    "lsearch -exact -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"",
    "-1 0 3", "", false, "nested-1693",
  )
  check_search_case(
    "lsearch -exact -all -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"",
    "{0 0 3} {2 0 3}", "", false, "nested-1694",
  )
  check_search_case(
    "lsearch -exact -all -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"",
    "", "", false, "nested-1695",
  )
  check_search_case(
    "lsearch -exact -inline -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"",
    "{x a} b", "", false, "nested-1696",
  )
  check_search_case(
    "lsearch -exact -inline -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"",
    "", "", false, "nested-1697",
  )
  check_search_case(
    "lsearch -exact -all -inline -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"",
    "a a", "", false, "nested-1698",
  )
  check_search_case(
    "lsearch -exact -all -inline -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"",
    "", "", false, "nested-1699",
  )
  check_search_case(
    "lsearch -exact -not -all -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"",
    "{1 0 3}", "", false, "nested-1700",
  )
  check_search_case(
    "lsearch -exact -not -all -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"",
    "{0 0 3} {1 0 3} {2 0 3}", "", false, "nested-1701",
  )
  check_search_case(
    "lsearch -exact -start 1 -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"",
    "2 0 3", "", false, "nested-1702",
  )
  check_search_case(
    "lsearch -exact -start 1 -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"",
    "-1 0 3", "", false, "nested-1703",
  )
  check_search_case(
    "lsearch -exact -start 100 -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"",
    "-1", "", false, "nested-1704",
  )
  check_search_case(
    "lsearch -exact -start 100 -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"",
    "-1", "", false, "nested-1705",
  )
  check_search_case(
    "lsearch -glob  -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"", "0", "",
    false, "nested-1706",
  )
  check_search_case(
    "lsearch -glob  -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"", "-1",
    "", false, "nested-1707",
  )
  check_search_case(
    "lsearch -glob -all -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"", "0 2",
    "", false, "nested-1708",
  )
  check_search_case(
    "lsearch -glob -all -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"", "",
    "", false, "nested-1709",
  )
  check_search_case(
    "lsearch -glob -inline -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"",
    "{x a} b", "", false, "nested-1710",
  )
  check_search_case(
    "lsearch -glob -inline -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"",
    "", "", false, "nested-1711",
  )
  check_search_case(
    "lsearch -glob -all -inline -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"",
    "{{x a} b} {{a} d}", "", false, "nested-1712",
  )
  check_search_case(
    "lsearch -glob -all -inline -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"",
    "", "", false, "nested-1713",
  )
  check_search_case(
    "lsearch -glob -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"",
    "0 0 3", "", false, "nested-1714",
  )
  check_search_case(
    "lsearch -glob -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"",
    "-1 0 3", "", false, "nested-1715",
  )
  check_search_case(
    "lsearch -glob -all -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"",
    "{0 0 3} {2 0 3}", "", false, "nested-1716",
  )
  check_search_case(
    "lsearch -glob -all -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"",
    "", "", false, "nested-1717",
  )
  check_search_case(
    "lsearch -glob -inline -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"",
    "{x a} b", "", false, "nested-1718",
  )
  check_search_case(
    "lsearch -glob -inline -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"",
    "", "", false, "nested-1719",
  )
}

///|
test "Tcl search cases 1721 through 1760" {
  check_search_case(
    "lsearch -glob -all -inline -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"",
    "a a", "", false, "nested-1720",
  )
  check_search_case(
    "lsearch -glob -all -inline -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"",
    "", "", false, "nested-1721",
  )
  check_search_case(
    "lsearch -glob -not -all -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"",
    "{1 0 3}", "", false, "nested-1722",
  )
  check_search_case(
    "lsearch -glob -not -all -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"",
    "{0 0 3} {1 0 3} {2 0 3}", "", false, "nested-1723",
  )
  check_search_case(
    "lsearch -glob -start 1 -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"",
    "2 0 3", "", false, "nested-1724",
  )
  check_search_case(
    "lsearch -glob -start 1 -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"",
    "-1 0 3", "", false, "nested-1725",
  )
  check_search_case(
    "lsearch -glob -start 100 -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"",
    "-1", "", false, "nested-1726",
  )
  check_search_case(
    "lsearch -glob -start 100 -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"",
    "-1", "", false, "nested-1727",
  )
  check_search_case(
    "lsearch -regexp  -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"", "0",
    "", false, "nested-1728",
  )
  check_search_case(
    "lsearch -regexp  -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"", "-1",
    "", false, "nested-1729",
  )
  check_search_case(
    "lsearch -regexp -all -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"",
    "0 2", "", false, "nested-1730",
  )
  check_search_case(
    "lsearch -regexp -all -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"",
    "", "", false, "nested-1731",
  )
  check_search_case(
    "lsearch -regexp -inline -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"",
    "{x a} b", "", false, "nested-1732",
  )
  check_search_case(
    "lsearch -regexp -inline -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"",
    "", "", false, "nested-1733",
  )
  check_search_case(
    "lsearch -regexp -all -inline -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"",
    "{{x a} b} {{a} d}", "", false, "nested-1734",
  )
  check_search_case(
    "lsearch -regexp -all -inline -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"",
    "", "", false, "nested-1735",
  )
  check_search_case(
    "lsearch -regexp -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"",
    "0 0 3", "", false, "nested-1736",
  )
  check_search_case(
    "lsearch -regexp -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"",
    "-1 0 3", "", false, "nested-1737",
  )
  check_search_case(
    "lsearch -regexp -all -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"",
    "{0 0 3} {2 0 3}", "", false, "nested-1738",
  )
  check_search_case(
    "lsearch -regexp -all -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"",
    "", "", false, "nested-1739",
  )
  check_search_case(
    "lsearch -regexp -inline -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"",
    "{x a} b", "", false, "nested-1740",
  )
  check_search_case(
    "lsearch -regexp -inline -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"",
    "", "", false, "nested-1741",
  )
  check_search_case(
    "lsearch -regexp -all -inline -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"",
    "a a", "", false, "nested-1742",
  )
  check_search_case(
    "lsearch -regexp -all -inline -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"",
    "", "", false, "nested-1743",
  )
  check_search_case(
    "lsearch -regexp -not -all -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"",
    "{1 0 3}", "", false, "nested-1744",
  )
  check_search_case(
    "lsearch -regexp -not -all -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"",
    "{0 0 3} {1 0 3} {2 0 3}", "", false, "nested-1745",
  )
  check_search_case(
    "lsearch -regexp -start 1 -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"",
    "2 0 3", "", false, "nested-1746",
  )
  check_search_case(
    "lsearch -regexp -start 1 -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"",
    "-1 0 3", "", false, "nested-1747",
  )
  check_search_case(
    "lsearch -regexp -start 100 -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"",
    "-1", "", false, "nested-1748",
  )
  check_search_case(
    "lsearch -regexp -start 100 -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"",
    "-1", "", false, "nested-1749",
  )
  check_search_case(
    "lsearch -sorted  -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"", "0",
    "", false, "nested-1750",
  )
  check_search_case(
    "lsearch -sorted  -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"", "-1",
    "", false, "nested-1751",
  )
  check_search_case(
    "lsearch -sorted -all -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"",
    "0 2", "", false, "nested-1752",
  )
  check_search_case(
    "lsearch -sorted -all -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"",
    "", "", false, "nested-1753",
  )
  check_search_case(
    "lsearch -sorted -inline -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"",
    "{x a} b", "", false, "nested-1754",
  )
  check_search_case(
    "lsearch -sorted -inline -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"",
    "", "", false, "nested-1755",
  )
  check_search_case(
    "lsearch -sorted -all -inline -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"",
    "{{x a} b} {{a} d}", "", false, "nested-1756",
  )
  check_search_case(
    "lsearch -sorted -all -inline -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"",
    "", "", false, "nested-1757",
  )
  check_search_case(
    "lsearch -sorted -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"",
    "0 0 3", "", false, "nested-1758",
  )
  check_search_case(
    "lsearch -sorted -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"",
    "-1 0 3", "", false, "nested-1759",
  )
}

///|
test "Tcl search cases 1761 through 1800" {
  check_search_case(
    "lsearch -sorted -all -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"",
    "{0 0 3} {2 0 3}", "", false, "nested-1760",
  )
  check_search_case(
    "lsearch -sorted -all -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"",
    "", "", false, "nested-1761",
  )
  check_search_case(
    "lsearch -sorted -inline -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"",
    "{x a} b", "", false, "nested-1762",
  )
  check_search_case(
    "lsearch -sorted -inline -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"",
    "", "", false, "nested-1763",
  )
  check_search_case(
    "lsearch -sorted -all -inline -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"",
    "a a", "", false, "nested-1764",
  )
  check_search_case(
    "lsearch -sorted -all -inline -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"",
    "", "", false, "nested-1765",
  )
  check_search_case(
    "lsearch -sorted -not -all -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"",
    "{1 0 3}", "", false, "nested-1766",
  )
  check_search_case(
    "lsearch -sorted -not -all -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"",
    "{0 0 3} {1 0 3} {2 0 3}", "", false, "nested-1767",
  )
  check_search_case(
    "lsearch -sorted -start 1 -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"",
    "-1 0 3", "", false, "nested-1768",
  )
  check_search_case(
    "lsearch -sorted -start 1 -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"",
    "-1 0 3", "", false, "nested-1769",
  )
  check_search_case(
    "lsearch -sorted -start 100 -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"a\"",
    "-1", "", false, "nested-1770",
  )
  check_search_case(
    "lsearch -sorted -start 100 -subindices -index \"0 end\" {{{x a} b} {{z b} c} {{a} d}} \"z\"",
    "-1", "", false, "nested-1771",
  )
  check_search_case(
    "lsearch -exact  -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"", "0", "",
    false, "nested-1772",
  )
  check_search_case(
    "lsearch -exact  -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"", "-1", "",
    false, "nested-1773",
  )
  check_search_case(
    "lsearch -exact -all -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"", "0 2",
    "", false, "nested-1774",
  )
  check_search_case(
    "lsearch -exact -all -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"", "", "",
    false, "nested-1775",
  )
  check_search_case(
    "lsearch -exact -inline -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"", "x {a b}",
    "", false, "nested-1776",
  )
  check_search_case(
    "lsearch -exact -inline -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"", "",
    "", false, "nested-1777",
  )
  check_search_case(
    "lsearch -exact -all -inline -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"",
    "{x {a b}} {z {a}}", "", false, "nested-1778",
  )
  check_search_case(
    "lsearch -exact -all -inline -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"",
    "", "", false, "nested-1779",
  )
  check_search_case(
    "lsearch -exact -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"",
    "0 1 0", "", false, "nested-1780",
  )
  check_search_case(
    "lsearch -exact -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"",
    "-1 1 0", "", false, "nested-1781",
  )
  check_search_case(
    "lsearch -exact -all -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"",
    "{0 1 0} {2 1 0}", "", false, "nested-1782",
  )
  check_search_case(
    "lsearch -exact -all -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"",
    "", "", false, "nested-1783",
  )
  check_search_case(
    "lsearch -exact -inline -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"",
    "x {a b}", "", false, "nested-1784",
  )
  check_search_case(
    "lsearch -exact -inline -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"",
    "", "", false, "nested-1785",
  )
  check_search_case(
    "lsearch -exact -all -inline -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"",
    "a a", "", false, "nested-1786",
  )
  check_search_case(
    "lsearch -exact -all -inline -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"",
    "", "", false, "nested-1787",
  )
  check_search_case(
    "lsearch -exact -not -all -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"",
    "{1 1 0}", "", false, "nested-1788",
  )
  check_search_case(
    "lsearch -exact -not -all -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"",
    "{0 1 0} {1 1 0} {2 1 0}", "", false, "nested-1789",
  )
  check_search_case(
    "lsearch -exact -start 1 -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"",
    "2 1 0", "", false, "nested-1790",
  )
  check_search_case(
    "lsearch -exact -start 1 -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"",
    "-1 1 0", "", false, "nested-1791",
  )
  check_search_case(
    "lsearch -exact -start 100 -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"",
    "-1", "", false, "nested-1792",
  )
  check_search_case(
    "lsearch -exact -start 100 -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"",
    "-1", "", false, "nested-1793",
  )
  check_search_case(
    "lsearch -glob  -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"", "0", "", false,
    "nested-1794",
  )
  check_search_case(
    "lsearch -glob  -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"", "-1", "",
    false, "nested-1795",
  )
  check_search_case(
    "lsearch -glob -all -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"", "0 2",
    "", false, "nested-1796",
  )
  check_search_case(
    "lsearch -glob -all -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"", "", "",
    false, "nested-1797",
  )
  check_search_case(
    "lsearch -glob -inline -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"", "x {a b}",
    "", false, "nested-1798",
  )
  check_search_case(
    "lsearch -glob -inline -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"", "",
    "", false, "nested-1799",
  )
}

///|
test "Tcl search cases 1801 through 1840" {
  check_search_case(
    "lsearch -glob -all -inline -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"",
    "{x {a b}} {z {a}}", "", false, "nested-1800",
  )
  check_search_case(
    "lsearch -glob -all -inline -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"",
    "", "", false, "nested-1801",
  )
  check_search_case(
    "lsearch -glob -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"",
    "0 1 0", "", false, "nested-1802",
  )
  check_search_case(
    "lsearch -glob -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"",
    "-1 1 0", "", false, "nested-1803",
  )
  check_search_case(
    "lsearch -glob -all -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"",
    "{0 1 0} {2 1 0}", "", false, "nested-1804",
  )
  check_search_case(
    "lsearch -glob -all -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"",
    "", "", false, "nested-1805",
  )
  check_search_case(
    "lsearch -glob -inline -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"",
    "x {a b}", "", false, "nested-1806",
  )
  check_search_case(
    "lsearch -glob -inline -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"",
    "", "", false, "nested-1807",
  )
  check_search_case(
    "lsearch -glob -all -inline -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"",
    "a a", "", false, "nested-1808",
  )
  check_search_case(
    "lsearch -glob -all -inline -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"",
    "", "", false, "nested-1809",
  )
  check_search_case(
    "lsearch -glob -not -all -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"",
    "{1 1 0}", "", false, "nested-1810",
  )
  check_search_case(
    "lsearch -glob -not -all -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"",
    "{0 1 0} {1 1 0} {2 1 0}", "", false, "nested-1811",
  )
  check_search_case(
    "lsearch -glob -start 1 -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"",
    "2 1 0", "", false, "nested-1812",
  )
  check_search_case(
    "lsearch -glob -start 1 -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"",
    "-1 1 0", "", false, "nested-1813",
  )
  check_search_case(
    "lsearch -glob -start 100 -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"",
    "-1", "", false, "nested-1814",
  )
  check_search_case(
    "lsearch -glob -start 100 -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"",
    "-1", "", false, "nested-1815",
  )
  check_search_case(
    "lsearch -regexp  -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"", "0", "",
    false, "nested-1816",
  )
  check_search_case(
    "lsearch -regexp  -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"", "-1", "",
    false, "nested-1817",
  )
  check_search_case(
    "lsearch -regexp -all -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"", "0 2",
    "", false, "nested-1818",
  )
  check_search_case(
    "lsearch -regexp -all -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"", "",
    "", false, "nested-1819",
  )
  check_search_case(
    "lsearch -regexp -inline -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"", "x {a b}",
    "", false, "nested-1820",
  )
  check_search_case(
    "lsearch -regexp -inline -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"", "",
    "", false, "nested-1821",
  )
  check_search_case(
    "lsearch -regexp -all -inline -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"",
    "{x {a b}} {z {a}}", "", false, "nested-1822",
  )
  check_search_case(
    "lsearch -regexp -all -inline -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"",
    "", "", false, "nested-1823",
  )
  check_search_case(
    "lsearch -regexp -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"",
    "0 1 0", "", false, "nested-1824",
  )
  check_search_case(
    "lsearch -regexp -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"",
    "-1 1 0", "", false, "nested-1825",
  )
  check_search_case(
    "lsearch -regexp -all -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"",
    "{0 1 0} {2 1 0}", "", false, "nested-1826",
  )
  check_search_case(
    "lsearch -regexp -all -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"",
    "", "", false, "nested-1827",
  )
  check_search_case(
    "lsearch -regexp -inline -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"",
    "x {a b}", "", false, "nested-1828",
  )
  check_search_case(
    "lsearch -regexp -inline -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"",
    "", "", false, "nested-1829",
  )
  check_search_case(
    "lsearch -regexp -all -inline -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"",
    "a a", "", false, "nested-1830",
  )
  check_search_case(
    "lsearch -regexp -all -inline -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"",
    "", "", false, "nested-1831",
  )
  check_search_case(
    "lsearch -regexp -not -all -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"",
    "{1 1 0}", "", false, "nested-1832",
  )
  check_search_case(
    "lsearch -regexp -not -all -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"",
    "{0 1 0} {1 1 0} {2 1 0}", "", false, "nested-1833",
  )
  check_search_case(
    "lsearch -regexp -start 1 -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"",
    "2 1 0", "", false, "nested-1834",
  )
  check_search_case(
    "lsearch -regexp -start 1 -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"",
    "-1 1 0", "", false, "nested-1835",
  )
  check_search_case(
    "lsearch -regexp -start 100 -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"",
    "-1", "", false, "nested-1836",
  )
  check_search_case(
    "lsearch -regexp -start 100 -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"",
    "-1", "", false, "nested-1837",
  )
  check_search_case(
    "lsearch -sorted  -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"", "0", "",
    false, "nested-1838",
  )
  check_search_case(
    "lsearch -sorted  -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"", "-1", "",
    false, "nested-1839",
  )
}

///|
test "Tcl search cases 1841 through 1880" {
  check_search_case(
    "lsearch -sorted -all -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"", "0 2",
    "", false, "nested-1840",
  )
  check_search_case(
    "lsearch -sorted -all -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"", "",
    "", false, "nested-1841",
  )
  check_search_case(
    "lsearch -sorted -inline -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"", "x {a b}",
    "", false, "nested-1842",
  )
  check_search_case(
    "lsearch -sorted -inline -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"", "",
    "", false, "nested-1843",
  )
  check_search_case(
    "lsearch -sorted -all -inline -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"",
    "{x {a b}} {z {a}}", "", false, "nested-1844",
  )
  check_search_case(
    "lsearch -sorted -all -inline -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"",
    "", "", false, "nested-1845",
  )
  check_search_case(
    "lsearch -sorted -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"",
    "0 1 0", "", false, "nested-1846",
  )
  check_search_case(
    "lsearch -sorted -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"",
    "-1 1 0", "", false, "nested-1847",
  )
  check_search_case(
    "lsearch -sorted -all -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"",
    "{0 1 0} {2 1 0}", "", false, "nested-1848",
  )
  check_search_case(
    "lsearch -sorted -all -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"",
    "", "", false, "nested-1849",
  )
  check_search_case(
    "lsearch -sorted -inline -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"",
    "x {a b}", "", false, "nested-1850",
  )
  check_search_case(
    "lsearch -sorted -inline -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"",
    "", "", false, "nested-1851",
  )
  check_search_case(
    "lsearch -sorted -all -inline -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"",
    "a a", "", false, "nested-1852",
  )
  check_search_case(
    "lsearch -sorted -all -inline -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"",
    "", "", false, "nested-1853",
  )
  check_search_case(
    "lsearch -sorted -not -all -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"",
    "{1 1 0}", "", false, "nested-1854",
  )
  check_search_case(
    "lsearch -sorted -not -all -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"",
    "{0 1 0} {1 1 0} {2 1 0}", "", false, "nested-1855",
  )
  check_search_case(
    "lsearch -sorted -start 1 -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"",
    "-1 1 0", "", false, "nested-1856",
  )
  check_search_case(
    "lsearch -sorted -start 1 -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"",
    "-1 1 0", "", false, "nested-1857",
  )
  check_search_case(
    "lsearch -sorted -start 100 -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"a\"",
    "-1", "", false, "nested-1858",
  )
  check_search_case(
    "lsearch -sorted -start 100 -subindices -index \"1 0\" {{x {a b}} {y {b}} {z {a}}} \"z\"",
    "-1", "", false, "nested-1859",
  )
  check_search_case(
    "lsearch -exact  -index \"\" {a b a} \"a\"", "0", "", false, "nested-1860",
  )
  check_search_case(
    "lsearch -exact  -index \"\" {a b a} \"z\"", "-1", "", false, "nested-1861",
  )
  check_search_case(
    "lsearch -exact -all -index \"\" {a b a} \"a\"", "0 2", "", false, "nested-1862",
  )
  check_search_case(
    "lsearch -exact -all -index \"\" {a b a} \"z\"", "", "", false, "nested-1863",
  )
  check_search_case(
    "lsearch -exact -inline -index \"\" {a b a} \"a\"", "a", "", false, "nested-1864",
  )
  check_search_case(
    "lsearch -exact -inline -index \"\" {a b a} \"z\"", "", "", false, "nested-1865",
  )
  check_search_case(
    "lsearch -exact -all -inline -index \"\" {a b a} \"a\"", "a a", "", false, "nested-1866",
  )
  check_search_case(
    "lsearch -exact -all -inline -index \"\" {a b a} \"z\"", "", "", false, "nested-1867",
  )
  check_search_case(
    "lsearch -exact -subindices -index \"\" {a b a} \"a\"", "-subindices cannot be used without -index option",
    "", true, "nested-1868",
  )
  check_search_case(
    "lsearch -exact -subindices -index \"\" {a b a} \"z\"", "-subindices cannot be used without -index option",
    "", true, "nested-1869",
  )
  check_search_case(
    "lsearch -exact -all -subindices -index \"\" {a b a} \"a\"", "-subindices cannot be used without -index option",
    "", true, "nested-1870",
  )
  check_search_case(
    "lsearch -exact -all -subindices -index \"\" {a b a} \"z\"", "-subindices cannot be used without -index option",
    "", true, "nested-1871",
  )
  check_search_case(
    "lsearch -exact -inline -subindices -index \"\" {a b a} \"a\"", "-subindices cannot be used without -index option",
    "", true, "nested-1872",
  )
  check_search_case(
    "lsearch -exact -inline -subindices -index \"\" {a b a} \"z\"", "-subindices cannot be used without -index option",
    "", true, "nested-1873",
  )
  check_search_case(
    "lsearch -exact -all -inline -subindices -index \"\" {a b a} \"a\"", "-subindices cannot be used without -index option",
    "", true, "nested-1874",
  )
  check_search_case(
    "lsearch -exact -all -inline -subindices -index \"\" {a b a} \"z\"", "-subindices cannot be used without -index option",
    "", true, "nested-1875",
  )
  check_search_case(
    "lsearch -exact -not -all -subindices -index \"\" {a b a} \"a\"", "-subindices cannot be used without -index option",
    "", true, "nested-1876",
  )
  check_search_case(
    "lsearch -exact -not -all -subindices -index \"\" {a b a} \"z\"", "-subindices cannot be used without -index option",
    "", true, "nested-1877",
  )
  check_search_case(
    "lsearch -exact -start 1 -subindices -index \"\" {a b a} \"a\"", "-subindices cannot be used without -index option",
    "", true, "nested-1878",
  )
  check_search_case(
    "lsearch -exact -start 1 -subindices -index \"\" {a b a} \"z\"", "-subindices cannot be used without -index option",
    "", true, "nested-1879",
  )
}

///|
test "Tcl search cases 1881 through 1920" {
  check_search_case(
    "lsearch -exact -start 100 -subindices -index \"\" {a b a} \"a\"", "-subindices cannot be used without -index option",
    "", true, "nested-1880",
  )
  check_search_case(
    "lsearch -exact -start 100 -subindices -index \"\" {a b a} \"z\"", "-subindices cannot be used without -index option",
    "", true, "nested-1881",
  )
  check_search_case(
    "lsearch -glob  -index \"\" {a b a} \"a\"", "0", "", false, "nested-1882",
  )
  check_search_case(
    "lsearch -glob  -index \"\" {a b a} \"z\"", "-1", "", false, "nested-1883",
  )
  check_search_case(
    "lsearch -glob -all -index \"\" {a b a} \"a\"", "0 2", "", false, "nested-1884",
  )
  check_search_case(
    "lsearch -glob -all -index \"\" {a b a} \"z\"", "", "", false, "nested-1885",
  )
  check_search_case(
    "lsearch -glob -inline -index \"\" {a b a} \"a\"", "a", "", false, "nested-1886",
  )
  check_search_case(
    "lsearch -glob -inline -index \"\" {a b a} \"z\"", "", "", false, "nested-1887",
  )
  check_search_case(
    "lsearch -glob -all -inline -index \"\" {a b a} \"a\"", "a a", "", false, "nested-1888",
  )
  check_search_case(
    "lsearch -glob -all -inline -index \"\" {a b a} \"z\"", "", "", false, "nested-1889",
  )
  check_search_case(
    "lsearch -glob -subindices -index \"\" {a b a} \"a\"", "-subindices cannot be used without -index option",
    "", true, "nested-1890",
  )
  check_search_case(
    "lsearch -glob -subindices -index \"\" {a b a} \"z\"", "-subindices cannot be used without -index option",
    "", true, "nested-1891",
  )
  check_search_case(
    "lsearch -glob -all -subindices -index \"\" {a b a} \"a\"", "-subindices cannot be used without -index option",
    "", true, "nested-1892",
  )
  check_search_case(
    "lsearch -glob -all -subindices -index \"\" {a b a} \"z\"", "-subindices cannot be used without -index option",
    "", true, "nested-1893",
  )
  check_search_case(
    "lsearch -glob -inline -subindices -index \"\" {a b a} \"a\"", "-subindices cannot be used without -index option",
    "", true, "nested-1894",
  )
  check_search_case(
    "lsearch -glob -inline -subindices -index \"\" {a b a} \"z\"", "-subindices cannot be used without -index option",
    "", true, "nested-1895",
  )
  check_search_case(
    "lsearch -glob -all -inline -subindices -index \"\" {a b a} \"a\"", "-subindices cannot be used without -index option",
    "", true, "nested-1896",
  )
  check_search_case(
    "lsearch -glob -all -inline -subindices -index \"\" {a b a} \"z\"", "-subindices cannot be used without -index option",
    "", true, "nested-1897",
  )
  check_search_case(
    "lsearch -glob -not -all -subindices -index \"\" {a b a} \"a\"", "-subindices cannot be used without -index option",
    "", true, "nested-1898",
  )
  check_search_case(
    "lsearch -glob -not -all -subindices -index \"\" {a b a} \"z\"", "-subindices cannot be used without -index option",
    "", true, "nested-1899",
  )
  check_search_case(
    "lsearch -glob -start 1 -subindices -index \"\" {a b a} \"a\"", "-subindices cannot be used without -index option",
    "", true, "nested-1900",
  )
  check_search_case(
    "lsearch -glob -start 1 -subindices -index \"\" {a b a} \"z\"", "-subindices cannot be used without -index option",
    "", true, "nested-1901",
  )
  check_search_case(
    "lsearch -glob -start 100 -subindices -index \"\" {a b a} \"a\"", "-subindices cannot be used without -index option",
    "", true, "nested-1902",
  )
  check_search_case(
    "lsearch -glob -start 100 -subindices -index \"\" {a b a} \"z\"", "-subindices cannot be used without -index option",
    "", true, "nested-1903",
  )
  check_search_case(
    "lsearch -regexp  -index \"\" {a b a} \"a\"", "0", "", false, "nested-1904",
  )
  check_search_case(
    "lsearch -regexp  -index \"\" {a b a} \"z\"", "-1", "", false, "nested-1905",
  )
  check_search_case(
    "lsearch -regexp -all -index \"\" {a b a} \"a\"", "0 2", "", false, "nested-1906",
  )
  check_search_case(
    "lsearch -regexp -all -index \"\" {a b a} \"z\"", "", "", false, "nested-1907",
  )
  check_search_case(
    "lsearch -regexp -inline -index \"\" {a b a} \"a\"", "a", "", false, "nested-1908",
  )
  check_search_case(
    "lsearch -regexp -inline -index \"\" {a b a} \"z\"", "", "", false, "nested-1909",
  )
  check_search_case(
    "lsearch -regexp -all -inline -index \"\" {a b a} \"a\"", "a a", "", false, "nested-1910",
  )
  check_search_case(
    "lsearch -regexp -all -inline -index \"\" {a b a} \"z\"", "", "", false, "nested-1911",
  )
  check_search_case(
    "lsearch -regexp -subindices -index \"\" {a b a} \"a\"", "-subindices cannot be used without -index option",
    "", true, "nested-1912",
  )
  check_search_case(
    "lsearch -regexp -subindices -index \"\" {a b a} \"z\"", "-subindices cannot be used without -index option",
    "", true, "nested-1913",
  )
  check_search_case(
    "lsearch -regexp -all -subindices -index \"\" {a b a} \"a\"", "-subindices cannot be used without -index option",
    "", true, "nested-1914",
  )
  check_search_case(
    "lsearch -regexp -all -subindices -index \"\" {a b a} \"z\"", "-subindices cannot be used without -index option",
    "", true, "nested-1915",
  )
  check_search_case(
    "lsearch -regexp -inline -subindices -index \"\" {a b a} \"a\"", "-subindices cannot be used without -index option",
    "", true, "nested-1916",
  )
  check_search_case(
    "lsearch -regexp -inline -subindices -index \"\" {a b a} \"z\"", "-subindices cannot be used without -index option",
    "", true, "nested-1917",
  )
  check_search_case(
    "lsearch -regexp -all -inline -subindices -index \"\" {a b a} \"a\"", "-subindices cannot be used without -index option",
    "", true, "nested-1918",
  )
  check_search_case(
    "lsearch -regexp -all -inline -subindices -index \"\" {a b a} \"z\"", "-subindices cannot be used without -index option",
    "", true, "nested-1919",
  )
}

///|
test "Tcl search cases 1921 through 1960" {
  check_search_case(
    "lsearch -regexp -not -all -subindices -index \"\" {a b a} \"a\"", "-subindices cannot be used without -index option",
    "", true, "nested-1920",
  )
  check_search_case(
    "lsearch -regexp -not -all -subindices -index \"\" {a b a} \"z\"", "-subindices cannot be used without -index option",
    "", true, "nested-1921",
  )
  check_search_case(
    "lsearch -regexp -start 1 -subindices -index \"\" {a b a} \"a\"", "-subindices cannot be used without -index option",
    "", true, "nested-1922",
  )
  check_search_case(
    "lsearch -regexp -start 1 -subindices -index \"\" {a b a} \"z\"", "-subindices cannot be used without -index option",
    "", true, "nested-1923",
  )
  check_search_case(
    "lsearch -regexp -start 100 -subindices -index \"\" {a b a} \"a\"", "-subindices cannot be used without -index option",
    "", true, "nested-1924",
  )
  check_search_case(
    "lsearch -regexp -start 100 -subindices -index \"\" {a b a} \"z\"", "-subindices cannot be used without -index option",
    "", true, "nested-1925",
  )
  check_search_case(
    "lsearch -sorted  -index \"\" {a b a} \"a\"", "0", "", false, "nested-1926",
  )
  check_search_case(
    "lsearch -sorted  -index \"\" {a b a} \"z\"", "-1", "", false, "nested-1927",
  )
  check_search_case(
    "lsearch -sorted -all -index \"\" {a b a} \"a\"", "0 2", "", false, "nested-1928",
  )
  check_search_case(
    "lsearch -sorted -all -index \"\" {a b a} \"z\"", "", "", false, "nested-1929",
  )
  check_search_case(
    "lsearch -sorted -inline -index \"\" {a b a} \"a\"", "a", "", false, "nested-1930",
  )
  check_search_case(
    "lsearch -sorted -inline -index \"\" {a b a} \"z\"", "", "", false, "nested-1931",
  )
  check_search_case(
    "lsearch -sorted -all -inline -index \"\" {a b a} \"a\"", "a a", "", false, "nested-1932",
  )
  check_search_case(
    "lsearch -sorted -all -inline -index \"\" {a b a} \"z\"", "", "", false, "nested-1933",
  )
  check_search_case(
    "lsearch -sorted -subindices -index \"\" {a b a} \"a\"", "-subindices cannot be used without -index option",
    "", true, "nested-1934",
  )
  check_search_case(
    "lsearch -sorted -subindices -index \"\" {a b a} \"z\"", "-subindices cannot be used without -index option",
    "", true, "nested-1935",
  )
  check_search_case(
    "lsearch -sorted -all -subindices -index \"\" {a b a} \"a\"", "-subindices cannot be used without -index option",
    "", true, "nested-1936",
  )
  check_search_case(
    "lsearch -sorted -all -subindices -index \"\" {a b a} \"z\"", "-subindices cannot be used without -index option",
    "", true, "nested-1937",
  )
  check_search_case(
    "lsearch -sorted -inline -subindices -index \"\" {a b a} \"a\"", "-subindices cannot be used without -index option",
    "", true, "nested-1938",
  )
  check_search_case(
    "lsearch -sorted -inline -subindices -index \"\" {a b a} \"z\"", "-subindices cannot be used without -index option",
    "", true, "nested-1939",
  )
  check_search_case(
    "lsearch -sorted -all -inline -subindices -index \"\" {a b a} \"a\"", "-subindices cannot be used without -index option",
    "", true, "nested-1940",
  )
  check_search_case(
    "lsearch -sorted -all -inline -subindices -index \"\" {a b a} \"z\"", "-subindices cannot be used without -index option",
    "", true, "nested-1941",
  )
  check_search_case(
    "lsearch -sorted -not -all -subindices -index \"\" {a b a} \"a\"", "-subindices cannot be used without -index option",
    "", true, "nested-1942",
  )
  check_search_case(
    "lsearch -sorted -not -all -subindices -index \"\" {a b a} \"z\"", "-subindices cannot be used without -index option",
    "", true, "nested-1943",
  )
  check_search_case(
    "lsearch -sorted -start 1 -subindices -index \"\" {a b a} \"a\"", "-subindices cannot be used without -index option",
    "", true, "nested-1944",
  )
  check_search_case(
    "lsearch -sorted -start 1 -subindices -index \"\" {a b a} \"z\"", "-subindices cannot be used without -index option",
    "", true, "nested-1945",
  )
  check_search_case(
    "lsearch -sorted -start 100 -subindices -index \"\" {a b a} \"a\"", "-subindices cannot be used without -index option",
    "", true, "nested-1946",
  )
  check_search_case(
    "lsearch -sorted -start 100 -subindices -index \"\" {a b a} \"z\"", "-subindices cannot be used without -index option",
    "", true, "nested-1947",
  )
  check_search_case(
    "set code [catch {lsearch} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"lsearch ?-option value ...? list pattern\"} {TCL WRONGARGS}",
    "", false, "selected-errors-1948",
  )
  check_search_case(
    "set code [catch {lsearch a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"lsearch ?-option value ...? list pattern\"} {TCL WRONGARGS}",
    "", false, "selected-errors-1949",
  )
  check_search_case(
    "set code [catch {lsearch -bad {} a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {bad option \"-bad\": must be -all, -ascii, -bisect, -decreasing, -dictionary, -exact, -glob, -increasing, -index, -inline, -integer, -nocase, -not, -real, -regexp, -sorted, -start, or -subindices} {TCL LOOKUP INDEX option -bad}",
    "", false, "selected-errors-1950",
  )
  check_search_case(
    "set code [catch {lsearch -a {} a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {ambiguous option \"-a\": must be -all, -ascii, -bisect, -decreasing, -dictionary, -exact, -glob, -increasing, -index, -inline, -integer, -nocase, -not, -real, -regexp, -sorted, -start, or -subindices} {TCL LOOKUP INDEX option -a}",
    "", false, "selected-errors-1951",
  )
  check_search_case(
    "set code [catch {lsearch -- {} a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {bad option \"--\": must be -all, -ascii, -bisect, -decreasing, -dictionary, -exact, -glob, -increasing, -index, -inline, -integer, -nocase, -not, -real, -regexp, -sorted, -start, or -subindices} {TCL LOOKUP INDEX option --}",
    "", false, "selected-errors-1952",
  )
  check_search_case(
    "set code [catch {lsearch - {} a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {ambiguous option \"-\": must be -all, -ascii, -bisect, -decreasing, -dictionary, -exact, -glob, -increasing, -index, -inline, -integer, -nocase, -not, -real, -regexp, -sorted, -start, or -subindices} {TCL LOOKUP INDEX option -}",
    "", false, "selected-errors-1953",
  )
  check_search_case(
    "set code [catch {lsearch nope {} a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {bad option \"nope\": must be -all, -ascii, -bisect, -decreasing, -dictionary, -exact, -glob, -increasing, -index, -inline, -integer, -nocase, -not, -real, -regexp, -sorted, -start, or -subindices} {TCL LOOKUP INDEX option nope}",
    "", false, "selected-errors-1954",
  )
  check_search_case(
    "set code [catch {lsearch -start {} a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {missing starting index} {TCL ARGUMENT MISSING}", "", false, "selected-errors-1955",
  )
  check_search_case(
    "set code [catch {lsearch -index {} a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {\"-index\" option must be followed by list index} {TCL ARGUMENT MISSING}",
    "", false, "selected-errors-1956",
  )
  check_search_case(
    "set code [catch {lsearch -subindices {} a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {-subindices cannot be used without -index option} {TCL OPERATION LSEARCH BAD_OPTION_MIX}",
    "", false, "selected-errors-1957",
  )
  check_search_case(
    "set code [catch {lsearch -index {} -subindices {} a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {-subindices cannot be used without -index option} {TCL OPERATION LSEARCH BAD_OPTION_MIX}",
    "", false, "selected-errors-1958",
  )
  check_search_case(
    "set code [catch {lsearch -bisect -all {} a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {-bisect is not compatible with -all or -not} {TCL OPERATION LSEARCH BAD_OPTION_MIX}",
    "", false, "selected-errors-1959",
  )
}

///|
test "Tcl search cases 1961 through 2000" {
  check_search_case(
    "set code [catch {lsearch -bisect -not -glob {} a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {-bisect is not compatible with -all or -not} {TCL OPERATION LSEARCH BAD_OPTION_MIX}",
    "", false, "selected-errors-1960",
  )
  check_search_case(
    "set code [catch {lsearch -stride 2 {} a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {bad option \"-stride\": must be -all, -ascii, -bisect, -decreasing, -dictionary, -exact, -glob, -increasing, -index, -inline, -integer, -nocase, -not, -real, -regexp, -sorted, -start, or -subindices} {TCL LOOKUP INDEX option -stride}",
    "", false, "selected-errors-1961",
  )
  check_search_case(
    "set code [catch {lsearch -regexp {} {(}} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {couldn't compile regular expression pattern: parentheses () not balanced} {REGEXP REG_EPAREN {parentheses () not balanced}}",
    "", false, "selected-errors-1962",
  )
  check_search_case(
    "set code [catch {lsearch -regexp -start bad {} {(}} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {couldn't compile regular expression pattern: parentheses () not balanced} {REGEXP REG_EPAREN {parentheses () not balanced}}",
    "", false, "selected-errors-1963",
  )
  check_search_case(
    "set code [catch {lsearch -regexp -start 100 {} {(}} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {couldn't compile regular expression pattern: parentheses () not balanced} {REGEXP REG_EPAREN {parentheses () not balanced}}",
    "", false, "selected-errors-1964",
  )
  check_search_case(
    "set code [catch {lsearch -regexp -subindices {} {(}} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {-subindices cannot be used without -index option} {TCL OPERATION LSEARCH BAD_OPTION_MIX}",
    "", false, "selected-errors-1965",
  )
  check_search_case(
    "set code [catch {lsearch -index bad -regexp {} {(}} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {bad index \"bad\": must be integer?[+-]integer? or end?[+-]integer?} {TCL VALUE INDEX}",
    "", false, "selected-errors-1966",
  )
  check_search_case(
    "set code [catch {lsearch -start bad -start 0 {a b} a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 0 {}", "", false, "selected-errors-1967",
  )
  check_search_case(
    "set code [catch {lsearch -index bad -index 0 {a b} a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {bad index \"bad\": must be integer?[+-]integer? or end?[+-]integer?} {TCL VALUE INDEX}",
    "", false, "selected-errors-1968",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer {} bad} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected integer but got \"bad\"} {TCL VALUE NUMBER}", "", false, "selected-errors-1969",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer -start 0 {} bad} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "selected-errors-1970",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real -start 10 {1} NaN} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "selected-errors-1971",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real {} NaN} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {floating point value is Not a Number} {TCL VALUE DOUBLE NAN}", "", false,
    "selected-errors-1972",
  )
  check_search_case(
    "set code [catch {lsearch -index 1 {{x a} x} a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 0 {}", "", false, "selected-errors-1973",
  )
  check_search_case(
    "set code [catch {lsearch -all -index 1 {{x a} x} a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {element 1 missing from sublist \"x\"} {TCL OPERATION LSORT INDEXFAILED}",
    "", false, "selected-errors-1974",
  )
  check_search_case(
    "set code [catch {lsearch -sorted -integer {bad 1 2} 2} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 2 {}", "", false, "selected-errors-1975",
  )
  check_search_case(
    "set code [catch {lsearch -sorted -integer {0 1 bad} 0} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 0 {}", "", false, "selected-errors-1976",
  )
  check_search_case(
    "set code [catch {lsearch -bisect -glob {a b c} b*} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 1 {}", "", false, "selected-errors-1977",
  )
  check_search_case(
    "set code [catch {lsearch -glob -bisect {a b c} b*} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 1 {}", "", false, "selected-errors-1978",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer -ascii {bad 2} bad} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 0 {}", "", false, "selected-errors-1979",
  )
  check_search_case(
    "set code [catch {lsearch -exact -ascii -integer {bad 2} bad} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected integer but got \"bad\"} {TCL VALUE NUMBER}", "", false, "selected-errors-1980",
  )
  check_search_case(
    "set code [catch {lsearch -index \"-1\" {} a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {index \"-1\" cannot select an element from any list} {TCL VALUE INDEXOUTOFRANGE}",
    "", false, "index-errors-1981",
  )
  check_search_case(
    "set code [catch {lsearch -index \"2147483647\" {} a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {index \"2147483647\" cannot select an element from any list} {TCL VALUE INDEXOUTOFRANGE}",
    "", false, "index-errors-1982",
  )
  check_search_case(
    "set code [catch {lsearch -index \"2147483646\" {} a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "index-errors-1983",
  )
  check_search_case(
    "set code [catch {lsearch -index \"-2147483648\" {} a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {index \"-2147483648\" cannot select an element from any list} {TCL VALUE INDEXOUTOFRANGE}",
    "", false, "index-errors-1984",
  )
  check_search_case(
    "set code [catch {lsearch -index \"end+1\" {} a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {index \"end+1\" cannot select an element from any list} {TCL VALUE INDEXOUTOFRANGE}",
    "", false, "index-errors-1985",
  )
  check_search_case(
    "set code [catch {lsearch -index \"end-2147483647\" {} a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {index \"end-2147483647\" cannot select an element from any list} {TCL VALUE INDEXOUTOFRANGE}",
    "", false, "index-errors-1986",
  )
  check_search_case(
    "set code [catch {lsearch -index \"end-2147483648\" {} a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {index \"end-2147483648\" cannot select an element from any list} {TCL VALUE INDEXOUTOFRANGE}",
    "", false, "index-errors-1987",
  )
  check_search_case(
    "set code [catch {lsearch -index \"end+4294967295\" {} a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "index-errors-1988",
  )
  check_search_case(
    "set code [catch {lsearch -index \"end--1\" {} a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {index \"end--1\" cannot select an element from any list} {TCL VALUE INDEXOUTOFRANGE}",
    "", false, "index-errors-1989",
  )
  check_search_case(
    "set code [catch {lsearch -index \"0+1\" {} a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "index-errors-1990",
  )
  check_search_case(
    "set code [catch {lsearch -index \"1-1\" {} a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "index-errors-1991",
  )
  check_search_case(
    "set code [catch {lsearch -index \"08\" {} a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {bad index \"08\": must be integer?[+-]integer? or end?[+-]integer? (looks like invalid octal number)} {TCL VALUE INDEX}",
    "", false, "index-errors-1992",
  )
  check_search_case(
    "set code [catch {lsearch -index \"bad\" {} a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {bad index \"bad\": must be integer?[+-]integer? or end?[+-]integer?} {TCL VALUE INDEX}",
    "", false, "index-errors-1993",
  )
  check_search_case(
    "set code [catch {lsearch -index \" 1 \" {} a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "index-errors-1994",
  )
  check_search_case(
    "set code [catch {lsearch -index \"end \" {} a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "index-errors-1995",
  )
  check_search_case(
    "set code [catch {lsearch -index \"1+ 1\" {} a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {bad index \"1+\": must be integer?[+-]integer? or end?[+-]integer?} {TCL VALUE INDEX}",
    "", false, "index-errors-1996",
  )
  check_search_case(
    "set code [catch {lsearch -start \"bad\" {a b} a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {bad index \"bad\": must be integer?[+-]integer? or end?[+-]integer?} {TCL VALUE INDEX}",
    "", false, "start-errors-1997",
  )
  check_search_case(
    "set code [catch {lsearch -start \"08\" {a b} a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {bad index \"08\": must be integer?[+-]integer? or end?[+-]integer? (looks like invalid octal number)} {TCL VALUE INDEX}",
    "", false, "start-errors-1998",
  )
  check_search_case(
    "set code [catch {lsearch -start \"4294967296\" {a b} a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {bad index \"4294967296\": must be integer?[+-]integer? or end?[+-]integer?} {TCL VALUE INDEX}",
    "", false, "start-errors-1999",
  )
}

///|
test "Tcl search cases 2001 through 2040" {
  check_search_case(
    "set code [catch {lsearch -start \"end \" {a b} a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {bad index \"end \": must be integer?[+-]integer? or end?[+-]integer?} {TCL VALUE INDEX}",
    "", false, "start-errors-2000",
  )
  check_search_case(
    "set code [catch {lsearch -start \"1+ 1\" {a b} a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {bad index \"1+ 1\": must be integer?[+-]integer? or end?[+-]integer?} {TCL VALUE INDEX}",
    "", false, "start-errors-2001",
  )
  check_search_case(
    "set code [catch {lsearch -start \"2147483647\" {a b} a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "start-errors-2002",
  )
  check_search_case(
    "lsearch -ex {1 2 3} 2", "1", "", false, "abbreviations-2003",
  )
  check_search_case(
    "lsearch -gl {1 2 3} 2", "1", "", false, "abbreviations-2004",
  )
  check_search_case(
    "lsearch -reg {1 2 3} 2", "1", "", false, "abbreviations-2005",
  )
  check_search_case(
    "lsearch -so {1 2 3} 2", "1", "", false, "abbreviations-2006",
  )
  check_search_case(
    "lsearch -al {1 2 3} 2", "1", "", false, "abbreviations-2007",
  )
  check_search_case(
    "lsearch -as {1 2 3} 2", "1", "", false, "abbreviations-2008",
  )
  check_search_case(
    "lsearch -bi {1 2 3} 2", "1", "", false, "abbreviations-2009",
  )
  check_search_case(
    "lsearch -dec {1 2 3} 2", "1", "", false, "abbreviations-2010",
  )
  check_search_case(
    "lsearch -di {1 2 3} 2", "1", "", false, "abbreviations-2011",
  )
  check_search_case(
    "lsearch -inc {1 2 3} 2", "1", "", false, "abbreviations-2012",
  )
  check_search_case(
    "lsearch -inl {1 2 3} 2", "2", "", false, "abbreviations-2013",
  )
  check_search_case(
    "lsearch -int {1 2 3} 2", "1", "", false, "abbreviations-2014",
  )
  check_search_case(
    "lsearch -noc {1 2 3} 2", "1", "", false, "abbreviations-2015",
  )
  check_search_case(
    "lsearch -not {1 2 3} 2", "0", "", false, "abbreviations-2016",
  )
  check_search_case(
    "lsearch -rea {1 2 3} 2", "1", "", false, "abbreviations-2017",
  )
  check_search_case(
    "lsearch -star 0 {1 2 3} 2", "1", "", false, "abbreviations-2018",
  )
  check_search_case(
    "lsearch -ind 0 {1 2 3} 2", "1", "", false, "abbreviations-2019",
  )
  check_search_case(
    "lsearch -sub -index 0 {1 2 3} 2", "1 0", "", false, "abbreviations-2020",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"-18446744073709551616\"] \"-1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {integer value too large to represent} {ARITH IOVERFLOW {integer value too large to represent}}",
    "", false, "numeric-boundaries-2021",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"-18446744073709551616\"] \"0\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {integer value too large to represent} {ARITH IOVERFLOW {integer value too large to represent}}",
    "", false, "numeric-boundaries-2022",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"-18446744073709551616\"] \"1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {integer value too large to represent} {ARITH IOVERFLOW {integer value too large to represent}}",
    "", false, "numeric-boundaries-2023",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"-18446744073709551616\"] \"16\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {integer value too large to represent} {ARITH IOVERFLOW {integer value too large to represent}}",
    "", false, "numeric-boundaries-2024",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"-18446744073709551616\"] \"-1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2025",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"-18446744073709551616\"] \"0\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2026",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"-18446744073709551616\"] \"1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2027",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"-18446744073709551616\"] \"16\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2028",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"-18446744073709551615\"] \"-1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2029",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"-18446744073709551615\"] \"0\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2030",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"-18446744073709551615\"] \"1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 0 {}", "", false, "numeric-boundaries-2031",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"-18446744073709551615\"] \"16\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2032",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"-18446744073709551615\"] \"-1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2033",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"-18446744073709551615\"] \"0\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2034",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"-18446744073709551615\"] \"1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2035",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"-18446744073709551615\"] \"16\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2036",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"-9223372036854775809\"] \"-1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2037",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"-9223372036854775809\"] \"0\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2038",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"-9223372036854775809\"] \"1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2039",
  )
}

///|
test "Tcl search cases 2041 through 2080" {
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"-9223372036854775809\"] \"16\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2040",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"-9223372036854775809\"] \"-1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2041",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"-9223372036854775809\"] \"0\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2042",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"-9223372036854775809\"] \"1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2043",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"-9223372036854775809\"] \"16\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2044",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"-9223372036854775808\"] \"-1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2045",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"-9223372036854775808\"] \"0\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2046",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"-9223372036854775808\"] \"1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2047",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"-9223372036854775808\"] \"16\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2048",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"-9223372036854775808\"] \"-1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2049",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"-9223372036854775808\"] \"0\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2050",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"-9223372036854775808\"] \"1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2051",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"-9223372036854775808\"] \"16\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2052",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"-1\"] \"-1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 0 {}", "", false, "numeric-boundaries-2053",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"-1\"] \"0\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2054",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"-1\"] \"1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2055",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"-1\"] \"16\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2056",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"-1\"] \"-1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 0 {}", "", false, "numeric-boundaries-2057",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"-1\"] \"0\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2058",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"-1\"] \"1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2059",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"-1\"] \"16\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2060",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"0\"] \"-1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2061",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"0\"] \"0\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 0 {}", "", false, "numeric-boundaries-2062",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"0\"] \"1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2063",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"0\"] \"16\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2064",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"0\"] \"-1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2065",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"0\"] \"0\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 0 {}", "", false, "numeric-boundaries-2066",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"0\"] \"1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2067",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"0\"] \"16\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2068",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"9223372036854775807\"] \"-1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2069",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"9223372036854775807\"] \"0\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2070",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"9223372036854775807\"] \"1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2071",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"9223372036854775807\"] \"16\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2072",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"9223372036854775807\"] \"-1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2073",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"9223372036854775807\"] \"0\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2074",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"9223372036854775807\"] \"1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2075",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"9223372036854775807\"] \"16\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2076",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"9223372036854775808\"] \"-1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2077",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"9223372036854775808\"] \"0\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2078",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"9223372036854775808\"] \"1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2079",
  )
}

///|
test "Tcl search cases 2081 through 2120" {
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"9223372036854775808\"] \"16\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2080",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"9223372036854775808\"] \"-1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2081",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"9223372036854775808\"] \"0\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2082",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"9223372036854775808\"] \"1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2083",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"9223372036854775808\"] \"16\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2084",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"18446744073709551615\"] \"-1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 0 {}", "", false, "numeric-boundaries-2085",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"18446744073709551615\"] \"0\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2086",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"18446744073709551615\"] \"1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2087",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"18446744073709551615\"] \"16\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2088",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"18446744073709551615\"] \"-1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2089",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"18446744073709551615\"] \"0\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2090",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"18446744073709551615\"] \"1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2091",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"18446744073709551615\"] \"16\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2092",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"18446744073709551616\"] \"-1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {integer value too large to represent} {ARITH IOVERFLOW {integer value too large to represent}}",
    "", false, "numeric-boundaries-2093",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"18446744073709551616\"] \"0\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {integer value too large to represent} {ARITH IOVERFLOW {integer value too large to represent}}",
    "", false, "numeric-boundaries-2094",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"18446744073709551616\"] \"1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {integer value too large to represent} {ARITH IOVERFLOW {integer value too large to represent}}",
    "", false, "numeric-boundaries-2095",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"18446744073709551616\"] \"16\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {integer value too large to represent} {ARITH IOVERFLOW {integer value too large to represent}}",
    "", false, "numeric-boundaries-2096",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"18446744073709551616\"] \"-1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2097",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"18446744073709551616\"] \"0\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2098",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"18446744073709551616\"] \"1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2099",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"18446744073709551616\"] \"16\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2100",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"08\"] \"-1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected integer but got \"08\"} {TCL VALUE NUMBER}", "", false, "numeric-boundaries-2101",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"08\"] \"0\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected integer but got \"08\"} {TCL VALUE NUMBER}", "", false, "numeric-boundaries-2102",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"08\"] \"1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected integer but got \"08\"} {TCL VALUE NUMBER}", "", false, "numeric-boundaries-2103",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"08\"] \"16\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected integer but got \"08\"} {TCL VALUE NUMBER}", "", false, "numeric-boundaries-2104",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"08\"] \"-1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected floating-point number but got \"08\" (looks like invalid octal number)} {TCL VALUE NUMBER}",
    "", false, "numeric-boundaries-2105",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"08\"] \"0\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected floating-point number but got \"08\" (looks like invalid octal number)} {TCL VALUE NUMBER}",
    "", false, "numeric-boundaries-2106",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"08\"] \"1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected floating-point number but got \"08\" (looks like invalid octal number)} {TCL VALUE NUMBER}",
    "", false, "numeric-boundaries-2107",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"08\"] \"16\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected floating-point number but got \"08\" (looks like invalid octal number)} {TCL VALUE NUMBER}",
    "", false, "numeric-boundaries-2108",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"1.0\"] \"-1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected integer but got \"1.0\"} {TCL VALUE NUMBER}", "", false, "numeric-boundaries-2109",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"1.0\"] \"0\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected integer but got \"1.0\"} {TCL VALUE NUMBER}", "", false, "numeric-boundaries-2110",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"1.0\"] \"1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected integer but got \"1.0\"} {TCL VALUE NUMBER}", "", false, "numeric-boundaries-2111",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"1.0\"] \"16\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected integer but got \"1.0\"} {TCL VALUE NUMBER}", "", false, "numeric-boundaries-2112",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"1.0\"] \"-1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2113",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"1.0\"] \"0\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2114",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"1.0\"] \"1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 0 {}", "", false, "numeric-boundaries-2115",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"1.0\"] \"16\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2116",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"NaN\"] \"-1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected integer but got \"NaN\"} {TCL VALUE NUMBER}", "", false, "numeric-boundaries-2117",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"NaN\"] \"0\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected integer but got \"NaN\"} {TCL VALUE NUMBER}", "", false, "numeric-boundaries-2118",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"NaN\"] \"1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected integer but got \"NaN\"} {TCL VALUE NUMBER}", "", false, "numeric-boundaries-2119",
  )
}

///|
test "Tcl search cases 2121 through 2160" {
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"NaN\"] \"16\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected integer but got \"NaN\"} {TCL VALUE NUMBER}", "", false, "numeric-boundaries-2120",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"NaN\"] \"-1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {floating point value is Not a Number} {TCL VALUE DOUBLE NAN}", "", false,
    "numeric-boundaries-2121",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"NaN\"] \"0\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {floating point value is Not a Number} {TCL VALUE DOUBLE NAN}", "", false,
    "numeric-boundaries-2122",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"NaN\"] \"1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {floating point value is Not a Number} {TCL VALUE DOUBLE NAN}", "", false,
    "numeric-boundaries-2123",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"NaN\"] \"16\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {floating point value is Not a Number} {TCL VALUE DOUBLE NAN}", "", false,
    "numeric-boundaries-2124",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"Inf\"] \"-1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected integer but got \"Inf\"} {TCL VALUE NUMBER}", "", false, "numeric-boundaries-2125",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"Inf\"] \"0\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected integer but got \"Inf\"} {TCL VALUE NUMBER}", "", false, "numeric-boundaries-2126",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"Inf\"] \"1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected integer but got \"Inf\"} {TCL VALUE NUMBER}", "", false, "numeric-boundaries-2127",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"Inf\"] \"16\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected integer but got \"Inf\"} {TCL VALUE NUMBER}", "", false, "numeric-boundaries-2128",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"Inf\"] \"-1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2129",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"Inf\"] \"0\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2130",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"Inf\"] \"1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2131",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"Inf\"] \"16\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2132",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"bad\"] \"-1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected integer but got \"bad\"} {TCL VALUE NUMBER}", "", false, "numeric-boundaries-2133",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"bad\"] \"0\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected integer but got \"bad\"} {TCL VALUE NUMBER}", "", false, "numeric-boundaries-2134",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"bad\"] \"1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected integer but got \"bad\"} {TCL VALUE NUMBER}", "", false, "numeric-boundaries-2135",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"bad\"] \"16\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected integer but got \"bad\"} {TCL VALUE NUMBER}", "", false, "numeric-boundaries-2136",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"bad\"] \"-1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected floating-point number but got \"bad\"} {TCL VALUE NUMBER}", "",
    false, "numeric-boundaries-2137",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"bad\"] \"0\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected floating-point number but got \"bad\"} {TCL VALUE NUMBER}", "",
    false, "numeric-boundaries-2138",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"bad\"] \"1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected floating-point number but got \"bad\"} {TCL VALUE NUMBER}", "",
    false, "numeric-boundaries-2139",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"bad\"] \"16\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected floating-point number but got \"bad\"} {TCL VALUE NUMBER}", "",
    false, "numeric-boundaries-2140",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \" 16 \"] \"-1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2141",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \" 16 \"] \"0\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2142",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \" 16 \"] \"1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2143",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \" 16 \"] \"16\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 0 {}", "", false, "numeric-boundaries-2144",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \" 16 \"] \"-1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2145",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \" 16 \"] \"0\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2146",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \" 16 \"] \"1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2147",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \" 16 \"] \"16\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 0 {}", "", false, "numeric-boundaries-2148",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"0x10\"] \"-1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2149",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"0x10\"] \"0\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2150",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"0x10\"] \"1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2151",
  )
  check_search_case(
    "set code [catch {lsearch -exact -integer [list \"0x10\"] \"16\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 0 {}", "", false, "numeric-boundaries-2152",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"0x10\"] \"-1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2153",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"0x10\"] \"0\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2154",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"0x10\"] \"1\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -1 {}", "", false, "numeric-boundaries-2155",
  )
  check_search_case(
    "set code [catch {lsearch -exact -real [list \"0x10\"] \"16\"} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 0 {}", "", false, "numeric-boundaries-2156",
  )
  check_search_case(
    "set v 2;catch {lsearch -exact -integer [list $v] $v} r;list $r [format %.17g $v]",
    "0 2", "", false, "representations-2157",
  )
  check_search_case(
    "set v [expr {2.0}];catch {lsearch -exact -integer [list $v] $v} r;list $r [format %.17g $v]",
    "{expected integer but got \"2.0\"} 2", "", false, "representations-2158",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;catch {lsearch -exact -integer [list $v] $v} r;list $r [format %.17g $v]",
    "{expected integer but got \"1.844674407370955e+19\"} 1.8446744073709552e+19",
    "", false, "representations-2159",
  )
}

///|
test "Tcl search cases 2161 through 2200" {
  check_search_case(
    "set v [expr {18446744073709551615}];catch {lsearch -exact -integer [list $v] $v} r;list $r [format %.17g $v]",
    "0 1.8446744073709552e+19", "", false, "representations-2160",
  )
  check_search_case(
    "set v 2;catch {lsearch -exact -real [list $v] $v} r;list $r [format %.17g $v]",
    "0 2", "", false, "representations-2161",
  )
  check_search_case(
    "set v [expr {2.0}];catch {lsearch -exact -real [list $v] $v} r;list $r [format %.17g $v]",
    "0 2", "", false, "representations-2162",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;catch {lsearch -exact -real [list $v] $v} r;list $r [format %.17g $v]",
    "0 1.8446744073709552e+19", "", false, "representations-2163",
  )
  check_search_case(
    "set v [expr {18446744073709551615}];catch {lsearch -exact -real [list $v] $v} r;list $r [format %.17g $v]",
    "0 1.8446744073709552e+19", "", false, "representations-2164",
  )
  check_search_case(
    "set v 2;catch {lsearch -regexp [list $v] .*} r;list $r [format %.17g $v]", "0 2",
    "", false, "representations-2165",
  )
  check_search_case(
    "set v [expr {2.0}];catch {lsearch -regexp [list $v] .*} r;list $r [format %.17g $v]",
    "0 2", "", false, "representations-2166",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;catch {lsearch -regexp [list $v] .*} r;list $r [format %.17g $v]",
    "0 1.8446744073709552e+19", "", false, "representations-2167",
  )
  check_search_case(
    "set v [expr {18446744073709551615}];catch {lsearch -regexp [list $v] .*} r;list $r [format %.17g $v]",
    "0 1.8446744073709552e+19", "", false, "representations-2168",
  )
  check_search_case(
    "set v 2;catch {lsearch -regexp [list 1] $v} r;list $r [format %.17g $v]", "-1 2",
    "", false, "representations-2169",
  )
  check_search_case(
    "set v [expr {2.0}];catch {lsearch -regexp [list 1] $v} r;list $r [format %.17g $v]",
    "-1 2", "", false, "representations-2170",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;catch {lsearch -regexp [list 1] $v} r;list $r [format %.17g $v]",
    "-1 1.844674407370955e+19", "", false, "representations-2171",
  )
  check_search_case(
    "set v [expr {18446744073709551615}];catch {lsearch -regexp [list 1] $v} r;list $r [format %.17g $v]",
    "-1 1.8446744073709552e+19", "", false, "representations-2172",
  )
  check_search_case(
    "set v 2;catch {lsearch -exact $v $v} r;list $r [format %.17g $v]", "0 2", "",
    false, "representations-2173",
  )
  check_search_case(
    "set v [expr {2.0}];catch {lsearch -exact $v $v} r;list $r [format %.17g $v]",
    "0 2", "", false, "representations-2174",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;catch {lsearch -exact $v $v} r;list $r [format %.17g $v]",
    "0 1.844674407370955e+19", "", false, "representations-2175",
  )
  check_search_case(
    "set v [expr {18446744073709551615}];catch {lsearch -exact $v $v} r;list $r [format %.17g $v]",
    "0 1.8446744073709552e+19", "", false, "representations-2176",
  )
  check_search_case(
    "set v 2;catch {lsearch -exact -integer $v $v} r;list $r [format %.17g $v]",
    "0 2", "", false, "representations-2177",
  )
  check_search_case(
    "set v [expr {2.0}];catch {lsearch -exact -integer $v $v} r;list $r [format %.17g $v]",
    "{expected integer but got \"2.0\"} 2", "", false, "representations-2178",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;catch {lsearch -exact -integer $v $v} r;list $r [format %.17g $v]",
    "{expected integer but got \"1.844674407370955e+19\"} 1.844674407370955e+19",
    "", false, "representations-2179",
  )
  check_search_case(
    "set v [expr {18446744073709551615}];catch {lsearch -exact -integer $v $v} r;list $r [format %.17g $v]",
    "0 1.8446744073709552e+19", "", false, "representations-2180",
  )
  check_search_case(
    "set v 2;catch {lsearch -start $v $v $v} r;list $r [format %.17g $v]", "-1 2",
    "", false, "representations-2181",
  )
  check_search_case(
    "set v [expr {2.0}];catch {lsearch -start $v $v $v} r;list $r [format %.17g $v]",
    "{bad index \"2.0\": must be integer?[+-]integer? or end?[+-]integer?} 2", "",
    false, "representations-2182",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;catch {lsearch -start $v $v $v} r;list $r [format %.17g $v]",
    "{bad index \"1.844674407370955e+19\": must be integer?[+-]integer? or end?[+-]integer?} 1.844674407370955e+19",
    "", false, "representations-2183",
  )
  check_search_case(
    "set v [expr {18446744073709551615}];catch {lsearch -start $v $v $v} r;list $r [format %.17g $v]",
    "{bad index \"18446744073709551615\": must be integer?[+-]integer? or end?[+-]integer?} 1.8446744073709552e+19",
    "", false, "representations-2184",
  )
  check_search_case(
    "lsort -dictionary  [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\"]", "A1 a1 a01 a001 a2 a10",
    "", false, "dictionary-sort-2185",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\"]",
    "A1 a1 a01 a001 a2 a10", "", false, "dictionary-sort-2186",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\"]",
    "A1 a1 a01 a001 a2 a10", "", false, "dictionary-sort-2187",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\"]",
    "a10 a2 a001 a01 a1 A1", "", false, "dictionary-sort-2188",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\"]",
    "a10 a2 a001 a01 a1 A1", "", false, "dictionary-sort-2189",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"K\" \"k\"]", "K K k", "", false, "dictionary-sort-2190",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"K\" \"K\" \"k\"]", "K K k", "", false,
    "dictionary-sort-2191",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"K\" \"k\"]", "K k", "", false, "dictionary-sort-2192",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"K\" \"K\" \"k\"]", "k K K", "", false,
    "dictionary-sort-2193",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"K\" \"k\"]", "k K", "",
    false, "dictionary-sort-2194",
  )
  check_search_case(
    "lsort -dictionary  [list \"İ\" \"i\" \"I\" \"ı\"]", "İ I i ı", "", false,
    "dictionary-sort-2195",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"İ\" \"i\" \"I\" \"ı\"]", "İ I i ı", "",
    false, "dictionary-sort-2196",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"İ\" \"i\" \"I\" \"ı\"]", "I i ı", "", false,
    "dictionary-sort-2197",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"İ\" \"i\" \"I\" \"ı\"]", "ı i İ I",
    "", false, "dictionary-sort-2198",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"İ\" \"i\" \"I\" \"ı\"]", "ı i I",
    "", false, "dictionary-sort-2199",
  )
}

///|
test "Tcl search cases 2201 through 2240" {
  check_search_case(
    "lsort -dictionary  [list \"Ǆ\" \"ǅ\" \"ǆ\"]", "Ǆ ǅ ǆ", "", false, "dictionary-sort-2200",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"Ǆ\" \"ǅ\" \"ǆ\"]", "Ǆ ǅ ǆ", "", false,
    "dictionary-sort-2201",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"Ǆ\" \"ǅ\" \"ǆ\"]", "ǆ", "", false, "dictionary-sort-2202",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"Ǆ\" \"ǅ\" \"ǆ\"]", "ǆ Ǆ ǅ", "",
    false, "dictionary-sort-2203",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"Ǆ\" \"ǅ\" \"ǆ\"]", "ǆ", "",
    false, "dictionary-sort-2204",
  )
  check_search_case(
    "lsort -dictionary  [list \"𐐨\" \"𐐀\" \"𐐩\" \"𐐁\"]", "𐐀 𐐁 𐐨 𐐩",
    "", false, "dictionary-sort-2205",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"𐐨\" \"𐐀\" \"𐐩\" \"𐐁\"]", "𐐀 𐐁 𐐨 𐐩",
    "", false, "dictionary-sort-2206",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"𐐨\" \"𐐀\" \"𐐩\" \"𐐁\"]", "𐐀 𐐁 𐐨 𐐩",
    "", false, "dictionary-sort-2207",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"𐐨\" \"𐐀\" \"𐐩\" \"𐐁\"]", "𐐩 𐐨 𐐁 𐐀",
    "", false, "dictionary-sort-2208",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"𐐨\" \"𐐀\" \"𐐩\" \"𐐁\"]",
    "𐐩 𐐨 𐐁 𐐀", "", false, "dictionary-sort-2209",
  )
  check_search_case(
    "lsort -dictionary  [list \"😀\" \"\" \"￿\" \"a\"]", "a  ￿ 😀",
    "", false, "dictionary-sort-2210",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"😀\" \"\" \"￿\" \"a\"]", "a  ￿ 😀",
    "", false, "dictionary-sort-2211",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"😀\" \"\" \"￿\" \"a\"]", "a  ￿ 😀",
    "", false, "dictionary-sort-2212",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"😀\" \"\" \"￿\" \"a\"]", "😀 ￿  a",
    "", false, "dictionary-sort-2213",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"😀\" \"\" \"￿\" \"a\"]",
    "😀 ￿  a", "", false, "dictionary-sort-2214",
  )
  check_search_case(
    "lsort -dictionary  [list \"a\" \"a\\x00b\" \"a\\x00A\" \"a\\x00\"]", "a a\u0000 a\u0000A a\u0000b",
    "", false, "dictionary-sort-2215",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"a\" \"a\\x00b\" \"a\\x00A\" \"a\\x00\"]",
    "a a\u0000 a\u0000A a\u0000b", "", false, "dictionary-sort-2216",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"a\" \"a\\x00b\" \"a\\x00A\" \"a\\x00\"]",
    "a a\u0000 a\u0000A a\u0000b", "", false, "dictionary-sort-2217",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"a\" \"a\\x00b\" \"a\\x00A\" \"a\\x00\"]",
    "a\u0000b a\u0000A a\u0000 a", "", false, "dictionary-sort-2218",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"a\" \"a\\x00b\" \"a\\x00A\" \"a\\x00\"]",
    "a\u0000b a\u0000A a\u0000 a", "", false, "dictionary-sort-2219",
  )
  check_search_case(
    "lsort -dictionary  [list \"x9\" \"x100\" \"x000100\" \"X100\" \"x01z9\" \"x1z10\"]",
    "x01z9 x1z10 x9 X100 x100 x000100", "", false, "dictionary-sort-2220",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"x9\" \"x100\" \"x000100\" \"X100\" \"x01z9\" \"x1z10\"]",
    "x01z9 x1z10 x9 X100 x100 x000100", "", false, "dictionary-sort-2221",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"x9\" \"x100\" \"x000100\" \"X100\" \"x01z9\" \"x1z10\"]",
    "x01z9 x1z10 x9 X100 x100 x000100", "", false, "dictionary-sort-2222",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"x9\" \"x100\" \"x000100\" \"X100\" \"x01z9\" \"x1z10\"]",
    "x000100 x100 X100 x9 x1z10 x01z9", "", false, "dictionary-sort-2223",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"x9\" \"x100\" \"x000100\" \"X100\" \"x01z9\" \"x1z10\"]",
    "x000100 x100 X100 x9 x1z10 x01z9", "", false, "dictionary-sort-2224",
  )
  check_search_case(
    "lsort -dictionary  [list \"2\" \"２\" \"٢\" \"10\" \"010\"]", "2 10 010 ٢ ２",
    "", false, "dictionary-sort-2225",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"2\" \"２\" \"٢\" \"10\" \"010\"]", "2 10 010 ٢ ２",
    "", false, "dictionary-sort-2226",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"2\" \"２\" \"٢\" \"10\" \"010\"]", "2 10 010 ٢ ２",
    "", false, "dictionary-sort-2227",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"2\" \"２\" \"٢\" \"10\" \"010\"]", "２ ٢ 010 10 2",
    "", false, "dictionary-sort-2228",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"2\" \"２\" \"٢\" \"10\" \"010\"]",
    "２ ٢ 010 10 2", "", false, "dictionary-sort-2229",
  )
  check_search_case(
    "lsort -dictionary  [list \"x9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999\" \"x10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000\" \"x0001\" \"X1\"]",
    "X1 x0001 x9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999 x10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
    "", false, "dictionary-sort-2230",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"x9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999\" \"x10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000\" \"x0001\" \"X1\"]",
    "X1 x0001 x9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999 x10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
    "", false, "dictionary-sort-2231",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"x9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999\" \"x10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000\" \"x0001\" \"X1\"]",
    "X1 x0001 x9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999 x10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
    "", false, "dictionary-sort-2232",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"x9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999\" \"x10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000\" \"x0001\" \"X1\"]",
    "x10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 x9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999 x0001 X1",
    "", false, "dictionary-sort-2233",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"x9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999\" \"x10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000\" \"x0001\" \"X1\"]",
    "x10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 x9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999 x0001 X1",
    "", false, "dictionary-sort-2234",
  )
  check_search_case(
    "lsort -dictionary  [list \"-aA-9\" \"--2A20_1b1K2a0\" \"Kak9AK__b-Ak-2\" \"-a\" \"A910_0kk\" \"2a0KK9_9\" \"-2299AkKk-BA-\" \"\" \"92_BKa-kB\" \"a_KBKaK0b222b\" \"A-Ab2A2Bk1a\" \"a9_2BBBAK1B00\" \"BBAba0K-BbAB_KB\" \"_B19922_1_\" \"k0k_KBa29\" \"b_aB9BKA2102k2\" \"2b2bab\" \"-A12\"]",
    "{} --2A20_1b1K2a0 -2299AkKk-BA- -a -A12 -aA-9 2a0KK9_9 2b2bab 92_BKa-kB _B19922_1_ A-Ab2A2Bk1a a9_2BBBAK1B00 A910_0kk a_KBKaK0b222b b_aB9BKA2102k2 BBAba0K-BbAB_KB k0k_KBa29 Kak9AK__b-Ak-2",
    "", false, "dictionary-sort-2235",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"-aA-9\" \"--2A20_1b1K2a0\" \"Kak9AK__b-Ak-2\" \"-a\" \"A910_0kk\" \"2a0KK9_9\" \"-2299AkKk-BA-\" \"\" \"92_BKa-kB\" \"a_KBKaK0b222b\" \"A-Ab2A2Bk1a\" \"a9_2BBBAK1B00\" \"BBAba0K-BbAB_KB\" \"_B19922_1_\" \"k0k_KBa29\" \"b_aB9BKA2102k2\" \"2b2bab\" \"-A12\"]",
    "{} --2A20_1b1K2a0 -2299AkKk-BA- -a -A12 -aA-9 2a0KK9_9 2b2bab 92_BKa-kB _B19922_1_ A-Ab2A2Bk1a a9_2BBBAK1B00 A910_0kk a_KBKaK0b222b b_aB9BKA2102k2 BBAba0K-BbAB_KB k0k_KBa29 Kak9AK__b-Ak-2",
    "", false, "dictionary-sort-2236",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"-aA-9\" \"--2A20_1b1K2a0\" \"Kak9AK__b-Ak-2\" \"-a\" \"A910_0kk\" \"2a0KK9_9\" \"-2299AkKk-BA-\" \"\" \"92_BKa-kB\" \"a_KBKaK0b222b\" \"A-Ab2A2Bk1a\" \"a9_2BBBAK1B00\" \"BBAba0K-BbAB_KB\" \"_B19922_1_\" \"k0k_KBa29\" \"b_aB9BKA2102k2\" \"2b2bab\" \"-A12\"]",
    "{} --2A20_1b1K2a0 -2299AkKk-BA- -a -A12 -aA-9 2a0KK9_9 2b2bab 92_BKa-kB _B19922_1_ A-Ab2A2Bk1a a9_2BBBAK1B00 A910_0kk a_KBKaK0b222b b_aB9BKA2102k2 BBAba0K-BbAB_KB k0k_KBa29 Kak9AK__b-Ak-2",
    "", false, "dictionary-sort-2237",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"-aA-9\" \"--2A20_1b1K2a0\" \"Kak9AK__b-Ak-2\" \"-a\" \"A910_0kk\" \"2a0KK9_9\" \"-2299AkKk-BA-\" \"\" \"92_BKa-kB\" \"a_KBKaK0b222b\" \"A-Ab2A2Bk1a\" \"a9_2BBBAK1B00\" \"BBAba0K-BbAB_KB\" \"_B19922_1_\" \"k0k_KBa29\" \"b_aB9BKA2102k2\" \"2b2bab\" \"-A12\"]",
    "Kak9AK__b-Ak-2 k0k_KBa29 BBAba0K-BbAB_KB b_aB9BKA2102k2 a_KBKaK0b222b A910_0kk a9_2BBBAK1B00 A-Ab2A2Bk1a _B19922_1_ 92_BKa-kB 2b2bab 2a0KK9_9 -aA-9 -A12 -a -2299AkKk-BA- --2A20_1b1K2a0 {}",
    "", false, "dictionary-sort-2238",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"-aA-9\" \"--2A20_1b1K2a0\" \"Kak9AK__b-Ak-2\" \"-a\" \"A910_0kk\" \"2a0KK9_9\" \"-2299AkKk-BA-\" \"\" \"92_BKa-kB\" \"a_KBKaK0b222b\" \"A-Ab2A2Bk1a\" \"a9_2BBBAK1B00\" \"BBAba0K-BbAB_KB\" \"_B19922_1_\" \"k0k_KBa29\" \"b_aB9BKA2102k2\" \"2b2bab\" \"-A12\"]",
    "Kak9AK__b-Ak-2 k0k_KBa29 BBAba0K-BbAB_KB b_aB9BKA2102k2 a_KBKaK0b222b A910_0kk a9_2BBBAK1B00 A-Ab2A2Bk1a _B19922_1_ 92_BKa-kB 2b2bab 2a0KK9_9 -aA-9 -A12 -a -2299AkKk-BA- --2A20_1b1K2a0 {}",
    "", false, "dictionary-sort-2239",
  )
}

///|
test "Tcl search cases 2241 through 2280" {
  check_search_case(
    "lsort -dictionary  [list \"2k0KBkaK9-2bB\" \"Ab2b_B21\" \"9bbab\" \"K_-b-0KBKK--kAA\" \"2A1k9AAB\" \"-0A_BK0K1BAaA1\" \"12BA0_\" \"k_Kk0-_90a0\" \"1191aBaB9a0\" \"-B2aK292\" \"kkBa\" \"B_B_1BKAk\" \"_a\" \"k-KK0baAa\" \"\" \"2BkB\" \"KBb-K1kA-\" \"01_Bb9AA_9b\"]",
    "{} -0A_BK0K1BAaA1 -B2aK292 01_Bb9AA_9b 2A1k9AAB 2BkB 2k0KBkaK9-2bB 9bbab 12BA0_ 1191aBaB9a0 _a Ab2b_B21 B_B_1BKAk k-KK0baAa K_-b-0KBKK--kAA k_Kk0-_90a0 KBb-K1kA- kkBa",
    "", false, "dictionary-sort-2240",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"2k0KBkaK9-2bB\" \"Ab2b_B21\" \"9bbab\" \"K_-b-0KBKK--kAA\" \"2A1k9AAB\" \"-0A_BK0K1BAaA1\" \"12BA0_\" \"k_Kk0-_90a0\" \"1191aBaB9a0\" \"-B2aK292\" \"kkBa\" \"B_B_1BKAk\" \"_a\" \"k-KK0baAa\" \"\" \"2BkB\" \"KBb-K1kA-\" \"01_Bb9AA_9b\"]",
    "{} -0A_BK0K1BAaA1 -B2aK292 01_Bb9AA_9b 2A1k9AAB 2BkB 2k0KBkaK9-2bB 9bbab 12BA0_ 1191aBaB9a0 _a Ab2b_B21 B_B_1BKAk k-KK0baAa K_-b-0KBKK--kAA k_Kk0-_90a0 KBb-K1kA- kkBa",
    "", false, "dictionary-sort-2241",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"2k0KBkaK9-2bB\" \"Ab2b_B21\" \"9bbab\" \"K_-b-0KBKK--kAA\" \"2A1k9AAB\" \"-0A_BK0K1BAaA1\" \"12BA0_\" \"k_Kk0-_90a0\" \"1191aBaB9a0\" \"-B2aK292\" \"kkBa\" \"B_B_1BKAk\" \"_a\" \"k-KK0baAa\" \"\" \"2BkB\" \"KBb-K1kA-\" \"01_Bb9AA_9b\"]",
    "{} -0A_BK0K1BAaA1 -B2aK292 01_Bb9AA_9b 2A1k9AAB 2BkB 2k0KBkaK9-2bB 9bbab 12BA0_ 1191aBaB9a0 _a Ab2b_B21 B_B_1BKAk k-KK0baAa K_-b-0KBKK--kAA k_Kk0-_90a0 KBb-K1kA- kkBa",
    "", false, "dictionary-sort-2242",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"2k0KBkaK9-2bB\" \"Ab2b_B21\" \"9bbab\" \"K_-b-0KBKK--kAA\" \"2A1k9AAB\" \"-0A_BK0K1BAaA1\" \"12BA0_\" \"k_Kk0-_90a0\" \"1191aBaB9a0\" \"-B2aK292\" \"kkBa\" \"B_B_1BKAk\" \"_a\" \"k-KK0baAa\" \"\" \"2BkB\" \"KBb-K1kA-\" \"01_Bb9AA_9b\"]",
    "kkBa KBb-K1kA- k_Kk0-_90a0 K_-b-0KBKK--kAA k-KK0baAa B_B_1BKAk Ab2b_B21 _a 1191aBaB9a0 12BA0_ 9bbab 2k0KBkaK9-2bB 2BkB 2A1k9AAB 01_Bb9AA_9b -B2aK292 -0A_BK0K1BAaA1 {}",
    "", false, "dictionary-sort-2243",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"2k0KBkaK9-2bB\" \"Ab2b_B21\" \"9bbab\" \"K_-b-0KBKK--kAA\" \"2A1k9AAB\" \"-0A_BK0K1BAaA1\" \"12BA0_\" \"k_Kk0-_90a0\" \"1191aBaB9a0\" \"-B2aK292\" \"kkBa\" \"B_B_1BKAk\" \"_a\" \"k-KK0baAa\" \"\" \"2BkB\" \"KBb-K1kA-\" \"01_Bb9AA_9b\"]",
    "kkBa KBb-K1kA- k_Kk0-_90a0 K_-b-0KBKK--kAA k-KK0baAa B_B_1BKAk Ab2b_B21 _a 1191aBaB9a0 12BA0_ 9bbab 2k0KBkaK9-2bB 2BkB 2A1k9AAB 01_Bb9AA_9b -B2aK292 -0A_BK0K1BAaA1 {}",
    "", false, "dictionary-sort-2244",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"1Kb\" \"1Kk9-KAaaAkK21a\" \"92\" \"9ab_20-\" \"_1bka0001k\" \"b9\" \"0_2a\" \"A0\" \"K9a-2K9KBkAK1K\" \"B9ka\" \"kBBA9\" \"A02ABKaA\" \"aa\" \"21K\" \"kA\" \"KBKKa-B90B1A2\" \"11\"]",
    "0_2a 1Kb 1Kk9-KAaaAkK21a 9ab_20- 11 21K 92 _1bka0001k A0 A02ABKaA aa b9 B9ka K K9a-2K9KBkAK1K kA kBBA9 KBKKa-B90B1A2",
    "", false, "dictionary-sort-2245",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"K\" \"1Kb\" \"1Kk9-KAaaAkK21a\" \"92\" \"9ab_20-\" \"_1bka0001k\" \"b9\" \"0_2a\" \"A0\" \"K9a-2K9KBkAK1K\" \"B9ka\" \"kBBA9\" \"A02ABKaA\" \"aa\" \"21K\" \"kA\" \"KBKKa-B90B1A2\" \"11\"]",
    "0_2a 1Kb 1Kk9-KAaaAkK21a 9ab_20- 11 21K 92 _1bka0001k A0 A02ABKaA aa b9 B9ka K K9a-2K9KBkAK1K kA kBBA9 KBKKa-B90B1A2",
    "", false, "dictionary-sort-2246",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"1Kb\" \"1Kk9-KAaaAkK21a\" \"92\" \"9ab_20-\" \"_1bka0001k\" \"b9\" \"0_2a\" \"A0\" \"K9a-2K9KBkAK1K\" \"B9ka\" \"kBBA9\" \"A02ABKaA\" \"aa\" \"21K\" \"kA\" \"KBKKa-B90B1A2\" \"11\"]",
    "0_2a 1Kb 1Kk9-KAaaAkK21a 9ab_20- 11 21K 92 _1bka0001k A0 A02ABKaA aa b9 B9ka K K9a-2K9KBkAK1K kA kBBA9 KBKKa-B90B1A2",
    "", false, "dictionary-sort-2247",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"K\" \"1Kb\" \"1Kk9-KAaaAkK21a\" \"92\" \"9ab_20-\" \"_1bka0001k\" \"b9\" \"0_2a\" \"A0\" \"K9a-2K9KBkAK1K\" \"B9ka\" \"kBBA9\" \"A02ABKaA\" \"aa\" \"21K\" \"kA\" \"KBKKa-B90B1A2\" \"11\"]",
    "KBKKa-B90B1A2 kBBA9 kA K9a-2K9KBkAK1K K B9ka b9 aa A02ABKaA A0 _1bka0001k 92 21K 11 9ab_20- 1Kk9-KAaaAkK21a 1Kb 0_2a",
    "", false, "dictionary-sort-2248",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"1Kb\" \"1Kk9-KAaaAkK21a\" \"92\" \"9ab_20-\" \"_1bka0001k\" \"b9\" \"0_2a\" \"A0\" \"K9a-2K9KBkAK1K\" \"B9ka\" \"kBBA9\" \"A02ABKaA\" \"aa\" \"21K\" \"kA\" \"KBKKa-B90B1A2\" \"11\"]",
    "KBKKa-B90B1A2 kBBA9 kA K9a-2K9KBkAK1K K B9ka b9 aa A02ABKaA A0 _1bka0001k 92 21K 11 9ab_20- 1Kk9-KAaaAkK21a 1Kb 0_2a",
    "", false, "dictionary-sort-2249",
  )
  check_search_case(
    "lsort -dictionary  [list \"KK\" \"K-b990\" \"-k12910Kab1\" \"\" \"B0abBbkA9292B1\" \"2A0_A_k92A\" \"kA9-BA0\" \"__1\" \"K-Kb01a\" \"B\" \"0k02k9\" \"099-Bkbb_2KK-21\" \"2_0a1Aa_KbA_2\" \"09-K9K_2_2\" \"BK-A-0\" \"0KBB\" \"\" \"-BA_99Ka_B\"]",
    "{} {} -BA_99Ka_B -k12910Kab1 0k02k9 0KBB 2_0a1Aa_KbA_2 2A0_A_k92A 09-K9K_2_2 099-Bkbb_2KK-21 __1 B B0abBbkA9292B1 BK-A-0 K-b990 K-Kb01a kA9-BA0 KK",
    "", false, "dictionary-sort-2250",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"KK\" \"K-b990\" \"-k12910Kab1\" \"\" \"B0abBbkA9292B1\" \"2A0_A_k92A\" \"kA9-BA0\" \"__1\" \"K-Kb01a\" \"B\" \"0k02k9\" \"099-Bkbb_2KK-21\" \"2_0a1Aa_KbA_2\" \"09-K9K_2_2\" \"BK-A-0\" \"0KBB\" \"\" \"-BA_99Ka_B\"]",
    "{} {} -BA_99Ka_B -k12910Kab1 0k02k9 0KBB 2_0a1Aa_KbA_2 2A0_A_k92A 09-K9K_2_2 099-Bkbb_2KK-21 __1 B B0abBbkA9292B1 BK-A-0 K-b990 K-Kb01a kA9-BA0 KK",
    "", false, "dictionary-sort-2251",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"KK\" \"K-b990\" \"-k12910Kab1\" \"\" \"B0abBbkA9292B1\" \"2A0_A_k92A\" \"kA9-BA0\" \"__1\" \"K-Kb01a\" \"B\" \"0k02k9\" \"099-Bkbb_2KK-21\" \"2_0a1Aa_KbA_2\" \"09-K9K_2_2\" \"BK-A-0\" \"0KBB\" \"\" \"-BA_99Ka_B\"]",
    "{} -BA_99Ka_B -k12910Kab1 0k02k9 0KBB 2_0a1Aa_KbA_2 2A0_A_k92A 09-K9K_2_2 099-Bkbb_2KK-21 __1 B B0abBbkA9292B1 BK-A-0 K-b990 K-Kb01a kA9-BA0 KK",
    "", false, "dictionary-sort-2252",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"KK\" \"K-b990\" \"-k12910Kab1\" \"\" \"B0abBbkA9292B1\" \"2A0_A_k92A\" \"kA9-BA0\" \"__1\" \"K-Kb01a\" \"B\" \"0k02k9\" \"099-Bkbb_2KK-21\" \"2_0a1Aa_KbA_2\" \"09-K9K_2_2\" \"BK-A-0\" \"0KBB\" \"\" \"-BA_99Ka_B\"]",
    "KK kA9-BA0 K-Kb01a K-b990 BK-A-0 B0abBbkA9292B1 B __1 099-Bkbb_2KK-21 09-K9K_2_2 2A0_A_k92A 2_0a1Aa_KbA_2 0KBB 0k02k9 -k12910Kab1 -BA_99Ka_B {} {}",
    "", false, "dictionary-sort-2253",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"KK\" \"K-b990\" \"-k12910Kab1\" \"\" \"B0abBbkA9292B1\" \"2A0_A_k92A\" \"kA9-BA0\" \"__1\" \"K-Kb01a\" \"B\" \"0k02k9\" \"099-Bkbb_2KK-21\" \"2_0a1Aa_KbA_2\" \"09-K9K_2_2\" \"BK-A-0\" \"0KBB\" \"\" \"-BA_99Ka_B\"]",
    "KK kA9-BA0 K-Kb01a K-b990 BK-A-0 B0abBbkA9292B1 B __1 099-Bkbb_2KK-21 09-K9K_2_2 2A0_A_k92A 2_0a1Aa_KbA_2 0KBB 0k02k9 -k12910Kab1 -BA_99Ka_B {}",
    "", false, "dictionary-sort-2254",
  )
  check_search_case(
    "lsort -dictionary  [list \"0Ba0aa__9A\" \"_9_k2BKk\" \"\" \"9a\" \"B19__2_bkkK_K\" \"K-_991-akbA2\" \"KB0-\" \"9bBk2ak_21A\" \"kK_a_29kbaBaKA\" \"bB0A2a--B\" \"--BB\" \"1_AAk2109\" \"k29-_0K9kB_9k\" \"b-9K0B2B0\" \"0b1a0_0-_\" \"-AB10-02-K_99\" \"K29Aba2b\" \"00A-2_B9-1B92\"]",
    "{} --BB -AB10-02-K_99 00A-2_B9-1B92 0b1a0_0-_ 0Ba0aa__9A 1_AAk2109 9a 9bBk2ak_21A _9_k2BKk b-9K0B2B0 B19__2_bkkK_K bB0A2a--B K-_991-akbA2 k29-_0K9kB_9k K29Aba2b KB0- kK_a_29kbaBaKA",
    "", false, "dictionary-sort-2255",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"0Ba0aa__9A\" \"_9_k2BKk\" \"\" \"9a\" \"B19__2_bkkK_K\" \"K-_991-akbA2\" \"KB0-\" \"9bBk2ak_21A\" \"kK_a_29kbaBaKA\" \"bB0A2a--B\" \"--BB\" \"1_AAk2109\" \"k29-_0K9kB_9k\" \"b-9K0B2B0\" \"0b1a0_0-_\" \"-AB10-02-K_99\" \"K29Aba2b\" \"00A-2_B9-1B92\"]",
    "{} --BB -AB10-02-K_99 00A-2_B9-1B92 0b1a0_0-_ 0Ba0aa__9A 1_AAk2109 9a 9bBk2ak_21A _9_k2BKk b-9K0B2B0 B19__2_bkkK_K bB0A2a--B K-_991-akbA2 k29-_0K9kB_9k K29Aba2b KB0- kK_a_29kbaBaKA",
    "", false, "dictionary-sort-2256",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"0Ba0aa__9A\" \"_9_k2BKk\" \"\" \"9a\" \"B19__2_bkkK_K\" \"K-_991-akbA2\" \"KB0-\" \"9bBk2ak_21A\" \"kK_a_29kbaBaKA\" \"bB0A2a--B\" \"--BB\" \"1_AAk2109\" \"k29-_0K9kB_9k\" \"b-9K0B2B0\" \"0b1a0_0-_\" \"-AB10-02-K_99\" \"K29Aba2b\" \"00A-2_B9-1B92\"]",
    "{} --BB -AB10-02-K_99 00A-2_B9-1B92 0b1a0_0-_ 0Ba0aa__9A 1_AAk2109 9a 9bBk2ak_21A _9_k2BKk b-9K0B2B0 B19__2_bkkK_K bB0A2a--B K-_991-akbA2 k29-_0K9kB_9k K29Aba2b KB0- kK_a_29kbaBaKA",
    "", false, "dictionary-sort-2257",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"0Ba0aa__9A\" \"_9_k2BKk\" \"\" \"9a\" \"B19__2_bkkK_K\" \"K-_991-akbA2\" \"KB0-\" \"9bBk2ak_21A\" \"kK_a_29kbaBaKA\" \"bB0A2a--B\" \"--BB\" \"1_AAk2109\" \"k29-_0K9kB_9k\" \"b-9K0B2B0\" \"0b1a0_0-_\" \"-AB10-02-K_99\" \"K29Aba2b\" \"00A-2_B9-1B92\"]",
    "kK_a_29kbaBaKA KB0- K29Aba2b k29-_0K9kB_9k K-_991-akbA2 bB0A2a--B B19__2_bkkK_K b-9K0B2B0 _9_k2BKk 9bBk2ak_21A 9a 1_AAk2109 0Ba0aa__9A 0b1a0_0-_ 00A-2_B9-1B92 -AB10-02-K_99 --BB {}",
    "", false, "dictionary-sort-2258",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"0Ba0aa__9A\" \"_9_k2BKk\" \"\" \"9a\" \"B19__2_bkkK_K\" \"K-_991-akbA2\" \"KB0-\" \"9bBk2ak_21A\" \"kK_a_29kbaBaKA\" \"bB0A2a--B\" \"--BB\" \"1_AAk2109\" \"k29-_0K9kB_9k\" \"b-9K0B2B0\" \"0b1a0_0-_\" \"-AB10-02-K_99\" \"K29Aba2b\" \"00A-2_B9-1B92\"]",
    "kK_a_29kbaBaKA KB0- K29Aba2b k29-_0K9kB_9k K-_991-akbA2 bB0A2a--B B19__2_bkkK_K b-9K0B2B0 _9_k2BKk 9bBk2ak_21A 9a 1_AAk2109 0Ba0aa__9A 0b1a0_0-_ 00A-2_B9-1B92 -AB10-02-K_99 --BB {}",
    "", false, "dictionary-sort-2259",
  )
  check_search_case(
    "lsort -dictionary  [list \"0a0_BaA2aBBB9\" \"11kK9k92291k10\" \"-0Kk2102\" \"BBk9\" \"1\" \"1K92-1kKkbb-\" \"_1092Ak\" \"b2K_\" \"bKBAabA12-\" \"11a02Aa_9B20k20\" \"Aak0k9bKkB19\" \"-BbBK\" \"b1b9_BAB__k\" \"K\" \"9kAa-2KA2\" \"1\" \"-B22KkA9Ab2B1k\" \"9Bk-0bkA2AB-1\"]",
    "-0Kk2102 -B22KkA9Ab2B1k -BbBK 0a0_BaA2aBBB9 1 1 1K92-1kKkbb- 9Bk-0bkA2AB-1 9kAa-2KA2 11a02Aa_9B20k20 11kK9k92291k10 _1092Ak Aak0k9bKkB19 b1b9_BAB__k b2K_ BBk9 bKBAabA12- K",
    "", false, "dictionary-sort-2260",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"0a0_BaA2aBBB9\" \"11kK9k92291k10\" \"-0Kk2102\" \"BBk9\" \"1\" \"1K92-1kKkbb-\" \"_1092Ak\" \"b2K_\" \"bKBAabA12-\" \"11a02Aa_9B20k20\" \"Aak0k9bKkB19\" \"-BbBK\" \"b1b9_BAB__k\" \"K\" \"9kAa-2KA2\" \"1\" \"-B22KkA9Ab2B1k\" \"9Bk-0bkA2AB-1\"]",
    "-0Kk2102 -B22KkA9Ab2B1k -BbBK 0a0_BaA2aBBB9 1 1 1K92-1kKkbb- 9Bk-0bkA2AB-1 9kAa-2KA2 11a02Aa_9B20k20 11kK9k92291k10 _1092Ak Aak0k9bKkB19 b1b9_BAB__k b2K_ BBk9 bKBAabA12- K",
    "", false, "dictionary-sort-2261",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"0a0_BaA2aBBB9\" \"11kK9k92291k10\" \"-0Kk2102\" \"BBk9\" \"1\" \"1K92-1kKkbb-\" \"_1092Ak\" \"b2K_\" \"bKBAabA12-\" \"11a02Aa_9B20k20\" \"Aak0k9bKkB19\" \"-BbBK\" \"b1b9_BAB__k\" \"K\" \"9kAa-2KA2\" \"1\" \"-B22KkA9Ab2B1k\" \"9Bk-0bkA2AB-1\"]",
    "-0Kk2102 -B22KkA9Ab2B1k -BbBK 0a0_BaA2aBBB9 1 1K92-1kKkbb- 9Bk-0bkA2AB-1 9kAa-2KA2 11a02Aa_9B20k20 11kK9k92291k10 _1092Ak Aak0k9bKkB19 b1b9_BAB__k b2K_ BBk9 bKBAabA12- K",
    "", false, "dictionary-sort-2262",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"0a0_BaA2aBBB9\" \"11kK9k92291k10\" \"-0Kk2102\" \"BBk9\" \"1\" \"1K92-1kKkbb-\" \"_1092Ak\" \"b2K_\" \"bKBAabA12-\" \"11a02Aa_9B20k20\" \"Aak0k9bKkB19\" \"-BbBK\" \"b1b9_BAB__k\" \"K\" \"9kAa-2KA2\" \"1\" \"-B22KkA9Ab2B1k\" \"9Bk-0bkA2AB-1\"]",
    "K bKBAabA12- BBk9 b2K_ b1b9_BAB__k Aak0k9bKkB19 _1092Ak 11kK9k92291k10 11a02Aa_9B20k20 9kAa-2KA2 9Bk-0bkA2AB-1 1K92-1kKkbb- 1 1 0a0_BaA2aBBB9 -BbBK -B22KkA9Ab2B1k -0Kk2102",
    "", false, "dictionary-sort-2263",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"0a0_BaA2aBBB9\" \"11kK9k92291k10\" \"-0Kk2102\" \"BBk9\" \"1\" \"1K92-1kKkbb-\" \"_1092Ak\" \"b2K_\" \"bKBAabA12-\" \"11a02Aa_9B20k20\" \"Aak0k9bKkB19\" \"-BbBK\" \"b1b9_BAB__k\" \"K\" \"9kAa-2KA2\" \"1\" \"-B22KkA9Ab2B1k\" \"9Bk-0bkA2AB-1\"]",
    "K bKBAabA12- BBk9 b2K_ b1b9_BAB__k Aak0k9bKkB19 _1092Ak 11kK9k92291k10 11a02Aa_9B20k20 9kAa-2KA2 9Bk-0bkA2AB-1 1K92-1kKkbb- 1 0a0_BaA2aBBB9 -BbBK -B22KkA9Ab2B1k -0Kk2102",
    "", false, "dictionary-sort-2264",
  )
  check_search_case(
    "lsort -dictionary  [list \"0a\" \"9_k\" \"\" \"-aAB9k-90A9KA0\" \"0Bk2AB2B\" \"a02-9K9Ak1-\" \"\" \"2Ka\" \"9a21\" \"209Bka2b_0K2\" \"_BA2kbaB9-K\" \"1b1a2a\" \"B9_kAKabb0Ba_k\" \"1_BB91K1kabK\" \"-22Bb0b2KbKAAA\" \"BbKA2k\" \"a-AKAB002kK11\" \"-2-k0AB\"]",
    "{} {} -2-k0AB -22Bb0b2KbKAAA -aAB9k-90A9KA0 0a 0Bk2AB2B 1_BB91K1kabK 1b1a2a 2Ka 9_k 9a21 209Bka2b_0K2 _BA2kbaB9-K a-AKAB002kK11 a02-9K9Ak1- B9_kAKabb0Ba_k BbKA2k",
    "", false, "dictionary-sort-2265",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"0a\" \"9_k\" \"\" \"-aAB9k-90A9KA0\" \"0Bk2AB2B\" \"a02-9K9Ak1-\" \"\" \"2Ka\" \"9a21\" \"209Bka2b_0K2\" \"_BA2kbaB9-K\" \"1b1a2a\" \"B9_kAKabb0Ba_k\" \"1_BB91K1kabK\" \"-22Bb0b2KbKAAA\" \"BbKA2k\" \"a-AKAB002kK11\" \"-2-k0AB\"]",
    "{} {} -2-k0AB -22Bb0b2KbKAAA -aAB9k-90A9KA0 0a 0Bk2AB2B 1_BB91K1kabK 1b1a2a 2Ka 9_k 9a21 209Bka2b_0K2 _BA2kbaB9-K a-AKAB002kK11 a02-9K9Ak1- B9_kAKabb0Ba_k BbKA2k",
    "", false, "dictionary-sort-2266",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"0a\" \"9_k\" \"\" \"-aAB9k-90A9KA0\" \"0Bk2AB2B\" \"a02-9K9Ak1-\" \"\" \"2Ka\" \"9a21\" \"209Bka2b_0K2\" \"_BA2kbaB9-K\" \"1b1a2a\" \"B9_kAKabb0Ba_k\" \"1_BB91K1kabK\" \"-22Bb0b2KbKAAA\" \"BbKA2k\" \"a-AKAB002kK11\" \"-2-k0AB\"]",
    "{} -2-k0AB -22Bb0b2KbKAAA -aAB9k-90A9KA0 0a 0Bk2AB2B 1_BB91K1kabK 1b1a2a 2Ka 9_k 9a21 209Bka2b_0K2 _BA2kbaB9-K a-AKAB002kK11 a02-9K9Ak1- B9_kAKabb0Ba_k BbKA2k",
    "", false, "dictionary-sort-2267",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"0a\" \"9_k\" \"\" \"-aAB9k-90A9KA0\" \"0Bk2AB2B\" \"a02-9K9Ak1-\" \"\" \"2Ka\" \"9a21\" \"209Bka2b_0K2\" \"_BA2kbaB9-K\" \"1b1a2a\" \"B9_kAKabb0Ba_k\" \"1_BB91K1kabK\" \"-22Bb0b2KbKAAA\" \"BbKA2k\" \"a-AKAB002kK11\" \"-2-k0AB\"]",
    "BbKA2k B9_kAKabb0Ba_k a02-9K9Ak1- a-AKAB002kK11 _BA2kbaB9-K 209Bka2b_0K2 9a21 9_k 2Ka 1b1a2a 1_BB91K1kabK 0Bk2AB2B 0a -aAB9k-90A9KA0 -22Bb0b2KbKAAA -2-k0AB {} {}",
    "", false, "dictionary-sort-2268",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"0a\" \"9_k\" \"\" \"-aAB9k-90A9KA0\" \"0Bk2AB2B\" \"a02-9K9Ak1-\" \"\" \"2Ka\" \"9a21\" \"209Bka2b_0K2\" \"_BA2kbaB9-K\" \"1b1a2a\" \"B9_kAKabb0Ba_k\" \"1_BB91K1kabK\" \"-22Bb0b2KbKAAA\" \"BbKA2k\" \"a-AKAB002kK11\" \"-2-k0AB\"]",
    "BbKA2k B9_kAKabb0Ba_k a02-9K9Ak1- a-AKAB002kK11 _BA2kbaB9-K 209Bka2b_0K2 9a21 9_k 2Ka 1b1a2a 1_BB91K1kabK 0Bk2AB2B 0a -aAB9k-90A9KA0 -22Bb0b2KbKAAA -2-k0AB {}",
    "", false, "dictionary-sort-2269",
  )
  check_search_case(
    "lsort -dictionary  [list \"B99kka-_K9\" \"\" \"K\" \"\" \"kBa_BBB\" \"1_kKB1_29k_9KK2\" \"a2ak0k\" \"02K102_0k2ba009\" \"kBb-0-__1\" \"Ab2_2K-2A-0B\" \"KAA-Bka002_\" \"b1-2K-b\" \"90K0-B1\" \"K1bKBk\" \"AAA_aka_B-\" \"\" \"0bKkK\" \"9__aAKbBaAk-KA_\"]",
    "{} {} {} 0bKkK 1_kKB1_29k_9KK2 02K102_0k2ba009 9__aAKbBaAk-KA_ 90K0-B1 a2ak0k AAA_aka_B- Ab2_2K-2A-0B b1-2K-b B99kka-_K9 K K1bKBk KAA-Bka002_ kBa_BBB kBb-0-__1",
    "", false, "dictionary-sort-2270",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"B99kka-_K9\" \"\" \"K\" \"\" \"kBa_BBB\" \"1_kKB1_29k_9KK2\" \"a2ak0k\" \"02K102_0k2ba009\" \"kBb-0-__1\" \"Ab2_2K-2A-0B\" \"KAA-Bka002_\" \"b1-2K-b\" \"90K0-B1\" \"K1bKBk\" \"AAA_aka_B-\" \"\" \"0bKkK\" \"9__aAKbBaAk-KA_\"]",
    "{} {} {} 0bKkK 1_kKB1_29k_9KK2 02K102_0k2ba009 9__aAKbBaAk-KA_ 90K0-B1 a2ak0k AAA_aka_B- Ab2_2K-2A-0B b1-2K-b B99kka-_K9 K K1bKBk KAA-Bka002_ kBa_BBB kBb-0-__1",
    "", false, "dictionary-sort-2271",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"B99kka-_K9\" \"\" \"K\" \"\" \"kBa_BBB\" \"1_kKB1_29k_9KK2\" \"a2ak0k\" \"02K102_0k2ba009\" \"kBb-0-__1\" \"Ab2_2K-2A-0B\" \"KAA-Bka002_\" \"b1-2K-b\" \"90K0-B1\" \"K1bKBk\" \"AAA_aka_B-\" \"\" \"0bKkK\" \"9__aAKbBaAk-KA_\"]",
    "{} 0bKkK 1_kKB1_29k_9KK2 02K102_0k2ba009 9__aAKbBaAk-KA_ 90K0-B1 a2ak0k AAA_aka_B- Ab2_2K-2A-0B b1-2K-b B99kka-_K9 K K1bKBk KAA-Bka002_ kBa_BBB kBb-0-__1",
    "", false, "dictionary-sort-2272",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"B99kka-_K9\" \"\" \"K\" \"\" \"kBa_BBB\" \"1_kKB1_29k_9KK2\" \"a2ak0k\" \"02K102_0k2ba009\" \"kBb-0-__1\" \"Ab2_2K-2A-0B\" \"KAA-Bka002_\" \"b1-2K-b\" \"90K0-B1\" \"K1bKBk\" \"AAA_aka_B-\" \"\" \"0bKkK\" \"9__aAKbBaAk-KA_\"]",
    "kBb-0-__1 kBa_BBB KAA-Bka002_ K1bKBk K B99kka-_K9 b1-2K-b Ab2_2K-2A-0B AAA_aka_B- a2ak0k 90K0-B1 9__aAKbBaAk-KA_ 02K102_0k2ba009 1_kKB1_29k_9KK2 0bKkK {} {} {}",
    "", false, "dictionary-sort-2273",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"B99kka-_K9\" \"\" \"K\" \"\" \"kBa_BBB\" \"1_kKB1_29k_9KK2\" \"a2ak0k\" \"02K102_0k2ba009\" \"kBb-0-__1\" \"Ab2_2K-2A-0B\" \"KAA-Bka002_\" \"b1-2K-b\" \"90K0-B1\" \"K1bKBk\" \"AAA_aka_B-\" \"\" \"0bKkK\" \"9__aAKbBaAk-KA_\"]",
    "kBb-0-__1 kBa_BBB KAA-Bka002_ K1bKBk K B99kka-_K9 b1-2K-b Ab2_2K-2A-0B AAA_aka_B- a2ak0k 90K0-B1 9__aAKbBaAk-KA_ 02K102_0k2ba009 1_kKB1_29k_9KK2 0bKkK {}",
    "", false, "dictionary-sort-2274",
  )
  check_search_case(
    "lsort -dictionary  [list \"\" \"0B\" \"a1B\" \"9aAk\" \"bA11K\" \"2BbaA120k0BaA\" \"9_a\" \"KAb2K_k1KaK00A\" \"aaKkk_KAkk2-B\" \"\" \"9k9B0b_0\" \"011_9\" \"KA-b\" \"0B1ab1KAaakA1-2\" \"B2B-\" \"A_9bK9-0\" \"K_\" \"_K2k09b\"]",
    "{} {} 0B 0B1ab1KAaakA1-2 2BbaA120k0BaA 9_a 9aAk 9k9B0b_0 011_9 _K2k09b a1B A_9bK9-0 aaKkk_KAkk2-B B2B- bA11K K_ KA-b KAb2K_k1KaK00A",
    "", false, "dictionary-sort-2275",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"\" \"0B\" \"a1B\" \"9aAk\" \"bA11K\" \"2BbaA120k0BaA\" \"9_a\" \"KAb2K_k1KaK00A\" \"aaKkk_KAkk2-B\" \"\" \"9k9B0b_0\" \"011_9\" \"KA-b\" \"0B1ab1KAaakA1-2\" \"B2B-\" \"A_9bK9-0\" \"K_\" \"_K2k09b\"]",
    "{} {} 0B 0B1ab1KAaakA1-2 2BbaA120k0BaA 9_a 9aAk 9k9B0b_0 011_9 _K2k09b a1B A_9bK9-0 aaKkk_KAkk2-B B2B- bA11K K_ KA-b KAb2K_k1KaK00A",
    "", false, "dictionary-sort-2276",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"\" \"0B\" \"a1B\" \"9aAk\" \"bA11K\" \"2BbaA120k0BaA\" \"9_a\" \"KAb2K_k1KaK00A\" \"aaKkk_KAkk2-B\" \"\" \"9k9B0b_0\" \"011_9\" \"KA-b\" \"0B1ab1KAaakA1-2\" \"B2B-\" \"A_9bK9-0\" \"K_\" \"_K2k09b\"]",
    "{} 0B 0B1ab1KAaakA1-2 2BbaA120k0BaA 9_a 9aAk 9k9B0b_0 011_9 _K2k09b a1B A_9bK9-0 aaKkk_KAkk2-B B2B- bA11K K_ KA-b KAb2K_k1KaK00A",
    "", false, "dictionary-sort-2277",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"\" \"0B\" \"a1B\" \"9aAk\" \"bA11K\" \"2BbaA120k0BaA\" \"9_a\" \"KAb2K_k1KaK00A\" \"aaKkk_KAkk2-B\" \"\" \"9k9B0b_0\" \"011_9\" \"KA-b\" \"0B1ab1KAaakA1-2\" \"B2B-\" \"A_9bK9-0\" \"K_\" \"_K2k09b\"]",
    "KAb2K_k1KaK00A KA-b K_ bA11K B2B- aaKkk_KAkk2-B A_9bK9-0 a1B _K2k09b 011_9 9k9B0b_0 9aAk 9_a 2BbaA120k0BaA 0B1ab1KAaakA1-2 0B {} {}",
    "", false, "dictionary-sort-2278",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"\" \"0B\" \"a1B\" \"9aAk\" \"bA11K\" \"2BbaA120k0BaA\" \"9_a\" \"KAb2K_k1KaK00A\" \"aaKkk_KAkk2-B\" \"\" \"9k9B0b_0\" \"011_9\" \"KA-b\" \"0B1ab1KAaakA1-2\" \"B2B-\" \"A_9bK9-0\" \"K_\" \"_K2k09b\"]",
    "KAb2K_k1KaK00A KA-b K_ bA11K B2B- aaKkk_KAkk2-B A_9bK9-0 a1B _K2k09b 011_9 9k9B0b_0 9aAk 9_a 2BbaA120k0BaA 0B1ab1KAaakA1-2 0B {}",
    "", false, "dictionary-sort-2279",
  )
}

///|
test "Tcl search cases 2281 through 2320" {
  check_search_case(
    "lsort -dictionary  [list \"_\" \"1AabABaA_AB2a\" \"a02B-K\" \"21A_a\" \"9\" \"2_9K9A_20B0bB\" \"9abK9K9\" \"_B0a\" \"\" \"90Kbk9BB2\" \"9a--9k\" \"KKb1k2\" \"2_KAaa\" \"00-kB9b912kK\" \"ba\" \"2A-_Ba-B01Bb9\" \"21\" \"1A__K9a__\"]",
    "{} 00-kB9b912kK 1A__K9a__ 1AabABaA_AB2a 2_9K9A_20B0bB 2_KAaa 2A-_Ba-B01Bb9 9 9a--9k 9abK9K9 21 21A_a 90Kbk9BB2 _ _B0a a02B-K ba KKb1k2",
    "", false, "dictionary-sort-2280",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"_\" \"1AabABaA_AB2a\" \"a02B-K\" \"21A_a\" \"9\" \"2_9K9A_20B0bB\" \"9abK9K9\" \"_B0a\" \"\" \"90Kbk9BB2\" \"9a--9k\" \"KKb1k2\" \"2_KAaa\" \"00-kB9b912kK\" \"ba\" \"2A-_Ba-B01Bb9\" \"21\" \"1A__K9a__\"]",
    "{} 00-kB9b912kK 1A__K9a__ 1AabABaA_AB2a 2_9K9A_20B0bB 2_KAaa 2A-_Ba-B01Bb9 9 9a--9k 9abK9K9 21 21A_a 90Kbk9BB2 _ _B0a a02B-K ba KKb1k2",
    "", false, "dictionary-sort-2281",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"_\" \"1AabABaA_AB2a\" \"a02B-K\" \"21A_a\" \"9\" \"2_9K9A_20B0bB\" \"9abK9K9\" \"_B0a\" \"\" \"90Kbk9BB2\" \"9a--9k\" \"KKb1k2\" \"2_KAaa\" \"00-kB9b912kK\" \"ba\" \"2A-_Ba-B01Bb9\" \"21\" \"1A__K9a__\"]",
    "{} 00-kB9b912kK 1A__K9a__ 1AabABaA_AB2a 2_9K9A_20B0bB 2_KAaa 2A-_Ba-B01Bb9 9 9a--9k 9abK9K9 21 21A_a 90Kbk9BB2 _ _B0a a02B-K ba KKb1k2",
    "", false, "dictionary-sort-2282",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"_\" \"1AabABaA_AB2a\" \"a02B-K\" \"21A_a\" \"9\" \"2_9K9A_20B0bB\" \"9abK9K9\" \"_B0a\" \"\" \"90Kbk9BB2\" \"9a--9k\" \"KKb1k2\" \"2_KAaa\" \"00-kB9b912kK\" \"ba\" \"2A-_Ba-B01Bb9\" \"21\" \"1A__K9a__\"]",
    "KKb1k2 ba a02B-K _B0a _ 90Kbk9BB2 21A_a 21 9abK9K9 9a--9k 9 2A-_Ba-B01Bb9 2_KAaa 2_9K9A_20B0bB 1AabABaA_AB2a 1A__K9a__ 00-kB9b912kK {}",
    "", false, "dictionary-sort-2283",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"_\" \"1AabABaA_AB2a\" \"a02B-K\" \"21A_a\" \"9\" \"2_9K9A_20B0bB\" \"9abK9K9\" \"_B0a\" \"\" \"90Kbk9BB2\" \"9a--9k\" \"KKb1k2\" \"2_KAaa\" \"00-kB9b912kK\" \"ba\" \"2A-_Ba-B01Bb9\" \"21\" \"1A__K9a__\"]",
    "KKb1k2 ba a02B-K _B0a _ 90Kbk9BB2 21A_a 21 9abK9K9 9a--9k 9 2A-_Ba-B01Bb9 2_KAaa 2_9K9A_20B0bB 1AabABaA_AB2a 1A__K9a__ 00-kB9b912kK {}",
    "", false, "dictionary-sort-2284",
  )
  check_search_case(
    "lsort -dictionary  [list \"B_aA1A9-__b\" \"91-kB_9921\" \"0292b11KKa09\" \"bk9BkaB2k0\" \"K9_\" \"90A2\" \"b20aK9a1_\" \"BkBb90219\" \"bb2a_-b2\" \"bba0B9B2ab2Bk\" \"A1K\" \"-Akk\" \"-9_9B-a_B0B\" \"Aa2-A9\" \"191aB-\" \"b_Bk0\" \"9_1_\" \"A9ak-B-a0b-b\"]",
    "-9_9B-a_B0B -Akk 9_1_ 90A2 91-kB_9921 191aB- 0292b11KKa09 A1K A9ak-B-a0b-b Aa2-A9 b20aK9a1_ B_aA1A9-__b b_Bk0 bb2a_-b2 bba0B9B2ab2Bk bk9BkaB2k0 BkBb90219 K9_",
    "", false, "dictionary-sort-2285",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"B_aA1A9-__b\" \"91-kB_9921\" \"0292b11KKa09\" \"bk9BkaB2k0\" \"K9_\" \"90A2\" \"b20aK9a1_\" \"BkBb90219\" \"bb2a_-b2\" \"bba0B9B2ab2Bk\" \"A1K\" \"-Akk\" \"-9_9B-a_B0B\" \"Aa2-A9\" \"191aB-\" \"b_Bk0\" \"9_1_\" \"A9ak-B-a0b-b\"]",
    "-9_9B-a_B0B -Akk 9_1_ 90A2 91-kB_9921 191aB- 0292b11KKa09 A1K A9ak-B-a0b-b Aa2-A9 b20aK9a1_ B_aA1A9-__b b_Bk0 bb2a_-b2 bba0B9B2ab2Bk bk9BkaB2k0 BkBb90219 K9_",
    "", false, "dictionary-sort-2286",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"B_aA1A9-__b\" \"91-kB_9921\" \"0292b11KKa09\" \"bk9BkaB2k0\" \"K9_\" \"90A2\" \"b20aK9a1_\" \"BkBb90219\" \"bb2a_-b2\" \"bba0B9B2ab2Bk\" \"A1K\" \"-Akk\" \"-9_9B-a_B0B\" \"Aa2-A9\" \"191aB-\" \"b_Bk0\" \"9_1_\" \"A9ak-B-a0b-b\"]",
    "-9_9B-a_B0B -Akk 9_1_ 90A2 91-kB_9921 191aB- 0292b11KKa09 A1K A9ak-B-a0b-b Aa2-A9 b20aK9a1_ B_aA1A9-__b b_Bk0 bb2a_-b2 bba0B9B2ab2Bk bk9BkaB2k0 BkBb90219 K9_",
    "", false, "dictionary-sort-2287",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"B_aA1A9-__b\" \"91-kB_9921\" \"0292b11KKa09\" \"bk9BkaB2k0\" \"K9_\" \"90A2\" \"b20aK9a1_\" \"BkBb90219\" \"bb2a_-b2\" \"bba0B9B2ab2Bk\" \"A1K\" \"-Akk\" \"-9_9B-a_B0B\" \"Aa2-A9\" \"191aB-\" \"b_Bk0\" \"9_1_\" \"A9ak-B-a0b-b\"]",
    "K9_ BkBb90219 bk9BkaB2k0 bba0B9B2ab2Bk bb2a_-b2 b_Bk0 B_aA1A9-__b b20aK9a1_ Aa2-A9 A9ak-B-a0b-b A1K 0292b11KKa09 191aB- 91-kB_9921 90A2 9_1_ -Akk -9_9B-a_B0B",
    "", false, "dictionary-sort-2288",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"B_aA1A9-__b\" \"91-kB_9921\" \"0292b11KKa09\" \"bk9BkaB2k0\" \"K9_\" \"90A2\" \"b20aK9a1_\" \"BkBb90219\" \"bb2a_-b2\" \"bba0B9B2ab2Bk\" \"A1K\" \"-Akk\" \"-9_9B-a_B0B\" \"Aa2-A9\" \"191aB-\" \"b_Bk0\" \"9_1_\" \"A9ak-B-a0b-b\"]",
    "K9_ BkBb90219 bk9BkaB2k0 bba0B9B2ab2Bk bb2a_-b2 b_Bk0 B_aA1A9-__b b20aK9a1_ Aa2-A9 A9ak-B-a0b-b A1K 0292b11KKa09 191aB- 91-kB_9921 90A2 9_1_ -Akk -9_9B-a_B0B",
    "", false, "dictionary-sort-2289",
  )
  check_search_case(
    "lsort -dictionary  [list \"\" \"AKka0--A-aA00K\" \"BBkBa_a0_kA1_B\" \"\" \"111\" \"29ABk-1k9a\" \"2\" \"aB\" \"K_Bk2-\" \"aAb_2K_1B_a9B\" \"B21ABA0a_\" \"k-AA21bB\" \"AKb9-BK0kKk21\" \"Babaa22A\" \"K-k01\" \"K92a_2bbk-\" \"_0-002\" \"A1_akk2A-02KAkB\"]",
    "{} {} 2 29ABk-1k9a 111 _0-002 A1_akk2A-02KAkB aAb_2K_1B_a9B aB AKb9-BK0kKk21 AKka0--A-aA00K B21ABA0a_ Babaa22A BBkBa_a0_kA1_B k-AA21bB K-k01 K92a_2bbk- K_Bk2-",
    "", false, "dictionary-sort-2290",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"\" \"AKka0--A-aA00K\" \"BBkBa_a0_kA1_B\" \"\" \"111\" \"29ABk-1k9a\" \"2\" \"aB\" \"K_Bk2-\" \"aAb_2K_1B_a9B\" \"B21ABA0a_\" \"k-AA21bB\" \"AKb9-BK0kKk21\" \"Babaa22A\" \"K-k01\" \"K92a_2bbk-\" \"_0-002\" \"A1_akk2A-02KAkB\"]",
    "{} {} 2 29ABk-1k9a 111 _0-002 A1_akk2A-02KAkB aAb_2K_1B_a9B aB AKb9-BK0kKk21 AKka0--A-aA00K B21ABA0a_ Babaa22A BBkBa_a0_kA1_B k-AA21bB K-k01 K92a_2bbk- K_Bk2-",
    "", false, "dictionary-sort-2291",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"\" \"AKka0--A-aA00K\" \"BBkBa_a0_kA1_B\" \"\" \"111\" \"29ABk-1k9a\" \"2\" \"aB\" \"K_Bk2-\" \"aAb_2K_1B_a9B\" \"B21ABA0a_\" \"k-AA21bB\" \"AKb9-BK0kKk21\" \"Babaa22A\" \"K-k01\" \"K92a_2bbk-\" \"_0-002\" \"A1_akk2A-02KAkB\"]",
    "{} 2 29ABk-1k9a 111 _0-002 A1_akk2A-02KAkB aAb_2K_1B_a9B aB AKb9-BK0kKk21 AKka0--A-aA00K B21ABA0a_ Babaa22A BBkBa_a0_kA1_B k-AA21bB K-k01 K92a_2bbk- K_Bk2-",
    "", false, "dictionary-sort-2292",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"\" \"AKka0--A-aA00K\" \"BBkBa_a0_kA1_B\" \"\" \"111\" \"29ABk-1k9a\" \"2\" \"aB\" \"K_Bk2-\" \"aAb_2K_1B_a9B\" \"B21ABA0a_\" \"k-AA21bB\" \"AKb9-BK0kKk21\" \"Babaa22A\" \"K-k01\" \"K92a_2bbk-\" \"_0-002\" \"A1_akk2A-02KAkB\"]",
    "K_Bk2- K92a_2bbk- K-k01 k-AA21bB BBkBa_a0_kA1_B Babaa22A B21ABA0a_ AKka0--A-aA00K AKb9-BK0kKk21 aB aAb_2K_1B_a9B A1_akk2A-02KAkB _0-002 111 29ABk-1k9a 2 {} {}",
    "", false, "dictionary-sort-2293",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"\" \"AKka0--A-aA00K\" \"BBkBa_a0_kA1_B\" \"\" \"111\" \"29ABk-1k9a\" \"2\" \"aB\" \"K_Bk2-\" \"aAb_2K_1B_a9B\" \"B21ABA0a_\" \"k-AA21bB\" \"AKb9-BK0kKk21\" \"Babaa22A\" \"K-k01\" \"K92a_2bbk-\" \"_0-002\" \"A1_akk2A-02KAkB\"]",
    "K_Bk2- K92a_2bbk- K-k01 k-AA21bB BBkBa_a0_kA1_B Babaa22A B21ABA0a_ AKka0--A-aA00K AKb9-BK0kKk21 aB aAb_2K_1B_a9B A1_akk2A-02KAkB _0-002 111 29ABk-1k9a 2 {}",
    "", false, "dictionary-sort-2294",
  )
  check_search_case(
    "lsort -dictionary  [list \"B-a0BB9A-Bk91\" \"Aa21_9K1902bB_a\" \"12-\" \"aKk-BK_A22bBkb\" \"KbKbA1kk_A2A0A1\" \"A2120\" \"B9-_Kk\" \"9-A-1B\" \"\" \"-2b1KA-aa_22A\" \"A_\" \"00ba_112-K1kK9B\" \"A9ba0kA\" \"A0_2bB1_KKKa2\" \"-bA_-a-91k\" \"KbbAkka9ak_b\" \"2B01b\" \"Ba_Bb-k9aKK0a09\"]",
    "{} -2b1KA-aa_22A -bA_-a-91k 00ba_112-K1kK9B 2B01b 9-A-1B 12- A0_2bB1_KKKa2 A9ba0kA A2120 A_ Aa21_9K1902bB_a aKk-BK_A22bBkb B-a0BB9A-Bk91 B9-_Kk Ba_Bb-k9aKK0a09 KbbAkka9ak_b KbKbA1kk_A2A0A1",
    "", false, "dictionary-sort-2295",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"B-a0BB9A-Bk91\" \"Aa21_9K1902bB_a\" \"12-\" \"aKk-BK_A22bBkb\" \"KbKbA1kk_A2A0A1\" \"A2120\" \"B9-_Kk\" \"9-A-1B\" \"\" \"-2b1KA-aa_22A\" \"A_\" \"00ba_112-K1kK9B\" \"A9ba0kA\" \"A0_2bB1_KKKa2\" \"-bA_-a-91k\" \"KbbAkka9ak_b\" \"2B01b\" \"Ba_Bb-k9aKK0a09\"]",
    "{} -2b1KA-aa_22A -bA_-a-91k 00ba_112-K1kK9B 2B01b 9-A-1B 12- A0_2bB1_KKKa2 A9ba0kA A2120 A_ Aa21_9K1902bB_a aKk-BK_A22bBkb B-a0BB9A-Bk91 B9-_Kk Ba_Bb-k9aKK0a09 KbbAkka9ak_b KbKbA1kk_A2A0A1",
    "", false, "dictionary-sort-2296",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"B-a0BB9A-Bk91\" \"Aa21_9K1902bB_a\" \"12-\" \"aKk-BK_A22bBkb\" \"KbKbA1kk_A2A0A1\" \"A2120\" \"B9-_Kk\" \"9-A-1B\" \"\" \"-2b1KA-aa_22A\" \"A_\" \"00ba_112-K1kK9B\" \"A9ba0kA\" \"A0_2bB1_KKKa2\" \"-bA_-a-91k\" \"KbbAkka9ak_b\" \"2B01b\" \"Ba_Bb-k9aKK0a09\"]",
    "{} -2b1KA-aa_22A -bA_-a-91k 00ba_112-K1kK9B 2B01b 9-A-1B 12- A0_2bB1_KKKa2 A9ba0kA A2120 A_ Aa21_9K1902bB_a aKk-BK_A22bBkb B-a0BB9A-Bk91 B9-_Kk Ba_Bb-k9aKK0a09 KbbAkka9ak_b KbKbA1kk_A2A0A1",
    "", false, "dictionary-sort-2297",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"B-a0BB9A-Bk91\" \"Aa21_9K1902bB_a\" \"12-\" \"aKk-BK_A22bBkb\" \"KbKbA1kk_A2A0A1\" \"A2120\" \"B9-_Kk\" \"9-A-1B\" \"\" \"-2b1KA-aa_22A\" \"A_\" \"00ba_112-K1kK9B\" \"A9ba0kA\" \"A0_2bB1_KKKa2\" \"-bA_-a-91k\" \"KbbAkka9ak_b\" \"2B01b\" \"Ba_Bb-k9aKK0a09\"]",
    "KbKbA1kk_A2A0A1 KbbAkka9ak_b Ba_Bb-k9aKK0a09 B9-_Kk B-a0BB9A-Bk91 aKk-BK_A22bBkb Aa21_9K1902bB_a A_ A2120 A9ba0kA A0_2bB1_KKKa2 12- 9-A-1B 2B01b 00ba_112-K1kK9B -bA_-a-91k -2b1KA-aa_22A {}",
    "", false, "dictionary-sort-2298",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"B-a0BB9A-Bk91\" \"Aa21_9K1902bB_a\" \"12-\" \"aKk-BK_A22bBkb\" \"KbKbA1kk_A2A0A1\" \"A2120\" \"B9-_Kk\" \"9-A-1B\" \"\" \"-2b1KA-aa_22A\" \"A_\" \"00ba_112-K1kK9B\" \"A9ba0kA\" \"A0_2bB1_KKKa2\" \"-bA_-a-91k\" \"KbbAkka9ak_b\" \"2B01b\" \"Ba_Bb-k9aKK0a09\"]",
    "KbKbA1kk_A2A0A1 KbbAkka9ak_b Ba_Bb-k9aKK0a09 B9-_Kk B-a0BB9A-Bk91 aKk-BK_A22bBkb Aa21_9K1902bB_a A_ A2120 A9ba0kA A0_2bB1_KKKa2 12- 9-A-1B 2B01b 00ba_112-K1kK9B -bA_-a-91k -2b1KA-aa_22A {}",
    "", false, "dictionary-sort-2299",
  )
  check_search_case(
    "lsort -dictionary  [list \"0-9\" \"A0AbB0BkaK0KB\" \"K1A02\" \"bK_k9aaka2Bab\" \"2aaa20bk_\" \"\" \"_a99A\" \"B9b_B2\" \"-_901-aBk_2a2\" \"0K1k0k\" \"b20B-0a0\" \"-k2kA_bkKBA\" \"1kb2__K2K1020\" \"aK\" \"Ka-k-ba2A1a1\" \"_a_A\" \"-BB\" \"1Bka9K\"]",
    "{} -_901-aBk_2a2 -BB -k2kA_bkKBA 0-9 0K1k0k 1Bka9K 1kb2__K2K1020 2aaa20bk_ _a99A _a_A A0AbB0BkaK0KB aK B9b_B2 b20B-0a0 bK_k9aaka2Bab K1A02 Ka-k-ba2A1a1",
    "", false, "dictionary-sort-2300",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"0-9\" \"A0AbB0BkaK0KB\" \"K1A02\" \"bK_k9aaka2Bab\" \"2aaa20bk_\" \"\" \"_a99A\" \"B9b_B2\" \"-_901-aBk_2a2\" \"0K1k0k\" \"b20B-0a0\" \"-k2kA_bkKBA\" \"1kb2__K2K1020\" \"aK\" \"Ka-k-ba2A1a1\" \"_a_A\" \"-BB\" \"1Bka9K\"]",
    "{} -_901-aBk_2a2 -BB -k2kA_bkKBA 0-9 0K1k0k 1Bka9K 1kb2__K2K1020 2aaa20bk_ _a99A _a_A A0AbB0BkaK0KB aK B9b_B2 b20B-0a0 bK_k9aaka2Bab K1A02 Ka-k-ba2A1a1",
    "", false, "dictionary-sort-2301",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"0-9\" \"A0AbB0BkaK0KB\" \"K1A02\" \"bK_k9aaka2Bab\" \"2aaa20bk_\" \"\" \"_a99A\" \"B9b_B2\" \"-_901-aBk_2a2\" \"0K1k0k\" \"b20B-0a0\" \"-k2kA_bkKBA\" \"1kb2__K2K1020\" \"aK\" \"Ka-k-ba2A1a1\" \"_a_A\" \"-BB\" \"1Bka9K\"]",
    "{} -_901-aBk_2a2 -BB -k2kA_bkKBA 0-9 0K1k0k 1Bka9K 1kb2__K2K1020 2aaa20bk_ _a99A _a_A A0AbB0BkaK0KB aK B9b_B2 b20B-0a0 bK_k9aaka2Bab K1A02 Ka-k-ba2A1a1",
    "", false, "dictionary-sort-2302",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"0-9\" \"A0AbB0BkaK0KB\" \"K1A02\" \"bK_k9aaka2Bab\" \"2aaa20bk_\" \"\" \"_a99A\" \"B9b_B2\" \"-_901-aBk_2a2\" \"0K1k0k\" \"b20B-0a0\" \"-k2kA_bkKBA\" \"1kb2__K2K1020\" \"aK\" \"Ka-k-ba2A1a1\" \"_a_A\" \"-BB\" \"1Bka9K\"]",
    "Ka-k-ba2A1a1 K1A02 bK_k9aaka2Bab b20B-0a0 B9b_B2 aK A0AbB0BkaK0KB _a_A _a99A 2aaa20bk_ 1kb2__K2K1020 1Bka9K 0K1k0k 0-9 -k2kA_bkKBA -BB -_901-aBk_2a2 {}",
    "", false, "dictionary-sort-2303",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"0-9\" \"A0AbB0BkaK0KB\" \"K1A02\" \"bK_k9aaka2Bab\" \"2aaa20bk_\" \"\" \"_a99A\" \"B9b_B2\" \"-_901-aBk_2a2\" \"0K1k0k\" \"b20B-0a0\" \"-k2kA_bkKBA\" \"1kb2__K2K1020\" \"aK\" \"Ka-k-ba2A1a1\" \"_a_A\" \"-BB\" \"1Bka9K\"]",
    "Ka-k-ba2A1a1 K1A02 bK_k9aaka2Bab b20B-0a0 B9b_B2 aK A0AbB0BkaK0KB _a_A _a99A 2aaa20bk_ 1kb2__K2K1020 1Bka9K 0K1k0k 0-9 -k2kA_bkKBA -BB -_901-aBk_2a2 {}",
    "", false, "dictionary-sort-2304",
  )
  check_search_case(
    "lsort -dictionary  [list \"k219\" \"aK-bB\" \"kaaB21K-KKK19\" \"\" \"K1B-_0ka\" \"b1kbka11Bk92Kk\" \"_b9\" \"ABkbk-2_AK_2AK\" \"K-a2\" \"k-bK9B9_a9ABa\" \"ab\" \"\" \"9A_BA1bk-99a210\" \"_2\" \"9-K\" \"b_29a2A\" \"A01bKa90\" \"\"]",
    "{} {} {} 9-K 9A_BA1bk-99a210 _2 _b9 A01bKa90 ab ABkbk-2_AK_2AK aK-bB b1kbka11Bk92Kk b_29a2A K-a2 k-bK9B9_a9ABa K1B-_0ka k219 kaaB21K-KKK19",
    "", false, "dictionary-sort-2305",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"k219\" \"aK-bB\" \"kaaB21K-KKK19\" \"\" \"K1B-_0ka\" \"b1kbka11Bk92Kk\" \"_b9\" \"ABkbk-2_AK_2AK\" \"K-a2\" \"k-bK9B9_a9ABa\" \"ab\" \"\" \"9A_BA1bk-99a210\" \"_2\" \"9-K\" \"b_29a2A\" \"A01bKa90\" \"\"]",
    "{} {} {} 9-K 9A_BA1bk-99a210 _2 _b9 A01bKa90 ab ABkbk-2_AK_2AK aK-bB b1kbka11Bk92Kk b_29a2A K-a2 k-bK9B9_a9ABa K1B-_0ka k219 kaaB21K-KKK19",
    "", false, "dictionary-sort-2306",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"k219\" \"aK-bB\" \"kaaB21K-KKK19\" \"\" \"K1B-_0ka\" \"b1kbka11Bk92Kk\" \"_b9\" \"ABkbk-2_AK_2AK\" \"K-a2\" \"k-bK9B9_a9ABa\" \"ab\" \"\" \"9A_BA1bk-99a210\" \"_2\" \"9-K\" \"b_29a2A\" \"A01bKa90\" \"\"]",
    "{} 9-K 9A_BA1bk-99a210 _2 _b9 A01bKa90 ab ABkbk-2_AK_2AK aK-bB b1kbka11Bk92Kk b_29a2A K-a2 k-bK9B9_a9ABa K1B-_0ka k219 kaaB21K-KKK19",
    "", false, "dictionary-sort-2307",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"k219\" \"aK-bB\" \"kaaB21K-KKK19\" \"\" \"K1B-_0ka\" \"b1kbka11Bk92Kk\" \"_b9\" \"ABkbk-2_AK_2AK\" \"K-a2\" \"k-bK9B9_a9ABa\" \"ab\" \"\" \"9A_BA1bk-99a210\" \"_2\" \"9-K\" \"b_29a2A\" \"A01bKa90\" \"\"]",
    "kaaB21K-KKK19 k219 K1B-_0ka k-bK9B9_a9ABa K-a2 b_29a2A b1kbka11Bk92Kk aK-bB ABkbk-2_AK_2AK ab A01bKa90 _b9 _2 9A_BA1bk-99a210 9-K {} {} {}",
    "", false, "dictionary-sort-2308",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"k219\" \"aK-bB\" \"kaaB21K-KKK19\" \"\" \"K1B-_0ka\" \"b1kbka11Bk92Kk\" \"_b9\" \"ABkbk-2_AK_2AK\" \"K-a2\" \"k-bK9B9_a9ABa\" \"ab\" \"\" \"9A_BA1bk-99a210\" \"_2\" \"9-K\" \"b_29a2A\" \"A01bKa90\" \"\"]",
    "kaaB21K-KKK19 k219 K1B-_0ka k-bK9B9_a9ABa K-a2 b_29a2A b1kbka11Bk92Kk aK-bB ABkbk-2_AK_2AK ab A01bKa90 _b9 _2 9A_BA1bk-99a210 9-K {}",
    "", false, "dictionary-sort-2309",
  )
  check_search_case(
    "lsort -dictionary  [list \"9bBa111bkA2\" \"99\" \"1kK\" \"b0\" \"a_k\" \"9\" \"22\" \"122A1\" \"1k01K_aB\" \"9_2Aa2bkkaAkK_\" \"-1B0__a-A-k0\" \"K1ab920BA_0\" \"_09a1bB\" \"2Ab_\" \"-1A02kBBB0bAb\" \"9K09\" \"2-_\" \"9A-a102A01B_Ak_\"]",
    "-1A02kBBB0bAb -1B0__a-A-k0 1k01K_aB 1kK 2-_ 2Ab_ 9 9_2Aa2bkkaAkK_ 9A-a102A01B_Ak_ 9bBa111bkA2 9K09 22 99 122A1 _09a1bB a_k b0 K1ab920BA_0",
    "", false, "dictionary-sort-2310",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"9bBa111bkA2\" \"99\" \"1kK\" \"b0\" \"a_k\" \"9\" \"22\" \"122A1\" \"1k01K_aB\" \"9_2Aa2bkkaAkK_\" \"-1B0__a-A-k0\" \"K1ab920BA_0\" \"_09a1bB\" \"2Ab_\" \"-1A02kBBB0bAb\" \"9K09\" \"2-_\" \"9A-a102A01B_Ak_\"]",
    "-1A02kBBB0bAb -1B0__a-A-k0 1k01K_aB 1kK 2-_ 2Ab_ 9 9_2Aa2bkkaAkK_ 9A-a102A01B_Ak_ 9bBa111bkA2 9K09 22 99 122A1 _09a1bB a_k b0 K1ab920BA_0",
    "", false, "dictionary-sort-2311",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"9bBa111bkA2\" \"99\" \"1kK\" \"b0\" \"a_k\" \"9\" \"22\" \"122A1\" \"1k01K_aB\" \"9_2Aa2bkkaAkK_\" \"-1B0__a-A-k0\" \"K1ab920BA_0\" \"_09a1bB\" \"2Ab_\" \"-1A02kBBB0bAb\" \"9K09\" \"2-_\" \"9A-a102A01B_Ak_\"]",
    "-1A02kBBB0bAb -1B0__a-A-k0 1k01K_aB 1kK 2-_ 2Ab_ 9 9_2Aa2bkkaAkK_ 9A-a102A01B_Ak_ 9bBa111bkA2 9K09 22 99 122A1 _09a1bB a_k b0 K1ab920BA_0",
    "", false, "dictionary-sort-2312",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"9bBa111bkA2\" \"99\" \"1kK\" \"b0\" \"a_k\" \"9\" \"22\" \"122A1\" \"1k01K_aB\" \"9_2Aa2bkkaAkK_\" \"-1B0__a-A-k0\" \"K1ab920BA_0\" \"_09a1bB\" \"2Ab_\" \"-1A02kBBB0bAb\" \"9K09\" \"2-_\" \"9A-a102A01B_Ak_\"]",
    "K1ab920BA_0 b0 a_k _09a1bB 122A1 99 22 9K09 9bBa111bkA2 9A-a102A01B_Ak_ 9_2Aa2bkkaAkK_ 9 2Ab_ 2-_ 1kK 1k01K_aB -1B0__a-A-k0 -1A02kBBB0bAb",
    "", false, "dictionary-sort-2313",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"9bBa111bkA2\" \"99\" \"1kK\" \"b0\" \"a_k\" \"9\" \"22\" \"122A1\" \"1k01K_aB\" \"9_2Aa2bkkaAkK_\" \"-1B0__a-A-k0\" \"K1ab920BA_0\" \"_09a1bB\" \"2Ab_\" \"-1A02kBBB0bAb\" \"9K09\" \"2-_\" \"9A-a102A01B_Ak_\"]",
    "K1ab920BA_0 b0 a_k _09a1bB 122A1 99 22 9K09 9bBa111bkA2 9A-a102A01B_Ak_ 9_2Aa2bkkaAkK_ 9 2Ab_ 2-_ 1kK 1k01K_aB -1B0__a-A-k0 -1A02kBBB0bAb",
    "", false, "dictionary-sort-2314",
  )
  check_search_case(
    "lsort -dictionary  [list \"9-b9K\" \"_20B\" \"A9_\" \"aBb_K9KABKaA\" \"-KAkbakB0\" \"Bkab-2A_9\" \"\" \"-9bk99B2a02_\" \"--9A2k1_\" \"K\" \"A_B_a\" \"K1\" \"\" \"1K_01A-9\" \"bA9\" \"a9_\" \"Kb0a2AK010kaaK\" \"9\"]",
    "{} {} --9A2k1_ -9bk99B2a02_ -KAkbakB0 1K_01A-9 9 9-b9K _20B A9_ a9_ A_B_a aBb_K9KABKaA bA9 Bkab-2A_9 K K1 Kb0a2AK010kaaK",
    "", false, "dictionary-sort-2315",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"9-b9K\" \"_20B\" \"A9_\" \"aBb_K9KABKaA\" \"-KAkbakB0\" \"Bkab-2A_9\" \"\" \"-9bk99B2a02_\" \"--9A2k1_\" \"K\" \"A_B_a\" \"K1\" \"\" \"1K_01A-9\" \"bA9\" \"a9_\" \"Kb0a2AK010kaaK\" \"9\"]",
    "{} {} --9A2k1_ -9bk99B2a02_ -KAkbakB0 1K_01A-9 9 9-b9K _20B A9_ a9_ A_B_a aBb_K9KABKaA bA9 Bkab-2A_9 K K1 Kb0a2AK010kaaK",
    "", false, "dictionary-sort-2316",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"9-b9K\" \"_20B\" \"A9_\" \"aBb_K9KABKaA\" \"-KAkbakB0\" \"Bkab-2A_9\" \"\" \"-9bk99B2a02_\" \"--9A2k1_\" \"K\" \"A_B_a\" \"K1\" \"\" \"1K_01A-9\" \"bA9\" \"a9_\" \"Kb0a2AK010kaaK\" \"9\"]",
    "{} --9A2k1_ -9bk99B2a02_ -KAkbakB0 1K_01A-9 9 9-b9K _20B A9_ a9_ A_B_a aBb_K9KABKaA bA9 Bkab-2A_9 K K1 Kb0a2AK010kaaK",
    "", false, "dictionary-sort-2317",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"9-b9K\" \"_20B\" \"A9_\" \"aBb_K9KABKaA\" \"-KAkbakB0\" \"Bkab-2A_9\" \"\" \"-9bk99B2a02_\" \"--9A2k1_\" \"K\" \"A_B_a\" \"K1\" \"\" \"1K_01A-9\" \"bA9\" \"a9_\" \"Kb0a2AK010kaaK\" \"9\"]",
    "Kb0a2AK010kaaK K1 K Bkab-2A_9 bA9 aBb_K9KABKaA A_B_a a9_ A9_ _20B 9-b9K 9 1K_01A-9 -KAkbakB0 -9bk99B2a02_ --9A2k1_ {} {}",
    "", false, "dictionary-sort-2318",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"9-b9K\" \"_20B\" \"A9_\" \"aBb_K9KABKaA\" \"-KAkbakB0\" \"Bkab-2A_9\" \"\" \"-9bk99B2a02_\" \"--9A2k1_\" \"K\" \"A_B_a\" \"K1\" \"\" \"1K_01A-9\" \"bA9\" \"a9_\" \"Kb0a2AK010kaaK\" \"9\"]",
    "Kb0a2AK010kaaK K1 K Bkab-2A_9 bA9 aBb_K9KABKaA A_B_a a9_ A9_ _20B 9-b9K 9 1K_01A-9 -KAkbakB0 -9bk99B2a02_ --9A2k1_ {}",
    "", false, "dictionary-sort-2319",
  )
}

///|
test "Tcl search cases 2321 through 2360" {
  check_search_case(
    "lsort -dictionary  [list \"b-K\" \"K2-9-ka_aA\" \"_29aAbk2Ab-99kA\" \"b92KB0BAk--\" \"k-AkaAAaAb9\" \"K\" \"bkKK0-92-K\" \"2120KABa-kB2\" \"-0-K901a_\" \"9-kbk10b_0-A0_\" \"-AA_a9K292-21Bk\" \"ak-kKKABk2\" \"020k-\" \"12KKK_a9b22b\" \"1B90k_kabA1_91_\" \"1\" \"0aA2\" \"A-k2baaAa22Bk\"]",
    "-0-K901a_ -AA_a9K292-21Bk 0aA2 1 1B90k_kabA1_91_ 9-kbk10b_0-A0_ 12KKK_a9b22b 020k- 2120KABa-kB2 _29aAbk2Ab-99kA A-k2baaAa22Bk ak-kKKABk2 b-K b92KB0BAk-- bkKK0-92-K K k-AkaAAaAb9 K2-9-ka_aA",
    "", false, "dictionary-sort-2320",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"b-K\" \"K2-9-ka_aA\" \"_29aAbk2Ab-99kA\" \"b92KB0BAk--\" \"k-AkaAAaAb9\" \"K\" \"bkKK0-92-K\" \"2120KABa-kB2\" \"-0-K901a_\" \"9-kbk10b_0-A0_\" \"-AA_a9K292-21Bk\" \"ak-kKKABk2\" \"020k-\" \"12KKK_a9b22b\" \"1B90k_kabA1_91_\" \"1\" \"0aA2\" \"A-k2baaAa22Bk\"]",
    "-0-K901a_ -AA_a9K292-21Bk 0aA2 1 1B90k_kabA1_91_ 9-kbk10b_0-A0_ 12KKK_a9b22b 020k- 2120KABa-kB2 _29aAbk2Ab-99kA A-k2baaAa22Bk ak-kKKABk2 b-K b92KB0BAk-- bkKK0-92-K K k-AkaAAaAb9 K2-9-ka_aA",
    "", false, "dictionary-sort-2321",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"b-K\" \"K2-9-ka_aA\" \"_29aAbk2Ab-99kA\" \"b92KB0BAk--\" \"k-AkaAAaAb9\" \"K\" \"bkKK0-92-K\" \"2120KABa-kB2\" \"-0-K901a_\" \"9-kbk10b_0-A0_\" \"-AA_a9K292-21Bk\" \"ak-kKKABk2\" \"020k-\" \"12KKK_a9b22b\" \"1B90k_kabA1_91_\" \"1\" \"0aA2\" \"A-k2baaAa22Bk\"]",
    "-0-K901a_ -AA_a9K292-21Bk 0aA2 1 1B90k_kabA1_91_ 9-kbk10b_0-A0_ 12KKK_a9b22b 020k- 2120KABa-kB2 _29aAbk2Ab-99kA A-k2baaAa22Bk ak-kKKABk2 b-K b92KB0BAk-- bkKK0-92-K K k-AkaAAaAb9 K2-9-ka_aA",
    "", false, "dictionary-sort-2322",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"b-K\" \"K2-9-ka_aA\" \"_29aAbk2Ab-99kA\" \"b92KB0BAk--\" \"k-AkaAAaAb9\" \"K\" \"bkKK0-92-K\" \"2120KABa-kB2\" \"-0-K901a_\" \"9-kbk10b_0-A0_\" \"-AA_a9K292-21Bk\" \"ak-kKKABk2\" \"020k-\" \"12KKK_a9b22b\" \"1B90k_kabA1_91_\" \"1\" \"0aA2\" \"A-k2baaAa22Bk\"]",
    "K2-9-ka_aA k-AkaAAaAb9 K bkKK0-92-K b92KB0BAk-- b-K ak-kKKABk2 A-k2baaAa22Bk _29aAbk2Ab-99kA 2120KABa-kB2 020k- 12KKK_a9b22b 9-kbk10b_0-A0_ 1B90k_kabA1_91_ 1 0aA2 -AA_a9K292-21Bk -0-K901a_",
    "", false, "dictionary-sort-2323",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"b-K\" \"K2-9-ka_aA\" \"_29aAbk2Ab-99kA\" \"b92KB0BAk--\" \"k-AkaAAaAb9\" \"K\" \"bkKK0-92-K\" \"2120KABa-kB2\" \"-0-K901a_\" \"9-kbk10b_0-A0_\" \"-AA_a9K292-21Bk\" \"ak-kKKABk2\" \"020k-\" \"12KKK_a9b22b\" \"1B90k_kabA1_91_\" \"1\" \"0aA2\" \"A-k2baaAa22Bk\"]",
    "K2-9-ka_aA k-AkaAAaAb9 K bkKK0-92-K b92KB0BAk-- b-K ak-kKKABk2 A-k2baaAa22Bk _29aAbk2Ab-99kA 2120KABa-kB2 020k- 12KKK_a9b22b 9-kbk10b_0-A0_ 1B90k_kabA1_91_ 1 0aA2 -AA_a9K292-21Bk -0-K901a_",
    "", false, "dictionary-sort-2324",
  )
  check_search_case(
    "lsort -dictionary  [list \"K-kba02_02K\" \"B1BB9B29A\" \"_kKaKK9-K\" \"-Ab2_\" \"KaA1A--2\" \"\" \"20ak\" \"0_0k_a-k11-0_0\" \"-a_29_kA\" \"1\" \"b91-0kB9aB0_Ba1\" \"bBB-B-bKb29_-\" \"2\" \"A_9-\" \"92Ak0-1kBk-K29\" \"-9_0211BK9\" \"A-B2a2\" \"K11kkbK100BkKk\"]",
    "{} -9_0211BK9 -a_29_kA -Ab2_ 0_0k_a-k11-0_0 1 2 20ak 92Ak0-1kBk-K29 _kKaKK9-K A-B2a2 A_9- B1BB9B29A b91-0kB9aB0_Ba1 bBB-B-bKb29_- K-kba02_02K K11kkbK100BkKk KaA1A--2",
    "", false, "dictionary-sort-2325",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"K-kba02_02K\" \"B1BB9B29A\" \"_kKaKK9-K\" \"-Ab2_\" \"KaA1A--2\" \"\" \"20ak\" \"0_0k_a-k11-0_0\" \"-a_29_kA\" \"1\" \"b91-0kB9aB0_Ba1\" \"bBB-B-bKb29_-\" \"2\" \"A_9-\" \"92Ak0-1kBk-K29\" \"-9_0211BK9\" \"A-B2a2\" \"K11kkbK100BkKk\"]",
    "{} -9_0211BK9 -a_29_kA -Ab2_ 0_0k_a-k11-0_0 1 2 20ak 92Ak0-1kBk-K29 _kKaKK9-K A-B2a2 A_9- B1BB9B29A b91-0kB9aB0_Ba1 bBB-B-bKb29_- K-kba02_02K K11kkbK100BkKk KaA1A--2",
    "", false, "dictionary-sort-2326",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K-kba02_02K\" \"B1BB9B29A\" \"_kKaKK9-K\" \"-Ab2_\" \"KaA1A--2\" \"\" \"20ak\" \"0_0k_a-k11-0_0\" \"-a_29_kA\" \"1\" \"b91-0kB9aB0_Ba1\" \"bBB-B-bKb29_-\" \"2\" \"A_9-\" \"92Ak0-1kBk-K29\" \"-9_0211BK9\" \"A-B2a2\" \"K11kkbK100BkKk\"]",
    "{} -9_0211BK9 -a_29_kA -Ab2_ 0_0k_a-k11-0_0 1 2 20ak 92Ak0-1kBk-K29 _kKaKK9-K A-B2a2 A_9- B1BB9B29A b91-0kB9aB0_Ba1 bBB-B-bKb29_- K-kba02_02K K11kkbK100BkKk KaA1A--2",
    "", false, "dictionary-sort-2327",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"K-kba02_02K\" \"B1BB9B29A\" \"_kKaKK9-K\" \"-Ab2_\" \"KaA1A--2\" \"\" \"20ak\" \"0_0k_a-k11-0_0\" \"-a_29_kA\" \"1\" \"b91-0kB9aB0_Ba1\" \"bBB-B-bKb29_-\" \"2\" \"A_9-\" \"92Ak0-1kBk-K29\" \"-9_0211BK9\" \"A-B2a2\" \"K11kkbK100BkKk\"]",
    "KaA1A--2 K11kkbK100BkKk K-kba02_02K bBB-B-bKb29_- b91-0kB9aB0_Ba1 B1BB9B29A A_9- A-B2a2 _kKaKK9-K 92Ak0-1kBk-K29 20ak 2 1 0_0k_a-k11-0_0 -Ab2_ -a_29_kA -9_0211BK9 {}",
    "", false, "dictionary-sort-2328",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K-kba02_02K\" \"B1BB9B29A\" \"_kKaKK9-K\" \"-Ab2_\" \"KaA1A--2\" \"\" \"20ak\" \"0_0k_a-k11-0_0\" \"-a_29_kA\" \"1\" \"b91-0kB9aB0_Ba1\" \"bBB-B-bKb29_-\" \"2\" \"A_9-\" \"92Ak0-1kBk-K29\" \"-9_0211BK9\" \"A-B2a2\" \"K11kkbK100BkKk\"]",
    "KaA1A--2 K11kkbK100BkKk K-kba02_02K bBB-B-bKb29_- b91-0kB9aB0_Ba1 B1BB9B29A A_9- A-B2a2 _kKaKK9-K 92Ak0-1kBk-K29 20ak 2 1 0_0k_a-k11-0_0 -Ab2_ -a_29_kA -9_0211BK9 {}",
    "", false, "dictionary-sort-2329",
  )
  check_search_case(
    "lsort -dictionary  [list \"9K90K2\" \"_-b1Ak09A9kb\" \"A11ABB\" \"\" \"1B02B1kA900\" \"aKBKAk09-Kk0-BA\" \"-111_99AAa\" \"B2Kb\" \"b0--b0B20-\" \"_AAA-bA\" \"AB\" \"bA0019-19aB0-\" \"BAA2b2-k-b\" \"akk0K1B_b_2b\" \"\" \"-1__A_9aKAb9\" \"AbK2B0B\" \"1_KK9--291K0Bkk\"]",
    "{} {} -1__A_9aKAb9 -111_99AAa 1_KK9--291K0Bkk 1B02B1kA900 9K90K2 _-b1Ak09A9kb _AAA-bA A11ABB AB AbK2B0B aKBKAk09-Kk0-BA akk0K1B_b_2b b0--b0B20- B2Kb bA0019-19aB0- BAA2b2-k-b",
    "", false, "dictionary-sort-2330",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"9K90K2\" \"_-b1Ak09A9kb\" \"A11ABB\" \"\" \"1B02B1kA900\" \"aKBKAk09-Kk0-BA\" \"-111_99AAa\" \"B2Kb\" \"b0--b0B20-\" \"_AAA-bA\" \"AB\" \"bA0019-19aB0-\" \"BAA2b2-k-b\" \"akk0K1B_b_2b\" \"\" \"-1__A_9aKAb9\" \"AbK2B0B\" \"1_KK9--291K0Bkk\"]",
    "{} {} -1__A_9aKAb9 -111_99AAa 1_KK9--291K0Bkk 1B02B1kA900 9K90K2 _-b1Ak09A9kb _AAA-bA A11ABB AB AbK2B0B aKBKAk09-Kk0-BA akk0K1B_b_2b b0--b0B20- B2Kb bA0019-19aB0- BAA2b2-k-b",
    "", false, "dictionary-sort-2331",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"9K90K2\" \"_-b1Ak09A9kb\" \"A11ABB\" \"\" \"1B02B1kA900\" \"aKBKAk09-Kk0-BA\" \"-111_99AAa\" \"B2Kb\" \"b0--b0B20-\" \"_AAA-bA\" \"AB\" \"bA0019-19aB0-\" \"BAA2b2-k-b\" \"akk0K1B_b_2b\" \"\" \"-1__A_9aKAb9\" \"AbK2B0B\" \"1_KK9--291K0Bkk\"]",
    "{} -1__A_9aKAb9 -111_99AAa 1_KK9--291K0Bkk 1B02B1kA900 9K90K2 _-b1Ak09A9kb _AAA-bA A11ABB AB AbK2B0B aKBKAk09-Kk0-BA akk0K1B_b_2b b0--b0B20- B2Kb bA0019-19aB0- BAA2b2-k-b",
    "", false, "dictionary-sort-2332",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"9K90K2\" \"_-b1Ak09A9kb\" \"A11ABB\" \"\" \"1B02B1kA900\" \"aKBKAk09-Kk0-BA\" \"-111_99AAa\" \"B2Kb\" \"b0--b0B20-\" \"_AAA-bA\" \"AB\" \"bA0019-19aB0-\" \"BAA2b2-k-b\" \"akk0K1B_b_2b\" \"\" \"-1__A_9aKAb9\" \"AbK2B0B\" \"1_KK9--291K0Bkk\"]",
    "BAA2b2-k-b bA0019-19aB0- B2Kb b0--b0B20- akk0K1B_b_2b aKBKAk09-Kk0-BA AbK2B0B AB A11ABB _AAA-bA _-b1Ak09A9kb 9K90K2 1B02B1kA900 1_KK9--291K0Bkk -111_99AAa -1__A_9aKAb9 {} {}",
    "", false, "dictionary-sort-2333",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"9K90K2\" \"_-b1Ak09A9kb\" \"A11ABB\" \"\" \"1B02B1kA900\" \"aKBKAk09-Kk0-BA\" \"-111_99AAa\" \"B2Kb\" \"b0--b0B20-\" \"_AAA-bA\" \"AB\" \"bA0019-19aB0-\" \"BAA2b2-k-b\" \"akk0K1B_b_2b\" \"\" \"-1__A_9aKAb9\" \"AbK2B0B\" \"1_KK9--291K0Bkk\"]",
    "BAA2b2-k-b bA0019-19aB0- B2Kb b0--b0B20- akk0K1B_b_2b aKBKAk09-Kk0-BA AbK2B0B AB A11ABB _AAA-bA _-b1Ak09A9kb 9K90K2 1B02B1kA900 1_KK9--291K0Bkk -111_99AAa -1__A_9aKAb9 {}",
    "", false, "dictionary-sort-2334",
  )
  check_search_case(
    "lsort -dictionary  [list \"KAK2KbkkaB_-1\" \"k-\" \"AKkB0a-_A9a_kA\" \"9BAA1b210k00\" \"10KkA01\" \"K9B9aB_a1-2-b\" \"2kBKK1b_B1\" \"a1a\" \"aK-k2_b1KAAA\" \"K0baBA-KaaBKaa\" \"A91K9a0\" \"b-_-kBkK0B0k22B\" \"9k\" \"AB9222__kBa\" \"0B_299_B\" \"92bA1a_aKkaa\" \"09\" \"_AkK\"]",
    "0B_299_B 2kBKK1b_B1 09 9BAA1b210k00 9k 10KkA01 92bA1a_aKkaa _AkK a1a A91K9a0 AB9222__kBa aK-k2_b1KAAA AKkB0a-_A9a_kA b-_-kBkK0B0k22B k- K0baBA-KaaBKaa K9B9aB_a1-2-b KAK2KbkkaB_-1",
    "", false, "dictionary-sort-2335",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"KAK2KbkkaB_-1\" \"k-\" \"AKkB0a-_A9a_kA\" \"9BAA1b210k00\" \"10KkA01\" \"K9B9aB_a1-2-b\" \"2kBKK1b_B1\" \"a1a\" \"aK-k2_b1KAAA\" \"K0baBA-KaaBKaa\" \"A91K9a0\" \"b-_-kBkK0B0k22B\" \"9k\" \"AB9222__kBa\" \"0B_299_B\" \"92bA1a_aKkaa\" \"09\" \"_AkK\"]",
    "0B_299_B 2kBKK1b_B1 09 9BAA1b210k00 9k 10KkA01 92bA1a_aKkaa _AkK a1a A91K9a0 AB9222__kBa aK-k2_b1KAAA AKkB0a-_A9a_kA b-_-kBkK0B0k22B k- K0baBA-KaaBKaa K9B9aB_a1-2-b KAK2KbkkaB_-1",
    "", false, "dictionary-sort-2336",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"KAK2KbkkaB_-1\" \"k-\" \"AKkB0a-_A9a_kA\" \"9BAA1b210k00\" \"10KkA01\" \"K9B9aB_a1-2-b\" \"2kBKK1b_B1\" \"a1a\" \"aK-k2_b1KAAA\" \"K0baBA-KaaBKaa\" \"A91K9a0\" \"b-_-kBkK0B0k22B\" \"9k\" \"AB9222__kBa\" \"0B_299_B\" \"92bA1a_aKkaa\" \"09\" \"_AkK\"]",
    "0B_299_B 2kBKK1b_B1 09 9BAA1b210k00 9k 10KkA01 92bA1a_aKkaa _AkK a1a A91K9a0 AB9222__kBa aK-k2_b1KAAA AKkB0a-_A9a_kA b-_-kBkK0B0k22B k- K0baBA-KaaBKaa K9B9aB_a1-2-b KAK2KbkkaB_-1",
    "", false, "dictionary-sort-2337",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"KAK2KbkkaB_-1\" \"k-\" \"AKkB0a-_A9a_kA\" \"9BAA1b210k00\" \"10KkA01\" \"K9B9aB_a1-2-b\" \"2kBKK1b_B1\" \"a1a\" \"aK-k2_b1KAAA\" \"K0baBA-KaaBKaa\" \"A91K9a0\" \"b-_-kBkK0B0k22B\" \"9k\" \"AB9222__kBa\" \"0B_299_B\" \"92bA1a_aKkaa\" \"09\" \"_AkK\"]",
    "KAK2KbkkaB_-1 K9B9aB_a1-2-b K0baBA-KaaBKaa k- b-_-kBkK0B0k22B AKkB0a-_A9a_kA aK-k2_b1KAAA AB9222__kBa A91K9a0 a1a _AkK 92bA1a_aKkaa 10KkA01 9k 9BAA1b210k00 09 2kBKK1b_B1 0B_299_B",
    "", false, "dictionary-sort-2338",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"KAK2KbkkaB_-1\" \"k-\" \"AKkB0a-_A9a_kA\" \"9BAA1b210k00\" \"10KkA01\" \"K9B9aB_a1-2-b\" \"2kBKK1b_B1\" \"a1a\" \"aK-k2_b1KAAA\" \"K0baBA-KaaBKaa\" \"A91K9a0\" \"b-_-kBkK0B0k22B\" \"9k\" \"AB9222__kBa\" \"0B_299_B\" \"92bA1a_aKkaa\" \"09\" \"_AkK\"]",
    "KAK2KbkkaB_-1 K9B9aB_a1-2-b K0baBA-KaaBKaa k- b-_-kBkK0B0k22B AKkB0a-_A9a_kA aK-k2_b1KAAA AB9222__kBa A91K9a0 a1a _AkK 92bA1a_aKkaa 10KkA01 9k 9BAA1b210k00 09 2kBKK1b_B1 0B_299_B",
    "", false, "dictionary-sort-2339",
  )
  check_search_case(
    "lsort -dictionary  [list \"_K91_-k\" \"b\" \"KBbakak-bbk\" \"aKaKk2baa0b-\" \"k029BB99\" \"0B92_bbk19k1K\" \"ak-bB2Bk1AAKb\" \"_Bk_k1k90B-A\" \"0KbbBAk_b0\" \"aAbb_-\" \"A19kb192B-kBB_2\" \"00ba9\" \"k-bb0a_K2\" \"_KA91BaAa1_B0\" \"\" \"__K\" \"bA_A0\" \"9092k01b\"]",
    "{} 0B92_bbk19k1K 00ba9 0KbbBAk_b0 9092k01b __K _Bk_k1k90B-A _K91_-k _KA91BaAa1_B0 A19kb192B-kBB_2 aAbb_- ak-bB2Bk1AAKb aKaKk2baa0b- b bA_A0 k-bb0a_K2 k029BB99 KBbakak-bbk",
    "", false, "dictionary-sort-2340",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"_K91_-k\" \"b\" \"KBbakak-bbk\" \"aKaKk2baa0b-\" \"k029BB99\" \"0B92_bbk19k1K\" \"ak-bB2Bk1AAKb\" \"_Bk_k1k90B-A\" \"0KbbBAk_b0\" \"aAbb_-\" \"A19kb192B-kBB_2\" \"00ba9\" \"k-bb0a_K2\" \"_KA91BaAa1_B0\" \"\" \"__K\" \"bA_A0\" \"9092k01b\"]",
    "{} 0B92_bbk19k1K 00ba9 0KbbBAk_b0 9092k01b __K _Bk_k1k90B-A _K91_-k _KA91BaAa1_B0 A19kb192B-kBB_2 aAbb_- ak-bB2Bk1AAKb aKaKk2baa0b- b bA_A0 k-bb0a_K2 k029BB99 KBbakak-bbk",
    "", false, "dictionary-sort-2341",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"_K91_-k\" \"b\" \"KBbakak-bbk\" \"aKaKk2baa0b-\" \"k029BB99\" \"0B92_bbk19k1K\" \"ak-bB2Bk1AAKb\" \"_Bk_k1k90B-A\" \"0KbbBAk_b0\" \"aAbb_-\" \"A19kb192B-kBB_2\" \"00ba9\" \"k-bb0a_K2\" \"_KA91BaAa1_B0\" \"\" \"__K\" \"bA_A0\" \"9092k01b\"]",
    "{} 0B92_bbk19k1K 00ba9 0KbbBAk_b0 9092k01b __K _Bk_k1k90B-A _K91_-k _KA91BaAa1_B0 A19kb192B-kBB_2 aAbb_- ak-bB2Bk1AAKb aKaKk2baa0b- b bA_A0 k-bb0a_K2 k029BB99 KBbakak-bbk",
    "", false, "dictionary-sort-2342",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"_K91_-k\" \"b\" \"KBbakak-bbk\" \"aKaKk2baa0b-\" \"k029BB99\" \"0B92_bbk19k1K\" \"ak-bB2Bk1AAKb\" \"_Bk_k1k90B-A\" \"0KbbBAk_b0\" \"aAbb_-\" \"A19kb192B-kBB_2\" \"00ba9\" \"k-bb0a_K2\" \"_KA91BaAa1_B0\" \"\" \"__K\" \"bA_A0\" \"9092k01b\"]",
    "KBbakak-bbk k029BB99 k-bb0a_K2 bA_A0 b aKaKk2baa0b- ak-bB2Bk1AAKb aAbb_- A19kb192B-kBB_2 _KA91BaAa1_B0 _K91_-k _Bk_k1k90B-A __K 9092k01b 0KbbBAk_b0 00ba9 0B92_bbk19k1K {}",
    "", false, "dictionary-sort-2343",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"_K91_-k\" \"b\" \"KBbakak-bbk\" \"aKaKk2baa0b-\" \"k029BB99\" \"0B92_bbk19k1K\" \"ak-bB2Bk1AAKb\" \"_Bk_k1k90B-A\" \"0KbbBAk_b0\" \"aAbb_-\" \"A19kb192B-kBB_2\" \"00ba9\" \"k-bb0a_K2\" \"_KA91BaAa1_B0\" \"\" \"__K\" \"bA_A0\" \"9092k01b\"]",
    "KBbakak-bbk k029BB99 k-bb0a_K2 bA_A0 b aKaKk2baa0b- ak-bB2Bk1AAKb aAbb_- A19kb192B-kBB_2 _KA91BaAa1_B0 _K91_-k _Bk_k1k90B-A __K 9092k01b 0KbbBAk_b0 00ba9 0B92_bbk19k1K {}",
    "", false, "dictionary-sort-2344",
  )
  check_search_case(
    "lsort -dictionary  [list \"b2KA22k29B22b9\" \"a\" \"_2a0KA-_A912B2\" \"B1k9\" \"\" \"-_aA_\" \"0aa_-\" \"\" \"2KbBb9b0bAA2aB\" \"920K_AkA-29A02\" \"_-a0a-A2_\" \"kB29k9aK\" \"K20B-b_220-k9\" \"k2B191-\" \"KaAA\" \"2_Kk2-21\" \"a-91K1Bk0\" \"-a9K2A_KB9b\"]",
    "{} {} -_aA_ -a9K2A_KB9b 0aa_- 2_Kk2-21 2KbBb9b0bAA2aB 920K_AkA-29A02 _-a0a-A2_ _2a0KA-_A912B2 a a-91K1Bk0 B1k9 b2KA22k29B22b9 k2B191- K20B-b_220-k9 KaAA kB29k9aK",
    "", false, "dictionary-sort-2345",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"b2KA22k29B22b9\" \"a\" \"_2a0KA-_A912B2\" \"B1k9\" \"\" \"-_aA_\" \"0aa_-\" \"\" \"2KbBb9b0bAA2aB\" \"920K_AkA-29A02\" \"_-a0a-A2_\" \"kB29k9aK\" \"K20B-b_220-k9\" \"k2B191-\" \"KaAA\" \"2_Kk2-21\" \"a-91K1Bk0\" \"-a9K2A_KB9b\"]",
    "{} {} -_aA_ -a9K2A_KB9b 0aa_- 2_Kk2-21 2KbBb9b0bAA2aB 920K_AkA-29A02 _-a0a-A2_ _2a0KA-_A912B2 a a-91K1Bk0 B1k9 b2KA22k29B22b9 k2B191- K20B-b_220-k9 KaAA kB29k9aK",
    "", false, "dictionary-sort-2346",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"b2KA22k29B22b9\" \"a\" \"_2a0KA-_A912B2\" \"B1k9\" \"\" \"-_aA_\" \"0aa_-\" \"\" \"2KbBb9b0bAA2aB\" \"920K_AkA-29A02\" \"_-a0a-A2_\" \"kB29k9aK\" \"K20B-b_220-k9\" \"k2B191-\" \"KaAA\" \"2_Kk2-21\" \"a-91K1Bk0\" \"-a9K2A_KB9b\"]",
    "{} -_aA_ -a9K2A_KB9b 0aa_- 2_Kk2-21 2KbBb9b0bAA2aB 920K_AkA-29A02 _-a0a-A2_ _2a0KA-_A912B2 a a-91K1Bk0 B1k9 b2KA22k29B22b9 k2B191- K20B-b_220-k9 KaAA kB29k9aK",
    "", false, "dictionary-sort-2347",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"b2KA22k29B22b9\" \"a\" \"_2a0KA-_A912B2\" \"B1k9\" \"\" \"-_aA_\" \"0aa_-\" \"\" \"2KbBb9b0bAA2aB\" \"920K_AkA-29A02\" \"_-a0a-A2_\" \"kB29k9aK\" \"K20B-b_220-k9\" \"k2B191-\" \"KaAA\" \"2_Kk2-21\" \"a-91K1Bk0\" \"-a9K2A_KB9b\"]",
    "kB29k9aK KaAA K20B-b_220-k9 k2B191- b2KA22k29B22b9 B1k9 a-91K1Bk0 a _2a0KA-_A912B2 _-a0a-A2_ 920K_AkA-29A02 2KbBb9b0bAA2aB 2_Kk2-21 0aa_- -a9K2A_KB9b -_aA_ {} {}",
    "", false, "dictionary-sort-2348",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"b2KA22k29B22b9\" \"a\" \"_2a0KA-_A912B2\" \"B1k9\" \"\" \"-_aA_\" \"0aa_-\" \"\" \"2KbBb9b0bAA2aB\" \"920K_AkA-29A02\" \"_-a0a-A2_\" \"kB29k9aK\" \"K20B-b_220-k9\" \"k2B191-\" \"KaAA\" \"2_Kk2-21\" \"a-91K1Bk0\" \"-a9K2A_KB9b\"]",
    "kB29k9aK KaAA K20B-b_220-k9 k2B191- b2KA22k29B22b9 B1k9 a-91K1Bk0 a _2a0KA-_A912B2 _-a0a-A2_ 920K_AkA-29A02 2KbBb9b0bAA2aB 2_Kk2-21 0aa_- -a9K2A_KB9b -_aA_ {}",
    "", false, "dictionary-sort-2349",
  )
  check_search_case(
    "lsort -dictionary  [list \"9AK1911\" \"1-\" \"00\" \"-0b\" \"a1kbaA9_ab1A9-k\" \"1K921A\" \"k2b1\" \"-_kkBKb\" \"A_a0K120BB11_B\" \"aAb9ak\" \"-a129\" \"110AK\" \"bk2Aa2b_B\" \"b-0b-910\" \"ka10bka09-KB_\" \"AkaA_\" \"20_-_K92kb19\" \"_K\"]",
    "-0b -_kkBKb -a129 00 1- 1K921A 9AK1911 20_-_K92kb19 110AK _K a1kbaA9_ab1A9-k A_a0K120BB11_B aAb9ak AkaA_ b-0b-910 bk2Aa2b_B k2b1 ka10bka09-KB_",
    "", false, "dictionary-sort-2350",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"9AK1911\" \"1-\" \"00\" \"-0b\" \"a1kbaA9_ab1A9-k\" \"1K921A\" \"k2b1\" \"-_kkBKb\" \"A_a0K120BB11_B\" \"aAb9ak\" \"-a129\" \"110AK\" \"bk2Aa2b_B\" \"b-0b-910\" \"ka10bka09-KB_\" \"AkaA_\" \"20_-_K92kb19\" \"_K\"]",
    "-0b -_kkBKb -a129 00 1- 1K921A 9AK1911 20_-_K92kb19 110AK _K a1kbaA9_ab1A9-k A_a0K120BB11_B aAb9ak AkaA_ b-0b-910 bk2Aa2b_B k2b1 ka10bka09-KB_",
    "", false, "dictionary-sort-2351",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"9AK1911\" \"1-\" \"00\" \"-0b\" \"a1kbaA9_ab1A9-k\" \"1K921A\" \"k2b1\" \"-_kkBKb\" \"A_a0K120BB11_B\" \"aAb9ak\" \"-a129\" \"110AK\" \"bk2Aa2b_B\" \"b-0b-910\" \"ka10bka09-KB_\" \"AkaA_\" \"20_-_K92kb19\" \"_K\"]",
    "-0b -_kkBKb -a129 00 1- 1K921A 9AK1911 20_-_K92kb19 110AK _K a1kbaA9_ab1A9-k A_a0K120BB11_B aAb9ak AkaA_ b-0b-910 bk2Aa2b_B k2b1 ka10bka09-KB_",
    "", false, "dictionary-sort-2352",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"9AK1911\" \"1-\" \"00\" \"-0b\" \"a1kbaA9_ab1A9-k\" \"1K921A\" \"k2b1\" \"-_kkBKb\" \"A_a0K120BB11_B\" \"aAb9ak\" \"-a129\" \"110AK\" \"bk2Aa2b_B\" \"b-0b-910\" \"ka10bka09-KB_\" \"AkaA_\" \"20_-_K92kb19\" \"_K\"]",
    "ka10bka09-KB_ k2b1 bk2Aa2b_B b-0b-910 AkaA_ aAb9ak A_a0K120BB11_B a1kbaA9_ab1A9-k _K 110AK 20_-_K92kb19 9AK1911 1K921A 1- 00 -a129 -_kkBKb -0b",
    "", false, "dictionary-sort-2353",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"9AK1911\" \"1-\" \"00\" \"-0b\" \"a1kbaA9_ab1A9-k\" \"1K921A\" \"k2b1\" \"-_kkBKb\" \"A_a0K120BB11_B\" \"aAb9ak\" \"-a129\" \"110AK\" \"bk2Aa2b_B\" \"b-0b-910\" \"ka10bka09-KB_\" \"AkaA_\" \"20_-_K92kb19\" \"_K\"]",
    "ka10bka09-KB_ k2b1 bk2Aa2b_B b-0b-910 AkaA_ aAb9ak A_a0K120BB11_B a1kbaA9_ab1A9-k _K 110AK 20_-_K92kb19 9AK1911 1K921A 1- 00 -a129 -_kkBKb -0b",
    "", false, "dictionary-sort-2354",
  )
  check_search_case(
    "lsort -dictionary  [list \"b9-B1-KA\" \"BAAbb_1Kbk\" \"a1\" \"B-BK\" \"b\" \"-1\" \"Ba_1Ba1b_\" \"KbABb10bb-9AKb2\" \"-kkA19a2b_0A-a9\" \"-b\" \"B2ka112k19a0a\" \"\" \"2K_0-0k1b\" \"12kBb\" \"K00-\" \"k_-BB9BkK2k1\" \"k\" \"-0a1Bbb-1029K\"]",
    "{} -0a1Bbb-1029K -1 -b -kkA19a2b_0A-a9 2K_0-0k1b 12kBb a1 b B-BK B2ka112k19a0a b9-B1-KA Ba_1Ba1b_ BAAbb_1Kbk k K00- k_-BB9BkK2k1 KbABb10bb-9AKb2",
    "", false, "dictionary-sort-2355",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"b9-B1-KA\" \"BAAbb_1Kbk\" \"a1\" \"B-BK\" \"b\" \"-1\" \"Ba_1Ba1b_\" \"KbABb10bb-9AKb2\" \"-kkA19a2b_0A-a9\" \"-b\" \"B2ka112k19a0a\" \"\" \"2K_0-0k1b\" \"12kBb\" \"K00-\" \"k_-BB9BkK2k1\" \"k\" \"-0a1Bbb-1029K\"]",
    "{} -0a1Bbb-1029K -1 -b -kkA19a2b_0A-a9 2K_0-0k1b 12kBb a1 b B-BK B2ka112k19a0a b9-B1-KA Ba_1Ba1b_ BAAbb_1Kbk k K00- k_-BB9BkK2k1 KbABb10bb-9AKb2",
    "", false, "dictionary-sort-2356",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"b9-B1-KA\" \"BAAbb_1Kbk\" \"a1\" \"B-BK\" \"b\" \"-1\" \"Ba_1Ba1b_\" \"KbABb10bb-9AKb2\" \"-kkA19a2b_0A-a9\" \"-b\" \"B2ka112k19a0a\" \"\" \"2K_0-0k1b\" \"12kBb\" \"K00-\" \"k_-BB9BkK2k1\" \"k\" \"-0a1Bbb-1029K\"]",
    "{} -0a1Bbb-1029K -1 -b -kkA19a2b_0A-a9 2K_0-0k1b 12kBb a1 b B-BK B2ka112k19a0a b9-B1-KA Ba_1Ba1b_ BAAbb_1Kbk k K00- k_-BB9BkK2k1 KbABb10bb-9AKb2",
    "", false, "dictionary-sort-2357",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"b9-B1-KA\" \"BAAbb_1Kbk\" \"a1\" \"B-BK\" \"b\" \"-1\" \"Ba_1Ba1b_\" \"KbABb10bb-9AKb2\" \"-kkA19a2b_0A-a9\" \"-b\" \"B2ka112k19a0a\" \"\" \"2K_0-0k1b\" \"12kBb\" \"K00-\" \"k_-BB9BkK2k1\" \"k\" \"-0a1Bbb-1029K\"]",
    "KbABb10bb-9AKb2 k_-BB9BkK2k1 K00- k BAAbb_1Kbk Ba_1Ba1b_ b9-B1-KA B2ka112k19a0a B-BK b a1 12kBb 2K_0-0k1b -kkA19a2b_0A-a9 -b -1 -0a1Bbb-1029K {}",
    "", false, "dictionary-sort-2358",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"b9-B1-KA\" \"BAAbb_1Kbk\" \"a1\" \"B-BK\" \"b\" \"-1\" \"Ba_1Ba1b_\" \"KbABb10bb-9AKb2\" \"-kkA19a2b_0A-a9\" \"-b\" \"B2ka112k19a0a\" \"\" \"2K_0-0k1b\" \"12kBb\" \"K00-\" \"k_-BB9BkK2k1\" \"k\" \"-0a1Bbb-1029K\"]",
    "KbABb10bb-9AKb2 k_-BB9BkK2k1 K00- k BAAbb_1Kbk Ba_1Ba1b_ b9-B1-KA B2ka112k19a0a B-BK b a1 12kBb 2K_0-0k1b -kkA19a2b_0A-a9 -b -1 -0a1Bbb-1029K {}",
    "", false, "dictionary-sort-2359",
  )
}

///|
test "Tcl search cases 2361 through 2400" {
  check_search_case(
    "lsort -dictionary  [list \"A2_9k\" \"kb-2AA-01Ab9-A\" \"BbbA\" \"a0\" \"_a0a-299bkAb21\" \"111KK2\" \"b0a_-K0bb\" \"120bk\" \"KB1a_010K9K090\" \"k0aKb_99\" \"22\" \"k11B\" \"_bKaB\" \"_2B9K0-_-_b1a\" \"9_ka_-\" \"9-09AA0k22b\" \"akA\" \"k99aAa0-B0\"]",
    "9-09AA0k22b 9_ka_- 22 111KK2 120bk _2B9K0-_-_b1a _a0a-299bkAb21 _bKaB a0 A2_9k akA b0a_-K0bb BbbA k0aKb_99 k11B k99aAa0-B0 kb-2AA-01Ab9-A KB1a_010K9K090",
    "", false, "dictionary-sort-2360",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"A2_9k\" \"kb-2AA-01Ab9-A\" \"BbbA\" \"a0\" \"_a0a-299bkAb21\" \"111KK2\" \"b0a_-K0bb\" \"120bk\" \"KB1a_010K9K090\" \"k0aKb_99\" \"22\" \"k11B\" \"_bKaB\" \"_2B9K0-_-_b1a\" \"9_ka_-\" \"9-09AA0k22b\" \"akA\" \"k99aAa0-B0\"]",
    "9-09AA0k22b 9_ka_- 22 111KK2 120bk _2B9K0-_-_b1a _a0a-299bkAb21 _bKaB a0 A2_9k akA b0a_-K0bb BbbA k0aKb_99 k11B k99aAa0-B0 kb-2AA-01Ab9-A KB1a_010K9K090",
    "", false, "dictionary-sort-2361",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"A2_9k\" \"kb-2AA-01Ab9-A\" \"BbbA\" \"a0\" \"_a0a-299bkAb21\" \"111KK2\" \"b0a_-K0bb\" \"120bk\" \"KB1a_010K9K090\" \"k0aKb_99\" \"22\" \"k11B\" \"_bKaB\" \"_2B9K0-_-_b1a\" \"9_ka_-\" \"9-09AA0k22b\" \"akA\" \"k99aAa0-B0\"]",
    "9-09AA0k22b 9_ka_- 22 111KK2 120bk _2B9K0-_-_b1a _a0a-299bkAb21 _bKaB a0 A2_9k akA b0a_-K0bb BbbA k0aKb_99 k11B k99aAa0-B0 kb-2AA-01Ab9-A KB1a_010K9K090",
    "", false, "dictionary-sort-2362",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"A2_9k\" \"kb-2AA-01Ab9-A\" \"BbbA\" \"a0\" \"_a0a-299bkAb21\" \"111KK2\" \"b0a_-K0bb\" \"120bk\" \"KB1a_010K9K090\" \"k0aKb_99\" \"22\" \"k11B\" \"_bKaB\" \"_2B9K0-_-_b1a\" \"9_ka_-\" \"9-09AA0k22b\" \"akA\" \"k99aAa0-B0\"]",
    "KB1a_010K9K090 kb-2AA-01Ab9-A k99aAa0-B0 k11B k0aKb_99 BbbA b0a_-K0bb akA A2_9k a0 _bKaB _a0a-299bkAb21 _2B9K0-_-_b1a 120bk 111KK2 22 9_ka_- 9-09AA0k22b",
    "", false, "dictionary-sort-2363",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"A2_9k\" \"kb-2AA-01Ab9-A\" \"BbbA\" \"a0\" \"_a0a-299bkAb21\" \"111KK2\" \"b0a_-K0bb\" \"120bk\" \"KB1a_010K9K090\" \"k0aKb_99\" \"22\" \"k11B\" \"_bKaB\" \"_2B9K0-_-_b1a\" \"9_ka_-\" \"9-09AA0k22b\" \"akA\" \"k99aAa0-B0\"]",
    "KB1a_010K9K090 kb-2AA-01Ab9-A k99aAa0-B0 k11B k0aKb_99 BbbA b0a_-K0bb akA A2_9k a0 _bKaB _a0a-299bkAb21 _2B9K0-_-_b1a 120bk 111KK2 22 9_ka_- 9-09AA0k22b",
    "", false, "dictionary-sort-2364",
  )
  check_search_case(
    "lsort -dictionary  [list \"2K-A__91k_bAA\" \"K22-aB2K\" \"-K_ab-b92\" \"a\" \"BA1AABAB0B1\" \"9A\" \"9a0bKB\" \"Bk22aka___BK9a\" \"9-B\" \"1K211B1Ka\" \"aA_Kk\" \"-_0kK_\" \"_1aA1b9ABK_2K\" \"2Bk_\" \"__kABB0_B-1k\" \"_Abb0a2a00_BK\" \"-A112a-9-k0\" \"bAB_1B\"]",
    "-_0kK_ -A112a-9-k0 -K_ab-b92 1K211B1Ka 2Bk_ 2K-A__91k_bAA 9-B 9A 9a0bKB _1aA1b9ABK_2K __kABB0_B-1k _Abb0a2a00_BK a aA_Kk BA1AABAB0B1 bAB_1B Bk22aka___BK9a K22-aB2K",
    "", false, "dictionary-sort-2365",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"2K-A__91k_bAA\" \"K22-aB2K\" \"-K_ab-b92\" \"a\" \"BA1AABAB0B1\" \"9A\" \"9a0bKB\" \"Bk22aka___BK9a\" \"9-B\" \"1K211B1Ka\" \"aA_Kk\" \"-_0kK_\" \"_1aA1b9ABK_2K\" \"2Bk_\" \"__kABB0_B-1k\" \"_Abb0a2a00_BK\" \"-A112a-9-k0\" \"bAB_1B\"]",
    "-_0kK_ -A112a-9-k0 -K_ab-b92 1K211B1Ka 2Bk_ 2K-A__91k_bAA 9-B 9A 9a0bKB _1aA1b9ABK_2K __kABB0_B-1k _Abb0a2a00_BK a aA_Kk BA1AABAB0B1 bAB_1B Bk22aka___BK9a K22-aB2K",
    "", false, "dictionary-sort-2366",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"2K-A__91k_bAA\" \"K22-aB2K\" \"-K_ab-b92\" \"a\" \"BA1AABAB0B1\" \"9A\" \"9a0bKB\" \"Bk22aka___BK9a\" \"9-B\" \"1K211B1Ka\" \"aA_Kk\" \"-_0kK_\" \"_1aA1b9ABK_2K\" \"2Bk_\" \"__kABB0_B-1k\" \"_Abb0a2a00_BK\" \"-A112a-9-k0\" \"bAB_1B\"]",
    "-_0kK_ -A112a-9-k0 -K_ab-b92 1K211B1Ka 2Bk_ 2K-A__91k_bAA 9-B 9A 9a0bKB _1aA1b9ABK_2K __kABB0_B-1k _Abb0a2a00_BK a aA_Kk BA1AABAB0B1 bAB_1B Bk22aka___BK9a K22-aB2K",
    "", false, "dictionary-sort-2367",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"2K-A__91k_bAA\" \"K22-aB2K\" \"-K_ab-b92\" \"a\" \"BA1AABAB0B1\" \"9A\" \"9a0bKB\" \"Bk22aka___BK9a\" \"9-B\" \"1K211B1Ka\" \"aA_Kk\" \"-_0kK_\" \"_1aA1b9ABK_2K\" \"2Bk_\" \"__kABB0_B-1k\" \"_Abb0a2a00_BK\" \"-A112a-9-k0\" \"bAB_1B\"]",
    "K22-aB2K Bk22aka___BK9a bAB_1B BA1AABAB0B1 aA_Kk a _Abb0a2a00_BK __kABB0_B-1k _1aA1b9ABK_2K 9a0bKB 9A 9-B 2K-A__91k_bAA 2Bk_ 1K211B1Ka -K_ab-b92 -A112a-9-k0 -_0kK_",
    "", false, "dictionary-sort-2368",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"2K-A__91k_bAA\" \"K22-aB2K\" \"-K_ab-b92\" \"a\" \"BA1AABAB0B1\" \"9A\" \"9a0bKB\" \"Bk22aka___BK9a\" \"9-B\" \"1K211B1Ka\" \"aA_Kk\" \"-_0kK_\" \"_1aA1b9ABK_2K\" \"2Bk_\" \"__kABB0_B-1k\" \"_Abb0a2a00_BK\" \"-A112a-9-k0\" \"bAB_1B\"]",
    "K22-aB2K Bk22aka___BK9a bAB_1B BA1AABAB0B1 aA_Kk a _Abb0a2a00_BK __kABB0_B-1k _1aA1b9ABK_2K 9a0bKB 9A 9-B 2K-A__91k_bAA 2Bk_ 1K211B1Ka -K_ab-b92 -A112a-9-k0 -_0kK_",
    "", false, "dictionary-sort-2369",
  )
  check_search_case(
    "lsort -dictionary  [list \"_1_09K_a_9-a1\" \"1a12aA09bAa\" \"bK0_0A-a2ak\" \"KabK021a\" \"kb2bBKB-\" \"1b_Ba0922B\" \"_aAkK09-k_0b\" \"0BBA9_AB_\" \"_-b2091BB\" \"BkK-0B_\" \"aKk2-b\" \"-ab0kbk22a99\" \"0B2-1_bABa9_B1b\" \"21121-bAk0\" \"k121A991\" \"kK_Kb-\" \"20KA1kB9901k2\" \"2-\"]",
    "-ab0kbk22a99 0B2-1_bABa9_B1b 0BBA9_AB_ 1a12aA09bAa 1b_Ba0922B 2- 20KA1kB9901k2 21121-bAk0 _-b2091BB _1_09K_a_9-a1 _aAkK09-k_0b aKk2-b bK0_0A-a2ak BkK-0B_ k121A991 KabK021a kb2bBKB- kK_Kb-",
    "", false, "dictionary-sort-2370",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"_1_09K_a_9-a1\" \"1a12aA09bAa\" \"bK0_0A-a2ak\" \"KabK021a\" \"kb2bBKB-\" \"1b_Ba0922B\" \"_aAkK09-k_0b\" \"0BBA9_AB_\" \"_-b2091BB\" \"BkK-0B_\" \"aKk2-b\" \"-ab0kbk22a99\" \"0B2-1_bABa9_B1b\" \"21121-bAk0\" \"k121A991\" \"kK_Kb-\" \"20KA1kB9901k2\" \"2-\"]",
    "-ab0kbk22a99 0B2-1_bABa9_B1b 0BBA9_AB_ 1a12aA09bAa 1b_Ba0922B 2- 20KA1kB9901k2 21121-bAk0 _-b2091BB _1_09K_a_9-a1 _aAkK09-k_0b aKk2-b bK0_0A-a2ak BkK-0B_ k121A991 KabK021a kb2bBKB- kK_Kb-",
    "", false, "dictionary-sort-2371",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"_1_09K_a_9-a1\" \"1a12aA09bAa\" \"bK0_0A-a2ak\" \"KabK021a\" \"kb2bBKB-\" \"1b_Ba0922B\" \"_aAkK09-k_0b\" \"0BBA9_AB_\" \"_-b2091BB\" \"BkK-0B_\" \"aKk2-b\" \"-ab0kbk22a99\" \"0B2-1_bABa9_B1b\" \"21121-bAk0\" \"k121A991\" \"kK_Kb-\" \"20KA1kB9901k2\" \"2-\"]",
    "-ab0kbk22a99 0B2-1_bABa9_B1b 0BBA9_AB_ 1a12aA09bAa 1b_Ba0922B 2- 20KA1kB9901k2 21121-bAk0 _-b2091BB _1_09K_a_9-a1 _aAkK09-k_0b aKk2-b bK0_0A-a2ak BkK-0B_ k121A991 KabK021a kb2bBKB- kK_Kb-",
    "", false, "dictionary-sort-2372",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"_1_09K_a_9-a1\" \"1a12aA09bAa\" \"bK0_0A-a2ak\" \"KabK021a\" \"kb2bBKB-\" \"1b_Ba0922B\" \"_aAkK09-k_0b\" \"0BBA9_AB_\" \"_-b2091BB\" \"BkK-0B_\" \"aKk2-b\" \"-ab0kbk22a99\" \"0B2-1_bABa9_B1b\" \"21121-bAk0\" \"k121A991\" \"kK_Kb-\" \"20KA1kB9901k2\" \"2-\"]",
    "kK_Kb- kb2bBKB- KabK021a k121A991 BkK-0B_ bK0_0A-a2ak aKk2-b _aAkK09-k_0b _1_09K_a_9-a1 _-b2091BB 21121-bAk0 20KA1kB9901k2 2- 1b_Ba0922B 1a12aA09bAa 0BBA9_AB_ 0B2-1_bABa9_B1b -ab0kbk22a99",
    "", false, "dictionary-sort-2373",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"_1_09K_a_9-a1\" \"1a12aA09bAa\" \"bK0_0A-a2ak\" \"KabK021a\" \"kb2bBKB-\" \"1b_Ba0922B\" \"_aAkK09-k_0b\" \"0BBA9_AB_\" \"_-b2091BB\" \"BkK-0B_\" \"aKk2-b\" \"-ab0kbk22a99\" \"0B2-1_bABa9_B1b\" \"21121-bAk0\" \"k121A991\" \"kK_Kb-\" \"20KA1kB9901k2\" \"2-\"]",
    "kK_Kb- kb2bBKB- KabK021a k121A991 BkK-0B_ bK0_0A-a2ak aKk2-b _aAkK09-k_0b _1_09K_a_9-a1 _-b2091BB 21121-bAk0 20KA1kB9901k2 2- 1b_Ba0922B 1a12aA09bAa 0BBA9_AB_ 0B2-1_bABa9_B1b -ab0kbk22a99",
    "", false, "dictionary-sort-2374",
  )
  check_search_case(
    "lsort -dictionary  [list \"bAk-B\" \"2kAA0A-21b\" \"b9bb-b9A21KA_1\" \"A--a2Kk9b10\" \"-__b921--_2K\" \"k9_A\" \"a-A01bk90b9\" \"Bk\" \"0a_k0109a-9kKa\" \"B1A1-A_21A_\" \"91_09B21A\" \"Ka2K21-Bb\" \"k1BB2_-bbbb\" \"22bbkb1900-\" \"02Kk92bKaaKkA-0\" \"A\" \"K_2KK\" \"0a9k_a9Ab-kb\"]",
    "-__b921--_2K 0a9k_a9Ab-kb 0a_k0109a-9kKa 2kAA0A-21b 02Kk92bKaaKkA-0 22bbkb1900- 91_09B21A A A--a2Kk9b10 a-A01bk90b9 B1A1-A_21A_ b9bb-b9A21KA_1 bAk-B Bk k1BB2_-bbbb k9_A K_2KK Ka2K21-Bb",
    "", false, "dictionary-sort-2375",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"bAk-B\" \"2kAA0A-21b\" \"b9bb-b9A21KA_1\" \"A--a2Kk9b10\" \"-__b921--_2K\" \"k9_A\" \"a-A01bk90b9\" \"Bk\" \"0a_k0109a-9kKa\" \"B1A1-A_21A_\" \"91_09B21A\" \"Ka2K21-Bb\" \"k1BB2_-bbbb\" \"22bbkb1900-\" \"02Kk92bKaaKkA-0\" \"A\" \"K_2KK\" \"0a9k_a9Ab-kb\"]",
    "-__b921--_2K 0a9k_a9Ab-kb 0a_k0109a-9kKa 2kAA0A-21b 02Kk92bKaaKkA-0 22bbkb1900- 91_09B21A A A--a2Kk9b10 a-A01bk90b9 B1A1-A_21A_ b9bb-b9A21KA_1 bAk-B Bk k1BB2_-bbbb k9_A K_2KK Ka2K21-Bb",
    "", false, "dictionary-sort-2376",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"bAk-B\" \"2kAA0A-21b\" \"b9bb-b9A21KA_1\" \"A--a2Kk9b10\" \"-__b921--_2K\" \"k9_A\" \"a-A01bk90b9\" \"Bk\" \"0a_k0109a-9kKa\" \"B1A1-A_21A_\" \"91_09B21A\" \"Ka2K21-Bb\" \"k1BB2_-bbbb\" \"22bbkb1900-\" \"02Kk92bKaaKkA-0\" \"A\" \"K_2KK\" \"0a9k_a9Ab-kb\"]",
    "-__b921--_2K 0a9k_a9Ab-kb 0a_k0109a-9kKa 2kAA0A-21b 02Kk92bKaaKkA-0 22bbkb1900- 91_09B21A A A--a2Kk9b10 a-A01bk90b9 B1A1-A_21A_ b9bb-b9A21KA_1 bAk-B Bk k1BB2_-bbbb k9_A K_2KK Ka2K21-Bb",
    "", false, "dictionary-sort-2377",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"bAk-B\" \"2kAA0A-21b\" \"b9bb-b9A21KA_1\" \"A--a2Kk9b10\" \"-__b921--_2K\" \"k9_A\" \"a-A01bk90b9\" \"Bk\" \"0a_k0109a-9kKa\" \"B1A1-A_21A_\" \"91_09B21A\" \"Ka2K21-Bb\" \"k1BB2_-bbbb\" \"22bbkb1900-\" \"02Kk92bKaaKkA-0\" \"A\" \"K_2KK\" \"0a9k_a9Ab-kb\"]",
    "Ka2K21-Bb K_2KK k9_A k1BB2_-bbbb Bk bAk-B b9bb-b9A21KA_1 B1A1-A_21A_ a-A01bk90b9 A--a2Kk9b10 A 91_09B21A 22bbkb1900- 02Kk92bKaaKkA-0 2kAA0A-21b 0a_k0109a-9kKa 0a9k_a9Ab-kb -__b921--_2K",
    "", false, "dictionary-sort-2378",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"bAk-B\" \"2kAA0A-21b\" \"b9bb-b9A21KA_1\" \"A--a2Kk9b10\" \"-__b921--_2K\" \"k9_A\" \"a-A01bk90b9\" \"Bk\" \"0a_k0109a-9kKa\" \"B1A1-A_21A_\" \"91_09B21A\" \"Ka2K21-Bb\" \"k1BB2_-bbbb\" \"22bbkb1900-\" \"02Kk92bKaaKkA-0\" \"A\" \"K_2KK\" \"0a9k_a9Ab-kb\"]",
    "Ka2K21-Bb K_2KK k9_A k1BB2_-bbbb Bk bAk-B b9bb-b9A21KA_1 B1A1-A_21A_ a-A01bk90b9 A--a2Kk9b10 A 91_09B21A 22bbkb1900- 02Kk92bKaaKkA-0 2kAA0A-21b 0a_k0109a-9kKa 0a9k_a9Ab-kb -__b921--_2K",
    "", false, "dictionary-sort-2379",
  )
  check_search_case(
    "lsort -dictionary  [list \"-ba2bA_92b0-\" \"A9Ab\" \"010B_K9-ba1020\" \"b_12Ba\" \"b19a__-\" \"bAAB2\" \"-191aa0_A\" \"029K\" \"Ab2K000_b\" \"a2KKba___\" \"1A212a0_2Bk\" \"AB_B2\" \"-AKkBAb\" \"929aK109\" \"01BA1BKa2-01a\" \"_9\" \"AKaA-K_b0\" \"0ab_\"]",
    "-191aa0_A -AKkBAb -ba2bA_92b0- 0ab_ 1A212a0_2Bk 01BA1BKa2-01a 010B_K9-ba1020 029K 929aK109 _9 a2KKba___ A9Ab Ab2K000_b AB_B2 AKaA-K_b0 b19a__- b_12Ba bAAB2",
    "", false, "dictionary-sort-2380",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"-ba2bA_92b0-\" \"A9Ab\" \"010B_K9-ba1020\" \"b_12Ba\" \"b19a__-\" \"bAAB2\" \"-191aa0_A\" \"029K\" \"Ab2K000_b\" \"a2KKba___\" \"1A212a0_2Bk\" \"AB_B2\" \"-AKkBAb\" \"929aK109\" \"01BA1BKa2-01a\" \"_9\" \"AKaA-K_b0\" \"0ab_\"]",
    "-191aa0_A -AKkBAb -ba2bA_92b0- 0ab_ 1A212a0_2Bk 01BA1BKa2-01a 010B_K9-ba1020 029K 929aK109 _9 a2KKba___ A9Ab Ab2K000_b AB_B2 AKaA-K_b0 b19a__- b_12Ba bAAB2",
    "", false, "dictionary-sort-2381",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"-ba2bA_92b0-\" \"A9Ab\" \"010B_K9-ba1020\" \"b_12Ba\" \"b19a__-\" \"bAAB2\" \"-191aa0_A\" \"029K\" \"Ab2K000_b\" \"a2KKba___\" \"1A212a0_2Bk\" \"AB_B2\" \"-AKkBAb\" \"929aK109\" \"01BA1BKa2-01a\" \"_9\" \"AKaA-K_b0\" \"0ab_\"]",
    "-191aa0_A -AKkBAb -ba2bA_92b0- 0ab_ 1A212a0_2Bk 01BA1BKa2-01a 010B_K9-ba1020 029K 929aK109 _9 a2KKba___ A9Ab Ab2K000_b AB_B2 AKaA-K_b0 b19a__- b_12Ba bAAB2",
    "", false, "dictionary-sort-2382",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"-ba2bA_92b0-\" \"A9Ab\" \"010B_K9-ba1020\" \"b_12Ba\" \"b19a__-\" \"bAAB2\" \"-191aa0_A\" \"029K\" \"Ab2K000_b\" \"a2KKba___\" \"1A212a0_2Bk\" \"AB_B2\" \"-AKkBAb\" \"929aK109\" \"01BA1BKa2-01a\" \"_9\" \"AKaA-K_b0\" \"0ab_\"]",
    "bAAB2 b_12Ba b19a__- AKaA-K_b0 AB_B2 Ab2K000_b A9Ab a2KKba___ _9 929aK109 029K 010B_K9-ba1020 01BA1BKa2-01a 1A212a0_2Bk 0ab_ -ba2bA_92b0- -AKkBAb -191aa0_A",
    "", false, "dictionary-sort-2383",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"-ba2bA_92b0-\" \"A9Ab\" \"010B_K9-ba1020\" \"b_12Ba\" \"b19a__-\" \"bAAB2\" \"-191aa0_A\" \"029K\" \"Ab2K000_b\" \"a2KKba___\" \"1A212a0_2Bk\" \"AB_B2\" \"-AKkBAb\" \"929aK109\" \"01BA1BKa2-01a\" \"_9\" \"AKaA-K_b0\" \"0ab_\"]",
    "bAAB2 b_12Ba b19a__- AKaA-K_b0 AB_B2 Ab2K000_b A9Ab a2KKba___ _9 929aK109 029K 010B_K9-ba1020 01BA1BKa2-01a 1A212a0_2Bk 0ab_ -ba2bA_92b0- -AKkBAb -191aa0_A",
    "", false, "dictionary-sort-2384",
  )
  check_search_case(
    "lsort -dictionary  [list \"a92\" \"-91k_b9KK2\" \"A0BK29-a1\" \"k\" \"_BKk\" \"111b2_aA-aaA92\" \"1_a01BB_kbk\" \"a19B-\" \"1ak2__akkkA_B2-\" \"k1kkB29_K2AAkb\" \"k\" \"\" \"K0_bK\" \"-9KK9-_B\" \"KbaB_ak_Kk-_B_\" \"Bb1\" \"21\" \"kB_KBkAb0\"]",
    "{} -9KK9-_B -91k_b9KK2 1_a01BB_kbk 1ak2__akkkA_B2- 21 111b2_aA-aaA92 _BKk A0BK29-a1 a19B- a92 Bb1 k k K0_bK k1kkB29_K2AAkb kB_KBkAb0 KbaB_ak_Kk-_B_",
    "", false, "dictionary-sort-2385",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"a92\" \"-91k_b9KK2\" \"A0BK29-a1\" \"k\" \"_BKk\" \"111b2_aA-aaA92\" \"1_a01BB_kbk\" \"a19B-\" \"1ak2__akkkA_B2-\" \"k1kkB29_K2AAkb\" \"k\" \"\" \"K0_bK\" \"-9KK9-_B\" \"KbaB_ak_Kk-_B_\" \"Bb1\" \"21\" \"kB_KBkAb0\"]",
    "{} -9KK9-_B -91k_b9KK2 1_a01BB_kbk 1ak2__akkkA_B2- 21 111b2_aA-aaA92 _BKk A0BK29-a1 a19B- a92 Bb1 k k K0_bK k1kkB29_K2AAkb kB_KBkAb0 KbaB_ak_Kk-_B_",
    "", false, "dictionary-sort-2386",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"a92\" \"-91k_b9KK2\" \"A0BK29-a1\" \"k\" \"_BKk\" \"111b2_aA-aaA92\" \"1_a01BB_kbk\" \"a19B-\" \"1ak2__akkkA_B2-\" \"k1kkB29_K2AAkb\" \"k\" \"\" \"K0_bK\" \"-9KK9-_B\" \"KbaB_ak_Kk-_B_\" \"Bb1\" \"21\" \"kB_KBkAb0\"]",
    "{} -9KK9-_B -91k_b9KK2 1_a01BB_kbk 1ak2__akkkA_B2- 21 111b2_aA-aaA92 _BKk A0BK29-a1 a19B- a92 Bb1 k K0_bK k1kkB29_K2AAkb kB_KBkAb0 KbaB_ak_Kk-_B_",
    "", false, "dictionary-sort-2387",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"a92\" \"-91k_b9KK2\" \"A0BK29-a1\" \"k\" \"_BKk\" \"111b2_aA-aaA92\" \"1_a01BB_kbk\" \"a19B-\" \"1ak2__akkkA_B2-\" \"k1kkB29_K2AAkb\" \"k\" \"\" \"K0_bK\" \"-9KK9-_B\" \"KbaB_ak_Kk-_B_\" \"Bb1\" \"21\" \"kB_KBkAb0\"]",
    "KbaB_ak_Kk-_B_ kB_KBkAb0 k1kkB29_K2AAkb K0_bK k k Bb1 a92 a19B- A0BK29-a1 _BKk 111b2_aA-aaA92 21 1ak2__akkkA_B2- 1_a01BB_kbk -91k_b9KK2 -9KK9-_B {}",
    "", false, "dictionary-sort-2388",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"a92\" \"-91k_b9KK2\" \"A0BK29-a1\" \"k\" \"_BKk\" \"111b2_aA-aaA92\" \"1_a01BB_kbk\" \"a19B-\" \"1ak2__akkkA_B2-\" \"k1kkB29_K2AAkb\" \"k\" \"\" \"K0_bK\" \"-9KK9-_B\" \"KbaB_ak_Kk-_B_\" \"Bb1\" \"21\" \"kB_KBkAb0\"]",
    "KbaB_ak_Kk-_B_ kB_KBkAb0 k1kkB29_K2AAkb K0_bK k Bb1 a92 a19B- A0BK29-a1 _BKk 111b2_aA-aaA92 21 1ak2__akkkA_B2- 1_a01BB_kbk -91k_b9KK2 -9KK9-_B {}",
    "", false, "dictionary-sort-2389",
  )
  check_search_case(
    "lsort -dictionary  [list \"k0909-a\" \"a\" \"1Bb9ka_k9-109\" \"00a0kKKB-a-1\" \"\" \"k-0a9-a9\" \"Ak2_0B29A91\" \"a9b90Akb-22a\" \"-299b91\" \"K_9KAB09\" \"21aBkAb-20A9_\" \"2K1-AB9-K\" \"-b\" \"A90B90\" \"aKK1a92KkKaK11K\" \"\" \"bk0__a1k1b0Aa_\" \"a1aA0k-B90-\"]",
    "{} {} -299b91 -b 00a0kKKB-a-1 1Bb9ka_k9-109 2K1-AB9-K 21aBkAb-20A9_ a a1aA0k-B90- a9b90Akb-22a A90B90 Ak2_0B29A91 aKK1a92KkKaK11K bk0__a1k1b0Aa_ k-0a9-a9 k0909-a K_9KAB09",
    "", false, "dictionary-sort-2390",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"k0909-a\" \"a\" \"1Bb9ka_k9-109\" \"00a0kKKB-a-1\" \"\" \"k-0a9-a9\" \"Ak2_0B29A91\" \"a9b90Akb-22a\" \"-299b91\" \"K_9KAB09\" \"21aBkAb-20A9_\" \"2K1-AB9-K\" \"-b\" \"A90B90\" \"aKK1a92KkKaK11K\" \"\" \"bk0__a1k1b0Aa_\" \"a1aA0k-B90-\"]",
    "{} {} -299b91 -b 00a0kKKB-a-1 1Bb9ka_k9-109 2K1-AB9-K 21aBkAb-20A9_ a a1aA0k-B90- a9b90Akb-22a A90B90 Ak2_0B29A91 aKK1a92KkKaK11K bk0__a1k1b0Aa_ k-0a9-a9 k0909-a K_9KAB09",
    "", false, "dictionary-sort-2391",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"k0909-a\" \"a\" \"1Bb9ka_k9-109\" \"00a0kKKB-a-1\" \"\" \"k-0a9-a9\" \"Ak2_0B29A91\" \"a9b90Akb-22a\" \"-299b91\" \"K_9KAB09\" \"21aBkAb-20A9_\" \"2K1-AB9-K\" \"-b\" \"A90B90\" \"aKK1a92KkKaK11K\" \"\" \"bk0__a1k1b0Aa_\" \"a1aA0k-B90-\"]",
    "{} -299b91 -b 00a0kKKB-a-1 1Bb9ka_k9-109 2K1-AB9-K 21aBkAb-20A9_ a a1aA0k-B90- a9b90Akb-22a A90B90 Ak2_0B29A91 aKK1a92KkKaK11K bk0__a1k1b0Aa_ k-0a9-a9 k0909-a K_9KAB09",
    "", false, "dictionary-sort-2392",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"k0909-a\" \"a\" \"1Bb9ka_k9-109\" \"00a0kKKB-a-1\" \"\" \"k-0a9-a9\" \"Ak2_0B29A91\" \"a9b90Akb-22a\" \"-299b91\" \"K_9KAB09\" \"21aBkAb-20A9_\" \"2K1-AB9-K\" \"-b\" \"A90B90\" \"aKK1a92KkKaK11K\" \"\" \"bk0__a1k1b0Aa_\" \"a1aA0k-B90-\"]",
    "K_9KAB09 k0909-a k-0a9-a9 bk0__a1k1b0Aa_ aKK1a92KkKaK11K Ak2_0B29A91 A90B90 a9b90Akb-22a a1aA0k-B90- a 21aBkAb-20A9_ 2K1-AB9-K 1Bb9ka_k9-109 00a0kKKB-a-1 -b -299b91 {} {}",
    "", false, "dictionary-sort-2393",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"k0909-a\" \"a\" \"1Bb9ka_k9-109\" \"00a0kKKB-a-1\" \"\" \"k-0a9-a9\" \"Ak2_0B29A91\" \"a9b90Akb-22a\" \"-299b91\" \"K_9KAB09\" \"21aBkAb-20A9_\" \"2K1-AB9-K\" \"-b\" \"A90B90\" \"aKK1a92KkKaK11K\" \"\" \"bk0__a1k1b0Aa_\" \"a1aA0k-B90-\"]",
    "K_9KAB09 k0909-a k-0a9-a9 bk0__a1k1b0Aa_ aKK1a92KkKaK11K Ak2_0B29A91 A90B90 a9b90Akb-22a a1aA0k-B90- a 21aBkAb-20A9_ 2K1-AB9-K 1Bb9ka_k9-109 00a0kKKB-a-1 -b -299b91 {}",
    "", false, "dictionary-sort-2394",
  )
  check_search_case(
    "lsort -dictionary  [list \"K0-Ka99\" \"_Aa\" \"9A_B1--0-0\" \"-b221\" \"KB-1a02B-\" \"k20\" \"kB_a_A2__0a_kA\" \"ab20a\" \"A2a_kK01-\" \"_a22aaabaA\" \"aBBb_a10-0\" \"91K9a9\" \"kbBAA22K9kaba2-\" \"9kbAk1a\" \"b0-0\" \"kB_bb_-_B9Bak\" \"Aba1baA\" \"-kA10A_a\"]",
    "-b221 -kA10A_a 9A_B1--0-0 9kbAk1a 91K9a9 _a22aaabaA _Aa A2a_kK01- ab20a Aba1baA aBBb_a10-0 b0-0 K0-Ka99 k20 KB-1a02B- kB_a_A2__0a_kA kB_bb_-_B9Bak kbBAA22K9kaba2-",
    "", false, "dictionary-sort-2395",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"K0-Ka99\" \"_Aa\" \"9A_B1--0-0\" \"-b221\" \"KB-1a02B-\" \"k20\" \"kB_a_A2__0a_kA\" \"ab20a\" \"A2a_kK01-\" \"_a22aaabaA\" \"aBBb_a10-0\" \"91K9a9\" \"kbBAA22K9kaba2-\" \"9kbAk1a\" \"b0-0\" \"kB_bb_-_B9Bak\" \"Aba1baA\" \"-kA10A_a\"]",
    "-b221 -kA10A_a 9A_B1--0-0 9kbAk1a 91K9a9 _a22aaabaA _Aa A2a_kK01- ab20a Aba1baA aBBb_a10-0 b0-0 K0-Ka99 k20 KB-1a02B- kB_a_A2__0a_kA kB_bb_-_B9Bak kbBAA22K9kaba2-",
    "", false, "dictionary-sort-2396",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K0-Ka99\" \"_Aa\" \"9A_B1--0-0\" \"-b221\" \"KB-1a02B-\" \"k20\" \"kB_a_A2__0a_kA\" \"ab20a\" \"A2a_kK01-\" \"_a22aaabaA\" \"aBBb_a10-0\" \"91K9a9\" \"kbBAA22K9kaba2-\" \"9kbAk1a\" \"b0-0\" \"kB_bb_-_B9Bak\" \"Aba1baA\" \"-kA10A_a\"]",
    "-b221 -kA10A_a 9A_B1--0-0 9kbAk1a 91K9a9 _a22aaabaA _Aa A2a_kK01- ab20a Aba1baA aBBb_a10-0 b0-0 K0-Ka99 k20 KB-1a02B- kB_a_A2__0a_kA kB_bb_-_B9Bak kbBAA22K9kaba2-",
    "", false, "dictionary-sort-2397",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"K0-Ka99\" \"_Aa\" \"9A_B1--0-0\" \"-b221\" \"KB-1a02B-\" \"k20\" \"kB_a_A2__0a_kA\" \"ab20a\" \"A2a_kK01-\" \"_a22aaabaA\" \"aBBb_a10-0\" \"91K9a9\" \"kbBAA22K9kaba2-\" \"9kbAk1a\" \"b0-0\" \"kB_bb_-_B9Bak\" \"Aba1baA\" \"-kA10A_a\"]",
    "kbBAA22K9kaba2- kB_bb_-_B9Bak kB_a_A2__0a_kA KB-1a02B- k20 K0-Ka99 b0-0 aBBb_a10-0 Aba1baA ab20a A2a_kK01- _Aa _a22aaabaA 91K9a9 9kbAk1a 9A_B1--0-0 -kA10A_a -b221",
    "", false, "dictionary-sort-2398",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K0-Ka99\" \"_Aa\" \"9A_B1--0-0\" \"-b221\" \"KB-1a02B-\" \"k20\" \"kB_a_A2__0a_kA\" \"ab20a\" \"A2a_kK01-\" \"_a22aaabaA\" \"aBBb_a10-0\" \"91K9a9\" \"kbBAA22K9kaba2-\" \"9kbAk1a\" \"b0-0\" \"kB_bb_-_B9Bak\" \"Aba1baA\" \"-kA10A_a\"]",
    "kbBAA22K9kaba2- kB_bb_-_B9Bak kB_a_A2__0a_kA KB-1a02B- k20 K0-Ka99 b0-0 aBBb_a10-0 Aba1baA ab20a A2a_kK01- _Aa _a22aaabaA 91K9a9 9kbAk1a 9A_B1--0-0 -kA10A_a -b221",
    "", false, "dictionary-sort-2399",
  )
}

///|
test "Tcl search cases 2401 through 2440" {
  check_search_case(
    "lsort -dictionary  [list \"19bkaA\" \"a0\" \"K29BA2_BK1122\" \"92b-KkaK-B\" \"-__Ba__aKkABa\" \"b_bK-0_Aa00bB\" \"1A0K29AK-K\" \"_bk_0\" \"b0_ab\" \"bK-K9K2Aab0_A\" \"1K-a1ka9aA2k1\" \"bBB0bk-b19\" \"1\" \"BA00BB9\" \"0012B\" \"1b\" \"B0k2\" \"baKbaKk2K99B_\"]",
    "-__Ba__aKkABa 1 1A0K29AK-K 1b 1K-a1ka9aA2k1 0012B 19bkaA 92b-KkaK-B _bk_0 a0 b0_ab B0k2 b_bK-0_Aa00bB BA00BB9 baKbaKk2K99B_ bBB0bk-b19 bK-K9K2Aab0_A K29BA2_BK1122",
    "", false, "dictionary-sort-2400",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"19bkaA\" \"a0\" \"K29BA2_BK1122\" \"92b-KkaK-B\" \"-__Ba__aKkABa\" \"b_bK-0_Aa00bB\" \"1A0K29AK-K\" \"_bk_0\" \"b0_ab\" \"bK-K9K2Aab0_A\" \"1K-a1ka9aA2k1\" \"bBB0bk-b19\" \"1\" \"BA00BB9\" \"0012B\" \"1b\" \"B0k2\" \"baKbaKk2K99B_\"]",
    "-__Ba__aKkABa 1 1A0K29AK-K 1b 1K-a1ka9aA2k1 0012B 19bkaA 92b-KkaK-B _bk_0 a0 b0_ab B0k2 b_bK-0_Aa00bB BA00BB9 baKbaKk2K99B_ bBB0bk-b19 bK-K9K2Aab0_A K29BA2_BK1122",
    "", false, "dictionary-sort-2401",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"19bkaA\" \"a0\" \"K29BA2_BK1122\" \"92b-KkaK-B\" \"-__Ba__aKkABa\" \"b_bK-0_Aa00bB\" \"1A0K29AK-K\" \"_bk_0\" \"b0_ab\" \"bK-K9K2Aab0_A\" \"1K-a1ka9aA2k1\" \"bBB0bk-b19\" \"1\" \"BA00BB9\" \"0012B\" \"1b\" \"B0k2\" \"baKbaKk2K99B_\"]",
    "-__Ba__aKkABa 1 1A0K29AK-K 1b 1K-a1ka9aA2k1 0012B 19bkaA 92b-KkaK-B _bk_0 a0 b0_ab B0k2 b_bK-0_Aa00bB BA00BB9 baKbaKk2K99B_ bBB0bk-b19 bK-K9K2Aab0_A K29BA2_BK1122",
    "", false, "dictionary-sort-2402",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"19bkaA\" \"a0\" \"K29BA2_BK1122\" \"92b-KkaK-B\" \"-__Ba__aKkABa\" \"b_bK-0_Aa00bB\" \"1A0K29AK-K\" \"_bk_0\" \"b0_ab\" \"bK-K9K2Aab0_A\" \"1K-a1ka9aA2k1\" \"bBB0bk-b19\" \"1\" \"BA00BB9\" \"0012B\" \"1b\" \"B0k2\" \"baKbaKk2K99B_\"]",
    "K29BA2_BK1122 bK-K9K2Aab0_A bBB0bk-b19 baKbaKk2K99B_ BA00BB9 b_bK-0_Aa00bB B0k2 b0_ab a0 _bk_0 92b-KkaK-B 19bkaA 0012B 1K-a1ka9aA2k1 1b 1A0K29AK-K 1 -__Ba__aKkABa",
    "", false, "dictionary-sort-2403",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"19bkaA\" \"a0\" \"K29BA2_BK1122\" \"92b-KkaK-B\" \"-__Ba__aKkABa\" \"b_bK-0_Aa00bB\" \"1A0K29AK-K\" \"_bk_0\" \"b0_ab\" \"bK-K9K2Aab0_A\" \"1K-a1ka9aA2k1\" \"bBB0bk-b19\" \"1\" \"BA00BB9\" \"0012B\" \"1b\" \"B0k2\" \"baKbaKk2K99B_\"]",
    "K29BA2_BK1122 bK-K9K2Aab0_A bBB0bk-b19 baKbaKk2K99B_ BA00BB9 b_bK-0_Aa00bB B0k2 b0_ab a0 _bk_0 92b-KkaK-B 19bkaA 0012B 1K-a1ka9aA2k1 1b 1A0K29AK-K 1 -__Ba__aKkABa",
    "", false, "dictionary-sort-2404",
  )
  check_search_case(
    "lsort -dictionary  [list \"2aAAK2_k\" \"_2Kb919aKb0b0\" \"K12k_bab\" \"k21-99\" \"b1a_bB9A1k_0a1\" \"19A0\" \"\" \"A-B0b-b_\" \"b-bk2_\" \"BKkA2aaK2_\" \"\" \"\" \"BbB\" \"9\" \"9_9KkBb91k-B_2A\" \"2\" \"bK9\" \"a9-\"]",
    "{} {} {} 2 2aAAK2_k 9 9_9KkBb91k-B_2A 19A0 _2Kb919aKb0b0 A-B0b-b_ a9- b-bk2_ b1a_bB9A1k_0a1 BbB bK9 BKkA2aaK2_ K12k_bab k21-99",
    "", false, "dictionary-sort-2405",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"2aAAK2_k\" \"_2Kb919aKb0b0\" \"K12k_bab\" \"k21-99\" \"b1a_bB9A1k_0a1\" \"19A0\" \"\" \"A-B0b-b_\" \"b-bk2_\" \"BKkA2aaK2_\" \"\" \"\" \"BbB\" \"9\" \"9_9KkBb91k-B_2A\" \"2\" \"bK9\" \"a9-\"]",
    "{} {} {} 2 2aAAK2_k 9 9_9KkBb91k-B_2A 19A0 _2Kb919aKb0b0 A-B0b-b_ a9- b-bk2_ b1a_bB9A1k_0a1 BbB bK9 BKkA2aaK2_ K12k_bab k21-99",
    "", false, "dictionary-sort-2406",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"2aAAK2_k\" \"_2Kb919aKb0b0\" \"K12k_bab\" \"k21-99\" \"b1a_bB9A1k_0a1\" \"19A0\" \"\" \"A-B0b-b_\" \"b-bk2_\" \"BKkA2aaK2_\" \"\" \"\" \"BbB\" \"9\" \"9_9KkBb91k-B_2A\" \"2\" \"bK9\" \"a9-\"]",
    "{} 2 2aAAK2_k 9 9_9KkBb91k-B_2A 19A0 _2Kb919aKb0b0 A-B0b-b_ a9- b-bk2_ b1a_bB9A1k_0a1 BbB bK9 BKkA2aaK2_ K12k_bab k21-99",
    "", false, "dictionary-sort-2407",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"2aAAK2_k\" \"_2Kb919aKb0b0\" \"K12k_bab\" \"k21-99\" \"b1a_bB9A1k_0a1\" \"19A0\" \"\" \"A-B0b-b_\" \"b-bk2_\" \"BKkA2aaK2_\" \"\" \"\" \"BbB\" \"9\" \"9_9KkBb91k-B_2A\" \"2\" \"bK9\" \"a9-\"]",
    "k21-99 K12k_bab BKkA2aaK2_ bK9 BbB b1a_bB9A1k_0a1 b-bk2_ a9- A-B0b-b_ _2Kb919aKb0b0 19A0 9_9KkBb91k-B_2A 9 2aAAK2_k 2 {} {} {}",
    "", false, "dictionary-sort-2408",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"2aAAK2_k\" \"_2Kb919aKb0b0\" \"K12k_bab\" \"k21-99\" \"b1a_bB9A1k_0a1\" \"19A0\" \"\" \"A-B0b-b_\" \"b-bk2_\" \"BKkA2aaK2_\" \"\" \"\" \"BbB\" \"9\" \"9_9KkBb91k-B_2A\" \"2\" \"bK9\" \"a9-\"]",
    "k21-99 K12k_bab BKkA2aaK2_ bK9 BbB b1a_bB9A1k_0a1 b-bk2_ a9- A-B0b-b_ _2Kb919aKb0b0 19A0 9_9KkBb91k-B_2A 9 2aAAK2_k 2 {}",
    "", false, "dictionary-sort-2409",
  )
  check_search_case(
    "lsort -dictionary  [list \"20kb_ab2a___\" \"12\" \"1KbK20bbaKb2\" \"_-_A9aA92\" \"Aak-BB22kkBA\" \"ka91K11bB19\" \"9a2\" \"91bkaK\" \"\" \"\" \"9_1ba129-9Bb--A\" \"b_\" \"9k_02baKAA0_B\" \"AK_0\" \"2b_\" \"-1AK\" \"bk2Bb1k\" \"B2k-1\"]",
    "{} {} -1AK 1KbK20bbaKb2 2b_ 9_1ba129-9Bb--A 9a2 9k_02baKAA0_B 12 20kb_ab2a___ 91bkaK _-_A9aA92 Aak-BB22kkBA AK_0 B2k-1 b_ bk2Bb1k ka91K11bB19",
    "", false, "dictionary-sort-2410",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"20kb_ab2a___\" \"12\" \"1KbK20bbaKb2\" \"_-_A9aA92\" \"Aak-BB22kkBA\" \"ka91K11bB19\" \"9a2\" \"91bkaK\" \"\" \"\" \"9_1ba129-9Bb--A\" \"b_\" \"9k_02baKAA0_B\" \"AK_0\" \"2b_\" \"-1AK\" \"bk2Bb1k\" \"B2k-1\"]",
    "{} {} -1AK 1KbK20bbaKb2 2b_ 9_1ba129-9Bb--A 9a2 9k_02baKAA0_B 12 20kb_ab2a___ 91bkaK _-_A9aA92 Aak-BB22kkBA AK_0 B2k-1 b_ bk2Bb1k ka91K11bB19",
    "", false, "dictionary-sort-2411",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"20kb_ab2a___\" \"12\" \"1KbK20bbaKb2\" \"_-_A9aA92\" \"Aak-BB22kkBA\" \"ka91K11bB19\" \"9a2\" \"91bkaK\" \"\" \"\" \"9_1ba129-9Bb--A\" \"b_\" \"9k_02baKAA0_B\" \"AK_0\" \"2b_\" \"-1AK\" \"bk2Bb1k\" \"B2k-1\"]",
    "{} -1AK 1KbK20bbaKb2 2b_ 9_1ba129-9Bb--A 9a2 9k_02baKAA0_B 12 20kb_ab2a___ 91bkaK _-_A9aA92 Aak-BB22kkBA AK_0 B2k-1 b_ bk2Bb1k ka91K11bB19",
    "", false, "dictionary-sort-2412",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"20kb_ab2a___\" \"12\" \"1KbK20bbaKb2\" \"_-_A9aA92\" \"Aak-BB22kkBA\" \"ka91K11bB19\" \"9a2\" \"91bkaK\" \"\" \"\" \"9_1ba129-9Bb--A\" \"b_\" \"9k_02baKAA0_B\" \"AK_0\" \"2b_\" \"-1AK\" \"bk2Bb1k\" \"B2k-1\"]",
    "ka91K11bB19 bk2Bb1k b_ B2k-1 AK_0 Aak-BB22kkBA _-_A9aA92 91bkaK 20kb_ab2a___ 12 9k_02baKAA0_B 9a2 9_1ba129-9Bb--A 2b_ 1KbK20bbaKb2 -1AK {} {}",
    "", false, "dictionary-sort-2413",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"20kb_ab2a___\" \"12\" \"1KbK20bbaKb2\" \"_-_A9aA92\" \"Aak-BB22kkBA\" \"ka91K11bB19\" \"9a2\" \"91bkaK\" \"\" \"\" \"9_1ba129-9Bb--A\" \"b_\" \"9k_02baKAA0_B\" \"AK_0\" \"2b_\" \"-1AK\" \"bk2Bb1k\" \"B2k-1\"]",
    "ka91K11bB19 bk2Bb1k b_ B2k-1 AK_0 Aak-BB22kkBA _-_A9aA92 91bkaK 20kb_ab2a___ 12 9k_02baKAA0_B 9a2 9_1ba129-9Bb--A 2b_ 1KbK20bbaKb2 -1AK {}",
    "", false, "dictionary-sort-2414",
  )
  check_search_case(
    "lsort -dictionary  [list \"2bk0b_\" \"aBBk-BK9a92\" \"\" \"k0_\" \"Aa--b\" \"aB_KBa9K-0-9a2\" \"9\" \"b0\" \"a9b229_2ak\" \"_\" \"A_A-BBA0B-\" \"ab\" \"b\" \"_ak-aBA2\" \"_b02-BAb\" \"K\" \"1_--BK-b1bbab\" \"b9101b9_AKAA\"]",
    "{} 1_--BK-b1bbab 2bk0b_ 9 _ _ak-aBA2 _b02-BAb a9b229_2ak A_A-BBA0B- Aa--b ab aB_KBa9K-0-9a2 aBBk-BK9a92 b b0 b9101b9_AKAA K k0_",
    "", false, "dictionary-sort-2415",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"2bk0b_\" \"aBBk-BK9a92\" \"\" \"k0_\" \"Aa--b\" \"aB_KBa9K-0-9a2\" \"9\" \"b0\" \"a9b229_2ak\" \"_\" \"A_A-BBA0B-\" \"ab\" \"b\" \"_ak-aBA2\" \"_b02-BAb\" \"K\" \"1_--BK-b1bbab\" \"b9101b9_AKAA\"]",
    "{} 1_--BK-b1bbab 2bk0b_ 9 _ _ak-aBA2 _b02-BAb a9b229_2ak A_A-BBA0B- Aa--b ab aB_KBa9K-0-9a2 aBBk-BK9a92 b b0 b9101b9_AKAA K k0_",
    "", false, "dictionary-sort-2416",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"2bk0b_\" \"aBBk-BK9a92\" \"\" \"k0_\" \"Aa--b\" \"aB_KBa9K-0-9a2\" \"9\" \"b0\" \"a9b229_2ak\" \"_\" \"A_A-BBA0B-\" \"ab\" \"b\" \"_ak-aBA2\" \"_b02-BAb\" \"K\" \"1_--BK-b1bbab\" \"b9101b9_AKAA\"]",
    "{} 1_--BK-b1bbab 2bk0b_ 9 _ _ak-aBA2 _b02-BAb a9b229_2ak A_A-BBA0B- Aa--b ab aB_KBa9K-0-9a2 aBBk-BK9a92 b b0 b9101b9_AKAA K k0_",
    "", false, "dictionary-sort-2417",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"2bk0b_\" \"aBBk-BK9a92\" \"\" \"k0_\" \"Aa--b\" \"aB_KBa9K-0-9a2\" \"9\" \"b0\" \"a9b229_2ak\" \"_\" \"A_A-BBA0B-\" \"ab\" \"b\" \"_ak-aBA2\" \"_b02-BAb\" \"K\" \"1_--BK-b1bbab\" \"b9101b9_AKAA\"]",
    "k0_ K b9101b9_AKAA b0 b aBBk-BK9a92 aB_KBa9K-0-9a2 ab Aa--b A_A-BBA0B- a9b229_2ak _b02-BAb _ak-aBA2 _ 9 2bk0b_ 1_--BK-b1bbab {}",
    "", false, "dictionary-sort-2418",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"2bk0b_\" \"aBBk-BK9a92\" \"\" \"k0_\" \"Aa--b\" \"aB_KBa9K-0-9a2\" \"9\" \"b0\" \"a9b229_2ak\" \"_\" \"A_A-BBA0B-\" \"ab\" \"b\" \"_ak-aBA2\" \"_b02-BAb\" \"K\" \"1_--BK-b1bbab\" \"b9101b9_AKAA\"]",
    "k0_ K b9101b9_AKAA b0 b aBBk-BK9a92 aB_KBa9K-0-9a2 ab Aa--b A_A-BBA0B- a9b229_2ak _b02-BAb _ak-aBA2 _ 9 2bk0b_ 1_--BK-b1bbab {}",
    "", false, "dictionary-sort-2419",
  )
  check_search_case(
    "lsort -dictionary  [list \"ak9a0\" \"-A\" \"_aA_KAb1-a_9--a\" \"11\" \"\" \"-B9\" \"B1KakbBBK\" \"-1kab2k\" \"ak1Ab9k\" \"1K\" \"2BK0b_-Ak2a22\" \"A-KK-92bA\" \"B0212a20B_a9a\" \"A0\" \"Kk0\" \"K_2kbk\" \"__BAa2-aa02kkb\" \"\"]",
    "{} {} -1kab2k -A -B9 1K 2BK0b_-Ak2a22 11 __BAa2-aa02kkb _aA_KAb1-a_9--a A-KK-92bA A0 ak1Ab9k ak9a0 B1KakbBBK B0212a20B_a9a K_2kbk Kk0",
    "", false, "dictionary-sort-2420",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"ak9a0\" \"-A\" \"_aA_KAb1-a_9--a\" \"11\" \"\" \"-B9\" \"B1KakbBBK\" \"-1kab2k\" \"ak1Ab9k\" \"1K\" \"2BK0b_-Ak2a22\" \"A-KK-92bA\" \"B0212a20B_a9a\" \"A0\" \"Kk0\" \"K_2kbk\" \"__BAa2-aa02kkb\" \"\"]",
    "{} {} -1kab2k -A -B9 1K 2BK0b_-Ak2a22 11 __BAa2-aa02kkb _aA_KAb1-a_9--a A-KK-92bA A0 ak1Ab9k ak9a0 B1KakbBBK B0212a20B_a9a K_2kbk Kk0",
    "", false, "dictionary-sort-2421",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ak9a0\" \"-A\" \"_aA_KAb1-a_9--a\" \"11\" \"\" \"-B9\" \"B1KakbBBK\" \"-1kab2k\" \"ak1Ab9k\" \"1K\" \"2BK0b_-Ak2a22\" \"A-KK-92bA\" \"B0212a20B_a9a\" \"A0\" \"Kk0\" \"K_2kbk\" \"__BAa2-aa02kkb\" \"\"]",
    "{} -1kab2k -A -B9 1K 2BK0b_-Ak2a22 11 __BAa2-aa02kkb _aA_KAb1-a_9--a A-KK-92bA A0 ak1Ab9k ak9a0 B1KakbBBK B0212a20B_a9a K_2kbk Kk0",
    "", false, "dictionary-sort-2422",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"ak9a0\" \"-A\" \"_aA_KAb1-a_9--a\" \"11\" \"\" \"-B9\" \"B1KakbBBK\" \"-1kab2k\" \"ak1Ab9k\" \"1K\" \"2BK0b_-Ak2a22\" \"A-KK-92bA\" \"B0212a20B_a9a\" \"A0\" \"Kk0\" \"K_2kbk\" \"__BAa2-aa02kkb\" \"\"]",
    "Kk0 K_2kbk B0212a20B_a9a B1KakbBBK ak9a0 ak1Ab9k A0 A-KK-92bA _aA_KAb1-a_9--a __BAa2-aa02kkb 11 2BK0b_-Ak2a22 1K -B9 -A -1kab2k {} {}",
    "", false, "dictionary-sort-2423",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ak9a0\" \"-A\" \"_aA_KAb1-a_9--a\" \"11\" \"\" \"-B9\" \"B1KakbBBK\" \"-1kab2k\" \"ak1Ab9k\" \"1K\" \"2BK0b_-Ak2a22\" \"A-KK-92bA\" \"B0212a20B_a9a\" \"A0\" \"Kk0\" \"K_2kbk\" \"__BAa2-aa02kkb\" \"\"]",
    "Kk0 K_2kbk B0212a20B_a9a B1KakbBBK ak9a0 ak1Ab9k A0 A-KK-92bA _aA_KAb1-a_9--a __BAa2-aa02kkb 11 2BK0b_-Ak2a22 1K -B9 -A -1kab2k {}",
    "", false, "dictionary-sort-2424",
  )
  check_search_case(
    "lsort -dictionary  [list \"ABKK9a02\" \"22Bk__akb0-Kb\" \"ab-a9KAaKk1\" \"kA\" \"9kk\" \"-0B\" \"-0Kb\" \"21b0\" \"000Ba1\" \"Kkbb\" \"_B_B-bA-\" \"0-\" \"2b92K__9Kkb\" \"A2b\" \"11_1B\" \"_k-0-0B-kAa99a\" \"k\" \"b\"]",
    "-0B -0Kb 0- 000Ba1 2b92K__9Kkb 9kk 11_1B 21b0 22Bk__akb0-Kb _B_B-bA- _k-0-0B-kAa99a A2b ab-a9KAaKk1 ABKK9a02 b k kA Kkbb",
    "", false, "dictionary-sort-2425",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"ABKK9a02\" \"22Bk__akb0-Kb\" \"ab-a9KAaKk1\" \"kA\" \"9kk\" \"-0B\" \"-0Kb\" \"21b0\" \"000Ba1\" \"Kkbb\" \"_B_B-bA-\" \"0-\" \"2b92K__9Kkb\" \"A2b\" \"11_1B\" \"_k-0-0B-kAa99a\" \"k\" \"b\"]",
    "-0B -0Kb 0- 000Ba1 2b92K__9Kkb 9kk 11_1B 21b0 22Bk__akb0-Kb _B_B-bA- _k-0-0B-kAa99a A2b ab-a9KAaKk1 ABKK9a02 b k kA Kkbb",
    "", false, "dictionary-sort-2426",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ABKK9a02\" \"22Bk__akb0-Kb\" \"ab-a9KAaKk1\" \"kA\" \"9kk\" \"-0B\" \"-0Kb\" \"21b0\" \"000Ba1\" \"Kkbb\" \"_B_B-bA-\" \"0-\" \"2b92K__9Kkb\" \"A2b\" \"11_1B\" \"_k-0-0B-kAa99a\" \"k\" \"b\"]",
    "-0B -0Kb 0- 000Ba1 2b92K__9Kkb 9kk 11_1B 21b0 22Bk__akb0-Kb _B_B-bA- _k-0-0B-kAa99a A2b ab-a9KAaKk1 ABKK9a02 b k kA Kkbb",
    "", false, "dictionary-sort-2427",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"ABKK9a02\" \"22Bk__akb0-Kb\" \"ab-a9KAaKk1\" \"kA\" \"9kk\" \"-0B\" \"-0Kb\" \"21b0\" \"000Ba1\" \"Kkbb\" \"_B_B-bA-\" \"0-\" \"2b92K__9Kkb\" \"A2b\" \"11_1B\" \"_k-0-0B-kAa99a\" \"k\" \"b\"]",
    "Kkbb kA k b ABKK9a02 ab-a9KAaKk1 A2b _k-0-0B-kAa99a _B_B-bA- 22Bk__akb0-Kb 21b0 11_1B 9kk 2b92K__9Kkb 000Ba1 0- -0Kb -0B",
    "", false, "dictionary-sort-2428",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ABKK9a02\" \"22Bk__akb0-Kb\" \"ab-a9KAaKk1\" \"kA\" \"9kk\" \"-0B\" \"-0Kb\" \"21b0\" \"000Ba1\" \"Kkbb\" \"_B_B-bA-\" \"0-\" \"2b92K__9Kkb\" \"A2b\" \"11_1B\" \"_k-0-0B-kAa99a\" \"k\" \"b\"]",
    "Kkbb kA k b ABKK9a02 ab-a9KAaKk1 A2b _k-0-0B-kAa99a _B_B-bA- 22Bk__akb0-Kb 21b0 11_1B 9kk 2b92K__9Kkb 000Ba1 0- -0Kb -0B",
    "", false, "dictionary-sort-2429",
  )
  check_search_case(
    "lsort -dictionary  [list \"KK209kK0ak90190\" \"2-kaak09b2B\" \"1a2KBb1AA\" \"b---1-0222BkkbA\" \"9b-b-KB2B_K\" \"9\" \"k1BAAb0k1a0K1\" \"9K-0Bb2--10A9A\" \"1B9k-09ak\" \"9abak-bK\" \"ab0__1\" \"\" \"-k9aa-9-_a9KA\" \"--9B10_bb-kAaAA\" \"2a0aBbA92b-\" \"BB\" \"K1kK\" \"1\"]",
    "{} --9B10_bb-kAaAA -k9aa-9-_a9KA 1 1a2KBb1AA 1B9k-09ak 2-kaak09b2B 2a0aBbA92b- 9 9abak-bK 9b-b-KB2B_K 9K-0Bb2--10A9A ab0__1 b---1-0222BkkbA BB k1BAAb0k1a0K1 K1kK KK209kK0ak90190",
    "", false, "dictionary-sort-2430",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"KK209kK0ak90190\" \"2-kaak09b2B\" \"1a2KBb1AA\" \"b---1-0222BkkbA\" \"9b-b-KB2B_K\" \"9\" \"k1BAAb0k1a0K1\" \"9K-0Bb2--10A9A\" \"1B9k-09ak\" \"9abak-bK\" \"ab0__1\" \"\" \"-k9aa-9-_a9KA\" \"--9B10_bb-kAaAA\" \"2a0aBbA92b-\" \"BB\" \"K1kK\" \"1\"]",
    "{} --9B10_bb-kAaAA -k9aa-9-_a9KA 1 1a2KBb1AA 1B9k-09ak 2-kaak09b2B 2a0aBbA92b- 9 9abak-bK 9b-b-KB2B_K 9K-0Bb2--10A9A ab0__1 b---1-0222BkkbA BB k1BAAb0k1a0K1 K1kK KK209kK0ak90190",
    "", false, "dictionary-sort-2431",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"KK209kK0ak90190\" \"2-kaak09b2B\" \"1a2KBb1AA\" \"b---1-0222BkkbA\" \"9b-b-KB2B_K\" \"9\" \"k1BAAb0k1a0K1\" \"9K-0Bb2--10A9A\" \"1B9k-09ak\" \"9abak-bK\" \"ab0__1\" \"\" \"-k9aa-9-_a9KA\" \"--9B10_bb-kAaAA\" \"2a0aBbA92b-\" \"BB\" \"K1kK\" \"1\"]",
    "{} --9B10_bb-kAaAA -k9aa-9-_a9KA 1 1a2KBb1AA 1B9k-09ak 2-kaak09b2B 2a0aBbA92b- 9 9abak-bK 9b-b-KB2B_K 9K-0Bb2--10A9A ab0__1 b---1-0222BkkbA BB k1BAAb0k1a0K1 K1kK KK209kK0ak90190",
    "", false, "dictionary-sort-2432",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"KK209kK0ak90190\" \"2-kaak09b2B\" \"1a2KBb1AA\" \"b---1-0222BkkbA\" \"9b-b-KB2B_K\" \"9\" \"k1BAAb0k1a0K1\" \"9K-0Bb2--10A9A\" \"1B9k-09ak\" \"9abak-bK\" \"ab0__1\" \"\" \"-k9aa-9-_a9KA\" \"--9B10_bb-kAaAA\" \"2a0aBbA92b-\" \"BB\" \"K1kK\" \"1\"]",
    "KK209kK0ak90190 K1kK k1BAAb0k1a0K1 BB b---1-0222BkkbA ab0__1 9K-0Bb2--10A9A 9b-b-KB2B_K 9abak-bK 9 2a0aBbA92b- 2-kaak09b2B 1B9k-09ak 1a2KBb1AA 1 -k9aa-9-_a9KA --9B10_bb-kAaAA {}",
    "", false, "dictionary-sort-2433",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"KK209kK0ak90190\" \"2-kaak09b2B\" \"1a2KBb1AA\" \"b---1-0222BkkbA\" \"9b-b-KB2B_K\" \"9\" \"k1BAAb0k1a0K1\" \"9K-0Bb2--10A9A\" \"1B9k-09ak\" \"9abak-bK\" \"ab0__1\" \"\" \"-k9aa-9-_a9KA\" \"--9B10_bb-kAaAA\" \"2a0aBbA92b-\" \"BB\" \"K1kK\" \"1\"]",
    "KK209kK0ak90190 K1kK k1BAAb0k1a0K1 BB b---1-0222BkkbA ab0__1 9K-0Bb2--10A9A 9b-b-KB2B_K 9abak-bK 9 2a0aBbA92b- 2-kaak09b2B 1B9k-09ak 1a2KBb1AA 1 -k9aa-9-_a9KA --9B10_bb-kAaAA {}",
    "", false, "dictionary-sort-2434",
  )
  check_search_case(
    "lsort -dictionary  [list \"aaABb92-KA2\" \"Bk\" \"-b-b9ka1A1\" \"b\" \"kA_02_BK\" \"ka-10bk-\" \"Ak\" \"2k\" \"-19Akk0bAkA-b9_\" \"BkAKbk-K20aK0A\" \"b9b_\" \"2kA-kkA\" \"\" \"01992b1K-9-0KaK\" \"k2122ak0A9_k9_\" \"21k\" \"9\" \"Kak\"]",
    "{} -19Akk0bAkA-b9_ -b-b9ka1A1 2k 2kA-kkA 9 21k 01992b1K-9-0KaK aaABb92-KA2 Ak b b9b_ Bk BkAKbk-K20aK0A k2122ak0A9_k9_ ka-10bk- kA_02_BK Kak",
    "", false, "dictionary-sort-2435",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"aaABb92-KA2\" \"Bk\" \"-b-b9ka1A1\" \"b\" \"kA_02_BK\" \"ka-10bk-\" \"Ak\" \"2k\" \"-19Akk0bAkA-b9_\" \"BkAKbk-K20aK0A\" \"b9b_\" \"2kA-kkA\" \"\" \"01992b1K-9-0KaK\" \"k2122ak0A9_k9_\" \"21k\" \"9\" \"Kak\"]",
    "{} -19Akk0bAkA-b9_ -b-b9ka1A1 2k 2kA-kkA 9 21k 01992b1K-9-0KaK aaABb92-KA2 Ak b b9b_ Bk BkAKbk-K20aK0A k2122ak0A9_k9_ ka-10bk- kA_02_BK Kak",
    "", false, "dictionary-sort-2436",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"aaABb92-KA2\" \"Bk\" \"-b-b9ka1A1\" \"b\" \"kA_02_BK\" \"ka-10bk-\" \"Ak\" \"2k\" \"-19Akk0bAkA-b9_\" \"BkAKbk-K20aK0A\" \"b9b_\" \"2kA-kkA\" \"\" \"01992b1K-9-0KaK\" \"k2122ak0A9_k9_\" \"21k\" \"9\" \"Kak\"]",
    "{} -19Akk0bAkA-b9_ -b-b9ka1A1 2k 2kA-kkA 9 21k 01992b1K-9-0KaK aaABb92-KA2 Ak b b9b_ Bk BkAKbk-K20aK0A k2122ak0A9_k9_ ka-10bk- kA_02_BK Kak",
    "", false, "dictionary-sort-2437",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"aaABb92-KA2\" \"Bk\" \"-b-b9ka1A1\" \"b\" \"kA_02_BK\" \"ka-10bk-\" \"Ak\" \"2k\" \"-19Akk0bAkA-b9_\" \"BkAKbk-K20aK0A\" \"b9b_\" \"2kA-kkA\" \"\" \"01992b1K-9-0KaK\" \"k2122ak0A9_k9_\" \"21k\" \"9\" \"Kak\"]",
    "Kak kA_02_BK ka-10bk- k2122ak0A9_k9_ BkAKbk-K20aK0A Bk b9b_ b Ak aaABb92-KA2 01992b1K-9-0KaK 21k 9 2kA-kkA 2k -b-b9ka1A1 -19Akk0bAkA-b9_ {}",
    "", false, "dictionary-sort-2438",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"aaABb92-KA2\" \"Bk\" \"-b-b9ka1A1\" \"b\" \"kA_02_BK\" \"ka-10bk-\" \"Ak\" \"2k\" \"-19Akk0bAkA-b9_\" \"BkAKbk-K20aK0A\" \"b9b_\" \"2kA-kkA\" \"\" \"01992b1K-9-0KaK\" \"k2122ak0A9_k9_\" \"21k\" \"9\" \"Kak\"]",
    "Kak kA_02_BK ka-10bk- k2122ak0A9_k9_ BkAKbk-K20aK0A Bk b9b_ b Ak aaABb92-KA2 01992b1K-9-0KaK 21k 9 2kA-kkA 2k -b-b9ka1A1 -19Akk0bAkA-b9_ {}",
    "", false, "dictionary-sort-2439",
  )
}

///|
test "Tcl search cases 2441 through 2480" {
  check_search_case(
    "lsort -dictionary  [list \"K99k9__1_-0-K1\" \"\" \"12bK__0aAB1AaA\" \"\" \"\" \"kK02-k91aA22_\" \"0-Kk-\" \"kb0a9091a_990_\" \"k2k-0ba9-99-\" \"Kkk9A92aAK1a0a\" \"A01A9A-K-BK\" \"bB0KB-AK0\" \"-_\" \"K_0KkBbba\" \"b-0Ab12KaBB\" \"k_Kk12k0K91k\" \"KKKA11bA1\" \"_A\"]",
    "{} {} {} -_ 0-Kk- 12bK__0aAB1AaA _A A01A9A-K-BK b-0Ab12KaBB bB0KB-AK0 k2k-0ba9-99- K99k9__1_-0-K1 K_0KkBbba k_Kk12k0K91k kb0a9091a_990_ kK02-k91aA22_ Kkk9A92aAK1a0a KKKA11bA1",
    "", false, "dictionary-sort-2440",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"K99k9__1_-0-K1\" \"\" \"12bK__0aAB1AaA\" \"\" \"\" \"kK02-k91aA22_\" \"0-Kk-\" \"kb0a9091a_990_\" \"k2k-0ba9-99-\" \"Kkk9A92aAK1a0a\" \"A01A9A-K-BK\" \"bB0KB-AK0\" \"-_\" \"K_0KkBbba\" \"b-0Ab12KaBB\" \"k_Kk12k0K91k\" \"KKKA11bA1\" \"_A\"]",
    "{} {} {} -_ 0-Kk- 12bK__0aAB1AaA _A A01A9A-K-BK b-0Ab12KaBB bB0KB-AK0 k2k-0ba9-99- K99k9__1_-0-K1 K_0KkBbba k_Kk12k0K91k kb0a9091a_990_ kK02-k91aA22_ Kkk9A92aAK1a0a KKKA11bA1",
    "", false, "dictionary-sort-2441",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K99k9__1_-0-K1\" \"\" \"12bK__0aAB1AaA\" \"\" \"\" \"kK02-k91aA22_\" \"0-Kk-\" \"kb0a9091a_990_\" \"k2k-0ba9-99-\" \"Kkk9A92aAK1a0a\" \"A01A9A-K-BK\" \"bB0KB-AK0\" \"-_\" \"K_0KkBbba\" \"b-0Ab12KaBB\" \"k_Kk12k0K91k\" \"KKKA11bA1\" \"_A\"]",
    "{} -_ 0-Kk- 12bK__0aAB1AaA _A A01A9A-K-BK b-0Ab12KaBB bB0KB-AK0 k2k-0ba9-99- K99k9__1_-0-K1 K_0KkBbba k_Kk12k0K91k kb0a9091a_990_ kK02-k91aA22_ Kkk9A92aAK1a0a KKKA11bA1",
    "", false, "dictionary-sort-2442",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"K99k9__1_-0-K1\" \"\" \"12bK__0aAB1AaA\" \"\" \"\" \"kK02-k91aA22_\" \"0-Kk-\" \"kb0a9091a_990_\" \"k2k-0ba9-99-\" \"Kkk9A92aAK1a0a\" \"A01A9A-K-BK\" \"bB0KB-AK0\" \"-_\" \"K_0KkBbba\" \"b-0Ab12KaBB\" \"k_Kk12k0K91k\" \"KKKA11bA1\" \"_A\"]",
    "KKKA11bA1 Kkk9A92aAK1a0a kK02-k91aA22_ kb0a9091a_990_ k_Kk12k0K91k K_0KkBbba K99k9__1_-0-K1 k2k-0ba9-99- bB0KB-AK0 b-0Ab12KaBB A01A9A-K-BK _A 12bK__0aAB1AaA 0-Kk- -_ {} {} {}",
    "", false, "dictionary-sort-2443",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K99k9__1_-0-K1\" \"\" \"12bK__0aAB1AaA\" \"\" \"\" \"kK02-k91aA22_\" \"0-Kk-\" \"kb0a9091a_990_\" \"k2k-0ba9-99-\" \"Kkk9A92aAK1a0a\" \"A01A9A-K-BK\" \"bB0KB-AK0\" \"-_\" \"K_0KkBbba\" \"b-0Ab12KaBB\" \"k_Kk12k0K91k\" \"KKKA11bA1\" \"_A\"]",
    "KKKA11bA1 Kkk9A92aAK1a0a kK02-k91aA22_ kb0a9091a_990_ k_Kk12k0K91k K_0KkBbba K99k9__1_-0-K1 k2k-0ba9-99- bB0KB-AK0 b-0Ab12KaBB A01A9A-K-BK _A 12bK__0aAB1AaA 0-Kk- -_ {}",
    "", false, "dictionary-sort-2444",
  )
  check_search_case(
    "lsort -dictionary  [list \"01KA\" \"1\" \"1K01_KkBB-00A\" \"KA2_aB2BA-\" \"-0b2A2-21\" \"2-9b1a9\" \"_0K292-A19A0aA9\" \"0A0aA20A-A_b9B\" \"02B22k2_-12bB-\" \"99kab0b_\" \"11A01B2K9k12B0\" \"a1bA__K9Bk\" \"-\" \"kK\" \"_bAb9a\" \"k109kKk\" \"k19b1a_A9A101\" \"-92Bkk-aA0a29bk\"]",
    "- -0b2A2-21 -92Bkk-aA0a29bk 0A0aA20A-A_b9B 1 1K01_KkBB-00A 01KA 2-9b1a9 02B22k2_-12bB- 11A01B2K9k12B0 99kab0b_ _0K292-A19A0aA9 _bAb9a a1bA__K9Bk k19b1a_A9A101 k109kKk KA2_aB2BA- kK",
    "", false, "dictionary-sort-2445",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"01KA\" \"1\" \"1K01_KkBB-00A\" \"KA2_aB2BA-\" \"-0b2A2-21\" \"2-9b1a9\" \"_0K292-A19A0aA9\" \"0A0aA20A-A_b9B\" \"02B22k2_-12bB-\" \"99kab0b_\" \"11A01B2K9k12B0\" \"a1bA__K9Bk\" \"-\" \"kK\" \"_bAb9a\" \"k109kKk\" \"k19b1a_A9A101\" \"-92Bkk-aA0a29bk\"]",
    "- -0b2A2-21 -92Bkk-aA0a29bk 0A0aA20A-A_b9B 1 1K01_KkBB-00A 01KA 2-9b1a9 02B22k2_-12bB- 11A01B2K9k12B0 99kab0b_ _0K292-A19A0aA9 _bAb9a a1bA__K9Bk k19b1a_A9A101 k109kKk KA2_aB2BA- kK",
    "", false, "dictionary-sort-2446",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"01KA\" \"1\" \"1K01_KkBB-00A\" \"KA2_aB2BA-\" \"-0b2A2-21\" \"2-9b1a9\" \"_0K292-A19A0aA9\" \"0A0aA20A-A_b9B\" \"02B22k2_-12bB-\" \"99kab0b_\" \"11A01B2K9k12B0\" \"a1bA__K9Bk\" \"-\" \"kK\" \"_bAb9a\" \"k109kKk\" \"k19b1a_A9A101\" \"-92Bkk-aA0a29bk\"]",
    "- -0b2A2-21 -92Bkk-aA0a29bk 0A0aA20A-A_b9B 1 1K01_KkBB-00A 01KA 2-9b1a9 02B22k2_-12bB- 11A01B2K9k12B0 99kab0b_ _0K292-A19A0aA9 _bAb9a a1bA__K9Bk k19b1a_A9A101 k109kKk KA2_aB2BA- kK",
    "", false, "dictionary-sort-2447",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"01KA\" \"1\" \"1K01_KkBB-00A\" \"KA2_aB2BA-\" \"-0b2A2-21\" \"2-9b1a9\" \"_0K292-A19A0aA9\" \"0A0aA20A-A_b9B\" \"02B22k2_-12bB-\" \"99kab0b_\" \"11A01B2K9k12B0\" \"a1bA__K9Bk\" \"-\" \"kK\" \"_bAb9a\" \"k109kKk\" \"k19b1a_A9A101\" \"-92Bkk-aA0a29bk\"]",
    "kK KA2_aB2BA- k109kKk k19b1a_A9A101 a1bA__K9Bk _bAb9a _0K292-A19A0aA9 99kab0b_ 11A01B2K9k12B0 02B22k2_-12bB- 2-9b1a9 01KA 1K01_KkBB-00A 1 0A0aA20A-A_b9B -92Bkk-aA0a29bk -0b2A2-21 -",
    "", false, "dictionary-sort-2448",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"01KA\" \"1\" \"1K01_KkBB-00A\" \"KA2_aB2BA-\" \"-0b2A2-21\" \"2-9b1a9\" \"_0K292-A19A0aA9\" \"0A0aA20A-A_b9B\" \"02B22k2_-12bB-\" \"99kab0b_\" \"11A01B2K9k12B0\" \"a1bA__K9Bk\" \"-\" \"kK\" \"_bAb9a\" \"k109kKk\" \"k19b1a_A9A101\" \"-92Bkk-aA0a29bk\"]",
    "kK KA2_aB2BA- k109kKk k19b1a_A9A101 a1bA__K9Bk _bAb9a _0K292-A19A0aA9 99kab0b_ 11A01B2K9k12B0 02B22k2_-12bB- 2-9b1a9 01KA 1K01_KkBB-00A 1 0A0aA20A-A_b9B -92Bkk-aA0a29bk -0b2A2-21 -",
    "", false, "dictionary-sort-2449",
  )
  check_search_case(
    "lsort -dictionary  [list \"\" \"22_1\" \"9K\" \"21B900abk\" \"1b01A2BKBB\" \"kkb9\" \"KBAka_9b1Ab\" \"B9019221AA\" \"10k-k\" \"A22b_a1_A22\" \"AB2-B-\" \"1k21k2AK-a_\" \"1KbK9bB-0A_-A2b\" \"\" \"-K0ba1K-122K\" \"b1_b\" \"ABk-b1BK-a0A\" \"2a_k-\"]",
    "{} {} -K0ba1K-122K 1b01A2BKBB 1k21k2AK-a_ 1KbK9bB-0A_-A2b 2a_k- 9K 10k-k 21B900abk 22_1 A22b_a1_A22 AB2-B- ABk-b1BK-a0A b1_b B9019221AA KBAka_9b1Ab kkb9",
    "", false, "dictionary-sort-2450",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"\" \"22_1\" \"9K\" \"21B900abk\" \"1b01A2BKBB\" \"kkb9\" \"KBAka_9b1Ab\" \"B9019221AA\" \"10k-k\" \"A22b_a1_A22\" \"AB2-B-\" \"1k21k2AK-a_\" \"1KbK9bB-0A_-A2b\" \"\" \"-K0ba1K-122K\" \"b1_b\" \"ABk-b1BK-a0A\" \"2a_k-\"]",
    "{} {} -K0ba1K-122K 1b01A2BKBB 1k21k2AK-a_ 1KbK9bB-0A_-A2b 2a_k- 9K 10k-k 21B900abk 22_1 A22b_a1_A22 AB2-B- ABk-b1BK-a0A b1_b B9019221AA KBAka_9b1Ab kkb9",
    "", false, "dictionary-sort-2451",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"\" \"22_1\" \"9K\" \"21B900abk\" \"1b01A2BKBB\" \"kkb9\" \"KBAka_9b1Ab\" \"B9019221AA\" \"10k-k\" \"A22b_a1_A22\" \"AB2-B-\" \"1k21k2AK-a_\" \"1KbK9bB-0A_-A2b\" \"\" \"-K0ba1K-122K\" \"b1_b\" \"ABk-b1BK-a0A\" \"2a_k-\"]",
    "{} -K0ba1K-122K 1b01A2BKBB 1k21k2AK-a_ 1KbK9bB-0A_-A2b 2a_k- 9K 10k-k 21B900abk 22_1 A22b_a1_A22 AB2-B- ABk-b1BK-a0A b1_b B9019221AA KBAka_9b1Ab kkb9",
    "", false, "dictionary-sort-2452",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"\" \"22_1\" \"9K\" \"21B900abk\" \"1b01A2BKBB\" \"kkb9\" \"KBAka_9b1Ab\" \"B9019221AA\" \"10k-k\" \"A22b_a1_A22\" \"AB2-B-\" \"1k21k2AK-a_\" \"1KbK9bB-0A_-A2b\" \"\" \"-K0ba1K-122K\" \"b1_b\" \"ABk-b1BK-a0A\" \"2a_k-\"]",
    "kkb9 KBAka_9b1Ab B9019221AA b1_b ABk-b1BK-a0A AB2-B- A22b_a1_A22 22_1 21B900abk 10k-k 9K 2a_k- 1KbK9bB-0A_-A2b 1k21k2AK-a_ 1b01A2BKBB -K0ba1K-122K {} {}",
    "", false, "dictionary-sort-2453",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"\" \"22_1\" \"9K\" \"21B900abk\" \"1b01A2BKBB\" \"kkb9\" \"KBAka_9b1Ab\" \"B9019221AA\" \"10k-k\" \"A22b_a1_A22\" \"AB2-B-\" \"1k21k2AK-a_\" \"1KbK9bB-0A_-A2b\" \"\" \"-K0ba1K-122K\" \"b1_b\" \"ABk-b1BK-a0A\" \"2a_k-\"]",
    "kkb9 KBAka_9b1Ab B9019221AA b1_b ABk-b1BK-a0A AB2-B- A22b_a1_A22 22_1 21B900abk 10k-k 9K 2a_k- 1KbK9bB-0A_-A2b 1k21k2AK-a_ 1b01A2BKBB -K0ba1K-122K {}",
    "", false, "dictionary-sort-2454",
  )
  check_search_case(
    "lsort -dictionary  [list \"BKKa-92\" \"_KK02akkbA_\" \"_2_Bb20\" \"1_B12A0ka21\" \"aA\" \"9aBk9k\" \"aaK\" \"b99b-1A0\" \"91K_1B_Akb-_\" \"1_b-Bkkkak-bBK\" \"9K_1bAb-AA2_a1\" \"1K0bb_A-k-kBK\" \"BKaA2kB\" \"B\" \"12kK01-aK\" \"kB-kk-AAb\" \"9B\" \"_2k\"]",
    "1_b-Bkkkak-bBK 1_B12A0ka21 1K0bb_A-k-kBK 9aBk9k 9B 9K_1bAb-AA2_a1 12kK01-aK 91K_1B_Akb-_ _2_Bb20 _2k _KK02akkbA_ aA aaK B b99b-1A0 BKaA2kB BKKa-92 kB-kk-AAb",
    "", false, "dictionary-sort-2455",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"BKKa-92\" \"_KK02akkbA_\" \"_2_Bb20\" \"1_B12A0ka21\" \"aA\" \"9aBk9k\" \"aaK\" \"b99b-1A0\" \"91K_1B_Akb-_\" \"1_b-Bkkkak-bBK\" \"9K_1bAb-AA2_a1\" \"1K0bb_A-k-kBK\" \"BKaA2kB\" \"B\" \"12kK01-aK\" \"kB-kk-AAb\" \"9B\" \"_2k\"]",
    "1_b-Bkkkak-bBK 1_B12A0ka21 1K0bb_A-k-kBK 9aBk9k 9B 9K_1bAb-AA2_a1 12kK01-aK 91K_1B_Akb-_ _2_Bb20 _2k _KK02akkbA_ aA aaK B b99b-1A0 BKaA2kB BKKa-92 kB-kk-AAb",
    "", false, "dictionary-sort-2456",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"BKKa-92\" \"_KK02akkbA_\" \"_2_Bb20\" \"1_B12A0ka21\" \"aA\" \"9aBk9k\" \"aaK\" \"b99b-1A0\" \"91K_1B_Akb-_\" \"1_b-Bkkkak-bBK\" \"9K_1bAb-AA2_a1\" \"1K0bb_A-k-kBK\" \"BKaA2kB\" \"B\" \"12kK01-aK\" \"kB-kk-AAb\" \"9B\" \"_2k\"]",
    "1_b-Bkkkak-bBK 1_B12A0ka21 1K0bb_A-k-kBK 9aBk9k 9B 9K_1bAb-AA2_a1 12kK01-aK 91K_1B_Akb-_ _2_Bb20 _2k _KK02akkbA_ aA aaK B b99b-1A0 BKaA2kB BKKa-92 kB-kk-AAb",
    "", false, "dictionary-sort-2457",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"BKKa-92\" \"_KK02akkbA_\" \"_2_Bb20\" \"1_B12A0ka21\" \"aA\" \"9aBk9k\" \"aaK\" \"b99b-1A0\" \"91K_1B_Akb-_\" \"1_b-Bkkkak-bBK\" \"9K_1bAb-AA2_a1\" \"1K0bb_A-k-kBK\" \"BKaA2kB\" \"B\" \"12kK01-aK\" \"kB-kk-AAb\" \"9B\" \"_2k\"]",
    "kB-kk-AAb BKKa-92 BKaA2kB b99b-1A0 B aaK aA _KK02akkbA_ _2k _2_Bb20 91K_1B_Akb-_ 12kK01-aK 9K_1bAb-AA2_a1 9B 9aBk9k 1K0bb_A-k-kBK 1_B12A0ka21 1_b-Bkkkak-bBK",
    "", false, "dictionary-sort-2458",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"BKKa-92\" \"_KK02akkbA_\" \"_2_Bb20\" \"1_B12A0ka21\" \"aA\" \"9aBk9k\" \"aaK\" \"b99b-1A0\" \"91K_1B_Akb-_\" \"1_b-Bkkkak-bBK\" \"9K_1bAb-AA2_a1\" \"1K0bb_A-k-kBK\" \"BKaA2kB\" \"B\" \"12kK01-aK\" \"kB-kk-AAb\" \"9B\" \"_2k\"]",
    "kB-kk-AAb BKKa-92 BKaA2kB b99b-1A0 B aaK aA _KK02akkbA_ _2k _2_Bb20 91K_1B_Akb-_ 12kK01-aK 9K_1bAb-AA2_a1 9B 9aBk9k 1K0bb_A-k-kBK 1_B12A0ka21 1_b-Bkkkak-bBK",
    "", false, "dictionary-sort-2459",
  )
  check_search_case(
    "lsort -dictionary  [list \"A__AK\" \"KA9aBk1-\" \"_1bAAA\" \"9-BKkKK_-_A92-2\" \"A2BBAA_a12\" \"19B0KKKA29\" \"_Kb1aA-1\" \"B_A0k\" \"-\" \"a_2bkab-k\" \"B\" \"\" \"\" \"0KkKB-2kaa02Ak0\" \"BA\" \"_b_\" \"10BB-KA2-K2kb\" \"b-_KKkA2\"]",
    "{} {} - 0KkKB-2kaa02Ak0 9-BKkKK_-_A92-2 10BB-KA2-K2kb 19B0KKKA29 _1bAAA _b_ _Kb1aA-1 A2BBAA_a12 a_2bkab-k A__AK B b-_KKkA2 B_A0k BA KA9aBk1-",
    "", false, "dictionary-sort-2460",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"A__AK\" \"KA9aBk1-\" \"_1bAAA\" \"9-BKkKK_-_A92-2\" \"A2BBAA_a12\" \"19B0KKKA29\" \"_Kb1aA-1\" \"B_A0k\" \"-\" \"a_2bkab-k\" \"B\" \"\" \"\" \"0KkKB-2kaa02Ak0\" \"BA\" \"_b_\" \"10BB-KA2-K2kb\" \"b-_KKkA2\"]",
    "{} {} - 0KkKB-2kaa02Ak0 9-BKkKK_-_A92-2 10BB-KA2-K2kb 19B0KKKA29 _1bAAA _b_ _Kb1aA-1 A2BBAA_a12 a_2bkab-k A__AK B b-_KKkA2 B_A0k BA KA9aBk1-",
    "", false, "dictionary-sort-2461",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"A__AK\" \"KA9aBk1-\" \"_1bAAA\" \"9-BKkKK_-_A92-2\" \"A2BBAA_a12\" \"19B0KKKA29\" \"_Kb1aA-1\" \"B_A0k\" \"-\" \"a_2bkab-k\" \"B\" \"\" \"\" \"0KkKB-2kaa02Ak0\" \"BA\" \"_b_\" \"10BB-KA2-K2kb\" \"b-_KKkA2\"]",
    "{} - 0KkKB-2kaa02Ak0 9-BKkKK_-_A92-2 10BB-KA2-K2kb 19B0KKKA29 _1bAAA _b_ _Kb1aA-1 A2BBAA_a12 a_2bkab-k A__AK B b-_KKkA2 B_A0k BA KA9aBk1-",
    "", false, "dictionary-sort-2462",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"A__AK\" \"KA9aBk1-\" \"_1bAAA\" \"9-BKkKK_-_A92-2\" \"A2BBAA_a12\" \"19B0KKKA29\" \"_Kb1aA-1\" \"B_A0k\" \"-\" \"a_2bkab-k\" \"B\" \"\" \"\" \"0KkKB-2kaa02Ak0\" \"BA\" \"_b_\" \"10BB-KA2-K2kb\" \"b-_KKkA2\"]",
    "KA9aBk1- BA B_A0k b-_KKkA2 B A__AK a_2bkab-k A2BBAA_a12 _Kb1aA-1 _b_ _1bAAA 19B0KKKA29 10BB-KA2-K2kb 9-BKkKK_-_A92-2 0KkKB-2kaa02Ak0 - {} {}",
    "", false, "dictionary-sort-2463",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"A__AK\" \"KA9aBk1-\" \"_1bAAA\" \"9-BKkKK_-_A92-2\" \"A2BBAA_a12\" \"19B0KKKA29\" \"_Kb1aA-1\" \"B_A0k\" \"-\" \"a_2bkab-k\" \"B\" \"\" \"\" \"0KkKB-2kaa02Ak0\" \"BA\" \"_b_\" \"10BB-KA2-K2kb\" \"b-_KKkA2\"]",
    "KA9aBk1- BA B_A0k b-_KKkA2 B A__AK a_2bkab-k A2BBAA_a12 _Kb1aA-1 _b_ _1bAAA 19B0KKKA29 10BB-KA2-K2kb 9-BKkKK_-_A92-2 0KkKB-2kaa02Ak0 - {}",
    "", false, "dictionary-sort-2464",
  )
  check_search_case(
    "lsort -dictionary  [list \"_-B1K2_9-k2Aa\" \"k_-\" \"BKkk9b9b9A\" \"_b2k2k1kKb_-_1\" \"B2Abk19_\" \"1_0k2b--kkkK000\" \"9A9\" \"k2k0ak-1A-\" \"BA11AAaKAab-a_2\" \"K1a92a9a0-a2b00\" \"90b2\" \"B0\" \"1b\" \"Kk1_Ak102-K_A-\" \"b0ab_Ab\" \"-bk-2-kk\" \"\" \"2_-b_110_b1201-\"]",
    "{} -bk-2-kk 1_0k2b--kkkK000 1b 2_-b_110_b1201- 9A9 90b2 _-B1K2_9-k2Aa _b2k2k1kKb_-_1 B0 b0ab_Ab B2Abk19_ BA11AAaKAab-a_2 BKkk9b9b9A K1a92a9a0-a2b00 k2k0ak-1A- k_- Kk1_Ak102-K_A-",
    "", false, "dictionary-sort-2465",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"_-B1K2_9-k2Aa\" \"k_-\" \"BKkk9b9b9A\" \"_b2k2k1kKb_-_1\" \"B2Abk19_\" \"1_0k2b--kkkK000\" \"9A9\" \"k2k0ak-1A-\" \"BA11AAaKAab-a_2\" \"K1a92a9a0-a2b00\" \"90b2\" \"B0\" \"1b\" \"Kk1_Ak102-K_A-\" \"b0ab_Ab\" \"-bk-2-kk\" \"\" \"2_-b_110_b1201-\"]",
    "{} -bk-2-kk 1_0k2b--kkkK000 1b 2_-b_110_b1201- 9A9 90b2 _-B1K2_9-k2Aa _b2k2k1kKb_-_1 B0 b0ab_Ab B2Abk19_ BA11AAaKAab-a_2 BKkk9b9b9A K1a92a9a0-a2b00 k2k0ak-1A- k_- Kk1_Ak102-K_A-",
    "", false, "dictionary-sort-2466",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"_-B1K2_9-k2Aa\" \"k_-\" \"BKkk9b9b9A\" \"_b2k2k1kKb_-_1\" \"B2Abk19_\" \"1_0k2b--kkkK000\" \"9A9\" \"k2k0ak-1A-\" \"BA11AAaKAab-a_2\" \"K1a92a9a0-a2b00\" \"90b2\" \"B0\" \"1b\" \"Kk1_Ak102-K_A-\" \"b0ab_Ab\" \"-bk-2-kk\" \"\" \"2_-b_110_b1201-\"]",
    "{} -bk-2-kk 1_0k2b--kkkK000 1b 2_-b_110_b1201- 9A9 90b2 _-B1K2_9-k2Aa _b2k2k1kKb_-_1 B0 b0ab_Ab B2Abk19_ BA11AAaKAab-a_2 BKkk9b9b9A K1a92a9a0-a2b00 k2k0ak-1A- k_- Kk1_Ak102-K_A-",
    "", false, "dictionary-sort-2467",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"_-B1K2_9-k2Aa\" \"k_-\" \"BKkk9b9b9A\" \"_b2k2k1kKb_-_1\" \"B2Abk19_\" \"1_0k2b--kkkK000\" \"9A9\" \"k2k0ak-1A-\" \"BA11AAaKAab-a_2\" \"K1a92a9a0-a2b00\" \"90b2\" \"B0\" \"1b\" \"Kk1_Ak102-K_A-\" \"b0ab_Ab\" \"-bk-2-kk\" \"\" \"2_-b_110_b1201-\"]",
    "Kk1_Ak102-K_A- k_- k2k0ak-1A- K1a92a9a0-a2b00 BKkk9b9b9A BA11AAaKAab-a_2 B2Abk19_ b0ab_Ab B0 _b2k2k1kKb_-_1 _-B1K2_9-k2Aa 90b2 9A9 2_-b_110_b1201- 1b 1_0k2b--kkkK000 -bk-2-kk {}",
    "", false, "dictionary-sort-2468",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"_-B1K2_9-k2Aa\" \"k_-\" \"BKkk9b9b9A\" \"_b2k2k1kKb_-_1\" \"B2Abk19_\" \"1_0k2b--kkkK000\" \"9A9\" \"k2k0ak-1A-\" \"BA11AAaKAab-a_2\" \"K1a92a9a0-a2b00\" \"90b2\" \"B0\" \"1b\" \"Kk1_Ak102-K_A-\" \"b0ab_Ab\" \"-bk-2-kk\" \"\" \"2_-b_110_b1201-\"]",
    "Kk1_Ak102-K_A- k_- k2k0ak-1A- K1a92a9a0-a2b00 BKkk9b9b9A BA11AAaKAab-a_2 B2Abk19_ b0ab_Ab B0 _b2k2k1kKb_-_1 _-B1K2_9-k2Aa 90b2 9A9 2_-b_110_b1201- 1b 1_0k2b--kkkK000 -bk-2-kk {}",
    "", false, "dictionary-sort-2469",
  )
  check_search_case(
    "lsort -dictionary  [list \"k21A2b9\" \"9B\" \"bB_\" \"a-b1KA\" \"_BBa0aaA\" \"_Aa_kA0A-_A9\" \"\" \"12BAKB_a2_1a\" \"-9a9_a\" \"B120\" \"B0b\" \"9-Kk9-\" \"0A0bkkkAa1_19A\" \"\" \"kbAa2k-ba0a-2\" \"Aa-aABB-\" \"BBBk9ba0kA9kaK1\" \"1101B2Kb0_Ba\"]",
    "{} {} -9a9_a 0A0bkkkAa1_19A 9-Kk9- 9B 12BAKB_a2_1a 1101B2Kb0_Ba _Aa_kA0A-_A9 _BBa0aaA a-b1KA Aa-aABB- B0b B120 bB_ BBBk9ba0kA9kaK1 k21A2b9 kbAa2k-ba0a-2",
    "", false, "dictionary-sort-2470",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"k21A2b9\" \"9B\" \"bB_\" \"a-b1KA\" \"_BBa0aaA\" \"_Aa_kA0A-_A9\" \"\" \"12BAKB_a2_1a\" \"-9a9_a\" \"B120\" \"B0b\" \"9-Kk9-\" \"0A0bkkkAa1_19A\" \"\" \"kbAa2k-ba0a-2\" \"Aa-aABB-\" \"BBBk9ba0kA9kaK1\" \"1101B2Kb0_Ba\"]",
    "{} {} -9a9_a 0A0bkkkAa1_19A 9-Kk9- 9B 12BAKB_a2_1a 1101B2Kb0_Ba _Aa_kA0A-_A9 _BBa0aaA a-b1KA Aa-aABB- B0b B120 bB_ BBBk9ba0kA9kaK1 k21A2b9 kbAa2k-ba0a-2",
    "", false, "dictionary-sort-2471",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"k21A2b9\" \"9B\" \"bB_\" \"a-b1KA\" \"_BBa0aaA\" \"_Aa_kA0A-_A9\" \"\" \"12BAKB_a2_1a\" \"-9a9_a\" \"B120\" \"B0b\" \"9-Kk9-\" \"0A0bkkkAa1_19A\" \"\" \"kbAa2k-ba0a-2\" \"Aa-aABB-\" \"BBBk9ba0kA9kaK1\" \"1101B2Kb0_Ba\"]",
    "{} -9a9_a 0A0bkkkAa1_19A 9-Kk9- 9B 12BAKB_a2_1a 1101B2Kb0_Ba _Aa_kA0A-_A9 _BBa0aaA a-b1KA Aa-aABB- B0b B120 bB_ BBBk9ba0kA9kaK1 k21A2b9 kbAa2k-ba0a-2",
    "", false, "dictionary-sort-2472",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"k21A2b9\" \"9B\" \"bB_\" \"a-b1KA\" \"_BBa0aaA\" \"_Aa_kA0A-_A9\" \"\" \"12BAKB_a2_1a\" \"-9a9_a\" \"B120\" \"B0b\" \"9-Kk9-\" \"0A0bkkkAa1_19A\" \"\" \"kbAa2k-ba0a-2\" \"Aa-aABB-\" \"BBBk9ba0kA9kaK1\" \"1101B2Kb0_Ba\"]",
    "kbAa2k-ba0a-2 k21A2b9 BBBk9ba0kA9kaK1 bB_ B120 B0b Aa-aABB- a-b1KA _BBa0aaA _Aa_kA0A-_A9 1101B2Kb0_Ba 12BAKB_a2_1a 9B 9-Kk9- 0A0bkkkAa1_19A -9a9_a {} {}",
    "", false, "dictionary-sort-2473",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"k21A2b9\" \"9B\" \"bB_\" \"a-b1KA\" \"_BBa0aaA\" \"_Aa_kA0A-_A9\" \"\" \"12BAKB_a2_1a\" \"-9a9_a\" \"B120\" \"B0b\" \"9-Kk9-\" \"0A0bkkkAa1_19A\" \"\" \"kbAa2k-ba0a-2\" \"Aa-aABB-\" \"BBBk9ba0kA9kaK1\" \"1101B2Kb0_Ba\"]",
    "kbAa2k-ba0a-2 k21A2b9 BBBk9ba0kA9kaK1 bB_ B120 B0b Aa-aABB- a-b1KA _BBa0aaA _Aa_kA0A-_A9 1101B2Kb0_Ba 12BAKB_a2_1a 9B 9-Kk9- 0A0bkkkAa1_19A -9a9_a {}",
    "", false, "dictionary-sort-2474",
  )
  check_search_case(
    "lsort -dictionary  [list \"Baab290\" \"aKa1a92a\" \"aa\" \"-bk\" \"0BBBb_b_-92-B\" \"bBb92K9aa1abB1b\" \"0_-2\" \"9K0bbk2__\" \"aakab\" \"9k-\" \"1k\" \"kbBk2_a\" \"A1Aa9\" \"kKBbk_-a\" \"a\" \"Ak1bB22k2ab\" \"K_91BB-29K01\" \"\"]",
    "{} -bk 0_-2 0BBBb_b_-92-B 1k 9k- 9K0bbk2__ a A1Aa9 aa aakab Ak1bB22k2ab aKa1a92a Baab290 bBb92K9aa1abB1b K_91BB-29K01 kbBk2_a kKBbk_-a",
    "", false, "dictionary-sort-2475",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"Baab290\" \"aKa1a92a\" \"aa\" \"-bk\" \"0BBBb_b_-92-B\" \"bBb92K9aa1abB1b\" \"0_-2\" \"9K0bbk2__\" \"aakab\" \"9k-\" \"1k\" \"kbBk2_a\" \"A1Aa9\" \"kKBbk_-a\" \"a\" \"Ak1bB22k2ab\" \"K_91BB-29K01\" \"\"]",
    "{} -bk 0_-2 0BBBb_b_-92-B 1k 9k- 9K0bbk2__ a A1Aa9 aa aakab Ak1bB22k2ab aKa1a92a Baab290 bBb92K9aa1abB1b K_91BB-29K01 kbBk2_a kKBbk_-a",
    "", false, "dictionary-sort-2476",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"Baab290\" \"aKa1a92a\" \"aa\" \"-bk\" \"0BBBb_b_-92-B\" \"bBb92K9aa1abB1b\" \"0_-2\" \"9K0bbk2__\" \"aakab\" \"9k-\" \"1k\" \"kbBk2_a\" \"A1Aa9\" \"kKBbk_-a\" \"a\" \"Ak1bB22k2ab\" \"K_91BB-29K01\" \"\"]",
    "{} -bk 0_-2 0BBBb_b_-92-B 1k 9k- 9K0bbk2__ a A1Aa9 aa aakab Ak1bB22k2ab aKa1a92a Baab290 bBb92K9aa1abB1b K_91BB-29K01 kbBk2_a kKBbk_-a",
    "", false, "dictionary-sort-2477",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"Baab290\" \"aKa1a92a\" \"aa\" \"-bk\" \"0BBBb_b_-92-B\" \"bBb92K9aa1abB1b\" \"0_-2\" \"9K0bbk2__\" \"aakab\" \"9k-\" \"1k\" \"kbBk2_a\" \"A1Aa9\" \"kKBbk_-a\" \"a\" \"Ak1bB22k2ab\" \"K_91BB-29K01\" \"\"]",
    "kKBbk_-a kbBk2_a K_91BB-29K01 bBb92K9aa1abB1b Baab290 aKa1a92a Ak1bB22k2ab aakab aa A1Aa9 a 9K0bbk2__ 9k- 1k 0BBBb_b_-92-B 0_-2 -bk {}",
    "", false, "dictionary-sort-2478",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"Baab290\" \"aKa1a92a\" \"aa\" \"-bk\" \"0BBBb_b_-92-B\" \"bBb92K9aa1abB1b\" \"0_-2\" \"9K0bbk2__\" \"aakab\" \"9k-\" \"1k\" \"kbBk2_a\" \"A1Aa9\" \"kKBbk_-a\" \"a\" \"Ak1bB22k2ab\" \"K_91BB-29K01\" \"\"]",
    "kKBbk_-a kbBk2_a K_91BB-29K01 bBb92K9aa1abB1b Baab290 aKa1a92a Ak1bB22k2ab aakab aa A1Aa9 a 9K0bbk2__ 9k- 1k 0BBBb_b_-92-B 0_-2 -bk {}",
    "", false, "dictionary-sort-2479",
  )
}

///|
test "Tcl search cases 2481 through 2520" {
  check_search_case(
    "lsort -dictionary  [list \"K_k\" \"\" \"Ab-_-b_a\" \"1_K2Akb012\" \"_Bbb_kbAA9K-\" \"a-_0\" \"B\" \"\" \"A\" \"_\" \"k2a-kb\" \"_\" \"9aak9A0K_9b\" \"A1-9bA2b-B-\" \"_99\" \"kaa2\" \"\" \"02\"]",
    "{} {} {} 1_K2Akb012 02 9aak9A0K_9b _ _ _99 _Bbb_kbAA9K- A a-_0 A1-9bA2b-B- Ab-_-b_a B k2a-kb K_k kaa2",
    "", false, "dictionary-sort-2480",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"K_k\" \"\" \"Ab-_-b_a\" \"1_K2Akb012\" \"_Bbb_kbAA9K-\" \"a-_0\" \"B\" \"\" \"A\" \"_\" \"k2a-kb\" \"_\" \"9aak9A0K_9b\" \"A1-9bA2b-B-\" \"_99\" \"kaa2\" \"\" \"02\"]",
    "{} {} {} 1_K2Akb012 02 9aak9A0K_9b _ _ _99 _Bbb_kbAA9K- A a-_0 A1-9bA2b-B- Ab-_-b_a B k2a-kb K_k kaa2",
    "", false, "dictionary-sort-2481",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K_k\" \"\" \"Ab-_-b_a\" \"1_K2Akb012\" \"_Bbb_kbAA9K-\" \"a-_0\" \"B\" \"\" \"A\" \"_\" \"k2a-kb\" \"_\" \"9aak9A0K_9b\" \"A1-9bA2b-B-\" \"_99\" \"kaa2\" \"\" \"02\"]",
    "{} 1_K2Akb012 02 9aak9A0K_9b _ _99 _Bbb_kbAA9K- A a-_0 A1-9bA2b-B- Ab-_-b_a B k2a-kb K_k kaa2",
    "", false, "dictionary-sort-2482",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"K_k\" \"\" \"Ab-_-b_a\" \"1_K2Akb012\" \"_Bbb_kbAA9K-\" \"a-_0\" \"B\" \"\" \"A\" \"_\" \"k2a-kb\" \"_\" \"9aak9A0K_9b\" \"A1-9bA2b-B-\" \"_99\" \"kaa2\" \"\" \"02\"]",
    "kaa2 K_k k2a-kb B Ab-_-b_a A1-9bA2b-B- a-_0 A _Bbb_kbAA9K- _99 _ _ 9aak9A0K_9b 02 1_K2Akb012 {} {} {}",
    "", false, "dictionary-sort-2483",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K_k\" \"\" \"Ab-_-b_a\" \"1_K2Akb012\" \"_Bbb_kbAA9K-\" \"a-_0\" \"B\" \"\" \"A\" \"_\" \"k2a-kb\" \"_\" \"9aak9A0K_9b\" \"A1-9bA2b-B-\" \"_99\" \"kaa2\" \"\" \"02\"]",
    "kaa2 K_k k2a-kb B Ab-_-b_a A1-9bA2b-B- a-_0 A _Bbb_kbAA9K- _99 _ 9aak9A0K_9b 02 1_K2Akb012 {}",
    "", false, "dictionary-sort-2484",
  )
  check_search_case(
    "lsort -dictionary  [list \"a0bKaKka010\" \"b_bB0k-Kb\" \"KK1bAaKkK2-\" \"ak_aB-\" \"0B99b\" \"1K900K_B-09A-aK\" \"-0abk1_99b\" \"\" \"k922A12BABbbBB\" \"\" \"ak_B9_abAa0Ba1\" \"09aa1\" \"B\" \"bBaBkBk0K_b\" \"9_-221__ab-_1A\" \"9bB\" \"--0BkbbK\" \"b2_1bka_\"]",
    "{} {} --0BkbbK -0abk1_99b 0B99b 1K900K_B-09A-aK 9_-221__ab-_1A 09aa1 9bB a0bKaKka010 ak_aB- ak_B9_abAa0Ba1 B b2_1bka_ b_bB0k-Kb bBaBkBk0K_b k922A12BABbbBB KK1bAaKkK2-",
    "", false, "dictionary-sort-2485",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"a0bKaKka010\" \"b_bB0k-Kb\" \"KK1bAaKkK2-\" \"ak_aB-\" \"0B99b\" \"1K900K_B-09A-aK\" \"-0abk1_99b\" \"\" \"k922A12BABbbBB\" \"\" \"ak_B9_abAa0Ba1\" \"09aa1\" \"B\" \"bBaBkBk0K_b\" \"9_-221__ab-_1A\" \"9bB\" \"--0BkbbK\" \"b2_1bka_\"]",
    "{} {} --0BkbbK -0abk1_99b 0B99b 1K900K_B-09A-aK 9_-221__ab-_1A 09aa1 9bB a0bKaKka010 ak_aB- ak_B9_abAa0Ba1 B b2_1bka_ b_bB0k-Kb bBaBkBk0K_b k922A12BABbbBB KK1bAaKkK2-",
    "", false, "dictionary-sort-2486",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"a0bKaKka010\" \"b_bB0k-Kb\" \"KK1bAaKkK2-\" \"ak_aB-\" \"0B99b\" \"1K900K_B-09A-aK\" \"-0abk1_99b\" \"\" \"k922A12BABbbBB\" \"\" \"ak_B9_abAa0Ba1\" \"09aa1\" \"B\" \"bBaBkBk0K_b\" \"9_-221__ab-_1A\" \"9bB\" \"--0BkbbK\" \"b2_1bka_\"]",
    "{} --0BkbbK -0abk1_99b 0B99b 1K900K_B-09A-aK 9_-221__ab-_1A 09aa1 9bB a0bKaKka010 ak_aB- ak_B9_abAa0Ba1 B b2_1bka_ b_bB0k-Kb bBaBkBk0K_b k922A12BABbbBB KK1bAaKkK2-",
    "", false, "dictionary-sort-2487",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"a0bKaKka010\" \"b_bB0k-Kb\" \"KK1bAaKkK2-\" \"ak_aB-\" \"0B99b\" \"1K900K_B-09A-aK\" \"-0abk1_99b\" \"\" \"k922A12BABbbBB\" \"\" \"ak_B9_abAa0Ba1\" \"09aa1\" \"B\" \"bBaBkBk0K_b\" \"9_-221__ab-_1A\" \"9bB\" \"--0BkbbK\" \"b2_1bka_\"]",
    "KK1bAaKkK2- k922A12BABbbBB bBaBkBk0K_b b_bB0k-Kb b2_1bka_ B ak_B9_abAa0Ba1 ak_aB- a0bKaKka010 9bB 09aa1 9_-221__ab-_1A 1K900K_B-09A-aK 0B99b -0abk1_99b --0BkbbK {} {}",
    "", false, "dictionary-sort-2488",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"a0bKaKka010\" \"b_bB0k-Kb\" \"KK1bAaKkK2-\" \"ak_aB-\" \"0B99b\" \"1K900K_B-09A-aK\" \"-0abk1_99b\" \"\" \"k922A12BABbbBB\" \"\" \"ak_B9_abAa0Ba1\" \"09aa1\" \"B\" \"bBaBkBk0K_b\" \"9_-221__ab-_1A\" \"9bB\" \"--0BkbbK\" \"b2_1bka_\"]",
    "KK1bAaKkK2- k922A12BABbbBB bBaBkBk0K_b b_bB0k-Kb b2_1bka_ B ak_B9_abAa0Ba1 ak_aB- a0bKaKka010 9bB 09aa1 9_-221__ab-_1A 1K900K_B-09A-aK 0B99b -0abk1_99b --0BkbbK {}",
    "", false, "dictionary-sort-2489",
  )
  check_search_case(
    "lsort -dictionary  [list \"B9kAbbBB\" \"_bbB_K-a2\" \"K1__Ka\" \"00Bk222BbBbK9-0\" \"-1_K922AA\" \"9b1--2\" \"_1BKaBb\" \"bK091b\" \"a_a2\" \"kb0K-Baa-1Bb\" \"-1-\" \"k__1K9\" \"-0kBkkb2Aa_K\" \"299a\" \"k2B_2\" \"22100AA-B92-0\" \"b1b9b\" \"\"]",
    "{} -0kBkkb2Aa_K -1- -1_K922AA 00Bk222BbBbK9-0 9b1--2 299a 22100AA-B92-0 _1BKaBb _bbB_K-a2 a_a2 b1b9b B9kAbbBB bK091b K1__Ka k2B_2 k__1K9 kb0K-Baa-1Bb",
    "", false, "dictionary-sort-2490",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"B9kAbbBB\" \"_bbB_K-a2\" \"K1__Ka\" \"00Bk222BbBbK9-0\" \"-1_K922AA\" \"9b1--2\" \"_1BKaBb\" \"bK091b\" \"a_a2\" \"kb0K-Baa-1Bb\" \"-1-\" \"k__1K9\" \"-0kBkkb2Aa_K\" \"299a\" \"k2B_2\" \"22100AA-B92-0\" \"b1b9b\" \"\"]",
    "{} -0kBkkb2Aa_K -1- -1_K922AA 00Bk222BbBbK9-0 9b1--2 299a 22100AA-B92-0 _1BKaBb _bbB_K-a2 a_a2 b1b9b B9kAbbBB bK091b K1__Ka k2B_2 k__1K9 kb0K-Baa-1Bb",
    "", false, "dictionary-sort-2491",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"B9kAbbBB\" \"_bbB_K-a2\" \"K1__Ka\" \"00Bk222BbBbK9-0\" \"-1_K922AA\" \"9b1--2\" \"_1BKaBb\" \"bK091b\" \"a_a2\" \"kb0K-Baa-1Bb\" \"-1-\" \"k__1K9\" \"-0kBkkb2Aa_K\" \"299a\" \"k2B_2\" \"22100AA-B92-0\" \"b1b9b\" \"\"]",
    "{} -0kBkkb2Aa_K -1- -1_K922AA 00Bk222BbBbK9-0 9b1--2 299a 22100AA-B92-0 _1BKaBb _bbB_K-a2 a_a2 b1b9b B9kAbbBB bK091b K1__Ka k2B_2 k__1K9 kb0K-Baa-1Bb",
    "", false, "dictionary-sort-2492",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"B9kAbbBB\" \"_bbB_K-a2\" \"K1__Ka\" \"00Bk222BbBbK9-0\" \"-1_K922AA\" \"9b1--2\" \"_1BKaBb\" \"bK091b\" \"a_a2\" \"kb0K-Baa-1Bb\" \"-1-\" \"k__1K9\" \"-0kBkkb2Aa_K\" \"299a\" \"k2B_2\" \"22100AA-B92-0\" \"b1b9b\" \"\"]",
    "kb0K-Baa-1Bb k__1K9 k2B_2 K1__Ka bK091b B9kAbbBB b1b9b a_a2 _bbB_K-a2 _1BKaBb 22100AA-B92-0 299a 9b1--2 00Bk222BbBbK9-0 -1_K922AA -1- -0kBkkb2Aa_K {}",
    "", false, "dictionary-sort-2493",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"B9kAbbBB\" \"_bbB_K-a2\" \"K1__Ka\" \"00Bk222BbBbK9-0\" \"-1_K922AA\" \"9b1--2\" \"_1BKaBb\" \"bK091b\" \"a_a2\" \"kb0K-Baa-1Bb\" \"-1-\" \"k__1K9\" \"-0kBkkb2Aa_K\" \"299a\" \"k2B_2\" \"22100AA-B92-0\" \"b1b9b\" \"\"]",
    "kb0K-Baa-1Bb k__1K9 k2B_2 K1__Ka bK091b B9kAbbBB b1b9b a_a2 _bbB_K-a2 _1BKaBb 22100AA-B92-0 299a 9b1--2 00Bk222BbBbK9-0 -1_K922AA -1- -0kBkkb2Aa_K {}",
    "", false, "dictionary-sort-2494",
  )
  check_search_case(
    "lsort -dictionary  [list \"b1a-9_BKK2aAB20\" \"9B_A92_-9b9Ab\" \"Ab0BB101K9ba9_\" \"-92b\" \"_1Ak0_22\" \"BK110A0\" \"1A12K-Kb9B0A\" \"-_b9KA29a\" \"B0b92--_1_92\" \"1ABA_22k9\" \"2B-K1BBb1a2k1\" \"2\" \"a-b-_1-b99\" \"K19BK0bk\" \"0a0Aa1AkK\" \"A\" \"A_B029ab1\" \"-9_2k_a9K\"]",
    "-9_2k_a9K -92b -_b9KA29a 0a0Aa1AkK 1A12K-Kb9B0A 1ABA_22k9 2 2B-K1BBb1a2k1 9B_A92_-9b9Ab _1Ak0_22 A a-b-_1-b99 A_B029ab1 Ab0BB101K9ba9_ B0b92--_1_92 b1a-9_BKK2aAB20 BK110A0 K19BK0bk",
    "", false, "dictionary-sort-2495",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"b1a-9_BKK2aAB20\" \"9B_A92_-9b9Ab\" \"Ab0BB101K9ba9_\" \"-92b\" \"_1Ak0_22\" \"BK110A0\" \"1A12K-Kb9B0A\" \"-_b9KA29a\" \"B0b92--_1_92\" \"1ABA_22k9\" \"2B-K1BBb1a2k1\" \"2\" \"a-b-_1-b99\" \"K19BK0bk\" \"0a0Aa1AkK\" \"A\" \"A_B029ab1\" \"-9_2k_a9K\"]",
    "-9_2k_a9K -92b -_b9KA29a 0a0Aa1AkK 1A12K-Kb9B0A 1ABA_22k9 2 2B-K1BBb1a2k1 9B_A92_-9b9Ab _1Ak0_22 A a-b-_1-b99 A_B029ab1 Ab0BB101K9ba9_ B0b92--_1_92 b1a-9_BKK2aAB20 BK110A0 K19BK0bk",
    "", false, "dictionary-sort-2496",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"b1a-9_BKK2aAB20\" \"9B_A92_-9b9Ab\" \"Ab0BB101K9ba9_\" \"-92b\" \"_1Ak0_22\" \"BK110A0\" \"1A12K-Kb9B0A\" \"-_b9KA29a\" \"B0b92--_1_92\" \"1ABA_22k9\" \"2B-K1BBb1a2k1\" \"2\" \"a-b-_1-b99\" \"K19BK0bk\" \"0a0Aa1AkK\" \"A\" \"A_B029ab1\" \"-9_2k_a9K\"]",
    "-9_2k_a9K -92b -_b9KA29a 0a0Aa1AkK 1A12K-Kb9B0A 1ABA_22k9 2 2B-K1BBb1a2k1 9B_A92_-9b9Ab _1Ak0_22 A a-b-_1-b99 A_B029ab1 Ab0BB101K9ba9_ B0b92--_1_92 b1a-9_BKK2aAB20 BK110A0 K19BK0bk",
    "", false, "dictionary-sort-2497",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"b1a-9_BKK2aAB20\" \"9B_A92_-9b9Ab\" \"Ab0BB101K9ba9_\" \"-92b\" \"_1Ak0_22\" \"BK110A0\" \"1A12K-Kb9B0A\" \"-_b9KA29a\" \"B0b92--_1_92\" \"1ABA_22k9\" \"2B-K1BBb1a2k1\" \"2\" \"a-b-_1-b99\" \"K19BK0bk\" \"0a0Aa1AkK\" \"A\" \"A_B029ab1\" \"-9_2k_a9K\"]",
    "K19BK0bk BK110A0 b1a-9_BKK2aAB20 B0b92--_1_92 Ab0BB101K9ba9_ A_B029ab1 a-b-_1-b99 A _1Ak0_22 9B_A92_-9b9Ab 2B-K1BBb1a2k1 2 1ABA_22k9 1A12K-Kb9B0A 0a0Aa1AkK -_b9KA29a -92b -9_2k_a9K",
    "", false, "dictionary-sort-2498",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"b1a-9_BKK2aAB20\" \"9B_A92_-9b9Ab\" \"Ab0BB101K9ba9_\" \"-92b\" \"_1Ak0_22\" \"BK110A0\" \"1A12K-Kb9B0A\" \"-_b9KA29a\" \"B0b92--_1_92\" \"1ABA_22k9\" \"2B-K1BBb1a2k1\" \"2\" \"a-b-_1-b99\" \"K19BK0bk\" \"0a0Aa1AkK\" \"A\" \"A_B029ab1\" \"-9_2k_a9K\"]",
    "K19BK0bk BK110A0 b1a-9_BKK2aAB20 B0b92--_1_92 Ab0BB101K9ba9_ A_B029ab1 a-b-_1-b99 A _1Ak0_22 9B_A92_-9b9Ab 2B-K1BBb1a2k1 2 1ABA_22k9 1A12K-Kb9B0A 0a0Aa1AkK -_b9KA29a -92b -9_2k_a9K",
    "", false, "dictionary-sort-2499",
  )
  check_search_case(
    "lsort -dictionary  [list \"aka\" \"_-a90\" \"2bA\" \"01002k__1_2\" \"2\" \"bK201\" \"A2A_a-B_\" \"\" \"9\" \"19ka0-0B2k\" \"-2aB9K-A0A\" \"k\" \"b9-k-0kaKAa1921\" \"a__-k1A\" \"A110\" \"Ba1aKa\" \"09BBkk-K\" \"a2\"]",
    "{} -2aB9K-A0A 2 2bA 9 09BBkk-K 19ka0-0B2k 01002k__1_2 _-a90 a2 A2A_a-B_ A110 a__-k1A aka b9-k-0kaKAa1921 Ba1aKa bK201 k",
    "", false, "dictionary-sort-2500",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"aka\" \"_-a90\" \"2bA\" \"01002k__1_2\" \"2\" \"bK201\" \"A2A_a-B_\" \"\" \"9\" \"19ka0-0B2k\" \"-2aB9K-A0A\" \"k\" \"b9-k-0kaKAa1921\" \"a__-k1A\" \"A110\" \"Ba1aKa\" \"09BBkk-K\" \"a2\"]",
    "{} -2aB9K-A0A 2 2bA 9 09BBkk-K 19ka0-0B2k 01002k__1_2 _-a90 a2 A2A_a-B_ A110 a__-k1A aka b9-k-0kaKAa1921 Ba1aKa bK201 k",
    "", false, "dictionary-sort-2501",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"aka\" \"_-a90\" \"2bA\" \"01002k__1_2\" \"2\" \"bK201\" \"A2A_a-B_\" \"\" \"9\" \"19ka0-0B2k\" \"-2aB9K-A0A\" \"k\" \"b9-k-0kaKAa1921\" \"a__-k1A\" \"A110\" \"Ba1aKa\" \"09BBkk-K\" \"a2\"]",
    "{} -2aB9K-A0A 2 2bA 9 09BBkk-K 19ka0-0B2k 01002k__1_2 _-a90 a2 A2A_a-B_ A110 a__-k1A aka b9-k-0kaKAa1921 Ba1aKa bK201 k",
    "", false, "dictionary-sort-2502",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"aka\" \"_-a90\" \"2bA\" \"01002k__1_2\" \"2\" \"bK201\" \"A2A_a-B_\" \"\" \"9\" \"19ka0-0B2k\" \"-2aB9K-A0A\" \"k\" \"b9-k-0kaKAa1921\" \"a__-k1A\" \"A110\" \"Ba1aKa\" \"09BBkk-K\" \"a2\"]",
    "k bK201 Ba1aKa b9-k-0kaKAa1921 aka a__-k1A A110 A2A_a-B_ a2 _-a90 01002k__1_2 19ka0-0B2k 09BBkk-K 9 2bA 2 -2aB9K-A0A {}",
    "", false, "dictionary-sort-2503",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"aka\" \"_-a90\" \"2bA\" \"01002k__1_2\" \"2\" \"bK201\" \"A2A_a-B_\" \"\" \"9\" \"19ka0-0B2k\" \"-2aB9K-A0A\" \"k\" \"b9-k-0kaKAa1921\" \"a__-k1A\" \"A110\" \"Ba1aKa\" \"09BBkk-K\" \"a2\"]",
    "k bK201 Ba1aKa b9-k-0kaKAa1921 aka a__-k1A A110 A2A_a-B_ a2 _-a90 01002k__1_2 19ka0-0B2k 09BBkk-K 9 2bA 2 -2aB9K-A0A {}",
    "", false, "dictionary-sort-2504",
  )
  check_search_case(
    "lsort -dictionary  [list \"BK2\" \"1ka909--abbabKB\" \"2BkbKK\" \"ka92A_1-b1\" \"A2aAa\" \"_k_KbBa9Bk_-\" \"9A1-k2_kbA2A9a\" \"kB2k0-1121K\" \"--9A_AKAA\" \"AKabK\" \"aK--\" \"-bAaa-KkB_\" \"B_1_k_k9A02-a\" \"1k_A9BbK_19k\" \"1aBkKb-9B0\" \"9B0KbAaKKB-1\" \"2kbBba\" \"1Abb_ka_b-_\"]",
    "--9A_AKAA -bAaa-KkB_ 1Abb_ka_b-_ 1aBkKb-9B0 1k_A9BbK_19k 1ka909--abbabKB 2BkbKK 2kbBba 9A1-k2_kbA2A9a 9B0KbAaKKB-1 _k_KbBa9Bk_- A2aAa aK-- AKabK B_1_k_k9A02-a BK2 ka92A_1-b1 kB2k0-1121K",
    "", false, "dictionary-sort-2505",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"BK2\" \"1ka909--abbabKB\" \"2BkbKK\" \"ka92A_1-b1\" \"A2aAa\" \"_k_KbBa9Bk_-\" \"9A1-k2_kbA2A9a\" \"kB2k0-1121K\" \"--9A_AKAA\" \"AKabK\" \"aK--\" \"-bAaa-KkB_\" \"B_1_k_k9A02-a\" \"1k_A9BbK_19k\" \"1aBkKb-9B0\" \"9B0KbAaKKB-1\" \"2kbBba\" \"1Abb_ka_b-_\"]",
    "--9A_AKAA -bAaa-KkB_ 1Abb_ka_b-_ 1aBkKb-9B0 1k_A9BbK_19k 1ka909--abbabKB 2BkbKK 2kbBba 9A1-k2_kbA2A9a 9B0KbAaKKB-1 _k_KbBa9Bk_- A2aAa aK-- AKabK B_1_k_k9A02-a BK2 ka92A_1-b1 kB2k0-1121K",
    "", false, "dictionary-sort-2506",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"BK2\" \"1ka909--abbabKB\" \"2BkbKK\" \"ka92A_1-b1\" \"A2aAa\" \"_k_KbBa9Bk_-\" \"9A1-k2_kbA2A9a\" \"kB2k0-1121K\" \"--9A_AKAA\" \"AKabK\" \"aK--\" \"-bAaa-KkB_\" \"B_1_k_k9A02-a\" \"1k_A9BbK_19k\" \"1aBkKb-9B0\" \"9B0KbAaKKB-1\" \"2kbBba\" \"1Abb_ka_b-_\"]",
    "--9A_AKAA -bAaa-KkB_ 1Abb_ka_b-_ 1aBkKb-9B0 1k_A9BbK_19k 1ka909--abbabKB 2BkbKK 2kbBba 9A1-k2_kbA2A9a 9B0KbAaKKB-1 _k_KbBa9Bk_- A2aAa aK-- AKabK B_1_k_k9A02-a BK2 ka92A_1-b1 kB2k0-1121K",
    "", false, "dictionary-sort-2507",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"BK2\" \"1ka909--abbabKB\" \"2BkbKK\" \"ka92A_1-b1\" \"A2aAa\" \"_k_KbBa9Bk_-\" \"9A1-k2_kbA2A9a\" \"kB2k0-1121K\" \"--9A_AKAA\" \"AKabK\" \"aK--\" \"-bAaa-KkB_\" \"B_1_k_k9A02-a\" \"1k_A9BbK_19k\" \"1aBkKb-9B0\" \"9B0KbAaKKB-1\" \"2kbBba\" \"1Abb_ka_b-_\"]",
    "kB2k0-1121K ka92A_1-b1 BK2 B_1_k_k9A02-a AKabK aK-- A2aAa _k_KbBa9Bk_- 9B0KbAaKKB-1 9A1-k2_kbA2A9a 2kbBba 2BkbKK 1ka909--abbabKB 1k_A9BbK_19k 1aBkKb-9B0 1Abb_ka_b-_ -bAaa-KkB_ --9A_AKAA",
    "", false, "dictionary-sort-2508",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"BK2\" \"1ka909--abbabKB\" \"2BkbKK\" \"ka92A_1-b1\" \"A2aAa\" \"_k_KbBa9Bk_-\" \"9A1-k2_kbA2A9a\" \"kB2k0-1121K\" \"--9A_AKAA\" \"AKabK\" \"aK--\" \"-bAaa-KkB_\" \"B_1_k_k9A02-a\" \"1k_A9BbK_19k\" \"1aBkKb-9B0\" \"9B0KbAaKKB-1\" \"2kbBba\" \"1Abb_ka_b-_\"]",
    "kB2k0-1121K ka92A_1-b1 BK2 B_1_k_k9A02-a AKabK aK-- A2aAa _k_KbBa9Bk_- 9B0KbAaKKB-1 9A1-k2_kbA2A9a 2kbBba 2BkbKK 1ka909--abbabKB 1k_A9BbK_19k 1aBkKb-9B0 1Abb_ka_b-_ -bAaa-KkB_ --9A_AKAA",
    "", false, "dictionary-sort-2509",
  )
  check_search_case(
    "lsort -dictionary  [list \"10kBB\" \"9Ak91Bba\" \"Abk_\" \"a\" \"k\" \"0-_-BK2ba\" \"abaB1bK_AA990-K\" \"1K1Ka_-2k10A0k2\" \"BKkAb2-9A0-\" \"99\" \"_1a9A9k9K_AAK1\" \"\" \"ab2_kb_2K1kB\" \"90kBB_a9Kk_2\" \"b_200b_KB290\" \"9ba1k11b9bk1a9k\" \"1A\" \"BKa-9\"]",
    "{} 0-_-BK2ba 1A 1K1Ka_-2k10A0k2 9Ak91Bba 9ba1k11b9bk1a9k 10kBB 90kBB_a9Kk_2 99 _1a9A9k9K_AAK1 a ab2_kb_2K1kB abaB1bK_AA990-K Abk_ b_200b_KB290 BKa-9 BKkAb2-9A0- k",
    "", false, "dictionary-sort-2510",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"10kBB\" \"9Ak91Bba\" \"Abk_\" \"a\" \"k\" \"0-_-BK2ba\" \"abaB1bK_AA990-K\" \"1K1Ka_-2k10A0k2\" \"BKkAb2-9A0-\" \"99\" \"_1a9A9k9K_AAK1\" \"\" \"ab2_kb_2K1kB\" \"90kBB_a9Kk_2\" \"b_200b_KB290\" \"9ba1k11b9bk1a9k\" \"1A\" \"BKa-9\"]",
    "{} 0-_-BK2ba 1A 1K1Ka_-2k10A0k2 9Ak91Bba 9ba1k11b9bk1a9k 10kBB 90kBB_a9Kk_2 99 _1a9A9k9K_AAK1 a ab2_kb_2K1kB abaB1bK_AA990-K Abk_ b_200b_KB290 BKa-9 BKkAb2-9A0- k",
    "", false, "dictionary-sort-2511",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"10kBB\" \"9Ak91Bba\" \"Abk_\" \"a\" \"k\" \"0-_-BK2ba\" \"abaB1bK_AA990-K\" \"1K1Ka_-2k10A0k2\" \"BKkAb2-9A0-\" \"99\" \"_1a9A9k9K_AAK1\" \"\" \"ab2_kb_2K1kB\" \"90kBB_a9Kk_2\" \"b_200b_KB290\" \"9ba1k11b9bk1a9k\" \"1A\" \"BKa-9\"]",
    "{} 0-_-BK2ba 1A 1K1Ka_-2k10A0k2 9Ak91Bba 9ba1k11b9bk1a9k 10kBB 90kBB_a9Kk_2 99 _1a9A9k9K_AAK1 a ab2_kb_2K1kB abaB1bK_AA990-K Abk_ b_200b_KB290 BKa-9 BKkAb2-9A0- k",
    "", false, "dictionary-sort-2512",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"10kBB\" \"9Ak91Bba\" \"Abk_\" \"a\" \"k\" \"0-_-BK2ba\" \"abaB1bK_AA990-K\" \"1K1Ka_-2k10A0k2\" \"BKkAb2-9A0-\" \"99\" \"_1a9A9k9K_AAK1\" \"\" \"ab2_kb_2K1kB\" \"90kBB_a9Kk_2\" \"b_200b_KB290\" \"9ba1k11b9bk1a9k\" \"1A\" \"BKa-9\"]",
    "k BKkAb2-9A0- BKa-9 b_200b_KB290 Abk_ abaB1bK_AA990-K ab2_kb_2K1kB a _1a9A9k9K_AAK1 99 90kBB_a9Kk_2 10kBB 9ba1k11b9bk1a9k 9Ak91Bba 1K1Ka_-2k10A0k2 1A 0-_-BK2ba {}",
    "", false, "dictionary-sort-2513",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"10kBB\" \"9Ak91Bba\" \"Abk_\" \"a\" \"k\" \"0-_-BK2ba\" \"abaB1bK_AA990-K\" \"1K1Ka_-2k10A0k2\" \"BKkAb2-9A0-\" \"99\" \"_1a9A9k9K_AAK1\" \"\" \"ab2_kb_2K1kB\" \"90kBB_a9Kk_2\" \"b_200b_KB290\" \"9ba1k11b9bk1a9k\" \"1A\" \"BKa-9\"]",
    "k BKkAb2-9A0- BKa-9 b_200b_KB290 Abk_ abaB1bK_AA990-K ab2_kb_2K1kB a _1a9A9k9K_AAK1 99 90kBB_a9Kk_2 10kBB 9ba1k11b9bk1a9k 9Ak91Bba 1K1Ka_-2k10A0k2 1A 0-_-BK2ba {}",
    "", false, "dictionary-sort-2514",
  )
  check_search_case(
    "lsort -dictionary  [list \"k\" \"22k\" \"__bK-bb_kB\" \"bK2A\" \"12ka-k\" \"k2b9aAb1_a202\" \"a0AA9bkA0911-k_\" \"KA29\" \"-2Ba9-KkKK-\" \"2B00aa-9bk\" \"Ka9B1_a\" \"b__a-kb_abK2bB\" \"1Ka2-Kk0a--0k-\" \"20\" \"b_ak29Ak2\" \"_211-k\" \"0\" \"2-KKA-0\"]",
    "-2Ba9-KkKK- 0 1Ka2-Kk0a--0k- 2-KKA-0 2B00aa-9bk 12ka-k 20 22k _211-k __bK-bb_kB a0AA9bkA0911-k_ b__a-kb_abK2bB b_ak29Ak2 bK2A k k2b9aAb1_a202 Ka9B1_a KA29",
    "", false, "dictionary-sort-2515",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"k\" \"22k\" \"__bK-bb_kB\" \"bK2A\" \"12ka-k\" \"k2b9aAb1_a202\" \"a0AA9bkA0911-k_\" \"KA29\" \"-2Ba9-KkKK-\" \"2B00aa-9bk\" \"Ka9B1_a\" \"b__a-kb_abK2bB\" \"1Ka2-Kk0a--0k-\" \"20\" \"b_ak29Ak2\" \"_211-k\" \"0\" \"2-KKA-0\"]",
    "-2Ba9-KkKK- 0 1Ka2-Kk0a--0k- 2-KKA-0 2B00aa-9bk 12ka-k 20 22k _211-k __bK-bb_kB a0AA9bkA0911-k_ b__a-kb_abK2bB b_ak29Ak2 bK2A k k2b9aAb1_a202 Ka9B1_a KA29",
    "", false, "dictionary-sort-2516",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"k\" \"22k\" \"__bK-bb_kB\" \"bK2A\" \"12ka-k\" \"k2b9aAb1_a202\" \"a0AA9bkA0911-k_\" \"KA29\" \"-2Ba9-KkKK-\" \"2B00aa-9bk\" \"Ka9B1_a\" \"b__a-kb_abK2bB\" \"1Ka2-Kk0a--0k-\" \"20\" \"b_ak29Ak2\" \"_211-k\" \"0\" \"2-KKA-0\"]",
    "-2Ba9-KkKK- 0 1Ka2-Kk0a--0k- 2-KKA-0 2B00aa-9bk 12ka-k 20 22k _211-k __bK-bb_kB a0AA9bkA0911-k_ b__a-kb_abK2bB b_ak29Ak2 bK2A k k2b9aAb1_a202 Ka9B1_a KA29",
    "", false, "dictionary-sort-2517",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"k\" \"22k\" \"__bK-bb_kB\" \"bK2A\" \"12ka-k\" \"k2b9aAb1_a202\" \"a0AA9bkA0911-k_\" \"KA29\" \"-2Ba9-KkKK-\" \"2B00aa-9bk\" \"Ka9B1_a\" \"b__a-kb_abK2bB\" \"1Ka2-Kk0a--0k-\" \"20\" \"b_ak29Ak2\" \"_211-k\" \"0\" \"2-KKA-0\"]",
    "KA29 Ka9B1_a k2b9aAb1_a202 k bK2A b_ak29Ak2 b__a-kb_abK2bB a0AA9bkA0911-k_ __bK-bb_kB _211-k 22k 20 12ka-k 2B00aa-9bk 2-KKA-0 1Ka2-Kk0a--0k- 0 -2Ba9-KkKK-",
    "", false, "dictionary-sort-2518",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"k\" \"22k\" \"__bK-bb_kB\" \"bK2A\" \"12ka-k\" \"k2b9aAb1_a202\" \"a0AA9bkA0911-k_\" \"KA29\" \"-2Ba9-KkKK-\" \"2B00aa-9bk\" \"Ka9B1_a\" \"b__a-kb_abK2bB\" \"1Ka2-Kk0a--0k-\" \"20\" \"b_ak29Ak2\" \"_211-k\" \"0\" \"2-KKA-0\"]",
    "KA29 Ka9B1_a k2b9aAb1_a202 k bK2A b_ak29Ak2 b__a-kb_abK2bB a0AA9bkA0911-k_ __bK-bb_kB _211-k 22k 20 12ka-k 2B00aa-9bk 2-KKA-0 1Ka2-Kk0a--0k- 0 -2Ba9-KkKK-",
    "", false, "dictionary-sort-2519",
  )
}

///|
test "Tcl search cases 2521 through 2560" {
  check_search_case(
    "lsort -dictionary  [list \"\" \"1_\" \"bb_ba_kA-1a\" \"_19B0ka0b9ba21\" \"bK1--KkA\" \"-_b\" \"09--9k\" \"bA9\" \"A1K0B0-_10KKBk_\" \"_b2Ba9bkaBAa\" \"1aaKB-\" \"A\" \"91_b2Bk\" \"29Kakb9Kk\" \"9Ka\" \"0B\" \"1A1Ba1bk0A\" \"20B__B1__BKk\"]",
    "{} -_b 0B 1_ 1A1Ba1bk0A 1aaKB- 09--9k 9Ka 20B__B1__BKk 29Kakb9Kk 91_b2Bk _19B0ka0b9ba21 _b2Ba9bkaBAa A A1K0B0-_10KKBk_ bA9 bb_ba_kA-1a bK1--KkA",
    "", false, "dictionary-sort-2520",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"\" \"1_\" \"bb_ba_kA-1a\" \"_19B0ka0b9ba21\" \"bK1--KkA\" \"-_b\" \"09--9k\" \"bA9\" \"A1K0B0-_10KKBk_\" \"_b2Ba9bkaBAa\" \"1aaKB-\" \"A\" \"91_b2Bk\" \"29Kakb9Kk\" \"9Ka\" \"0B\" \"1A1Ba1bk0A\" \"20B__B1__BKk\"]",
    "{} -_b 0B 1_ 1A1Ba1bk0A 1aaKB- 09--9k 9Ka 20B__B1__BKk 29Kakb9Kk 91_b2Bk _19B0ka0b9ba21 _b2Ba9bkaBAa A A1K0B0-_10KKBk_ bA9 bb_ba_kA-1a bK1--KkA",
    "", false, "dictionary-sort-2521",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"\" \"1_\" \"bb_ba_kA-1a\" \"_19B0ka0b9ba21\" \"bK1--KkA\" \"-_b\" \"09--9k\" \"bA9\" \"A1K0B0-_10KKBk_\" \"_b2Ba9bkaBAa\" \"1aaKB-\" \"A\" \"91_b2Bk\" \"29Kakb9Kk\" \"9Ka\" \"0B\" \"1A1Ba1bk0A\" \"20B__B1__BKk\"]",
    "{} -_b 0B 1_ 1A1Ba1bk0A 1aaKB- 09--9k 9Ka 20B__B1__BKk 29Kakb9Kk 91_b2Bk _19B0ka0b9ba21 _b2Ba9bkaBAa A A1K0B0-_10KKBk_ bA9 bb_ba_kA-1a bK1--KkA",
    "", false, "dictionary-sort-2522",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"\" \"1_\" \"bb_ba_kA-1a\" \"_19B0ka0b9ba21\" \"bK1--KkA\" \"-_b\" \"09--9k\" \"bA9\" \"A1K0B0-_10KKBk_\" \"_b2Ba9bkaBAa\" \"1aaKB-\" \"A\" \"91_b2Bk\" \"29Kakb9Kk\" \"9Ka\" \"0B\" \"1A1Ba1bk0A\" \"20B__B1__BKk\"]",
    "bK1--KkA bb_ba_kA-1a bA9 A1K0B0-_10KKBk_ A _b2Ba9bkaBAa _19B0ka0b9ba21 91_b2Bk 29Kakb9Kk 20B__B1__BKk 9Ka 09--9k 1aaKB- 1A1Ba1bk0A 1_ 0B -_b {}",
    "", false, "dictionary-sort-2523",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"\" \"1_\" \"bb_ba_kA-1a\" \"_19B0ka0b9ba21\" \"bK1--KkA\" \"-_b\" \"09--9k\" \"bA9\" \"A1K0B0-_10KKBk_\" \"_b2Ba9bkaBAa\" \"1aaKB-\" \"A\" \"91_b2Bk\" \"29Kakb9Kk\" \"9Ka\" \"0B\" \"1A1Ba1bk0A\" \"20B__B1__BKk\"]",
    "bK1--KkA bb_ba_kA-1a bA9 A1K0B0-_10KKBk_ A _b2Ba9bkaBAa _19B0ka0b9ba21 91_b2Bk 29Kakb9Kk 20B__B1__BKk 9Ka 09--9k 1aaKB- 1A1Ba1bk0A 1_ 0B -_b {}",
    "", false, "dictionary-sort-2524",
  )
  check_search_case(
    "lsort -dictionary  [list \"_BKAk2K9a-\" \"K912kkK11Ab2_2b\" \"_Ak_Ka_9BK9\" \"1kB9\" \"B20\" \"--B-110_\" \"kb1baAKa\" \"a0bkK11AakK2\" \"09\" \"kk-BaB11b\" \"a0b--A_9bb_A\" \"0_aKAB29_K\" \"b29-12-2bk0k1Aa\" \"02BBa009-aAkB_0\" \"b\" \"\" \"-BK0990B00KkK-b\" \"--b011\"]",
    "{} --B-110_ --b011 -BK0990B00KkK-b 0_aKAB29_K 1kB9 02BBa009-aAkB_0 09 _Ak_Ka_9BK9 _BKAk2K9a- a0b--A_9bb_A a0bkK11AakK2 b B20 b29-12-2bk0k1Aa K912kkK11Ab2_2b kb1baAKa kk-BaB11b",
    "", false, "dictionary-sort-2525",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"_BKAk2K9a-\" \"K912kkK11Ab2_2b\" \"_Ak_Ka_9BK9\" \"1kB9\" \"B20\" \"--B-110_\" \"kb1baAKa\" \"a0bkK11AakK2\" \"09\" \"kk-BaB11b\" \"a0b--A_9bb_A\" \"0_aKAB29_K\" \"b29-12-2bk0k1Aa\" \"02BBa009-aAkB_0\" \"b\" \"\" \"-BK0990B00KkK-b\" \"--b011\"]",
    "{} --B-110_ --b011 -BK0990B00KkK-b 0_aKAB29_K 1kB9 02BBa009-aAkB_0 09 _Ak_Ka_9BK9 _BKAk2K9a- a0b--A_9bb_A a0bkK11AakK2 b B20 b29-12-2bk0k1Aa K912kkK11Ab2_2b kb1baAKa kk-BaB11b",
    "", false, "dictionary-sort-2526",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"_BKAk2K9a-\" \"K912kkK11Ab2_2b\" \"_Ak_Ka_9BK9\" \"1kB9\" \"B20\" \"--B-110_\" \"kb1baAKa\" \"a0bkK11AakK2\" \"09\" \"kk-BaB11b\" \"a0b--A_9bb_A\" \"0_aKAB29_K\" \"b29-12-2bk0k1Aa\" \"02BBa009-aAkB_0\" \"b\" \"\" \"-BK0990B00KkK-b\" \"--b011\"]",
    "{} --B-110_ --b011 -BK0990B00KkK-b 0_aKAB29_K 1kB9 02BBa009-aAkB_0 09 _Ak_Ka_9BK9 _BKAk2K9a- a0b--A_9bb_A a0bkK11AakK2 b B20 b29-12-2bk0k1Aa K912kkK11Ab2_2b kb1baAKa kk-BaB11b",
    "", false, "dictionary-sort-2527",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"_BKAk2K9a-\" \"K912kkK11Ab2_2b\" \"_Ak_Ka_9BK9\" \"1kB9\" \"B20\" \"--B-110_\" \"kb1baAKa\" \"a0bkK11AakK2\" \"09\" \"kk-BaB11b\" \"a0b--A_9bb_A\" \"0_aKAB29_K\" \"b29-12-2bk0k1Aa\" \"02BBa009-aAkB_0\" \"b\" \"\" \"-BK0990B00KkK-b\" \"--b011\"]",
    "kk-BaB11b kb1baAKa K912kkK11Ab2_2b b29-12-2bk0k1Aa B20 b a0bkK11AakK2 a0b--A_9bb_A _BKAk2K9a- _Ak_Ka_9BK9 09 02BBa009-aAkB_0 1kB9 0_aKAB29_K -BK0990B00KkK-b --b011 --B-110_ {}",
    "", false, "dictionary-sort-2528",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"_BKAk2K9a-\" \"K912kkK11Ab2_2b\" \"_Ak_Ka_9BK9\" \"1kB9\" \"B20\" \"--B-110_\" \"kb1baAKa\" \"a0bkK11AakK2\" \"09\" \"kk-BaB11b\" \"a0b--A_9bb_A\" \"0_aKAB29_K\" \"b29-12-2bk0k1Aa\" \"02BBa009-aAkB_0\" \"b\" \"\" \"-BK0990B00KkK-b\" \"--b011\"]",
    "kk-BaB11b kb1baAKa K912kkK11Ab2_2b b29-12-2bk0k1Aa B20 b a0bkK11AakK2 a0b--A_9bb_A _BKAk2K9a- _Ak_Ka_9BK9 09 02BBa009-aAkB_0 1kB9 0_aKAB29_K -BK0990B00KkK-b --b011 --B-110_ {}",
    "", false, "dictionary-sort-2529",
  )
  check_search_case(
    "lsort -dictionary  [list \"a2K90KBB2020\" \"kA9AK-_a_2\" \"119a\" \"2B0\" \"1k9-A9KB\" \"A9110K202A02\" \"\" \"A9BBKab-b\" \"20-0\" \"K-\" \"\" \"KK\" \"2Ba1-_\" \"KBkB0b-ba-11k0\" \"-b-a\" \"-aaBk90b9b2-1\" \"2_9Bb\" \"0A09b100b2a2K9\"]",
    "{} {} -aaBk90b9b2-1 -b-a 0A09b100b2a2K9 1k9-A9KB 2_9Bb 2B0 2Ba1-_ 20-0 119a a2K90KBB2020 A9BBKab-b A9110K202A02 K- kA9AK-_a_2 KBkB0b-ba-11k0 KK",
    "", false, "dictionary-sort-2530",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"a2K90KBB2020\" \"kA9AK-_a_2\" \"119a\" \"2B0\" \"1k9-A9KB\" \"A9110K202A02\" \"\" \"A9BBKab-b\" \"20-0\" \"K-\" \"\" \"KK\" \"2Ba1-_\" \"KBkB0b-ba-11k0\" \"-b-a\" \"-aaBk90b9b2-1\" \"2_9Bb\" \"0A09b100b2a2K9\"]",
    "{} {} -aaBk90b9b2-1 -b-a 0A09b100b2a2K9 1k9-A9KB 2_9Bb 2B0 2Ba1-_ 20-0 119a a2K90KBB2020 A9BBKab-b A9110K202A02 K- kA9AK-_a_2 KBkB0b-ba-11k0 KK",
    "", false, "dictionary-sort-2531",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"a2K90KBB2020\" \"kA9AK-_a_2\" \"119a\" \"2B0\" \"1k9-A9KB\" \"A9110K202A02\" \"\" \"A9BBKab-b\" \"20-0\" \"K-\" \"\" \"KK\" \"2Ba1-_\" \"KBkB0b-ba-11k0\" \"-b-a\" \"-aaBk90b9b2-1\" \"2_9Bb\" \"0A09b100b2a2K9\"]",
    "{} -aaBk90b9b2-1 -b-a 0A09b100b2a2K9 1k9-A9KB 2_9Bb 2B0 2Ba1-_ 20-0 119a a2K90KBB2020 A9BBKab-b A9110K202A02 K- kA9AK-_a_2 KBkB0b-ba-11k0 KK",
    "", false, "dictionary-sort-2532",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"a2K90KBB2020\" \"kA9AK-_a_2\" \"119a\" \"2B0\" \"1k9-A9KB\" \"A9110K202A02\" \"\" \"A9BBKab-b\" \"20-0\" \"K-\" \"\" \"KK\" \"2Ba1-_\" \"KBkB0b-ba-11k0\" \"-b-a\" \"-aaBk90b9b2-1\" \"2_9Bb\" \"0A09b100b2a2K9\"]",
    "KK KBkB0b-ba-11k0 kA9AK-_a_2 K- A9110K202A02 A9BBKab-b a2K90KBB2020 119a 20-0 2Ba1-_ 2B0 2_9Bb 1k9-A9KB 0A09b100b2a2K9 -b-a -aaBk90b9b2-1 {} {}",
    "", false, "dictionary-sort-2533",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"a2K90KBB2020\" \"kA9AK-_a_2\" \"119a\" \"2B0\" \"1k9-A9KB\" \"A9110K202A02\" \"\" \"A9BBKab-b\" \"20-0\" \"K-\" \"\" \"KK\" \"2Ba1-_\" \"KBkB0b-ba-11k0\" \"-b-a\" \"-aaBk90b9b2-1\" \"2_9Bb\" \"0A09b100b2a2K9\"]",
    "KK KBkB0b-ba-11k0 kA9AK-_a_2 K- A9110K202A02 A9BBKab-b a2K90KBB2020 119a 20-0 2Ba1-_ 2B0 2_9Bb 1k9-A9KB 0A09b100b2a2K9 -b-a -aaBk90b9b2-1 {}",
    "", false, "dictionary-sort-2534",
  )
  check_search_case(
    "lsort -dictionary  [list \"b-AK2a_0\" \"2AB009_ak\" \"a2-bK1_2_\" \"11B9_b9-B\" \"12AB__Kb19k9b0\" \"A92K12\" \"kk9\" \"akB\" \"--kaKK\" \"0\" \"Ab0BbaB_bAaB_-\" \"Kk0a9aakK1_ka_\" \"kK2b220BB-AakK\" \"B\" \"11\" \"BAk-A-bb_\" \"ak\" \"k22b\"]",
    "--kaKK 0 2AB009_ak 11 11B9_b9-B 12AB__Kb19k9b0 a2-bK1_2_ A92K12 Ab0BbaB_bAaB_- ak akB B b-AK2a_0 BAk-A-bb_ k22b Kk0a9aakK1_ka_ kK2b220BB-AakK kk9",
    "", false, "dictionary-sort-2535",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"b-AK2a_0\" \"2AB009_ak\" \"a2-bK1_2_\" \"11B9_b9-B\" \"12AB__Kb19k9b0\" \"A92K12\" \"kk9\" \"akB\" \"--kaKK\" \"0\" \"Ab0BbaB_bAaB_-\" \"Kk0a9aakK1_ka_\" \"kK2b220BB-AakK\" \"B\" \"11\" \"BAk-A-bb_\" \"ak\" \"k22b\"]",
    "--kaKK 0 2AB009_ak 11 11B9_b9-B 12AB__Kb19k9b0 a2-bK1_2_ A92K12 Ab0BbaB_bAaB_- ak akB B b-AK2a_0 BAk-A-bb_ k22b Kk0a9aakK1_ka_ kK2b220BB-AakK kk9",
    "", false, "dictionary-sort-2536",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"b-AK2a_0\" \"2AB009_ak\" \"a2-bK1_2_\" \"11B9_b9-B\" \"12AB__Kb19k9b0\" \"A92K12\" \"kk9\" \"akB\" \"--kaKK\" \"0\" \"Ab0BbaB_bAaB_-\" \"Kk0a9aakK1_ka_\" \"kK2b220BB-AakK\" \"B\" \"11\" \"BAk-A-bb_\" \"ak\" \"k22b\"]",
    "--kaKK 0 2AB009_ak 11 11B9_b9-B 12AB__Kb19k9b0 a2-bK1_2_ A92K12 Ab0BbaB_bAaB_- ak akB B b-AK2a_0 BAk-A-bb_ k22b Kk0a9aakK1_ka_ kK2b220BB-AakK kk9",
    "", false, "dictionary-sort-2537",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"b-AK2a_0\" \"2AB009_ak\" \"a2-bK1_2_\" \"11B9_b9-B\" \"12AB__Kb19k9b0\" \"A92K12\" \"kk9\" \"akB\" \"--kaKK\" \"0\" \"Ab0BbaB_bAaB_-\" \"Kk0a9aakK1_ka_\" \"kK2b220BB-AakK\" \"B\" \"11\" \"BAk-A-bb_\" \"ak\" \"k22b\"]",
    "kk9 kK2b220BB-AakK Kk0a9aakK1_ka_ k22b BAk-A-bb_ b-AK2a_0 B akB ak Ab0BbaB_bAaB_- A92K12 a2-bK1_2_ 12AB__Kb19k9b0 11B9_b9-B 11 2AB009_ak 0 --kaKK",
    "", false, "dictionary-sort-2538",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"b-AK2a_0\" \"2AB009_ak\" \"a2-bK1_2_\" \"11B9_b9-B\" \"12AB__Kb19k9b0\" \"A92K12\" \"kk9\" \"akB\" \"--kaKK\" \"0\" \"Ab0BbaB_bAaB_-\" \"Kk0a9aakK1_ka_\" \"kK2b220BB-AakK\" \"B\" \"11\" \"BAk-A-bb_\" \"ak\" \"k22b\"]",
    "kk9 kK2b220BB-AakK Kk0a9aakK1_ka_ k22b BAk-A-bb_ b-AK2a_0 B akB ak Ab0BbaB_bAaB_- A92K12 a2-bK1_2_ 12AB__Kb19k9b0 11B9_b9-B 11 2AB009_ak 0 --kaKK",
    "", false, "dictionary-sort-2539",
  )
  check_search_case(
    "lsort -dictionary  [list \"19Ba-\" \"_B9Kk2KB\" \"\" \"BkK2\" \"-929a0\" \"b\" \"b_BKBK\" \"_Ab\" \"0KA20a0AbaA9BB\" \"aB\" \"bK2Ba_2_0919k1a\" \"Kba\" \"\" \"b0aa1_Kba21\" \"K\" \"-B0B\" \"0BakBKb1B2-A_0\" \"-k122b_B\"]",
    "{} {} -929a0 -B0B -k122b_B 0BakBKb1B2-A_0 0KA20a0AbaA9BB 19Ba- _Ab _B9Kk2KB aB b b0aa1_Kba21 b_BKBK bK2Ba_2_0919k1a BkK2 K Kba",
    "", false, "dictionary-sort-2540",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"19Ba-\" \"_B9Kk2KB\" \"\" \"BkK2\" \"-929a0\" \"b\" \"b_BKBK\" \"_Ab\" \"0KA20a0AbaA9BB\" \"aB\" \"bK2Ba_2_0919k1a\" \"Kba\" \"\" \"b0aa1_Kba21\" \"K\" \"-B0B\" \"0BakBKb1B2-A_0\" \"-k122b_B\"]",
    "{} {} -929a0 -B0B -k122b_B 0BakBKb1B2-A_0 0KA20a0AbaA9BB 19Ba- _Ab _B9Kk2KB aB b b0aa1_Kba21 b_BKBK bK2Ba_2_0919k1a BkK2 K Kba",
    "", false, "dictionary-sort-2541",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"19Ba-\" \"_B9Kk2KB\" \"\" \"BkK2\" \"-929a0\" \"b\" \"b_BKBK\" \"_Ab\" \"0KA20a0AbaA9BB\" \"aB\" \"bK2Ba_2_0919k1a\" \"Kba\" \"\" \"b0aa1_Kba21\" \"K\" \"-B0B\" \"0BakBKb1B2-A_0\" \"-k122b_B\"]",
    "{} -929a0 -B0B -k122b_B 0BakBKb1B2-A_0 0KA20a0AbaA9BB 19Ba- _Ab _B9Kk2KB aB b b0aa1_Kba21 b_BKBK bK2Ba_2_0919k1a BkK2 K Kba",
    "", false, "dictionary-sort-2542",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"19Ba-\" \"_B9Kk2KB\" \"\" \"BkK2\" \"-929a0\" \"b\" \"b_BKBK\" \"_Ab\" \"0KA20a0AbaA9BB\" \"aB\" \"bK2Ba_2_0919k1a\" \"Kba\" \"\" \"b0aa1_Kba21\" \"K\" \"-B0B\" \"0BakBKb1B2-A_0\" \"-k122b_B\"]",
    "Kba K BkK2 bK2Ba_2_0919k1a b_BKBK b0aa1_Kba21 b aB _B9Kk2KB _Ab 19Ba- 0KA20a0AbaA9BB 0BakBKb1B2-A_0 -k122b_B -B0B -929a0 {} {}",
    "", false, "dictionary-sort-2543",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"19Ba-\" \"_B9Kk2KB\" \"\" \"BkK2\" \"-929a0\" \"b\" \"b_BKBK\" \"_Ab\" \"0KA20a0AbaA9BB\" \"aB\" \"bK2Ba_2_0919k1a\" \"Kba\" \"\" \"b0aa1_Kba21\" \"K\" \"-B0B\" \"0BakBKb1B2-A_0\" \"-k122b_B\"]",
    "Kba K BkK2 bK2Ba_2_0919k1a b_BKBK b0aa1_Kba21 b aB _B9Kk2KB _Ab 19Ba- 0KA20a0AbaA9BB 0BakBKb1B2-A_0 -k122b_B -B0B -929a0 {}",
    "", false, "dictionary-sort-2544",
  )
  check_search_case(
    "lsort -dictionary  [list \"-aa29b1-a___-A\" \"k2a1\" \"a_A-_aKB91B\" \"aK9-b20-a\" \"2\" \"a-k\" \"k92\" \"Ak-k0Aab\" \"bb9b-1kk_kaB\" \"_kaa1Ka2-bB-\" \"K\" \"A09A2-BKK0a0A\" \"Bbb2A0kbABB-1A2\" \"B2120aB1kaBbK\" \"0aBa0BK2_\" \"-kB9_0902-99K\" \"-2b_A92\" \"1A_Ak9aKAB\"]",
    "-2b_A92 -aa29b1-a___-A -kB9_0902-99K 0aBa0BK2_ 1A_Ak9aKAB 2 _kaa1Ka2-bB- a-k A09A2-BKK0a0A a_A-_aKB91B Ak-k0Aab aK9-b20-a B2120aB1kaBbK bb9b-1kk_kaB Bbb2A0kbABB-1A2 K k2a1 k92",
    "", false, "dictionary-sort-2545",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"-aa29b1-a___-A\" \"k2a1\" \"a_A-_aKB91B\" \"aK9-b20-a\" \"2\" \"a-k\" \"k92\" \"Ak-k0Aab\" \"bb9b-1kk_kaB\" \"_kaa1Ka2-bB-\" \"K\" \"A09A2-BKK0a0A\" \"Bbb2A0kbABB-1A2\" \"B2120aB1kaBbK\" \"0aBa0BK2_\" \"-kB9_0902-99K\" \"-2b_A92\" \"1A_Ak9aKAB\"]",
    "-2b_A92 -aa29b1-a___-A -kB9_0902-99K 0aBa0BK2_ 1A_Ak9aKAB 2 _kaa1Ka2-bB- a-k A09A2-BKK0a0A a_A-_aKB91B Ak-k0Aab aK9-b20-a B2120aB1kaBbK bb9b-1kk_kaB Bbb2A0kbABB-1A2 K k2a1 k92",
    "", false, "dictionary-sort-2546",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"-aa29b1-a___-A\" \"k2a1\" \"a_A-_aKB91B\" \"aK9-b20-a\" \"2\" \"a-k\" \"k92\" \"Ak-k0Aab\" \"bb9b-1kk_kaB\" \"_kaa1Ka2-bB-\" \"K\" \"A09A2-BKK0a0A\" \"Bbb2A0kbABB-1A2\" \"B2120aB1kaBbK\" \"0aBa0BK2_\" \"-kB9_0902-99K\" \"-2b_A92\" \"1A_Ak9aKAB\"]",
    "-2b_A92 -aa29b1-a___-A -kB9_0902-99K 0aBa0BK2_ 1A_Ak9aKAB 2 _kaa1Ka2-bB- a-k A09A2-BKK0a0A a_A-_aKB91B Ak-k0Aab aK9-b20-a B2120aB1kaBbK bb9b-1kk_kaB Bbb2A0kbABB-1A2 K k2a1 k92",
    "", false, "dictionary-sort-2547",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"-aa29b1-a___-A\" \"k2a1\" \"a_A-_aKB91B\" \"aK9-b20-a\" \"2\" \"a-k\" \"k92\" \"Ak-k0Aab\" \"bb9b-1kk_kaB\" \"_kaa1Ka2-bB-\" \"K\" \"A09A2-BKK0a0A\" \"Bbb2A0kbABB-1A2\" \"B2120aB1kaBbK\" \"0aBa0BK2_\" \"-kB9_0902-99K\" \"-2b_A92\" \"1A_Ak9aKAB\"]",
    "k92 k2a1 K Bbb2A0kbABB-1A2 bb9b-1kk_kaB B2120aB1kaBbK aK9-b20-a Ak-k0Aab a_A-_aKB91B A09A2-BKK0a0A a-k _kaa1Ka2-bB- 2 1A_Ak9aKAB 0aBa0BK2_ -kB9_0902-99K -aa29b1-a___-A -2b_A92",
    "", false, "dictionary-sort-2548",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"-aa29b1-a___-A\" \"k2a1\" \"a_A-_aKB91B\" \"aK9-b20-a\" \"2\" \"a-k\" \"k92\" \"Ak-k0Aab\" \"bb9b-1kk_kaB\" \"_kaa1Ka2-bB-\" \"K\" \"A09A2-BKK0a0A\" \"Bbb2A0kbABB-1A2\" \"B2120aB1kaBbK\" \"0aBa0BK2_\" \"-kB9_0902-99K\" \"-2b_A92\" \"1A_Ak9aKAB\"]",
    "k92 k2a1 K Bbb2A0kbABB-1A2 bb9b-1kk_kaB B2120aB1kaBbK aK9-b20-a Ak-k0Aab a_A-_aKB91B A09A2-BKK0a0A a-k _kaa1Ka2-bB- 2 1A_Ak9aKAB 0aBa0BK2_ -kB9_0902-99K -aa29b1-a___-A -2b_A92",
    "", false, "dictionary-sort-2549",
  )
  check_search_case(
    "lsort -dictionary  [list \"1Bk2ab\" \"\" \"B_0ka\" \"kka2AAb\" \"09_Baa-0a-01-\" \"A_k\" \"a0b_00K1b\" \"9A-902a0KB\" \"-a2K0a9K\" \"11Ka9_-0\" \"b_1\" \"K1-2\" \"_2K02b0KBa\" \"k1B_\" \"2_00K9--B\" \"_K-kB0b\" \"k\" \"_-K0-K_k-\"]",
    "{} -a2K0a9K 1Bk2ab 2_00K9--B 09_Baa-0a-01- 9A-902a0KB 11Ka9_-0 _-K0-K_k- _2K02b0KBa _K-kB0b a0b_00K1b A_k B_0ka b_1 k K1-2 k1B_ kka2AAb",
    "", false, "dictionary-sort-2550",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"1Bk2ab\" \"\" \"B_0ka\" \"kka2AAb\" \"09_Baa-0a-01-\" \"A_k\" \"a0b_00K1b\" \"9A-902a0KB\" \"-a2K0a9K\" \"11Ka9_-0\" \"b_1\" \"K1-2\" \"_2K02b0KBa\" \"k1B_\" \"2_00K9--B\" \"_K-kB0b\" \"k\" \"_-K0-K_k-\"]",
    "{} -a2K0a9K 1Bk2ab 2_00K9--B 09_Baa-0a-01- 9A-902a0KB 11Ka9_-0 _-K0-K_k- _2K02b0KBa _K-kB0b a0b_00K1b A_k B_0ka b_1 k K1-2 k1B_ kka2AAb",
    "", false, "dictionary-sort-2551",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"1Bk2ab\" \"\" \"B_0ka\" \"kka2AAb\" \"09_Baa-0a-01-\" \"A_k\" \"a0b_00K1b\" \"9A-902a0KB\" \"-a2K0a9K\" \"11Ka9_-0\" \"b_1\" \"K1-2\" \"_2K02b0KBa\" \"k1B_\" \"2_00K9--B\" \"_K-kB0b\" \"k\" \"_-K0-K_k-\"]",
    "{} -a2K0a9K 1Bk2ab 2_00K9--B 09_Baa-0a-01- 9A-902a0KB 11Ka9_-0 _-K0-K_k- _2K02b0KBa _K-kB0b a0b_00K1b A_k B_0ka b_1 k K1-2 k1B_ kka2AAb",
    "", false, "dictionary-sort-2552",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"1Bk2ab\" \"\" \"B_0ka\" \"kka2AAb\" \"09_Baa-0a-01-\" \"A_k\" \"a0b_00K1b\" \"9A-902a0KB\" \"-a2K0a9K\" \"11Ka9_-0\" \"b_1\" \"K1-2\" \"_2K02b0KBa\" \"k1B_\" \"2_00K9--B\" \"_K-kB0b\" \"k\" \"_-K0-K_k-\"]",
    "kka2AAb k1B_ K1-2 k b_1 B_0ka A_k a0b_00K1b _K-kB0b _2K02b0KBa _-K0-K_k- 11Ka9_-0 9A-902a0KB 09_Baa-0a-01- 2_00K9--B 1Bk2ab -a2K0a9K {}",
    "", false, "dictionary-sort-2553",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"1Bk2ab\" \"\" \"B_0ka\" \"kka2AAb\" \"09_Baa-0a-01-\" \"A_k\" \"a0b_00K1b\" \"9A-902a0KB\" \"-a2K0a9K\" \"11Ka9_-0\" \"b_1\" \"K1-2\" \"_2K02b0KBa\" \"k1B_\" \"2_00K9--B\" \"_K-kB0b\" \"k\" \"_-K0-K_k-\"]",
    "kka2AAb k1B_ K1-2 k b_1 B_0ka A_k a0b_00K1b _K-kB0b _2K02b0KBa _-K0-K_k- 11Ka9_-0 9A-902a0KB 09_Baa-0a-01- 2_00K9--B 1Bk2ab -a2K0a9K {}",
    "", false, "dictionary-sort-2554",
  )
  check_search_case(
    "lsort -dictionary  [list \"k\" \"1\" \"0bB\" \"0a1190A9\" \"0bbA-_Ak\" \"021k\" \"a_\" \"k29a\" \"_k29A-A_-KBKA\" \"B\" \"Bba09ab91_92_\" \"b11bk--0b__1--9\" \"-kKka-b0A_\" \"1b\" \"b_akK\" \"2BBK02_\" \"-_\" \"K\"]",
    "-_ -kKka-b0A_ 0a1190A9 0bB 0bbA-_Ak 1 1b 2BBK02_ 021k _k29A-A_-KBKA a_ B b11bk--0b__1--9 b_akK Bba09ab91_92_ K k k29a",
    "", false, "dictionary-sort-2555",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"k\" \"1\" \"0bB\" \"0a1190A9\" \"0bbA-_Ak\" \"021k\" \"a_\" \"k29a\" \"_k29A-A_-KBKA\" \"B\" \"Bba09ab91_92_\" \"b11bk--0b__1--9\" \"-kKka-b0A_\" \"1b\" \"b_akK\" \"2BBK02_\" \"-_\" \"K\"]",
    "-_ -kKka-b0A_ 0a1190A9 0bB 0bbA-_Ak 1 1b 2BBK02_ 021k _k29A-A_-KBKA a_ B b11bk--0b__1--9 b_akK Bba09ab91_92_ K k k29a",
    "", false, "dictionary-sort-2556",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"k\" \"1\" \"0bB\" \"0a1190A9\" \"0bbA-_Ak\" \"021k\" \"a_\" \"k29a\" \"_k29A-A_-KBKA\" \"B\" \"Bba09ab91_92_\" \"b11bk--0b__1--9\" \"-kKka-b0A_\" \"1b\" \"b_akK\" \"2BBK02_\" \"-_\" \"K\"]",
    "-_ -kKka-b0A_ 0a1190A9 0bB 0bbA-_Ak 1 1b 2BBK02_ 021k _k29A-A_-KBKA a_ B b11bk--0b__1--9 b_akK Bba09ab91_92_ K k k29a",
    "", false, "dictionary-sort-2557",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"k\" \"1\" \"0bB\" \"0a1190A9\" \"0bbA-_Ak\" \"021k\" \"a_\" \"k29a\" \"_k29A-A_-KBKA\" \"B\" \"Bba09ab91_92_\" \"b11bk--0b__1--9\" \"-kKka-b0A_\" \"1b\" \"b_akK\" \"2BBK02_\" \"-_\" \"K\"]",
    "k29a k K Bba09ab91_92_ b_akK b11bk--0b__1--9 B a_ _k29A-A_-KBKA 021k 2BBK02_ 1b 1 0bbA-_Ak 0bB 0a1190A9 -kKka-b0A_ -_",
    "", false, "dictionary-sort-2558",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"k\" \"1\" \"0bB\" \"0a1190A9\" \"0bbA-_Ak\" \"021k\" \"a_\" \"k29a\" \"_k29A-A_-KBKA\" \"B\" \"Bba09ab91_92_\" \"b11bk--0b__1--9\" \"-kKka-b0A_\" \"1b\" \"b_akK\" \"2BBK02_\" \"-_\" \"K\"]",
    "k29a k K Bba09ab91_92_ b_akK b11bk--0b__1--9 B a_ _k29A-A_-KBKA 021k 2BBK02_ 1b 1 0bbA-_Ak 0bB 0a1190A9 -kKka-b0A_ -_",
    "", false, "dictionary-sort-2559",
  )
}

///|
test "Tcl search cases 2561 through 2600" {
  check_search_case(
    "lsort -dictionary  [list \"0_99--\" \"B_aABk_19\" \"b-0Ak-90bb\" \"k1K2BK2A\" \"2-BakBKkBA\" \"_1B-kB-ka90a\" \"9Bkkk-092A2\" \"b922KK29A1A9bK_\" \"\" \"kb9kBb\" \"K_1b1-2\" \"B9KK21-KkKKA\" \"1K\" \"2-19Ba0K-\" \"9_Ba-1_9aB9ab10\" \"K2AbKk2\" \"1-0K2_0A-Kk0a\" \"0-9B_29\"]",
    "{} 0-9B_29 0_99-- 1-0K2_0A-Kk0a 1K 2-19Ba0K- 2-BakBKkBA 9_Ba-1_9aB9ab10 9Bkkk-092A2 _1B-kB-ka90a b-0Ak-90bb B9KK21-KkKKA b922KK29A1A9bK_ B_aABk_19 k1K2BK2A K2AbKk2 K_1b1-2 kb9kBb",
    "", false, "dictionary-sort-2560",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"0_99--\" \"B_aABk_19\" \"b-0Ak-90bb\" \"k1K2BK2A\" \"2-BakBKkBA\" \"_1B-kB-ka90a\" \"9Bkkk-092A2\" \"b922KK29A1A9bK_\" \"\" \"kb9kBb\" \"K_1b1-2\" \"B9KK21-KkKKA\" \"1K\" \"2-19Ba0K-\" \"9_Ba-1_9aB9ab10\" \"K2AbKk2\" \"1-0K2_0A-Kk0a\" \"0-9B_29\"]",
    "{} 0-9B_29 0_99-- 1-0K2_0A-Kk0a 1K 2-19Ba0K- 2-BakBKkBA 9_Ba-1_9aB9ab10 9Bkkk-092A2 _1B-kB-ka90a b-0Ak-90bb B9KK21-KkKKA b922KK29A1A9bK_ B_aABk_19 k1K2BK2A K2AbKk2 K_1b1-2 kb9kBb",
    "", false, "dictionary-sort-2561",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"0_99--\" \"B_aABk_19\" \"b-0Ak-90bb\" \"k1K2BK2A\" \"2-BakBKkBA\" \"_1B-kB-ka90a\" \"9Bkkk-092A2\" \"b922KK29A1A9bK_\" \"\" \"kb9kBb\" \"K_1b1-2\" \"B9KK21-KkKKA\" \"1K\" \"2-19Ba0K-\" \"9_Ba-1_9aB9ab10\" \"K2AbKk2\" \"1-0K2_0A-Kk0a\" \"0-9B_29\"]",
    "{} 0-9B_29 0_99-- 1-0K2_0A-Kk0a 1K 2-19Ba0K- 2-BakBKkBA 9_Ba-1_9aB9ab10 9Bkkk-092A2 _1B-kB-ka90a b-0Ak-90bb B9KK21-KkKKA b922KK29A1A9bK_ B_aABk_19 k1K2BK2A K2AbKk2 K_1b1-2 kb9kBb",
    "", false, "dictionary-sort-2562",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"0_99--\" \"B_aABk_19\" \"b-0Ak-90bb\" \"k1K2BK2A\" \"2-BakBKkBA\" \"_1B-kB-ka90a\" \"9Bkkk-092A2\" \"b922KK29A1A9bK_\" \"\" \"kb9kBb\" \"K_1b1-2\" \"B9KK21-KkKKA\" \"1K\" \"2-19Ba0K-\" \"9_Ba-1_9aB9ab10\" \"K2AbKk2\" \"1-0K2_0A-Kk0a\" \"0-9B_29\"]",
    "kb9kBb K_1b1-2 K2AbKk2 k1K2BK2A B_aABk_19 b922KK29A1A9bK_ B9KK21-KkKKA b-0Ak-90bb _1B-kB-ka90a 9Bkkk-092A2 9_Ba-1_9aB9ab10 2-BakBKkBA 2-19Ba0K- 1K 1-0K2_0A-Kk0a 0_99-- 0-9B_29 {}",
    "", false, "dictionary-sort-2563",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"0_99--\" \"B_aABk_19\" \"b-0Ak-90bb\" \"k1K2BK2A\" \"2-BakBKkBA\" \"_1B-kB-ka90a\" \"9Bkkk-092A2\" \"b922KK29A1A9bK_\" \"\" \"kb9kBb\" \"K_1b1-2\" \"B9KK21-KkKKA\" \"1K\" \"2-19Ba0K-\" \"9_Ba-1_9aB9ab10\" \"K2AbKk2\" \"1-0K2_0A-Kk0a\" \"0-9B_29\"]",
    "kb9kBb K_1b1-2 K2AbKk2 k1K2BK2A B_aABk_19 b922KK29A1A9bK_ B9KK21-KkKKA b-0Ak-90bb _1B-kB-ka90a 9Bkkk-092A2 9_Ba-1_9aB9ab10 2-BakBKkBA 2-19Ba0K- 1K 1-0K2_0A-Kk0a 0_99-- 0-9B_29 {}",
    "", false, "dictionary-sort-2564",
  )
  check_search_case(
    "lsort -dictionary  [list \"KBb9B-Ka9A2\" \"_B\" \"k1_a29A\" \"_AKkb\" \"Bk911\" \"_09AA\" \"\" \"1___-0_a9_1\" \"BK\" \"aK-Kb91aBBk-\" \"2K20\" \"BKbak10_K_a_-0\" \"0B2A\" \"aaBBA__9kAbAa2\" \"k00aB9\" \"bBk-ak0_b-B\" \"a0K901a-00\" \"Kk0Bb1b\"]",
    "{} 0B2A 1___-0_a9_1 2K20 _09AA _AKkb _B a0K901a-00 aaBBA__9kAbAa2 aK-Kb91aBBk- bBk-ak0_b-B BK Bk911 BKbak10_K_a_-0 k00aB9 k1_a29A KBb9B-Ka9A2 Kk0Bb1b",
    "", false, "dictionary-sort-2565",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"KBb9B-Ka9A2\" \"_B\" \"k1_a29A\" \"_AKkb\" \"Bk911\" \"_09AA\" \"\" \"1___-0_a9_1\" \"BK\" \"aK-Kb91aBBk-\" \"2K20\" \"BKbak10_K_a_-0\" \"0B2A\" \"aaBBA__9kAbAa2\" \"k00aB9\" \"bBk-ak0_b-B\" \"a0K901a-00\" \"Kk0Bb1b\"]",
    "{} 0B2A 1___-0_a9_1 2K20 _09AA _AKkb _B a0K901a-00 aaBBA__9kAbAa2 aK-Kb91aBBk- bBk-ak0_b-B BK Bk911 BKbak10_K_a_-0 k00aB9 k1_a29A KBb9B-Ka9A2 Kk0Bb1b",
    "", false, "dictionary-sort-2566",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"KBb9B-Ka9A2\" \"_B\" \"k1_a29A\" \"_AKkb\" \"Bk911\" \"_09AA\" \"\" \"1___-0_a9_1\" \"BK\" \"aK-Kb91aBBk-\" \"2K20\" \"BKbak10_K_a_-0\" \"0B2A\" \"aaBBA__9kAbAa2\" \"k00aB9\" \"bBk-ak0_b-B\" \"a0K901a-00\" \"Kk0Bb1b\"]",
    "{} 0B2A 1___-0_a9_1 2K20 _09AA _AKkb _B a0K901a-00 aaBBA__9kAbAa2 aK-Kb91aBBk- bBk-ak0_b-B BK Bk911 BKbak10_K_a_-0 k00aB9 k1_a29A KBb9B-Ka9A2 Kk0Bb1b",
    "", false, "dictionary-sort-2567",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"KBb9B-Ka9A2\" \"_B\" \"k1_a29A\" \"_AKkb\" \"Bk911\" \"_09AA\" \"\" \"1___-0_a9_1\" \"BK\" \"aK-Kb91aBBk-\" \"2K20\" \"BKbak10_K_a_-0\" \"0B2A\" \"aaBBA__9kAbAa2\" \"k00aB9\" \"bBk-ak0_b-B\" \"a0K901a-00\" \"Kk0Bb1b\"]",
    "Kk0Bb1b KBb9B-Ka9A2 k1_a29A k00aB9 BKbak10_K_a_-0 Bk911 BK bBk-ak0_b-B aK-Kb91aBBk- aaBBA__9kAbAa2 a0K901a-00 _B _AKkb _09AA 2K20 1___-0_a9_1 0B2A {}",
    "", false, "dictionary-sort-2568",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"KBb9B-Ka9A2\" \"_B\" \"k1_a29A\" \"_AKkb\" \"Bk911\" \"_09AA\" \"\" \"1___-0_a9_1\" \"BK\" \"aK-Kb91aBBk-\" \"2K20\" \"BKbak10_K_a_-0\" \"0B2A\" \"aaBBA__9kAbAa2\" \"k00aB9\" \"bBk-ak0_b-B\" \"a0K901a-00\" \"Kk0Bb1b\"]",
    "Kk0Bb1b KBb9B-Ka9A2 k1_a29A k00aB9 BKbak10_K_a_-0 Bk911 BK bBk-ak0_b-B aK-Kb91aBBk- aaBBA__9kAbAa2 a0K901a-00 _B _AKkb _09AA 2K20 1___-0_a9_1 0B2A {}",
    "", false, "dictionary-sort-2569",
  )
  check_search_case(
    "lsort -dictionary  [list \"a_0\" \"9--K0k1Kk-_KAA\" \"kKkB-\" \"BAA_k0kK91KkA\" \"1KB2\" \"_AA_\" \"9k2\" \"bK0_2\" \"BBaab02a1bA_00\" \"A2b0KK122b9a\" \"Ak-Aa\" \"a-kK0\" \"ab29_Aa-0A_b\" \"1211B19-00a\" \"Aba\" \"bkKk-kAA0K_ak_\" \"9a-a_KK01-A0k9K\" \"-a00A-K_B2\"]",
    "-a00A-K_B2 1KB2 9--K0k1Kk-_KAA 9a-a_KK01-A0k9K 9k2 1211B19-00a _AA_ a-kK0 A2b0KK122b9a a_0 ab29_Aa-0A_b Aba Ak-Aa BAA_k0kK91KkA BBaab02a1bA_00 bK0_2 bkKk-kAA0K_ak_ kKkB-",
    "", false, "dictionary-sort-2570",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"a_0\" \"9--K0k1Kk-_KAA\" \"kKkB-\" \"BAA_k0kK91KkA\" \"1KB2\" \"_AA_\" \"9k2\" \"bK0_2\" \"BBaab02a1bA_00\" \"A2b0KK122b9a\" \"Ak-Aa\" \"a-kK0\" \"ab29_Aa-0A_b\" \"1211B19-00a\" \"Aba\" \"bkKk-kAA0K_ak_\" \"9a-a_KK01-A0k9K\" \"-a00A-K_B2\"]",
    "-a00A-K_B2 1KB2 9--K0k1Kk-_KAA 9a-a_KK01-A0k9K 9k2 1211B19-00a _AA_ a-kK0 A2b0KK122b9a a_0 ab29_Aa-0A_b Aba Ak-Aa BAA_k0kK91KkA BBaab02a1bA_00 bK0_2 bkKk-kAA0K_ak_ kKkB-",
    "", false, "dictionary-sort-2571",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"a_0\" \"9--K0k1Kk-_KAA\" \"kKkB-\" \"BAA_k0kK91KkA\" \"1KB2\" \"_AA_\" \"9k2\" \"bK0_2\" \"BBaab02a1bA_00\" \"A2b0KK122b9a\" \"Ak-Aa\" \"a-kK0\" \"ab29_Aa-0A_b\" \"1211B19-00a\" \"Aba\" \"bkKk-kAA0K_ak_\" \"9a-a_KK01-A0k9K\" \"-a00A-K_B2\"]",
    "-a00A-K_B2 1KB2 9--K0k1Kk-_KAA 9a-a_KK01-A0k9K 9k2 1211B19-00a _AA_ a-kK0 A2b0KK122b9a a_0 ab29_Aa-0A_b Aba Ak-Aa BAA_k0kK91KkA BBaab02a1bA_00 bK0_2 bkKk-kAA0K_ak_ kKkB-",
    "", false, "dictionary-sort-2572",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"a_0\" \"9--K0k1Kk-_KAA\" \"kKkB-\" \"BAA_k0kK91KkA\" \"1KB2\" \"_AA_\" \"9k2\" \"bK0_2\" \"BBaab02a1bA_00\" \"A2b0KK122b9a\" \"Ak-Aa\" \"a-kK0\" \"ab29_Aa-0A_b\" \"1211B19-00a\" \"Aba\" \"bkKk-kAA0K_ak_\" \"9a-a_KK01-A0k9K\" \"-a00A-K_B2\"]",
    "kKkB- bkKk-kAA0K_ak_ bK0_2 BBaab02a1bA_00 BAA_k0kK91KkA Ak-Aa Aba ab29_Aa-0A_b a_0 A2b0KK122b9a a-kK0 _AA_ 1211B19-00a 9k2 9a-a_KK01-A0k9K 9--K0k1Kk-_KAA 1KB2 -a00A-K_B2",
    "", false, "dictionary-sort-2573",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"a_0\" \"9--K0k1Kk-_KAA\" \"kKkB-\" \"BAA_k0kK91KkA\" \"1KB2\" \"_AA_\" \"9k2\" \"bK0_2\" \"BBaab02a1bA_00\" \"A2b0KK122b9a\" \"Ak-Aa\" \"a-kK0\" \"ab29_Aa-0A_b\" \"1211B19-00a\" \"Aba\" \"bkKk-kAA0K_ak_\" \"9a-a_KK01-A0k9K\" \"-a00A-K_B2\"]",
    "kKkB- bkKk-kAA0K_ak_ bK0_2 BBaab02a1bA_00 BAA_k0kK91KkA Ak-Aa Aba ab29_Aa-0A_b a_0 A2b0KK122b9a a-kK0 _AA_ 1211B19-00a 9k2 9a-a_KK01-A0k9K 9--K0k1Kk-_KAA 1KB2 -a00A-K_B2",
    "", false, "dictionary-sort-2574",
  )
  check_search_case(
    "lsort -dictionary  [list \"b2b2-1Bk\" \"9_a9bKA\" \"BbA\" \"\" \"kA1_K--1-Ba1\" \"9B_2a1-B1k\" \"aA-K\" \"k91A\" \"akbKa_B-29\" \"9kkBBK00_a-12K1\" \"baaKa00-k2\" \"9-Ak292AAB_\" \"b--2k\" \"bA_1k_AKBb\" \"BKbka19_-AABA\" \"A-k0aB2a2Kb1a\" \"\" \"k_KA12-_1B_\"]",
    "{} {} 9-Ak292AAB_ 9_a9bKA 9B_2a1-B1k 9kkBBK00_a-12K1 A-k0aB2a2Kb1a aA-K akbKa_B-29 b--2k b2b2-1Bk bA_1k_AKBb baaKa00-k2 BbA BKbka19_-AABA k91A k_KA12-_1B_ kA1_K--1-Ba1",
    "", false, "dictionary-sort-2575",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"b2b2-1Bk\" \"9_a9bKA\" \"BbA\" \"\" \"kA1_K--1-Ba1\" \"9B_2a1-B1k\" \"aA-K\" \"k91A\" \"akbKa_B-29\" \"9kkBBK00_a-12K1\" \"baaKa00-k2\" \"9-Ak292AAB_\" \"b--2k\" \"bA_1k_AKBb\" \"BKbka19_-AABA\" \"A-k0aB2a2Kb1a\" \"\" \"k_KA12-_1B_\"]",
    "{} {} 9-Ak292AAB_ 9_a9bKA 9B_2a1-B1k 9kkBBK00_a-12K1 A-k0aB2a2Kb1a aA-K akbKa_B-29 b--2k b2b2-1Bk bA_1k_AKBb baaKa00-k2 BbA BKbka19_-AABA k91A k_KA12-_1B_ kA1_K--1-Ba1",
    "", false, "dictionary-sort-2576",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"b2b2-1Bk\" \"9_a9bKA\" \"BbA\" \"\" \"kA1_K--1-Ba1\" \"9B_2a1-B1k\" \"aA-K\" \"k91A\" \"akbKa_B-29\" \"9kkBBK00_a-12K1\" \"baaKa00-k2\" \"9-Ak292AAB_\" \"b--2k\" \"bA_1k_AKBb\" \"BKbka19_-AABA\" \"A-k0aB2a2Kb1a\" \"\" \"k_KA12-_1B_\"]",
    "{} 9-Ak292AAB_ 9_a9bKA 9B_2a1-B1k 9kkBBK00_a-12K1 A-k0aB2a2Kb1a aA-K akbKa_B-29 b--2k b2b2-1Bk bA_1k_AKBb baaKa00-k2 BbA BKbka19_-AABA k91A k_KA12-_1B_ kA1_K--1-Ba1",
    "", false, "dictionary-sort-2577",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"b2b2-1Bk\" \"9_a9bKA\" \"BbA\" \"\" \"kA1_K--1-Ba1\" \"9B_2a1-B1k\" \"aA-K\" \"k91A\" \"akbKa_B-29\" \"9kkBBK00_a-12K1\" \"baaKa00-k2\" \"9-Ak292AAB_\" \"b--2k\" \"bA_1k_AKBb\" \"BKbka19_-AABA\" \"A-k0aB2a2Kb1a\" \"\" \"k_KA12-_1B_\"]",
    "kA1_K--1-Ba1 k_KA12-_1B_ k91A BKbka19_-AABA BbA baaKa00-k2 bA_1k_AKBb b2b2-1Bk b--2k akbKa_B-29 aA-K A-k0aB2a2Kb1a 9kkBBK00_a-12K1 9B_2a1-B1k 9_a9bKA 9-Ak292AAB_ {} {}",
    "", false, "dictionary-sort-2578",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"b2b2-1Bk\" \"9_a9bKA\" \"BbA\" \"\" \"kA1_K--1-Ba1\" \"9B_2a1-B1k\" \"aA-K\" \"k91A\" \"akbKa_B-29\" \"9kkBBK00_a-12K1\" \"baaKa00-k2\" \"9-Ak292AAB_\" \"b--2k\" \"bA_1k_AKBb\" \"BKbka19_-AABA\" \"A-k0aB2a2Kb1a\" \"\" \"k_KA12-_1B_\"]",
    "kA1_K--1-Ba1 k_KA12-_1B_ k91A BKbka19_-AABA BbA baaKa00-k2 bA_1k_AKBb b2b2-1Bk b--2k akbKa_B-29 aA-K A-k0aB2a2Kb1a 9kkBBK00_a-12K1 9B_2a1-B1k 9_a9bKA 9-Ak292AAB_ {}",
    "", false, "dictionary-sort-2579",
  )
  check_search_case(
    "lsort -dictionary  [list \"kKk_A00K9B\" \"kB02-Kk1b2BA-\" \"Kb2A_10_kB0A9\" \"KA--K\" \"a9Aka-2Ak92B9\" \"-A0KakKk202BkBa\" \"1A\" \"0-KB_K-bK_0b2aA\" \"\" \"20Kaa1A1\" \"BBkK\" \"KK-B-1K_Ba0b\" \"-A9Bb_A99BbA010\" \"-\" \"a2bb0B_K\" \"9kA2AkB-00201\" \"b_B0BkBBKa2-\" \"-_a-00B11b_0_\"]",
    "{} - -_a-00B11b_0_ -A0KakKk202BkBa -A9Bb_A99BbA010 0-KB_K-bK_0b2aA 1A 9kA2AkB-00201 20Kaa1A1 a2bb0B_K a9Aka-2Ak92B9 b_B0BkBBKa2- BBkK KA--K kB02-Kk1b2BA- Kb2A_10_kB0A9 KK-B-1K_Ba0b kKk_A00K9B",
    "", false, "dictionary-sort-2580",
  )
  check_search_case(
    "lsort -dictionary -nocase [list \"kKk_A00K9B\" \"kB02-Kk1b2BA-\" \"Kb2A_10_kB0A9\" \"KA--K\" \"a9Aka-2Ak92B9\" \"-A0KakKk202BkBa\" \"1A\" \"0-KB_K-bK_0b2aA\" \"\" \"20Kaa1A1\" \"BBkK\" \"KK-B-1K_Ba0b\" \"-A9Bb_A99BbA010\" \"-\" \"a2bb0B_K\" \"9kA2AkB-00201\" \"b_B0BkBBKa2-\" \"-_a-00B11b_0_\"]",
    "{} - -_a-00B11b_0_ -A0KakKk202BkBa -A9Bb_A99BbA010 0-KB_K-bK_0b2aA 1A 9kA2AkB-00201 20Kaa1A1 a2bb0B_K a9Aka-2Ak92B9 b_B0BkBBKa2- BBkK KA--K kB02-Kk1b2BA- Kb2A_10_kB0A9 KK-B-1K_Ba0b kKk_A00K9B",
    "", false, "dictionary-sort-2581",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"kKk_A00K9B\" \"kB02-Kk1b2BA-\" \"Kb2A_10_kB0A9\" \"KA--K\" \"a9Aka-2Ak92B9\" \"-A0KakKk202BkBa\" \"1A\" \"0-KB_K-bK_0b2aA\" \"\" \"20Kaa1A1\" \"BBkK\" \"KK-B-1K_Ba0b\" \"-A9Bb_A99BbA010\" \"-\" \"a2bb0B_K\" \"9kA2AkB-00201\" \"b_B0BkBBKa2-\" \"-_a-00B11b_0_\"]",
    "{} - -_a-00B11b_0_ -A0KakKk202BkBa -A9Bb_A99BbA010 0-KB_K-bK_0b2aA 1A 9kA2AkB-00201 20Kaa1A1 a2bb0B_K a9Aka-2Ak92B9 b_B0BkBBKa2- BBkK KA--K kB02-Kk1b2BA- Kb2A_10_kB0A9 KK-B-1K_Ba0b kKk_A00K9B",
    "", false, "dictionary-sort-2582",
  )
  check_search_case(
    "lsort -dictionary -decreasing [list \"kKk_A00K9B\" \"kB02-Kk1b2BA-\" \"Kb2A_10_kB0A9\" \"KA--K\" \"a9Aka-2Ak92B9\" \"-A0KakKk202BkBa\" \"1A\" \"0-KB_K-bK_0b2aA\" \"\" \"20Kaa1A1\" \"BBkK\" \"KK-B-1K_Ba0b\" \"-A9Bb_A99BbA010\" \"-\" \"a2bb0B_K\" \"9kA2AkB-00201\" \"b_B0BkBBKa2-\" \"-_a-00B11b_0_\"]",
    "kKk_A00K9B KK-B-1K_Ba0b Kb2A_10_kB0A9 kB02-Kk1b2BA- KA--K BBkK b_B0BkBBKa2- a9Aka-2Ak92B9 a2bb0B_K 20Kaa1A1 9kA2AkB-00201 1A 0-KB_K-bK_0b2aA -A9Bb_A99BbA010 -A0KakKk202BkBa -_a-00B11b_0_ - {}",
    "", false, "dictionary-sort-2583",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"kKk_A00K9B\" \"kB02-Kk1b2BA-\" \"Kb2A_10_kB0A9\" \"KA--K\" \"a9Aka-2Ak92B9\" \"-A0KakKk202BkBa\" \"1A\" \"0-KB_K-bK_0b2aA\" \"\" \"20Kaa1A1\" \"BBkK\" \"KK-B-1K_Ba0b\" \"-A9Bb_A99BbA010\" \"-\" \"a2bb0B_K\" \"9kA2AkB-00201\" \"b_B0BkBBKa2-\" \"-_a-00B11b_0_\"]",
    "kKk_A00K9B KK-B-1K_Ba0b Kb2A_10_kB0A9 kB02-Kk1b2BA- KA--K BBkK b_B0BkBBKa2- a9Aka-2Ak92B9 a2bb0B_K 20Kaa1A1 9kA2AkB-00201 1A 0-KB_K-bK_0b2aA -A9Bb_A99BbA010 -A0KakKk202BkBa -_a-00B11b_0_ - {}",
    "", false, "dictionary-sort-2584",
  )
  check_search_case(
    "lsearch -all -exact -dictionary [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\"] \"a01\"",
    "0", "", false, "dictionary-search-2585",
  )
  check_search_case(
    "set v [lsort -ascii [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\"]];lsearch -sorted $v \"a01\"",
    "2", "", false, "ascii-search-2586",
  )
  check_search_case(
    "set v [lsort -ascii -nocase [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\"]];lsearch -sorted -nocase $v \"a01\"",
    "1", "", false, "nocase-sorted-2587",
  )
  check_search_case(
    "lsearch -all -exact -dictionary [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\"] \"a1\"",
    "1", "", false, "dictionary-search-2588",
  )
  check_search_case(
    "set v [lsort -ascii [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\"]];lsearch -sorted $v \"a1\"",
    "3", "", false, "ascii-search-2589",
  )
  check_search_case(
    "set v [lsort -ascii -nocase [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\"]];lsearch -sorted -nocase $v \"a1\"",
    "2", "", false, "nocase-sorted-2590",
  )
  check_search_case(
    "lsearch -all -exact -dictionary [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\"] \"a001\"",
    "2", "", false, "dictionary-search-2591",
  )
  check_search_case(
    "set v [lsort -ascii [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\"]];lsearch -sorted $v \"a001\"",
    "1", "", false, "ascii-search-2592",
  )
  check_search_case(
    "set v [lsort -ascii -nocase [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\"]];lsearch -sorted -nocase $v \"a001\"",
    "0", "", false, "nocase-sorted-2593",
  )
  check_search_case(
    "lsearch -all -exact -dictionary [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\"] \"a10\"",
    "3", "", false, "dictionary-search-2594",
  )
  check_search_case(
    "set v [lsort -ascii [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\"]];lsearch -sorted $v \"a10\"",
    "4", "", false, "ascii-search-2595",
  )
  check_search_case(
    "set v [lsort -ascii -nocase [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\"]];lsearch -sorted -nocase $v \"a10\"",
    "4", "", false, "nocase-sorted-2596",
  )
  check_search_case(
    "lsearch -all -exact -dictionary [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\"] \"a2\"",
    "4", "", false, "dictionary-search-2597",
  )
  check_search_case(
    "set v [lsort -ascii [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\"]];lsearch -sorted $v \"a2\"",
    "5", "", false, "ascii-search-2598",
  )
  check_search_case(
    "set v [lsort -ascii -nocase [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\"]];lsearch -sorted -nocase $v \"a2\"",
    "5", "", false, "nocase-sorted-2599",
  )
}

///|
test "Tcl search cases 2601 through 2640" {
  check_search_case(
    "lsearch -all -exact -dictionary [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\"] \"A1\"",
    "5", "", false, "dictionary-search-2600",
  )
  check_search_case(
    "set v [lsort -ascii [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\"]];lsearch -sorted $v \"A1\"",
    "0", "", false, "ascii-search-2601",
  )
  check_search_case(
    "set v [lsort -ascii -nocase [list \"a01\" \"a1\" \"a001\" \"a10\" \"a2\" \"A1\"]];lsearch -sorted -nocase $v \"A1\"",
    "2", "", false, "nocase-sorted-2602",
  )
  check_search_case(
    "lsearch -all -exact -dictionary [list \"K\" \"K\" \"k\"] \"K\"", "0 1",
    "", false, "dictionary-search-2603",
  )
  check_search_case(
    "set v [lsort -ascii [list \"K\" \"K\" \"k\"]];lsearch -sorted $v \"K\"",
    "2", "", false, "ascii-search-2604",
  )
  check_search_case(
    "set v [lsort -ascii -nocase [list \"K\" \"K\" \"k\"]];lsearch -sorted -nocase $v \"K\"",
    "0", "", false, "nocase-sorted-2605",
  )
  check_search_case(
    "lsearch -all -exact -dictionary [list \"K\" \"K\" \"k\"] \"K\"", "0 1", "",
    false, "dictionary-search-2606",
  )
  check_search_case(
    "set v [lsort -ascii [list \"K\" \"K\" \"k\"]];lsearch -sorted $v \"K\"", "0",
    "", false, "ascii-search-2607",
  )
  check_search_case(
    "set v [lsort -ascii -nocase [list \"K\" \"K\" \"k\"]];lsearch -sorted -nocase $v \"K\"",
    "0", "", false, "nocase-sorted-2608",
  )
  check_search_case(
    "lsearch -all -exact -dictionary [list \"K\" \"K\" \"k\"] \"k\"", "2", "",
    false, "dictionary-search-2609",
  )
  check_search_case(
    "set v [lsort -ascii [list \"K\" \"K\" \"k\"]];lsearch -sorted $v \"k\"", "1",
    "", false, "ascii-search-2610",
  )
  check_search_case(
    "set v [lsort -ascii -nocase [list \"K\" \"K\" \"k\"]];lsearch -sorted -nocase $v \"k\"",
    "0", "", false, "nocase-sorted-2611",
  )
  check_search_case(
    "lsearch -all -exact -dictionary [list \"İ\" \"i\" \"I\" \"ı\"] \"İ\"", "0 2",
    "", false, "dictionary-search-2612",
  )
  check_search_case(
    "set v [lsort -ascii [list \"İ\" \"i\" \"I\" \"ı\"]];lsearch -sorted $v \"İ\"",
    "2", "", false, "ascii-search-2613",
  )
  check_search_case(
    "set v [lsort -ascii -nocase [list \"İ\" \"i\" \"I\" \"ı\"]];lsearch -sorted -nocase $v \"İ\"",
    "0", "", false, "nocase-sorted-2614",
  )
  check_search_case(
    "lsearch -all -exact -dictionary [list \"İ\" \"i\" \"I\" \"ı\"] \"i\"", "1",
    "", false, "dictionary-search-2615",
  )
  check_search_case(
    "set v [lsort -ascii [list \"İ\" \"i\" \"I\" \"ı\"]];lsearch -sorted $v \"i\"",
    "1", "", false, "ascii-search-2616",
  )
  check_search_case(
    "set v [lsort -ascii -nocase [list \"İ\" \"i\" \"I\" \"ı\"]];lsearch -sorted -nocase $v \"i\"",
    "0", "", false, "nocase-sorted-2617",
  )
  check_search_case(
    "lsearch -all -exact -dictionary [list \"İ\" \"i\" \"I\" \"ı\"] \"I\"", "0 2",
    "", false, "dictionary-search-2618",
  )
  check_search_case(
    "set v [lsort -ascii [list \"İ\" \"i\" \"I\" \"ı\"]];lsearch -sorted $v \"I\"",
    "0", "", false, "ascii-search-2619",
  )
  check_search_case(
    "set v [lsort -ascii -nocase [list \"İ\" \"i\" \"I\" \"ı\"]];lsearch -sorted -nocase $v \"I\"",
    "0", "", false, "nocase-sorted-2620",
  )
  check_search_case(
    "lsearch -all -exact -dictionary [list \"İ\" \"i\" \"I\" \"ı\"] \"ı\"", "3",
    "", false, "dictionary-search-2621",
  )
  check_search_case(
    "set v [lsort -ascii [list \"İ\" \"i\" \"I\" \"ı\"]];lsearch -sorted $v \"ı\"",
    "3", "", false, "ascii-search-2622",
  )
  check_search_case(
    "set v [lsort -ascii -nocase [list \"İ\" \"i\" \"I\" \"ı\"]];lsearch -sorted -nocase $v \"ı\"",
    "3", "", false, "nocase-sorted-2623",
  )
  check_search_case(
    "lsearch -all -exact -dictionary [list \"Ǆ\" \"ǅ\" \"ǆ\"] \"Ǆ\"", "0 1",
    "", false, "dictionary-search-2624",
  )
  check_search_case(
    "set v [lsort -ascii [list \"Ǆ\" \"ǅ\" \"ǆ\"]];lsearch -sorted $v \"Ǆ\"",
    "0", "", false, "ascii-search-2625",
  )
  check_search_case(
    "set v [lsort -ascii -nocase [list \"Ǆ\" \"ǅ\" \"ǆ\"]];lsearch -sorted -nocase $v \"Ǆ\"",
    "0", "", false, "nocase-sorted-2626",
  )
  check_search_case(
    "lsearch -all -exact -dictionary [list \"Ǆ\" \"ǅ\" \"ǆ\"] \"ǅ\"", "0 1 2",
    "", false, "dictionary-search-2627",
  )
  check_search_case(
    "set v [lsort -ascii [list \"Ǆ\" \"ǅ\" \"ǆ\"]];lsearch -sorted $v \"ǅ\"",
    "1", "", false, "ascii-search-2628",
  )
  check_search_case(
    "set v [lsort -ascii -nocase [list \"Ǆ\" \"ǅ\" \"ǆ\"]];lsearch -sorted -nocase $v \"ǅ\"",
    "0", "", false, "nocase-sorted-2629",
  )
  check_search_case(
    "lsearch -all -exact -dictionary [list \"Ǆ\" \"ǅ\" \"ǆ\"] \"ǆ\"", "1 2",
    "", false, "dictionary-search-2630",
  )
  check_search_case(
    "set v [lsort -ascii [list \"Ǆ\" \"ǅ\" \"ǆ\"]];lsearch -sorted $v \"ǆ\"",
    "2", "", false, "ascii-search-2631",
  )
  check_search_case(
    "set v [lsort -ascii -nocase [list \"Ǆ\" \"ǅ\" \"ǆ\"]];lsearch -sorted -nocase $v \"ǆ\"",
    "0", "", false, "nocase-sorted-2632",
  )
  check_search_case(
    "lsearch -all -exact -dictionary [list \"𐐨\" \"𐐀\" \"𐐩\" \"𐐁\"] \"𐐨\"",
    "0", "", false, "dictionary-search-2633",
  )
  check_search_case(
    "set v [lsort -ascii [list \"𐐨\" \"𐐀\" \"𐐩\" \"𐐁\"]];lsearch -sorted $v \"𐐨\"",
    "2", "", false, "ascii-search-2634",
  )
  check_search_case(
    "set v [lsort -ascii -nocase [list \"𐐨\" \"𐐀\" \"𐐩\" \"𐐁\"]];lsearch -sorted -nocase $v \"𐐨\"",
    "2", "", false, "nocase-sorted-2635",
  )
  check_search_case(
    "lsearch -all -exact -dictionary [list \"𐐨\" \"𐐀\" \"𐐩\" \"𐐁\"] \"𐐀\"",
    "1", "", false, "dictionary-search-2636",
  )
  check_search_case(
    "set v [lsort -ascii [list \"𐐨\" \"𐐀\" \"𐐩\" \"𐐁\"]];lsearch -sorted $v \"𐐀\"",
    "0", "", false, "ascii-search-2637",
  )
  check_search_case(
    "set v [lsort -ascii -nocase [list \"𐐨\" \"𐐀\" \"𐐩\" \"𐐁\"]];lsearch -sorted -nocase $v \"𐐀\"",
    "0", "", false, "nocase-sorted-2638",
  )
  check_search_case(
    "lsearch -all -exact -dictionary [list \"𐐨\" \"𐐀\" \"𐐩\" \"𐐁\"] \"𐐩\"",
    "2", "", false, "dictionary-search-2639",
  )
}

///|
test "Tcl search cases 2641 through 2680" {
  check_search_case(
    "set v [lsort -ascii [list \"𐐨\" \"𐐀\" \"𐐩\" \"𐐁\"]];lsearch -sorted $v \"𐐩\"",
    "3", "", false, "ascii-search-2640",
  )
  check_search_case(
    "set v [lsort -ascii -nocase [list \"𐐨\" \"𐐀\" \"𐐩\" \"𐐁\"]];lsearch -sorted -nocase $v \"𐐩\"",
    "3", "", false, "nocase-sorted-2641",
  )
  check_search_case(
    "lsearch -all -exact -dictionary [list \"𐐨\" \"𐐀\" \"𐐩\" \"𐐁\"] \"𐐁\"",
    "3", "", false, "dictionary-search-2642",
  )
  check_search_case(
    "set v [lsort -ascii [list \"𐐨\" \"𐐀\" \"𐐩\" \"𐐁\"]];lsearch -sorted $v \"𐐁\"",
    "1", "", false, "ascii-search-2643",
  )
  check_search_case(
    "set v [lsort -ascii -nocase [list \"𐐨\" \"𐐀\" \"𐐩\" \"𐐁\"]];lsearch -sorted -nocase $v \"𐐁\"",
    "1", "", false, "nocase-sorted-2644",
  )
  check_search_case(
    "lsearch -all -exact -dictionary [list \"😀\" \"\" \"￿\" \"a\"] \"😀\"",
    "0", "", false, "dictionary-search-2645",
  )
  check_search_case(
    "set v [lsort -ascii [list \"😀\" \"\" \"￿\" \"a\"]];lsearch -sorted $v \"😀\"",
    "3", "", false, "ascii-search-2646",
  )
  check_search_case(
    "set v [lsort -ascii -nocase [list \"😀\" \"\" \"￿\" \"a\"]];lsearch -sorted -nocase $v \"😀\"",
    "1", "", false, "nocase-sorted-2647",
  )
  check_search_case(
    "lsearch -all -exact -dictionary [list \"😀\" \"\" \"￿\" \"a\"] \"\"",
    "1", "", false, "dictionary-search-2648",
  )
  check_search_case(
    "set v [lsort -ascii [list \"😀\" \"\" \"￿\" \"a\"]];lsearch -sorted $v \"\"",
    "1", "", false, "ascii-search-2649",
  )
  check_search_case(
    "set v [lsort -ascii -nocase [list \"😀\" \"\" \"￿\" \"a\"]];lsearch -sorted -nocase $v \"\"",
    "2", "", false, "nocase-sorted-2650",
  )
  check_search_case(
    "lsearch -all -exact -dictionary [list \"😀\" \"\" \"￿\" \"a\"] \"￿\"",
    "2", "", false, "dictionary-search-2651",
  )
  check_search_case(
    "set v [lsort -ascii [list \"😀\" \"\" \"￿\" \"a\"]];lsearch -sorted $v \"￿\"",
    "2", "", false, "ascii-search-2652",
  )
  check_search_case(
    "set v [lsort -ascii -nocase [list \"😀\" \"\" \"￿\" \"a\"]];lsearch -sorted -nocase $v \"￿\"",
    "3", "", false, "nocase-sorted-2653",
  )
  check_search_case(
    "lsearch -all -exact -dictionary [list \"😀\" \"\" \"￿\" \"a\"] \"a\"",
    "3", "", false, "dictionary-search-2654",
  )
  check_search_case(
    "set v [lsort -ascii [list \"😀\" \"\" \"￿\" \"a\"]];lsearch -sorted $v \"a\"",
    "0", "", false, "ascii-search-2655",
  )
  check_search_case(
    "set v [lsort -ascii -nocase [list \"😀\" \"\" \"￿\" \"a\"]];lsearch -sorted -nocase $v \"a\"",
    "0", "", false, "nocase-sorted-2656",
  )
  check_search_case(
    "lsearch -all -exact -dictionary [list \"a\" \"a\\x00b\" \"a\\x00A\" \"a\\x00\"] \"a\"",
    "0", "", false, "dictionary-search-2657",
  )
  check_search_case(
    "set v [lsort -ascii [list \"a\" \"a\\x00b\" \"a\\x00A\" \"a\\x00\"]];lsearch -sorted $v \"a\"",
    "0", "", false, "ascii-search-2658",
  )
  check_search_case(
    "set v [lsort -ascii -nocase [list \"a\" \"a\\x00b\" \"a\\x00A\" \"a\\x00\"]];lsearch -sorted -nocase $v \"a\"",
    "0", "", false, "nocase-sorted-2659",
  )
  check_search_case(
    "lsearch -all -exact -dictionary [list \"a\" \"a\\x00b\" \"a\\x00A\" \"a\\x00\"] \"a\\x00b\"",
    "1", "", false, "dictionary-search-2660",
  )
  check_search_case(
    "set v [lsort -ascii [list \"a\" \"a\\x00b\" \"a\\x00A\" \"a\\x00\"]];lsearch -sorted $v \"a\\x00b\"",
    "3", "", false, "ascii-search-2661",
  )
  check_search_case(
    "set v [lsort -ascii -nocase [list \"a\" \"a\\x00b\" \"a\\x00A\" \"a\\x00\"]];lsearch -sorted -nocase $v \"a\\x00b\"",
    "3", "", false, "nocase-sorted-2662",
  )
  check_search_case(
    "lsearch -all -exact -dictionary [list \"a\" \"a\\x00b\" \"a\\x00A\" \"a\\x00\"] \"a\\x00A\"",
    "2", "", false, "dictionary-search-2663",
  )
  check_search_case(
    "set v [lsort -ascii [list \"a\" \"a\\x00b\" \"a\\x00A\" \"a\\x00\"]];lsearch -sorted $v \"a\\x00A\"",
    "2", "", false, "ascii-search-2664",
  )
  check_search_case(
    "set v [lsort -ascii -nocase [list \"a\" \"a\\x00b\" \"a\\x00A\" \"a\\x00\"]];lsearch -sorted -nocase $v \"a\\x00A\"",
    "2", "", false, "nocase-sorted-2665",
  )
  check_search_case(
    "lsearch -all -exact -dictionary [list \"a\" \"a\\x00b\" \"a\\x00A\" \"a\\x00\"] \"a\\x00\"",
    "3", "", false, "dictionary-search-2666",
  )
  check_search_case(
    "set v [lsort -ascii [list \"a\" \"a\\x00b\" \"a\\x00A\" \"a\\x00\"]];lsearch -sorted $v \"a\\x00\"",
    "1", "", false, "ascii-search-2667",
  )
  check_search_case(
    "set v [lsort -ascii -nocase [list \"a\" \"a\\x00b\" \"a\\x00A\" \"a\\x00\"]];lsearch -sorted -nocase $v \"a\\x00\"",
    "1", "", false, "nocase-sorted-2668",
  )
  check_search_case(
    "lsearch -all -exact -dictionary [list \"x9\" \"x100\" \"x000100\" \"X100\" \"x01z9\" \"x1z10\"] \"x9\"",
    "0", "", false, "dictionary-search-2669",
  )
  check_search_case(
    "set v [lsort -ascii [list \"x9\" \"x100\" \"x000100\" \"X100\" \"x01z9\" \"x1z10\"]];lsearch -sorted $v \"x9\"",
    "5", "", false, "ascii-search-2670",
  )
  check_search_case(
    "set v [lsort -ascii -nocase [list \"x9\" \"x100\" \"x000100\" \"X100\" \"x01z9\" \"x1z10\"]];lsearch -sorted -nocase $v \"x9\"",
    "5", "", false, "nocase-sorted-2671",
  )
  check_search_case(
    "lsearch -all -exact -dictionary [list \"x9\" \"x100\" \"x000100\" \"X100\" \"x01z9\" \"x1z10\"] \"x100\"",
    "1", "", false, "dictionary-search-2672",
  )
  check_search_case(
    "set v [lsort -ascii [list \"x9\" \"x100\" \"x000100\" \"X100\" \"x01z9\" \"x1z10\"]];lsearch -sorted $v \"x100\"",
    "3", "", false, "ascii-search-2673",
  )
  check_search_case(
    "set v [lsort -ascii -nocase [list \"x9\" \"x100\" \"x000100\" \"X100\" \"x01z9\" \"x1z10\"]];lsearch -sorted -nocase $v \"x100\"",
    "2", "", false, "nocase-sorted-2674",
  )
  check_search_case(
    "lsearch -all -exact -dictionary [list \"x9\" \"x100\" \"x000100\" \"X100\" \"x01z9\" \"x1z10\"] \"x000100\"",
    "2", "", false, "dictionary-search-2675",
  )
  check_search_case(
    "set v [lsort -ascii [list \"x9\" \"x100\" \"x000100\" \"X100\" \"x01z9\" \"x1z10\"]];lsearch -sorted $v \"x000100\"",
    "1", "", false, "ascii-search-2676",
  )
  check_search_case(
    "set v [lsort -ascii -nocase [list \"x9\" \"x100\" \"x000100\" \"X100\" \"x01z9\" \"x1z10\"]];lsearch -sorted -nocase $v \"x000100\"",
    "0", "", false, "nocase-sorted-2677",
  )
  check_search_case(
    "lsearch -all -exact -dictionary [list \"x9\" \"x100\" \"x000100\" \"X100\" \"x01z9\" \"x1z10\"] \"X100\"",
    "3", "", false, "dictionary-search-2678",
  )
  check_search_case(
    "set v [lsort -ascii [list \"x9\" \"x100\" \"x000100\" \"X100\" \"x01z9\" \"x1z10\"]];lsearch -sorted $v \"X100\"",
    "0", "", false, "ascii-search-2679",
  )
}

///|
test "Tcl search cases 2681 through 2720" {
  check_search_case(
    "set v [lsort -ascii -nocase [list \"x9\" \"x100\" \"x000100\" \"X100\" \"x01z9\" \"x1z10\"]];lsearch -sorted -nocase $v \"X100\"",
    "2", "", false, "nocase-sorted-2680",
  )
  check_search_case(
    "lsearch -all -exact -dictionary [list \"x9\" \"x100\" \"x000100\" \"X100\" \"x01z9\" \"x1z10\"] \"x01z9\"",
    "4", "", false, "dictionary-search-2681",
  )
  check_search_case(
    "set v [lsort -ascii [list \"x9\" \"x100\" \"x000100\" \"X100\" \"x01z9\" \"x1z10\"]];lsearch -sorted $v \"x01z9\"",
    "2", "", false, "ascii-search-2682",
  )
  check_search_case(
    "set v [lsort -ascii -nocase [list \"x9\" \"x100\" \"x000100\" \"X100\" \"x01z9\" \"x1z10\"]];lsearch -sorted -nocase $v \"x01z9\"",
    "1", "", false, "nocase-sorted-2683",
  )
  check_search_case(
    "lsearch -all -exact -dictionary [list \"x9\" \"x100\" \"x000100\" \"X100\" \"x01z9\" \"x1z10\"] \"x1z10\"",
    "5", "", false, "dictionary-search-2684",
  )
  check_search_case(
    "set v [lsort -ascii [list \"x9\" \"x100\" \"x000100\" \"X100\" \"x01z9\" \"x1z10\"]];lsearch -sorted $v \"x1z10\"",
    "4", "", false, "ascii-search-2685",
  )
  check_search_case(
    "set v [lsort -ascii -nocase [list \"x9\" \"x100\" \"x000100\" \"X100\" \"x01z9\" \"x1z10\"]];lsearch -sorted -nocase $v \"x1z10\"",
    "4", "", false, "nocase-sorted-2686",
  )
  check_search_case(
    "lsearch -all -exact -dictionary [list \"2\" \"２\" \"٢\" \"10\" \"010\"] \"2\"",
    "0", "", false, "dictionary-search-2687",
  )
  check_search_case(
    "set v [lsort -ascii [list \"2\" \"２\" \"٢\" \"10\" \"010\"]];lsearch -sorted $v \"2\"",
    "2", "", false, "ascii-search-2688",
  )
  check_search_case(
    "set v [lsort -ascii -nocase [list \"2\" \"２\" \"٢\" \"10\" \"010\"]];lsearch -sorted -nocase $v \"2\"",
    "2", "", false, "nocase-sorted-2689",
  )
  check_search_case(
    "lsearch -all -exact -dictionary [list \"2\" \"２\" \"٢\" \"10\" \"010\"] \"２\"",
    "1", "", false, "dictionary-search-2690",
  )
  check_search_case(
    "set v [lsort -ascii [list \"2\" \"２\" \"٢\" \"10\" \"010\"]];lsearch -sorted $v \"２\"",
    "4", "", false, "ascii-search-2691",
  )
  check_search_case(
    "set v [lsort -ascii -nocase [list \"2\" \"２\" \"٢\" \"10\" \"010\"]];lsearch -sorted -nocase $v \"２\"",
    "4", "", false, "nocase-sorted-2692",
  )
  check_search_case(
    "lsearch -all -exact -dictionary [list \"2\" \"２\" \"٢\" \"10\" \"010\"] \"٢\"",
    "2", "", false, "dictionary-search-2693",
  )
  check_search_case(
    "set v [lsort -ascii [list \"2\" \"２\" \"٢\" \"10\" \"010\"]];lsearch -sorted $v \"٢\"",
    "3", "", false, "ascii-search-2694",
  )
  check_search_case(
    "set v [lsort -ascii -nocase [list \"2\" \"２\" \"٢\" \"10\" \"010\"]];lsearch -sorted -nocase $v \"٢\"",
    "3", "", false, "nocase-sorted-2695",
  )
  check_search_case(
    "lsearch -all -exact -dictionary [list \"2\" \"２\" \"٢\" \"10\" \"010\"] \"10\"",
    "3", "", false, "dictionary-search-2696",
  )
  check_search_case(
    "set v [lsort -ascii [list \"2\" \"２\" \"٢\" \"10\" \"010\"]];lsearch -sorted $v \"10\"",
    "1", "", false, "ascii-search-2697",
  )
  check_search_case(
    "set v [lsort -ascii -nocase [list \"2\" \"２\" \"٢\" \"10\" \"010\"]];lsearch -sorted -nocase $v \"10\"",
    "1", "", false, "nocase-sorted-2698",
  )
  check_search_case(
    "lsearch -all -exact -dictionary [list \"2\" \"２\" \"٢\" \"10\" \"010\"] \"010\"",
    "4", "", false, "dictionary-search-2699",
  )
  check_search_case(
    "set v [lsort -ascii [list \"2\" \"２\" \"٢\" \"10\" \"010\"]];lsearch -sorted $v \"010\"",
    "0", "", false, "ascii-search-2700",
  )
  check_search_case(
    "set v [lsort -ascii -nocase [list \"2\" \"２\" \"٢\" \"10\" \"010\"]];lsearch -sorted -nocase $v \"010\"",
    "0", "", false, "nocase-sorted-2701",
  )
  check_search_case(
    "lsearch -all -exact -dictionary [list \"x9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999\" \"x10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000\" \"x0001\" \"X1\"] \"x9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999\"",
    "0", "", false, "dictionary-search-2702",
  )
  check_search_case(
    "set v [lsort -ascii [list \"x9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999\" \"x10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000\" \"x0001\" \"X1\"]];lsearch -sorted $v \"x9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999\"",
    "3", "", false, "ascii-search-2703",
  )
  check_search_case(
    "set v [lsort -ascii -nocase [list \"x9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999\" \"x10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000\" \"x0001\" \"X1\"]];lsearch -sorted -nocase $v \"x9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999\"",
    "3", "", false, "nocase-sorted-2704",
  )
  check_search_case(
    "lsearch -all -exact -dictionary [list \"x9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999\" \"x10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000\" \"x0001\" \"X1\"] \"x10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000\"",
    "1", "", false, "dictionary-search-2705",
  )
  check_search_case(
    "set v [lsort -ascii [list \"x9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999\" \"x10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000\" \"x0001\" \"X1\"]];lsearch -sorted $v \"x10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000\"",
    "2", "", false, "ascii-search-2706",
  )
  check_search_case(
    "set v [lsort -ascii -nocase [list \"x9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999\" \"x10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000\" \"x0001\" \"X1\"]];lsearch -sorted -nocase $v \"x10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000\"",
    "2", "", false, "nocase-sorted-2707",
  )
  check_search_case(
    "lsearch -all -exact -dictionary [list \"x9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999\" \"x10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000\" \"x0001\" \"X1\"] \"x0001\"",
    "2", "", false, "dictionary-search-2708",
  )
  check_search_case(
    "set v [lsort -ascii [list \"x9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999\" \"x10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000\" \"x0001\" \"X1\"]];lsearch -sorted $v \"x0001\"",
    "1", "", false, "ascii-search-2709",
  )
  check_search_case(
    "set v [lsort -ascii -nocase [list \"x9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999\" \"x10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000\" \"x0001\" \"X1\"]];lsearch -sorted -nocase $v \"x0001\"",
    "0", "", false, "nocase-sorted-2710",
  )
  check_search_case(
    "lsearch -all -exact -dictionary [list \"x9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999\" \"x10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000\" \"x0001\" \"X1\"] \"X1\"",
    "3", "", false, "dictionary-search-2711",
  )
  check_search_case(
    "set v [lsort -ascii [list \"x9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999\" \"x10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000\" \"x0001\" \"X1\"]];lsearch -sorted $v \"X1\"",
    "0", "", false, "ascii-search-2712",
  )
  check_search_case(
    "set v [lsort -ascii -nocase [list \"x9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999\" \"x10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000\" \"x0001\" \"X1\"]];lsearch -sorted -nocase $v \"X1\"",
    "1", "", false, "nocase-sorted-2713",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -regexp \"\"]",
    "12 A a {a\nb} {a b} aa ab a\u0000b b k K 汉字 😀", "", false, "array-regexp-2714",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -reg \"\"]",
    "12 A a {a\nb} {a b} aa ab a\u0000b b k K 汉字 😀", "", false, "array-regexp-2715",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -glob \"\"]",
    "", "", false, "array-regexp-2716",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -exact \"\"]",
    "", "", false, "array-regexp-2717",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -regexp \"a\"]",
    "a {a\nb} {a b} aa ab a\u0000b", "", false, "array-regexp-2718",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -reg \"a\"]",
    "a {a\nb} {a b} aa ab a\u0000b", "", false, "array-regexp-2719",
  )
}

///|
test "Tcl search cases 2721 through 2760" {
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -glob \"a\"]",
    "a", "", false, "array-regexp-2720",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -exact \"a\"]",
    "a", "", false, "array-regexp-2721",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -regexp \"a*\"]",
    "12 A a {a\nb} {a b} aa ab a\u0000b b k K 汉字 😀", "", false, "array-regexp-2722",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -reg \"a*\"]",
    "12 A a {a\nb} {a b} aa ab a\u0000b b k K 汉字 😀", "", false, "array-regexp-2723",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -glob \"a*\"]",
    "a {a\nb} {a b} aa ab a\u0000b", "", false, "array-regexp-2724",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -exact \"a*\"]",
    "", "", false, "array-regexp-2725",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -regexp \"^a\"]",
    "a {a\nb} {a b} aa ab a\u0000b", "", false, "array-regexp-2726",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -reg \"^a\"]",
    "a {a\nb} {a b} aa ab a\u0000b", "", false, "array-regexp-2727",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -glob \"^a\"]",
    "", "", false, "array-regexp-2728",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -exact \"^a\"]",
    "", "", false, "array-regexp-2729",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -regexp \"(a)\\\\1\"]",
    "aa", "", false, "array-regexp-2730",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -reg \"(a)\\\\1\"]",
    "aa", "", false, "array-regexp-2731",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -glob \"(a)\\\\1\"]",
    "", "", false, "array-regexp-2732",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -exact \"(a)\\\\1\"]",
    "", "", false, "array-regexp-2733",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -regexp \"(?i)a\"]",
    "A a {a\nb} {a b} aa ab a\u0000b", "", false, "array-regexp-2734",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -reg \"(?i)a\"]",
    "A a {a\nb} {a b} aa ab a\u0000b", "", false, "array-regexp-2735",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -glob \"(?i)a\"]",
    "", "", false, "array-regexp-2736",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -exact \"(?i)a\"]",
    "", "", false, "array-regexp-2737",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -regexp \"(?n)^b\"]",
    "{a\nb} b", "", false, "array-regexp-2738",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -reg \"(?n)^b\"]",
    "{a\nb} b", "", false, "array-regexp-2739",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -glob \"(?n)^b\"]",
    "", "", false, "array-regexp-2740",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -exact \"(?n)^b\"]",
    "", "", false, "array-regexp-2741",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -regexp \"\\[0-9\\]+\"]",
    "12", "", false, "array-regexp-2742",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -reg \"\\[0-9\\]+\"]",
    "12", "", false, "array-regexp-2743",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -glob \"\\[0-9\\]+\"]",
    "", "", false, "array-regexp-2744",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -exact \"\\[0-9\\]+\"]",
    "", "", false, "array-regexp-2745",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -regexp \"汉\"]",
    "汉字", "", false, "array-regexp-2746",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -reg \"汉\"]",
    "汉字", "", false, "array-regexp-2747",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -glob \"汉\"]",
    "", "", false, "array-regexp-2748",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -exact \"汉\"]",
    "", "", false, "array-regexp-2749",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -regexp \"\\x00\"]",
    "a\u0000b", "", false, "array-regexp-2750",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -reg \"\\x00\"]",
    "a\u0000b", "", false, "array-regexp-2751",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -glob \"\\x00\"]",
    "", "", false, "array-regexp-2752",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -exact \"\\x00\"]",
    "", "", false, "array-regexp-2753",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -regexp \"😀\"]",
    "😀", "", false, "array-regexp-2754",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -reg \"😀\"]",
    "😀", "", false, "array-regexp-2755",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -glob \"😀\"]",
    "😀", "", false, "array-regexp-2756",
  )
  check_search_case(
    "array set a [list \"a\" \"value\" \"ab\" \"value\" \"aa\" \"value\" \"A\" \"value\" \"b\" \"value\" \"12\" \"value\" \"a b\" \"value\" \"a\\nb\" \"value\" \"汉字\" \"value\" \"K\" \"value\" \"k\" \"value\" \"😀\" \"value\" \"a\\x00b\" \"value\"];lsort [array names a -exact \"😀\"]",
    "😀", "", false, "array-regexp-2757",
  )
  check_search_case(
    "set code [catch {;array names a -regexp {(}} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} {}", "", false, "array-validation-2758",
  )
  check_search_case(
    "set code [catch {;array names a -reg {(}} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} {}", "", false, "array-validation-2759",
  )
}

///|
test "Tcl search cases 2761 through 2800" {
  check_search_case(
    "set code [catch {;array names a -bad a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {bad option \"-bad\": must be -exact, -glob, or -regexp} {TCL LOOKUP INDEX option -bad}",
    "", false, "array-validation-2760",
  )
  check_search_case(
    "set code [catch {;array names a - a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {ambiguous option \"-\": must be -exact, -glob, or -regexp} {TCL LOOKUP INDEX option -}",
    "", false, "array-validation-2761",
  )
  check_search_case(
    "set code [catch {;array names a -regexp {}} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} {}", "", false, "array-validation-2762",
  )
  check_search_case(
    "set code [catch {set a scalar;array names a -regexp {(}} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} {}", "", false, "array-validation-2763",
  )
  check_search_case(
    "set code [catch {set a scalar;array names a -reg {(}} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} {}", "", false, "array-validation-2764",
  )
  check_search_case(
    "set code [catch {set a scalar;array names a -bad a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {bad option \"-bad\": must be -exact, -glob, or -regexp} {TCL LOOKUP INDEX option -bad}",
    "", false, "array-validation-2765",
  )
  check_search_case(
    "set code [catch {set a scalar;array names a - a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {ambiguous option \"-\": must be -exact, -glob, or -regexp} {TCL LOOKUP INDEX option -}",
    "", false, "array-validation-2766",
  )
  check_search_case(
    "set code [catch {set a scalar;array names a -regexp {}} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} {}", "", false, "array-validation-2767",
  )
  check_search_case(
    "set code [catch {array set a {};array names a -regexp {(}} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} {}", "", false, "array-validation-2768",
  )
  check_search_case(
    "set code [catch {array set a {};array names a -reg {(}} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} {}", "", false, "array-validation-2769",
  )
  check_search_case(
    "set code [catch {array set a {};array names a -bad a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {bad option \"-bad\": must be -exact, -glob, or -regexp} {TCL LOOKUP INDEX option -bad}",
    "", false, "array-validation-2770",
  )
  check_search_case(
    "set code [catch {array set a {};array names a - a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {ambiguous option \"-\": must be -exact, -glob, or -regexp} {TCL LOOKUP INDEX option -}",
    "", false, "array-validation-2771",
  )
  check_search_case(
    "set code [catch {array set a {};array names a -regexp {}} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} {}", "", false, "array-validation-2772",
  )
  check_search_case(
    "set code [catch {array set a {x 1};array names a -regexp {(}} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {couldn't compile regular expression pattern: parentheses () not balanced} {REGEXP REG_EPAREN {parentheses () not balanced}}",
    "", false, "array-validation-2773",
  )
  check_search_case(
    "set code [catch {array set a {x 1};array names a -reg {(}} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {couldn't compile regular expression pattern: parentheses () not balanced} {REGEXP REG_EPAREN {parentheses () not balanced}}",
    "", false, "array-validation-2774",
  )
  check_search_case(
    "set code [catch {array set a {x 1};array names a -bad a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {bad option \"-bad\": must be -exact, -glob, or -regexp} {TCL LOOKUP INDEX option -bad}",
    "", false, "array-validation-2775",
  )
  check_search_case(
    "set code [catch {array set a {x 1};array names a - a} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {ambiguous option \"-\": must be -exact, -glob, or -regexp} {TCL LOOKUP INDEX option -}",
    "", false, "array-validation-2776",
  )
  check_search_case(
    "set code [catch {array set a {x 1};array names a -regexp {}} r o];list $code $r [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 x {}", "", false, "array-validation-2777",
  )
  check_search_case(
    "namespace eval n {variable a;array set a {a1 x a2 y b3 z}};proc f {} {upvar #0 n::a v;lsort [array names v -regexp {^a}]} ;f",
    "a1 a2", "", false, "dispatch-scope-2778",
  )
  check_search_case(
    "rename lsearch find;find -regexp -all {a b aa} {a+}", "0 2", "", false, "dispatch-scope-2779",
  )
  check_search_case(
    "set cmd lsearch;set option -reg;$cmd $option {b aa c} {a+}", "1", "", false,
    "dispatch-scope-2780",
  )
  check_search_case(
    "lsort -dictionary -index 1 {{first a10} {second a2} {third a01} {fourth a1}}",
    "{fourth a1} {third a01} {second a2} {first a10}", "", false, "dispatch-scope-2781",
  )
  check_search_case(
    "puts [lsearch -all -regexp {a b aa} a];puts [lsort -dictionary {a10 a2 a1}];set done yes",
    "yes", "0 2\na1 a2 a10\n", false, "dispatch-scope-2782",
  )
  check_search_case(
    "set v 😀;set r [lsearch -regexp  [list $v] \"\"];list $r [llength $v]", "0 1",
    "", false, "regexp-fast-representation-2783",
  )
  check_search_case(
    "set v 😀;set r [lsearch -regexp -nocase [list $v] \"\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2784",
  )
  check_search_case(
    "set v [list 😀];set r [lsearch -regexp  [list $v] \"\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2785",
  )
  check_search_case(
    "set v [list 😀];set r [lsearch -regexp -nocase [list $v] \"\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2786",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;set r [lsearch -regexp  [list $v] \"\"];list $r [format %.17g $v]",
    "0 1.8446744073709552e+19", "", false, "regexp-fast-representation-2787",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;set r [lsearch -regexp -nocase [list $v] \"\"];list $r [format %.17g $v]",
    "0 1.8446744073709552e+19", "", false, "regexp-fast-representation-2788",
  )
  check_search_case(
    "set v [list 1];set r [lsearch -regexp  [list $v] \"\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2789",
  )
  check_search_case(
    "set v [list 1];set r [lsearch -regexp -nocase [list $v] \"\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2790",
  )
  check_search_case(
    "set v 😀;set r [lsearch -regexp  [list $v] \".\"];list $r [llength $v]", "0 1",
    "", false, "regexp-fast-representation-2791",
  )
  check_search_case(
    "set v 😀;set r [lsearch -regexp -nocase [list $v] \".\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2792",
  )
  check_search_case(
    "set v [list 😀];set r [lsearch -regexp  [list $v] \".\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2793",
  )
  check_search_case(
    "set v [list 😀];set r [lsearch -regexp -nocase [list $v] \".\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2794",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;set r [lsearch -regexp  [list $v] \".\"];list $r [format %.17g $v]",
    "0 1.8446744073709552e+19", "", false, "regexp-fast-representation-2795",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;set r [lsearch -regexp -nocase [list $v] \".\"];list $r [format %.17g $v]",
    "0 1.8446744073709552e+19", "", false, "regexp-fast-representation-2796",
  )
  check_search_case(
    "set v [list 1];set r [lsearch -regexp  [list $v] \".\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2797",
  )
  check_search_case(
    "set v [list 1];set r [lsearch -regexp -nocase [list $v] \".\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2798",
  )
  check_search_case(
    "set v 😀;set r [lsearch -regexp  [list $v] \".*\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2799",
  )
}

///|
test "Tcl search cases 2801 through 2840" {
  check_search_case(
    "set v 😀;set r [lsearch -regexp -nocase [list $v] \".*\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2800",
  )
  check_search_case(
    "set v [list 😀];set r [lsearch -regexp  [list $v] \".*\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2801",
  )
  check_search_case(
    "set v [list 😀];set r [lsearch -regexp -nocase [list $v] \".*\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2802",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;set r [lsearch -regexp  [list $v] \".*\"];list $r [format %.17g $v]",
    "0 1.8446744073709552e+19", "", false, "regexp-fast-representation-2803",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;set r [lsearch -regexp -nocase [list $v] \".*\"];list $r [format %.17g $v]",
    "0 1.8446744073709552e+19", "", false, "regexp-fast-representation-2804",
  )
  check_search_case(
    "set v [list 1];set r [lsearch -regexp  [list $v] \".*\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2805",
  )
  check_search_case(
    "set v [list 1];set r [lsearch -regexp -nocase [list $v] \".*\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2806",
  )
  check_search_case(
    "set v 😀;set r [lsearch -regexp  [list $v] \".+\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2807",
  )
  check_search_case(
    "set v 😀;set r [lsearch -regexp -nocase [list $v] \".+\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2808",
  )
  check_search_case(
    "set v [list 😀];set r [lsearch -regexp  [list $v] \".+\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2809",
  )
  check_search_case(
    "set v [list 😀];set r [lsearch -regexp -nocase [list $v] \".+\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2810",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;set r [lsearch -regexp  [list $v] \".+\"];list $r [format %.17g $v]",
    "0 1.8446744073709552e+19", "", false, "regexp-fast-representation-2811",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;set r [lsearch -regexp -nocase [list $v] \".+\"];list $r [format %.17g $v]",
    "0 1.8446744073709552e+19", "", false, "regexp-fast-representation-2812",
  )
  check_search_case(
    "set v [list 1];set r [lsearch -regexp  [list $v] \".+\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2813",
  )
  check_search_case(
    "set v [list 1];set r [lsearch -regexp -nocase [list $v] \".+\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2814",
  )
  check_search_case(
    "set v 😀;set r [lsearch -regexp  [list $v] \"^.\\$\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2815",
  )
  check_search_case(
    "set v 😀;set r [lsearch -regexp -nocase [list $v] \"^.\\$\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2816",
  )
  check_search_case(
    "set v [list 😀];set r [lsearch -regexp  [list $v] \"^.\\$\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2817",
  )
  check_search_case(
    "set v [list 😀];set r [lsearch -regexp -nocase [list $v] \"^.\\$\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2818",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;set r [lsearch -regexp  [list $v] \"^.\\$\"];list $r [format %.17g $v]",
    "-1 1.8446744073709552e+19", "", false, "regexp-fast-representation-2819",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;set r [lsearch -regexp -nocase [list $v] \"^.\\$\"];list $r [format %.17g $v]",
    "-1 1.8446744073709552e+19", "", false, "regexp-fast-representation-2820",
  )
  check_search_case(
    "set v [list 1];set r [lsearch -regexp  [list $v] \"^.\\$\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2821",
  )
  check_search_case(
    "set v [list 1];set r [lsearch -regexp -nocase [list $v] \"^.\\$\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2822",
  )
  check_search_case(
    "set v 😀;set r [lsearch -regexp  [list $v] \"^.*\\$\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2823",
  )
  check_search_case(
    "set v 😀;set r [lsearch -regexp -nocase [list $v] \"^.*\\$\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2824",
  )
  check_search_case(
    "set v [list 😀];set r [lsearch -regexp  [list $v] \"^.*\\$\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2825",
  )
  check_search_case(
    "set v [list 😀];set r [lsearch -regexp -nocase [list $v] \"^.*\\$\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2826",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;set r [lsearch -regexp  [list $v] \"^.*\\$\"];list $r [format %.17g $v]",
    "0 1.8446744073709552e+19", "", false, "regexp-fast-representation-2827",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;set r [lsearch -regexp -nocase [list $v] \"^.*\\$\"];list $r [format %.17g $v]",
    "0 1.8446744073709552e+19", "", false, "regexp-fast-representation-2828",
  )
  check_search_case(
    "set v [list 1];set r [lsearch -regexp  [list $v] \"^.*\\$\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2829",
  )
  check_search_case(
    "set v [list 1];set r [lsearch -regexp -nocase [list $v] \"^.*\\$\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2830",
  )
  check_search_case(
    "set v 😀;set r [lsearch -regexp  [list $v] \"a.*b\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2831",
  )
  check_search_case(
    "set v 😀;set r [lsearch -regexp -nocase [list $v] \"a.*b\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2832",
  )
  check_search_case(
    "set v [list 😀];set r [lsearch -regexp  [list $v] \"a.*b\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2833",
  )
  check_search_case(
    "set v [list 😀];set r [lsearch -regexp -nocase [list $v] \"a.*b\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2834",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;set r [lsearch -regexp  [list $v] \"a.*b\"];list $r [format %.17g $v]",
    "-1 1.8446744073709552e+19", "", false, "regexp-fast-representation-2835",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;set r [lsearch -regexp -nocase [list $v] \"a.*b\"];list $r [format %.17g $v]",
    "-1 1.8446744073709552e+19", "", false, "regexp-fast-representation-2836",
  )
  check_search_case(
    "set v [list 1];set r [lsearch -regexp  [list $v] \"a.*b\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2837",
  )
  check_search_case(
    "set v [list 1];set r [lsearch -regexp -nocase [list $v] \"a.*b\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2838",
  )
  check_search_case(
    "set v 😀;set r [lsearch -regexp  [list $v] \"a.*b.*c\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2839",
  )
}

///|
test "Tcl search cases 2841 through 2880" {
  check_search_case(
    "set v 😀;set r [lsearch -regexp -nocase [list $v] \"a.*b.*c\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2840",
  )
  check_search_case(
    "set v [list 😀];set r [lsearch -regexp  [list $v] \"a.*b.*c\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2841",
  )
  check_search_case(
    "set v [list 😀];set r [lsearch -regexp -nocase [list $v] \"a.*b.*c\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2842",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;set r [lsearch -regexp  [list $v] \"a.*b.*c\"];list $r [format %.17g $v]",
    "-1 1.844674407370955e+19", "", false, "regexp-fast-representation-2843",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;set r [lsearch -regexp -nocase [list $v] \"a.*b.*c\"];list $r [format %.17g $v]",
    "-1 1.844674407370955e+19", "", false, "regexp-fast-representation-2844",
  )
  check_search_case(
    "set v [list 1];set r [lsearch -regexp  [list $v] \"a.*b.*c\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2845",
  )
  check_search_case(
    "set v [list 1];set r [lsearch -regexp -nocase [list $v] \"a.*b.*c\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2846",
  )
  check_search_case(
    "set v 😀;set r [lsearch -regexp  [list $v] \".*a.*\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2847",
  )
  check_search_case(
    "set v 😀;set r [lsearch -regexp -nocase [list $v] \".*a.*\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2848",
  )
  check_search_case(
    "set v [list 😀];set r [lsearch -regexp  [list $v] \".*a.*\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2849",
  )
  check_search_case(
    "set v [list 😀];set r [lsearch -regexp -nocase [list $v] \".*a.*\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2850",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;set r [lsearch -regexp  [list $v] \".*a.*\"];list $r [format %.17g $v]",
    "-1 1.8446744073709552e+19", "", false, "regexp-fast-representation-2851",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;set r [lsearch -regexp -nocase [list $v] \".*a.*\"];list $r [format %.17g $v]",
    "-1 1.8446744073709552e+19", "", false, "regexp-fast-representation-2852",
  )
  check_search_case(
    "set v [list 1];set r [lsearch -regexp  [list $v] \".*a.*\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2853",
  )
  check_search_case(
    "set v [list 1];set r [lsearch -regexp -nocase [list $v] \".*a.*\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2854",
  )
  check_search_case(
    "set v 😀;set r [lsearch -regexp  [list $v] \"(.)\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2855",
  )
  check_search_case(
    "set v 😀;set r [lsearch -regexp -nocase [list $v] \"(.)\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2856",
  )
  check_search_case(
    "set v [list 😀];set r [lsearch -regexp  [list $v] \"(.)\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2857",
  )
  check_search_case(
    "set v [list 😀];set r [lsearch -regexp -nocase [list $v] \"(.)\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2858",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;set r [lsearch -regexp  [list $v] \"(.)\"];list $r [format %.17g $v]",
    "0 1.844674407370955e+19", "", false, "regexp-fast-representation-2859",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;set r [lsearch -regexp -nocase [list $v] \"(.)\"];list $r [format %.17g $v]",
    "0 1.844674407370955e+19", "", false, "regexp-fast-representation-2860",
  )
  check_search_case(
    "set v [list 1];set r [lsearch -regexp  [list $v] \"(.)\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2861",
  )
  check_search_case(
    "set v [list 1];set r [lsearch -regexp -nocase [list $v] \"(.)\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2862",
  )
  check_search_case(
    "set v 😀;set r [lsearch -regexp  [list $v] \"(?i).\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2863",
  )
  check_search_case(
    "set v 😀;set r [lsearch -regexp -nocase [list $v] \"(?i).\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2864",
  )
  check_search_case(
    "set v [list 😀];set r [lsearch -regexp  [list $v] \"(?i).\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2865",
  )
  check_search_case(
    "set v [list 😀];set r [lsearch -regexp -nocase [list $v] \"(?i).\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2866",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;set r [lsearch -regexp  [list $v] \"(?i).\"];list $r [format %.17g $v]",
    "0 1.844674407370955e+19", "", false, "regexp-fast-representation-2867",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;set r [lsearch -regexp -nocase [list $v] \"(?i).\"];list $r [format %.17g $v]",
    "0 1.844674407370955e+19", "", false, "regexp-fast-representation-2868",
  )
  check_search_case(
    "set v [list 1];set r [lsearch -regexp  [list $v] \"(?i).\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2869",
  )
  check_search_case(
    "set v [list 1];set r [lsearch -regexp -nocase [list $v] \"(?i).\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2870",
  )
  check_search_case(
    "set v 😀;set r [lsearch -regexp  [list $v] \"\\[a-z\\]\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2871",
  )
  check_search_case(
    "set v 😀;set r [lsearch -regexp -nocase [list $v] \"\\[a-z\\]\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2872",
  )
  check_search_case(
    "set v [list 😀];set r [lsearch -regexp  [list $v] \"\\[a-z\\]\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2873",
  )
  check_search_case(
    "set v [list 😀];set r [lsearch -regexp -nocase [list $v] \"\\[a-z\\]\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2874",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;set r [lsearch -regexp  [list $v] \"\\[a-z\\]\"];list $r [format %.17g $v]",
    "0 1.844674407370955e+19", "", false, "regexp-fast-representation-2875",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;set r [lsearch -regexp -nocase [list $v] \"\\[a-z\\]\"];list $r [format %.17g $v]",
    "0 1.844674407370955e+19", "", false, "regexp-fast-representation-2876",
  )
  check_search_case(
    "set v [list 1];set r [lsearch -regexp  [list $v] \"\\[a-z\\]\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2877",
  )
  check_search_case(
    "set v [list 1];set r [lsearch -regexp -nocase [list $v] \"\\[a-z\\]\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2878",
  )
  check_search_case(
    "set v 😀;set r [lsearch -regexp  [list $v] \"\\\\.\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2879",
  )
}

///|
test "Tcl search cases 2881 through 2920" {
  check_search_case(
    "set v 😀;set r [lsearch -regexp -nocase [list $v] \"\\\\.\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2880",
  )
  check_search_case(
    "set v [list 😀];set r [lsearch -regexp  [list $v] \"\\\\.\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2881",
  )
  check_search_case(
    "set v [list 😀];set r [lsearch -regexp -nocase [list $v] \"\\\\.\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2882",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;set r [lsearch -regexp  [list $v] \"\\\\.\"];list $r [format %.17g $v]",
    "0 1.8446744073709552e+19", "", false, "regexp-fast-representation-2883",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;set r [lsearch -regexp -nocase [list $v] \"\\\\.\"];list $r [format %.17g $v]",
    "0 1.8446744073709552e+19", "", false, "regexp-fast-representation-2884",
  )
  check_search_case(
    "set v [list 1];set r [lsearch -regexp  [list $v] \"\\\\.\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2885",
  )
  check_search_case(
    "set v [list 1];set r [lsearch -regexp -nocase [list $v] \"\\\\.\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2886",
  )
  check_search_case(
    "set v 😀;set r [lsearch -regexp  [list $v] \"\\\\B\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2887",
  )
  check_search_case(
    "set v 😀;set r [lsearch -regexp -nocase [list $v] \"\\\\B\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2888",
  )
  check_search_case(
    "set v [list 😀];set r [lsearch -regexp  [list $v] \"\\\\B\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2889",
  )
  check_search_case(
    "set v [list 😀];set r [lsearch -regexp -nocase [list $v] \"\\\\B\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2890",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;set r [lsearch -regexp  [list $v] \"\\\\B\"];list $r [format %.17g $v]",
    "-1 1.8446744073709552e+19", "", false, "regexp-fast-representation-2891",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;set r [lsearch -regexp -nocase [list $v] \"\\\\B\"];list $r [format %.17g $v]",
    "-1 1.8446744073709552e+19", "", false, "regexp-fast-representation-2892",
  )
  check_search_case(
    "set v [list 1];set r [lsearch -regexp  [list $v] \"\\\\B\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2893",
  )
  check_search_case(
    "set v [list 1];set r [lsearch -regexp -nocase [list $v] \"\\\\B\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2894",
  )
  check_search_case(
    "set v 😀;set r [lsearch -regexp  [list $v] \"\\\\n\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2895",
  )
  check_search_case(
    "set v 😀;set r [lsearch -regexp -nocase [list $v] \"\\\\n\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2896",
  )
  check_search_case(
    "set v [list 😀];set r [lsearch -regexp  [list $v] \"\\\\n\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2897",
  )
  check_search_case(
    "set v [list 😀];set r [lsearch -regexp -nocase [list $v] \"\\\\n\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2898",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;set r [lsearch -regexp  [list $v] \"\\\\n\"];list $r [format %.17g $v]",
    "-1 1.8446744073709552e+19", "", false, "regexp-fast-representation-2899",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;set r [lsearch -regexp -nocase [list $v] \"\\\\n\"];list $r [format %.17g $v]",
    "-1 1.8446744073709552e+19", "", false, "regexp-fast-representation-2900",
  )
  check_search_case(
    "set v [list 1];set r [lsearch -regexp  [list $v] \"\\\\n\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2901",
  )
  check_search_case(
    "set v [list 1];set r [lsearch -regexp -nocase [list $v] \"\\\\n\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2902",
  )
  check_search_case(
    "set v 😀;set r [lsearch -regexp  [list $v] \"\\\\x31\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2903",
  )
  check_search_case(
    "set v 😀;set r [lsearch -regexp -nocase [list $v] \"\\\\x31\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2904",
  )
  check_search_case(
    "set v [list 😀];set r [lsearch -regexp  [list $v] \"\\\\x31\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2905",
  )
  check_search_case(
    "set v [list 😀];set r [lsearch -regexp -nocase [list $v] \"\\\\x31\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2906",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;set r [lsearch -regexp  [list $v] \"\\\\x31\"];list $r [format %.17g $v]",
    "0 1.844674407370955e+19", "", false, "regexp-fast-representation-2907",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;set r [lsearch -regexp -nocase [list $v] \"\\\\x31\"];list $r [format %.17g $v]",
    "0 1.844674407370955e+19", "", false, "regexp-fast-representation-2908",
  )
  check_search_case(
    "set v [list 1];set r [lsearch -regexp  [list $v] \"\\\\x31\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2909",
  )
  check_search_case(
    "set v [list 1];set r [lsearch -regexp -nocase [list $v] \"\\\\x31\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2910",
  )
  check_search_case(
    "set v 😀;set r [lsearch -regexp  [list $v] \"***=.\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2911",
  )
  check_search_case(
    "set v 😀;set r [lsearch -regexp -nocase [list $v] \"***=.\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2912",
  )
  check_search_case(
    "set v [list 😀];set r [lsearch -regexp  [list $v] \"***=.\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2913",
  )
  check_search_case(
    "set v [list 😀];set r [lsearch -regexp -nocase [list $v] \"***=.\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2914",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;set r [lsearch -regexp  [list $v] \"***=.\"];list $r [format %.17g $v]",
    "0 1.8446744073709552e+19", "", false, "regexp-fast-representation-2915",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;set r [lsearch -regexp -nocase [list $v] \"***=.\"];list $r [format %.17g $v]",
    "0 1.8446744073709552e+19", "", false, "regexp-fast-representation-2916",
  )
  check_search_case(
    "set v [list 1];set r [lsearch -regexp  [list $v] \"***=.\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2917",
  )
  check_search_case(
    "set v [list 1];set r [lsearch -regexp -nocase [list $v] \"***=.\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2918",
  )
  check_search_case(
    "set v 😀;set r [lsearch -regexp  [list $v] \"^1\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2919",
  )
}

///|
test "Tcl search cases 2921 through 2960" {
  check_search_case(
    "set v 😀;set r [lsearch -regexp -nocase [list $v] \"^1\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2920",
  )
  check_search_case(
    "set v [list 😀];set r [lsearch -regexp  [list $v] \"^1\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2921",
  )
  check_search_case(
    "set v [list 😀];set r [lsearch -regexp -nocase [list $v] \"^1\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2922",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;set r [lsearch -regexp  [list $v] \"^1\"];list $r [format %.17g $v]",
    "0 1.8446744073709552e+19", "", false, "regexp-fast-representation-2923",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;set r [lsearch -regexp -nocase [list $v] \"^1\"];list $r [format %.17g $v]",
    "0 1.8446744073709552e+19", "", false, "regexp-fast-representation-2924",
  )
  check_search_case(
    "set v [list 1];set r [lsearch -regexp  [list $v] \"^1\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2925",
  )
  check_search_case(
    "set v [list 1];set r [lsearch -regexp -nocase [list $v] \"^1\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2926",
  )
  check_search_case(
    "set v 😀;set r [lsearch -regexp  [list $v] \"1\\$\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2927",
  )
  check_search_case(
    "set v 😀;set r [lsearch -regexp -nocase [list $v] \"1\\$\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2928",
  )
  check_search_case(
    "set v [list 😀];set r [lsearch -regexp  [list $v] \"1\\$\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2929",
  )
  check_search_case(
    "set v [list 😀];set r [lsearch -regexp -nocase [list $v] \"1\\$\"];list $r [llength $v]",
    "-1 1", "", false, "regexp-fast-representation-2930",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;set r [lsearch -regexp  [list $v] \"1\\$\"];list $r [format %.17g $v]",
    "-1 1.8446744073709552e+19", "", false, "regexp-fast-representation-2931",
  )
  check_search_case(
    "scan 18446744073709551616 %f v;set r [lsearch -regexp -nocase [list $v] \"1\\$\"];list $r [format %.17g $v]",
    "-1 1.8446744073709552e+19", "", false, "regexp-fast-representation-2932",
  )
  check_search_case(
    "set v [list 1];set r [lsearch -regexp  [list $v] \"1\\$\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2933",
  )
  check_search_case(
    "set v [list 1];set r [lsearch -regexp -nocase [list $v] \"1\\$\"];list $r [llength $v]",
    "0 1", "", false, "regexp-fast-representation-2934",
  )
  check_search_case(
    "lsort -dictionary  [list \"Ǆ\" \"ǅ\" \"ǆ\" \"K\" \"K\"]", "K K Ǆ ǅ ǆ",
    "", false, "dictionary-equivalence-2935",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"Ǆ\" \"ǅ\" \"ǆ\" \"K\" \"K\"]", "K ǆ",
    "", false, "dictionary-equivalence-2936",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"Ǆ\" \"ǅ\" \"ǆ\" \"K\" \"K\"]",
    "ǆ K", "", false, "dictionary-equivalence-2937",
  )
  check_search_case(
    "lsort -dictionary  [list \"Ǆ\" \"ǅ\" \"ǆ\" \"K\" \"K\"]", "K K Ǆ ǅ ǆ",
    "", false, "dictionary-equivalence-2938",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"Ǆ\" \"ǅ\" \"ǆ\" \"K\" \"K\"]", "K ǆ",
    "", false, "dictionary-equivalence-2939",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"Ǆ\" \"ǅ\" \"ǆ\" \"K\" \"K\"]",
    "ǆ K", "", false, "dictionary-equivalence-2940",
  )
  check_search_case(
    "lsort -dictionary  [list \"Ǆ\" \"ǅ\" \"K\" \"ǆ\" \"K\"]", "K K Ǆ ǅ ǆ",
    "", false, "dictionary-equivalence-2941",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"Ǆ\" \"ǅ\" \"K\" \"ǆ\" \"K\"]", "K ǆ",
    "", false, "dictionary-equivalence-2942",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"Ǆ\" \"ǅ\" \"K\" \"ǆ\" \"K\"]",
    "ǆ K", "", false, "dictionary-equivalence-2943",
  )
  check_search_case(
    "lsort -dictionary  [list \"Ǆ\" \"ǅ\" \"K\" \"K\" \"ǆ\"]", "K K Ǆ ǅ ǆ",
    "", false, "dictionary-equivalence-2944",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"Ǆ\" \"ǅ\" \"K\" \"K\" \"ǆ\"]", "K ǆ",
    "", false, "dictionary-equivalence-2945",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"Ǆ\" \"ǅ\" \"K\" \"K\" \"ǆ\"]",
    "ǆ K", "", false, "dictionary-equivalence-2946",
  )
  check_search_case(
    "lsort -dictionary  [list \"Ǆ\" \"ǅ\" \"K\" \"ǆ\" \"K\"]", "K K Ǆ ǅ ǆ",
    "", false, "dictionary-equivalence-2947",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"Ǆ\" \"ǅ\" \"K\" \"ǆ\" \"K\"]", "K ǆ",
    "", false, "dictionary-equivalence-2948",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"Ǆ\" \"ǅ\" \"K\" \"ǆ\" \"K\"]",
    "ǆ K", "", false, "dictionary-equivalence-2949",
  )
  check_search_case(
    "lsort -dictionary  [list \"Ǆ\" \"ǅ\" \"K\" \"K\" \"ǆ\"]", "K K Ǆ ǅ ǆ",
    "", false, "dictionary-equivalence-2950",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"Ǆ\" \"ǅ\" \"K\" \"K\" \"ǆ\"]", "K ǆ",
    "", false, "dictionary-equivalence-2951",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"Ǆ\" \"ǅ\" \"K\" \"K\" \"ǆ\"]",
    "ǆ K", "", false, "dictionary-equivalence-2952",
  )
  check_search_case(
    "lsort -dictionary  [list \"Ǆ\" \"ǆ\" \"ǅ\" \"K\" \"K\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-2953",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"Ǆ\" \"ǆ\" \"ǅ\" \"K\" \"K\"]", "K ǅ ǆ",
    "", false, "dictionary-equivalence-2954",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"Ǆ\" \"ǆ\" \"ǅ\" \"K\" \"K\"]",
    "ǅ Ǆ K", "", false, "dictionary-equivalence-2955",
  )
  check_search_case(
    "lsort -dictionary  [list \"Ǆ\" \"ǆ\" \"ǅ\" \"K\" \"K\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-2956",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"Ǆ\" \"ǆ\" \"ǅ\" \"K\" \"K\"]", "K ǅ ǆ",
    "", false, "dictionary-equivalence-2957",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"Ǆ\" \"ǆ\" \"ǅ\" \"K\" \"K\"]",
    "ǅ Ǆ K", "", false, "dictionary-equivalence-2958",
  )
  check_search_case(
    "lsort -dictionary  [list \"Ǆ\" \"ǆ\" \"K\" \"ǅ\" \"K\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-2959",
  )
}

///|
test "Tcl search cases 2961 through 3000" {
  check_search_case(
    "lsort -dictionary -unique [list \"Ǆ\" \"ǆ\" \"K\" \"ǅ\" \"K\"]", "K ǅ ǆ",
    "", false, "dictionary-equivalence-2960",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"Ǆ\" \"ǆ\" \"K\" \"ǅ\" \"K\"]",
    "ǅ Ǆ K", "", false, "dictionary-equivalence-2961",
  )
  check_search_case(
    "lsort -dictionary  [list \"Ǆ\" \"ǆ\" \"K\" \"K\" \"ǅ\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-2962",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"Ǆ\" \"ǆ\" \"K\" \"K\" \"ǅ\"]", "K ǅ ǆ",
    "", false, "dictionary-equivalence-2963",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"Ǆ\" \"ǆ\" \"K\" \"K\" \"ǅ\"]",
    "ǅ Ǆ K", "", false, "dictionary-equivalence-2964",
  )
  check_search_case(
    "lsort -dictionary  [list \"Ǆ\" \"ǆ\" \"K\" \"ǅ\" \"K\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-2965",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"Ǆ\" \"ǆ\" \"K\" \"ǅ\" \"K\"]", "K ǅ ǆ",
    "", false, "dictionary-equivalence-2966",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"Ǆ\" \"ǆ\" \"K\" \"ǅ\" \"K\"]",
    "ǅ Ǆ K", "", false, "dictionary-equivalence-2967",
  )
  check_search_case(
    "lsort -dictionary  [list \"Ǆ\" \"ǆ\" \"K\" \"K\" \"ǅ\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-2968",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"Ǆ\" \"ǆ\" \"K\" \"K\" \"ǅ\"]", "K ǅ ǆ",
    "", false, "dictionary-equivalence-2969",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"Ǆ\" \"ǆ\" \"K\" \"K\" \"ǅ\"]",
    "ǅ Ǆ K", "", false, "dictionary-equivalence-2970",
  )
  check_search_case(
    "lsort -dictionary  [list \"Ǆ\" \"K\" \"ǅ\" \"ǆ\" \"K\"]", "K K Ǆ ǅ ǆ",
    "", false, "dictionary-equivalence-2971",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"Ǆ\" \"K\" \"ǅ\" \"ǆ\" \"K\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-2972",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"Ǆ\" \"K\" \"ǅ\" \"ǆ\" \"K\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-2973",
  )
  check_search_case(
    "lsort -dictionary  [list \"Ǆ\" \"K\" \"ǅ\" \"K\" \"ǆ\"]", "K K Ǆ ǅ ǆ",
    "", false, "dictionary-equivalence-2974",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"Ǆ\" \"K\" \"ǅ\" \"K\" \"ǆ\"]", "K ǆ",
    "", false, "dictionary-equivalence-2975",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"Ǆ\" \"K\" \"ǅ\" \"K\" \"ǆ\"]",
    "ǆ K", "", false, "dictionary-equivalence-2976",
  )
  check_search_case(
    "lsort -dictionary  [list \"Ǆ\" \"K\" \"ǆ\" \"ǅ\" \"K\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-2977",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"Ǆ\" \"K\" \"ǆ\" \"ǅ\" \"K\"]", "K ǅ",
    "", false, "dictionary-equivalence-2978",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"Ǆ\" \"K\" \"ǆ\" \"ǅ\" \"K\"]",
    "ǅ K", "", false, "dictionary-equivalence-2979",
  )
  check_search_case(
    "lsort -dictionary  [list \"Ǆ\" \"K\" \"ǆ\" \"K\" \"ǅ\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-2980",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"Ǆ\" \"K\" \"ǆ\" \"K\" \"ǅ\"]", "K ǅ ǆ",
    "", false, "dictionary-equivalence-2981",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"Ǆ\" \"K\" \"ǆ\" \"K\" \"ǅ\"]",
    "ǅ Ǆ K", "", false, "dictionary-equivalence-2982",
  )
  check_search_case(
    "lsort -dictionary  [list \"Ǆ\" \"K\" \"K\" \"ǅ\" \"ǆ\"]", "K K Ǆ ǅ ǆ",
    "", false, "dictionary-equivalence-2983",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"Ǆ\" \"K\" \"K\" \"ǅ\" \"ǆ\"]", "K ǆ",
    "", false, "dictionary-equivalence-2984",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"Ǆ\" \"K\" \"K\" \"ǅ\" \"ǆ\"]",
    "ǆ K", "", false, "dictionary-equivalence-2985",
  )
  check_search_case(
    "lsort -dictionary  [list \"Ǆ\" \"K\" \"K\" \"ǆ\" \"ǅ\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-2986",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"Ǆ\" \"K\" \"K\" \"ǆ\" \"ǅ\"]", "K ǅ ǆ",
    "", false, "dictionary-equivalence-2987",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"Ǆ\" \"K\" \"K\" \"ǆ\" \"ǅ\"]",
    "ǅ Ǆ K", "", false, "dictionary-equivalence-2988",
  )
  check_search_case(
    "lsort -dictionary  [list \"Ǆ\" \"K\" \"ǅ\" \"ǆ\" \"K\"]", "K K Ǆ ǅ ǆ",
    "", false, "dictionary-equivalence-2989",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"Ǆ\" \"K\" \"ǅ\" \"ǆ\" \"K\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-2990",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"Ǆ\" \"K\" \"ǅ\" \"ǆ\" \"K\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-2991",
  )
  check_search_case(
    "lsort -dictionary  [list \"Ǆ\" \"K\" \"ǅ\" \"K\" \"ǆ\"]", "K K Ǆ ǅ ǆ",
    "", false, "dictionary-equivalence-2992",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"Ǆ\" \"K\" \"ǅ\" \"K\" \"ǆ\"]", "K ǆ",
    "", false, "dictionary-equivalence-2993",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"Ǆ\" \"K\" \"ǅ\" \"K\" \"ǆ\"]",
    "ǆ K", "", false, "dictionary-equivalence-2994",
  )
  check_search_case(
    "lsort -dictionary  [list \"Ǆ\" \"K\" \"ǆ\" \"ǅ\" \"K\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-2995",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"Ǆ\" \"K\" \"ǆ\" \"ǅ\" \"K\"]", "K ǅ",
    "", false, "dictionary-equivalence-2996",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"Ǆ\" \"K\" \"ǆ\" \"ǅ\" \"K\"]",
    "ǅ K", "", false, "dictionary-equivalence-2997",
  )
  check_search_case(
    "lsort -dictionary  [list \"Ǆ\" \"K\" \"ǆ\" \"K\" \"ǅ\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-2998",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"Ǆ\" \"K\" \"ǆ\" \"K\" \"ǅ\"]", "K ǅ ǆ",
    "", false, "dictionary-equivalence-2999",
  )
}

///|
test "Tcl search cases 3001 through 3040" {
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"Ǆ\" \"K\" \"ǆ\" \"K\" \"ǅ\"]",
    "ǅ Ǆ K", "", false, "dictionary-equivalence-3000",
  )
  check_search_case(
    "lsort -dictionary  [list \"Ǆ\" \"K\" \"K\" \"ǅ\" \"ǆ\"]", "K K Ǆ ǅ ǆ",
    "", false, "dictionary-equivalence-3001",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"Ǆ\" \"K\" \"K\" \"ǅ\" \"ǆ\"]", "K ǆ",
    "", false, "dictionary-equivalence-3002",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"Ǆ\" \"K\" \"K\" \"ǅ\" \"ǆ\"]",
    "ǆ K", "", false, "dictionary-equivalence-3003",
  )
  check_search_case(
    "lsort -dictionary  [list \"Ǆ\" \"K\" \"K\" \"ǆ\" \"ǅ\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3004",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"Ǆ\" \"K\" \"K\" \"ǆ\" \"ǅ\"]", "K ǅ ǆ",
    "", false, "dictionary-equivalence-3005",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"Ǆ\" \"K\" \"K\" \"ǆ\" \"ǅ\"]",
    "ǅ Ǆ K", "", false, "dictionary-equivalence-3006",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǅ\" \"Ǆ\" \"ǆ\" \"K\" \"K\"]", "K K ǅ Ǆ ǆ",
    "", false, "dictionary-equivalence-3007",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǅ\" \"Ǆ\" \"ǆ\" \"K\" \"K\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3008",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǅ\" \"Ǆ\" \"ǆ\" \"K\" \"K\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3009",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǅ\" \"Ǆ\" \"ǆ\" \"K\" \"K\"]", "K K ǅ Ǆ ǆ",
    "", false, "dictionary-equivalence-3010",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǅ\" \"Ǆ\" \"ǆ\" \"K\" \"K\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3011",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǅ\" \"Ǆ\" \"ǆ\" \"K\" \"K\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3012",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǅ\" \"Ǆ\" \"K\" \"ǆ\" \"K\"]", "K K ǅ Ǆ ǆ",
    "", false, "dictionary-equivalence-3013",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǅ\" \"Ǆ\" \"K\" \"ǆ\" \"K\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3014",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǅ\" \"Ǆ\" \"K\" \"ǆ\" \"K\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3015",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǅ\" \"Ǆ\" \"K\" \"K\" \"ǆ\"]", "K K ǅ Ǆ ǆ",
    "", false, "dictionary-equivalence-3016",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǅ\" \"Ǆ\" \"K\" \"K\" \"ǆ\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3017",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǅ\" \"Ǆ\" \"K\" \"K\" \"ǆ\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3018",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǅ\" \"Ǆ\" \"K\" \"ǆ\" \"K\"]", "K K ǅ Ǆ ǆ",
    "", false, "dictionary-equivalence-3019",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǅ\" \"Ǆ\" \"K\" \"ǆ\" \"K\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3020",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǅ\" \"Ǆ\" \"K\" \"ǆ\" \"K\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3021",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǅ\" \"Ǆ\" \"K\" \"K\" \"ǆ\"]", "K K ǅ Ǆ ǆ",
    "", false, "dictionary-equivalence-3022",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǅ\" \"Ǆ\" \"K\" \"K\" \"ǆ\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3023",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǅ\" \"Ǆ\" \"K\" \"K\" \"ǆ\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3024",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǅ\" \"ǆ\" \"Ǆ\" \"K\" \"K\"]", "K K ǅ Ǆ ǆ",
    "", false, "dictionary-equivalence-3025",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǅ\" \"ǆ\" \"Ǆ\" \"K\" \"K\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3026",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǅ\" \"ǆ\" \"Ǆ\" \"K\" \"K\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3027",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǅ\" \"ǆ\" \"Ǆ\" \"K\" \"K\"]", "K K ǅ Ǆ ǆ",
    "", false, "dictionary-equivalence-3028",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǅ\" \"ǆ\" \"Ǆ\" \"K\" \"K\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3029",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǅ\" \"ǆ\" \"Ǆ\" \"K\" \"K\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3030",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǅ\" \"ǆ\" \"K\" \"Ǆ\" \"K\"]", "K K ǅ Ǆ ǆ",
    "", false, "dictionary-equivalence-3031",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǅ\" \"ǆ\" \"K\" \"Ǆ\" \"K\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3032",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǅ\" \"ǆ\" \"K\" \"Ǆ\" \"K\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3033",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǅ\" \"ǆ\" \"K\" \"K\" \"Ǆ\"]", "K K ǅ Ǆ ǆ",
    "", false, "dictionary-equivalence-3034",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǅ\" \"ǆ\" \"K\" \"K\" \"Ǆ\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3035",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǅ\" \"ǆ\" \"K\" \"K\" \"Ǆ\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3036",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǅ\" \"ǆ\" \"K\" \"Ǆ\" \"K\"]", "K K ǅ Ǆ ǆ",
    "", false, "dictionary-equivalence-3037",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǅ\" \"ǆ\" \"K\" \"Ǆ\" \"K\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3038",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǅ\" \"ǆ\" \"K\" \"Ǆ\" \"K\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3039",
  )
}

///|
test "Tcl search cases 3041 through 3080" {
  check_search_case(
    "lsort -dictionary  [list \"ǅ\" \"ǆ\" \"K\" \"K\" \"Ǆ\"]", "K K ǅ Ǆ ǆ",
    "", false, "dictionary-equivalence-3040",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǅ\" \"ǆ\" \"K\" \"K\" \"Ǆ\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3041",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǅ\" \"ǆ\" \"K\" \"K\" \"Ǆ\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3042",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǅ\" \"K\" \"Ǆ\" \"ǆ\" \"K\"]", "K K ǅ Ǆ ǆ",
    "", false, "dictionary-equivalence-3043",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǅ\" \"K\" \"Ǆ\" \"ǆ\" \"K\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3044",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǅ\" \"K\" \"Ǆ\" \"ǆ\" \"K\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3045",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǅ\" \"K\" \"Ǆ\" \"K\" \"ǆ\"]", "K K ǅ Ǆ ǆ",
    "", false, "dictionary-equivalence-3046",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǅ\" \"K\" \"Ǆ\" \"K\" \"ǆ\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3047",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǅ\" \"K\" \"Ǆ\" \"K\" \"ǆ\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3048",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǅ\" \"K\" \"ǆ\" \"Ǆ\" \"K\"]", "K K ǅ Ǆ ǆ",
    "", false, "dictionary-equivalence-3049",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǅ\" \"K\" \"ǆ\" \"Ǆ\" \"K\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3050",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǅ\" \"K\" \"ǆ\" \"Ǆ\" \"K\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3051",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǅ\" \"K\" \"ǆ\" \"K\" \"Ǆ\"]", "K K ǅ Ǆ ǆ",
    "", false, "dictionary-equivalence-3052",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǅ\" \"K\" \"ǆ\" \"K\" \"Ǆ\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3053",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǅ\" \"K\" \"ǆ\" \"K\" \"Ǆ\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3054",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǅ\" \"K\" \"K\" \"Ǆ\" \"ǆ\"]", "K K ǅ Ǆ ǆ",
    "", false, "dictionary-equivalence-3055",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǅ\" \"K\" \"K\" \"Ǆ\" \"ǆ\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3056",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǅ\" \"K\" \"K\" \"Ǆ\" \"ǆ\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3057",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǅ\" \"K\" \"K\" \"ǆ\" \"Ǆ\"]", "K K ǅ Ǆ ǆ",
    "", false, "dictionary-equivalence-3058",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǅ\" \"K\" \"K\" \"ǆ\" \"Ǆ\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3059",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǅ\" \"K\" \"K\" \"ǆ\" \"Ǆ\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3060",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǅ\" \"K\" \"Ǆ\" \"ǆ\" \"K\"]", "K K ǅ Ǆ ǆ",
    "", false, "dictionary-equivalence-3061",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǅ\" \"K\" \"Ǆ\" \"ǆ\" \"K\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3062",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǅ\" \"K\" \"Ǆ\" \"ǆ\" \"K\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3063",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǅ\" \"K\" \"Ǆ\" \"K\" \"ǆ\"]", "K K ǅ Ǆ ǆ",
    "", false, "dictionary-equivalence-3064",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǅ\" \"K\" \"Ǆ\" \"K\" \"ǆ\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3065",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǅ\" \"K\" \"Ǆ\" \"K\" \"ǆ\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3066",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǅ\" \"K\" \"ǆ\" \"Ǆ\" \"K\"]", "K K ǅ Ǆ ǆ",
    "", false, "dictionary-equivalence-3067",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǅ\" \"K\" \"ǆ\" \"Ǆ\" \"K\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3068",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǅ\" \"K\" \"ǆ\" \"Ǆ\" \"K\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3069",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǅ\" \"K\" \"ǆ\" \"K\" \"Ǆ\"]", "K K ǅ Ǆ ǆ",
    "", false, "dictionary-equivalence-3070",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǅ\" \"K\" \"ǆ\" \"K\" \"Ǆ\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3071",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǅ\" \"K\" \"ǆ\" \"K\" \"Ǆ\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3072",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǅ\" \"K\" \"K\" \"Ǆ\" \"ǆ\"]", "K K ǅ Ǆ ǆ",
    "", false, "dictionary-equivalence-3073",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǅ\" \"K\" \"K\" \"Ǆ\" \"ǆ\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3074",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǅ\" \"K\" \"K\" \"Ǆ\" \"ǆ\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3075",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǅ\" \"K\" \"K\" \"ǆ\" \"Ǆ\"]", "K K ǅ Ǆ ǆ",
    "", false, "dictionary-equivalence-3076",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǅ\" \"K\" \"K\" \"ǆ\" \"Ǆ\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3077",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǅ\" \"K\" \"K\" \"ǆ\" \"Ǆ\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3078",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǆ\" \"Ǆ\" \"ǅ\" \"K\" \"K\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3079",
  )
}

///|
test "Tcl search cases 3081 through 3120" {
  check_search_case(
    "lsort -dictionary -unique [list \"ǆ\" \"Ǆ\" \"ǅ\" \"K\" \"K\"]", "K ǅ ǆ",
    "", false, "dictionary-equivalence-3080",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǆ\" \"Ǆ\" \"ǅ\" \"K\" \"K\"]",
    "ǅ Ǆ K", "", false, "dictionary-equivalence-3081",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǆ\" \"Ǆ\" \"ǅ\" \"K\" \"K\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3082",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǆ\" \"Ǆ\" \"ǅ\" \"K\" \"K\"]", "K ǅ ǆ",
    "", false, "dictionary-equivalence-3083",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǆ\" \"Ǆ\" \"ǅ\" \"K\" \"K\"]",
    "ǅ Ǆ K", "", false, "dictionary-equivalence-3084",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǆ\" \"Ǆ\" \"K\" \"ǅ\" \"K\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3085",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǆ\" \"Ǆ\" \"K\" \"ǅ\" \"K\"]", "K ǅ ǆ",
    "", false, "dictionary-equivalence-3086",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǆ\" \"Ǆ\" \"K\" \"ǅ\" \"K\"]",
    "ǅ Ǆ K", "", false, "dictionary-equivalence-3087",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǆ\" \"Ǆ\" \"K\" \"K\" \"ǅ\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3088",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǆ\" \"Ǆ\" \"K\" \"K\" \"ǅ\"]", "K ǅ ǆ",
    "", false, "dictionary-equivalence-3089",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǆ\" \"Ǆ\" \"K\" \"K\" \"ǅ\"]",
    "ǅ Ǆ K", "", false, "dictionary-equivalence-3090",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǆ\" \"Ǆ\" \"K\" \"ǅ\" \"K\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3091",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǆ\" \"Ǆ\" \"K\" \"ǅ\" \"K\"]", "K ǅ ǆ",
    "", false, "dictionary-equivalence-3092",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǆ\" \"Ǆ\" \"K\" \"ǅ\" \"K\"]",
    "ǅ Ǆ K", "", false, "dictionary-equivalence-3093",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǆ\" \"Ǆ\" \"K\" \"K\" \"ǅ\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3094",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǆ\" \"Ǆ\" \"K\" \"K\" \"ǅ\"]", "K ǅ ǆ",
    "", false, "dictionary-equivalence-3095",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǆ\" \"Ǆ\" \"K\" \"K\" \"ǅ\"]",
    "ǅ Ǆ K", "", false, "dictionary-equivalence-3096",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǆ\" \"ǅ\" \"Ǆ\" \"K\" \"K\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3097",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǆ\" \"ǅ\" \"Ǆ\" \"K\" \"K\"]", "K Ǆ",
    "", false, "dictionary-equivalence-3098",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǆ\" \"ǅ\" \"Ǆ\" \"K\" \"K\"]",
    "Ǆ K", "", false, "dictionary-equivalence-3099",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǆ\" \"ǅ\" \"Ǆ\" \"K\" \"K\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3100",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǆ\" \"ǅ\" \"Ǆ\" \"K\" \"K\"]", "K Ǆ",
    "", false, "dictionary-equivalence-3101",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǆ\" \"ǅ\" \"Ǆ\" \"K\" \"K\"]",
    "Ǆ K", "", false, "dictionary-equivalence-3102",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǆ\" \"ǅ\" \"K\" \"Ǆ\" \"K\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3103",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǆ\" \"ǅ\" \"K\" \"Ǆ\" \"K\"]", "K Ǆ",
    "", false, "dictionary-equivalence-3104",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǆ\" \"ǅ\" \"K\" \"Ǆ\" \"K\"]",
    "Ǆ K", "", false, "dictionary-equivalence-3105",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǆ\" \"ǅ\" \"K\" \"K\" \"Ǆ\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3106",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǆ\" \"ǅ\" \"K\" \"K\" \"Ǆ\"]", "K Ǆ",
    "", false, "dictionary-equivalence-3107",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǆ\" \"ǅ\" \"K\" \"K\" \"Ǆ\"]",
    "Ǆ K", "", false, "dictionary-equivalence-3108",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǆ\" \"ǅ\" \"K\" \"Ǆ\" \"K\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3109",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǆ\" \"ǅ\" \"K\" \"Ǆ\" \"K\"]", "K Ǆ",
    "", false, "dictionary-equivalence-3110",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǆ\" \"ǅ\" \"K\" \"Ǆ\" \"K\"]",
    "Ǆ K", "", false, "dictionary-equivalence-3111",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǆ\" \"ǅ\" \"K\" \"K\" \"Ǆ\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3112",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǆ\" \"ǅ\" \"K\" \"K\" \"Ǆ\"]", "K Ǆ",
    "", false, "dictionary-equivalence-3113",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǆ\" \"ǅ\" \"K\" \"K\" \"Ǆ\"]",
    "Ǆ K", "", false, "dictionary-equivalence-3114",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǆ\" \"K\" \"Ǆ\" \"ǅ\" \"K\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3115",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǆ\" \"K\" \"Ǆ\" \"ǅ\" \"K\"]", "K ǅ",
    "", false, "dictionary-equivalence-3116",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǆ\" \"K\" \"Ǆ\" \"ǅ\" \"K\"]",
    "ǅ K", "", false, "dictionary-equivalence-3117",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǆ\" \"K\" \"Ǆ\" \"K\" \"ǅ\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3118",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǆ\" \"K\" \"Ǆ\" \"K\" \"ǅ\"]", "K ǅ ǆ",
    "", false, "dictionary-equivalence-3119",
  )
}

///|
test "Tcl search cases 3121 through 3160" {
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǆ\" \"K\" \"Ǆ\" \"K\" \"ǅ\"]",
    "ǅ Ǆ K", "", false, "dictionary-equivalence-3120",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǆ\" \"K\" \"ǅ\" \"Ǆ\" \"K\"]", "K K ǆ ǅ Ǆ",
    "", false, "dictionary-equivalence-3121",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǆ\" \"K\" \"ǅ\" \"Ǆ\" \"K\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3122",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǆ\" \"K\" \"ǅ\" \"Ǆ\" \"K\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3123",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǆ\" \"K\" \"ǅ\" \"K\" \"Ǆ\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3124",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǆ\" \"K\" \"ǅ\" \"K\" \"Ǆ\"]", "K Ǆ",
    "", false, "dictionary-equivalence-3125",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǆ\" \"K\" \"ǅ\" \"K\" \"Ǆ\"]",
    "Ǆ K", "", false, "dictionary-equivalence-3126",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǆ\" \"K\" \"K\" \"Ǆ\" \"ǅ\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3127",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǆ\" \"K\" \"K\" \"Ǆ\" \"ǅ\"]", "K ǅ ǆ",
    "", false, "dictionary-equivalence-3128",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǆ\" \"K\" \"K\" \"Ǆ\" \"ǅ\"]",
    "ǅ Ǆ K", "", false, "dictionary-equivalence-3129",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǆ\" \"K\" \"K\" \"ǅ\" \"Ǆ\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3130",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǆ\" \"K\" \"K\" \"ǅ\" \"Ǆ\"]", "K Ǆ",
    "", false, "dictionary-equivalence-3131",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǆ\" \"K\" \"K\" \"ǅ\" \"Ǆ\"]",
    "Ǆ K", "", false, "dictionary-equivalence-3132",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǆ\" \"K\" \"Ǆ\" \"ǅ\" \"K\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3133",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǆ\" \"K\" \"Ǆ\" \"ǅ\" \"K\"]", "K ǅ",
    "", false, "dictionary-equivalence-3134",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǆ\" \"K\" \"Ǆ\" \"ǅ\" \"K\"]",
    "ǅ K", "", false, "dictionary-equivalence-3135",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǆ\" \"K\" \"Ǆ\" \"K\" \"ǅ\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3136",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǆ\" \"K\" \"Ǆ\" \"K\" \"ǅ\"]", "K ǅ ǆ",
    "", false, "dictionary-equivalence-3137",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǆ\" \"K\" \"Ǆ\" \"K\" \"ǅ\"]",
    "ǅ Ǆ K", "", false, "dictionary-equivalence-3138",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǆ\" \"K\" \"ǅ\" \"Ǆ\" \"K\"]", "K K ǆ ǅ Ǆ",
    "", false, "dictionary-equivalence-3139",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǆ\" \"K\" \"ǅ\" \"Ǆ\" \"K\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3140",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǆ\" \"K\" \"ǅ\" \"Ǆ\" \"K\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3141",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǆ\" \"K\" \"ǅ\" \"K\" \"Ǆ\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3142",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǆ\" \"K\" \"ǅ\" \"K\" \"Ǆ\"]", "K Ǆ",
    "", false, "dictionary-equivalence-3143",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǆ\" \"K\" \"ǅ\" \"K\" \"Ǆ\"]",
    "Ǆ K", "", false, "dictionary-equivalence-3144",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǆ\" \"K\" \"K\" \"Ǆ\" \"ǅ\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3145",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǆ\" \"K\" \"K\" \"Ǆ\" \"ǅ\"]", "K ǅ ǆ",
    "", false, "dictionary-equivalence-3146",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǆ\" \"K\" \"K\" \"Ǆ\" \"ǅ\"]",
    "ǅ Ǆ K", "", false, "dictionary-equivalence-3147",
  )
  check_search_case(
    "lsort -dictionary  [list \"ǆ\" \"K\" \"K\" \"ǅ\" \"Ǆ\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3148",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"ǆ\" \"K\" \"K\" \"ǅ\" \"Ǆ\"]", "K Ǆ",
    "", false, "dictionary-equivalence-3149",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"ǆ\" \"K\" \"K\" \"ǅ\" \"Ǆ\"]",
    "Ǆ K", "", false, "dictionary-equivalence-3150",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"Ǆ\" \"ǅ\" \"ǆ\" \"K\"]", "K K Ǆ ǅ ǆ",
    "", false, "dictionary-equivalence-3151",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"Ǆ\" \"ǅ\" \"ǆ\" \"K\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3152",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"Ǆ\" \"ǅ\" \"ǆ\" \"K\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3153",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"Ǆ\" \"ǅ\" \"K\" \"ǆ\"]", "K K Ǆ ǅ ǆ",
    "", false, "dictionary-equivalence-3154",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"Ǆ\" \"ǅ\" \"K\" \"ǆ\"]", "K ǆ",
    "", false, "dictionary-equivalence-3155",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"Ǆ\" \"ǅ\" \"K\" \"ǆ\"]",
    "ǆ K", "", false, "dictionary-equivalence-3156",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"Ǆ\" \"ǆ\" \"ǅ\" \"K\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3157",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"Ǆ\" \"ǆ\" \"ǅ\" \"K\"]", "K ǅ",
    "", false, "dictionary-equivalence-3158",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"Ǆ\" \"ǆ\" \"ǅ\" \"K\"]",
    "ǅ K", "", false, "dictionary-equivalence-3159",
  )
}

///|
test "Tcl search cases 3161 through 3200" {
  check_search_case(
    "lsort -dictionary  [list \"K\" \"Ǆ\" \"ǆ\" \"K\" \"ǅ\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3160",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"Ǆ\" \"ǆ\" \"K\" \"ǅ\"]", "K ǅ ǆ",
    "", false, "dictionary-equivalence-3161",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"Ǆ\" \"ǆ\" \"K\" \"ǅ\"]",
    "ǅ Ǆ K", "", false, "dictionary-equivalence-3162",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"Ǆ\" \"K\" \"ǅ\" \"ǆ\"]", "K K Ǆ ǅ ǆ",
    "", false, "dictionary-equivalence-3163",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"Ǆ\" \"K\" \"ǅ\" \"ǆ\"]", "K ǆ",
    "", false, "dictionary-equivalence-3164",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"Ǆ\" \"K\" \"ǅ\" \"ǆ\"]",
    "ǆ K", "", false, "dictionary-equivalence-3165",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"Ǆ\" \"K\" \"ǆ\" \"ǅ\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3166",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"Ǆ\" \"K\" \"ǆ\" \"ǅ\"]", "K ǅ ǆ",
    "", false, "dictionary-equivalence-3167",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"Ǆ\" \"K\" \"ǆ\" \"ǅ\"]",
    "ǅ Ǆ K", "", false, "dictionary-equivalence-3168",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"ǅ\" \"Ǆ\" \"ǆ\" \"K\"]", "K K ǅ Ǆ ǆ",
    "", false, "dictionary-equivalence-3169",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"ǅ\" \"Ǆ\" \"ǆ\" \"K\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3170",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"ǅ\" \"Ǆ\" \"ǆ\" \"K\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3171",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"ǅ\" \"Ǆ\" \"K\" \"ǆ\"]", "K K ǅ Ǆ ǆ",
    "", false, "dictionary-equivalence-3172",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"ǅ\" \"Ǆ\" \"K\" \"ǆ\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3173",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"ǅ\" \"Ǆ\" \"K\" \"ǆ\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3174",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"ǅ\" \"ǆ\" \"Ǆ\" \"K\"]", "K K ǅ Ǆ ǆ",
    "", false, "dictionary-equivalence-3175",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"ǅ\" \"ǆ\" \"Ǆ\" \"K\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3176",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"ǅ\" \"ǆ\" \"Ǆ\" \"K\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3177",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"ǅ\" \"ǆ\" \"K\" \"Ǆ\"]", "K K ǅ Ǆ ǆ",
    "", false, "dictionary-equivalence-3178",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"ǅ\" \"ǆ\" \"K\" \"Ǆ\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3179",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"ǅ\" \"ǆ\" \"K\" \"Ǆ\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3180",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"ǅ\" \"K\" \"Ǆ\" \"ǆ\"]", "K K ǅ Ǆ ǆ",
    "", false, "dictionary-equivalence-3181",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"ǅ\" \"K\" \"Ǆ\" \"ǆ\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3182",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"ǅ\" \"K\" \"Ǆ\" \"ǆ\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3183",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"ǅ\" \"K\" \"ǆ\" \"Ǆ\"]", "K K ǅ Ǆ ǆ",
    "", false, "dictionary-equivalence-3184",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"ǅ\" \"K\" \"ǆ\" \"Ǆ\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3185",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"ǅ\" \"K\" \"ǆ\" \"Ǆ\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3186",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"ǆ\" \"Ǆ\" \"ǅ\" \"K\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3187",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"ǆ\" \"Ǆ\" \"ǅ\" \"K\"]", "K ǅ",
    "", false, "dictionary-equivalence-3188",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"ǆ\" \"Ǆ\" \"ǅ\" \"K\"]",
    "ǅ K", "", false, "dictionary-equivalence-3189",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"ǆ\" \"Ǆ\" \"K\" \"ǅ\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3190",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"ǆ\" \"Ǆ\" \"K\" \"ǅ\"]", "K ǅ ǆ",
    "", false, "dictionary-equivalence-3191",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"ǆ\" \"Ǆ\" \"K\" \"ǅ\"]",
    "ǅ Ǆ K", "", false, "dictionary-equivalence-3192",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"ǆ\" \"ǅ\" \"Ǆ\" \"K\"]", "K K ǆ ǅ Ǆ",
    "", false, "dictionary-equivalence-3193",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"ǆ\" \"ǅ\" \"Ǆ\" \"K\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3194",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"ǆ\" \"ǅ\" \"Ǆ\" \"K\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3195",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"ǆ\" \"ǅ\" \"K\" \"Ǆ\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3196",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"ǆ\" \"ǅ\" \"K\" \"Ǆ\"]", "K Ǆ",
    "", false, "dictionary-equivalence-3197",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"ǆ\" \"ǅ\" \"K\" \"Ǆ\"]",
    "Ǆ K", "", false, "dictionary-equivalence-3198",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"ǆ\" \"K\" \"Ǆ\" \"ǅ\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3199",
  )
}

///|
test "Tcl search cases 3201 through 3240" {
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"ǆ\" \"K\" \"Ǆ\" \"ǅ\"]", "K ǅ ǆ",
    "", false, "dictionary-equivalence-3200",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"ǆ\" \"K\" \"Ǆ\" \"ǅ\"]",
    "ǅ Ǆ K", "", false, "dictionary-equivalence-3201",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"ǆ\" \"K\" \"ǅ\" \"Ǆ\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3202",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"ǆ\" \"K\" \"ǅ\" \"Ǆ\"]", "K Ǆ",
    "", false, "dictionary-equivalence-3203",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"ǆ\" \"K\" \"ǅ\" \"Ǆ\"]",
    "Ǆ K", "", false, "dictionary-equivalence-3204",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"K\" \"Ǆ\" \"ǅ\" \"ǆ\"]", "K K Ǆ ǅ ǆ",
    "", false, "dictionary-equivalence-3205",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"K\" \"Ǆ\" \"ǅ\" \"ǆ\"]", "K ǆ",
    "", false, "dictionary-equivalence-3206",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"K\" \"Ǆ\" \"ǅ\" \"ǆ\"]",
    "ǆ K", "", false, "dictionary-equivalence-3207",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"K\" \"Ǆ\" \"ǆ\" \"ǅ\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3208",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"K\" \"Ǆ\" \"ǆ\" \"ǅ\"]", "K ǅ ǆ",
    "", false, "dictionary-equivalence-3209",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"K\" \"Ǆ\" \"ǆ\" \"ǅ\"]",
    "ǅ Ǆ K", "", false, "dictionary-equivalence-3210",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"K\" \"ǅ\" \"Ǆ\" \"ǆ\"]", "K K ǅ Ǆ ǆ",
    "", false, "dictionary-equivalence-3211",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"K\" \"ǅ\" \"Ǆ\" \"ǆ\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3212",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"K\" \"ǅ\" \"Ǆ\" \"ǆ\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3213",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"K\" \"ǅ\" \"ǆ\" \"Ǆ\"]", "K K ǅ Ǆ ǆ",
    "", false, "dictionary-equivalence-3214",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"K\" \"ǅ\" \"ǆ\" \"Ǆ\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3215",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"K\" \"ǅ\" \"ǆ\" \"Ǆ\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3216",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"K\" \"ǆ\" \"Ǆ\" \"ǅ\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3217",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"K\" \"ǆ\" \"Ǆ\" \"ǅ\"]", "K ǅ ǆ",
    "", false, "dictionary-equivalence-3218",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"K\" \"ǆ\" \"Ǆ\" \"ǅ\"]",
    "ǅ Ǆ K", "", false, "dictionary-equivalence-3219",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"K\" \"ǆ\" \"ǅ\" \"Ǆ\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3220",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"K\" \"ǆ\" \"ǅ\" \"Ǆ\"]", "K Ǆ",
    "", false, "dictionary-equivalence-3221",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"K\" \"ǆ\" \"ǅ\" \"Ǆ\"]",
    "Ǆ K", "", false, "dictionary-equivalence-3222",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"Ǆ\" \"ǅ\" \"ǆ\" \"K\"]", "K K Ǆ ǅ ǆ",
    "", false, "dictionary-equivalence-3223",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"Ǆ\" \"ǅ\" \"ǆ\" \"K\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3224",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"Ǆ\" \"ǅ\" \"ǆ\" \"K\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3225",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"Ǆ\" \"ǅ\" \"K\" \"ǆ\"]", "K K Ǆ ǅ ǆ",
    "", false, "dictionary-equivalence-3226",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"Ǆ\" \"ǅ\" \"K\" \"ǆ\"]", "K ǆ",
    "", false, "dictionary-equivalence-3227",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"Ǆ\" \"ǅ\" \"K\" \"ǆ\"]",
    "ǆ K", "", false, "dictionary-equivalence-3228",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"Ǆ\" \"ǆ\" \"ǅ\" \"K\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3229",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"Ǆ\" \"ǆ\" \"ǅ\" \"K\"]", "K ǅ",
    "", false, "dictionary-equivalence-3230",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"Ǆ\" \"ǆ\" \"ǅ\" \"K\"]",
    "ǅ K", "", false, "dictionary-equivalence-3231",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"Ǆ\" \"ǆ\" \"K\" \"ǅ\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3232",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"Ǆ\" \"ǆ\" \"K\" \"ǅ\"]", "K ǅ ǆ",
    "", false, "dictionary-equivalence-3233",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"Ǆ\" \"ǆ\" \"K\" \"ǅ\"]",
    "ǅ Ǆ K", "", false, "dictionary-equivalence-3234",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"Ǆ\" \"K\" \"ǅ\" \"ǆ\"]", "K K Ǆ ǅ ǆ",
    "", false, "dictionary-equivalence-3235",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"Ǆ\" \"K\" \"ǅ\" \"ǆ\"]", "K ǆ",
    "", false, "dictionary-equivalence-3236",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"Ǆ\" \"K\" \"ǅ\" \"ǆ\"]",
    "ǆ K", "", false, "dictionary-equivalence-3237",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"Ǆ\" \"K\" \"ǆ\" \"ǅ\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3238",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"Ǆ\" \"K\" \"ǆ\" \"ǅ\"]", "K ǅ ǆ",
    "", false, "dictionary-equivalence-3239",
  )
}

///|
test "Tcl search cases 3241 through 3280" {
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"Ǆ\" \"K\" \"ǆ\" \"ǅ\"]",
    "ǅ Ǆ K", "", false, "dictionary-equivalence-3240",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"ǅ\" \"Ǆ\" \"ǆ\" \"K\"]", "K K ǅ Ǆ ǆ",
    "", false, "dictionary-equivalence-3241",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"ǅ\" \"Ǆ\" \"ǆ\" \"K\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3242",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"ǅ\" \"Ǆ\" \"ǆ\" \"K\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3243",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"ǅ\" \"Ǆ\" \"K\" \"ǆ\"]", "K K ǅ Ǆ ǆ",
    "", false, "dictionary-equivalence-3244",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"ǅ\" \"Ǆ\" \"K\" \"ǆ\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3245",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"ǅ\" \"Ǆ\" \"K\" \"ǆ\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3246",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"ǅ\" \"ǆ\" \"Ǆ\" \"K\"]", "K K ǅ Ǆ ǆ",
    "", false, "dictionary-equivalence-3247",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"ǅ\" \"ǆ\" \"Ǆ\" \"K\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3248",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"ǅ\" \"ǆ\" \"Ǆ\" \"K\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3249",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"ǅ\" \"ǆ\" \"K\" \"Ǆ\"]", "K K ǅ Ǆ ǆ",
    "", false, "dictionary-equivalence-3250",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"ǅ\" \"ǆ\" \"K\" \"Ǆ\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3251",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"ǅ\" \"ǆ\" \"K\" \"Ǆ\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3252",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"ǅ\" \"K\" \"Ǆ\" \"ǆ\"]", "K K ǅ Ǆ ǆ",
    "", false, "dictionary-equivalence-3253",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"ǅ\" \"K\" \"Ǆ\" \"ǆ\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3254",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"ǅ\" \"K\" \"Ǆ\" \"ǆ\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3255",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"ǅ\" \"K\" \"ǆ\" \"Ǆ\"]", "K K ǅ Ǆ ǆ",
    "", false, "dictionary-equivalence-3256",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"ǅ\" \"K\" \"ǆ\" \"Ǆ\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3257",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"ǅ\" \"K\" \"ǆ\" \"Ǆ\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3258",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"ǆ\" \"Ǆ\" \"ǅ\" \"K\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3259",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"ǆ\" \"Ǆ\" \"ǅ\" \"K\"]", "K ǅ",
    "", false, "dictionary-equivalence-3260",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"ǆ\" \"Ǆ\" \"ǅ\" \"K\"]",
    "ǅ K", "", false, "dictionary-equivalence-3261",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"ǆ\" \"Ǆ\" \"K\" \"ǅ\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3262",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"ǆ\" \"Ǆ\" \"K\" \"ǅ\"]", "K ǅ ǆ",
    "", false, "dictionary-equivalence-3263",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"ǆ\" \"Ǆ\" \"K\" \"ǅ\"]",
    "ǅ Ǆ K", "", false, "dictionary-equivalence-3264",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"ǆ\" \"ǅ\" \"Ǆ\" \"K\"]", "K K ǆ ǅ Ǆ",
    "", false, "dictionary-equivalence-3265",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"ǆ\" \"ǅ\" \"Ǆ\" \"K\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3266",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"ǆ\" \"ǅ\" \"Ǆ\" \"K\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3267",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"ǆ\" \"ǅ\" \"K\" \"Ǆ\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3268",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"ǆ\" \"ǅ\" \"K\" \"Ǆ\"]", "K Ǆ",
    "", false, "dictionary-equivalence-3269",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"ǆ\" \"ǅ\" \"K\" \"Ǆ\"]",
    "Ǆ K", "", false, "dictionary-equivalence-3270",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"ǆ\" \"K\" \"Ǆ\" \"ǅ\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3271",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"ǆ\" \"K\" \"Ǆ\" \"ǅ\"]", "K ǅ ǆ",
    "", false, "dictionary-equivalence-3272",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"ǆ\" \"K\" \"Ǆ\" \"ǅ\"]",
    "ǅ Ǆ K", "", false, "dictionary-equivalence-3273",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"ǆ\" \"K\" \"ǅ\" \"Ǆ\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3274",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"ǆ\" \"K\" \"ǅ\" \"Ǆ\"]", "K Ǆ",
    "", false, "dictionary-equivalence-3275",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"ǆ\" \"K\" \"ǅ\" \"Ǆ\"]",
    "Ǆ K", "", false, "dictionary-equivalence-3276",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"K\" \"Ǆ\" \"ǅ\" \"ǆ\"]", "K K Ǆ ǅ ǆ",
    "", false, "dictionary-equivalence-3277",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"K\" \"Ǆ\" \"ǅ\" \"ǆ\"]", "K ǆ",
    "", false, "dictionary-equivalence-3278",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"K\" \"Ǆ\" \"ǅ\" \"ǆ\"]",
    "ǆ K", "", false, "dictionary-equivalence-3279",
  )
}

///|
test "Tcl search cases 3281 through 3307" {
  check_search_case(
    "lsort -dictionary  [list \"K\" \"K\" \"Ǆ\" \"ǆ\" \"ǅ\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3280",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"K\" \"Ǆ\" \"ǆ\" \"ǅ\"]", "K ǅ ǆ",
    "", false, "dictionary-equivalence-3281",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"K\" \"Ǆ\" \"ǆ\" \"ǅ\"]",
    "ǅ Ǆ K", "", false, "dictionary-equivalence-3282",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"K\" \"ǅ\" \"Ǆ\" \"ǆ\"]", "K K ǅ Ǆ ǆ",
    "", false, "dictionary-equivalence-3283",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"K\" \"ǅ\" \"Ǆ\" \"ǆ\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3284",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"K\" \"ǅ\" \"Ǆ\" \"ǆ\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3285",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"K\" \"ǅ\" \"ǆ\" \"Ǆ\"]", "K K ǅ Ǆ ǆ",
    "", false, "dictionary-equivalence-3286",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"K\" \"ǅ\" \"ǆ\" \"Ǆ\"]", "K Ǆ ǆ",
    "", false, "dictionary-equivalence-3287",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"K\" \"ǅ\" \"ǆ\" \"Ǆ\"]",
    "ǆ Ǆ K", "", false, "dictionary-equivalence-3288",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"K\" \"ǆ\" \"Ǆ\" \"ǅ\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3289",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"K\" \"ǆ\" \"Ǆ\" \"ǅ\"]", "K ǅ ǆ",
    "", false, "dictionary-equivalence-3290",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"K\" \"ǆ\" \"Ǆ\" \"ǅ\"]",
    "ǅ Ǆ K", "", false, "dictionary-equivalence-3291",
  )
  check_search_case(
    "lsort -dictionary  [list \"K\" \"K\" \"ǆ\" \"ǅ\" \"Ǆ\"]", "K K Ǆ ǆ ǅ",
    "", false, "dictionary-equivalence-3292",
  )
  check_search_case(
    "lsort -dictionary -unique [list \"K\" \"K\" \"ǆ\" \"ǅ\" \"Ǆ\"]", "K Ǆ",
    "", false, "dictionary-equivalence-3293",
  )
  check_search_case(
    "lsort -dictionary -decreasing -unique [list \"K\" \"K\" \"ǆ\" \"ǅ\" \"Ǆ\"]",
    "Ǆ K", "", false, "dictionary-equivalence-3294",
  )
  check_search_case(
    "lsearch -all -glob [list \"😀\" \"🙏\" \"x😀x\" \"\"] \"?\"", "0 1 3",
    "", false, "glob-codepoints-3295",
  )
  check_search_case(
    "array set a [list \"😀\" \"1\" \"🙏\" \"2\" \"x😀x\" \"3\" \"\" \"4\"];lsort [array names a \"?\"]",
    " 😀 🙏", "", false, "array-glob-codepoints-3296",
  )
  check_search_case(
    "lsearch -all -glob [list \"😀\" \"🙏\" \"x😀x\" \"\"] \"??\"", "",
    "", false, "glob-codepoints-3297",
  )
  check_search_case(
    "array set a [list \"😀\" \"1\" \"🙏\" \"2\" \"x😀x\" \"3\" \"\" \"4\"];lsort [array names a \"??\"]",
    "", "", false, "array-glob-codepoints-3298",
  )
  check_search_case(
    "lsearch -all -glob [list \"😀\" \"🙏\" \"x😀x\" \"\"] \"\\[😀\\]\"",
    "0", "", false, "glob-codepoints-3299",
  )
  check_search_case(
    "array set a [list \"😀\" \"1\" \"🙏\" \"2\" \"x😀x\" \"3\" \"\" \"4\"];lsort [array names a \"\\[😀\\]\"]",
    "😀", "", false, "array-glob-codepoints-3300",
  )
  check_search_case(
    "lsearch -all -glob [list \"😀\" \"🙏\" \"x😀x\" \"\"] \"\\[😀-🙏\\]\"",
    "0 1", "", false, "glob-codepoints-3301",
  )
  check_search_case(
    "array set a [list \"😀\" \"1\" \"🙏\" \"2\" \"x😀x\" \"3\" \"\" \"4\"];lsort [array names a \"\\[😀-🙏\\]\"]",
    "😀 🙏", "", false, "array-glob-codepoints-3302",
  )
  check_search_case(
    "lsearch -all -glob [list \"😀\" \"🙏\" \"x😀x\" \"\"] \"\\[🙏-😀\\]\"",
    "0 1", "", false, "glob-codepoints-3303",
  )
  check_search_case(
    "array set a [list \"😀\" \"1\" \"🙏\" \"2\" \"x😀x\" \"3\" \"\" \"4\"];lsort [array names a \"\\[🙏-😀\\]\"]",
    "😀 🙏", "", false, "array-glob-codepoints-3304",
  )
  check_search_case(
    "lsearch -all -glob [list \"😀\" \"🙏\" \"x😀x\" \"\"] \"*😀*\"",
    "0 2", "", false, "glob-codepoints-3305",
  )
  check_search_case(
    "array set a [list \"😀\" \"1\" \"🙏\" \"2\" \"x😀x\" \"3\" \"\" \"4\"];lsort [array names a \"*😀*\"]",
    "x😀x 😀", "", false, "array-glob-codepoints-3306",
  )
}
