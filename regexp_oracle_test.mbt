// Original programs, expected results evaluated by Tcl 8.6.15. Do not hand-edit.

///|
fn check_regexp_case(
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
test "Tcl regexp cases 1 through 40" {
  check_regexp_case(
    "regexp  -inline -indices -- \"\" \"\"", "{0 -1}", "", false, "search-0",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\" \"\"", "{0 -1}", "", false, "search-1",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\" \"a\"", "{0 -1}", "", false, "search-2",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\" \"a\"", "{0 -1}", "", false, "search-3",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\" \"b\"", "{0 -1}", "", false, "search-4",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\" \"b\"", "{0 -1}", "", false, "search-5",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\" \"ab\"", "{0 -1}", "", false, "search-6",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\" \"ab\"", "{0 -1} {1 0}", "", false, "search-7",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\" \"aba\"", "{0 -1}", "", false, "search-8",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\" \"aba\"", "{0 -1} {1 0} {2 1}", "", false,
    "search-9",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\" \"aaab\"", "{0 -1}", "", false, "search-10",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\" \"aaab\"", "{0 -1} {1 0} {2 1} {3 2}",
    "", false, "search-11",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\" \"xaba\"", "{0 -1}", "", false, "search-12",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\" \"xaba\"", "{0 -1} {1 0} {2 1} {3 2}",
    "", false, "search-13",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\" \"a\\nb\"", "{0 -1}", "", false, "search-14",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\" \"a\\nb\"", "{0 -1} {1 0} {2 1}", "", false,
    "search-15",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\" \"\\na\"", "{0 -1}", "", false, "search-16",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\" \"\\na\"", "{0 -1} {1 0}", "", false, "search-17",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\" \"a\\n\"", "{0 -1}", "", false, "search-18",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\" \"a\\n\"", "{0 -1} {1 0}", "", false, "search-19",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\" \"A B\"", "{0 -1}", "", false, "search-20",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\" \"A B\"", "{0 -1} {1 0} {2 1}", "", false,
    "search-21",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\" \"abc 12\"", "{0 -1}", "", false, "search-22",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\" \"abc 12\"", "{0 -1} {1 0} {2 1} {3 2} {4 3} {5 4}",
    "", false, "search-23",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\" \"姹夊瓧\"", "{0 -1}", "", false, "search-24",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\" \"姹夊瓧\"", "{0 -1} {1 0} {2 1}", "",
    false, "search-25",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\" \"馃榾a\"", "{0 -1}", "", false, "search-26",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\" \"馃榾a\"", "{0 -1} {1 0} {2 1}", "",
    false, "search-27",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\" \"a\\x00b\"", "{0 -1}", "", false, "search-28",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\" \"a\\x00b\"", "{0 -1} {1 0} {2 1}", "",
    false, "search-29",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\" \"\"", "", "", false, "search-30",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\" \"\"", "", "", false, "search-31",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\" \"a\"", "{0 0}", "", false, "search-32",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\" \"a\"", "{0 0}", "", false, "search-33",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\" \"b\"", "", "", false, "search-34",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\" \"b\"", "", "", false, "search-35",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\" \"ab\"", "{0 0}", "", false, "search-36",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\" \"ab\"", "{0 0}", "", false, "search-37",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\" \"aba\"", "{0 0}", "", false, "search-38",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\" \"aba\"", "{0 0} {2 2}", "", false, "search-39",
  )
}

///|
test "Tcl regexp cases 41 through 80" {
  check_regexp_case(
    "regexp  -inline -indices -- \"a\" \"aaab\"", "{0 0}", "", false, "search-40",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\" \"aaab\"", "{0 0} {1 1} {2 2}", "", false,
    "search-41",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\" \"xaba\"", "{1 1}", "", false, "search-42",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\" \"xaba\"", "{1 1} {3 3}", "", false, "search-43",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\" \"a\\nb\"", "{0 0}", "", false, "search-44",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\" \"a\\nb\"", "{0 0}", "", false, "search-45",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\" \"\\na\"", "{1 1}", "", false, "search-46",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\" \"\\na\"", "{1 1}", "", false, "search-47",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\" \"a\\n\"", "{0 0}", "", false, "search-48",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\" \"a\\n\"", "{0 0}", "", false, "search-49",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\" \"A B\"", "", "", false, "search-50",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\" \"A B\"", "", "", false, "search-51",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\" \"abc 12\"", "{0 0}", "", false, "search-52",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\" \"abc 12\"", "{0 0}", "", false, "search-53",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\" \"姹夊瓧\"", "", "", false, "search-54",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\" \"姹夊瓧\"", "", "", false, "search-55",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\" \"馃榾a\"", "{2 2}", "", false, "search-56",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\" \"馃榾a\"", "{2 2}", "", false, "search-57",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\" \"a\\x00b\"", "{0 0}", "", false, "search-58",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\" \"a\\x00b\"", "{0 0}", "", false, "search-59",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a*\" \"\"", "{0 -1}", "", false, "search-60",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a*\" \"\"", "{0 -1}", "", false, "search-61",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a*\" \"a\"", "{0 0}", "", false, "search-62",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a*\" \"a\"", "{0 0}", "", false, "search-63",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a*\" \"b\"", "{0 -1}", "", false, "search-64",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a*\" \"b\"", "{0 -1}", "", false, "search-65",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a*\" \"ab\"", "{0 0}", "", false, "search-66",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a*\" \"ab\"", "{0 0} {1 0}", "", false, "search-67",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a*\" \"aba\"", "{0 0}", "", false, "search-68",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a*\" \"aba\"", "{0 0} {1 0} {2 2}", "", false,
    "search-69",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a*\" \"aaab\"", "{0 2}", "", false, "search-70",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a*\" \"aaab\"", "{0 2} {3 2}", "", false,
    "search-71",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a*\" \"xaba\"", "{0 -1}", "", false, "search-72",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a*\" \"xaba\"", "{0 -1} {1 1} {2 1} {3 3}",
    "", false, "search-73",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a*\" \"a\\nb\"", "{0 0}", "", false, "search-74",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a*\" \"a\\nb\"", "{0 0} {1 0} {2 1}", "",
    false, "search-75",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a*\" \"\\na\"", "{0 -1}", "", false, "search-76",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a*\" \"\\na\"", "{0 -1} {1 1}", "", false,
    "search-77",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a*\" \"a\\n\"", "{0 0}", "", false, "search-78",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a*\" \"a\\n\"", "{0 0} {1 0}", "", false,
    "search-79",
  )
}

///|
test "Tcl regexp cases 81 through 120" {
  check_regexp_case(
    "regexp  -inline -indices -- \"a*\" \"A B\"", "{0 -1}", "", false, "search-80",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a*\" \"A B\"", "{0 -1} {1 0} {2 1}", "", false,
    "search-81",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a*\" \"abc 12\"", "{0 0}", "", false, "search-82",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a*\" \"abc 12\"", "{0 0} {1 0} {2 1} {3 2} {4 3} {5 4}",
    "", false, "search-83",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a*\" \"姹夊瓧\"", "{0 -1}", "", false, "search-84",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a*\" \"姹夊瓧\"", "{0 -1} {1 0} {2 1}",
    "", false, "search-85",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a*\" \"馃榾a\"", "{0 -1}", "", false, "search-86",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a*\" \"馃榾a\"", "{0 -1} {1 0} {2 2}", "",
    false, "search-87",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a*\" \"a\\x00b\"", "{0 0}", "", false, "search-88",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a*\" \"a\\x00b\"", "{0 0} {1 0} {2 1}", "",
    false, "search-89",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a+\" \"\"", "", "", false, "search-90",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a+\" \"\"", "", "", false, "search-91",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a+\" \"a\"", "{0 0}", "", false, "search-92",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a+\" \"a\"", "{0 0}", "", false, "search-93",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a+\" \"b\"", "", "", false, "search-94",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a+\" \"b\"", "", "", false, "search-95",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a+\" \"ab\"", "{0 0}", "", false, "search-96",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a+\" \"ab\"", "{0 0}", "", false, "search-97",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a+\" \"aba\"", "{0 0}", "", false, "search-98",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a+\" \"aba\"", "{0 0} {2 2}", "", false, "search-99",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a+\" \"aaab\"", "{0 2}", "", false, "search-100",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a+\" \"aaab\"", "{0 2}", "", false, "search-101",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a+\" \"xaba\"", "{1 1}", "", false, "search-102",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a+\" \"xaba\"", "{1 1} {3 3}", "", false,
    "search-103",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a+\" \"a\\nb\"", "{0 0}", "", false, "search-104",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a+\" \"a\\nb\"", "{0 0}", "", false, "search-105",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a+\" \"\\na\"", "{1 1}", "", false, "search-106",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a+\" \"\\na\"", "{1 1}", "", false, "search-107",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a+\" \"a\\n\"", "{0 0}", "", false, "search-108",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a+\" \"a\\n\"", "{0 0}", "", false, "search-109",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a+\" \"A B\"", "", "", false, "search-110",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a+\" \"A B\"", "", "", false, "search-111",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a+\" \"abc 12\"", "{0 0}", "", false, "search-112",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a+\" \"abc 12\"", "{0 0}", "", false, "search-113",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a+\" \"姹夊瓧\"", "", "", false, "search-114",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a+\" \"姹夊瓧\"", "", "", false, "search-115",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a+\" \"馃榾a\"", "{2 2}", "", false, "search-116",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a+\" \"馃榾a\"", "{2 2}", "", false, "search-117",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a+\" \"a\\x00b\"", "{0 0}", "", false, "search-118",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a+\" \"a\\x00b\"", "{0 0}", "", false, "search-119",
  )
}

///|
test "Tcl regexp cases 121 through 160" {
  check_regexp_case(
    "regexp  -inline -indices -- \"a?\" \"\"", "{0 -1}", "", false, "search-120",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a?\" \"\"", "{0 -1}", "", false, "search-121",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a?\" \"a\"", "{0 0}", "", false, "search-122",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a?\" \"a\"", "{0 0}", "", false, "search-123",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a?\" \"b\"", "{0 -1}", "", false, "search-124",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a?\" \"b\"", "{0 -1}", "", false, "search-125",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a?\" \"ab\"", "{0 0}", "", false, "search-126",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a?\" \"ab\"", "{0 0} {1 0}", "", false, "search-127",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a?\" \"aba\"", "{0 0}", "", false, "search-128",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a?\" \"aba\"", "{0 0} {1 0} {2 2}", "", false,
    "search-129",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a?\" \"aaab\"", "{0 0}", "", false, "search-130",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a?\" \"aaab\"", "{0 0} {1 1} {2 2} {3 2}",
    "", false, "search-131",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a?\" \"xaba\"", "{0 -1}", "", false, "search-132",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a?\" \"xaba\"", "{0 -1} {1 1} {2 1} {3 3}",
    "", false, "search-133",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a?\" \"a\\nb\"", "{0 0}", "", false, "search-134",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a?\" \"a\\nb\"", "{0 0} {1 0} {2 1}", "",
    false, "search-135",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a?\" \"\\na\"", "{0 -1}", "", false, "search-136",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a?\" \"\\na\"", "{0 -1} {1 1}", "", false,
    "search-137",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a?\" \"a\\n\"", "{0 0}", "", false, "search-138",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a?\" \"a\\n\"", "{0 0} {1 0}", "", false,
    "search-139",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a?\" \"A B\"", "{0 -1}", "", false, "search-140",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a?\" \"A B\"", "{0 -1} {1 0} {2 1}", "", false,
    "search-141",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a?\" \"abc 12\"", "{0 0}", "", false, "search-142",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a?\" \"abc 12\"", "{0 0} {1 0} {2 1} {3 2} {4 3} {5 4}",
    "", false, "search-143",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a?\" \"姹夊瓧\"", "{0 -1}", "", false, "search-144",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a?\" \"姹夊瓧\"", "{0 -1} {1 0} {2 1}",
    "", false, "search-145",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a?\" \"馃榾a\"", "{0 -1}", "", false, "search-146",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a?\" \"馃榾a\"", "{0 -1} {1 0} {2 2}", "",
    false, "search-147",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a?\" \"a\\x00b\"", "{0 0}", "", false, "search-148",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a?\" \"a\\x00b\"", "{0 0} {1 0} {2 1}", "",
    false, "search-149",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a*?\" \"\"", "{0 -1}", "", false, "search-150",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a*?\" \"\"", "{0 -1}", "", false, "search-151",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a*?\" \"a\"", "{0 -1}", "", false, "search-152",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a*?\" \"a\"", "{0 -1}", "", false, "search-153",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a*?\" \"b\"", "{0 -1}", "", false, "search-154",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a*?\" \"b\"", "{0 -1}", "", false, "search-155",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a*?\" \"ab\"", "{0 -1}", "", false, "search-156",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a*?\" \"ab\"", "{0 -1} {1 0}", "", false,
    "search-157",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a*?\" \"aba\"", "{0 -1}", "", false, "search-158",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a*?\" \"aba\"", "{0 -1} {1 0} {2 1}", "",
    false, "search-159",
  )
}

///|
test "Tcl regexp cases 161 through 200" {
  check_regexp_case(
    "regexp  -inline -indices -- \"a*?\" \"aaab\"", "{0 -1}", "", false, "search-160",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a*?\" \"aaab\"", "{0 -1} {1 0} {2 1} {3 2}",
    "", false, "search-161",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a*?\" \"xaba\"", "{0 -1}", "", false, "search-162",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a*?\" \"xaba\"", "{0 -1} {1 0} {2 1} {3 2}",
    "", false, "search-163",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a*?\" \"a\\nb\"", "{0 -1}", "", false, "search-164",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a*?\" \"a\\nb\"", "{0 -1} {1 0} {2 1}", "",
    false, "search-165",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a*?\" \"\\na\"", "{0 -1}", "", false, "search-166",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a*?\" \"\\na\"", "{0 -1} {1 0}", "", false,
    "search-167",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a*?\" \"a\\n\"", "{0 -1}", "", false, "search-168",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a*?\" \"a\\n\"", "{0 -1} {1 0}", "", false,
    "search-169",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a*?\" \"A B\"", "{0 -1}", "", false, "search-170",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a*?\" \"A B\"", "{0 -1} {1 0} {2 1}", "",
    false, "search-171",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a*?\" \"abc 12\"", "{0 -1}", "", false, "search-172",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a*?\" \"abc 12\"", "{0 -1} {1 0} {2 1} {3 2} {4 3} {5 4}",
    "", false, "search-173",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a*?\" \"姹夊瓧\"", "{0 -1}", "", false, "search-174",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a*?\" \"姹夊瓧\"", "{0 -1} {1 0} {2 1}",
    "", false, "search-175",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a*?\" \"馃榾a\"", "{0 -1}", "", false, "search-176",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a*?\" \"馃榾a\"", "{0 -1} {1 0} {2 1}",
    "", false, "search-177",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a*?\" \"a\\x00b\"", "{0 -1}", "", false, "search-178",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a*?\" \"a\\x00b\"", "{0 -1} {1 0} {2 1}",
    "", false, "search-179",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a+?\" \"\"", "", "", false, "search-180",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a+?\" \"\"", "", "", false, "search-181",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a+?\" \"a\"", "{0 0}", "", false, "search-182",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a+?\" \"a\"", "{0 0}", "", false, "search-183",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a+?\" \"b\"", "", "", false, "search-184",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a+?\" \"b\"", "", "", false, "search-185",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a+?\" \"ab\"", "{0 0}", "", false, "search-186",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a+?\" \"ab\"", "{0 0}", "", false, "search-187",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a+?\" \"aba\"", "{0 0}", "", false, "search-188",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a+?\" \"aba\"", "{0 0} {2 2}", "", false,
    "search-189",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a+?\" \"aaab\"", "{0 0}", "", false, "search-190",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a+?\" \"aaab\"", "{0 0} {1 1} {2 2}", "",
    false, "search-191",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a+?\" \"xaba\"", "{1 1}", "", false, "search-192",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a+?\" \"xaba\"", "{1 1} {3 3}", "", false,
    "search-193",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a+?\" \"a\\nb\"", "{0 0}", "", false, "search-194",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a+?\" \"a\\nb\"", "{0 0}", "", false, "search-195",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a+?\" \"\\na\"", "{1 1}", "", false, "search-196",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a+?\" \"\\na\"", "{1 1}", "", false, "search-197",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a+?\" \"a\\n\"", "{0 0}", "", false, "search-198",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a+?\" \"a\\n\"", "{0 0}", "", false, "search-199",
  )
}

///|
test "Tcl regexp cases 201 through 240" {
  check_regexp_case(
    "regexp  -inline -indices -- \"a+?\" \"A B\"", "", "", false, "search-200",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a+?\" \"A B\"", "", "", false, "search-201",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a+?\" \"abc 12\"", "{0 0}", "", false, "search-202",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a+?\" \"abc 12\"", "{0 0}", "", false, "search-203",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a+?\" \"姹夊瓧\"", "", "", false, "search-204",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a+?\" \"姹夊瓧\"", "", "", false, "search-205",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a+?\" \"馃榾a\"", "{2 2}", "", false, "search-206",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a+?\" \"馃榾a\"", "{2 2}", "", false, "search-207",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a+?\" \"a\\x00b\"", "{0 0}", "", false, "search-208",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a+?\" \"a\\x00b\"", "{0 0}", "", false, "search-209",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a??\" \"\"", "{0 -1}", "", false, "search-210",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a??\" \"\"", "{0 -1}", "", false, "search-211",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a??\" \"a\"", "{0 -1}", "", false, "search-212",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a??\" \"a\"", "{0 -1}", "", false, "search-213",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a??\" \"b\"", "{0 -1}", "", false, "search-214",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a??\" \"b\"", "{0 -1}", "", false, "search-215",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a??\" \"ab\"", "{0 -1}", "", false, "search-216",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a??\" \"ab\"", "{0 -1} {1 0}", "", false,
    "search-217",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a??\" \"aba\"", "{0 -1}", "", false, "search-218",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a??\" \"aba\"", "{0 -1} {1 0} {2 1}", "",
    false, "search-219",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a??\" \"aaab\"", "{0 -1}", "", false, "search-220",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a??\" \"aaab\"", "{0 -1} {1 0} {2 1} {3 2}",
    "", false, "search-221",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a??\" \"xaba\"", "{0 -1}", "", false, "search-222",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a??\" \"xaba\"", "{0 -1} {1 0} {2 1} {3 2}",
    "", false, "search-223",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a??\" \"a\\nb\"", "{0 -1}", "", false, "search-224",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a??\" \"a\\nb\"", "{0 -1} {1 0} {2 1}", "",
    false, "search-225",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a??\" \"\\na\"", "{0 -1}", "", false, "search-226",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a??\" \"\\na\"", "{0 -1} {1 0}", "", false,
    "search-227",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a??\" \"a\\n\"", "{0 -1}", "", false, "search-228",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a??\" \"a\\n\"", "{0 -1} {1 0}", "", false,
    "search-229",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a??\" \"A B\"", "{0 -1}", "", false, "search-230",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a??\" \"A B\"", "{0 -1} {1 0} {2 1}", "",
    false, "search-231",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a??\" \"abc 12\"", "{0 -1}", "", false, "search-232",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a??\" \"abc 12\"", "{0 -1} {1 0} {2 1} {3 2} {4 3} {5 4}",
    "", false, "search-233",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a??\" \"姹夊瓧\"", "{0 -1}", "", false, "search-234",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a??\" \"姹夊瓧\"", "{0 -1} {1 0} {2 1}",
    "", false, "search-235",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a??\" \"馃榾a\"", "{0 -1}", "", false, "search-236",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a??\" \"馃榾a\"", "{0 -1} {1 0} {2 1}",
    "", false, "search-237",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a??\" \"a\\x00b\"", "{0 -1}", "", false, "search-238",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a??\" \"a\\x00b\"", "{0 -1} {1 0} {2 1}",
    "", false, "search-239",
  )
}

///|
test "Tcl regexp cases 241 through 280" {
  check_regexp_case(
    "regexp  -inline -indices -- \"a{0}\" \"\"", "{0 -1}", "", false, "search-240",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{0}\" \"\"", "{0 -1}", "", false, "search-241",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a{0}\" \"a\"", "{0 -1}", "", false, "search-242",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{0}\" \"a\"", "{0 -1}", "", false, "search-243",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a{0}\" \"b\"", "{0 -1}", "", false, "search-244",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{0}\" \"b\"", "{0 -1}", "", false, "search-245",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a{0}\" \"ab\"", "{0 -1}", "", false, "search-246",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{0}\" \"ab\"", "{0 -1} {1 0}", "", false,
    "search-247",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a{0}\" \"aba\"", "{0 -1}", "", false, "search-248",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{0}\" \"aba\"", "{0 -1} {1 0} {2 1}", "",
    false, "search-249",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a{0}\" \"aaab\"", "{0 -1}", "", false, "search-250",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{0}\" \"aaab\"", "{0 -1} {1 0} {2 1} {3 2}",
    "", false, "search-251",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a{0}\" \"xaba\"", "{0 -1}", "", false, "search-252",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{0}\" \"xaba\"", "{0 -1} {1 0} {2 1} {3 2}",
    "", false, "search-253",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a{0}\" \"a\\nb\"", "{0 -1}", "", false, "search-254",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{0}\" \"a\\nb\"", "{0 -1} {1 0} {2 1}", "",
    false, "search-255",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a{0}\" \"\\na\"", "{0 -1}", "", false, "search-256",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{0}\" \"\\na\"", "{0 -1} {1 0}", "", false,
    "search-257",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a{0}\" \"a\\n\"", "{0 -1}", "", false, "search-258",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{0}\" \"a\\n\"", "{0 -1} {1 0}", "", false,
    "search-259",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a{0}\" \"A B\"", "{0 -1}", "", false, "search-260",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{0}\" \"A B\"", "{0 -1} {1 0} {2 1}", "",
    false, "search-261",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a{0}\" \"abc 12\"", "{0 -1}", "", false, "search-262",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{0}\" \"abc 12\"", "{0 -1} {1 0} {2 1} {3 2} {4 3} {5 4}",
    "", false, "search-263",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a{0}\" \"姹夊瓧\"", "{0 -1}", "", false, "search-264",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{0}\" \"姹夊瓧\"", "{0 -1} {1 0} {2 1}",
    "", false, "search-265",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a{0}\" \"馃榾a\"", "{0 -1}", "", false, "search-266",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{0}\" \"馃榾a\"", "{0 -1} {1 0} {2 1}",
    "", false, "search-267",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a{0}\" \"a\\x00b\"", "{0 -1}", "", false, "search-268",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{0}\" \"a\\x00b\"", "{0 -1} {1 0} {2 1}",
    "", false, "search-269",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a{1,2}\" \"\"", "", "", false, "search-270",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{1,2}\" \"\"", "", "", false, "search-271",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a{1,2}\" \"a\"", "{0 0}", "", false, "search-272",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{1,2}\" \"a\"", "{0 0}", "", false, "search-273",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a{1,2}\" \"b\"", "", "", false, "search-274",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{1,2}\" \"b\"", "", "", false, "search-275",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a{1,2}\" \"ab\"", "{0 0}", "", false, "search-276",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{1,2}\" \"ab\"", "{0 0}", "", false, "search-277",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a{1,2}\" \"aba\"", "{0 0}", "", false, "search-278",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{1,2}\" \"aba\"", "{0 0} {2 2}", "", false,
    "search-279",
  )
}

///|
test "Tcl regexp cases 281 through 320" {
  check_regexp_case(
    "regexp  -inline -indices -- \"a{1,2}\" \"aaab\"", "{0 1}", "", false, "search-280",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{1,2}\" \"aaab\"", "{0 1} {2 2}", "", false,
    "search-281",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a{1,2}\" \"xaba\"", "{1 1}", "", false, "search-282",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{1,2}\" \"xaba\"", "{1 1} {3 3}", "", false,
    "search-283",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a{1,2}\" \"a\\nb\"", "{0 0}", "", false, "search-284",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{1,2}\" \"a\\nb\"", "{0 0}", "", false, "search-285",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a{1,2}\" \"\\na\"", "{1 1}", "", false, "search-286",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{1,2}\" \"\\na\"", "{1 1}", "", false, "search-287",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a{1,2}\" \"a\\n\"", "{0 0}", "", false, "search-288",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{1,2}\" \"a\\n\"", "{0 0}", "", false, "search-289",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a{1,2}\" \"A B\"", "", "", false, "search-290",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{1,2}\" \"A B\"", "", "", false, "search-291",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a{1,2}\" \"abc 12\"", "{0 0}", "", false, "search-292",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{1,2}\" \"abc 12\"", "{0 0}", "", false,
    "search-293",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a{1,2}\" \"姹夊瓧\"", "", "", false, "search-294",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{1,2}\" \"姹夊瓧\"", "", "", false, "search-295",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a{1,2}\" \"馃榾a\"", "{2 2}", "", false, "search-296",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{1,2}\" \"馃榾a\"", "{2 2}", "", false,
    "search-297",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a{1,2}\" \"a\\x00b\"", "{0 0}", "", false, "search-298",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{1,2}\" \"a\\x00b\"", "{0 0}", "", false,
    "search-299",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a{1,2}?\" \"\"", "", "", false, "search-300",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{1,2}?\" \"\"", "", "", false, "search-301",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a{1,2}?\" \"a\"", "{0 0}", "", false, "search-302",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{1,2}?\" \"a\"", "{0 0}", "", false, "search-303",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a{1,2}?\" \"b\"", "", "", false, "search-304",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{1,2}?\" \"b\"", "", "", false, "search-305",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a{1,2}?\" \"ab\"", "{0 0}", "", false, "search-306",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{1,2}?\" \"ab\"", "{0 0}", "", false, "search-307",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a{1,2}?\" \"aba\"", "{0 0}", "", false, "search-308",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{1,2}?\" \"aba\"", "{0 0} {2 2}", "", false,
    "search-309",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a{1,2}?\" \"aaab\"", "{0 0}", "", false, "search-310",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{1,2}?\" \"aaab\"", "{0 0} {1 1} {2 2}",
    "", false, "search-311",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a{1,2}?\" \"xaba\"", "{1 1}", "", false, "search-312",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{1,2}?\" \"xaba\"", "{1 1} {3 3}", "", false,
    "search-313",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a{1,2}?\" \"a\\nb\"", "{0 0}", "", false, "search-314",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{1,2}?\" \"a\\nb\"", "{0 0}", "", false,
    "search-315",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a{1,2}?\" \"\\na\"", "{1 1}", "", false, "search-316",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{1,2}?\" \"\\na\"", "{1 1}", "", false, "search-317",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a{1,2}?\" \"a\\n\"", "{0 0}", "", false, "search-318",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{1,2}?\" \"a\\n\"", "{0 0}", "", false, "search-319",
  )
}

///|
test "Tcl regexp cases 321 through 360" {
  check_regexp_case(
    "regexp  -inline -indices -- \"a{1,2}?\" \"A B\"", "", "", false, "search-320",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{1,2}?\" \"A B\"", "", "", false, "search-321",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a{1,2}?\" \"abc 12\"", "{0 0}", "", false, "search-322",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{1,2}?\" \"abc 12\"", "{0 0}", "", false,
    "search-323",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a{1,2}?\" \"姹夊瓧\"", "", "", false, "search-324",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{1,2}?\" \"姹夊瓧\"", "", "", false, "search-325",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a{1,2}?\" \"馃榾a\"", "{2 2}", "", false, "search-326",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{1,2}?\" \"馃榾a\"", "{2 2}", "", false,
    "search-327",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a{1,2}?\" \"a\\x00b\"", "{0 0}", "", false, "search-328",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a{1,2}?\" \"a\\x00b\"", "{0 0}", "", false,
    "search-329",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)\" \"\"", "{0 -1} {0 -1}", "", false, "search-330",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)\" \"\"", "{0 -1} {0 -1}", "", false,
    "search-331",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)\" \"a\"", "{0 0} {0 0}", "", false, "search-332",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)\" \"a\"", "{0 0} {0 0}", "", false, "search-333",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)\" \"b\"", "{0 -1} {0 -1}", "", false, "search-334",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)\" \"b\"", "{0 -1} {0 -1}", "", false,
    "search-335",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)\" \"ab\"", "{0 0} {0 0}", "", false, "search-336",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)\" \"ab\"", "{0 0} {0 0} {1 0} {1 0}",
    "", false, "search-337",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)\" \"aba\"", "{0 0} {0 0}", "", false, "search-338",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)\" \"aba\"", "{0 0} {0 0} {1 0} {1 0} {2 2} {2 2}",
    "", false, "search-339",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)\" \"aaab\"", "{0 2} {0 2}", "", false, "search-340",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)\" \"aaab\"", "{0 2} {0 2} {3 2} {3 2}",
    "", false, "search-341",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)\" \"xaba\"", "{0 -1} {0 -1}", "", false,
    "search-342",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)\" \"xaba\"", "{0 -1} {0 -1} {1 1} {1 1} {2 1} {2 1} {3 3} {3 3}",
    "", false, "search-343",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)\" \"a\\nb\"", "{0 0} {0 0}", "", false, "search-344",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)\" \"a\\nb\"", "{0 0} {0 0} {1 0} {1 0} {2 1} {2 1}",
    "", false, "search-345",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)\" \"\\na\"", "{0 -1} {0 -1}", "", false,
    "search-346",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)\" \"\\na\"", "{0 -1} {0 -1} {1 1} {1 1}",
    "", false, "search-347",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)\" \"a\\n\"", "{0 0} {0 0}", "", false, "search-348",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)\" \"a\\n\"", "{0 0} {0 0} {1 0} {1 0}",
    "", false, "search-349",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)\" \"A B\"", "{0 -1} {0 -1}", "", false, "search-350",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)\" \"A B\"", "{0 -1} {0 -1} {1 0} {1 0} {2 1} {2 1}",
    "", false, "search-351",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)\" \"abc 12\"", "{0 0} {0 0}", "", false,
    "search-352",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)\" \"abc 12\"", "{0 0} {0 0} {1 0} {1 0} {2 1} {2 1} {3 2} {3 2} {4 3} {4 3} {5 4} {5 4}",
    "", false, "search-353",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)\" \"姹夊瓧\"", "{0 -1} {0 -1}", "", false,
    "search-354",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)\" \"姹夊瓧\"", "{0 -1} {0 -1} {1 0} {1 0} {2 1} {2 1}",
    "", false, "search-355",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)\" \"馃榾a\"", "{0 -1} {0 -1}", "", false,
    "search-356",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)\" \"馃榾a\"", "{0 -1} {0 -1} {1 0} {1 0} {2 2} {2 2}",
    "", false, "search-357",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)\" \"a\\x00b\"", "{0 0} {0 0}", "", false,
    "search-358",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)\" \"a\\x00b\"", "{0 0} {0 0} {1 0} {1 0} {2 1} {2 1}",
    "", false, "search-359",
  )
}

///|
test "Tcl regexp cases 361 through 400" {
  check_regexp_case(
    "regexp  -inline -indices -- \"(a)?(b)?\" \"\"", "{0 -1} {-1 -1} {-1 -1}", "",
    false, "search-360",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a)?(b)?\" \"\"", "{0 -1} {-1 -1} {-1 -1}",
    "", false, "search-361",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a)?(b)?\" \"a\"", "{0 0} {0 0} {-1 -1}", "",
    false, "search-362",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a)?(b)?\" \"a\"", "{0 0} {0 0} {-1 -1}",
    "", false, "search-363",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a)?(b)?\" \"b\"", "{0 0} {-1 -1} {0 0}", "",
    false, "search-364",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a)?(b)?\" \"b\"", "{0 0} {-1 -1} {0 0}",
    "", false, "search-365",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a)?(b)?\" \"ab\"", "{0 1} {0 0} {1 1}", "", false,
    "search-366",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a)?(b)?\" \"ab\"", "{0 1} {0 0} {1 1}", "",
    false, "search-367",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a)?(b)?\" \"aba\"", "{0 1} {0 0} {1 1}", "",
    false, "search-368",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a)?(b)?\" \"aba\"", "{0 1} {0 0} {1 1} {2 2} {2 2} {-1 -1}",
    "", false, "search-369",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a)?(b)?\" \"aaab\"", "{0 0} {0 0} {-1 -1}", "",
    false, "search-370",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a)?(b)?\" \"aaab\"", "{0 0} {0 0} {-1 -1} {1 1} {1 1} {-1 -1} {2 3} {2 2} {3 3}",
    "", false, "search-371",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a)?(b)?\" \"xaba\"", "{0 -1} {-1 -1} {-1 -1}",
    "", false, "search-372",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a)?(b)?\" \"xaba\"", "{0 -1} {-1 -1} {-1 -1} {1 2} {1 1} {2 2} {3 3} {3 3} {-1 -1}",
    "", false, "search-373",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a)?(b)?\" \"a\\nb\"", "{0 0} {0 0} {-1 -1}",
    "", false, "search-374",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a)?(b)?\" \"a\\nb\"", "{0 0} {0 0} {-1 -1} {1 0} {-1 -1} {-1 -1} {2 2} {-1 -1} {2 2}",
    "", false, "search-375",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a)?(b)?\" \"\\na\"", "{0 -1} {-1 -1} {-1 -1}",
    "", false, "search-376",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a)?(b)?\" \"\\na\"", "{0 -1} {-1 -1} {-1 -1} {1 1} {1 1} {-1 -1}",
    "", false, "search-377",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a)?(b)?\" \"a\\n\"", "{0 0} {0 0} {-1 -1}", "",
    false, "search-378",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a)?(b)?\" \"a\\n\"", "{0 0} {0 0} {-1 -1} {1 0} {-1 -1} {-1 -1}",
    "", false, "search-379",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a)?(b)?\" \"A B\"", "{0 -1} {-1 -1} {-1 -1}",
    "", false, "search-380",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a)?(b)?\" \"A B\"", "{0 -1} {-1 -1} {-1 -1} {1 0} {-1 -1} {-1 -1} {2 1} {-1 -1} {-1 -1}",
    "", false, "search-381",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a)?(b)?\" \"abc 12\"", "{0 1} {0 0} {1 1}", "",
    false, "search-382",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a)?(b)?\" \"abc 12\"", "{0 1} {0 0} {1 1} {2 1} {-1 -1} {-1 -1} {3 2} {-1 -1} {-1 -1} {4 3} {-1 -1} {-1 -1} {5 4} {-1 -1} {-1 -1}",
    "", false, "search-383",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a)?(b)?\" \"姹夊瓧\"", "{0 -1} {-1 -1} {-1 -1}",
    "", false, "search-384",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a)?(b)?\" \"姹夊瓧\"", "{0 -1} {-1 -1} {-1 -1} {1 0} {-1 -1} {-1 -1} {2 1} {-1 -1} {-1 -1}",
    "", false, "search-385",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a)?(b)?\" \"馃榾a\"", "{0 -1} {-1 -1} {-1 -1}",
    "", false, "search-386",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a)?(b)?\" \"馃榾a\"", "{0 -1} {-1 -1} {-1 -1} {1 0} {-1 -1} {-1 -1} {2 2} {2 2} {-1 -1}",
    "", false, "search-387",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a)?(b)?\" \"a\\x00b\"", "{0 0} {0 0} {-1 -1}",
    "", false, "search-388",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a)?(b)?\" \"a\\x00b\"", "{0 0} {0 0} {-1 -1} {1 0} {-1 -1} {-1 -1} {2 2} {-1 -1} {2 2}",
    "", false, "search-389",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a|ab)(b*)\" \"\"", "", "", false, "search-390",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a|ab)(b*)\" \"\"", "", "", false, "search-391",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a|ab)(b*)\" \"a\"", "{0 0} {0 0} {1 0}", "",
    false, "search-392",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a|ab)(b*)\" \"a\"", "{0 0} {0 0} {1 0}",
    "", false, "search-393",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a|ab)(b*)\" \"b\"", "", "", false, "search-394",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a|ab)(b*)\" \"b\"", "", "", false, "search-395",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a|ab)(b*)\" \"ab\"", "{0 1} {0 1} {2 1}", "",
    false, "search-396",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a|ab)(b*)\" \"ab\"", "{0 1} {0 1} {2 1}",
    "", false, "search-397",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a|ab)(b*)\" \"aba\"", "{0 1} {0 1} {2 1}", "",
    false, "search-398",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a|ab)(b*)\" \"aba\"", "{0 1} {0 1} {2 1} {2 2} {2 2} {3 2}",
    "", false, "search-399",
  )
}

///|
test "Tcl regexp cases 401 through 440" {
  check_regexp_case(
    "regexp  -inline -indices -- \"(a|ab)(b*)\" \"aaab\"", "{0 0} {0 0} {1 0}", "",
    false, "search-400",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a|ab)(b*)\" \"aaab\"", "{0 0} {0 0} {1 0} {1 1} {1 1} {2 1} {2 3} {2 3} {4 3}",
    "", false, "search-401",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a|ab)(b*)\" \"xaba\"", "{1 2} {1 2} {3 2}", "",
    false, "search-402",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a|ab)(b*)\" \"xaba\"", "{1 2} {1 2} {3 2} {3 3} {3 3} {4 3}",
    "", false, "search-403",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a|ab)(b*)\" \"a\\nb\"", "{0 0} {0 0} {1 0}",
    "", false, "search-404",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a|ab)(b*)\" \"a\\nb\"", "{0 0} {0 0} {1 0}",
    "", false, "search-405",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a|ab)(b*)\" \"\\na\"", "{1 1} {1 1} {2 1}", "",
    false, "search-406",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a|ab)(b*)\" \"\\na\"", "{1 1} {1 1} {2 1}",
    "", false, "search-407",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a|ab)(b*)\" \"a\\n\"", "{0 0} {0 0} {1 0}", "",
    false, "search-408",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a|ab)(b*)\" \"a\\n\"", "{0 0} {0 0} {1 0}",
    "", false, "search-409",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a|ab)(b*)\" \"A B\"", "", "", false, "search-410",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a|ab)(b*)\" \"A B\"", "", "", false, "search-411",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a|ab)(b*)\" \"abc 12\"", "{0 1} {0 1} {2 1}",
    "", false, "search-412",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a|ab)(b*)\" \"abc 12\"", "{0 1} {0 1} {2 1}",
    "", false, "search-413",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a|ab)(b*)\" \"姹夊瓧\"", "", "", false, "search-414",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a|ab)(b*)\" \"姹夊瓧\"", "", "", false,
    "search-415",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a|ab)(b*)\" \"馃榾a\"", "{2 2} {2 2} {3 2}",
    "", false, "search-416",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a|ab)(b*)\" \"馃榾a\"", "{2 2} {2 2} {3 2}",
    "", false, "search-417",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a|ab)(b*)\" \"a\\x00b\"", "{0 0} {0 0} {1 0}",
    "", false, "search-418",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a|ab)(b*)\" \"a\\x00b\"", "{0 0} {0 0} {1 0}",
    "", false, "search-419",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"((a)(b)?)\" \"\"", "", "", false, "search-420",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"((a)(b)?)\" \"\"", "", "", false, "search-421",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"((a)(b)?)\" \"a\"", "{0 0} {0 0} {0 0} {-1 -1}",
    "", false, "search-422",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"((a)(b)?)\" \"a\"", "{0 0} {0 0} {0 0} {-1 -1}",
    "", false, "search-423",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"((a)(b)?)\" \"b\"", "", "", false, "search-424",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"((a)(b)?)\" \"b\"", "", "", false, "search-425",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"((a)(b)?)\" \"ab\"", "{0 1} {0 1} {0 0} {1 1}",
    "", false, "search-426",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"((a)(b)?)\" \"ab\"", "{0 1} {0 1} {0 0} {1 1}",
    "", false, "search-427",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"((a)(b)?)\" \"aba\"", "{0 1} {0 1} {0 0} {1 1}",
    "", false, "search-428",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"((a)(b)?)\" \"aba\"", "{0 1} {0 1} {0 0} {1 1} {2 2} {2 2} {2 2} {-1 -1}",
    "", false, "search-429",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"((a)(b)?)\" \"aaab\"", "{0 0} {0 0} {0 0} {-1 -1}",
    "", false, "search-430",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"((a)(b)?)\" \"aaab\"", "{0 0} {0 0} {0 0} {-1 -1} {1 1} {1 1} {1 1} {-1 -1} {2 3} {2 3} {2 2} {3 3}",
    "", false, "search-431",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"((a)(b)?)\" \"xaba\"", "{1 2} {1 2} {1 1} {2 2}",
    "", false, "search-432",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"((a)(b)?)\" \"xaba\"", "{1 2} {1 2} {1 1} {2 2} {3 3} {3 3} {3 3} {-1 -1}",
    "", false, "search-433",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"((a)(b)?)\" \"a\\nb\"", "{0 0} {0 0} {0 0} {-1 -1}",
    "", false, "search-434",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"((a)(b)?)\" \"a\\nb\"", "{0 0} {0 0} {0 0} {-1 -1}",
    "", false, "search-435",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"((a)(b)?)\" \"\\na\"", "{1 1} {1 1} {1 1} {-1 -1}",
    "", false, "search-436",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"((a)(b)?)\" \"\\na\"", "{1 1} {1 1} {1 1} {-1 -1}",
    "", false, "search-437",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"((a)(b)?)\" \"a\\n\"", "{0 0} {0 0} {0 0} {-1 -1}",
    "", false, "search-438",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"((a)(b)?)\" \"a\\n\"", "{0 0} {0 0} {0 0} {-1 -1}",
    "", false, "search-439",
  )
}

///|
test "Tcl regexp cases 441 through 480" {
  check_regexp_case(
    "regexp  -inline -indices -- \"((a)(b)?)\" \"A B\"", "", "", false, "search-440",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"((a)(b)?)\" \"A B\"", "", "", false, "search-441",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"((a)(b)?)\" \"abc 12\"", "{0 1} {0 1} {0 0} {1 1}",
    "", false, "search-442",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"((a)(b)?)\" \"abc 12\"", "{0 1} {0 1} {0 0} {1 1}",
    "", false, "search-443",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"((a)(b)?)\" \"姹夊瓧\"", "", "", false, "search-444",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"((a)(b)?)\" \"姹夊瓧\"", "", "", false,
    "search-445",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"((a)(b)?)\" \"馃榾a\"", "{2 2} {2 2} {2 2} {-1 -1}",
    "", false, "search-446",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"((a)(b)?)\" \"馃榾a\"", "{2 2} {2 2} {2 2} {-1 -1}",
    "", false, "search-447",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"((a)(b)?)\" \"a\\x00b\"", "{0 0} {0 0} {0 0} {-1 -1}",
    "", false, "search-448",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"((a)(b)?)\" \"a\\x00b\"", "{0 0} {0 0} {0 0} {-1 -1}",
    "", false, "search-449",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)*\" \"\"", "{0 -1} {-1 -1}", "", false, "search-450",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)*\" \"\"", "{0 -1} {-1 -1}", "", false,
    "search-451",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)*\" \"a\"", "{0 0} {0 0}", "", false, "search-452",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)*\" \"a\"", "{0 0} {0 0}", "", false,
    "search-453",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)*\" \"b\"", "{0 -1} {-1 -1}", "", false, "search-454",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)*\" \"b\"", "{0 -1} {-1 -1}", "", false,
    "search-455",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)*\" \"ab\"", "{0 0} {0 0}", "", false, "search-456",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)*\" \"ab\"", "{0 0} {0 0} {1 0} {-1 -1}",
    "", false, "search-457",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)*\" \"aba\"", "{0 0} {0 0}", "", false, "search-458",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)*\" \"aba\"", "{0 0} {0 0} {1 0} {-1 -1} {2 2} {2 2}",
    "", false, "search-459",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)*\" \"aaab\"", "{0 2} {0 2}", "", false, "search-460",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)*\" \"aaab\"", "{0 2} {0 2} {3 2} {-1 -1}",
    "", false, "search-461",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)*\" \"xaba\"", "{0 -1} {-1 -1}", "", false,
    "search-462",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)*\" \"xaba\"", "{0 -1} {-1 -1} {1 1} {1 1} {2 1} {-1 -1} {3 3} {3 3}",
    "", false, "search-463",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)*\" \"a\\nb\"", "{0 0} {0 0}", "", false,
    "search-464",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)*\" \"a\\nb\"", "{0 0} {0 0} {1 0} {-1 -1} {2 1} {-1 -1}",
    "", false, "search-465",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)*\" \"\\na\"", "{0 -1} {-1 -1}", "", false,
    "search-466",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)*\" \"\\na\"", "{0 -1} {-1 -1} {1 1} {1 1}",
    "", false, "search-467",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)*\" \"a\\n\"", "{0 0} {0 0}", "", false, "search-468",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)*\" \"a\\n\"", "{0 0} {0 0} {1 0} {-1 -1}",
    "", false, "search-469",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)*\" \"A B\"", "{0 -1} {-1 -1}", "", false,
    "search-470",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)*\" \"A B\"", "{0 -1} {-1 -1} {1 0} {-1 -1} {2 1} {-1 -1}",
    "", false, "search-471",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)*\" \"abc 12\"", "{0 0} {0 0}", "", false,
    "search-472",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)*\" \"abc 12\"", "{0 0} {0 0} {1 0} {-1 -1} {2 1} {-1 -1} {3 2} {-1 -1} {4 3} {-1 -1} {5 4} {-1 -1}",
    "", false, "search-473",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)*\" \"姹夊瓧\"", "{0 -1} {-1 -1}", "",
    false, "search-474",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)*\" \"姹夊瓧\"", "{0 -1} {-1 -1} {1 0} {-1 -1} {2 1} {-1 -1}",
    "", false, "search-475",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)*\" \"馃榾a\"", "{0 -1} {-1 -1}", "", false,
    "search-476",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)*\" \"馃榾a\"", "{0 -1} {-1 -1} {1 0} {-1 -1} {2 2} {2 2}",
    "", false, "search-477",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)*\" \"a\\x00b\"", "{0 0} {0 0}", "", false,
    "search-478",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)*\" \"a\\x00b\"", "{0 0} {0 0} {1 0} {-1 -1} {2 1} {-1 -1}",
    "", false, "search-479",
  )
}

///|
test "Tcl regexp cases 481 through 520" {
  check_regexp_case(
    "regexp  -inline -indices -- \"(a+)*\" \"\"", "{0 -1} {-1 -1}", "", false, "search-480",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a+)*\" \"\"", "{0 -1} {-1 -1}", "", false,
    "search-481",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a+)*\" \"a\"", "{0 0} {0 0}", "", false, "search-482",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a+)*\" \"a\"", "{0 0} {0 0}", "", false,
    "search-483",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a+)*\" \"b\"", "{0 -1} {-1 -1}", "", false, "search-484",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a+)*\" \"b\"", "{0 -1} {-1 -1}", "", false,
    "search-485",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a+)*\" \"ab\"", "{0 0} {0 0}", "", false, "search-486",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a+)*\" \"ab\"", "{0 0} {0 0} {1 0} {-1 -1}",
    "", false, "search-487",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a+)*\" \"aba\"", "{0 0} {0 0}", "", false, "search-488",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a+)*\" \"aba\"", "{0 0} {0 0} {1 0} {-1 -1} {2 2} {2 2}",
    "", false, "search-489",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a+)*\" \"aaab\"", "{0 2} {0 2}", "", false, "search-490",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a+)*\" \"aaab\"", "{0 2} {0 2} {3 2} {-1 -1}",
    "", false, "search-491",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a+)*\" \"xaba\"", "{0 -1} {-1 -1}", "", false,
    "search-492",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a+)*\" \"xaba\"", "{0 -1} {-1 -1} {1 1} {1 1} {2 1} {-1 -1} {3 3} {3 3}",
    "", false, "search-493",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a+)*\" \"a\\nb\"", "{0 0} {0 0}", "", false,
    "search-494",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a+)*\" \"a\\nb\"", "{0 0} {0 0} {1 0} {-1 -1} {2 1} {-1 -1}",
    "", false, "search-495",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a+)*\" \"\\na\"", "{0 -1} {-1 -1}", "", false,
    "search-496",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a+)*\" \"\\na\"", "{0 -1} {-1 -1} {1 1} {1 1}",
    "", false, "search-497",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a+)*\" \"a\\n\"", "{0 0} {0 0}", "", false, "search-498",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a+)*\" \"a\\n\"", "{0 0} {0 0} {1 0} {-1 -1}",
    "", false, "search-499",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a+)*\" \"A B\"", "{0 -1} {-1 -1}", "", false,
    "search-500",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a+)*\" \"A B\"", "{0 -1} {-1 -1} {1 0} {-1 -1} {2 1} {-1 -1}",
    "", false, "search-501",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a+)*\" \"abc 12\"", "{0 0} {0 0}", "", false,
    "search-502",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a+)*\" \"abc 12\"", "{0 0} {0 0} {1 0} {-1 -1} {2 1} {-1 -1} {3 2} {-1 -1} {4 3} {-1 -1} {5 4} {-1 -1}",
    "", false, "search-503",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a+)*\" \"姹夊瓧\"", "{0 -1} {-1 -1}", "",
    false, "search-504",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a+)*\" \"姹夊瓧\"", "{0 -1} {-1 -1} {1 0} {-1 -1} {2 1} {-1 -1}",
    "", false, "search-505",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a+)*\" \"馃榾a\"", "{0 -1} {-1 -1}", "", false,
    "search-506",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a+)*\" \"馃榾a\"", "{0 -1} {-1 -1} {1 0} {-1 -1} {2 2} {2 2}",
    "", false, "search-507",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a+)*\" \"a\\x00b\"", "{0 0} {0 0}", "", false,
    "search-508",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a+)*\" \"a\\x00b\"", "{0 0} {0 0} {1 0} {-1 -1} {2 1} {-1 -1}",
    "", false, "search-509",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a|b)+\" \"\"", "", "", false, "search-510",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a|b)+\" \"\"", "", "", false, "search-511",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a|b)+\" \"a\"", "{0 0} {0 0}", "", false, "search-512",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a|b)+\" \"a\"", "{0 0} {0 0}", "", false,
    "search-513",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a|b)+\" \"b\"", "{0 0} {0 0}", "", false, "search-514",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a|b)+\" \"b\"", "{0 0} {0 0}", "", false,
    "search-515",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a|b)+\" \"ab\"", "{0 1} {1 1}", "", false, "search-516",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a|b)+\" \"ab\"", "{0 1} {1 1}", "", false,
    "search-517",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a|b)+\" \"aba\"", "{0 2} {2 2}", "", false, "search-518",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a|b)+\" \"aba\"", "{0 2} {2 2}", "", false,
    "search-519",
  )
}

///|
test "Tcl regexp cases 521 through 560" {
  check_regexp_case(
    "regexp  -inline -indices -- \"(a|b)+\" \"aaab\"", "{0 3} {3 3}", "", false,
    "search-520",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a|b)+\" \"aaab\"", "{0 3} {3 3}", "", false,
    "search-521",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a|b)+\" \"xaba\"", "{1 3} {3 3}", "", false,
    "search-522",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a|b)+\" \"xaba\"", "{1 3} {3 3}", "", false,
    "search-523",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a|b)+\" \"a\\nb\"", "{0 0} {0 0}", "", false,
    "search-524",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a|b)+\" \"a\\nb\"", "{0 0} {0 0} {2 2} {2 2}",
    "", false, "search-525",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a|b)+\" \"\\na\"", "{1 1} {1 1}", "", false,
    "search-526",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a|b)+\" \"\\na\"", "{1 1} {1 1}", "", false,
    "search-527",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a|b)+\" \"a\\n\"", "{0 0} {0 0}", "", false,
    "search-528",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a|b)+\" \"a\\n\"", "{0 0} {0 0}", "", false,
    "search-529",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a|b)+\" \"A B\"", "", "", false, "search-530",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a|b)+\" \"A B\"", "", "", false, "search-531",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a|b)+\" \"abc 12\"", "{0 1} {1 1}", "", false,
    "search-532",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a|b)+\" \"abc 12\"", "{0 1} {1 1}", "", false,
    "search-533",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a|b)+\" \"姹夊瓧\"", "", "", false, "search-534",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a|b)+\" \"姹夊瓧\"", "", "", false, "search-535",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a|b)+\" \"馃榾a\"", "{2 2} {2 2}", "", false,
    "search-536",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a|b)+\" \"馃榾a\"", "{2 2} {2 2}", "",
    false, "search-537",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a|b)+\" \"a\\x00b\"", "{0 0} {0 0}", "", false,
    "search-538",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a|b)+\" \"a\\x00b\"", "{0 0} {0 0} {2 2} {2 2}",
    "", false, "search-539",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?:a)\" \"\"", "", "", false, "search-540",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?:a)\" \"\"", "", "", false, "search-541",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?:a)\" \"a\"", "{0 0}", "", false, "search-542",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?:a)\" \"a\"", "{0 0}", "", false, "search-543",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?:a)\" \"b\"", "", "", false, "search-544",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?:a)\" \"b\"", "", "", false, "search-545",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?:a)\" \"ab\"", "{0 0}", "", false, "search-546",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?:a)\" \"ab\"", "{0 0}", "", false, "search-547",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?:a)\" \"aba\"", "{0 0}", "", false, "search-548",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?:a)\" \"aba\"", "{0 0} {2 2}", "", false,
    "search-549",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?:a)\" \"aaab\"", "{0 0}", "", false, "search-550",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?:a)\" \"aaab\"", "{0 0} {1 1} {2 2}", "",
    false, "search-551",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?:a)\" \"xaba\"", "{1 1}", "", false, "search-552",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?:a)\" \"xaba\"", "{1 1} {3 3}", "", false,
    "search-553",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?:a)\" \"a\\nb\"", "{0 0}", "", false, "search-554",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?:a)\" \"a\\nb\"", "{0 0}", "", false, "search-555",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?:a)\" \"\\na\"", "{1 1}", "", false, "search-556",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?:a)\" \"\\na\"", "{1 1}", "", false, "search-557",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?:a)\" \"a\\n\"", "{0 0}", "", false, "search-558",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?:a)\" \"a\\n\"", "{0 0}", "", false, "search-559",
  )
}

///|
test "Tcl regexp cases 561 through 600" {
  check_regexp_case(
    "regexp  -inline -indices -- \"(?:a)\" \"A B\"", "", "", false, "search-560",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?:a)\" \"A B\"", "", "", false, "search-561",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?:a)\" \"abc 12\"", "{0 0}", "", false, "search-562",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?:a)\" \"abc 12\"", "{0 0}", "", false, "search-563",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?:a)\" \"姹夊瓧\"", "", "", false, "search-564",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?:a)\" \"姹夊瓧\"", "", "", false, "search-565",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?:a)\" \"馃榾a\"", "{2 2}", "", false, "search-566",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?:a)\" \"馃榾a\"", "{2 2}", "", false,
    "search-567",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?:a)\" \"a\\x00b\"", "{0 0}", "", false, "search-568",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?:a)\" \"a\\x00b\"", "{0 0}", "", false,
    "search-569",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^\" \"\"", "{0 -1}", "", false, "search-570",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^\" \"\"", "{0 -1}", "", false, "search-571",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^\" \"a\"", "{0 -1}", "", false, "search-572",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^\" \"a\"", "{0 -1}", "", false, "search-573",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^\" \"b\"", "{0 -1}", "", false, "search-574",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^\" \"b\"", "{0 -1}", "", false, "search-575",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^\" \"ab\"", "{0 -1}", "", false, "search-576",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^\" \"ab\"", "{0 -1}", "", false, "search-577",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^\" \"aba\"", "{0 -1}", "", false, "search-578",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^\" \"aba\"", "{0 -1}", "", false, "search-579",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^\" \"aaab\"", "{0 -1}", "", false, "search-580",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^\" \"aaab\"", "{0 -1}", "", false, "search-581",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^\" \"xaba\"", "{0 -1}", "", false, "search-582",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^\" \"xaba\"", "{0 -1}", "", false, "search-583",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^\" \"a\\nb\"", "{0 -1}", "", false, "search-584",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^\" \"a\\nb\"", "{0 -1}", "", false, "search-585",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^\" \"\\na\"", "{0 -1}", "", false, "search-586",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^\" \"\\na\"", "{0 -1} {1 0}", "", false,
    "search-587",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^\" \"a\\n\"", "{0 -1}", "", false, "search-588",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^\" \"a\\n\"", "{0 -1}", "", false, "search-589",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^\" \"A B\"", "{0 -1}", "", false, "search-590",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^\" \"A B\"", "{0 -1}", "", false, "search-591",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^\" \"abc 12\"", "{0 -1}", "", false, "search-592",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^\" \"abc 12\"", "{0 -1}", "", false, "search-593",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^\" \"姹夊瓧\"", "{0 -1}", "", false, "search-594",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^\" \"姹夊瓧\"", "{0 -1}", "", false, "search-595",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^\" \"馃榾a\"", "{0 -1}", "", false, "search-596",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^\" \"馃榾a\"", "{0 -1}", "", false, "search-597",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^\" \"a\\x00b\"", "{0 -1}", "", false, "search-598",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^\" \"a\\x00b\"", "{0 -1}", "", false, "search-599",
  )
}

///|
test "Tcl regexp cases 601 through 640" {
  check_regexp_case(
    "regexp  -inline -indices -- \"\\$\" \"\"", "{0 -1}", "", false, "search-600",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\$\" \"\"", "{0 -1}", "", false, "search-601",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\$\" \"a\"", "{1 0}", "", false, "search-602",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\$\" \"a\"", "{1 0}", "", false, "search-603",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\$\" \"b\"", "{1 0}", "", false, "search-604",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\$\" \"b\"", "{1 0}", "", false, "search-605",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\$\" \"ab\"", "{2 1}", "", false, "search-606",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\$\" \"ab\"", "{2 1}", "", false, "search-607",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\$\" \"aba\"", "{3 2}", "", false, "search-608",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\$\" \"aba\"", "{3 2}", "", false, "search-609",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\$\" \"aaab\"", "{4 3}", "", false, "search-610",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\$\" \"aaab\"", "{4 3}", "", false, "search-611",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\$\" \"xaba\"", "{4 3}", "", false, "search-612",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\$\" \"xaba\"", "{4 3}", "", false, "search-613",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\$\" \"a\\nb\"", "{3 2}", "", false, "search-614",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\$\" \"a\\nb\"", "{3 2}", "", false, "search-615",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\$\" \"\\na\"", "{2 1}", "", false, "search-616",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\$\" \"\\na\"", "{2 1}", "", false, "search-617",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\$\" \"a\\n\"", "{2 1}", "", false, "search-618",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\$\" \"a\\n\"", "{2 1}", "", false, "search-619",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\$\" \"A B\"", "{3 2}", "", false, "search-620",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\$\" \"A B\"", "{3 2}", "", false, "search-621",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\$\" \"abc 12\"", "{6 5}", "", false, "search-622",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\$\" \"abc 12\"", "{6 5}", "", false, "search-623",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\$\" \"姹夊瓧\"", "{3 2}", "", false, "search-624",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\$\" \"姹夊瓧\"", "{3 2}", "", false,
    "search-625",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\$\" \"馃榾a\"", "{3 2}", "", false, "search-626",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\$\" \"馃榾a\"", "{3 2}", "", false, "search-627",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\$\" \"a\\x00b\"", "{3 2}", "", false, "search-628",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\$\" \"a\\x00b\"", "{3 2}", "", false, "search-629",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^\\$\" \"\"", "{0 -1}", "", false, "search-630",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^\\$\" \"\"", "{0 -1}", "", false, "search-631",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^\\$\" \"a\"", "", "", false, "search-632",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^\\$\" \"a\"", "", "", false, "search-633",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^\\$\" \"b\"", "", "", false, "search-634",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^\\$\" \"b\"", "", "", false, "search-635",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^\\$\" \"ab\"", "", "", false, "search-636",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^\\$\" \"ab\"", "", "", false, "search-637",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^\\$\" \"aba\"", "", "", false, "search-638",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^\\$\" \"aba\"", "", "", false, "search-639",
  )
}

///|
test "Tcl regexp cases 641 through 680" {
  check_regexp_case(
    "regexp  -inline -indices -- \"^\\$\" \"aaab\"", "", "", false, "search-640",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^\\$\" \"aaab\"", "", "", false, "search-641",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^\\$\" \"xaba\"", "", "", false, "search-642",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^\\$\" \"xaba\"", "", "", false, "search-643",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^\\$\" \"a\\nb\"", "", "", false, "search-644",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^\\$\" \"a\\nb\"", "", "", false, "search-645",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^\\$\" \"\\na\"", "", "", false, "search-646",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^\\$\" \"\\na\"", "", "", false, "search-647",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^\\$\" \"a\\n\"", "", "", false, "search-648",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^\\$\" \"a\\n\"", "", "", false, "search-649",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^\\$\" \"A B\"", "", "", false, "search-650",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^\\$\" \"A B\"", "", "", false, "search-651",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^\\$\" \"abc 12\"", "", "", false, "search-652",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^\\$\" \"abc 12\"", "", "", false, "search-653",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^\\$\" \"姹夊瓧\"", "", "", false, "search-654",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^\\$\" \"姹夊瓧\"", "", "", false, "search-655",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^\\$\" \"馃榾a\"", "", "", false, "search-656",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^\\$\" \"馃榾a\"", "", "", false, "search-657",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^\\$\" \"a\\x00b\"", "", "", false, "search-658",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^\\$\" \"a\\x00b\"", "", "", false, "search-659",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^a\" \"\"", "", "", false, "search-660",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^a\" \"\"", "", "", false, "search-661",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^a\" \"a\"", "{0 0}", "", false, "search-662",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^a\" \"a\"", "{0 0}", "", false, "search-663",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^a\" \"b\"", "", "", false, "search-664",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^a\" \"b\"", "", "", false, "search-665",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^a\" \"ab\"", "{0 0}", "", false, "search-666",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^a\" \"ab\"", "{0 0}", "", false, "search-667",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^a\" \"aba\"", "{0 0}", "", false, "search-668",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^a\" \"aba\"", "{0 0}", "", false, "search-669",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^a\" \"aaab\"", "{0 0}", "", false, "search-670",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^a\" \"aaab\"", "{0 0}", "", false, "search-671",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^a\" \"xaba\"", "", "", false, "search-672",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^a\" \"xaba\"", "", "", false, "search-673",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^a\" \"a\\nb\"", "{0 0}", "", false, "search-674",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^a\" \"a\\nb\"", "{0 0}", "", false, "search-675",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^a\" \"\\na\"", "", "", false, "search-676",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^a\" \"\\na\"", "", "", false, "search-677",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^a\" \"a\\n\"", "{0 0}", "", false, "search-678",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^a\" \"a\\n\"", "{0 0}", "", false, "search-679",
  )
}

///|
test "Tcl regexp cases 681 through 720" {
  check_regexp_case(
    "regexp  -inline -indices -- \"^a\" \"A B\"", "", "", false, "search-680",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^a\" \"A B\"", "", "", false, "search-681",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^a\" \"abc 12\"", "{0 0}", "", false, "search-682",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^a\" \"abc 12\"", "{0 0}", "", false, "search-683",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^a\" \"姹夊瓧\"", "", "", false, "search-684",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^a\" \"姹夊瓧\"", "", "", false, "search-685",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^a\" \"馃榾a\"", "", "", false, "search-686",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^a\" \"馃榾a\"", "", "", false, "search-687",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"^a\" \"a\\x00b\"", "{0 0}", "", false, "search-688",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"^a\" \"a\\x00b\"", "{0 0}", "", false, "search-689",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\\$\" \"\"", "", "", false, "search-690",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\\$\" \"\"", "", "", false, "search-691",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\\$\" \"a\"", "{0 0}", "", false, "search-692",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\\$\" \"a\"", "{0 0}", "", false, "search-693",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\\$\" \"b\"", "", "", false, "search-694",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\\$\" \"b\"", "", "", false, "search-695",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\\$\" \"ab\"", "", "", false, "search-696",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\\$\" \"ab\"", "", "", false, "search-697",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\\$\" \"aba\"", "{2 2}", "", false, "search-698",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\\$\" \"aba\"", "{2 2}", "", false, "search-699",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\\$\" \"aaab\"", "", "", false, "search-700",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\\$\" \"aaab\"", "", "", false, "search-701",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\\$\" \"xaba\"", "{3 3}", "", false, "search-702",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\\$\" \"xaba\"", "{3 3}", "", false, "search-703",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\\$\" \"a\\nb\"", "", "", false, "search-704",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\\$\" \"a\\nb\"", "", "", false, "search-705",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\\$\" \"\\na\"", "{1 1}", "", false, "search-706",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\\$\" \"\\na\"", "{1 1}", "", false, "search-707",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\\$\" \"a\\n\"", "", "", false, "search-708",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\\$\" \"a\\n\"", "", "", false, "search-709",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\\$\" \"A B\"", "", "", false, "search-710",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\\$\" \"A B\"", "", "", false, "search-711",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\\$\" \"abc 12\"", "", "", false, "search-712",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\\$\" \"abc 12\"", "", "", false, "search-713",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\\$\" \"姹夊瓧\"", "", "", false, "search-714",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\\$\" \"姹夊瓧\"", "", "", false, "search-715",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\\$\" \"馃榾a\"", "{2 2}", "", false, "search-716",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\\$\" \"馃榾a\"", "{2 2}", "", false, "search-717",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\\$\" \"a\\x00b\"", "", "", false, "search-718",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\\$\" \"a\\x00b\"", "", "", false, "search-719",
  )
}

///|
test "Tcl regexp cases 721 through 760" {
  check_regexp_case(
    "regexp  -inline -indices -- \"a^\" \"\"", "", "", false, "search-720",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a^\" \"\"", "", "", false, "search-721",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a^\" \"a\"", "", "", false, "search-722",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a^\" \"a\"", "", "", false, "search-723",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a^\" \"b\"", "", "", false, "search-724",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a^\" \"b\"", "", "", false, "search-725",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a^\" \"ab\"", "", "", false, "search-726",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a^\" \"ab\"", "", "", false, "search-727",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a^\" \"aba\"", "", "", false, "search-728",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a^\" \"aba\"", "", "", false, "search-729",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a^\" \"aaab\"", "", "", false, "search-730",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a^\" \"aaab\"", "", "", false, "search-731",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a^\" \"xaba\"", "", "", false, "search-732",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a^\" \"xaba\"", "", "", false, "search-733",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a^\" \"a\\nb\"", "", "", false, "search-734",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a^\" \"a\\nb\"", "", "", false, "search-735",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a^\" \"\\na\"", "", "", false, "search-736",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a^\" \"\\na\"", "", "", false, "search-737",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a^\" \"a\\n\"", "", "", false, "search-738",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a^\" \"a\\n\"", "", "", false, "search-739",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a^\" \"A B\"", "", "", false, "search-740",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a^\" \"A B\"", "", "", false, "search-741",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a^\" \"abc 12\"", "", "", false, "search-742",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a^\" \"abc 12\"", "", "", false, "search-743",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a^\" \"姹夊瓧\"", "", "", false, "search-744",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a^\" \"姹夊瓧\"", "", "", false, "search-745",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a^\" \"馃榾a\"", "", "", false, "search-746",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a^\" \"馃榾a\"", "", "", false, "search-747",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a^\" \"a\\x00b\"", "", "", false, "search-748",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a^\" \"a\\x00b\"", "", "", false, "search-749",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\\$b\" \"\"", "", "", false, "search-750",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\\$b\" \"\"", "", "", false, "search-751",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\\$b\" \"a\"", "", "", false, "search-752",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\\$b\" \"a\"", "", "", false, "search-753",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\\$b\" \"b\"", "", "", false, "search-754",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\\$b\" \"b\"", "", "", false, "search-755",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\\$b\" \"ab\"", "", "", false, "search-756",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\\$b\" \"ab\"", "", "", false, "search-757",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\\$b\" \"aba\"", "", "", false, "search-758",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\\$b\" \"aba\"", "", "", false, "search-759",
  )
}

///|
test "Tcl regexp cases 761 through 800" {
  check_regexp_case(
    "regexp  -inline -indices -- \"a\\$b\" \"aaab\"", "", "", false, "search-760",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\\$b\" \"aaab\"", "", "", false, "search-761",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\\$b\" \"xaba\"", "", "", false, "search-762",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\\$b\" \"xaba\"", "", "", false, "search-763",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\\$b\" \"a\\nb\"", "", "", false, "search-764",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\\$b\" \"a\\nb\"", "", "", false, "search-765",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\\$b\" \"\\na\"", "", "", false, "search-766",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\\$b\" \"\\na\"", "", "", false, "search-767",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\\$b\" \"a\\n\"", "", "", false, "search-768",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\\$b\" \"a\\n\"", "", "", false, "search-769",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\\$b\" \"A B\"", "", "", false, "search-770",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\\$b\" \"A B\"", "", "", false, "search-771",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\\$b\" \"abc 12\"", "", "", false, "search-772",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\\$b\" \"abc 12\"", "", "", false, "search-773",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\\$b\" \"姹夊瓧\"", "", "", false, "search-774",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\\$b\" \"姹夊瓧\"", "", "", false, "search-775",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\\$b\" \"馃榾a\"", "", "", false, "search-776",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\\$b\" \"馃榾a\"", "", "", false, "search-777",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a\\$b\" \"a\\x00b\"", "", "", false, "search-778",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a\\$b\" \"a\\x00b\"", "", "", false, "search-779",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\A\" \"\"", "{0 -1}", "", false, "search-780",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\A\" \"\"", "{0 -1}", "", false, "search-781",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\A\" \"a\"", "{0 -1}", "", false, "search-782",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\A\" \"a\"", "{0 -1}", "", false, "search-783",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\A\" \"b\"", "{0 -1}", "", false, "search-784",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\A\" \"b\"", "{0 -1}", "", false, "search-785",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\A\" \"ab\"", "{0 -1}", "", false, "search-786",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\A\" \"ab\"", "{0 -1} {1 0}", "", false,
    "search-787",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\A\" \"aba\"", "{0 -1}", "", false, "search-788",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\A\" \"aba\"", "{0 -1} {1 0} {2 1}", "",
    false, "search-789",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\A\" \"aaab\"", "{0 -1}", "", false, "search-790",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\A\" \"aaab\"", "{0 -1} {1 0} {2 1} {3 2}",
    "", false, "search-791",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\A\" \"xaba\"", "{0 -1}", "", false, "search-792",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\A\" \"xaba\"", "{0 -1} {1 0} {2 1} {3 2}",
    "", false, "search-793",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\A\" \"a\\nb\"", "{0 -1}", "", false, "search-794",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\A\" \"a\\nb\"", "{0 -1} {1 0} {2 1}",
    "", false, "search-795",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\A\" \"\\na\"", "{0 -1}", "", false, "search-796",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\A\" \"\\na\"", "{0 -1} {1 0}", "", false,
    "search-797",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\A\" \"a\\n\"", "{0 -1}", "", false, "search-798",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\A\" \"a\\n\"", "{0 -1} {1 0}", "", false,
    "search-799",
  )
}

///|
test "Tcl regexp cases 801 through 840" {
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\A\" \"A B\"", "{0 -1}", "", false, "search-800",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\A\" \"A B\"", "{0 -1} {1 0} {2 1}", "",
    false, "search-801",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\A\" \"abc 12\"", "{0 -1}", "", false, "search-802",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\A\" \"abc 12\"", "{0 -1} {1 0} {2 1} {3 2} {4 3} {5 4}",
    "", false, "search-803",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\A\" \"姹夊瓧\"", "{0 -1}", "", false, "search-804",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\A\" \"姹夊瓧\"", "{0 -1} {1 0} {2 1}",
    "", false, "search-805",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\A\" \"馃榾a\"", "{0 -1}", "", false, "search-806",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\A\" \"馃榾a\"", "{0 -1} {1 0} {2 1}",
    "", false, "search-807",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\A\" \"a\\x00b\"", "{0 -1}", "", false, "search-808",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\A\" \"a\\x00b\"", "{0 -1} {1 0} {2 1}",
    "", false, "search-809",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\Z\" \"\"", "{0 -1}", "", false, "search-810",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\Z\" \"\"", "{0 -1}", "", false, "search-811",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\Z\" \"a\"", "{1 0}", "", false, "search-812",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\Z\" \"a\"", "{1 0}", "", false, "search-813",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\Z\" \"b\"", "{1 0}", "", false, "search-814",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\Z\" \"b\"", "{1 0}", "", false, "search-815",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\Z\" \"ab\"", "{2 1}", "", false, "search-816",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\Z\" \"ab\"", "{2 1}", "", false, "search-817",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\Z\" \"aba\"", "{3 2}", "", false, "search-818",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\Z\" \"aba\"", "{3 2}", "", false, "search-819",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\Z\" \"aaab\"", "{4 3}", "", false, "search-820",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\Z\" \"aaab\"", "{4 3}", "", false, "search-821",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\Z\" \"xaba\"", "{4 3}", "", false, "search-822",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\Z\" \"xaba\"", "{4 3}", "", false, "search-823",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\Z\" \"a\\nb\"", "{3 2}", "", false, "search-824",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\Z\" \"a\\nb\"", "{3 2}", "", false, "search-825",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\Z\" \"\\na\"", "{2 1}", "", false, "search-826",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\Z\" \"\\na\"", "{2 1}", "", false, "search-827",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\Z\" \"a\\n\"", "{2 1}", "", false, "search-828",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\Z\" \"a\\n\"", "{2 1}", "", false, "search-829",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\Z\" \"A B\"", "{3 2}", "", false, "search-830",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\Z\" \"A B\"", "{3 2}", "", false, "search-831",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\Z\" \"abc 12\"", "{6 5}", "", false, "search-832",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\Z\" \"abc 12\"", "{6 5}", "", false, "search-833",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\Z\" \"姹夊瓧\"", "{3 2}", "", false, "search-834",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\Z\" \"姹夊瓧\"", "{3 2}", "", false,
    "search-835",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\Z\" \"馃榾a\"", "{3 2}", "", false, "search-836",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\Z\" \"馃榾a\"", "{3 2}", "", false,
    "search-837",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\Z\" \"a\\x00b\"", "{3 2}", "", false, "search-838",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\Z\" \"a\\x00b\"", "{3 2}", "", false,
    "search-839",
  )
}

///|
test "Tcl regexp cases 841 through 880" {
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\m\" \"\"", "", "", false, "search-840",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\m\" \"\"", "", "", false, "search-841",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\m\" \"a\"", "{0 -1}", "", false, "search-842",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\m\" \"a\"", "{0 -1}", "", false, "search-843",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\m\" \"b\"", "{0 -1}", "", false, "search-844",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\m\" \"b\"", "{0 -1}", "", false, "search-845",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\m\" \"ab\"", "{0 -1}", "", false, "search-846",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\m\" \"ab\"", "{0 -1} {1 0}", "", false,
    "search-847",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\m\" \"aba\"", "{0 -1}", "", false, "search-848",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\m\" \"aba\"", "{0 -1} {1 0} {2 1}", "",
    false, "search-849",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\m\" \"aaab\"", "{0 -1}", "", false, "search-850",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\m\" \"aaab\"", "{0 -1} {1 0} {2 1} {3 2}",
    "", false, "search-851",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\m\" \"xaba\"", "{0 -1}", "", false, "search-852",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\m\" \"xaba\"", "{0 -1} {1 0} {2 1} {3 2}",
    "", false, "search-853",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\m\" \"a\\nb\"", "{0 -1}", "", false, "search-854",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\m\" \"a\\nb\"", "{0 -1} {2 1}", "", false,
    "search-855",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\m\" \"\\na\"", "{1 0}", "", false, "search-856",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\m\" \"\\na\"", "{1 0}", "", false, "search-857",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\m\" \"a\\n\"", "{0 -1}", "", false, "search-858",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\m\" \"a\\n\"", "{0 -1}", "", false, "search-859",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\m\" \"A B\"", "{0 -1}", "", false, "search-860",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\m\" \"A B\"", "{0 -1} {2 1}", "", false,
    "search-861",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\m\" \"abc 12\"", "{0 -1}", "", false, "search-862",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\m\" \"abc 12\"", "{0 -1} {1 0} {2 1} {4 3} {5 4}",
    "", false, "search-863",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\m\" \"姹夊瓧\"", "{0 -1}", "", false, "search-864",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\m\" \"姹夊瓧\"", "{0 -1} {1 0} {2 1}",
    "", false, "search-865",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\m\" \"馃榾a\"", "{0 -1}", "", false, "search-866",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\m\" \"馃榾a\"", "{0 -1} {1 0} {2 1}",
    "", false, "search-867",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\m\" \"a\\x00b\"", "{0 -1}", "", false, "search-868",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\m\" \"a\\x00b\"", "{0 -1} {2 1}", "",
    false, "search-869",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\M\" \"\"", "", "", false, "search-870",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\M\" \"\"", "", "", false, "search-871",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\M\" \"a\"", "{1 0}", "", false, "search-872",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\M\" \"a\"", "{1 0}", "", false, "search-873",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\M\" \"b\"", "{1 0}", "", false, "search-874",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\M\" \"b\"", "{1 0}", "", false, "search-875",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\M\" \"ab\"", "{2 1}", "", false, "search-876",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\M\" \"ab\"", "{2 1}", "", false, "search-877",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\M\" \"aba\"", "{3 2}", "", false, "search-878",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\M\" \"aba\"", "{3 2}", "", false, "search-879",
  )
}

///|
test "Tcl regexp cases 881 through 920" {
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\M\" \"aaab\"", "{4 3}", "", false, "search-880",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\M\" \"aaab\"", "{4 3}", "", false, "search-881",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\M\" \"xaba\"", "{4 3}", "", false, "search-882",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\M\" \"xaba\"", "{4 3}", "", false, "search-883",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\M\" \"a\\nb\"", "{1 0}", "", false, "search-884",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\M\" \"a\\nb\"", "{1 0} {3 2}", "", false,
    "search-885",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\M\" \"\\na\"", "{2 1}", "", false, "search-886",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\M\" \"\\na\"", "{2 1}", "", false, "search-887",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\M\" \"a\\n\"", "{1 0}", "", false, "search-888",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\M\" \"a\\n\"", "{1 0}", "", false, "search-889",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\M\" \"A B\"", "{1 0}", "", false, "search-890",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\M\" \"A B\"", "{1 0} {3 2}", "", false,
    "search-891",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\M\" \"abc 12\"", "{3 2}", "", false, "search-892",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\M\" \"abc 12\"", "{3 2} {6 5}", "", false,
    "search-893",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\M\" \"姹夊瓧\"", "{3 2}", "", false, "search-894",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\M\" \"姹夊瓧\"", "{3 2}", "", false,
    "search-895",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\M\" \"馃榾a\"", "{3 2}", "", false, "search-896",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\M\" \"馃榾a\"", "{3 2}", "", false,
    "search-897",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\M\" \"a\\x00b\"", "{1 0}", "", false, "search-898",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\M\" \"a\\x00b\"", "{1 0} {3 2}", "", false,
    "search-899",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\y\" \"\"", "", "", false, "search-900",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\y\" \"\"", "", "", false, "search-901",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\y\" \"a\"", "{0 -1}", "", false, "search-902",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\y\" \"a\"", "{0 -1}", "", false, "search-903",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\y\" \"b\"", "{0 -1}", "", false, "search-904",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\y\" \"b\"", "{0 -1}", "", false, "search-905",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\y\" \"ab\"", "{0 -1}", "", false, "search-906",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\y\" \"ab\"", "{0 -1} {1 0}", "", false,
    "search-907",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\y\" \"aba\"", "{0 -1}", "", false, "search-908",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\y\" \"aba\"", "{0 -1} {1 0} {2 1}", "",
    false, "search-909",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\y\" \"aaab\"", "{0 -1}", "", false, "search-910",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\y\" \"aaab\"", "{0 -1} {1 0} {2 1} {3 2}",
    "", false, "search-911",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\y\" \"xaba\"", "{0 -1}", "", false, "search-912",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\y\" \"xaba\"", "{0 -1} {1 0} {2 1} {3 2}",
    "", false, "search-913",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\y\" \"a\\nb\"", "{0 -1}", "", false, "search-914",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\y\" \"a\\nb\"", "{0 -1} {2 1}", "", false,
    "search-915",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\y\" \"\\na\"", "{1 0}", "", false, "search-916",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\y\" \"\\na\"", "{1 0}", "", false, "search-917",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\y\" \"a\\n\"", "{0 -1}", "", false, "search-918",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\y\" \"a\\n\"", "{0 -1}", "", false, "search-919",
  )
}

///|
test "Tcl regexp cases 921 through 960" {
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\y\" \"A B\"", "{0 -1}", "", false, "search-920",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\y\" \"A B\"", "{0 -1} {2 1}", "", false,
    "search-921",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\y\" \"abc 12\"", "{0 -1}", "", false, "search-922",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\y\" \"abc 12\"", "{0 -1} {1 0} {2 1} {4 3} {5 4}",
    "", false, "search-923",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\y\" \"姹夊瓧\"", "{0 -1}", "", false, "search-924",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\y\" \"姹夊瓧\"", "{0 -1} {1 0} {2 1}",
    "", false, "search-925",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\y\" \"馃榾a\"", "{0 -1}", "", false, "search-926",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\y\" \"馃榾a\"", "{0 -1} {1 0} {2 1}",
    "", false, "search-927",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\y\" \"a\\x00b\"", "{0 -1}", "", false, "search-928",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\y\" \"a\\x00b\"", "{0 -1} {2 1}", "",
    false, "search-929",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\Y\" \"\"", "{0 -1}", "", false, "search-930",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\Y\" \"\"", "{0 -1}", "", false, "search-931",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\Y\" \"a\"", "", "", false, "search-932",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\Y\" \"a\"", "", "", false, "search-933",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\Y\" \"b\"", "", "", false, "search-934",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\Y\" \"b\"", "", "", false, "search-935",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\Y\" \"ab\"", "{1 0}", "", false, "search-936",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\Y\" \"ab\"", "{1 0}", "", false, "search-937",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\Y\" \"aba\"", "{1 0}", "", false, "search-938",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\Y\" \"aba\"", "{1 0}", "", false, "search-939",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\Y\" \"aaab\"", "{1 0}", "", false, "search-940",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\Y\" \"aaab\"", "{1 0} {3 2}", "", false,
    "search-941",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\Y\" \"xaba\"", "{1 0}", "", false, "search-942",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\Y\" \"xaba\"", "{1 0} {3 2}", "", false,
    "search-943",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\Y\" \"a\\nb\"", "", "", false, "search-944",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\Y\" \"a\\nb\"", "", "", false, "search-945",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\Y\" \"\\na\"", "{0 -1}", "", false, "search-946",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\Y\" \"\\na\"", "{0 -1}", "", false, "search-947",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\Y\" \"a\\n\"", "{2 1}", "", false, "search-948",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\Y\" \"a\\n\"", "{2 1}", "", false, "search-949",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\Y\" \"A B\"", "", "", false, "search-950",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\Y\" \"A B\"", "", "", false, "search-951",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\Y\" \"abc 12\"", "{1 0}", "", false, "search-952",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\Y\" \"abc 12\"", "{1 0} {5 4}", "", false,
    "search-953",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\Y\" \"姹夊瓧\"", "{1 0}", "", false, "search-954",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\Y\" \"姹夊瓧\"", "{1 0}", "", false,
    "search-955",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\Y\" \"馃榾a\"", "{1 0}", "", false, "search-956",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\Y\" \"馃榾a\"", "{1 0}", "", false,
    "search-957",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\Y\" \"a\\x00b\"", "", "", false, "search-958",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\Y\" \"a\\x00b\"", "", "", false, "search-959",
  )
}

///|
test "Tcl regexp cases 961 through 1000" {
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\d+\" \"\"", "", "", false, "search-960",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\d+\" \"\"", "", "", false, "search-961",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\d+\" \"a\"", "", "", false, "search-962",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\d+\" \"a\"", "", "", false, "search-963",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\d+\" \"b\"", "", "", false, "search-964",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\d+\" \"b\"", "", "", false, "search-965",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\d+\" \"ab\"", "", "", false, "search-966",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\d+\" \"ab\"", "", "", false, "search-967",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\d+\" \"aba\"", "", "", false, "search-968",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\d+\" \"aba\"", "", "", false, "search-969",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\d+\" \"aaab\"", "", "", false, "search-970",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\d+\" \"aaab\"", "", "", false, "search-971",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\d+\" \"xaba\"", "", "", false, "search-972",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\d+\" \"xaba\"", "", "", false, "search-973",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\d+\" \"a\\nb\"", "", "", false, "search-974",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\d+\" \"a\\nb\"", "", "", false, "search-975",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\d+\" \"\\na\"", "", "", false, "search-976",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\d+\" \"\\na\"", "", "", false, "search-977",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\d+\" \"a\\n\"", "", "", false, "search-978",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\d+\" \"a\\n\"", "", "", false, "search-979",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\d+\" \"A B\"", "", "", false, "search-980",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\d+\" \"A B\"", "", "", false, "search-981",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\d+\" \"abc 12\"", "{4 5}", "", false, "search-982",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\d+\" \"abc 12\"", "{4 5}", "", false,
    "search-983",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\d+\" \"姹夊瓧\"", "", "", false, "search-984",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\d+\" \"姹夊瓧\"", "", "", false, "search-985",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\d+\" \"馃榾a\"", "", "", false, "search-986",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\d+\" \"馃榾a\"", "", "", false, "search-987",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\d+\" \"a\\x00b\"", "", "", false, "search-988",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\d+\" \"a\\x00b\"", "", "", false, "search-989",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\w+\" \"\"", "", "", false, "search-990",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\w+\" \"\"", "", "", false, "search-991",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\w+\" \"a\"", "{0 0}", "", false, "search-992",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\w+\" \"a\"", "{0 0}", "", false, "search-993",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\w+\" \"b\"", "{0 0}", "", false, "search-994",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\w+\" \"b\"", "{0 0}", "", false, "search-995",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\w+\" \"ab\"", "{0 1}", "", false, "search-996",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\w+\" \"ab\"", "{0 1}", "", false, "search-997",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\w+\" \"aba\"", "{0 2}", "", false, "search-998",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\w+\" \"aba\"", "{0 2}", "", false, "search-999",
  )
}

///|
test "Tcl regexp cases 1001 through 1040" {
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\w+\" \"aaab\"", "{0 3}", "", false, "search-1000",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\w+\" \"aaab\"", "{0 3}", "", false, "search-1001",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\w+\" \"xaba\"", "{0 3}", "", false, "search-1002",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\w+\" \"xaba\"", "{0 3}", "", false, "search-1003",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\w+\" \"a\\nb\"", "{0 0}", "", false, "search-1004",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\w+\" \"a\\nb\"", "{0 0} {2 2}", "", false,
    "search-1005",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\w+\" \"\\na\"", "{1 1}", "", false, "search-1006",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\w+\" \"\\na\"", "{1 1}", "", false, "search-1007",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\w+\" \"a\\n\"", "{0 0}", "", false, "search-1008",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\w+\" \"a\\n\"", "{0 0}", "", false, "search-1009",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\w+\" \"A B\"", "{0 0}", "", false, "search-1010",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\w+\" \"A B\"", "{0 0} {2 2}", "", false,
    "search-1011",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\w+\" \"abc 12\"", "{0 2}", "", false, "search-1012",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\w+\" \"abc 12\"", "{0 2} {4 5}", "", false,
    "search-1013",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\w+\" \"姹夊瓧\"", "{0 2}", "", false, "search-1014",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\w+\" \"姹夊瓧\"", "{0 2}", "", false,
    "search-1015",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\w+\" \"馃榾a\"", "{0 2}", "", false, "search-1016",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\w+\" \"馃榾a\"", "{0 2}", "", false,
    "search-1017",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\w+\" \"a\\x00b\"", "{0 0}", "", false, "search-1018",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\w+\" \"a\\x00b\"", "{0 0} {2 2}", "",
    false, "search-1019",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\s+\" \"\"", "", "", false, "search-1020",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\s+\" \"\"", "", "", false, "search-1021",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\s+\" \"a\"", "", "", false, "search-1022",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\s+\" \"a\"", "", "", false, "search-1023",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\s+\" \"b\"", "", "", false, "search-1024",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\s+\" \"b\"", "", "", false, "search-1025",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\s+\" \"ab\"", "", "", false, "search-1026",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\s+\" \"ab\"", "", "", false, "search-1027",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\s+\" \"aba\"", "", "", false, "search-1028",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\s+\" \"aba\"", "", "", false, "search-1029",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\s+\" \"aaab\"", "", "", false, "search-1030",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\s+\" \"aaab\"", "", "", false, "search-1031",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\s+\" \"xaba\"", "", "", false, "search-1032",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\s+\" \"xaba\"", "", "", false, "search-1033",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\s+\" \"a\\nb\"", "{1 1}", "", false, "search-1034",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\s+\" \"a\\nb\"", "{1 1}", "", false, "search-1035",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\s+\" \"\\na\"", "{0 0}", "", false, "search-1036",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\s+\" \"\\na\"", "{0 0}", "", false, "search-1037",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\s+\" \"a\\n\"", "{1 1}", "", false, "search-1038",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\s+\" \"a\\n\"", "{1 1}", "", false, "search-1039",
  )
}

///|
test "Tcl regexp cases 1041 through 1080" {
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\s+\" \"A B\"", "{1 1}", "", false, "search-1040",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\s+\" \"A B\"", "{1 1}", "", false, "search-1041",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\s+\" \"abc 12\"", "{3 3}", "", false, "search-1042",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\s+\" \"abc 12\"", "{3 3}", "", false,
    "search-1043",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\s+\" \"姹夊瓧\"", "", "", false, "search-1044",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\s+\" \"姹夊瓧\"", "", "", false, "search-1045",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\s+\" \"馃榾a\"", "", "", false, "search-1046",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\s+\" \"馃榾a\"", "", "", false, "search-1047",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\s+\" \"a\\x00b\"", "", "", false, "search-1048",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\s+\" \"a\\x00b\"", "", "", false, "search-1049",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\D+\" \"\"", "", "", false, "search-1050",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\D+\" \"\"", "", "", false, "search-1051",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\D+\" \"a\"", "{0 0}", "", false, "search-1052",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\D+\" \"a\"", "{0 0}", "", false, "search-1053",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\D+\" \"b\"", "{0 0}", "", false, "search-1054",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\D+\" \"b\"", "{0 0}", "", false, "search-1055",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\D+\" \"ab\"", "{0 1}", "", false, "search-1056",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\D+\" \"ab\"", "{0 1}", "", false, "search-1057",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\D+\" \"aba\"", "{0 2}", "", false, "search-1058",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\D+\" \"aba\"", "{0 2}", "", false, "search-1059",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\D+\" \"aaab\"", "{0 3}", "", false, "search-1060",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\D+\" \"aaab\"", "{0 3}", "", false, "search-1061",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\D+\" \"xaba\"", "{0 3}", "", false, "search-1062",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\D+\" \"xaba\"", "{0 3}", "", false, "search-1063",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\D+\" \"a\\nb\"", "{0 2}", "", false, "search-1064",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\D+\" \"a\\nb\"", "{0 2}", "", false, "search-1065",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\D+\" \"\\na\"", "{0 1}", "", false, "search-1066",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\D+\" \"\\na\"", "{0 1}", "", false, "search-1067",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\D+\" \"a\\n\"", "{0 1}", "", false, "search-1068",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\D+\" \"a\\n\"", "{0 1}", "", false, "search-1069",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\D+\" \"A B\"", "{0 2}", "", false, "search-1070",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\D+\" \"A B\"", "{0 2}", "", false, "search-1071",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\D+\" \"abc 12\"", "{0 3}", "", false, "search-1072",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\D+\" \"abc 12\"", "{0 3}", "", false,
    "search-1073",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\D+\" \"姹夊瓧\"", "{0 2}", "", false, "search-1074",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\D+\" \"姹夊瓧\"", "{0 2}", "", false,
    "search-1075",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\D+\" \"馃榾a\"", "{0 2}", "", false, "search-1076",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\D+\" \"馃榾a\"", "{0 2}", "", false,
    "search-1077",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\\\D+\" \"a\\x00b\"", "{0 2}", "", false, "search-1078",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\\\D+\" \"a\\x00b\"", "{0 2}", "", false,
    "search-1079",
  )
}

///|
test "Tcl regexp cases 1081 through 1120" {
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[^a\\]+\" \"\"", "", "", false, "search-1080",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[^a\\]+\" \"\"", "", "", false, "search-1081",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[^a\\]+\" \"a\"", "", "", false, "search-1082",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[^a\\]+\" \"a\"", "", "", false, "search-1083",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[^a\\]+\" \"b\"", "{0 0}", "", false, "search-1084",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[^a\\]+\" \"b\"", "{0 0}", "", false, "search-1085",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[^a\\]+\" \"ab\"", "{1 1}", "", false, "search-1086",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[^a\\]+\" \"ab\"", "{1 1}", "", false, "search-1087",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[^a\\]+\" \"aba\"", "{1 1}", "", false, "search-1088",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[^a\\]+\" \"aba\"", "{1 1}", "", false,
    "search-1089",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[^a\\]+\" \"aaab\"", "{3 3}", "", false, "search-1090",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[^a\\]+\" \"aaab\"", "{3 3}", "", false,
    "search-1091",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[^a\\]+\" \"xaba\"", "{0 0}", "", false, "search-1092",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[^a\\]+\" \"xaba\"", "{0 0} {2 2}", "",
    false, "search-1093",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[^a\\]+\" \"a\\nb\"", "{1 2}", "", false, "search-1094",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[^a\\]+\" \"a\\nb\"", "{1 2}", "", false,
    "search-1095",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[^a\\]+\" \"\\na\"", "{0 0}", "", false, "search-1096",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[^a\\]+\" \"\\na\"", "{0 0}", "", false,
    "search-1097",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[^a\\]+\" \"a\\n\"", "{1 1}", "", false, "search-1098",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[^a\\]+\" \"a\\n\"", "{1 1}", "", false,
    "search-1099",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[^a\\]+\" \"A B\"", "{0 2}", "", false, "search-1100",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[^a\\]+\" \"A B\"", "{0 2}", "", false,
    "search-1101",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[^a\\]+\" \"abc 12\"", "{1 5}", "", false, "search-1102",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[^a\\]+\" \"abc 12\"", "{1 5}", "", false,
    "search-1103",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[^a\\]+\" \"姹夊瓧\"", "{0 2}", "", false,
    "search-1104",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[^a\\]+\" \"姹夊瓧\"", "{0 2}", "", false,
    "search-1105",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[^a\\]+\" \"馃榾a\"", "{0 1}", "", false,
    "search-1106",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[^a\\]+\" \"馃榾a\"", "{0 1}", "", false,
    "search-1107",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[^a\\]+\" \"a\\x00b\"", "{1 2}", "", false,
    "search-1108",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[^a\\]+\" \"a\\x00b\"", "{1 2}", "", false,
    "search-1109",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[a-c\\]\" \"\"", "", "", false, "search-1110",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[a-c\\]\" \"\"", "", "", false, "search-1111",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[a-c\\]\" \"a\"", "{0 0}", "", false, "search-1112",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[a-c\\]\" \"a\"", "{0 0}", "", false, "search-1113",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[a-c\\]\" \"b\"", "{0 0}", "", false, "search-1114",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[a-c\\]\" \"b\"", "{0 0}", "", false, "search-1115",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[a-c\\]\" \"ab\"", "{0 0}", "", false, "search-1116",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[a-c\\]\" \"ab\"", "{0 0} {1 1}", "", false,
    "search-1117",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[a-c\\]\" \"aba\"", "{0 0}", "", false, "search-1118",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[a-c\\]\" \"aba\"", "{0 0} {1 1} {2 2}",
    "", false, "search-1119",
  )
}

///|
test "Tcl regexp cases 1121 through 1160" {
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[a-c\\]\" \"aaab\"", "{0 0}", "", false, "search-1120",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[a-c\\]\" \"aaab\"", "{0 0} {1 1} {2 2} {3 3}",
    "", false, "search-1121",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[a-c\\]\" \"xaba\"", "{1 1}", "", false, "search-1122",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[a-c\\]\" \"xaba\"", "{1 1} {2 2} {3 3}",
    "", false, "search-1123",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[a-c\\]\" \"a\\nb\"", "{0 0}", "", false, "search-1124",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[a-c\\]\" \"a\\nb\"", "{0 0} {2 2}", "",
    false, "search-1125",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[a-c\\]\" \"\\na\"", "{1 1}", "", false, "search-1126",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[a-c\\]\" \"\\na\"", "{1 1}", "", false,
    "search-1127",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[a-c\\]\" \"a\\n\"", "{0 0}", "", false, "search-1128",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[a-c\\]\" \"a\\n\"", "{0 0}", "", false,
    "search-1129",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[a-c\\]\" \"A B\"", "", "", false, "search-1130",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[a-c\\]\" \"A B\"", "", "", false, "search-1131",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[a-c\\]\" \"abc 12\"", "{0 0}", "", false, "search-1132",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[a-c\\]\" \"abc 12\"", "{0 0} {1 1} {2 2}",
    "", false, "search-1133",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[a-c\\]\" \"姹夊瓧\"", "", "", false, "search-1134",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[a-c\\]\" \"姹夊瓧\"", "", "", false,
    "search-1135",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[a-c\\]\" \"馃榾a\"", "{2 2}", "", false,
    "search-1136",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[a-c\\]\" \"馃榾a\"", "{2 2}", "", false,
    "search-1137",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[a-c\\]\" \"a\\x00b\"", "{0 0}", "", false,
    "search-1138",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[a-c\\]\" \"a\\x00b\"", "{0 0} {2 2}", "",
    false, "search-1139",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[\\[:upper:\\]\\]\" \"\"", "", "", false, "search-1140",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[\\[:upper:\\]\\]\" \"\"", "", "", false,
    "search-1141",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[\\[:upper:\\]\\]\" \"a\"", "", "", false, "search-1142",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[\\[:upper:\\]\\]\" \"a\"", "", "", false,
    "search-1143",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[\\[:upper:\\]\\]\" \"b\"", "", "", false, "search-1144",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[\\[:upper:\\]\\]\" \"b\"", "", "", false,
    "search-1145",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[\\[:upper:\\]\\]\" \"ab\"", "", "", false,
    "search-1146",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[\\[:upper:\\]\\]\" \"ab\"", "", "", false,
    "search-1147",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[\\[:upper:\\]\\]\" \"aba\"", "", "", false,
    "search-1148",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[\\[:upper:\\]\\]\" \"aba\"", "", "", false,
    "search-1149",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[\\[:upper:\\]\\]\" \"aaab\"", "", "", false,
    "search-1150",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[\\[:upper:\\]\\]\" \"aaab\"", "", "", false,
    "search-1151",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[\\[:upper:\\]\\]\" \"xaba\"", "", "", false,
    "search-1152",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[\\[:upper:\\]\\]\" \"xaba\"", "", "", false,
    "search-1153",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[\\[:upper:\\]\\]\" \"a\\nb\"", "", "", false,
    "search-1154",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[\\[:upper:\\]\\]\" \"a\\nb\"", "", "",
    false, "search-1155",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[\\[:upper:\\]\\]\" \"\\na\"", "", "", false,
    "search-1156",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[\\[:upper:\\]\\]\" \"\\na\"", "", "", false,
    "search-1157",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[\\[:upper:\\]\\]\" \"a\\n\"", "", "", false,
    "search-1158",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[\\[:upper:\\]\\]\" \"a\\n\"", "", "", false,
    "search-1159",
  )
}

///|
test "Tcl regexp cases 1161 through 1200" {
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[\\[:upper:\\]\\]\" \"A B\"", "{0 0}", "", false,
    "search-1160",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[\\[:upper:\\]\\]\" \"A B\"", "{0 0} {2 2}",
    "", false, "search-1161",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[\\[:upper:\\]\\]\" \"abc 12\"", "", "", false,
    "search-1162",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[\\[:upper:\\]\\]\" \"abc 12\"", "", "",
    false, "search-1163",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[\\[:upper:\\]\\]\" \"姹夊瓧\"", "", "",
    false, "search-1164",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[\\[:upper:\\]\\]\" \"姹夊瓧\"", "",
    "", false, "search-1165",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[\\[:upper:\\]\\]\" \"馃榾a\"", "", "", false,
    "search-1166",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[\\[:upper:\\]\\]\" \"馃榾a\"", "", "",
    false, "search-1167",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[\\[:upper:\\]\\]\" \"a\\x00b\"", "", "", false,
    "search-1168",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[\\[:upper:\\]\\]\" \"a\\x00b\"", "", "",
    false, "search-1169",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[\\[:<:\\]\\]a\\[\\[:>:\\]\\]\" \"\"", "", "",
    false, "search-1170",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[\\[:<:\\]\\]a\\[\\[:>:\\]\\]\" \"\"", "",
    "", false, "search-1171",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[\\[:<:\\]\\]a\\[\\[:>:\\]\\]\" \"a\"", "{0 0}",
    "", false, "search-1172",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[\\[:<:\\]\\]a\\[\\[:>:\\]\\]\" \"a\"",
    "{0 0}", "", false, "search-1173",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[\\[:<:\\]\\]a\\[\\[:>:\\]\\]\" \"b\"", "",
    "", false, "search-1174",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[\\[:<:\\]\\]a\\[\\[:>:\\]\\]\" \"b\"",
    "", "", false, "search-1175",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[\\[:<:\\]\\]a\\[\\[:>:\\]\\]\" \"ab\"", "",
    "", false, "search-1176",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[\\[:<:\\]\\]a\\[\\[:>:\\]\\]\" \"ab\"",
    "", "", false, "search-1177",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[\\[:<:\\]\\]a\\[\\[:>:\\]\\]\" \"aba\"", "",
    "", false, "search-1178",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[\\[:<:\\]\\]a\\[\\[:>:\\]\\]\" \"aba\"",
    "", "", false, "search-1179",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[\\[:<:\\]\\]a\\[\\[:>:\\]\\]\" \"aaab\"", "",
    "", false, "search-1180",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[\\[:<:\\]\\]a\\[\\[:>:\\]\\]\" \"aaab\"",
    "", "", false, "search-1181",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[\\[:<:\\]\\]a\\[\\[:>:\\]\\]\" \"xaba\"", "",
    "", false, "search-1182",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[\\[:<:\\]\\]a\\[\\[:>:\\]\\]\" \"xaba\"",
    "", "", false, "search-1183",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[\\[:<:\\]\\]a\\[\\[:>:\\]\\]\" \"a\\nb\"",
    "{0 0}", "", false, "search-1184",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[\\[:<:\\]\\]a\\[\\[:>:\\]\\]\" \"a\\nb\"",
    "{0 0}", "", false, "search-1185",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[\\[:<:\\]\\]a\\[\\[:>:\\]\\]\" \"\\na\"", "{1 1}",
    "", false, "search-1186",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[\\[:<:\\]\\]a\\[\\[:>:\\]\\]\" \"\\na\"",
    "{1 1}", "", false, "search-1187",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[\\[:<:\\]\\]a\\[\\[:>:\\]\\]\" \"a\\n\"", "{0 0}",
    "", false, "search-1188",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[\\[:<:\\]\\]a\\[\\[:>:\\]\\]\" \"a\\n\"",
    "{0 0}", "", false, "search-1189",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[\\[:<:\\]\\]a\\[\\[:>:\\]\\]\" \"A B\"", "",
    "", false, "search-1190",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[\\[:<:\\]\\]a\\[\\[:>:\\]\\]\" \"A B\"",
    "", "", false, "search-1191",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[\\[:<:\\]\\]a\\[\\[:>:\\]\\]\" \"abc 12\"",
    "", "", false, "search-1192",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[\\[:<:\\]\\]a\\[\\[:>:\\]\\]\" \"abc 12\"",
    "", "", false, "search-1193",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[\\[:<:\\]\\]a\\[\\[:>:\\]\\]\" \"姹夊瓧\"",
    "", "", false, "search-1194",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[\\[:<:\\]\\]a\\[\\[:>:\\]\\]\" \"姹夊瓧\"",
    "", "", false, "search-1195",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[\\[:<:\\]\\]a\\[\\[:>:\\]\\]\" \"馃榾a\"",
    "", "", false, "search-1196",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[\\[:<:\\]\\]a\\[\\[:>:\\]\\]\" \"馃榾a\"",
    "", "", false, "search-1197",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"\\[\\[:<:\\]\\]a\\[\\[:>:\\]\\]\" \"a\\x00b\"",
    "{0 0}", "", false, "search-1198",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"\\[\\[:<:\\]\\]a\\[\\[:>:\\]\\]\" \"a\\x00b\"",
    "{0 0}", "", false, "search-1199",
  )
}

///|
test "Tcl regexp cases 1201 through 1240" {
  check_regexp_case(
    "regexp  -inline -indices -- \"a(?=b)\" \"\"", "", "", false, "search-1200",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a(?=b)\" \"\"", "", "", false, "search-1201",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a(?=b)\" \"a\"", "", "", false, "search-1202",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a(?=b)\" \"a\"", "", "", false, "search-1203",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a(?=b)\" \"b\"", "", "", false, "search-1204",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a(?=b)\" \"b\"", "", "", false, "search-1205",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a(?=b)\" \"ab\"", "{0 0}", "", false, "search-1206",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a(?=b)\" \"ab\"", "{0 0}", "", false, "search-1207",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a(?=b)\" \"aba\"", "{0 0}", "", false, "search-1208",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a(?=b)\" \"aba\"", "{0 0}", "", false, "search-1209",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a(?=b)\" \"aaab\"", "{2 2}", "", false, "search-1210",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a(?=b)\" \"aaab\"", "{2 2}", "", false, "search-1211",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a(?=b)\" \"xaba\"", "{1 1}", "", false, "search-1212",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a(?=b)\" \"xaba\"", "{1 1}", "", false, "search-1213",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a(?=b)\" \"a\\nb\"", "", "", false, "search-1214",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a(?=b)\" \"a\\nb\"", "", "", false, "search-1215",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a(?=b)\" \"\\na\"", "", "", false, "search-1216",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a(?=b)\" \"\\na\"", "", "", false, "search-1217",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a(?=b)\" \"a\\n\"", "", "", false, "search-1218",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a(?=b)\" \"a\\n\"", "", "", false, "search-1219",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a(?=b)\" \"A B\"", "", "", false, "search-1220",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a(?=b)\" \"A B\"", "", "", false, "search-1221",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a(?=b)\" \"abc 12\"", "{0 0}", "", false, "search-1222",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a(?=b)\" \"abc 12\"", "{0 0}", "", false,
    "search-1223",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a(?=b)\" \"姹夊瓧\"", "", "", false, "search-1224",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a(?=b)\" \"姹夊瓧\"", "", "", false, "search-1225",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a(?=b)\" \"馃榾a\"", "", "", false, "search-1226",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a(?=b)\" \"馃榾a\"", "", "", false, "search-1227",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a(?=b)\" \"a\\x00b\"", "", "", false, "search-1228",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a(?=b)\" \"a\\x00b\"", "", "", false, "search-1229",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a(?!b)\" \"\"", "", "", false, "search-1230",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a(?!b)\" \"\"", "", "", false, "search-1231",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a(?!b)\" \"a\"", "{0 0}", "", false, "search-1232",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a(?!b)\" \"a\"", "{0 0}", "", false, "search-1233",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a(?!b)\" \"b\"", "", "", false, "search-1234",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a(?!b)\" \"b\"", "", "", false, "search-1235",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a(?!b)\" \"ab\"", "", "", false, "search-1236",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a(?!b)\" \"ab\"", "", "", false, "search-1237",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a(?!b)\" \"aba\"", "{2 2}", "", false, "search-1238",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a(?!b)\" \"aba\"", "{2 2}", "", false, "search-1239",
  )
}

///|
test "Tcl regexp cases 1241 through 1280" {
  check_regexp_case(
    "regexp  -inline -indices -- \"a(?!b)\" \"aaab\"", "{0 0}", "", false, "search-1240",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a(?!b)\" \"aaab\"", "{0 0} {1 1}", "", false,
    "search-1241",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a(?!b)\" \"xaba\"", "{3 3}", "", false, "search-1242",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a(?!b)\" \"xaba\"", "{3 3}", "", false, "search-1243",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a(?!b)\" \"a\\nb\"", "{0 0}", "", false, "search-1244",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a(?!b)\" \"a\\nb\"", "{0 0}", "", false, "search-1245",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a(?!b)\" \"\\na\"", "{1 1}", "", false, "search-1246",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a(?!b)\" \"\\na\"", "{1 1}", "", false, "search-1247",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a(?!b)\" \"a\\n\"", "{0 0}", "", false, "search-1248",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a(?!b)\" \"a\\n\"", "{0 0}", "", false, "search-1249",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a(?!b)\" \"A B\"", "", "", false, "search-1250",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a(?!b)\" \"A B\"", "", "", false, "search-1251",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a(?!b)\" \"abc 12\"", "", "", false, "search-1252",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a(?!b)\" \"abc 12\"", "", "", false, "search-1253",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a(?!b)\" \"姹夊瓧\"", "", "", false, "search-1254",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a(?!b)\" \"姹夊瓧\"", "", "", false, "search-1255",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a(?!b)\" \"馃榾a\"", "{2 2}", "", false, "search-1256",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a(?!b)\" \"馃榾a\"", "{2 2}", "", false,
    "search-1257",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"a(?!b)\" \"a\\x00b\"", "{0 0}", "", false, "search-1258",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"a(?!b)\" \"a\\x00b\"", "{0 0}", "", false,
    "search-1259",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?=(a))a\" \"\"", "", "", false, "search-1260",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?=(a))a\" \"\"", "", "", false, "search-1261",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?=(a))a\" \"a\"", "{0 0}", "", false, "search-1262",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?=(a))a\" \"a\"", "{0 0}", "", false, "search-1263",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?=(a))a\" \"b\"", "", "", false, "search-1264",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?=(a))a\" \"b\"", "", "", false, "search-1265",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?=(a))a\" \"ab\"", "{0 0}", "", false, "search-1266",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?=(a))a\" \"ab\"", "{0 0}", "", false, "search-1267",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?=(a))a\" \"aba\"", "{0 0}", "", false, "search-1268",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?=(a))a\" \"aba\"", "{0 0} {2 2}", "", false,
    "search-1269",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?=(a))a\" \"aaab\"", "{0 0}", "", false, "search-1270",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?=(a))a\" \"aaab\"", "{0 0} {1 1} {2 2}",
    "", false, "search-1271",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?=(a))a\" \"xaba\"", "{1 1}", "", false, "search-1272",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?=(a))a\" \"xaba\"", "{1 1} {3 3}", "", false,
    "search-1273",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?=(a))a\" \"a\\nb\"", "{0 0}", "", false, "search-1274",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?=(a))a\" \"a\\nb\"", "{0 0}", "", false,
    "search-1275",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?=(a))a\" \"\\na\"", "{1 1}", "", false, "search-1276",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?=(a))a\" \"\\na\"", "{1 1}", "", false,
    "search-1277",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?=(a))a\" \"a\\n\"", "{0 0}", "", false, "search-1278",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?=(a))a\" \"a\\n\"", "{0 0}", "", false,
    "search-1279",
  )
}

///|
test "Tcl regexp cases 1281 through 1320" {
  check_regexp_case(
    "regexp  -inline -indices -- \"(?=(a))a\" \"A B\"", "", "", false, "search-1280",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?=(a))a\" \"A B\"", "", "", false, "search-1281",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?=(a))a\" \"abc 12\"", "{0 0}", "", false, "search-1282",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?=(a))a\" \"abc 12\"", "{0 0}", "", false,
    "search-1283",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?=(a))a\" \"姹夊瓧\"", "", "", false, "search-1284",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?=(a))a\" \"姹夊瓧\"", "", "", false,
    "search-1285",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?=(a))a\" \"馃榾a\"", "{2 2}", "", false, "search-1286",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?=(a))a\" \"馃榾a\"", "{2 2}", "", false,
    "search-1287",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?=(a))a\" \"a\\x00b\"", "{0 0}", "", false, "search-1288",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?=(a))a\" \"a\\x00b\"", "{0 0}", "", false,
    "search-1289",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(ab|a)\\\\1\" \"\"", "", "", false, "search-1290",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(ab|a)\\\\1\" \"\"", "", "", false, "search-1291",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(ab|a)\\\\1\" \"a\"", "", "", false, "search-1292",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(ab|a)\\\\1\" \"a\"", "", "", false, "search-1293",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(ab|a)\\\\1\" \"b\"", "", "", false, "search-1294",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(ab|a)\\\\1\" \"b\"", "", "", false, "search-1295",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(ab|a)\\\\1\" \"ab\"", "", "", false, "search-1296",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(ab|a)\\\\1\" \"ab\"", "", "", false, "search-1297",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(ab|a)\\\\1\" \"aba\"", "", "", false, "search-1298",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(ab|a)\\\\1\" \"aba\"", "", "", false, "search-1299",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(ab|a)\\\\1\" \"aaab\"", "{0 1} {0 0}", "", false,
    "search-1300",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(ab|a)\\\\1\" \"aaab\"", "{0 1} {0 0}", "",
    false, "search-1301",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(ab|a)\\\\1\" \"xaba\"", "", "", false, "search-1302",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(ab|a)\\\\1\" \"xaba\"", "", "", false, "search-1303",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(ab|a)\\\\1\" \"a\\nb\"", "", "", false, "search-1304",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(ab|a)\\\\1\" \"a\\nb\"", "", "", false, "search-1305",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(ab|a)\\\\1\" \"\\na\"", "", "", false, "search-1306",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(ab|a)\\\\1\" \"\\na\"", "", "", false, "search-1307",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(ab|a)\\\\1\" \"a\\n\"", "", "", false, "search-1308",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(ab|a)\\\\1\" \"a\\n\"", "", "", false, "search-1309",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(ab|a)\\\\1\" \"A B\"", "", "", false, "search-1310",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(ab|a)\\\\1\" \"A B\"", "", "", false, "search-1311",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(ab|a)\\\\1\" \"abc 12\"", "", "", false, "search-1312",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(ab|a)\\\\1\" \"abc 12\"", "", "", false,
    "search-1313",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(ab|a)\\\\1\" \"姹夊瓧\"", "", "", false, "search-1314",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(ab|a)\\\\1\" \"姹夊瓧\"", "", "", false,
    "search-1315",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(ab|a)\\\\1\" \"馃榾a\"", "", "", false, "search-1316",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(ab|a)\\\\1\" \"馃榾a\"", "", "", false,
    "search-1317",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(ab|a)\\\\1\" \"a\\x00b\"", "", "", false, "search-1318",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(ab|a)\\\\1\" \"a\\x00b\"", "", "", false,
    "search-1319",
  )
}

///|
test "Tcl regexp cases 1321 through 1360" {
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)\\\\1\" \"\"", "{0 -1} {0 -1}", "", false,
    "search-1320",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)\\\\1\" \"\"", "{0 -1} {0 -1}", "", false,
    "search-1321",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)\\\\1\" \"a\"", "{0 -1} {0 -1}", "", false,
    "search-1322",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)\\\\1\" \"a\"", "{0 -1} {0 -1}", "", false,
    "search-1323",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)\\\\1\" \"b\"", "{0 -1} {0 -1}", "", false,
    "search-1324",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)\\\\1\" \"b\"", "{0 -1} {0 -1}", "", false,
    "search-1325",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)\\\\1\" \"ab\"", "{0 -1} {0 -1}", "", false,
    "search-1326",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)\\\\1\" \"ab\"", "{0 -1} {0 -1} {1 0} {1 0}",
    "", false, "search-1327",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)\\\\1\" \"aba\"", "{0 -1} {0 -1}", "", false,
    "search-1328",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)\\\\1\" \"aba\"", "{0 -1} {0 -1} {1 0} {1 0} {2 1} {2 1}",
    "", false, "search-1329",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)\\\\1\" \"aaab\"", "{0 1} {0 0}", "", false,
    "search-1330",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)\\\\1\" \"aaab\"", "{0 1} {0 0} {2 1} {2 1} {3 2} {3 2}",
    "", false, "search-1331",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)\\\\1\" \"xaba\"", "{0 -1} {0 -1}", "", false,
    "search-1332",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)\\\\1\" \"xaba\"", "{0 -1} {0 -1} {1 0} {1 0} {2 1} {2 1} {3 2} {3 2}",
    "", false, "search-1333",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)\\\\1\" \"a\\nb\"", "{0 -1} {0 -1}", "", false,
    "search-1334",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)\\\\1\" \"a\\nb\"", "{0 -1} {0 -1} {1 0} {1 0} {2 1} {2 1}",
    "", false, "search-1335",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)\\\\1\" \"\\na\"", "{0 -1} {0 -1}", "", false,
    "search-1336",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)\\\\1\" \"\\na\"", "{0 -1} {0 -1} {1 0} {1 0}",
    "", false, "search-1337",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)\\\\1\" \"a\\n\"", "{0 -1} {0 -1}", "", false,
    "search-1338",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)\\\\1\" \"a\\n\"", "{0 -1} {0 -1} {1 0} {1 0}",
    "", false, "search-1339",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)\\\\1\" \"A B\"", "{0 -1} {0 -1}", "", false,
    "search-1340",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)\\\\1\" \"A B\"", "{0 -1} {0 -1} {1 0} {1 0} {2 1} {2 1}",
    "", false, "search-1341",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)\\\\1\" \"abc 12\"", "{0 -1} {0 -1}", "",
    false, "search-1342",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)\\\\1\" \"abc 12\"", "{0 -1} {0 -1} {1 0} {1 0} {2 1} {2 1} {3 2} {3 2} {4 3} {4 3} {5 4} {5 4}",
    "", false, "search-1343",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)\\\\1\" \"姹夊瓧\"", "{0 -1} {0 -1}", "",
    false, "search-1344",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)\\\\1\" \"姹夊瓧\"", "{0 -1} {0 -1} {1 0} {1 0} {2 1} {2 1}",
    "", false, "search-1345",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)\\\\1\" \"馃榾a\"", "{0 -1} {0 -1}", "",
    false, "search-1346",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)\\\\1\" \"馃榾a\"", "{0 -1} {0 -1} {1 0} {1 0} {2 1} {2 1}",
    "", false, "search-1347",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(a*)\\\\1\" \"a\\x00b\"", "{0 -1} {0 -1}", "",
    false, "search-1348",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(a*)\\\\1\" \"a\\x00b\"", "{0 -1} {0 -1} {1 0} {1 0} {2 1} {2 1}",
    "", false, "search-1349",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?i)a\" \"\"", "", "", false, "search-1350",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?i)a\" \"\"", "", "", false, "search-1351",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?i)a\" \"a\"", "{0 0}", "", false, "search-1352",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?i)a\" \"a\"", "{0 0}", "", false, "search-1353",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?i)a\" \"b\"", "", "", false, "search-1354",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?i)a\" \"b\"", "", "", false, "search-1355",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?i)a\" \"ab\"", "{0 0}", "", false, "search-1356",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?i)a\" \"ab\"", "{0 0}", "", false, "search-1357",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?i)a\" \"aba\"", "{0 0}", "", false, "search-1358",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?i)a\" \"aba\"", "{0 0} {2 2}", "", false,
    "search-1359",
  )
}

///|
test "Tcl regexp cases 1361 through 1400" {
  check_regexp_case(
    "regexp  -inline -indices -- \"(?i)a\" \"aaab\"", "{0 0}", "", false, "search-1360",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?i)a\" \"aaab\"", "{0 0} {1 1} {2 2}", "",
    false, "search-1361",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?i)a\" \"xaba\"", "{1 1}", "", false, "search-1362",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?i)a\" \"xaba\"", "{1 1} {3 3}", "", false,
    "search-1363",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?i)a\" \"a\\nb\"", "{0 0}", "", false, "search-1364",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?i)a\" \"a\\nb\"", "{0 0}", "", false, "search-1365",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?i)a\" \"\\na\"", "{1 1}", "", false, "search-1366",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?i)a\" \"\\na\"", "{1 1}", "", false, "search-1367",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?i)a\" \"a\\n\"", "{0 0}", "", false, "search-1368",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?i)a\" \"a\\n\"", "{0 0}", "", false, "search-1369",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?i)a\" \"A B\"", "{0 0}", "", false, "search-1370",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?i)a\" \"A B\"", "{0 0}", "", false, "search-1371",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?i)a\" \"abc 12\"", "{0 0}", "", false, "search-1372",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?i)a\" \"abc 12\"", "{0 0}", "", false, "search-1373",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?i)a\" \"姹夊瓧\"", "", "", false, "search-1374",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?i)a\" \"姹夊瓧\"", "", "", false, "search-1375",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?i)a\" \"馃榾a\"", "{2 2}", "", false, "search-1376",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?i)a\" \"馃榾a\"", "{2 2}", "", false,
    "search-1377",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?i)a\" \"a\\x00b\"", "{0 0}", "", false, "search-1378",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?i)a\" \"a\\x00b\"", "{0 0}", "", false,
    "search-1379",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?n)^a.\\$\" \"\"", "", "", false, "search-1380",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?n)^a.\\$\" \"\"", "", "", false, "search-1381",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?n)^a.\\$\" \"a\"", "", "", false, "search-1382",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?n)^a.\\$\" \"a\"", "", "", false, "search-1383",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?n)^a.\\$\" \"b\"", "", "", false, "search-1384",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?n)^a.\\$\" \"b\"", "", "", false, "search-1385",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?n)^a.\\$\" \"ab\"", "{0 1}", "", false, "search-1386",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?n)^a.\\$\" \"ab\"", "{0 1}", "", false,
    "search-1387",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?n)^a.\\$\" \"aba\"", "", "", false, "search-1388",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?n)^a.\\$\" \"aba\"", "", "", false, "search-1389",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?n)^a.\\$\" \"aaab\"", "", "", false, "search-1390",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?n)^a.\\$\" \"aaab\"", "", "", false, "search-1391",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?n)^a.\\$\" \"xaba\"", "", "", false, "search-1392",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?n)^a.\\$\" \"xaba\"", "", "", false, "search-1393",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?n)^a.\\$\" \"a\\nb\"", "", "", false, "search-1394",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?n)^a.\\$\" \"a\\nb\"", "", "", false, "search-1395",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?n)^a.\\$\" \"\\na\"", "", "", false, "search-1396",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?n)^a.\\$\" \"\\na\"", "", "", false, "search-1397",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?n)^a.\\$\" \"a\\n\"", "", "", false, "search-1398",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?n)^a.\\$\" \"a\\n\"", "", "", false, "search-1399",
  )
}

///|
test "Tcl regexp cases 1401 through 1440" {
  check_regexp_case(
    "regexp  -inline -indices -- \"(?n)^a.\\$\" \"A B\"", "", "", false, "search-1400",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?n)^a.\\$\" \"A B\"", "", "", false, "search-1401",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?n)^a.\\$\" \"abc 12\"", "", "", false, "search-1402",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?n)^a.\\$\" \"abc 12\"", "", "", false, "search-1403",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?n)^a.\\$\" \"姹夊瓧\"", "", "", false, "search-1404",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?n)^a.\\$\" \"姹夊瓧\"", "", "", false,
    "search-1405",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?n)^a.\\$\" \"馃榾a\"", "", "", false, "search-1406",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?n)^a.\\$\" \"馃榾a\"", "", "", false,
    "search-1407",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?n)^a.\\$\" \"a\\x00b\"", "", "", false, "search-1408",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?n)^a.\\$\" \"a\\x00b\"", "", "", false,
    "search-1409",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?x)a b\" \"\"", "", "", false, "search-1410",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?x)a b\" \"\"", "", "", false, "search-1411",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?x)a b\" \"a\"", "", "", false, "search-1412",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?x)a b\" \"a\"", "", "", false, "search-1413",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?x)a b\" \"b\"", "", "", false, "search-1414",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?x)a b\" \"b\"", "", "", false, "search-1415",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?x)a b\" \"ab\"", "{0 1}", "", false, "search-1416",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?x)a b\" \"ab\"", "{0 1}", "", false, "search-1417",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?x)a b\" \"aba\"", "{0 1}", "", false, "search-1418",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?x)a b\" \"aba\"", "{0 1}", "", false, "search-1419",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?x)a b\" \"aaab\"", "{2 3}", "", false, "search-1420",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?x)a b\" \"aaab\"", "{2 3}", "", false, "search-1421",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?x)a b\" \"xaba\"", "{1 2}", "", false, "search-1422",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?x)a b\" \"xaba\"", "{1 2}", "", false, "search-1423",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?x)a b\" \"a\\nb\"", "", "", false, "search-1424",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?x)a b\" \"a\\nb\"", "", "", false, "search-1425",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?x)a b\" \"\\na\"", "", "", false, "search-1426",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?x)a b\" \"\\na\"", "", "", false, "search-1427",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?x)a b\" \"a\\n\"", "", "", false, "search-1428",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?x)a b\" \"a\\n\"", "", "", false, "search-1429",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?x)a b\" \"A B\"", "", "", false, "search-1430",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?x)a b\" \"A B\"", "", "", false, "search-1431",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?x)a b\" \"abc 12\"", "{0 1}", "", false, "search-1432",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?x)a b\" \"abc 12\"", "{0 1}", "", false,
    "search-1433",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?x)a b\" \"姹夊瓧\"", "", "", false, "search-1434",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?x)a b\" \"姹夊瓧\"", "", "", false, "search-1435",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?x)a b\" \"馃榾a\"", "", "", false, "search-1436",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?x)a b\" \"馃榾a\"", "", "", false, "search-1437",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?x)a b\" \"a\\x00b\"", "", "", false, "search-1438",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?x)a b\" \"a\\x00b\"", "", "", false, "search-1439",
  )
}

///|
test "Tcl regexp cases 1441 through 1480" {
  check_regexp_case(
    "regexp  -inline -indices -- \"(?q)a.b\" \"\"", "", "", false, "search-1440",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?q)a.b\" \"\"", "", "", false, "search-1441",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?q)a.b\" \"a\"", "", "", false, "search-1442",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?q)a.b\" \"a\"", "", "", false, "search-1443",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?q)a.b\" \"b\"", "", "", false, "search-1444",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?q)a.b\" \"b\"", "", "", false, "search-1445",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?q)a.b\" \"ab\"", "", "", false, "search-1446",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?q)a.b\" \"ab\"", "", "", false, "search-1447",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?q)a.b\" \"aba\"", "", "", false, "search-1448",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?q)a.b\" \"aba\"", "", "", false, "search-1449",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?q)a.b\" \"aaab\"", "", "", false, "search-1450",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?q)a.b\" \"aaab\"", "", "", false, "search-1451",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?q)a.b\" \"xaba\"", "", "", false, "search-1452",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?q)a.b\" \"xaba\"", "", "", false, "search-1453",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?q)a.b\" \"a\\nb\"", "", "", false, "search-1454",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?q)a.b\" \"a\\nb\"", "", "", false, "search-1455",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?q)a.b\" \"\\na\"", "", "", false, "search-1456",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?q)a.b\" \"\\na\"", "", "", false, "search-1457",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?q)a.b\" \"a\\n\"", "", "", false, "search-1458",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?q)a.b\" \"a\\n\"", "", "", false, "search-1459",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?q)a.b\" \"A B\"", "", "", false, "search-1460",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?q)a.b\" \"A B\"", "", "", false, "search-1461",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?q)a.b\" \"abc 12\"", "", "", false, "search-1462",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?q)a.b\" \"abc 12\"", "", "", false, "search-1463",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?q)a.b\" \"姹夊瓧\"", "", "", false, "search-1464",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?q)a.b\" \"姹夊瓧\"", "", "", false, "search-1465",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?q)a.b\" \"馃榾a\"", "", "", false, "search-1466",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?q)a.b\" \"馃榾a\"", "", "", false, "search-1467",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?q)a.b\" \"a\\x00b\"", "", "", false, "search-1468",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?q)a.b\" \"a\\x00b\"", "", "", false, "search-1469",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"***=a.b\" \"\"", "", "", false, "search-1470",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"***=a.b\" \"\"", "", "", false, "search-1471",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"***=a.b\" \"a\"", "", "", false, "search-1472",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"***=a.b\" \"a\"", "", "", false, "search-1473",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"***=a.b\" \"b\"", "", "", false, "search-1474",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"***=a.b\" \"b\"", "", "", false, "search-1475",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"***=a.b\" \"ab\"", "", "", false, "search-1476",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"***=a.b\" \"ab\"", "", "", false, "search-1477",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"***=a.b\" \"aba\"", "", "", false, "search-1478",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"***=a.b\" \"aba\"", "", "", false, "search-1479",
  )
}

///|
test "Tcl regexp cases 1481 through 1520" {
  check_regexp_case(
    "regexp  -inline -indices -- \"***=a.b\" \"aaab\"", "", "", false, "search-1480",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"***=a.b\" \"aaab\"", "", "", false, "search-1481",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"***=a.b\" \"xaba\"", "", "", false, "search-1482",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"***=a.b\" \"xaba\"", "", "", false, "search-1483",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"***=a.b\" \"a\\nb\"", "", "", false, "search-1484",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"***=a.b\" \"a\\nb\"", "", "", false, "search-1485",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"***=a.b\" \"\\na\"", "", "", false, "search-1486",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"***=a.b\" \"\\na\"", "", "", false, "search-1487",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"***=a.b\" \"a\\n\"", "", "", false, "search-1488",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"***=a.b\" \"a\\n\"", "", "", false, "search-1489",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"***=a.b\" \"A B\"", "", "", false, "search-1490",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"***=a.b\" \"A B\"", "", "", false, "search-1491",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"***=a.b\" \"abc 12\"", "", "", false, "search-1492",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"***=a.b\" \"abc 12\"", "", "", false, "search-1493",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"***=a.b\" \"姹夊瓧\"", "", "", false, "search-1494",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"***=a.b\" \"姹夊瓧\"", "", "", false, "search-1495",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"***=a.b\" \"馃榾a\"", "", "", false, "search-1496",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"***=a.b\" \"馃榾a\"", "", "", false, "search-1497",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"***=a.b\" \"a\\x00b\"", "", "", false, "search-1498",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"***=a.b\" \"a\\x00b\"", "", "", false, "search-1499",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?b)\\\\(a\\\\)\\\\1\" \"\"", "", "", false, "search-1500",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?b)\\\\(a\\\\)\\\\1\" \"\"", "", "", false,
    "search-1501",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?b)\\\\(a\\\\)\\\\1\" \"a\"", "", "", false,
    "search-1502",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?b)\\\\(a\\\\)\\\\1\" \"a\"", "", "", false,
    "search-1503",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?b)\\\\(a\\\\)\\\\1\" \"b\"", "", "", false,
    "search-1504",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?b)\\\\(a\\\\)\\\\1\" \"b\"", "", "", false,
    "search-1505",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?b)\\\\(a\\\\)\\\\1\" \"ab\"", "", "", false,
    "search-1506",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?b)\\\\(a\\\\)\\\\1\" \"ab\"", "", "", false,
    "search-1507",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?b)\\\\(a\\\\)\\\\1\" \"aba\"", "", "", false,
    "search-1508",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?b)\\\\(a\\\\)\\\\1\" \"aba\"", "", "", false,
    "search-1509",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?b)\\\\(a\\\\)\\\\1\" \"aaab\"", "{0 1} {0 0}",
    "", false, "search-1510",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?b)\\\\(a\\\\)\\\\1\" \"aaab\"", "{0 1} {0 0}",
    "", false, "search-1511",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?b)\\\\(a\\\\)\\\\1\" \"xaba\"", "", "", false,
    "search-1512",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?b)\\\\(a\\\\)\\\\1\" \"xaba\"", "", "",
    false, "search-1513",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?b)\\\\(a\\\\)\\\\1\" \"a\\nb\"", "", "", false,
    "search-1514",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?b)\\\\(a\\\\)\\\\1\" \"a\\nb\"", "", "",
    false, "search-1515",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?b)\\\\(a\\\\)\\\\1\" \"\\na\"", "", "", false,
    "search-1516",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?b)\\\\(a\\\\)\\\\1\" \"\\na\"", "", "",
    false, "search-1517",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?b)\\\\(a\\\\)\\\\1\" \"a\\n\"", "", "", false,
    "search-1518",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?b)\\\\(a\\\\)\\\\1\" \"a\\n\"", "", "",
    false, "search-1519",
  )
}

///|
test "Tcl regexp cases 1521 through 1560" {
  check_regexp_case(
    "regexp  -inline -indices -- \"(?b)\\\\(a\\\\)\\\\1\" \"A B\"", "", "", false,
    "search-1520",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?b)\\\\(a\\\\)\\\\1\" \"A B\"", "", "", false,
    "search-1521",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?b)\\\\(a\\\\)\\\\1\" \"abc 12\"", "", "", false,
    "search-1522",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?b)\\\\(a\\\\)\\\\1\" \"abc 12\"", "", "",
    false, "search-1523",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?b)\\\\(a\\\\)\\\\1\" \"姹夊瓧\"", "", "",
    false, "search-1524",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?b)\\\\(a\\\\)\\\\1\" \"姹夊瓧\"", "",
    "", false, "search-1525",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?b)\\\\(a\\\\)\\\\1\" \"馃榾a\"", "", "", false,
    "search-1526",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?b)\\\\(a\\\\)\\\\1\" \"馃榾a\"", "", "",
    false, "search-1527",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?b)\\\\(a\\\\)\\\\1\" \"a\\x00b\"", "", "", false,
    "search-1528",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?b)\\\\(a\\\\)\\\\1\" \"a\\x00b\"", "", "",
    false, "search-1529",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?e)(a|b)+\" \"\"", "", "", false, "search-1530",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?e)(a|b)+\" \"\"", "", "", false, "search-1531",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?e)(a|b)+\" \"a\"", "{0 0} {0 0}", "", false,
    "search-1532",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?e)(a|b)+\" \"a\"", "{0 0} {0 0}", "", false,
    "search-1533",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?e)(a|b)+\" \"b\"", "{0 0} {0 0}", "", false,
    "search-1534",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?e)(a|b)+\" \"b\"", "{0 0} {0 0}", "", false,
    "search-1535",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?e)(a|b)+\" \"ab\"", "{0 1} {1 1}", "", false,
    "search-1536",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?e)(a|b)+\" \"ab\"", "{0 1} {1 1}", "", false,
    "search-1537",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?e)(a|b)+\" \"aba\"", "{0 2} {2 2}", "", false,
    "search-1538",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?e)(a|b)+\" \"aba\"", "{0 2} {2 2}", "",
    false, "search-1539",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?e)(a|b)+\" \"aaab\"", "{0 3} {3 3}", "", false,
    "search-1540",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?e)(a|b)+\" \"aaab\"", "{0 3} {3 3}", "",
    false, "search-1541",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?e)(a|b)+\" \"xaba\"", "{1 3} {3 3}", "", false,
    "search-1542",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?e)(a|b)+\" \"xaba\"", "{1 3} {3 3}", "",
    false, "search-1543",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?e)(a|b)+\" \"a\\nb\"", "{0 0} {0 0}", "", false,
    "search-1544",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?e)(a|b)+\" \"a\\nb\"", "{0 0} {0 0} {2 2} {2 2}",
    "", false, "search-1545",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?e)(a|b)+\" \"\\na\"", "{1 1} {1 1}", "", false,
    "search-1546",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?e)(a|b)+\" \"\\na\"", "{1 1} {1 1}", "",
    false, "search-1547",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?e)(a|b)+\" \"a\\n\"", "{0 0} {0 0}", "", false,
    "search-1548",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?e)(a|b)+\" \"a\\n\"", "{0 0} {0 0}", "",
    false, "search-1549",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?e)(a|b)+\" \"A B\"", "", "", false, "search-1550",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?e)(a|b)+\" \"A B\"", "", "", false, "search-1551",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?e)(a|b)+\" \"abc 12\"", "{0 1} {1 1}", "", false,
    "search-1552",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?e)(a|b)+\" \"abc 12\"", "{0 1} {1 1}", "",
    false, "search-1553",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?e)(a|b)+\" \"姹夊瓧\"", "", "", false, "search-1554",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?e)(a|b)+\" \"姹夊瓧\"", "", "", false,
    "search-1555",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?e)(a|b)+\" \"馃榾a\"", "{2 2} {2 2}", "",
    false, "search-1556",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?e)(a|b)+\" \"馃榾a\"", "{2 2} {2 2}",
    "", false, "search-1557",
  )
  check_regexp_case(
    "regexp  -inline -indices -- \"(?e)(a|b)+\" \"a\\x00b\"", "{0 0} {0 0}", "",
    false, "search-1558",
  )
  check_regexp_case(
    "regexp -all -inline -indices -- \"(?e)(a|b)+\" \"a\\x00b\"", "{0 0} {0 0} {2 2} {2 2}",
    "", false, "search-1559",
  )
}

///|
test "Tcl regexp cases 1561 through 1600" {
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"\" \"\"", "{0 -1}", "", false, "start-1560",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"\" \"\"", "{0 -1}", "", false, "start-1561",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"\" \"\"", "{1 0}", "", false, "start-1562",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"\" \"\"", "{2 1}", "", false, "start-1563",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"\" \"\"", "{3 2}", "", false, "start-1564",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"\" \"\"", "{4 3}", "", false, "start-1565",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"\" \"\"", "{100 99}", "", false,
    "start-1566",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"\" \"\"", "{0 -1}", "", false,
    "start-1567",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"\" \"\"", "{0 -1}", "", false,
    "start-1568",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"\" \"\"", "{1 0}", "", false,
    "start-1569",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"\" \"\"", "{0 -1}", "", false,
    "start-1570",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"\" \"\"", "{0 -1}", "", false,
    "start-1571",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"\" \"\"", "{1 0}", "", false,
    "start-1572",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"\" \"\"", "{2 1}", "", false,
    "start-1573",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"\" \"\"", "{3 2}", "", false,
    "start-1574",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"\" \"\"", "{4 3}", "", false,
    "start-1575",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"\" \"\"", "{100 99}", "", false,
    "start-1576",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"\" \"\"", "{0 -1}", "", false,
    "start-1577",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"\" \"\"", "{0 -1}", "", false,
    "start-1578",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"\" \"\"", "{1 0}", "", false,
    "start-1579",
  )
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"\" \"a\"", "{0 -1}", "", false,
    "start-1580",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"\" \"a\"", "{0 -1}", "", false, "start-1581",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"\" \"a\"", "{1 0}", "", false, "start-1582",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"\" \"a\"", "{2 1}", "", false, "start-1583",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"\" \"a\"", "{3 2}", "", false, "start-1584",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"\" \"a\"", "{4 3}", "", false, "start-1585",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"\" \"a\"", "{100 99}", "", false,
    "start-1586",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"\" \"a\"", "{1 0}", "", false,
    "start-1587",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"\" \"a\"", "{0 -1}", "", false,
    "start-1588",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"\" \"a\"", "{2 1}", "", false,
    "start-1589",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"\" \"a\"", "{0 -1}", "", false,
    "start-1590",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"\" \"a\"", "{0 -1}", "", false,
    "start-1591",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"\" \"a\"", "{1 0}", "", false,
    "start-1592",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"\" \"a\"", "{2 1}", "", false,
    "start-1593",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"\" \"a\"", "{3 2}", "", false,
    "start-1594",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"\" \"a\"", "{4 3}", "", false,
    "start-1595",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"\" \"a\"", "{100 99}", "",
    false, "start-1596",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"\" \"a\"", "{1 0}", "", false,
    "start-1597",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"\" \"a\"", "{0 -1}", "",
    false, "start-1598",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"\" \"a\"", "{2 1}", "", false,
    "start-1599",
  )
}

///|
test "Tcl regexp cases 1601 through 1640" {
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"\" \"aba\"", "{0 -1}", "", false,
    "start-1600",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"\" \"aba\"", "{0 -1}", "", false,
    "start-1601",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"\" \"aba\"", "{1 0}", "", false,
    "start-1602",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"\" \"aba\"", "{2 1}", "", false,
    "start-1603",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"\" \"aba\"", "{3 2}", "", false,
    "start-1604",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"\" \"aba\"", "{4 3}", "", false,
    "start-1605",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"\" \"aba\"", "{100 99}", "", false,
    "start-1606",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"\" \"aba\"", "{3 2}", "", false,
    "start-1607",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"\" \"aba\"", "{2 1}", "", false,
    "start-1608",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"\" \"aba\"", "{4 3}", "", false,
    "start-1609",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"\" \"aba\"", "{0 -1} {1 0} {2 1}",
    "", false, "start-1610",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"\" \"aba\"", "{0 -1} {1 0} {2 1}",
    "", false, "start-1611",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"\" \"aba\"", "{1 0} {2 1}", "",
    false, "start-1612",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"\" \"aba\"", "{2 1}", "", false,
    "start-1613",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"\" \"aba\"", "{3 2}", "", false,
    "start-1614",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"\" \"aba\"", "{4 3}", "", false,
    "start-1615",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"\" \"aba\"", "{100 99}", "",
    false, "start-1616",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"\" \"aba\"", "{3 2}", "", false,
    "start-1617",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"\" \"aba\"", "{2 1}", "",
    false, "start-1618",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"\" \"aba\"", "{4 3}", "",
    false, "start-1619",
  )
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"\" \"abc\"", "{0 -1}", "", false,
    "start-1620",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"\" \"abc\"", "{0 -1}", "", false,
    "start-1621",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"\" \"abc\"", "{1 0}", "", false,
    "start-1622",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"\" \"abc\"", "{2 1}", "", false,
    "start-1623",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"\" \"abc\"", "{3 2}", "", false,
    "start-1624",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"\" \"abc\"", "{4 3}", "", false,
    "start-1625",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"\" \"abc\"", "{100 99}", "", false,
    "start-1626",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"\" \"abc\"", "{3 2}", "", false,
    "start-1627",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"\" \"abc\"", "{2 1}", "", false,
    "start-1628",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"\" \"abc\"", "{4 3}", "", false,
    "start-1629",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"\" \"abc\"", "{0 -1} {1 0} {2 1}",
    "", false, "start-1630",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"\" \"abc\"", "{0 -1} {1 0} {2 1}",
    "", false, "start-1631",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"\" \"abc\"", "{1 0} {2 1}", "",
    false, "start-1632",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"\" \"abc\"", "{2 1}", "", false,
    "start-1633",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"\" \"abc\"", "{3 2}", "", false,
    "start-1634",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"\" \"abc\"", "{4 3}", "", false,
    "start-1635",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"\" \"abc\"", "{100 99}", "",
    false, "start-1636",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"\" \"abc\"", "{3 2}", "", false,
    "start-1637",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"\" \"abc\"", "{2 1}", "",
    false, "start-1638",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"\" \"abc\"", "{4 3}", "",
    false, "start-1639",
  )
}

///|
test "Tcl regexp cases 1641 through 1680" {
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"\" \"a\\nb\"", "{0 -1}", "", false,
    "start-1640",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"\" \"a\\nb\"", "{0 -1}", "", false,
    "start-1641",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"\" \"a\\nb\"", "{1 0}", "", false,
    "start-1642",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"\" \"a\\nb\"", "{2 1}", "", false,
    "start-1643",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"\" \"a\\nb\"", "{3 2}", "", false,
    "start-1644",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"\" \"a\\nb\"", "{4 3}", "", false,
    "start-1645",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"\" \"a\\nb\"", "{100 99}", "",
    false, "start-1646",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"\" \"a\\nb\"", "{3 2}", "", false,
    "start-1647",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"\" \"a\\nb\"", "{2 1}", "", false,
    "start-1648",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"\" \"a\\nb\"", "{4 3}", "", false,
    "start-1649",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"\" \"a\\nb\"", "{0 -1} {1 0} {2 1}",
    "", false, "start-1650",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"\" \"a\\nb\"", "{0 -1} {1 0} {2 1}",
    "", false, "start-1651",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"\" \"a\\nb\"", "{1 0} {2 1}",
    "", false, "start-1652",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"\" \"a\\nb\"", "{2 1}", "", false,
    "start-1653",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"\" \"a\\nb\"", "{3 2}", "", false,
    "start-1654",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"\" \"a\\nb\"", "{4 3}", "", false,
    "start-1655",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"\" \"a\\nb\"", "{100 99}",
    "", false, "start-1656",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"\" \"a\\nb\"", "{3 2}", "",
    false, "start-1657",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"\" \"a\\nb\"", "{2 1}", "",
    false, "start-1658",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"\" \"a\\nb\"", "{4 3}", "",
    false, "start-1659",
  )
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"\" \"a\\n\"", "{0 -1}", "", false,
    "start-1660",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"\" \"a\\n\"", "{0 -1}", "", false,
    "start-1661",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"\" \"a\\n\"", "{1 0}", "", false,
    "start-1662",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"\" \"a\\n\"", "{2 1}", "", false,
    "start-1663",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"\" \"a\\n\"", "{3 2}", "", false,
    "start-1664",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"\" \"a\\n\"", "{4 3}", "", false,
    "start-1665",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"\" \"a\\n\"", "{100 99}", "", false,
    "start-1666",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"\" \"a\\n\"", "{2 1}", "", false,
    "start-1667",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"\" \"a\\n\"", "{1 0}", "", false,
    "start-1668",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"\" \"a\\n\"", "{3 2}", "", false,
    "start-1669",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"\" \"a\\n\"", "{0 -1} {1 0}",
    "", false, "start-1670",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"\" \"a\\n\"", "{0 -1} {1 0}",
    "", false, "start-1671",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"\" \"a\\n\"", "{1 0}", "", false,
    "start-1672",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"\" \"a\\n\"", "{2 1}", "", false,
    "start-1673",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"\" \"a\\n\"", "{3 2}", "", false,
    "start-1674",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"\" \"a\\n\"", "{4 3}", "", false,
    "start-1675",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"\" \"a\\n\"", "{100 99}", "",
    false, "start-1676",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"\" \"a\\n\"", "{2 1}", "",
    false, "start-1677",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"\" \"a\\n\"", "{1 0}", "",
    false, "start-1678",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"\" \"a\\n\"", "{3 2}", "",
    false, "start-1679",
  )
}

///|
test "Tcl regexp cases 1681 through 1720" {
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"()\" \"\"", "{0 -1} {0 -1}", "",
    false, "start-1680",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"()\" \"\"", "{0 -1} {0 -1}", "",
    false, "start-1681",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"()\" \"\"", "{1 0} {1 0}", "", false,
    "start-1682",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"()\" \"\"", "{2 1} {2 1}", "", false,
    "start-1683",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"()\" \"\"", "{3 2} {3 2}", "", false,
    "start-1684",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"()\" \"\"", "{4 3} {4 3}", "", false,
    "start-1685",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"()\" \"\"", "{100 99} {100 99}",
    "", false, "start-1686",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"()\" \"\"", "{0 -1} {0 -1}", "",
    false, "start-1687",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"()\" \"\"", "{0 -1} {0 -1}",
    "", false, "start-1688",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"()\" \"\"", "{1 0} {1 0}", "",
    false, "start-1689",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"()\" \"\"", "{0 -1} {0 -1}",
    "", false, "start-1690",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"()\" \"\"", "{0 -1} {0 -1}",
    "", false, "start-1691",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"()\" \"\"", "{1 0} {1 0}", "",
    false, "start-1692",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"()\" \"\"", "{2 1} {2 1}", "",
    false, "start-1693",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"()\" \"\"", "{3 2} {3 2}", "",
    false, "start-1694",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"()\" \"\"", "{4 3} {4 3}", "",
    false, "start-1695",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"()\" \"\"", "{100 99} {100 99}",
    "", false, "start-1696",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"()\" \"\"", "{0 -1} {0 -1}",
    "", false, "start-1697",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"()\" \"\"", "{0 -1} {0 -1}",
    "", false, "start-1698",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"()\" \"\"", "{1 0} {1 0}",
    "", false, "start-1699",
  )
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"()\" \"a\"", "{0 -1} {0 -1}", "",
    false, "start-1700",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"()\" \"a\"", "{0 -1} {0 -1}", "",
    false, "start-1701",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"()\" \"a\"", "{1 0} {1 0}", "", false,
    "start-1702",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"()\" \"a\"", "{2 1} {2 1}", "", false,
    "start-1703",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"()\" \"a\"", "{3 2} {3 2}", "", false,
    "start-1704",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"()\" \"a\"", "{4 3} {4 3}", "", false,
    "start-1705",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"()\" \"a\"", "{100 99} {100 99}",
    "", false, "start-1706",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"()\" \"a\"", "{1 0} {1 0}", "",
    false, "start-1707",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"()\" \"a\"", "{0 -1} {0 -1}",
    "", false, "start-1708",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"()\" \"a\"", "{2 1} {2 1}", "",
    false, "start-1709",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"()\" \"a\"", "{0 -1} {0 -1}",
    "", false, "start-1710",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"()\" \"a\"", "{0 -1} {0 -1}",
    "", false, "start-1711",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"()\" \"a\"", "{1 0} {1 0}", "",
    false, "start-1712",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"()\" \"a\"", "{2 1} {2 1}", "",
    false, "start-1713",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"()\" \"a\"", "{3 2} {3 2}", "",
    false, "start-1714",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"()\" \"a\"", "{4 3} {4 3}", "",
    false, "start-1715",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"()\" \"a\"", "{100 99} {100 99}",
    "", false, "start-1716",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"()\" \"a\"", "{1 0} {1 0}",
    "", false, "start-1717",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"()\" \"a\"", "{0 -1} {0 -1}",
    "", false, "start-1718",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"()\" \"a\"", "{2 1} {2 1}",
    "", false, "start-1719",
  )
}

///|
test "Tcl regexp cases 1721 through 1760" {
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"()\" \"aba\"", "{0 -1} {0 -1}",
    "", false, "start-1720",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"()\" \"aba\"", "{0 -1} {0 -1}", "",
    false, "start-1721",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"()\" \"aba\"", "{1 0} {1 0}", "",
    false, "start-1722",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"()\" \"aba\"", "{2 1} {2 1}", "",
    false, "start-1723",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"()\" \"aba\"", "{3 2} {3 2}", "",
    false, "start-1724",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"()\" \"aba\"", "{4 3} {4 3}", "",
    false, "start-1725",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"()\" \"aba\"", "{100 99} {100 99}",
    "", false, "start-1726",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"()\" \"aba\"", "{3 2} {3 2}", "",
    false, "start-1727",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"()\" \"aba\"", "{2 1} {2 1}",
    "", false, "start-1728",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"()\" \"aba\"", "{4 3} {4 3}",
    "", false, "start-1729",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"()\" \"aba\"", "{0 -1} {0 -1} {1 0} {1 0} {2 1} {2 1}",
    "", false, "start-1730",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"()\" \"aba\"", "{0 -1} {0 -1} {1 0} {1 0} {2 1} {2 1}",
    "", false, "start-1731",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"()\" \"aba\"", "{1 0} {1 0} {2 1} {2 1}",
    "", false, "start-1732",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"()\" \"aba\"", "{2 1} {2 1}",
    "", false, "start-1733",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"()\" \"aba\"", "{3 2} {3 2}",
    "", false, "start-1734",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"()\" \"aba\"", "{4 3} {4 3}",
    "", false, "start-1735",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"()\" \"aba\"", "{100 99} {100 99}",
    "", false, "start-1736",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"()\" \"aba\"", "{3 2} {3 2}",
    "", false, "start-1737",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"()\" \"aba\"", "{2 1} {2 1}",
    "", false, "start-1738",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"()\" \"aba\"", "{4 3} {4 3}",
    "", false, "start-1739",
  )
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"()\" \"abc\"", "{0 -1} {0 -1}",
    "", false, "start-1740",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"()\" \"abc\"", "{0 -1} {0 -1}", "",
    false, "start-1741",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"()\" \"abc\"", "{1 0} {1 0}", "",
    false, "start-1742",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"()\" \"abc\"", "{2 1} {2 1}", "",
    false, "start-1743",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"()\" \"abc\"", "{3 2} {3 2}", "",
    false, "start-1744",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"()\" \"abc\"", "{4 3} {4 3}", "",
    false, "start-1745",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"()\" \"abc\"", "{100 99} {100 99}",
    "", false, "start-1746",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"()\" \"abc\"", "{3 2} {3 2}", "",
    false, "start-1747",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"()\" \"abc\"", "{2 1} {2 1}",
    "", false, "start-1748",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"()\" \"abc\"", "{4 3} {4 3}",
    "", false, "start-1749",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"()\" \"abc\"", "{0 -1} {0 -1} {1 0} {1 0} {2 1} {2 1}",
    "", false, "start-1750",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"()\" \"abc\"", "{0 -1} {0 -1} {1 0} {1 0} {2 1} {2 1}",
    "", false, "start-1751",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"()\" \"abc\"", "{1 0} {1 0} {2 1} {2 1}",
    "", false, "start-1752",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"()\" \"abc\"", "{2 1} {2 1}",
    "", false, "start-1753",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"()\" \"abc\"", "{3 2} {3 2}",
    "", false, "start-1754",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"()\" \"abc\"", "{4 3} {4 3}",
    "", false, "start-1755",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"()\" \"abc\"", "{100 99} {100 99}",
    "", false, "start-1756",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"()\" \"abc\"", "{3 2} {3 2}",
    "", false, "start-1757",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"()\" \"abc\"", "{2 1} {2 1}",
    "", false, "start-1758",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"()\" \"abc\"", "{4 3} {4 3}",
    "", false, "start-1759",
  )
}

///|
test "Tcl regexp cases 1761 through 1800" {
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"()\" \"a\\nb\"", "{0 -1} {0 -1}",
    "", false, "start-1760",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"()\" \"a\\nb\"", "{0 -1} {0 -1}",
    "", false, "start-1761",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"()\" \"a\\nb\"", "{1 0} {1 0}", "",
    false, "start-1762",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"()\" \"a\\nb\"", "{2 1} {2 1}", "",
    false, "start-1763",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"()\" \"a\\nb\"", "{3 2} {3 2}", "",
    false, "start-1764",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"()\" \"a\\nb\"", "{4 3} {4 3}", "",
    false, "start-1765",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"()\" \"a\\nb\"", "{100 99} {100 99}",
    "", false, "start-1766",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"()\" \"a\\nb\"", "{3 2} {3 2}",
    "", false, "start-1767",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"()\" \"a\\nb\"", "{2 1} {2 1}",
    "", false, "start-1768",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"()\" \"a\\nb\"", "{4 3} {4 3}",
    "", false, "start-1769",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"()\" \"a\\nb\"", "{0 -1} {0 -1} {1 0} {1 0} {2 1} {2 1}",
    "", false, "start-1770",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"()\" \"a\\nb\"", "{0 -1} {0 -1} {1 0} {1 0} {2 1} {2 1}",
    "", false, "start-1771",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"()\" \"a\\nb\"", "{1 0} {1 0} {2 1} {2 1}",
    "", false, "start-1772",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"()\" \"a\\nb\"", "{2 1} {2 1}",
    "", false, "start-1773",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"()\" \"a\\nb\"", "{3 2} {3 2}",
    "", false, "start-1774",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"()\" \"a\\nb\"", "{4 3} {4 3}",
    "", false, "start-1775",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"()\" \"a\\nb\"", "{100 99} {100 99}",
    "", false, "start-1776",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"()\" \"a\\nb\"", "{3 2} {3 2}",
    "", false, "start-1777",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"()\" \"a\\nb\"", "{2 1} {2 1}",
    "", false, "start-1778",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"()\" \"a\\nb\"", "{4 3} {4 3}",
    "", false, "start-1779",
  )
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"()\" \"a\\n\"", "{0 -1} {0 -1}",
    "", false, "start-1780",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"()\" \"a\\n\"", "{0 -1} {0 -1}",
    "", false, "start-1781",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"()\" \"a\\n\"", "{1 0} {1 0}", "",
    false, "start-1782",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"()\" \"a\\n\"", "{2 1} {2 1}", "",
    false, "start-1783",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"()\" \"a\\n\"", "{3 2} {3 2}", "",
    false, "start-1784",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"()\" \"a\\n\"", "{4 3} {4 3}", "",
    false, "start-1785",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"()\" \"a\\n\"", "{100 99} {100 99}",
    "", false, "start-1786",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"()\" \"a\\n\"", "{2 1} {2 1}",
    "", false, "start-1787",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"()\" \"a\\n\"", "{1 0} {1 0}",
    "", false, "start-1788",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"()\" \"a\\n\"", "{3 2} {3 2}",
    "", false, "start-1789",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"()\" \"a\\n\"", "{0 -1} {0 -1} {1 0} {1 0}",
    "", false, "start-1790",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"()\" \"a\\n\"", "{0 -1} {0 -1} {1 0} {1 0}",
    "", false, "start-1791",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"()\" \"a\\n\"", "{1 0} {1 0}",
    "", false, "start-1792",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"()\" \"a\\n\"", "{2 1} {2 1}",
    "", false, "start-1793",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"()\" \"a\\n\"", "{3 2} {3 2}",
    "", false, "start-1794",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"()\" \"a\\n\"", "{4 3} {4 3}",
    "", false, "start-1795",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"()\" \"a\\n\"", "{100 99} {100 99}",
    "", false, "start-1796",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"()\" \"a\\n\"", "{2 1} {2 1}",
    "", false, "start-1797",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"()\" \"a\\n\"", "{1 0} {1 0}",
    "", false, "start-1798",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"()\" \"a\\n\"", "{3 2} {3 2}",
    "", false, "start-1799",
  )
}

///|
test "Tcl regexp cases 1801 through 1840" {
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"a*\" \"\"", "{0 -1}", "", false,
    "start-1800",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"a*\" \"\"", "{0 -1}", "", false,
    "start-1801",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"a*\" \"\"", "{1 0}", "", false, "start-1802",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"a*\" \"\"", "{2 1}", "", false, "start-1803",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"a*\" \"\"", "{3 2}", "", false, "start-1804",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"a*\" \"\"", "{4 3}", "", false, "start-1805",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"a*\" \"\"", "{100 99}", "", false,
    "start-1806",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"a*\" \"\"", "{0 -1}", "", false,
    "start-1807",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"a*\" \"\"", "{0 -1}", "", false,
    "start-1808",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"a*\" \"\"", "{1 0}", "", false,
    "start-1809",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"a*\" \"\"", "{0 -1}", "", false,
    "start-1810",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"a*\" \"\"", "{0 -1}", "", false,
    "start-1811",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"a*\" \"\"", "{1 0}", "", false,
    "start-1812",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"a*\" \"\"", "{2 1}", "", false,
    "start-1813",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"a*\" \"\"", "{3 2}", "", false,
    "start-1814",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"a*\" \"\"", "{4 3}", "", false,
    "start-1815",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"a*\" \"\"", "{100 99}", "",
    false, "start-1816",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"a*\" \"\"", "{0 -1}", "", false,
    "start-1817",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"a*\" \"\"", "{0 -1}", "",
    false, "start-1818",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"a*\" \"\"", "{1 0}", "",
    false, "start-1819",
  )
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"a*\" \"a\"", "{0 0}", "", false,
    "start-1820",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"a*\" \"a\"", "{0 0}", "", false,
    "start-1821",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"a*\" \"a\"", "{1 0}", "", false,
    "start-1822",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"a*\" \"a\"", "{2 1}", "", false,
    "start-1823",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"a*\" \"a\"", "{3 2}", "", false,
    "start-1824",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"a*\" \"a\"", "{4 3}", "", false,
    "start-1825",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"a*\" \"a\"", "{100 99}", "", false,
    "start-1826",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"a*\" \"a\"", "{1 0}", "", false,
    "start-1827",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"a*\" \"a\"", "{0 0}", "", false,
    "start-1828",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"a*\" \"a\"", "{2 1}", "", false,
    "start-1829",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"a*\" \"a\"", "{0 0}", "", false,
    "start-1830",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"a*\" \"a\"", "{0 0}", "", false,
    "start-1831",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"a*\" \"a\"", "{1 0}", "", false,
    "start-1832",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"a*\" \"a\"", "{2 1}", "", false,
    "start-1833",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"a*\" \"a\"", "{3 2}", "", false,
    "start-1834",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"a*\" \"a\"", "{4 3}", "", false,
    "start-1835",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"a*\" \"a\"", "{100 99}", "",
    false, "start-1836",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"a*\" \"a\"", "{1 0}", "", false,
    "start-1837",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"a*\" \"a\"", "{0 0}", "",
    false, "start-1838",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"a*\" \"a\"", "{2 1}", "",
    false, "start-1839",
  )
}

///|
test "Tcl regexp cases 1841 through 1880" {
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"a*\" \"aba\"", "{0 0}", "", false,
    "start-1840",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"a*\" \"aba\"", "{0 0}", "", false,
    "start-1841",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"a*\" \"aba\"", "{1 0}", "", false,
    "start-1842",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"a*\" \"aba\"", "{2 2}", "", false,
    "start-1843",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"a*\" \"aba\"", "{3 2}", "", false,
    "start-1844",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"a*\" \"aba\"", "{4 3}", "", false,
    "start-1845",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"a*\" \"aba\"", "{100 99}", "",
    false, "start-1846",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"a*\" \"aba\"", "{3 2}", "", false,
    "start-1847",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"a*\" \"aba\"", "{2 2}", "", false,
    "start-1848",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"a*\" \"aba\"", "{4 3}", "", false,
    "start-1849",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"a*\" \"aba\"", "{0 0} {1 0} {2 2}",
    "", false, "start-1850",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"a*\" \"aba\"", "{0 0} {1 0} {2 2}",
    "", false, "start-1851",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"a*\" \"aba\"", "{1 0} {2 2}",
    "", false, "start-1852",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"a*\" \"aba\"", "{2 2}", "", false,
    "start-1853",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"a*\" \"aba\"", "{3 2}", "", false,
    "start-1854",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"a*\" \"aba\"", "{4 3}", "", false,
    "start-1855",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"a*\" \"aba\"", "{100 99}",
    "", false, "start-1856",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"a*\" \"aba\"", "{3 2}", "",
    false, "start-1857",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"a*\" \"aba\"", "{2 2}", "",
    false, "start-1858",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"a*\" \"aba\"", "{4 3}", "",
    false, "start-1859",
  )
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"a*\" \"abc\"", "{0 0}", "", false,
    "start-1860",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"a*\" \"abc\"", "{0 0}", "", false,
    "start-1861",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"a*\" \"abc\"", "{1 0}", "", false,
    "start-1862",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"a*\" \"abc\"", "{2 1}", "", false,
    "start-1863",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"a*\" \"abc\"", "{3 2}", "", false,
    "start-1864",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"a*\" \"abc\"", "{4 3}", "", false,
    "start-1865",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"a*\" \"abc\"", "{100 99}", "",
    false, "start-1866",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"a*\" \"abc\"", "{3 2}", "", false,
    "start-1867",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"a*\" \"abc\"", "{2 1}", "", false,
    "start-1868",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"a*\" \"abc\"", "{4 3}", "", false,
    "start-1869",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"a*\" \"abc\"", "{0 0} {1 0} {2 1}",
    "", false, "start-1870",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"a*\" \"abc\"", "{0 0} {1 0} {2 1}",
    "", false, "start-1871",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"a*\" \"abc\"", "{1 0} {2 1}",
    "", false, "start-1872",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"a*\" \"abc\"", "{2 1}", "", false,
    "start-1873",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"a*\" \"abc\"", "{3 2}", "", false,
    "start-1874",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"a*\" \"abc\"", "{4 3}", "", false,
    "start-1875",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"a*\" \"abc\"", "{100 99}",
    "", false, "start-1876",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"a*\" \"abc\"", "{3 2}", "",
    false, "start-1877",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"a*\" \"abc\"", "{2 1}", "",
    false, "start-1878",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"a*\" \"abc\"", "{4 3}", "",
    false, "start-1879",
  )
}

///|
test "Tcl regexp cases 1881 through 1920" {
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"a*\" \"a\\nb\"", "{0 0}", "", false,
    "start-1880",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"a*\" \"a\\nb\"", "{0 0}", "", false,
    "start-1881",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"a*\" \"a\\nb\"", "{1 0}", "", false,
    "start-1882",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"a*\" \"a\\nb\"", "{2 1}", "", false,
    "start-1883",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"a*\" \"a\\nb\"", "{3 2}", "", false,
    "start-1884",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"a*\" \"a\\nb\"", "{4 3}", "", false,
    "start-1885",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"a*\" \"a\\nb\"", "{100 99}", "",
    false, "start-1886",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"a*\" \"a\\nb\"", "{3 2}", "", false,
    "start-1887",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"a*\" \"a\\nb\"", "{2 1}", "",
    false, "start-1888",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"a*\" \"a\\nb\"", "{4 3}", "",
    false, "start-1889",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"a*\" \"a\\nb\"", "{0 0} {1 0} {2 1}",
    "", false, "start-1890",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"a*\" \"a\\nb\"", "{0 0} {1 0} {2 1}",
    "", false, "start-1891",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"a*\" \"a\\nb\"", "{1 0} {2 1}",
    "", false, "start-1892",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"a*\" \"a\\nb\"", "{2 1}", "",
    false, "start-1893",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"a*\" \"a\\nb\"", "{3 2}", "",
    false, "start-1894",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"a*\" \"a\\nb\"", "{4 3}", "",
    false, "start-1895",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"a*\" \"a\\nb\"", "{100 99}",
    "", false, "start-1896",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"a*\" \"a\\nb\"", "{3 2}", "",
    false, "start-1897",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"a*\" \"a\\nb\"", "{2 1}",
    "", false, "start-1898",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"a*\" \"a\\nb\"", "{4 3}",
    "", false, "start-1899",
  )
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"a*\" \"a\\n\"", "{0 0}", "", false,
    "start-1900",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"a*\" \"a\\n\"", "{0 0}", "", false,
    "start-1901",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"a*\" \"a\\n\"", "{1 0}", "", false,
    "start-1902",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"a*\" \"a\\n\"", "{2 1}", "", false,
    "start-1903",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"a*\" \"a\\n\"", "{3 2}", "", false,
    "start-1904",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"a*\" \"a\\n\"", "{4 3}", "", false,
    "start-1905",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"a*\" \"a\\n\"", "{100 99}", "",
    false, "start-1906",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"a*\" \"a\\n\"", "{2 1}", "", false,
    "start-1907",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"a*\" \"a\\n\"", "{1 0}", "",
    false, "start-1908",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"a*\" \"a\\n\"", "{3 2}", "",
    false, "start-1909",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"a*\" \"a\\n\"", "{0 0} {1 0}",
    "", false, "start-1910",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"a*\" \"a\\n\"", "{0 0} {1 0}",
    "", false, "start-1911",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"a*\" \"a\\n\"", "{1 0}", "",
    false, "start-1912",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"a*\" \"a\\n\"", "{2 1}", "",
    false, "start-1913",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"a*\" \"a\\n\"", "{3 2}", "",
    false, "start-1914",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"a*\" \"a\\n\"", "{4 3}", "",
    false, "start-1915",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"a*\" \"a\\n\"", "{100 99}",
    "", false, "start-1916",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"a*\" \"a\\n\"", "{2 1}", "",
    false, "start-1917",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"a*\" \"a\\n\"", "{1 0}",
    "", false, "start-1918",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"a*\" \"a\\n\"", "{3 2}",
    "", false, "start-1919",
  )
}

///|
test "Tcl regexp cases 1921 through 1960" {
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"a*?\" \"\"", "{0 -1}", "", false,
    "start-1920",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"a*?\" \"\"", "{0 -1}", "", false,
    "start-1921",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"a*?\" \"\"", "{1 0}", "", false,
    "start-1922",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"a*?\" \"\"", "{2 1}", "", false,
    "start-1923",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"a*?\" \"\"", "{3 2}", "", false,
    "start-1924",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"a*?\" \"\"", "{4 3}", "", false,
    "start-1925",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"a*?\" \"\"", "{100 99}", "", false,
    "start-1926",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"a*?\" \"\"", "{0 -1}", "", false,
    "start-1927",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"a*?\" \"\"", "{0 -1}", "", false,
    "start-1928",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"a*?\" \"\"", "{1 0}", "", false,
    "start-1929",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"a*?\" \"\"", "{0 -1}", "", false,
    "start-1930",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"a*?\" \"\"", "{0 -1}", "", false,
    "start-1931",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"a*?\" \"\"", "{1 0}", "", false,
    "start-1932",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"a*?\" \"\"", "{2 1}", "", false,
    "start-1933",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"a*?\" \"\"", "{3 2}", "", false,
    "start-1934",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"a*?\" \"\"", "{4 3}", "", false,
    "start-1935",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"a*?\" \"\"", "{100 99}", "",
    false, "start-1936",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"a*?\" \"\"", "{0 -1}", "",
    false, "start-1937",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"a*?\" \"\"", "{0 -1}", "",
    false, "start-1938",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"a*?\" \"\"", "{1 0}", "",
    false, "start-1939",
  )
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"a*?\" \"a\"", "{0 -1}", "", false,
    "start-1940",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"a*?\" \"a\"", "{0 -1}", "", false,
    "start-1941",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"a*?\" \"a\"", "{1 0}", "", false,
    "start-1942",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"a*?\" \"a\"", "{2 1}", "", false,
    "start-1943",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"a*?\" \"a\"", "{3 2}", "", false,
    "start-1944",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"a*?\" \"a\"", "{4 3}", "", false,
    "start-1945",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"a*?\" \"a\"", "{100 99}", "", false,
    "start-1946",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"a*?\" \"a\"", "{1 0}", "", false,
    "start-1947",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"a*?\" \"a\"", "{0 -1}", "", false,
    "start-1948",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"a*?\" \"a\"", "{2 1}", "", false,
    "start-1949",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"a*?\" \"a\"", "{0 -1}", "",
    false, "start-1950",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"a*?\" \"a\"", "{0 -1}", "", false,
    "start-1951",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"a*?\" \"a\"", "{1 0}", "", false,
    "start-1952",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"a*?\" \"a\"", "{2 1}", "", false,
    "start-1953",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"a*?\" \"a\"", "{3 2}", "", false,
    "start-1954",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"a*?\" \"a\"", "{4 3}", "", false,
    "start-1955",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"a*?\" \"a\"", "{100 99}", "",
    false, "start-1956",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"a*?\" \"a\"", "{1 0}", "",
    false, "start-1957",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"a*?\" \"a\"", "{0 -1}", "",
    false, "start-1958",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"a*?\" \"a\"", "{2 1}", "",
    false, "start-1959",
  )
}

///|
test "Tcl regexp cases 1961 through 2000" {
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"a*?\" \"aba\"", "{0 -1}", "", false,
    "start-1960",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"a*?\" \"aba\"", "{0 -1}", "", false,
    "start-1961",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"a*?\" \"aba\"", "{1 0}", "", false,
    "start-1962",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"a*?\" \"aba\"", "{2 1}", "", false,
    "start-1963",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"a*?\" \"aba\"", "{3 2}", "", false,
    "start-1964",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"a*?\" \"aba\"", "{4 3}", "", false,
    "start-1965",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"a*?\" \"aba\"", "{100 99}", "",
    false, "start-1966",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"a*?\" \"aba\"", "{3 2}", "", false,
    "start-1967",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"a*?\" \"aba\"", "{2 1}", "",
    false, "start-1968",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"a*?\" \"aba\"", "{4 3}", "",
    false, "start-1969",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"a*?\" \"aba\"", "{0 -1} {1 0} {2 1}",
    "", false, "start-1970",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"a*?\" \"aba\"", "{0 -1} {1 0} {2 1}",
    "", false, "start-1971",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"a*?\" \"aba\"", "{1 0} {2 1}",
    "", false, "start-1972",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"a*?\" \"aba\"", "{2 1}", "",
    false, "start-1973",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"a*?\" \"aba\"", "{3 2}", "",
    false, "start-1974",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"a*?\" \"aba\"", "{4 3}", "",
    false, "start-1975",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"a*?\" \"aba\"", "{100 99}",
    "", false, "start-1976",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"a*?\" \"aba\"", "{3 2}", "",
    false, "start-1977",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"a*?\" \"aba\"", "{2 1}",
    "", false, "start-1978",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"a*?\" \"aba\"", "{4 3}",
    "", false, "start-1979",
  )
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"a*?\" \"abc\"", "{0 -1}", "", false,
    "start-1980",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"a*?\" \"abc\"", "{0 -1}", "", false,
    "start-1981",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"a*?\" \"abc\"", "{1 0}", "", false,
    "start-1982",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"a*?\" \"abc\"", "{2 1}", "", false,
    "start-1983",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"a*?\" \"abc\"", "{3 2}", "", false,
    "start-1984",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"a*?\" \"abc\"", "{4 3}", "", false,
    "start-1985",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"a*?\" \"abc\"", "{100 99}", "",
    false, "start-1986",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"a*?\" \"abc\"", "{3 2}", "", false,
    "start-1987",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"a*?\" \"abc\"", "{2 1}", "",
    false, "start-1988",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"a*?\" \"abc\"", "{4 3}", "",
    false, "start-1989",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"a*?\" \"abc\"", "{0 -1} {1 0} {2 1}",
    "", false, "start-1990",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"a*?\" \"abc\"", "{0 -1} {1 0} {2 1}",
    "", false, "start-1991",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"a*?\" \"abc\"", "{1 0} {2 1}",
    "", false, "start-1992",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"a*?\" \"abc\"", "{2 1}", "",
    false, "start-1993",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"a*?\" \"abc\"", "{3 2}", "",
    false, "start-1994",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"a*?\" \"abc\"", "{4 3}", "",
    false, "start-1995",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"a*?\" \"abc\"", "{100 99}",
    "", false, "start-1996",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"a*?\" \"abc\"", "{3 2}", "",
    false, "start-1997",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"a*?\" \"abc\"", "{2 1}",
    "", false, "start-1998",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"a*?\" \"abc\"", "{4 3}",
    "", false, "start-1999",
  )
}

///|
test "Tcl regexp cases 2001 through 2040" {
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"a*?\" \"a\\nb\"", "{0 -1}", "",
    false, "start-2000",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"a*?\" \"a\\nb\"", "{0 -1}", "", false,
    "start-2001",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"a*?\" \"a\\nb\"", "{1 0}", "", false,
    "start-2002",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"a*?\" \"a\\nb\"", "{2 1}", "", false,
    "start-2003",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"a*?\" \"a\\nb\"", "{3 2}", "", false,
    "start-2004",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"a*?\" \"a\\nb\"", "{4 3}", "", false,
    "start-2005",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"a*?\" \"a\\nb\"", "{100 99}", "",
    false, "start-2006",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"a*?\" \"a\\nb\"", "{3 2}", "",
    false, "start-2007",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"a*?\" \"a\\nb\"", "{2 1}", "",
    false, "start-2008",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"a*?\" \"a\\nb\"", "{4 3}", "",
    false, "start-2009",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"a*?\" \"a\\nb\"", "{0 -1} {1 0} {2 1}",
    "", false, "start-2010",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"a*?\" \"a\\nb\"", "{0 -1} {1 0} {2 1}",
    "", false, "start-2011",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"a*?\" \"a\\nb\"", "{1 0} {2 1}",
    "", false, "start-2012",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"a*?\" \"a\\nb\"", "{2 1}", "",
    false, "start-2013",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"a*?\" \"a\\nb\"", "{3 2}", "",
    false, "start-2014",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"a*?\" \"a\\nb\"", "{4 3}", "",
    false, "start-2015",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"a*?\" \"a\\nb\"", "{100 99}",
    "", false, "start-2016",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"a*?\" \"a\\nb\"", "{3 2}",
    "", false, "start-2017",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"a*?\" \"a\\nb\"", "{2 1}",
    "", false, "start-2018",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"a*?\" \"a\\nb\"", "{4 3}",
    "", false, "start-2019",
  )
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"a*?\" \"a\\n\"", "{0 -1}", "", false,
    "start-2020",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"a*?\" \"a\\n\"", "{0 -1}", "", false,
    "start-2021",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"a*?\" \"a\\n\"", "{1 0}", "", false,
    "start-2022",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"a*?\" \"a\\n\"", "{2 1}", "", false,
    "start-2023",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"a*?\" \"a\\n\"", "{3 2}", "", false,
    "start-2024",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"a*?\" \"a\\n\"", "{4 3}", "", false,
    "start-2025",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"a*?\" \"a\\n\"", "{100 99}", "",
    false, "start-2026",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"a*?\" \"a\\n\"", "{2 1}", "", false,
    "start-2027",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"a*?\" \"a\\n\"", "{1 0}", "",
    false, "start-2028",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"a*?\" \"a\\n\"", "{3 2}", "",
    false, "start-2029",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"a*?\" \"a\\n\"", "{0 -1} {1 0}",
    "", false, "start-2030",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"a*?\" \"a\\n\"", "{0 -1} {1 0}",
    "", false, "start-2031",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"a*?\" \"a\\n\"", "{1 0}", "",
    false, "start-2032",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"a*?\" \"a\\n\"", "{2 1}", "",
    false, "start-2033",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"a*?\" \"a\\n\"", "{3 2}", "",
    false, "start-2034",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"a*?\" \"a\\n\"", "{4 3}", "",
    false, "start-2035",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"a*?\" \"a\\n\"", "{100 99}",
    "", false, "start-2036",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"a*?\" \"a\\n\"", "{2 1}", "",
    false, "start-2037",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"a*?\" \"a\\n\"", "{1 0}",
    "", false, "start-2038",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"a*?\" \"a\\n\"", "{3 2}",
    "", false, "start-2039",
  )
}

///|
test "Tcl regexp cases 2041 through 2080" {
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"(a)?b\" \"\"", "", "", false, "start-2040",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"(a)?b\" \"\"", "", "", false, "start-2041",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"(a)?b\" \"\"", "", "", false, "start-2042",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"(a)?b\" \"\"", "", "", false, "start-2043",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"(a)?b\" \"\"", "", "", false, "start-2044",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"(a)?b\" \"\"", "", "", false, "start-2045",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"(a)?b\" \"\"", "", "", false, "start-2046",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"(a)?b\" \"\"", "", "", false, "start-2047",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"(a)?b\" \"\"", "", "", false,
    "start-2048",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"(a)?b\" \"\"", "", "", false,
    "start-2049",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"(a)?b\" \"\"", "", "", false,
    "start-2050",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"(a)?b\" \"\"", "", "", false,
    "start-2051",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"(a)?b\" \"\"", "", "", false,
    "start-2052",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"(a)?b\" \"\"", "", "", false,
    "start-2053",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"(a)?b\" \"\"", "", "", false,
    "start-2054",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"(a)?b\" \"\"", "", "", false,
    "start-2055",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"(a)?b\" \"\"", "", "", false,
    "start-2056",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"(a)?b\" \"\"", "", "", false,
    "start-2057",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"(a)?b\" \"\"", "", "", false,
    "start-2058",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"(a)?b\" \"\"", "", "", false,
    "start-2059",
  )
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"(a)?b\" \"a\"", "", "", false, "start-2060",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"(a)?b\" \"a\"", "", "", false, "start-2061",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"(a)?b\" \"a\"", "", "", false, "start-2062",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"(a)?b\" \"a\"", "", "", false, "start-2063",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"(a)?b\" \"a\"", "", "", false, "start-2064",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"(a)?b\" \"a\"", "", "", false, "start-2065",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"(a)?b\" \"a\"", "", "", false,
    "start-2066",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"(a)?b\" \"a\"", "", "", false,
    "start-2067",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"(a)?b\" \"a\"", "", "", false,
    "start-2068",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"(a)?b\" \"a\"", "", "", false,
    "start-2069",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"(a)?b\" \"a\"", "", "", false,
    "start-2070",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"(a)?b\" \"a\"", "", "", false,
    "start-2071",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"(a)?b\" \"a\"", "", "", false,
    "start-2072",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"(a)?b\" \"a\"", "", "", false,
    "start-2073",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"(a)?b\" \"a\"", "", "", false,
    "start-2074",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"(a)?b\" \"a\"", "", "", false,
    "start-2075",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"(a)?b\" \"a\"", "", "", false,
    "start-2076",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"(a)?b\" \"a\"", "", "", false,
    "start-2077",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"(a)?b\" \"a\"", "", "", false,
    "start-2078",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"(a)?b\" \"a\"", "", "", false,
    "start-2079",
  )
}

///|
test "Tcl regexp cases 2081 through 2120" {
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"(a)?b\" \"aba\"", "{0 1} {0 0}",
    "", false, "start-2080",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"(a)?b\" \"aba\"", "{0 1} {0 0}",
    "", false, "start-2081",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"(a)?b\" \"aba\"", "{1 1} {-1 -1}",
    "", false, "start-2082",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"(a)?b\" \"aba\"", "", "", false,
    "start-2083",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"(a)?b\" \"aba\"", "", "", false,
    "start-2084",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"(a)?b\" \"aba\"", "", "", false,
    "start-2085",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"(a)?b\" \"aba\"", "", "", false,
    "start-2086",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"(a)?b\" \"aba\"", "", "", false,
    "start-2087",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"(a)?b\" \"aba\"", "", "", false,
    "start-2088",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"(a)?b\" \"aba\"", "", "", false,
    "start-2089",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"(a)?b\" \"aba\"", "{0 1} {0 0}",
    "", false, "start-2090",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"(a)?b\" \"aba\"", "{0 1} {0 0}",
    "", false, "start-2091",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"(a)?b\" \"aba\"", "{1 1} {-1 -1}",
    "", false, "start-2092",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"(a)?b\" \"aba\"", "", "", false,
    "start-2093",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"(a)?b\" \"aba\"", "", "", false,
    "start-2094",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"(a)?b\" \"aba\"", "", "", false,
    "start-2095",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"(a)?b\" \"aba\"", "", "", false,
    "start-2096",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"(a)?b\" \"aba\"", "", "", false,
    "start-2097",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"(a)?b\" \"aba\"", "", "",
    false, "start-2098",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"(a)?b\" \"aba\"", "", "",
    false, "start-2099",
  )
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"(a)?b\" \"abc\"", "{0 1} {0 0}",
    "", false, "start-2100",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"(a)?b\" \"abc\"", "{0 1} {0 0}",
    "", false, "start-2101",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"(a)?b\" \"abc\"", "{1 1} {-1 -1}",
    "", false, "start-2102",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"(a)?b\" \"abc\"", "", "", false,
    "start-2103",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"(a)?b\" \"abc\"", "", "", false,
    "start-2104",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"(a)?b\" \"abc\"", "", "", false,
    "start-2105",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"(a)?b\" \"abc\"", "", "", false,
    "start-2106",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"(a)?b\" \"abc\"", "", "", false,
    "start-2107",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"(a)?b\" \"abc\"", "", "", false,
    "start-2108",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"(a)?b\" \"abc\"", "", "", false,
    "start-2109",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"(a)?b\" \"abc\"", "{0 1} {0 0}",
    "", false, "start-2110",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"(a)?b\" \"abc\"", "{0 1} {0 0}",
    "", false, "start-2111",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"(a)?b\" \"abc\"", "{1 1} {-1 -1}",
    "", false, "start-2112",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"(a)?b\" \"abc\"", "", "", false,
    "start-2113",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"(a)?b\" \"abc\"", "", "", false,
    "start-2114",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"(a)?b\" \"abc\"", "", "", false,
    "start-2115",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"(a)?b\" \"abc\"", "", "", false,
    "start-2116",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"(a)?b\" \"abc\"", "", "", false,
    "start-2117",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"(a)?b\" \"abc\"", "", "",
    false, "start-2118",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"(a)?b\" \"abc\"", "", "",
    false, "start-2119",
  )
}

///|
test "Tcl regexp cases 2121 through 2160" {
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"(a)?b\" \"a\\nb\"", "{2 2} {-1 -1}",
    "", false, "start-2120",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"(a)?b\" \"a\\nb\"", "{2 2} {-1 -1}",
    "", false, "start-2121",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"(a)?b\" \"a\\nb\"", "{2 2} {-1 -1}",
    "", false, "start-2122",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"(a)?b\" \"a\\nb\"", "{2 2} {-1 -1}",
    "", false, "start-2123",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"(a)?b\" \"a\\nb\"", "", "", false,
    "start-2124",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"(a)?b\" \"a\\nb\"", "", "", false,
    "start-2125",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"(a)?b\" \"a\\nb\"", "", "", false,
    "start-2126",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"(a)?b\" \"a\\nb\"", "", "", false,
    "start-2127",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"(a)?b\" \"a\\nb\"", "{2 2} {-1 -1}",
    "", false, "start-2128",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"(a)?b\" \"a\\nb\"", "", "", false,
    "start-2129",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"(a)?b\" \"a\\nb\"", "{2 2} {-1 -1}",
    "", false, "start-2130",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"(a)?b\" \"a\\nb\"", "{2 2} {-1 -1}",
    "", false, "start-2131",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"(a)?b\" \"a\\nb\"", "{2 2} {-1 -1}",
    "", false, "start-2132",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"(a)?b\" \"a\\nb\"", "{2 2} {-1 -1}",
    "", false, "start-2133",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"(a)?b\" \"a\\nb\"", "", "", false,
    "start-2134",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"(a)?b\" \"a\\nb\"", "", "", false,
    "start-2135",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"(a)?b\" \"a\\nb\"", "", "",
    false, "start-2136",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"(a)?b\" \"a\\nb\"", "", "",
    false, "start-2137",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"(a)?b\" \"a\\nb\"", "{2 2} {-1 -1}",
    "", false, "start-2138",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"(a)?b\" \"a\\nb\"", "", "",
    false, "start-2139",
  )
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"(a)?b\" \"a\\n\"", "", "", false,
    "start-2140",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"(a)?b\" \"a\\n\"", "", "", false,
    "start-2141",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"(a)?b\" \"a\\n\"", "", "", false,
    "start-2142",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"(a)?b\" \"a\\n\"", "", "", false,
    "start-2143",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"(a)?b\" \"a\\n\"", "", "", false,
    "start-2144",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"(a)?b\" \"a\\n\"", "", "", false,
    "start-2145",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"(a)?b\" \"a\\n\"", "", "", false,
    "start-2146",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"(a)?b\" \"a\\n\"", "", "", false,
    "start-2147",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"(a)?b\" \"a\\n\"", "", "", false,
    "start-2148",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"(a)?b\" \"a\\n\"", "", "", false,
    "start-2149",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"(a)?b\" \"a\\n\"", "", "", false,
    "start-2150",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"(a)?b\" \"a\\n\"", "", "", false,
    "start-2151",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"(a)?b\" \"a\\n\"", "", "", false,
    "start-2152",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"(a)?b\" \"a\\n\"", "", "", false,
    "start-2153",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"(a)?b\" \"a\\n\"", "", "", false,
    "start-2154",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"(a)?b\" \"a\\n\"", "", "", false,
    "start-2155",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"(a)?b\" \"a\\n\"", "", "",
    false, "start-2156",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"(a)?b\" \"a\\n\"", "", "",
    false, "start-2157",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"(a)?b\" \"a\\n\"", "", "",
    false, "start-2158",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"(a)?b\" \"a\\n\"", "", "",
    false, "start-2159",
  )
}

///|
test "Tcl regexp cases 2161 through 2200" {
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"^\" \"\"", "{0 -1}", "", false,
    "start-2160",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"^\" \"\"", "{0 -1}", "", false, "start-2161",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"^\" \"\"", "", "", false, "start-2162",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"^\" \"\"", "", "", false, "start-2163",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"^\" \"\"", "", "", false, "start-2164",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"^\" \"\"", "", "", false, "start-2165",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"^\" \"\"", "", "", false, "start-2166",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"^\" \"\"", "{0 -1}", "", false,
    "start-2167",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"^\" \"\"", "{0 -1}", "", false,
    "start-2168",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"^\" \"\"", "", "", false, "start-2169",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"^\" \"\"", "{0 -1}", "", false,
    "start-2170",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"^\" \"\"", "{0 -1}", "", false,
    "start-2171",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"^\" \"\"", "", "", false, "start-2172",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"^\" \"\"", "", "", false, "start-2173",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"^\" \"\"", "", "", false, "start-2174",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"^\" \"\"", "", "", false, "start-2175",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"^\" \"\"", "", "", false, "start-2176",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"^\" \"\"", "{0 -1}", "", false,
    "start-2177",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"^\" \"\"", "{0 -1}", "",
    false, "start-2178",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"^\" \"\"", "", "", false,
    "start-2179",
  )
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"^\" \"a\"", "{0 -1}", "", false,
    "start-2180",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"^\" \"a\"", "{0 -1}", "", false,
    "start-2181",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"^\" \"a\"", "", "", false, "start-2182",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"^\" \"a\"", "", "", false, "start-2183",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"^\" \"a\"", "", "", false, "start-2184",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"^\" \"a\"", "", "", false, "start-2185",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"^\" \"a\"", "", "", false, "start-2186",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"^\" \"a\"", "", "", false, "start-2187",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"^\" \"a\"", "{0 -1}", "", false,
    "start-2188",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"^\" \"a\"", "", "", false, "start-2189",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"^\" \"a\"", "{0 -1}", "", false,
    "start-2190",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"^\" \"a\"", "{0 -1}", "", false,
    "start-2191",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"^\" \"a\"", "", "", false, "start-2192",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"^\" \"a\"", "", "", false, "start-2193",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"^\" \"a\"", "", "", false, "start-2194",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"^\" \"a\"", "", "", false, "start-2195",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"^\" \"a\"", "", "", false,
    "start-2196",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"^\" \"a\"", "", "", false,
    "start-2197",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"^\" \"a\"", "{0 -1}", "",
    false, "start-2198",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"^\" \"a\"", "", "", false,
    "start-2199",
  )
}

///|
test "Tcl regexp cases 2201 through 2240" {
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"^\" \"aba\"", "{0 -1}", "", false,
    "start-2200",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"^\" \"aba\"", "{0 -1}", "", false,
    "start-2201",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"^\" \"aba\"", "", "", false, "start-2202",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"^\" \"aba\"", "", "", false, "start-2203",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"^\" \"aba\"", "", "", false, "start-2204",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"^\" \"aba\"", "", "", false, "start-2205",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"^\" \"aba\"", "", "", false, "start-2206",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"^\" \"aba\"", "", "", false, "start-2207",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"^\" \"aba\"", "", "", false,
    "start-2208",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"^\" \"aba\"", "", "", false,
    "start-2209",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"^\" \"aba\"", "{0 -1}", "",
    false, "start-2210",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"^\" \"aba\"", "{0 -1}", "", false,
    "start-2211",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"^\" \"aba\"", "", "", false,
    "start-2212",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"^\" \"aba\"", "", "", false,
    "start-2213",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"^\" \"aba\"", "", "", false,
    "start-2214",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"^\" \"aba\"", "", "", false,
    "start-2215",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"^\" \"aba\"", "", "", false,
    "start-2216",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"^\" \"aba\"", "", "", false,
    "start-2217",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"^\" \"aba\"", "", "", false,
    "start-2218",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"^\" \"aba\"", "", "", false,
    "start-2219",
  )
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"^\" \"abc\"", "{0 -1}", "", false,
    "start-2220",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"^\" \"abc\"", "{0 -1}", "", false,
    "start-2221",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"^\" \"abc\"", "", "", false, "start-2222",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"^\" \"abc\"", "", "", false, "start-2223",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"^\" \"abc\"", "", "", false, "start-2224",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"^\" \"abc\"", "", "", false, "start-2225",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"^\" \"abc\"", "", "", false, "start-2226",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"^\" \"abc\"", "", "", false, "start-2227",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"^\" \"abc\"", "", "", false,
    "start-2228",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"^\" \"abc\"", "", "", false,
    "start-2229",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"^\" \"abc\"", "{0 -1}", "",
    false, "start-2230",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"^\" \"abc\"", "{0 -1}", "", false,
    "start-2231",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"^\" \"abc\"", "", "", false,
    "start-2232",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"^\" \"abc\"", "", "", false,
    "start-2233",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"^\" \"abc\"", "", "", false,
    "start-2234",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"^\" \"abc\"", "", "", false,
    "start-2235",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"^\" \"abc\"", "", "", false,
    "start-2236",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"^\" \"abc\"", "", "", false,
    "start-2237",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"^\" \"abc\"", "", "", false,
    "start-2238",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"^\" \"abc\"", "", "", false,
    "start-2239",
  )
}

///|
test "Tcl regexp cases 2241 through 2280" {
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"^\" \"a\\nb\"", "{0 -1}", "", false,
    "start-2240",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"^\" \"a\\nb\"", "{0 -1}", "", false,
    "start-2241",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"^\" \"a\\nb\"", "", "", false, "start-2242",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"^\" \"a\\nb\"", "{2 1}", "", false,
    "start-2243",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"^\" \"a\\nb\"", "", "", false, "start-2244",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"^\" \"a\\nb\"", "", "", false, "start-2245",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"^\" \"a\\nb\"", "", "", false,
    "start-2246",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"^\" \"a\\nb\"", "", "", false,
    "start-2247",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"^\" \"a\\nb\"", "{2 1}", "",
    false, "start-2248",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"^\" \"a\\nb\"", "", "", false,
    "start-2249",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"^\" \"a\\nb\"", "{0 -1}", "",
    false, "start-2250",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"^\" \"a\\nb\"", "{0 -1}", "",
    false, "start-2251",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"^\" \"a\\nb\"", "", "", false,
    "start-2252",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"^\" \"a\\nb\"", "{2 1}", "",
    false, "start-2253",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"^\" \"a\\nb\"", "", "", false,
    "start-2254",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"^\" \"a\\nb\"", "", "", false,
    "start-2255",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"^\" \"a\\nb\"", "", "", false,
    "start-2256",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"^\" \"a\\nb\"", "", "", false,
    "start-2257",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"^\" \"a\\nb\"", "{2 1}",
    "", false, "start-2258",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"^\" \"a\\nb\"", "", "", false,
    "start-2259",
  )
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"^\" \"a\\n\"", "{0 -1}", "", false,
    "start-2260",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"^\" \"a\\n\"", "{0 -1}", "", false,
    "start-2261",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"^\" \"a\\n\"", "", "", false, "start-2262",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"^\" \"a\\n\"", "{2 1}", "", false,
    "start-2263",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"^\" \"a\\n\"", "", "", false, "start-2264",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"^\" \"a\\n\"", "", "", false, "start-2265",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"^\" \"a\\n\"", "", "", false, "start-2266",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"^\" \"a\\n\"", "{2 1}", "", false,
    "start-2267",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"^\" \"a\\n\"", "", "", false,
    "start-2268",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"^\" \"a\\n\"", "", "", false,
    "start-2269",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"^\" \"a\\n\"", "{0 -1}", "",
    false, "start-2270",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"^\" \"a\\n\"", "{0 -1}", "",
    false, "start-2271",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"^\" \"a\\n\"", "", "", false,
    "start-2272",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"^\" \"a\\n\"", "{2 1}", "", false,
    "start-2273",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"^\" \"a\\n\"", "", "", false,
    "start-2274",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"^\" \"a\\n\"", "", "", false,
    "start-2275",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"^\" \"a\\n\"", "", "", false,
    "start-2276",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"^\" \"a\\n\"", "{2 1}", "",
    false, "start-2277",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"^\" \"a\\n\"", "", "", false,
    "start-2278",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"^\" \"a\\n\"", "", "", false,
    "start-2279",
  )
}

///|
test "Tcl regexp cases 2281 through 2320" {
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"\\$\" \"\"", "{0 -1}", "", false,
    "start-2280",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"\\$\" \"\"", "{0 -1}", "", false,
    "start-2281",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"\\$\" \"\"", "{1 0}", "", false,
    "start-2282",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"\\$\" \"\"", "{2 1}", "", false,
    "start-2283",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"\\$\" \"\"", "{3 2}", "", false,
    "start-2284",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"\\$\" \"\"", "{4 3}", "", false,
    "start-2285",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"\\$\" \"\"", "{100 99}", "", false,
    "start-2286",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"\\$\" \"\"", "{0 -1}", "", false,
    "start-2287",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"\\$\" \"\"", "{0 -1}", "", false,
    "start-2288",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"\\$\" \"\"", "{1 0}", "", false,
    "start-2289",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"\\$\" \"\"", "{0 -1}", "", false,
    "start-2290",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"\\$\" \"\"", "{0 -1}", "", false,
    "start-2291",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"\\$\" \"\"", "{1 0}", "", false,
    "start-2292",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"\\$\" \"\"", "{2 1}", "", false,
    "start-2293",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"\\$\" \"\"", "{3 2}", "", false,
    "start-2294",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"\\$\" \"\"", "{4 3}", "", false,
    "start-2295",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"\\$\" \"\"", "{100 99}", "",
    false, "start-2296",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"\\$\" \"\"", "{0 -1}", "",
    false, "start-2297",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"\\$\" \"\"", "{0 -1}", "",
    false, "start-2298",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"\\$\" \"\"", "{1 0}", "",
    false, "start-2299",
  )
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"\\$\" \"a\"", "{1 0}", "", false,
    "start-2300",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"\\$\" \"a\"", "{1 0}", "", false,
    "start-2301",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"\\$\" \"a\"", "{1 0}", "", false,
    "start-2302",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"\\$\" \"a\"", "{2 1}", "", false,
    "start-2303",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"\\$\" \"a\"", "{3 2}", "", false,
    "start-2304",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"\\$\" \"a\"", "{4 3}", "", false,
    "start-2305",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"\\$\" \"a\"", "{100 99}", "", false,
    "start-2306",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"\\$\" \"a\"", "{1 0}", "", false,
    "start-2307",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"\\$\" \"a\"", "{1 0}", "", false,
    "start-2308",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"\\$\" \"a\"", "{2 1}", "", false,
    "start-2309",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"\\$\" \"a\"", "{1 0}", "", false,
    "start-2310",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"\\$\" \"a\"", "{1 0}", "", false,
    "start-2311",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"\\$\" \"a\"", "{1 0}", "", false,
    "start-2312",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"\\$\" \"a\"", "{2 1}", "", false,
    "start-2313",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"\\$\" \"a\"", "{3 2}", "", false,
    "start-2314",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"\\$\" \"a\"", "{4 3}", "", false,
    "start-2315",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"\\$\" \"a\"", "{100 99}", "",
    false, "start-2316",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"\\$\" \"a\"", "{1 0}", "",
    false, "start-2317",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"\\$\" \"a\"", "{1 0}", "",
    false, "start-2318",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"\\$\" \"a\"", "{2 1}", "",
    false, "start-2319",
  )
}

///|
test "Tcl regexp cases 2321 through 2360" {
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"\\$\" \"aba\"", "{3 2}", "", false,
    "start-2320",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"\\$\" \"aba\"", "{3 2}", "", false,
    "start-2321",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"\\$\" \"aba\"", "{3 2}", "", false,
    "start-2322",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"\\$\" \"aba\"", "{3 2}", "", false,
    "start-2323",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"\\$\" \"aba\"", "{3 2}", "", false,
    "start-2324",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"\\$\" \"aba\"", "{4 3}", "", false,
    "start-2325",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"\\$\" \"aba\"", "{100 99}", "",
    false, "start-2326",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"\\$\" \"aba\"", "{3 2}", "", false,
    "start-2327",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"\\$\" \"aba\"", "{3 2}", "",
    false, "start-2328",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"\\$\" \"aba\"", "{4 3}", "",
    false, "start-2329",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"\\$\" \"aba\"", "{3 2}", "",
    false, "start-2330",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"\\$\" \"aba\"", "{3 2}", "",
    false, "start-2331",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"\\$\" \"aba\"", "{3 2}", "",
    false, "start-2332",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"\\$\" \"aba\"", "{3 2}", "",
    false, "start-2333",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"\\$\" \"aba\"", "{3 2}", "",
    false, "start-2334",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"\\$\" \"aba\"", "{4 3}", "",
    false, "start-2335",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"\\$\" \"aba\"", "{100 99}",
    "", false, "start-2336",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"\\$\" \"aba\"", "{3 2}", "",
    false, "start-2337",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"\\$\" \"aba\"", "{3 2}",
    "", false, "start-2338",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"\\$\" \"aba\"", "{4 3}",
    "", false, "start-2339",
  )
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"\\$\" \"abc\"", "{3 2}", "", false,
    "start-2340",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"\\$\" \"abc\"", "{3 2}", "", false,
    "start-2341",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"\\$\" \"abc\"", "{3 2}", "", false,
    "start-2342",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"\\$\" \"abc\"", "{3 2}", "", false,
    "start-2343",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"\\$\" \"abc\"", "{3 2}", "", false,
    "start-2344",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"\\$\" \"abc\"", "{4 3}", "", false,
    "start-2345",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"\\$\" \"abc\"", "{100 99}", "",
    false, "start-2346",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"\\$\" \"abc\"", "{3 2}", "", false,
    "start-2347",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"\\$\" \"abc\"", "{3 2}", "",
    false, "start-2348",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"\\$\" \"abc\"", "{4 3}", "",
    false, "start-2349",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"\\$\" \"abc\"", "{3 2}", "",
    false, "start-2350",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"\\$\" \"abc\"", "{3 2}", "",
    false, "start-2351",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"\\$\" \"abc\"", "{3 2}", "",
    false, "start-2352",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"\\$\" \"abc\"", "{3 2}", "",
    false, "start-2353",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"\\$\" \"abc\"", "{3 2}", "",
    false, "start-2354",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"\\$\" \"abc\"", "{4 3}", "",
    false, "start-2355",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"\\$\" \"abc\"", "{100 99}",
    "", false, "start-2356",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"\\$\" \"abc\"", "{3 2}", "",
    false, "start-2357",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"\\$\" \"abc\"", "{3 2}",
    "", false, "start-2358",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"\\$\" \"abc\"", "{4 3}",
    "", false, "start-2359",
  )
}

///|
test "Tcl regexp cases 2361 through 2400" {
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"\\$\" \"a\\nb\"", "{3 2}", "", false,
    "start-2360",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"\\$\" \"a\\nb\"", "{3 2}", "", false,
    "start-2361",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"\\$\" \"a\\nb\"", "{3 2}", "", false,
    "start-2362",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"\\$\" \"a\\nb\"", "{3 2}", "", false,
    "start-2363",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"\\$\" \"a\\nb\"", "{3 2}", "", false,
    "start-2364",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"\\$\" \"a\\nb\"", "{4 3}", "", false,
    "start-2365",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"\\$\" \"a\\nb\"", "{100 99}", "",
    false, "start-2366",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"\\$\" \"a\\nb\"", "{3 2}", "",
    false, "start-2367",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"\\$\" \"a\\nb\"", "{3 2}", "",
    false, "start-2368",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"\\$\" \"a\\nb\"", "{4 3}", "",
    false, "start-2369",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"\\$\" \"a\\nb\"", "{3 2}", "",
    false, "start-2370",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"\\$\" \"a\\nb\"", "{3 2}", "",
    false, "start-2371",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"\\$\" \"a\\nb\"", "{3 2}", "",
    false, "start-2372",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"\\$\" \"a\\nb\"", "{3 2}", "",
    false, "start-2373",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"\\$\" \"a\\nb\"", "{3 2}", "",
    false, "start-2374",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"\\$\" \"a\\nb\"", "{4 3}", "",
    false, "start-2375",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"\\$\" \"a\\nb\"", "{100 99}",
    "", false, "start-2376",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"\\$\" \"a\\nb\"", "{3 2}",
    "", false, "start-2377",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"\\$\" \"a\\nb\"", "{3 2}",
    "", false, "start-2378",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"\\$\" \"a\\nb\"", "{4 3}",
    "", false, "start-2379",
  )
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"\\$\" \"a\\n\"", "{2 1}", "", false,
    "start-2380",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"\\$\" \"a\\n\"", "{2 1}", "", false,
    "start-2381",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"\\$\" \"a\\n\"", "{2 1}", "", false,
    "start-2382",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"\\$\" \"a\\n\"", "{2 1}", "", false,
    "start-2383",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"\\$\" \"a\\n\"", "{3 2}", "", false,
    "start-2384",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"\\$\" \"a\\n\"", "{4 3}", "", false,
    "start-2385",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"\\$\" \"a\\n\"", "{100 99}", "",
    false, "start-2386",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"\\$\" \"a\\n\"", "{2 1}", "", false,
    "start-2387",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"\\$\" \"a\\n\"", "{2 1}", "",
    false, "start-2388",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"\\$\" \"a\\n\"", "{3 2}", "",
    false, "start-2389",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"\\$\" \"a\\n\"", "{2 1}", "",
    false, "start-2390",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"\\$\" \"a\\n\"", "{2 1}", "",
    false, "start-2391",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"\\$\" \"a\\n\"", "{2 1}", "",
    false, "start-2392",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"\\$\" \"a\\n\"", "{2 1}", "",
    false, "start-2393",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"\\$\" \"a\\n\"", "{3 2}", "",
    false, "start-2394",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"\\$\" \"a\\n\"", "{4 3}", "",
    false, "start-2395",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"\\$\" \"a\\n\"", "{100 99}",
    "", false, "start-2396",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"\\$\" \"a\\n\"", "{2 1}", "",
    false, "start-2397",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"\\$\" \"a\\n\"", "{2 1}",
    "", false, "start-2398",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"\\$\" \"a\\n\"", "{3 2}",
    "", false, "start-2399",
  )
}

///|
test "Tcl regexp cases 2401 through 2440" {
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"\\\\A\" \"\"", "{0 -1}", "", false,
    "start-2400",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"\\\\A\" \"\"", "{0 -1}", "", false,
    "start-2401",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"\\\\A\" \"\"", "{1 0}", "", false,
    "start-2402",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"\\\\A\" \"\"", "{2 1}", "", false,
    "start-2403",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"\\\\A\" \"\"", "{3 2}", "", false,
    "start-2404",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"\\\\A\" \"\"", "{4 3}", "", false,
    "start-2405",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"\\\\A\" \"\"", "{100 99}", "",
    false, "start-2406",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"\\\\A\" \"\"", "{0 -1}", "", false,
    "start-2407",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"\\\\A\" \"\"", "{0 -1}", "",
    false, "start-2408",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"\\\\A\" \"\"", "{1 0}", "", false,
    "start-2409",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"\\\\A\" \"\"", "{0 -1}", "",
    false, "start-2410",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"\\\\A\" \"\"", "{0 -1}", "",
    false, "start-2411",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"\\\\A\" \"\"", "{1 0}", "", false,
    "start-2412",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"\\\\A\" \"\"", "{2 1}", "", false,
    "start-2413",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"\\\\A\" \"\"", "{3 2}", "", false,
    "start-2414",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"\\\\A\" \"\"", "{4 3}", "", false,
    "start-2415",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"\\\\A\" \"\"", "{100 99}",
    "", false, "start-2416",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"\\\\A\" \"\"", "{0 -1}", "",
    false, "start-2417",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"\\\\A\" \"\"", "{0 -1}",
    "", false, "start-2418",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"\\\\A\" \"\"", "{1 0}", "",
    false, "start-2419",
  )
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"\\\\A\" \"a\"", "{0 -1}", "", false,
    "start-2420",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"\\\\A\" \"a\"", "{0 -1}", "", false,
    "start-2421",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"\\\\A\" \"a\"", "{1 0}", "", false,
    "start-2422",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"\\\\A\" \"a\"", "{2 1}", "", false,
    "start-2423",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"\\\\A\" \"a\"", "{3 2}", "", false,
    "start-2424",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"\\\\A\" \"a\"", "{4 3}", "", false,
    "start-2425",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"\\\\A\" \"a\"", "{100 99}", "",
    false, "start-2426",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"\\\\A\" \"a\"", "{1 0}", "", false,
    "start-2427",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"\\\\A\" \"a\"", "{0 -1}", "",
    false, "start-2428",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"\\\\A\" \"a\"", "{2 1}", "",
    false, "start-2429",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"\\\\A\" \"a\"", "{0 -1}", "",
    false, "start-2430",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"\\\\A\" \"a\"", "{0 -1}", "",
    false, "start-2431",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"\\\\A\" \"a\"", "{1 0}", "",
    false, "start-2432",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"\\\\A\" \"a\"", "{2 1}", "",
    false, "start-2433",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"\\\\A\" \"a\"", "{3 2}", "",
    false, "start-2434",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"\\\\A\" \"a\"", "{4 3}", "",
    false, "start-2435",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"\\\\A\" \"a\"", "{100 99}",
    "", false, "start-2436",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"\\\\A\" \"a\"", "{1 0}", "",
    false, "start-2437",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"\\\\A\" \"a\"", "{0 -1}",
    "", false, "start-2438",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"\\\\A\" \"a\"", "{2 1}",
    "", false, "start-2439",
  )
}

///|
test "Tcl regexp cases 2441 through 2480" {
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"\\\\A\" \"aba\"", "{0 -1}", "",
    false, "start-2440",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"\\\\A\" \"aba\"", "{0 -1}", "", false,
    "start-2441",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"\\\\A\" \"aba\"", "{1 0}", "", false,
    "start-2442",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"\\\\A\" \"aba\"", "{2 1}", "", false,
    "start-2443",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"\\\\A\" \"aba\"", "{3 2}", "", false,
    "start-2444",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"\\\\A\" \"aba\"", "{4 3}", "", false,
    "start-2445",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"\\\\A\" \"aba\"", "{100 99}", "",
    false, "start-2446",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"\\\\A\" \"aba\"", "{3 2}", "",
    false, "start-2447",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"\\\\A\" \"aba\"", "{2 1}", "",
    false, "start-2448",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"\\\\A\" \"aba\"", "{4 3}", "",
    false, "start-2449",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"\\\\A\" \"aba\"", "{0 -1} {1 0} {2 1}",
    "", false, "start-2450",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"\\\\A\" \"aba\"", "{0 -1} {1 0} {2 1}",
    "", false, "start-2451",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"\\\\A\" \"aba\"", "{1 0} {2 1}",
    "", false, "start-2452",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"\\\\A\" \"aba\"", "{2 1}", "",
    false, "start-2453",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"\\\\A\" \"aba\"", "{3 2}", "",
    false, "start-2454",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"\\\\A\" \"aba\"", "{4 3}", "",
    false, "start-2455",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"\\\\A\" \"aba\"", "{100 99}",
    "", false, "start-2456",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"\\\\A\" \"aba\"", "{3 2}",
    "", false, "start-2457",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"\\\\A\" \"aba\"", "{2 1}",
    "", false, "start-2458",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"\\\\A\" \"aba\"", "{4 3}",
    "", false, "start-2459",
  )
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"\\\\A\" \"abc\"", "{0 -1}", "",
    false, "start-2460",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"\\\\A\" \"abc\"", "{0 -1}", "", false,
    "start-2461",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"\\\\A\" \"abc\"", "{1 0}", "", false,
    "start-2462",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"\\\\A\" \"abc\"", "{2 1}", "", false,
    "start-2463",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"\\\\A\" \"abc\"", "{3 2}", "", false,
    "start-2464",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"\\\\A\" \"abc\"", "{4 3}", "", false,
    "start-2465",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"\\\\A\" \"abc\"", "{100 99}", "",
    false, "start-2466",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"\\\\A\" \"abc\"", "{3 2}", "",
    false, "start-2467",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"\\\\A\" \"abc\"", "{2 1}", "",
    false, "start-2468",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"\\\\A\" \"abc\"", "{4 3}", "",
    false, "start-2469",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"\\\\A\" \"abc\"", "{0 -1} {1 0} {2 1}",
    "", false, "start-2470",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"\\\\A\" \"abc\"", "{0 -1} {1 0} {2 1}",
    "", false, "start-2471",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"\\\\A\" \"abc\"", "{1 0} {2 1}",
    "", false, "start-2472",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"\\\\A\" \"abc\"", "{2 1}", "",
    false, "start-2473",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"\\\\A\" \"abc\"", "{3 2}", "",
    false, "start-2474",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"\\\\A\" \"abc\"", "{4 3}", "",
    false, "start-2475",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"\\\\A\" \"abc\"", "{100 99}",
    "", false, "start-2476",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"\\\\A\" \"abc\"", "{3 2}",
    "", false, "start-2477",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"\\\\A\" \"abc\"", "{2 1}",
    "", false, "start-2478",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"\\\\A\" \"abc\"", "{4 3}",
    "", false, "start-2479",
  )
}

///|
test "Tcl regexp cases 2481 through 2520" {
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"\\\\A\" \"a\\nb\"", "{0 -1}", "",
    false, "start-2480",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"\\\\A\" \"a\\nb\"", "{0 -1}", "",
    false, "start-2481",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"\\\\A\" \"a\\nb\"", "{1 0}", "",
    false, "start-2482",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"\\\\A\" \"a\\nb\"", "{2 1}", "",
    false, "start-2483",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"\\\\A\" \"a\\nb\"", "{3 2}", "",
    false, "start-2484",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"\\\\A\" \"a\\nb\"", "{4 3}", "",
    false, "start-2485",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"\\\\A\" \"a\\nb\"", "{100 99}",
    "", false, "start-2486",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"\\\\A\" \"a\\nb\"", "{3 2}", "",
    false, "start-2487",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"\\\\A\" \"a\\nb\"", "{2 1}",
    "", false, "start-2488",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"\\\\A\" \"a\\nb\"", "{4 3}",
    "", false, "start-2489",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"\\\\A\" \"a\\nb\"", "{0 -1} {1 0} {2 1}",
    "", false, "start-2490",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"\\\\A\" \"a\\nb\"", "{0 -1} {1 0} {2 1}",
    "", false, "start-2491",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"\\\\A\" \"a\\nb\"", "{1 0} {2 1}",
    "", false, "start-2492",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"\\\\A\" \"a\\nb\"", "{2 1}",
    "", false, "start-2493",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"\\\\A\" \"a\\nb\"", "{3 2}",
    "", false, "start-2494",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"\\\\A\" \"a\\nb\"", "{4 3}",
    "", false, "start-2495",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"\\\\A\" \"a\\nb\"", "{100 99}",
    "", false, "start-2496",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"\\\\A\" \"a\\nb\"", "{3 2}",
    "", false, "start-2497",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"\\\\A\" \"a\\nb\"", "{2 1}",
    "", false, "start-2498",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"\\\\A\" \"a\\nb\"", "{4 3}",
    "", false, "start-2499",
  )
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"\\\\A\" \"a\\n\"", "{0 -1}", "",
    false, "start-2500",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"\\\\A\" \"a\\n\"", "{0 -1}", "",
    false, "start-2501",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"\\\\A\" \"a\\n\"", "{1 0}", "", false,
    "start-2502",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"\\\\A\" \"a\\n\"", "{2 1}", "", false,
    "start-2503",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"\\\\A\" \"a\\n\"", "{3 2}", "", false,
    "start-2504",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"\\\\A\" \"a\\n\"", "{4 3}", "", false,
    "start-2505",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"\\\\A\" \"a\\n\"", "{100 99}",
    "", false, "start-2506",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"\\\\A\" \"a\\n\"", "{2 1}", "",
    false, "start-2507",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"\\\\A\" \"a\\n\"", "{1 0}", "",
    false, "start-2508",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"\\\\A\" \"a\\n\"", "{3 2}", "",
    false, "start-2509",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"\\\\A\" \"a\\n\"", "{0 -1} {1 0}",
    "", false, "start-2510",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"\\\\A\" \"a\\n\"", "{0 -1} {1 0}",
    "", false, "start-2511",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"\\\\A\" \"a\\n\"", "{1 0}", "",
    false, "start-2512",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"\\\\A\" \"a\\n\"", "{2 1}", "",
    false, "start-2513",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"\\\\A\" \"a\\n\"", "{3 2}", "",
    false, "start-2514",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"\\\\A\" \"a\\n\"", "{4 3}", "",
    false, "start-2515",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"\\\\A\" \"a\\n\"", "{100 99}",
    "", false, "start-2516",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"\\\\A\" \"a\\n\"", "{2 1}",
    "", false, "start-2517",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"\\\\A\" \"a\\n\"", "{1 0}",
    "", false, "start-2518",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"\\\\A\" \"a\\n\"", "{3 2}",
    "", false, "start-2519",
  )
}

///|
test "Tcl regexp cases 2521 through 2560" {
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"\\\\m\" \"\"", "", "", false, "start-2520",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"\\\\m\" \"\"", "", "", false, "start-2521",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"\\\\m\" \"\"", "", "", false, "start-2522",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"\\\\m\" \"\"", "", "", false, "start-2523",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"\\\\m\" \"\"", "", "", false, "start-2524",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"\\\\m\" \"\"", "", "", false, "start-2525",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"\\\\m\" \"\"", "", "", false, "start-2526",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"\\\\m\" \"\"", "", "", false, "start-2527",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"\\\\m\" \"\"", "", "", false,
    "start-2528",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"\\\\m\" \"\"", "", "", false,
    "start-2529",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"\\\\m\" \"\"", "", "", false,
    "start-2530",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"\\\\m\" \"\"", "", "", false,
    "start-2531",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"\\\\m\" \"\"", "", "", false,
    "start-2532",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"\\\\m\" \"\"", "", "", false,
    "start-2533",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"\\\\m\" \"\"", "", "", false,
    "start-2534",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"\\\\m\" \"\"", "", "", false,
    "start-2535",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"\\\\m\" \"\"", "", "", false,
    "start-2536",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"\\\\m\" \"\"", "", "", false,
    "start-2537",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"\\\\m\" \"\"", "", "", false,
    "start-2538",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"\\\\m\" \"\"", "", "", false,
    "start-2539",
  )
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"\\\\m\" \"a\"", "{0 -1}", "", false,
    "start-2540",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"\\\\m\" \"a\"", "{0 -1}", "", false,
    "start-2541",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"\\\\m\" \"a\"", "", "", false, "start-2542",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"\\\\m\" \"a\"", "", "", false, "start-2543",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"\\\\m\" \"a\"", "", "", false, "start-2544",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"\\\\m\" \"a\"", "", "", false, "start-2545",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"\\\\m\" \"a\"", "", "", false,
    "start-2546",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"\\\\m\" \"a\"", "", "", false,
    "start-2547",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"\\\\m\" \"a\"", "{0 -1}", "",
    false, "start-2548",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"\\\\m\" \"a\"", "", "", false,
    "start-2549",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"\\\\m\" \"a\"", "{0 -1}", "",
    false, "start-2550",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"\\\\m\" \"a\"", "{0 -1}", "",
    false, "start-2551",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"\\\\m\" \"a\"", "", "", false,
    "start-2552",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"\\\\m\" \"a\"", "", "", false,
    "start-2553",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"\\\\m\" \"a\"", "", "", false,
    "start-2554",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"\\\\m\" \"a\"", "", "", false,
    "start-2555",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"\\\\m\" \"a\"", "", "", false,
    "start-2556",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"\\\\m\" \"a\"", "", "", false,
    "start-2557",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"\\\\m\" \"a\"", "{0 -1}",
    "", false, "start-2558",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"\\\\m\" \"a\"", "", "", false,
    "start-2559",
  )
}

///|
test "Tcl regexp cases 2561 through 2600" {
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"\\\\m\" \"aba\"", "{0 -1}", "",
    false, "start-2560",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"\\\\m\" \"aba\"", "{0 -1}", "", false,
    "start-2561",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"\\\\m\" \"aba\"", "{1 0}", "", false,
    "start-2562",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"\\\\m\" \"aba\"", "{2 1}", "", false,
    "start-2563",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"\\\\m\" \"aba\"", "", "", false,
    "start-2564",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"\\\\m\" \"aba\"", "", "", false,
    "start-2565",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"\\\\m\" \"aba\"", "", "", false,
    "start-2566",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"\\\\m\" \"aba\"", "", "", false,
    "start-2567",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"\\\\m\" \"aba\"", "{2 1}", "",
    false, "start-2568",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"\\\\m\" \"aba\"", "", "", false,
    "start-2569",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"\\\\m\" \"aba\"", "{0 -1} {1 0} {2 1}",
    "", false, "start-2570",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"\\\\m\" \"aba\"", "{0 -1} {1 0} {2 1}",
    "", false, "start-2571",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"\\\\m\" \"aba\"", "{1 0} {2 1}",
    "", false, "start-2572",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"\\\\m\" \"aba\"", "{2 1}", "",
    false, "start-2573",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"\\\\m\" \"aba\"", "", "", false,
    "start-2574",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"\\\\m\" \"aba\"", "", "", false,
    "start-2575",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"\\\\m\" \"aba\"", "", "", false,
    "start-2576",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"\\\\m\" \"aba\"", "", "", false,
    "start-2577",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"\\\\m\" \"aba\"", "{2 1}",
    "", false, "start-2578",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"\\\\m\" \"aba\"", "", "",
    false, "start-2579",
  )
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"\\\\m\" \"abc\"", "{0 -1}", "",
    false, "start-2580",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"\\\\m\" \"abc\"", "{0 -1}", "", false,
    "start-2581",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"\\\\m\" \"abc\"", "{1 0}", "", false,
    "start-2582",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"\\\\m\" \"abc\"", "{2 1}", "", false,
    "start-2583",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"\\\\m\" \"abc\"", "", "", false,
    "start-2584",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"\\\\m\" \"abc\"", "", "", false,
    "start-2585",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"\\\\m\" \"abc\"", "", "", false,
    "start-2586",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"\\\\m\" \"abc\"", "", "", false,
    "start-2587",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"\\\\m\" \"abc\"", "{2 1}", "",
    false, "start-2588",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"\\\\m\" \"abc\"", "", "", false,
    "start-2589",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"\\\\m\" \"abc\"", "{0 -1} {1 0} {2 1}",
    "", false, "start-2590",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"\\\\m\" \"abc\"", "{0 -1} {1 0} {2 1}",
    "", false, "start-2591",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"\\\\m\" \"abc\"", "{1 0} {2 1}",
    "", false, "start-2592",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"\\\\m\" \"abc\"", "{2 1}", "",
    false, "start-2593",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"\\\\m\" \"abc\"", "", "", false,
    "start-2594",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"\\\\m\" \"abc\"", "", "", false,
    "start-2595",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"\\\\m\" \"abc\"", "", "", false,
    "start-2596",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"\\\\m\" \"abc\"", "", "", false,
    "start-2597",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"\\\\m\" \"abc\"", "{2 1}",
    "", false, "start-2598",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"\\\\m\" \"abc\"", "", "",
    false, "start-2599",
  )
}

///|
test "Tcl regexp cases 2601 through 2640" {
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"\\\\m\" \"a\\nb\"", "{0 -1}", "",
    false, "start-2600",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"\\\\m\" \"a\\nb\"", "{0 -1}", "",
    false, "start-2601",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"\\\\m\" \"a\\nb\"", "{2 1}", "",
    false, "start-2602",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"\\\\m\" \"a\\nb\"", "{2 1}", "",
    false, "start-2603",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"\\\\m\" \"a\\nb\"", "", "", false,
    "start-2604",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"\\\\m\" \"a\\nb\"", "", "", false,
    "start-2605",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"\\\\m\" \"a\\nb\"", "", "", false,
    "start-2606",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"\\\\m\" \"a\\nb\"", "", "", false,
    "start-2607",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"\\\\m\" \"a\\nb\"", "{2 1}",
    "", false, "start-2608",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"\\\\m\" \"a\\nb\"", "", "", false,
    "start-2609",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"\\\\m\" \"a\\nb\"", "{0 -1} {2 1}",
    "", false, "start-2610",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"\\\\m\" \"a\\nb\"", "{0 -1} {2 1}",
    "", false, "start-2611",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"\\\\m\" \"a\\nb\"", "{2 1}",
    "", false, "start-2612",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"\\\\m\" \"a\\nb\"", "{2 1}",
    "", false, "start-2613",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"\\\\m\" \"a\\nb\"", "", "", false,
    "start-2614",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"\\\\m\" \"a\\nb\"", "", "", false,
    "start-2615",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"\\\\m\" \"a\\nb\"", "", "",
    false, "start-2616",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"\\\\m\" \"a\\nb\"", "", "",
    false, "start-2617",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"\\\\m\" \"a\\nb\"", "{2 1}",
    "", false, "start-2618",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"\\\\m\" \"a\\nb\"", "", "",
    false, "start-2619",
  )
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"\\\\m\" \"a\\n\"", "{0 -1}", "",
    false, "start-2620",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"\\\\m\" \"a\\n\"", "{0 -1}", "",
    false, "start-2621",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"\\\\m\" \"a\\n\"", "", "", false,
    "start-2622",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"\\\\m\" \"a\\n\"", "", "", false,
    "start-2623",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"\\\\m\" \"a\\n\"", "", "", false,
    "start-2624",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"\\\\m\" \"a\\n\"", "", "", false,
    "start-2625",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"\\\\m\" \"a\\n\"", "", "", false,
    "start-2626",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"\\\\m\" \"a\\n\"", "", "", false,
    "start-2627",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"\\\\m\" \"a\\n\"", "", "", false,
    "start-2628",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"\\\\m\" \"a\\n\"", "", "", false,
    "start-2629",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"\\\\m\" \"a\\n\"", "{0 -1}",
    "", false, "start-2630",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"\\\\m\" \"a\\n\"", "{0 -1}",
    "", false, "start-2631",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"\\\\m\" \"a\\n\"", "", "", false,
    "start-2632",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"\\\\m\" \"a\\n\"", "", "", false,
    "start-2633",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"\\\\m\" \"a\\n\"", "", "", false,
    "start-2634",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"\\\\m\" \"a\\n\"", "", "", false,
    "start-2635",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"\\\\m\" \"a\\n\"", "", "",
    false, "start-2636",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"\\\\m\" \"a\\n\"", "", "",
    false, "start-2637",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"\\\\m\" \"a\\n\"", "", "",
    false, "start-2638",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"\\\\m\" \"a\\n\"", "", "",
    false, "start-2639",
  )
}

///|
test "Tcl regexp cases 2641 through 2680" {
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"(a)(b?)\" \"\"", "", "", false,
    "start-2640",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"(a)(b?)\" \"\"", "", "", false, "start-2641",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"(a)(b?)\" \"\"", "", "", false, "start-2642",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"(a)(b?)\" \"\"", "", "", false, "start-2643",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"(a)(b?)\" \"\"", "", "", false, "start-2644",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"(a)(b?)\" \"\"", "", "", false, "start-2645",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"(a)(b?)\" \"\"", "", "", false,
    "start-2646",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"(a)(b?)\" \"\"", "", "", false,
    "start-2647",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"(a)(b?)\" \"\"", "", "", false,
    "start-2648",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"(a)(b?)\" \"\"", "", "", false,
    "start-2649",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"(a)(b?)\" \"\"", "", "", false,
    "start-2650",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"(a)(b?)\" \"\"", "", "", false,
    "start-2651",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"(a)(b?)\" \"\"", "", "", false,
    "start-2652",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"(a)(b?)\" \"\"", "", "", false,
    "start-2653",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"(a)(b?)\" \"\"", "", "", false,
    "start-2654",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"(a)(b?)\" \"\"", "", "", false,
    "start-2655",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"(a)(b?)\" \"\"", "", "", false,
    "start-2656",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"(a)(b?)\" \"\"", "", "", false,
    "start-2657",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"(a)(b?)\" \"\"", "", "",
    false, "start-2658",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"(a)(b?)\" \"\"", "", "",
    false, "start-2659",
  )
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"(a)(b?)\" \"a\"", "{0 0} {0 0} {1 0}",
    "", false, "start-2660",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"(a)(b?)\" \"a\"", "{0 0} {0 0} {1 0}",
    "", false, "start-2661",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"(a)(b?)\" \"a\"", "", "", false,
    "start-2662",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"(a)(b?)\" \"a\"", "", "", false,
    "start-2663",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"(a)(b?)\" \"a\"", "", "", false,
    "start-2664",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"(a)(b?)\" \"a\"", "", "", false,
    "start-2665",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"(a)(b?)\" \"a\"", "", "", false,
    "start-2666",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"(a)(b?)\" \"a\"", "", "", false,
    "start-2667",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"(a)(b?)\" \"a\"", "{0 0} {0 0} {1 0}",
    "", false, "start-2668",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"(a)(b?)\" \"a\"", "", "", false,
    "start-2669",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"(a)(b?)\" \"a\"", "{0 0} {0 0} {1 0}",
    "", false, "start-2670",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"(a)(b?)\" \"a\"", "{0 0} {0 0} {1 0}",
    "", false, "start-2671",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"(a)(b?)\" \"a\"", "", "", false,
    "start-2672",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"(a)(b?)\" \"a\"", "", "", false,
    "start-2673",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"(a)(b?)\" \"a\"", "", "", false,
    "start-2674",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"(a)(b?)\" \"a\"", "", "", false,
    "start-2675",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"(a)(b?)\" \"a\"", "", "", false,
    "start-2676",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"(a)(b?)\" \"a\"", "", "", false,
    "start-2677",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"(a)(b?)\" \"a\"", "{0 0} {0 0} {1 0}",
    "", false, "start-2678",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"(a)(b?)\" \"a\"", "", "",
    false, "start-2679",
  )
}

///|
test "Tcl regexp cases 2681 through 2720" {
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"(a)(b?)\" \"aba\"", "{0 1} {0 0} {1 1}",
    "", false, "start-2680",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"(a)(b?)\" \"aba\"", "{0 1} {0 0} {1 1}",
    "", false, "start-2681",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"(a)(b?)\" \"aba\"", "{2 2} {2 2} {3 2}",
    "", false, "start-2682",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"(a)(b?)\" \"aba\"", "{2 2} {2 2} {3 2}",
    "", false, "start-2683",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"(a)(b?)\" \"aba\"", "", "", false,
    "start-2684",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"(a)(b?)\" \"aba\"", "", "", false,
    "start-2685",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"(a)(b?)\" \"aba\"", "", "", false,
    "start-2686",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"(a)(b?)\" \"aba\"", "", "", false,
    "start-2687",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"(a)(b?)\" \"aba\"", "{2 2} {2 2} {3 2}",
    "", false, "start-2688",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"(a)(b?)\" \"aba\"", "", "", false,
    "start-2689",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"(a)(b?)\" \"aba\"", "{0 1} {0 0} {1 1} {2 2} {2 2} {3 2}",
    "", false, "start-2690",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"(a)(b?)\" \"aba\"", "{0 1} {0 0} {1 1} {2 2} {2 2} {3 2}",
    "", false, "start-2691",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"(a)(b?)\" \"aba\"", "{2 2} {2 2} {3 2}",
    "", false, "start-2692",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"(a)(b?)\" \"aba\"", "{2 2} {2 2} {3 2}",
    "", false, "start-2693",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"(a)(b?)\" \"aba\"", "", "", false,
    "start-2694",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"(a)(b?)\" \"aba\"", "", "", false,
    "start-2695",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"(a)(b?)\" \"aba\"", "", "",
    false, "start-2696",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"(a)(b?)\" \"aba\"", "", "",
    false, "start-2697",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"(a)(b?)\" \"aba\"", "{2 2} {2 2} {3 2}",
    "", false, "start-2698",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"(a)(b?)\" \"aba\"", "", "",
    false, "start-2699",
  )
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"(a)(b?)\" \"abc\"", "{0 1} {0 0} {1 1}",
    "", false, "start-2700",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"(a)(b?)\" \"abc\"", "{0 1} {0 0} {1 1}",
    "", false, "start-2701",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"(a)(b?)\" \"abc\"", "", "", false,
    "start-2702",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"(a)(b?)\" \"abc\"", "", "", false,
    "start-2703",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"(a)(b?)\" \"abc\"", "", "", false,
    "start-2704",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"(a)(b?)\" \"abc\"", "", "", false,
    "start-2705",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"(a)(b?)\" \"abc\"", "", "", false,
    "start-2706",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"(a)(b?)\" \"abc\"", "", "", false,
    "start-2707",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"(a)(b?)\" \"abc\"", "", "", false,
    "start-2708",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"(a)(b?)\" \"abc\"", "", "", false,
    "start-2709",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"(a)(b?)\" \"abc\"", "{0 1} {0 0} {1 1}",
    "", false, "start-2710",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"(a)(b?)\" \"abc\"", "{0 1} {0 0} {1 1}",
    "", false, "start-2711",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"(a)(b?)\" \"abc\"", "", "", false,
    "start-2712",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"(a)(b?)\" \"abc\"", "", "", false,
    "start-2713",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"(a)(b?)\" \"abc\"", "", "", false,
    "start-2714",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"(a)(b?)\" \"abc\"", "", "", false,
    "start-2715",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"(a)(b?)\" \"abc\"", "", "",
    false, "start-2716",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"(a)(b?)\" \"abc\"", "", "",
    false, "start-2717",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"(a)(b?)\" \"abc\"", "", "",
    false, "start-2718",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"(a)(b?)\" \"abc\"", "", "",
    false, "start-2719",
  )
}

///|
test "Tcl regexp cases 2721 through 2760" {
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"(a)(b?)\" \"a\\nb\"", "{0 0} {0 0} {1 0}",
    "", false, "start-2720",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"(a)(b?)\" \"a\\nb\"", "{0 0} {0 0} {1 0}",
    "", false, "start-2721",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"(a)(b?)\" \"a\\nb\"", "", "", false,
    "start-2722",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"(a)(b?)\" \"a\\nb\"", "", "", false,
    "start-2723",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"(a)(b?)\" \"a\\nb\"", "", "", false,
    "start-2724",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"(a)(b?)\" \"a\\nb\"", "", "", false,
    "start-2725",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"(a)(b?)\" \"a\\nb\"", "", "", false,
    "start-2726",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"(a)(b?)\" \"a\\nb\"", "", "", false,
    "start-2727",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"(a)(b?)\" \"a\\nb\"", "", "",
    false, "start-2728",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"(a)(b?)\" \"a\\nb\"", "", "",
    false, "start-2729",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"(a)(b?)\" \"a\\nb\"", "{0 0} {0 0} {1 0}",
    "", false, "start-2730",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"(a)(b?)\" \"a\\nb\"", "{0 0} {0 0} {1 0}",
    "", false, "start-2731",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"(a)(b?)\" \"a\\nb\"", "", "",
    false, "start-2732",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"(a)(b?)\" \"a\\nb\"", "", "",
    false, "start-2733",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"(a)(b?)\" \"a\\nb\"", "", "",
    false, "start-2734",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"(a)(b?)\" \"a\\nb\"", "", "",
    false, "start-2735",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"(a)(b?)\" \"a\\nb\"", "", "",
    false, "start-2736",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"(a)(b?)\" \"a\\nb\"", "", "",
    false, "start-2737",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"(a)(b?)\" \"a\\nb\"", "",
    "", false, "start-2738",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"(a)(b?)\" \"a\\nb\"", "",
    "", false, "start-2739",
  )
  check_regexp_case(
    "regexp  -start \"-1\" -inline -indices -- \"(a)(b?)\" \"a\\n\"", "{0 0} {0 0} {1 0}",
    "", false, "start-2740",
  )
  check_regexp_case(
    "regexp  -start \"0\" -inline -indices -- \"(a)(b?)\" \"a\\n\"", "{0 0} {0 0} {1 0}",
    "", false, "start-2741",
  )
  check_regexp_case(
    "regexp  -start \"1\" -inline -indices -- \"(a)(b?)\" \"a\\n\"", "", "", false,
    "start-2742",
  )
  check_regexp_case(
    "regexp  -start \"2\" -inline -indices -- \"(a)(b?)\" \"a\\n\"", "", "", false,
    "start-2743",
  )
  check_regexp_case(
    "regexp  -start \"3\" -inline -indices -- \"(a)(b?)\" \"a\\n\"", "", "", false,
    "start-2744",
  )
  check_regexp_case(
    "regexp  -start \"4\" -inline -indices -- \"(a)(b?)\" \"a\\n\"", "", "", false,
    "start-2745",
  )
  check_regexp_case(
    "regexp  -start \"100\" -inline -indices -- \"(a)(b?)\" \"a\\n\"", "", "", false,
    "start-2746",
  )
  check_regexp_case(
    "regexp  -start \"end\" -inline -indices -- \"(a)(b?)\" \"a\\n\"", "", "", false,
    "start-2747",
  )
  check_regexp_case(
    "regexp  -start \"end-1\" -inline -indices -- \"(a)(b?)\" \"a\\n\"", "", "",
    false, "start-2748",
  )
  check_regexp_case(
    "regexp  -start \"end+1\" -inline -indices -- \"(a)(b?)\" \"a\\n\"", "", "",
    false, "start-2749",
  )
  check_regexp_case(
    "regexp -all -start \"-1\" -inline -indices -- \"(a)(b?)\" \"a\\n\"", "{0 0} {0 0} {1 0}",
    "", false, "start-2750",
  )
  check_regexp_case(
    "regexp -all -start \"0\" -inline -indices -- \"(a)(b?)\" \"a\\n\"", "{0 0} {0 0} {1 0}",
    "", false, "start-2751",
  )
  check_regexp_case(
    "regexp -all -start \"1\" -inline -indices -- \"(a)(b?)\" \"a\\n\"", "", "",
    false, "start-2752",
  )
  check_regexp_case(
    "regexp -all -start \"2\" -inline -indices -- \"(a)(b?)\" \"a\\n\"", "", "",
    false, "start-2753",
  )
  check_regexp_case(
    "regexp -all -start \"3\" -inline -indices -- \"(a)(b?)\" \"a\\n\"", "", "",
    false, "start-2754",
  )
  check_regexp_case(
    "regexp -all -start \"4\" -inline -indices -- \"(a)(b?)\" \"a\\n\"", "", "",
    false, "start-2755",
  )
  check_regexp_case(
    "regexp -all -start \"100\" -inline -indices -- \"(a)(b?)\" \"a\\n\"", "", "",
    false, "start-2756",
  )
  check_regexp_case(
    "regexp -all -start \"end\" -inline -indices -- \"(a)(b?)\" \"a\\n\"", "", "",
    false, "start-2757",
  )
  check_regexp_case(
    "regexp -all -start \"end-1\" -inline -indices -- \"(a)(b?)\" \"a\\n\"", "",
    "", false, "start-2758",
  )
  check_regexp_case(
    "regexp -all -start \"end+1\" -inline -indices -- \"(a)(b?)\" \"a\\n\"", "",
    "", false, "start-2759",
  )
}

///|
test "Tcl regexp cases 2761 through 2800" {
  check_regexp_case(
    "catch {regexp -start \"1+2\" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code] [dict get $o -level] [dict exists $o -errorcode]",
    "{{3 2}} 0 0 0", "", false, "index-2760",
  )
  check_regexp_case(
    "catch {regexp -start \"2-1\" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code] [dict get $o -level] [dict exists $o -errorcode]",
    "{{1 0}} 0 0 0", "", false, "index-2761",
  )
  check_regexp_case(
    "catch {regexp -start \"end--1\" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code] [dict get $o -level] [dict exists $o -errorcode]",
    "{{5 4}} 0 0 0", "", false, "index-2762",
  )
  check_regexp_case(
    "catch {regexp -start \"end+-1\" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code] [dict get $o -level] [dict exists $o -errorcode]",
    "{{3 2}} 0 0 0", "", false, "index-2763",
  )
  check_regexp_case(
    "catch {regexp -start \" 2 \" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code] [dict get $o -level] [dict exists $o -errorcode]",
    "{{2 1}} 0 0 0", "", false, "index-2764",
  )
  check_regexp_case(
    "catch {regexp -start \"+2\" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code] [dict get $o -level] [dict exists $o -errorcode]",
    "{{2 1}} 0 0 0", "", false, "index-2765",
  )
  check_regexp_case(
    "catch {regexp -start \"0x2\" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code] [dict get $o -level] [dict exists $o -errorcode]",
    "{{2 1}} 0 0 0", "", false, "index-2766",
  )
  check_regexp_case(
    "catch {regexp -start \"0o2\" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code] [dict get $o -level] [dict exists $o -errorcode]",
    "{{2 1}} 0 0 0", "", false, "index-2767",
  )
  check_regexp_case(
    "catch {regexp -start \"02\" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code] [dict get $o -level] [dict exists $o -errorcode]",
    "{{2 1}} 0 0 0", "", false, "index-2768",
  )
  check_regexp_case(
    "catch {regexp -start \"08\" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code] [dict get $o -level] [dict exists $o -errorcode]",
    "{bad index \"08\": must be integer?[+-]integer? or end?[+-]integer? (looks like invalid octal number)} 1 0 1",
    "", false, "index-2769",
  )
  check_regexp_case(
    "catch {regexp -start \"2+0x1\" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code] [dict get $o -level] [dict exists $o -errorcode]",
    "{{3 2}} 0 0 0", "", false, "index-2770",
  )
  check_regexp_case(
    "catch {regexp -start \"2 + 1\" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code] [dict get $o -level] [dict exists $o -errorcode]",
    "{bad index \"2 + 1\": must be integer?[+-]integer? or end?[+-]integer?} 1 0 1",
    "", false, "index-2771",
  )
  check_regexp_case(
    "catch {regexp -start \"2147483647\" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code] [dict get $o -level] [dict exists $o -errorcode]",
    "{{2147483647 2147483646}} 0 0 0", "", false, "index-2772",
  )
  check_regexp_case(
    "catch {regexp -start \"2147483648\" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code] [dict get $o -level] [dict exists $o -errorcode]",
    "{{0 -1}} 0 0 0", "", false, "index-2773",
  )
  check_regexp_case(
    "catch {regexp -start \"4294967295\" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code] [dict get $o -level] [dict exists $o -errorcode]",
    "{{0 -1}} 0 0 0", "", false, "index-2774",
  )
  check_regexp_case(
    "catch {regexp -start \"4294967296\" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code] [dict get $o -level] [dict exists $o -errorcode]",
    "{bad index \"4294967296\": must be integer?[+-]integer? or end?[+-]integer?} 1 0 1",
    "", false, "index-2775",
  )
  check_regexp_case(
    "catch {regexp -start \"-2147483648\" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code] [dict get $o -level] [dict exists $o -errorcode]",
    "{{0 -1}} 0 0 0", "", false, "index-2776",
  )
  check_regexp_case(
    "catch {regexp -start \"-2147483649\" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code] [dict get $o -level] [dict exists $o -errorcode]",
    "{{2147483647 2147483646}} 0 0 0", "", false, "index-2777",
  )
  check_regexp_case(
    "catch {regexp -start \"end+2147483647\" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code] [dict get $o -level] [dict exists $o -errorcode]",
    "{{0 -1}} 0 0 0", "", false, "index-2778",
  )
  check_regexp_case(
    "catch {regexp -start \"end+4294967295\" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code] [dict get $o -level] [dict exists $o -errorcode]",
    "{{3 2}} 0 0 0", "", false, "index-2779",
  )
  check_regexp_case(
    "catch {regexp -start \"end+4294967296\" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code] [dict get $o -level] [dict exists $o -errorcode]",
    "{bad index \"end+4294967296\": must be integer?[+-]integer? or end?[+-]integer?} 1 0 1",
    "", false, "index-2780",
  )
  check_regexp_case(
    "catch {regexp -start \"1+-1\" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code] [dict get $o -level] [dict exists $o -errorcode]",
    "{{0 -1}} 0 0 0", "", false, "index-2781",
  )
  check_regexp_case(
    "catch {regexp -start \"1--1\" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code] [dict get $o -level] [dict exists $o -errorcode]",
    "{{2 1}} 0 0 0", "", false, "index-2782",
  )
  check_regexp_case(
    "catch {regexp -start \" 1+2\" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code] [dict get $o -level] [dict exists $o -errorcode]",
    "{{3 2}} 0 0 0", "", false, "index-2783",
  )
  check_regexp_case(
    "catch {regexp -start \"1+2 \" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code] [dict get $o -level] [dict exists $o -errorcode]",
    "{{3 2}} 0 0 0", "", false, "index-2784",
  )
  check_regexp_case(
    "catch {regexp -start \"end \" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code] [dict get $o -level] [dict exists $o -errorcode]",
    "{bad index \"end \": must be integer?[+-]integer? or end?[+-]integer?} 1 0 1",
    "", false, "index-2785",
  )
  check_regexp_case(
    "catch {regexp -start \" end\" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code] [dict get $o -level] [dict exists $o -errorcode]",
    "{bad index \" end\": must be integer?[+-]integer? or end?[+-]integer?} 1 0 1",
    "", false, "index-2786",
  )
  check_regexp_case(
    "catch {regexp -start \"end+ 1\" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code] [dict get $o -level] [dict exists $o -errorcode]",
    "{bad index \"end+ 1\": must be integer?[+-]integer? or end?[+-]integer?} 1 0 1",
    "", false, "index-2787",
  )
  check_regexp_case(
    "catch {regexp -start \"1+ 1\" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code] [dict get $o -level] [dict exists $o -errorcode]",
    "{bad index \"1+ 1\": must be integer?[+-]integer? or end?[+-]integer?} 1 0 1",
    "", false, "index-2788",
  )
  check_regexp_case(
    "catch {regexp -start \"1+2+3\" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code] [dict get $o -level] [dict exists $o -errorcode]",
    "{bad index \"1+2+3\": must be integer?[+-]integer? or end?[+-]integer?} 1 0 1",
    "", false, "index-2789",
  )
  check_regexp_case(
    "catch {regexp -start \"\" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code] [dict get $o -level] [dict exists $o -errorcode]",
    "{bad index \"\": must be integer?[+-]integer? or end?[+-]integer?} 1 0 1", "",
    false, "index-2790",
  )
  check_regexp_case(
    "catch {regexp -start \"NaN\" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code] [dict get $o -level] [dict exists $o -errorcode]",
    "{bad index \"NaN\": must be integer?[+-]integer? or end?[+-]integer?} 1 0 1",
    "", false, "index-2791",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \".\" \"a\\nb\"", "{0 0}", "", false, "flags-2792",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \".\" \"a\\nb\"", "{0 0}", "", false,
    "flags-2793",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \".\" \"a\\nb\"", "{0 0}", "", false, "flags-2794",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \".\" \"a\\nb\"", "{0 0}", "", false, "flags-2795",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \".\" \"a\\nb\"", "{0 0}", "", false, "flags-2796",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \".\" \"a\\nb\"", "{0 0}", "", false,
    "flags-2797",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \".\" \"a\\nb\"", "{0 0}", "", false,
    "flags-2798",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \".\" \"a\\nb\"", "{0 0}",
    "", false, "flags-2799",
  )
}

///|
test "Tcl regexp cases 2801 through 2840" {
  check_regexp_case(
    "regexp -line -inline -indices -- \".\" \"a\\n\"", "{0 0}", "", false, "flags-2800",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \".\" \"a\\n\"", "{0 0}", "", false,
    "flags-2801",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \".\" \"a\\n\"", "{0 0}", "", false, "flags-2802",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \".\" \"a\\n\"", "{0 0}", "", false, "flags-2803",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \".\" \"a\\n\"", "{0 0}", "", false, "flags-2804",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \".\" \"a\\n\"", "{0 0}", "", false,
    "flags-2805",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \".\" \"a\\n\"", "{0 0}", "", false,
    "flags-2806",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \".\" \"a\\n\"", "{0 0}", "",
    false, "flags-2807",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \".\" \"A\"", "{0 0}", "", false, "flags-2808",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \".\" \"A\"", "{0 0}", "", false, "flags-2809",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \".\" \"A\"", "{0 0}", "", false, "flags-2810",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \".\" \"A\"", "{0 0}", "", false, "flags-2811",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \".\" \"A\"", "{0 0}", "", false, "flags-2812",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \".\" \"A\"", "{0 0}", "", false, "flags-2813",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \".\" \"A\"", "{0 0}", "", false,
    "flags-2814",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \".\" \"A\"", "{0 0}", "",
    false, "flags-2815",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \".\" \"a b\"", "{0 0}", "", false, "flags-2816",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \".\" \"a b\"", "{0 0}", "", false, "flags-2817",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \".\" \"a b\"", "{0 0}", "", false, "flags-2818",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \".\" \"a b\"", "{0 0}", "", false, "flags-2819",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \".\" \"a b\"", "{0 0}", "", false, "flags-2820",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \".\" \"a b\"", "{0 0}", "", false,
    "flags-2821",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \".\" \"a b\"", "{0 0}", "", false,
    "flags-2822",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \".\" \"a b\"", "{0 0}", "",
    false, "flags-2823",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \".\" \"ab\"", "{0 0}", "", false, "flags-2824",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \".\" \"ab\"", "{0 0}", "", false, "flags-2825",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \".\" \"ab\"", "{0 0}", "", false, "flags-2826",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \".\" \"ab\"", "{0 0}", "", false, "flags-2827",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \".\" \"ab\"", "{0 0}", "", false, "flags-2828",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \".\" \"ab\"", "{0 0}", "", false,
    "flags-2829",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \".\" \"ab\"", "{0 0}", "", false,
    "flags-2830",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \".\" \"ab\"", "{0 0}", "",
    false, "flags-2831",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \"\\[^b\\]+\" \"a\\nb\"", "{0 0}", "", false,
    "flags-2832",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"\\[^b\\]+\" \"a\\nb\"", "{0 1}", "",
    false, "flags-2833",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"\\[^b\\]+\" \"a\\nb\"", "{0 0}", "",
    false, "flags-2834",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"\\[^b\\]+\" \"a\\nb\"", "{0 1}", "",
    false, "flags-2835",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"\\[^b\\]+\" \"a\\nb\"", "{0 1}", "", false,
    "flags-2836",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"\\[^b\\]+\" \"a\\nb\"", "{0 0}",
    "", false, "flags-2837",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"\\[^b\\]+\" \"a\\nb\"", "{0 0}",
    "", false, "flags-2838",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"\\[^b\\]+\" \"a\\nb\"", "{0 0}",
    "", false, "flags-2839",
  )
}

///|
test "Tcl regexp cases 2841 through 2880" {
  check_regexp_case(
    "regexp -line -inline -indices -- \"\\[^b\\]+\" \"a\\n\"", "{0 0}", "", false,
    "flags-2840",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"\\[^b\\]+\" \"a\\n\"", "{0 1}", "",
    false, "flags-2841",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"\\[^b\\]+\" \"a\\n\"", "{0 0}", "", false,
    "flags-2842",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"\\[^b\\]+\" \"a\\n\"", "{0 1}", "", false,
    "flags-2843",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"\\[^b\\]+\" \"a\\n\"", "{0 1}", "", false,
    "flags-2844",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"\\[^b\\]+\" \"a\\n\"", "{0 0}", "",
    false, "flags-2845",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"\\[^b\\]+\" \"a\\n\"", "{0 0}",
    "", false, "flags-2846",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"\\[^b\\]+\" \"a\\n\"", "{0 0}",
    "", false, "flags-2847",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \"\\[^b\\]+\" \"A\"", "{0 0}", "", false, "flags-2848",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"\\[^b\\]+\" \"A\"", "{0 0}", "", false,
    "flags-2849",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"\\[^b\\]+\" \"A\"", "{0 0}", "", false,
    "flags-2850",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"\\[^b\\]+\" \"A\"", "{0 0}", "", false,
    "flags-2851",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"\\[^b\\]+\" \"A\"", "{0 0}", "", false,
    "flags-2852",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"\\[^b\\]+\" \"A\"", "{0 0}", "",
    false, "flags-2853",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"\\[^b\\]+\" \"A\"", "{0 0}", "",
    false, "flags-2854",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"\\[^b\\]+\" \"A\"", "{0 0}",
    "", false, "flags-2855",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \"\\[^b\\]+\" \"a b\"", "{0 1}", "", false,
    "flags-2856",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"\\[^b\\]+\" \"a b\"", "{0 1}", "",
    false, "flags-2857",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"\\[^b\\]+\" \"a b\"", "{0 1}", "", false,
    "flags-2858",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"\\[^b\\]+\" \"a b\"", "{0 1}", "", false,
    "flags-2859",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"\\[^b\\]+\" \"a b\"", "{0 1}", "", false,
    "flags-2860",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"\\[^b\\]+\" \"a b\"", "{0 1}", "",
    false, "flags-2861",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"\\[^b\\]+\" \"a b\"", "{0 1}",
    "", false, "flags-2862",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"\\[^b\\]+\" \"a b\"", "{0 1}",
    "", false, "flags-2863",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \"\\[^b\\]+\" \"ab\"", "{0 0}", "", false,
    "flags-2864",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"\\[^b\\]+\" \"ab\"", "{0 0}", "", false,
    "flags-2865",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"\\[^b\\]+\" \"ab\"", "{0 0}", "", false,
    "flags-2866",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"\\[^b\\]+\" \"ab\"", "{0 0}", "", false,
    "flags-2867",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"\\[^b\\]+\" \"ab\"", "{0 0}", "", false,
    "flags-2868",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"\\[^b\\]+\" \"ab\"", "{0 0}", "",
    false, "flags-2869",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"\\[^b\\]+\" \"ab\"", "{0 0}", "",
    false, "flags-2870",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"\\[^b\\]+\" \"ab\"", "{0 0}",
    "", false, "flags-2871",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \"^a.*\\$\" \"a\\nb\"", "{0 0}", "", false,
    "flags-2872",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"^a.*\\$\" \"a\\nb\"", "{0 2}", "",
    false, "flags-2873",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"^a.*\\$\" \"a\\nb\"", "", "", false,
    "flags-2874",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"^a.*\\$\" \"a\\nb\"", "{0 2}", "", false,
    "flags-2875",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"^a.*\\$\" \"a\\nb\"", "{0 2}", "", false,
    "flags-2876",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"^a.*\\$\" \"a\\nb\"", "{0 0}", "",
    false, "flags-2877",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"^a.*\\$\" \"a\\nb\"", "{0 0}",
    "", false, "flags-2878",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"^a.*\\$\" \"a\\nb\"", "{0 0}",
    "", false, "flags-2879",
  )
}

///|
test "Tcl regexp cases 2881 through 2920" {
  check_regexp_case(
    "regexp -line -inline -indices -- \"^a.*\\$\" \"a\\n\"", "{0 0}", "", false,
    "flags-2880",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"^a.*\\$\" \"a\\n\"", "{0 1}", "", false,
    "flags-2881",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"^a.*\\$\" \"a\\n\"", "", "", false, "flags-2882",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"^a.*\\$\" \"a\\n\"", "{0 1}", "", false,
    "flags-2883",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"^a.*\\$\" \"a\\n\"", "{0 1}", "", false,
    "flags-2884",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"^a.*\\$\" \"a\\n\"", "{0 0}", "",
    false, "flags-2885",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"^a.*\\$\" \"a\\n\"", "{0 0}", "",
    false, "flags-2886",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"^a.*\\$\" \"a\\n\"", "{0 0}",
    "", false, "flags-2887",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \"^a.*\\$\" \"A\"", "", "", false, "flags-2888",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"^a.*\\$\" \"A\"", "", "", false, "flags-2889",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"^a.*\\$\" \"A\"", "", "", false, "flags-2890",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"^a.*\\$\" \"A\"", "", "", false, "flags-2891",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"^a.*\\$\" \"A\"", "{0 0}", "", false, "flags-2892",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"^a.*\\$\" \"A\"", "{0 0}", "", false,
    "flags-2893",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"^a.*\\$\" \"A\"", "", "", false,
    "flags-2894",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"^a.*\\$\" \"A\"", "", "",
    false, "flags-2895",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \"^a.*\\$\" \"a b\"", "{0 2}", "", false, "flags-2896",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"^a.*\\$\" \"a b\"", "{0 2}", "", false,
    "flags-2897",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"^a.*\\$\" \"a b\"", "{0 2}", "", false,
    "flags-2898",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"^a.*\\$\" \"a b\"", "{0 2}", "", false,
    "flags-2899",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"^a.*\\$\" \"a b\"", "{0 2}", "", false,
    "flags-2900",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"^a.*\\$\" \"a b\"", "{0 2}", "",
    false, "flags-2901",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"^a.*\\$\" \"a b\"", "{0 2}", "",
    false, "flags-2902",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"^a.*\\$\" \"a b\"", "{0 2}",
    "", false, "flags-2903",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \"^a.*\\$\" \"ab\"", "{0 1}", "", false, "flags-2904",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"^a.*\\$\" \"ab\"", "{0 1}", "", false,
    "flags-2905",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"^a.*\\$\" \"ab\"", "{0 1}", "", false,
    "flags-2906",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"^a.*\\$\" \"ab\"", "{0 1}", "", false,
    "flags-2907",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"^a.*\\$\" \"ab\"", "{0 1}", "", false,
    "flags-2908",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"^a.*\\$\" \"ab\"", "{0 1}", "", false,
    "flags-2909",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"^a.*\\$\" \"ab\"", "{0 1}", "",
    false, "flags-2910",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"^a.*\\$\" \"ab\"", "{0 1}",
    "", false, "flags-2911",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \"a.b\" \"a\\nb\"", "", "", false, "flags-2912",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"a.b\" \"a\\nb\"", "{0 2}", "", false,
    "flags-2913",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"a.b\" \"a\\nb\"", "", "", false, "flags-2914",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"a.b\" \"a\\nb\"", "{0 2}", "", false,
    "flags-2915",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"a.b\" \"a\\nb\"", "{0 2}", "", false, "flags-2916",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"a.b\" \"a\\nb\"", "", "", false,
    "flags-2917",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"a.b\" \"a\\nb\"", "", "", false,
    "flags-2918",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"a.b\" \"a\\nb\"", "", "",
    false, "flags-2919",
  )
}

///|
test "Tcl regexp cases 2921 through 2960" {
  check_regexp_case(
    "regexp -line -inline -indices -- \"a.b\" \"a\\n\"", "", "", false, "flags-2920",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"a.b\" \"a\\n\"", "", "", false, "flags-2921",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"a.b\" \"a\\n\"", "", "", false, "flags-2922",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"a.b\" \"a\\n\"", "", "", false, "flags-2923",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"a.b\" \"a\\n\"", "", "", false, "flags-2924",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"a.b\" \"a\\n\"", "", "", false, "flags-2925",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"a.b\" \"a\\n\"", "", "", false,
    "flags-2926",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"a.b\" \"a\\n\"", "", "",
    false, "flags-2927",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \"a.b\" \"A\"", "", "", false, "flags-2928",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"a.b\" \"A\"", "", "", false, "flags-2929",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"a.b\" \"A\"", "", "", false, "flags-2930",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"a.b\" \"A\"", "", "", false, "flags-2931",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"a.b\" \"A\"", "", "", false, "flags-2932",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"a.b\" \"A\"", "", "", false, "flags-2933",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"a.b\" \"A\"", "", "", false, "flags-2934",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"a.b\" \"A\"", "", "", false,
    "flags-2935",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \"a.b\" \"a b\"", "{0 2}", "", false, "flags-2936",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"a.b\" \"a b\"", "{0 2}", "", false,
    "flags-2937",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"a.b\" \"a b\"", "{0 2}", "", false, "flags-2938",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"a.b\" \"a b\"", "{0 2}", "", false, "flags-2939",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"a.b\" \"a b\"", "{0 2}", "", false, "flags-2940",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"a.b\" \"a b\"", "{0 2}", "", false,
    "flags-2941",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"a.b\" \"a b\"", "{0 2}", "", false,
    "flags-2942",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"a.b\" \"a b\"", "{0 2}",
    "", false, "flags-2943",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \"a.b\" \"ab\"", "", "", false, "flags-2944",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"a.b\" \"ab\"", "", "", false, "flags-2945",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"a.b\" \"ab\"", "", "", false, "flags-2946",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"a.b\" \"ab\"", "", "", false, "flags-2947",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"a.b\" \"ab\"", "", "", false, "flags-2948",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"a.b\" \"ab\"", "", "", false, "flags-2949",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"a.b\" \"ab\"", "", "", false, "flags-2950",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"a.b\" \"ab\"", "", "", false,
    "flags-2951",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \"a b\" \"a\\nb\"", "", "", false, "flags-2952",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"a b\" \"a\\nb\"", "", "", false, "flags-2953",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"a b\" \"a\\nb\"", "", "", false, "flags-2954",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"a b\" \"a\\nb\"", "", "", false, "flags-2955",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"a b\" \"a\\nb\"", "", "", false, "flags-2956",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"a b\" \"a\\nb\"", "", "", false,
    "flags-2957",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"a b\" \"a\\nb\"", "", "", false,
    "flags-2958",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"a b\" \"a\\nb\"", "", "",
    false, "flags-2959",
  )
}

///|
test "Tcl regexp cases 2961 through 3000" {
  check_regexp_case(
    "regexp -line -inline -indices -- \"a b\" \"a\\n\"", "", "", false, "flags-2960",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"a b\" \"a\\n\"", "", "", false, "flags-2961",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"a b\" \"a\\n\"", "", "", false, "flags-2962",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"a b\" \"a\\n\"", "", "", false, "flags-2963",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"a b\" \"a\\n\"", "", "", false, "flags-2964",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"a b\" \"a\\n\"", "", "", false, "flags-2965",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"a b\" \"a\\n\"", "", "", false,
    "flags-2966",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"a b\" \"a\\n\"", "", "",
    false, "flags-2967",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \"a b\" \"A\"", "", "", false, "flags-2968",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"a b\" \"A\"", "", "", false, "flags-2969",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"a b\" \"A\"", "", "", false, "flags-2970",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"a b\" \"A\"", "", "", false, "flags-2971",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"a b\" \"A\"", "", "", false, "flags-2972",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"a b\" \"A\"", "", "", false, "flags-2973",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"a b\" \"A\"", "", "", false, "flags-2974",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"a b\" \"A\"", "", "", false,
    "flags-2975",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \"a b\" \"a b\"", "{0 2}", "", false, "flags-2976",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"a b\" \"a b\"", "{0 2}", "", false,
    "flags-2977",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"a b\" \"a b\"", "{0 2}", "", false, "flags-2978",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"a b\" \"a b\"", "", "", false, "flags-2979",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"a b\" \"a b\"", "{0 2}", "", false, "flags-2980",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"a b\" \"a b\"", "{0 2}", "", false,
    "flags-2981",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"a b\" \"a b\"", "{0 2}", "", false,
    "flags-2982",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"a b\" \"a b\"", "{0 2}",
    "", false, "flags-2983",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \"a b\" \"ab\"", "", "", false, "flags-2984",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"a b\" \"ab\"", "", "", false, "flags-2985",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"a b\" \"ab\"", "", "", false, "flags-2986",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"a b\" \"ab\"", "{0 1}", "", false, "flags-2987",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"a b\" \"ab\"", "", "", false, "flags-2988",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"a b\" \"ab\"", "", "", false, "flags-2989",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"a b\" \"ab\"", "", "", false, "flags-2990",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"a b\" \"ab\"", "", "", false,
    "flags-2991",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \"(?x)a b\" \"a\\nb\"", "", "", false, "flags-2992",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"(?x)a b\" \"a\\nb\"", "", "", false,
    "flags-2993",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"(?x)a b\" \"a\\nb\"", "", "", false,
    "flags-2994",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"(?x)a b\" \"a\\nb\"", "", "", false,
    "flags-2995",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"(?x)a b\" \"a\\nb\"", "", "", false, "flags-2996",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"(?x)a b\" \"a\\nb\"", "", "", false,
    "flags-2997",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"(?x)a b\" \"a\\nb\"", "", "", false,
    "flags-2998",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"(?x)a b\" \"a\\nb\"", "",
    "", false, "flags-2999",
  )
}

///|
test "Tcl regexp cases 3001 through 3040" {
  check_regexp_case(
    "regexp -line -inline -indices -- \"(?x)a b\" \"a\\n\"", "", "", false, "flags-3000",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"(?x)a b\" \"a\\n\"", "", "", false,
    "flags-3001",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"(?x)a b\" \"a\\n\"", "", "", false, "flags-3002",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"(?x)a b\" \"a\\n\"", "", "", false, "flags-3003",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"(?x)a b\" \"a\\n\"", "", "", false, "flags-3004",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"(?x)a b\" \"a\\n\"", "", "", false,
    "flags-3005",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"(?x)a b\" \"a\\n\"", "", "", false,
    "flags-3006",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"(?x)a b\" \"a\\n\"", "",
    "", false, "flags-3007",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \"(?x)a b\" \"A\"", "", "", false, "flags-3008",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"(?x)a b\" \"A\"", "", "", false, "flags-3009",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"(?x)a b\" \"A\"", "", "", false, "flags-3010",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"(?x)a b\" \"A\"", "", "", false, "flags-3011",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"(?x)a b\" \"A\"", "", "", false, "flags-3012",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"(?x)a b\" \"A\"", "", "", false,
    "flags-3013",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"(?x)a b\" \"A\"", "", "", false,
    "flags-3014",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"(?x)a b\" \"A\"", "", "",
    false, "flags-3015",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \"(?x)a b\" \"a b\"", "", "", false, "flags-3016",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"(?x)a b\" \"a b\"", "", "", false,
    "flags-3017",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"(?x)a b\" \"a b\"", "", "", false, "flags-3018",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"(?x)a b\" \"a b\"", "", "", false, "flags-3019",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"(?x)a b\" \"a b\"", "", "", false, "flags-3020",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"(?x)a b\" \"a b\"", "", "", false,
    "flags-3021",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"(?x)a b\" \"a b\"", "", "", false,
    "flags-3022",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"(?x)a b\" \"a b\"", "", "",
    false, "flags-3023",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \"(?x)a b\" \"ab\"", "{0 1}", "", false, "flags-3024",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"(?x)a b\" \"ab\"", "{0 1}", "", false,
    "flags-3025",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"(?x)a b\" \"ab\"", "{0 1}", "", false,
    "flags-3026",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"(?x)a b\" \"ab\"", "{0 1}", "", false,
    "flags-3027",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"(?x)a b\" \"ab\"", "{0 1}", "", false,
    "flags-3028",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"(?x)a b\" \"ab\"", "{0 1}", "", false,
    "flags-3029",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"(?x)a b\" \"ab\"", "{0 1}", "",
    false, "flags-3030",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"(?x)a b\" \"ab\"", "{0 1}",
    "", false, "flags-3031",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \"(?t)a b\" \"a\\nb\"", "", "", false, "flags-3032",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"(?t)a b\" \"a\\nb\"", "", "", false,
    "flags-3033",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"(?t)a b\" \"a\\nb\"", "", "", false,
    "flags-3034",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"(?t)a b\" \"a\\nb\"", "", "", false,
    "flags-3035",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"(?t)a b\" \"a\\nb\"", "", "", false, "flags-3036",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"(?t)a b\" \"a\\nb\"", "", "", false,
    "flags-3037",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"(?t)a b\" \"a\\nb\"", "", "", false,
    "flags-3038",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"(?t)a b\" \"a\\nb\"", "",
    "", false, "flags-3039",
  )
}

///|
test "Tcl regexp cases 3041 through 3080" {
  check_regexp_case(
    "regexp -line -inline -indices -- \"(?t)a b\" \"a\\n\"", "", "", false, "flags-3040",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"(?t)a b\" \"a\\n\"", "", "", false,
    "flags-3041",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"(?t)a b\" \"a\\n\"", "", "", false, "flags-3042",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"(?t)a b\" \"a\\n\"", "", "", false, "flags-3043",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"(?t)a b\" \"a\\n\"", "", "", false, "flags-3044",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"(?t)a b\" \"a\\n\"", "", "", false,
    "flags-3045",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"(?t)a b\" \"a\\n\"", "", "", false,
    "flags-3046",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"(?t)a b\" \"a\\n\"", "",
    "", false, "flags-3047",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \"(?t)a b\" \"A\"", "", "", false, "flags-3048",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"(?t)a b\" \"A\"", "", "", false, "flags-3049",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"(?t)a b\" \"A\"", "", "", false, "flags-3050",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"(?t)a b\" \"A\"", "", "", false, "flags-3051",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"(?t)a b\" \"A\"", "", "", false, "flags-3052",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"(?t)a b\" \"A\"", "", "", false,
    "flags-3053",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"(?t)a b\" \"A\"", "", "", false,
    "flags-3054",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"(?t)a b\" \"A\"", "", "",
    false, "flags-3055",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \"(?t)a b\" \"a b\"", "{0 2}", "", false, "flags-3056",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"(?t)a b\" \"a b\"", "{0 2}", "", false,
    "flags-3057",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"(?t)a b\" \"a b\"", "{0 2}", "", false,
    "flags-3058",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"(?t)a b\" \"a b\"", "{0 2}", "", false,
    "flags-3059",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"(?t)a b\" \"a b\"", "{0 2}", "", false,
    "flags-3060",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"(?t)a b\" \"a b\"", "{0 2}", "",
    false, "flags-3061",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"(?t)a b\" \"a b\"", "{0 2}", "",
    false, "flags-3062",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"(?t)a b\" \"a b\"", "{0 2}",
    "", false, "flags-3063",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \"(?t)a b\" \"ab\"", "", "", false, "flags-3064",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"(?t)a b\" \"ab\"", "", "", false, "flags-3065",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"(?t)a b\" \"ab\"", "", "", false, "flags-3066",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"(?t)a b\" \"ab\"", "", "", false, "flags-3067",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"(?t)a b\" \"ab\"", "", "", false, "flags-3068",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"(?t)a b\" \"ab\"", "", "", false,
    "flags-3069",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"(?t)a b\" \"ab\"", "", "", false,
    "flags-3070",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"(?t)a b\" \"ab\"", "", "",
    false, "flags-3071",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \"(?i)a\" \"a\\nb\"", "{0 0}", "", false, "flags-3072",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"(?i)a\" \"a\\nb\"", "{0 0}", "", false,
    "flags-3073",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"(?i)a\" \"a\\nb\"", "{0 0}", "", false,
    "flags-3074",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"(?i)a\" \"a\\nb\"", "{0 0}", "", false,
    "flags-3075",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"(?i)a\" \"a\\nb\"", "{0 0}", "", false,
    "flags-3076",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"(?i)a\" \"a\\nb\"", "{0 0}", "",
    false, "flags-3077",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"(?i)a\" \"a\\nb\"", "{0 0}", "",
    false, "flags-3078",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"(?i)a\" \"a\\nb\"", "{0 0}",
    "", false, "flags-3079",
  )
}

///|
test "Tcl regexp cases 3081 through 3120" {
  check_regexp_case(
    "regexp -line -inline -indices -- \"(?i)a\" \"a\\n\"", "{0 0}", "", false, "flags-3080",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"(?i)a\" \"a\\n\"", "{0 0}", "", false,
    "flags-3081",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"(?i)a\" \"a\\n\"", "{0 0}", "", false,
    "flags-3082",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"(?i)a\" \"a\\n\"", "{0 0}", "", false,
    "flags-3083",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"(?i)a\" \"a\\n\"", "{0 0}", "", false,
    "flags-3084",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"(?i)a\" \"a\\n\"", "{0 0}", "", false,
    "flags-3085",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"(?i)a\" \"a\\n\"", "{0 0}", "",
    false, "flags-3086",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"(?i)a\" \"a\\n\"", "{0 0}",
    "", false, "flags-3087",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \"(?i)a\" \"A\"", "{0 0}", "", false, "flags-3088",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"(?i)a\" \"A\"", "{0 0}", "", false,
    "flags-3089",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"(?i)a\" \"A\"", "{0 0}", "", false, "flags-3090",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"(?i)a\" \"A\"", "{0 0}", "", false, "flags-3091",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"(?i)a\" \"A\"", "{0 0}", "", false, "flags-3092",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"(?i)a\" \"A\"", "{0 0}", "", false,
    "flags-3093",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"(?i)a\" \"A\"", "{0 0}", "", false,
    "flags-3094",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"(?i)a\" \"A\"", "{0 0}",
    "", false, "flags-3095",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \"(?i)a\" \"a b\"", "{0 0}", "", false, "flags-3096",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"(?i)a\" \"a b\"", "{0 0}", "", false,
    "flags-3097",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"(?i)a\" \"a b\"", "{0 0}", "", false,
    "flags-3098",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"(?i)a\" \"a b\"", "{0 0}", "", false,
    "flags-3099",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"(?i)a\" \"a b\"", "{0 0}", "", false, "flags-3100",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"(?i)a\" \"a b\"", "{0 0}", "", false,
    "flags-3101",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"(?i)a\" \"a b\"", "{0 0}", "",
    false, "flags-3102",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"(?i)a\" \"a b\"", "{0 0}",
    "", false, "flags-3103",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \"(?i)a\" \"ab\"", "{0 0}", "", false, "flags-3104",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"(?i)a\" \"ab\"", "{0 0}", "", false,
    "flags-3105",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"(?i)a\" \"ab\"", "{0 0}", "", false,
    "flags-3106",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"(?i)a\" \"ab\"", "{0 0}", "", false,
    "flags-3107",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"(?i)a\" \"ab\"", "{0 0}", "", false, "flags-3108",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"(?i)a\" \"ab\"", "{0 0}", "", false,
    "flags-3109",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"(?i)a\" \"ab\"", "{0 0}", "", false,
    "flags-3110",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"(?i)a\" \"ab\"", "{0 0}",
    "", false, "flags-3111",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \"(?c)a\" \"a\\nb\"", "{0 0}", "", false, "flags-3112",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"(?c)a\" \"a\\nb\"", "{0 0}", "", false,
    "flags-3113",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"(?c)a\" \"a\\nb\"", "{0 0}", "", false,
    "flags-3114",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"(?c)a\" \"a\\nb\"", "{0 0}", "", false,
    "flags-3115",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"(?c)a\" \"a\\nb\"", "{0 0}", "", false,
    "flags-3116",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"(?c)a\" \"a\\nb\"", "{0 0}", "",
    false, "flags-3117",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"(?c)a\" \"a\\nb\"", "{0 0}", "",
    false, "flags-3118",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"(?c)a\" \"a\\nb\"", "{0 0}",
    "", false, "flags-3119",
  )
}

///|
test "Tcl regexp cases 3121 through 3160" {
  check_regexp_case(
    "regexp -line -inline -indices -- \"(?c)a\" \"a\\n\"", "{0 0}", "", false, "flags-3120",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"(?c)a\" \"a\\n\"", "{0 0}", "", false,
    "flags-3121",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"(?c)a\" \"a\\n\"", "{0 0}", "", false,
    "flags-3122",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"(?c)a\" \"a\\n\"", "{0 0}", "", false,
    "flags-3123",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"(?c)a\" \"a\\n\"", "{0 0}", "", false,
    "flags-3124",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"(?c)a\" \"a\\n\"", "{0 0}", "", false,
    "flags-3125",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"(?c)a\" \"a\\n\"", "{0 0}", "",
    false, "flags-3126",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"(?c)a\" \"a\\n\"", "{0 0}",
    "", false, "flags-3127",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \"(?c)a\" \"A\"", "", "", false, "flags-3128",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"(?c)a\" \"A\"", "", "", false, "flags-3129",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"(?c)a\" \"A\"", "", "", false, "flags-3130",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"(?c)a\" \"A\"", "", "", false, "flags-3131",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"(?c)a\" \"A\"", "", "", false, "flags-3132",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"(?c)a\" \"A\"", "", "", false, "flags-3133",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"(?c)a\" \"A\"", "", "", false,
    "flags-3134",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"(?c)a\" \"A\"", "", "", false,
    "flags-3135",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \"(?c)a\" \"a b\"", "{0 0}", "", false, "flags-3136",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"(?c)a\" \"a b\"", "{0 0}", "", false,
    "flags-3137",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"(?c)a\" \"a b\"", "{0 0}", "", false,
    "flags-3138",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"(?c)a\" \"a b\"", "{0 0}", "", false,
    "flags-3139",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"(?c)a\" \"a b\"", "{0 0}", "", false, "flags-3140",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"(?c)a\" \"a b\"", "{0 0}", "", false,
    "flags-3141",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"(?c)a\" \"a b\"", "{0 0}", "",
    false, "flags-3142",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"(?c)a\" \"a b\"", "{0 0}",
    "", false, "flags-3143",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \"(?c)a\" \"ab\"", "{0 0}", "", false, "flags-3144",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"(?c)a\" \"ab\"", "{0 0}", "", false,
    "flags-3145",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"(?c)a\" \"ab\"", "{0 0}", "", false,
    "flags-3146",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"(?c)a\" \"ab\"", "{0 0}", "", false,
    "flags-3147",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"(?c)a\" \"ab\"", "{0 0}", "", false, "flags-3148",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"(?c)a\" \"ab\"", "{0 0}", "", false,
    "flags-3149",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"(?c)a\" \"ab\"", "{0 0}", "", false,
    "flags-3150",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"(?c)a\" \"ab\"", "{0 0}",
    "", false, "flags-3151",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \"(?n).\" \"a\\nb\"", "{0 0}", "", false, "flags-3152",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"(?n).\" \"a\\nb\"", "{0 0}", "", false,
    "flags-3153",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"(?n).\" \"a\\nb\"", "{0 0}", "", false,
    "flags-3154",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"(?n).\" \"a\\nb\"", "{0 0}", "", false,
    "flags-3155",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"(?n).\" \"a\\nb\"", "{0 0}", "", false,
    "flags-3156",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"(?n).\" \"a\\nb\"", "{0 0}", "",
    false, "flags-3157",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"(?n).\" \"a\\nb\"", "{0 0}", "",
    false, "flags-3158",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"(?n).\" \"a\\nb\"", "{0 0}",
    "", false, "flags-3159",
  )
}

///|
test "Tcl regexp cases 3161 through 3200" {
  check_regexp_case(
    "regexp -line -inline -indices -- \"(?n).\" \"a\\n\"", "{0 0}", "", false, "flags-3160",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"(?n).\" \"a\\n\"", "{0 0}", "", false,
    "flags-3161",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"(?n).\" \"a\\n\"", "{0 0}", "", false,
    "flags-3162",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"(?n).\" \"a\\n\"", "{0 0}", "", false,
    "flags-3163",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"(?n).\" \"a\\n\"", "{0 0}", "", false,
    "flags-3164",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"(?n).\" \"a\\n\"", "{0 0}", "", false,
    "flags-3165",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"(?n).\" \"a\\n\"", "{0 0}", "",
    false, "flags-3166",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"(?n).\" \"a\\n\"", "{0 0}",
    "", false, "flags-3167",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \"(?n).\" \"A\"", "{0 0}", "", false, "flags-3168",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"(?n).\" \"A\"", "{0 0}", "", false,
    "flags-3169",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"(?n).\" \"A\"", "{0 0}", "", false, "flags-3170",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"(?n).\" \"A\"", "{0 0}", "", false, "flags-3171",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"(?n).\" \"A\"", "{0 0}", "", false, "flags-3172",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"(?n).\" \"A\"", "{0 0}", "", false,
    "flags-3173",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"(?n).\" \"A\"", "{0 0}", "", false,
    "flags-3174",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"(?n).\" \"A\"", "{0 0}",
    "", false, "flags-3175",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \"(?n).\" \"a b\"", "{0 0}", "", false, "flags-3176",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"(?n).\" \"a b\"", "{0 0}", "", false,
    "flags-3177",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"(?n).\" \"a b\"", "{0 0}", "", false,
    "flags-3178",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"(?n).\" \"a b\"", "{0 0}", "", false,
    "flags-3179",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"(?n).\" \"a b\"", "{0 0}", "", false, "flags-3180",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"(?n).\" \"a b\"", "{0 0}", "", false,
    "flags-3181",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"(?n).\" \"a b\"", "{0 0}", "",
    false, "flags-3182",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"(?n).\" \"a b\"", "{0 0}",
    "", false, "flags-3183",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \"(?n).\" \"ab\"", "{0 0}", "", false, "flags-3184",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"(?n).\" \"ab\"", "{0 0}", "", false,
    "flags-3185",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"(?n).\" \"ab\"", "{0 0}", "", false,
    "flags-3186",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"(?n).\" \"ab\"", "{0 0}", "", false,
    "flags-3187",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"(?n).\" \"ab\"", "{0 0}", "", false, "flags-3188",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"(?n).\" \"ab\"", "{0 0}", "", false,
    "flags-3189",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"(?n).\" \"ab\"", "{0 0}", "", false,
    "flags-3190",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"(?n).\" \"ab\"", "{0 0}",
    "", false, "flags-3191",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \"(?s).\" \"a\\nb\"", "{0 0}", "", false, "flags-3192",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"(?s).\" \"a\\nb\"", "{0 0}", "", false,
    "flags-3193",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"(?s).\" \"a\\nb\"", "{0 0}", "", false,
    "flags-3194",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"(?s).\" \"a\\nb\"", "{0 0}", "", false,
    "flags-3195",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"(?s).\" \"a\\nb\"", "{0 0}", "", false,
    "flags-3196",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"(?s).\" \"a\\nb\"", "{0 0}", "",
    false, "flags-3197",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"(?s).\" \"a\\nb\"", "{0 0}", "",
    false, "flags-3198",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"(?s).\" \"a\\nb\"", "{0 0}",
    "", false, "flags-3199",
  )
}

///|
test "Tcl regexp cases 3201 through 3240" {
  check_regexp_case(
    "regexp -line -inline -indices -- \"(?s).\" \"a\\n\"", "{0 0}", "", false, "flags-3200",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"(?s).\" \"a\\n\"", "{0 0}", "", false,
    "flags-3201",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"(?s).\" \"a\\n\"", "{0 0}", "", false,
    "flags-3202",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"(?s).\" \"a\\n\"", "{0 0}", "", false,
    "flags-3203",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"(?s).\" \"a\\n\"", "{0 0}", "", false,
    "flags-3204",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"(?s).\" \"a\\n\"", "{0 0}", "", false,
    "flags-3205",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"(?s).\" \"a\\n\"", "{0 0}", "",
    false, "flags-3206",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"(?s).\" \"a\\n\"", "{0 0}",
    "", false, "flags-3207",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \"(?s).\" \"A\"", "{0 0}", "", false, "flags-3208",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"(?s).\" \"A\"", "{0 0}", "", false,
    "flags-3209",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"(?s).\" \"A\"", "{0 0}", "", false, "flags-3210",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"(?s).\" \"A\"", "{0 0}", "", false, "flags-3211",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"(?s).\" \"A\"", "{0 0}", "", false, "flags-3212",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"(?s).\" \"A\"", "{0 0}", "", false,
    "flags-3213",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"(?s).\" \"A\"", "{0 0}", "", false,
    "flags-3214",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"(?s).\" \"A\"", "{0 0}",
    "", false, "flags-3215",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \"(?s).\" \"a b\"", "{0 0}", "", false, "flags-3216",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"(?s).\" \"a b\"", "{0 0}", "", false,
    "flags-3217",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"(?s).\" \"a b\"", "{0 0}", "", false,
    "flags-3218",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"(?s).\" \"a b\"", "{0 0}", "", false,
    "flags-3219",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"(?s).\" \"a b\"", "{0 0}", "", false, "flags-3220",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"(?s).\" \"a b\"", "{0 0}", "", false,
    "flags-3221",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"(?s).\" \"a b\"", "{0 0}", "",
    false, "flags-3222",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"(?s).\" \"a b\"", "{0 0}",
    "", false, "flags-3223",
  )
  check_regexp_case(
    "regexp -line -inline -indices -- \"(?s).\" \"ab\"", "{0 0}", "", false, "flags-3224",
  )
  check_regexp_case(
    "regexp -lineanchor -inline -indices -- \"(?s).\" \"ab\"", "{0 0}", "", false,
    "flags-3225",
  )
  check_regexp_case(
    "regexp -linestop -inline -indices -- \"(?s).\" \"ab\"", "{0 0}", "", false,
    "flags-3226",
  )
  check_regexp_case(
    "regexp -expanded -inline -indices -- \"(?s).\" \"ab\"", "{0 0}", "", false,
    "flags-3227",
  )
  check_regexp_case(
    "regexp -nocase -inline -indices -- \"(?s).\" \"ab\"", "{0 0}", "", false, "flags-3228",
  )
  check_regexp_case(
    "regexp -line -nocase -inline -indices -- \"(?s).\" \"ab\"", "{0 0}", "", false,
    "flags-3229",
  )
  check_regexp_case(
    "regexp -line -linestop -inline -indices -- \"(?s).\" \"ab\"", "{0 0}", "", false,
    "flags-3230",
  )
  check_regexp_case(
    "regexp -lineanchor -linestop -inline -indices -- \"(?s).\" \"ab\"", "{0 0}",
    "", false, "flags-3231",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\" \"\" \"X\" out];list $n $out", "1 X", "",
    false, "replacement-3232",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\" \"\" \"X\" out];list $n $out", "0 {}",
    "", false, "replacement-3233",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\" \"\" \"&\" out];list $n $out", "1 {}", "",
    false, "replacement-3234",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\" \"\" \"&\" out];list $n $out", "1 {}",
    "", false, "replacement-3235",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\" \"\" \"\\\\0\" out];list $n $out", "1 {}",
    "", false, "replacement-3236",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\" \"\" \"\\\\0\" out];list $n $out", "1 {}",
    "", false, "replacement-3237",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\" \"\" \"<\\\\1>\" out];list $n $out", "1 <>",
    "", false, "replacement-3238",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\" \"\" \"<\\\\1>\" out];list $n $out",
    "1 <>", "", false, "replacement-3239",
  )
}

///|
test "Tcl regexp cases 3241 through 3280" {
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\" \"\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 -", "", false, "replacement-3240",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\" \"\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 -", "", false, "replacement-3241",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\" \"\" \"\\\\&\" out];list $n $out", "1 &",
    "", false, "replacement-3242",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\" \"\" \"\\\\&\" out];list $n $out", "1 &",
    "", false, "replacement-3243",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\" \"\" \"\\\\\\\\\" out];list $n $out", "1 \\\\",
    "", false, "replacement-3244",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\" \"\" \"\\\\\\\\\" out];list $n $out",
    "1 \\\\", "", false, "replacement-3245",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\" \"\" \"\\\\n\" out];list $n $out", "1 {\\n}",
    "", false, "replacement-3246",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\" \"\" \"\\\\n\" out];list $n $out", "1 {\\n}",
    "", false, "replacement-3247",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\" \"\" \"x\\\\\" out];list $n $out", "1 x\\\\",
    "", false, "replacement-3248",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\" \"\" \"x\\\\\" out];list $n $out", "1 x\\\\",
    "", false, "replacement-3249",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\" \"\" \"&&\" out];list $n $out", "1 {}", "",
    false, "replacement-3250",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\" \"\" \"&&\" out];list $n $out", "1 {}",
    "", false, "replacement-3251",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\" \"abc\" \"X\" out];list $n $out", "1 Xabc",
    "", false, "replacement-3252",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\" \"abc\" \"X\" out];list $n $out", "3 XaXbXc",
    "", false, "replacement-3253",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\" \"abc\" \"&\" out];list $n $out", "1 abc",
    "", false, "replacement-3254",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\" \"abc\" \"&\" out];list $n $out", "4 abc",
    "", false, "replacement-3255",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\" \"abc\" \"\\\\0\" out];list $n $out", "1 abc",
    "", false, "replacement-3256",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\" \"abc\" \"\\\\0\" out];list $n $out",
    "4 abc", "", false, "replacement-3257",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\" \"abc\" \"<\\\\1>\" out];list $n $out", "1 <>abc",
    "", false, "replacement-3258",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\" \"abc\" \"<\\\\1>\" out];list $n $out",
    "4 <>a<>b<>c<>", "", false, "replacement-3259",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\" \"abc\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 -abc", "", false, "replacement-3260",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\" \"abc\" \"\\\\2-\\\\9\" out];list $n $out",
    "4 -a-b-c-", "", false, "replacement-3261",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\" \"abc\" \"\\\\&\" out];list $n $out", "1 &abc",
    "", false, "replacement-3262",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\" \"abc\" \"\\\\&\" out];list $n $out",
    "4 &a&b&c&", "", false, "replacement-3263",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\" \"abc\" \"\\\\\\\\\" out];list $n $out",
    "1 {\\abc}", "", false, "replacement-3264",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\" \"abc\" \"\\\\\\\\\" out];list $n $out",
    "4 \\\\a\\\\b\\\\c\\\\", "", false, "replacement-3265",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\" \"abc\" \"\\\\n\" out];list $n $out", "1 {\\nabc}",
    "", false, "replacement-3266",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\" \"abc\" \"\\\\n\" out];list $n $out",
    "4 {\\na\\nb\\nc\\n}", "", false, "replacement-3267",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\" \"abc\" \"x\\\\\" out];list $n $out", "1 {x\\abc}",
    "", false, "replacement-3268",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\" \"abc\" \"x\\\\\" out];list $n $out",
    "4 x\\\\ax\\\\bx\\\\cx\\\\", "", false, "replacement-3269",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\" \"abc\" \"&&\" out];list $n $out", "1 abc",
    "", false, "replacement-3270",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\" \"abc\" \"&&\" out];list $n $out", "4 abc",
    "", false, "replacement-3271",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\" \"aba\" \"X\" out];list $n $out", "1 Xaba",
    "", false, "replacement-3272",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\" \"aba\" \"X\" out];list $n $out", "3 XaXbXa",
    "", false, "replacement-3273",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\" \"aba\" \"&\" out];list $n $out", "1 aba",
    "", false, "replacement-3274",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\" \"aba\" \"&\" out];list $n $out", "4 aba",
    "", false, "replacement-3275",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\" \"aba\" \"\\\\0\" out];list $n $out", "1 aba",
    "", false, "replacement-3276",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\" \"aba\" \"\\\\0\" out];list $n $out",
    "4 aba", "", false, "replacement-3277",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\" \"aba\" \"<\\\\1>\" out];list $n $out", "1 <>aba",
    "", false, "replacement-3278",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\" \"aba\" \"<\\\\1>\" out];list $n $out",
    "4 <>a<>b<>a<>", "", false, "replacement-3279",
  )
}

///|
test "Tcl regexp cases 3281 through 3320" {
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\" \"aba\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 -aba", "", false, "replacement-3280",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\" \"aba\" \"\\\\2-\\\\9\" out];list $n $out",
    "4 -a-b-a-", "", false, "replacement-3281",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\" \"aba\" \"\\\\&\" out];list $n $out", "1 &aba",
    "", false, "replacement-3282",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\" \"aba\" \"\\\\&\" out];list $n $out",
    "4 &a&b&a&", "", false, "replacement-3283",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\" \"aba\" \"\\\\\\\\\" out];list $n $out",
    "1 {\\aba}", "", false, "replacement-3284",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\" \"aba\" \"\\\\\\\\\" out];list $n $out",
    "4 \\\\a\\\\b\\\\a\\\\", "", false, "replacement-3285",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\" \"aba\" \"\\\\n\" out];list $n $out", "1 {\\naba}",
    "", false, "replacement-3286",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\" \"aba\" \"\\\\n\" out];list $n $out",
    "4 {\\na\\nb\\na\\n}", "", false, "replacement-3287",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\" \"aba\" \"x\\\\\" out];list $n $out", "1 {x\\aba}",
    "", false, "replacement-3288",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\" \"aba\" \"x\\\\\" out];list $n $out",
    "4 x\\\\ax\\\\bx\\\\ax\\\\", "", false, "replacement-3289",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\" \"aba\" \"&&\" out];list $n $out", "1 aba",
    "", false, "replacement-3290",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\" \"aba\" \"&&\" out];list $n $out", "4 aba",
    "", false, "replacement-3291",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\" \"a\\nb\" \"X\" out];list $n $out", "1 {Xa\nb}",
    "", false, "replacement-3292",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\" \"a\\nb\" \"X\" out];list $n $out", "3 {XaX\nXb}",
    "", false, "replacement-3293",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\" \"a\\nb\" \"&\" out];list $n $out", "1 {a\nb}",
    "", false, "replacement-3294",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\" \"a\\nb\" \"&\" out];list $n $out", "4 {a\nb}",
    "", false, "replacement-3295",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\" \"a\\nb\" \"\\\\0\" out];list $n $out", "1 {a\nb}",
    "", false, "replacement-3296",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\" \"a\\nb\" \"\\\\0\" out];list $n $out",
    "4 {a\nb}", "", false, "replacement-3297",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\" \"a\\nb\" \"<\\\\1>\" out];list $n $out",
    "1 {<>a\nb}", "", false, "replacement-3298",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\" \"a\\nb\" \"<\\\\1>\" out];list $n $out",
    "4 {<>a<>\n<>b<>}", "", false, "replacement-3299",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\" \"a\\nb\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 {-a\nb}", "", false, "replacement-3300",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\" \"a\\nb\" \"\\\\2-\\\\9\" out];list $n $out",
    "4 {-a-\n-b-}", "", false, "replacement-3301",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\" \"a\\nb\" \"\\\\&\" out];list $n $out", "1 {&a\nb}",
    "", false, "replacement-3302",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\" \"a\\nb\" \"\\\\&\" out];list $n $out",
    "4 {&a&\n&b&}", "", false, "replacement-3303",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\" \"a\\nb\" \"\\\\\\\\\" out];list $n $out",
    "1 {\\a\nb}", "", false, "replacement-3304",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\" \"a\\nb\" \"\\\\\\\\\" out];list $n $out",
    "4 \\\\a\\\\\\n\\\\b\\\\", "", false, "replacement-3305",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\" \"a\\nb\" \"\\\\n\" out];list $n $out", "1 {\\na\nb}",
    "", false, "replacement-3306",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\" \"a\\nb\" \"\\\\n\" out];list $n $out",
    "4 {\\na\\n\n\\nb\\n}", "", false, "replacement-3307",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\" \"a\\nb\" \"x\\\\\" out];list $n $out", "1 {x\\a\nb}",
    "", false, "replacement-3308",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\" \"a\\nb\" \"x\\\\\" out];list $n $out",
    "4 x\\\\ax\\\\\\nx\\\\bx\\\\", "", false, "replacement-3309",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\" \"a\\nb\" \"&&\" out];list $n $out", "1 {a\nb}",
    "", false, "replacement-3310",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\" \"a\\nb\" \"&&\" out];list $n $out",
    "4 {a\nb}", "", false, "replacement-3311",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"()\" \"\" \"X\" out];list $n $out", "1 X", "",
    false, "replacement-3312",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"()\" \"\" \"X\" out];list $n $out", "1 X",
    "", false, "replacement-3313",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"()\" \"\" \"&\" out];list $n $out", "1 {}",
    "", false, "replacement-3314",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"()\" \"\" \"&\" out];list $n $out", "1 {}",
    "", false, "replacement-3315",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"()\" \"\" \"\\\\0\" out];list $n $out", "1 {}",
    "", false, "replacement-3316",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"()\" \"\" \"\\\\0\" out];list $n $out",
    "1 {}", "", false, "replacement-3317",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"()\" \"\" \"<\\\\1>\" out];list $n $out", "1 <>",
    "", false, "replacement-3318",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"()\" \"\" \"<\\\\1>\" out];list $n $out",
    "1 <>", "", false, "replacement-3319",
  )
}

///|
test "Tcl regexp cases 3321 through 3360" {
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"()\" \"\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 -", "", false, "replacement-3320",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"()\" \"\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 -", "", false, "replacement-3321",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"()\" \"\" \"\\\\&\" out];list $n $out", "1 &",
    "", false, "replacement-3322",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"()\" \"\" \"\\\\&\" out];list $n $out",
    "1 &", "", false, "replacement-3323",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"()\" \"\" \"\\\\\\\\\" out];list $n $out", "1 \\\\",
    "", false, "replacement-3324",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"()\" \"\" \"\\\\\\\\\" out];list $n $out",
    "1 \\\\", "", false, "replacement-3325",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"()\" \"\" \"\\\\n\" out];list $n $out", "1 {\\n}",
    "", false, "replacement-3326",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"()\" \"\" \"\\\\n\" out];list $n $out",
    "1 {\\n}", "", false, "replacement-3327",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"()\" \"\" \"x\\\\\" out];list $n $out", "1 x\\\\",
    "", false, "replacement-3328",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"()\" \"\" \"x\\\\\" out];list $n $out",
    "1 x\\\\", "", false, "replacement-3329",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"()\" \"\" \"&&\" out];list $n $out", "1 {}",
    "", false, "replacement-3330",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"()\" \"\" \"&&\" out];list $n $out", "1 {}",
    "", false, "replacement-3331",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"()\" \"abc\" \"X\" out];list $n $out", "1 Xabc",
    "", false, "replacement-3332",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"()\" \"abc\" \"X\" out];list $n $out", "4 XaXbXcX",
    "", false, "replacement-3333",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"()\" \"abc\" \"&\" out];list $n $out", "1 abc",
    "", false, "replacement-3334",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"()\" \"abc\" \"&\" out];list $n $out", "4 abc",
    "", false, "replacement-3335",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"()\" \"abc\" \"\\\\0\" out];list $n $out", "1 abc",
    "", false, "replacement-3336",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"()\" \"abc\" \"\\\\0\" out];list $n $out",
    "4 abc", "", false, "replacement-3337",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"()\" \"abc\" \"<\\\\1>\" out];list $n $out",
    "1 <>abc", "", false, "replacement-3338",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"()\" \"abc\" \"<\\\\1>\" out];list $n $out",
    "4 <>a<>b<>c<>", "", false, "replacement-3339",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"()\" \"abc\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 -abc", "", false, "replacement-3340",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"()\" \"abc\" \"\\\\2-\\\\9\" out];list $n $out",
    "4 -a-b-c-", "", false, "replacement-3341",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"()\" \"abc\" \"\\\\&\" out];list $n $out", "1 &abc",
    "", false, "replacement-3342",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"()\" \"abc\" \"\\\\&\" out];list $n $out",
    "4 &a&b&c&", "", false, "replacement-3343",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"()\" \"abc\" \"\\\\\\\\\" out];list $n $out",
    "1 {\\abc}", "", false, "replacement-3344",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"()\" \"abc\" \"\\\\\\\\\" out];list $n $out",
    "4 \\\\a\\\\b\\\\c\\\\", "", false, "replacement-3345",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"()\" \"abc\" \"\\\\n\" out];list $n $out", "1 {\\nabc}",
    "", false, "replacement-3346",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"()\" \"abc\" \"\\\\n\" out];list $n $out",
    "4 {\\na\\nb\\nc\\n}", "", false, "replacement-3347",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"()\" \"abc\" \"x\\\\\" out];list $n $out", "1 {x\\abc}",
    "", false, "replacement-3348",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"()\" \"abc\" \"x\\\\\" out];list $n $out",
    "4 x\\\\ax\\\\bx\\\\cx\\\\", "", false, "replacement-3349",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"()\" \"abc\" \"&&\" out];list $n $out", "1 abc",
    "", false, "replacement-3350",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"()\" \"abc\" \"&&\" out];list $n $out",
    "4 abc", "", false, "replacement-3351",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"()\" \"aba\" \"X\" out];list $n $out", "1 Xaba",
    "", false, "replacement-3352",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"()\" \"aba\" \"X\" out];list $n $out", "4 XaXbXaX",
    "", false, "replacement-3353",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"()\" \"aba\" \"&\" out];list $n $out", "1 aba",
    "", false, "replacement-3354",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"()\" \"aba\" \"&\" out];list $n $out", "4 aba",
    "", false, "replacement-3355",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"()\" \"aba\" \"\\\\0\" out];list $n $out", "1 aba",
    "", false, "replacement-3356",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"()\" \"aba\" \"\\\\0\" out];list $n $out",
    "4 aba", "", false, "replacement-3357",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"()\" \"aba\" \"<\\\\1>\" out];list $n $out",
    "1 <>aba", "", false, "replacement-3358",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"()\" \"aba\" \"<\\\\1>\" out];list $n $out",
    "4 <>a<>b<>a<>", "", false, "replacement-3359",
  )
}

///|
test "Tcl regexp cases 3361 through 3400" {
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"()\" \"aba\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 -aba", "", false, "replacement-3360",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"()\" \"aba\" \"\\\\2-\\\\9\" out];list $n $out",
    "4 -a-b-a-", "", false, "replacement-3361",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"()\" \"aba\" \"\\\\&\" out];list $n $out", "1 &aba",
    "", false, "replacement-3362",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"()\" \"aba\" \"\\\\&\" out];list $n $out",
    "4 &a&b&a&", "", false, "replacement-3363",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"()\" \"aba\" \"\\\\\\\\\" out];list $n $out",
    "1 {\\aba}", "", false, "replacement-3364",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"()\" \"aba\" \"\\\\\\\\\" out];list $n $out",
    "4 \\\\a\\\\b\\\\a\\\\", "", false, "replacement-3365",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"()\" \"aba\" \"\\\\n\" out];list $n $out", "1 {\\naba}",
    "", false, "replacement-3366",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"()\" \"aba\" \"\\\\n\" out];list $n $out",
    "4 {\\na\\nb\\na\\n}", "", false, "replacement-3367",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"()\" \"aba\" \"x\\\\\" out];list $n $out", "1 {x\\aba}",
    "", false, "replacement-3368",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"()\" \"aba\" \"x\\\\\" out];list $n $out",
    "4 x\\\\ax\\\\bx\\\\ax\\\\", "", false, "replacement-3369",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"()\" \"aba\" \"&&\" out];list $n $out", "1 aba",
    "", false, "replacement-3370",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"()\" \"aba\" \"&&\" out];list $n $out",
    "4 aba", "", false, "replacement-3371",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"()\" \"a\\nb\" \"X\" out];list $n $out", "1 {Xa\nb}",
    "", false, "replacement-3372",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"()\" \"a\\nb\" \"X\" out];list $n $out",
    "4 {XaX\nXbX}", "", false, "replacement-3373",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"()\" \"a\\nb\" \"&\" out];list $n $out", "1 {a\nb}",
    "", false, "replacement-3374",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"()\" \"a\\nb\" \"&\" out];list $n $out",
    "4 {a\nb}", "", false, "replacement-3375",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"()\" \"a\\nb\" \"\\\\0\" out];list $n $out",
    "1 {a\nb}", "", false, "replacement-3376",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"()\" \"a\\nb\" \"\\\\0\" out];list $n $out",
    "4 {a\nb}", "", false, "replacement-3377",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"()\" \"a\\nb\" \"<\\\\1>\" out];list $n $out",
    "1 {<>a\nb}", "", false, "replacement-3378",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"()\" \"a\\nb\" \"<\\\\1>\" out];list $n $out",
    "4 {<>a<>\n<>b<>}", "", false, "replacement-3379",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"()\" \"a\\nb\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 {-a\nb}", "", false, "replacement-3380",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"()\" \"a\\nb\" \"\\\\2-\\\\9\" out];list $n $out",
    "4 {-a-\n-b-}", "", false, "replacement-3381",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"()\" \"a\\nb\" \"\\\\&\" out];list $n $out",
    "1 {&a\nb}", "", false, "replacement-3382",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"()\" \"a\\nb\" \"\\\\&\" out];list $n $out",
    "4 {&a&\n&b&}", "", false, "replacement-3383",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"()\" \"a\\nb\" \"\\\\\\\\\" out];list $n $out",
    "1 {\\a\nb}", "", false, "replacement-3384",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"()\" \"a\\nb\" \"\\\\\\\\\" out];list $n $out",
    "4 \\\\a\\\\\\n\\\\b\\\\", "", false, "replacement-3385",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"()\" \"a\\nb\" \"\\\\n\" out];list $n $out",
    "1 {\\na\nb}", "", false, "replacement-3386",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"()\" \"a\\nb\" \"\\\\n\" out];list $n $out",
    "4 {\\na\\n\n\\nb\\n}", "", false, "replacement-3387",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"()\" \"a\\nb\" \"x\\\\\" out];list $n $out",
    "1 {x\\a\nb}", "", false, "replacement-3388",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"()\" \"a\\nb\" \"x\\\\\" out];list $n $out",
    "4 x\\\\ax\\\\\\nx\\\\bx\\\\", "", false, "replacement-3389",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"()\" \"a\\nb\" \"&&\" out];list $n $out", "1 {a\nb}",
    "", false, "replacement-3390",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"()\" \"a\\nb\" \"&&\" out];list $n $out",
    "4 {a\nb}", "", false, "replacement-3391",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a\" \"\" \"X\" out];list $n $out", "0 {}", "",
    false, "replacement-3392",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a\" \"\" \"X\" out];list $n $out", "0 {}",
    "", false, "replacement-3393",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a\" \"\" \"&\" out];list $n $out", "0 {}", "",
    false, "replacement-3394",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a\" \"\" \"&\" out];list $n $out", "0 {}",
    "", false, "replacement-3395",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a\" \"\" \"\\\\0\" out];list $n $out", "0 {}",
    "", false, "replacement-3396",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a\" \"\" \"\\\\0\" out];list $n $out", "0 {}",
    "", false, "replacement-3397",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a\" \"\" \"<\\\\1>\" out];list $n $out", "0 {}",
    "", false, "replacement-3398",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a\" \"\" \"<\\\\1>\" out];list $n $out",
    "0 {}", "", false, "replacement-3399",
  )
}

///|
test "Tcl regexp cases 3401 through 3440" {
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a\" \"\" \"\\\\2-\\\\9\" out];list $n $out",
    "0 {}", "", false, "replacement-3400",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a\" \"\" \"\\\\2-\\\\9\" out];list $n $out",
    "0 {}", "", false, "replacement-3401",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a\" \"\" \"\\\\&\" out];list $n $out", "0 {}",
    "", false, "replacement-3402",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a\" \"\" \"\\\\&\" out];list $n $out", "0 {}",
    "", false, "replacement-3403",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a\" \"\" \"\\\\\\\\\" out];list $n $out", "0 {}",
    "", false, "replacement-3404",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a\" \"\" \"\\\\\\\\\" out];list $n $out",
    "0 {}", "", false, "replacement-3405",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a\" \"\" \"\\\\n\" out];list $n $out", "0 {}",
    "", false, "replacement-3406",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a\" \"\" \"\\\\n\" out];list $n $out", "0 {}",
    "", false, "replacement-3407",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a\" \"\" \"x\\\\\" out];list $n $out", "0 {}",
    "", false, "replacement-3408",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a\" \"\" \"x\\\\\" out];list $n $out", "0 {}",
    "", false, "replacement-3409",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a\" \"\" \"&&\" out];list $n $out", "0 {}",
    "", false, "replacement-3410",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a\" \"\" \"&&\" out];list $n $out", "0 {}",
    "", false, "replacement-3411",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a\" \"abc\" \"X\" out];list $n $out", "1 Xbc",
    "", false, "replacement-3412",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a\" \"abc\" \"X\" out];list $n $out", "1 Xbc",
    "", false, "replacement-3413",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a\" \"abc\" \"&\" out];list $n $out", "1 abc",
    "", false, "replacement-3414",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a\" \"abc\" \"&\" out];list $n $out", "1 abc",
    "", false, "replacement-3415",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a\" \"abc\" \"\\\\0\" out];list $n $out", "1 abc",
    "", false, "replacement-3416",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a\" \"abc\" \"\\\\0\" out];list $n $out",
    "1 abc", "", false, "replacement-3417",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a\" \"abc\" \"<\\\\1>\" out];list $n $out",
    "1 <>bc", "", false, "replacement-3418",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a\" \"abc\" \"<\\\\1>\" out];list $n $out",
    "1 <>bc", "", false, "replacement-3419",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a\" \"abc\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 -bc", "", false, "replacement-3420",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a\" \"abc\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 -bc", "", false, "replacement-3421",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a\" \"abc\" \"\\\\&\" out];list $n $out", "1 &bc",
    "", false, "replacement-3422",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a\" \"abc\" \"\\\\&\" out];list $n $out",
    "1 &bc", "", false, "replacement-3423",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a\" \"abc\" \"\\\\\\\\\" out];list $n $out",
    "1 {\\bc}", "", false, "replacement-3424",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a\" \"abc\" \"\\\\\\\\\" out];list $n $out",
    "1 {\\bc}", "", false, "replacement-3425",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a\" \"abc\" \"\\\\n\" out];list $n $out", "1 {\\nbc}",
    "", false, "replacement-3426",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a\" \"abc\" \"\\\\n\" out];list $n $out",
    "1 {\\nbc}", "", false, "replacement-3427",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a\" \"abc\" \"x\\\\\" out];list $n $out", "1 {x\\bc}",
    "", false, "replacement-3428",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a\" \"abc\" \"x\\\\\" out];list $n $out",
    "1 {x\\bc}", "", false, "replacement-3429",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a\" \"abc\" \"&&\" out];list $n $out", "1 aabc",
    "", false, "replacement-3430",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a\" \"abc\" \"&&\" out];list $n $out", "1 aabc",
    "", false, "replacement-3431",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a\" \"aba\" \"X\" out];list $n $out", "1 Xba",
    "", false, "replacement-3432",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a\" \"aba\" \"X\" out];list $n $out", "2 XbX",
    "", false, "replacement-3433",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a\" \"aba\" \"&\" out];list $n $out", "1 aba",
    "", false, "replacement-3434",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a\" \"aba\" \"&\" out];list $n $out", "2 aba",
    "", false, "replacement-3435",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a\" \"aba\" \"\\\\0\" out];list $n $out", "1 aba",
    "", false, "replacement-3436",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a\" \"aba\" \"\\\\0\" out];list $n $out",
    "2 aba", "", false, "replacement-3437",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a\" \"aba\" \"<\\\\1>\" out];list $n $out",
    "1 <>ba", "", false, "replacement-3438",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a\" \"aba\" \"<\\\\1>\" out];list $n $out",
    "2 <>b<>", "", false, "replacement-3439",
  )
}

///|
test "Tcl regexp cases 3441 through 3480" {
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a\" \"aba\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 -ba", "", false, "replacement-3440",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a\" \"aba\" \"\\\\2-\\\\9\" out];list $n $out",
    "2 -b-", "", false, "replacement-3441",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a\" \"aba\" \"\\\\&\" out];list $n $out", "1 &ba",
    "", false, "replacement-3442",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a\" \"aba\" \"\\\\&\" out];list $n $out",
    "2 &b&", "", false, "replacement-3443",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a\" \"aba\" \"\\\\\\\\\" out];list $n $out",
    "1 {\\ba}", "", false, "replacement-3444",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a\" \"aba\" \"\\\\\\\\\" out];list $n $out",
    "2 \\\\b\\\\", "", false, "replacement-3445",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a\" \"aba\" \"\\\\n\" out];list $n $out", "1 {\\nba}",
    "", false, "replacement-3446",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a\" \"aba\" \"\\\\n\" out];list $n $out",
    "2 {\\nb\\n}", "", false, "replacement-3447",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a\" \"aba\" \"x\\\\\" out];list $n $out", "1 {x\\ba}",
    "", false, "replacement-3448",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a\" \"aba\" \"x\\\\\" out];list $n $out",
    "2 x\\\\bx\\\\", "", false, "replacement-3449",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a\" \"aba\" \"&&\" out];list $n $out", "1 aaba",
    "", false, "replacement-3450",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a\" \"aba\" \"&&\" out];list $n $out", "2 aabaa",
    "", false, "replacement-3451",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a\" \"a\\nb\" \"X\" out];list $n $out", "1 {X\nb}",
    "", false, "replacement-3452",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a\" \"a\\nb\" \"X\" out];list $n $out",
    "1 {X\nb}", "", false, "replacement-3453",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a\" \"a\\nb\" \"&\" out];list $n $out", "1 {a\nb}",
    "", false, "replacement-3454",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a\" \"a\\nb\" \"&\" out];list $n $out",
    "1 {a\nb}", "", false, "replacement-3455",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a\" \"a\\nb\" \"\\\\0\" out];list $n $out",
    "1 {a\nb}", "", false, "replacement-3456",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a\" \"a\\nb\" \"\\\\0\" out];list $n $out",
    "1 {a\nb}", "", false, "replacement-3457",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a\" \"a\\nb\" \"<\\\\1>\" out];list $n $out",
    "1 {<>\nb}", "", false, "replacement-3458",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a\" \"a\\nb\" \"<\\\\1>\" out];list $n $out",
    "1 {<>\nb}", "", false, "replacement-3459",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a\" \"a\\nb\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 {-\nb}", "", false, "replacement-3460",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a\" \"a\\nb\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 {-\nb}", "", false, "replacement-3461",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a\" \"a\\nb\" \"\\\\&\" out];list $n $out",
    "1 {&\nb}", "", false, "replacement-3462",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a\" \"a\\nb\" \"\\\\&\" out];list $n $out",
    "1 {&\nb}", "", false, "replacement-3463",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a\" \"a\\nb\" \"\\\\\\\\\" out];list $n $out",
    "1 \\\\\\nb", "", false, "replacement-3464",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a\" \"a\\nb\" \"\\\\\\\\\" out];list $n $out",
    "1 \\\\\\nb", "", false, "replacement-3465",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a\" \"a\\nb\" \"\\\\n\" out];list $n $out",
    "1 {\\n\nb}", "", false, "replacement-3466",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a\" \"a\\nb\" \"\\\\n\" out];list $n $out",
    "1 {\\n\nb}", "", false, "replacement-3467",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a\" \"a\\nb\" \"x\\\\\" out];list $n $out",
    "1 x\\\\\\nb", "", false, "replacement-3468",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a\" \"a\\nb\" \"x\\\\\" out];list $n $out",
    "1 x\\\\\\nb", "", false, "replacement-3469",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a\" \"a\\nb\" \"&&\" out];list $n $out", "1 {aa\nb}",
    "", false, "replacement-3470",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a\" \"a\\nb\" \"&&\" out];list $n $out",
    "1 {aa\nb}", "", false, "replacement-3471",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"(a)(b?)\" \"\" \"X\" out];list $n $out", "0 {}",
    "", false, "replacement-3472",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"(a)(b?)\" \"\" \"X\" out];list $n $out",
    "0 {}", "", false, "replacement-3473",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"(a)(b?)\" \"\" \"&\" out];list $n $out", "0 {}",
    "", false, "replacement-3474",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"(a)(b?)\" \"\" \"&\" out];list $n $out",
    "0 {}", "", false, "replacement-3475",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"(a)(b?)\" \"\" \"\\\\0\" out];list $n $out",
    "0 {}", "", false, "replacement-3476",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"(a)(b?)\" \"\" \"\\\\0\" out];list $n $out",
    "0 {}", "", false, "replacement-3477",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"(a)(b?)\" \"\" \"<\\\\1>\" out];list $n $out",
    "0 {}", "", false, "replacement-3478",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"(a)(b?)\" \"\" \"<\\\\1>\" out];list $n $out",
    "0 {}", "", false, "replacement-3479",
  )
}

///|
test "Tcl regexp cases 3481 through 3520" {
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"(a)(b?)\" \"\" \"\\\\2-\\\\9\" out];list $n $out",
    "0 {}", "", false, "replacement-3480",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"(a)(b?)\" \"\" \"\\\\2-\\\\9\" out];list $n $out",
    "0 {}", "", false, "replacement-3481",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"(a)(b?)\" \"\" \"\\\\&\" out];list $n $out",
    "0 {}", "", false, "replacement-3482",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"(a)(b?)\" \"\" \"\\\\&\" out];list $n $out",
    "0 {}", "", false, "replacement-3483",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"(a)(b?)\" \"\" \"\\\\\\\\\" out];list $n $out",
    "0 {}", "", false, "replacement-3484",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"(a)(b?)\" \"\" \"\\\\\\\\\" out];list $n $out",
    "0 {}", "", false, "replacement-3485",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"(a)(b?)\" \"\" \"\\\\n\" out];list $n $out",
    "0 {}", "", false, "replacement-3486",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"(a)(b?)\" \"\" \"\\\\n\" out];list $n $out",
    "0 {}", "", false, "replacement-3487",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"(a)(b?)\" \"\" \"x\\\\\" out];list $n $out",
    "0 {}", "", false, "replacement-3488",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"(a)(b?)\" \"\" \"x\\\\\" out];list $n $out",
    "0 {}", "", false, "replacement-3489",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"(a)(b?)\" \"\" \"&&\" out];list $n $out", "0 {}",
    "", false, "replacement-3490",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"(a)(b?)\" \"\" \"&&\" out];list $n $out",
    "0 {}", "", false, "replacement-3491",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"(a)(b?)\" \"abc\" \"X\" out];list $n $out",
    "1 Xc", "", false, "replacement-3492",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"(a)(b?)\" \"abc\" \"X\" out];list $n $out",
    "1 Xc", "", false, "replacement-3493",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"(a)(b?)\" \"abc\" \"&\" out];list $n $out",
    "1 abc", "", false, "replacement-3494",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"(a)(b?)\" \"abc\" \"&\" out];list $n $out",
    "1 abc", "", false, "replacement-3495",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"(a)(b?)\" \"abc\" \"\\\\0\" out];list $n $out",
    "1 abc", "", false, "replacement-3496",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"(a)(b?)\" \"abc\" \"\\\\0\" out];list $n $out",
    "1 abc", "", false, "replacement-3497",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"(a)(b?)\" \"abc\" \"<\\\\1>\" out];list $n $out",
    "1 <a>c", "", false, "replacement-3498",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"(a)(b?)\" \"abc\" \"<\\\\1>\" out];list $n $out",
    "1 <a>c", "", false, "replacement-3499",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"(a)(b?)\" \"abc\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 b-c", "", false, "replacement-3500",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"(a)(b?)\" \"abc\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 b-c", "", false, "replacement-3501",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"(a)(b?)\" \"abc\" \"\\\\&\" out];list $n $out",
    "1 &c", "", false, "replacement-3502",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"(a)(b?)\" \"abc\" \"\\\\&\" out];list $n $out",
    "1 &c", "", false, "replacement-3503",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"(a)(b?)\" \"abc\" \"\\\\\\\\\" out];list $n $out",
    "1 {\\c}", "", false, "replacement-3504",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"(a)(b?)\" \"abc\" \"\\\\\\\\\" out];list $n $out",
    "1 {\\c}", "", false, "replacement-3505",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"(a)(b?)\" \"abc\" \"\\\\n\" out];list $n $out",
    "1 {\\nc}", "", false, "replacement-3506",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"(a)(b?)\" \"abc\" \"\\\\n\" out];list $n $out",
    "1 {\\nc}", "", false, "replacement-3507",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"(a)(b?)\" \"abc\" \"x\\\\\" out];list $n $out",
    "1 {x\\c}", "", false, "replacement-3508",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"(a)(b?)\" \"abc\" \"x\\\\\" out];list $n $out",
    "1 {x\\c}", "", false, "replacement-3509",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"(a)(b?)\" \"abc\" \"&&\" out];list $n $out",
    "1 ababc", "", false, "replacement-3510",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"(a)(b?)\" \"abc\" \"&&\" out];list $n $out",
    "1 ababc", "", false, "replacement-3511",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"(a)(b?)\" \"aba\" \"X\" out];list $n $out",
    "1 Xa", "", false, "replacement-3512",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"(a)(b?)\" \"aba\" \"X\" out];list $n $out",
    "2 XX", "", false, "replacement-3513",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"(a)(b?)\" \"aba\" \"&\" out];list $n $out",
    "1 aba", "", false, "replacement-3514",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"(a)(b?)\" \"aba\" \"&\" out];list $n $out",
    "2 aba", "", false, "replacement-3515",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"(a)(b?)\" \"aba\" \"\\\\0\" out];list $n $out",
    "1 aba", "", false, "replacement-3516",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"(a)(b?)\" \"aba\" \"\\\\0\" out];list $n $out",
    "2 aba", "", false, "replacement-3517",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"(a)(b?)\" \"aba\" \"<\\\\1>\" out];list $n $out",
    "1 <a>a", "", false, "replacement-3518",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"(a)(b?)\" \"aba\" \"<\\\\1>\" out];list $n $out",
    "2 <a><a>", "", false, "replacement-3519",
  )
}

///|
test "Tcl regexp cases 3521 through 3560" {
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"(a)(b?)\" \"aba\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 b-a", "", false, "replacement-3520",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"(a)(b?)\" \"aba\" \"\\\\2-\\\\9\" out];list $n $out",
    "2 b--", "", false, "replacement-3521",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"(a)(b?)\" \"aba\" \"\\\\&\" out];list $n $out",
    "1 &a", "", false, "replacement-3522",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"(a)(b?)\" \"aba\" \"\\\\&\" out];list $n $out",
    "2 &&", "", false, "replacement-3523",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"(a)(b?)\" \"aba\" \"\\\\\\\\\" out];list $n $out",
    "1 {\\a}", "", false, "replacement-3524",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"(a)(b?)\" \"aba\" \"\\\\\\\\\" out];list $n $out",
    "2 {\\\\}", "", false, "replacement-3525",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"(a)(b?)\" \"aba\" \"\\\\n\" out];list $n $out",
    "1 {\\na}", "", false, "replacement-3526",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"(a)(b?)\" \"aba\" \"\\\\n\" out];list $n $out",
    "2 {\\n\\n}", "", false, "replacement-3527",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"(a)(b?)\" \"aba\" \"x\\\\\" out];list $n $out",
    "1 {x\\a}", "", false, "replacement-3528",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"(a)(b?)\" \"aba\" \"x\\\\\" out];list $n $out",
    "2 x\\\\x\\\\", "", false, "replacement-3529",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"(a)(b?)\" \"aba\" \"&&\" out];list $n $out",
    "1 ababa", "", false, "replacement-3530",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"(a)(b?)\" \"aba\" \"&&\" out];list $n $out",
    "2 ababaa", "", false, "replacement-3531",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"(a)(b?)\" \"a\\nb\" \"X\" out];list $n $out",
    "1 {X\nb}", "", false, "replacement-3532",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"(a)(b?)\" \"a\\nb\" \"X\" out];list $n $out",
    "1 {X\nb}", "", false, "replacement-3533",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"(a)(b?)\" \"a\\nb\" \"&\" out];list $n $out",
    "1 {a\nb}", "", false, "replacement-3534",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"(a)(b?)\" \"a\\nb\" \"&\" out];list $n $out",
    "1 {a\nb}", "", false, "replacement-3535",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"(a)(b?)\" \"a\\nb\" \"\\\\0\" out];list $n $out",
    "1 {a\nb}", "", false, "replacement-3536",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"(a)(b?)\" \"a\\nb\" \"\\\\0\" out];list $n $out",
    "1 {a\nb}", "", false, "replacement-3537",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"(a)(b?)\" \"a\\nb\" \"<\\\\1>\" out];list $n $out",
    "1 {<a>\nb}", "", false, "replacement-3538",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"(a)(b?)\" \"a\\nb\" \"<\\\\1>\" out];list $n $out",
    "1 {<a>\nb}", "", false, "replacement-3539",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"(a)(b?)\" \"a\\nb\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 {-\nb}", "", false, "replacement-3540",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"(a)(b?)\" \"a\\nb\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 {-\nb}", "", false, "replacement-3541",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"(a)(b?)\" \"a\\nb\" \"\\\\&\" out];list $n $out",
    "1 {&\nb}", "", false, "replacement-3542",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"(a)(b?)\" \"a\\nb\" \"\\\\&\" out];list $n $out",
    "1 {&\nb}", "", false, "replacement-3543",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"(a)(b?)\" \"a\\nb\" \"\\\\\\\\\" out];list $n $out",
    "1 \\\\\\nb", "", false, "replacement-3544",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"(a)(b?)\" \"a\\nb\" \"\\\\\\\\\" out];list $n $out",
    "1 \\\\\\nb", "", false, "replacement-3545",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"(a)(b?)\" \"a\\nb\" \"\\\\n\" out];list $n $out",
    "1 {\\n\nb}", "", false, "replacement-3546",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"(a)(b?)\" \"a\\nb\" \"\\\\n\" out];list $n $out",
    "1 {\\n\nb}", "", false, "replacement-3547",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"(a)(b?)\" \"a\\nb\" \"x\\\\\" out];list $n $out",
    "1 x\\\\\\nb", "", false, "replacement-3548",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"(a)(b?)\" \"a\\nb\" \"x\\\\\" out];list $n $out",
    "1 x\\\\\\nb", "", false, "replacement-3549",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"(a)(b?)\" \"a\\nb\" \"&&\" out];list $n $out",
    "1 {aa\nb}", "", false, "replacement-3550",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"(a)(b?)\" \"a\\nb\" \"&&\" out];list $n $out",
    "1 {aa\nb}", "", false, "replacement-3551",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*\" \"\" \"X\" out];list $n $out", "1 X", "",
    false, "replacement-3552",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*\" \"\" \"X\" out];list $n $out", "1 X",
    "", false, "replacement-3553",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*\" \"\" \"&\" out];list $n $out", "1 {}",
    "", false, "replacement-3554",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*\" \"\" \"&\" out];list $n $out", "1 {}",
    "", false, "replacement-3555",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*\" \"\" \"\\\\0\" out];list $n $out", "1 {}",
    "", false, "replacement-3556",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*\" \"\" \"\\\\0\" out];list $n $out",
    "1 {}", "", false, "replacement-3557",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*\" \"\" \"<\\\\1>\" out];list $n $out", "1 <>",
    "", false, "replacement-3558",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*\" \"\" \"<\\\\1>\" out];list $n $out",
    "1 <>", "", false, "replacement-3559",
  )
}

///|
test "Tcl regexp cases 3561 through 3600" {
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*\" \"\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 -", "", false, "replacement-3560",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*\" \"\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 -", "", false, "replacement-3561",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*\" \"\" \"\\\\&\" out];list $n $out", "1 &",
    "", false, "replacement-3562",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*\" \"\" \"\\\\&\" out];list $n $out",
    "1 &", "", false, "replacement-3563",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*\" \"\" \"\\\\\\\\\" out];list $n $out", "1 \\\\",
    "", false, "replacement-3564",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*\" \"\" \"\\\\\\\\\" out];list $n $out",
    "1 \\\\", "", false, "replacement-3565",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*\" \"\" \"\\\\n\" out];list $n $out", "1 {\\n}",
    "", false, "replacement-3566",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*\" \"\" \"\\\\n\" out];list $n $out",
    "1 {\\n}", "", false, "replacement-3567",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*\" \"\" \"x\\\\\" out];list $n $out", "1 x\\\\",
    "", false, "replacement-3568",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*\" \"\" \"x\\\\\" out];list $n $out",
    "1 x\\\\", "", false, "replacement-3569",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*\" \"\" \"&&\" out];list $n $out", "1 {}",
    "", false, "replacement-3570",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*\" \"\" \"&&\" out];list $n $out", "1 {}",
    "", false, "replacement-3571",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*\" \"abc\" \"X\" out];list $n $out", "1 Xbc",
    "", false, "replacement-3572",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*\" \"abc\" \"X\" out];list $n $out", "4 XXbXcX",
    "", false, "replacement-3573",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*\" \"abc\" \"&\" out];list $n $out", "1 abc",
    "", false, "replacement-3574",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*\" \"abc\" \"&\" out];list $n $out", "4 abc",
    "", false, "replacement-3575",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*\" \"abc\" \"\\\\0\" out];list $n $out", "1 abc",
    "", false, "replacement-3576",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*\" \"abc\" \"\\\\0\" out];list $n $out",
    "4 abc", "", false, "replacement-3577",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*\" \"abc\" \"<\\\\1>\" out];list $n $out",
    "1 <>bc", "", false, "replacement-3578",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*\" \"abc\" \"<\\\\1>\" out];list $n $out",
    "4 <><>b<>c<>", "", false, "replacement-3579",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*\" \"abc\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 -bc", "", false, "replacement-3580",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*\" \"abc\" \"\\\\2-\\\\9\" out];list $n $out",
    "4 --b-c-", "", false, "replacement-3581",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*\" \"abc\" \"\\\\&\" out];list $n $out", "1 &bc",
    "", false, "replacement-3582",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*\" \"abc\" \"\\\\&\" out];list $n $out",
    "4 &&b&c&", "", false, "replacement-3583",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*\" \"abc\" \"\\\\\\\\\" out];list $n $out",
    "1 {\\bc}", "", false, "replacement-3584",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*\" \"abc\" \"\\\\\\\\\" out];list $n $out",
    "4 \\\\\\\\b\\\\c\\\\", "", false, "replacement-3585",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*\" \"abc\" \"\\\\n\" out];list $n $out", "1 {\\nbc}",
    "", false, "replacement-3586",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*\" \"abc\" \"\\\\n\" out];list $n $out",
    "4 {\\n\\nb\\nc\\n}", "", false, "replacement-3587",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*\" \"abc\" \"x\\\\\" out];list $n $out", "1 {x\\bc}",
    "", false, "replacement-3588",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*\" \"abc\" \"x\\\\\" out];list $n $out",
    "4 x\\\\x\\\\bx\\\\cx\\\\", "", false, "replacement-3589",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*\" \"abc\" \"&&\" out];list $n $out", "1 aabc",
    "", false, "replacement-3590",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*\" \"abc\" \"&&\" out];list $n $out",
    "4 aabc", "", false, "replacement-3591",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*\" \"aba\" \"X\" out];list $n $out", "1 Xba",
    "", false, "replacement-3592",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*\" \"aba\" \"X\" out];list $n $out", "4 XXbXX",
    "", false, "replacement-3593",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*\" \"aba\" \"&\" out];list $n $out", "1 aba",
    "", false, "replacement-3594",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*\" \"aba\" \"&\" out];list $n $out", "4 aba",
    "", false, "replacement-3595",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*\" \"aba\" \"\\\\0\" out];list $n $out", "1 aba",
    "", false, "replacement-3596",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*\" \"aba\" \"\\\\0\" out];list $n $out",
    "4 aba", "", false, "replacement-3597",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*\" \"aba\" \"<\\\\1>\" out];list $n $out",
    "1 <>ba", "", false, "replacement-3598",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*\" \"aba\" \"<\\\\1>\" out];list $n $out",
    "4 <><>b<><>", "", false, "replacement-3599",
  )
}

///|
test "Tcl regexp cases 3601 through 3640" {
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*\" \"aba\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 -ba", "", false, "replacement-3600",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*\" \"aba\" \"\\\\2-\\\\9\" out];list $n $out",
    "4 --b--", "", false, "replacement-3601",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*\" \"aba\" \"\\\\&\" out];list $n $out", "1 &ba",
    "", false, "replacement-3602",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*\" \"aba\" \"\\\\&\" out];list $n $out",
    "4 &&b&&", "", false, "replacement-3603",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*\" \"aba\" \"\\\\\\\\\" out];list $n $out",
    "1 {\\ba}", "", false, "replacement-3604",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*\" \"aba\" \"\\\\\\\\\" out];list $n $out",
    "4 {\\\\b\\\\}", "", false, "replacement-3605",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*\" \"aba\" \"\\\\n\" out];list $n $out", "1 {\\nba}",
    "", false, "replacement-3606",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*\" \"aba\" \"\\\\n\" out];list $n $out",
    "4 {\\n\\nb\\n\\n}", "", false, "replacement-3607",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*\" \"aba\" \"x\\\\\" out];list $n $out", "1 {x\\ba}",
    "", false, "replacement-3608",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*\" \"aba\" \"x\\\\\" out];list $n $out",
    "4 x\\\\x\\\\bx\\\\x\\\\", "", false, "replacement-3609",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*\" \"aba\" \"&&\" out];list $n $out", "1 aaba",
    "", false, "replacement-3610",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*\" \"aba\" \"&&\" out];list $n $out",
    "4 aabaa", "", false, "replacement-3611",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*\" \"a\\nb\" \"X\" out];list $n $out", "1 {X\nb}",
    "", false, "replacement-3612",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*\" \"a\\nb\" \"X\" out];list $n $out",
    "4 {XX\nXbX}", "", false, "replacement-3613",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*\" \"a\\nb\" \"&\" out];list $n $out", "1 {a\nb}",
    "", false, "replacement-3614",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*\" \"a\\nb\" \"&\" out];list $n $out",
    "4 {a\nb}", "", false, "replacement-3615",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*\" \"a\\nb\" \"\\\\0\" out];list $n $out",
    "1 {a\nb}", "", false, "replacement-3616",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*\" \"a\\nb\" \"\\\\0\" out];list $n $out",
    "4 {a\nb}", "", false, "replacement-3617",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*\" \"a\\nb\" \"<\\\\1>\" out];list $n $out",
    "1 {<>\nb}", "", false, "replacement-3618",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*\" \"a\\nb\" \"<\\\\1>\" out];list $n $out",
    "4 {<><>\n<>b<>}", "", false, "replacement-3619",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*\" \"a\\nb\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 {-\nb}", "", false, "replacement-3620",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*\" \"a\\nb\" \"\\\\2-\\\\9\" out];list $n $out",
    "4 {--\n-b-}", "", false, "replacement-3621",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*\" \"a\\nb\" \"\\\\&\" out];list $n $out",
    "1 {&\nb}", "", false, "replacement-3622",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*\" \"a\\nb\" \"\\\\&\" out];list $n $out",
    "4 {&&\n&b&}", "", false, "replacement-3623",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*\" \"a\\nb\" \"\\\\\\\\\" out];list $n $out",
    "1 \\\\\\nb", "", false, "replacement-3624",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*\" \"a\\nb\" \"\\\\\\\\\" out];list $n $out",
    "4 \\\\\\\\\\n\\\\b\\\\", "", false, "replacement-3625",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*\" \"a\\nb\" \"\\\\n\" out];list $n $out",
    "1 {\\n\nb}", "", false, "replacement-3626",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*\" \"a\\nb\" \"\\\\n\" out];list $n $out",
    "4 {\\n\\n\n\\nb\\n}", "", false, "replacement-3627",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*\" \"a\\nb\" \"x\\\\\" out];list $n $out",
    "1 x\\\\\\nb", "", false, "replacement-3628",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*\" \"a\\nb\" \"x\\\\\" out];list $n $out",
    "4 x\\\\x\\\\\\nx\\\\bx\\\\", "", false, "replacement-3629",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*\" \"a\\nb\" \"&&\" out];list $n $out", "1 {aa\nb}",
    "", false, "replacement-3630",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*\" \"a\\nb\" \"&&\" out];list $n $out",
    "4 {aa\nb}", "", false, "replacement-3631",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*?\" \"\" \"X\" out];list $n $out", "1 X",
    "", false, "replacement-3632",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*?\" \"\" \"X\" out];list $n $out", "1 X",
    "", false, "replacement-3633",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*?\" \"\" \"&\" out];list $n $out", "1 {}",
    "", false, "replacement-3634",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*?\" \"\" \"&\" out];list $n $out", "1 {}",
    "", false, "replacement-3635",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*?\" \"\" \"\\\\0\" out];list $n $out", "1 {}",
    "", false, "replacement-3636",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*?\" \"\" \"\\\\0\" out];list $n $out",
    "1 {}", "", false, "replacement-3637",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*?\" \"\" \"<\\\\1>\" out];list $n $out", "1 <>",
    "", false, "replacement-3638",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*?\" \"\" \"<\\\\1>\" out];list $n $out",
    "1 <>", "", false, "replacement-3639",
  )
}

///|
test "Tcl regexp cases 3641 through 3680" {
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*?\" \"\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 -", "", false, "replacement-3640",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*?\" \"\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 -", "", false, "replacement-3641",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*?\" \"\" \"\\\\&\" out];list $n $out", "1 &",
    "", false, "replacement-3642",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*?\" \"\" \"\\\\&\" out];list $n $out",
    "1 &", "", false, "replacement-3643",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*?\" \"\" \"\\\\\\\\\" out];list $n $out",
    "1 \\\\", "", false, "replacement-3644",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*?\" \"\" \"\\\\\\\\\" out];list $n $out",
    "1 \\\\", "", false, "replacement-3645",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*?\" \"\" \"\\\\n\" out];list $n $out", "1 {\\n}",
    "", false, "replacement-3646",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*?\" \"\" \"\\\\n\" out];list $n $out",
    "1 {\\n}", "", false, "replacement-3647",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*?\" \"\" \"x\\\\\" out];list $n $out", "1 x\\\\",
    "", false, "replacement-3648",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*?\" \"\" \"x\\\\\" out];list $n $out",
    "1 x\\\\", "", false, "replacement-3649",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*?\" \"\" \"&&\" out];list $n $out", "1 {}",
    "", false, "replacement-3650",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*?\" \"\" \"&&\" out];list $n $out", "1 {}",
    "", false, "replacement-3651",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*?\" \"abc\" \"X\" out];list $n $out", "1 Xabc",
    "", false, "replacement-3652",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*?\" \"abc\" \"X\" out];list $n $out",
    "4 XaXbXcX", "", false, "replacement-3653",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*?\" \"abc\" \"&\" out];list $n $out", "1 abc",
    "", false, "replacement-3654",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*?\" \"abc\" \"&\" out];list $n $out",
    "4 abc", "", false, "replacement-3655",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*?\" \"abc\" \"\\\\0\" out];list $n $out",
    "1 abc", "", false, "replacement-3656",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*?\" \"abc\" \"\\\\0\" out];list $n $out",
    "4 abc", "", false, "replacement-3657",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*?\" \"abc\" \"<\\\\1>\" out];list $n $out",
    "1 <>abc", "", false, "replacement-3658",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*?\" \"abc\" \"<\\\\1>\" out];list $n $out",
    "4 <>a<>b<>c<>", "", false, "replacement-3659",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*?\" \"abc\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 -abc", "", false, "replacement-3660",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*?\" \"abc\" \"\\\\2-\\\\9\" out];list $n $out",
    "4 -a-b-c-", "", false, "replacement-3661",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*?\" \"abc\" \"\\\\&\" out];list $n $out",
    "1 &abc", "", false, "replacement-3662",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*?\" \"abc\" \"\\\\&\" out];list $n $out",
    "4 &a&b&c&", "", false, "replacement-3663",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*?\" \"abc\" \"\\\\\\\\\" out];list $n $out",
    "1 {\\abc}", "", false, "replacement-3664",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*?\" \"abc\" \"\\\\\\\\\" out];list $n $out",
    "4 \\\\a\\\\b\\\\c\\\\", "", false, "replacement-3665",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*?\" \"abc\" \"\\\\n\" out];list $n $out",
    "1 {\\nabc}", "", false, "replacement-3666",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*?\" \"abc\" \"\\\\n\" out];list $n $out",
    "4 {\\na\\nb\\nc\\n}", "", false, "replacement-3667",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*?\" \"abc\" \"x\\\\\" out];list $n $out",
    "1 {x\\abc}", "", false, "replacement-3668",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*?\" \"abc\" \"x\\\\\" out];list $n $out",
    "4 x\\\\ax\\\\bx\\\\cx\\\\", "", false, "replacement-3669",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*?\" \"abc\" \"&&\" out];list $n $out", "1 abc",
    "", false, "replacement-3670",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*?\" \"abc\" \"&&\" out];list $n $out",
    "4 abc", "", false, "replacement-3671",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*?\" \"aba\" \"X\" out];list $n $out", "1 Xaba",
    "", false, "replacement-3672",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*?\" \"aba\" \"X\" out];list $n $out",
    "4 XaXbXaX", "", false, "replacement-3673",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*?\" \"aba\" \"&\" out];list $n $out", "1 aba",
    "", false, "replacement-3674",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*?\" \"aba\" \"&\" out];list $n $out",
    "4 aba", "", false, "replacement-3675",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*?\" \"aba\" \"\\\\0\" out];list $n $out",
    "1 aba", "", false, "replacement-3676",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*?\" \"aba\" \"\\\\0\" out];list $n $out",
    "4 aba", "", false, "replacement-3677",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*?\" \"aba\" \"<\\\\1>\" out];list $n $out",
    "1 <>aba", "", false, "replacement-3678",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*?\" \"aba\" \"<\\\\1>\" out];list $n $out",
    "4 <>a<>b<>a<>", "", false, "replacement-3679",
  )
}

///|
test "Tcl regexp cases 3681 through 3720" {
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*?\" \"aba\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 -aba", "", false, "replacement-3680",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*?\" \"aba\" \"\\\\2-\\\\9\" out];list $n $out",
    "4 -a-b-a-", "", false, "replacement-3681",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*?\" \"aba\" \"\\\\&\" out];list $n $out",
    "1 &aba", "", false, "replacement-3682",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*?\" \"aba\" \"\\\\&\" out];list $n $out",
    "4 &a&b&a&", "", false, "replacement-3683",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*?\" \"aba\" \"\\\\\\\\\" out];list $n $out",
    "1 {\\aba}", "", false, "replacement-3684",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*?\" \"aba\" \"\\\\\\\\\" out];list $n $out",
    "4 \\\\a\\\\b\\\\a\\\\", "", false, "replacement-3685",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*?\" \"aba\" \"\\\\n\" out];list $n $out",
    "1 {\\naba}", "", false, "replacement-3686",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*?\" \"aba\" \"\\\\n\" out];list $n $out",
    "4 {\\na\\nb\\na\\n}", "", false, "replacement-3687",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*?\" \"aba\" \"x\\\\\" out];list $n $out",
    "1 {x\\aba}", "", false, "replacement-3688",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*?\" \"aba\" \"x\\\\\" out];list $n $out",
    "4 x\\\\ax\\\\bx\\\\ax\\\\", "", false, "replacement-3689",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*?\" \"aba\" \"&&\" out];list $n $out", "1 aba",
    "", false, "replacement-3690",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*?\" \"aba\" \"&&\" out];list $n $out",
    "4 aba", "", false, "replacement-3691",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*?\" \"a\\nb\" \"X\" out];list $n $out", "1 {Xa\nb}",
    "", false, "replacement-3692",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*?\" \"a\\nb\" \"X\" out];list $n $out",
    "4 {XaX\nXbX}", "", false, "replacement-3693",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*?\" \"a\\nb\" \"&\" out];list $n $out", "1 {a\nb}",
    "", false, "replacement-3694",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*?\" \"a\\nb\" \"&\" out];list $n $out",
    "4 {a\nb}", "", false, "replacement-3695",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*?\" \"a\\nb\" \"\\\\0\" out];list $n $out",
    "1 {a\nb}", "", false, "replacement-3696",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*?\" \"a\\nb\" \"\\\\0\" out];list $n $out",
    "4 {a\nb}", "", false, "replacement-3697",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*?\" \"a\\nb\" \"<\\\\1>\" out];list $n $out",
    "1 {<>a\nb}", "", false, "replacement-3698",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*?\" \"a\\nb\" \"<\\\\1>\" out];list $n $out",
    "4 {<>a<>\n<>b<>}", "", false, "replacement-3699",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*?\" \"a\\nb\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 {-a\nb}", "", false, "replacement-3700",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*?\" \"a\\nb\" \"\\\\2-\\\\9\" out];list $n $out",
    "4 {-a-\n-b-}", "", false, "replacement-3701",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*?\" \"a\\nb\" \"\\\\&\" out];list $n $out",
    "1 {&a\nb}", "", false, "replacement-3702",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*?\" \"a\\nb\" \"\\\\&\" out];list $n $out",
    "4 {&a&\n&b&}", "", false, "replacement-3703",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*?\" \"a\\nb\" \"\\\\\\\\\" out];list $n $out",
    "1 {\\a\nb}", "", false, "replacement-3704",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*?\" \"a\\nb\" \"\\\\\\\\\" out];list $n $out",
    "4 \\\\a\\\\\\n\\\\b\\\\", "", false, "replacement-3705",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*?\" \"a\\nb\" \"\\\\n\" out];list $n $out",
    "1 {\\na\nb}", "", false, "replacement-3706",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*?\" \"a\\nb\" \"\\\\n\" out];list $n $out",
    "4 {\\na\\n\n\\nb\\n}", "", false, "replacement-3707",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*?\" \"a\\nb\" \"x\\\\\" out];list $n $out",
    "1 {x\\a\nb}", "", false, "replacement-3708",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*?\" \"a\\nb\" \"x\\\\\" out];list $n $out",
    "4 x\\\\ax\\\\\\nx\\\\bx\\\\", "", false, "replacement-3709",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"a*?\" \"a\\nb\" \"&&\" out];list $n $out", "1 {a\nb}",
    "", false, "replacement-3710",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"a*?\" \"a\\nb\" \"&&\" out];list $n $out",
    "4 {a\nb}", "", false, "replacement-3711",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"^\" \"\" \"X\" out];list $n $out", "1 X", "",
    false, "replacement-3712",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"^\" \"\" \"X\" out];list $n $out", "1 X",
    "", false, "replacement-3713",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"^\" \"\" \"&\" out];list $n $out", "1 {}", "",
    false, "replacement-3714",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"^\" \"\" \"&\" out];list $n $out", "1 {}",
    "", false, "replacement-3715",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"^\" \"\" \"\\\\0\" out];list $n $out", "1 {}",
    "", false, "replacement-3716",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"^\" \"\" \"\\\\0\" out];list $n $out", "1 {}",
    "", false, "replacement-3717",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"^\" \"\" \"<\\\\1>\" out];list $n $out", "1 <>",
    "", false, "replacement-3718",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"^\" \"\" \"<\\\\1>\" out];list $n $out",
    "1 <>", "", false, "replacement-3719",
  )
}

///|
test "Tcl regexp cases 3721 through 3760" {
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"^\" \"\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 -", "", false, "replacement-3720",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"^\" \"\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 -", "", false, "replacement-3721",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"^\" \"\" \"\\\\&\" out];list $n $out", "1 &",
    "", false, "replacement-3722",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"^\" \"\" \"\\\\&\" out];list $n $out", "1 &",
    "", false, "replacement-3723",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"^\" \"\" \"\\\\\\\\\" out];list $n $out", "1 \\\\",
    "", false, "replacement-3724",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"^\" \"\" \"\\\\\\\\\" out];list $n $out",
    "1 \\\\", "", false, "replacement-3725",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"^\" \"\" \"\\\\n\" out];list $n $out", "1 {\\n}",
    "", false, "replacement-3726",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"^\" \"\" \"\\\\n\" out];list $n $out", "1 {\\n}",
    "", false, "replacement-3727",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"^\" \"\" \"x\\\\\" out];list $n $out", "1 x\\\\",
    "", false, "replacement-3728",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"^\" \"\" \"x\\\\\" out];list $n $out", "1 x\\\\",
    "", false, "replacement-3729",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"^\" \"\" \"&&\" out];list $n $out", "1 {}",
    "", false, "replacement-3730",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"^\" \"\" \"&&\" out];list $n $out", "1 {}",
    "", false, "replacement-3731",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"^\" \"abc\" \"X\" out];list $n $out", "1 Xabc",
    "", false, "replacement-3732",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"^\" \"abc\" \"X\" out];list $n $out", "1 Xabc",
    "", false, "replacement-3733",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"^\" \"abc\" \"&\" out];list $n $out", "1 abc",
    "", false, "replacement-3734",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"^\" \"abc\" \"&\" out];list $n $out", "1 abc",
    "", false, "replacement-3735",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"^\" \"abc\" \"\\\\0\" out];list $n $out", "1 abc",
    "", false, "replacement-3736",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"^\" \"abc\" \"\\\\0\" out];list $n $out",
    "1 abc", "", false, "replacement-3737",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"^\" \"abc\" \"<\\\\1>\" out];list $n $out",
    "1 <>abc", "", false, "replacement-3738",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"^\" \"abc\" \"<\\\\1>\" out];list $n $out",
    "1 <>abc", "", false, "replacement-3739",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"^\" \"abc\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 -abc", "", false, "replacement-3740",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"^\" \"abc\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 -abc", "", false, "replacement-3741",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"^\" \"abc\" \"\\\\&\" out];list $n $out", "1 &abc",
    "", false, "replacement-3742",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"^\" \"abc\" \"\\\\&\" out];list $n $out",
    "1 &abc", "", false, "replacement-3743",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"^\" \"abc\" \"\\\\\\\\\" out];list $n $out",
    "1 {\\abc}", "", false, "replacement-3744",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"^\" \"abc\" \"\\\\\\\\\" out];list $n $out",
    "1 {\\abc}", "", false, "replacement-3745",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"^\" \"abc\" \"\\\\n\" out];list $n $out", "1 {\\nabc}",
    "", false, "replacement-3746",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"^\" \"abc\" \"\\\\n\" out];list $n $out",
    "1 {\\nabc}", "", false, "replacement-3747",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"^\" \"abc\" \"x\\\\\" out];list $n $out", "1 {x\\abc}",
    "", false, "replacement-3748",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"^\" \"abc\" \"x\\\\\" out];list $n $out",
    "1 {x\\abc}", "", false, "replacement-3749",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"^\" \"abc\" \"&&\" out];list $n $out", "1 abc",
    "", false, "replacement-3750",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"^\" \"abc\" \"&&\" out];list $n $out", "1 abc",
    "", false, "replacement-3751",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"^\" \"aba\" \"X\" out];list $n $out", "1 Xaba",
    "", false, "replacement-3752",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"^\" \"aba\" \"X\" out];list $n $out", "1 Xaba",
    "", false, "replacement-3753",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"^\" \"aba\" \"&\" out];list $n $out", "1 aba",
    "", false, "replacement-3754",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"^\" \"aba\" \"&\" out];list $n $out", "1 aba",
    "", false, "replacement-3755",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"^\" \"aba\" \"\\\\0\" out];list $n $out", "1 aba",
    "", false, "replacement-3756",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"^\" \"aba\" \"\\\\0\" out];list $n $out",
    "1 aba", "", false, "replacement-3757",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"^\" \"aba\" \"<\\\\1>\" out];list $n $out",
    "1 <>aba", "", false, "replacement-3758",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"^\" \"aba\" \"<\\\\1>\" out];list $n $out",
    "1 <>aba", "", false, "replacement-3759",
  )
}

///|
test "Tcl regexp cases 3761 through 3800" {
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"^\" \"aba\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 -aba", "", false, "replacement-3760",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"^\" \"aba\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 -aba", "", false, "replacement-3761",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"^\" \"aba\" \"\\\\&\" out];list $n $out", "1 &aba",
    "", false, "replacement-3762",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"^\" \"aba\" \"\\\\&\" out];list $n $out",
    "1 &aba", "", false, "replacement-3763",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"^\" \"aba\" \"\\\\\\\\\" out];list $n $out",
    "1 {\\aba}", "", false, "replacement-3764",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"^\" \"aba\" \"\\\\\\\\\" out];list $n $out",
    "1 {\\aba}", "", false, "replacement-3765",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"^\" \"aba\" \"\\\\n\" out];list $n $out", "1 {\\naba}",
    "", false, "replacement-3766",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"^\" \"aba\" \"\\\\n\" out];list $n $out",
    "1 {\\naba}", "", false, "replacement-3767",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"^\" \"aba\" \"x\\\\\" out];list $n $out", "1 {x\\aba}",
    "", false, "replacement-3768",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"^\" \"aba\" \"x\\\\\" out];list $n $out",
    "1 {x\\aba}", "", false, "replacement-3769",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"^\" \"aba\" \"&&\" out];list $n $out", "1 aba",
    "", false, "replacement-3770",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"^\" \"aba\" \"&&\" out];list $n $out", "1 aba",
    "", false, "replacement-3771",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"^\" \"a\\nb\" \"X\" out];list $n $out", "1 {Xa\nb}",
    "", false, "replacement-3772",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"^\" \"a\\nb\" \"X\" out];list $n $out",
    "1 {Xa\nb}", "", false, "replacement-3773",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"^\" \"a\\nb\" \"&\" out];list $n $out", "1 {a\nb}",
    "", false, "replacement-3774",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"^\" \"a\\nb\" \"&\" out];list $n $out",
    "1 {a\nb}", "", false, "replacement-3775",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"^\" \"a\\nb\" \"\\\\0\" out];list $n $out",
    "1 {a\nb}", "", false, "replacement-3776",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"^\" \"a\\nb\" \"\\\\0\" out];list $n $out",
    "1 {a\nb}", "", false, "replacement-3777",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"^\" \"a\\nb\" \"<\\\\1>\" out];list $n $out",
    "1 {<>a\nb}", "", false, "replacement-3778",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"^\" \"a\\nb\" \"<\\\\1>\" out];list $n $out",
    "1 {<>a\nb}", "", false, "replacement-3779",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"^\" \"a\\nb\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 {-a\nb}", "", false, "replacement-3780",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"^\" \"a\\nb\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 {-a\nb}", "", false, "replacement-3781",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"^\" \"a\\nb\" \"\\\\&\" out];list $n $out",
    "1 {&a\nb}", "", false, "replacement-3782",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"^\" \"a\\nb\" \"\\\\&\" out];list $n $out",
    "1 {&a\nb}", "", false, "replacement-3783",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"^\" \"a\\nb\" \"\\\\\\\\\" out];list $n $out",
    "1 {\\a\nb}", "", false, "replacement-3784",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"^\" \"a\\nb\" \"\\\\\\\\\" out];list $n $out",
    "1 {\\a\nb}", "", false, "replacement-3785",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"^\" \"a\\nb\" \"\\\\n\" out];list $n $out",
    "1 {\\na\nb}", "", false, "replacement-3786",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"^\" \"a\\nb\" \"\\\\n\" out];list $n $out",
    "1 {\\na\nb}", "", false, "replacement-3787",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"^\" \"a\\nb\" \"x\\\\\" out];list $n $out",
    "1 {x\\a\nb}", "", false, "replacement-3788",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"^\" \"a\\nb\" \"x\\\\\" out];list $n $out",
    "1 {x\\a\nb}", "", false, "replacement-3789",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"^\" \"a\\nb\" \"&&\" out];list $n $out", "1 {a\nb}",
    "", false, "replacement-3790",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"^\" \"a\\nb\" \"&&\" out];list $n $out",
    "1 {a\nb}", "", false, "replacement-3791",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\$\" \"\" \"X\" out];list $n $out", "1 X",
    "", false, "replacement-3792",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\$\" \"\" \"X\" out];list $n $out", "1 X",
    "", false, "replacement-3793",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\$\" \"\" \"&\" out];list $n $out", "1 {}",
    "", false, "replacement-3794",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\$\" \"\" \"&\" out];list $n $out", "1 {}",
    "", false, "replacement-3795",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\$\" \"\" \"\\\\0\" out];list $n $out", "1 {}",
    "", false, "replacement-3796",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\$\" \"\" \"\\\\0\" out];list $n $out",
    "1 {}", "", false, "replacement-3797",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\$\" \"\" \"<\\\\1>\" out];list $n $out", "1 <>",
    "", false, "replacement-3798",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\$\" \"\" \"<\\\\1>\" out];list $n $out",
    "1 <>", "", false, "replacement-3799",
  )
}

///|
test "Tcl regexp cases 3801 through 3840" {
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\$\" \"\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 -", "", false, "replacement-3800",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\$\" \"\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 -", "", false, "replacement-3801",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\$\" \"\" \"\\\\&\" out];list $n $out", "1 &",
    "", false, "replacement-3802",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\$\" \"\" \"\\\\&\" out];list $n $out",
    "1 &", "", false, "replacement-3803",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\$\" \"\" \"\\\\\\\\\" out];list $n $out",
    "1 \\\\", "", false, "replacement-3804",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\$\" \"\" \"\\\\\\\\\" out];list $n $out",
    "1 \\\\", "", false, "replacement-3805",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\$\" \"\" \"\\\\n\" out];list $n $out", "1 {\\n}",
    "", false, "replacement-3806",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\$\" \"\" \"\\\\n\" out];list $n $out",
    "1 {\\n}", "", false, "replacement-3807",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\$\" \"\" \"x\\\\\" out];list $n $out", "1 x\\\\",
    "", false, "replacement-3808",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\$\" \"\" \"x\\\\\" out];list $n $out",
    "1 x\\\\", "", false, "replacement-3809",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\$\" \"\" \"&&\" out];list $n $out", "1 {}",
    "", false, "replacement-3810",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\$\" \"\" \"&&\" out];list $n $out", "1 {}",
    "", false, "replacement-3811",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\$\" \"abc\" \"X\" out];list $n $out", "1 abcX",
    "", false, "replacement-3812",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\$\" \"abc\" \"X\" out];list $n $out",
    "1 abcX", "", false, "replacement-3813",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\$\" \"abc\" \"&\" out];list $n $out", "1 abc",
    "", false, "replacement-3814",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\$\" \"abc\" \"&\" out];list $n $out",
    "1 abc", "", false, "replacement-3815",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\$\" \"abc\" \"\\\\0\" out];list $n $out",
    "1 abc", "", false, "replacement-3816",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\$\" \"abc\" \"\\\\0\" out];list $n $out",
    "1 abc", "", false, "replacement-3817",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\$\" \"abc\" \"<\\\\1>\" out];list $n $out",
    "1 abc<>", "", false, "replacement-3818",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\$\" \"abc\" \"<\\\\1>\" out];list $n $out",
    "1 abc<>", "", false, "replacement-3819",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\$\" \"abc\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 abc-", "", false, "replacement-3820",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\$\" \"abc\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 abc-", "", false, "replacement-3821",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\$\" \"abc\" \"\\\\&\" out];list $n $out",
    "1 abc&", "", false, "replacement-3822",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\$\" \"abc\" \"\\\\&\" out];list $n $out",
    "1 abc&", "", false, "replacement-3823",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\$\" \"abc\" \"\\\\\\\\\" out];list $n $out",
    "1 abc\\\\", "", false, "replacement-3824",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\$\" \"abc\" \"\\\\\\\\\" out];list $n $out",
    "1 abc\\\\", "", false, "replacement-3825",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\$\" \"abc\" \"\\\\n\" out];list $n $out",
    "1 {abc\\n}", "", false, "replacement-3826",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\$\" \"abc\" \"\\\\n\" out];list $n $out",
    "1 {abc\\n}", "", false, "replacement-3827",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\$\" \"abc\" \"x\\\\\" out];list $n $out",
    "1 abcx\\\\", "", false, "replacement-3828",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\$\" \"abc\" \"x\\\\\" out];list $n $out",
    "1 abcx\\\\", "", false, "replacement-3829",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\$\" \"abc\" \"&&\" out];list $n $out", "1 abc",
    "", false, "replacement-3830",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\$\" \"abc\" \"&&\" out];list $n $out",
    "1 abc", "", false, "replacement-3831",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\$\" \"aba\" \"X\" out];list $n $out", "1 abaX",
    "", false, "replacement-3832",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\$\" \"aba\" \"X\" out];list $n $out",
    "1 abaX", "", false, "replacement-3833",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\$\" \"aba\" \"&\" out];list $n $out", "1 aba",
    "", false, "replacement-3834",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\$\" \"aba\" \"&\" out];list $n $out",
    "1 aba", "", false, "replacement-3835",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\$\" \"aba\" \"\\\\0\" out];list $n $out",
    "1 aba", "", false, "replacement-3836",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\$\" \"aba\" \"\\\\0\" out];list $n $out",
    "1 aba", "", false, "replacement-3837",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\$\" \"aba\" \"<\\\\1>\" out];list $n $out",
    "1 aba<>", "", false, "replacement-3838",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\$\" \"aba\" \"<\\\\1>\" out];list $n $out",
    "1 aba<>", "", false, "replacement-3839",
  )
}

///|
test "Tcl regexp cases 3841 through 3880" {
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\$\" \"aba\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 aba-", "", false, "replacement-3840",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\$\" \"aba\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 aba-", "", false, "replacement-3841",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\$\" \"aba\" \"\\\\&\" out];list $n $out",
    "1 aba&", "", false, "replacement-3842",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\$\" \"aba\" \"\\\\&\" out];list $n $out",
    "1 aba&", "", false, "replacement-3843",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\$\" \"aba\" \"\\\\\\\\\" out];list $n $out",
    "1 aba\\\\", "", false, "replacement-3844",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\$\" \"aba\" \"\\\\\\\\\" out];list $n $out",
    "1 aba\\\\", "", false, "replacement-3845",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\$\" \"aba\" \"\\\\n\" out];list $n $out",
    "1 {aba\\n}", "", false, "replacement-3846",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\$\" \"aba\" \"\\\\n\" out];list $n $out",
    "1 {aba\\n}", "", false, "replacement-3847",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\$\" \"aba\" \"x\\\\\" out];list $n $out",
    "1 abax\\\\", "", false, "replacement-3848",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\$\" \"aba\" \"x\\\\\" out];list $n $out",
    "1 abax\\\\", "", false, "replacement-3849",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\$\" \"aba\" \"&&\" out];list $n $out", "1 aba",
    "", false, "replacement-3850",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\$\" \"aba\" \"&&\" out];list $n $out",
    "1 aba", "", false, "replacement-3851",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\$\" \"a\\nb\" \"X\" out];list $n $out", "1 {a\nbX}",
    "", false, "replacement-3852",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\$\" \"a\\nb\" \"X\" out];list $n $out",
    "1 {a\nbX}", "", false, "replacement-3853",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\$\" \"a\\nb\" \"&\" out];list $n $out", "1 {a\nb}",
    "", false, "replacement-3854",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\$\" \"a\\nb\" \"&\" out];list $n $out",
    "1 {a\nb}", "", false, "replacement-3855",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\$\" \"a\\nb\" \"\\\\0\" out];list $n $out",
    "1 {a\nb}", "", false, "replacement-3856",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\$\" \"a\\nb\" \"\\\\0\" out];list $n $out",
    "1 {a\nb}", "", false, "replacement-3857",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\$\" \"a\\nb\" \"<\\\\1>\" out];list $n $out",
    "1 {a\nb<>}", "", false, "replacement-3858",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\$\" \"a\\nb\" \"<\\\\1>\" out];list $n $out",
    "1 {a\nb<>}", "", false, "replacement-3859",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\$\" \"a\\nb\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 {a\nb-}", "", false, "replacement-3860",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\$\" \"a\\nb\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 {a\nb-}", "", false, "replacement-3861",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\$\" \"a\\nb\" \"\\\\&\" out];list $n $out",
    "1 {a\nb&}", "", false, "replacement-3862",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\$\" \"a\\nb\" \"\\\\&\" out];list $n $out",
    "1 {a\nb&}", "", false, "replacement-3863",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\$\" \"a\\nb\" \"\\\\\\\\\" out];list $n $out",
    "1 a\\nb\\\\", "", false, "replacement-3864",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\$\" \"a\\nb\" \"\\\\\\\\\" out];list $n $out",
    "1 a\\nb\\\\", "", false, "replacement-3865",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\$\" \"a\\nb\" \"\\\\n\" out];list $n $out",
    "1 {a\nb\\n}", "", false, "replacement-3866",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\$\" \"a\\nb\" \"\\\\n\" out];list $n $out",
    "1 {a\nb\\n}", "", false, "replacement-3867",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\$\" \"a\\nb\" \"x\\\\\" out];list $n $out",
    "1 a\\nbx\\\\", "", false, "replacement-3868",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\$\" \"a\\nb\" \"x\\\\\" out];list $n $out",
    "1 a\\nbx\\\\", "", false, "replacement-3869",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\$\" \"a\\nb\" \"&&\" out];list $n $out", "1 {a\nb}",
    "", false, "replacement-3870",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\$\" \"a\\nb\" \"&&\" out];list $n $out",
    "1 {a\nb}", "", false, "replacement-3871",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\A\" \"\" \"X\" out];list $n $out", "1 X",
    "", false, "replacement-3872",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\A\" \"\" \"X\" out];list $n $out", "1 X",
    "", false, "replacement-3873",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\A\" \"\" \"&\" out];list $n $out", "1 {}",
    "", false, "replacement-3874",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\A\" \"\" \"&\" out];list $n $out", "1 {}",
    "", false, "replacement-3875",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\A\" \"\" \"\\\\0\" out];list $n $out", "1 {}",
    "", false, "replacement-3876",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\A\" \"\" \"\\\\0\" out];list $n $out",
    "1 {}", "", false, "replacement-3877",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\A\" \"\" \"<\\\\1>\" out];list $n $out",
    "1 <>", "", false, "replacement-3878",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\A\" \"\" \"<\\\\1>\" out];list $n $out",
    "1 <>", "", false, "replacement-3879",
  )
}

///|
test "Tcl regexp cases 3881 through 3920" {
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\A\" \"\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 -", "", false, "replacement-3880",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\A\" \"\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 -", "", false, "replacement-3881",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\A\" \"\" \"\\\\&\" out];list $n $out", "1 &",
    "", false, "replacement-3882",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\A\" \"\" \"\\\\&\" out];list $n $out",
    "1 &", "", false, "replacement-3883",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\A\" \"\" \"\\\\\\\\\" out];list $n $out",
    "1 \\\\", "", false, "replacement-3884",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\A\" \"\" \"\\\\\\\\\" out];list $n $out",
    "1 \\\\", "", false, "replacement-3885",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\A\" \"\" \"\\\\n\" out];list $n $out", "1 {\\n}",
    "", false, "replacement-3886",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\A\" \"\" \"\\\\n\" out];list $n $out",
    "1 {\\n}", "", false, "replacement-3887",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\A\" \"\" \"x\\\\\" out];list $n $out", "1 x\\\\",
    "", false, "replacement-3888",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\A\" \"\" \"x\\\\\" out];list $n $out",
    "1 x\\\\", "", false, "replacement-3889",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\A\" \"\" \"&&\" out];list $n $out", "1 {}",
    "", false, "replacement-3890",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\A\" \"\" \"&&\" out];list $n $out",
    "1 {}", "", false, "replacement-3891",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\A\" \"abc\" \"X\" out];list $n $out", "1 Xabc",
    "", false, "replacement-3892",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\A\" \"abc\" \"X\" out];list $n $out",
    "4 XaXbXcX", "", false, "replacement-3893",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\A\" \"abc\" \"&\" out];list $n $out", "1 abc",
    "", false, "replacement-3894",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\A\" \"abc\" \"&\" out];list $n $out",
    "4 abc", "", false, "replacement-3895",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\A\" \"abc\" \"\\\\0\" out];list $n $out",
    "1 abc", "", false, "replacement-3896",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\A\" \"abc\" \"\\\\0\" out];list $n $out",
    "4 abc", "", false, "replacement-3897",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\A\" \"abc\" \"<\\\\1>\" out];list $n $out",
    "1 <>abc", "", false, "replacement-3898",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\A\" \"abc\" \"<\\\\1>\" out];list $n $out",
    "4 <>a<>b<>c<>", "", false, "replacement-3899",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\A\" \"abc\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 -abc", "", false, "replacement-3900",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\A\" \"abc\" \"\\\\2-\\\\9\" out];list $n $out",
    "4 -a-b-c-", "", false, "replacement-3901",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\A\" \"abc\" \"\\\\&\" out];list $n $out",
    "1 &abc", "", false, "replacement-3902",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\A\" \"abc\" \"\\\\&\" out];list $n $out",
    "4 &a&b&c&", "", false, "replacement-3903",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\A\" \"abc\" \"\\\\\\\\\" out];list $n $out",
    "1 {\\abc}", "", false, "replacement-3904",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\A\" \"abc\" \"\\\\\\\\\" out];list $n $out",
    "4 \\\\a\\\\b\\\\c\\\\", "", false, "replacement-3905",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\A\" \"abc\" \"\\\\n\" out];list $n $out",
    "1 {\\nabc}", "", false, "replacement-3906",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\A\" \"abc\" \"\\\\n\" out];list $n $out",
    "4 {\\na\\nb\\nc\\n}", "", false, "replacement-3907",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\A\" \"abc\" \"x\\\\\" out];list $n $out",
    "1 {x\\abc}", "", false, "replacement-3908",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\A\" \"abc\" \"x\\\\\" out];list $n $out",
    "4 x\\\\ax\\\\bx\\\\cx\\\\", "", false, "replacement-3909",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\A\" \"abc\" \"&&\" out];list $n $out", "1 abc",
    "", false, "replacement-3910",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\A\" \"abc\" \"&&\" out];list $n $out",
    "4 abc", "", false, "replacement-3911",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\A\" \"aba\" \"X\" out];list $n $out", "1 Xaba",
    "", false, "replacement-3912",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\A\" \"aba\" \"X\" out];list $n $out",
    "4 XaXbXaX", "", false, "replacement-3913",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\A\" \"aba\" \"&\" out];list $n $out", "1 aba",
    "", false, "replacement-3914",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\A\" \"aba\" \"&\" out];list $n $out",
    "4 aba", "", false, "replacement-3915",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\A\" \"aba\" \"\\\\0\" out];list $n $out",
    "1 aba", "", false, "replacement-3916",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\A\" \"aba\" \"\\\\0\" out];list $n $out",
    "4 aba", "", false, "replacement-3917",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\A\" \"aba\" \"<\\\\1>\" out];list $n $out",
    "1 <>aba", "", false, "replacement-3918",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\A\" \"aba\" \"<\\\\1>\" out];list $n $out",
    "4 <>a<>b<>a<>", "", false, "replacement-3919",
  )
}

///|
test "Tcl regexp cases 3921 through 3960" {
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\A\" \"aba\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 -aba", "", false, "replacement-3920",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\A\" \"aba\" \"\\\\2-\\\\9\" out];list $n $out",
    "4 -a-b-a-", "", false, "replacement-3921",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\A\" \"aba\" \"\\\\&\" out];list $n $out",
    "1 &aba", "", false, "replacement-3922",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\A\" \"aba\" \"\\\\&\" out];list $n $out",
    "4 &a&b&a&", "", false, "replacement-3923",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\A\" \"aba\" \"\\\\\\\\\" out];list $n $out",
    "1 {\\aba}", "", false, "replacement-3924",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\A\" \"aba\" \"\\\\\\\\\" out];list $n $out",
    "4 \\\\a\\\\b\\\\a\\\\", "", false, "replacement-3925",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\A\" \"aba\" \"\\\\n\" out];list $n $out",
    "1 {\\naba}", "", false, "replacement-3926",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\A\" \"aba\" \"\\\\n\" out];list $n $out",
    "4 {\\na\\nb\\na\\n}", "", false, "replacement-3927",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\A\" \"aba\" \"x\\\\\" out];list $n $out",
    "1 {x\\aba}", "", false, "replacement-3928",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\A\" \"aba\" \"x\\\\\" out];list $n $out",
    "4 x\\\\ax\\\\bx\\\\ax\\\\", "", false, "replacement-3929",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\A\" \"aba\" \"&&\" out];list $n $out", "1 aba",
    "", false, "replacement-3930",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\A\" \"aba\" \"&&\" out];list $n $out",
    "4 aba", "", false, "replacement-3931",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\A\" \"a\\nb\" \"X\" out];list $n $out",
    "1 {Xa\nb}", "", false, "replacement-3932",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\A\" \"a\\nb\" \"X\" out];list $n $out",
    "4 {XaX\nXbX}", "", false, "replacement-3933",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\A\" \"a\\nb\" \"&\" out];list $n $out",
    "1 {a\nb}", "", false, "replacement-3934",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\A\" \"a\\nb\" \"&\" out];list $n $out",
    "4 {a\nb}", "", false, "replacement-3935",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\A\" \"a\\nb\" \"\\\\0\" out];list $n $out",
    "1 {a\nb}", "", false, "replacement-3936",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\A\" \"a\\nb\" \"\\\\0\" out];list $n $out",
    "4 {a\nb}", "", false, "replacement-3937",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\A\" \"a\\nb\" \"<\\\\1>\" out];list $n $out",
    "1 {<>a\nb}", "", false, "replacement-3938",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\A\" \"a\\nb\" \"<\\\\1>\" out];list $n $out",
    "4 {<>a<>\n<>b<>}", "", false, "replacement-3939",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\A\" \"a\\nb\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 {-a\nb}", "", false, "replacement-3940",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\A\" \"a\\nb\" \"\\\\2-\\\\9\" out];list $n $out",
    "4 {-a-\n-b-}", "", false, "replacement-3941",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\A\" \"a\\nb\" \"\\\\&\" out];list $n $out",
    "1 {&a\nb}", "", false, "replacement-3942",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\A\" \"a\\nb\" \"\\\\&\" out];list $n $out",
    "4 {&a&\n&b&}", "", false, "replacement-3943",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\A\" \"a\\nb\" \"\\\\\\\\\" out];list $n $out",
    "1 {\\a\nb}", "", false, "replacement-3944",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\A\" \"a\\nb\" \"\\\\\\\\\" out];list $n $out",
    "4 \\\\a\\\\\\n\\\\b\\\\", "", false, "replacement-3945",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\A\" \"a\\nb\" \"\\\\n\" out];list $n $out",
    "1 {\\na\nb}", "", false, "replacement-3946",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\A\" \"a\\nb\" \"\\\\n\" out];list $n $out",
    "4 {\\na\\n\n\\nb\\n}", "", false, "replacement-3947",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\A\" \"a\\nb\" \"x\\\\\" out];list $n $out",
    "1 {x\\a\nb}", "", false, "replacement-3948",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\A\" \"a\\nb\" \"x\\\\\" out];list $n $out",
    "4 x\\\\ax\\\\\\nx\\\\bx\\\\", "", false, "replacement-3949",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\A\" \"a\\nb\" \"&&\" out];list $n $out",
    "1 {a\nb}", "", false, "replacement-3950",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\A\" \"a\\nb\" \"&&\" out];list $n $out",
    "4 {a\nb}", "", false, "replacement-3951",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\m\" \"\" \"X\" out];list $n $out", "0 {}",
    "", false, "replacement-3952",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\m\" \"\" \"X\" out];list $n $out", "0 {}",
    "", false, "replacement-3953",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\m\" \"\" \"&\" out];list $n $out", "0 {}",
    "", false, "replacement-3954",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\m\" \"\" \"&\" out];list $n $out", "0 {}",
    "", false, "replacement-3955",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\m\" \"\" \"\\\\0\" out];list $n $out", "0 {}",
    "", false, "replacement-3956",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\m\" \"\" \"\\\\0\" out];list $n $out",
    "0 {}", "", false, "replacement-3957",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\m\" \"\" \"<\\\\1>\" out];list $n $out",
    "0 {}", "", false, "replacement-3958",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\m\" \"\" \"<\\\\1>\" out];list $n $out",
    "0 {}", "", false, "replacement-3959",
  )
}

///|
test "Tcl regexp cases 3961 through 4000" {
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\m\" \"\" \"\\\\2-\\\\9\" out];list $n $out",
    "0 {}", "", false, "replacement-3960",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\m\" \"\" \"\\\\2-\\\\9\" out];list $n $out",
    "0 {}", "", false, "replacement-3961",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\m\" \"\" \"\\\\&\" out];list $n $out", "0 {}",
    "", false, "replacement-3962",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\m\" \"\" \"\\\\&\" out];list $n $out",
    "0 {}", "", false, "replacement-3963",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\m\" \"\" \"\\\\\\\\\" out];list $n $out",
    "0 {}", "", false, "replacement-3964",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\m\" \"\" \"\\\\\\\\\" out];list $n $out",
    "0 {}", "", false, "replacement-3965",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\m\" \"\" \"\\\\n\" out];list $n $out", "0 {}",
    "", false, "replacement-3966",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\m\" \"\" \"\\\\n\" out];list $n $out",
    "0 {}", "", false, "replacement-3967",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\m\" \"\" \"x\\\\\" out];list $n $out", "0 {}",
    "", false, "replacement-3968",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\m\" \"\" \"x\\\\\" out];list $n $out",
    "0 {}", "", false, "replacement-3969",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\m\" \"\" \"&&\" out];list $n $out", "0 {}",
    "", false, "replacement-3970",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\m\" \"\" \"&&\" out];list $n $out",
    "0 {}", "", false, "replacement-3971",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\m\" \"abc\" \"X\" out];list $n $out", "1 Xabc",
    "", false, "replacement-3972",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\m\" \"abc\" \"X\" out];list $n $out",
    "3 XaXbXc", "", false, "replacement-3973",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\m\" \"abc\" \"&\" out];list $n $out", "1 abc",
    "", false, "replacement-3974",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\m\" \"abc\" \"&\" out];list $n $out",
    "3 abc", "", false, "replacement-3975",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\m\" \"abc\" \"\\\\0\" out];list $n $out",
    "1 abc", "", false, "replacement-3976",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\m\" \"abc\" \"\\\\0\" out];list $n $out",
    "3 abc", "", false, "replacement-3977",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\m\" \"abc\" \"<\\\\1>\" out];list $n $out",
    "1 <>abc", "", false, "replacement-3978",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\m\" \"abc\" \"<\\\\1>\" out];list $n $out",
    "3 <>a<>b<>c", "", false, "replacement-3979",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\m\" \"abc\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 -abc", "", false, "replacement-3980",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\m\" \"abc\" \"\\\\2-\\\\9\" out];list $n $out",
    "3 -a-b-c", "", false, "replacement-3981",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\m\" \"abc\" \"\\\\&\" out];list $n $out",
    "1 &abc", "", false, "replacement-3982",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\m\" \"abc\" \"\\\\&\" out];list $n $out",
    "3 &a&b&c", "", false, "replacement-3983",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\m\" \"abc\" \"\\\\\\\\\" out];list $n $out",
    "1 {\\abc}", "", false, "replacement-3984",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\m\" \"abc\" \"\\\\\\\\\" out];list $n $out",
    "3 {\\a\\b\\c}", "", false, "replacement-3985",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\m\" \"abc\" \"\\\\n\" out];list $n $out",
    "1 {\\nabc}", "", false, "replacement-3986",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\m\" \"abc\" \"\\\\n\" out];list $n $out",
    "3 {\\na\\nb\\nc}", "", false, "replacement-3987",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\m\" \"abc\" \"x\\\\\" out];list $n $out",
    "1 {x\\abc}", "", false, "replacement-3988",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\m\" \"abc\" \"x\\\\\" out];list $n $out",
    "3 {x\\ax\\bx\\c}", "", false, "replacement-3989",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\m\" \"abc\" \"&&\" out];list $n $out", "1 abc",
    "", false, "replacement-3990",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\m\" \"abc\" \"&&\" out];list $n $out",
    "3 abc", "", false, "replacement-3991",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\m\" \"aba\" \"X\" out];list $n $out", "1 Xaba",
    "", false, "replacement-3992",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\m\" \"aba\" \"X\" out];list $n $out",
    "3 XaXbXa", "", false, "replacement-3993",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\m\" \"aba\" \"&\" out];list $n $out", "1 aba",
    "", false, "replacement-3994",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\m\" \"aba\" \"&\" out];list $n $out",
    "3 aba", "", false, "replacement-3995",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\m\" \"aba\" \"\\\\0\" out];list $n $out",
    "1 aba", "", false, "replacement-3996",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\m\" \"aba\" \"\\\\0\" out];list $n $out",
    "3 aba", "", false, "replacement-3997",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\m\" \"aba\" \"<\\\\1>\" out];list $n $out",
    "1 <>aba", "", false, "replacement-3998",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\m\" \"aba\" \"<\\\\1>\" out];list $n $out",
    "3 <>a<>b<>a", "", false, "replacement-3999",
  )
}

///|
test "Tcl regexp cases 4001 through 4040" {
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\m\" \"aba\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 -aba", "", false, "replacement-4000",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\m\" \"aba\" \"\\\\2-\\\\9\" out];list $n $out",
    "3 -a-b-a", "", false, "replacement-4001",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\m\" \"aba\" \"\\\\&\" out];list $n $out",
    "1 &aba", "", false, "replacement-4002",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\m\" \"aba\" \"\\\\&\" out];list $n $out",
    "3 &a&b&a", "", false, "replacement-4003",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\m\" \"aba\" \"\\\\\\\\\" out];list $n $out",
    "1 {\\aba}", "", false, "replacement-4004",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\m\" \"aba\" \"\\\\\\\\\" out];list $n $out",
    "3 {\\a\\b\\a}", "", false, "replacement-4005",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\m\" \"aba\" \"\\\\n\" out];list $n $out",
    "1 {\\naba}", "", false, "replacement-4006",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\m\" \"aba\" \"\\\\n\" out];list $n $out",
    "3 {\\na\\nb\\na}", "", false, "replacement-4007",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\m\" \"aba\" \"x\\\\\" out];list $n $out",
    "1 {x\\aba}", "", false, "replacement-4008",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\m\" \"aba\" \"x\\\\\" out];list $n $out",
    "3 {x\\ax\\bx\\a}", "", false, "replacement-4009",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\m\" \"aba\" \"&&\" out];list $n $out", "1 aba",
    "", false, "replacement-4010",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\m\" \"aba\" \"&&\" out];list $n $out",
    "3 aba", "", false, "replacement-4011",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\m\" \"a\\nb\" \"X\" out];list $n $out",
    "1 {Xa\nb}", "", false, "replacement-4012",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\m\" \"a\\nb\" \"X\" out];list $n $out",
    "2 {Xa\nXb}", "", false, "replacement-4013",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\m\" \"a\\nb\" \"&\" out];list $n $out",
    "1 {a\nb}", "", false, "replacement-4014",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\m\" \"a\\nb\" \"&\" out];list $n $out",
    "2 {a\nb}", "", false, "replacement-4015",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\m\" \"a\\nb\" \"\\\\0\" out];list $n $out",
    "1 {a\nb}", "", false, "replacement-4016",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\m\" \"a\\nb\" \"\\\\0\" out];list $n $out",
    "2 {a\nb}", "", false, "replacement-4017",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\m\" \"a\\nb\" \"<\\\\1>\" out];list $n $out",
    "1 {<>a\nb}", "", false, "replacement-4018",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\m\" \"a\\nb\" \"<\\\\1>\" out];list $n $out",
    "2 {<>a\n<>b}", "", false, "replacement-4019",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\m\" \"a\\nb\" \"\\\\2-\\\\9\" out];list $n $out",
    "1 {-a\nb}", "", false, "replacement-4020",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\m\" \"a\\nb\" \"\\\\2-\\\\9\" out];list $n $out",
    "2 {-a\n-b}", "", false, "replacement-4021",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\m\" \"a\\nb\" \"\\\\&\" out];list $n $out",
    "1 {&a\nb}", "", false, "replacement-4022",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\m\" \"a\\nb\" \"\\\\&\" out];list $n $out",
    "2 {&a\n&b}", "", false, "replacement-4023",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\m\" \"a\\nb\" \"\\\\\\\\\" out];list $n $out",
    "1 {\\a\nb}", "", false, "replacement-4024",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\m\" \"a\\nb\" \"\\\\\\\\\" out];list $n $out",
    "2 {\\a\n\\b}", "", false, "replacement-4025",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\m\" \"a\\nb\" \"\\\\n\" out];list $n $out",
    "1 {\\na\nb}", "", false, "replacement-4026",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\m\" \"a\\nb\" \"\\\\n\" out];list $n $out",
    "2 {\\na\n\\nb}", "", false, "replacement-4027",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\m\" \"a\\nb\" \"x\\\\\" out];list $n $out",
    "1 {x\\a\nb}", "", false, "replacement-4028",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\m\" \"a\\nb\" \"x\\\\\" out];list $n $out",
    "2 {x\\a\nx\\b}", "", false, "replacement-4029",
  )
  check_regexp_case(
    "set out OLD;set n [regsub  -- \"\\\\m\" \"a\\nb\" \"&&\" out];list $n $out",
    "1 {a\nb}", "", false, "replacement-4030",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -- \"\\\\m\" \"a\\nb\" \"&&\" out];list $n $out",
    "2 {a\nb}", "", false, "replacement-4031",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"\" \"\" \"X\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4032",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"\" \"\" \"X\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4033",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"\" \"\" \"X\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4034",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"\" \"\" \"X\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4035",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"\" \"\" \"X\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4036",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"\" \"\" \"X\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4037",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"\" \"\" \"<&>\" out];list $n $out",
    "1 <>", "", false, "replacement-options-4038",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"\" \"\" \"<&>\" out];list $n $out",
    "1 <>", "", false, "replacement-options-4039",
  )
}

///|
test "Tcl regexp cases 4041 through 4080" {
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"\" \"\" \"<&>\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4040",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"\" \"\" \"<&>\" out];list $n $out",
    "1 <>", "", false, "replacement-options-4041",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"\" \"\" \"<&>\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4042",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"\" \"\" \"<&>\" out];list $n $out",
    "1 <>", "", false, "replacement-options-4043",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"\" \"a b a\" \"X\" out];list $n $out",
    "5 {XaX XbX Xa}", "", false, "replacement-options-4044",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"\" \"a b a\" \"X\" out];list $n $out",
    "5 {XaX XbX Xa}", "", false, "replacement-options-4045",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"\" \"a b a\" \"X\" out];list $n $out",
    "5 {aX XbX XaX}", "", false, "replacement-options-4046",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"\" \"a b a\" \"X\" out];list $n $out",
    "1 {a b aX}", "", false, "replacement-options-4047",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"\" \"a b a\" \"X\" out];list $n $out",
    "0 {a b a}", "", false, "replacement-options-4048",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"\" \"a b a\" \"X\" out];list $n $out",
    "5 {XaX XbX Xa}", "", false, "replacement-options-4049",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"\" \"a b a\" \"<&>\" out];list $n $out",
    "6 {<>a<> <>b<> <>a<>}", "", false, "replacement-options-4050",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"\" \"a b a\" \"<&>\" out];list $n $out",
    "6 {<>a<> <>b<> <>a<>}", "", false, "replacement-options-4051",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"\" \"a b a\" \"<&>\" out];list $n $out",
    "5 {a<> <>b<> <>a<>}", "", false, "replacement-options-4052",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"\" \"a b a\" \"<&>\" out];list $n $out",
    "1 {a b a<>}", "", false, "replacement-options-4053",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"\" \"a b a\" \"<&>\" out];list $n $out",
    "0 {a b a}", "", false, "replacement-options-4054",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"\" \"a b a\" \"<&>\" out];list $n $out",
    "6 {<>a<> <>b<> <>a<>}", "", false, "replacement-options-4055",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"\" \"ABC\" \"X\" out];list $n $out",
    "3 XAXBXC", "", false, "replacement-options-4056",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"\" \"ABC\" \"X\" out];list $n $out",
    "3 XAXBXC", "", false, "replacement-options-4057",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"\" \"ABC\" \"X\" out];list $n $out",
    "3 AXBXCX", "", false, "replacement-options-4058",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"\" \"ABC\" \"X\" out];list $n $out",
    "1 ABCX", "", false, "replacement-options-4059",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"\" \"ABC\" \"X\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4060",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"\" \"ABC\" \"X\" out];list $n $out",
    "3 XAXBXC", "", false, "replacement-options-4061",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"\" \"ABC\" \"<&>\" out];list $n $out",
    "4 <>A<>B<>C<>", "", false, "replacement-options-4062",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"\" \"ABC\" \"<&>\" out];list $n $out",
    "4 <>A<>B<>C<>", "", false, "replacement-options-4063",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"\" \"ABC\" \"<&>\" out];list $n $out",
    "3 A<>B<>C<>", "", false, "replacement-options-4064",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"\" \"ABC\" \"<&>\" out];list $n $out",
    "1 ABC<>", "", false, "replacement-options-4065",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"\" \"ABC\" \"<&>\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4066",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"\" \"ABC\" \"<&>\" out];list $n $out",
    "4 <>A<>B<>C<>", "", false, "replacement-options-4067",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"\" \"ab\\nab\" \"X\" out];list $n $out",
    "5 {XaXbX\nXaXb}", "", false, "replacement-options-4068",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"\" \"ab\\nab\" \"X\" out];list $n $out",
    "5 {XaXbX\nXaXb}", "", false, "replacement-options-4069",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"\" \"ab\\nab\" \"X\" out];list $n $out",
    "5 {aXbX\nXaXbX}", "", false, "replacement-options-4070",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"\" \"ab\\nab\" \"X\" out];list $n $out",
    "1 {ab\nabX}", "", false, "replacement-options-4071",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"\" \"ab\\nab\" \"X\" out];list $n $out",
    "0 {ab\nab}", "", false, "replacement-options-4072",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"\" \"ab\\nab\" \"X\" out];list $n $out",
    "5 {XaXbX\nXaXb}", "", false, "replacement-options-4073",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"\" \"ab\\nab\" \"<&>\" out];list $n $out",
    "6 {<>a<>b<>\n<>a<>b<>}", "", false, "replacement-options-4074",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"\" \"ab\\nab\" \"<&>\" out];list $n $out",
    "6 {<>a<>b<>\n<>a<>b<>}", "", false, "replacement-options-4075",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"\" \"ab\\nab\" \"<&>\" out];list $n $out",
    "5 {a<>b<>\n<>a<>b<>}", "", false, "replacement-options-4076",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"\" \"ab\\nab\" \"<&>\" out];list $n $out",
    "1 {ab\nab<>}", "", false, "replacement-options-4077",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"\" \"ab\\nab\" \"<&>\" out];list $n $out",
    "0 {ab\nab}", "", false, "replacement-options-4078",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"\" \"ab\\nab\" \"<&>\" out];list $n $out",
    "6 {<>a<>b<>\n<>a<>b<>}", "", false, "replacement-options-4079",
  )
}

///|
test "Tcl regexp cases 4081 through 4120" {
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"\" \"鈩猭K\" \"X\" out];list $n $out",
    "3 X鈩X猭XK", "", false, "replacement-options-4080",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"\" \"鈩猭K\" \"X\" out];list $n $out",
    "3 X鈩X猭XK", "", false, "replacement-options-4081",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"\" \"鈩猭K\" \"X\" out];list $n $out",
    "3 鈩X猭XKX", "", false, "replacement-options-4082",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"\" \"鈩猭K\" \"X\" out];list $n $out",
    "1 鈩猭KX", "", false, "replacement-options-4083",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"\" \"鈩猭K\" \"X\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4084",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"\" \"鈩猭K\" \"X\" out];list $n $out",
    "3 X鈩X猭XK", "", false, "replacement-options-4085",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"\" \"鈩猭K\" \"<&>\" out];list $n $out",
    "4 <>鈩<>猭<>K<>", "", false, "replacement-options-4086",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"\" \"鈩猭K\" \"<&>\" out];list $n $out",
    "4 <>鈩<>猭<>K<>", "", false, "replacement-options-4087",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"\" \"鈩猭K\" \"<&>\" out];list $n $out",
    "3 鈩<>猭<>K<>", "", false, "replacement-options-4088",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"\" \"鈩猭K\" \"<&>\" out];list $n $out",
    "1 鈩猭K<>", "", false, "replacement-options-4089",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"\" \"鈩猭K\" \"<&>\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4090",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"\" \"鈩猭K\" \"<&>\" out];list $n $out",
    "4 <>鈩<>猭<>K<>", "", false, "replacement-options-4091",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"\" \"姹夊瓧\" \"X\" out];list $n $out",
    "3 X姹X夊X瓧", "", false, "replacement-options-4092",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"\" \"姹夊瓧\" \"X\" out];list $n $out",
    "3 X姹X夊X瓧", "", false, "replacement-options-4093",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"\" \"姹夊瓧\" \"X\" out];list $n $out",
    "3 姹X夊X瓧X", "", false, "replacement-options-4094",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"\" \"姹夊瓧\" \"X\" out];list $n $out",
    "1 姹夊瓧X", "", false, "replacement-options-4095",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"\" \"姹夊瓧\" \"X\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4096",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"\" \"姹夊瓧\" \"X\" out];list $n $out",
    "3 X姹X夊X瓧", "", false, "replacement-options-4097",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"\" \"姹夊瓧\" \"<&>\" out];list $n $out",
    "4 <>姹<>夊<>瓧<>", "", false, "replacement-options-4098",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"\" \"姹夊瓧\" \"<&>\" out];list $n $out",
    "4 <>姹<>夊<>瓧<>", "", false, "replacement-options-4099",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"\" \"姹夊瓧\" \"<&>\" out];list $n $out",
    "3 姹<>夊<>瓧<>", "", false, "replacement-options-4100",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"\" \"姹夊瓧\" \"<&>\" out];list $n $out",
    "1 姹夊瓧<>", "", false, "replacement-options-4101",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"\" \"姹夊瓧\" \"<&>\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4102",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"\" \"姹夊瓧\" \"<&>\" out];list $n $out",
    "4 <>姹<>夊<>瓧<>", "", false, "replacement-options-4103",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"a\" \"\" \"X\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4104",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"a\" \"\" \"X\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4105",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"a\" \"\" \"X\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4106",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"a\" \"\" \"X\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4107",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"a\" \"\" \"X\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4108",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"a\" \"\" \"X\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4109",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"a\" \"\" \"<&>\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4110",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"a\" \"\" \"<&>\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4111",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"a\" \"\" \"<&>\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4112",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"a\" \"\" \"<&>\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4113",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"a\" \"\" \"<&>\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4114",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"a\" \"\" \"<&>\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4115",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"a\" \"a b a\" \"X\" out];list $n $out",
    "2 {X b X}", "", false, "replacement-options-4116",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"a\" \"a b a\" \"X\" out];list $n $out",
    "2 {X b X}", "", false, "replacement-options-4117",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"a\" \"a b a\" \"X\" out];list $n $out",
    "1 {a b X}", "", false, "replacement-options-4118",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"a\" \"a b a\" \"X\" out];list $n $out",
    "0 {a b a}", "", false, "replacement-options-4119",
  )
}

///|
test "Tcl regexp cases 4121 through 4160" {
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"a\" \"a b a\" \"X\" out];list $n $out",
    "0 {a b a}", "", false, "replacement-options-4120",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"a\" \"a b a\" \"X\" out];list $n $out",
    "2 {X b X}", "", false, "replacement-options-4121",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"a\" \"a b a\" \"<&>\" out];list $n $out",
    "2 {<a> b <a>}", "", false, "replacement-options-4122",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"a\" \"a b a\" \"<&>\" out];list $n $out",
    "2 {<a> b <a>}", "", false, "replacement-options-4123",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"a\" \"a b a\" \"<&>\" out];list $n $out",
    "1 {a b <a>}", "", false, "replacement-options-4124",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"a\" \"a b a\" \"<&>\" out];list $n $out",
    "0 {a b a}", "", false, "replacement-options-4125",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"a\" \"a b a\" \"<&>\" out];list $n $out",
    "0 {a b a}", "", false, "replacement-options-4126",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"a\" \"a b a\" \"<&>\" out];list $n $out",
    "2 {<a> b <a>}", "", false, "replacement-options-4127",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"a\" \"ABC\" \"X\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4128",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"a\" \"ABC\" \"X\" out];list $n $out",
    "1 XBC", "", false, "replacement-options-4129",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"a\" \"ABC\" \"X\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4130",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"a\" \"ABC\" \"X\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4131",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"a\" \"ABC\" \"X\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4132",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"a\" \"ABC\" \"X\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4133",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"a\" \"ABC\" \"<&>\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4134",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"a\" \"ABC\" \"<&>\" out];list $n $out",
    "1 <A>BC", "", false, "replacement-options-4135",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"a\" \"ABC\" \"<&>\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4136",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"a\" \"ABC\" \"<&>\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4137",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"a\" \"ABC\" \"<&>\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4138",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"a\" \"ABC\" \"<&>\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4139",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"a\" \"ab\\nab\" \"X\" out];list $n $out",
    "2 {Xb\nXb}", "", false, "replacement-options-4140",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"a\" \"ab\\nab\" \"X\" out];list $n $out",
    "2 {Xb\nXb}", "", false, "replacement-options-4141",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"a\" \"ab\\nab\" \"X\" out];list $n $out",
    "1 {ab\nXb}", "", false, "replacement-options-4142",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"a\" \"ab\\nab\" \"X\" out];list $n $out",
    "0 {ab\nab}", "", false, "replacement-options-4143",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"a\" \"ab\\nab\" \"X\" out];list $n $out",
    "0 {ab\nab}", "", false, "replacement-options-4144",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"a\" \"ab\\nab\" \"X\" out];list $n $out",
    "2 {Xb\nXb}", "", false, "replacement-options-4145",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"a\" \"ab\\nab\" \"<&>\" out];list $n $out",
    "2 {<a>b\n<a>b}", "", false, "replacement-options-4146",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"a\" \"ab\\nab\" \"<&>\" out];list $n $out",
    "2 {<a>b\n<a>b}", "", false, "replacement-options-4147",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"a\" \"ab\\nab\" \"<&>\" out];list $n $out",
    "1 {ab\n<a>b}", "", false, "replacement-options-4148",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"a\" \"ab\\nab\" \"<&>\" out];list $n $out",
    "0 {ab\nab}", "", false, "replacement-options-4149",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"a\" \"ab\\nab\" \"<&>\" out];list $n $out",
    "0 {ab\nab}", "", false, "replacement-options-4150",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"a\" \"ab\\nab\" \"<&>\" out];list $n $out",
    "2 {<a>b\n<a>b}", "", false, "replacement-options-4151",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"a\" \"鈩猭K\" \"X\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4152",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"a\" \"鈩猭K\" \"X\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4153",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"a\" \"鈩猭K\" \"X\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4154",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"a\" \"鈩猭K\" \"X\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4155",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"a\" \"鈩猭K\" \"X\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4156",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"a\" \"鈩猭K\" \"X\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4157",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"a\" \"鈩猭K\" \"<&>\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4158",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"a\" \"鈩猭K\" \"<&>\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4159",
  )
}

///|
test "Tcl regexp cases 4161 through 4200" {
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"a\" \"鈩猭K\" \"<&>\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4160",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"a\" \"鈩猭K\" \"<&>\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4161",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"a\" \"鈩猭K\" \"<&>\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4162",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"a\" \"鈩猭K\" \"<&>\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4163",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"a\" \"姹夊瓧\" \"X\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4164",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"a\" \"姹夊瓧\" \"X\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4165",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"a\" \"姹夊瓧\" \"X\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4166",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"a\" \"姹夊瓧\" \"X\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4167",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"a\" \"姹夊瓧\" \"X\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4168",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"a\" \"姹夊瓧\" \"X\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4169",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"a\" \"姹夊瓧\" \"<&>\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4170",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"a\" \"姹夊瓧\" \"<&>\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4171",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"a\" \"姹夊瓧\" \"<&>\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4172",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"a\" \"姹夊瓧\" \"<&>\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4173",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"a\" \"姹夊瓧\" \"<&>\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4174",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"a\" \"姹夊瓧\" \"<&>\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4175",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"a b\" \"\" \"X\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4176",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"a b\" \"\" \"X\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4177",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"a b\" \"\" \"X\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4178",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"a b\" \"\" \"X\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4179",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"a b\" \"\" \"X\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4180",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"a b\" \"\" \"X\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4181",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"a b\" \"\" \"<&>\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4182",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"a b\" \"\" \"<&>\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4183",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"a b\" \"\" \"<&>\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4184",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"a b\" \"\" \"<&>\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4185",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"a b\" \"\" \"<&>\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4186",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"a b\" \"\" \"<&>\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4187",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"a b\" \"a b a\" \"X\" out];list $n $out",
    "1 {X a}", "", false, "replacement-options-4188",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"a b\" \"a b a\" \"X\" out];list $n $out",
    "1 {X a}", "", false, "replacement-options-4189",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"a b\" \"a b a\" \"X\" out];list $n $out",
    "0 {a b a}", "", false, "replacement-options-4190",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"a b\" \"a b a\" \"X\" out];list $n $out",
    "0 {a b a}", "", false, "replacement-options-4191",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"a b\" \"a b a\" \"X\" out];list $n $out",
    "0 {a b a}", "", false, "replacement-options-4192",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"a b\" \"a b a\" \"X\" out];list $n $out",
    "1 {X a}", "", false, "replacement-options-4193",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"a b\" \"a b a\" \"<&>\" out];list $n $out",
    "0 {a b a}", "", false, "replacement-options-4194",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"a b\" \"a b a\" \"<&>\" out];list $n $out",
    "1 {<a b> a}", "", false, "replacement-options-4195",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"a b\" \"a b a\" \"<&>\" out];list $n $out",
    "0 {a b a}", "", false, "replacement-options-4196",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"a b\" \"a b a\" \"<&>\" out];list $n $out",
    "0 {a b a}", "", false, "replacement-options-4197",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"a b\" \"a b a\" \"<&>\" out];list $n $out",
    "0 {a b a}", "", false, "replacement-options-4198",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"a b\" \"a b a\" \"<&>\" out];list $n $out",
    "1 {<a b> a}", "", false, "replacement-options-4199",
  )
}

///|
test "Tcl regexp cases 4201 through 4240" {
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"a b\" \"ABC\" \"X\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4200",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"a b\" \"ABC\" \"X\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4201",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"a b\" \"ABC\" \"X\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4202",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"a b\" \"ABC\" \"X\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4203",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"a b\" \"ABC\" \"X\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4204",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"a b\" \"ABC\" \"X\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4205",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"a b\" \"ABC\" \"<&>\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4206",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"a b\" \"ABC\" \"<&>\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4207",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"a b\" \"ABC\" \"<&>\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4208",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"a b\" \"ABC\" \"<&>\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4209",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"a b\" \"ABC\" \"<&>\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4210",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"a b\" \"ABC\" \"<&>\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4211",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"a b\" \"ab\\nab\" \"X\" out];list $n $out",
    "0 {ab\nab}", "", false, "replacement-options-4212",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"a b\" \"ab\\nab\" \"X\" out];list $n $out",
    "0 {ab\nab}", "", false, "replacement-options-4213",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"a b\" \"ab\\nab\" \"X\" out];list $n $out",
    "0 {ab\nab}", "", false, "replacement-options-4214",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"a b\" \"ab\\nab\" \"X\" out];list $n $out",
    "0 {ab\nab}", "", false, "replacement-options-4215",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"a b\" \"ab\\nab\" \"X\" out];list $n $out",
    "0 {ab\nab}", "", false, "replacement-options-4216",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"a b\" \"ab\\nab\" \"X\" out];list $n $out",
    "0 {ab\nab}", "", false, "replacement-options-4217",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"a b\" \"ab\\nab\" \"<&>\" out];list $n $out",
    "2 {<ab>\n<ab>}", "", false, "replacement-options-4218",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"a b\" \"ab\\nab\" \"<&>\" out];list $n $out",
    "0 {ab\nab}", "", false, "replacement-options-4219",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"a b\" \"ab\\nab\" \"<&>\" out];list $n $out",
    "0 {ab\nab}", "", false, "replacement-options-4220",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"a b\" \"ab\\nab\" \"<&>\" out];list $n $out",
    "0 {ab\nab}", "", false, "replacement-options-4221",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"a b\" \"ab\\nab\" \"<&>\" out];list $n $out",
    "0 {ab\nab}", "", false, "replacement-options-4222",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"a b\" \"ab\\nab\" \"<&>\" out];list $n $out",
    "0 {ab\nab}", "", false, "replacement-options-4223",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"a b\" \"鈩猭K\" \"X\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4224",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"a b\" \"鈩猭K\" \"X\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4225",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"a b\" \"鈩猭K\" \"X\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4226",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"a b\" \"鈩猭K\" \"X\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4227",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"a b\" \"鈩猭K\" \"X\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4228",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"a b\" \"鈩猭K\" \"X\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4229",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"a b\" \"鈩猭K\" \"<&>\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4230",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"a b\" \"鈩猭K\" \"<&>\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4231",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"a b\" \"鈩猭K\" \"<&>\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4232",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"a b\" \"鈩猭K\" \"<&>\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4233",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"a b\" \"鈩猭K\" \"<&>\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4234",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"a b\" \"鈩猭K\" \"<&>\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4235",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"a b\" \"姹夊瓧\" \"X\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4236",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"a b\" \"姹夊瓧\" \"X\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4237",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"a b\" \"姹夊瓧\" \"X\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4238",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"a b\" \"姹夊瓧\" \"X\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4239",
  )
}

///|
test "Tcl regexp cases 4241 through 4280" {
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"a b\" \"姹夊瓧\" \"X\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4240",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"a b\" \"姹夊瓧\" \"X\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4241",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"a b\" \"姹夊瓧\" \"<&>\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4242",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"a b\" \"姹夊瓧\" \"<&>\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4243",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"a b\" \"姹夊瓧\" \"<&>\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4244",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"a b\" \"姹夊瓧\" \"<&>\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4245",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"a b\" \"姹夊瓧\" \"<&>\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4246",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"a b\" \"姹夊瓧\" \"<&>\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4247",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"\\\\w+\" \"\" \"X\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4248",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"\\\\w+\" \"\" \"X\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4249",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"\\\\w+\" \"\" \"X\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4250",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"\\\\w+\" \"\" \"X\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4251",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"\\\\w+\" \"\" \"X\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4252",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"\\\\w+\" \"\" \"X\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4253",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"\\\\w+\" \"\" \"<&>\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4254",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"\\\\w+\" \"\" \"<&>\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4255",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"\\\\w+\" \"\" \"<&>\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4256",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"\\\\w+\" \"\" \"<&>\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4257",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"\\\\w+\" \"\" \"<&>\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4258",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"\\\\w+\" \"\" \"<&>\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4259",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"\\\\w+\" \"a b a\" \"X\" out];list $n $out",
    "3 {X X X}", "", false, "replacement-options-4260",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"\\\\w+\" \"a b a\" \"X\" out];list $n $out",
    "3 {X X X}", "", false, "replacement-options-4261",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"\\\\w+\" \"a b a\" \"X\" out];list $n $out",
    "2 {a X X}", "", false, "replacement-options-4262",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"\\\\w+\" \"a b a\" \"X\" out];list $n $out",
    "0 {a b a}", "", false, "replacement-options-4263",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"\\\\w+\" \"a b a\" \"X\" out];list $n $out",
    "0 {a b a}", "", false, "replacement-options-4264",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"\\\\w+\" \"a b a\" \"X\" out];list $n $out",
    "3 {X X X}", "", false, "replacement-options-4265",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"\\\\w+\" \"a b a\" \"<&>\" out];list $n $out",
    "3 {<a> <b> <a>}", "", false, "replacement-options-4266",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"\\\\w+\" \"a b a\" \"<&>\" out];list $n $out",
    "3 {<a> <b> <a>}", "", false, "replacement-options-4267",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"\\\\w+\" \"a b a\" \"<&>\" out];list $n $out",
    "2 {a <b> <a>}", "", false, "replacement-options-4268",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"\\\\w+\" \"a b a\" \"<&>\" out];list $n $out",
    "0 {a b a}", "", false, "replacement-options-4269",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"\\\\w+\" \"a b a\" \"<&>\" out];list $n $out",
    "0 {a b a}", "", false, "replacement-options-4270",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"\\\\w+\" \"a b a\" \"<&>\" out];list $n $out",
    "3 {<a> <b> <a>}", "", false, "replacement-options-4271",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"\\\\w+\" \"ABC\" \"X\" out];list $n $out",
    "1 X", "", false, "replacement-options-4272",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"\\\\w+\" \"ABC\" \"X\" out];list $n $out",
    "1 X", "", false, "replacement-options-4273",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"\\\\w+\" \"ABC\" \"X\" out];list $n $out",
    "1 AX", "", false, "replacement-options-4274",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"\\\\w+\" \"ABC\" \"X\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4275",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"\\\\w+\" \"ABC\" \"X\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4276",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"\\\\w+\" \"ABC\" \"X\" out];list $n $out",
    "1 X", "", false, "replacement-options-4277",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"\\\\w+\" \"ABC\" \"<&>\" out];list $n $out",
    "1 <ABC>", "", false, "replacement-options-4278",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"\\\\w+\" \"ABC\" \"<&>\" out];list $n $out",
    "1 <ABC>", "", false, "replacement-options-4279",
  )
}

///|
test "Tcl regexp cases 4281 through 4320" {
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"\\\\w+\" \"ABC\" \"<&>\" out];list $n $out",
    "1 A<BC>", "", false, "replacement-options-4280",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"\\\\w+\" \"ABC\" \"<&>\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4281",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"\\\\w+\" \"ABC\" \"<&>\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4282",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"\\\\w+\" \"ABC\" \"<&>\" out];list $n $out",
    "1 <ABC>", "", false, "replacement-options-4283",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"\\\\w+\" \"ab\\nab\" \"X\" out];list $n $out",
    "2 {X\nX}", "", false, "replacement-options-4284",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"\\\\w+\" \"ab\\nab\" \"X\" out];list $n $out",
    "2 {X\nX}", "", false, "replacement-options-4285",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"\\\\w+\" \"ab\\nab\" \"X\" out];list $n $out",
    "2 {aX\nX}", "", false, "replacement-options-4286",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"\\\\w+\" \"ab\\nab\" \"X\" out];list $n $out",
    "0 {ab\nab}", "", false, "replacement-options-4287",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"\\\\w+\" \"ab\\nab\" \"X\" out];list $n $out",
    "0 {ab\nab}", "", false, "replacement-options-4288",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"\\\\w+\" \"ab\\nab\" \"X\" out];list $n $out",
    "2 {X\nX}", "", false, "replacement-options-4289",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"\\\\w+\" \"ab\\nab\" \"<&>\" out];list $n $out",
    "2 {<ab>\n<ab>}", "", false, "replacement-options-4290",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"\\\\w+\" \"ab\\nab\" \"<&>\" out];list $n $out",
    "2 {<ab>\n<ab>}", "", false, "replacement-options-4291",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"\\\\w+\" \"ab\\nab\" \"<&>\" out];list $n $out",
    "2 {a<b>\n<ab>}", "", false, "replacement-options-4292",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"\\\\w+\" \"ab\\nab\" \"<&>\" out];list $n $out",
    "0 {ab\nab}", "", false, "replacement-options-4293",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"\\\\w+\" \"ab\\nab\" \"<&>\" out];list $n $out",
    "0 {ab\nab}", "", false, "replacement-options-4294",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"\\\\w+\" \"ab\\nab\" \"<&>\" out];list $n $out",
    "2 {<ab>\n<ab>}", "", false, "replacement-options-4295",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"\\\\w+\" \"鈩猭K\" \"X\" out];list $n $out",
    "1 X", "", false, "replacement-options-4296",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"\\\\w+\" \"鈩猭K\" \"X\" out];list $n $out",
    "1 X", "", false, "replacement-options-4297",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"\\\\w+\" \"鈩猭K\" \"X\" out];list $n $out",
    "1 鈩X", "", false, "replacement-options-4298",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"\\\\w+\" \"鈩猭K\" \"X\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4299",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"\\\\w+\" \"鈩猭K\" \"X\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4300",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"\\\\w+\" \"鈩猭K\" \"X\" out];list $n $out",
    "1 X", "", false, "replacement-options-4301",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"\\\\w+\" \"鈩猭K\" \"<&>\" out];list $n $out",
    "1 <鈩猭K>", "", false, "replacement-options-4302",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"\\\\w+\" \"鈩猭K\" \"<&>\" out];list $n $out",
    "1 <鈩猭K>", "", false, "replacement-options-4303",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"\\\\w+\" \"鈩猭K\" \"<&>\" out];list $n $out",
    "1 鈩<猭K>", "", false, "replacement-options-4304",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"\\\\w+\" \"鈩猭K\" \"<&>\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4305",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"\\\\w+\" \"鈩猭K\" \"<&>\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4306",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"\\\\w+\" \"鈩猭K\" \"<&>\" out];list $n $out",
    "1 <鈩猭K>", "", false, "replacement-options-4307",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"\\\\w+\" \"姹夊瓧\" \"X\" out];list $n $out",
    "1 X", "", false, "replacement-options-4308",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"\\\\w+\" \"姹夊瓧\" \"X\" out];list $n $out",
    "1 X", "", false, "replacement-options-4309",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"\\\\w+\" \"姹夊瓧\" \"X\" out];list $n $out",
    "1 姹X", "", false, "replacement-options-4310",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"\\\\w+\" \"姹夊瓧\" \"X\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4311",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"\\\\w+\" \"姹夊瓧\" \"X\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4312",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"\\\\w+\" \"姹夊瓧\" \"X\" out];list $n $out",
    "1 X", "", false, "replacement-options-4313",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"\\\\w+\" \"姹夊瓧\" \"<&>\" out];list $n $out",
    "1 <姹夊瓧>", "", false, "replacement-options-4314",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"\\\\w+\" \"姹夊瓧\" \"<&>\" out];list $n $out",
    "1 <姹夊瓧>", "", false, "replacement-options-4315",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"\\\\w+\" \"姹夊瓧\" \"<&>\" out];list $n $out",
    "1 姹<夊瓧>", "", false, "replacement-options-4316",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"\\\\w+\" \"姹夊瓧\" \"<&>\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4317",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"\\\\w+\" \"姹夊瓧\" \"<&>\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4318",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"\\\\w+\" \"姹夊瓧\" \"<&>\" out];list $n $out",
    "1 <姹夊瓧>", "", false, "replacement-options-4319",
  )
}

///|
test "Tcl regexp cases 4321 through 4360" {
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"\\[a-z\\]+\" \"\" \"X\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4320",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"\\[a-z\\]+\" \"\" \"X\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4321",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"\\[a-z\\]+\" \"\" \"X\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4322",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"\\[a-z\\]+\" \"\" \"X\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4323",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"\\[a-z\\]+\" \"\" \"X\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4324",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"\\[a-z\\]+\" \"\" \"X\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4325",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"\\[a-z\\]+\" \"\" \"<&>\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4326",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"\\[a-z\\]+\" \"\" \"<&>\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4327",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"\\[a-z\\]+\" \"\" \"<&>\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4328",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"\\[a-z\\]+\" \"\" \"<&>\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4329",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"\\[a-z\\]+\" \"\" \"<&>\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4330",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"\\[a-z\\]+\" \"\" \"<&>\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4331",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"\\[a-z\\]+\" \"a b a\" \"X\" out];list $n $out",
    "3 {X X X}", "", false, "replacement-options-4332",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"\\[a-z\\]+\" \"a b a\" \"X\" out];list $n $out",
    "3 {X X X}", "", false, "replacement-options-4333",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"\\[a-z\\]+\" \"a b a\" \"X\" out];list $n $out",
    "2 {a X X}", "", false, "replacement-options-4334",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"\\[a-z\\]+\" \"a b a\" \"X\" out];list $n $out",
    "0 {a b a}", "", false, "replacement-options-4335",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"\\[a-z\\]+\" \"a b a\" \"X\" out];list $n $out",
    "0 {a b a}", "", false, "replacement-options-4336",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"\\[a-z\\]+\" \"a b a\" \"X\" out];list $n $out",
    "3 {X X X}", "", false, "replacement-options-4337",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"\\[a-z\\]+\" \"a b a\" \"<&>\" out];list $n $out",
    "3 {<a> <b> <a>}", "", false, "replacement-options-4338",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"\\[a-z\\]+\" \"a b a\" \"<&>\" out];list $n $out",
    "3 {<a> <b> <a>}", "", false, "replacement-options-4339",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"\\[a-z\\]+\" \"a b a\" \"<&>\" out];list $n $out",
    "2 {a <b> <a>}", "", false, "replacement-options-4340",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"\\[a-z\\]+\" \"a b a\" \"<&>\" out];list $n $out",
    "0 {a b a}", "", false, "replacement-options-4341",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"\\[a-z\\]+\" \"a b a\" \"<&>\" out];list $n $out",
    "0 {a b a}", "", false, "replacement-options-4342",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"\\[a-z\\]+\" \"a b a\" \"<&>\" out];list $n $out",
    "3 {<a> <b> <a>}", "", false, "replacement-options-4343",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"\\[a-z\\]+\" \"ABC\" \"X\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4344",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"\\[a-z\\]+\" \"ABC\" \"X\" out];list $n $out",
    "1 X", "", false, "replacement-options-4345",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"\\[a-z\\]+\" \"ABC\" \"X\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4346",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"\\[a-z\\]+\" \"ABC\" \"X\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4347",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"\\[a-z\\]+\" \"ABC\" \"X\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4348",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"\\[a-z\\]+\" \"ABC\" \"X\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4349",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"\\[a-z\\]+\" \"ABC\" \"<&>\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4350",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"\\[a-z\\]+\" \"ABC\" \"<&>\" out];list $n $out",
    "1 <ABC>", "", false, "replacement-options-4351",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"\\[a-z\\]+\" \"ABC\" \"<&>\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4352",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"\\[a-z\\]+\" \"ABC\" \"<&>\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4353",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"\\[a-z\\]+\" \"ABC\" \"<&>\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4354",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"\\[a-z\\]+\" \"ABC\" \"<&>\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4355",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"\\[a-z\\]+\" \"ab\\nab\" \"X\" out];list $n $out",
    "2 {X\nX}", "", false, "replacement-options-4356",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"\\[a-z\\]+\" \"ab\\nab\" \"X\" out];list $n $out",
    "2 {X\nX}", "", false, "replacement-options-4357",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"\\[a-z\\]+\" \"ab\\nab\" \"X\" out];list $n $out",
    "2 {aX\nX}", "", false, "replacement-options-4358",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"\\[a-z\\]+\" \"ab\\nab\" \"X\" out];list $n $out",
    "0 {ab\nab}", "", false, "replacement-options-4359",
  )
}

///|
test "Tcl regexp cases 4361 through 4400" {
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"\\[a-z\\]+\" \"ab\\nab\" \"X\" out];list $n $out",
    "0 {ab\nab}", "", false, "replacement-options-4360",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"\\[a-z\\]+\" \"ab\\nab\" \"X\" out];list $n $out",
    "2 {X\nX}", "", false, "replacement-options-4361",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"\\[a-z\\]+\" \"ab\\nab\" \"<&>\" out];list $n $out",
    "2 {<ab>\n<ab>}", "", false, "replacement-options-4362",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"\\[a-z\\]+\" \"ab\\nab\" \"<&>\" out];list $n $out",
    "2 {<ab>\n<ab>}", "", false, "replacement-options-4363",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"\\[a-z\\]+\" \"ab\\nab\" \"<&>\" out];list $n $out",
    "2 {a<b>\n<ab>}", "", false, "replacement-options-4364",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"\\[a-z\\]+\" \"ab\\nab\" \"<&>\" out];list $n $out",
    "0 {ab\nab}", "", false, "replacement-options-4365",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"\\[a-z\\]+\" \"ab\\nab\" \"<&>\" out];list $n $out",
    "0 {ab\nab}", "", false, "replacement-options-4366",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"\\[a-z\\]+\" \"ab\\nab\" \"<&>\" out];list $n $out",
    "2 {<ab>\n<ab>}", "", false, "replacement-options-4367",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"\\[a-z\\]+\" \"鈩猭K\" \"X\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4368",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"\\[a-z\\]+\" \"鈩猭K\" \"X\" out];list $n $out",
    "1 鈩猭X", "", false, "replacement-options-4369",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"\\[a-z\\]+\" \"鈩猭K\" \"X\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4370",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"\\[a-z\\]+\" \"鈩猭K\" \"X\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4371",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"\\[a-z\\]+\" \"鈩猭K\" \"X\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4372",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"\\[a-z\\]+\" \"鈩猭K\" \"X\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4373",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"\\[a-z\\]+\" \"鈩猭K\" \"<&>\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4374",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"\\[a-z\\]+\" \"鈩猭K\" \"<&>\" out];list $n $out",
    "1 鈩猭<K>", "", false, "replacement-options-4375",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"\\[a-z\\]+\" \"鈩猭K\" \"<&>\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4376",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"\\[a-z\\]+\" \"鈩猭K\" \"<&>\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4377",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"\\[a-z\\]+\" \"鈩猭K\" \"<&>\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4378",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"\\[a-z\\]+\" \"鈩猭K\" \"<&>\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4379",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"\\[a-z\\]+\" \"姹夊瓧\" \"X\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4380",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"\\[a-z\\]+\" \"姹夊瓧\" \"X\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4381",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"\\[a-z\\]+\" \"姹夊瓧\" \"X\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4382",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"\\[a-z\\]+\" \"姹夊瓧\" \"X\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4383",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"\\[a-z\\]+\" \"姹夊瓧\" \"X\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4384",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"\\[a-z\\]+\" \"姹夊瓧\" \"X\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4385",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"\\[a-z\\]+\" \"姹夊瓧\" \"<&>\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4386",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"\\[a-z\\]+\" \"姹夊瓧\" \"<&>\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4387",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"\\[a-z\\]+\" \"姹夊瓧\" \"<&>\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4388",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"\\[a-z\\]+\" \"姹夊瓧\" \"<&>\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4389",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"\\[a-z\\]+\" \"姹夊瓧\" \"<&>\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4390",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"\\[a-z\\]+\" \"姹夊瓧\" \"<&>\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4391",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"(a)\" \"\" \"X\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4392",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"(a)\" \"\" \"X\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4393",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"(a)\" \"\" \"X\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4394",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"(a)\" \"\" \"X\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4395",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"(a)\" \"\" \"X\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4396",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"(a)\" \"\" \"X\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4397",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"(a)\" \"\" \"<&>\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4398",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"(a)\" \"\" \"<&>\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4399",
  )
}

///|
test "Tcl regexp cases 4401 through 4440" {
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"(a)\" \"\" \"<&>\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4400",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"(a)\" \"\" \"<&>\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4401",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"(a)\" \"\" \"<&>\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4402",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"(a)\" \"\" \"<&>\" out];list $n $out",
    "0 {}", "", false, "replacement-options-4403",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"(a)\" \"a b a\" \"X\" out];list $n $out",
    "2 {X b X}", "", false, "replacement-options-4404",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"(a)\" \"a b a\" \"X\" out];list $n $out",
    "2 {X b X}", "", false, "replacement-options-4405",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"(a)\" \"a b a\" \"X\" out];list $n $out",
    "1 {a b X}", "", false, "replacement-options-4406",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"(a)\" \"a b a\" \"X\" out];list $n $out",
    "0 {a b a}", "", false, "replacement-options-4407",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"(a)\" \"a b a\" \"X\" out];list $n $out",
    "0 {a b a}", "", false, "replacement-options-4408",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"(a)\" \"a b a\" \"X\" out];list $n $out",
    "2 {X b X}", "", false, "replacement-options-4409",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"(a)\" \"a b a\" \"<&>\" out];list $n $out",
    "2 {<a> b <a>}", "", false, "replacement-options-4410",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"(a)\" \"a b a\" \"<&>\" out];list $n $out",
    "2 {<a> b <a>}", "", false, "replacement-options-4411",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"(a)\" \"a b a\" \"<&>\" out];list $n $out",
    "1 {a b <a>}", "", false, "replacement-options-4412",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"(a)\" \"a b a\" \"<&>\" out];list $n $out",
    "0 {a b a}", "", false, "replacement-options-4413",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"(a)\" \"a b a\" \"<&>\" out];list $n $out",
    "0 {a b a}", "", false, "replacement-options-4414",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"(a)\" \"a b a\" \"<&>\" out];list $n $out",
    "2 {<a> b <a>}", "", false, "replacement-options-4415",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"(a)\" \"ABC\" \"X\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4416",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"(a)\" \"ABC\" \"X\" out];list $n $out",
    "1 XBC", "", false, "replacement-options-4417",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"(a)\" \"ABC\" \"X\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4418",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"(a)\" \"ABC\" \"X\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4419",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"(a)\" \"ABC\" \"X\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4420",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"(a)\" \"ABC\" \"X\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4421",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"(a)\" \"ABC\" \"<&>\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4422",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"(a)\" \"ABC\" \"<&>\" out];list $n $out",
    "1 <A>BC", "", false, "replacement-options-4423",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"(a)\" \"ABC\" \"<&>\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4424",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"(a)\" \"ABC\" \"<&>\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4425",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"(a)\" \"ABC\" \"<&>\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4426",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"(a)\" \"ABC\" \"<&>\" out];list $n $out",
    "0 ABC", "", false, "replacement-options-4427",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"(a)\" \"ab\\nab\" \"X\" out];list $n $out",
    "2 {Xb\nXb}", "", false, "replacement-options-4428",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"(a)\" \"ab\\nab\" \"X\" out];list $n $out",
    "2 {Xb\nXb}", "", false, "replacement-options-4429",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"(a)\" \"ab\\nab\" \"X\" out];list $n $out",
    "1 {ab\nXb}", "", false, "replacement-options-4430",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"(a)\" \"ab\\nab\" \"X\" out];list $n $out",
    "0 {ab\nab}", "", false, "replacement-options-4431",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"(a)\" \"ab\\nab\" \"X\" out];list $n $out",
    "0 {ab\nab}", "", false, "replacement-options-4432",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"(a)\" \"ab\\nab\" \"X\" out];list $n $out",
    "2 {Xb\nXb}", "", false, "replacement-options-4433",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"(a)\" \"ab\\nab\" \"<&>\" out];list $n $out",
    "2 {<a>b\n<a>b}", "", false, "replacement-options-4434",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"(a)\" \"ab\\nab\" \"<&>\" out];list $n $out",
    "2 {<a>b\n<a>b}", "", false, "replacement-options-4435",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"(a)\" \"ab\\nab\" \"<&>\" out];list $n $out",
    "1 {ab\n<a>b}", "", false, "replacement-options-4436",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"(a)\" \"ab\\nab\" \"<&>\" out];list $n $out",
    "0 {ab\nab}", "", false, "replacement-options-4437",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"(a)\" \"ab\\nab\" \"<&>\" out];list $n $out",
    "0 {ab\nab}", "", false, "replacement-options-4438",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"(a)\" \"ab\\nab\" \"<&>\" out];list $n $out",
    "2 {<a>b\n<a>b}", "", false, "replacement-options-4439",
  )
}

///|
test "Tcl regexp cases 4441 through 4480" {
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"(a)\" \"鈩猭K\" \"X\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4440",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"(a)\" \"鈩猭K\" \"X\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4441",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"(a)\" \"鈩猭K\" \"X\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4442",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"(a)\" \"鈩猭K\" \"X\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4443",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"(a)\" \"鈩猭K\" \"X\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4444",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"(a)\" \"鈩猭K\" \"X\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4445",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"(a)\" \"鈩猭K\" \"<&>\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4446",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"(a)\" \"鈩猭K\" \"<&>\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4447",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"(a)\" \"鈩猭K\" \"<&>\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4448",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"(a)\" \"鈩猭K\" \"<&>\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4449",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"(a)\" \"鈩猭K\" \"<&>\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4450",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"(a)\" \"鈩猭K\" \"<&>\" out];list $n $out",
    "0 鈩猭K", "", false, "replacement-options-4451",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"(a)\" \"姹夊瓧\" \"X\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4452",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"(a)\" \"姹夊瓧\" \"X\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4453",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"(a)\" \"姹夊瓧\" \"X\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4454",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"(a)\" \"姹夊瓧\" \"X\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4455",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"(a)\" \"姹夊瓧\" \"X\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4456",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"(a)\" \"姹夊瓧\" \"X\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4457",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -expanded -- \"(a)\" \"姹夊瓧\" \"<&>\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4458",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -nocase -- \"(a)\" \"姹夊瓧\" \"<&>\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4459",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start 1 -- \"(a)\" \"姹夊瓧\" \"<&>\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4460",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -start end -- \"(a)\" \"姹夊瓧\" \"<&>\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4461",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -start 100 -- \"(a)\" \"姹夊瓧\" \"<&>\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4462",
  )
  check_regexp_case(
    "set out OLD;set n [regsub -all -line -- \"(a)\" \"姹夊瓧\" \"<&>\" out];list $n $out",
    "0 姹夊瓧", "", false, "replacement-options-4463",
  )
  check_regexp_case(
    "catch {regexp} r o;list $r [dict get $o -code] [dict get $o -level] [dict get $o -errorcode]",
    "{wrong # args: should be \"regexp ?-option ...? exp string ?matchVar? ?subMatchVar ...?\"} 1 0 {TCL WRONGARGS}",
    "", false, "command-errors-4464",
  )
  check_regexp_case(
    "catch {regexp a} r o;list $r [dict get $o -code] [dict get $o -level] [dict get $o -errorcode]",
    "{wrong # args: should be \"regexp ?-option ...? exp string ?matchVar? ?subMatchVar ...?\"} 1 0 {TCL WRONGARGS}",
    "", false, "command-errors-4465",
  )
  check_regexp_case(
    "catch {regexp -start} r o;list $r [dict get $o -code] [dict get $o -level] [dict get $o -errorcode]",
    "{wrong # args: should be \"regexp ?-option ...? exp string ?matchVar? ?subMatchVar ...?\"} 1 0 {TCL WRONGARGS}",
    "", false, "command-errors-4466",
  )
  check_regexp_case(
    "catch {regexp -start 0} r o;list $r [dict get $o -code] [dict get $o -level] [dict get $o -errorcode]",
    "{wrong # args: should be \"regexp ?-option ...? exp string ?matchVar? ?subMatchVar ...?\"} 1 0 {TCL WRONGARGS}",
    "", false, "command-errors-4467",
  )
  check_regexp_case(
    "catch {regexp -about} r o;list $r [dict get $o -code] [dict get $o -level] [dict get $o -errorcode]",
    "{wrong # args: should be \"regexp ?-option ...? exp string ?matchVar? ?subMatchVar ...?\"} 1 0 {TCL WRONGARGS}",
    "", false, "command-errors-4468",
  )
  check_regexp_case(
    "catch {regexp -inline -about a} r o;list $r [dict get $o -code] [dict get $o -level] [dict get $o -errorcode]",
    "{regexp match variables not allowed when using -inline} 1 0 {TCL OPERATION REGEXP MIX_VAR_INLINE}",
    "", false, "command-errors-4469",
  )
  check_regexp_case(
    "catch {regexp -inline a a v} r o;list $r [dict get $o -code] [dict get $o -level] [dict get $o -errorcode]",
    "{regexp match variables not allowed when using -inline} 1 0 {TCL OPERATION REGEXP MIX_VAR_INLINE}",
    "", false, "command-errors-4470",
  )
  check_regexp_case(
    "catch {regexp -inline -about a b c} r o;list $r [dict get $o -code] [dict get $o -level] [dict get $o -errorcode]",
    "{regexp match variables not allowed when using -inline} 1 0 {TCL OPERATION REGEXP MIX_VAR_INLINE}",
    "", false, "command-errors-4471",
  )
  check_regexp_case(
    "catch {regexp -a a a} r o;list $r [dict get $o -code] [dict get $o -level] [dict get $o -errorcode]",
    "{bad option \"-a\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --} 1 0 {TCL LOOKUP INDEX option -a}",
    "", false, "command-errors-4472",
  )
  check_regexp_case(
    "catch {regexp -i a a} r o;list $r [dict get $o -code] [dict get $o -level] [dict get $o -errorcode]",
    "{bad option \"-i\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --} 1 0 {TCL LOOKUP INDEX option -i}",
    "", false, "command-errors-4473",
  )
  check_regexp_case(
    "catch {regexp -bad a a} r o;list $r [dict get $o -code] [dict get $o -level] [dict get $o -errorcode]",
    "{bad option \"-bad\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --} 1 0 {TCL LOOKUP INDEX option -bad}",
    "", false, "command-errors-4474",
  )
  check_regexp_case(
    "catch {regexp - a a} r o;list $r [dict get $o -code] [dict get $o -level] [dict get $o -errorcode]",
    "{bad option \"-\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --} 1 0 {TCL LOOKUP INDEX option -}",
    "", false, "command-errors-4475",
  )
  check_regexp_case(
    "catch {regexp --} r o;list $r [dict get $o -code] [dict get $o -level] [dict get $o -errorcode]",
    "{wrong # args: should be \"regexp ?-option ...? exp string ?matchVar? ?subMatchVar ...?\"} 1 0 {TCL WRONGARGS}",
    "", false, "command-errors-4476",
  )
  check_regexp_case(
    "catch {regexp -- -a -a} r o;list $r [dict get $o -code] [dict get $o -level] [dict get $o -errorcode]",
    "key \"-errorcode\" not known in dictionary", "", true, "command-errors-4477",
  )
  check_regexp_case(
    "catch {regsub} r o;list $r [dict get $o -code] [dict get $o -level] [dict get $o -errorcode]",
    "{wrong # args: should be \"regsub ?-option ...? exp string subSpec ?varName?\"} 1 0 {TCL WRONGARGS}",
    "", false, "command-errors-4478",
  )
  check_regexp_case(
    "catch {regsub a} r o;list $r [dict get $o -code] [dict get $o -level] [dict get $o -errorcode]",
    "{wrong # args: should be \"regsub ?-option ...? exp string subSpec ?varName?\"} 1 0 {TCL WRONGARGS}",
    "", false, "command-errors-4479",
  )
}

///|
test "Tcl regexp cases 4481 through 4520" {
  check_regexp_case(
    "catch {regsub a a} r o;list $r [dict get $o -code] [dict get $o -level] [dict get $o -errorcode]",
    "{wrong # args: should be \"regsub ?-option ...? exp string subSpec ?varName?\"} 1 0 {TCL WRONGARGS}",
    "", false, "command-errors-4480",
  )
  check_regexp_case(
    "catch {regsub a a x v w} r o;list $r [dict get $o -code] [dict get $o -level] [dict get $o -errorcode]",
    "{wrong # args: should be \"regsub ?-option ...? exp string subSpec ?varName?\"} 1 0 {TCL WRONGARGS}",
    "", false, "command-errors-4481",
  )
  check_regexp_case(
    "catch {regsub -a a a x} r o;list $r [dict get $o -code] [dict get $o -level] [dict get $o -errorcode]",
    "{bad option \"-a\": must be -all, -nocase, -expanded, -line, -linestop, -lineanchor, -start, or --} 1 0 {TCL LOOKUP INDEX option -a}",
    "", false, "command-errors-4482",
  )
  check_regexp_case(
    "catch {regsub -about a a x} r o;list $r [dict get $o -code] [dict get $o -level] [dict get $o -errorcode]",
    "{bad option \"-about\": must be -all, -nocase, -expanded, -line, -linestop, -lineanchor, -start, or --} 1 0 {TCL LOOKUP INDEX option -about}",
    "", false, "command-errors-4483",
  )
  check_regexp_case(
    "catch {regsub -start} r o;list $r [dict get $o -code] [dict get $o -level] [dict get $o -errorcode]",
    "{wrong # args: should be \"regsub ?-option ...? exp string subSpec ?varName?\"} 1 0 {TCL WRONGARGS}",
    "", false, "command-errors-4484",
  )
  check_regexp_case(
    "catch {regsub -start bad} r o;list $r [dict get $o -code] [dict get $o -level] [dict get $o -errorcode]",
    "{bad index \"bad\": must be integer?[+-]integer? or end?[+-]integer?} 1 0 {TCL VALUE INDEX}",
    "", false, "command-errors-4485",
  )
  check_regexp_case(
    "catch {regsub -start 0} r o;list $r [dict get $o -code] [dict get $o -level] [dict get $o -errorcode]",
    "{wrong # args: should be \"regsub ?-option ...? exp string subSpec ?varName?\"} 1 0 {TCL WRONGARGS}",
    "", false, "command-errors-4486",
  )
  check_regexp_case(
    "catch {regexp -start bad} r o;list $r [dict get $o -code] [dict get $o -level] [dict get $o -errorcode]",
    "{bad index \"bad\": must be integer?[+-]integer? or end?[+-]integer?} 1 0 {TCL VALUE INDEX}",
    "", false, "command-errors-4487",
  )
  check_regexp_case(
    "catch {regexp -start bad a a} r o;list $r [dict get $o -code] [dict get $o -level] [dict get $o -errorcode]",
    "{bad index \"bad\": must be integer?[+-]integer? or end?[+-]integer?} 1 0 {TCL VALUE INDEX}",
    "", false, "command-errors-4488",
  )
  check_regexp_case(
    "catch {regexp -start bad -bad} r o;list $r [dict get $o -code] [dict get $o -level] [dict get $o -errorcode]",
    "{bad index \"bad\": must be integer?[+-]integer? or end?[+-]integer?} 1 0 {TCL VALUE INDEX}",
    "", false, "command-errors-4489",
  )
  check_regexp_case(
    "catch {regsub -start bad a a x} r o;list $r [dict get $o -code] [dict get $o -level] [dict get $o -errorcode]",
    "{bad index \"bad\": must be integer?[+-]integer? or end?[+-]integer?} 1 0 {TCL VALUE INDEX}",
    "", false, "command-errors-4490",
  )
  check_regexp_case(
    "set a OLD;set b OLD;set c OLD;set d OLD;set n [regexp {(a)?(b)} b a b c d];list $n $a $b $c $d",
    "1 b {} b {}", "", false, "state-and-aliases-4491",
  )
  check_regexp_case(
    "set a OLD;set b OLD;set n [regexp -all {(a)} abab a b];list $n $a $b", "2 a a",
    "", false, "state-and-aliases-4492",
  )
  check_regexp_case(
    "set a OLD;set b OLD;set n [regexp {(x)} abc a b];list $n $a $b", "0 OLD OLD",
    "", false, "state-and-aliases-4493",
  )
  check_regexp_case(
    "set v OLD;regexp {(a)(b)} ab v v v;set v", "b", "", false, "state-and-aliases-4494",
  )
  check_regexp_case(
    "set a 0;set b OLD;catch {regexp {(a)} a b a(x)};list $a $b", "0 a", "", false,
    "state-and-aliases-4495",
  )
  check_regexp_case(
    "set a 0;set b OLD;catch {regexp {(a)} a a(x) b};list $a $b", "0 OLD", "", false,
    "state-and-aliases-4496",
  )
  check_regexp_case(
    "set a 0;catch {regsub a aba X a(x)} r;list $a $r", "0 {can't set \"a(x)\": variable isn't array}",
    "", false, "state-and-aliases-4497",
  )
  check_regexp_case(
    "array set a {};regexp -indices {(a)(b?)} a a(m) a(x) a(y);list $a(m) $a(x) $a(y)",
    "{0 0} {0 0} {1 0}", "", false, "state-and-aliases-4498",
  )
  check_regexp_case(
    "proc f {} {regexp {(a)} a m s;list $m $s};f", "a a", "", false, "state-and-aliases-4499",
  )
  check_regexp_case(
    "namespace eval n {variable v 1;proc f {} {variable v;regsub -all a aba X v;set v}};list [n::f] $n::v",
    "XbX XbX", "", false, "state-and-aliases-4500",
  )
  check_regexp_case(
    "proc f {name} {upvar 1 $name dest;regexp a abc dest};set v OLD;list [f v] $v",
    "1 a", "", false, "state-and-aliases-4501",
  )
  check_regexp_case(
    "rename regexp search;search -inline {(a)} abc", "a a", "", false, "state-and-aliases-4502",
  )
  check_regexp_case(
    "rename regsub replace;replace -all a aba X", "XbX", "", false, "state-and-aliases-4503",
  )
  check_regexp_case(
    "regexp -about a ignored extra arguments", "0 {}", "", false, "state-and-aliases-4504",
  )
  check_regexp_case(
    "regexp -inline -about a ignored", "0 {}", "", false, "state-and-aliases-4505",
  )
  check_regexp_case(
    "scan 18446744073709551616 %f v;regexp .* $v;format %.17g $v", "1.844674407370955e+19",
    "", false, "numeric-representation-4506",
  )
  check_regexp_case(
    "scan 18446744073709551616 %f v;regexp $v x;format %.17g $v", "1.844674407370955e+19",
    "", false, "numeric-representation-4507",
  )
  check_regexp_case(
    "scan 18446744073709551616 %f v;regsub x $v y;format %.17g $v", "1.844674407370955e+19",
    "", false, "numeric-representation-4508",
  )
  check_regexp_case(
    "scan 18446744073709551616 %f v;regsub -all x $v y;format %.17g $v", "1.844674407370955e+19",
    "", false, "numeric-representation-4509",
  )
  check_regexp_case(
    "scan 18446744073709551616 %f v;regsub -all {} $v y;format %.17g $v", "1.844674407370955e+19",
    "", false, "numeric-representation-4510",
  )
  check_regexp_case(
    "scan 18446744073709551616 %f v;regsub $v x y;format %.17g $v", "1.844674407370955e+19",
    "", false, "numeric-representation-4511",
  )
  check_regexp_case(
    "scan 18446744073709551616 %f v;regsub x y $v;format %.17g $v", "1.844674407370955e+19",
    "", false, "numeric-representation-4512",
  )
  check_regexp_case(
    "scan 18446744073709551616 %f v;regexp -about $v;format %.17g $v", "1.844674407370955e+19",
    "", false, "numeric-representation-4513",
  )
  check_regexp_case(
    "scan 18446744073709551616 %f v;catch {regexp {(} $v};format %.17g $v", "1.8446744073709552e+19",
    "", false, "numeric-representation-4514",
  )
  check_regexp_case(
    "scan 18446744073709551616 %f v;catch {regsub {(} $v x};format %.17g $v", "1.8446744073709552e+19",
    "", false, "numeric-representation-4515",
  )
  check_regexp_case(
    "regexp -about  -- \"\"", "0 {REG_UUNSPEC REG_UEMPTYMATCH}", "", false, "about-4516",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"\"", "0 {REG_UUNSPEC REG_UEMPTYMATCH}", "", false,
    "about-4517",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"\"", "0 {REG_UUNSPEC REG_UEMPTYMATCH}", "", false,
    "about-4518",
  )
  check_regexp_case("regexp -about  -- \"a\"", "0 {}", "", false, "about-4519")
}

///|
test "Tcl regexp cases 4521 through 4560" {
  check_regexp_case(
    "regexp -about -nocase -- \"a\"", "0 {}", "", false, "about-4520",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"a\"", "0 {}", "", false, "about-4521",
  )
  check_regexp_case(
    "regexp -about  -- \"a*\"", "0 REG_UEMPTYMATCH", "", false, "about-4522",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"a*\"", "0 REG_UEMPTYMATCH", "", false, "about-4523",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"a*\"", "0 REG_UEMPTYMATCH", "", false, "about-4524",
  )
  check_regexp_case(
    "regexp -about  -- \"a+?\"", "0 {REG_UNONPOSIX REG_USHORTEST}", "", false, "about-4525",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"a+?\"", "0 {REG_UNONPOSIX REG_USHORTEST}", "", false,
    "about-4526",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"a+?\"", "0 {REG_UNONPOSIX REG_USHORTEST}", "",
    false, "about-4527",
  )
  check_regexp_case(
    "regexp -about  -- \"a{1}\"", "0 REG_UBOUNDS", "", false, "about-4528",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"a{1}\"", "0 REG_UBOUNDS", "", false, "about-4529",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"a{1}\"", "0 REG_UBOUNDS", "", false, "about-4530",
  )
  check_regexp_case(
    "regexp -about  -- \"a{0}\"", "0 {REG_UBOUNDS REG_UEMPTYMATCH}", "", false, "about-4531",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"a{0}\"", "0 {REG_UBOUNDS REG_UEMPTYMATCH}", "", false,
    "about-4532",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"a{0}\"", "0 {REG_UBOUNDS REG_UEMPTYMATCH}", "",
    false, "about-4533",
  )
  check_regexp_case(
    "regexp -about  -- \"a{1,2}\"", "0 REG_UBOUNDS", "", false, "about-4534",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"a{1,2}\"", "0 REG_UBOUNDS", "", false, "about-4535",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"a{1,2}\"", "0 REG_UBOUNDS", "", false, "about-4536",
  )
  check_regexp_case(
    "regexp -about  -- \"{}\"", "0 {REG_UBRACES REG_UUNSPEC}", "", false, "about-4537",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"{}\"", "0 {REG_UBRACES REG_UUNSPEC}", "", false,
    "about-4538",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"{}\"", "0 {REG_UBRACES REG_UUNSPEC}", "", false,
    "about-4539",
  )
  check_regexp_case(
    "regexp -about  -- \"{a}\"", "0 {REG_UBRACES REG_UUNSPEC}", "", false, "about-4540",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"{a}\"", "0 {REG_UBRACES REG_UUNSPEC}", "", false,
    "about-4541",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"{a}\"", "0 {REG_UBRACES REG_UUNSPEC}", "", false,
    "about-4542",
  )
  check_regexp_case(
    "regexp -about  -- \"a{\"", "0 {REG_UBRACES REG_UUNSPEC}", "", false, "about-4543",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"a{\"", "0 {REG_UBRACES REG_UUNSPEC}", "", false,
    "about-4544",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"a{\"", "0 {REG_UBRACES REG_UUNSPEC}", "", false,
    "about-4545",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[a-z\\]\"", "0 REG_UUNPORT", "", false, "about-4546",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"\\[a-z\\]\"", "0 REG_UUNPORT", "", false, "about-4547",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"\\[a-z\\]\"", "0 REG_UUNPORT", "", false, "about-4548",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[a-a\\]\"", "0 {}", "", false, "about-4549",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"\\[a-a\\]\"", "0 {}", "", false, "about-4550",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"\\[a-a\\]\"", "0 {}", "", false, "about-4551",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[abc\\]\"", "0 {}", "", false, "about-4552",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"\\[abc\\]\"", "0 {}", "", false, "about-4553",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"\\[abc\\]\"", "0 {}", "", false, "about-4554",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[\\[.a.\\]\\]\"", "0 {}", "", false, "about-4555",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"\\[\\[.a.\\]\\]\"", "0 {}", "", false, "about-4556",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"\\[\\[.a.\\]\\]\"", "0 {}", "", false, "about-4557",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[^a\\]\"", "0 {}", "", false, "about-4558",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"\\[^a\\]\"", "0 {}", "", false, "about-4559",
  )
}

///|
test "Tcl regexp cases 4561 through 4600" {
  check_regexp_case(
    "regexp -about -expanded -- \"\\[^a\\]\"", "0 {}", "", false, "about-4560",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[a-\\]\"", "0 {}", "", false, "about-4561",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"\\[a-\\]\"", "0 {}", "", false, "about-4562",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"\\[a-\\]\"", "0 {}", "", false, "about-4563",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[-a\\]\"", "0 {}", "", false, "about-4564",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"\\[-a\\]\"", "0 {}", "", false, "about-4565",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"\\[-a\\]\"", "0 {}", "", false, "about-4566",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[\\[:alpha:\\]\\]\"", "0 REG_ULOCALE", "", false, "about-4567",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"\\[\\[:alpha:\\]\\]\"", "0 REG_ULOCALE", "", false,
    "about-4568",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"\\[\\[:alpha:\\]\\]\"", "0 REG_ULOCALE", "", false,
    "about-4569",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[a\\[:alpha:\\]\\]\"", "0 REG_ULOCALE", "", false, "about-4570",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"\\[a\\[:alpha:\\]\\]\"", "0 REG_ULOCALE", "", false,
    "about-4571",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"\\[a\\[:alpha:\\]\\]\"", "0 REG_ULOCALE", "", false,
    "about-4572",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[\\[=a=\\]\\]\"", "0 REG_ULOCALE", "", false, "about-4573",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"\\[\\[=a=\\]\\]\"", "0 REG_ULOCALE", "", false, "about-4574",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"\\[\\[=a=\\]\\]\"", "0 REG_ULOCALE", "", false,
    "about-4575",
  )
  check_regexp_case(
    "regexp -about  -- \"(a)\"", "1 {}", "", false, "about-4576",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"(a)\"", "1 {}", "", false, "about-4577",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"(a)\"", "1 {}", "", false, "about-4578",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:a)\"", "0 REG_UNONPOSIX", "", false, "about-4579",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"(?:a)\"", "0 REG_UNONPOSIX", "", false, "about-4580",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"(?:a)\"", "0 REG_UNONPOSIX", "", false, "about-4581",
  )
  check_regexp_case(
    "regexp -about  -- \"(a)\\\\1\"", "1 {REG_UBACKREF REG_UNONPOSIX}", "", false,
    "about-4582",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"(a)\\\\1\"", "1 {REG_UBACKREF REG_UNONPOSIX}", "",
    false, "about-4583",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"(a)\\\\1\"", "1 {REG_UBACKREF REG_UNONPOSIX}",
    "", false, "about-4584",
  )
  check_regexp_case(
    "regexp -about  -- \"(a*)\\\\1\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-4585",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"(a*)\\\\1\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-4586",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"(a*)\\\\1\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-4587",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-4588",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "",
    false, "about-4589",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "",
    false, "about-4590",
  )
  check_regexp_case(
    "regexp -about  -- \"(?!a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-4591",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"(?!a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "",
    false, "about-4592",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"(?!a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "",
    false, "about-4593",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-4594",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"(?=)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-4595",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"(?=)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-4596",
  )
  check_regexp_case(
    "regexp -about  -- \"(?!)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-4597",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"(?!)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-4598",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"(?!)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-4599",
  )
}

///|
test "Tcl regexp cases 4601 through 4640" {
  check_regexp_case(
    "regexp -about  -- \"(?!a)a\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-4600",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"(?!a)a\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "",
    false, "about-4601",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"(?!a)a\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-4602",
  )
  check_regexp_case(
    "regexp -about  -- \"a(?=)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-4603",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"a(?=)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-4604",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"a(?=)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-4605",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\d\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false, "about-4606",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"\\\\d\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false,
    "about-4607",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"\\\\d\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "",
    false, "about-4608",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\A\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}", "", false,
    "about-4609",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"\\\\A\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}", "",
    false, "about-4610",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"\\\\A\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-4611",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\m\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-4612",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"\\\\m\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-4613",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"\\\\m\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-4614",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\b\"", "0 REG_UNONPOSIX", "", false, "about-4615",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"\\\\b\"", "0 REG_UNONPOSIX", "", false, "about-4616",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"\\\\b\"", "0 REG_UNONPOSIX", "", false, "about-4617",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\B\"", "0 REG_UNONPOSIX", "", false, "about-4618",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"\\\\B\"", "0 REG_UNONPOSIX", "", false, "about-4619",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"\\\\B\"", "0 REG_UNONPOSIX", "", false, "about-4620",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\cA\"", "0 {REG_UNONPOSIX REG_UUNPORT}", "", false, "about-4621",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"\\\\cA\"", "0 {REG_UNONPOSIX REG_UUNPORT}", "", false,
    "about-4622",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"\\\\cA\"", "0 {REG_UNONPOSIX REG_UUNPORT}", "",
    false, "about-4623",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\x41\"", "0 {REG_UNONPOSIX REG_UUNPORT}", "", false,
    "about-4624",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"\\\\x41\"", "0 {REG_UNONPOSIX REG_UUNPORT}", "",
    false, "about-4625",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"\\\\x41\"", "0 {REG_UNONPOSIX REG_UUNPORT}", "",
    false, "about-4626",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\141\"", "0 {REG_UNONPOSIX REG_UUNPORT}", "", false,
    "about-4627",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"\\\\141\"", "0 {REG_UNONPOSIX REG_UUNPORT}", "",
    false, "about-4628",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"\\\\141\"", "0 {REG_UNONPOSIX REG_UUNPORT}", "",
    false, "about-4629",
  )
  check_regexp_case(
    "regexp -about  -- \"a(?#x)b\"", "0 REG_UNONPOSIX", "", false, "about-4630",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"a(?#x)b\"", "0 REG_UNONPOSIX", "", false, "about-4631",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"a(?#x)b\"", "0 REG_UNONPOSIX", "", false, "about-4632",
  )
  check_regexp_case(
    "regexp -about  -- \"(?i)a\"", "0 REG_UNONPOSIX", "", false, "about-4633",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"(?i)a\"", "0 REG_UNONPOSIX", "", false, "about-4634",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"(?i)a\"", "0 REG_UNONPOSIX", "", false, "about-4635",
  )
  check_regexp_case(
    "regexp -about  -- \"(?n)a\"", "0 REG_UNONPOSIX", "", false, "about-4636",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"(?n)a\"", "0 REG_UNONPOSIX", "", false, "about-4637",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"(?n)a\"", "0 REG_UNONPOSIX", "", false, "about-4638",
  )
  check_regexp_case(
    "regexp -about  -- \"(?x)a b\"", "0 REG_UNONPOSIX", "", false, "about-4639",
  )
}

///|
test "Tcl regexp cases 4641 through 4680" {
  check_regexp_case(
    "regexp -about -nocase -- \"(?x)a b\"", "0 REG_UNONPOSIX", "", false, "about-4640",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"(?x)a b\"", "0 REG_UNONPOSIX", "", false, "about-4641",
  )
  check_regexp_case(
    "regexp -about  -- \"(?e)a\"", "0 REG_UNONPOSIX", "", false, "about-4642",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"(?e)a\"", "0 REG_UNONPOSIX", "", false, "about-4643",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"(?e)a\"", "0 REG_UNONPOSIX", "", false, "about-4644",
  )
  check_regexp_case(
    "regexp -about  -- \"(?b)a\"", "0 REG_UNONPOSIX", "", false, "about-4645",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"(?b)a\"", "0 REG_UNONPOSIX", "", false, "about-4646",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"(?b)a\"", "0 REG_UNONPOSIX", "", false, "about-4647",
  )
  check_regexp_case(
    "regexp -about  -- \"(?q)a\"", "0 REG_UNONPOSIX", "", false, "about-4648",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"(?q)a\"", "0 REG_UNONPOSIX", "", false, "about-4649",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"(?q)a\"", "0 REG_UNONPOSIX", "", false, "about-4650",
  )
  check_regexp_case(
    "regexp -about  -- \"***=a.b\"", "0 REG_UNONPOSIX", "", false, "about-4651",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"***=a.b\"", "0 REG_UNONPOSIX", "", false, "about-4652",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"***=a.b\"", "0 REG_UNONPOSIX", "", false, "about-4653",
  )
  check_regexp_case(
    "regexp -about  -- \"a^\"", "0 REG_UIMPOSSIBLE", "", false, "about-4654",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"a^\"", "0 REG_UIMPOSSIBLE", "", false, "about-4655",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"a^\"", "0 REG_UIMPOSSIBLE", "", false, "about-4656",
  )
  check_regexp_case(
    "regexp -about  -- \"a\\$b\"", "0 REG_UIMPOSSIBLE", "", false, "about-4657",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"a\\$b\"", "0 REG_UIMPOSSIBLE", "", false, "about-4658",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"a\\$b\"", "0 REG_UIMPOSSIBLE", "", false, "about-4659",
  )
  check_regexp_case(
    "regexp -about  -- \"^\\$\"", "0 REG_UEMPTYMATCH", "", false, "about-4660",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"^\\$\"", "0 REG_UEMPTYMATCH", "", false, "about-4661",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"^\\$\"", "0 REG_UEMPTYMATCH", "", false, "about-4662",
  )
  check_regexp_case(
    "regexp -about  -- \"^a\\$\"", "0 {}", "", false, "about-4663",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"^a\\$\"", "0 {}", "", false, "about-4664",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"^a\\$\"", "0 {}", "", false, "about-4665",
  )
  check_regexp_case(
    "regexp -about  -- \"(?e)\\\\d\"", "0 {REG_UBSALNUM REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-4666",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"(?e)\\\\d\"", "0 {REG_UBSALNUM REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-4667",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"(?e)\\\\d\"", "0 {REG_UBSALNUM REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-4668",
  )
  check_regexp_case(
    "regexp -about  -- \"(?e)\\[\\\\d\\]\"", "0 {REG_UBBS REG_UNONPOSIX}", "", false,
    "about-4669",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"(?e)\\[\\\\d\\]\"", "0 {REG_UBBS REG_UNONPOSIX}",
    "", false, "about-4670",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"(?e)\\[\\\\d\\]\"", "0 {REG_UBBS REG_UNONPOSIX}",
    "", false, "about-4671",
  )
  check_regexp_case(
    "regexp -about  -- \"(?b)\\\\(a\\\\)\\\\1\"", "1 {REG_UBACKREF REG_UNONPOSIX}",
    "", false, "about-4672",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"(?b)\\\\(a\\\\)\\\\1\"", "1 {REG_UBACKREF REG_UNONPOSIX}",
    "", false, "about-4673",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"(?b)\\\\(a\\\\)\\\\1\"", "1 {REG_UBACKREF REG_UNONPOSIX}",
    "", false, "about-4674",
  )
  check_regexp_case(
    "regexp -about  -- \"(?b)*\"", "0 REG_UNONPOSIX", "", false, "about-4675",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"(?b)*\"", "0 REG_UNONPOSIX", "", false, "about-4676",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"(?b)*\"", "0 REG_UNONPOSIX", "", false, "about-4677",
  )
  check_regexp_case(
    "regexp -about  -- \"(?b)a^\"", "0 REG_UNONPOSIX", "", false, "about-4678",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"(?b)a^\"", "0 REG_UNONPOSIX", "", false, "about-4679",
  )
}

///|
test "Tcl regexp cases 4681 through 4720" {
  check_regexp_case(
    "regexp -about -expanded -- \"(?b)a^\"", "0 REG_UNONPOSIX", "", false, "about-4680",
  )
  check_regexp_case(
    "regexp -about  -- \"(?b)a\\$b\"", "0 REG_UNONPOSIX", "", false, "about-4681",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"(?b)a\\$b\"", "0 REG_UNONPOSIX", "", false, "about-4682",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"(?b)a\\$b\"", "0 REG_UNONPOSIX", "", false, "about-4683",
  )
  check_regexp_case(
    "regexp -about  -- \"a)\"", "couldn't compile regular expression pattern: parentheses () not balanced",
    "", true, "about-4684",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"a)\"", "couldn't compile regular expression pattern: parentheses () not balanced",
    "", true, "about-4685",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"a)\"", "couldn't compile regular expression pattern: parentheses () not balanced",
    "", true, "about-4686",
  )
  check_regexp_case(
    "regexp -about  -- \"(?e)a)\"", "0 {REG_UPBOTCH REG_UNONPOSIX}", "", false, "about-4687",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"(?e)a)\"", "0 {REG_UPBOTCH REG_UNONPOSIX}", "", false,
    "about-4688",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"(?e)a)\"", "0 {REG_UPBOTCH REG_UNONPOSIX}", "",
    false, "about-4689",
  )
  check_regexp_case(
    "regexp -about  -- \"a\\]\"", "0 {}", "", false, "about-4690",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"a\\]\"", "0 {}", "", false, "about-4691",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"a\\]\"", "0 {}", "", false, "about-4692",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[\\[:<:\\]\\]\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-4693",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"\\[\\[:<:\\]\\]\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-4694",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"\\[\\[:<:\\]\\]\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-4695",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[.a.\\]\"", "0 {}", "", false, "about-4696",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"\\[.a.\\]\"", "0 {}", "", false, "about-4697",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"\\[.a.\\]\"", "0 {}", "", false, "about-4698",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[:alpha:\\]\"", "0 {}", "", false, "about-4699",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"\\[:alpha:\\]\"", "0 {}", "", false, "about-4700",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"\\[:alpha:\\]\"", "0 {}", "", false, "about-4701",
  )
  check_regexp_case(
    "regexp -about  -- \"a|\"", "0 {REG_UUNSPEC REG_UEMPTYMATCH}", "", false, "about-4702",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"a|\"", "0 {REG_UUNSPEC REG_UEMPTYMATCH}", "", false,
    "about-4703",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"a|\"", "0 {REG_UUNSPEC REG_UEMPTYMATCH}", "", false,
    "about-4704",
  )
  check_regexp_case(
    "regexp -about  -- \"|\"", "0 {REG_UUNSPEC REG_UEMPTYMATCH}", "", false, "about-4705",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"|\"", "0 {REG_UUNSPEC REG_UEMPTYMATCH}", "", false,
    "about-4706",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"|\"", "0 {REG_UUNSPEC REG_UEMPTYMATCH}", "", false,
    "about-4707",
  )
  check_regexp_case(
    "regexp -about  -- \"()\"", "1 {REG_UUNSPEC REG_UEMPTYMATCH}", "", false, "about-4708",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"()\"", "1 {REG_UUNSPEC REG_UEMPTYMATCH}", "", false,
    "about-4709",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"()\"", "1 {REG_UUNSPEC REG_UEMPTYMATCH}", "", false,
    "about-4710",
  )
  check_regexp_case(
    "regexp -about  -- \"(?n)a^\"", "0 {REG_UNONPOSIX REG_UIMPOSSIBLE}", "", false,
    "about-4711",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"(?n)a^\"", "0 {REG_UNONPOSIX REG_UIMPOSSIBLE}", "",
    false, "about-4712",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"(?n)a^\"", "0 {REG_UNONPOSIX REG_UIMPOSSIBLE}",
    "", false, "about-4713",
  )
  check_regexp_case(
    "regexp -about  -- \"(?n)\\$a\"", "0 {REG_UNONPOSIX REG_UIMPOSSIBLE}", "", false,
    "about-4714",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"(?n)\\$a\"", "0 {REG_UNONPOSIX REG_UIMPOSSIBLE}",
    "", false, "about-4715",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"(?n)\\$a\"", "0 {REG_UNONPOSIX REG_UIMPOSSIBLE}",
    "", false, "about-4716",
  )
  check_regexp_case(
    "regexp -about  -- \"(?n)a\\$\"", "0 REG_UNONPOSIX", "", false, "about-4717",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"(?n)a\\$\"", "0 REG_UNONPOSIX", "", false, "about-4718",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"(?n)a\\$\"", "0 REG_UNONPOSIX", "", false, "about-4719",
  )
}

///|
test "Tcl regexp cases 4721 through 4760" {
  check_regexp_case(
    "regexp -about  -- \"(?n)\\$\\\\n\"", "0 REG_UNONPOSIX", "", false, "about-4720",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"(?n)\\$\\\\n\"", "0 REG_UNONPOSIX", "", false, "about-4721",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"(?n)\\$\\\\n\"", "0 REG_UNONPOSIX", "", false,
    "about-4722",
  )
  check_regexp_case(
    "regexp -about  -- \"(?n)\\\\n^\"", "0 REG_UNONPOSIX", "", false, "about-4723",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"(?n)\\\\n^\"", "0 REG_UNONPOSIX", "", false, "about-4724",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"(?n)\\\\n^\"", "0 REG_UNONPOSIX", "", false, "about-4725",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[^\\\\u0000-\\\\uffff\\]\"", "0 {REG_UBBS REG_UNONPOSIX REG_UUNPORT}",
    "", false, "about-4726",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"\\[^\\\\u0000-\\\\uffff\\]\"", "0 {REG_UBBS REG_UNONPOSIX REG_UUNPORT}",
    "", false, "about-4727",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"\\[^\\\\u0000-\\\\uffff\\]\"", "0 {REG_UBBS REG_UNONPOSIX REG_UUNPORT}",
    "", false, "about-4728",
  )
  check_regexp_case(
    "regexp -about  -- \"(?q)\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-4729",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"(?q)\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-4730",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"(?q)\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-4731",
  )
  check_regexp_case(
    "regexp -about  -- \"***=\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-4732",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"***=\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-4733",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"***=\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-4734",
  )
  check_regexp_case(
    "regexp -about  -- \"(?b)\\\\(^a\\$\\\\)\"", "1 {REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-4735",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"(?b)\\\\(^a\\$\\\\)\"", "1 {REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-4736",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"(?b)\\\\(^a\\$\\\\)\"", "1 {REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-4737",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[\\\\.\\]\"", "0 {REG_UBBS REG_UNONPOSIX}", "", false,
    "about-4738",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"\\[\\\\.\\]\"", "0 {REG_UBBS REG_UNONPOSIX}", "",
    false, "about-4739",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"\\[\\\\.\\]\"", "0 {REG_UBBS REG_UNONPOSIX}", "",
    false, "about-4740",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[\\\\u0041\\]\"", "0 {REG_UBBS REG_UNONPOSIX}", "", false,
    "about-4741",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"\\[\\\\u0041\\]\"", "0 {REG_UBBS REG_UNONPOSIX}",
    "", false, "about-4742",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"\\[\\\\u0041\\]\"", "0 {REG_UBBS REG_UNONPOSIX}",
    "", false, "about-4743",
  )
  check_regexp_case(
    "regexp -about  -- \"a{1}?\"", "0 {REG_UBOUNDS REG_UNONPOSIX}", "", false, "about-4744",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"a{1}?\"", "0 {REG_UBOUNDS REG_UNONPOSIX}", "", false,
    "about-4745",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"a{1}?\"", "0 {REG_UBOUNDS REG_UNONPOSIX}", "",
    false, "about-4746",
  )
  check_regexp_case(
    "regexp -about  -- \"(a+?){1}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_USHORTEST}",
    "", false, "about-4747",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"(a+?){1}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_USHORTEST}",
    "", false, "about-4748",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"(a+?){1}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_USHORTEST}",
    "", false, "about-4749",
  )
  check_regexp_case(
    "regexp -about  -- \"(a+?){2}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_USHORTEST}",
    "", false, "about-4750",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"(a+?){2}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_USHORTEST}",
    "", false, "about-4751",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"(a+?){2}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_USHORTEST}",
    "", false, "about-4752",
  )
  check_regexp_case(
    "regexp -about  -- \"a*?|b\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}", "", false,
    "about-4753",
  )
  check_regexp_case(
    "regexp -about -nocase -- \"a*?|b\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}", "",
    false, "about-4754",
  )
  check_regexp_case(
    "regexp -about -expanded -- \"a*?|b\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-4755",
  )
  check_regexp_case(
    "regexp -about  -- \"^^\"", "0 REG_UEMPTYMATCH", "", false, "about-analysis-4756",
  )
  check_regexp_case(
    "regexp -about -line -- \"^^\"", "0 REG_UEMPTYMATCH", "", false, "about-analysis-4757",
  )
  check_regexp_case(
    "regexp -about  -- \"^\\$\"", "0 REG_UEMPTYMATCH", "", false, "about-analysis-4758",
  )
  check_regexp_case(
    "regexp -about -line -- \"^\\$\"", "0 REG_UEMPTYMATCH", "", false, "about-analysis-4759",
  )
}

///|
test "Tcl regexp cases 4761 through 4800" {
  check_regexp_case(
    "regexp -about  -- \"^\\\\A\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}", "", false,
    "about-analysis-4760",
  )
  check_regexp_case(
    "regexp -about -line -- \"^\\\\A\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}", "",
    false, "about-analysis-4761",
  )
  check_regexp_case(
    "regexp -about  -- \"^\\\\Z\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}", "", false,
    "about-analysis-4762",
  )
  check_regexp_case(
    "regexp -about -line -- \"^\\\\Z\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}", "",
    false, "about-analysis-4763",
  )
  check_regexp_case(
    "regexp -about  -- \"^\\\\m\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4764",
  )
  check_regexp_case(
    "regexp -about -line -- \"^\\\\m\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4765",
  )
  check_regexp_case(
    "regexp -about  -- \"^\\\\M\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-4766",
  )
  check_regexp_case(
    "regexp -about -line -- \"^\\\\M\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-4767",
  )
  check_regexp_case(
    "regexp -about  -- \"^\\\\y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4768",
  )
  check_regexp_case(
    "regexp -about -line -- \"^\\\\y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4769",
  )
  check_regexp_case(
    "regexp -about  -- \"^\\\\Y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4770",
  )
  check_regexp_case(
    "regexp -about -line -- \"^\\\\Y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4771",
  )
  check_regexp_case(
    "regexp -about  -- \"^a\"", "0 {}", "", false, "about-analysis-4772",
  )
  check_regexp_case(
    "regexp -about -line -- \"^a\"", "0 {}", "", false, "about-analysis-4773",
  )
  check_regexp_case(
    "regexp -about  -- \"^\\\\n\"", "0 REG_UNONPOSIX", "", false, "about-analysis-4774",
  )
  check_regexp_case(
    "regexp -about -line -- \"^\\\\n\"", "0 REG_UNONPOSIX", "", false, "about-analysis-4775",
  )
  check_regexp_case(
    "regexp -about  -- \"^.\"", "0 {}", "", false, "about-analysis-4776",
  )
  check_regexp_case(
    "regexp -about -line -- \"^.\"", "0 {}", "", false, "about-analysis-4777",
  )
  check_regexp_case(
    "regexp -about  -- \"^\\[^a\\]\"", "0 {}", "", false, "about-analysis-4778",
  )
  check_regexp_case(
    "regexp -about -line -- \"^\\[^a\\]\"", "0 {}", "", false, "about-analysis-4779",
  )
  check_regexp_case(
    "regexp -about  -- \"^\\[a-z\\]\"", "0 REG_UUNPORT", "", false, "about-analysis-4780",
  )
  check_regexp_case(
    "regexp -about -line -- \"^\\[a-z\\]\"", "0 REG_UUNPORT", "", false, "about-analysis-4781",
  )
  check_regexp_case(
    "regexp -about  -- \"^a*\"", "0 REG_UEMPTYMATCH", "", false, "about-analysis-4782",
  )
  check_regexp_case(
    "regexp -about -line -- \"^a*\"", "0 REG_UEMPTYMATCH", "", false, "about-analysis-4783",
  )
  check_regexp_case(
    "regexp -about  -- \"^a?\"", "0 REG_UEMPTYMATCH", "", false, "about-analysis-4784",
  )
  check_regexp_case(
    "regexp -about -line -- \"^a?\"", "0 REG_UEMPTYMATCH", "", false, "about-analysis-4785",
  )
  check_regexp_case(
    "regexp -about  -- \"^(?:)\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-analysis-4786",
  )
  check_regexp_case(
    "regexp -about -line -- \"^(?:)\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-analysis-4787",
  )
  check_regexp_case(
    "regexp -about  -- \"^(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-analysis-4788",
  )
  check_regexp_case(
    "regexp -about -line -- \"^(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "",
    false, "about-analysis-4789",
  )
  check_regexp_case(
    "regexp -about  -- \"^(?!a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-analysis-4790",
  )
  check_regexp_case(
    "regexp -about -line -- \"^(?!a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "",
    false, "about-analysis-4791",
  )
  check_regexp_case(
    "regexp -about  -- \"\\$^\"", "0 REG_UEMPTYMATCH", "", false, "about-analysis-4792",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\$^\"", "0 REG_UEMPTYMATCH", "", false, "about-analysis-4793",
  )
  check_regexp_case(
    "regexp -about  -- \"\\$\\$\"", "0 REG_UEMPTYMATCH", "", false, "about-analysis-4794",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\$\\$\"", "0 REG_UEMPTYMATCH", "", false, "about-analysis-4795",
  )
  check_regexp_case(
    "regexp -about  -- \"\\$\\\\A\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}", "", false,
    "about-analysis-4796",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\$\\\\A\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}", "",
    false, "about-analysis-4797",
  )
  check_regexp_case(
    "regexp -about  -- \"\\$\\\\Z\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}", "", false,
    "about-analysis-4798",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\$\\\\Z\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}", "",
    false, "about-analysis-4799",
  )
}

///|
test "Tcl regexp cases 4801 through 4840" {
  check_regexp_case(
    "regexp -about  -- \"\\$\\\\m\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-4800",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\$\\\\m\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-4801",
  )
  check_regexp_case(
    "regexp -about  -- \"\\$\\\\M\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4802",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\$\\\\M\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4803",
  )
  check_regexp_case(
    "regexp -about  -- \"\\$\\\\y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4804",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\$\\\\y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4805",
  )
  check_regexp_case(
    "regexp -about  -- \"\\$\\\\Y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4806",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\$\\\\Y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4807",
  )
  check_regexp_case(
    "regexp -about  -- \"\\$a\"", "0 REG_UIMPOSSIBLE", "", false, "about-analysis-4808",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\$a\"", "0 REG_UIMPOSSIBLE", "", false, "about-analysis-4809",
  )
  check_regexp_case(
    "regexp -about  -- \"\\$\\\\n\"", "0 {REG_UNONPOSIX REG_UIMPOSSIBLE}", "", false,
    "about-analysis-4810",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\$\\\\n\"", "0 REG_UNONPOSIX", "", false, "about-analysis-4811",
  )
  check_regexp_case(
    "regexp -about  -- \"\\$.\"", "0 REG_UIMPOSSIBLE", "", false, "about-analysis-4812",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\$.\"", "0 REG_UIMPOSSIBLE", "", false, "about-analysis-4813",
  )
  check_regexp_case(
    "regexp -about  -- \"\\$\\[^a\\]\"", "0 REG_UIMPOSSIBLE", "", false, "about-analysis-4814",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\$\\[^a\\]\"", "0 REG_UIMPOSSIBLE", "", false, "about-analysis-4815",
  )
  check_regexp_case(
    "regexp -about  -- \"\\$\\[a-z\\]\"", "0 {REG_UUNPORT REG_UIMPOSSIBLE}", "",
    false, "about-analysis-4816",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\$\\[a-z\\]\"", "0 {REG_UUNPORT REG_UIMPOSSIBLE}",
    "", false, "about-analysis-4817",
  )
  check_regexp_case(
    "regexp -about  -- \"\\$a*\"", "0 REG_UEMPTYMATCH", "", false, "about-analysis-4818",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\$a*\"", "0 REG_UEMPTYMATCH", "", false, "about-analysis-4819",
  )
  check_regexp_case(
    "regexp -about  -- \"\\$a?\"", "0 REG_UEMPTYMATCH", "", false, "about-analysis-4820",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\$a?\"", "0 REG_UEMPTYMATCH", "", false, "about-analysis-4821",
  )
  check_regexp_case(
    "regexp -about  -- \"\\$(?:)\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-analysis-4822",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\$(?:)\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-analysis-4823",
  )
  check_regexp_case(
    "regexp -about  -- \"\\$(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-analysis-4824",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\$(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "",
    false, "about-analysis-4825",
  )
  check_regexp_case(
    "regexp -about  -- \"\\$(?!a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-analysis-4826",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\$(?!a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "",
    false, "about-analysis-4827",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\A^\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}", "", false,
    "about-analysis-4828",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\A^\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}", "",
    false, "about-analysis-4829",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\A\\$\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}", "", false,
    "about-analysis-4830",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\A\\$\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}", "",
    false, "about-analysis-4831",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\A\\\\A\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}", "",
    false, "about-analysis-4832",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\A\\\\A\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-analysis-4833",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\A\\\\Z\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}", "",
    false, "about-analysis-4834",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\A\\\\Z\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-analysis-4835",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\A\\\\m\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4836",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\A\\\\m\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4837",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\A\\\\M\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-4838",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\A\\\\M\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-4839",
  )
}

///|
test "Tcl regexp cases 4841 through 4880" {
  check_regexp_case(
    "regexp -about  -- \"\\\\A\\\\y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4840",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\A\\\\y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4841",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\A\\\\Y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4842",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\A\\\\Y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4843",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\Aa\"", "0 REG_UNONPOSIX", "", false, "about-analysis-4844",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\Aa\"", "0 REG_UNONPOSIX", "", false, "about-analysis-4845",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\A\\\\n\"", "0 REG_UNONPOSIX", "", false, "about-analysis-4846",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\A\\\\n\"", "0 REG_UNONPOSIX", "", false, "about-analysis-4847",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\A.\"", "0 REG_UNONPOSIX", "", false, "about-analysis-4848",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\A.\"", "0 REG_UNONPOSIX", "", false, "about-analysis-4849",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\A\\[^a\\]\"", "0 REG_UNONPOSIX", "", false, "about-analysis-4850",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\A\\[^a\\]\"", "0 REG_UNONPOSIX", "", false, "about-analysis-4851",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\A\\[a-z\\]\"", "0 {REG_UNONPOSIX REG_UUNPORT}", "",
    false, "about-analysis-4852",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\A\\[a-z\\]\"", "0 {REG_UNONPOSIX REG_UUNPORT}",
    "", false, "about-analysis-4853",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\Aa*\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}", "", false,
    "about-analysis-4854",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\Aa*\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}", "",
    false, "about-analysis-4855",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\Aa?\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}", "", false,
    "about-analysis-4856",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\Aa?\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}", "",
    false, "about-analysis-4857",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\A(?:)\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-analysis-4858",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\A(?:)\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-analysis-4859",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\A(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-analysis-4860",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\A(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-analysis-4861",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\A(?!a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-analysis-4862",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\A(?!a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-analysis-4863",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\Z^\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}", "", false,
    "about-analysis-4864",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\Z^\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}", "",
    false, "about-analysis-4865",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\Z\\$\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}", "", false,
    "about-analysis-4866",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\Z\\$\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}", "",
    false, "about-analysis-4867",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\Z\\\\A\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}", "",
    false, "about-analysis-4868",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\Z\\\\A\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-analysis-4869",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\Z\\\\Z\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}", "",
    false, "about-analysis-4870",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\Z\\\\Z\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-analysis-4871",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\Z\\\\m\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-4872",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\Z\\\\m\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-4873",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\Z\\\\M\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4874",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\Z\\\\M\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4875",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\Z\\\\y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4876",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\Z\\\\y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4877",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\Z\\\\Y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4878",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\Z\\\\Y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4879",
  )
}

///|
test "Tcl regexp cases 4881 through 4920" {
  check_regexp_case(
    "regexp -about  -- \"\\\\Za\"", "0 {REG_UNONPOSIX REG_UIMPOSSIBLE}", "", false,
    "about-analysis-4880",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\Za\"", "0 {REG_UNONPOSIX REG_UIMPOSSIBLE}", "",
    false, "about-analysis-4881",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\Z\\\\n\"", "0 {REG_UNONPOSIX REG_UIMPOSSIBLE}", "",
    false, "about-analysis-4882",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\Z\\\\n\"", "0 {REG_UNONPOSIX REG_UIMPOSSIBLE}",
    "", false, "about-analysis-4883",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\Z.\"", "0 {REG_UNONPOSIX REG_UIMPOSSIBLE}", "", false,
    "about-analysis-4884",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\Z.\"", "0 {REG_UNONPOSIX REG_UIMPOSSIBLE}", "",
    false, "about-analysis-4885",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\Z\\[^a\\]\"", "0 {REG_UNONPOSIX REG_UIMPOSSIBLE}", "",
    false, "about-analysis-4886",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\Z\\[^a\\]\"", "0 {REG_UNONPOSIX REG_UIMPOSSIBLE}",
    "", false, "about-analysis-4887",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\Z\\[a-z\\]\"", "0 {REG_UNONPOSIX REG_UUNPORT REG_UIMPOSSIBLE}",
    "", false, "about-analysis-4888",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\Z\\[a-z\\]\"", "0 {REG_UNONPOSIX REG_UUNPORT REG_UIMPOSSIBLE}",
    "", false, "about-analysis-4889",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\Za*\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}", "", false,
    "about-analysis-4890",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\Za*\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}", "",
    false, "about-analysis-4891",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\Za?\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}", "", false,
    "about-analysis-4892",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\Za?\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}", "",
    false, "about-analysis-4893",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\Z(?:)\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-analysis-4894",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\Z(?:)\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-analysis-4895",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\Z(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-analysis-4896",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\Z(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-analysis-4897",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\Z(?!a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-analysis-4898",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\Z(?!a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-analysis-4899",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\m^\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4900",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\m^\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4901",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\m\\$\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-4902",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\m\\$\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-4903",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\m\\\\A\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4904",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\m\\\\A\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4905",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\m\\\\Z\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-4906",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\m\\\\Z\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-4907",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\m\\\\m\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4908",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\m\\\\m\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4909",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\m\\\\M\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-4910",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\m\\\\M\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-4911",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\m\\\\y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4912",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\m\\\\y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4913",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\m\\\\Y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-4914",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\m\\\\Y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-4915",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\ma\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false, "about-analysis-4916",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\ma\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false,
    "about-analysis-4917",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\m\\\\n\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-4918",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\m\\\\n\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-4919",
  )
}

///|
test "Tcl regexp cases 4921 through 4960" {
  check_regexp_case(
    "regexp -about  -- \"\\\\m.\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false, "about-analysis-4920",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\m.\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false,
    "about-analysis-4921",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\m\\[^a\\]\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false,
    "about-analysis-4922",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\m\\[^a\\]\"", "0 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-analysis-4923",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\m\\[a-z\\]\"", "0 {REG_UNONPOSIX REG_UUNPORT REG_ULOCALE}",
    "", false, "about-analysis-4924",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\m\\[a-z\\]\"", "0 {REG_UNONPOSIX REG_UUNPORT REG_ULOCALE}",
    "", false, "about-analysis-4925",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\ma*\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4926",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\ma*\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4927",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\ma?\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4928",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\ma?\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4929",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\m(?:)\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4930",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\m(?:)\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4931",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\m(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-analysis-4932",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\m(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-analysis-4933",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\m(?!a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-analysis-4934",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\m(?!a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-analysis-4935",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\M^\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-4936",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\M^\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-4937",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\M\\$\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4938",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\M\\$\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4939",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\M\\\\A\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-4940",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\M\\\\A\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-4941",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\M\\\\Z\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4942",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\M\\\\Z\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4943",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\M\\\\m\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-4944",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\M\\\\m\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-4945",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\M\\\\M\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4946",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\M\\\\M\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4947",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\M\\\\y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4948",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\M\\\\y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4949",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\M\\\\Y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-4950",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\M\\\\Y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-4951",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\Ma\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-4952",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\Ma\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-4953",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\M\\\\n\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false,
    "about-analysis-4954",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\M\\\\n\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "",
    false, "about-analysis-4955",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\M.\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false, "about-analysis-4956",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\M.\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false,
    "about-analysis-4957",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\M\\[^a\\]\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false,
    "about-analysis-4958",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\M\\[^a\\]\"", "0 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-analysis-4959",
  )
}

///|
test "Tcl regexp cases 4961 through 5000" {
  check_regexp_case(
    "regexp -about  -- \"\\\\M\\[a-z\\]\"", "0 {REG_UNONPOSIX REG_UUNPORT REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-4960",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\M\\[a-z\\]\"", "0 {REG_UNONPOSIX REG_UUNPORT REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-4961",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\Ma*\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4962",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\Ma*\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4963",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\Ma?\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4964",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\Ma?\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4965",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\M(?:)\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4966",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\M(?:)\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4967",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\M(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-analysis-4968",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\M(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-analysis-4969",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\M(?!a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-analysis-4970",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\M(?!a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-analysis-4971",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\y^\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4972",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\y^\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4973",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\y\\$\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4974",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\y\\$\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4975",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\y\\\\A\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4976",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\y\\\\A\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4977",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\y\\\\Z\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4978",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\y\\\\Z\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4979",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\y\\\\m\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4980",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\y\\\\m\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4981",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\y\\\\M\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4982",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\y\\\\M\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4983",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\y\\\\y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4984",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\y\\\\y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4985",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\y\\\\Y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-4986",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\y\\\\Y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-4987",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\ya\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false, "about-analysis-4988",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\ya\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false,
    "about-analysis-4989",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\y\\\\n\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false,
    "about-analysis-4990",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\y\\\\n\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "",
    false, "about-analysis-4991",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\y.\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false, "about-analysis-4992",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\y.\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false,
    "about-analysis-4993",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\y\\[^a\\]\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false,
    "about-analysis-4994",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\y\\[^a\\]\"", "0 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-analysis-4995",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\y\\[a-z\\]\"", "0 {REG_UNONPOSIX REG_UUNPORT REG_ULOCALE}",
    "", false, "about-analysis-4996",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\y\\[a-z\\]\"", "0 {REG_UNONPOSIX REG_UUNPORT REG_ULOCALE}",
    "", false, "about-analysis-4997",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\ya*\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4998",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\ya*\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-4999",
  )
}

///|
test "Tcl regexp cases 5001 through 5040" {
  check_regexp_case(
    "regexp -about  -- \"\\\\ya?\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5000",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\ya?\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5001",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\y(?:)\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5002",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\y(?:)\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5003",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\y(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-analysis-5004",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\y(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-analysis-5005",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\y(?!a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-analysis-5006",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\y(?!a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-analysis-5007",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\Y^\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5008",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\Y^\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5009",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\Y\\$\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5010",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\Y\\$\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5011",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\Y\\\\A\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5012",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\Y\\\\A\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5013",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\Y\\\\Z\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5014",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\Y\\\\Z\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5015",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\Y\\\\m\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-5016",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\Y\\\\m\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-5017",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\Y\\\\M\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-5018",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\Y\\\\M\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-5019",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\Y\\\\y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-5020",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\Y\\\\y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-5021",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\Y\\\\Y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5022",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\Y\\\\Y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5023",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\Ya\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false, "about-analysis-5024",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\Ya\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false,
    "about-analysis-5025",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\Y\\\\n\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false,
    "about-analysis-5026",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\Y\\\\n\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "",
    false, "about-analysis-5027",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\Y.\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false, "about-analysis-5028",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\Y.\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false,
    "about-analysis-5029",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\Y\\[^a\\]\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false,
    "about-analysis-5030",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\Y\\[^a\\]\"", "0 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-analysis-5031",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\Y\\[a-z\\]\"", "0 {REG_UNONPOSIX REG_UUNPORT REG_ULOCALE}",
    "", false, "about-analysis-5032",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\Y\\[a-z\\]\"", "0 {REG_UNONPOSIX REG_UUNPORT REG_ULOCALE}",
    "", false, "about-analysis-5033",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\Ya*\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5034",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\Ya*\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5035",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\Ya?\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5036",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\Ya?\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5037",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\Y(?:)\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5038",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\Y(?:)\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5039",
  )
}

///|
test "Tcl regexp cases 5041 through 5080" {
  check_regexp_case(
    "regexp -about  -- \"\\\\Y(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-analysis-5040",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\Y(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-analysis-5041",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\Y(?!a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-analysis-5042",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\Y(?!a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-analysis-5043",
  )
  check_regexp_case(
    "regexp -about  -- \"a^\"", "0 REG_UIMPOSSIBLE", "", false, "about-analysis-5044",
  )
  check_regexp_case(
    "regexp -about -line -- \"a^\"", "0 REG_UIMPOSSIBLE", "", false, "about-analysis-5045",
  )
  check_regexp_case(
    "regexp -about  -- \"a\\$\"", "0 {}", "", false, "about-analysis-5046",
  )
  check_regexp_case(
    "regexp -about -line -- \"a\\$\"", "0 {}", "", false, "about-analysis-5047",
  )
  check_regexp_case(
    "regexp -about  -- \"a\\\\A\"", "0 {REG_UNONPOSIX REG_UIMPOSSIBLE}", "", false,
    "about-analysis-5048",
  )
  check_regexp_case(
    "regexp -about -line -- \"a\\\\A\"", "0 {REG_UNONPOSIX REG_UIMPOSSIBLE}", "",
    false, "about-analysis-5049",
  )
  check_regexp_case(
    "regexp -about  -- \"a\\\\Z\"", "0 REG_UNONPOSIX", "", false, "about-analysis-5050",
  )
  check_regexp_case(
    "regexp -about -line -- \"a\\\\Z\"", "0 REG_UNONPOSIX", "", false, "about-analysis-5051",
  )
  check_regexp_case(
    "regexp -about  -- \"a\\\\m\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-5052",
  )
  check_regexp_case(
    "regexp -about -line -- \"a\\\\m\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-5053",
  )
  check_regexp_case(
    "regexp -about  -- \"a\\\\M\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false, "about-analysis-5054",
  )
  check_regexp_case(
    "regexp -about -line -- \"a\\\\M\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false,
    "about-analysis-5055",
  )
  check_regexp_case(
    "regexp -about  -- \"a\\\\y\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false, "about-analysis-5056",
  )
  check_regexp_case(
    "regexp -about -line -- \"a\\\\y\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false,
    "about-analysis-5057",
  )
  check_regexp_case(
    "regexp -about  -- \"a\\\\Y\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false, "about-analysis-5058",
  )
  check_regexp_case(
    "regexp -about -line -- \"a\\\\Y\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false,
    "about-analysis-5059",
  )
  check_regexp_case(
    "regexp -about  -- \"aa\"", "0 {}", "", false, "about-analysis-5060",
  )
  check_regexp_case(
    "regexp -about -line -- \"aa\"", "0 {}", "", false, "about-analysis-5061",
  )
  check_regexp_case(
    "regexp -about  -- \"a\\\\n\"", "0 REG_UNONPOSIX", "", false, "about-analysis-5062",
  )
  check_regexp_case(
    "regexp -about -line -- \"a\\\\n\"", "0 REG_UNONPOSIX", "", false, "about-analysis-5063",
  )
  check_regexp_case(
    "regexp -about  -- \"a.\"", "0 {}", "", false, "about-analysis-5064",
  )
  check_regexp_case(
    "regexp -about -line -- \"a.\"", "0 {}", "", false, "about-analysis-5065",
  )
  check_regexp_case(
    "regexp -about  -- \"a\\[^a\\]\"", "0 {}", "", false, "about-analysis-5066",
  )
  check_regexp_case(
    "regexp -about -line -- \"a\\[^a\\]\"", "0 {}", "", false, "about-analysis-5067",
  )
  check_regexp_case(
    "regexp -about  -- \"a\\[a-z\\]\"", "0 REG_UUNPORT", "", false, "about-analysis-5068",
  )
  check_regexp_case(
    "regexp -about -line -- \"a\\[a-z\\]\"", "0 REG_UUNPORT", "", false, "about-analysis-5069",
  )
  check_regexp_case(
    "regexp -about  -- \"aa*\"", "0 {}", "", false, "about-analysis-5070",
  )
  check_regexp_case(
    "regexp -about -line -- \"aa*\"", "0 {}", "", false, "about-analysis-5071",
  )
  check_regexp_case(
    "regexp -about  -- \"aa?\"", "0 {}", "", false, "about-analysis-5072",
  )
  check_regexp_case(
    "regexp -about -line -- \"aa?\"", "0 {}", "", false, "about-analysis-5073",
  )
  check_regexp_case(
    "regexp -about  -- \"a(?:)\"", "0 {REG_UNONPOSIX REG_UUNSPEC}", "", false, "about-analysis-5074",
  )
  check_regexp_case(
    "regexp -about -line -- \"a(?:)\"", "0 {REG_UNONPOSIX REG_UUNSPEC}", "", false,
    "about-analysis-5075",
  )
  check_regexp_case(
    "regexp -about  -- \"a(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-analysis-5076",
  )
  check_regexp_case(
    "regexp -about -line -- \"a(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "",
    false, "about-analysis-5077",
  )
  check_regexp_case(
    "regexp -about  -- \"a(?!a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-analysis-5078",
  )
  check_regexp_case(
    "regexp -about -line -- \"a(?!a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "",
    false, "about-analysis-5079",
  )
}

///|
test "Tcl regexp cases 5081 through 5120" {
  check_regexp_case(
    "regexp -about  -- \"\\\\n^\"", "0 {REG_UNONPOSIX REG_UIMPOSSIBLE}", "", false,
    "about-analysis-5080",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\n^\"", "0 REG_UNONPOSIX", "", false, "about-analysis-5081",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\n\\$\"", "0 REG_UNONPOSIX", "", false, "about-analysis-5082",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\n\\$\"", "0 REG_UNONPOSIX", "", false, "about-analysis-5083",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\n\\\\A\"", "0 {REG_UNONPOSIX REG_UIMPOSSIBLE}", "",
    false, "about-analysis-5084",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\n\\\\A\"", "0 {REG_UNONPOSIX REG_UIMPOSSIBLE}",
    "", false, "about-analysis-5085",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\n\\\\Z\"", "0 REG_UNONPOSIX", "", false, "about-analysis-5086",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\n\\\\Z\"", "0 REG_UNONPOSIX", "", false, "about-analysis-5087",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\n\\\\m\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false,
    "about-analysis-5088",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\n\\\\m\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "",
    false, "about-analysis-5089",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\n\\\\M\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-5090",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\n\\\\M\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-5091",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\n\\\\y\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false,
    "about-analysis-5092",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\n\\\\y\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "",
    false, "about-analysis-5093",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\n\\\\Y\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false,
    "about-analysis-5094",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\n\\\\Y\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "",
    false, "about-analysis-5095",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\na\"", "0 REG_UNONPOSIX", "", false, "about-analysis-5096",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\na\"", "0 REG_UNONPOSIX", "", false, "about-analysis-5097",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\n\\\\n\"", "0 REG_UNONPOSIX", "", false, "about-analysis-5098",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\n\\\\n\"", "0 REG_UNONPOSIX", "", false, "about-analysis-5099",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\n.\"", "0 REG_UNONPOSIX", "", false, "about-analysis-5100",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\n.\"", "0 REG_UNONPOSIX", "", false, "about-analysis-5101",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\n\\[^a\\]\"", "0 REG_UNONPOSIX", "", false, "about-analysis-5102",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\n\\[^a\\]\"", "0 REG_UNONPOSIX", "", false, "about-analysis-5103",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\n\\[a-z\\]\"", "0 {REG_UNONPOSIX REG_UUNPORT}", "",
    false, "about-analysis-5104",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\n\\[a-z\\]\"", "0 {REG_UNONPOSIX REG_UUNPORT}",
    "", false, "about-analysis-5105",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\na*\"", "0 REG_UNONPOSIX", "", false, "about-analysis-5106",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\na*\"", "0 REG_UNONPOSIX", "", false, "about-analysis-5107",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\na?\"", "0 REG_UNONPOSIX", "", false, "about-analysis-5108",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\na?\"", "0 REG_UNONPOSIX", "", false, "about-analysis-5109",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\n(?:)\"", "0 {REG_UNONPOSIX REG_UUNSPEC}", "", false,
    "about-analysis-5110",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\n(?:)\"", "0 {REG_UNONPOSIX REG_UUNSPEC}", "",
    false, "about-analysis-5111",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\n(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-analysis-5112",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\n(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-analysis-5113",
  )
  check_regexp_case(
    "regexp -about  -- \"\\\\n(?!a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-analysis-5114",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\\\n(?!a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-analysis-5115",
  )
  check_regexp_case(
    "regexp -about  -- \".^\"", "0 REG_UIMPOSSIBLE", "", false, "about-analysis-5116",
  )
  check_regexp_case(
    "regexp -about -line -- \".^\"", "0 REG_UIMPOSSIBLE", "", false, "about-analysis-5117",
  )
  check_regexp_case(
    "regexp -about  -- \".\\$\"", "0 {}", "", false, "about-analysis-5118",
  )
  check_regexp_case(
    "regexp -about -line -- \".\\$\"", "0 {}", "", false, "about-analysis-5119",
  )
}

///|
test "Tcl regexp cases 5121 through 5160" {
  check_regexp_case(
    "regexp -about  -- \".\\\\A\"", "0 {REG_UNONPOSIX REG_UIMPOSSIBLE}", "", false,
    "about-analysis-5120",
  )
  check_regexp_case(
    "regexp -about -line -- \".\\\\A\"", "0 {REG_UNONPOSIX REG_UIMPOSSIBLE}", "",
    false, "about-analysis-5121",
  )
  check_regexp_case(
    "regexp -about  -- \".\\\\Z\"", "0 REG_UNONPOSIX", "", false, "about-analysis-5122",
  )
  check_regexp_case(
    "regexp -about -line -- \".\\\\Z\"", "0 REG_UNONPOSIX", "", false, "about-analysis-5123",
  )
  check_regexp_case(
    "regexp -about  -- \".\\\\m\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false, "about-analysis-5124",
  )
  check_regexp_case(
    "regexp -about -line -- \".\\\\m\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false,
    "about-analysis-5125",
  )
  check_regexp_case(
    "regexp -about  -- \".\\\\M\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false, "about-analysis-5126",
  )
  check_regexp_case(
    "regexp -about -line -- \".\\\\M\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false,
    "about-analysis-5127",
  )
  check_regexp_case(
    "regexp -about  -- \".\\\\y\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false, "about-analysis-5128",
  )
  check_regexp_case(
    "regexp -about -line -- \".\\\\y\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false,
    "about-analysis-5129",
  )
  check_regexp_case(
    "regexp -about  -- \".\\\\Y\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false, "about-analysis-5130",
  )
  check_regexp_case(
    "regexp -about -line -- \".\\\\Y\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false,
    "about-analysis-5131",
  )
  check_regexp_case(
    "regexp -about  -- \".a\"", "0 {}", "", false, "about-analysis-5132",
  )
  check_regexp_case(
    "regexp -about -line -- \".a\"", "0 {}", "", false, "about-analysis-5133",
  )
  check_regexp_case(
    "regexp -about  -- \".\\\\n\"", "0 REG_UNONPOSIX", "", false, "about-analysis-5134",
  )
  check_regexp_case(
    "regexp -about -line -- \".\\\\n\"", "0 REG_UNONPOSIX", "", false, "about-analysis-5135",
  )
  check_regexp_case(
    "regexp -about  -- \"..\"", "0 {}", "", false, "about-analysis-5136",
  )
  check_regexp_case(
    "regexp -about -line -- \"..\"", "0 {}", "", false, "about-analysis-5137",
  )
  check_regexp_case(
    "regexp -about  -- \".\\[^a\\]\"", "0 {}", "", false, "about-analysis-5138",
  )
  check_regexp_case(
    "regexp -about -line -- \".\\[^a\\]\"", "0 {}", "", false, "about-analysis-5139",
  )
  check_regexp_case(
    "regexp -about  -- \".\\[a-z\\]\"", "0 REG_UUNPORT", "", false, "about-analysis-5140",
  )
  check_regexp_case(
    "regexp -about -line -- \".\\[a-z\\]\"", "0 REG_UUNPORT", "", false, "about-analysis-5141",
  )
  check_regexp_case(
    "regexp -about  -- \".a*\"", "0 {}", "", false, "about-analysis-5142",
  )
  check_regexp_case(
    "regexp -about -line -- \".a*\"", "0 {}", "", false, "about-analysis-5143",
  )
  check_regexp_case(
    "regexp -about  -- \".a?\"", "0 {}", "", false, "about-analysis-5144",
  )
  check_regexp_case(
    "regexp -about -line -- \".a?\"", "0 {}", "", false, "about-analysis-5145",
  )
  check_regexp_case(
    "regexp -about  -- \".(?:)\"", "0 {REG_UNONPOSIX REG_UUNSPEC}", "", false, "about-analysis-5146",
  )
  check_regexp_case(
    "regexp -about -line -- \".(?:)\"", "0 {REG_UNONPOSIX REG_UUNSPEC}", "", false,
    "about-analysis-5147",
  )
  check_regexp_case(
    "regexp -about  -- \".(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-analysis-5148",
  )
  check_regexp_case(
    "regexp -about -line -- \".(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "",
    false, "about-analysis-5149",
  )
  check_regexp_case(
    "regexp -about  -- \".(?!a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-analysis-5150",
  )
  check_regexp_case(
    "regexp -about -line -- \".(?!a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "",
    false, "about-analysis-5151",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[^a\\]^\"", "0 REG_UIMPOSSIBLE", "", false, "about-analysis-5152",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\[^a\\]^\"", "0 REG_UIMPOSSIBLE", "", false, "about-analysis-5153",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[^a\\]\\$\"", "0 {}", "", false, "about-analysis-5154",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\[^a\\]\\$\"", "0 {}", "", false, "about-analysis-5155",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[^a\\]\\\\A\"", "0 {REG_UNONPOSIX REG_UIMPOSSIBLE}", "",
    false, "about-analysis-5156",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\[^a\\]\\\\A\"", "0 {REG_UNONPOSIX REG_UIMPOSSIBLE}",
    "", false, "about-analysis-5157",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[^a\\]\\\\Z\"", "0 REG_UNONPOSIX", "", false, "about-analysis-5158",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\[^a\\]\\\\Z\"", "0 REG_UNONPOSIX", "", false, "about-analysis-5159",
  )
}

///|
test "Tcl regexp cases 5161 through 5200" {
  check_regexp_case(
    "regexp -about  -- \"\\[^a\\]\\\\m\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false,
    "about-analysis-5160",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\[^a\\]\\\\m\"", "0 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-analysis-5161",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[^a\\]\\\\M\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false,
    "about-analysis-5162",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\[^a\\]\\\\M\"", "0 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-analysis-5163",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[^a\\]\\\\y\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false,
    "about-analysis-5164",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\[^a\\]\\\\y\"", "0 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-analysis-5165",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[^a\\]\\\\Y\"", "0 {REG_UNONPOSIX REG_ULOCALE}", "", false,
    "about-analysis-5166",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\[^a\\]\\\\Y\"", "0 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-analysis-5167",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[^a\\]a\"", "0 {}", "", false, "about-analysis-5168",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\[^a\\]a\"", "0 {}", "", false, "about-analysis-5169",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[^a\\]\\\\n\"", "0 REG_UNONPOSIX", "", false, "about-analysis-5170",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\[^a\\]\\\\n\"", "0 REG_UNONPOSIX", "", false, "about-analysis-5171",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[^a\\].\"", "0 {}", "", false, "about-analysis-5172",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\[^a\\].\"", "0 {}", "", false, "about-analysis-5173",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[^a\\]\\[^a\\]\"", "0 {}", "", false, "about-analysis-5174",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\[^a\\]\\[^a\\]\"", "0 {}", "", false, "about-analysis-5175",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[^a\\]\\[a-z\\]\"", "0 REG_UUNPORT", "", false, "about-analysis-5176",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\[^a\\]\\[a-z\\]\"", "0 REG_UUNPORT", "", false, "about-analysis-5177",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[^a\\]a*\"", "0 {}", "", false, "about-analysis-5178",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\[^a\\]a*\"", "0 {}", "", false, "about-analysis-5179",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[^a\\]a?\"", "0 {}", "", false, "about-analysis-5180",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\[^a\\]a?\"", "0 {}", "", false, "about-analysis-5181",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[^a\\](?:)\"", "0 {REG_UNONPOSIX REG_UUNSPEC}", "", false,
    "about-analysis-5182",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\[^a\\](?:)\"", "0 {REG_UNONPOSIX REG_UUNSPEC}", "",
    false, "about-analysis-5183",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[^a\\](?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "",
    false, "about-analysis-5184",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\[^a\\](?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-analysis-5185",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[^a\\](?!a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "",
    false, "about-analysis-5186",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\[^a\\](?!a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-analysis-5187",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[a-z\\]^\"", "0 {REG_UUNPORT REG_UIMPOSSIBLE}", "", false,
    "about-analysis-5188",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\[a-z\\]^\"", "0 {REG_UUNPORT REG_UIMPOSSIBLE}", "",
    false, "about-analysis-5189",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[a-z\\]\\$\"", "0 REG_UUNPORT", "", false, "about-analysis-5190",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\[a-z\\]\\$\"", "0 REG_UUNPORT", "", false, "about-analysis-5191",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[a-z\\]\\\\A\"", "0 {REG_UNONPOSIX REG_UUNPORT REG_UIMPOSSIBLE}",
    "", false, "about-analysis-5192",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\[a-z\\]\\\\A\"", "0 {REG_UNONPOSIX REG_UUNPORT REG_UIMPOSSIBLE}",
    "", false, "about-analysis-5193",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[a-z\\]\\\\Z\"", "0 {REG_UNONPOSIX REG_UUNPORT}", "",
    false, "about-analysis-5194",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\[a-z\\]\\\\Z\"", "0 {REG_UNONPOSIX REG_UUNPORT}",
    "", false, "about-analysis-5195",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[a-z\\]\\\\m\"", "0 {REG_UNONPOSIX REG_UUNPORT REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-5196",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\[a-z\\]\\\\m\"", "0 {REG_UNONPOSIX REG_UUNPORT REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-analysis-5197",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[a-z\\]\\\\M\"", "0 {REG_UNONPOSIX REG_UUNPORT REG_ULOCALE}",
    "", false, "about-analysis-5198",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\[a-z\\]\\\\M\"", "0 {REG_UNONPOSIX REG_UUNPORT REG_ULOCALE}",
    "", false, "about-analysis-5199",
  )
}

///|
test "Tcl regexp cases 5201 through 5240" {
  check_regexp_case(
    "regexp -about  -- \"\\[a-z\\]\\\\y\"", "0 {REG_UNONPOSIX REG_UUNPORT REG_ULOCALE}",
    "", false, "about-analysis-5200",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\[a-z\\]\\\\y\"", "0 {REG_UNONPOSIX REG_UUNPORT REG_ULOCALE}",
    "", false, "about-analysis-5201",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[a-z\\]\\\\Y\"", "0 {REG_UNONPOSIX REG_UUNPORT REG_ULOCALE}",
    "", false, "about-analysis-5202",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\[a-z\\]\\\\Y\"", "0 {REG_UNONPOSIX REG_UUNPORT REG_ULOCALE}",
    "", false, "about-analysis-5203",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[a-z\\]a\"", "0 REG_UUNPORT", "", false, "about-analysis-5204",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\[a-z\\]a\"", "0 REG_UUNPORT", "", false, "about-analysis-5205",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[a-z\\]\\\\n\"", "0 {REG_UNONPOSIX REG_UUNPORT}", "",
    false, "about-analysis-5206",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\[a-z\\]\\\\n\"", "0 {REG_UNONPOSIX REG_UUNPORT}",
    "", false, "about-analysis-5207",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[a-z\\].\"", "0 REG_UUNPORT", "", false, "about-analysis-5208",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\[a-z\\].\"", "0 REG_UUNPORT", "", false, "about-analysis-5209",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[a-z\\]\\[^a\\]\"", "0 REG_UUNPORT", "", false, "about-analysis-5210",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\[a-z\\]\\[^a\\]\"", "0 REG_UUNPORT", "", false, "about-analysis-5211",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[a-z\\]\\[a-z\\]\"", "0 REG_UUNPORT", "", false, "about-analysis-5212",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\[a-z\\]\\[a-z\\]\"", "0 REG_UUNPORT", "", false,
    "about-analysis-5213",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[a-z\\]a*\"", "0 REG_UUNPORT", "", false, "about-analysis-5214",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\[a-z\\]a*\"", "0 REG_UUNPORT", "", false, "about-analysis-5215",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[a-z\\]a?\"", "0 REG_UUNPORT", "", false, "about-analysis-5216",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\[a-z\\]a?\"", "0 REG_UUNPORT", "", false, "about-analysis-5217",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[a-z\\](?:)\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_UUNPORT}",
    "", false, "about-analysis-5218",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\[a-z\\](?:)\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_UUNPORT}",
    "", false, "about-analysis-5219",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[a-z\\](?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNPORT}",
    "", false, "about-analysis-5220",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\[a-z\\](?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNPORT}",
    "", false, "about-analysis-5221",
  )
  check_regexp_case(
    "regexp -about  -- \"\\[a-z\\](?!a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNPORT}",
    "", false, "about-analysis-5222",
  )
  check_regexp_case(
    "regexp -about -line -- \"\\[a-z\\](?!a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNPORT}",
    "", false, "about-analysis-5223",
  )
  check_regexp_case(
    "regexp -about  -- \"a*^\"", "0 REG_UEMPTYMATCH", "", false, "about-analysis-5224",
  )
  check_regexp_case(
    "regexp -about -line -- \"a*^\"", "0 REG_UEMPTYMATCH", "", false, "about-analysis-5225",
  )
  check_regexp_case(
    "regexp -about  -- \"a*\\$\"", "0 REG_UEMPTYMATCH", "", false, "about-analysis-5226",
  )
  check_regexp_case(
    "regexp -about -line -- \"a*\\$\"", "0 REG_UEMPTYMATCH", "", false, "about-analysis-5227",
  )
  check_regexp_case(
    "regexp -about  -- \"a*\\\\A\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}", "", false,
    "about-analysis-5228",
  )
  check_regexp_case(
    "regexp -about -line -- \"a*\\\\A\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}", "",
    false, "about-analysis-5229",
  )
  check_regexp_case(
    "regexp -about  -- \"a*\\\\Z\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}", "", false,
    "about-analysis-5230",
  )
  check_regexp_case(
    "regexp -about -line -- \"a*\\\\Z\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}", "",
    false, "about-analysis-5231",
  )
  check_regexp_case(
    "regexp -about  -- \"a*\\\\m\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5232",
  )
  check_regexp_case(
    "regexp -about -line -- \"a*\\\\m\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5233",
  )
  check_regexp_case(
    "regexp -about  -- \"a*\\\\M\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5234",
  )
  check_regexp_case(
    "regexp -about -line -- \"a*\\\\M\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5235",
  )
  check_regexp_case(
    "regexp -about  -- \"a*\\\\y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5236",
  )
  check_regexp_case(
    "regexp -about -line -- \"a*\\\\y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5237",
  )
  check_regexp_case(
    "regexp -about  -- \"a*\\\\Y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5238",
  )
  check_regexp_case(
    "regexp -about -line -- \"a*\\\\Y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5239",
  )
}

///|
test "Tcl regexp cases 5241 through 5280" {
  check_regexp_case(
    "regexp -about  -- \"a*a\"", "0 {}", "", false, "about-analysis-5240",
  )
  check_regexp_case(
    "regexp -about -line -- \"a*a\"", "0 {}", "", false, "about-analysis-5241",
  )
  check_regexp_case(
    "regexp -about  -- \"a*\\\\n\"", "0 REG_UNONPOSIX", "", false, "about-analysis-5242",
  )
  check_regexp_case(
    "regexp -about -line -- \"a*\\\\n\"", "0 REG_UNONPOSIX", "", false, "about-analysis-5243",
  )
  check_regexp_case(
    "regexp -about  -- \"a*.\"", "0 {}", "", false, "about-analysis-5244",
  )
  check_regexp_case(
    "regexp -about -line -- \"a*.\"", "0 {}", "", false, "about-analysis-5245",
  )
  check_regexp_case(
    "regexp -about  -- \"a*\\[^a\\]\"", "0 {}", "", false, "about-analysis-5246",
  )
  check_regexp_case(
    "regexp -about -line -- \"a*\\[^a\\]\"", "0 {}", "", false, "about-analysis-5247",
  )
  check_regexp_case(
    "regexp -about  -- \"a*\\[a-z\\]\"", "0 REG_UUNPORT", "", false, "about-analysis-5248",
  )
  check_regexp_case(
    "regexp -about -line -- \"a*\\[a-z\\]\"", "0 REG_UUNPORT", "", false, "about-analysis-5249",
  )
  check_regexp_case(
    "regexp -about  -- \"a*a*\"", "0 REG_UEMPTYMATCH", "", false, "about-analysis-5250",
  )
  check_regexp_case(
    "regexp -about -line -- \"a*a*\"", "0 REG_UEMPTYMATCH", "", false, "about-analysis-5251",
  )
  check_regexp_case(
    "regexp -about  -- \"a*a?\"", "0 REG_UEMPTYMATCH", "", false, "about-analysis-5252",
  )
  check_regexp_case(
    "regexp -about -line -- \"a*a?\"", "0 REG_UEMPTYMATCH", "", false, "about-analysis-5253",
  )
  check_regexp_case(
    "regexp -about  -- \"a*(?:)\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-analysis-5254",
  )
  check_regexp_case(
    "regexp -about -line -- \"a*(?:)\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-analysis-5255",
  )
  check_regexp_case(
    "regexp -about  -- \"a*(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-analysis-5256",
  )
  check_regexp_case(
    "regexp -about -line -- \"a*(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "",
    false, "about-analysis-5257",
  )
  check_regexp_case(
    "regexp -about  -- \"a*(?!a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-analysis-5258",
  )
  check_regexp_case(
    "regexp -about -line -- \"a*(?!a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "",
    false, "about-analysis-5259",
  )
  check_regexp_case(
    "regexp -about  -- \"a?^\"", "0 REG_UEMPTYMATCH", "", false, "about-analysis-5260",
  )
  check_regexp_case(
    "regexp -about -line -- \"a?^\"", "0 REG_UEMPTYMATCH", "", false, "about-analysis-5261",
  )
  check_regexp_case(
    "regexp -about  -- \"a?\\$\"", "0 REG_UEMPTYMATCH", "", false, "about-analysis-5262",
  )
  check_regexp_case(
    "regexp -about -line -- \"a?\\$\"", "0 REG_UEMPTYMATCH", "", false, "about-analysis-5263",
  )
  check_regexp_case(
    "regexp -about  -- \"a?\\\\A\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}", "", false,
    "about-analysis-5264",
  )
  check_regexp_case(
    "regexp -about -line -- \"a?\\\\A\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}", "",
    false, "about-analysis-5265",
  )
  check_regexp_case(
    "regexp -about  -- \"a?\\\\Z\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}", "", false,
    "about-analysis-5266",
  )
  check_regexp_case(
    "regexp -about -line -- \"a?\\\\Z\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}", "",
    false, "about-analysis-5267",
  )
  check_regexp_case(
    "regexp -about  -- \"a?\\\\m\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5268",
  )
  check_regexp_case(
    "regexp -about -line -- \"a?\\\\m\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5269",
  )
  check_regexp_case(
    "regexp -about  -- \"a?\\\\M\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5270",
  )
  check_regexp_case(
    "regexp -about -line -- \"a?\\\\M\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5271",
  )
  check_regexp_case(
    "regexp -about  -- \"a?\\\\y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5272",
  )
  check_regexp_case(
    "regexp -about -line -- \"a?\\\\y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5273",
  )
  check_regexp_case(
    "regexp -about  -- \"a?\\\\Y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5274",
  )
  check_regexp_case(
    "regexp -about -line -- \"a?\\\\Y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5275",
  )
  check_regexp_case(
    "regexp -about  -- \"a?a\"", "0 {}", "", false, "about-analysis-5276",
  )
  check_regexp_case(
    "regexp -about -line -- \"a?a\"", "0 {}", "", false, "about-analysis-5277",
  )
  check_regexp_case(
    "regexp -about  -- \"a?\\\\n\"", "0 REG_UNONPOSIX", "", false, "about-analysis-5278",
  )
  check_regexp_case(
    "regexp -about -line -- \"a?\\\\n\"", "0 REG_UNONPOSIX", "", false, "about-analysis-5279",
  )
}

///|
test "Tcl regexp cases 5281 through 5320" {
  check_regexp_case(
    "regexp -about  -- \"a?.\"", "0 {}", "", false, "about-analysis-5280",
  )
  check_regexp_case(
    "regexp -about -line -- \"a?.\"", "0 {}", "", false, "about-analysis-5281",
  )
  check_regexp_case(
    "regexp -about  -- \"a?\\[^a\\]\"", "0 {}", "", false, "about-analysis-5282",
  )
  check_regexp_case(
    "regexp -about -line -- \"a?\\[^a\\]\"", "0 {}", "", false, "about-analysis-5283",
  )
  check_regexp_case(
    "regexp -about  -- \"a?\\[a-z\\]\"", "0 REG_UUNPORT", "", false, "about-analysis-5284",
  )
  check_regexp_case(
    "regexp -about -line -- \"a?\\[a-z\\]\"", "0 REG_UUNPORT", "", false, "about-analysis-5285",
  )
  check_regexp_case(
    "regexp -about  -- \"a?a*\"", "0 REG_UEMPTYMATCH", "", false, "about-analysis-5286",
  )
  check_regexp_case(
    "regexp -about -line -- \"a?a*\"", "0 REG_UEMPTYMATCH", "", false, "about-analysis-5287",
  )
  check_regexp_case(
    "regexp -about  -- \"a?a?\"", "0 REG_UEMPTYMATCH", "", false, "about-analysis-5288",
  )
  check_regexp_case(
    "regexp -about -line -- \"a?a?\"", "0 REG_UEMPTYMATCH", "", false, "about-analysis-5289",
  )
  check_regexp_case(
    "regexp -about  -- \"a?(?:)\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-analysis-5290",
  )
  check_regexp_case(
    "regexp -about -line -- \"a?(?:)\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-analysis-5291",
  )
  check_regexp_case(
    "regexp -about  -- \"a?(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-analysis-5292",
  )
  check_regexp_case(
    "regexp -about -line -- \"a?(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "",
    false, "about-analysis-5293",
  )
  check_regexp_case(
    "regexp -about  -- \"a?(?!a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-analysis-5294",
  )
  check_regexp_case(
    "regexp -about -line -- \"a?(?!a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "",
    false, "about-analysis-5295",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:)^\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-analysis-5296",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:)^\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-analysis-5297",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:)\\$\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-analysis-5298",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:)\\$\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-analysis-5299",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:)\\\\A\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-analysis-5300",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:)\\\\A\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-analysis-5301",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:)\\\\Z\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-analysis-5302",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:)\\\\Z\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-analysis-5303",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:)\\\\m\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5304",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:)\\\\m\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5305",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:)\\\\M\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5306",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:)\\\\M\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5307",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:)\\\\y\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5308",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:)\\\\y\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5309",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:)\\\\Y\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5310",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:)\\\\Y\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-analysis-5311",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:)a\"", "0 {REG_UNONPOSIX REG_UUNSPEC}", "", false, "about-analysis-5312",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:)a\"", "0 {REG_UNONPOSIX REG_UUNSPEC}", "", false,
    "about-analysis-5313",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:)\\\\n\"", "0 {REG_UNONPOSIX REG_UUNSPEC}", "", false,
    "about-analysis-5314",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:)\\\\n\"", "0 {REG_UNONPOSIX REG_UUNSPEC}", "",
    false, "about-analysis-5315",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:).\"", "0 {REG_UNONPOSIX REG_UUNSPEC}", "", false, "about-analysis-5316",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:).\"", "0 {REG_UNONPOSIX REG_UUNSPEC}", "", false,
    "about-analysis-5317",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:)\\[^a\\]\"", "0 {REG_UNONPOSIX REG_UUNSPEC}", "", false,
    "about-analysis-5318",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:)\\[^a\\]\"", "0 {REG_UNONPOSIX REG_UUNSPEC}", "",
    false, "about-analysis-5319",
  )
}

///|
test "Tcl regexp cases 5321 through 5360" {
  check_regexp_case(
    "regexp -about  -- \"(?:)\\[a-z\\]\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_UUNPORT}",
    "", false, "about-analysis-5320",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:)\\[a-z\\]\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_UUNPORT}",
    "", false, "about-analysis-5321",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:)a*\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-analysis-5322",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:)a*\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-analysis-5323",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:)a?\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-analysis-5324",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:)a?\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-analysis-5325",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:)(?:)\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-analysis-5326",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:)(?:)\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-analysis-5327",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:)(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-analysis-5328",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:)(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-analysis-5329",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:)(?!a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-analysis-5330",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:)(?!a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-analysis-5331",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=a)^\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-analysis-5332",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=a)^\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "",
    false, "about-analysis-5333",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=a)\\$\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-analysis-5334",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=a)\\$\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "",
    false, "about-analysis-5335",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=a)\\\\A\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-analysis-5336",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=a)\\\\A\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-analysis-5337",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=a)\\\\Z\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-analysis-5338",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=a)\\\\Z\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-analysis-5339",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=a)\\\\m\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-analysis-5340",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=a)\\\\m\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-analysis-5341",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=a)\\\\M\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-analysis-5342",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=a)\\\\M\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-analysis-5343",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=a)\\\\y\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-analysis-5344",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=a)\\\\y\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-analysis-5345",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=a)\\\\Y\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-analysis-5346",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=a)\\\\Y\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-analysis-5347",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=a)a\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-analysis-5348",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=a)a\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "",
    false, "about-analysis-5349",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=a)\\\\n\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-analysis-5350",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=a)\\\\n\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-analysis-5351",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=a).\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-analysis-5352",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=a).\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "",
    false, "about-analysis-5353",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=a)\\[^a\\]\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "",
    false, "about-analysis-5354",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=a)\\[^a\\]\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-analysis-5355",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=a)\\[a-z\\]\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNPORT}",
    "", false, "about-analysis-5356",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=a)\\[a-z\\]\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNPORT}",
    "", false, "about-analysis-5357",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=a)a*\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-analysis-5358",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=a)a*\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "",
    false, "about-analysis-5359",
  )
}

///|
test "Tcl regexp cases 5361 through 5400" {
  check_regexp_case(
    "regexp -about  -- \"(?=a)a?\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-analysis-5360",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=a)a?\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "",
    false, "about-analysis-5361",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=a)(?:)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-analysis-5362",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=a)(?:)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-analysis-5363",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=a)(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-analysis-5364",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=a)(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-analysis-5365",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=a)(?!a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-analysis-5366",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=a)(?!a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-analysis-5367",
  )
  check_regexp_case(
    "regexp -about  -- \"(?!a)^\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-analysis-5368",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?!a)^\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "",
    false, "about-analysis-5369",
  )
  check_regexp_case(
    "regexp -about  -- \"(?!a)\\$\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-analysis-5370",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?!a)\\$\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "",
    false, "about-analysis-5371",
  )
  check_regexp_case(
    "regexp -about  -- \"(?!a)\\\\A\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-analysis-5372",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?!a)\\\\A\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-analysis-5373",
  )
  check_regexp_case(
    "regexp -about  -- \"(?!a)\\\\Z\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-analysis-5374",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?!a)\\\\Z\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-analysis-5375",
  )
  check_regexp_case(
    "regexp -about  -- \"(?!a)\\\\m\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-analysis-5376",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?!a)\\\\m\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-analysis-5377",
  )
  check_regexp_case(
    "regexp -about  -- \"(?!a)\\\\M\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-analysis-5378",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?!a)\\\\M\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-analysis-5379",
  )
  check_regexp_case(
    "regexp -about  -- \"(?!a)\\\\y\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-analysis-5380",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?!a)\\\\y\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-analysis-5381",
  )
  check_regexp_case(
    "regexp -about  -- \"(?!a)\\\\Y\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-analysis-5382",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?!a)\\\\Y\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-analysis-5383",
  )
  check_regexp_case(
    "regexp -about  -- \"(?!a)a\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-analysis-5384",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?!a)a\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "",
    false, "about-analysis-5385",
  )
  check_regexp_case(
    "regexp -about  -- \"(?!a)\\\\n\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-analysis-5386",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?!a)\\\\n\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-analysis-5387",
  )
  check_regexp_case(
    "regexp -about  -- \"(?!a).\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-analysis-5388",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?!a).\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "",
    false, "about-analysis-5389",
  )
  check_regexp_case(
    "regexp -about  -- \"(?!a)\\[^a\\]\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "",
    false, "about-analysis-5390",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?!a)\\[^a\\]\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-analysis-5391",
  )
  check_regexp_case(
    "regexp -about  -- \"(?!a)\\[a-z\\]\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNPORT}",
    "", false, "about-analysis-5392",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?!a)\\[a-z\\]\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNPORT}",
    "", false, "about-analysis-5393",
  )
  check_regexp_case(
    "regexp -about  -- \"(?!a)a*\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-analysis-5394",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?!a)a*\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "",
    false, "about-analysis-5395",
  )
  check_regexp_case(
    "regexp -about  -- \"(?!a)a?\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-analysis-5396",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?!a)a?\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "",
    false, "about-analysis-5397",
  )
  check_regexp_case(
    "regexp -about  -- \"(?!a)(?:)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-analysis-5398",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?!a)(?:)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-analysis-5399",
  )
}

///|
test "Tcl regexp cases 5401 through 5440" {
  check_regexp_case(
    "regexp -about  -- \"(?!a)(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-analysis-5400",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?!a)(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-analysis-5401",
  )
  check_regexp_case(
    "regexp -about  -- \"(?!a)(?!a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-analysis-5402",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?!a)(?!a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-analysis-5403",
  )
  check_regexp_case(
    "set code [catch {regexp -n a a} result options];list $code $result", "1 {bad option \"-n\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "Known difference local contract: option-dispatch-5404",
  )
  check_regexp_case(
    "set code [catch {set p a;regexp -n $p a} result options];list $code $result",
    "1 {bad option \"-n\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "Known difference local contract: option-dispatch-5405",
  )
  check_regexp_case(
    "set code [catch {set opt -n;regexp $opt a a} result options];list $code $result",
    "1 {bad option \"-n\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5406",
  )
  check_regexp_case(
    "set code [catch {set command regexp;$command -n a a} result options];list $code $result",
    "1 {bad option \"-n\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5407",
  )
  check_regexp_case(
    "set code [catch {regexp -n a a m} result options];list $code $result", "1 {bad option \"-n\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5408",
  )
  check_regexp_case(
    "set code [catch {rename regexp search;search -n a a} result options];list $code $result",
    "1 {bad option \"-n\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5409",
  )
  check_regexp_case(
    "set code [catch {eval [list regexp -n a a]} result options];list $code $result",
    "1 {bad option \"-n\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5410",
  )
  check_regexp_case(
    "set code [catch {regexp {*}[list -n a a]} result options];list $code $result",
    "1 {bad option \"-n\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5411",
  )
  check_regexp_case(
    "set code [catch {regsub -n a a x} result options];list $code $result", "1 {bad option \"-n\": must be -all, -nocase, -expanded, -line, -linestop, -lineanchor, -start, or --}",
    "", false, "option-dispatch-5412",
  )
  check_regexp_case(
    "set code [catch {regexp -no a a} result options];list $code $result", "1 {bad option \"-no\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "Known difference local contract: option-dispatch-5413",
  )
  check_regexp_case(
    "set code [catch {set p a;regexp -no $p a} result options];list $code $result",
    "1 {bad option \"-no\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "Known difference local contract: option-dispatch-5414",
  )
  check_regexp_case(
    "set code [catch {set opt -no;regexp $opt a a} result options];list $code $result",
    "1 {bad option \"-no\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5415",
  )
  check_regexp_case(
    "set code [catch {set command regexp;$command -no a a} result options];list $code $result",
    "1 {bad option \"-no\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5416",
  )
  check_regexp_case(
    "set code [catch {regexp -no a a m} result options];list $code $result", "1 {bad option \"-no\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5417",
  )
  check_regexp_case(
    "set code [catch {rename regexp search;search -no a a} result options];list $code $result",
    "1 {bad option \"-no\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5418",
  )
  check_regexp_case(
    "set code [catch {eval [list regexp -no a a]} result options];list $code $result",
    "1 {bad option \"-no\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5419",
  )
  check_regexp_case(
    "set code [catch {regexp {*}[list -no a a]} result options];list $code $result",
    "1 {bad option \"-no\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5420",
  )
  check_regexp_case(
    "set code [catch {regsub -no a a x} result options];list $code $result", "1 {bad option \"-no\": must be -all, -nocase, -expanded, -line, -linestop, -lineanchor, -start, or --}",
    "", false, "option-dispatch-5421",
  )
  check_regexp_case(
    "set code [catch {regexp -noc a a} result options];list $code $result", "1 {bad option \"-noc\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "Known difference local contract: option-dispatch-5422",
  )
  check_regexp_case(
    "set code [catch {set p a;regexp -noc $p a} result options];list $code $result",
    "1 {bad option \"-noc\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "Known difference local contract: option-dispatch-5423",
  )
  check_regexp_case(
    "set code [catch {set opt -noc;regexp $opt a a} result options];list $code $result",
    "1 {bad option \"-noc\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5424",
  )
  check_regexp_case(
    "set code [catch {set command regexp;$command -noc a a} result options];list $code $result",
    "1 {bad option \"-noc\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5425",
  )
  check_regexp_case(
    "set code [catch {regexp -noc a a m} result options];list $code $result", "1 {bad option \"-noc\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5426",
  )
  check_regexp_case(
    "set code [catch {rename regexp search;search -noc a a} result options];list $code $result",
    "1 {bad option \"-noc\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5427",
  )
  check_regexp_case(
    "set code [catch {eval [list regexp -noc a a]} result options];list $code $result",
    "1 {bad option \"-noc\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5428",
  )
  check_regexp_case(
    "set code [catch {regexp {*}[list -noc a a]} result options];list $code $result",
    "1 {bad option \"-noc\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5429",
  )
  check_regexp_case(
    "set code [catch {regsub -noc a a x} result options];list $code $result", "1 {bad option \"-noc\": must be -all, -nocase, -expanded, -line, -linestop, -lineanchor, -start, or --}",
    "", false, "option-dispatch-5430",
  )
  check_regexp_case(
    "set code [catch {regexp -nocas a a} result options];list $code $result", "1 {bad option \"-nocas\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "Known difference local contract: option-dispatch-5431",
  )
  check_regexp_case(
    "set code [catch {set p a;regexp -nocas $p a} result options];list $code $result",
    "1 {bad option \"-nocas\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "Known difference local contract: option-dispatch-5432",
  )
  check_regexp_case(
    "set code [catch {set opt -nocas;regexp $opt a a} result options];list $code $result",
    "1 {bad option \"-nocas\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5433",
  )
  check_regexp_case(
    "set code [catch {set command regexp;$command -nocas a a} result options];list $code $result",
    "1 {bad option \"-nocas\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5434",
  )
  check_regexp_case(
    "set code [catch {regexp -nocas a a m} result options];list $code $result", "1 {bad option \"-nocas\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5435",
  )
  check_regexp_case(
    "set code [catch {rename regexp search;search -nocas a a} result options];list $code $result",
    "1 {bad option \"-nocas\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5436",
  )
  check_regexp_case(
    "set code [catch {eval [list regexp -nocas a a]} result options];list $code $result",
    "1 {bad option \"-nocas\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5437",
  )
  check_regexp_case(
    "set code [catch {regexp {*}[list -nocas a a]} result options];list $code $result",
    "1 {bad option \"-nocas\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5438",
  )
  check_regexp_case(
    "set code [catch {regsub -nocas a a x} result options];list $code $result", "1 {bad option \"-nocas\": must be -all, -nocase, -expanded, -line, -linestop, -lineanchor, -start, or --}",
    "", false, "option-dispatch-5439",
  )
}

///|
test "Tcl regexp cases 5441 through 5480" {
  check_regexp_case(
    "set code [catch {regexp -a a a} result options];list $code $result", "1 {bad option \"-a\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5440",
  )
  check_regexp_case(
    "set code [catch {set p a;regexp -a $p a} result options];list $code $result",
    "1 {bad option \"-a\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5441",
  )
  check_regexp_case(
    "set code [catch {set opt -a;regexp $opt a a} result options];list $code $result",
    "1 {bad option \"-a\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5442",
  )
  check_regexp_case(
    "set code [catch {set command regexp;$command -a a a} result options];list $code $result",
    "1 {bad option \"-a\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5443",
  )
  check_regexp_case(
    "set code [catch {regexp -a a a m} result options];list $code $result", "1 {bad option \"-a\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5444",
  )
  check_regexp_case(
    "set code [catch {rename regexp search;search -a a a} result options];list $code $result",
    "1 {bad option \"-a\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5445",
  )
  check_regexp_case(
    "set code [catch {eval [list regexp -a a a]} result options];list $code $result",
    "1 {bad option \"-a\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5446",
  )
  check_regexp_case(
    "set code [catch {regexp {*}[list -a a a]} result options];list $code $result",
    "1 {bad option \"-a\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5447",
  )
  check_regexp_case(
    "set code [catch {regsub -a a a x} result options];list $code $result", "1 {bad option \"-a\": must be -all, -nocase, -expanded, -line, -linestop, -lineanchor, -start, or --}",
    "", false, "option-dispatch-5448",
  )
  check_regexp_case(
    "set code [catch {regexp -al a a} result options];list $code $result", "1 {bad option \"-al\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5449",
  )
  check_regexp_case(
    "set code [catch {set p a;regexp -al $p a} result options];list $code $result",
    "1 {bad option \"-al\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5450",
  )
  check_regexp_case(
    "set code [catch {set opt -al;regexp $opt a a} result options];list $code $result",
    "1 {bad option \"-al\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5451",
  )
  check_regexp_case(
    "set code [catch {set command regexp;$command -al a a} result options];list $code $result",
    "1 {bad option \"-al\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5452",
  )
  check_regexp_case(
    "set code [catch {regexp -al a a m} result options];list $code $result", "1 {bad option \"-al\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5453",
  )
  check_regexp_case(
    "set code [catch {rename regexp search;search -al a a} result options];list $code $result",
    "1 {bad option \"-al\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5454",
  )
  check_regexp_case(
    "set code [catch {eval [list regexp -al a a]} result options];list $code $result",
    "1 {bad option \"-al\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5455",
  )
  check_regexp_case(
    "set code [catch {regexp {*}[list -al a a]} result options];list $code $result",
    "1 {bad option \"-al\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5456",
  )
  check_regexp_case(
    "set code [catch {regsub -al a a x} result options];list $code $result", "1 {bad option \"-al\": must be -all, -nocase, -expanded, -line, -linestop, -lineanchor, -start, or --}",
    "", false, "option-dispatch-5457",
  )
  check_regexp_case(
    "set code [catch {regexp -in a a} result options];list $code $result", "1 {bad option \"-in\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5458",
  )
  check_regexp_case(
    "set code [catch {set p a;regexp -in $p a} result options];list $code $result",
    "1 {bad option \"-in\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5459",
  )
  check_regexp_case(
    "set code [catch {set opt -in;regexp $opt a a} result options];list $code $result",
    "1 {bad option \"-in\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5460",
  )
  check_regexp_case(
    "set code [catch {set command regexp;$command -in a a} result options];list $code $result",
    "1 {bad option \"-in\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5461",
  )
  check_regexp_case(
    "set code [catch {regexp -in a a m} result options];list $code $result", "1 {bad option \"-in\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5462",
  )
  check_regexp_case(
    "set code [catch {rename regexp search;search -in a a} result options];list $code $result",
    "1 {bad option \"-in\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5463",
  )
  check_regexp_case(
    "set code [catch {eval [list regexp -in a a]} result options];list $code $result",
    "1 {bad option \"-in\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5464",
  )
  check_regexp_case(
    "set code [catch {regexp {*}[list -in a a]} result options];list $code $result",
    "1 {bad option \"-in\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5465",
  )
  check_regexp_case(
    "set code [catch {regsub -in a a x} result options];list $code $result", "1 {bad option \"-in\": must be -all, -nocase, -expanded, -line, -linestop, -lineanchor, -start, or --}",
    "", false, "option-dispatch-5466",
  )
  check_regexp_case(
    "set code [catch {regexp -l a a} result options];list $code $result", "1 {bad option \"-l\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5467",
  )
  check_regexp_case(
    "set code [catch {set p a;regexp -l $p a} result options];list $code $result",
    "1 {bad option \"-l\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5468",
  )
  check_regexp_case(
    "set code [catch {set opt -l;regexp $opt a a} result options];list $code $result",
    "1 {bad option \"-l\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5469",
  )
  check_regexp_case(
    "set code [catch {set command regexp;$command -l a a} result options];list $code $result",
    "1 {bad option \"-l\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5470",
  )
  check_regexp_case(
    "set code [catch {regexp -l a a m} result options];list $code $result", "1 {bad option \"-l\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5471",
  )
  check_regexp_case(
    "set code [catch {rename regexp search;search -l a a} result options];list $code $result",
    "1 {bad option \"-l\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5472",
  )
  check_regexp_case(
    "set code [catch {eval [list regexp -l a a]} result options];list $code $result",
    "1 {bad option \"-l\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5473",
  )
  check_regexp_case(
    "set code [catch {regexp {*}[list -l a a]} result options];list $code $result",
    "1 {bad option \"-l\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5474",
  )
  check_regexp_case(
    "set code [catch {regsub -l a a x} result options];list $code $result", "1 {bad option \"-l\": must be -all, -nocase, -expanded, -line, -linestop, -lineanchor, -start, or --}",
    "", false, "option-dispatch-5475",
  )
  check_regexp_case(
    "set code [catch {regexp -st a a} result options];list $code $result", "1 {bad option \"-st\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5476",
  )
  check_regexp_case(
    "set code [catch {set p a;regexp -st $p a} result options];list $code $result",
    "1 {bad option \"-st\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5477",
  )
  check_regexp_case(
    "set code [catch {set opt -st;regexp $opt a a} result options];list $code $result",
    "1 {bad option \"-st\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5478",
  )
  check_regexp_case(
    "set code [catch {set command regexp;$command -st a a} result options];list $code $result",
    "1 {bad option \"-st\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5479",
  )
}

///|
test "Tcl regexp cases 5481 through 5520" {
  check_regexp_case(
    "set code [catch {regexp -st a a m} result options];list $code $result", "1 {bad option \"-st\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5480",
  )
  check_regexp_case(
    "set code [catch {rename regexp search;search -st a a} result options];list $code $result",
    "1 {bad option \"-st\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5481",
  )
  check_regexp_case(
    "set code [catch {eval [list regexp -st a a]} result options];list $code $result",
    "1 {bad option \"-st\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5482",
  )
  check_regexp_case(
    "set code [catch {regexp {*}[list -st a a]} result options];list $code $result",
    "1 {bad option \"-st\": must be -all, -about, -indices, -inline, -expanded, -line, -linestop, -lineanchor, -nocase, -start, or --}",
    "", false, "option-dispatch-5483",
  )
  check_regexp_case(
    "set code [catch {regsub -st a a x} result options];list $code $result", "1 {bad option \"-st\": must be -all, -nocase, -expanded, -line, -linestop, -lineanchor, -start, or --}",
    "", false, "option-dispatch-5484",
  )
  check_regexp_case(
    "catch {regexp -start \"-4294967295\" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code]",
    "{{1 0}} 0", "", false, "index-extended-5485",
  )
  check_regexp_case(
    "catch {regexp -start \"-4294967296\" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code]",
    "{bad index \"-4294967296\": must be integer?[+-]integer? or end?[+-]integer?} 1",
    "", false, "index-extended-5486",
  )
  check_regexp_case(
    "catch {regexp -start \"end+1 \" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code]",
    "{{5 4}} 0", "", false, "index-extended-5487",
  )
  check_regexp_case(
    "catch {regexp -start \"end+ 1\" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code]",
    "{bad index \"end+ 1\": must be integer?[+-]integer? or end?[+-]integer?} 1",
    "", false, "index-extended-5488",
  )
  check_regexp_case(
    "catch {regexp -start \"end+08\" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code]",
    "{bad index \"end+08\": must be integer?[+-]integer? or end?[+-]integer?} 1",
    "", false, "index-extended-5489",
  )
  check_regexp_case(
    "catch {regexp -start \"08+1\" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code]",
    "{bad index \"08+1\": must be integer?[+-]integer? or end?[+-]integer?} 1", "",
    false, "index-extended-5490",
  )
  check_regexp_case(
    "catch {regexp -start \"1+08\" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code]",
    "{bad index \"1+08\": must be integer?[+-]integer? or end?[+-]integer?} 1", "",
    false, "index-extended-5491",
  )
  check_regexp_case(
    "catch {regexp -start \"-08\" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code]",
    "{bad index \"-08\": must be integer?[+-]integer? or end?[+-]integer? (looks like invalid octal number)} 1",
    "", false, "index-extended-5492",
  )
  check_regexp_case(
    "catch {regexp -start \"09x\" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code]",
    "{bad index \"09x\": must be integer?[+-]integer? or end?[+-]integer?} 1", "",
    false, "index-extended-5493",
  )
  check_regexp_case(
    "catch {regexp -start \"end+0x2\" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code]",
    "{{6 5}} 0", "", false, "index-extended-5494",
  )
  check_regexp_case(
    "catch {regexp -start \"1+2 \" -inline -indices -- \"\" \"abcd\"} r o;list $r [dict get $o -code]",
    "{{3 2}} 0", "", false, "index-extended-5495",
  )
  check_regexp_case(
    "array set a {};catch {regexp a a a} r o;list $r [dict get $o -errorcode]", "{can't set \"a\": variable is array} {TCL WRITE VARNAME}",
    "", false, "write-errors-5496",
  )
  check_regexp_case(
    "set a 0;catch {regexp a a a(x)} r o;list $r [dict get $o -errorcode]", "{can't set \"a(x)\": variable isn't array} {TCL LOOKUP VARNAME a}",
    "", false, "write-errors-5497",
  )
  check_regexp_case(
    "array set a {};catch {regsub a a x a} r o;list $r [dict get $o -errorcode]",
    "{can't set \"a\": variable is array} {TCL WRITE VARNAME}", "", false, "write-errors-5498",
  )
  check_regexp_case(
    "regexp -about -line -- \"(a|\\\\Y){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5499",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\A|\\\\M)\\\\M\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5500",
  )
  check_regexp_case(
    "regexp -about  -- \"((?!b)|\\\\y)(?:)\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5501",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[ab\\])\\\\1^\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_UIMPOSSIBLE}",
    "", false, "about-generated-5502",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[\\[:digit:\\]\\](?=a))?\\\\A\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5503",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=\\[ab\\](?!b))\\\\A\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5504",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\Z\\[^a\\])?\\\\Z\"", "1 {REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-5505",
  )
  check_regexp_case(
    "regexp -about  -- \"((?=a)|(?=a)){1,3}\"", "1 {REG_ULOOKAHEAD REG_UBOUNDS REG_UNONPOSIX}",
    "", false, "about-generated-5506",
  )
  check_regexp_case(
    "regexp -about -line -- \"(a|\\\\Z){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-5507",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\$b)?\\\\Z\"", "1 {REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-5508",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\Y)\\\\1a\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5509",
  )
  check_regexp_case(
    "regexp -about  -- \"(^|\\[ab\\])\\[\\[:alpha:\\]\\]\"", "1 REG_ULOCALE", "",
    false, "about-generated-5510",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\M|\\\\A)(?:)\"", "1 {REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5511",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\Y)\\\\1(?!b)\"", "1 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5512",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[\\[:alpha:\\]\\])(\\\\M)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-generated-5513",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=(?!b)(?!b))b\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5514",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=\\[^a\\]\\[^a\\])\\\\y\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5515",
  )
  check_regexp_case(
    "regexp -about  -- \"(^)\\\\1^\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-5516",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=(?!b)\\\\Z)\\$\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5517",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[\\[:digit:\\]\\]\\\\Y)?\\\\Y\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5518",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\$\\\\m)?\\\\A\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5519",
  )
}

///|
test "Tcl regexp cases 5521 through 5560" {
  check_regexp_case(
    "regexp -about  -- \"(?:\\[^a\\]\\\\n)*\\\\Z\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-5520",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=\\[\\[:digit:\\]\\]^)\\[\\[:alpha:\\]\\]\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5521",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\[\\[:alpha:\\]\\]\\[ab\\])*\\[ab\\]\"", "0 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5522",
  )
  check_regexp_case(
    "regexp -about  -- \"(a)\\\\1\\[^a\\]\"", "1 {REG_UBACKREF REG_UNONPOSIX}", "",
    false, "about-generated-5523",
  )
  check_regexp_case(
    "regexp -about  -- \"((?!b))(\\[ab\\])\\\\2\\\\1\"", "2 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5524",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=\\\\m\\\\n)b\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5525",
  )
  check_regexp_case(
    "regexp -about  -- \"(a\\\\n)?a\"", "1 REG_UNONPOSIX", "", false, "about-generated-5526",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\Z|\\\\A){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-5527",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\y|a){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5528",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:\\\\Y\\\\M)*\\\\A\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5529",
  )
  check_regexp_case(
    "regexp -about -line -- \"(a|(?!b)){1,3}\"", "1 {REG_ULOOKAHEAD REG_UBOUNDS REG_UNONPOSIX}",
    "", false, "about-generated-5530",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:(?!b)\\\\M)*\\\\Z\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5531",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\\\M\\[ab\\])*\\[ab\\]\"", "0 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5532",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\A|\\[\\[:digit:\\]\\])\\[\\[:digit:\\]\\]\"", "1 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5533",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[\\[:digit:\\]\\]|(?=a))b\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5534",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\Y|\\[\\[:digit:\\]\\]){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5535",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:^\\[\\[:digit:\\]\\])*a\"", "0 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5536",
  )
  check_regexp_case(
    "regexp -about  -- \"(b\\[\\[:alpha:\\]\\])?\\[ab\\]\"", "1 REG_ULOCALE", "",
    false, "about-generated-5537",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\n|(?!b)){1,3}\"", "1 {REG_ULOOKAHEAD REG_UBOUNDS REG_UNONPOSIX}",
    "", false, "about-generated-5538",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\M|\\[\\[:digit:\\]\\])\\[\\[:alpha:\\]\\]\"", "1 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5539",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\Y)\\\\1\\[^a\\]\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5540",
  )
  check_regexp_case(
    "regexp -about  -- \"((?=a)|(?:))\\[\\[:alpha:\\]\\]\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE}",
    "", false, "about-generated-5541",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=(?:)\\[\\[:alpha:\\]\\])\\$\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE}",
    "", false, "about-generated-5542",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=\\[\\[:digit:\\]\\]\\\\Z)^\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5543",
  )
  check_regexp_case(
    "regexp -about  -- \"((?!b))\\\\1\\\\A\"", "1 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5544",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=\\[\\[:alpha:\\]\\]\\\\Y).\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5545",
  )
  check_regexp_case(
    "regexp -about  -- \"(a)(\\\\y)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-generated-5546",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:a\\\\Z)*.\"", "0 REG_UNONPOSIX", "", false, "about-generated-5547",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\\\m\\\\Y)*\\[ab\\]\"", "0 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5548",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=\\\\n\\\\M)\\\\m\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5549",
  )
  check_regexp_case(
    "regexp -about  -- \"(b|(?=a))^\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-generated-5550",
  )
  check_regexp_case(
    "regexp -about -line -- \"((?=a))(a)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5551",
  )
  check_regexp_case(
    "regexp -about -line -- \"((?:))\\\\1b\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-generated-5552",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\m)\\\\1.\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5553",
  )
  check_regexp_case(
    "regexp -about -line -- \"((?!b))\\\\1(?:)\"", "1 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-generated-5554",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\A\\\\y)?\\[\\[:digit:\\]\\]\"", "1 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5555",
  )
  check_regexp_case(
    "regexp -about  -- \"((?=a)\\[\\[:digit:\\]\\])?a\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5556",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:\\\\Z\\\\M)*\\\\m\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5557",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\M)(\\\\Z)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5558",
  )
  check_regexp_case(
    "regexp -about  -- \"((?!b)|\\[ab\\]).\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5559",
  )
}

///|
test "Tcl regexp cases 5561 through 5600" {
  check_regexp_case(
    "regexp -about -line -- \"((?!b)\\\\y)?\\\\Y\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5560",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\A\\\\Y)?\\[\\[:alpha:\\]\\]\"", "1 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5561",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\n)(\\\\A)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_UIMPOSSIBLE}",
    "", false, "about-generated-5562",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\\\Ya)*\\\\Z\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5563",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=\\\\nb)\\\\m\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5564",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:a(?=a))*\\[ab\\]\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5565",
  )
  check_regexp_case(
    "regexp -about  -- \"(a\\[^a\\])?\\\\m\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5566",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=\\$.)\\[^a\\]\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5567",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\$|\\[^a\\]){1,3}\"", "1 {REG_UBOUNDS REG_UEMPTYMATCH}",
    "", false, "about-generated-5568",
  )
  check_regexp_case(
    "regexp -about -line -- \"(a|\\[\\[:alpha:\\]\\])a\"", "1 REG_ULOCALE", "", false,
    "about-generated-5569",
  )
  check_regexp_case(
    "regexp -about  -- \"(a|\\[ab\\]){1,3}\"", "1 REG_UBOUNDS", "", false, "about-generated-5570",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\y)(\\\\A)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5571",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:\\\\n\\$)*\\\\M\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5572",
  )
  check_regexp_case(
    "regexp -about -line -- \"(a\\[ab\\])?\\\\A\"", "1 {REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-5573",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:b\\[ab\\])*\\[ab\\]\"", "0 REG_UNONPOSIX", "", false,
    "about-generated-5574",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[^a\\]\\\\n)?\\\\M\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5575",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[^a\\]\\\\M)?\\[\\[:digit:\\]\\]\"", "1 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5576",
  )
  check_regexp_case(
    "regexp -about  -- \"((?!b)|\\\\A)\\[ab\\]\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5577",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=(?=a)\\\\M)\\[^a\\]\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5578",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\m|\\[\\[:alpha:\\]\\])\\[ab\\]\"", "1 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5579",
  )
  check_regexp_case(
    "regexp -about  -- \"(b.)?\\[^a\\]\"", "1 {}", "", false, "about-generated-5580",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\Z)\\\\1\\\\Y\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5581",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\M|a){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5582",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:\\\\n\\[\\[:digit:\\]\\])*\\[^a\\]\"", "0 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5583",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\y|b)\\\\Z\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5584",
  )
  check_regexp_case(
    "regexp -about -line -- \"(ba)?\\[\\[:alpha:\\]\\]\"", "1 REG_ULOCALE", "", false,
    "about-generated-5585",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[\\[:alpha:\\]\\]|(?!b))^\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5586",
  )
  check_regexp_case(
    "regexp -about  -- \"(.)(\\\\A)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_UIMPOSSIBLE}",
    "", false, "about-generated-5587",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=.a)\\\\n\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "",
    false, "about-generated-5588",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=(?:)\\\\Y)\\[\\[:digit:\\]\\]\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE}",
    "", false, "about-generated-5589",
  )
  check_regexp_case(
    "regexp -about  -- \"(.\\\\Y)?\\\\n\"", "1 {REG_UNONPOSIX REG_ULOCALE}", "",
    false, "about-generated-5590",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[^a\\])(\\\\A)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_UIMPOSSIBLE}",
    "", false, "about-generated-5591",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[\\[:alpha:\\]\\]\\\\m)?\\\\Y\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5592",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[^a\\]\\\\m)?^\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5593",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[\\[:alpha:\\]\\])(\\[ab\\])\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5594",
  )
  check_regexp_case(
    "regexp -about -line -- \"((?!b))(\\[\\[:digit:\\]\\])\\\\2\\\\1\"", "2 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5595",
  )
  check_regexp_case(
    "regexp -about -line -- \"(.|\\\\Z)^\"", "1 {REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-5596",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[ab\\])\\\\1b\"", "1 {REG_UBACKREF REG_UNONPOSIX}",
    "", false, "about-generated-5597",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\m|\\$)\\[\\[:digit:\\]\\]\"", "1 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5598",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\y\\\\Z)?\\\\Y\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5599",
  )
}

///|
test "Tcl regexp cases 5601 through 5640" {
  check_regexp_case(
    "regexp -about -line -- \"(?:..)*\\$\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-5600",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=\\\\M\\\\Y)b\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5601",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[^a\\])\\\\1\\\\m\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5602",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\y)\\\\1(?=a)\"", "1 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5603",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\m|(?:)){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5604",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:\\[\\[:alpha:\\]\\](?:))*\\\\Z\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5605",
  )
  check_regexp_case(
    "regexp -about -line -- \"((?!b))\\\\1\\[ab\\]\"", "1 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5606",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\$|\\\\A)\\[\\[:digit:\\]\\]\"", "1 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5607",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[\\[:digit:\\]\\])\\\\1^\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-generated-5608",
  )
  check_regexp_case(
    "regexp -about  -- \"((?:))(\\\\A)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-generated-5609",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\$|(?:)){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-generated-5610",
  )
  check_regexp_case(
    "regexp -about  -- \"((?=a))\\\\1\\\\M\"", "1 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5611",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\Y|^){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5612",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\[\\[:digit:\\]\\](?!b))*^\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5613",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=(?:)\\\\Z)\\[\\[:digit:\\]\\]\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE}",
    "", false, "about-generated-5614",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\A)\\\\1\\\\y\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5615",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\y)(b)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5616",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\Z)(\\\\Z)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-5617",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=(?=a)(?!b))\\\\y\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5618",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\[\\[:alpha:\\]\\]\\\\A)*^\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5619",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\m|^)\\\\A\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5620",
  )
  check_regexp_case(
    "regexp -about -line -- \"((?=a)|\\[^a\\]){1,3}\"", "1 {REG_ULOOKAHEAD REG_UBOUNDS REG_UNONPOSIX}",
    "", false, "about-generated-5621",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\A\\[ab\\])?\\\\m\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5622",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\Y|\\\\Z)\\\\n\"", "1 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5623",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\Z(?=a))?(?!b)\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5624",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\\\m\\[\\[:alpha:\\]\\])*a\"", "0 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5625",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\Y|\\\\Y)\\[\\[:alpha:\\]\\]\"", "1 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5626",
  )
  check_regexp_case(
    "regexp -about -line -- \"((?:)|\\[^a\\]){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-generated-5627",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\Y)((?:))\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5628",
  )
  check_regexp_case(
    "regexp -about  -- \"((?=a)a)?\\\\Y\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5629",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\m|(?!b)){1,3}\"", "1 {REG_ULOOKAHEAD REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5630",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[\\[:alpha:\\]\\]|\\\\m)\\$\"", "1 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5631",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\y|(?!b)){1,3}\"", "1 {REG_ULOOKAHEAD REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5632",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=(?=a).)(?:)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-generated-5633",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\Y)(\\\\Y)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5634",
  )
  check_regexp_case(
    "regexp -about  -- \"(b|\\\\A)\\\\m\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5635",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[\\[:alpha:\\]\\]|\\[\\[:digit:\\]\\]).\"", "1 REG_ULOCALE",
    "", false, "about-generated-5636",
  )
  check_regexp_case(
    "regexp -about  -- \"((?=a)|\\\\m)\\\\A\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5637",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\m|\\[\\[:digit:\\]\\])\\\\A\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5638",
  )
  check_regexp_case(
    "regexp -about  -- \"((?=a))(\\[\\[:alpha:\\]\\])\\\\2\\\\1\"", "2 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5639",
  )
}

///|
test "Tcl regexp cases 5641 through 5680" {
  check_regexp_case(
    "regexp -about  -- \"(\\\\Y\\[ab\\])?\\$\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5640",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=\\\\Y\\\\M)^\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5641",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\M)\\\\1(?!b)\"", "1 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5642",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[\\[:digit:\\]\\])\\\\1(?:)\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE}",
    "", false, "about-generated-5643",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:\\[\\[:alpha:\\]\\](?!b))*\\[\\[:digit:\\]\\]\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5644",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=\\\\m(?=a))\\\\y\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5645",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[\\[:alpha:\\]\\]|^).\"", "1 REG_ULOCALE", "", false,
    "about-generated-5646",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\Y|\\\\Y)\\\\Z\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5647",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\A^)?\\\\Y\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5648",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\n|b){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX}",
    "", false, "about-generated-5649",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\M)((?:))\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5650",
  )
  check_regexp_case(
    "regexp -about -line -- \"(.)\\\\1.\"", "1 {REG_UBACKREF REG_UNONPOSIX}", "",
    false, "about-generated-5651",
  )
  check_regexp_case(
    "regexp -about -line -- \"((?=a)\\\\Y)?\\\\M\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5652",
  )
  check_regexp_case(
    "regexp -about -line -- \"((?:)|(?:))\\\\m\"", "1 {REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5653",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\Z)\\\\1\\\\Y\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5654",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=(?=a)^)\\\\A\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5655",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[ab\\]|\\\\y){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5656",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\$)(.)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_UIMPOSSIBLE}",
    "", false, "about-generated-5657",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\[\\[:digit:\\]\\]b)*.\"", "0 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5658",
  )
  check_regexp_case(
    "regexp -about  -- \"(^|\\$){1,3}\"", "1 {REG_UBOUNDS REG_UEMPTYMATCH}", "",
    false, "about-generated-5659",
  )
  check_regexp_case(
    "regexp -about  -- \"((?:)|.){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-generated-5660",
  )
  check_regexp_case(
    "regexp -about  -- \"((?=a)|\\[\\[:alpha:\\]\\]){1,3}\"", "1 {REG_ULOOKAHEAD REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5661",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:\\\\m(?!b))*\\\\Z\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5662",
  )
  check_regexp_case(
    "regexp -about  -- \"((?=a)|(?=a)){1,3}\"", "1 {REG_ULOOKAHEAD REG_UBOUNDS REG_UNONPOSIX}",
    "", false, "about-generated-5663",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\n|\\\\Y)\\\\A\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5664",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\m|\\[\\[:digit:\\]\\])\\[^a\\]\"", "1 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5665",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:\\\\y\\$)*\\\\Z\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5666",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[\\[:alpha:\\]\\])\\\\1\\\\n\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5667",
  )
  check_regexp_case(
    "regexp -about  -- \"((?:)^)?\\[ab\\]\"", "1 {REG_UNONPOSIX REG_UUNSPEC}", "",
    false, "about-generated-5668",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=\\\\y(?!b))\\\\A\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5669",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=\\\\m\\\\M)\\\\Y\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5670",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[\\[:alpha:\\]\\]|\\[ab\\]){1,3}\"", "1 {REG_UBOUNDS REG_ULOCALE}",
    "", false, "about-generated-5671",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[^a\\])\\\\1(?=a)\"", "1 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5672",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[^a\\])\\\\1a\"", "1 {REG_UBACKREF REG_UNONPOSIX}",
    "", false, "about-generated-5673",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\Z\\\\A)?(?!b)\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5674",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[\\[:alpha:\\]\\])\\\\1(?=a)\"", "1 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5675",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\Z|\\\\M){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5676",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\Y)(\\$)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5677",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=\\[\\[:digit:\\]\\]^)\\\\M\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5678",
  )
  check_regexp_case(
    "regexp -about -line -- \"(^)\\\\1b\"", "1 {REG_UBACKREF REG_UNONPOSIX}", "",
    false, "about-generated-5679",
  )
}

///|
test "Tcl regexp cases 5681 through 5720" {
  check_regexp_case(
    "regexp -about  -- \"(\\\\m^)?^\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5680",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=\\[^a\\]\\\\A)b\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5681",
  )
  check_regexp_case(
    "regexp -about  -- \"((?:)|\\\\n)a\"", "1 {REG_UNONPOSIX REG_UUNSPEC}", "", false,
    "about-generated-5682",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\A)(\\[^a\\])\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_UIMPOSSIBLE}",
    "", false, "about-generated-5683",
  )
  check_regexp_case(
    "regexp -about -line -- \"(b\\\\n)?\\\\m\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5684",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:ba)*\\\\Z\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-5685",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\Y|(?:))\\\\M\"", "1 {REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5686",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\M\\\\m)?\\[\\[:digit:\\]\\]\"", "1 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5687",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\Y\\[\\[:digit:\\]\\])?\\\\A\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5688",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\n\\\\M)?(?!b)\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5689",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\[^a\\]\\[\\[:alpha:\\]\\])*a\"", "0 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5690",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=\\\\Y(?=a))\\\\A\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5691",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=.^)\\$\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-generated-5692",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\m)(\\[^a\\])\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5693",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=(?:).)\\\\n\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-generated-5694",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=\\\\n\\[ab\\])\\\\Z\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5695",
  )
  check_regexp_case(
    "regexp -about  -- \"(b)(\\\\M)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-generated-5696",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:^\\\\A)*\\\\Y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5697",
  )
  check_regexp_case(
    "regexp -about  -- \"((?=a)|b)\\\\n\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX}", "",
    false, "about-generated-5698",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=\\[^a\\]\\\\Z)\\\\Z\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5699",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=b\\[ab\\])b\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5700",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\m\\[\\[:digit:\\]\\])?\\[\\[:digit:\\]\\]\"", "1 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5701",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[\\[:digit:\\]\\])(\\$)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-generated-5702",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:ab)*\\[\\[:digit:\\]\\]\"", "0 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5703",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[ab\\]\\[^a\\])?(?:)\"", "1 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-generated-5704",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\$\\\\n)?.\"", "1 REG_UNONPOSIX", "", false, "about-generated-5705",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\y)((?=a))\\\\2\\\\1\"", "2 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5706",
  )
  check_regexp_case(
    "regexp -about -line -- \"((?=a)(?=a))?\\$\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-5707",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\$)\\\\1\\[\\[:alpha:\\]\\]\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-generated-5708",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\M|a)\\\\Y\"", "1 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5709",
  )
  check_regexp_case(
    "regexp -about -line -- \"((?!b))\\\\1(?:)\"", "1 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-generated-5710",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\m)(\\$)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-generated-5711",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=(?=a)\\\\m)\\$\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5712",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\n|\\\\Y)\\\\M\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-generated-5713",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\$)\\\\1\\\\y\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5714",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\Z.)?\\$\"", "1 {REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-5715",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\n|\\$){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-5716",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\[\\[:alpha:\\]\\]\\$)*\\\\Y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5717",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=^\\\\Y)\\\\A\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5718",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[ab\\])\\\\1\\\\y\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5719",
  )
}

///|
test "Tcl regexp cases 5721 through 5760" {
  check_regexp_case(
    "regexp -about  -- \"(a)(.)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX}", "",
    false, "about-generated-5720",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[ab\\])(\\[ab\\])\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX}",
    "", false, "about-generated-5721",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=^a)\\$\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}", "", false,
    "about-generated-5722",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=(?:)\\[ab\\])\\\\Y\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE}",
    "", false, "about-generated-5723",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[^a\\]|^)b\"", "1 {}", "", false, "about-generated-5724",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\n)\\\\1\\\\m\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5725",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\n|\\$){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-5726",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=\\[^a\\]\\\\y)\\\\Z\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5727",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:(?:)^)*\\[\\[:digit:\\]\\]\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE}",
    "", false, "about-generated-5728",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\[^a\\]\\[^a\\])*\\[\\[:alpha:\\]\\]\"", "0 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5729",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=(?!b)\\\\Z)(?!b)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5730",
  )
  check_regexp_case(
    "regexp -about  -- \"(a|\\$)\\\\n\"", "1 REG_UNONPOSIX", "", false, "about-generated-5731",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\[^a\\]\\\\n)*\\[\\[:digit:\\]\\]\"", "0 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5732",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\Ab)?\\[ab\\]\"", "1 REG_UNONPOSIX", "", false,
    "about-generated-5733",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\y(?:))?b\"", "1 {REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE}",
    "", false, "about-generated-5734",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=\\\\A\\\\m)\\\\y\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5735",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\m)((?!b))\\\\2\\\\1\"", "2 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5736",
  )
  check_regexp_case(
    "regexp -about -line -- \"(.|(?=a))(?:)\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-generated-5737",
  )
  check_regexp_case(
    "regexp -about -line -- \"((?=a))\\\\1\\\\Z\"", "1 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5738",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=\\\\Z\\\\y)\\\\A\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5739",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\M(?:))?^\"", "1 {REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5740",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\A)\\\\1\\\\m\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5741",
  )
  check_regexp_case(
    "regexp -about  -- \"(a|\\\\n){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX}", "",
    false, "about-generated-5742",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=\\\\M(?:))\\\\Z\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE}",
    "", false, "about-generated-5743",
  )
  check_regexp_case(
    "regexp -about -line -- \"(a|(?!b))(?!b)\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5744",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=\\[ab\\]\\\\M)\\\\M\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5745",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\y|a){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5746",
  )
  check_regexp_case(
    "regexp -about -line -- \"(a\\\\y)?\\\\A\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5747",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[\\[:alpha:\\]\\])\\\\1\\\\n\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5748",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[ab\\]\\[ab\\])?\\\\Z\"", "1 {REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-5749",
  )
  check_regexp_case(
    "regexp -about  -- \"((?=a))((?!b))\\\\2\\\\1\"", "2 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5750",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\n|\\\\A){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-5751",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[\\[:alpha:\\]\\])(^)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-generated-5752",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\\\Z\\[^a\\])*\\[\\[:digit:\\]\\]\"", "0 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5753",
  )
  check_regexp_case(
    "regexp -about -line -- \"((?:)\\$)?\\\\n\"", "1 {REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-generated-5754",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[ab\\]\\\\Y)?(?!b)\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5755",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=\\\\Y\\[ab\\])\\\\n\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5756",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\Y|(?!b))\\\\A\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5757",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\M)\\\\1\\\\A\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-generated-5758",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[ab\\])\\\\1^\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_UIMPOSSIBLE}",
    "", false, "about-generated-5759",
  )
}

///|
test "Tcl regexp cases 5761 through 5800" {
  check_regexp_case(
    "regexp -about -line -- \"(^|\\\\Y)\\\\Z\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5760",
  )
  check_regexp_case(
    "regexp -about  -- \"((?:)\\\\n)?\\[^a\\]\"", "1 {REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-generated-5761",
  )
  check_regexp_case(
    "regexp -about  -- \"((?=a))((?=a))\\\\2\\\\1\"", "2 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5762",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\y|b)\\\\A\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5763",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=\\[ab\\]a)\\\\Z\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5764",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=\\\\Aa)(?!b)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5765",
  )
  check_regexp_case(
    "regexp -about  -- \"(^|\\$)\\\\M\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5766",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\M|\\$)\\\\m\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-generated-5767",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\y)(\\[^a\\])\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5768",
  )
  check_regexp_case(
    "regexp -about  -- \"(^)(\\\\M)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-generated-5769",
  )
  check_regexp_case(
    "regexp -about  -- \"(^|.)\\\\n\"", "1 REG_UNONPOSIX", "", false, "about-generated-5770",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\y|b)\\[\\[:alpha:\\]\\]\"", "1 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5771",
  )
  check_regexp_case(
    "regexp -about  -- \"(.|(?:)){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-generated-5772",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=\\$\\\\y)\\\\y\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5773",
  )
  check_regexp_case(
    "regexp -about  -- \"((?=a)|b)(?:)\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-generated-5774",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=(?!b)\\\\y)\\[\\[:digit:\\]\\]\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5775",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\M|\\[\\[:alpha:\\]\\]){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5776",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:b\\\\Z)*.\"", "0 REG_UNONPOSIX", "", false, "about-generated-5777",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\\\y\\\\n)*\\[ab\\]\"", "0 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5778",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\Z)\\\\1\\$\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-5779",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[ab\\]|\\[\\[:alpha:\\]\\])\\\\y\"", "1 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5780",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=\\\\m\\\\Y)(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5781",
  )
  check_regexp_case(
    "regexp -about  -- \"(a|\\\\Y)\\\\y\"", "1 {REG_UNONPOSIX REG_ULOCALE}", "",
    false, "about-generated-5782",
  )
  check_regexp_case(
    "regexp -about  -- \"((?=a)|(?=a))\\[^a\\]\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5783",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[ab\\])\\\\1\\\\m\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-generated-5784",
  )
  check_regexp_case(
    "regexp -about  -- \"((?!b))\\\\1\\[^a\\]\"", "1 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5785",
  )
  check_regexp_case(
    "regexp -about -line -- \"(^\\\\y)?(?=a)\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5786",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\Z)\\\\1\\\\n\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_UIMPOSSIBLE}",
    "", false, "about-generated-5787",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\m\\\\Z)?\\\\m\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5788",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:b\\\\M)*\\[\\[:alpha:\\]\\]\"", "0 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5789",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=(?!b)\\[\\[:digit:\\]\\])\\\\Z\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5790",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\M|\\[ab\\])b\"", "1 {REG_UNONPOSIX REG_ULOCALE}", "",
    false, "about-generated-5791",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\Y\\\\m)?\\[\\[:alpha:\\]\\]\"", "1 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5792",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\$|\\$){1,3}\"", "1 {REG_UBOUNDS REG_UEMPTYMATCH}", "",
    false, "about-generated-5793",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\$|^)\\\\n\"", "1 REG_UNONPOSIX", "", false, "about-generated-5794",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\M|(?!b)){1,3}\"", "1 {REG_ULOOKAHEAD REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5795",
  )
  check_regexp_case(
    "regexp -about -line -- \"((?:)|\\\\Y){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5796",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\n\\\\y)?(?:)\"", "1 {REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5797",
  )
  check_regexp_case(
    "regexp -about  -- \"((?=a)|.)\\[^a\\]\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5798",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\[ab\\]\\[\\[:alpha:\\]\\])*\\\\Z\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5799",
  )
}

///|
test "Tcl regexp cases 5801 through 5840" {
  check_regexp_case(
    "regexp -about -line -- \"(?=(?:)(?!b))\\$\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-generated-5800",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[\\[:digit:\\]\\]|a)(?:)\"", "1 {REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE}",
    "", false, "about-generated-5801",
  )
  check_regexp_case(
    "regexp -about -line -- \"(.\\$)?\\\\y\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5802",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\y|(?=a))(?=a)\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5803",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[^a\\])(\\\\A)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_UIMPOSSIBLE}",
    "", false, "about-generated-5804",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\M|.){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5805",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[\\[:digit:\\]\\])(\\[ab\\])\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5806",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\y)(\\[ab\\])\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5807",
  )
  check_regexp_case(
    "regexp -about  -- \"((?:))((?!b))\\\\2\\\\1\"", "2 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-generated-5808",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\[\\[:digit:\\]\\]\\[^a\\])*b\"", "0 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5809",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\A)\\\\1.\"", "1 {REG_UBACKREF REG_UNONPOSIX}",
    "", false, "about-generated-5810",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\Y)\\\\1\\[\\[:digit:\\]\\]\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5811",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\n(?=a))?(?:)\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-generated-5812",
  )
  check_regexp_case(
    "regexp -about  -- \"(b\\[^a\\])?\\[ab\\]\"", "1 {}", "", false, "about-generated-5813",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\A)(\\\\m)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5814",
  )
  check_regexp_case(
    "regexp -about  -- \"((?!b))\\\\1b\"", "1 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5815",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\m(?=a))?(?:)\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5816",
  )
  check_regexp_case(
    "regexp -about -line -- \"(^|\\\\Y)\\\\Y\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5817",
  )
  check_regexp_case(
    "regexp -about -line -- \"(a)((?:))\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-generated-5818",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=\\\\y\\\\n)(?!b)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5819",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[\\[:digit:\\]\\])\\\\1\\\\Y\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5820",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\Z|\\[\\[:digit:\\]\\])(?:)\"", "1 {REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5821",
  )
  check_regexp_case(
    "regexp -about  -- \"((?=a))(\\[ab\\])\\\\2\\\\1\"", "2 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5822",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:a\\$)*a\"", "0 REG_UNONPOSIX", "", false, "about-generated-5823",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\M)(\\\\y)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5824",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=.a)\\\\M\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5825",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=\\\\Z\\[\\[:digit:\\]\\])(?!b)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5826",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\$|\\\\y)\\\\n\"", "1 {REG_UNONPOSIX REG_ULOCALE}", "",
    false, "about-generated-5827",
  )
  check_regexp_case(
    "regexp -about -line -- \"(b|^)(?!b)\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5828",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=ba)(?:)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-generated-5829",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=^\\[ab\\])\\[^a\\]\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5830",
  )
  check_regexp_case(
    "regexp -about  -- \"(.)(b)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX}", "",
    false, "about-generated-5831",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\Y\\\\n)?\\[ab\\]\"", "1 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5832",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:b\\\\y)*\\\\n\"", "0 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5833",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=\\\\Y\\\\A)\\\\y\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5834",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=\\\\Z.)\\\\A\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5835",
  )
  check_regexp_case(
    "regexp -about  -- \"((?!b)|\\[^a\\]){1,3}\"", "1 {REG_ULOOKAHEAD REG_UBOUNDS REG_UNONPOSIX}",
    "", false, "about-generated-5836",
  )
  check_regexp_case(
    "regexp -about  -- \"(^)\\\\1\\\\m\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5837",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=\\\\na)\\[\\[:digit:\\]\\]\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5838",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\n)\\\\1.\"", "1 {REG_UBACKREF REG_UNONPOSIX}",
    "", false, "about-generated-5839",
  )
}

///|
test "Tcl regexp cases 5841 through 5880" {
  check_regexp_case(
    "regexp -about  -- \"((?:)|\\\\Z){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-generated-5840",
  )
  check_regexp_case(
    "regexp -about -line -- \"((?:)|\\[\\[:digit:\\]\\]){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5841",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\$|a){1,3}\"", "1 {REG_UBOUNDS REG_UEMPTYMATCH}",
    "", false, "about-generated-5842",
  )
  check_regexp_case(
    "regexp -about  -- \"((?:)|b){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-generated-5843",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\\\A\\\\Z)*\\$\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-5844",
  )
  check_regexp_case(
    "regexp -about -line -- \"(b|b)(?!b)\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5845",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\y)\\\\1\\\\A\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5846",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=\\[\\[:alpha:\\]\\]\\\\m)\\\\Y\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5847",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:.\\$)*\\[ab\\]\"", "0 REG_UNONPOSIX", "", false, "about-generated-5848",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=\\\\Z\\\\y)\\[ab\\]\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5849",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=\\[\\[:alpha:\\]\\]\\[^a\\])\\\\M\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5850",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\[\\[:digit:\\]\\]\\\\y)*\\\\y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5851",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\$|^)(?!b)\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX}", "",
    false, "about-generated-5852",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\\\n\\[\\[:alpha:\\]\\])*a\"", "0 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5853",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=\\[\\[:digit:\\]\\]\\[\\[:digit:\\]\\])\\[ab\\]\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5854",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:(?=a)\\\\n)*\\\\n\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5855",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\M)\\\\1\\\\M\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5856",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=\\[ab\\]\\\\Y).\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5857",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\A\\\\y)?\\[^a\\]\"", "1 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5858",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\m)(\\\\n)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-generated-5859",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\$|\\\\m)(?=a)\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5860",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:b(?!b))*(?:)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-generated-5861",
  )
  check_regexp_case(
    "regexp -about -line -- \"(.)\\\\1\\\\Z\"", "1 {REG_UBACKREF REG_UNONPOSIX}",
    "", false, "about-generated-5862",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=\\[\\[:digit:\\]\\]a)\\\\n\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5863",
  )
  check_regexp_case(
    "regexp -about  -- \"((?=a)|\\\\Y){1,3}\"", "1 {REG_ULOOKAHEAD REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5864",
  )
  check_regexp_case(
    "regexp -about -line -- \"(b|\\$)\\\\A\"", "1 {REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-5865",
  )
  check_regexp_case(
    "regexp -about -line -- \"(b|\\\\Z){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-5866",
  )
  check_regexp_case(
    "regexp -about -line -- \"((?:)|(?=a))\\\\m\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5867",
  )
  check_regexp_case(
    "regexp -about -line -- \"(^|\\\\Z)\\[\\[:digit:\\]\\]\"", "1 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5868",
  )
  check_regexp_case(
    "regexp -about  -- \"((?=a)|\\[\\[:digit:\\]\\])\\\\y\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5869",
  )
  check_regexp_case(
    "regexp -about  -- \"((?!b)|^)\\\\A\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-5870",
  )
  check_regexp_case(
    "regexp -about -line -- \"((?!b)|\\\\n){1,3}\"", "1 {REG_ULOOKAHEAD REG_UBOUNDS REG_UNONPOSIX}",
    "", false, "about-generated-5871",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:\\[\\[:digit:\\]\\]\\[\\[:alpha:\\]\\])*\\\\M\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5872",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[ab\\]|b)\\\\Z\"", "1 REG_UNONPOSIX", "", false,
    "about-generated-5873",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:.\\\\Y)*(?!b)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5874",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=(?!b)\\$)\\[^a\\]\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5875",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:\\\\Z\\$)*\\[\\[:alpha:\\]\\]\"", "0 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5876",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\y|^){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5877",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:\\\\n\\\\y)*\\[\\[:digit:\\]\\]\"", "0 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5878",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[ab\\]|\\[^a\\]){1,3}\"", "1 REG_UBOUNDS", "", false,
    "about-generated-5879",
  )
}

///|
test "Tcl regexp cases 5881 through 5920" {
  check_regexp_case(
    "regexp -about -line -- \"(\\[\\[:digit:\\]\\]a)?\\\\y\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5880",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:(?:)(?=a))*\\\\Z\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-generated-5881",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[\\[:digit:\\]\\]|\\[\\[:digit:\\]\\])(?!b)\"",
    "1 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}", "", false, "about-generated-5882",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[ab\\]\\[\\[:digit:\\]\\])?\\\\y\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5883",
  )
  check_regexp_case(
    "regexp -about  -- \"(b\\\\A)?(?:)\"", "1 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-generated-5884",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\y\\\\y)?\\\\M\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5885",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\M(?=a))?\\\\A\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5886",
  )
  check_regexp_case(
    "regexp -about  -- \"((?!b)|(?!b)){1,3}\"", "1 {REG_ULOOKAHEAD REG_UBOUNDS REG_UNONPOSIX}",
    "", false, "about-generated-5887",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\\\Y^)*^\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5888",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=(?:)\\[^a\\])\\\\A\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-generated-5889",
  )
  check_regexp_case(
    "regexp -about  -- \"((?!b))(\\\\Y)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5890",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\A|\\\\y){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5891",
  )
  check_regexp_case(
    "regexp -about  -- \"(^)(\\\\y)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5892",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=.\\\\Z)\\\\y\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5893",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[\\[:digit:\\]\\]|\\\\y){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5894",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[\\[:alpha:\\]\\])(\\[ab\\])\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5895",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\n)\\\\1\\[\\[:alpha:\\]\\]\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5896",
  )
  check_regexp_case(
    "regexp -about -line -- \"((?:))(\\[ab\\])\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-generated-5897",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[\\[:alpha:\\]\\])(\\[\\[:alpha:\\]\\])\\\\2\\\\1\"",
    "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}", "", false, "about-generated-5898",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=(?=a)\\$)(?:)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-generated-5899",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\Z\\$)?(?:)\"", "1 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-generated-5900",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=\\[\\[:alpha:\\]\\]\\\\A)(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5901",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\Y|\\[\\[:digit:\\]\\])\\[ab\\]\"", "1 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5902",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=.(?!b))\\\\A\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5903",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[^a\\]\\\\y)?\\[\\[:alpha:\\]\\]\"", "1 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5904",
  )
  check_regexp_case(
    "regexp -about  -- \"(.)\\\\1\\\\y\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5905",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:a(?!b))*\\\\A\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-5906",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=(?!b)\\\\Z)^\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5907",
  )
  check_regexp_case(
    "regexp -about -line -- \"(.\\[\\[:alpha:\\]\\])?\\[^a\\]\"", "1 REG_ULOCALE",
    "", false, "about-generated-5908",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\$|\\\\A){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-5909",
  )
  check_regexp_case(
    "regexp -about -line -- \"(.)\\\\1\\$\"", "1 {REG_UBACKREF REG_UNONPOSIX}", "",
    false, "about-generated-5910",
  )
  check_regexp_case(
    "regexp -about  -- \"(a)\\\\1\\\\Z\"", "1 {REG_UBACKREF REG_UNONPOSIX}", "",
    false, "about-generated-5911",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[\\[:digit:\\]\\]|\\[\\[:alpha:\\]\\])\\\\Y\"", "1 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5912",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:(?!b)(?=a))*\\\\A\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-5913",
  )
  check_regexp_case(
    "regexp -about  -- \"(b)\\\\1\\\\M\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5914",
  )
  check_regexp_case(
    "regexp -about -line -- \"((?=a))\\\\1\\$\"", "1 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5915",
  )
  check_regexp_case(
    "regexp -about -line -- \"(b|\\\\Z)\\\\n\"", "1 REG_UNONPOSIX", "", false, "about-generated-5916",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[^a\\])((?:))\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-generated-5917",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\y|\\\\Z){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5918",
  )
  check_regexp_case(
    "regexp -about -line -- \"((?:)|^){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-generated-5919",
  )
}

///|
test "Tcl regexp cases 5921 through 5960" {
  check_regexp_case(
    "regexp -about -line -- \"(\\\\Y|\\\\Y)\\[\\[:alpha:\\]\\]\"", "1 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5920",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:.a)*b\"", "0 REG_UNONPOSIX", "", false, "about-generated-5921",
  )
  check_regexp_case(
    "regexp -about -line -- \"((?!b))(\\\\Y)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5922",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[\\[:alpha:\\]\\])\\\\1\\\\m\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-generated-5923",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[ab\\])(\\\\M)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-generated-5924",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\A)(\\\\Z)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-5925",
  )
  check_regexp_case(
    "regexp -about  -- \"(^)(.)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_UIMPOSSIBLE}",
    "", false, "about-generated-5926",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\M.)?b\"", "1 {REG_UNONPOSIX REG_ULOCALE}", "",
    false, "about-generated-5927",
  )
  check_regexp_case(
    "regexp -about  -- \"(^\\\\A)?\\\\m\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5928",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=\\[\\[:alpha:\\]\\]\\[^a\\])\\\\Y\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5929",
  )
  check_regexp_case(
    "regexp -about  -- \"(.|a){1,3}\"", "1 REG_UBOUNDS", "", false, "about-generated-5930",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\$)(\\\\n)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_UIMPOSSIBLE}",
    "", false, "about-generated-5931",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\[\\[:alpha:\\]\\](?!b))*\\\\A\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5932",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\M)\\\\1\\\\A\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-generated-5933",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:.^)*(?:)\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-generated-5934",
  )
  check_regexp_case(
    "regexp -about -line -- \"(^(?:))?\\$\"", "1 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-generated-5935",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[\\[:alpha:\\]\\])(.)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5936",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[\\[:alpha:\\]\\]|\\\\Y)\\$\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5937",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\m|\\\\Z)b\"", "1 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5938",
  )
  check_regexp_case(
    "regexp -about -line -- \"(^)(\\[^a\\])\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_UIMPOSSIBLE}",
    "", false, "about-generated-5939",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\Y)(a)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5940",
  )
  check_regexp_case(
    "regexp -about -line -- \"(^)(.)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_UIMPOSSIBLE}",
    "", false, "about-generated-5941",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[\\[:alpha:\\]\\])\\\\1\\$\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5942",
  )
  check_regexp_case(
    "regexp -about  -- \"(^)(\\\\M)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-generated-5943",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=(?=a)\\[\\[:digit:\\]\\])(?!b)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5944",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:a\\[^a\\])*b\"", "0 REG_UNONPOSIX", "", false, "about-generated-5945",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\M|\\[\\[:alpha:\\]\\])(?=a)\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5946",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[^a\\])(^)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_UIMPOSSIBLE}",
    "", false, "about-generated-5947",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\y)\\\\1\\\\M\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5948",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[ab\\])(\\\\Y)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5949",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=.\\\\m)\\[\\[:digit:\\]\\]\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5950",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\n)\\\\1.\"", "1 {REG_UBACKREF REG_UNONPOSIX}",
    "", false, "about-generated-5951",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[ab\\]|\\$)\\[ab\\]\"", "1 {}", "", false, "about-generated-5952",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[\\[:digit:\\]\\]|^)\\\\Y\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5953",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=.\\\\y)\\\\y\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5954",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[ab\\])(\\[^a\\])\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX}",
    "", false, "about-generated-5955",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[ab\\])\\\\1a\"", "1 {REG_UBACKREF REG_UNONPOSIX}",
    "", false, "about-generated-5956",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\Y)\\\\1(?!b)\"", "1 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5957",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:(?:)\\\\y)*(?:)\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5958",
  )
  check_regexp_case(
    "regexp -about -line -- \"((?:)|\\\\n){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-generated-5959",
  )
}

///|
test "Tcl regexp cases 5961 through 6000" {
  check_regexp_case(
    "regexp -about -line -- \"(^|\\\\Y){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5960",
  )
  check_regexp_case(
    "regexp -about -line -- \"(b)\\\\1\\\\M\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5961",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[\\[:alpha:\\]\\]|\\[\\[:digit:\\]\\]){1,3}\"", "1 {REG_UBOUNDS REG_ULOCALE}",
    "", false, "about-generated-5962",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:^.)*\\\\n\"", "0 REG_UNONPOSIX", "", false, "about-generated-5963",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[^a\\]|\\\\n){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX}",
    "", false, "about-generated-5964",
  )
  check_regexp_case(
    "regexp -about  -- \"(^)(\\[^a\\])\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_UIMPOSSIBLE}",
    "", false, "about-generated-5965",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\Y|\\$){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5966",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\m|\\[ab\\])\\$\"", "1 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5967",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\A\\\\y)?\\[\\[:digit:\\]\\]\"", "1 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5968",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:\\[\\[:alpha:\\]\\]\\[^a\\])*(?:)\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5969",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=\\\\M\\\\y)\\$\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5970",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\m|\\[^a\\])\\\\A\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5971",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\Y\\[\\[:digit:\\]\\])?\\$\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5972",
  )
  check_regexp_case(
    "regexp -about  -- \"(b)\\\\1\\$\"", "1 {REG_UBACKREF REG_UNONPOSIX}", "", false,
    "about-generated-5973",
  )
  check_regexp_case(
    "regexp -about -line -- \"(a)\\\\1\\$\"", "1 {REG_UBACKREF REG_UNONPOSIX}", "",
    false, "about-generated-5974",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:.b)*\\[^a\\]\"", "0 REG_UNONPOSIX", "", false, "about-generated-5975",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[\\[:digit:\\]\\]|(?!b))\\\\n\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5976",
  )
  check_regexp_case(
    "regexp -about -line -- \"((?!b)^)?^\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-5977",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\A|\\\\Y)^\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5978",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:.\\[\\[:digit:\\]\\])*\\[^a\\]\"", "0 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5979",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[ab\\]|\\[\\[:alpha:\\]\\])\\\\A\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-generated-5980",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\Z)(\\\\n)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_UIMPOSSIBLE}",
    "", false, "about-generated-5981",
  )
  check_regexp_case(
    "regexp -about  -- \"((?=a)|\\\\M){1,3}\"", "1 {REG_ULOOKAHEAD REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5982",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\$|\\\\y)\\\\Z\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5983",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\M)\\\\1\\[\\[:digit:\\]\\]\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-generated-5984",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[^a\\])(b)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX}",
    "", false, "about-generated-5985",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\y|\\[^a\\])(?!b)\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5986",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\\\n^)*\\\\Y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5987",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[ab\\])\\\\1(?:)\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-generated-5988",
  )
  check_regexp_case(
    "regexp -about  -- \"((?!b)|(?!b))(?!b)\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5989",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[ab\\])\\\\1\\\\n\"", "1 {REG_UBACKREF REG_UNONPOSIX}",
    "", false, "about-generated-5990",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=.\\\\y)\\[^a\\]\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5991",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:.a)*\\\\y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5992",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\y)(\\$)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5993",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\$(?=a))?\\\\Z\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-5994",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=\\\\n\\[^a\\]).\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5995",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\y)(\\\\Z)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-5996",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=(?!b)a)a\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-5997",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[^a\\])(a)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX}",
    "", false, "about-generated-5998",
  )
  check_regexp_case(
    "regexp -about  -- \"(.)(\\\\Y)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-5999",
  )
}

///|
test "Tcl regexp cases 6001 through 6040" {
  check_regexp_case(
    "regexp -about -line -- \"(.)(b)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX}",
    "", false, "about-generated-6000",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\n|(?!b))^\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX}", "",
    false, "about-generated-6001",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[\\[:alpha:\\]\\]|\\\\n)\\\\A\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-generated-6002",
  )
  check_regexp_case(
    "regexp -about -line -- \"(a)(\\[\\[:alpha:\\]\\])\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6003",
  )
  check_regexp_case(
    "regexp -about -line -- \"(^|\\\\Y)\\\\m\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6004",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=\\[\\[:alpha:\\]\\](?:))\\[^a\\]\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE}",
    "", false, "about-generated-6005",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\y|\\\\y)\\\\m\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6006",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=\\\\n\\[^a\\])\\[\\[:digit:\\]\\]\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6007",
  )
  check_regexp_case(
    "regexp -about  -- \"(.)\\\\1\\\\Z\"", "1 {REG_UBACKREF REG_UNONPOSIX}", "",
    false, "about-generated-6008",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=(?:)\\\\Z)(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-generated-6009",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[^a\\]|\\\\y)\\\\m\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6010",
  )
  check_regexp_case(
    "regexp -about  -- \"((?!b))(\\[^a\\])\\\\2\\\\1\"", "2 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-6011",
  )
  check_regexp_case(
    "regexp -about -line -- \"(^\\[\\[:digit:\\]\\])?(?=a)\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6012",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=\\[^a\\](?=a))\\[\\[:alpha:\\]\\]\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6013",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:(?:)(?:))*^\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-generated-6014",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:\\[ab\\]\\\\Y)*(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6015",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=\\\\y.)a\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6016",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[^a\\]|\\\\A){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-6017",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\n)\\\\1a\"", "1 {REG_UBACKREF REG_UNONPOSIX}", "",
    false, "about-generated-6018",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\\\M\\\\n)*\\\\y\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6019",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\n(?:))?\\\\Z\"", "1 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-generated-6020",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\Y|\\\\Y)a\"", "1 {REG_UNONPOSIX REG_ULOCALE}", "",
    false, "about-generated-6021",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\m)(\\\\m)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6022",
  )
  check_regexp_case(
    "regexp -about -line -- \"((?=a))\\\\1a\"", "1 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-6023",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\[^a\\]\\\\n)*\\[\\[:digit:\\]\\]\"", "0 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6024",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\m|\\[\\[:alpha:\\]\\]){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6025",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:\\\\Y.)*\\\\M\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6026",
  )
  check_regexp_case(
    "regexp -about  -- \"(^|^)(?:)\"", "1 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-generated-6027",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\A|\\[\\[:digit:\\]\\])\\\\y\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6028",
  )
  check_regexp_case(
    "regexp -about -line -- \"(^)(\\\\Y)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6029",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=(?=a)\\\\Y)\\[^a\\]\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6030",
  )
  check_regexp_case(
    "regexp -about -line -- \"(a)(\\\\m)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-generated-6031",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\m|\\[\\[:alpha:\\]\\])^\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6032",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[^a\\])\\\\1\\\\M\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6033",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[^a\\]|\\\\m){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6034",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[\\[:digit:\\]\\](?=a))?b\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6035",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[ab\\])(\\\\A)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_UIMPOSSIBLE}",
    "", false, "about-generated-6036",
  )
  check_regexp_case(
    "regexp -about  -- \"((?=a)|(?=a)){1,3}\"", "1 {REG_ULOOKAHEAD REG_UBOUNDS REG_UNONPOSIX}",
    "", false, "about-generated-6037",
  )
  check_regexp_case(
    "regexp -about -line -- \"((?!b)|(?=a))\\\\M\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6038",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\\\Z\\\\A)*a\"", "0 REG_UNONPOSIX", "", false,
    "about-generated-6039",
  )
}

///|
test "Tcl regexp cases 6041 through 6080" {
  check_regexp_case(
    "regexp -about -line -- \"(?:a\\[\\[:alpha:\\]\\])*\\$\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6040",
  )
  check_regexp_case(
    "regexp -about -line -- \"((?:)\\\\Z)?\\\\Z\"", "1 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-generated-6041",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[^a\\]|b)a\"", "1 {}", "", false, "about-generated-6042",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\n)\\\\1\\\\n\"", "1 {REG_UBACKREF REG_UNONPOSIX}",
    "", false, "about-generated-6043",
  )
  check_regexp_case(
    "regexp -about -line -- \"((?=a)\\\\A)?(?!b)\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-6044",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[\\[:alpha:\\]\\]\\[ab\\])?\\\\Y\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6045",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=\\[\\[:digit:\\]\\]\\\\A).\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6046",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\\\y\\\\Y)*\\[\\[:alpha:\\]\\]\"", "0 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6047",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=\\$\\[^a\\])a\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-6048",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:\\\\M\\\\n)*\\\\m\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6049",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\A|\\\\m)\\\\M\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-generated-6050",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:\\\\m\\\\M)*\\[\\[:alpha:\\]\\]\"", "0 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6051",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\M|\\\\M)\\[ab\\]\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-generated-6052",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\\\y\\$)*b\"", "0 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6053",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\Y)\\\\1\\\\n\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6054",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\m)(\\[\\[:alpha:\\]\\])\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-generated-6055",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\[\\[:digit:\\]\\]\\\\Y)*\\\\n\"", "0 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6056",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[^a\\]|b)\\[\\[:alpha:\\]\\]\"", "1 REG_ULOCALE",
    "", false, "about-generated-6057",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:b\\\\y)*\\\\Z\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6058",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\m)(.)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6059",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:(?:).)*\\[\\[:digit:\\]\\]\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE}",
    "", false, "about-generated-6060",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[\\[:digit:\\]\\])\\\\1a\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6061",
  )
  check_regexp_case(
    "regexp -about -line -- \"((?!b))(\\$)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-6062",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[\\[:digit:\\]\\])\\\\1a\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6063",
  )
  check_regexp_case(
    "regexp -about  -- \"(.|\\\\A)\\[^a\\]\"", "1 REG_UNONPOSIX", "", false, "about-generated-6064",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=b\\\\n)\\[^a\\]\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-6065",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[\\[:alpha:\\]\\]|a){1,3}\"", "1 {REG_UBOUNDS REG_ULOCALE}",
    "", false, "about-generated-6066",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\Y)\\\\1\\\\n\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6067",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\\\Y\\\\y)*^\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6068",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\\\n^)*\\\\n\"", "0 REG_UNONPOSIX", "", false,
    "about-generated-6069",
  )
  check_regexp_case(
    "regexp -about  -- \"(..)?b\"", "1 {}", "", false, "about-generated-6070",
  )
  check_regexp_case(
    "regexp -about  -- \"(a)\\\\1\\[ab\\]\"", "1 {REG_UBACKREF REG_UNONPOSIX}", "",
    false, "about-generated-6071",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\\\yb)*\\[\\[:digit:\\]\\]\"", "0 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6072",
  )
  check_regexp_case(
    "regexp -about -line -- \"(a|^){1,3}\"", "1 {REG_UBOUNDS REG_UEMPTYMATCH}", "",
    false, "about-generated-6073",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\$|\\\\A)\\\\Y\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6074",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\m|\\\\m)\\\\A\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6075",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:^(?:))*\\[\\[:alpha:\\]\\]\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE}",
    "", false, "about-generated-6076",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\Z\\[^a\\])?\\\\A\"", "1 {REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-6077",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\$.)*\\\\n\"", "0 REG_UNONPOSIX", "", false, "about-generated-6078",
  )
  check_regexp_case(
    "regexp -about -line -- \"(.)\\\\1\\\\m\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6079",
  )
}

///|
test "Tcl regexp cases 6081 through 6120" {
  check_regexp_case(
    "regexp -about  -- \"(?:\\\\Z\\[\\[:alpha:\\]\\])*\\[\\[:digit:\\]\\]\"", "0 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6080",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\$)(b)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_UIMPOSSIBLE}",
    "", false, "about-generated-6081",
  )
  check_regexp_case(
    "regexp -about  -- \"((?!b))(\\\\Z)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-6082",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\Z)\\\\1\\\\Y\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6083",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=.\\\\Y)\\\\Z\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6084",
  )
  check_regexp_case(
    "regexp -about  -- \"(^|\\\\n){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-6085",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\Z|(?!b))\\\\A\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-6086",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\$|(?:))^\"", "1 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-generated-6087",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=\\\\A(?!b))\\$\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-6088",
  )
  check_regexp_case(
    "regexp -about  -- \"(b\\[^a\\])?\\$\"", "1 REG_UEMPTYMATCH", "", false, "about-generated-6089",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[\\[:digit:\\]\\])(\\$)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-generated-6090",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[\\[:alpha:\\]\\]|\\\\M){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6091",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\A|\\\\A){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-6092",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:(?:)\\[^a\\])*(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-generated-6093",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:\\\\A\\[\\[:alpha:\\]\\])*\\[\\[:digit:\\]\\]\"", "0 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6094",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\n|\\\\M)\\$\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6095",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\M\\[ab\\])?^\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6096",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[^a\\]|\\\\Y)(?=a)\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6097",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\m|.)\\[\\[:digit:\\]\\]\"", "1 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6098",
  )
  check_regexp_case(
    "regexp -about  -- \"((?:))(\\\\n)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-generated-6099",
  )
  check_regexp_case(
    "regexp -about  -- \"((?!b))(b)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-6100",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[\\[:digit:\\]\\])\\\\1\\[ab\\]\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6101",
  )
  check_regexp_case(
    "regexp -about -line -- \"(a)(b)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX}",
    "", false, "about-generated-6102",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[ab\\]\\\\y)?\\\\Y\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6103",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\y|\\[\\[:digit:\\]\\]){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6104",
  )
  check_regexp_case(
    "regexp -about  -- \"(^\\\\M)?\\[\\[:alpha:\\]\\]\"", "1 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6105",
  )
  check_regexp_case(
    "regexp -about  -- \"(^(?!b))?\\\\n\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX}", "",
    false, "about-generated-6106",
  )
  check_regexp_case(
    "regexp -about  -- \"(.)\\\\1(?:)\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-generated-6107",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[^a\\])(\\\\n)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX}",
    "", false, "about-generated-6108",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\\\Y(?:))*\\[\\[:digit:\\]\\]\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE}",
    "", false, "about-generated-6109",
  )
  check_regexp_case(
    "regexp -about -line -- \"(^)\\\\1\\[\\[:digit:\\]\\]\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6110",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[^a\\])((?:))\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-generated-6111",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=b\\\\Y)\\\\y\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6112",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:\\$\\\\y)*\\\\M\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6113",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=.(?:)).\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-generated-6114",
  )
  check_regexp_case(
    "regexp -about -line -- \"((?:)|.){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-generated-6115",
  )
  check_regexp_case(
    "regexp -about  -- \"(^)((?=a))\\\\2\\\\1\"", "2 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-6116",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\M\\$)?\\[\\[:digit:\\]\\]\"", "1 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6117",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\m|^){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6118",
  )
  check_regexp_case(
    "regexp -about  -- \"(b)(\\\\y)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-generated-6119",
  )
}

///|
test "Tcl regexp cases 6121 through 6160" {
  check_regexp_case(
    "regexp -about  -- \"(\\\\y)\\\\1\\\\Z\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6120",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\$)(\\\\Y)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6121",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\n|\\$){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-6122",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\$|\\[^a\\]).\"", "1 {}", "", false, "about-generated-6123",
  )
  check_regexp_case(
    "regexp -about -line -- \"((?:).)?\\\\Y\"", "1 {REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6124",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[ab\\])\\\\1(?!b)\"", "1 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-6125",
  )
  check_regexp_case(
    "regexp -about  -- \"(^)((?=a))\\\\2\\\\1\"", "2 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-6126",
  )
  check_regexp_case(
    "regexp -about  -- \"(^|a){1,3}\"", "1 {REG_UBOUNDS REG_UEMPTYMATCH}", "", false,
    "about-generated-6127",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\Z)(\\\\M)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6128",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:b(?!b))*.\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-6129",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[^a\\]|a){1,3}\"", "1 REG_UBOUNDS", "", false, "about-generated-6130",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\m)(\\[^a\\])\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6131",
  )
  check_regexp_case(
    "regexp -about  -- \"((?=a))\\\\1b\"", "1 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-6132",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[ab\\]\\\\Y)?\\[ab\\]\"", "1 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6133",
  )
  check_regexp_case(
    "regexp -about  -- \"(.)\\\\1(?!b)\"", "1 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-6134",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[\\[:digit:\\]\\])\\\\1\\\\M\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6135",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\n)\\\\1\\\\y\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6136",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\M)(b)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-generated-6137",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[\\[:alpha:\\]\\]|\\\\n)(?:)\"", "1 {REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE}",
    "", false, "about-generated-6138",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\\\A\\\\n)*\\[ab\\]\"", "0 REG_UNONPOSIX", "",
    false, "about-generated-6139",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\Z|.)\\\\Y\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6140",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[\\[:digit:\\]\\])(\\\\Z)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-generated-6141",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[^a\\]\\\\Z)?\\\\Z\"", "1 {REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-6142",
  )
  check_regexp_case(
    "regexp -about  -- \"((?!b))\\\\1(?:)\"", "1 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-generated-6143",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=\\\\Y\\\\M)(?:)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE}",
    "", false, "about-generated-6144",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[^a\\]|\\\\n){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX}",
    "", false, "about-generated-6145",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=\\\\na)\\\\m\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6146",
  )
  check_regexp_case(
    "regexp -about -line -- \"(b|\\\\m)\\\\Z\"", "1 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6147",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\A|\\$){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-6148",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[\\[:digit:\\]\\])(\\[\\[:digit:\\]\\])\\\\2\\\\1\"",
    "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}", "", false, "about-generated-6149",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=\\\\A\\[\\[:alpha:\\]\\])\\\\Z\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6150",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=\\\\A\\[^a\\])b\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-6151",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=\\[ab\\]\\[\\[:alpha:\\]\\])\\\\n\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6152",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[ab\\]|^){1,3}\"", "1 {REG_UBOUNDS REG_UEMPTYMATCH}",
    "", false, "about-generated-6153",
  )
  check_regexp_case(
    "regexp -about  -- \"((?=a)|^)\\[ab\\]\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-6154",
  )
  check_regexp_case(
    "regexp -about  -- \"((?=a))(\\\\Z)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-6155",
  )
  check_regexp_case(
    "regexp -about  -- \"(^|a)a\"", "1 {}", "", false, "about-generated-6156",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\$)(\\\\Y)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6157",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\\\Z\\\\Z)*\\[\\[:alpha:\\]\\]\"", "0 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6158",
  )
  check_regexp_case(
    "regexp -about -line -- \"((?=a))(\\\\Z)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-6159",
  )
}

///|
test "Tcl regexp cases 6161 through 6200" {
  check_regexp_case(
    "regexp -about  -- \"(\\[ab\\]|\\[\\[:alpha:\\]\\])\\[\\[:digit:\\]\\]\"", "1 REG_ULOCALE",
    "", false, "about-generated-6160",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\m|\\$){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6161",
  )
  check_regexp_case(
    "regexp -about -line -- \"((?=a)\\\\m)?\\[\\[:alpha:\\]\\]\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6162",
  )
  check_regexp_case(
    "regexp -about -line -- \"(a|\\\\Z){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-6163",
  )
  check_regexp_case(
    "regexp -about  -- \"(^)\\\\1\\\\M\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-generated-6164",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:(?=a)\\\\y)*(?!b)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6165",
  )
  check_regexp_case(
    "regexp -about  -- \"((?:)\\\\y)?\\\\M\"", "1 {REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6166",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=\\\\A\\\\Z)\\[ab\\]\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-6167",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\M)((?=a))\\\\2\\\\1\"", "2 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6168",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=(?!b)\\[ab\\])(?:)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-generated-6169",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\n\\[^a\\])?\\\\m\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6170",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[ab\\])\\\\1(?=a)\"", "1 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-6171",
  )
  check_regexp_case(
    "regexp -about -line -- \"((?!b)|\\[ab\\]){1,3}\"", "1 {REG_ULOOKAHEAD REG_UBOUNDS REG_UNONPOSIX}",
    "", false, "about-generated-6172",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\n|\\\\m)\\\\m\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6173",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\y)(\\\\M)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6174",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=\\$(?:))^\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-generated-6175",
  )
  check_regexp_case(
    "regexp -about -line -- \"((?!b)|\\\\Y)(?:)\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6176",
  )
  check_regexp_case(
    "regexp -about  -- \"((?:)|\\\\Y){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6177",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[\\[:alpha:\\]\\])\\\\1\\\\Z\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6178",
  )
  check_regexp_case(
    "regexp -about  -- \"(a|\\[^a\\]){1,3}\"", "1 REG_UBOUNDS", "", false, "about-generated-6179",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:\\$\\$)*\\\\Z\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-6180",
  )
  check_regexp_case(
    "regexp -about  -- \"(^|\\[^a\\])\\$\"", "1 REG_UEMPTYMATCH", "", false, "about-generated-6181",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:a\\\\M)*\\[^a\\]\"", "0 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6182",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\y(?=a))?b\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6183",
  )
  check_regexp_case(
    "regexp -about  -- \"(.|\\\\m){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6184",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\Y|^)\\\\Z\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6185",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\[\\[:digit:\\]\\]\\[ab\\])*(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6186",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\M)((?:))\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6187",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:\\\\A^)*^\"", "0 {REG_UNONPOSIX REG_UEMPTYMATCH}", "",
    false, "about-generated-6188",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\Y|\\[ab\\]){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6189",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\A\\[\\[:digit:\\]\\])?b\"", "1 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6190",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\M|(?=a)){1,3}\"", "1 {REG_ULOOKAHEAD REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6191",
  )
  check_regexp_case(
    "regexp -about -line -- \"(b|\\\\y){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6192",
  )
  check_regexp_case(
    "regexp -about -line -- \"((?!b))(\\\\A)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-6193",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[^a\\])(b)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX}",
    "", false, "about-generated-6194",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=\\[ab\\]a)\\\\y\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6195",
  )
  check_regexp_case(
    "regexp -about -line -- \"((?!b))(^)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-6196",
  )
  check_regexp_case(
    "regexp -about  -- \"((?!b))(\\\\A)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-6197",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\Z)\\\\1\\\\Y\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6198",
  )
  check_regexp_case(
    "regexp -about -line -- \"((?:))\\\\1b\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-generated-6199",
  )
}

///|
test "Tcl regexp cases 6201 through 6240" {
  check_regexp_case(
    "regexp -about  -- \"(\\\\M|^){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6200",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=\\\\m\\[\\[:digit:\\]\\]).\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6201",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\\\Ma)*\\[ab\\]\"", "0 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6202",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:^\\[ab\\])*\\\\n\"", "0 REG_UNONPOSIX", "", false,
    "about-generated-6203",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\Z\\\\n)?\\[\\[:alpha:\\]\\]\"", "1 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6204",
  )
  check_regexp_case(
    "regexp -about -line -- \"(b)\\\\1^\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_UIMPOSSIBLE}",
    "", false, "about-generated-6205",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[\\[:alpha:\\]\\])\\\\1.\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6206",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\n|\\$)\\\\A\"", "1 {REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-6207",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\Y|.)^\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6208",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[\\[:digit:\\]\\])\\\\1\\\\n\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6209",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[ab\\]|\\\\y){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6210",
  )
  check_regexp_case(
    "regexp -about -line -- \"(a)(\\[ab\\])\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX}",
    "", false, "about-generated-6211",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\\\M\\[ab\\])*.\"", "0 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6212",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[^a\\]\\[ab\\])?\\\\n\"", "1 REG_UNONPOSIX", "",
    false, "about-generated-6213",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\A|\\[\\[:digit:\\]\\]){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6214",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\n)\\\\1.\"", "1 {REG_UBACKREF REG_UNONPOSIX}",
    "", false, "about-generated-6215",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=\\\\A.)\\\\Z\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-6216",
  )
  check_regexp_case(
    "regexp -about -line -- \"(b\\\\Z)?\\[\\[:alpha:\\]\\]\"", "1 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6217",
  )
  check_regexp_case(
    "regexp -about  -- \"(.|\\[^a\\])^\"", "1 REG_UIMPOSSIBLE", "", false, "about-generated-6218",
  )
  check_regexp_case(
    "regexp -about -line -- \"((?=a)|\\[\\[:digit:\\]\\]){1,3}\"", "1 {REG_ULOOKAHEAD REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6219",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\\\n\\\\Z)*\\[\\[:digit:\\]\\]\"", "0 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6220",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=\\[^a\\]\\\\n)\\[\\[:alpha:\\]\\]\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6221",
  )
  check_regexp_case(
    "regexp -about  -- \"((?!b))\\\\1\\\\A\"", "1 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-6222",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\M|^)b\"", "1 {REG_UNONPOSIX REG_ULOCALE}", "", false,
    "about-generated-6223",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\y\\$)?\\\\y\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6224",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\\\M\\[\\[:alpha:\\]\\])*\\\\n\"", "0 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6225",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\[\\[:digit:\\]\\]\\[ab\\])*\\\\M\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6226",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\M|(?=a)){1,3}\"", "1 {REG_ULOOKAHEAD REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6227",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\A)\\\\1(?:)\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-generated-6228",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\\\A(?=a))*\\$\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-6229",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=\\$\\\\Z)\\\\M\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6230",
  )
  check_regexp_case(
    "regexp -about -line -- \"((?!b)\\\\M)?\\[\\[:digit:\\]\\]\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6231",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:a(?=a))*\\\\Z\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-6232",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[\\[:alpha:\\]\\])\\\\1\\\\y\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6233",
  )
  check_regexp_case(
    "regexp -about  -- \"((?!b)|\\\\n){1,3}\"", "1 {REG_ULOOKAHEAD REG_UBOUNDS REG_UNONPOSIX}",
    "", false, "about-generated-6234",
  )
  check_regexp_case(
    "regexp -about  -- \"(b|\\[ab\\]){1,3}\"", "1 REG_UBOUNDS", "", false, "about-generated-6235",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\M\\[\\[:alpha:\\]\\])?\\\\n\"", "1 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6236",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=\\[ab\\]\\\\A)\\[^a\\]\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-6237",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\A.)?\\[^a\\]\"", "1 REG_UNONPOSIX", "", false, "about-generated-6238",
  )
  check_regexp_case(
    "regexp -about  -- \"(a|a){1,3}\"", "1 REG_UBOUNDS", "", false, "about-generated-6239",
  )
}

///|
test "Tcl regexp cases 6241 through 6280" {
  check_regexp_case(
    "regexp -about  -- \"(\\\\Z)\\\\1\\\\m\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-generated-6240",
  )
  check_regexp_case(
    "regexp -about -line -- \"(b\\\\A)?(?=a)\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-6241",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[\\[:alpha:\\]\\])\\\\1\\\\M\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6242",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\M)(\\[\\[:alpha:\\]\\])\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-generated-6243",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\\\Z\\\\Y)*\\\\A\"", "0 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6244",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:(?!b)\\\\Z)*(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-6245",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\y)\\\\1\\\\y\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6246",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\A\\[\\[:digit:\\]\\])?\\\\n\"", "1 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6247",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[\\[:alpha:\\]\\]\\\\A)?\\\\y\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6248",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\y|\\$)\\[\\[:alpha:\\]\\]\"", "1 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6249",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\A|a){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-6250",
  )
  check_regexp_case(
    "regexp -about  -- \"(^)(\\\\A)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-6251",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\M|^){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6252",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\Y^)?\\[^a\\]\"", "1 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6253",
  )
  check_regexp_case(
    "regexp -about  -- \"((?=a)|\\\\m){1,3}\"", "1 {REG_ULOOKAHEAD REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6254",
  )
  check_regexp_case(
    "regexp -about -line -- \"((?:)|\\\\y)b\"", "1 {REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE}",
    "", false, "about-generated-6255",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\y)\\\\1\\\\A\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6256",
  )
  check_regexp_case(
    "regexp -about -line -- \"(^\\\\Z)?\\\\Y\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6257",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:(?:)\\[\\[:alpha:\\]\\])*\\\\Z\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6258",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\Z|(?:))\\[^a\\]\"", "1 {REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-generated-6259",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\m)(.)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6260",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\\\Y\\\\Z)*(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6261",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[\\[:digit:\\]\\]|\\\\Z){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6262",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[\\[:alpha:\\]\\]|\\\\m)b\"", "1 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6263",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\n|\\\\Z)\\\\Y\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6264",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[\\[:digit:\\]\\])((?=a))\\\\2\\\\1\"", "2 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6265",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\A\\$)?\\\\A\"", "1 {REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-6266",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\y|\\\\n){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6267",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\y)(b)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6268",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\Z.)?\\\\y\"", "1 {REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6269",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\m|\\\\m).\"", "1 {REG_UNONPOSIX REG_ULOCALE}", "",
    false, "about-generated-6270",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\n)\\\\1\\\\n\"", "1 {REG_UBACKREF REG_UNONPOSIX}",
    "", false, "about-generated-6271",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?:\\\\Z(?!b))*\\[^a\\]\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-6272",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\Y|\\\\y){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6273",
  )
  check_regexp_case(
    "regexp -about -line -- \"(?=(?!b)(?=a))\\\\n\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX}",
    "", false, "about-generated-6274",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=(?:)\\[^a\\])\\\\m\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE}",
    "", false, "about-generated-6275",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[\\[:digit:\\]\\])\\\\1\\$\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6276",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\A)\\\\1\\$\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-6277",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\y|(?!b))\\\\A\"", "1 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6278",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=\\\\Y\\[^a\\])\\\\y\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6279",
  )
}

///|
test "Tcl regexp cases 6281 through 6299" {
  check_regexp_case(
    "regexp -about  -- \"(\\[\\[:digit:\\]\\])((?=a))\\\\2\\\\1\"", "2 {REG_UBACKREF REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6280",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:\\\\Z\\\\M)*(?:)\"", "0 {REG_UNONPOSIX REG_UUNSPEC REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6281",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\M)(^)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-generated-6282",
  )
  check_regexp_case(
    "regexp -about -line -- \"(.|^){1,3}\"", "1 {REG_UBOUNDS REG_UEMPTYMATCH}", "",
    false, "about-generated-6283",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[\\[:digit:\\]\\])(\\\\A)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE REG_UIMPOSSIBLE}",
    "", false, "about-generated-6284",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\\\A|\\\\m){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6285",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\Z|(?=a)){1,3}\"", "1 {REG_ULOOKAHEAD REG_UBOUNDS REG_UNONPOSIX REG_UEMPTYMATCH}",
    "", false, "about-generated-6286",
  )
  check_regexp_case(
    "regexp -about -line -- \"((?:).)?\\\\Z\"", "1 {REG_UNONPOSIX REG_UUNSPEC REG_UEMPTYMATCH}",
    "", false, "about-generated-6287",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[\\[:digit:\\]\\])(\\\\n)\\\\2\\\\1\"", "2 {REG_UBACKREF REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6288",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\[^a\\])\\\\1^\"", "1 {REG_UBACKREF REG_UNONPOSIX REG_UIMPOSSIBLE}",
    "", false, "about-generated-6289",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\M|\\[^a\\]){1,3}\"", "1 {REG_UBOUNDS REG_UNONPOSIX REG_ULOCALE REG_UEMPTYMATCH}",
    "", false, "about-generated-6290",
  )
  check_regexp_case(
    "regexp -about  -- \"(^|\\[^a\\])\\[\\[:digit:\\]\\]\"", "1 REG_ULOCALE", "",
    false, "about-generated-6291",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:\\$\\$)*b\"", "0 REG_UNONPOSIX", "", false, "about-generated-6292",
  )
  check_regexp_case(
    "regexp -about  -- \"(\\$\\\\m)?\\[\\[:alpha:\\]\\]\"", "1 {REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6293",
  )
  check_regexp_case(
    "regexp -about -line -- \"(a)\\\\1\\$\"", "1 {REG_UBACKREF REG_UNONPOSIX}", "",
    false, "about-generated-6294",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\[ab\\]|b)(?:)\"", "1 {REG_UNONPOSIX REG_UUNSPEC}",
    "", false, "about-generated-6295",
  )
  check_regexp_case(
    "regexp -about -line -- \"(\\\\n.)?\\\\n\"", "1 REG_UNONPOSIX", "", false, "about-generated-6296",
  )
  check_regexp_case(
    "regexp -about  -- \"(?:\\\\n.)*.\"", "0 REG_UNONPOSIX", "", false, "about-generated-6297",
  )
  check_regexp_case(
    "regexp -about  -- \"(?=\\\\Y\\[\\[:digit:\\]\\])(?=a)\"", "0 {REG_ULOOKAHEAD REG_UNONPOSIX REG_ULOCALE}",
    "", false, "about-generated-6298",
  )
}
