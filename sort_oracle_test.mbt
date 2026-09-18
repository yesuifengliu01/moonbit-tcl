// Original programs, expected results evaluated by Tcl 8.6.15. Do not hand-edit.

///|
fn check_sort_case(
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
test "Tcl sort cases 1 through 40" {
  check_sort_case("lsort -ascii  [list ]", "", "", false, "content-0")
  check_sort_case("lsort -ascii -indices [list ]", "", "", false, "content-1")
  check_sort_case("lsort -ascii -unique [list ]", "", "", false, "content-2")
  check_sort_case(
    "lsort -ascii -unique -indices [list ]", "", "", false, "content-3",
  )
  check_sort_case(
    "lsort -ascii -decreasing [list ]", "", "", false, "content-4",
  )
  check_sort_case(
    "lsort -ascii -decreasing -unique -indices [list ]", "", "", false, "content-5",
  )
  check_sort_case("lsort -ascii -nocase [list ]", "", "", false, "content-6")
  check_sort_case(
    "lsort -ascii -nocase -unique [list ]", "", "", false, "content-7",
  )
  check_sort_case(
    "lsort -ascii -nocase -indices [list ]", "", "", false, "content-8",
  )
  check_sort_case("lsort -dictionary  [list ]", "", "", false, "content-9")
  check_sort_case(
    "lsort -dictionary -indices [list ]", "", "", false, "content-10",
  )
  check_sort_case(
    "lsort -dictionary -unique [list ]", "", "", false, "content-11",
  )
  check_sort_case(
    "lsort -dictionary -unique -indices [list ]", "", "", false, "content-12",
  )
  check_sort_case(
    "lsort -dictionary -decreasing [list ]", "", "", false, "content-13",
  )
  check_sort_case(
    "lsort -dictionary -decreasing -unique -indices [list ]", "", "", false, "content-14",
  )
  check_sort_case(
    "lsort -dictionary -nocase [list ]", "", "", false, "content-15",
  )
  check_sort_case(
    "lsort -dictionary -nocase -unique [list ]", "", "", false, "content-16",
  )
  check_sort_case(
    "lsort -dictionary -nocase -indices [list ]", "", "", false, "content-17",
  )
  check_sort_case("lsort -integer  [list ]", "", "", false, "content-18")
  check_sort_case(
    "lsort -integer -indices [list ]", "", "", false, "content-19",
  )
  check_sort_case("lsort -integer -unique [list ]", "", "", false, "content-20")
  check_sort_case(
    "lsort -integer -unique -indices [list ]", "", "", false, "content-21",
  )
  check_sort_case(
    "lsort -integer -decreasing [list ]", "", "", false, "content-22",
  )
  check_sort_case(
    "lsort -integer -decreasing -unique -indices [list ]", "", "", false, "content-23",
  )
  check_sort_case("lsort -integer -nocase [list ]", "", "", false, "content-24")
  check_sort_case(
    "lsort -integer -nocase -unique [list ]", "", "", false, "content-25",
  )
  check_sort_case(
    "lsort -integer -nocase -indices [list ]", "", "", false, "content-26",
  )
  check_sort_case("lsort -real  [list ]", "", "", false, "content-27")
  check_sort_case("lsort -real -indices [list ]", "", "", false, "content-28")
  check_sort_case("lsort -real -unique [list ]", "", "", false, "content-29")
  check_sort_case(
    "lsort -real -unique -indices [list ]", "", "", false, "content-30",
  )
  check_sort_case(
    "lsort -real -decreasing [list ]", "", "", false, "content-31",
  )
  check_sort_case(
    "lsort -real -decreasing -unique -indices [list ]", "", "", false, "content-32",
  )
  check_sort_case("lsort -real -nocase [list ]", "", "", false, "content-33")
  check_sort_case(
    "lsort -real -nocase -unique [list ]", "", "", false, "content-34",
  )
  check_sort_case(
    "lsort -real -nocase -indices [list ]", "", "", false, "content-35",
  )
  check_sort_case("lsort -ascii  [list \"a\"]", "a", "", false, "content-36")
  check_sort_case(
    "lsort -ascii -indices [list \"a\"]", "0", "", false, "content-37",
  )
  check_sort_case(
    "lsort -ascii -unique [list \"a\"]", "a", "", false, "content-38",
  )
  check_sort_case(
    "lsort -ascii -unique -indices [list \"a\"]", "0", "", false, "content-39",
  )
}

///|
test "Tcl sort cases 41 through 80" {
  check_sort_case(
    "lsort -ascii -decreasing [list \"a\"]", "a", "", false, "content-40",
  )
  check_sort_case(
    "lsort -ascii -decreasing -unique -indices [list \"a\"]", "0", "", false, "content-41",
  )
  check_sort_case(
    "lsort -ascii -nocase [list \"a\"]", "a", "", false, "content-42",
  )
  check_sort_case(
    "lsort -ascii -nocase -unique [list \"a\"]", "a", "", false, "content-43",
  )
  check_sort_case(
    "lsort -ascii -nocase -indices [list \"a\"]", "0", "", false, "content-44",
  )
  check_sort_case(
    "lsort -dictionary  [list \"a\"]", "a", "", false, "content-45",
  )
  check_sort_case(
    "lsort -dictionary -indices [list \"a\"]", "0", "", false, "content-46",
  )
  check_sort_case(
    "lsort -dictionary -unique [list \"a\"]", "a", "", false, "content-47",
  )
  check_sort_case(
    "lsort -dictionary -unique -indices [list \"a\"]", "0", "", false, "content-48",
  )
  check_sort_case(
    "lsort -dictionary -decreasing [list \"a\"]", "a", "", false, "content-49",
  )
  check_sort_case(
    "lsort -dictionary -decreasing -unique -indices [list \"a\"]", "0", "", false,
    "content-50",
  )
  check_sort_case(
    "lsort -dictionary -nocase [list \"a\"]", "a", "", false, "content-51",
  )
  check_sort_case(
    "lsort -dictionary -nocase -unique [list \"a\"]", "a", "", false, "content-52",
  )
  check_sort_case(
    "lsort -dictionary -nocase -indices [list \"a\"]", "0", "", false, "content-53",
  )
  check_sort_case(
    "lsort -integer  [list \"a\"]", "expected integer but got \"a\"", "", true, "content-54",
  )
  check_sort_case(
    "lsort -integer -indices [list \"a\"]", "expected integer but got \"a\"", "",
    true, "content-55",
  )
  check_sort_case(
    "lsort -integer -unique [list \"a\"]", "expected integer but got \"a\"", "",
    true, "content-56",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"a\"]", "expected integer but got \"a\"",
    "", true, "content-57",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"a\"]", "expected integer but got \"a\"",
    "", true, "content-58",
  )
  check_sort_case(
    "lsort -integer -decreasing -unique -indices [list \"a\"]", "expected integer but got \"a\"",
    "", true, "content-59",
  )
  check_sort_case(
    "lsort -integer -nocase [list \"a\"]", "expected integer but got \"a\"", "",
    true, "content-60",
  )
  check_sort_case(
    "lsort -integer -nocase -unique [list \"a\"]", "expected integer but got \"a\"",
    "", true, "content-61",
  )
  check_sort_case(
    "lsort -integer -nocase -indices [list \"a\"]", "expected integer but got \"a\"",
    "", true, "content-62",
  )
  check_sort_case(
    "lsort -real  [list \"a\"]", "expected floating-point number but got \"a\"",
    "", true, "content-63",
  )
  check_sort_case(
    "lsort -real -indices [list \"a\"]", "expected floating-point number but got \"a\"",
    "", true, "content-64",
  )
  check_sort_case(
    "lsort -real -unique [list \"a\"]", "expected floating-point number but got \"a\"",
    "", true, "content-65",
  )
  check_sort_case(
    "lsort -real -unique -indices [list \"a\"]", "expected floating-point number but got \"a\"",
    "", true, "content-66",
  )
  check_sort_case(
    "lsort -real -decreasing [list \"a\"]", "expected floating-point number but got \"a\"",
    "", true, "content-67",
  )
  check_sort_case(
    "lsort -real -decreasing -unique -indices [list \"a\"]", "expected floating-point number but got \"a\"",
    "", true, "content-68",
  )
  check_sort_case(
    "lsort -real -nocase [list \"a\"]", "expected floating-point number but got \"a\"",
    "", true, "content-69",
  )
  check_sort_case(
    "lsort -real -nocase -unique [list \"a\"]", "expected floating-point number but got \"a\"",
    "", true, "content-70",
  )
  check_sort_case(
    "lsort -real -nocase -indices [list \"a\"]", "expected floating-point number but got \"a\"",
    "", true, "content-71",
  )
  check_sort_case(
    "lsort -ascii  [list \"c\" \"a\" \"b\" \"a\"]", "a a b c", "", false, "content-72",
  )
  check_sort_case(
    "lsort -ascii -indices [list \"c\" \"a\" \"b\" \"a\"]", "1 3 2 0", "", false,
    "content-73",
  )
  check_sort_case(
    "lsort -ascii -unique [list \"c\" \"a\" \"b\" \"a\"]", "a b c", "", false, "content-74",
  )
  check_sort_case(
    "lsort -ascii -unique -indices [list \"c\" \"a\" \"b\" \"a\"]", "3 2 0", "",
    false, "content-75",
  )
  check_sort_case(
    "lsort -ascii -decreasing [list \"c\" \"a\" \"b\" \"a\"]", "c b a a", "", false,
    "content-76",
  )
  check_sort_case(
    "lsort -ascii -decreasing -unique -indices [list \"c\" \"a\" \"b\" \"a\"]", "0 2 3",
    "", false, "content-77",
  )
  check_sort_case(
    "lsort -ascii -nocase [list \"c\" \"a\" \"b\" \"a\"]", "a a b c", "", false,
    "content-78",
  )
  check_sort_case(
    "lsort -ascii -nocase -unique [list \"c\" \"a\" \"b\" \"a\"]", "a b c", "", false,
    "content-79",
  )
}

///|
test "Tcl sort cases 81 through 120" {
  check_sort_case(
    "lsort -ascii -nocase -indices [list \"c\" \"a\" \"b\" \"a\"]", "1 3 2 0", "",
    false, "content-80",
  )
  check_sort_case(
    "lsort -dictionary  [list \"c\" \"a\" \"b\" \"a\"]", "a a b c", "", false, "content-81",
  )
  check_sort_case(
    "lsort -dictionary -indices [list \"c\" \"a\" \"b\" \"a\"]", "1 3 2 0", "", false,
    "content-82",
  )
  check_sort_case(
    "lsort -dictionary -unique [list \"c\" \"a\" \"b\" \"a\"]", "a b c", "", false,
    "content-83",
  )
  check_sort_case(
    "lsort -dictionary -unique -indices [list \"c\" \"a\" \"b\" \"a\"]", "3 2 0",
    "", false, "content-84",
  )
  check_sort_case(
    "lsort -dictionary -decreasing [list \"c\" \"a\" \"b\" \"a\"]", "c b a a", "",
    false, "content-85",
  )
  check_sort_case(
    "lsort -dictionary -decreasing -unique -indices [list \"c\" \"a\" \"b\" \"a\"]",
    "0 2 3", "", false, "content-86",
  )
  check_sort_case(
    "lsort -dictionary -nocase [list \"c\" \"a\" \"b\" \"a\"]", "a a b c", "", false,
    "content-87",
  )
  check_sort_case(
    "lsort -dictionary -nocase -unique [list \"c\" \"a\" \"b\" \"a\"]", "a b c",
    "", false, "content-88",
  )
  check_sort_case(
    "lsort -dictionary -nocase -indices [list \"c\" \"a\" \"b\" \"a\"]", "1 3 2 0",
    "", false, "content-89",
  )
  check_sort_case(
    "lsort -integer  [list \"c\" \"a\" \"b\" \"a\"]", "expected integer but got \"c\"",
    "", true, "content-90",
  )
  check_sort_case(
    "lsort -integer -indices [list \"c\" \"a\" \"b\" \"a\"]", "expected integer but got \"c\"",
    "", true, "content-91",
  )
  check_sort_case(
    "lsort -integer -unique [list \"c\" \"a\" \"b\" \"a\"]", "expected integer but got \"c\"",
    "", true, "content-92",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"c\" \"a\" \"b\" \"a\"]", "expected integer but got \"c\"",
    "", true, "content-93",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"c\" \"a\" \"b\" \"a\"]", "expected integer but got \"c\"",
    "", true, "content-94",
  )
  check_sort_case(
    "lsort -integer -decreasing -unique -indices [list \"c\" \"a\" \"b\" \"a\"]",
    "expected integer but got \"c\"", "", true, "content-95",
  )
  check_sort_case(
    "lsort -integer -nocase [list \"c\" \"a\" \"b\" \"a\"]", "expected integer but got \"c\"",
    "", true, "content-96",
  )
  check_sort_case(
    "lsort -integer -nocase -unique [list \"c\" \"a\" \"b\" \"a\"]", "expected integer but got \"c\"",
    "", true, "content-97",
  )
  check_sort_case(
    "lsort -integer -nocase -indices [list \"c\" \"a\" \"b\" \"a\"]", "expected integer but got \"c\"",
    "", true, "content-98",
  )
  check_sort_case(
    "lsort -real  [list \"c\" \"a\" \"b\" \"a\"]", "expected floating-point number but got \"c\"",
    "", true, "content-99",
  )
  check_sort_case(
    "lsort -real -indices [list \"c\" \"a\" \"b\" \"a\"]", "expected floating-point number but got \"c\"",
    "", true, "content-100",
  )
  check_sort_case(
    "lsort -real -unique [list \"c\" \"a\" \"b\" \"a\"]", "expected floating-point number but got \"c\"",
    "", true, "content-101",
  )
  check_sort_case(
    "lsort -real -unique -indices [list \"c\" \"a\" \"b\" \"a\"]", "expected floating-point number but got \"c\"",
    "", true, "content-102",
  )
  check_sort_case(
    "lsort -real -decreasing [list \"c\" \"a\" \"b\" \"a\"]", "expected floating-point number but got \"c\"",
    "", true, "content-103",
  )
  check_sort_case(
    "lsort -real -decreasing -unique -indices [list \"c\" \"a\" \"b\" \"a\"]", "expected floating-point number but got \"c\"",
    "", true, "content-104",
  )
  check_sort_case(
    "lsort -real -nocase [list \"c\" \"a\" \"b\" \"a\"]", "expected floating-point number but got \"c\"",
    "", true, "content-105",
  )
  check_sort_case(
    "lsort -real -nocase -unique [list \"c\" \"a\" \"b\" \"a\"]", "expected floating-point number but got \"c\"",
    "", true, "content-106",
  )
  check_sort_case(
    "lsort -real -nocase -indices [list \"c\" \"a\" \"b\" \"a\"]", "expected floating-point number but got \"c\"",
    "", true, "content-107",
  )
  check_sort_case(
    "lsort -ascii  [list \"A\" \"a\" \"B\" \"b\"]", "A B a b", "", false, "content-108",
  )
  check_sort_case(
    "lsort -ascii -indices [list \"A\" \"a\" \"B\" \"b\"]", "0 2 1 3", "", false,
    "content-109",
  )
  check_sort_case(
    "lsort -ascii -unique [list \"A\" \"a\" \"B\" \"b\"]", "A B a b", "", false,
    "content-110",
  )
  check_sort_case(
    "lsort -ascii -unique -indices [list \"A\" \"a\" \"B\" \"b\"]", "0 2 1 3", "",
    false, "content-111",
  )
  check_sort_case(
    "lsort -ascii -decreasing [list \"A\" \"a\" \"B\" \"b\"]", "b a B A", "", false,
    "content-112",
  )
  check_sort_case(
    "lsort -ascii -decreasing -unique -indices [list \"A\" \"a\" \"B\" \"b\"]", "3 1 2 0",
    "", false, "content-113",
  )
  check_sort_case(
    "lsort -ascii -nocase [list \"A\" \"a\" \"B\" \"b\"]", "A a B b", "", false,
    "content-114",
  )
  check_sort_case(
    "lsort -ascii -nocase -unique [list \"A\" \"a\" \"B\" \"b\"]", "a b", "", false,
    "content-115",
  )
  check_sort_case(
    "lsort -ascii -nocase -indices [list \"A\" \"a\" \"B\" \"b\"]", "0 1 2 3", "",
    false, "content-116",
  )
  check_sort_case(
    "lsort -dictionary  [list \"A\" \"a\" \"B\" \"b\"]", "A a B b", "", false, "content-117",
  )
  check_sort_case(
    "lsort -dictionary -indices [list \"A\" \"a\" \"B\" \"b\"]", "0 1 2 3", "", false,
    "content-118",
  )
  check_sort_case(
    "lsort -dictionary -unique [list \"A\" \"a\" \"B\" \"b\"]", "A a B b", "", false,
    "content-119",
  )
}

///|
test "Tcl sort cases 121 through 160" {
  check_sort_case(
    "lsort -dictionary -unique -indices [list \"A\" \"a\" \"B\" \"b\"]", "0 1 2 3",
    "", false, "content-120",
  )
  check_sort_case(
    "lsort -dictionary -decreasing [list \"A\" \"a\" \"B\" \"b\"]", "b B a A", "",
    false, "content-121",
  )
  check_sort_case(
    "lsort -dictionary -decreasing -unique -indices [list \"A\" \"a\" \"B\" \"b\"]",
    "3 2 1 0", "", false, "content-122",
  )
  check_sort_case(
    "lsort -dictionary -nocase [list \"A\" \"a\" \"B\" \"b\"]", "A a B b", "", false,
    "content-123",
  )
  check_sort_case(
    "lsort -dictionary -nocase -unique [list \"A\" \"a\" \"B\" \"b\"]", "A a B b",
    "", false, "content-124",
  )
  check_sort_case(
    "lsort -dictionary -nocase -indices [list \"A\" \"a\" \"B\" \"b\"]", "0 1 2 3",
    "", false, "content-125",
  )
  check_sort_case(
    "lsort -integer  [list \"A\" \"a\" \"B\" \"b\"]", "expected integer but got \"A\"",
    "", true, "content-126",
  )
  check_sort_case(
    "lsort -integer -indices [list \"A\" \"a\" \"B\" \"b\"]", "expected integer but got \"A\"",
    "", true, "content-127",
  )
  check_sort_case(
    "lsort -integer -unique [list \"A\" \"a\" \"B\" \"b\"]", "expected integer but got \"A\"",
    "", true, "content-128",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"A\" \"a\" \"B\" \"b\"]", "expected integer but got \"A\"",
    "", true, "content-129",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"A\" \"a\" \"B\" \"b\"]", "expected integer but got \"A\"",
    "", true, "content-130",
  )
  check_sort_case(
    "lsort -integer -decreasing -unique -indices [list \"A\" \"a\" \"B\" \"b\"]",
    "expected integer but got \"A\"", "", true, "content-131",
  )
  check_sort_case(
    "lsort -integer -nocase [list \"A\" \"a\" \"B\" \"b\"]", "expected integer but got \"A\"",
    "", true, "content-132",
  )
  check_sort_case(
    "lsort -integer -nocase -unique [list \"A\" \"a\" \"B\" \"b\"]", "expected integer but got \"A\"",
    "", true, "content-133",
  )
  check_sort_case(
    "lsort -integer -nocase -indices [list \"A\" \"a\" \"B\" \"b\"]", "expected integer but got \"A\"",
    "", true, "content-134",
  )
  check_sort_case(
    "lsort -real  [list \"A\" \"a\" \"B\" \"b\"]", "expected floating-point number but got \"A\"",
    "", true, "content-135",
  )
  check_sort_case(
    "lsort -real -indices [list \"A\" \"a\" \"B\" \"b\"]", "expected floating-point number but got \"A\"",
    "", true, "content-136",
  )
  check_sort_case(
    "lsort -real -unique [list \"A\" \"a\" \"B\" \"b\"]", "expected floating-point number but got \"A\"",
    "", true, "content-137",
  )
  check_sort_case(
    "lsort -real -unique -indices [list \"A\" \"a\" \"B\" \"b\"]", "expected floating-point number but got \"A\"",
    "", true, "content-138",
  )
  check_sort_case(
    "lsort -real -decreasing [list \"A\" \"a\" \"B\" \"b\"]", "expected floating-point number but got \"A\"",
    "", true, "content-139",
  )
  check_sort_case(
    "lsort -real -decreasing -unique -indices [list \"A\" \"a\" \"B\" \"b\"]", "expected floating-point number but got \"A\"",
    "", true, "content-140",
  )
  check_sort_case(
    "lsort -real -nocase [list \"A\" \"a\" \"B\" \"b\"]", "expected floating-point number but got \"A\"",
    "", true, "content-141",
  )
  check_sort_case(
    "lsort -real -nocase -unique [list \"A\" \"a\" \"B\" \"b\"]", "expected floating-point number but got \"A\"",
    "", true, "content-142",
  )
  check_sort_case(
    "lsort -real -nocase -indices [list \"A\" \"a\" \"B\" \"b\"]", "expected floating-point number but got \"A\"",
    "", true, "content-143",
  )
  check_sort_case(
    "lsort -ascii  [list \"a01\" \"a1\" \"A1\" \"a0001\" \"a10\" \"a2\"]", "A1 a0001 a01 a1 a10 a2",
    "", false, "content-144",
  )
  check_sort_case(
    "lsort -ascii -indices [list \"a01\" \"a1\" \"A1\" \"a0001\" \"a10\" \"a2\"]",
    "2 3 0 1 4 5", "", false, "content-145",
  )
  check_sort_case(
    "lsort -ascii -unique [list \"a01\" \"a1\" \"A1\" \"a0001\" \"a10\" \"a2\"]",
    "A1 a0001 a01 a1 a10 a2", "", false, "content-146",
  )
  check_sort_case(
    "lsort -ascii -unique -indices [list \"a01\" \"a1\" \"A1\" \"a0001\" \"a10\" \"a2\"]",
    "2 3 0 1 4 5", "", false, "content-147",
  )
  check_sort_case(
    "lsort -ascii -decreasing [list \"a01\" \"a1\" \"A1\" \"a0001\" \"a10\" \"a2\"]",
    "a2 a10 a1 a01 a0001 A1", "", false, "content-148",
  )
  check_sort_case(
    "lsort -ascii -decreasing -unique -indices [list \"a01\" \"a1\" \"A1\" \"a0001\" \"a10\" \"a2\"]",
    "5 4 1 0 3 2", "", false, "content-149",
  )
  check_sort_case(
    "lsort -ascii -nocase [list \"a01\" \"a1\" \"A1\" \"a0001\" \"a10\" \"a2\"]",
    "a0001 a01 a1 A1 a10 a2", "", false, "content-150",
  )
  check_sort_case(
    "lsort -ascii -nocase -unique [list \"a01\" \"a1\" \"A1\" \"a0001\" \"a10\" \"a2\"]",
    "a0001 a01 A1 a10 a2", "", false, "content-151",
  )
  check_sort_case(
    "lsort -ascii -nocase -indices [list \"a01\" \"a1\" \"A1\" \"a0001\" \"a10\" \"a2\"]",
    "3 0 1 2 4 5", "", false, "content-152",
  )
  check_sort_case(
    "lsort -dictionary  [list \"a01\" \"a1\" \"A1\" \"a0001\" \"a10\" \"a2\"]", "A1 a1 a01 a0001 a2 a10",
    "", false, "content-153",
  )
  check_sort_case(
    "lsort -dictionary -indices [list \"a01\" \"a1\" \"A1\" \"a0001\" \"a10\" \"a2\"]",
    "2 1 0 3 5 4", "", false, "content-154",
  )
  check_sort_case(
    "lsort -dictionary -unique [list \"a01\" \"a1\" \"A1\" \"a0001\" \"a10\" \"a2\"]",
    "A1 a1 a01 a0001 a2 a10", "", false, "content-155",
  )
  check_sort_case(
    "lsort -dictionary -unique -indices [list \"a01\" \"a1\" \"A1\" \"a0001\" \"a10\" \"a2\"]",
    "2 1 0 3 5 4", "", false, "content-156",
  )
  check_sort_case(
    "lsort -dictionary -decreasing [list \"a01\" \"a1\" \"A1\" \"a0001\" \"a10\" \"a2\"]",
    "a10 a2 a0001 a01 a1 A1", "", false, "content-157",
  )
  check_sort_case(
    "lsort -dictionary -decreasing -unique -indices [list \"a01\" \"a1\" \"A1\" \"a0001\" \"a10\" \"a2\"]",
    "4 5 3 0 1 2", "", false, "content-158",
  )
  check_sort_case(
    "lsort -dictionary -nocase [list \"a01\" \"a1\" \"A1\" \"a0001\" \"a10\" \"a2\"]",
    "A1 a1 a01 a0001 a2 a10", "", false, "content-159",
  )
}

///|
test "Tcl sort cases 161 through 200" {
  check_sort_case(
    "lsort -dictionary -nocase -unique [list \"a01\" \"a1\" \"A1\" \"a0001\" \"a10\" \"a2\"]",
    "A1 a1 a01 a0001 a2 a10", "", false, "content-160",
  )
  check_sort_case(
    "lsort -dictionary -nocase -indices [list \"a01\" \"a1\" \"A1\" \"a0001\" \"a10\" \"a2\"]",
    "2 1 0 3 5 4", "", false, "content-161",
  )
  check_sort_case(
    "lsort -integer  [list \"a01\" \"a1\" \"A1\" \"a0001\" \"a10\" \"a2\"]", "expected integer but got \"a01\"",
    "", true, "content-162",
  )
  check_sort_case(
    "lsort -integer -indices [list \"a01\" \"a1\" \"A1\" \"a0001\" \"a10\" \"a2\"]",
    "expected integer but got \"a01\"", "", true, "content-163",
  )
  check_sort_case(
    "lsort -integer -unique [list \"a01\" \"a1\" \"A1\" \"a0001\" \"a10\" \"a2\"]",
    "expected integer but got \"a01\"", "", true, "content-164",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"a01\" \"a1\" \"A1\" \"a0001\" \"a10\" \"a2\"]",
    "expected integer but got \"a01\"", "", true, "content-165",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"a01\" \"a1\" \"A1\" \"a0001\" \"a10\" \"a2\"]",
    "expected integer but got \"a01\"", "", true, "content-166",
  )
  check_sort_case(
    "lsort -integer -decreasing -unique -indices [list \"a01\" \"a1\" \"A1\" \"a0001\" \"a10\" \"a2\"]",
    "expected integer but got \"a01\"", "", true, "content-167",
  )
  check_sort_case(
    "lsort -integer -nocase [list \"a01\" \"a1\" \"A1\" \"a0001\" \"a10\" \"a2\"]",
    "expected integer but got \"a01\"", "", true, "content-168",
  )
  check_sort_case(
    "lsort -integer -nocase -unique [list \"a01\" \"a1\" \"A1\" \"a0001\" \"a10\" \"a2\"]",
    "expected integer but got \"a01\"", "", true, "content-169",
  )
  check_sort_case(
    "lsort -integer -nocase -indices [list \"a01\" \"a1\" \"A1\" \"a0001\" \"a10\" \"a2\"]",
    "expected integer but got \"a01\"", "", true, "content-170",
  )
  check_sort_case(
    "lsort -real  [list \"a01\" \"a1\" \"A1\" \"a0001\" \"a10\" \"a2\"]", "expected floating-point number but got \"a01\"",
    "", true, "content-171",
  )
  check_sort_case(
    "lsort -real -indices [list \"a01\" \"a1\" \"A1\" \"a0001\" \"a10\" \"a2\"]",
    "expected floating-point number but got \"a01\"", "", true, "content-172",
  )
  check_sort_case(
    "lsort -real -unique [list \"a01\" \"a1\" \"A1\" \"a0001\" \"a10\" \"a2\"]",
    "expected floating-point number but got \"a01\"", "", true, "content-173",
  )
  check_sort_case(
    "lsort -real -unique -indices [list \"a01\" \"a1\" \"A1\" \"a0001\" \"a10\" \"a2\"]",
    "expected floating-point number but got \"a01\"", "", true, "content-174",
  )
  check_sort_case(
    "lsort -real -decreasing [list \"a01\" \"a1\" \"A1\" \"a0001\" \"a10\" \"a2\"]",
    "expected floating-point number but got \"a01\"", "", true, "content-175",
  )
  check_sort_case(
    "lsort -real -decreasing -unique -indices [list \"a01\" \"a1\" \"A1\" \"a0001\" \"a10\" \"a2\"]",
    "expected floating-point number but got \"a01\"", "", true, "content-176",
  )
  check_sort_case(
    "lsort -real -nocase [list \"a01\" \"a1\" \"A1\" \"a0001\" \"a10\" \"a2\"]",
    "expected floating-point number but got \"a01\"", "", true, "content-177",
  )
  check_sort_case(
    "lsort -real -nocase -unique [list \"a01\" \"a1\" \"A1\" \"a0001\" \"a10\" \"a2\"]",
    "expected floating-point number but got \"a01\"", "", true, "content-178",
  )
  check_sort_case(
    "lsort -real -nocase -indices [list \"a01\" \"a1\" \"A1\" \"a0001\" \"a10\" \"a2\"]",
    "expected floating-point number but got \"a01\"", "", true, "content-179",
  )
  check_sort_case(
    "lsort -ascii  [list \"0\" \"-0\" \"-1\" \"2\" \"0x10\" \"010\" \"+2\"]", "+2 -0 -1 0 010 0x10 2",
    "", false, "content-180",
  )
  check_sort_case(
    "lsort -ascii -indices [list \"0\" \"-0\" \"-1\" \"2\" \"0x10\" \"010\" \"+2\"]",
    "6 1 2 0 5 4 3", "", false, "content-181",
  )
  check_sort_case(
    "lsort -ascii -unique [list \"0\" \"-0\" \"-1\" \"2\" \"0x10\" \"010\" \"+2\"]",
    "+2 -0 -1 0 010 0x10 2", "", false, "content-182",
  )
  check_sort_case(
    "lsort -ascii -unique -indices [list \"0\" \"-0\" \"-1\" \"2\" \"0x10\" \"010\" \"+2\"]",
    "6 1 2 0 5 4 3", "", false, "content-183",
  )
  check_sort_case(
    "lsort -ascii -decreasing [list \"0\" \"-0\" \"-1\" \"2\" \"0x10\" \"010\" \"+2\"]",
    "2 0x10 010 0 -1 -0 +2", "", false, "content-184",
  )
  check_sort_case(
    "lsort -ascii -decreasing -unique -indices [list \"0\" \"-0\" \"-1\" \"2\" \"0x10\" \"010\" \"+2\"]",
    "3 4 5 0 2 1 6", "", false, "content-185",
  )
  check_sort_case(
    "lsort -ascii -nocase [list \"0\" \"-0\" \"-1\" \"2\" \"0x10\" \"010\" \"+2\"]",
    "+2 -0 -1 0 010 0x10 2", "", false, "content-186",
  )
  check_sort_case(
    "lsort -ascii -nocase -unique [list \"0\" \"-0\" \"-1\" \"2\" \"0x10\" \"010\" \"+2\"]",
    "+2 -0 -1 0 010 0x10 2", "", false, "content-187",
  )
  check_sort_case(
    "lsort -ascii -nocase -indices [list \"0\" \"-0\" \"-1\" \"2\" \"0x10\" \"010\" \"+2\"]",
    "6 1 2 0 5 4 3", "", false, "content-188",
  )
  check_sort_case(
    "lsort -dictionary  [list \"0\" \"-0\" \"-1\" \"2\" \"0x10\" \"010\" \"+2\"]",
    "+2 -0 -1 0 0x10 2 010", "", false, "content-189",
  )
  check_sort_case(
    "lsort -dictionary -indices [list \"0\" \"-0\" \"-1\" \"2\" \"0x10\" \"010\" \"+2\"]",
    "6 1 2 0 4 3 5", "", false, "content-190",
  )
  check_sort_case(
    "lsort -dictionary -unique [list \"0\" \"-0\" \"-1\" \"2\" \"0x10\" \"010\" \"+2\"]",
    "+2 -0 -1 0 0x10 2 010", "", false, "content-191",
  )
  check_sort_case(
    "lsort -dictionary -unique -indices [list \"0\" \"-0\" \"-1\" \"2\" \"0x10\" \"010\" \"+2\"]",
    "6 1 2 0 4 3 5", "", false, "content-192",
  )
  check_sort_case(
    "lsort -dictionary -decreasing [list \"0\" \"-0\" \"-1\" \"2\" \"0x10\" \"010\" \"+2\"]",
    "010 2 0x10 0 -1 -0 +2", "", false, "content-193",
  )
  check_sort_case(
    "lsort -dictionary -decreasing -unique -indices [list \"0\" \"-0\" \"-1\" \"2\" \"0x10\" \"010\" \"+2\"]",
    "5 3 4 0 2 1 6", "", false, "content-194",
  )
  check_sort_case(
    "lsort -dictionary -nocase [list \"0\" \"-0\" \"-1\" \"2\" \"0x10\" \"010\" \"+2\"]",
    "+2 -0 -1 0 0x10 2 010", "", false, "content-195",
  )
  check_sort_case(
    "lsort -dictionary -nocase -unique [list \"0\" \"-0\" \"-1\" \"2\" \"0x10\" \"010\" \"+2\"]",
    "+2 -0 -1 0 0x10 2 010", "", false, "content-196",
  )
  check_sort_case(
    "lsort -dictionary -nocase -indices [list \"0\" \"-0\" \"-1\" \"2\" \"0x10\" \"010\" \"+2\"]",
    "6 1 2 0 4 3 5", "", false, "content-197",
  )
  check_sort_case(
    "lsort -integer  [list \"0\" \"-0\" \"-1\" \"2\" \"0x10\" \"010\" \"+2\"]", "-1 0 -0 2 +2 010 0x10",
    "", false, "content-198",
  )
  check_sort_case(
    "lsort -integer -indices [list \"0\" \"-0\" \"-1\" \"2\" \"0x10\" \"010\" \"+2\"]",
    "2 0 1 3 6 5 4", "", false, "content-199",
  )
}

///|
test "Tcl sort cases 201 through 240" {
  check_sort_case(
    "lsort -integer -unique [list \"0\" \"-0\" \"-1\" \"2\" \"0x10\" \"010\" \"+2\"]",
    "-1 -0 +2 010 0x10", "", false, "content-200",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"0\" \"-0\" \"-1\" \"2\" \"0x10\" \"010\" \"+2\"]",
    "2 1 6 5 4", "", false, "content-201",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"0\" \"-0\" \"-1\" \"2\" \"0x10\" \"010\" \"+2\"]",
    "0x10 010 2 +2 0 -0 -1", "", false, "content-202",
  )
  check_sort_case(
    "lsort -integer -decreasing -unique -indices [list \"0\" \"-0\" \"-1\" \"2\" \"0x10\" \"010\" \"+2\"]",
    "4 5 6 1 2", "", false, "content-203",
  )
  check_sort_case(
    "lsort -integer -nocase [list \"0\" \"-0\" \"-1\" \"2\" \"0x10\" \"010\" \"+2\"]",
    "-1 0 -0 2 +2 010 0x10", "", false, "content-204",
  )
  check_sort_case(
    "lsort -integer -nocase -unique [list \"0\" \"-0\" \"-1\" \"2\" \"0x10\" \"010\" \"+2\"]",
    "-1 -0 +2 010 0x10", "", false, "content-205",
  )
  check_sort_case(
    "lsort -integer -nocase -indices [list \"0\" \"-0\" \"-1\" \"2\" \"0x10\" \"010\" \"+2\"]",
    "2 0 1 3 6 5 4", "", false, "content-206",
  )
  check_sort_case(
    "lsort -real  [list \"0\" \"-0\" \"-1\" \"2\" \"0x10\" \"010\" \"+2\"]", "-1 0 -0 2 +2 010 0x10",
    "", false, "content-207",
  )
  check_sort_case(
    "lsort -real -indices [list \"0\" \"-0\" \"-1\" \"2\" \"0x10\" \"010\" \"+2\"]",
    "2 0 1 3 6 5 4", "", false, "content-208",
  )
  check_sort_case(
    "lsort -real -unique [list \"0\" \"-0\" \"-1\" \"2\" \"0x10\" \"010\" \"+2\"]",
    "-1 -0 +2 010 0x10", "", false, "content-209",
  )
  check_sort_case(
    "lsort -real -unique -indices [list \"0\" \"-0\" \"-1\" \"2\" \"0x10\" \"010\" \"+2\"]",
    "2 1 6 5 4", "", false, "content-210",
  )
  check_sort_case(
    "lsort -real -decreasing [list \"0\" \"-0\" \"-1\" \"2\" \"0x10\" \"010\" \"+2\"]",
    "0x10 010 2 +2 0 -0 -1", "", false, "content-211",
  )
  check_sort_case(
    "lsort -real -decreasing -unique -indices [list \"0\" \"-0\" \"-1\" \"2\" \"0x10\" \"010\" \"+2\"]",
    "4 5 6 1 2", "", false, "content-212",
  )
  check_sort_case(
    "lsort -real -nocase [list \"0\" \"-0\" \"-1\" \"2\" \"0x10\" \"010\" \"+2\"]",
    "-1 0 -0 2 +2 010 0x10", "", false, "content-213",
  )
  check_sort_case(
    "lsort -real -nocase -unique [list \"0\" \"-0\" \"-1\" \"2\" \"0x10\" \"010\" \"+2\"]",
    "-1 -0 +2 010 0x10", "", false, "content-214",
  )
  check_sort_case(
    "lsort -real -nocase -indices [list \"0\" \"-0\" \"-1\" \"2\" \"0x10\" \"010\" \"+2\"]",
    "2 0 1 3 6 5 4", "", false, "content-215",
  )
  check_sort_case(
    "lsort -ascii  [list \"Inf\" \"-Inf\" \"-0.0\" \"1\" \"1.0\" \"0.5\" \"3e2\"]",
    "-0.0 -Inf 0.5 1 1.0 3e2 Inf", "", false, "content-216",
  )
  check_sort_case(
    "lsort -ascii -indices [list \"Inf\" \"-Inf\" \"-0.0\" \"1\" \"1.0\" \"0.5\" \"3e2\"]",
    "2 1 5 3 4 6 0", "", false, "content-217",
  )
  check_sort_case(
    "lsort -ascii -unique [list \"Inf\" \"-Inf\" \"-0.0\" \"1\" \"1.0\" \"0.5\" \"3e2\"]",
    "-0.0 -Inf 0.5 1 1.0 3e2 Inf", "", false, "content-218",
  )
  check_sort_case(
    "lsort -ascii -unique -indices [list \"Inf\" \"-Inf\" \"-0.0\" \"1\" \"1.0\" \"0.5\" \"3e2\"]",
    "2 1 5 3 4 6 0", "", false, "content-219",
  )
  check_sort_case(
    "lsort -ascii -decreasing [list \"Inf\" \"-Inf\" \"-0.0\" \"1\" \"1.0\" \"0.5\" \"3e2\"]",
    "Inf 3e2 1.0 1 0.5 -Inf -0.0", "", false, "content-220",
  )
  check_sort_case(
    "lsort -ascii -decreasing -unique -indices [list \"Inf\" \"-Inf\" \"-0.0\" \"1\" \"1.0\" \"0.5\" \"3e2\"]",
    "0 6 4 3 5 1 2", "", false, "content-221",
  )
  check_sort_case(
    "lsort -ascii -nocase [list \"Inf\" \"-Inf\" \"-0.0\" \"1\" \"1.0\" \"0.5\" \"3e2\"]",
    "-0.0 -Inf 0.5 1 1.0 3e2 Inf", "", false, "content-222",
  )
  check_sort_case(
    "lsort -ascii -nocase -unique [list \"Inf\" \"-Inf\" \"-0.0\" \"1\" \"1.0\" \"0.5\" \"3e2\"]",
    "-0.0 -Inf 0.5 1 1.0 3e2 Inf", "", false, "content-223",
  )
  check_sort_case(
    "lsort -ascii -nocase -indices [list \"Inf\" \"-Inf\" \"-0.0\" \"1\" \"1.0\" \"0.5\" \"3e2\"]",
    "2 1 5 3 4 6 0", "", false, "content-224",
  )
  check_sort_case(
    "lsort -dictionary  [list \"Inf\" \"-Inf\" \"-0.0\" \"1\" \"1.0\" \"0.5\" \"3e2\"]",
    "-0.0 -Inf 0.5 1 1.0 3e2 Inf", "", false, "content-225",
  )
  check_sort_case(
    "lsort -dictionary -indices [list \"Inf\" \"-Inf\" \"-0.0\" \"1\" \"1.0\" \"0.5\" \"3e2\"]",
    "2 1 5 3 4 6 0", "", false, "content-226",
  )
  check_sort_case(
    "lsort -dictionary -unique [list \"Inf\" \"-Inf\" \"-0.0\" \"1\" \"1.0\" \"0.5\" \"3e2\"]",
    "-0.0 -Inf 0.5 1 1.0 3e2 Inf", "", false, "content-227",
  )
  check_sort_case(
    "lsort -dictionary -unique -indices [list \"Inf\" \"-Inf\" \"-0.0\" \"1\" \"1.0\" \"0.5\" \"3e2\"]",
    "2 1 5 3 4 6 0", "", false, "content-228",
  )
  check_sort_case(
    "lsort -dictionary -decreasing [list \"Inf\" \"-Inf\" \"-0.0\" \"1\" \"1.0\" \"0.5\" \"3e2\"]",
    "Inf 3e2 1.0 1 0.5 -Inf -0.0", "", false, "content-229",
  )
  check_sort_case(
    "lsort -dictionary -decreasing -unique -indices [list \"Inf\" \"-Inf\" \"-0.0\" \"1\" \"1.0\" \"0.5\" \"3e2\"]",
    "0 6 4 3 5 1 2", "", false, "content-230",
  )
  check_sort_case(
    "lsort -dictionary -nocase [list \"Inf\" \"-Inf\" \"-0.0\" \"1\" \"1.0\" \"0.5\" \"3e2\"]",
    "-0.0 -Inf 0.5 1 1.0 3e2 Inf", "", false, "content-231",
  )
  check_sort_case(
    "lsort -dictionary -nocase -unique [list \"Inf\" \"-Inf\" \"-0.0\" \"1\" \"1.0\" \"0.5\" \"3e2\"]",
    "-0.0 -Inf 0.5 1 1.0 3e2 Inf", "", false, "content-232",
  )
  check_sort_case(
    "lsort -dictionary -nocase -indices [list \"Inf\" \"-Inf\" \"-0.0\" \"1\" \"1.0\" \"0.5\" \"3e2\"]",
    "2 1 5 3 4 6 0", "", false, "content-233",
  )
  check_sort_case(
    "lsort -integer  [list \"Inf\" \"-Inf\" \"-0.0\" \"1\" \"1.0\" \"0.5\" \"3e2\"]",
    "expected integer but got \"Inf\"", "", true, "content-234",
  )
  check_sort_case(
    "lsort -integer -indices [list \"Inf\" \"-Inf\" \"-0.0\" \"1\" \"1.0\" \"0.5\" \"3e2\"]",
    "expected integer but got \"Inf\"", "", true, "content-235",
  )
  check_sort_case(
    "lsort -integer -unique [list \"Inf\" \"-Inf\" \"-0.0\" \"1\" \"1.0\" \"0.5\" \"3e2\"]",
    "expected integer but got \"Inf\"", "", true, "content-236",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"Inf\" \"-Inf\" \"-0.0\" \"1\" \"1.0\" \"0.5\" \"3e2\"]",
    "expected integer but got \"Inf\"", "", true, "content-237",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"Inf\" \"-Inf\" \"-0.0\" \"1\" \"1.0\" \"0.5\" \"3e2\"]",
    "expected integer but got \"Inf\"", "", true, "content-238",
  )
  check_sort_case(
    "lsort -integer -decreasing -unique -indices [list \"Inf\" \"-Inf\" \"-0.0\" \"1\" \"1.0\" \"0.5\" \"3e2\"]",
    "expected integer but got \"Inf\"", "", true, "content-239",
  )
}

///|
test "Tcl sort cases 241 through 280" {
  check_sort_case(
    "lsort -integer -nocase [list \"Inf\" \"-Inf\" \"-0.0\" \"1\" \"1.0\" \"0.5\" \"3e2\"]",
    "expected integer but got \"Inf\"", "", true, "content-240",
  )
  check_sort_case(
    "lsort -integer -nocase -unique [list \"Inf\" \"-Inf\" \"-0.0\" \"1\" \"1.0\" \"0.5\" \"3e2\"]",
    "expected integer but got \"Inf\"", "", true, "content-241",
  )
  check_sort_case(
    "lsort -integer -nocase -indices [list \"Inf\" \"-Inf\" \"-0.0\" \"1\" \"1.0\" \"0.5\" \"3e2\"]",
    "expected integer but got \"Inf\"", "", true, "content-242",
  )
  check_sort_case(
    "lsort -real  [list \"Inf\" \"-Inf\" \"-0.0\" \"1\" \"1.0\" \"0.5\" \"3e2\"]",
    "-Inf -0.0 0.5 1 1.0 3e2 Inf", "", false, "content-243",
  )
  check_sort_case(
    "lsort -real -indices [list \"Inf\" \"-Inf\" \"-0.0\" \"1\" \"1.0\" \"0.5\" \"3e2\"]",
    "1 2 5 3 4 6 0", "", false, "content-244",
  )
  check_sort_case(
    "lsort -real -unique [list \"Inf\" \"-Inf\" \"-0.0\" \"1\" \"1.0\" \"0.5\" \"3e2\"]",
    "-Inf -0.0 0.5 1.0 3e2 Inf", "", false, "content-245",
  )
  check_sort_case(
    "lsort -real -unique -indices [list \"Inf\" \"-Inf\" \"-0.0\" \"1\" \"1.0\" \"0.5\" \"3e2\"]",
    "1 2 5 4 6 0", "", false, "content-246",
  )
  check_sort_case(
    "lsort -real -decreasing [list \"Inf\" \"-Inf\" \"-0.0\" \"1\" \"1.0\" \"0.5\" \"3e2\"]",
    "Inf 3e2 1 1.0 0.5 -0.0 -Inf", "", false, "content-247",
  )
  check_sort_case(
    "lsort -real -decreasing -unique -indices [list \"Inf\" \"-Inf\" \"-0.0\" \"1\" \"1.0\" \"0.5\" \"3e2\"]",
    "0 6 4 5 2 1", "", false, "content-248",
  )
  check_sort_case(
    "lsort -real -nocase [list \"Inf\" \"-Inf\" \"-0.0\" \"1\" \"1.0\" \"0.5\" \"3e2\"]",
    "-Inf -0.0 0.5 1 1.0 3e2 Inf", "", false, "content-249",
  )
  check_sort_case(
    "lsort -real -nocase -unique [list \"Inf\" \"-Inf\" \"-0.0\" \"1\" \"1.0\" \"0.5\" \"3e2\"]",
    "-Inf -0.0 0.5 1.0 3e2 Inf", "", false, "content-250",
  )
  check_sort_case(
    "lsort -real -nocase -indices [list \"Inf\" \"-Inf\" \"-0.0\" \"1\" \"1.0\" \"0.5\" \"3e2\"]",
    "1 2 5 3 4 6 0", "", false, "content-251",
  )
  check_sort_case(
    "lsort -ascii  [list \"K\" \"K\" \"k\" \"İ\" \"I\" \"i\" \"Ǆ\" \"ǅ\" \"ǆ\"]",
    "I K i k İ Ǆ ǅ ǆ K", "", false, "content-252",
  )
  check_sort_case(
    "lsort -ascii -indices [list \"K\" \"K\" \"k\" \"İ\" \"I\" \"i\" \"Ǆ\" \"ǅ\" \"ǆ\"]",
    "4 1 5 2 3 6 7 8 0", "", false, "content-253",
  )
  check_sort_case(
    "lsort -ascii -unique [list \"K\" \"K\" \"k\" \"İ\" \"I\" \"i\" \"Ǆ\" \"ǅ\" \"ǆ\"]",
    "I K i k İ Ǆ ǅ ǆ K", "", false, "content-254",
  )
  check_sort_case(
    "lsort -ascii -unique -indices [list \"K\" \"K\" \"k\" \"İ\" \"I\" \"i\" \"Ǆ\" \"ǅ\" \"ǆ\"]",
    "4 1 5 2 3 6 7 8 0", "", false, "content-255",
  )
  check_sort_case(
    "lsort -ascii -decreasing [list \"K\" \"K\" \"k\" \"İ\" \"I\" \"i\" \"Ǆ\" \"ǅ\" \"ǆ\"]",
    "K ǆ ǅ Ǆ İ k i K I", "", false, "content-256",
  )
  check_sort_case(
    "lsort -ascii -decreasing -unique -indices [list \"K\" \"K\" \"k\" \"İ\" \"I\" \"i\" \"Ǆ\" \"ǅ\" \"ǆ\"]",
    "0 8 7 6 3 2 5 1 4", "", false, "content-257",
  )
  check_sort_case(
    "lsort -ascii -nocase [list \"K\" \"K\" \"k\" \"İ\" \"I\" \"i\" \"Ǆ\" \"ǅ\" \"ǆ\"]",
    "İ I i K K k Ǆ ǅ ǆ", "", false, "content-258",
  )
  check_sort_case(
    "lsort -ascii -nocase -unique [list \"K\" \"K\" \"k\" \"İ\" \"I\" \"i\" \"Ǆ\" \"ǅ\" \"ǆ\"]",
    "i k ǆ", "", false, "content-259",
  )
  check_sort_case(
    "lsort -ascii -nocase -indices [list \"K\" \"K\" \"k\" \"İ\" \"I\" \"i\" \"Ǆ\" \"ǅ\" \"ǆ\"]",
    "3 4 5 0 1 2 6 7 8", "", false, "content-260",
  )
  check_sort_case(
    "lsort -dictionary  [list \"K\" \"K\" \"k\" \"İ\" \"I\" \"i\" \"Ǆ\" \"ǅ\" \"ǆ\"]",
    "İ I i K K k Ǆ ǅ ǆ", "", false, "content-261",
  )
  check_sort_case(
    "lsort -dictionary -indices [list \"K\" \"K\" \"k\" \"İ\" \"I\" \"i\" \"Ǆ\" \"ǅ\" \"ǆ\"]",
    "3 4 5 0 1 2 6 7 8", "", false, "content-262",
  )
  check_sort_case(
    "lsort -dictionary -unique [list \"K\" \"K\" \"k\" \"İ\" \"I\" \"i\" \"Ǆ\" \"ǅ\" \"ǆ\"]",
    "I i K k ǆ", "", false, "content-263",
  )
  check_sort_case(
    "lsort -dictionary -unique -indices [list \"K\" \"K\" \"k\" \"İ\" \"I\" \"i\" \"Ǆ\" \"ǅ\" \"ǆ\"]",
    "4 5 1 2 8", "", false, "content-264",
  )
  check_sort_case(
    "lsort -dictionary -decreasing [list \"K\" \"K\" \"k\" \"İ\" \"I\" \"i\" \"Ǆ\" \"ǅ\" \"ǆ\"]",
    "ǆ Ǆ ǅ k K K i İ I", "", false, "content-265",
  )
  check_sort_case(
    "lsort -dictionary -decreasing -unique -indices [list \"K\" \"K\" \"k\" \"İ\" \"I\" \"i\" \"Ǆ\" \"ǅ\" \"ǆ\"]",
    "8 2 1 5 4", "", false, "content-266",
  )
  check_sort_case(
    "lsort -dictionary -nocase [list \"K\" \"K\" \"k\" \"İ\" \"I\" \"i\" \"Ǆ\" \"ǅ\" \"ǆ\"]",
    "İ I i K K k Ǆ ǅ ǆ", "", false, "content-267",
  )
  check_sort_case(
    "lsort -dictionary -nocase -unique [list \"K\" \"K\" \"k\" \"İ\" \"I\" \"i\" \"Ǆ\" \"ǅ\" \"ǆ\"]",
    "I i K k ǆ", "", false, "content-268",
  )
  check_sort_case(
    "lsort -dictionary -nocase -indices [list \"K\" \"K\" \"k\" \"İ\" \"I\" \"i\" \"Ǆ\" \"ǅ\" \"ǆ\"]",
    "3 4 5 0 1 2 6 7 8", "", false, "content-269",
  )
  check_sort_case(
    "lsort -integer  [list \"K\" \"K\" \"k\" \"İ\" \"I\" \"i\" \"Ǆ\" \"ǅ\" \"ǆ\"]",
    "expected integer but got \"K\"", "", true, "content-270",
  )
  check_sort_case(
    "lsort -integer -indices [list \"K\" \"K\" \"k\" \"İ\" \"I\" \"i\" \"Ǆ\" \"ǅ\" \"ǆ\"]",
    "expected integer but got \"K\"", "", true, "content-271",
  )
  check_sort_case(
    "lsort -integer -unique [list \"K\" \"K\" \"k\" \"İ\" \"I\" \"i\" \"Ǆ\" \"ǅ\" \"ǆ\"]",
    "expected integer but got \"K\"", "", true, "content-272",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"K\" \"K\" \"k\" \"İ\" \"I\" \"i\" \"Ǆ\" \"ǅ\" \"ǆ\"]",
    "expected integer but got \"K\"", "", true, "content-273",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"K\" \"K\" \"k\" \"İ\" \"I\" \"i\" \"Ǆ\" \"ǅ\" \"ǆ\"]",
    "expected integer but got \"K\"", "", true, "content-274",
  )
  check_sort_case(
    "lsort -integer -decreasing -unique -indices [list \"K\" \"K\" \"k\" \"İ\" \"I\" \"i\" \"Ǆ\" \"ǅ\" \"ǆ\"]",
    "expected integer but got \"K\"", "", true, "content-275",
  )
  check_sort_case(
    "lsort -integer -nocase [list \"K\" \"K\" \"k\" \"İ\" \"I\" \"i\" \"Ǆ\" \"ǅ\" \"ǆ\"]",
    "expected integer but got \"K\"", "", true, "content-276",
  )
  check_sort_case(
    "lsort -integer -nocase -unique [list \"K\" \"K\" \"k\" \"İ\" \"I\" \"i\" \"Ǆ\" \"ǅ\" \"ǆ\"]",
    "expected integer but got \"K\"", "", true, "content-277",
  )
  check_sort_case(
    "lsort -integer -nocase -indices [list \"K\" \"K\" \"k\" \"İ\" \"I\" \"i\" \"Ǆ\" \"ǅ\" \"ǆ\"]",
    "expected integer but got \"K\"", "", true, "content-278",
  )
  check_sort_case(
    "lsort -real  [list \"K\" \"K\" \"k\" \"İ\" \"I\" \"i\" \"Ǆ\" \"ǅ\" \"ǆ\"]",
    "expected floating-point number but got \"K\"", "", true, "content-279",
  )
}

///|
test "Tcl sort cases 281 through 320" {
  check_sort_case(
    "lsort -real -indices [list \"K\" \"K\" \"k\" \"İ\" \"I\" \"i\" \"Ǆ\" \"ǅ\" \"ǆ\"]",
    "expected floating-point number but got \"K\"", "", true, "content-280",
  )
  check_sort_case(
    "lsort -real -unique [list \"K\" \"K\" \"k\" \"İ\" \"I\" \"i\" \"Ǆ\" \"ǅ\" \"ǆ\"]",
    "expected floating-point number but got \"K\"", "", true, "content-281",
  )
  check_sort_case(
    "lsort -real -unique -indices [list \"K\" \"K\" \"k\" \"İ\" \"I\" \"i\" \"Ǆ\" \"ǅ\" \"ǆ\"]",
    "expected floating-point number but got \"K\"", "", true, "content-282",
  )
  check_sort_case(
    "lsort -real -decreasing [list \"K\" \"K\" \"k\" \"İ\" \"I\" \"i\" \"Ǆ\" \"ǅ\" \"ǆ\"]",
    "expected floating-point number but got \"K\"", "", true, "content-283",
  )
  check_sort_case(
    "lsort -real -decreasing -unique -indices [list \"K\" \"K\" \"k\" \"İ\" \"I\" \"i\" \"Ǆ\" \"ǅ\" \"ǆ\"]",
    "expected floating-point number but got \"K\"", "", true, "content-284",
  )
  check_sort_case(
    "lsort -real -nocase [list \"K\" \"K\" \"k\" \"İ\" \"I\" \"i\" \"Ǆ\" \"ǅ\" \"ǆ\"]",
    "expected floating-point number but got \"K\"", "", true, "content-285",
  )
  check_sort_case(
    "lsort -real -nocase -unique [list \"K\" \"K\" \"k\" \"İ\" \"I\" \"i\" \"Ǆ\" \"ǅ\" \"ǆ\"]",
    "expected floating-point number but got \"K\"", "", true, "content-286",
  )
  check_sort_case(
    "lsort -real -nocase -indices [list \"K\" \"K\" \"k\" \"İ\" \"I\" \"i\" \"Ǆ\" \"ǅ\" \"ǆ\"]",
    "expected floating-point number but got \"K\"", "", true, "content-287",
  )
  check_sort_case(
    "lsort -ascii  [list \"😀\" \"\" \"￿\" \"a\"]", "a  ￿ 😀", "",
    false, "content-288",
  )
  check_sort_case(
    "lsort -ascii -indices [list \"😀\" \"\" \"￿\" \"a\"]", "3 1 2 0", "",
    false, "content-289",
  )
  check_sort_case(
    "lsort -ascii -unique [list \"😀\" \"\" \"￿\" \"a\"]", "a  ￿ 😀",
    "", false, "content-290",
  )
  check_sort_case(
    "lsort -ascii -unique -indices [list \"😀\" \"\" \"￿\" \"a\"]", "3 1 2 0",
    "", false, "content-291",
  )
  check_sort_case(
    "lsort -ascii -decreasing [list \"😀\" \"\" \"￿\" \"a\"]", "😀 ￿  a",
    "", false, "content-292",
  )
  check_sort_case(
    "lsort -ascii -decreasing -unique -indices [list \"😀\" \"\" \"￿\" \"a\"]",
    "0 2 1 3", "", false, "content-293",
  )
  check_sort_case(
    "lsort -ascii -nocase [list \"😀\" \"\" \"￿\" \"a\"]", "a 😀  ￿",
    "", false, "content-294",
  )
  check_sort_case(
    "lsort -ascii -nocase -unique [list \"😀\" \"\" \"￿\" \"a\"]", "a 😀  ￿",
    "", false, "content-295",
  )
  check_sort_case(
    "lsort -ascii -nocase -indices [list \"😀\" \"\" \"￿\" \"a\"]", "3 0 1 2",
    "", false, "content-296",
  )
  check_sort_case(
    "lsort -dictionary  [list \"😀\" \"\" \"￿\" \"a\"]", "a  ￿ 😀",
    "", false, "content-297",
  )
  check_sort_case(
    "lsort -dictionary -indices [list \"😀\" \"\" \"￿\" \"a\"]", "3 1 2 0",
    "", false, "content-298",
  )
  check_sort_case(
    "lsort -dictionary -unique [list \"😀\" \"\" \"￿\" \"a\"]", "a  ￿ 😀",
    "", false, "content-299",
  )
  check_sort_case(
    "lsort -dictionary -unique -indices [list \"😀\" \"\" \"￿\" \"a\"]", "3 1 2 0",
    "", false, "content-300",
  )
  check_sort_case(
    "lsort -dictionary -decreasing [list \"😀\" \"\" \"￿\" \"a\"]", "😀 ￿  a",
    "", false, "content-301",
  )
  check_sort_case(
    "lsort -dictionary -decreasing -unique -indices [list \"😀\" \"\" \"￿\" \"a\"]",
    "0 2 1 3", "", false, "content-302",
  )
  check_sort_case(
    "lsort -dictionary -nocase [list \"😀\" \"\" \"￿\" \"a\"]", "a  ￿ 😀",
    "", false, "content-303",
  )
  check_sort_case(
    "lsort -dictionary -nocase -unique [list \"😀\" \"\" \"￿\" \"a\"]", "a  ￿ 😀",
    "", false, "content-304",
  )
  check_sort_case(
    "lsort -dictionary -nocase -indices [list \"😀\" \"\" \"￿\" \"a\"]", "3 1 2 0",
    "", false, "content-305",
  )
  check_sort_case(
    "lsort -integer  [list \"😀\" \"\" \"￿\" \"a\"]", "expected integer but got \"😀\"",
    "", true, "content-306",
  )
  check_sort_case(
    "lsort -integer -indices [list \"😀\" \"\" \"￿\" \"a\"]", "expected integer but got \"😀\"",
    "", true, "content-307",
  )
  check_sort_case(
    "lsort -integer -unique [list \"😀\" \"\" \"￿\" \"a\"]", "expected integer but got \"😀\"",
    "", true, "content-308",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"😀\" \"\" \"￿\" \"a\"]", "expected integer but got \"😀\"",
    "", true, "content-309",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"😀\" \"\" \"￿\" \"a\"]", "expected integer but got \"😀\"",
    "", true, "content-310",
  )
  check_sort_case(
    "lsort -integer -decreasing -unique -indices [list \"😀\" \"\" \"￿\" \"a\"]",
    "expected integer but got \"😀\"", "", true, "content-311",
  )
  check_sort_case(
    "lsort -integer -nocase [list \"😀\" \"\" \"￿\" \"a\"]", "expected integer but got \"😀\"",
    "", true, "content-312",
  )
  check_sort_case(
    "lsort -integer -nocase -unique [list \"😀\" \"\" \"￿\" \"a\"]", "expected integer but got \"😀\"",
    "", true, "content-313",
  )
  check_sort_case(
    "lsort -integer -nocase -indices [list \"😀\" \"\" \"￿\" \"a\"]", "expected integer but got \"😀\"",
    "", true, "content-314",
  )
  check_sort_case(
    "lsort -real  [list \"😀\" \"\" \"￿\" \"a\"]", "expected floating-point number but got \"😀\"",
    "", true, "content-315",
  )
  check_sort_case(
    "lsort -real -indices [list \"😀\" \"\" \"￿\" \"a\"]", "expected floating-point number but got \"😀\"",
    "", true, "content-316",
  )
  check_sort_case(
    "lsort -real -unique [list \"😀\" \"\" \"￿\" \"a\"]", "expected floating-point number but got \"😀\"",
    "", true, "content-317",
  )
  check_sort_case(
    "lsort -real -unique -indices [list \"😀\" \"\" \"￿\" \"a\"]", "expected floating-point number but got \"😀\"",
    "", true, "content-318",
  )
  check_sort_case(
    "lsort -real -decreasing [list \"😀\" \"\" \"￿\" \"a\"]", "expected floating-point number but got \"😀\"",
    "", true, "content-319",
  )
}

///|
test "Tcl sort cases 321 through 360" {
  check_sort_case(
    "lsort -real -decreasing -unique -indices [list \"😀\" \"\" \"￿\" \"a\"]",
    "expected floating-point number but got \"😀\"", "", true, "content-320",
  )
  check_sort_case(
    "lsort -real -nocase [list \"😀\" \"\" \"￿\" \"a\"]", "expected floating-point number but got \"😀\"",
    "", true, "content-321",
  )
  check_sort_case(
    "lsort -real -nocase -unique [list \"😀\" \"\" \"￿\" \"a\"]", "expected floating-point number but got \"😀\"",
    "", true, "content-322",
  )
  check_sort_case(
    "lsort -real -nocase -indices [list \"😀\" \"\" \"￿\" \"a\"]", "expected floating-point number but got \"😀\"",
    "", true, "content-323",
  )
  check_sort_case(
    "lsort -ascii  [list \"a\\x00\" \"a\\x00b\" \"a\" \"a\\x00A\"]", "a a\u0000 a\u0000A a\u0000b",
    "", false, "content-324",
  )
  check_sort_case(
    "lsort -ascii -indices [list \"a\\x00\" \"a\\x00b\" \"a\" \"a\\x00A\"]", "2 0 3 1",
    "", false, "content-325",
  )
  check_sort_case(
    "lsort -ascii -unique [list \"a\\x00\" \"a\\x00b\" \"a\" \"a\\x00A\"]", "a a\u0000 a\u0000A a\u0000b",
    "", false, "content-326",
  )
  check_sort_case(
    "lsort -ascii -unique -indices [list \"a\\x00\" \"a\\x00b\" \"a\" \"a\\x00A\"]",
    "2 0 3 1", "", false, "content-327",
  )
  check_sort_case(
    "lsort -ascii -decreasing [list \"a\\x00\" \"a\\x00b\" \"a\" \"a\\x00A\"]", "a\u0000b a\u0000A a\u0000 a",
    "", false, "content-328",
  )
  check_sort_case(
    "lsort -ascii -decreasing -unique -indices [list \"a\\x00\" \"a\\x00b\" \"a\" \"a\\x00A\"]",
    "1 3 0 2", "", false, "content-329",
  )
  check_sort_case(
    "lsort -ascii -nocase [list \"a\\x00\" \"a\\x00b\" \"a\" \"a\\x00A\"]", "a a\u0000 a\u0000A a\u0000b",
    "", false, "content-330",
  )
  check_sort_case(
    "lsort -ascii -nocase -unique [list \"a\\x00\" \"a\\x00b\" \"a\" \"a\\x00A\"]",
    "a a\u0000 a\u0000A a\u0000b", "", false, "content-331",
  )
  check_sort_case(
    "lsort -ascii -nocase -indices [list \"a\\x00\" \"a\\x00b\" \"a\" \"a\\x00A\"]",
    "2 0 3 1", "", false, "content-332",
  )
  check_sort_case(
    "lsort -dictionary  [list \"a\\x00\" \"a\\x00b\" \"a\" \"a\\x00A\"]", "a a\u0000 a\u0000A a\u0000b",
    "", false, "content-333",
  )
  check_sort_case(
    "lsort -dictionary -indices [list \"a\\x00\" \"a\\x00b\" \"a\" \"a\\x00A\"]",
    "2 0 3 1", "", false, "content-334",
  )
  check_sort_case(
    "lsort -dictionary -unique [list \"a\\x00\" \"a\\x00b\" \"a\" \"a\\x00A\"]",
    "a a\u0000 a\u0000A a\u0000b", "", false, "content-335",
  )
  check_sort_case(
    "lsort -dictionary -unique -indices [list \"a\\x00\" \"a\\x00b\" \"a\" \"a\\x00A\"]",
    "2 0 3 1", "", false, "content-336",
  )
  check_sort_case(
    "lsort -dictionary -decreasing [list \"a\\x00\" \"a\\x00b\" \"a\" \"a\\x00A\"]",
    "a\u0000b a\u0000A a\u0000 a", "", false, "content-337",
  )
  check_sort_case(
    "lsort -dictionary -decreasing -unique -indices [list \"a\\x00\" \"a\\x00b\" \"a\" \"a\\x00A\"]",
    "1 3 0 2", "", false, "content-338",
  )
  check_sort_case(
    "lsort -dictionary -nocase [list \"a\\x00\" \"a\\x00b\" \"a\" \"a\\x00A\"]",
    "a a\u0000 a\u0000A a\u0000b", "", false, "content-339",
  )
  check_sort_case(
    "lsort -dictionary -nocase -unique [list \"a\\x00\" \"a\\x00b\" \"a\" \"a\\x00A\"]",
    "a a\u0000 a\u0000A a\u0000b", "", false, "content-340",
  )
  check_sort_case(
    "lsort -dictionary -nocase -indices [list \"a\\x00\" \"a\\x00b\" \"a\" \"a\\x00A\"]",
    "2 0 3 1", "", false, "content-341",
  )
  check_sort_case(
    "lsort -integer  [list \"a\\x00\" \"a\\x00b\" \"a\" \"a\\x00A\"]", "expected integer but got \"a\u0000\"",
    "", true, "content-342",
  )
  check_sort_case(
    "lsort -integer -indices [list \"a\\x00\" \"a\\x00b\" \"a\" \"a\\x00A\"]", "expected integer but got \"a\u0000\"",
    "", true, "content-343",
  )
  check_sort_case(
    "lsort -integer -unique [list \"a\\x00\" \"a\\x00b\" \"a\" \"a\\x00A\"]", "expected integer but got \"a\u0000\"",
    "", true, "content-344",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"a\\x00\" \"a\\x00b\" \"a\" \"a\\x00A\"]",
    "expected integer but got \"a\u0000\"", "", true, "content-345",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"a\\x00\" \"a\\x00b\" \"a\" \"a\\x00A\"]",
    "expected integer but got \"a\u0000\"", "", true, "content-346",
  )
  check_sort_case(
    "lsort -integer -decreasing -unique -indices [list \"a\\x00\" \"a\\x00b\" \"a\" \"a\\x00A\"]",
    "expected integer but got \"a\u0000\"", "", true, "content-347",
  )
  check_sort_case(
    "lsort -integer -nocase [list \"a\\x00\" \"a\\x00b\" \"a\" \"a\\x00A\"]", "expected integer but got \"a\u0000\"",
    "", true, "content-348",
  )
  check_sort_case(
    "lsort -integer -nocase -unique [list \"a\\x00\" \"a\\x00b\" \"a\" \"a\\x00A\"]",
    "expected integer but got \"a\u0000\"", "", true, "content-349",
  )
  check_sort_case(
    "lsort -integer -nocase -indices [list \"a\\x00\" \"a\\x00b\" \"a\" \"a\\x00A\"]",
    "expected integer but got \"a\u0000\"", "", true, "content-350",
  )
  check_sort_case(
    "lsort -real  [list \"a\\x00\" \"a\\x00b\" \"a\" \"a\\x00A\"]", "expected floating-point number but got \"a\u0000\"",
    "", true, "content-351",
  )
  check_sort_case(
    "lsort -real -indices [list \"a\\x00\" \"a\\x00b\" \"a\" \"a\\x00A\"]", "expected floating-point number but got \"a\u0000\"",
    "", true, "content-352",
  )
  check_sort_case(
    "lsort -real -unique [list \"a\\x00\" \"a\\x00b\" \"a\" \"a\\x00A\"]", "expected floating-point number but got \"a\u0000\"",
    "", true, "content-353",
  )
  check_sort_case(
    "lsort -real -unique -indices [list \"a\\x00\" \"a\\x00b\" \"a\" \"a\\x00A\"]",
    "expected floating-point number but got \"a\u0000\"", "", true, "content-354",
  )
  check_sort_case(
    "lsort -real -decreasing [list \"a\\x00\" \"a\\x00b\" \"a\" \"a\\x00A\"]", "expected floating-point number but got \"a\u0000\"",
    "", true, "content-355",
  )
  check_sort_case(
    "lsort -real -decreasing -unique -indices [list \"a\\x00\" \"a\\x00b\" \"a\" \"a\\x00A\"]",
    "expected floating-point number but got \"a\u0000\"", "", true, "content-356",
  )
  check_sort_case(
    "lsort -real -nocase [list \"a\\x00\" \"a\\x00b\" \"a\" \"a\\x00A\"]", "expected floating-point number but got \"a\u0000\"",
    "", true, "content-357",
  )
  check_sort_case(
    "lsort -real -nocase -unique [list \"a\\x00\" \"a\\x00b\" \"a\" \"a\\x00A\"]",
    "expected floating-point number but got \"a\u0000\"", "", true, "content-358",
  )
  check_sort_case(
    "lsort -real -nocase -indices [list \"a\\x00\" \"a\\x00b\" \"a\" \"a\\x00A\"]",
    "expected floating-point number but got \"a\u0000\"", "", true, "content-359",
  )
}

///|
test "Tcl sort cases 361 through 400" {
  check_sort_case(
    "set code [catch \"lsort -integer  \\[list \\\"18446744073709551615\\\" \\\"-1\\\" \\\"0\\\" \\\"1\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {18446744073709551615 -1 0 1} 0 {}", "", false, "number-boundaries-360",
  )
  check_sort_case(
    "set code [catch \"lsort -integer -indices \\[list \\\"18446744073709551615\\\" \\\"-1\\\" \\\"0\\\" \\\"1\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {0 1 2 3} 0 {}", "", false, "number-boundaries-361",
  )
  check_sort_case(
    "set code [catch \"lsort -integer -unique \\[list \\\"18446744073709551615\\\" \\\"-1\\\" \\\"0\\\" \\\"1\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {-1 0 1} 0 {}", "", false, "number-boundaries-362",
  )
  check_sort_case(
    "set code [catch \"lsort -integer -decreasing \\[list \\\"18446744073709551615\\\" \\\"-1\\\" \\\"0\\\" \\\"1\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {1 0 18446744073709551615 -1} 0 {}", "", false, "number-boundaries-363",
  )
  check_sort_case(
    "set code [catch \"lsort -real  \\[list \\\"18446744073709551615\\\" \\\"-1\\\" \\\"0\\\" \\\"1\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {-1 0 1 18446744073709551615} 0 {}", "", false, "number-boundaries-364",
  )
  check_sort_case(
    "set code [catch \"lsort -real -indices \\[list \\\"18446744073709551615\\\" \\\"-1\\\" \\\"0\\\" \\\"1\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {1 2 3 0} 0 {}", "", false, "number-boundaries-365",
  )
  check_sort_case(
    "set code [catch \"lsort -real -unique \\[list \\\"18446744073709551615\\\" \\\"-1\\\" \\\"0\\\" \\\"1\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {-1 0 1 18446744073709551615} 0 {}", "", false, "number-boundaries-366",
  )
  check_sort_case(
    "set code [catch \"lsort -real -decreasing \\[list \\\"18446744073709551615\\\" \\\"-1\\\" \\\"0\\\" \\\"1\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {18446744073709551615 1 0 -1} 0 {}", "", false, "number-boundaries-367",
  )
  check_sort_case(
    "set code [catch \"lsort -integer  \\[list \\\"-18446744073709551615\\\" \\\"1\\\" \\\"0\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {0 -18446744073709551615 1} 0 {}", "", false, "number-boundaries-368",
  )
  check_sort_case(
    "set code [catch \"lsort -integer -indices \\[list \\\"-18446744073709551615\\\" \\\"1\\\" \\\"0\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {2 0 1} 0 {}", "", false, "number-boundaries-369",
  )
  check_sort_case(
    "set code [catch \"lsort -integer -unique \\[list \\\"-18446744073709551615\\\" \\\"1\\\" \\\"0\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {0 1} 0 {}", "", false, "number-boundaries-370",
  )
  check_sort_case(
    "set code [catch \"lsort -integer -decreasing \\[list \\\"-18446744073709551615\\\" \\\"1\\\" \\\"0\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {-18446744073709551615 1 0} 0 {}", "", false, "number-boundaries-371",
  )
  check_sort_case(
    "set code [catch \"lsort -real  \\[list \\\"-18446744073709551615\\\" \\\"1\\\" \\\"0\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {-18446744073709551615 0 1} 0 {}", "", false, "number-boundaries-372",
  )
  check_sort_case(
    "set code [catch \"lsort -real -indices \\[list \\\"-18446744073709551615\\\" \\\"1\\\" \\\"0\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {0 2 1} 0 {}", "", false, "number-boundaries-373",
  )
  check_sort_case(
    "set code [catch \"lsort -real -unique \\[list \\\"-18446744073709551615\\\" \\\"1\\\" \\\"0\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {-18446744073709551615 0 1} 0 {}", "", false, "number-boundaries-374",
  )
  check_sort_case(
    "set code [catch \"lsort -real -decreasing \\[list \\\"-18446744073709551615\\\" \\\"1\\\" \\\"0\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {1 0 -18446744073709551615} 0 {}", "", false, "number-boundaries-375",
  )
  check_sort_case(
    "set code [catch \"lsort -integer  \\[list \\\"-9223372036854775809\\\" \\\"9223372036854775807\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {-9223372036854775809 9223372036854775807} 0 {}", "", false, "number-boundaries-376",
  )
  check_sort_case(
    "set code [catch \"lsort -integer -indices \\[list \\\"-9223372036854775809\\\" \\\"9223372036854775807\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {0 1} 0 {}", "", false, "number-boundaries-377",
  )
  check_sort_case(
    "set code [catch \"lsort -integer -unique \\[list \\\"-9223372036854775809\\\" \\\"9223372036854775807\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 9223372036854775807 0 {}", "", false, "number-boundaries-378",
  )
  check_sort_case(
    "set code [catch \"lsort -integer -decreasing \\[list \\\"-9223372036854775809\\\" \\\"9223372036854775807\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {-9223372036854775809 9223372036854775807} 0 {}", "", false, "number-boundaries-379",
  )
  check_sort_case(
    "set code [catch \"lsort -real  \\[list \\\"-9223372036854775809\\\" \\\"9223372036854775807\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {-9223372036854775809 9223372036854775807} 0 {}", "", false, "number-boundaries-380",
  )
  check_sort_case(
    "set code [catch \"lsort -real -indices \\[list \\\"-9223372036854775809\\\" \\\"9223372036854775807\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {0 1} 0 {}", "", false, "number-boundaries-381",
  )
  check_sort_case(
    "set code [catch \"lsort -real -unique \\[list \\\"-9223372036854775809\\\" \\\"9223372036854775807\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {-9223372036854775809 9223372036854775807} 0 {}", "", false, "number-boundaries-382",
  )
  check_sort_case(
    "set code [catch \"lsort -real -decreasing \\[list \\\"-9223372036854775809\\\" \\\"9223372036854775807\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {9223372036854775807 -9223372036854775809} 0 {}", "", false, "number-boundaries-383",
  )
  check_sort_case(
    "set code [catch \"lsort -integer  \\[list \\\"18446744073709551616\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {integer value too large to represent} 0 {ARITH IOVERFLOW {integer value too large to represent}}",
    "", false, "number-boundaries-384",
  )
  check_sort_case(
    "set code [catch \"lsort -integer -indices \\[list \\\"18446744073709551616\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {integer value too large to represent} 0 {ARITH IOVERFLOW {integer value too large to represent}}",
    "", false, "number-boundaries-385",
  )
  check_sort_case(
    "set code [catch \"lsort -integer -unique \\[list \\\"18446744073709551616\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {integer value too large to represent} 0 {ARITH IOVERFLOW {integer value too large to represent}}",
    "", false, "number-boundaries-386",
  )
  check_sort_case(
    "set code [catch \"lsort -integer -decreasing \\[list \\\"18446744073709551616\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {integer value too large to represent} 0 {ARITH IOVERFLOW {integer value too large to represent}}",
    "", false, "number-boundaries-387",
  )
  check_sort_case(
    "set code [catch \"lsort -real  \\[list \\\"18446744073709551616\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 18446744073709551616 0 {}", "", false, "number-boundaries-388",
  )
  check_sort_case(
    "set code [catch \"lsort -real -indices \\[list \\\"18446744073709551616\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 0 0 {}", "", false, "number-boundaries-389",
  )
  check_sort_case(
    "set code [catch \"lsort -real -unique \\[list \\\"18446744073709551616\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 18446744073709551616 0 {}", "", false, "number-boundaries-390",
  )
  check_sort_case(
    "set code [catch \"lsort -real -decreasing \\[list \\\"18446744073709551616\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 18446744073709551616 0 {}", "", false, "number-boundaries-391",
  )
  check_sort_case(
    "set code [catch \"lsort -integer  \\[list \\\"-18446744073709551616\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {integer value too large to represent} 0 {ARITH IOVERFLOW {integer value too large to represent}}",
    "", false, "number-boundaries-392",
  )
  check_sort_case(
    "set code [catch \"lsort -integer -indices \\[list \\\"-18446744073709551616\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {integer value too large to represent} 0 {ARITH IOVERFLOW {integer value too large to represent}}",
    "", false, "number-boundaries-393",
  )
  check_sort_case(
    "set code [catch \"lsort -integer -unique \\[list \\\"-18446744073709551616\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {integer value too large to represent} 0 {ARITH IOVERFLOW {integer value too large to represent}}",
    "", false, "number-boundaries-394",
  )
  check_sort_case(
    "set code [catch \"lsort -integer -decreasing \\[list \\\"-18446744073709551616\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {integer value too large to represent} 0 {ARITH IOVERFLOW {integer value too large to represent}}",
    "", false, "number-boundaries-395",
  )
  check_sort_case(
    "set code [catch \"lsort -real  \\[list \\\"-18446744073709551616\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -18446744073709551616 0 {}", "", false, "number-boundaries-396",
  )
  check_sort_case(
    "set code [catch \"lsort -real -indices \\[list \\\"-18446744073709551616\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 0 0 {}", "", false, "number-boundaries-397",
  )
  check_sort_case(
    "set code [catch \"lsort -real -unique \\[list \\\"-18446744073709551616\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -18446744073709551616 0 {}", "", false, "number-boundaries-398",
  )
  check_sort_case(
    "set code [catch \"lsort -real -decreasing \\[list \\\"-18446744073709551616\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 -18446744073709551616 0 {}", "", false, "number-boundaries-399",
  )
}

///|
test "Tcl sort cases 401 through 440" {
  check_sort_case(
    "set code [catch \"lsort -integer  \\[list \\\"NaN\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected integer but got \"NaN\"} 0 {TCL VALUE NUMBER}", "", false, "number-boundaries-400",
  )
  check_sort_case(
    "set code [catch \"lsort -integer -indices \\[list \\\"NaN\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected integer but got \"NaN\"} 0 {TCL VALUE NUMBER}", "", false, "number-boundaries-401",
  )
  check_sort_case(
    "set code [catch \"lsort -integer -unique \\[list \\\"NaN\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected integer but got \"NaN\"} 0 {TCL VALUE NUMBER}", "", false, "number-boundaries-402",
  )
  check_sort_case(
    "set code [catch \"lsort -integer -decreasing \\[list \\\"NaN\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected integer but got \"NaN\"} 0 {TCL VALUE NUMBER}", "", false, "number-boundaries-403",
  )
  check_sort_case(
    "set code [catch \"lsort -real  \\[list \\\"NaN\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {floating point value is Not a Number} 0 {TCL VALUE DOUBLE NAN}", "", false,
    "number-boundaries-404",
  )
  check_sort_case(
    "set code [catch \"lsort -real -indices \\[list \\\"NaN\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {floating point value is Not a Number} 0 {TCL VALUE DOUBLE NAN}", "", false,
    "number-boundaries-405",
  )
  check_sort_case(
    "set code [catch \"lsort -real -unique \\[list \\\"NaN\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {floating point value is Not a Number} 0 {TCL VALUE DOUBLE NAN}", "", false,
    "number-boundaries-406",
  )
  check_sort_case(
    "set code [catch \"lsort -real -decreasing \\[list \\\"NaN\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {floating point value is Not a Number} 0 {TCL VALUE DOUBLE NAN}", "", false,
    "number-boundaries-407",
  )
  check_sort_case(
    "set code [catch \"lsort -integer  \\[list \\\"1.0\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected integer but got \"1.0\"} 0 {TCL VALUE NUMBER}", "", false, "number-boundaries-408",
  )
  check_sort_case(
    "set code [catch \"lsort -integer -indices \\[list \\\"1.0\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected integer but got \"1.0\"} 0 {TCL VALUE NUMBER}", "", false, "number-boundaries-409",
  )
  check_sort_case(
    "set code [catch \"lsort -integer -unique \\[list \\\"1.0\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected integer but got \"1.0\"} 0 {TCL VALUE NUMBER}", "", false, "number-boundaries-410",
  )
  check_sort_case(
    "set code [catch \"lsort -integer -decreasing \\[list \\\"1.0\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected integer but got \"1.0\"} 0 {TCL VALUE NUMBER}", "", false, "number-boundaries-411",
  )
  check_sort_case(
    "set code [catch \"lsort -real  \\[list \\\"1.0\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 1.0 0 {}", "", false, "number-boundaries-412",
  )
  check_sort_case(
    "set code [catch \"lsort -real -indices \\[list \\\"1.0\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 0 0 {}", "", false, "number-boundaries-413",
  )
  check_sort_case(
    "set code [catch \"lsort -real -unique \\[list \\\"1.0\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 1.0 0 {}", "", false, "number-boundaries-414",
  )
  check_sort_case(
    "set code [catch \"lsort -real -decreasing \\[list \\\"1.0\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 1.0 0 {}", "", false, "number-boundaries-415",
  )
  check_sort_case(
    "set code [catch \"lsort -integer  \\[list \\\"08\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected integer but got \"08\"} 0 {TCL VALUE NUMBER}", "", false, "number-boundaries-416",
  )
  check_sort_case(
    "set code [catch \"lsort -integer -indices \\[list \\\"08\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected integer but got \"08\"} 0 {TCL VALUE NUMBER}", "", false, "number-boundaries-417",
  )
  check_sort_case(
    "set code [catch \"lsort -integer -unique \\[list \\\"08\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected integer but got \"08\"} 0 {TCL VALUE NUMBER}", "", false, "number-boundaries-418",
  )
  check_sort_case(
    "set code [catch \"lsort -integer -decreasing \\[list \\\"08\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected integer but got \"08\"} 0 {TCL VALUE NUMBER}", "", false, "number-boundaries-419",
  )
  check_sort_case(
    "set code [catch \"lsort -real  \\[list \\\"08\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected floating-point number but got \"08\" (looks like invalid octal number)} 0 {TCL VALUE NUMBER}",
    "", false, "number-boundaries-420",
  )
  check_sort_case(
    "set code [catch \"lsort -real -indices \\[list \\\"08\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected floating-point number but got \"08\" (looks like invalid octal number)} 0 {TCL VALUE NUMBER}",
    "", false, "number-boundaries-421",
  )
  check_sort_case(
    "set code [catch \"lsort -real -unique \\[list \\\"08\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected floating-point number but got \"08\" (looks like invalid octal number)} 0 {TCL VALUE NUMBER}",
    "", false, "number-boundaries-422",
  )
  check_sort_case(
    "set code [catch \"lsort -real -decreasing \\[list \\\"08\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected floating-point number but got \"08\" (looks like invalid octal number)} 0 {TCL VALUE NUMBER}",
    "", false, "number-boundaries-423",
  )
  check_sort_case(
    "set code [catch \"lsort -integer  \\[list \\\"bad\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected integer but got \"bad\"} 0 {TCL VALUE NUMBER}", "", false, "number-boundaries-424",
  )
  check_sort_case(
    "set code [catch \"lsort -integer -indices \\[list \\\"bad\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected integer but got \"bad\"} 0 {TCL VALUE NUMBER}", "", false, "number-boundaries-425",
  )
  check_sort_case(
    "set code [catch \"lsort -integer -unique \\[list \\\"bad\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected integer but got \"bad\"} 0 {TCL VALUE NUMBER}", "", false, "number-boundaries-426",
  )
  check_sort_case(
    "set code [catch \"lsort -integer -decreasing \\[list \\\"bad\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected integer but got \"bad\"} 0 {TCL VALUE NUMBER}", "", false, "number-boundaries-427",
  )
  check_sort_case(
    "set code [catch \"lsort -real  \\[list \\\"bad\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected floating-point number but got \"bad\"} 0 {TCL VALUE NUMBER}", "",
    false, "number-boundaries-428",
  )
  check_sort_case(
    "set code [catch \"lsort -real -indices \\[list \\\"bad\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected floating-point number but got \"bad\"} 0 {TCL VALUE NUMBER}", "",
    false, "number-boundaries-429",
  )
  check_sort_case(
    "set code [catch \"lsort -real -unique \\[list \\\"bad\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected floating-point number but got \"bad\"} 0 {TCL VALUE NUMBER}", "",
    false, "number-boundaries-430",
  )
  check_sort_case(
    "set code [catch \"lsort -real -decreasing \\[list \\\"bad\\\"\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected floating-point number but got \"bad\"} 0 {TCL VALUE NUMBER}", "",
    false, "number-boundaries-431",
  )
  check_sort_case(
    "lsort -index \"0 1\"  [list \"{a 3} x\" \"{b 1} y\" \"{c 2} z\"]", "{{b 1} y} {{c 2} z} {{a 3} x}",
    "", false, "nested-432",
  )
  check_sort_case(
    "lsort -index \"0 1\" -indices [list \"{a 3} x\" \"{b 1} y\" \"{c 2} z\"]", "1 2 0",
    "", false, "nested-433",
  )
  check_sort_case(
    "lsort -index \"0 1\" -unique [list \"{a 3} x\" \"{b 1} y\" \"{c 2} z\"]", "{{b 1} y} {{c 2} z} {{a 3} x}",
    "", false, "nested-434",
  )
  check_sort_case(
    "lsort -index \"0 1\" -unique -indices [list \"{a 3} x\" \"{b 1} y\" \"{c 2} z\"]",
    "1 2 0", "", false, "nested-435",
  )
  check_sort_case(
    "lsort -index \"0 1\" -decreasing [list \"{a 3} x\" \"{b 1} y\" \"{c 2} z\"]",
    "{{a 3} x} {{c 2} z} {{b 1} y}", "", false, "nested-436",
  )
  check_sort_case(
    "lsort -index \"0 1\" -nocase [list \"{a 3} x\" \"{b 1} y\" \"{c 2} z\"]", "{{b 1} y} {{c 2} z} {{a 3} x}",
    "", false, "nested-437",
  )
  check_sort_case(
    "lsort -index \"0 1\" -dictionary [list \"{a 3} x\" \"{b 1} y\" \"{c 2} z\"]",
    "{{b 1} y} {{c 2} z} {{a 3} x}", "", false, "nested-438",
  )
  check_sort_case(
    "lsort -index \"0 1\" -dictionary -unique -indices [list \"{a 3} x\" \"{b 1} y\" \"{c 2} z\"]",
    "1 2 0", "", false, "nested-439",
  )
}

///|
test "Tcl sort cases 441 through 480" {
  check_sort_case(
    "lsort -index \"1 end\"  [list \"x {a 3}\" \"y {b 1}\" \"z {c 2}\"]", "{y {b 1}} {z {c 2}} {x {a 3}}",
    "", false, "nested-440",
  )
  check_sort_case(
    "lsort -index \"1 end\" -indices [list \"x {a 3}\" \"y {b 1}\" \"z {c 2}\"]",
    "1 2 0", "", false, "nested-441",
  )
  check_sort_case(
    "lsort -index \"1 end\" -unique [list \"x {a 3}\" \"y {b 1}\" \"z {c 2}\"]",
    "{y {b 1}} {z {c 2}} {x {a 3}}", "", false, "nested-442",
  )
  check_sort_case(
    "lsort -index \"1 end\" -unique -indices [list \"x {a 3}\" \"y {b 1}\" \"z {c 2}\"]",
    "1 2 0", "", false, "nested-443",
  )
  check_sort_case(
    "lsort -index \"1 end\" -decreasing [list \"x {a 3}\" \"y {b 1}\" \"z {c 2}\"]",
    "{x {a 3}} {z {c 2}} {y {b 1}}", "", false, "nested-444",
  )
  check_sort_case(
    "lsort -index \"1 end\" -nocase [list \"x {a 3}\" \"y {b 1}\" \"z {c 2}\"]",
    "{y {b 1}} {z {c 2}} {x {a 3}}", "", false, "nested-445",
  )
  check_sort_case(
    "lsort -index \"1 end\" -dictionary [list \"x {a 3}\" \"y {b 1}\" \"z {c 2}\"]",
    "{y {b 1}} {z {c 2}} {x {a 3}}", "", false, "nested-446",
  )
  check_sort_case(
    "lsort -index \"1 end\" -dictionary -unique -indices [list \"x {a 3}\" \"y {b 1}\" \"z {c 2}\"]",
    "1 2 0", "", false, "nested-447",
  )
  check_sort_case(
    "lsort -index \"end\"  [list \"x a\" \"y b\" \"z a\"]", "{x a} {z a} {y b}",
    "", false, "nested-448",
  )
  check_sort_case(
    "lsort -index \"end\" -indices [list \"x a\" \"y b\" \"z a\"]", "0 2 1", "",
    false, "nested-449",
  )
  check_sort_case(
    "lsort -index \"end\" -unique [list \"x a\" \"y b\" \"z a\"]", "{z a} {y b}",
    "", false, "nested-450",
  )
  check_sort_case(
    "lsort -index \"end\" -unique -indices [list \"x a\" \"y b\" \"z a\"]", "2 1",
    "", false, "nested-451",
  )
  check_sort_case(
    "lsort -index \"end\" -decreasing [list \"x a\" \"y b\" \"z a\"]", "{y b} {x a} {z a}",
    "", false, "nested-452",
  )
  check_sort_case(
    "lsort -index \"end\" -nocase [list \"x a\" \"y b\" \"z a\"]", "{x a} {z a} {y b}",
    "", false, "nested-453",
  )
  check_sort_case(
    "lsort -index \"end\" -dictionary [list \"x a\" \"y b\" \"z a\"]", "{x a} {z a} {y b}",
    "", false, "nested-454",
  )
  check_sort_case(
    "lsort -index \"end\" -dictionary -unique -indices [list \"x a\" \"y b\" \"z a\"]",
    "2 1", "", false, "nested-455",
  )
  check_sort_case(
    "lsort -index \"end-1\"  [list \"a x\" \"b y\" \"a z\"]", "{a x} {a z} {b y}",
    "", false, "nested-456",
  )
  check_sort_case(
    "lsort -index \"end-1\" -indices [list \"a x\" \"b y\" \"a z\"]", "0 2 1", "",
    false, "nested-457",
  )
  check_sort_case(
    "lsort -index \"end-1\" -unique [list \"a x\" \"b y\" \"a z\"]", "{a z} {b y}",
    "", false, "nested-458",
  )
  check_sort_case(
    "lsort -index \"end-1\" -unique -indices [list \"a x\" \"b y\" \"a z\"]", "2 1",
    "", false, "nested-459",
  )
  check_sort_case(
    "lsort -index \"end-1\" -decreasing [list \"a x\" \"b y\" \"a z\"]", "{b y} {a x} {a z}",
    "", false, "nested-460",
  )
  check_sort_case(
    "lsort -index \"end-1\" -nocase [list \"a x\" \"b y\" \"a z\"]", "{a x} {a z} {b y}",
    "", false, "nested-461",
  )
  check_sort_case(
    "lsort -index \"end-1\" -dictionary [list \"a x\" \"b y\" \"a z\"]", "{a x} {a z} {b y}",
    "", false, "nested-462",
  )
  check_sort_case(
    "lsort -index \"end-1\" -dictionary -unique -indices [list \"a x\" \"b y\" \"a z\"]",
    "2 1", "", false, "nested-463",
  )
  check_sort_case(
    "lsort -index \"\"  [list \"a\" \"b\" \"a\"]", "a a b", "", false, "nested-464",
  )
  check_sort_case(
    "lsort -index \"\" -indices [list \"a\" \"b\" \"a\"]", "0 2 1", "", false, "nested-465",
  )
  check_sort_case(
    "lsort -index \"\" -unique [list \"a\" \"b\" \"a\"]", "a b", "", false, "nested-466",
  )
  check_sort_case(
    "lsort -index \"\" -unique -indices [list \"a\" \"b\" \"a\"]", "2 1", "", false,
    "nested-467",
  )
  check_sort_case(
    "lsort -index \"\" -decreasing [list \"a\" \"b\" \"a\"]", "b a a", "", false,
    "nested-468",
  )
  check_sort_case(
    "lsort -index \"\" -nocase [list \"a\" \"b\" \"a\"]", "a a b", "", false, "nested-469",
  )
  check_sort_case(
    "lsort -index \"\" -dictionary [list \"a\" \"b\" \"a\"]", "a a b", "", false,
    "nested-470",
  )
  check_sort_case(
    "lsort -index \"\" -dictionary -unique -indices [list \"a\" \"b\" \"a\"]", "2 1",
    "", false, "nested-471",
  )
  check_sort_case(
    "lsort -stride 2 -index \"0\" -integer  [list \"3\" \"payload11\" \"1\" \"payload13\" \"2\" \"payload15\" \"1\" \"payload17\" \"4\" \"payload19\"]",
    "1 payload13 1 payload17 2 payload15 3 payload11 4 payload19", "", false, "stride-472",
  )
  check_sort_case(
    "lsort -stride 2 -index \"0\" -integer -indices [list \"3\" \"payload11\" \"1\" \"payload13\" \"2\" \"payload15\" \"1\" \"payload17\" \"4\" \"payload19\"]",
    "2 3 6 7 4 5 0 1 8 9", "", false, "stride-473",
  )
  check_sort_case(
    "lsort -stride 2 -index \"0\" -integer -unique [list \"3\" \"payload11\" \"1\" \"payload13\" \"2\" \"payload15\" \"1\" \"payload17\" \"4\" \"payload19\"]",
    "1 payload17 2 payload15 3 payload11 4 payload19", "", false, "stride-474",
  )
  check_sort_case(
    "lsort -stride 2 -index \"0\" -integer -unique -indices [list \"3\" \"payload11\" \"1\" \"payload13\" \"2\" \"payload15\" \"1\" \"payload17\" \"4\" \"payload19\"]",
    "6 7 4 5 0 1 8 9", "", false, "stride-475",
  )
  check_sort_case(
    "lsort -stride 2 -index \"0\" -integer -decreasing [list \"3\" \"payload11\" \"1\" \"payload13\" \"2\" \"payload15\" \"1\" \"payload17\" \"4\" \"payload19\"]",
    "4 payload19 3 payload11 2 payload15 1 payload13 1 payload17", "", false, "stride-476",
  )
  check_sort_case(
    "lsort -stride 2 -index \"0\" -integer -decreasing -unique -indices [list \"3\" \"payload11\" \"1\" \"payload13\" \"2\" \"payload15\" \"1\" \"payload17\" \"4\" \"payload19\"]",
    "8 9 0 1 4 5 6 7", "", false, "stride-477",
  )
  check_sort_case(
    "lsort -stride 2 -index \"0\" -integer -increasing -nocase [list \"3\" \"payload11\" \"1\" \"payload13\" \"2\" \"payload15\" \"1\" \"payload17\" \"4\" \"payload19\"]",
    "1 payload13 1 payload17 2 payload15 3 payload11 4 payload19", "", false, "stride-478",
  )
  check_sort_case(
    "lsort -stride 2 -index \"end-1\" -integer  [list \"3\" \"payload11\" \"1\" \"payload13\" \"2\" \"payload15\" \"1\" \"payload17\" \"4\" \"payload19\"]",
    "1 payload13 1 payload17 2 payload15 3 payload11 4 payload19", "", false, "stride-479",
  )
}

///|
test "Tcl sort cases 481 through 520" {
  check_sort_case(
    "lsort -stride 2 -index \"end-1\" -integer -indices [list \"3\" \"payload11\" \"1\" \"payload13\" \"2\" \"payload15\" \"1\" \"payload17\" \"4\" \"payload19\"]",
    "2 3 6 7 4 5 0 1 8 9", "", false, "stride-480",
  )
  check_sort_case(
    "lsort -stride 2 -index \"end-1\" -integer -unique [list \"3\" \"payload11\" \"1\" \"payload13\" \"2\" \"payload15\" \"1\" \"payload17\" \"4\" \"payload19\"]",
    "1 payload17 2 payload15 3 payload11 4 payload19", "", false, "stride-481",
  )
  check_sort_case(
    "lsort -stride 2 -index \"end-1\" -integer -unique -indices [list \"3\" \"payload11\" \"1\" \"payload13\" \"2\" \"payload15\" \"1\" \"payload17\" \"4\" \"payload19\"]",
    "6 7 4 5 0 1 8 9", "", false, "stride-482",
  )
  check_sort_case(
    "lsort -stride 2 -index \"end-1\" -integer -decreasing [list \"3\" \"payload11\" \"1\" \"payload13\" \"2\" \"payload15\" \"1\" \"payload17\" \"4\" \"payload19\"]",
    "4 payload19 3 payload11 2 payload15 1 payload13 1 payload17", "", false, "stride-483",
  )
  check_sort_case(
    "lsort -stride 2 -index \"end-1\" -integer -decreasing -unique -indices [list \"3\" \"payload11\" \"1\" \"payload13\" \"2\" \"payload15\" \"1\" \"payload17\" \"4\" \"payload19\"]",
    "8 9 0 1 4 5 6 7", "", false, "stride-484",
  )
  check_sort_case(
    "lsort -stride 2 -index \"end-1\" -integer -increasing -nocase [list \"3\" \"payload11\" \"1\" \"payload13\" \"2\" \"payload15\" \"1\" \"payload17\" \"4\" \"payload19\"]",
    "1 payload13 1 payload17 2 payload15 3 payload11 4 payload19", "", false, "stride-485",
  )
  check_sort_case(
    "lsort -stride 2 -index \"0 end\" -integer  [list \"tag 3\" \"payload11\" \"tag 1\" \"payload13\" \"tag 2\" \"payload15\" \"tag 1\" \"payload17\" \"tag 4\" \"payload19\"]",
    "{tag 1} payload13 {tag 1} payload17 {tag 2} payload15 {tag 3} payload11 {tag 4} payload19",
    "", false, "stride-nested-486",
  )
  check_sort_case(
    "lsort -stride 2 -index \"0 end\" -integer -indices [list \"tag 3\" \"payload11\" \"tag 1\" \"payload13\" \"tag 2\" \"payload15\" \"tag 1\" \"payload17\" \"tag 4\" \"payload19\"]",
    "2 3 6 7 4 5 0 1 8 9", "", false, "stride-nested-487",
  )
  check_sort_case(
    "lsort -stride 2 -index \"0 end\" -integer -unique [list \"tag 3\" \"payload11\" \"tag 1\" \"payload13\" \"tag 2\" \"payload15\" \"tag 1\" \"payload17\" \"tag 4\" \"payload19\"]",
    "{tag 1} payload17 {tag 2} payload15 {tag 3} payload11 {tag 4} payload19", "",
    false, "stride-nested-488",
  )
  check_sort_case(
    "lsort -stride 2 -index \"0 end\" -integer -decreasing -unique -indices [list \"tag 3\" \"payload11\" \"tag 1\" \"payload13\" \"tag 2\" \"payload15\" \"tag 1\" \"payload17\" \"tag 4\" \"payload19\"]",
    "8 9 0 1 4 5 6 7", "", false, "stride-nested-489",
  )
  check_sort_case(
    "lsort -stride 2 -index \"1\" -integer  [list \"payload00\" \"3\" \"payload02\" \"1\" \"payload04\" \"2\" \"payload06\" \"1\" \"payload08\" \"4\"]",
    "payload02 1 payload06 1 payload04 2 payload00 3 payload08 4", "", false, "stride-490",
  )
  check_sort_case(
    "lsort -stride 2 -index \"1\" -integer -indices [list \"payload00\" \"3\" \"payload02\" \"1\" \"payload04\" \"2\" \"payload06\" \"1\" \"payload08\" \"4\"]",
    "2 3 6 7 4 5 0 1 8 9", "", false, "stride-491",
  )
  check_sort_case(
    "lsort -stride 2 -index \"1\" -integer -unique [list \"payload00\" \"3\" \"payload02\" \"1\" \"payload04\" \"2\" \"payload06\" \"1\" \"payload08\" \"4\"]",
    "payload06 1 payload04 2 payload00 3 payload08 4", "", false, "stride-492",
  )
  check_sort_case(
    "lsort -stride 2 -index \"1\" -integer -unique -indices [list \"payload00\" \"3\" \"payload02\" \"1\" \"payload04\" \"2\" \"payload06\" \"1\" \"payload08\" \"4\"]",
    "6 7 4 5 0 1 8 9", "", false, "stride-493",
  )
  check_sort_case(
    "lsort -stride 2 -index \"1\" -integer -decreasing [list \"payload00\" \"3\" \"payload02\" \"1\" \"payload04\" \"2\" \"payload06\" \"1\" \"payload08\" \"4\"]",
    "payload08 4 payload00 3 payload04 2 payload02 1 payload06 1", "", false, "stride-494",
  )
  check_sort_case(
    "lsort -stride 2 -index \"1\" -integer -decreasing -unique -indices [list \"payload00\" \"3\" \"payload02\" \"1\" \"payload04\" \"2\" \"payload06\" \"1\" \"payload08\" \"4\"]",
    "8 9 0 1 4 5 6 7", "", false, "stride-495",
  )
  check_sort_case(
    "lsort -stride 2 -index \"1\" -integer -increasing -nocase [list \"payload00\" \"3\" \"payload02\" \"1\" \"payload04\" \"2\" \"payload06\" \"1\" \"payload08\" \"4\"]",
    "payload02 1 payload06 1 payload04 2 payload00 3 payload08 4", "", false, "stride-496",
  )
  check_sort_case(
    "lsort -stride 2 -index \"end-0\" -integer  [list \"payload00\" \"3\" \"payload02\" \"1\" \"payload04\" \"2\" \"payload06\" \"1\" \"payload08\" \"4\"]",
    "payload02 1 payload06 1 payload04 2 payload00 3 payload08 4", "", false, "stride-497",
  )
  check_sort_case(
    "lsort -stride 2 -index \"end-0\" -integer -indices [list \"payload00\" \"3\" \"payload02\" \"1\" \"payload04\" \"2\" \"payload06\" \"1\" \"payload08\" \"4\"]",
    "2 3 6 7 4 5 0 1 8 9", "", false, "stride-498",
  )
  check_sort_case(
    "lsort -stride 2 -index \"end-0\" -integer -unique [list \"payload00\" \"3\" \"payload02\" \"1\" \"payload04\" \"2\" \"payload06\" \"1\" \"payload08\" \"4\"]",
    "payload06 1 payload04 2 payload00 3 payload08 4", "", false, "stride-499",
  )
  check_sort_case(
    "lsort -stride 2 -index \"end-0\" -integer -unique -indices [list \"payload00\" \"3\" \"payload02\" \"1\" \"payload04\" \"2\" \"payload06\" \"1\" \"payload08\" \"4\"]",
    "6 7 4 5 0 1 8 9", "", false, "stride-500",
  )
  check_sort_case(
    "lsort -stride 2 -index \"end-0\" -integer -decreasing [list \"payload00\" \"3\" \"payload02\" \"1\" \"payload04\" \"2\" \"payload06\" \"1\" \"payload08\" \"4\"]",
    "payload08 4 payload00 3 payload04 2 payload02 1 payload06 1", "", false, "stride-501",
  )
  check_sort_case(
    "lsort -stride 2 -index \"end-0\" -integer -decreasing -unique -indices [list \"payload00\" \"3\" \"payload02\" \"1\" \"payload04\" \"2\" \"payload06\" \"1\" \"payload08\" \"4\"]",
    "8 9 0 1 4 5 6 7", "", false, "stride-502",
  )
  check_sort_case(
    "lsort -stride 2 -index \"end-0\" -integer -increasing -nocase [list \"payload00\" \"3\" \"payload02\" \"1\" \"payload04\" \"2\" \"payload06\" \"1\" \"payload08\" \"4\"]",
    "payload02 1 payload06 1 payload04 2 payload00 3 payload08 4", "", false, "stride-503",
  )
  check_sort_case(
    "lsort -stride 2 -index \"1 end\" -integer  [list \"payload00\" \"tag 3\" \"payload02\" \"tag 1\" \"payload04\" \"tag 2\" \"payload06\" \"tag 1\" \"payload08\" \"tag 4\"]",
    "payload02 {tag 1} payload06 {tag 1} payload04 {tag 2} payload00 {tag 3} payload08 {tag 4}",
    "", false, "stride-nested-504",
  )
  check_sort_case(
    "lsort -stride 2 -index \"1 end\" -integer -indices [list \"payload00\" \"tag 3\" \"payload02\" \"tag 1\" \"payload04\" \"tag 2\" \"payload06\" \"tag 1\" \"payload08\" \"tag 4\"]",
    "2 3 6 7 4 5 0 1 8 9", "", false, "stride-nested-505",
  )
  check_sort_case(
    "lsort -stride 2 -index \"1 end\" -integer -unique [list \"payload00\" \"tag 3\" \"payload02\" \"tag 1\" \"payload04\" \"tag 2\" \"payload06\" \"tag 1\" \"payload08\" \"tag 4\"]",
    "payload06 {tag 1} payload04 {tag 2} payload00 {tag 3} payload08 {tag 4}", "",
    false, "stride-nested-506",
  )
  check_sort_case(
    "lsort -stride 2 -index \"1 end\" -integer -decreasing -unique -indices [list \"payload00\" \"tag 3\" \"payload02\" \"tag 1\" \"payload04\" \"tag 2\" \"payload06\" \"tag 1\" \"payload08\" \"tag 4\"]",
    "8 9 0 1 4 5 6 7", "", false, "stride-nested-507",
  )
  check_sort_case(
    "lsort -stride 3 -index \"0\" -integer  [list \"3\" \"payload11\" \"payload22\" \"1\" \"payload14\" \"payload25\" \"2\" \"payload17\" \"payload28\" \"1\" \"payload110\" \"payload211\" \"4\" \"payload113\" \"payload214\"]",
    "1 payload14 payload25 1 payload110 payload211 2 payload17 payload28 3 payload11 payload22 4 payload113 payload214",
    "", false, "stride-508",
  )
  check_sort_case(
    "lsort -stride 3 -index \"0\" -integer -indices [list \"3\" \"payload11\" \"payload22\" \"1\" \"payload14\" \"payload25\" \"2\" \"payload17\" \"payload28\" \"1\" \"payload110\" \"payload211\" \"4\" \"payload113\" \"payload214\"]",
    "3 4 5 9 10 11 6 7 8 0 1 2 12 13 14", "", false, "stride-509",
  )
  check_sort_case(
    "lsort -stride 3 -index \"0\" -integer -unique [list \"3\" \"payload11\" \"payload22\" \"1\" \"payload14\" \"payload25\" \"2\" \"payload17\" \"payload28\" \"1\" \"payload110\" \"payload211\" \"4\" \"payload113\" \"payload214\"]",
    "1 payload110 payload211 2 payload17 payload28 3 payload11 payload22 4 payload113 payload214",
    "", false, "stride-510",
  )
  check_sort_case(
    "lsort -stride 3 -index \"0\" -integer -unique -indices [list \"3\" \"payload11\" \"payload22\" \"1\" \"payload14\" \"payload25\" \"2\" \"payload17\" \"payload28\" \"1\" \"payload110\" \"payload211\" \"4\" \"payload113\" \"payload214\"]",
    "9 10 11 6 7 8 0 1 2 12 13 14", "", false, "stride-511",
  )
  check_sort_case(
    "lsort -stride 3 -index \"0\" -integer -decreasing [list \"3\" \"payload11\" \"payload22\" \"1\" \"payload14\" \"payload25\" \"2\" \"payload17\" \"payload28\" \"1\" \"payload110\" \"payload211\" \"4\" \"payload113\" \"payload214\"]",
    "4 payload113 payload214 3 payload11 payload22 2 payload17 payload28 1 payload14 payload25 1 payload110 payload211",
    "", false, "stride-512",
  )
  check_sort_case(
    "lsort -stride 3 -index \"0\" -integer -decreasing -unique -indices [list \"3\" \"payload11\" \"payload22\" \"1\" \"payload14\" \"payload25\" \"2\" \"payload17\" \"payload28\" \"1\" \"payload110\" \"payload211\" \"4\" \"payload113\" \"payload214\"]",
    "12 13 14 0 1 2 6 7 8 9 10 11", "", false, "stride-513",
  )
  check_sort_case(
    "lsort -stride 3 -index \"0\" -integer -increasing -nocase [list \"3\" \"payload11\" \"payload22\" \"1\" \"payload14\" \"payload25\" \"2\" \"payload17\" \"payload28\" \"1\" \"payload110\" \"payload211\" \"4\" \"payload113\" \"payload214\"]",
    "1 payload14 payload25 1 payload110 payload211 2 payload17 payload28 3 payload11 payload22 4 payload113 payload214",
    "", false, "stride-514",
  )
  check_sort_case(
    "lsort -stride 3 -index \"end-2\" -integer  [list \"3\" \"payload11\" \"payload22\" \"1\" \"payload14\" \"payload25\" \"2\" \"payload17\" \"payload28\" \"1\" \"payload110\" \"payload211\" \"4\" \"payload113\" \"payload214\"]",
    "1 payload14 payload25 1 payload110 payload211 2 payload17 payload28 3 payload11 payload22 4 payload113 payload214",
    "", false, "stride-515",
  )
  check_sort_case(
    "lsort -stride 3 -index \"end-2\" -integer -indices [list \"3\" \"payload11\" \"payload22\" \"1\" \"payload14\" \"payload25\" \"2\" \"payload17\" \"payload28\" \"1\" \"payload110\" \"payload211\" \"4\" \"payload113\" \"payload214\"]",
    "3 4 5 9 10 11 6 7 8 0 1 2 12 13 14", "", false, "stride-516",
  )
  check_sort_case(
    "lsort -stride 3 -index \"end-2\" -integer -unique [list \"3\" \"payload11\" \"payload22\" \"1\" \"payload14\" \"payload25\" \"2\" \"payload17\" \"payload28\" \"1\" \"payload110\" \"payload211\" \"4\" \"payload113\" \"payload214\"]",
    "1 payload110 payload211 2 payload17 payload28 3 payload11 payload22 4 payload113 payload214",
    "", false, "stride-517",
  )
  check_sort_case(
    "lsort -stride 3 -index \"end-2\" -integer -unique -indices [list \"3\" \"payload11\" \"payload22\" \"1\" \"payload14\" \"payload25\" \"2\" \"payload17\" \"payload28\" \"1\" \"payload110\" \"payload211\" \"4\" \"payload113\" \"payload214\"]",
    "9 10 11 6 7 8 0 1 2 12 13 14", "", false, "stride-518",
  )
  check_sort_case(
    "lsort -stride 3 -index \"end-2\" -integer -decreasing [list \"3\" \"payload11\" \"payload22\" \"1\" \"payload14\" \"payload25\" \"2\" \"payload17\" \"payload28\" \"1\" \"payload110\" \"payload211\" \"4\" \"payload113\" \"payload214\"]",
    "4 payload113 payload214 3 payload11 payload22 2 payload17 payload28 1 payload14 payload25 1 payload110 payload211",
    "", false, "stride-519",
  )
}

///|
test "Tcl sort cases 521 through 560" {
  check_sort_case(
    "lsort -stride 3 -index \"end-2\" -integer -decreasing -unique -indices [list \"3\" \"payload11\" \"payload22\" \"1\" \"payload14\" \"payload25\" \"2\" \"payload17\" \"payload28\" \"1\" \"payload110\" \"payload211\" \"4\" \"payload113\" \"payload214\"]",
    "12 13 14 0 1 2 6 7 8 9 10 11", "", false, "stride-520",
  )
  check_sort_case(
    "lsort -stride 3 -index \"end-2\" -integer -increasing -nocase [list \"3\" \"payload11\" \"payload22\" \"1\" \"payload14\" \"payload25\" \"2\" \"payload17\" \"payload28\" \"1\" \"payload110\" \"payload211\" \"4\" \"payload113\" \"payload214\"]",
    "1 payload14 payload25 1 payload110 payload211 2 payload17 payload28 3 payload11 payload22 4 payload113 payload214",
    "", false, "stride-521",
  )
  check_sort_case(
    "lsort -stride 3 -index \"0 end\" -integer  [list \"tag 3\" \"payload11\" \"payload22\" \"tag 1\" \"payload14\" \"payload25\" \"tag 2\" \"payload17\" \"payload28\" \"tag 1\" \"payload110\" \"payload211\" \"tag 4\" \"payload113\" \"payload214\"]",
    "{tag 1} payload14 payload25 {tag 1} payload110 payload211 {tag 2} payload17 payload28 {tag 3} payload11 payload22 {tag 4} payload113 payload214",
    "", false, "stride-nested-522",
  )
  check_sort_case(
    "lsort -stride 3 -index \"0 end\" -integer -indices [list \"tag 3\" \"payload11\" \"payload22\" \"tag 1\" \"payload14\" \"payload25\" \"tag 2\" \"payload17\" \"payload28\" \"tag 1\" \"payload110\" \"payload211\" \"tag 4\" \"payload113\" \"payload214\"]",
    "3 4 5 9 10 11 6 7 8 0 1 2 12 13 14", "", false, "stride-nested-523",
  )
  check_sort_case(
    "lsort -stride 3 -index \"0 end\" -integer -unique [list \"tag 3\" \"payload11\" \"payload22\" \"tag 1\" \"payload14\" \"payload25\" \"tag 2\" \"payload17\" \"payload28\" \"tag 1\" \"payload110\" \"payload211\" \"tag 4\" \"payload113\" \"payload214\"]",
    "{tag 1} payload110 payload211 {tag 2} payload17 payload28 {tag 3} payload11 payload22 {tag 4} payload113 payload214",
    "", false, "stride-nested-524",
  )
  check_sort_case(
    "lsort -stride 3 -index \"0 end\" -integer -decreasing -unique -indices [list \"tag 3\" \"payload11\" \"payload22\" \"tag 1\" \"payload14\" \"payload25\" \"tag 2\" \"payload17\" \"payload28\" \"tag 1\" \"payload110\" \"payload211\" \"tag 4\" \"payload113\" \"payload214\"]",
    "12 13 14 0 1 2 6 7 8 9 10 11", "", false, "stride-nested-525",
  )
  check_sort_case(
    "lsort -stride 3 -index \"1\" -integer  [list \"payload00\" \"3\" \"payload22\" \"payload03\" \"1\" \"payload25\" \"payload06\" \"2\" \"payload28\" \"payload09\" \"1\" \"payload211\" \"payload012\" \"4\" \"payload214\"]",
    "payload03 1 payload25 payload09 1 payload211 payload06 2 payload28 payload00 3 payload22 payload012 4 payload214",
    "", false, "stride-526",
  )
  check_sort_case(
    "lsort -stride 3 -index \"1\" -integer -indices [list \"payload00\" \"3\" \"payload22\" \"payload03\" \"1\" \"payload25\" \"payload06\" \"2\" \"payload28\" \"payload09\" \"1\" \"payload211\" \"payload012\" \"4\" \"payload214\"]",
    "3 4 5 9 10 11 6 7 8 0 1 2 12 13 14", "", false, "stride-527",
  )
  check_sort_case(
    "lsort -stride 3 -index \"1\" -integer -unique [list \"payload00\" \"3\" \"payload22\" \"payload03\" \"1\" \"payload25\" \"payload06\" \"2\" \"payload28\" \"payload09\" \"1\" \"payload211\" \"payload012\" \"4\" \"payload214\"]",
    "payload09 1 payload211 payload06 2 payload28 payload00 3 payload22 payload012 4 payload214",
    "", false, "stride-528",
  )
  check_sort_case(
    "lsort -stride 3 -index \"1\" -integer -unique -indices [list \"payload00\" \"3\" \"payload22\" \"payload03\" \"1\" \"payload25\" \"payload06\" \"2\" \"payload28\" \"payload09\" \"1\" \"payload211\" \"payload012\" \"4\" \"payload214\"]",
    "9 10 11 6 7 8 0 1 2 12 13 14", "", false, "stride-529",
  )
  check_sort_case(
    "lsort -stride 3 -index \"1\" -integer -decreasing [list \"payload00\" \"3\" \"payload22\" \"payload03\" \"1\" \"payload25\" \"payload06\" \"2\" \"payload28\" \"payload09\" \"1\" \"payload211\" \"payload012\" \"4\" \"payload214\"]",
    "payload012 4 payload214 payload00 3 payload22 payload06 2 payload28 payload03 1 payload25 payload09 1 payload211",
    "", false, "stride-530",
  )
  check_sort_case(
    "lsort -stride 3 -index \"1\" -integer -decreasing -unique -indices [list \"payload00\" \"3\" \"payload22\" \"payload03\" \"1\" \"payload25\" \"payload06\" \"2\" \"payload28\" \"payload09\" \"1\" \"payload211\" \"payload012\" \"4\" \"payload214\"]",
    "12 13 14 0 1 2 6 7 8 9 10 11", "", false, "stride-531",
  )
  check_sort_case(
    "lsort -stride 3 -index \"1\" -integer -increasing -nocase [list \"payload00\" \"3\" \"payload22\" \"payload03\" \"1\" \"payload25\" \"payload06\" \"2\" \"payload28\" \"payload09\" \"1\" \"payload211\" \"payload012\" \"4\" \"payload214\"]",
    "payload03 1 payload25 payload09 1 payload211 payload06 2 payload28 payload00 3 payload22 payload012 4 payload214",
    "", false, "stride-532",
  )
  check_sort_case(
    "lsort -stride 3 -index \"end-1\" -integer  [list \"payload00\" \"3\" \"payload22\" \"payload03\" \"1\" \"payload25\" \"payload06\" \"2\" \"payload28\" \"payload09\" \"1\" \"payload211\" \"payload012\" \"4\" \"payload214\"]",
    "payload03 1 payload25 payload09 1 payload211 payload06 2 payload28 payload00 3 payload22 payload012 4 payload214",
    "", false, "stride-533",
  )
  check_sort_case(
    "lsort -stride 3 -index \"end-1\" -integer -indices [list \"payload00\" \"3\" \"payload22\" \"payload03\" \"1\" \"payload25\" \"payload06\" \"2\" \"payload28\" \"payload09\" \"1\" \"payload211\" \"payload012\" \"4\" \"payload214\"]",
    "3 4 5 9 10 11 6 7 8 0 1 2 12 13 14", "", false, "stride-534",
  )
  check_sort_case(
    "lsort -stride 3 -index \"end-1\" -integer -unique [list \"payload00\" \"3\" \"payload22\" \"payload03\" \"1\" \"payload25\" \"payload06\" \"2\" \"payload28\" \"payload09\" \"1\" \"payload211\" \"payload012\" \"4\" \"payload214\"]",
    "payload09 1 payload211 payload06 2 payload28 payload00 3 payload22 payload012 4 payload214",
    "", false, "stride-535",
  )
  check_sort_case(
    "lsort -stride 3 -index \"end-1\" -integer -unique -indices [list \"payload00\" \"3\" \"payload22\" \"payload03\" \"1\" \"payload25\" \"payload06\" \"2\" \"payload28\" \"payload09\" \"1\" \"payload211\" \"payload012\" \"4\" \"payload214\"]",
    "9 10 11 6 7 8 0 1 2 12 13 14", "", false, "stride-536",
  )
  check_sort_case(
    "lsort -stride 3 -index \"end-1\" -integer -decreasing [list \"payload00\" \"3\" \"payload22\" \"payload03\" \"1\" \"payload25\" \"payload06\" \"2\" \"payload28\" \"payload09\" \"1\" \"payload211\" \"payload012\" \"4\" \"payload214\"]",
    "payload012 4 payload214 payload00 3 payload22 payload06 2 payload28 payload03 1 payload25 payload09 1 payload211",
    "", false, "stride-537",
  )
  check_sort_case(
    "lsort -stride 3 -index \"end-1\" -integer -decreasing -unique -indices [list \"payload00\" \"3\" \"payload22\" \"payload03\" \"1\" \"payload25\" \"payload06\" \"2\" \"payload28\" \"payload09\" \"1\" \"payload211\" \"payload012\" \"4\" \"payload214\"]",
    "12 13 14 0 1 2 6 7 8 9 10 11", "", false, "stride-538",
  )
  check_sort_case(
    "lsort -stride 3 -index \"end-1\" -integer -increasing -nocase [list \"payload00\" \"3\" \"payload22\" \"payload03\" \"1\" \"payload25\" \"payload06\" \"2\" \"payload28\" \"payload09\" \"1\" \"payload211\" \"payload012\" \"4\" \"payload214\"]",
    "payload03 1 payload25 payload09 1 payload211 payload06 2 payload28 payload00 3 payload22 payload012 4 payload214",
    "", false, "stride-539",
  )
  check_sort_case(
    "lsort -stride 3 -index \"1 end\" -integer  [list \"payload00\" \"tag 3\" \"payload22\" \"payload03\" \"tag 1\" \"payload25\" \"payload06\" \"tag 2\" \"payload28\" \"payload09\" \"tag 1\" \"payload211\" \"payload012\" \"tag 4\" \"payload214\"]",
    "payload03 {tag 1} payload25 payload09 {tag 1} payload211 payload06 {tag 2} payload28 payload00 {tag 3} payload22 payload012 {tag 4} payload214",
    "", false, "stride-nested-540",
  )
  check_sort_case(
    "lsort -stride 3 -index \"1 end\" -integer -indices [list \"payload00\" \"tag 3\" \"payload22\" \"payload03\" \"tag 1\" \"payload25\" \"payload06\" \"tag 2\" \"payload28\" \"payload09\" \"tag 1\" \"payload211\" \"payload012\" \"tag 4\" \"payload214\"]",
    "3 4 5 9 10 11 6 7 8 0 1 2 12 13 14", "", false, "stride-nested-541",
  )
  check_sort_case(
    "lsort -stride 3 -index \"1 end\" -integer -unique [list \"payload00\" \"tag 3\" \"payload22\" \"payload03\" \"tag 1\" \"payload25\" \"payload06\" \"tag 2\" \"payload28\" \"payload09\" \"tag 1\" \"payload211\" \"payload012\" \"tag 4\" \"payload214\"]",
    "payload09 {tag 1} payload211 payload06 {tag 2} payload28 payload00 {tag 3} payload22 payload012 {tag 4} payload214",
    "", false, "stride-nested-542",
  )
  check_sort_case(
    "lsort -stride 3 -index \"1 end\" -integer -decreasing -unique -indices [list \"payload00\" \"tag 3\" \"payload22\" \"payload03\" \"tag 1\" \"payload25\" \"payload06\" \"tag 2\" \"payload28\" \"payload09\" \"tag 1\" \"payload211\" \"payload012\" \"tag 4\" \"payload214\"]",
    "12 13 14 0 1 2 6 7 8 9 10 11", "", false, "stride-nested-543",
  )
  check_sort_case(
    "lsort -stride 3 -index \"2\" -integer  [list \"payload00\" \"payload11\" \"3\" \"payload03\" \"payload14\" \"1\" \"payload06\" \"payload17\" \"2\" \"payload09\" \"payload110\" \"1\" \"payload012\" \"payload113\" \"4\"]",
    "payload03 payload14 1 payload09 payload110 1 payload06 payload17 2 payload00 payload11 3 payload012 payload113 4",
    "", false, "stride-544",
  )
  check_sort_case(
    "lsort -stride 3 -index \"2\" -integer -indices [list \"payload00\" \"payload11\" \"3\" \"payload03\" \"payload14\" \"1\" \"payload06\" \"payload17\" \"2\" \"payload09\" \"payload110\" \"1\" \"payload012\" \"payload113\" \"4\"]",
    "3 4 5 9 10 11 6 7 8 0 1 2 12 13 14", "", false, "stride-545",
  )
  check_sort_case(
    "lsort -stride 3 -index \"2\" -integer -unique [list \"payload00\" \"payload11\" \"3\" \"payload03\" \"payload14\" \"1\" \"payload06\" \"payload17\" \"2\" \"payload09\" \"payload110\" \"1\" \"payload012\" \"payload113\" \"4\"]",
    "payload09 payload110 1 payload06 payload17 2 payload00 payload11 3 payload012 payload113 4",
    "", false, "stride-546",
  )
  check_sort_case(
    "lsort -stride 3 -index \"2\" -integer -unique -indices [list \"payload00\" \"payload11\" \"3\" \"payload03\" \"payload14\" \"1\" \"payload06\" \"payload17\" \"2\" \"payload09\" \"payload110\" \"1\" \"payload012\" \"payload113\" \"4\"]",
    "9 10 11 6 7 8 0 1 2 12 13 14", "", false, "stride-547",
  )
  check_sort_case(
    "lsort -stride 3 -index \"2\" -integer -decreasing [list \"payload00\" \"payload11\" \"3\" \"payload03\" \"payload14\" \"1\" \"payload06\" \"payload17\" \"2\" \"payload09\" \"payload110\" \"1\" \"payload012\" \"payload113\" \"4\"]",
    "payload012 payload113 4 payload00 payload11 3 payload06 payload17 2 payload03 payload14 1 payload09 payload110 1",
    "", false, "stride-548",
  )
  check_sort_case(
    "lsort -stride 3 -index \"2\" -integer -decreasing -unique -indices [list \"payload00\" \"payload11\" \"3\" \"payload03\" \"payload14\" \"1\" \"payload06\" \"payload17\" \"2\" \"payload09\" \"payload110\" \"1\" \"payload012\" \"payload113\" \"4\"]",
    "12 13 14 0 1 2 6 7 8 9 10 11", "", false, "stride-549",
  )
  check_sort_case(
    "lsort -stride 3 -index \"2\" -integer -increasing -nocase [list \"payload00\" \"payload11\" \"3\" \"payload03\" \"payload14\" \"1\" \"payload06\" \"payload17\" \"2\" \"payload09\" \"payload110\" \"1\" \"payload012\" \"payload113\" \"4\"]",
    "payload03 payload14 1 payload09 payload110 1 payload06 payload17 2 payload00 payload11 3 payload012 payload113 4",
    "", false, "stride-550",
  )
  check_sort_case(
    "lsort -stride 3 -index \"end-0\" -integer  [list \"payload00\" \"payload11\" \"3\" \"payload03\" \"payload14\" \"1\" \"payload06\" \"payload17\" \"2\" \"payload09\" \"payload110\" \"1\" \"payload012\" \"payload113\" \"4\"]",
    "payload03 payload14 1 payload09 payload110 1 payload06 payload17 2 payload00 payload11 3 payload012 payload113 4",
    "", false, "stride-551",
  )
  check_sort_case(
    "lsort -stride 3 -index \"end-0\" -integer -indices [list \"payload00\" \"payload11\" \"3\" \"payload03\" \"payload14\" \"1\" \"payload06\" \"payload17\" \"2\" \"payload09\" \"payload110\" \"1\" \"payload012\" \"payload113\" \"4\"]",
    "3 4 5 9 10 11 6 7 8 0 1 2 12 13 14", "", false, "stride-552",
  )
  check_sort_case(
    "lsort -stride 3 -index \"end-0\" -integer -unique [list \"payload00\" \"payload11\" \"3\" \"payload03\" \"payload14\" \"1\" \"payload06\" \"payload17\" \"2\" \"payload09\" \"payload110\" \"1\" \"payload012\" \"payload113\" \"4\"]",
    "payload09 payload110 1 payload06 payload17 2 payload00 payload11 3 payload012 payload113 4",
    "", false, "stride-553",
  )
  check_sort_case(
    "lsort -stride 3 -index \"end-0\" -integer -unique -indices [list \"payload00\" \"payload11\" \"3\" \"payload03\" \"payload14\" \"1\" \"payload06\" \"payload17\" \"2\" \"payload09\" \"payload110\" \"1\" \"payload012\" \"payload113\" \"4\"]",
    "9 10 11 6 7 8 0 1 2 12 13 14", "", false, "stride-554",
  )
  check_sort_case(
    "lsort -stride 3 -index \"end-0\" -integer -decreasing [list \"payload00\" \"payload11\" \"3\" \"payload03\" \"payload14\" \"1\" \"payload06\" \"payload17\" \"2\" \"payload09\" \"payload110\" \"1\" \"payload012\" \"payload113\" \"4\"]",
    "payload012 payload113 4 payload00 payload11 3 payload06 payload17 2 payload03 payload14 1 payload09 payload110 1",
    "", false, "stride-555",
  )
  check_sort_case(
    "lsort -stride 3 -index \"end-0\" -integer -decreasing -unique -indices [list \"payload00\" \"payload11\" \"3\" \"payload03\" \"payload14\" \"1\" \"payload06\" \"payload17\" \"2\" \"payload09\" \"payload110\" \"1\" \"payload012\" \"payload113\" \"4\"]",
    "12 13 14 0 1 2 6 7 8 9 10 11", "", false, "stride-556",
  )
  check_sort_case(
    "lsort -stride 3 -index \"end-0\" -integer -increasing -nocase [list \"payload00\" \"payload11\" \"3\" \"payload03\" \"payload14\" \"1\" \"payload06\" \"payload17\" \"2\" \"payload09\" \"payload110\" \"1\" \"payload012\" \"payload113\" \"4\"]",
    "payload03 payload14 1 payload09 payload110 1 payload06 payload17 2 payload00 payload11 3 payload012 payload113 4",
    "", false, "stride-557",
  )
  check_sort_case(
    "lsort -stride 3 -index \"2 end\" -integer  [list \"payload00\" \"payload11\" \"tag 3\" \"payload03\" \"payload14\" \"tag 1\" \"payload06\" \"payload17\" \"tag 2\" \"payload09\" \"payload110\" \"tag 1\" \"payload012\" \"payload113\" \"tag 4\"]",
    "payload03 payload14 {tag 1} payload09 payload110 {tag 1} payload06 payload17 {tag 2} payload00 payload11 {tag 3} payload012 payload113 {tag 4}",
    "", false, "stride-nested-558",
  )
  check_sort_case(
    "lsort -stride 3 -index \"2 end\" -integer -indices [list \"payload00\" \"payload11\" \"tag 3\" \"payload03\" \"payload14\" \"tag 1\" \"payload06\" \"payload17\" \"tag 2\" \"payload09\" \"payload110\" \"tag 1\" \"payload012\" \"payload113\" \"tag 4\"]",
    "3 4 5 9 10 11 6 7 8 0 1 2 12 13 14", "", false, "stride-nested-559",
  )
}

///|
test "Tcl sort cases 561 through 600" {
  check_sort_case(
    "lsort -stride 3 -index \"2 end\" -integer -unique [list \"payload00\" \"payload11\" \"tag 3\" \"payload03\" \"payload14\" \"tag 1\" \"payload06\" \"payload17\" \"tag 2\" \"payload09\" \"payload110\" \"tag 1\" \"payload012\" \"payload113\" \"tag 4\"]",
    "payload09 payload110 {tag 1} payload06 payload17 {tag 2} payload00 payload11 {tag 3} payload012 payload113 {tag 4}",
    "", false, "stride-nested-560",
  )
  check_sort_case(
    "lsort -stride 3 -index \"2 end\" -integer -decreasing -unique -indices [list \"payload00\" \"payload11\" \"tag 3\" \"payload03\" \"payload14\" \"tag 1\" \"payload06\" \"payload17\" \"tag 2\" \"payload09\" \"payload110\" \"tag 1\" \"payload012\" \"payload113\" \"tag 4\"]",
    "12 13 14 0 1 2 6 7 8 9 10 11", "", false, "stride-nested-561",
  )
  check_sort_case(
    "lsort -stride 4 -index \"0\" -integer  [list \"3\" \"payload11\" \"payload22\" \"payload33\" \"1\" \"payload15\" \"payload26\" \"payload37\" \"2\" \"payload19\" \"payload210\" \"payload311\" \"1\" \"payload113\" \"payload214\" \"payload315\" \"4\" \"payload117\" \"payload218\" \"payload319\"]",
    "1 payload15 payload26 payload37 1 payload113 payload214 payload315 2 payload19 payload210 payload311 3 payload11 payload22 payload33 4 payload117 payload218 payload319",
    "", false, "stride-562",
  )
  check_sort_case(
    "lsort -stride 4 -index \"0\" -integer -indices [list \"3\" \"payload11\" \"payload22\" \"payload33\" \"1\" \"payload15\" \"payload26\" \"payload37\" \"2\" \"payload19\" \"payload210\" \"payload311\" \"1\" \"payload113\" \"payload214\" \"payload315\" \"4\" \"payload117\" \"payload218\" \"payload319\"]",
    "4 5 6 7 12 13 14 15 8 9 10 11 0 1 2 3 16 17 18 19", "", false, "stride-563",
  )
  check_sort_case(
    "lsort -stride 4 -index \"0\" -integer -unique [list \"3\" \"payload11\" \"payload22\" \"payload33\" \"1\" \"payload15\" \"payload26\" \"payload37\" \"2\" \"payload19\" \"payload210\" \"payload311\" \"1\" \"payload113\" \"payload214\" \"payload315\" \"4\" \"payload117\" \"payload218\" \"payload319\"]",
    "1 payload113 payload214 payload315 2 payload19 payload210 payload311 3 payload11 payload22 payload33 4 payload117 payload218 payload319",
    "", false, "stride-564",
  )
  check_sort_case(
    "lsort -stride 4 -index \"0\" -integer -unique -indices [list \"3\" \"payload11\" \"payload22\" \"payload33\" \"1\" \"payload15\" \"payload26\" \"payload37\" \"2\" \"payload19\" \"payload210\" \"payload311\" \"1\" \"payload113\" \"payload214\" \"payload315\" \"4\" \"payload117\" \"payload218\" \"payload319\"]",
    "12 13 14 15 8 9 10 11 0 1 2 3 16 17 18 19", "", false, "stride-565",
  )
  check_sort_case(
    "lsort -stride 4 -index \"0\" -integer -decreasing [list \"3\" \"payload11\" \"payload22\" \"payload33\" \"1\" \"payload15\" \"payload26\" \"payload37\" \"2\" \"payload19\" \"payload210\" \"payload311\" \"1\" \"payload113\" \"payload214\" \"payload315\" \"4\" \"payload117\" \"payload218\" \"payload319\"]",
    "4 payload117 payload218 payload319 3 payload11 payload22 payload33 2 payload19 payload210 payload311 1 payload15 payload26 payload37 1 payload113 payload214 payload315",
    "", false, "stride-566",
  )
  check_sort_case(
    "lsort -stride 4 -index \"0\" -integer -decreasing -unique -indices [list \"3\" \"payload11\" \"payload22\" \"payload33\" \"1\" \"payload15\" \"payload26\" \"payload37\" \"2\" \"payload19\" \"payload210\" \"payload311\" \"1\" \"payload113\" \"payload214\" \"payload315\" \"4\" \"payload117\" \"payload218\" \"payload319\"]",
    "16 17 18 19 0 1 2 3 8 9 10 11 12 13 14 15", "", false, "stride-567",
  )
  check_sort_case(
    "lsort -stride 4 -index \"0\" -integer -increasing -nocase [list \"3\" \"payload11\" \"payload22\" \"payload33\" \"1\" \"payload15\" \"payload26\" \"payload37\" \"2\" \"payload19\" \"payload210\" \"payload311\" \"1\" \"payload113\" \"payload214\" \"payload315\" \"4\" \"payload117\" \"payload218\" \"payload319\"]",
    "1 payload15 payload26 payload37 1 payload113 payload214 payload315 2 payload19 payload210 payload311 3 payload11 payload22 payload33 4 payload117 payload218 payload319",
    "", false, "stride-568",
  )
  check_sort_case(
    "lsort -stride 4 -index \"end-3\" -integer  [list \"3\" \"payload11\" \"payload22\" \"payload33\" \"1\" \"payload15\" \"payload26\" \"payload37\" \"2\" \"payload19\" \"payload210\" \"payload311\" \"1\" \"payload113\" \"payload214\" \"payload315\" \"4\" \"payload117\" \"payload218\" \"payload319\"]",
    "1 payload15 payload26 payload37 1 payload113 payload214 payload315 2 payload19 payload210 payload311 3 payload11 payload22 payload33 4 payload117 payload218 payload319",
    "", false, "stride-569",
  )
  check_sort_case(
    "lsort -stride 4 -index \"end-3\" -integer -indices [list \"3\" \"payload11\" \"payload22\" \"payload33\" \"1\" \"payload15\" \"payload26\" \"payload37\" \"2\" \"payload19\" \"payload210\" \"payload311\" \"1\" \"payload113\" \"payload214\" \"payload315\" \"4\" \"payload117\" \"payload218\" \"payload319\"]",
    "4 5 6 7 12 13 14 15 8 9 10 11 0 1 2 3 16 17 18 19", "", false, "stride-570",
  )
  check_sort_case(
    "lsort -stride 4 -index \"end-3\" -integer -unique [list \"3\" \"payload11\" \"payload22\" \"payload33\" \"1\" \"payload15\" \"payload26\" \"payload37\" \"2\" \"payload19\" \"payload210\" \"payload311\" \"1\" \"payload113\" \"payload214\" \"payload315\" \"4\" \"payload117\" \"payload218\" \"payload319\"]",
    "1 payload113 payload214 payload315 2 payload19 payload210 payload311 3 payload11 payload22 payload33 4 payload117 payload218 payload319",
    "", false, "stride-571",
  )
  check_sort_case(
    "lsort -stride 4 -index \"end-3\" -integer -unique -indices [list \"3\" \"payload11\" \"payload22\" \"payload33\" \"1\" \"payload15\" \"payload26\" \"payload37\" \"2\" \"payload19\" \"payload210\" \"payload311\" \"1\" \"payload113\" \"payload214\" \"payload315\" \"4\" \"payload117\" \"payload218\" \"payload319\"]",
    "12 13 14 15 8 9 10 11 0 1 2 3 16 17 18 19", "", false, "stride-572",
  )
  check_sort_case(
    "lsort -stride 4 -index \"end-3\" -integer -decreasing [list \"3\" \"payload11\" \"payload22\" \"payload33\" \"1\" \"payload15\" \"payload26\" \"payload37\" \"2\" \"payload19\" \"payload210\" \"payload311\" \"1\" \"payload113\" \"payload214\" \"payload315\" \"4\" \"payload117\" \"payload218\" \"payload319\"]",
    "4 payload117 payload218 payload319 3 payload11 payload22 payload33 2 payload19 payload210 payload311 1 payload15 payload26 payload37 1 payload113 payload214 payload315",
    "", false, "stride-573",
  )
  check_sort_case(
    "lsort -stride 4 -index \"end-3\" -integer -decreasing -unique -indices [list \"3\" \"payload11\" \"payload22\" \"payload33\" \"1\" \"payload15\" \"payload26\" \"payload37\" \"2\" \"payload19\" \"payload210\" \"payload311\" \"1\" \"payload113\" \"payload214\" \"payload315\" \"4\" \"payload117\" \"payload218\" \"payload319\"]",
    "16 17 18 19 0 1 2 3 8 9 10 11 12 13 14 15", "", false, "stride-574",
  )
  check_sort_case(
    "lsort -stride 4 -index \"end-3\" -integer -increasing -nocase [list \"3\" \"payload11\" \"payload22\" \"payload33\" \"1\" \"payload15\" \"payload26\" \"payload37\" \"2\" \"payload19\" \"payload210\" \"payload311\" \"1\" \"payload113\" \"payload214\" \"payload315\" \"4\" \"payload117\" \"payload218\" \"payload319\"]",
    "1 payload15 payload26 payload37 1 payload113 payload214 payload315 2 payload19 payload210 payload311 3 payload11 payload22 payload33 4 payload117 payload218 payload319",
    "", false, "stride-575",
  )
  check_sort_case(
    "lsort -stride 4 -index \"0 end\" -integer  [list \"tag 3\" \"payload11\" \"payload22\" \"payload33\" \"tag 1\" \"payload15\" \"payload26\" \"payload37\" \"tag 2\" \"payload19\" \"payload210\" \"payload311\" \"tag 1\" \"payload113\" \"payload214\" \"payload315\" \"tag 4\" \"payload117\" \"payload218\" \"payload319\"]",
    "{tag 1} payload15 payload26 payload37 {tag 1} payload113 payload214 payload315 {tag 2} payload19 payload210 payload311 {tag 3} payload11 payload22 payload33 {tag 4} payload117 payload218 payload319",
    "", false, "stride-nested-576",
  )
  check_sort_case(
    "lsort -stride 4 -index \"0 end\" -integer -indices [list \"tag 3\" \"payload11\" \"payload22\" \"payload33\" \"tag 1\" \"payload15\" \"payload26\" \"payload37\" \"tag 2\" \"payload19\" \"payload210\" \"payload311\" \"tag 1\" \"payload113\" \"payload214\" \"payload315\" \"tag 4\" \"payload117\" \"payload218\" \"payload319\"]",
    "4 5 6 7 12 13 14 15 8 9 10 11 0 1 2 3 16 17 18 19", "", false, "stride-nested-577",
  )
  check_sort_case(
    "lsort -stride 4 -index \"0 end\" -integer -unique [list \"tag 3\" \"payload11\" \"payload22\" \"payload33\" \"tag 1\" \"payload15\" \"payload26\" \"payload37\" \"tag 2\" \"payload19\" \"payload210\" \"payload311\" \"tag 1\" \"payload113\" \"payload214\" \"payload315\" \"tag 4\" \"payload117\" \"payload218\" \"payload319\"]",
    "{tag 1} payload113 payload214 payload315 {tag 2} payload19 payload210 payload311 {tag 3} payload11 payload22 payload33 {tag 4} payload117 payload218 payload319",
    "", false, "stride-nested-578",
  )
  check_sort_case(
    "lsort -stride 4 -index \"0 end\" -integer -decreasing -unique -indices [list \"tag 3\" \"payload11\" \"payload22\" \"payload33\" \"tag 1\" \"payload15\" \"payload26\" \"payload37\" \"tag 2\" \"payload19\" \"payload210\" \"payload311\" \"tag 1\" \"payload113\" \"payload214\" \"payload315\" \"tag 4\" \"payload117\" \"payload218\" \"payload319\"]",
    "16 17 18 19 0 1 2 3 8 9 10 11 12 13 14 15", "", false, "stride-nested-579",
  )
  check_sort_case(
    "lsort -stride 4 -index \"1\" -integer  [list \"payload00\" \"3\" \"payload22\" \"payload33\" \"payload04\" \"1\" \"payload26\" \"payload37\" \"payload08\" \"2\" \"payload210\" \"payload311\" \"payload012\" \"1\" \"payload214\" \"payload315\" \"payload016\" \"4\" \"payload218\" \"payload319\"]",
    "payload04 1 payload26 payload37 payload012 1 payload214 payload315 payload08 2 payload210 payload311 payload00 3 payload22 payload33 payload016 4 payload218 payload319",
    "", false, "stride-580",
  )
  check_sort_case(
    "lsort -stride 4 -index \"1\" -integer -indices [list \"payload00\" \"3\" \"payload22\" \"payload33\" \"payload04\" \"1\" \"payload26\" \"payload37\" \"payload08\" \"2\" \"payload210\" \"payload311\" \"payload012\" \"1\" \"payload214\" \"payload315\" \"payload016\" \"4\" \"payload218\" \"payload319\"]",
    "4 5 6 7 12 13 14 15 8 9 10 11 0 1 2 3 16 17 18 19", "", false, "stride-581",
  )
  check_sort_case(
    "lsort -stride 4 -index \"1\" -integer -unique [list \"payload00\" \"3\" \"payload22\" \"payload33\" \"payload04\" \"1\" \"payload26\" \"payload37\" \"payload08\" \"2\" \"payload210\" \"payload311\" \"payload012\" \"1\" \"payload214\" \"payload315\" \"payload016\" \"4\" \"payload218\" \"payload319\"]",
    "payload012 1 payload214 payload315 payload08 2 payload210 payload311 payload00 3 payload22 payload33 payload016 4 payload218 payload319",
    "", false, "stride-582",
  )
  check_sort_case(
    "lsort -stride 4 -index \"1\" -integer -unique -indices [list \"payload00\" \"3\" \"payload22\" \"payload33\" \"payload04\" \"1\" \"payload26\" \"payload37\" \"payload08\" \"2\" \"payload210\" \"payload311\" \"payload012\" \"1\" \"payload214\" \"payload315\" \"payload016\" \"4\" \"payload218\" \"payload319\"]",
    "12 13 14 15 8 9 10 11 0 1 2 3 16 17 18 19", "", false, "stride-583",
  )
  check_sort_case(
    "lsort -stride 4 -index \"1\" -integer -decreasing [list \"payload00\" \"3\" \"payload22\" \"payload33\" \"payload04\" \"1\" \"payload26\" \"payload37\" \"payload08\" \"2\" \"payload210\" \"payload311\" \"payload012\" \"1\" \"payload214\" \"payload315\" \"payload016\" \"4\" \"payload218\" \"payload319\"]",
    "payload016 4 payload218 payload319 payload00 3 payload22 payload33 payload08 2 payload210 payload311 payload04 1 payload26 payload37 payload012 1 payload214 payload315",
    "", false, "stride-584",
  )
  check_sort_case(
    "lsort -stride 4 -index \"1\" -integer -decreasing -unique -indices [list \"payload00\" \"3\" \"payload22\" \"payload33\" \"payload04\" \"1\" \"payload26\" \"payload37\" \"payload08\" \"2\" \"payload210\" \"payload311\" \"payload012\" \"1\" \"payload214\" \"payload315\" \"payload016\" \"4\" \"payload218\" \"payload319\"]",
    "16 17 18 19 0 1 2 3 8 9 10 11 12 13 14 15", "", false, "stride-585",
  )
  check_sort_case(
    "lsort -stride 4 -index \"1\" -integer -increasing -nocase [list \"payload00\" \"3\" \"payload22\" \"payload33\" \"payload04\" \"1\" \"payload26\" \"payload37\" \"payload08\" \"2\" \"payload210\" \"payload311\" \"payload012\" \"1\" \"payload214\" \"payload315\" \"payload016\" \"4\" \"payload218\" \"payload319\"]",
    "payload04 1 payload26 payload37 payload012 1 payload214 payload315 payload08 2 payload210 payload311 payload00 3 payload22 payload33 payload016 4 payload218 payload319",
    "", false, "stride-586",
  )
  check_sort_case(
    "lsort -stride 4 -index \"end-2\" -integer  [list \"payload00\" \"3\" \"payload22\" \"payload33\" \"payload04\" \"1\" \"payload26\" \"payload37\" \"payload08\" \"2\" \"payload210\" \"payload311\" \"payload012\" \"1\" \"payload214\" \"payload315\" \"payload016\" \"4\" \"payload218\" \"payload319\"]",
    "payload04 1 payload26 payload37 payload012 1 payload214 payload315 payload08 2 payload210 payload311 payload00 3 payload22 payload33 payload016 4 payload218 payload319",
    "", false, "stride-587",
  )
  check_sort_case(
    "lsort -stride 4 -index \"end-2\" -integer -indices [list \"payload00\" \"3\" \"payload22\" \"payload33\" \"payload04\" \"1\" \"payload26\" \"payload37\" \"payload08\" \"2\" \"payload210\" \"payload311\" \"payload012\" \"1\" \"payload214\" \"payload315\" \"payload016\" \"4\" \"payload218\" \"payload319\"]",
    "4 5 6 7 12 13 14 15 8 9 10 11 0 1 2 3 16 17 18 19", "", false, "stride-588",
  )
  check_sort_case(
    "lsort -stride 4 -index \"end-2\" -integer -unique [list \"payload00\" \"3\" \"payload22\" \"payload33\" \"payload04\" \"1\" \"payload26\" \"payload37\" \"payload08\" \"2\" \"payload210\" \"payload311\" \"payload012\" \"1\" \"payload214\" \"payload315\" \"payload016\" \"4\" \"payload218\" \"payload319\"]",
    "payload012 1 payload214 payload315 payload08 2 payload210 payload311 payload00 3 payload22 payload33 payload016 4 payload218 payload319",
    "", false, "stride-589",
  )
  check_sort_case(
    "lsort -stride 4 -index \"end-2\" -integer -unique -indices [list \"payload00\" \"3\" \"payload22\" \"payload33\" \"payload04\" \"1\" \"payload26\" \"payload37\" \"payload08\" \"2\" \"payload210\" \"payload311\" \"payload012\" \"1\" \"payload214\" \"payload315\" \"payload016\" \"4\" \"payload218\" \"payload319\"]",
    "12 13 14 15 8 9 10 11 0 1 2 3 16 17 18 19", "", false, "stride-590",
  )
  check_sort_case(
    "lsort -stride 4 -index \"end-2\" -integer -decreasing [list \"payload00\" \"3\" \"payload22\" \"payload33\" \"payload04\" \"1\" \"payload26\" \"payload37\" \"payload08\" \"2\" \"payload210\" \"payload311\" \"payload012\" \"1\" \"payload214\" \"payload315\" \"payload016\" \"4\" \"payload218\" \"payload319\"]",
    "payload016 4 payload218 payload319 payload00 3 payload22 payload33 payload08 2 payload210 payload311 payload04 1 payload26 payload37 payload012 1 payload214 payload315",
    "", false, "stride-591",
  )
  check_sort_case(
    "lsort -stride 4 -index \"end-2\" -integer -decreasing -unique -indices [list \"payload00\" \"3\" \"payload22\" \"payload33\" \"payload04\" \"1\" \"payload26\" \"payload37\" \"payload08\" \"2\" \"payload210\" \"payload311\" \"payload012\" \"1\" \"payload214\" \"payload315\" \"payload016\" \"4\" \"payload218\" \"payload319\"]",
    "16 17 18 19 0 1 2 3 8 9 10 11 12 13 14 15", "", false, "stride-592",
  )
  check_sort_case(
    "lsort -stride 4 -index \"end-2\" -integer -increasing -nocase [list \"payload00\" \"3\" \"payload22\" \"payload33\" \"payload04\" \"1\" \"payload26\" \"payload37\" \"payload08\" \"2\" \"payload210\" \"payload311\" \"payload012\" \"1\" \"payload214\" \"payload315\" \"payload016\" \"4\" \"payload218\" \"payload319\"]",
    "payload04 1 payload26 payload37 payload012 1 payload214 payload315 payload08 2 payload210 payload311 payload00 3 payload22 payload33 payload016 4 payload218 payload319",
    "", false, "stride-593",
  )
  check_sort_case(
    "lsort -stride 4 -index \"1 end\" -integer  [list \"payload00\" \"tag 3\" \"payload22\" \"payload33\" \"payload04\" \"tag 1\" \"payload26\" \"payload37\" \"payload08\" \"tag 2\" \"payload210\" \"payload311\" \"payload012\" \"tag 1\" \"payload214\" \"payload315\" \"payload016\" \"tag 4\" \"payload218\" \"payload319\"]",
    "payload04 {tag 1} payload26 payload37 payload012 {tag 1} payload214 payload315 payload08 {tag 2} payload210 payload311 payload00 {tag 3} payload22 payload33 payload016 {tag 4} payload218 payload319",
    "", false, "stride-nested-594",
  )
  check_sort_case(
    "lsort -stride 4 -index \"1 end\" -integer -indices [list \"payload00\" \"tag 3\" \"payload22\" \"payload33\" \"payload04\" \"tag 1\" \"payload26\" \"payload37\" \"payload08\" \"tag 2\" \"payload210\" \"payload311\" \"payload012\" \"tag 1\" \"payload214\" \"payload315\" \"payload016\" \"tag 4\" \"payload218\" \"payload319\"]",
    "4 5 6 7 12 13 14 15 8 9 10 11 0 1 2 3 16 17 18 19", "", false, "stride-nested-595",
  )
  check_sort_case(
    "lsort -stride 4 -index \"1 end\" -integer -unique [list \"payload00\" \"tag 3\" \"payload22\" \"payload33\" \"payload04\" \"tag 1\" \"payload26\" \"payload37\" \"payload08\" \"tag 2\" \"payload210\" \"payload311\" \"payload012\" \"tag 1\" \"payload214\" \"payload315\" \"payload016\" \"tag 4\" \"payload218\" \"payload319\"]",
    "payload012 {tag 1} payload214 payload315 payload08 {tag 2} payload210 payload311 payload00 {tag 3} payload22 payload33 payload016 {tag 4} payload218 payload319",
    "", false, "stride-nested-596",
  )
  check_sort_case(
    "lsort -stride 4 -index \"1 end\" -integer -decreasing -unique -indices [list \"payload00\" \"tag 3\" \"payload22\" \"payload33\" \"payload04\" \"tag 1\" \"payload26\" \"payload37\" \"payload08\" \"tag 2\" \"payload210\" \"payload311\" \"payload012\" \"tag 1\" \"payload214\" \"payload315\" \"payload016\" \"tag 4\" \"payload218\" \"payload319\"]",
    "16 17 18 19 0 1 2 3 8 9 10 11 12 13 14 15", "", false, "stride-nested-597",
  )
  check_sort_case(
    "lsort -stride 4 -index \"2\" -integer  [list \"payload00\" \"payload11\" \"3\" \"payload33\" \"payload04\" \"payload15\" \"1\" \"payload37\" \"payload08\" \"payload19\" \"2\" \"payload311\" \"payload012\" \"payload113\" \"1\" \"payload315\" \"payload016\" \"payload117\" \"4\" \"payload319\"]",
    "payload04 payload15 1 payload37 payload012 payload113 1 payload315 payload08 payload19 2 payload311 payload00 payload11 3 payload33 payload016 payload117 4 payload319",
    "", false, "stride-598",
  )
  check_sort_case(
    "lsort -stride 4 -index \"2\" -integer -indices [list \"payload00\" \"payload11\" \"3\" \"payload33\" \"payload04\" \"payload15\" \"1\" \"payload37\" \"payload08\" \"payload19\" \"2\" \"payload311\" \"payload012\" \"payload113\" \"1\" \"payload315\" \"payload016\" \"payload117\" \"4\" \"payload319\"]",
    "4 5 6 7 12 13 14 15 8 9 10 11 0 1 2 3 16 17 18 19", "", false, "stride-599",
  )
}

///|
test "Tcl sort cases 601 through 640" {
  check_sort_case(
    "lsort -stride 4 -index \"2\" -integer -unique [list \"payload00\" \"payload11\" \"3\" \"payload33\" \"payload04\" \"payload15\" \"1\" \"payload37\" \"payload08\" \"payload19\" \"2\" \"payload311\" \"payload012\" \"payload113\" \"1\" \"payload315\" \"payload016\" \"payload117\" \"4\" \"payload319\"]",
    "payload012 payload113 1 payload315 payload08 payload19 2 payload311 payload00 payload11 3 payload33 payload016 payload117 4 payload319",
    "", false, "stride-600",
  )
  check_sort_case(
    "lsort -stride 4 -index \"2\" -integer -unique -indices [list \"payload00\" \"payload11\" \"3\" \"payload33\" \"payload04\" \"payload15\" \"1\" \"payload37\" \"payload08\" \"payload19\" \"2\" \"payload311\" \"payload012\" \"payload113\" \"1\" \"payload315\" \"payload016\" \"payload117\" \"4\" \"payload319\"]",
    "12 13 14 15 8 9 10 11 0 1 2 3 16 17 18 19", "", false, "stride-601",
  )
  check_sort_case(
    "lsort -stride 4 -index \"2\" -integer -decreasing [list \"payload00\" \"payload11\" \"3\" \"payload33\" \"payload04\" \"payload15\" \"1\" \"payload37\" \"payload08\" \"payload19\" \"2\" \"payload311\" \"payload012\" \"payload113\" \"1\" \"payload315\" \"payload016\" \"payload117\" \"4\" \"payload319\"]",
    "payload016 payload117 4 payload319 payload00 payload11 3 payload33 payload08 payload19 2 payload311 payload04 payload15 1 payload37 payload012 payload113 1 payload315",
    "", false, "stride-602",
  )
  check_sort_case(
    "lsort -stride 4 -index \"2\" -integer -decreasing -unique -indices [list \"payload00\" \"payload11\" \"3\" \"payload33\" \"payload04\" \"payload15\" \"1\" \"payload37\" \"payload08\" \"payload19\" \"2\" \"payload311\" \"payload012\" \"payload113\" \"1\" \"payload315\" \"payload016\" \"payload117\" \"4\" \"payload319\"]",
    "16 17 18 19 0 1 2 3 8 9 10 11 12 13 14 15", "", false, "stride-603",
  )
  check_sort_case(
    "lsort -stride 4 -index \"2\" -integer -increasing -nocase [list \"payload00\" \"payload11\" \"3\" \"payload33\" \"payload04\" \"payload15\" \"1\" \"payload37\" \"payload08\" \"payload19\" \"2\" \"payload311\" \"payload012\" \"payload113\" \"1\" \"payload315\" \"payload016\" \"payload117\" \"4\" \"payload319\"]",
    "payload04 payload15 1 payload37 payload012 payload113 1 payload315 payload08 payload19 2 payload311 payload00 payload11 3 payload33 payload016 payload117 4 payload319",
    "", false, "stride-604",
  )
  check_sort_case(
    "lsort -stride 4 -index \"end-1\" -integer  [list \"payload00\" \"payload11\" \"3\" \"payload33\" \"payload04\" \"payload15\" \"1\" \"payload37\" \"payload08\" \"payload19\" \"2\" \"payload311\" \"payload012\" \"payload113\" \"1\" \"payload315\" \"payload016\" \"payload117\" \"4\" \"payload319\"]",
    "payload04 payload15 1 payload37 payload012 payload113 1 payload315 payload08 payload19 2 payload311 payload00 payload11 3 payload33 payload016 payload117 4 payload319",
    "", false, "stride-605",
  )
  check_sort_case(
    "lsort -stride 4 -index \"end-1\" -integer -indices [list \"payload00\" \"payload11\" \"3\" \"payload33\" \"payload04\" \"payload15\" \"1\" \"payload37\" \"payload08\" \"payload19\" \"2\" \"payload311\" \"payload012\" \"payload113\" \"1\" \"payload315\" \"payload016\" \"payload117\" \"4\" \"payload319\"]",
    "4 5 6 7 12 13 14 15 8 9 10 11 0 1 2 3 16 17 18 19", "", false, "stride-606",
  )
  check_sort_case(
    "lsort -stride 4 -index \"end-1\" -integer -unique [list \"payload00\" \"payload11\" \"3\" \"payload33\" \"payload04\" \"payload15\" \"1\" \"payload37\" \"payload08\" \"payload19\" \"2\" \"payload311\" \"payload012\" \"payload113\" \"1\" \"payload315\" \"payload016\" \"payload117\" \"4\" \"payload319\"]",
    "payload012 payload113 1 payload315 payload08 payload19 2 payload311 payload00 payload11 3 payload33 payload016 payload117 4 payload319",
    "", false, "stride-607",
  )
  check_sort_case(
    "lsort -stride 4 -index \"end-1\" -integer -unique -indices [list \"payload00\" \"payload11\" \"3\" \"payload33\" \"payload04\" \"payload15\" \"1\" \"payload37\" \"payload08\" \"payload19\" \"2\" \"payload311\" \"payload012\" \"payload113\" \"1\" \"payload315\" \"payload016\" \"payload117\" \"4\" \"payload319\"]",
    "12 13 14 15 8 9 10 11 0 1 2 3 16 17 18 19", "", false, "stride-608",
  )
  check_sort_case(
    "lsort -stride 4 -index \"end-1\" -integer -decreasing [list \"payload00\" \"payload11\" \"3\" \"payload33\" \"payload04\" \"payload15\" \"1\" \"payload37\" \"payload08\" \"payload19\" \"2\" \"payload311\" \"payload012\" \"payload113\" \"1\" \"payload315\" \"payload016\" \"payload117\" \"4\" \"payload319\"]",
    "payload016 payload117 4 payload319 payload00 payload11 3 payload33 payload08 payload19 2 payload311 payload04 payload15 1 payload37 payload012 payload113 1 payload315",
    "", false, "stride-609",
  )
  check_sort_case(
    "lsort -stride 4 -index \"end-1\" -integer -decreasing -unique -indices [list \"payload00\" \"payload11\" \"3\" \"payload33\" \"payload04\" \"payload15\" \"1\" \"payload37\" \"payload08\" \"payload19\" \"2\" \"payload311\" \"payload012\" \"payload113\" \"1\" \"payload315\" \"payload016\" \"payload117\" \"4\" \"payload319\"]",
    "16 17 18 19 0 1 2 3 8 9 10 11 12 13 14 15", "", false, "stride-610",
  )
  check_sort_case(
    "lsort -stride 4 -index \"end-1\" -integer -increasing -nocase [list \"payload00\" \"payload11\" \"3\" \"payload33\" \"payload04\" \"payload15\" \"1\" \"payload37\" \"payload08\" \"payload19\" \"2\" \"payload311\" \"payload012\" \"payload113\" \"1\" \"payload315\" \"payload016\" \"payload117\" \"4\" \"payload319\"]",
    "payload04 payload15 1 payload37 payload012 payload113 1 payload315 payload08 payload19 2 payload311 payload00 payload11 3 payload33 payload016 payload117 4 payload319",
    "", false, "stride-611",
  )
  check_sort_case(
    "lsort -stride 4 -index \"2 end\" -integer  [list \"payload00\" \"payload11\" \"tag 3\" \"payload33\" \"payload04\" \"payload15\" \"tag 1\" \"payload37\" \"payload08\" \"payload19\" \"tag 2\" \"payload311\" \"payload012\" \"payload113\" \"tag 1\" \"payload315\" \"payload016\" \"payload117\" \"tag 4\" \"payload319\"]",
    "payload04 payload15 {tag 1} payload37 payload012 payload113 {tag 1} payload315 payload08 payload19 {tag 2} payload311 payload00 payload11 {tag 3} payload33 payload016 payload117 {tag 4} payload319",
    "", false, "stride-nested-612",
  )
  check_sort_case(
    "lsort -stride 4 -index \"2 end\" -integer -indices [list \"payload00\" \"payload11\" \"tag 3\" \"payload33\" \"payload04\" \"payload15\" \"tag 1\" \"payload37\" \"payload08\" \"payload19\" \"tag 2\" \"payload311\" \"payload012\" \"payload113\" \"tag 1\" \"payload315\" \"payload016\" \"payload117\" \"tag 4\" \"payload319\"]",
    "4 5 6 7 12 13 14 15 8 9 10 11 0 1 2 3 16 17 18 19", "", false, "stride-nested-613",
  )
  check_sort_case(
    "lsort -stride 4 -index \"2 end\" -integer -unique [list \"payload00\" \"payload11\" \"tag 3\" \"payload33\" \"payload04\" \"payload15\" \"tag 1\" \"payload37\" \"payload08\" \"payload19\" \"tag 2\" \"payload311\" \"payload012\" \"payload113\" \"tag 1\" \"payload315\" \"payload016\" \"payload117\" \"tag 4\" \"payload319\"]",
    "payload012 payload113 {tag 1} payload315 payload08 payload19 {tag 2} payload311 payload00 payload11 {tag 3} payload33 payload016 payload117 {tag 4} payload319",
    "", false, "stride-nested-614",
  )
  check_sort_case(
    "lsort -stride 4 -index \"2 end\" -integer -decreasing -unique -indices [list \"payload00\" \"payload11\" \"tag 3\" \"payload33\" \"payload04\" \"payload15\" \"tag 1\" \"payload37\" \"payload08\" \"payload19\" \"tag 2\" \"payload311\" \"payload012\" \"payload113\" \"tag 1\" \"payload315\" \"payload016\" \"payload117\" \"tag 4\" \"payload319\"]",
    "16 17 18 19 0 1 2 3 8 9 10 11 12 13 14 15", "", false, "stride-nested-615",
  )
  check_sort_case(
    "lsort -stride 4 -index \"3\" -integer  [list \"payload00\" \"payload11\" \"payload22\" \"3\" \"payload04\" \"payload15\" \"payload26\" \"1\" \"payload08\" \"payload19\" \"payload210\" \"2\" \"payload012\" \"payload113\" \"payload214\" \"1\" \"payload016\" \"payload117\" \"payload218\" \"4\"]",
    "payload04 payload15 payload26 1 payload012 payload113 payload214 1 payload08 payload19 payload210 2 payload00 payload11 payload22 3 payload016 payload117 payload218 4",
    "", false, "stride-616",
  )
  check_sort_case(
    "lsort -stride 4 -index \"3\" -integer -indices [list \"payload00\" \"payload11\" \"payload22\" \"3\" \"payload04\" \"payload15\" \"payload26\" \"1\" \"payload08\" \"payload19\" \"payload210\" \"2\" \"payload012\" \"payload113\" \"payload214\" \"1\" \"payload016\" \"payload117\" \"payload218\" \"4\"]",
    "4 5 6 7 12 13 14 15 8 9 10 11 0 1 2 3 16 17 18 19", "", false, "stride-617",
  )
  check_sort_case(
    "lsort -stride 4 -index \"3\" -integer -unique [list \"payload00\" \"payload11\" \"payload22\" \"3\" \"payload04\" \"payload15\" \"payload26\" \"1\" \"payload08\" \"payload19\" \"payload210\" \"2\" \"payload012\" \"payload113\" \"payload214\" \"1\" \"payload016\" \"payload117\" \"payload218\" \"4\"]",
    "payload012 payload113 payload214 1 payload08 payload19 payload210 2 payload00 payload11 payload22 3 payload016 payload117 payload218 4",
    "", false, "stride-618",
  )
  check_sort_case(
    "lsort -stride 4 -index \"3\" -integer -unique -indices [list \"payload00\" \"payload11\" \"payload22\" \"3\" \"payload04\" \"payload15\" \"payload26\" \"1\" \"payload08\" \"payload19\" \"payload210\" \"2\" \"payload012\" \"payload113\" \"payload214\" \"1\" \"payload016\" \"payload117\" \"payload218\" \"4\"]",
    "12 13 14 15 8 9 10 11 0 1 2 3 16 17 18 19", "", false, "stride-619",
  )
  check_sort_case(
    "lsort -stride 4 -index \"3\" -integer -decreasing [list \"payload00\" \"payload11\" \"payload22\" \"3\" \"payload04\" \"payload15\" \"payload26\" \"1\" \"payload08\" \"payload19\" \"payload210\" \"2\" \"payload012\" \"payload113\" \"payload214\" \"1\" \"payload016\" \"payload117\" \"payload218\" \"4\"]",
    "payload016 payload117 payload218 4 payload00 payload11 payload22 3 payload08 payload19 payload210 2 payload04 payload15 payload26 1 payload012 payload113 payload214 1",
    "", false, "stride-620",
  )
  check_sort_case(
    "lsort -stride 4 -index \"3\" -integer -decreasing -unique -indices [list \"payload00\" \"payload11\" \"payload22\" \"3\" \"payload04\" \"payload15\" \"payload26\" \"1\" \"payload08\" \"payload19\" \"payload210\" \"2\" \"payload012\" \"payload113\" \"payload214\" \"1\" \"payload016\" \"payload117\" \"payload218\" \"4\"]",
    "16 17 18 19 0 1 2 3 8 9 10 11 12 13 14 15", "", false, "stride-621",
  )
  check_sort_case(
    "lsort -stride 4 -index \"3\" -integer -increasing -nocase [list \"payload00\" \"payload11\" \"payload22\" \"3\" \"payload04\" \"payload15\" \"payload26\" \"1\" \"payload08\" \"payload19\" \"payload210\" \"2\" \"payload012\" \"payload113\" \"payload214\" \"1\" \"payload016\" \"payload117\" \"payload218\" \"4\"]",
    "payload04 payload15 payload26 1 payload012 payload113 payload214 1 payload08 payload19 payload210 2 payload00 payload11 payload22 3 payload016 payload117 payload218 4",
    "", false, "stride-622",
  )
  check_sort_case(
    "lsort -stride 4 -index \"end-0\" -integer  [list \"payload00\" \"payload11\" \"payload22\" \"3\" \"payload04\" \"payload15\" \"payload26\" \"1\" \"payload08\" \"payload19\" \"payload210\" \"2\" \"payload012\" \"payload113\" \"payload214\" \"1\" \"payload016\" \"payload117\" \"payload218\" \"4\"]",
    "payload04 payload15 payload26 1 payload012 payload113 payload214 1 payload08 payload19 payload210 2 payload00 payload11 payload22 3 payload016 payload117 payload218 4",
    "", false, "stride-623",
  )
  check_sort_case(
    "lsort -stride 4 -index \"end-0\" -integer -indices [list \"payload00\" \"payload11\" \"payload22\" \"3\" \"payload04\" \"payload15\" \"payload26\" \"1\" \"payload08\" \"payload19\" \"payload210\" \"2\" \"payload012\" \"payload113\" \"payload214\" \"1\" \"payload016\" \"payload117\" \"payload218\" \"4\"]",
    "4 5 6 7 12 13 14 15 8 9 10 11 0 1 2 3 16 17 18 19", "", false, "stride-624",
  )
  check_sort_case(
    "lsort -stride 4 -index \"end-0\" -integer -unique [list \"payload00\" \"payload11\" \"payload22\" \"3\" \"payload04\" \"payload15\" \"payload26\" \"1\" \"payload08\" \"payload19\" \"payload210\" \"2\" \"payload012\" \"payload113\" \"payload214\" \"1\" \"payload016\" \"payload117\" \"payload218\" \"4\"]",
    "payload012 payload113 payload214 1 payload08 payload19 payload210 2 payload00 payload11 payload22 3 payload016 payload117 payload218 4",
    "", false, "stride-625",
  )
  check_sort_case(
    "lsort -stride 4 -index \"end-0\" -integer -unique -indices [list \"payload00\" \"payload11\" \"payload22\" \"3\" \"payload04\" \"payload15\" \"payload26\" \"1\" \"payload08\" \"payload19\" \"payload210\" \"2\" \"payload012\" \"payload113\" \"payload214\" \"1\" \"payload016\" \"payload117\" \"payload218\" \"4\"]",
    "12 13 14 15 8 9 10 11 0 1 2 3 16 17 18 19", "", false, "stride-626",
  )
  check_sort_case(
    "lsort -stride 4 -index \"end-0\" -integer -decreasing [list \"payload00\" \"payload11\" \"payload22\" \"3\" \"payload04\" \"payload15\" \"payload26\" \"1\" \"payload08\" \"payload19\" \"payload210\" \"2\" \"payload012\" \"payload113\" \"payload214\" \"1\" \"payload016\" \"payload117\" \"payload218\" \"4\"]",
    "payload016 payload117 payload218 4 payload00 payload11 payload22 3 payload08 payload19 payload210 2 payload04 payload15 payload26 1 payload012 payload113 payload214 1",
    "", false, "stride-627",
  )
  check_sort_case(
    "lsort -stride 4 -index \"end-0\" -integer -decreasing -unique -indices [list \"payload00\" \"payload11\" \"payload22\" \"3\" \"payload04\" \"payload15\" \"payload26\" \"1\" \"payload08\" \"payload19\" \"payload210\" \"2\" \"payload012\" \"payload113\" \"payload214\" \"1\" \"payload016\" \"payload117\" \"payload218\" \"4\"]",
    "16 17 18 19 0 1 2 3 8 9 10 11 12 13 14 15", "", false, "stride-628",
  )
  check_sort_case(
    "lsort -stride 4 -index \"end-0\" -integer -increasing -nocase [list \"payload00\" \"payload11\" \"payload22\" \"3\" \"payload04\" \"payload15\" \"payload26\" \"1\" \"payload08\" \"payload19\" \"payload210\" \"2\" \"payload012\" \"payload113\" \"payload214\" \"1\" \"payload016\" \"payload117\" \"payload218\" \"4\"]",
    "payload04 payload15 payload26 1 payload012 payload113 payload214 1 payload08 payload19 payload210 2 payload00 payload11 payload22 3 payload016 payload117 payload218 4",
    "", false, "stride-629",
  )
  check_sort_case(
    "lsort -stride 4 -index \"3 end\" -integer  [list \"payload00\" \"payload11\" \"payload22\" \"tag 3\" \"payload04\" \"payload15\" \"payload26\" \"tag 1\" \"payload08\" \"payload19\" \"payload210\" \"tag 2\" \"payload012\" \"payload113\" \"payload214\" \"tag 1\" \"payload016\" \"payload117\" \"payload218\" \"tag 4\"]",
    "payload04 payload15 payload26 {tag 1} payload012 payload113 payload214 {tag 1} payload08 payload19 payload210 {tag 2} payload00 payload11 payload22 {tag 3} payload016 payload117 payload218 {tag 4}",
    "", false, "stride-nested-630",
  )
  check_sort_case(
    "lsort -stride 4 -index \"3 end\" -integer -indices [list \"payload00\" \"payload11\" \"payload22\" \"tag 3\" \"payload04\" \"payload15\" \"payload26\" \"tag 1\" \"payload08\" \"payload19\" \"payload210\" \"tag 2\" \"payload012\" \"payload113\" \"payload214\" \"tag 1\" \"payload016\" \"payload117\" \"payload218\" \"tag 4\"]",
    "4 5 6 7 12 13 14 15 8 9 10 11 0 1 2 3 16 17 18 19", "", false, "stride-nested-631",
  )
  check_sort_case(
    "lsort -stride 4 -index \"3 end\" -integer -unique [list \"payload00\" \"payload11\" \"payload22\" \"tag 3\" \"payload04\" \"payload15\" \"payload26\" \"tag 1\" \"payload08\" \"payload19\" \"payload210\" \"tag 2\" \"payload012\" \"payload113\" \"payload214\" \"tag 1\" \"payload016\" \"payload117\" \"payload218\" \"tag 4\"]",
    "payload012 payload113 payload214 {tag 1} payload08 payload19 payload210 {tag 2} payload00 payload11 payload22 {tag 3} payload016 payload117 payload218 {tag 4}",
    "", false, "stride-nested-632",
  )
  check_sort_case(
    "lsort -stride 4 -index \"3 end\" -integer -decreasing -unique -indices [list \"payload00\" \"payload11\" \"payload22\" \"tag 3\" \"payload04\" \"payload15\" \"payload26\" \"tag 1\" \"payload08\" \"payload19\" \"payload210\" \"tag 2\" \"payload012\" \"payload113\" \"payload214\" \"tag 1\" \"payload016\" \"payload117\" \"payload218\" \"tag 4\"]",
    "16 17 18 19 0 1 2 3 8 9 10 11 12 13 14 15", "", false, "stride-nested-633",
  )
  check_sort_case(
    "set code [catch \"lsort\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"lsort ?-option value ...? list\"} 0 {TCL WRONGARGS}",
    "", false, "selected-errors-634",
  )
  check_sort_case(
    "set code [catch \"lsort -bad {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {bad option \"-bad\": must be -ascii, -command, -decreasing, -dictionary, -increasing, -index, -indices, -integer, -nocase, -real, -stride, or -unique} 0 {TCL LOOKUP INDEX option -bad}",
    "", false, "selected-errors-635",
  )
  check_sort_case(
    "set code [catch \"lsort -i {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {ambiguous option \"-i\": must be -ascii, -command, -decreasing, -dictionary, -increasing, -index, -indices, -integer, -nocase, -real, -stride, or -unique} 0 {TCL LOOKUP INDEX option -i}",
    "", false, "selected-errors-636",
  )
  check_sort_case(
    "set code [catch \"lsort - {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {ambiguous option \"-\": must be -ascii, -command, -decreasing, -dictionary, -increasing, -index, -indices, -integer, -nocase, -real, -stride, or -unique} 0 {TCL LOOKUP INDEX option -}",
    "", false, "selected-errors-637",
  )
  check_sort_case(
    "set code [catch \"lsort -- {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {bad option \"--\": must be -ascii, -command, -decreasing, -dictionary, -increasing, -index, -indices, -integer, -nocase, -real, -stride, or -unique} 0 {TCL LOOKUP INDEX option --}",
    "", false, "selected-errors-638",
  )
  check_sort_case(
    "set code [catch \"lsort nope {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {bad option \"nope\": must be -ascii, -command, -decreasing, -dictionary, -increasing, -index, -indices, -integer, -nocase, -real, -stride, or -unique} 0 {TCL LOOKUP INDEX option nope}",
    "", false, "selected-errors-639",
  )
}

///|
test "Tcl sort cases 641 through 680" {
  check_sort_case(
    "set code [catch \"lsort -command {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {\"-command\" option must be followed by comparison command} 0 {TCL ARGUMENT MISSING}",
    "", false, "selected-errors-640",
  )
  check_sort_case(
    "set code [catch \"lsort -index {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {\"-index\" option must be followed by list index} 0 {TCL ARGUMENT MISSING}",
    "", false, "selected-errors-641",
  )
  check_sort_case(
    "set code [catch \"lsort -stride {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {\"-stride\" option must be followed by stride length} 0 {TCL ARGUMENT MISSING}",
    "", false, "selected-errors-642",
  )
  check_sort_case(
    "set code [catch \"lsort -stride 1 {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {stride length must be at least 2} 0 {TCL OPERATION LSORT BADSTRIDE}", "",
    false, "selected-errors-643",
  )
  check_sort_case(
    "set code [catch \"lsort -stride 0 {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {stride length must be at least 2} 0 {TCL OPERATION LSORT BADSTRIDE}", "",
    false, "selected-errors-644",
  )
  check_sort_case(
    "set code [catch \"lsort -stride -1 {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {stride length must be at least 2} 0 {TCL OPERATION LSORT BADSTRIDE}", "",
    false, "selected-errors-645",
  )
  check_sort_case(
    "set code [catch \"lsort -stride 2 {a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {list size must be a multiple of the stride length} 0 {TCL OPERATION LSORT BADSTRIDE}",
    "", false, "selected-errors-646",
  )
  check_sort_case(
    "set code [catch \"lsort -stride 2 -index 2 {a b}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {when used with \"-stride\", the leading \"-index\" value must be within the group} 0 {TCL OPERATION LSORT BADINDEX}",
    "", false, "selected-errors-647",
  )
  check_sort_case(
    "set code [catch \"lsort -stride 2 -index 2 {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "selected-errors-648",
  )
  check_sort_case(
    "set code [catch \"lsort -stride 2 -index end+1 {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {index \"end+1\" cannot select an element from any list} 0 {TCL VALUE INDEXOUTOFRANGE}",
    "", false, "selected-errors-649",
  )
  check_sort_case(
    "set code [catch \"lsort -stride 2 -index {1 0} {a x b {}}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {element 0 missing from sublist \"\"} 0 {TCL OPERATION LSORT INDEXFAILED}",
    "", false, "selected-errors-650",
  )
  check_sort_case(
    "set code [catch \"lsort -index 1 {x}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {element 1 missing from sublist \"x\"} 0 {TCL OPERATION LSORT INDEXFAILED}",
    "", false, "selected-errors-651",
  )
  check_sort_case(
    "set code [catch \"lsort -index bad {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {bad index \"bad\": must be integer?[+-]integer? or end?[+-]integer?} 0 {TCL VALUE INDEX}",
    "", false, "selected-errors-652",
  )
  check_sort_case(
    "set code [catch \"lsort -index bad -index 0 {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {bad index \"bad\": must be integer?[+-]integer? or end?[+-]integer?} 0 {TCL VALUE INDEX}",
    "", false, "selected-errors-653",
  )
  check_sort_case(
    "set code [catch \"lsort -index 1 -index {} {a b}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {a b} 0 {}", "", false, "selected-errors-654",
  )
  check_sort_case(
    "set code [catch \"lsort -command noSuch {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "selected-errors-655",
  )
  check_sort_case(
    "set code [catch \"lsort -command noSuch {x}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 x 0 {}", "", false, "selected-errors-656",
  )
  check_sort_case(
    "set code [catch \"lsort -command noSuch {x y}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {invalid command name \"noSuch\"} 0 {TCL LOOKUP COMMAND noSuch}", "", false,
    "selected-errors-657",
  )
  check_sort_case(
    "set code [catch \"lsort -command \\\"{\\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unmatched open brace in list} 0 {TCL VALUE LIST BRACE}", "", false, "selected-errors-658",
  )
  check_sort_case(
    "set code [catch \"lsort -command \\\"{\\\" \\\"{\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unmatched open brace in list} 0 {TCL VALUE LIST BRACE}", "", false, "selected-errors-659",
  )
  check_sort_case(
    "set code [catch \"lsort -command noSuch -integer {2 1}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {1 2} 0 {}", "", false, "selected-errors-660",
  )
  check_sort_case(
    "set code [catch \"lsort -integer -command noSuch {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "selected-errors-661",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"-1\\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {index \"-1\" cannot select an element from any list} 0 {TCL VALUE INDEXOUTOFRANGE}",
    "", false, "index-validation-662",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"-1\\\" {x}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {index \"-1\" cannot select an element from any list} 0 {TCL VALUE INDEXOUTOFRANGE}",
    "", false, "index-validation-663",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"-1\\\" {{a b}}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {index \"-1\" cannot select an element from any list} 0 {TCL VALUE INDEXOUTOFRANGE}",
    "", false, "index-validation-664",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"2147483647\\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {index \"2147483647\" cannot select an element from any list} 0 {TCL VALUE INDEXOUTOFRANGE}",
    "", false, "index-validation-665",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"2147483647\\\" {x}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {index \"2147483647\" cannot select an element from any list} 0 {TCL VALUE INDEXOUTOFRANGE}",
    "", false, "index-validation-666",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"2147483647\\\" {{a b}}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {index \"2147483647\" cannot select an element from any list} 0 {TCL VALUE INDEXOUTOFRANGE}",
    "", false, "index-validation-667",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"2147483646\\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "index-validation-668",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"2147483646\\\" {x}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {element 2147483646 missing from sublist \"x\"} 0 {TCL OPERATION LSORT INDEXFAILED}",
    "", false, "index-validation-669",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"2147483646\\\" {{a b}}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {element 2147483646 missing from sublist \"a b\"} 0 {TCL OPERATION LSORT INDEXFAILED}",
    "", false, "index-validation-670",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"-2147483648\\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {index \"-2147483648\" cannot select an element from any list} 0 {TCL VALUE INDEXOUTOFRANGE}",
    "", false, "index-validation-671",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"-2147483648\\\" {x}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {index \"-2147483648\" cannot select an element from any list} 0 {TCL VALUE INDEXOUTOFRANGE}",
    "", false, "index-validation-672",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"-2147483648\\\" {{a b}}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {index \"-2147483648\" cannot select an element from any list} 0 {TCL VALUE INDEXOUTOFRANGE}",
    "", false, "index-validation-673",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"end+1\\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {index \"end+1\" cannot select an element from any list} 0 {TCL VALUE INDEXOUTOFRANGE}",
    "", false, "index-validation-674",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"end+1\\\" {x}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {index \"end+1\" cannot select an element from any list} 0 {TCL VALUE INDEXOUTOFRANGE}",
    "", false, "index-validation-675",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"end+1\\\" {{a b}}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {index \"end+1\" cannot select an element from any list} 0 {TCL VALUE INDEXOUTOFRANGE}",
    "", false, "index-validation-676",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"end-2147483647\\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {index \"end-2147483647\" cannot select an element from any list} 0 {TCL VALUE INDEXOUTOFRANGE}",
    "", false, "index-validation-677",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"end-2147483647\\\" {x}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {index \"end-2147483647\" cannot select an element from any list} 0 {TCL VALUE INDEXOUTOFRANGE}",
    "", false, "index-validation-678",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"end-2147483647\\\" {{a b}}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {index \"end-2147483647\" cannot select an element from any list} 0 {TCL VALUE INDEXOUTOFRANGE}",
    "", false, "index-validation-679",
  )
}

///|
test "Tcl sort cases 681 through 720" {
  check_sort_case(
    "set code [catch \"lsort -index \\\"end-2147483648\\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {index \"end-2147483648\" cannot select an element from any list} 0 {TCL VALUE INDEXOUTOFRANGE}",
    "", false, "index-validation-680",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"end-2147483648\\\" {x}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {index \"end-2147483648\" cannot select an element from any list} 0 {TCL VALUE INDEXOUTOFRANGE}",
    "", false, "index-validation-681",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"end-2147483648\\\" {{a b}}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {index \"end-2147483648\" cannot select an element from any list} 0 {TCL VALUE INDEXOUTOFRANGE}",
    "", false, "index-validation-682",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"end+4294967295\\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "index-validation-683",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"end+4294967295\\\" {x}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {element -1 missing from sublist \"x\"} 0 {TCL OPERATION LSORT INDEXFAILED}",
    "", false, "index-validation-684",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"end+4294967295\\\" {{a b}}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {{a b}} 0 {}", "", false, "index-validation-685",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"end--1\\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {index \"end--1\" cannot select an element from any list} 0 {TCL VALUE INDEXOUTOFRANGE}",
    "", false, "index-validation-686",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"end--1\\\" {x}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {index \"end--1\" cannot select an element from any list} 0 {TCL VALUE INDEXOUTOFRANGE}",
    "", false, "index-validation-687",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"end--1\\\" {{a b}}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {index \"end--1\" cannot select an element from any list} 0 {TCL VALUE INDEXOUTOFRANGE}",
    "", false, "index-validation-688",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"0+1\\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "index-validation-689",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"0+1\\\" {x}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {element 1 missing from sublist \"x\"} 0 {TCL OPERATION LSORT INDEXFAILED}",
    "", false, "index-validation-690",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"0+1\\\" {{a b}}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {{a b}} 0 {}", "", false, "index-validation-691",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"1-1\\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "index-validation-692",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"1-1\\\" {x}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 x 0 {}", "", false, "index-validation-693",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"1-1\\\" {{a b}}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {{a b}} 0 {}", "", false, "index-validation-694",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"08\\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {bad index \"08\": must be integer?[+-]integer? or end?[+-]integer? (looks like invalid octal number)} 0 {TCL VALUE INDEX}",
    "", false, "index-validation-695",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"08\\\" {x}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {bad index \"08\": must be integer?[+-]integer? or end?[+-]integer? (looks like invalid octal number)} 0 {TCL VALUE INDEX}",
    "", false, "index-validation-696",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"08\\\" {{a b}}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {bad index \"08\": must be integer?[+-]integer? or end?[+-]integer? (looks like invalid octal number)} 0 {TCL VALUE INDEX}",
    "", false, "index-validation-697",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"bad\\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {bad index \"bad\": must be integer?[+-]integer? or end?[+-]integer?} 0 {TCL VALUE INDEX}",
    "", false, "index-validation-698",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"bad\\\" {x}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {bad index \"bad\": must be integer?[+-]integer? or end?[+-]integer?} 0 {TCL VALUE INDEX}",
    "", false, "index-validation-699",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"bad\\\" {{a b}}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {bad index \"bad\": must be integer?[+-]integer? or end?[+-]integer?} 0 {TCL VALUE INDEX}",
    "", false, "index-validation-700",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\" 1 \\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "index-validation-701",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\" 1 \\\" {x}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {element 1 missing from sublist \"x\"} 0 {TCL OPERATION LSORT INDEXFAILED}",
    "", false, "index-validation-702",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\" 1 \\\" {{a b}}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {{a b}} 0 {}", "", false, "index-validation-703",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"end \\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "index-validation-704",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"end \\\" {x}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 x 0 {}", "", false, "index-validation-705",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"end \\\" {{a b}}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {{a b}} 0 {}", "", false, "index-validation-706",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"1+ 1\\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {bad index \"1+\": must be integer?[+-]integer? or end?[+-]integer?} 0 {TCL VALUE INDEX}",
    "", false, "index-validation-707",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"1+ 1\\\" {x}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {bad index \"1+\": must be integer?[+-]integer? or end?[+-]integer?} 0 {TCL VALUE INDEX}",
    "", false, "index-validation-708",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"1+ 1\\\" {{a b}}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {bad index \"1+\": must be integer?[+-]integer? or end?[+-]integer?} 0 {TCL VALUE INDEX}",
    "", false, "index-validation-709",
  )
  check_sort_case(
    "set code [catch \"lsort -stride \\\"2147483647\\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "stride-validation-710",
  )
  check_sort_case(
    "set code [catch \"lsort -stride \\\"2147483648\\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {stride length must be at least 2} 0 {TCL OPERATION LSORT BADSTRIDE}", "",
    false, "stride-validation-711",
  )
  check_sort_case(
    "set code [catch \"lsort -stride \\\"4294967295\\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {stride length must be at least 2} 0 {TCL OPERATION LSORT BADSTRIDE}", "",
    false, "stride-validation-712",
  )
  check_sort_case(
    "set code [catch \"lsort -stride \\\"4294967296\\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {integer value too large to represent} 0 {ARITH IOVERFLOW {integer value too large to represent}}",
    "", false, "stride-validation-713",
  )
  check_sort_case(
    "set code [catch \"lsort -stride \\\"-4294967295\\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {stride length must be at least 2} 0 {TCL OPERATION LSORT BADSTRIDE}", "",
    false, "stride-validation-714",
  )
  check_sort_case(
    "set code [catch \"lsort -stride \\\"-4294967296\\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {integer value too large to represent} 0 {ARITH IOVERFLOW {integer value too large to represent}}",
    "", false, "stride-validation-715",
  )
  check_sort_case(
    "set code [catch \"lsort -stride \\\"2.0\\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected integer but got \"2.0\"} 0 {TCL VALUE NUMBER}", "", false, "stride-validation-716",
  )
  check_sort_case(
    "set code [catch \"lsort -stride \\\"08\\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected integer but got \"08\"} 0 {TCL VALUE NUMBER}", "", false, "stride-validation-717",
  )
  check_sort_case(
    "set code [catch \"lsort -stride \\\"NaN\\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected integer but got \"NaN\"} 0 {TCL VALUE NUMBER}", "", false, "stride-validation-718",
  )
  check_sort_case(
    "set code [catch \"lsort -stride \\\"bad\\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {expected integer but got \"bad\"} 0 {TCL VALUE NUMBER}", "", false, "stride-validation-719",
  )
}

///|
test "Tcl sort cases 721 through 760" {
  check_sort_case(
    "set code [catch \"lsort -stride \\\"0x2\\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "stride-validation-720",
  )
  check_sort_case(
    "set code [catch \"lsort -stride \\\" 2 \\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "stride-validation-721",
  )
  check_sort_case(
    "set code [catch \"lsort -as {2 1 4 3}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {1 2 3 4} 0 {}", "", false, "abbreviations-722",
  )
  check_sort_case(
    "set code [catch \"lsort -com {string compare} {2 1 4 3}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {1 2 3 4} 0 {}", "", false, "abbreviations-723",
  )
  check_sort_case(
    "set code [catch \"lsort -dec {2 1 4 3}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {4 3 2 1} 0 {}", "", false, "abbreviations-724",
  )
  check_sort_case(
    "set code [catch \"lsort -di {2 1 4 3}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {1 2 3 4} 0 {}", "", false, "abbreviations-725",
  )
  check_sort_case(
    "set code [catch \"lsort -inc {2 1 4 3}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {1 2 3 4} 0 {}", "", false, "abbreviations-726",
  )
  check_sort_case(
    "set code [catch \"lsort -ind {2 1 4 3}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {ambiguous option \"-ind\": must be -ascii, -command, -decreasing, -dictionary, -increasing, -index, -indices, -integer, -nocase, -real, -stride, or -unique} 0 {TCL LOOKUP INDEX option -ind}",
    "", false, "abbreviations-727",
  )
  check_sort_case(
    "set code [catch \"lsort -inde 0 {2 1 4 3}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {1 2 3 4} 0 {}", "", false, "abbreviations-728",
  )
  check_sort_case(
    "set code [catch \"lsort -indic {2 1 4 3}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {1 0 3 2} 0 {}", "", false, "abbreviations-729",
  )
  check_sort_case(
    "set code [catch \"lsort -int {2 1 4 3}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {1 2 3 4} 0 {}", "", false, "abbreviations-730",
  )
  check_sort_case(
    "set code [catch \"lsort -noc {2 1 4 3}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {1 2 3 4} 0 {}", "", false, "abbreviations-731",
  )
  check_sort_case(
    "set code [catch \"lsort -rea {2 1 4 3}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {1 2 3 4} 0 {}", "", false, "abbreviations-732",
  )
  check_sort_case(
    "set code [catch \"lsort -str 2 {2 1 4 3}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {2 1 4 3} 0 {}", "", false, "abbreviations-733",
  )
  check_sort_case(
    "set code [catch \"lsort -un {2 1 4 3}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {1 2 3 4} 0 {}", "", false, "abbreviations-734",
  )
  check_sort_case(
    "lsort -ascii -ascii -nocase {10 2 01 1}", "01 1 10 2", "", false, "mode-order-735",
  )
  check_sort_case(
    "lsort -ascii -dictionary -nocase {10 2 01 1}", "1 01 2 10", "", false, "mode-order-736",
  )
  check_sort_case(
    "lsort -ascii -integer -nocase {10 2 01 1}", "01 1 2 10", "", false, "mode-order-737",
  )
  check_sort_case(
    "lsort -ascii -real -nocase {10 2 01 1}", "01 1 2 10", "", false, "mode-order-738",
  )
  check_sort_case(
    "lsort -ascii -command {string compare} -nocase {10 2 01 1}", "01 1 10 2", "",
    false, "mode-order-739",
  )
  check_sort_case(
    "lsort -dictionary -ascii -nocase {10 2 01 1}", "01 1 10 2", "", false, "mode-order-740",
  )
  check_sort_case(
    "lsort -dictionary -dictionary -nocase {10 2 01 1}", "1 01 2 10", "", false,
    "mode-order-741",
  )
  check_sort_case(
    "lsort -dictionary -integer -nocase {10 2 01 1}", "01 1 2 10", "", false, "mode-order-742",
  )
  check_sort_case(
    "lsort -dictionary -real -nocase {10 2 01 1}", "01 1 2 10", "", false, "mode-order-743",
  )
  check_sort_case(
    "lsort -dictionary -command {string compare} -nocase {10 2 01 1}", "01 1 10 2",
    "", false, "mode-order-744",
  )
  check_sort_case(
    "lsort -integer -ascii -nocase {10 2 01 1}", "01 1 10 2", "", false, "mode-order-745",
  )
  check_sort_case(
    "lsort -integer -dictionary -nocase {10 2 01 1}", "1 01 2 10", "", false, "mode-order-746",
  )
  check_sort_case(
    "lsort -integer -integer -nocase {10 2 01 1}", "01 1 2 10", "", false, "mode-order-747",
  )
  check_sort_case(
    "lsort -integer -real -nocase {10 2 01 1}", "01 1 2 10", "", false, "mode-order-748",
  )
  check_sort_case(
    "lsort -integer -command {string compare} -nocase {10 2 01 1}", "01 1 10 2",
    "", false, "mode-order-749",
  )
  check_sort_case(
    "lsort -real -ascii -nocase {10 2 01 1}", "01 1 10 2", "", false, "mode-order-750",
  )
  check_sort_case(
    "lsort -real -dictionary -nocase {10 2 01 1}", "1 01 2 10", "", false, "mode-order-751",
  )
  check_sort_case(
    "lsort -real -integer -nocase {10 2 01 1}", "01 1 2 10", "", false, "mode-order-752",
  )
  check_sort_case(
    "lsort -real -real -nocase {10 2 01 1}", "01 1 2 10", "", false, "mode-order-753",
  )
  check_sort_case(
    "lsort -real -command {string compare} -nocase {10 2 01 1}", "01 1 10 2", "",
    false, "mode-order-754",
  )
  check_sort_case(
    "lsort -command {string compare} -ascii -nocase {10 2 01 1}", "01 1 10 2", "",
    false, "mode-order-755",
  )
  check_sort_case(
    "lsort -command {string compare} -dictionary -nocase {10 2 01 1}", "1 01 2 10",
    "", false, "mode-order-756",
  )
  check_sort_case(
    "lsort -command {string compare} -integer -nocase {10 2 01 1}", "01 1 2 10",
    "", false, "mode-order-757",
  )
  check_sort_case(
    "lsort -command {string compare} -real -nocase {10 2 01 1}", "01 1 2 10", "",
    false, "mode-order-758",
  )
  check_sort_case(
    "lsort -command {string compare} -command {string compare} -nocase {10 2 01 1}",
    "01 1 10 2", "", false, "mode-order-759",
  )
}

///|
test "Tcl sort cases 761 through 800" {
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"e\" \"d\" \"c\" \"b\" \"a\"]];list $result $calls",
    "{a b c d e} {{e d} {c b} {d b} {d c} {b a}}", "", false, "comparison-order-760",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"e\" \"d\" \"c\" \"b\" \"a\"]];list $result $calls",
    "{e d c b a} {{e d} {c b} {e c} {d c} {e a} {d a} {c a} {b a}}", "", false, "comparison-order-761",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"e\" \"d\" \"c\" \"b\" \"a\"]];list $result $calls",
    "{a b c d e} {{e d} {c b} {d b} {d c} {b a}}", "", false, "comparison-order-762",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"e\" \"d\" \"c\" \"b\" \"a\"]];list $result $calls",
    "{e d c b a} {{e d} {c b} {e c} {d c} {e a} {d a} {c a} {b a}}", "", false, "comparison-order-763",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"e\" \"d\" \"c\" \"a\" \"b\"]];list $result $calls",
    "{a b c d e} {{e d} {c a} {d a} {d c} {a b} {c b}}", "", false, "comparison-order-764",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"e\" \"d\" \"c\" \"a\" \"b\"]];list $result $calls",
    "{e d c b a} {{e d} {c a} {e c} {d c} {e b} {d b} {c b} {a b}}", "", false, "comparison-order-765",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"e\" \"d\" \"c\" \"a\" \"b\"]];list $result $calls",
    "{a b c d e} {{e d} {c a} {d a} {d c} {a b} {c b}}", "", false, "comparison-order-766",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"e\" \"d\" \"c\" \"a\" \"b\"]];list $result $calls",
    "{e d c b a} {{e d} {c a} {e c} {d c} {e b} {d b} {c b} {a b}}", "", false, "comparison-order-767",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"e\" \"d\" \"b\" \"c\" \"a\"]];list $result $calls",
    "{a b c d e} {{e d} {b c} {d b} {d c} {b a}}", "", false, "comparison-order-768",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"e\" \"d\" \"b\" \"c\" \"a\"]];list $result $calls",
    "{e d c b a} {{e d} {b c} {e c} {d c} {e a} {d a} {c a} {b a}}", "", false, "comparison-order-769",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"e\" \"d\" \"b\" \"c\" \"a\"]];list $result $calls",
    "{a b c d e} {{e d} {b c} {d b} {d c} {b a}}", "", false, "comparison-order-770",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"e\" \"d\" \"b\" \"c\" \"a\"]];list $result $calls",
    "{e d c b a} {{e d} {b c} {e c} {d c} {e a} {d a} {c a} {b a}}", "", false, "comparison-order-771",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"e\" \"d\" \"b\" \"a\" \"c\"]];list $result $calls",
    "{a b c d e} {{e d} {b a} {d a} {d b} {a c} {b c} {d c}}", "", false, "comparison-order-772",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"e\" \"d\" \"b\" \"a\" \"c\"]];list $result $calls",
    "{e d c b a} {{e d} {b a} {e b} {d b} {e c} {d c} {b c}}", "", false, "comparison-order-773",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"e\" \"d\" \"b\" \"a\" \"c\"]];list $result $calls",
    "{a b c d e} {{e d} {b a} {d a} {d b} {a c} {b c} {d c}}", "", false, "comparison-order-774",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"e\" \"d\" \"b\" \"a\" \"c\"]];list $result $calls",
    "{e d c b a} {{e d} {b a} {e b} {d b} {e c} {d c} {b c}}", "", false, "comparison-order-775",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"e\" \"d\" \"a\" \"c\" \"b\"]];list $result $calls",
    "{a b c d e} {{e d} {a c} {d a} {d c} {a b} {c b}}", "", false, "comparison-order-776",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"e\" \"d\" \"a\" \"c\" \"b\"]];list $result $calls",
    "{e d c b a} {{e d} {a c} {e c} {d c} {e b} {d b} {c b} {a b}}", "", false, "comparison-order-777",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"e\" \"d\" \"a\" \"c\" \"b\"]];list $result $calls",
    "{a b c d e} {{e d} {a c} {d a} {d c} {a b} {c b}}", "", false, "comparison-order-778",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"e\" \"d\" \"a\" \"c\" \"b\"]];list $result $calls",
    "{e d c b a} {{e d} {a c} {e c} {d c} {e b} {d b} {c b} {a b}}", "", false, "comparison-order-779",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"e\" \"d\" \"a\" \"b\" \"c\"]];list $result $calls",
    "{a b c d e} {{e d} {a b} {d a} {d b} {a c} {b c} {d c}}", "", false, "comparison-order-780",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"e\" \"d\" \"a\" \"b\" \"c\"]];list $result $calls",
    "{e d c b a} {{e d} {a b} {e b} {d b} {e c} {d c} {b c}}", "", false, "comparison-order-781",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"e\" \"d\" \"a\" \"b\" \"c\"]];list $result $calls",
    "{a b c d e} {{e d} {a b} {d a} {d b} {a c} {b c} {d c}}", "", false, "comparison-order-782",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"e\" \"d\" \"a\" \"b\" \"c\"]];list $result $calls",
    "{e d c b a} {{e d} {a b} {e b} {d b} {e c} {d c} {b c}}", "", false, "comparison-order-783",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"e\" \"c\" \"d\" \"b\" \"a\"]];list $result $calls",
    "{a b c d e} {{e c} {d b} {c b} {c d} {e d} {b a}}", "", false, "comparison-order-784",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"e\" \"c\" \"d\" \"b\" \"a\"]];list $result $calls",
    "{e d c b a} {{e c} {d b} {e d} {c d} {c b} {e a} {d a} {c a} {b a}}", "", false,
    "comparison-order-785",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"e\" \"c\" \"d\" \"b\" \"a\"]];list $result $calls",
    "{a b c d e} {{e c} {d b} {c b} {c d} {e d} {b a}}", "", false, "comparison-order-786",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"e\" \"c\" \"d\" \"b\" \"a\"]];list $result $calls",
    "{e d c b a} {{e c} {d b} {e d} {c d} {c b} {e a} {d a} {c a} {b a}}", "", false,
    "comparison-order-787",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"e\" \"c\" \"d\" \"a\" \"b\"]];list $result $calls",
    "{a b c d e} {{e c} {d a} {c a} {c d} {e d} {a b} {c b}}", "", false, "comparison-order-788",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"e\" \"c\" \"d\" \"a\" \"b\"]];list $result $calls",
    "{e d c b a} {{e c} {d a} {e d} {c d} {c a} {e b} {d b} {c b} {a b}}", "", false,
    "comparison-order-789",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"e\" \"c\" \"d\" \"a\" \"b\"]];list $result $calls",
    "{a b c d e} {{e c} {d a} {c a} {c d} {e d} {a b} {c b}}", "", false, "comparison-order-790",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"e\" \"c\" \"d\" \"a\" \"b\"]];list $result $calls",
    "{e d c b a} {{e c} {d a} {e d} {c d} {c a} {e b} {d b} {c b} {a b}}", "", false,
    "comparison-order-791",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"e\" \"c\" \"b\" \"d\" \"a\"]];list $result $calls",
    "{a b c d e} {{e c} {b d} {c b} {c d} {e d} {b a}}", "", false, "comparison-order-792",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"e\" \"c\" \"b\" \"d\" \"a\"]];list $result $calls",
    "{e d c b a} {{e c} {b d} {e d} {c d} {c b} {e a} {d a} {c a} {b a}}", "", false,
    "comparison-order-793",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"e\" \"c\" \"b\" \"d\" \"a\"]];list $result $calls",
    "{a b c d e} {{e c} {b d} {c b} {c d} {e d} {b a}}", "", false, "comparison-order-794",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"e\" \"c\" \"b\" \"d\" \"a\"]];list $result $calls",
    "{e d c b a} {{e c} {b d} {e d} {c d} {c b} {e a} {d a} {c a} {b a}}", "", false,
    "comparison-order-795",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"e\" \"c\" \"b\" \"a\" \"d\"]];list $result $calls",
    "{a b c d e} {{e c} {b a} {c a} {c b} {a d} {b d} {c d} {e d}}", "", false, "comparison-order-796",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"e\" \"c\" \"b\" \"a\" \"d\"]];list $result $calls",
    "{e d c b a} {{e c} {b a} {e b} {c b} {e d} {c d}}", "", false, "comparison-order-797",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"e\" \"c\" \"b\" \"a\" \"d\"]];list $result $calls",
    "{a b c d e} {{e c} {b a} {c a} {c b} {a d} {b d} {c d} {e d}}", "", false, "comparison-order-798",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"e\" \"c\" \"b\" \"a\" \"d\"]];list $result $calls",
    "{e d c b a} {{e c} {b a} {e b} {c b} {e d} {c d}}", "", false, "comparison-order-799",
  )
}

///|
test "Tcl sort cases 801 through 840" {
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"e\" \"c\" \"a\" \"d\" \"b\"]];list $result $calls",
    "{a b c d e} {{e c} {a d} {c a} {c d} {e d} {a b} {c b}}", "", false, "comparison-order-800",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"e\" \"c\" \"a\" \"d\" \"b\"]];list $result $calls",
    "{e d c b a} {{e c} {a d} {e d} {c d} {c a} {e b} {d b} {c b} {a b}}", "", false,
    "comparison-order-801",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"e\" \"c\" \"a\" \"d\" \"b\"]];list $result $calls",
    "{a b c d e} {{e c} {a d} {c a} {c d} {e d} {a b} {c b}}", "", false, "comparison-order-802",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"e\" \"c\" \"a\" \"d\" \"b\"]];list $result $calls",
    "{e d c b a} {{e c} {a d} {e d} {c d} {c a} {e b} {d b} {c b} {a b}}", "", false,
    "comparison-order-803",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"e\" \"c\" \"a\" \"b\" \"d\"]];list $result $calls",
    "{a b c d e} {{e c} {a b} {c a} {c b} {a d} {b d} {c d} {e d}}", "", false, "comparison-order-804",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"e\" \"c\" \"a\" \"b\" \"d\"]];list $result $calls",
    "{e d c b a} {{e c} {a b} {e b} {c b} {e d} {c d}}", "", false, "comparison-order-805",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"e\" \"c\" \"a\" \"b\" \"d\"]];list $result $calls",
    "{a b c d e} {{e c} {a b} {c a} {c b} {a d} {b d} {c d} {e d}}", "", false, "comparison-order-806",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"e\" \"c\" \"a\" \"b\" \"d\"]];list $result $calls",
    "{e d c b a} {{e c} {a b} {e b} {c b} {e d} {c d}}", "", false, "comparison-order-807",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"e\" \"b\" \"d\" \"c\" \"a\"]];list $result $calls",
    "{a b c d e} {{e b} {d c} {b c} {e c} {e d} {b a}}", "", false, "comparison-order-808",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"e\" \"b\" \"d\" \"c\" \"a\"]];list $result $calls",
    "{e d c b a} {{e b} {d c} {e d} {b d} {b c} {e a} {d a} {c a} {b a}}", "", false,
    "comparison-order-809",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"e\" \"b\" \"d\" \"c\" \"a\"]];list $result $calls",
    "{a b c d e} {{e b} {d c} {b c} {e c} {e d} {b a}}", "", false, "comparison-order-810",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"e\" \"b\" \"d\" \"c\" \"a\"]];list $result $calls",
    "{e d c b a} {{e b} {d c} {e d} {b d} {b c} {e a} {d a} {c a} {b a}}", "", false,
    "comparison-order-811",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"e\" \"b\" \"d\" \"a\" \"c\"]];list $result $calls",
    "{a b c d e} {{e b} {d a} {b a} {b d} {e d} {a c} {b c} {d c}}", "", false, "comparison-order-812",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"e\" \"b\" \"d\" \"a\" \"c\"]];list $result $calls",
    "{e d c b a} {{e b} {d a} {e d} {b d} {b a} {e c} {d c} {b c}}", "", false, "comparison-order-813",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"e\" \"b\" \"d\" \"a\" \"c\"]];list $result $calls",
    "{a b c d e} {{e b} {d a} {b a} {b d} {e d} {a c} {b c} {d c}}", "", false, "comparison-order-814",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"e\" \"b\" \"d\" \"a\" \"c\"]];list $result $calls",
    "{e d c b a} {{e b} {d a} {e d} {b d} {b a} {e c} {d c} {b c}}", "", false, "comparison-order-815",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"e\" \"b\" \"c\" \"d\" \"a\"]];list $result $calls",
    "{a b c d e} {{e b} {c d} {b c} {e c} {e d} {b a}}", "", false, "comparison-order-816",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"e\" \"b\" \"c\" \"d\" \"a\"]];list $result $calls",
    "{e d c b a} {{e b} {c d} {e d} {b d} {b c} {e a} {d a} {c a} {b a}}", "", false,
    "comparison-order-817",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"e\" \"b\" \"c\" \"d\" \"a\"]];list $result $calls",
    "{a b c d e} {{e b} {c d} {b c} {e c} {e d} {b a}}", "", false, "comparison-order-818",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"e\" \"b\" \"c\" \"d\" \"a\"]];list $result $calls",
    "{e d c b a} {{e b} {c d} {e d} {b d} {b c} {e a} {d a} {c a} {b a}}", "", false,
    "comparison-order-819",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"e\" \"b\" \"c\" \"a\" \"d\"]];list $result $calls",
    "{a b c d e} {{e b} {c a} {b a} {b c} {e c} {a d} {b d} {c d} {e d}}", "", false,
    "comparison-order-820",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"e\" \"b\" \"c\" \"a\" \"d\"]];list $result $calls",
    "{e d c b a} {{e b} {c a} {e c} {b c} {b a} {e d} {c d}}", "", false, "comparison-order-821",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"e\" \"b\" \"c\" \"a\" \"d\"]];list $result $calls",
    "{a b c d e} {{e b} {c a} {b a} {b c} {e c} {a d} {b d} {c d} {e d}}", "", false,
    "comparison-order-822",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"e\" \"b\" \"c\" \"a\" \"d\"]];list $result $calls",
    "{e d c b a} {{e b} {c a} {e c} {b c} {b a} {e d} {c d}}", "", false, "comparison-order-823",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"e\" \"b\" \"a\" \"d\" \"c\"]];list $result $calls",
    "{a b c d e} {{e b} {a d} {b a} {b d} {e d} {a c} {b c} {d c}}", "", false, "comparison-order-824",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"e\" \"b\" \"a\" \"d\" \"c\"]];list $result $calls",
    "{e d c b a} {{e b} {a d} {e d} {b d} {b a} {e c} {d c} {b c}}", "", false, "comparison-order-825",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"e\" \"b\" \"a\" \"d\" \"c\"]];list $result $calls",
    "{a b c d e} {{e b} {a d} {b a} {b d} {e d} {a c} {b c} {d c}}", "", false, "comparison-order-826",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"e\" \"b\" \"a\" \"d\" \"c\"]];list $result $calls",
    "{e d c b a} {{e b} {a d} {e d} {b d} {b a} {e c} {d c} {b c}}", "", false, "comparison-order-827",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"e\" \"b\" \"a\" \"c\" \"d\"]];list $result $calls",
    "{a b c d e} {{e b} {a c} {b a} {b c} {e c} {a d} {b d} {c d} {e d}}", "", false,
    "comparison-order-828",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"e\" \"b\" \"a\" \"c\" \"d\"]];list $result $calls",
    "{e d c b a} {{e b} {a c} {e c} {b c} {b a} {e d} {c d}}", "", false, "comparison-order-829",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"e\" \"b\" \"a\" \"c\" \"d\"]];list $result $calls",
    "{a b c d e} {{e b} {a c} {b a} {b c} {e c} {a d} {b d} {c d} {e d}}", "", false,
    "comparison-order-830",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"e\" \"b\" \"a\" \"c\" \"d\"]];list $result $calls",
    "{e d c b a} {{e b} {a c} {e c} {b c} {b a} {e d} {c d}}", "", false, "comparison-order-831",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"e\" \"a\" \"d\" \"c\" \"b\"]];list $result $calls",
    "{a b c d e} {{e a} {d c} {a c} {e c} {e d} {a b} {c b}}", "", false, "comparison-order-832",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"e\" \"a\" \"d\" \"c\" \"b\"]];list $result $calls",
    "{e d c b a} {{e a} {d c} {e d} {a d} {a c} {e b} {d b} {c b} {a b}}", "", false,
    "comparison-order-833",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"e\" \"a\" \"d\" \"c\" \"b\"]];list $result $calls",
    "{a b c d e} {{e a} {d c} {a c} {e c} {e d} {a b} {c b}}", "", false, "comparison-order-834",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"e\" \"a\" \"d\" \"c\" \"b\"]];list $result $calls",
    "{e d c b a} {{e a} {d c} {e d} {a d} {a c} {e b} {d b} {c b} {a b}}", "", false,
    "comparison-order-835",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"e\" \"a\" \"d\" \"b\" \"c\"]];list $result $calls",
    "{a b c d e} {{e a} {d b} {a b} {e b} {e d} {a c} {b c} {d c}}", "", false, "comparison-order-836",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"e\" \"a\" \"d\" \"b\" \"c\"]];list $result $calls",
    "{e d c b a} {{e a} {d b} {e d} {a d} {a b} {e c} {d c} {b c}}", "", false, "comparison-order-837",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"e\" \"a\" \"d\" \"b\" \"c\"]];list $result $calls",
    "{a b c d e} {{e a} {d b} {a b} {e b} {e d} {a c} {b c} {d c}}", "", false, "comparison-order-838",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"e\" \"a\" \"d\" \"b\" \"c\"]];list $result $calls",
    "{e d c b a} {{e a} {d b} {e d} {a d} {a b} {e c} {d c} {b c}}", "", false, "comparison-order-839",
  )
}

///|
test "Tcl sort cases 841 through 880" {
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"e\" \"a\" \"c\" \"d\" \"b\"]];list $result $calls",
    "{a b c d e} {{e a} {c d} {a c} {e c} {e d} {a b} {c b}}", "", false, "comparison-order-840",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"e\" \"a\" \"c\" \"d\" \"b\"]];list $result $calls",
    "{e d c b a} {{e a} {c d} {e d} {a d} {a c} {e b} {d b} {c b} {a b}}", "", false,
    "comparison-order-841",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"e\" \"a\" \"c\" \"d\" \"b\"]];list $result $calls",
    "{a b c d e} {{e a} {c d} {a c} {e c} {e d} {a b} {c b}}", "", false, "comparison-order-842",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"e\" \"a\" \"c\" \"d\" \"b\"]];list $result $calls",
    "{e d c b a} {{e a} {c d} {e d} {a d} {a c} {e b} {d b} {c b} {a b}}", "", false,
    "comparison-order-843",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"e\" \"a\" \"c\" \"b\" \"d\"]];list $result $calls",
    "{a b c d e} {{e a} {c b} {a b} {e b} {e c} {a d} {b d} {c d} {e d}}", "", false,
    "comparison-order-844",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"e\" \"a\" \"c\" \"b\" \"d\"]];list $result $calls",
    "{e d c b a} {{e a} {c b} {e c} {a c} {a b} {e d} {c d}}", "", false, "comparison-order-845",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"e\" \"a\" \"c\" \"b\" \"d\"]];list $result $calls",
    "{a b c d e} {{e a} {c b} {a b} {e b} {e c} {a d} {b d} {c d} {e d}}", "", false,
    "comparison-order-846",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"e\" \"a\" \"c\" \"b\" \"d\"]];list $result $calls",
    "{e d c b a} {{e a} {c b} {e c} {a c} {a b} {e d} {c d}}", "", false, "comparison-order-847",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"e\" \"a\" \"b\" \"d\" \"c\"]];list $result $calls",
    "{a b c d e} {{e a} {b d} {a b} {e b} {e d} {a c} {b c} {d c}}", "", false, "comparison-order-848",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"e\" \"a\" \"b\" \"d\" \"c\"]];list $result $calls",
    "{e d c b a} {{e a} {b d} {e d} {a d} {a b} {e c} {d c} {b c}}", "", false, "comparison-order-849",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"e\" \"a\" \"b\" \"d\" \"c\"]];list $result $calls",
    "{a b c d e} {{e a} {b d} {a b} {e b} {e d} {a c} {b c} {d c}}", "", false, "comparison-order-850",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"e\" \"a\" \"b\" \"d\" \"c\"]];list $result $calls",
    "{e d c b a} {{e a} {b d} {e d} {a d} {a b} {e c} {d c} {b c}}", "", false, "comparison-order-851",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"e\" \"a\" \"b\" \"c\" \"d\"]];list $result $calls",
    "{a b c d e} {{e a} {b c} {a b} {e b} {e c} {a d} {b d} {c d} {e d}}", "", false,
    "comparison-order-852",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"e\" \"a\" \"b\" \"c\" \"d\"]];list $result $calls",
    "{e d c b a} {{e a} {b c} {e c} {a c} {a b} {e d} {c d}}", "", false, "comparison-order-853",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"e\" \"a\" \"b\" \"c\" \"d\"]];list $result $calls",
    "{a b c d e} {{e a} {b c} {a b} {e b} {e c} {a d} {b d} {c d} {e d}}", "", false,
    "comparison-order-854",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"e\" \"a\" \"b\" \"c\" \"d\"]];list $result $calls",
    "{e d c b a} {{e a} {b c} {e c} {a c} {a b} {e d} {c d}}", "", false, "comparison-order-855",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"d\" \"e\" \"c\" \"b\" \"a\"]];list $result $calls",
    "{a b c d e} {{d e} {c b} {d b} {d c} {b a}}", "", false, "comparison-order-856",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"d\" \"e\" \"c\" \"b\" \"a\"]];list $result $calls",
    "{e d c b a} {{d e} {c b} {e c} {d c} {e a} {d a} {c a} {b a}}", "", false, "comparison-order-857",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"d\" \"e\" \"c\" \"b\" \"a\"]];list $result $calls",
    "{a b c d e} {{d e} {c b} {d b} {d c} {b a}}", "", false, "comparison-order-858",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"d\" \"e\" \"c\" \"b\" \"a\"]];list $result $calls",
    "{e d c b a} {{d e} {c b} {e c} {d c} {e a} {d a} {c a} {b a}}", "", false, "comparison-order-859",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"d\" \"e\" \"c\" \"a\" \"b\"]];list $result $calls",
    "{a b c d e} {{d e} {c a} {d a} {d c} {a b} {c b}}", "", false, "comparison-order-860",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"d\" \"e\" \"c\" \"a\" \"b\"]];list $result $calls",
    "{e d c b a} {{d e} {c a} {e c} {d c} {e b} {d b} {c b} {a b}}", "", false, "comparison-order-861",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"d\" \"e\" \"c\" \"a\" \"b\"]];list $result $calls",
    "{a b c d e} {{d e} {c a} {d a} {d c} {a b} {c b}}", "", false, "comparison-order-862",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"d\" \"e\" \"c\" \"a\" \"b\"]];list $result $calls",
    "{e d c b a} {{d e} {c a} {e c} {d c} {e b} {d b} {c b} {a b}}", "", false, "comparison-order-863",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"d\" \"e\" \"b\" \"c\" \"a\"]];list $result $calls",
    "{a b c d e} {{d e} {b c} {d b} {d c} {b a}}", "", false, "comparison-order-864",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"d\" \"e\" \"b\" \"c\" \"a\"]];list $result $calls",
    "{e d c b a} {{d e} {b c} {e c} {d c} {e a} {d a} {c a} {b a}}", "", false, "comparison-order-865",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"d\" \"e\" \"b\" \"c\" \"a\"]];list $result $calls",
    "{a b c d e} {{d e} {b c} {d b} {d c} {b a}}", "", false, "comparison-order-866",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"d\" \"e\" \"b\" \"c\" \"a\"]];list $result $calls",
    "{e d c b a} {{d e} {b c} {e c} {d c} {e a} {d a} {c a} {b a}}", "", false, "comparison-order-867",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"d\" \"e\" \"b\" \"a\" \"c\"]];list $result $calls",
    "{a b c d e} {{d e} {b a} {d a} {d b} {a c} {b c} {d c}}", "", false, "comparison-order-868",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"d\" \"e\" \"b\" \"a\" \"c\"]];list $result $calls",
    "{e d c b a} {{d e} {b a} {e b} {d b} {e c} {d c} {b c}}", "", false, "comparison-order-869",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"d\" \"e\" \"b\" \"a\" \"c\"]];list $result $calls",
    "{a b c d e} {{d e} {b a} {d a} {d b} {a c} {b c} {d c}}", "", false, "comparison-order-870",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"d\" \"e\" \"b\" \"a\" \"c\"]];list $result $calls",
    "{e d c b a} {{d e} {b a} {e b} {d b} {e c} {d c} {b c}}", "", false, "comparison-order-871",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"d\" \"e\" \"a\" \"c\" \"b\"]];list $result $calls",
    "{a b c d e} {{d e} {a c} {d a} {d c} {a b} {c b}}", "", false, "comparison-order-872",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"d\" \"e\" \"a\" \"c\" \"b\"]];list $result $calls",
    "{e d c b a} {{d e} {a c} {e c} {d c} {e b} {d b} {c b} {a b}}", "", false, "comparison-order-873",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"d\" \"e\" \"a\" \"c\" \"b\"]];list $result $calls",
    "{a b c d e} {{d e} {a c} {d a} {d c} {a b} {c b}}", "", false, "comparison-order-874",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"d\" \"e\" \"a\" \"c\" \"b\"]];list $result $calls",
    "{e d c b a} {{d e} {a c} {e c} {d c} {e b} {d b} {c b} {a b}}", "", false, "comparison-order-875",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"d\" \"e\" \"a\" \"b\" \"c\"]];list $result $calls",
    "{a b c d e} {{d e} {a b} {d a} {d b} {a c} {b c} {d c}}", "", false, "comparison-order-876",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"d\" \"e\" \"a\" \"b\" \"c\"]];list $result $calls",
    "{e d c b a} {{d e} {a b} {e b} {d b} {e c} {d c} {b c}}", "", false, "comparison-order-877",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"d\" \"e\" \"a\" \"b\" \"c\"]];list $result $calls",
    "{a b c d e} {{d e} {a b} {d a} {d b} {a c} {b c} {d c}}", "", false, "comparison-order-878",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"d\" \"e\" \"a\" \"b\" \"c\"]];list $result $calls",
    "{e d c b a} {{d e} {a b} {e b} {d b} {e c} {d c} {b c}}", "", false, "comparison-order-879",
  )
}

///|
test "Tcl sort cases 881 through 920" {
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"d\" \"c\" \"e\" \"b\" \"a\"]];list $result $calls",
    "{a b c d e} {{d c} {e b} {c b} {c e} {d e} {b a}}", "", false, "comparison-order-880",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"d\" \"c\" \"e\" \"b\" \"a\"]];list $result $calls",
    "{e d c b a} {{d c} {e b} {d e} {d b} {c b} {e a} {d a} {c a} {b a}}", "", false,
    "comparison-order-881",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"d\" \"c\" \"e\" \"b\" \"a\"]];list $result $calls",
    "{a b c d e} {{d c} {e b} {c b} {c e} {d e} {b a}}", "", false, "comparison-order-882",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"d\" \"c\" \"e\" \"b\" \"a\"]];list $result $calls",
    "{e d c b a} {{d c} {e b} {d e} {d b} {c b} {e a} {d a} {c a} {b a}}", "", false,
    "comparison-order-883",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"d\" \"c\" \"e\" \"a\" \"b\"]];list $result $calls",
    "{a b c d e} {{d c} {e a} {c a} {c e} {d e} {a b} {c b}}", "", false, "comparison-order-884",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"d\" \"c\" \"e\" \"a\" \"b\"]];list $result $calls",
    "{e d c b a} {{d c} {e a} {d e} {d a} {c a} {e b} {d b} {c b} {a b}}", "", false,
    "comparison-order-885",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"d\" \"c\" \"e\" \"a\" \"b\"]];list $result $calls",
    "{a b c d e} {{d c} {e a} {c a} {c e} {d e} {a b} {c b}}", "", false, "comparison-order-886",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"d\" \"c\" \"e\" \"a\" \"b\"]];list $result $calls",
    "{e d c b a} {{d c} {e a} {d e} {d a} {c a} {e b} {d b} {c b} {a b}}", "", false,
    "comparison-order-887",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"d\" \"c\" \"b\" \"e\" \"a\"]];list $result $calls",
    "{a b c d e} {{d c} {b e} {c b} {c e} {d e} {b a}}", "", false, "comparison-order-888",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"d\" \"c\" \"b\" \"e\" \"a\"]];list $result $calls",
    "{e d c b a} {{d c} {b e} {d e} {d b} {c b} {e a} {d a} {c a} {b a}}", "", false,
    "comparison-order-889",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"d\" \"c\" \"b\" \"e\" \"a\"]];list $result $calls",
    "{a b c d e} {{d c} {b e} {c b} {c e} {d e} {b a}}", "", false, "comparison-order-890",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"d\" \"c\" \"b\" \"e\" \"a\"]];list $result $calls",
    "{e d c b a} {{d c} {b e} {d e} {d b} {c b} {e a} {d a} {c a} {b a}}", "", false,
    "comparison-order-891",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"d\" \"c\" \"b\" \"a\" \"e\"]];list $result $calls",
    "{a b c d e} {{d c} {b a} {c a} {c b} {a e} {b e} {c e} {d e}}", "", false, "comparison-order-892",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"d\" \"c\" \"b\" \"a\" \"e\"]];list $result $calls",
    "{e d c b a} {{d c} {b a} {d b} {c b} {d e}}", "", false, "comparison-order-893",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"d\" \"c\" \"b\" \"a\" \"e\"]];list $result $calls",
    "{a b c d e} {{d c} {b a} {c a} {c b} {a e} {b e} {c e} {d e}}", "", false, "comparison-order-894",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"d\" \"c\" \"b\" \"a\" \"e\"]];list $result $calls",
    "{e d c b a} {{d c} {b a} {d b} {c b} {d e}}", "", false, "comparison-order-895",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"d\" \"c\" \"a\" \"e\" \"b\"]];list $result $calls",
    "{a b c d e} {{d c} {a e} {c a} {c e} {d e} {a b} {c b}}", "", false, "comparison-order-896",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"d\" \"c\" \"a\" \"e\" \"b\"]];list $result $calls",
    "{e d c b a} {{d c} {a e} {d e} {d a} {c a} {e b} {d b} {c b} {a b}}", "", false,
    "comparison-order-897",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"d\" \"c\" \"a\" \"e\" \"b\"]];list $result $calls",
    "{a b c d e} {{d c} {a e} {c a} {c e} {d e} {a b} {c b}}", "", false, "comparison-order-898",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"d\" \"c\" \"a\" \"e\" \"b\"]];list $result $calls",
    "{e d c b a} {{d c} {a e} {d e} {d a} {c a} {e b} {d b} {c b} {a b}}", "", false,
    "comparison-order-899",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"d\" \"c\" \"a\" \"b\" \"e\"]];list $result $calls",
    "{a b c d e} {{d c} {a b} {c a} {c b} {a e} {b e} {c e} {d e}}", "", false, "comparison-order-900",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"d\" \"c\" \"a\" \"b\" \"e\"]];list $result $calls",
    "{e d c b a} {{d c} {a b} {d b} {c b} {d e}}", "", false, "comparison-order-901",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"d\" \"c\" \"a\" \"b\" \"e\"]];list $result $calls",
    "{a b c d e} {{d c} {a b} {c a} {c b} {a e} {b e} {c e} {d e}}", "", false, "comparison-order-902",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"d\" \"c\" \"a\" \"b\" \"e\"]];list $result $calls",
    "{e d c b a} {{d c} {a b} {d b} {c b} {d e}}", "", false, "comparison-order-903",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"d\" \"b\" \"e\" \"c\" \"a\"]];list $result $calls",
    "{a b c d e} {{d b} {e c} {b c} {d c} {d e} {b a}}", "", false, "comparison-order-904",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"d\" \"b\" \"e\" \"c\" \"a\"]];list $result $calls",
    "{e d c b a} {{d b} {e c} {d e} {d c} {b c} {e a} {d a} {c a} {b a}}", "", false,
    "comparison-order-905",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"d\" \"b\" \"e\" \"c\" \"a\"]];list $result $calls",
    "{a b c d e} {{d b} {e c} {b c} {d c} {d e} {b a}}", "", false, "comparison-order-906",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"d\" \"b\" \"e\" \"c\" \"a\"]];list $result $calls",
    "{e d c b a} {{d b} {e c} {d e} {d c} {b c} {e a} {d a} {c a} {b a}}", "", false,
    "comparison-order-907",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"d\" \"b\" \"e\" \"a\" \"c\"]];list $result $calls",
    "{a b c d e} {{d b} {e a} {b a} {b e} {d e} {a c} {b c} {d c}}", "", false, "comparison-order-908",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"d\" \"b\" \"e\" \"a\" \"c\"]];list $result $calls",
    "{e d c b a} {{d b} {e a} {d e} {d a} {b a} {e c} {d c} {b c}}", "", false, "comparison-order-909",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"d\" \"b\" \"e\" \"a\" \"c\"]];list $result $calls",
    "{a b c d e} {{d b} {e a} {b a} {b e} {d e} {a c} {b c} {d c}}", "", false, "comparison-order-910",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"d\" \"b\" \"e\" \"a\" \"c\"]];list $result $calls",
    "{e d c b a} {{d b} {e a} {d e} {d a} {b a} {e c} {d c} {b c}}", "", false, "comparison-order-911",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"d\" \"b\" \"c\" \"e\" \"a\"]];list $result $calls",
    "{a b c d e} {{d b} {c e} {b c} {d c} {d e} {b a}}", "", false, "comparison-order-912",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"d\" \"b\" \"c\" \"e\" \"a\"]];list $result $calls",
    "{e d c b a} {{d b} {c e} {d e} {d c} {b c} {e a} {d a} {c a} {b a}}", "", false,
    "comparison-order-913",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"d\" \"b\" \"c\" \"e\" \"a\"]];list $result $calls",
    "{a b c d e} {{d b} {c e} {b c} {d c} {d e} {b a}}", "", false, "comparison-order-914",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"d\" \"b\" \"c\" \"e\" \"a\"]];list $result $calls",
    "{e d c b a} {{d b} {c e} {d e} {d c} {b c} {e a} {d a} {c a} {b a}}", "", false,
    "comparison-order-915",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"d\" \"b\" \"c\" \"a\" \"e\"]];list $result $calls",
    "{a b c d e} {{d b} {c a} {b a} {b c} {d c} {a e} {b e} {c e} {d e}}", "", false,
    "comparison-order-916",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"d\" \"b\" \"c\" \"a\" \"e\"]];list $result $calls",
    "{e d c b a} {{d b} {c a} {d c} {b c} {b a} {d e}}", "", false, "comparison-order-917",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"d\" \"b\" \"c\" \"a\" \"e\"]];list $result $calls",
    "{a b c d e} {{d b} {c a} {b a} {b c} {d c} {a e} {b e} {c e} {d e}}", "", false,
    "comparison-order-918",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"d\" \"b\" \"c\" \"a\" \"e\"]];list $result $calls",
    "{e d c b a} {{d b} {c a} {d c} {b c} {b a} {d e}}", "", false, "comparison-order-919",
  )
}

///|
test "Tcl sort cases 921 through 960" {
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"d\" \"b\" \"a\" \"e\" \"c\"]];list $result $calls",
    "{a b c d e} {{d b} {a e} {b a} {b e} {d e} {a c} {b c} {d c}}", "", false, "comparison-order-920",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"d\" \"b\" \"a\" \"e\" \"c\"]];list $result $calls",
    "{e d c b a} {{d b} {a e} {d e} {d a} {b a} {e c} {d c} {b c}}", "", false, "comparison-order-921",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"d\" \"b\" \"a\" \"e\" \"c\"]];list $result $calls",
    "{a b c d e} {{d b} {a e} {b a} {b e} {d e} {a c} {b c} {d c}}", "", false, "comparison-order-922",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"d\" \"b\" \"a\" \"e\" \"c\"]];list $result $calls",
    "{e d c b a} {{d b} {a e} {d e} {d a} {b a} {e c} {d c} {b c}}", "", false, "comparison-order-923",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"d\" \"b\" \"a\" \"c\" \"e\"]];list $result $calls",
    "{a b c d e} {{d b} {a c} {b a} {b c} {d c} {a e} {b e} {c e} {d e}}", "", false,
    "comparison-order-924",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"d\" \"b\" \"a\" \"c\" \"e\"]];list $result $calls",
    "{e d c b a} {{d b} {a c} {d c} {b c} {b a} {d e}}", "", false, "comparison-order-925",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"d\" \"b\" \"a\" \"c\" \"e\"]];list $result $calls",
    "{a b c d e} {{d b} {a c} {b a} {b c} {d c} {a e} {b e} {c e} {d e}}", "", false,
    "comparison-order-926",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"d\" \"b\" \"a\" \"c\" \"e\"]];list $result $calls",
    "{e d c b a} {{d b} {a c} {d c} {b c} {b a} {d e}}", "", false, "comparison-order-927",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"d\" \"a\" \"e\" \"c\" \"b\"]];list $result $calls",
    "{a b c d e} {{d a} {e c} {a c} {d c} {d e} {a b} {c b}}", "", false, "comparison-order-928",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"d\" \"a\" \"e\" \"c\" \"b\"]];list $result $calls",
    "{e d c b a} {{d a} {e c} {d e} {d c} {a c} {e b} {d b} {c b} {a b}}", "", false,
    "comparison-order-929",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"d\" \"a\" \"e\" \"c\" \"b\"]];list $result $calls",
    "{a b c d e} {{d a} {e c} {a c} {d c} {d e} {a b} {c b}}", "", false, "comparison-order-930",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"d\" \"a\" \"e\" \"c\" \"b\"]];list $result $calls",
    "{e d c b a} {{d a} {e c} {d e} {d c} {a c} {e b} {d b} {c b} {a b}}", "", false,
    "comparison-order-931",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"d\" \"a\" \"e\" \"b\" \"c\"]];list $result $calls",
    "{a b c d e} {{d a} {e b} {a b} {d b} {d e} {a c} {b c} {d c}}", "", false, "comparison-order-932",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"d\" \"a\" \"e\" \"b\" \"c\"]];list $result $calls",
    "{e d c b a} {{d a} {e b} {d e} {d b} {a b} {e c} {d c} {b c}}", "", false, "comparison-order-933",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"d\" \"a\" \"e\" \"b\" \"c\"]];list $result $calls",
    "{a b c d e} {{d a} {e b} {a b} {d b} {d e} {a c} {b c} {d c}}", "", false, "comparison-order-934",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"d\" \"a\" \"e\" \"b\" \"c\"]];list $result $calls",
    "{e d c b a} {{d a} {e b} {d e} {d b} {a b} {e c} {d c} {b c}}", "", false, "comparison-order-935",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"d\" \"a\" \"c\" \"e\" \"b\"]];list $result $calls",
    "{a b c d e} {{d a} {c e} {a c} {d c} {d e} {a b} {c b}}", "", false, "comparison-order-936",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"d\" \"a\" \"c\" \"e\" \"b\"]];list $result $calls",
    "{e d c b a} {{d a} {c e} {d e} {d c} {a c} {e b} {d b} {c b} {a b}}", "", false,
    "comparison-order-937",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"d\" \"a\" \"c\" \"e\" \"b\"]];list $result $calls",
    "{a b c d e} {{d a} {c e} {a c} {d c} {d e} {a b} {c b}}", "", false, "comparison-order-938",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"d\" \"a\" \"c\" \"e\" \"b\"]];list $result $calls",
    "{e d c b a} {{d a} {c e} {d e} {d c} {a c} {e b} {d b} {c b} {a b}}", "", false,
    "comparison-order-939",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"d\" \"a\" \"c\" \"b\" \"e\"]];list $result $calls",
    "{a b c d e} {{d a} {c b} {a b} {d b} {d c} {a e} {b e} {c e} {d e}}", "", false,
    "comparison-order-940",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"d\" \"a\" \"c\" \"b\" \"e\"]];list $result $calls",
    "{e d c b a} {{d a} {c b} {d c} {a c} {a b} {d e}}", "", false, "comparison-order-941",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"d\" \"a\" \"c\" \"b\" \"e\"]];list $result $calls",
    "{a b c d e} {{d a} {c b} {a b} {d b} {d c} {a e} {b e} {c e} {d e}}", "", false,
    "comparison-order-942",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"d\" \"a\" \"c\" \"b\" \"e\"]];list $result $calls",
    "{e d c b a} {{d a} {c b} {d c} {a c} {a b} {d e}}", "", false, "comparison-order-943",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"d\" \"a\" \"b\" \"e\" \"c\"]];list $result $calls",
    "{a b c d e} {{d a} {b e} {a b} {d b} {d e} {a c} {b c} {d c}}", "", false, "comparison-order-944",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"d\" \"a\" \"b\" \"e\" \"c\"]];list $result $calls",
    "{e d c b a} {{d a} {b e} {d e} {d b} {a b} {e c} {d c} {b c}}", "", false, "comparison-order-945",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"d\" \"a\" \"b\" \"e\" \"c\"]];list $result $calls",
    "{a b c d e} {{d a} {b e} {a b} {d b} {d e} {a c} {b c} {d c}}", "", false, "comparison-order-946",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"d\" \"a\" \"b\" \"e\" \"c\"]];list $result $calls",
    "{e d c b a} {{d a} {b e} {d e} {d b} {a b} {e c} {d c} {b c}}", "", false, "comparison-order-947",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"d\" \"a\" \"b\" \"c\" \"e\"]];list $result $calls",
    "{a b c d e} {{d a} {b c} {a b} {d b} {d c} {a e} {b e} {c e} {d e}}", "", false,
    "comparison-order-948",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"d\" \"a\" \"b\" \"c\" \"e\"]];list $result $calls",
    "{e d c b a} {{d a} {b c} {d c} {a c} {a b} {d e}}", "", false, "comparison-order-949",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"d\" \"a\" \"b\" \"c\" \"e\"]];list $result $calls",
    "{a b c d e} {{d a} {b c} {a b} {d b} {d c} {a e} {b e} {c e} {d e}}", "", false,
    "comparison-order-950",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"d\" \"a\" \"b\" \"c\" \"e\"]];list $result $calls",
    "{e d c b a} {{d a} {b c} {d c} {a c} {a b} {d e}}", "", false, "comparison-order-951",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"c\" \"e\" \"d\" \"b\" \"a\"]];list $result $calls",
    "{a b c d e} {{c e} {d b} {c b} {c d} {e d} {b a}}", "", false, "comparison-order-952",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"c\" \"e\" \"d\" \"b\" \"a\"]];list $result $calls",
    "{e d c b a} {{c e} {d b} {e d} {c d} {c b} {e a} {d a} {c a} {b a}}", "", false,
    "comparison-order-953",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"c\" \"e\" \"d\" \"b\" \"a\"]];list $result $calls",
    "{a b c d e} {{c e} {d b} {c b} {c d} {e d} {b a}}", "", false, "comparison-order-954",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"c\" \"e\" \"d\" \"b\" \"a\"]];list $result $calls",
    "{e d c b a} {{c e} {d b} {e d} {c d} {c b} {e a} {d a} {c a} {b a}}", "", false,
    "comparison-order-955",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"c\" \"e\" \"d\" \"a\" \"b\"]];list $result $calls",
    "{a b c d e} {{c e} {d a} {c a} {c d} {e d} {a b} {c b}}", "", false, "comparison-order-956",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"c\" \"e\" \"d\" \"a\" \"b\"]];list $result $calls",
    "{e d c b a} {{c e} {d a} {e d} {c d} {c a} {e b} {d b} {c b} {a b}}", "", false,
    "comparison-order-957",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"c\" \"e\" \"d\" \"a\" \"b\"]];list $result $calls",
    "{a b c d e} {{c e} {d a} {c a} {c d} {e d} {a b} {c b}}", "", false, "comparison-order-958",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"c\" \"e\" \"d\" \"a\" \"b\"]];list $result $calls",
    "{e d c b a} {{c e} {d a} {e d} {c d} {c a} {e b} {d b} {c b} {a b}}", "", false,
    "comparison-order-959",
  )
}

///|
test "Tcl sort cases 961 through 1000" {
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"c\" \"e\" \"b\" \"d\" \"a\"]];list $result $calls",
    "{a b c d e} {{c e} {b d} {c b} {c d} {e d} {b a}}", "", false, "comparison-order-960",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"c\" \"e\" \"b\" \"d\" \"a\"]];list $result $calls",
    "{e d c b a} {{c e} {b d} {e d} {c d} {c b} {e a} {d a} {c a} {b a}}", "", false,
    "comparison-order-961",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"c\" \"e\" \"b\" \"d\" \"a\"]];list $result $calls",
    "{a b c d e} {{c e} {b d} {c b} {c d} {e d} {b a}}", "", false, "comparison-order-962",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"c\" \"e\" \"b\" \"d\" \"a\"]];list $result $calls",
    "{e d c b a} {{c e} {b d} {e d} {c d} {c b} {e a} {d a} {c a} {b a}}", "", false,
    "comparison-order-963",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"c\" \"e\" \"b\" \"a\" \"d\"]];list $result $calls",
    "{a b c d e} {{c e} {b a} {c a} {c b} {a d} {b d} {c d} {e d}}", "", false, "comparison-order-964",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"c\" \"e\" \"b\" \"a\" \"d\"]];list $result $calls",
    "{e d c b a} {{c e} {b a} {e b} {c b} {e d} {c d}}", "", false, "comparison-order-965",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"c\" \"e\" \"b\" \"a\" \"d\"]];list $result $calls",
    "{a b c d e} {{c e} {b a} {c a} {c b} {a d} {b d} {c d} {e d}}", "", false, "comparison-order-966",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"c\" \"e\" \"b\" \"a\" \"d\"]];list $result $calls",
    "{e d c b a} {{c e} {b a} {e b} {c b} {e d} {c d}}", "", false, "comparison-order-967",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"c\" \"e\" \"a\" \"d\" \"b\"]];list $result $calls",
    "{a b c d e} {{c e} {a d} {c a} {c d} {e d} {a b} {c b}}", "", false, "comparison-order-968",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"c\" \"e\" \"a\" \"d\" \"b\"]];list $result $calls",
    "{e d c b a} {{c e} {a d} {e d} {c d} {c a} {e b} {d b} {c b} {a b}}", "", false,
    "comparison-order-969",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"c\" \"e\" \"a\" \"d\" \"b\"]];list $result $calls",
    "{a b c d e} {{c e} {a d} {c a} {c d} {e d} {a b} {c b}}", "", false, "comparison-order-970",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"c\" \"e\" \"a\" \"d\" \"b\"]];list $result $calls",
    "{e d c b a} {{c e} {a d} {e d} {c d} {c a} {e b} {d b} {c b} {a b}}", "", false,
    "comparison-order-971",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"c\" \"e\" \"a\" \"b\" \"d\"]];list $result $calls",
    "{a b c d e} {{c e} {a b} {c a} {c b} {a d} {b d} {c d} {e d}}", "", false, "comparison-order-972",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"c\" \"e\" \"a\" \"b\" \"d\"]];list $result $calls",
    "{e d c b a} {{c e} {a b} {e b} {c b} {e d} {c d}}", "", false, "comparison-order-973",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"c\" \"e\" \"a\" \"b\" \"d\"]];list $result $calls",
    "{a b c d e} {{c e} {a b} {c a} {c b} {a d} {b d} {c d} {e d}}", "", false, "comparison-order-974",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"c\" \"e\" \"a\" \"b\" \"d\"]];list $result $calls",
    "{e d c b a} {{c e} {a b} {e b} {c b} {e d} {c d}}", "", false, "comparison-order-975",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"c\" \"d\" \"e\" \"b\" \"a\"]];list $result $calls",
    "{a b c d e} {{c d} {e b} {c b} {c e} {d e} {b a}}", "", false, "comparison-order-976",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"c\" \"d\" \"e\" \"b\" \"a\"]];list $result $calls",
    "{e d c b a} {{c d} {e b} {d e} {d b} {c b} {e a} {d a} {c a} {b a}}", "", false,
    "comparison-order-977",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"c\" \"d\" \"e\" \"b\" \"a\"]];list $result $calls",
    "{a b c d e} {{c d} {e b} {c b} {c e} {d e} {b a}}", "", false, "comparison-order-978",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"c\" \"d\" \"e\" \"b\" \"a\"]];list $result $calls",
    "{e d c b a} {{c d} {e b} {d e} {d b} {c b} {e a} {d a} {c a} {b a}}", "", false,
    "comparison-order-979",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"c\" \"d\" \"e\" \"a\" \"b\"]];list $result $calls",
    "{a b c d e} {{c d} {e a} {c a} {c e} {d e} {a b} {c b}}", "", false, "comparison-order-980",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"c\" \"d\" \"e\" \"a\" \"b\"]];list $result $calls",
    "{e d c b a} {{c d} {e a} {d e} {d a} {c a} {e b} {d b} {c b} {a b}}", "", false,
    "comparison-order-981",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"c\" \"d\" \"e\" \"a\" \"b\"]];list $result $calls",
    "{a b c d e} {{c d} {e a} {c a} {c e} {d e} {a b} {c b}}", "", false, "comparison-order-982",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"c\" \"d\" \"e\" \"a\" \"b\"]];list $result $calls",
    "{e d c b a} {{c d} {e a} {d e} {d a} {c a} {e b} {d b} {c b} {a b}}", "", false,
    "comparison-order-983",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"c\" \"d\" \"b\" \"e\" \"a\"]];list $result $calls",
    "{a b c d e} {{c d} {b e} {c b} {c e} {d e} {b a}}", "", false, "comparison-order-984",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"c\" \"d\" \"b\" \"e\" \"a\"]];list $result $calls",
    "{e d c b a} {{c d} {b e} {d e} {d b} {c b} {e a} {d a} {c a} {b a}}", "", false,
    "comparison-order-985",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"c\" \"d\" \"b\" \"e\" \"a\"]];list $result $calls",
    "{a b c d e} {{c d} {b e} {c b} {c e} {d e} {b a}}", "", false, "comparison-order-986",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"c\" \"d\" \"b\" \"e\" \"a\"]];list $result $calls",
    "{e d c b a} {{c d} {b e} {d e} {d b} {c b} {e a} {d a} {c a} {b a}}", "", false,
    "comparison-order-987",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"c\" \"d\" \"b\" \"a\" \"e\"]];list $result $calls",
    "{a b c d e} {{c d} {b a} {c a} {c b} {a e} {b e} {c e} {d e}}", "", false, "comparison-order-988",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"c\" \"d\" \"b\" \"a\" \"e\"]];list $result $calls",
    "{e d c b a} {{c d} {b a} {d b} {c b} {d e}}", "", false, "comparison-order-989",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"c\" \"d\" \"b\" \"a\" \"e\"]];list $result $calls",
    "{a b c d e} {{c d} {b a} {c a} {c b} {a e} {b e} {c e} {d e}}", "", false, "comparison-order-990",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"c\" \"d\" \"b\" \"a\" \"e\"]];list $result $calls",
    "{e d c b a} {{c d} {b a} {d b} {c b} {d e}}", "", false, "comparison-order-991",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"c\" \"d\" \"a\" \"e\" \"b\"]];list $result $calls",
    "{a b c d e} {{c d} {a e} {c a} {c e} {d e} {a b} {c b}}", "", false, "comparison-order-992",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"c\" \"d\" \"a\" \"e\" \"b\"]];list $result $calls",
    "{e d c b a} {{c d} {a e} {d e} {d a} {c a} {e b} {d b} {c b} {a b}}", "", false,
    "comparison-order-993",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"c\" \"d\" \"a\" \"e\" \"b\"]];list $result $calls",
    "{a b c d e} {{c d} {a e} {c a} {c e} {d e} {a b} {c b}}", "", false, "comparison-order-994",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"c\" \"d\" \"a\" \"e\" \"b\"]];list $result $calls",
    "{e d c b a} {{c d} {a e} {d e} {d a} {c a} {e b} {d b} {c b} {a b}}", "", false,
    "comparison-order-995",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"c\" \"d\" \"a\" \"b\" \"e\"]];list $result $calls",
    "{a b c d e} {{c d} {a b} {c a} {c b} {a e} {b e} {c e} {d e}}", "", false, "comparison-order-996",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"c\" \"d\" \"a\" \"b\" \"e\"]];list $result $calls",
    "{e d c b a} {{c d} {a b} {d b} {c b} {d e}}", "", false, "comparison-order-997",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"c\" \"d\" \"a\" \"b\" \"e\"]];list $result $calls",
    "{a b c d e} {{c d} {a b} {c a} {c b} {a e} {b e} {c e} {d e}}", "", false, "comparison-order-998",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"c\" \"d\" \"a\" \"b\" \"e\"]];list $result $calls",
    "{e d c b a} {{c d} {a b} {d b} {c b} {d e}}", "", false, "comparison-order-999",
  )
}

///|
test "Tcl sort cases 1001 through 1040" {
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"c\" \"b\" \"e\" \"d\" \"a\"]];list $result $calls",
    "{a b c d e} {{c b} {e d} {b d} {c d} {b a}}", "", false, "comparison-order-1000",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"c\" \"b\" \"e\" \"d\" \"a\"]];list $result $calls",
    "{e d c b a} {{c b} {e d} {c e} {c d} {e a} {d a} {c a} {b a}}", "", false, "comparison-order-1001",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"c\" \"b\" \"e\" \"d\" \"a\"]];list $result $calls",
    "{a b c d e} {{c b} {e d} {b d} {c d} {b a}}", "", false, "comparison-order-1002",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"c\" \"b\" \"e\" \"d\" \"a\"]];list $result $calls",
    "{e d c b a} {{c b} {e d} {c e} {c d} {e a} {d a} {c a} {b a}}", "", false, "comparison-order-1003",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"c\" \"b\" \"e\" \"a\" \"d\"]];list $result $calls",
    "{a b c d e} {{c b} {e a} {b a} {b e} {c e} {a d} {b d} {c d} {e d}}", "", false,
    "comparison-order-1004",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"c\" \"b\" \"e\" \"a\" \"d\"]];list $result $calls",
    "{e d c b a} {{c b} {e a} {c e} {c a} {b a} {e d} {c d}}", "", false, "comparison-order-1005",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"c\" \"b\" \"e\" \"a\" \"d\"]];list $result $calls",
    "{a b c d e} {{c b} {e a} {b a} {b e} {c e} {a d} {b d} {c d} {e d}}", "", false,
    "comparison-order-1006",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"c\" \"b\" \"e\" \"a\" \"d\"]];list $result $calls",
    "{e d c b a} {{c b} {e a} {c e} {c a} {b a} {e d} {c d}}", "", false, "comparison-order-1007",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"c\" \"b\" \"d\" \"e\" \"a\"]];list $result $calls",
    "{a b c d e} {{c b} {d e} {b d} {c d} {b a}}", "", false, "comparison-order-1008",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"c\" \"b\" \"d\" \"e\" \"a\"]];list $result $calls",
    "{e d c b a} {{c b} {d e} {c e} {c d} {e a} {d a} {c a} {b a}}", "", false, "comparison-order-1009",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"c\" \"b\" \"d\" \"e\" \"a\"]];list $result $calls",
    "{a b c d e} {{c b} {d e} {b d} {c d} {b a}}", "", false, "comparison-order-1010",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"c\" \"b\" \"d\" \"e\" \"a\"]];list $result $calls",
    "{e d c b a} {{c b} {d e} {c e} {c d} {e a} {d a} {c a} {b a}}", "", false, "comparison-order-1011",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"c\" \"b\" \"d\" \"a\" \"e\"]];list $result $calls",
    "{a b c d e} {{c b} {d a} {b a} {b d} {c d} {a e} {b e} {c e} {d e}}", "", false,
    "comparison-order-1012",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"c\" \"b\" \"d\" \"a\" \"e\"]];list $result $calls",
    "{e d c b a} {{c b} {d a} {c d} {c a} {b a} {d e}}", "", false, "comparison-order-1013",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"c\" \"b\" \"d\" \"a\" \"e\"]];list $result $calls",
    "{a b c d e} {{c b} {d a} {b a} {b d} {c d} {a e} {b e} {c e} {d e}}", "", false,
    "comparison-order-1014",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"c\" \"b\" \"d\" \"a\" \"e\"]];list $result $calls",
    "{e d c b a} {{c b} {d a} {c d} {c a} {b a} {d e}}", "", false, "comparison-order-1015",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"c\" \"b\" \"a\" \"e\" \"d\"]];list $result $calls",
    "{a b c d e} {{c b} {a e} {b a} {b e} {c e} {a d} {b d} {c d} {e d}}", "", false,
    "comparison-order-1016",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"c\" \"b\" \"a\" \"e\" \"d\"]];list $result $calls",
    "{e d c b a} {{c b} {a e} {c e} {c a} {b a} {e d} {c d}}", "", false, "comparison-order-1017",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"c\" \"b\" \"a\" \"e\" \"d\"]];list $result $calls",
    "{a b c d e} {{c b} {a e} {b a} {b e} {c e} {a d} {b d} {c d} {e d}}", "", false,
    "comparison-order-1018",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"c\" \"b\" \"a\" \"e\" \"d\"]];list $result $calls",
    "{e d c b a} {{c b} {a e} {c e} {c a} {b a} {e d} {c d}}", "", false, "comparison-order-1019",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"c\" \"b\" \"a\" \"d\" \"e\"]];list $result $calls",
    "{a b c d e} {{c b} {a d} {b a} {b d} {c d} {a e} {b e} {c e} {d e}}", "", false,
    "comparison-order-1020",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"c\" \"b\" \"a\" \"d\" \"e\"]];list $result $calls",
    "{e d c b a} {{c b} {a d} {c d} {c a} {b a} {d e}}", "", false, "comparison-order-1021",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"c\" \"b\" \"a\" \"d\" \"e\"]];list $result $calls",
    "{a b c d e} {{c b} {a d} {b a} {b d} {c d} {a e} {b e} {c e} {d e}}", "", false,
    "comparison-order-1022",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"c\" \"b\" \"a\" \"d\" \"e\"]];list $result $calls",
    "{e d c b a} {{c b} {a d} {c d} {c a} {b a} {d e}}", "", false, "comparison-order-1023",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"c\" \"a\" \"e\" \"d\" \"b\"]];list $result $calls",
    "{a b c d e} {{c a} {e d} {a d} {c d} {a b} {c b}}", "", false, "comparison-order-1024",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"c\" \"a\" \"e\" \"d\" \"b\"]];list $result $calls",
    "{e d c b a} {{c a} {e d} {c e} {c d} {e b} {d b} {c b} {a b}}", "", false, "comparison-order-1025",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"c\" \"a\" \"e\" \"d\" \"b\"]];list $result $calls",
    "{a b c d e} {{c a} {e d} {a d} {c d} {a b} {c b}}", "", false, "comparison-order-1026",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"c\" \"a\" \"e\" \"d\" \"b\"]];list $result $calls",
    "{e d c b a} {{c a} {e d} {c e} {c d} {e b} {d b} {c b} {a b}}", "", false, "comparison-order-1027",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"c\" \"a\" \"e\" \"b\" \"d\"]];list $result $calls",
    "{a b c d e} {{c a} {e b} {a b} {c b} {c e} {a d} {b d} {c d} {e d}}", "", false,
    "comparison-order-1028",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"c\" \"a\" \"e\" \"b\" \"d\"]];list $result $calls",
    "{e d c b a} {{c a} {e b} {c e} {c b} {a b} {e d} {c d}}", "", false, "comparison-order-1029",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"c\" \"a\" \"e\" \"b\" \"d\"]];list $result $calls",
    "{a b c d e} {{c a} {e b} {a b} {c b} {c e} {a d} {b d} {c d} {e d}}", "", false,
    "comparison-order-1030",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"c\" \"a\" \"e\" \"b\" \"d\"]];list $result $calls",
    "{e d c b a} {{c a} {e b} {c e} {c b} {a b} {e d} {c d}}", "", false, "comparison-order-1031",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"c\" \"a\" \"d\" \"e\" \"b\"]];list $result $calls",
    "{a b c d e} {{c a} {d e} {a d} {c d} {a b} {c b}}", "", false, "comparison-order-1032",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"c\" \"a\" \"d\" \"e\" \"b\"]];list $result $calls",
    "{e d c b a} {{c a} {d e} {c e} {c d} {e b} {d b} {c b} {a b}}", "", false, "comparison-order-1033",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"c\" \"a\" \"d\" \"e\" \"b\"]];list $result $calls",
    "{a b c d e} {{c a} {d e} {a d} {c d} {a b} {c b}}", "", false, "comparison-order-1034",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"c\" \"a\" \"d\" \"e\" \"b\"]];list $result $calls",
    "{e d c b a} {{c a} {d e} {c e} {c d} {e b} {d b} {c b} {a b}}", "", false, "comparison-order-1035",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"c\" \"a\" \"d\" \"b\" \"e\"]];list $result $calls",
    "{a b c d e} {{c a} {d b} {a b} {c b} {c d} {a e} {b e} {c e} {d e}}", "", false,
    "comparison-order-1036",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"c\" \"a\" \"d\" \"b\" \"e\"]];list $result $calls",
    "{e d c b a} {{c a} {d b} {c d} {c b} {a b} {d e}}", "", false, "comparison-order-1037",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"c\" \"a\" \"d\" \"b\" \"e\"]];list $result $calls",
    "{a b c d e} {{c a} {d b} {a b} {c b} {c d} {a e} {b e} {c e} {d e}}", "", false,
    "comparison-order-1038",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"c\" \"a\" \"d\" \"b\" \"e\"]];list $result $calls",
    "{e d c b a} {{c a} {d b} {c d} {c b} {a b} {d e}}", "", false, "comparison-order-1039",
  )
}

///|
test "Tcl sort cases 1041 through 1080" {
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"c\" \"a\" \"b\" \"e\" \"d\"]];list $result $calls",
    "{a b c d e} {{c a} {b e} {a b} {c b} {c e} {a d} {b d} {c d} {e d}}", "", false,
    "comparison-order-1040",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"c\" \"a\" \"b\" \"e\" \"d\"]];list $result $calls",
    "{e d c b a} {{c a} {b e} {c e} {c b} {a b} {e d} {c d}}", "", false, "comparison-order-1041",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"c\" \"a\" \"b\" \"e\" \"d\"]];list $result $calls",
    "{a b c d e} {{c a} {b e} {a b} {c b} {c e} {a d} {b d} {c d} {e d}}", "", false,
    "comparison-order-1042",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"c\" \"a\" \"b\" \"e\" \"d\"]];list $result $calls",
    "{e d c b a} {{c a} {b e} {c e} {c b} {a b} {e d} {c d}}", "", false, "comparison-order-1043",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"c\" \"a\" \"b\" \"d\" \"e\"]];list $result $calls",
    "{a b c d e} {{c a} {b d} {a b} {c b} {c d} {a e} {b e} {c e} {d e}}", "", false,
    "comparison-order-1044",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"c\" \"a\" \"b\" \"d\" \"e\"]];list $result $calls",
    "{e d c b a} {{c a} {b d} {c d} {c b} {a b} {d e}}", "", false, "comparison-order-1045",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"c\" \"a\" \"b\" \"d\" \"e\"]];list $result $calls",
    "{a b c d e} {{c a} {b d} {a b} {c b} {c d} {a e} {b e} {c e} {d e}}", "", false,
    "comparison-order-1046",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"c\" \"a\" \"b\" \"d\" \"e\"]];list $result $calls",
    "{e d c b a} {{c a} {b d} {c d} {c b} {a b} {d e}}", "", false, "comparison-order-1047",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"b\" \"e\" \"d\" \"c\" \"a\"]];list $result $calls",
    "{a b c d e} {{b e} {d c} {b c} {e c} {e d} {b a}}", "", false, "comparison-order-1048",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"b\" \"e\" \"d\" \"c\" \"a\"]];list $result $calls",
    "{e d c b a} {{b e} {d c} {e d} {b d} {b c} {e a} {d a} {c a} {b a}}", "", false,
    "comparison-order-1049",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"b\" \"e\" \"d\" \"c\" \"a\"]];list $result $calls",
    "{a b c d e} {{b e} {d c} {b c} {e c} {e d} {b a}}", "", false, "comparison-order-1050",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"b\" \"e\" \"d\" \"c\" \"a\"]];list $result $calls",
    "{e d c b a} {{b e} {d c} {e d} {b d} {b c} {e a} {d a} {c a} {b a}}", "", false,
    "comparison-order-1051",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"b\" \"e\" \"d\" \"a\" \"c\"]];list $result $calls",
    "{a b c d e} {{b e} {d a} {b a} {b d} {e d} {a c} {b c} {d c}}", "", false, "comparison-order-1052",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"b\" \"e\" \"d\" \"a\" \"c\"]];list $result $calls",
    "{e d c b a} {{b e} {d a} {e d} {b d} {b a} {e c} {d c} {b c}}", "", false, "comparison-order-1053",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"b\" \"e\" \"d\" \"a\" \"c\"]];list $result $calls",
    "{a b c d e} {{b e} {d a} {b a} {b d} {e d} {a c} {b c} {d c}}", "", false, "comparison-order-1054",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"b\" \"e\" \"d\" \"a\" \"c\"]];list $result $calls",
    "{e d c b a} {{b e} {d a} {e d} {b d} {b a} {e c} {d c} {b c}}", "", false, "comparison-order-1055",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"b\" \"e\" \"c\" \"d\" \"a\"]];list $result $calls",
    "{a b c d e} {{b e} {c d} {b c} {e c} {e d} {b a}}", "", false, "comparison-order-1056",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"b\" \"e\" \"c\" \"d\" \"a\"]];list $result $calls",
    "{e d c b a} {{b e} {c d} {e d} {b d} {b c} {e a} {d a} {c a} {b a}}", "", false,
    "comparison-order-1057",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"b\" \"e\" \"c\" \"d\" \"a\"]];list $result $calls",
    "{a b c d e} {{b e} {c d} {b c} {e c} {e d} {b a}}", "", false, "comparison-order-1058",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"b\" \"e\" \"c\" \"d\" \"a\"]];list $result $calls",
    "{e d c b a} {{b e} {c d} {e d} {b d} {b c} {e a} {d a} {c a} {b a}}", "", false,
    "comparison-order-1059",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"b\" \"e\" \"c\" \"a\" \"d\"]];list $result $calls",
    "{a b c d e} {{b e} {c a} {b a} {b c} {e c} {a d} {b d} {c d} {e d}}", "", false,
    "comparison-order-1060",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"b\" \"e\" \"c\" \"a\" \"d\"]];list $result $calls",
    "{e d c b a} {{b e} {c a} {e c} {b c} {b a} {e d} {c d}}", "", false, "comparison-order-1061",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"b\" \"e\" \"c\" \"a\" \"d\"]];list $result $calls",
    "{a b c d e} {{b e} {c a} {b a} {b c} {e c} {a d} {b d} {c d} {e d}}", "", false,
    "comparison-order-1062",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"b\" \"e\" \"c\" \"a\" \"d\"]];list $result $calls",
    "{e d c b a} {{b e} {c a} {e c} {b c} {b a} {e d} {c d}}", "", false, "comparison-order-1063",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"b\" \"e\" \"a\" \"d\" \"c\"]];list $result $calls",
    "{a b c d e} {{b e} {a d} {b a} {b d} {e d} {a c} {b c} {d c}}", "", false, "comparison-order-1064",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"b\" \"e\" \"a\" \"d\" \"c\"]];list $result $calls",
    "{e d c b a} {{b e} {a d} {e d} {b d} {b a} {e c} {d c} {b c}}", "", false, "comparison-order-1065",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"b\" \"e\" \"a\" \"d\" \"c\"]];list $result $calls",
    "{a b c d e} {{b e} {a d} {b a} {b d} {e d} {a c} {b c} {d c}}", "", false, "comparison-order-1066",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"b\" \"e\" \"a\" \"d\" \"c\"]];list $result $calls",
    "{e d c b a} {{b e} {a d} {e d} {b d} {b a} {e c} {d c} {b c}}", "", false, "comparison-order-1067",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"b\" \"e\" \"a\" \"c\" \"d\"]];list $result $calls",
    "{a b c d e} {{b e} {a c} {b a} {b c} {e c} {a d} {b d} {c d} {e d}}", "", false,
    "comparison-order-1068",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"b\" \"e\" \"a\" \"c\" \"d\"]];list $result $calls",
    "{e d c b a} {{b e} {a c} {e c} {b c} {b a} {e d} {c d}}", "", false, "comparison-order-1069",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"b\" \"e\" \"a\" \"c\" \"d\"]];list $result $calls",
    "{a b c d e} {{b e} {a c} {b a} {b c} {e c} {a d} {b d} {c d} {e d}}", "", false,
    "comparison-order-1070",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"b\" \"e\" \"a\" \"c\" \"d\"]];list $result $calls",
    "{e d c b a} {{b e} {a c} {e c} {b c} {b a} {e d} {c d}}", "", false, "comparison-order-1071",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"b\" \"d\" \"e\" \"c\" \"a\"]];list $result $calls",
    "{a b c d e} {{b d} {e c} {b c} {d c} {d e} {b a}}", "", false, "comparison-order-1072",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"b\" \"d\" \"e\" \"c\" \"a\"]];list $result $calls",
    "{e d c b a} {{b d} {e c} {d e} {d c} {b c} {e a} {d a} {c a} {b a}}", "", false,
    "comparison-order-1073",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"b\" \"d\" \"e\" \"c\" \"a\"]];list $result $calls",
    "{a b c d e} {{b d} {e c} {b c} {d c} {d e} {b a}}", "", false, "comparison-order-1074",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"b\" \"d\" \"e\" \"c\" \"a\"]];list $result $calls",
    "{e d c b a} {{b d} {e c} {d e} {d c} {b c} {e a} {d a} {c a} {b a}}", "", false,
    "comparison-order-1075",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"b\" \"d\" \"e\" \"a\" \"c\"]];list $result $calls",
    "{a b c d e} {{b d} {e a} {b a} {b e} {d e} {a c} {b c} {d c}}", "", false, "comparison-order-1076",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"b\" \"d\" \"e\" \"a\" \"c\"]];list $result $calls",
    "{e d c b a} {{b d} {e a} {d e} {d a} {b a} {e c} {d c} {b c}}", "", false, "comparison-order-1077",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"b\" \"d\" \"e\" \"a\" \"c\"]];list $result $calls",
    "{a b c d e} {{b d} {e a} {b a} {b e} {d e} {a c} {b c} {d c}}", "", false, "comparison-order-1078",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"b\" \"d\" \"e\" \"a\" \"c\"]];list $result $calls",
    "{e d c b a} {{b d} {e a} {d e} {d a} {b a} {e c} {d c} {b c}}", "", false, "comparison-order-1079",
  )
}

///|
test "Tcl sort cases 1081 through 1120" {
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"b\" \"d\" \"c\" \"e\" \"a\"]];list $result $calls",
    "{a b c d e} {{b d} {c e} {b c} {d c} {d e} {b a}}", "", false, "comparison-order-1080",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"b\" \"d\" \"c\" \"e\" \"a\"]];list $result $calls",
    "{e d c b a} {{b d} {c e} {d e} {d c} {b c} {e a} {d a} {c a} {b a}}", "", false,
    "comparison-order-1081",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"b\" \"d\" \"c\" \"e\" \"a\"]];list $result $calls",
    "{a b c d e} {{b d} {c e} {b c} {d c} {d e} {b a}}", "", false, "comparison-order-1082",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"b\" \"d\" \"c\" \"e\" \"a\"]];list $result $calls",
    "{e d c b a} {{b d} {c e} {d e} {d c} {b c} {e a} {d a} {c a} {b a}}", "", false,
    "comparison-order-1083",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"b\" \"d\" \"c\" \"a\" \"e\"]];list $result $calls",
    "{a b c d e} {{b d} {c a} {b a} {b c} {d c} {a e} {b e} {c e} {d e}}", "", false,
    "comparison-order-1084",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"b\" \"d\" \"c\" \"a\" \"e\"]];list $result $calls",
    "{e d c b a} {{b d} {c a} {d c} {b c} {b a} {d e}}", "", false, "comparison-order-1085",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"b\" \"d\" \"c\" \"a\" \"e\"]];list $result $calls",
    "{a b c d e} {{b d} {c a} {b a} {b c} {d c} {a e} {b e} {c e} {d e}}", "", false,
    "comparison-order-1086",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"b\" \"d\" \"c\" \"a\" \"e\"]];list $result $calls",
    "{e d c b a} {{b d} {c a} {d c} {b c} {b a} {d e}}", "", false, "comparison-order-1087",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"b\" \"d\" \"a\" \"e\" \"c\"]];list $result $calls",
    "{a b c d e} {{b d} {a e} {b a} {b e} {d e} {a c} {b c} {d c}}", "", false, "comparison-order-1088",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"b\" \"d\" \"a\" \"e\" \"c\"]];list $result $calls",
    "{e d c b a} {{b d} {a e} {d e} {d a} {b a} {e c} {d c} {b c}}", "", false, "comparison-order-1089",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"b\" \"d\" \"a\" \"e\" \"c\"]];list $result $calls",
    "{a b c d e} {{b d} {a e} {b a} {b e} {d e} {a c} {b c} {d c}}", "", false, "comparison-order-1090",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"b\" \"d\" \"a\" \"e\" \"c\"]];list $result $calls",
    "{e d c b a} {{b d} {a e} {d e} {d a} {b a} {e c} {d c} {b c}}", "", false, "comparison-order-1091",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"b\" \"d\" \"a\" \"c\" \"e\"]];list $result $calls",
    "{a b c d e} {{b d} {a c} {b a} {b c} {d c} {a e} {b e} {c e} {d e}}", "", false,
    "comparison-order-1092",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"b\" \"d\" \"a\" \"c\" \"e\"]];list $result $calls",
    "{e d c b a} {{b d} {a c} {d c} {b c} {b a} {d e}}", "", false, "comparison-order-1093",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"b\" \"d\" \"a\" \"c\" \"e\"]];list $result $calls",
    "{a b c d e} {{b d} {a c} {b a} {b c} {d c} {a e} {b e} {c e} {d e}}", "", false,
    "comparison-order-1094",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"b\" \"d\" \"a\" \"c\" \"e\"]];list $result $calls",
    "{e d c b a} {{b d} {a c} {d c} {b c} {b a} {d e}}", "", false, "comparison-order-1095",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"b\" \"c\" \"e\" \"d\" \"a\"]];list $result $calls",
    "{a b c d e} {{b c} {e d} {b d} {c d} {b a}}", "", false, "comparison-order-1096",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"b\" \"c\" \"e\" \"d\" \"a\"]];list $result $calls",
    "{e d c b a} {{b c} {e d} {c e} {c d} {e a} {d a} {c a} {b a}}", "", false, "comparison-order-1097",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"b\" \"c\" \"e\" \"d\" \"a\"]];list $result $calls",
    "{a b c d e} {{b c} {e d} {b d} {c d} {b a}}", "", false, "comparison-order-1098",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"b\" \"c\" \"e\" \"d\" \"a\"]];list $result $calls",
    "{e d c b a} {{b c} {e d} {c e} {c d} {e a} {d a} {c a} {b a}}", "", false, "comparison-order-1099",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"b\" \"c\" \"e\" \"a\" \"d\"]];list $result $calls",
    "{a b c d e} {{b c} {e a} {b a} {b e} {c e} {a d} {b d} {c d} {e d}}", "", false,
    "comparison-order-1100",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"b\" \"c\" \"e\" \"a\" \"d\"]];list $result $calls",
    "{e d c b a} {{b c} {e a} {c e} {c a} {b a} {e d} {c d}}", "", false, "comparison-order-1101",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"b\" \"c\" \"e\" \"a\" \"d\"]];list $result $calls",
    "{a b c d e} {{b c} {e a} {b a} {b e} {c e} {a d} {b d} {c d} {e d}}", "", false,
    "comparison-order-1102",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"b\" \"c\" \"e\" \"a\" \"d\"]];list $result $calls",
    "{e d c b a} {{b c} {e a} {c e} {c a} {b a} {e d} {c d}}", "", false, "comparison-order-1103",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"b\" \"c\" \"d\" \"e\" \"a\"]];list $result $calls",
    "{a b c d e} {{b c} {d e} {b d} {c d} {b a}}", "", false, "comparison-order-1104",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"b\" \"c\" \"d\" \"e\" \"a\"]];list $result $calls",
    "{e d c b a} {{b c} {d e} {c e} {c d} {e a} {d a} {c a} {b a}}", "", false, "comparison-order-1105",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"b\" \"c\" \"d\" \"e\" \"a\"]];list $result $calls",
    "{a b c d e} {{b c} {d e} {b d} {c d} {b a}}", "", false, "comparison-order-1106",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"b\" \"c\" \"d\" \"e\" \"a\"]];list $result $calls",
    "{e d c b a} {{b c} {d e} {c e} {c d} {e a} {d a} {c a} {b a}}", "", false, "comparison-order-1107",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"b\" \"c\" \"d\" \"a\" \"e\"]];list $result $calls",
    "{a b c d e} {{b c} {d a} {b a} {b d} {c d} {a e} {b e} {c e} {d e}}", "", false,
    "comparison-order-1108",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"b\" \"c\" \"d\" \"a\" \"e\"]];list $result $calls",
    "{e d c b a} {{b c} {d a} {c d} {c a} {b a} {d e}}", "", false, "comparison-order-1109",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"b\" \"c\" \"d\" \"a\" \"e\"]];list $result $calls",
    "{a b c d e} {{b c} {d a} {b a} {b d} {c d} {a e} {b e} {c e} {d e}}", "", false,
    "comparison-order-1110",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"b\" \"c\" \"d\" \"a\" \"e\"]];list $result $calls",
    "{e d c b a} {{b c} {d a} {c d} {c a} {b a} {d e}}", "", false, "comparison-order-1111",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"b\" \"c\" \"a\" \"e\" \"d\"]];list $result $calls",
    "{a b c d e} {{b c} {a e} {b a} {b e} {c e} {a d} {b d} {c d} {e d}}", "", false,
    "comparison-order-1112",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"b\" \"c\" \"a\" \"e\" \"d\"]];list $result $calls",
    "{e d c b a} {{b c} {a e} {c e} {c a} {b a} {e d} {c d}}", "", false, "comparison-order-1113",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"b\" \"c\" \"a\" \"e\" \"d\"]];list $result $calls",
    "{a b c d e} {{b c} {a e} {b a} {b e} {c e} {a d} {b d} {c d} {e d}}", "", false,
    "comparison-order-1114",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"b\" \"c\" \"a\" \"e\" \"d\"]];list $result $calls",
    "{e d c b a} {{b c} {a e} {c e} {c a} {b a} {e d} {c d}}", "", false, "comparison-order-1115",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"b\" \"c\" \"a\" \"d\" \"e\"]];list $result $calls",
    "{a b c d e} {{b c} {a d} {b a} {b d} {c d} {a e} {b e} {c e} {d e}}", "", false,
    "comparison-order-1116",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"b\" \"c\" \"a\" \"d\" \"e\"]];list $result $calls",
    "{e d c b a} {{b c} {a d} {c d} {c a} {b a} {d e}}", "", false, "comparison-order-1117",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"b\" \"c\" \"a\" \"d\" \"e\"]];list $result $calls",
    "{a b c d e} {{b c} {a d} {b a} {b d} {c d} {a e} {b e} {c e} {d e}}", "", false,
    "comparison-order-1118",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"b\" \"c\" \"a\" \"d\" \"e\"]];list $result $calls",
    "{e d c b a} {{b c} {a d} {c d} {c a} {b a} {d e}}", "", false, "comparison-order-1119",
  )
}

///|
test "Tcl sort cases 1121 through 1160" {
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"b\" \"a\" \"e\" \"d\" \"c\"]];list $result $calls",
    "{a b c d e} {{b a} {e d} {a d} {b d} {a c} {b c} {d c}}", "", false, "comparison-order-1120",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"b\" \"a\" \"e\" \"d\" \"c\"]];list $result $calls",
    "{e d c b a} {{b a} {e d} {b e} {b d} {e c} {d c} {b c}}", "", false, "comparison-order-1121",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"b\" \"a\" \"e\" \"d\" \"c\"]];list $result $calls",
    "{a b c d e} {{b a} {e d} {a d} {b d} {a c} {b c} {d c}}", "", false, "comparison-order-1122",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"b\" \"a\" \"e\" \"d\" \"c\"]];list $result $calls",
    "{e d c b a} {{b a} {e d} {b e} {b d} {e c} {d c} {b c}}", "", false, "comparison-order-1123",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"b\" \"a\" \"e\" \"c\" \"d\"]];list $result $calls",
    "{a b c d e} {{b a} {e c} {a c} {b c} {a d} {b d} {c d} {e d}}", "", false, "comparison-order-1124",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"b\" \"a\" \"e\" \"c\" \"d\"]];list $result $calls",
    "{e d c b a} {{b a} {e c} {b e} {b c} {e d} {c d}}", "", false, "comparison-order-1125",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"b\" \"a\" \"e\" \"c\" \"d\"]];list $result $calls",
    "{a b c d e} {{b a} {e c} {a c} {b c} {a d} {b d} {c d} {e d}}", "", false, "comparison-order-1126",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"b\" \"a\" \"e\" \"c\" \"d\"]];list $result $calls",
    "{e d c b a} {{b a} {e c} {b e} {b c} {e d} {c d}}", "", false, "comparison-order-1127",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"b\" \"a\" \"d\" \"e\" \"c\"]];list $result $calls",
    "{a b c d e} {{b a} {d e} {a d} {b d} {a c} {b c} {d c}}", "", false, "comparison-order-1128",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"b\" \"a\" \"d\" \"e\" \"c\"]];list $result $calls",
    "{e d c b a} {{b a} {d e} {b e} {b d} {e c} {d c} {b c}}", "", false, "comparison-order-1129",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"b\" \"a\" \"d\" \"e\" \"c\"]];list $result $calls",
    "{a b c d e} {{b a} {d e} {a d} {b d} {a c} {b c} {d c}}", "", false, "comparison-order-1130",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"b\" \"a\" \"d\" \"e\" \"c\"]];list $result $calls",
    "{e d c b a} {{b a} {d e} {b e} {b d} {e c} {d c} {b c}}", "", false, "comparison-order-1131",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"b\" \"a\" \"d\" \"c\" \"e\"]];list $result $calls",
    "{a b c d e} {{b a} {d c} {a c} {b c} {a e} {b e} {c e} {d e}}", "", false, "comparison-order-1132",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"b\" \"a\" \"d\" \"c\" \"e\"]];list $result $calls",
    "{e d c b a} {{b a} {d c} {b d} {b c} {d e}}", "", false, "comparison-order-1133",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"b\" \"a\" \"d\" \"c\" \"e\"]];list $result $calls",
    "{a b c d e} {{b a} {d c} {a c} {b c} {a e} {b e} {c e} {d e}}", "", false, "comparison-order-1134",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"b\" \"a\" \"d\" \"c\" \"e\"]];list $result $calls",
    "{e d c b a} {{b a} {d c} {b d} {b c} {d e}}", "", false, "comparison-order-1135",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"b\" \"a\" \"c\" \"e\" \"d\"]];list $result $calls",
    "{a b c d e} {{b a} {c e} {a c} {b c} {a d} {b d} {c d} {e d}}", "", false, "comparison-order-1136",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"b\" \"a\" \"c\" \"e\" \"d\"]];list $result $calls",
    "{e d c b a} {{b a} {c e} {b e} {b c} {e d} {c d}}", "", false, "comparison-order-1137",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"b\" \"a\" \"c\" \"e\" \"d\"]];list $result $calls",
    "{a b c d e} {{b a} {c e} {a c} {b c} {a d} {b d} {c d} {e d}}", "", false, "comparison-order-1138",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"b\" \"a\" \"c\" \"e\" \"d\"]];list $result $calls",
    "{e d c b a} {{b a} {c e} {b e} {b c} {e d} {c d}}", "", false, "comparison-order-1139",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"b\" \"a\" \"c\" \"d\" \"e\"]];list $result $calls",
    "{a b c d e} {{b a} {c d} {a c} {b c} {a e} {b e} {c e} {d e}}", "", false, "comparison-order-1140",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"b\" \"a\" \"c\" \"d\" \"e\"]];list $result $calls",
    "{e d c b a} {{b a} {c d} {b d} {b c} {d e}}", "", false, "comparison-order-1141",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"b\" \"a\" \"c\" \"d\" \"e\"]];list $result $calls",
    "{a b c d e} {{b a} {c d} {a c} {b c} {a e} {b e} {c e} {d e}}", "", false, "comparison-order-1142",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"b\" \"a\" \"c\" \"d\" \"e\"]];list $result $calls",
    "{e d c b a} {{b a} {c d} {b d} {b c} {d e}}", "", false, "comparison-order-1143",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"a\" \"e\" \"d\" \"c\" \"b\"]];list $result $calls",
    "{a b c d e} {{a e} {d c} {a c} {e c} {e d} {a b} {c b}}", "", false, "comparison-order-1144",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"a\" \"e\" \"d\" \"c\" \"b\"]];list $result $calls",
    "{e d c b a} {{a e} {d c} {e d} {a d} {a c} {e b} {d b} {c b} {a b}}", "", false,
    "comparison-order-1145",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"a\" \"e\" \"d\" \"c\" \"b\"]];list $result $calls",
    "{a b c d e} {{a e} {d c} {a c} {e c} {e d} {a b} {c b}}", "", false, "comparison-order-1146",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"a\" \"e\" \"d\" \"c\" \"b\"]];list $result $calls",
    "{e d c b a} {{a e} {d c} {e d} {a d} {a c} {e b} {d b} {c b} {a b}}", "", false,
    "comparison-order-1147",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"a\" \"e\" \"d\" \"b\" \"c\"]];list $result $calls",
    "{a b c d e} {{a e} {d b} {a b} {e b} {e d} {a c} {b c} {d c}}", "", false, "comparison-order-1148",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"a\" \"e\" \"d\" \"b\" \"c\"]];list $result $calls",
    "{e d c b a} {{a e} {d b} {e d} {a d} {a b} {e c} {d c} {b c}}", "", false, "comparison-order-1149",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"a\" \"e\" \"d\" \"b\" \"c\"]];list $result $calls",
    "{a b c d e} {{a e} {d b} {a b} {e b} {e d} {a c} {b c} {d c}}", "", false, "comparison-order-1150",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"a\" \"e\" \"d\" \"b\" \"c\"]];list $result $calls",
    "{e d c b a} {{a e} {d b} {e d} {a d} {a b} {e c} {d c} {b c}}", "", false, "comparison-order-1151",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"a\" \"e\" \"c\" \"d\" \"b\"]];list $result $calls",
    "{a b c d e} {{a e} {c d} {a c} {e c} {e d} {a b} {c b}}", "", false, "comparison-order-1152",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"a\" \"e\" \"c\" \"d\" \"b\"]];list $result $calls",
    "{e d c b a} {{a e} {c d} {e d} {a d} {a c} {e b} {d b} {c b} {a b}}", "", false,
    "comparison-order-1153",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"a\" \"e\" \"c\" \"d\" \"b\"]];list $result $calls",
    "{a b c d e} {{a e} {c d} {a c} {e c} {e d} {a b} {c b}}", "", false, "comparison-order-1154",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"a\" \"e\" \"c\" \"d\" \"b\"]];list $result $calls",
    "{e d c b a} {{a e} {c d} {e d} {a d} {a c} {e b} {d b} {c b} {a b}}", "", false,
    "comparison-order-1155",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"a\" \"e\" \"c\" \"b\" \"d\"]];list $result $calls",
    "{a b c d e} {{a e} {c b} {a b} {e b} {e c} {a d} {b d} {c d} {e d}}", "", false,
    "comparison-order-1156",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"a\" \"e\" \"c\" \"b\" \"d\"]];list $result $calls",
    "{e d c b a} {{a e} {c b} {e c} {a c} {a b} {e d} {c d}}", "", false, "comparison-order-1157",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"a\" \"e\" \"c\" \"b\" \"d\"]];list $result $calls",
    "{a b c d e} {{a e} {c b} {a b} {e b} {e c} {a d} {b d} {c d} {e d}}", "", false,
    "comparison-order-1158",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"a\" \"e\" \"c\" \"b\" \"d\"]];list $result $calls",
    "{e d c b a} {{a e} {c b} {e c} {a c} {a b} {e d} {c d}}", "", false, "comparison-order-1159",
  )
}

///|
test "Tcl sort cases 1161 through 1200" {
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"a\" \"e\" \"b\" \"d\" \"c\"]];list $result $calls",
    "{a b c d e} {{a e} {b d} {a b} {e b} {e d} {a c} {b c} {d c}}", "", false, "comparison-order-1160",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"a\" \"e\" \"b\" \"d\" \"c\"]];list $result $calls",
    "{e d c b a} {{a e} {b d} {e d} {a d} {a b} {e c} {d c} {b c}}", "", false, "comparison-order-1161",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"a\" \"e\" \"b\" \"d\" \"c\"]];list $result $calls",
    "{a b c d e} {{a e} {b d} {a b} {e b} {e d} {a c} {b c} {d c}}", "", false, "comparison-order-1162",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"a\" \"e\" \"b\" \"d\" \"c\"]];list $result $calls",
    "{e d c b a} {{a e} {b d} {e d} {a d} {a b} {e c} {d c} {b c}}", "", false, "comparison-order-1163",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"a\" \"e\" \"b\" \"c\" \"d\"]];list $result $calls",
    "{a b c d e} {{a e} {b c} {a b} {e b} {e c} {a d} {b d} {c d} {e d}}", "", false,
    "comparison-order-1164",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"a\" \"e\" \"b\" \"c\" \"d\"]];list $result $calls",
    "{e d c b a} {{a e} {b c} {e c} {a c} {a b} {e d} {c d}}", "", false, "comparison-order-1165",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"a\" \"e\" \"b\" \"c\" \"d\"]];list $result $calls",
    "{a b c d e} {{a e} {b c} {a b} {e b} {e c} {a d} {b d} {c d} {e d}}", "", false,
    "comparison-order-1166",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"a\" \"e\" \"b\" \"c\" \"d\"]];list $result $calls",
    "{e d c b a} {{a e} {b c} {e c} {a c} {a b} {e d} {c d}}", "", false, "comparison-order-1167",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"a\" \"d\" \"e\" \"c\" \"b\"]];list $result $calls",
    "{a b c d e} {{a d} {e c} {a c} {d c} {d e} {a b} {c b}}", "", false, "comparison-order-1168",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"a\" \"d\" \"e\" \"c\" \"b\"]];list $result $calls",
    "{e d c b a} {{a d} {e c} {d e} {d c} {a c} {e b} {d b} {c b} {a b}}", "", false,
    "comparison-order-1169",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"a\" \"d\" \"e\" \"c\" \"b\"]];list $result $calls",
    "{a b c d e} {{a d} {e c} {a c} {d c} {d e} {a b} {c b}}", "", false, "comparison-order-1170",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"a\" \"d\" \"e\" \"c\" \"b\"]];list $result $calls",
    "{e d c b a} {{a d} {e c} {d e} {d c} {a c} {e b} {d b} {c b} {a b}}", "", false,
    "comparison-order-1171",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"a\" \"d\" \"e\" \"b\" \"c\"]];list $result $calls",
    "{a b c d e} {{a d} {e b} {a b} {d b} {d e} {a c} {b c} {d c}}", "", false, "comparison-order-1172",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"a\" \"d\" \"e\" \"b\" \"c\"]];list $result $calls",
    "{e d c b a} {{a d} {e b} {d e} {d b} {a b} {e c} {d c} {b c}}", "", false, "comparison-order-1173",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"a\" \"d\" \"e\" \"b\" \"c\"]];list $result $calls",
    "{a b c d e} {{a d} {e b} {a b} {d b} {d e} {a c} {b c} {d c}}", "", false, "comparison-order-1174",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"a\" \"d\" \"e\" \"b\" \"c\"]];list $result $calls",
    "{e d c b a} {{a d} {e b} {d e} {d b} {a b} {e c} {d c} {b c}}", "", false, "comparison-order-1175",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"a\" \"d\" \"c\" \"e\" \"b\"]];list $result $calls",
    "{a b c d e} {{a d} {c e} {a c} {d c} {d e} {a b} {c b}}", "", false, "comparison-order-1176",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"a\" \"d\" \"c\" \"e\" \"b\"]];list $result $calls",
    "{e d c b a} {{a d} {c e} {d e} {d c} {a c} {e b} {d b} {c b} {a b}}", "", false,
    "comparison-order-1177",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"a\" \"d\" \"c\" \"e\" \"b\"]];list $result $calls",
    "{a b c d e} {{a d} {c e} {a c} {d c} {d e} {a b} {c b}}", "", false, "comparison-order-1178",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"a\" \"d\" \"c\" \"e\" \"b\"]];list $result $calls",
    "{e d c b a} {{a d} {c e} {d e} {d c} {a c} {e b} {d b} {c b} {a b}}", "", false,
    "comparison-order-1179",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"a\" \"d\" \"c\" \"b\" \"e\"]];list $result $calls",
    "{a b c d e} {{a d} {c b} {a b} {d b} {d c} {a e} {b e} {c e} {d e}}", "", false,
    "comparison-order-1180",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"a\" \"d\" \"c\" \"b\" \"e\"]];list $result $calls",
    "{e d c b a} {{a d} {c b} {d c} {a c} {a b} {d e}}", "", false, "comparison-order-1181",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"a\" \"d\" \"c\" \"b\" \"e\"]];list $result $calls",
    "{a b c d e} {{a d} {c b} {a b} {d b} {d c} {a e} {b e} {c e} {d e}}", "", false,
    "comparison-order-1182",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"a\" \"d\" \"c\" \"b\" \"e\"]];list $result $calls",
    "{e d c b a} {{a d} {c b} {d c} {a c} {a b} {d e}}", "", false, "comparison-order-1183",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"a\" \"d\" \"b\" \"e\" \"c\"]];list $result $calls",
    "{a b c d e} {{a d} {b e} {a b} {d b} {d e} {a c} {b c} {d c}}", "", false, "comparison-order-1184",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"a\" \"d\" \"b\" \"e\" \"c\"]];list $result $calls",
    "{e d c b a} {{a d} {b e} {d e} {d b} {a b} {e c} {d c} {b c}}", "", false, "comparison-order-1185",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"a\" \"d\" \"b\" \"e\" \"c\"]];list $result $calls",
    "{a b c d e} {{a d} {b e} {a b} {d b} {d e} {a c} {b c} {d c}}", "", false, "comparison-order-1186",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"a\" \"d\" \"b\" \"e\" \"c\"]];list $result $calls",
    "{e d c b a} {{a d} {b e} {d e} {d b} {a b} {e c} {d c} {b c}}", "", false, "comparison-order-1187",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"a\" \"d\" \"b\" \"c\" \"e\"]];list $result $calls",
    "{a b c d e} {{a d} {b c} {a b} {d b} {d c} {a e} {b e} {c e} {d e}}", "", false,
    "comparison-order-1188",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"a\" \"d\" \"b\" \"c\" \"e\"]];list $result $calls",
    "{e d c b a} {{a d} {b c} {d c} {a c} {a b} {d e}}", "", false, "comparison-order-1189",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"a\" \"d\" \"b\" \"c\" \"e\"]];list $result $calls",
    "{a b c d e} {{a d} {b c} {a b} {d b} {d c} {a e} {b e} {c e} {d e}}", "", false,
    "comparison-order-1190",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"a\" \"d\" \"b\" \"c\" \"e\"]];list $result $calls",
    "{e d c b a} {{a d} {b c} {d c} {a c} {a b} {d e}}", "", false, "comparison-order-1191",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"a\" \"c\" \"e\" \"d\" \"b\"]];list $result $calls",
    "{a b c d e} {{a c} {e d} {a d} {c d} {a b} {c b}}", "", false, "comparison-order-1192",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"a\" \"c\" \"e\" \"d\" \"b\"]];list $result $calls",
    "{e d c b a} {{a c} {e d} {c e} {c d} {e b} {d b} {c b} {a b}}", "", false, "comparison-order-1193",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"a\" \"c\" \"e\" \"d\" \"b\"]];list $result $calls",
    "{a b c d e} {{a c} {e d} {a d} {c d} {a b} {c b}}", "", false, "comparison-order-1194",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"a\" \"c\" \"e\" \"d\" \"b\"]];list $result $calls",
    "{e d c b a} {{a c} {e d} {c e} {c d} {e b} {d b} {c b} {a b}}", "", false, "comparison-order-1195",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"a\" \"c\" \"e\" \"b\" \"d\"]];list $result $calls",
    "{a b c d e} {{a c} {e b} {a b} {c b} {c e} {a d} {b d} {c d} {e d}}", "", false,
    "comparison-order-1196",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"a\" \"c\" \"e\" \"b\" \"d\"]];list $result $calls",
    "{e d c b a} {{a c} {e b} {c e} {c b} {a b} {e d} {c d}}", "", false, "comparison-order-1197",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"a\" \"c\" \"e\" \"b\" \"d\"]];list $result $calls",
    "{a b c d e} {{a c} {e b} {a b} {c b} {c e} {a d} {b d} {c d} {e d}}", "", false,
    "comparison-order-1198",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"a\" \"c\" \"e\" \"b\" \"d\"]];list $result $calls",
    "{e d c b a} {{a c} {e b} {c e} {c b} {a b} {e d} {c d}}", "", false, "comparison-order-1199",
  )
}

///|
test "Tcl sort cases 1201 through 1240" {
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"a\" \"c\" \"d\" \"e\" \"b\"]];list $result $calls",
    "{a b c d e} {{a c} {d e} {a d} {c d} {a b} {c b}}", "", false, "comparison-order-1200",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"a\" \"c\" \"d\" \"e\" \"b\"]];list $result $calls",
    "{e d c b a} {{a c} {d e} {c e} {c d} {e b} {d b} {c b} {a b}}", "", false, "comparison-order-1201",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"a\" \"c\" \"d\" \"e\" \"b\"]];list $result $calls",
    "{a b c d e} {{a c} {d e} {a d} {c d} {a b} {c b}}", "", false, "comparison-order-1202",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"a\" \"c\" \"d\" \"e\" \"b\"]];list $result $calls",
    "{e d c b a} {{a c} {d e} {c e} {c d} {e b} {d b} {c b} {a b}}", "", false, "comparison-order-1203",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"a\" \"c\" \"d\" \"b\" \"e\"]];list $result $calls",
    "{a b c d e} {{a c} {d b} {a b} {c b} {c d} {a e} {b e} {c e} {d e}}", "", false,
    "comparison-order-1204",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"a\" \"c\" \"d\" \"b\" \"e\"]];list $result $calls",
    "{e d c b a} {{a c} {d b} {c d} {c b} {a b} {d e}}", "", false, "comparison-order-1205",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"a\" \"c\" \"d\" \"b\" \"e\"]];list $result $calls",
    "{a b c d e} {{a c} {d b} {a b} {c b} {c d} {a e} {b e} {c e} {d e}}", "", false,
    "comparison-order-1206",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"a\" \"c\" \"d\" \"b\" \"e\"]];list $result $calls",
    "{e d c b a} {{a c} {d b} {c d} {c b} {a b} {d e}}", "", false, "comparison-order-1207",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"a\" \"c\" \"b\" \"e\" \"d\"]];list $result $calls",
    "{a b c d e} {{a c} {b e} {a b} {c b} {c e} {a d} {b d} {c d} {e d}}", "", false,
    "comparison-order-1208",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"a\" \"c\" \"b\" \"e\" \"d\"]];list $result $calls",
    "{e d c b a} {{a c} {b e} {c e} {c b} {a b} {e d} {c d}}", "", false, "comparison-order-1209",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"a\" \"c\" \"b\" \"e\" \"d\"]];list $result $calls",
    "{a b c d e} {{a c} {b e} {a b} {c b} {c e} {a d} {b d} {c d} {e d}}", "", false,
    "comparison-order-1210",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"a\" \"c\" \"b\" \"e\" \"d\"]];list $result $calls",
    "{e d c b a} {{a c} {b e} {c e} {c b} {a b} {e d} {c d}}", "", false, "comparison-order-1211",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"a\" \"c\" \"b\" \"d\" \"e\"]];list $result $calls",
    "{a b c d e} {{a c} {b d} {a b} {c b} {c d} {a e} {b e} {c e} {d e}}", "", false,
    "comparison-order-1212",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"a\" \"c\" \"b\" \"d\" \"e\"]];list $result $calls",
    "{e d c b a} {{a c} {b d} {c d} {c b} {a b} {d e}}", "", false, "comparison-order-1213",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"a\" \"c\" \"b\" \"d\" \"e\"]];list $result $calls",
    "{a b c d e} {{a c} {b d} {a b} {c b} {c d} {a e} {b e} {c e} {d e}}", "", false,
    "comparison-order-1214",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"a\" \"c\" \"b\" \"d\" \"e\"]];list $result $calls",
    "{e d c b a} {{a c} {b d} {c d} {c b} {a b} {d e}}", "", false, "comparison-order-1215",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"a\" \"b\" \"e\" \"d\" \"c\"]];list $result $calls",
    "{a b c d e} {{a b} {e d} {a d} {b d} {a c} {b c} {d c}}", "", false, "comparison-order-1216",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"a\" \"b\" \"e\" \"d\" \"c\"]];list $result $calls",
    "{e d c b a} {{a b} {e d} {b e} {b d} {e c} {d c} {b c}}", "", false, "comparison-order-1217",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"a\" \"b\" \"e\" \"d\" \"c\"]];list $result $calls",
    "{a b c d e} {{a b} {e d} {a d} {b d} {a c} {b c} {d c}}", "", false, "comparison-order-1218",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"a\" \"b\" \"e\" \"d\" \"c\"]];list $result $calls",
    "{e d c b a} {{a b} {e d} {b e} {b d} {e c} {d c} {b c}}", "", false, "comparison-order-1219",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"a\" \"b\" \"e\" \"c\" \"d\"]];list $result $calls",
    "{a b c d e} {{a b} {e c} {a c} {b c} {a d} {b d} {c d} {e d}}", "", false, "comparison-order-1220",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"a\" \"b\" \"e\" \"c\" \"d\"]];list $result $calls",
    "{e d c b a} {{a b} {e c} {b e} {b c} {e d} {c d}}", "", false, "comparison-order-1221",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"a\" \"b\" \"e\" \"c\" \"d\"]];list $result $calls",
    "{a b c d e} {{a b} {e c} {a c} {b c} {a d} {b d} {c d} {e d}}", "", false, "comparison-order-1222",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"a\" \"b\" \"e\" \"c\" \"d\"]];list $result $calls",
    "{e d c b a} {{a b} {e c} {b e} {b c} {e d} {c d}}", "", false, "comparison-order-1223",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"a\" \"b\" \"d\" \"e\" \"c\"]];list $result $calls",
    "{a b c d e} {{a b} {d e} {a d} {b d} {a c} {b c} {d c}}", "", false, "comparison-order-1224",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"a\" \"b\" \"d\" \"e\" \"c\"]];list $result $calls",
    "{e d c b a} {{a b} {d e} {b e} {b d} {e c} {d c} {b c}}", "", false, "comparison-order-1225",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"a\" \"b\" \"d\" \"e\" \"c\"]];list $result $calls",
    "{a b c d e} {{a b} {d e} {a d} {b d} {a c} {b c} {d c}}", "", false, "comparison-order-1226",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"a\" \"b\" \"d\" \"e\" \"c\"]];list $result $calls",
    "{e d c b a} {{a b} {d e} {b e} {b d} {e c} {d c} {b c}}", "", false, "comparison-order-1227",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"a\" \"b\" \"d\" \"c\" \"e\"]];list $result $calls",
    "{a b c d e} {{a b} {d c} {a c} {b c} {a e} {b e} {c e} {d e}}", "", false, "comparison-order-1228",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"a\" \"b\" \"d\" \"c\" \"e\"]];list $result $calls",
    "{e d c b a} {{a b} {d c} {b d} {b c} {d e}}", "", false, "comparison-order-1229",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"a\" \"b\" \"d\" \"c\" \"e\"]];list $result $calls",
    "{a b c d e} {{a b} {d c} {a c} {b c} {a e} {b e} {c e} {d e}}", "", false, "comparison-order-1230",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"a\" \"b\" \"d\" \"c\" \"e\"]];list $result $calls",
    "{e d c b a} {{a b} {d c} {b d} {b c} {d e}}", "", false, "comparison-order-1231",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"a\" \"b\" \"c\" \"e\" \"d\"]];list $result $calls",
    "{a b c d e} {{a b} {c e} {a c} {b c} {a d} {b d} {c d} {e d}}", "", false, "comparison-order-1232",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"a\" \"b\" \"c\" \"e\" \"d\"]];list $result $calls",
    "{e d c b a} {{a b} {c e} {b e} {b c} {e d} {c d}}", "", false, "comparison-order-1233",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"a\" \"b\" \"c\" \"e\" \"d\"]];list $result $calls",
    "{a b c d e} {{a b} {c e} {a c} {b c} {a d} {b d} {c d} {e d}}", "", false, "comparison-order-1234",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"a\" \"b\" \"c\" \"e\" \"d\"]];list $result $calls",
    "{e d c b a} {{a b} {c e} {b e} {b c} {e d} {c d}}", "", false, "comparison-order-1235",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp  [list \"a\" \"b\" \"c\" \"d\" \"e\"]];list $result $calls",
    "{a b c d e} {{a b} {c d} {a c} {b c} {a e} {b e} {c e} {d e}}", "", false, "comparison-order-1236",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing [list \"a\" \"b\" \"c\" \"d\" \"e\"]];list $result $calls",
    "{e d c b a} {{a b} {c d} {b d} {b c} {d e}}", "", false, "comparison-order-1237",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -unique [list \"a\" \"b\" \"c\" \"d\" \"e\"]];list $result $calls",
    "{a b c d e} {{a b} {c d} {a c} {b c} {a e} {b e} {c e} {d e}}", "", false, "comparison-order-1238",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];string compare $a $b};set calls {};set result [lsort -command cmp -decreasing -unique [list \"a\" \"b\" \"c\" \"d\" \"e\"]];list $result $calls",
    "{e d c b a} {{a b} {c d} {b d} {b c} {d e}}", "", false, "comparison-order-1239",
  )
}

///|
test "Tcl sort cases 1241 through 1280" {
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return 0};set calls {};set result [lsort -command cmp  [list \"a\" \"b\" \"a\" \"c\" \"a\"]];list $result $calls",
    "{a b a c a} {{a b} {a c} {a a} {b a} {a a} {b a} {a a} {c a}}", "", false, "custom-order-1240",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return -1};set calls {};set result [lsort -command cmp  [list \"a\" \"b\" \"a\" \"c\" \"a\"]];list $result $calls",
    "{a b a c a} {{a b} {a c} {a a} {b a} {a a} {b a} {a a} {c a}}", "", false, "custom-order-1241",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return 1};set calls {};set result [lsort -command cmp  [list \"a\" \"b\" \"a\" \"c\" \"a\"]];list $result $calls",
    "{a c a b a} {{a b} {a c} {b c} {b a} {c a}}", "", false, "custom-order-1242",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return -2147483648};set calls {};set result [lsort -command cmp  [list \"a\" \"b\" \"a\" \"c\" \"a\"]];list $result $calls",
    "{a b a c a} {{a b} {a c} {a a} {b a} {a a} {b a} {a a} {c a}}", "", false, "custom-order-1243",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];expr {[string length $a]-[string length $b]}};set calls {};set result [lsort -command cmp  [list \"a\" \"b\" \"a\" \"c\" \"a\"]];list $result $calls",
    "{a b a c a} {{a b} {a c} {a a} {b a} {a a} {b a} {a a} {c a}}", "", false, "custom-order-1244",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return 0};set calls {};set result [lsort -command cmp -unique [list \"a\" \"b\" \"a\" \"c\" \"a\"]];list $result $calls",
    "a {{a b} {a c} {b c} {c a}}", "", false, "custom-order-1245",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return -1};set calls {};set result [lsort -command cmp -unique [list \"a\" \"b\" \"a\" \"c\" \"a\"]];list $result $calls",
    "{a b a c a} {{a b} {a c} {a a} {b a} {a a} {b a} {a a} {c a}}", "", false, "custom-order-1246",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return 1};set calls {};set result [lsort -command cmp -unique [list \"a\" \"b\" \"a\" \"c\" \"a\"]];list $result $calls",
    "{a c a b a} {{a b} {a c} {b c} {b a} {c a}}", "", false, "custom-order-1247",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return -2147483648};set calls {};set result [lsort -command cmp -unique [list \"a\" \"b\" \"a\" \"c\" \"a\"]];list $result $calls",
    "{a b a c a} {{a b} {a c} {a a} {b a} {a a} {b a} {a a} {c a}}", "", false, "custom-order-1248",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];expr {[string length $a]-[string length $b]}};set calls {};set result [lsort -command cmp -unique [list \"a\" \"b\" \"a\" \"c\" \"a\"]];list $result $calls",
    "a {{a b} {a c} {b c} {c a}}", "", false, "custom-order-1249",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return 0};set calls {};set result [lsort -command cmp -nocase [list \"a\" \"b\" \"a\" \"c\" \"a\"]];list $result $calls",
    "{a b a c a} {{a b} {a c} {a a} {b a} {a a} {b a} {a a} {c a}}", "", false, "custom-order-1250",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return -1};set calls {};set result [lsort -command cmp -nocase [list \"a\" \"b\" \"a\" \"c\" \"a\"]];list $result $calls",
    "{a b a c a} {{a b} {a c} {a a} {b a} {a a} {b a} {a a} {c a}}", "", false, "custom-order-1251",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return 1};set calls {};set result [lsort -command cmp -nocase [list \"a\" \"b\" \"a\" \"c\" \"a\"]];list $result $calls",
    "{a c a b a} {{a b} {a c} {b c} {b a} {c a}}", "", false, "custom-order-1252",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return -2147483648};set calls {};set result [lsort -command cmp -nocase [list \"a\" \"b\" \"a\" \"c\" \"a\"]];list $result $calls",
    "{a b a c a} {{a b} {a c} {a a} {b a} {a a} {b a} {a a} {c a}}", "", false, "custom-order-1253",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];expr {[string length $a]-[string length $b]}};set calls {};set result [lsort -command cmp -nocase [list \"a\" \"b\" \"a\" \"c\" \"a\"]];list $result $calls",
    "{a b a c a} {{a b} {a c} {a a} {b a} {a a} {b a} {a a} {c a}}", "", false, "custom-order-1254",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return 0};set calls {};set result [lsort -command cmp -indices [list \"a\" \"b\" \"a\" \"c\" \"a\"]];list $result $calls",
    "{0 1 2 3 4} {{a b} {a c} {a a} {b a} {a a} {b a} {a a} {c a}}", "", false, "custom-order-1255",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return -1};set calls {};set result [lsort -command cmp -indices [list \"a\" \"b\" \"a\" \"c\" \"a\"]];list $result $calls",
    "{0 1 2 3 4} {{a b} {a c} {a a} {b a} {a a} {b a} {a a} {c a}}", "", false, "custom-order-1256",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return 1};set calls {};set result [lsort -command cmp -indices [list \"a\" \"b\" \"a\" \"c\" \"a\"]];list $result $calls",
    "{4 3 2 1 0} {{a b} {a c} {b c} {b a} {c a}}", "", false, "custom-order-1257",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return -2147483648};set calls {};set result [lsort -command cmp -indices [list \"a\" \"b\" \"a\" \"c\" \"a\"]];list $result $calls",
    "{0 1 2 3 4} {{a b} {a c} {a a} {b a} {a a} {b a} {a a} {c a}}", "", false, "custom-order-1258",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];expr {[string length $a]-[string length $b]}};set calls {};set result [lsort -command cmp -indices [list \"a\" \"b\" \"a\" \"c\" \"a\"]];list $result $calls",
    "{0 1 2 3 4} {{a b} {a c} {a a} {b a} {a a} {b a} {a a} {c a}}", "", false, "custom-order-1259",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return 0};set calls {};set result [lsort -command cmp -decreasing -unique -indices [list \"a\" \"b\" \"a\" \"c\" \"a\"]];list $result $calls",
    "4 {{a b} {a c} {b c} {c a}}", "", false, "custom-order-1260",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return -1};set calls {};set result [lsort -command cmp -decreasing -unique -indices [list \"a\" \"b\" \"a\" \"c\" \"a\"]];list $result $calls",
    "{4 3 2 1 0} {{a b} {a c} {b c} {b a} {c a}}", "", false, "custom-order-1261",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return 1};set calls {};set result [lsort -command cmp -decreasing -unique -indices [list \"a\" \"b\" \"a\" \"c\" \"a\"]];list $result $calls",
    "{0 1 2 3 4} {{a b} {a c} {a a} {b a} {a a} {b a} {a a} {c a}}", "", false, "custom-order-1262",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return -2147483648};set calls {};set result [lsort -command cmp -decreasing -unique -indices [list \"a\" \"b\" \"a\" \"c\" \"a\"]];list $result $calls",
    "{0 1 2 3 4} {{a b} {a c} {a a} {b a} {a a} {b a} {a a} {c a}}", "", false, "custom-order-1263",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];expr {[string length $a]-[string length $b]}};set calls {};set result [lsort -command cmp -decreasing -unique -indices [list \"a\" \"b\" \"a\" \"c\" \"a\"]];list $result $calls",
    "4 {{a b} {a c} {b c} {c a}}", "", false, "custom-order-1264",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return 0};set calls {};set result [lsort -command cmp  [list \"A\" \"b\" \"C\"]];list $result $calls",
    "{A b C} {{A b} {A C} {b C}}", "", false, "custom-order-1265",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return -1};set calls {};set result [lsort -command cmp  [list \"A\" \"b\" \"C\"]];list $result $calls",
    "{A b C} {{A b} {A C} {b C}}", "", false, "custom-order-1266",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return 1};set calls {};set result [lsort -command cmp  [list \"A\" \"b\" \"C\"]];list $result $calls",
    "{C b A} {{A b} {b C}}", "", false, "custom-order-1267",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return -2147483648};set calls {};set result [lsort -command cmp  [list \"A\" \"b\" \"C\"]];list $result $calls",
    "{A b C} {{A b} {A C} {b C}}", "", false, "custom-order-1268",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];expr {[string length $a]-[string length $b]}};set calls {};set result [lsort -command cmp  [list \"A\" \"b\" \"C\"]];list $result $calls",
    "{A b C} {{A b} {A C} {b C}}", "", false, "custom-order-1269",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return 0};set calls {};set result [lsort -command cmp -unique [list \"A\" \"b\" \"C\"]];list $result $calls",
    "C {{A b} {b C}}", "", false, "custom-order-1270",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return -1};set calls {};set result [lsort -command cmp -unique [list \"A\" \"b\" \"C\"]];list $result $calls",
    "{A b C} {{A b} {A C} {b C}}", "", false, "custom-order-1271",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return 1};set calls {};set result [lsort -command cmp -unique [list \"A\" \"b\" \"C\"]];list $result $calls",
    "{C b A} {{A b} {b C}}", "", false, "custom-order-1272",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return -2147483648};set calls {};set result [lsort -command cmp -unique [list \"A\" \"b\" \"C\"]];list $result $calls",
    "{A b C} {{A b} {A C} {b C}}", "", false, "custom-order-1273",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];expr {[string length $a]-[string length $b]}};set calls {};set result [lsort -command cmp -unique [list \"A\" \"b\" \"C\"]];list $result $calls",
    "C {{A b} {b C}}", "", false, "custom-order-1274",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return 0};set calls {};set result [lsort -command cmp -nocase [list \"A\" \"b\" \"C\"]];list $result $calls",
    "{A b C} {{A b} {A C} {b C}}", "", false, "custom-order-1275",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return -1};set calls {};set result [lsort -command cmp -nocase [list \"A\" \"b\" \"C\"]];list $result $calls",
    "{A b C} {{A b} {A C} {b C}}", "", false, "custom-order-1276",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return 1};set calls {};set result [lsort -command cmp -nocase [list \"A\" \"b\" \"C\"]];list $result $calls",
    "{C b A} {{A b} {b C}}", "", false, "custom-order-1277",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return -2147483648};set calls {};set result [lsort -command cmp -nocase [list \"A\" \"b\" \"C\"]];list $result $calls",
    "{A b C} {{A b} {A C} {b C}}", "", false, "custom-order-1278",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];expr {[string length $a]-[string length $b]}};set calls {};set result [lsort -command cmp -nocase [list \"A\" \"b\" \"C\"]];list $result $calls",
    "{A b C} {{A b} {A C} {b C}}", "", false, "custom-order-1279",
  )
}

///|
test "Tcl sort cases 1281 through 1320" {
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return 0};set calls {};set result [lsort -command cmp -indices [list \"A\" \"b\" \"C\"]];list $result $calls",
    "{0 1 2} {{A b} {A C} {b C}}", "", false, "custom-order-1280",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return -1};set calls {};set result [lsort -command cmp -indices [list \"A\" \"b\" \"C\"]];list $result $calls",
    "{0 1 2} {{A b} {A C} {b C}}", "", false, "custom-order-1281",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return 1};set calls {};set result [lsort -command cmp -indices [list \"A\" \"b\" \"C\"]];list $result $calls",
    "{2 1 0} {{A b} {b C}}", "", false, "custom-order-1282",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return -2147483648};set calls {};set result [lsort -command cmp -indices [list \"A\" \"b\" \"C\"]];list $result $calls",
    "{0 1 2} {{A b} {A C} {b C}}", "", false, "custom-order-1283",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];expr {[string length $a]-[string length $b]}};set calls {};set result [lsort -command cmp -indices [list \"A\" \"b\" \"C\"]];list $result $calls",
    "{0 1 2} {{A b} {A C} {b C}}", "", false, "custom-order-1284",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return 0};set calls {};set result [lsort -command cmp -decreasing -unique -indices [list \"A\" \"b\" \"C\"]];list $result $calls",
    "2 {{A b} {b C}}", "", false, "custom-order-1285",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return -1};set calls {};set result [lsort -command cmp -decreasing -unique -indices [list \"A\" \"b\" \"C\"]];list $result $calls",
    "{2 1 0} {{A b} {b C}}", "", false, "custom-order-1286",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return 1};set calls {};set result [lsort -command cmp -decreasing -unique -indices [list \"A\" \"b\" \"C\"]];list $result $calls",
    "{0 1 2} {{A b} {A C} {b C}}", "", false, "custom-order-1287",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return -2147483648};set calls {};set result [lsort -command cmp -decreasing -unique -indices [list \"A\" \"b\" \"C\"]];list $result $calls",
    "{0 1 2} {{A b} {A C} {b C}}", "", false, "custom-order-1288",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];expr {[string length $a]-[string length $b]}};set calls {};set result [lsort -command cmp -decreasing -unique -indices [list \"A\" \"b\" \"C\"]];list $result $calls",
    "2 {{A b} {b C}}", "", false, "custom-order-1289",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return 0};set calls {};set result [lsort -command cmp  [list \"x\" \"y\" \"z\" \"w\" \"v\"]];list $result $calls",
    "{x y z w v} {{x y} {z w} {x z} {y z} {x v} {y v} {z v} {w v}}", "", false, "custom-order-1290",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return -1};set calls {};set result [lsort -command cmp  [list \"x\" \"y\" \"z\" \"w\" \"v\"]];list $result $calls",
    "{x y z w v} {{x y} {z w} {x z} {y z} {x v} {y v} {z v} {w v}}", "", false, "custom-order-1291",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return 1};set calls {};set result [lsort -command cmp  [list \"x\" \"y\" \"z\" \"w\" \"v\"]];list $result $calls",
    "{v w z y x} {{x y} {z w} {y w} {y z} {w v}}", "", false, "custom-order-1292",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return -2147483648};set calls {};set result [lsort -command cmp  [list \"x\" \"y\" \"z\" \"w\" \"v\"]];list $result $calls",
    "{x y z w v} {{x y} {z w} {x z} {y z} {x v} {y v} {z v} {w v}}", "", false, "custom-order-1293",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];expr {[string length $a]-[string length $b]}};set calls {};set result [lsort -command cmp  [list \"x\" \"y\" \"z\" \"w\" \"v\"]];list $result $calls",
    "{x y z w v} {{x y} {z w} {x z} {y z} {x v} {y v} {z v} {w v}}", "", false, "custom-order-1294",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return 0};set calls {};set result [lsort -command cmp -unique [list \"x\" \"y\" \"z\" \"w\" \"v\"]];list $result $calls",
    "v {{x y} {z w} {y w} {w v}}", "", false, "custom-order-1295",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return -1};set calls {};set result [lsort -command cmp -unique [list \"x\" \"y\" \"z\" \"w\" \"v\"]];list $result $calls",
    "{x y z w v} {{x y} {z w} {x z} {y z} {x v} {y v} {z v} {w v}}", "", false, "custom-order-1296",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return 1};set calls {};set result [lsort -command cmp -unique [list \"x\" \"y\" \"z\" \"w\" \"v\"]];list $result $calls",
    "{v w z y x} {{x y} {z w} {y w} {y z} {w v}}", "", false, "custom-order-1297",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return -2147483648};set calls {};set result [lsort -command cmp -unique [list \"x\" \"y\" \"z\" \"w\" \"v\"]];list $result $calls",
    "{x y z w v} {{x y} {z w} {x z} {y z} {x v} {y v} {z v} {w v}}", "", false, "custom-order-1298",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];expr {[string length $a]-[string length $b]}};set calls {};set result [lsort -command cmp -unique [list \"x\" \"y\" \"z\" \"w\" \"v\"]];list $result $calls",
    "v {{x y} {z w} {y w} {w v}}", "", false, "custom-order-1299",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return 0};set calls {};set result [lsort -command cmp -nocase [list \"x\" \"y\" \"z\" \"w\" \"v\"]];list $result $calls",
    "{x y z w v} {{x y} {z w} {x z} {y z} {x v} {y v} {z v} {w v}}", "", false, "custom-order-1300",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return -1};set calls {};set result [lsort -command cmp -nocase [list \"x\" \"y\" \"z\" \"w\" \"v\"]];list $result $calls",
    "{x y z w v} {{x y} {z w} {x z} {y z} {x v} {y v} {z v} {w v}}", "", false, "custom-order-1301",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return 1};set calls {};set result [lsort -command cmp -nocase [list \"x\" \"y\" \"z\" \"w\" \"v\"]];list $result $calls",
    "{v w z y x} {{x y} {z w} {y w} {y z} {w v}}", "", false, "custom-order-1302",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return -2147483648};set calls {};set result [lsort -command cmp -nocase [list \"x\" \"y\" \"z\" \"w\" \"v\"]];list $result $calls",
    "{x y z w v} {{x y} {z w} {x z} {y z} {x v} {y v} {z v} {w v}}", "", false, "custom-order-1303",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];expr {[string length $a]-[string length $b]}};set calls {};set result [lsort -command cmp -nocase [list \"x\" \"y\" \"z\" \"w\" \"v\"]];list $result $calls",
    "{x y z w v} {{x y} {z w} {x z} {y z} {x v} {y v} {z v} {w v}}", "", false, "custom-order-1304",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return 0};set calls {};set result [lsort -command cmp -indices [list \"x\" \"y\" \"z\" \"w\" \"v\"]];list $result $calls",
    "{0 1 2 3 4} {{x y} {z w} {x z} {y z} {x v} {y v} {z v} {w v}}", "", false, "custom-order-1305",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return -1};set calls {};set result [lsort -command cmp -indices [list \"x\" \"y\" \"z\" \"w\" \"v\"]];list $result $calls",
    "{0 1 2 3 4} {{x y} {z w} {x z} {y z} {x v} {y v} {z v} {w v}}", "", false, "custom-order-1306",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return 1};set calls {};set result [lsort -command cmp -indices [list \"x\" \"y\" \"z\" \"w\" \"v\"]];list $result $calls",
    "{4 3 2 1 0} {{x y} {z w} {y w} {y z} {w v}}", "", false, "custom-order-1307",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return -2147483648};set calls {};set result [lsort -command cmp -indices [list \"x\" \"y\" \"z\" \"w\" \"v\"]];list $result $calls",
    "{0 1 2 3 4} {{x y} {z w} {x z} {y z} {x v} {y v} {z v} {w v}}", "", false, "custom-order-1308",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];expr {[string length $a]-[string length $b]}};set calls {};set result [lsort -command cmp -indices [list \"x\" \"y\" \"z\" \"w\" \"v\"]];list $result $calls",
    "{0 1 2 3 4} {{x y} {z w} {x z} {y z} {x v} {y v} {z v} {w v}}", "", false, "custom-order-1309",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return 0};set calls {};set result [lsort -command cmp -decreasing -unique -indices [list \"x\" \"y\" \"z\" \"w\" \"v\"]];list $result $calls",
    "4 {{x y} {z w} {y w} {w v}}", "", false, "custom-order-1310",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return -1};set calls {};set result [lsort -command cmp -decreasing -unique -indices [list \"x\" \"y\" \"z\" \"w\" \"v\"]];list $result $calls",
    "{4 3 2 1 0} {{x y} {z w} {y w} {y z} {w v}}", "", false, "custom-order-1311",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return 1};set calls {};set result [lsort -command cmp -decreasing -unique -indices [list \"x\" \"y\" \"z\" \"w\" \"v\"]];list $result $calls",
    "{0 1 2 3 4} {{x y} {z w} {x z} {y z} {x v} {y v} {z v} {w v}}", "", false, "custom-order-1312",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return -2147483648};set calls {};set result [lsort -command cmp -decreasing -unique -indices [list \"x\" \"y\" \"z\" \"w\" \"v\"]];list $result $calls",
    "{0 1 2 3 4} {{x y} {z w} {x z} {y z} {x v} {y v} {z v} {w v}}", "", false, "custom-order-1313",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];expr {[string length $a]-[string length $b]}};set calls {};set result [lsort -command cmp -decreasing -unique -indices [list \"x\" \"y\" \"z\" \"w\" \"v\"]];list $result $calls",
    "4 {{x y} {z w} {y w} {w v}}", "", false, "custom-order-1314",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return 0};set calls {};set result [lsort -command cmp  [list \"1\" \"2\" \"1\" \"3\" \"2\"]];list $result $calls",
    "{1 2 1 3 2} {{1 2} {1 3} {1 1} {2 1} {1 2} {2 2} {1 2} {3 2}}", "", false, "custom-order-1315",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return -1};set calls {};set result [lsort -command cmp  [list \"1\" \"2\" \"1\" \"3\" \"2\"]];list $result $calls",
    "{1 2 1 3 2} {{1 2} {1 3} {1 1} {2 1} {1 2} {2 2} {1 2} {3 2}}", "", false, "custom-order-1316",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return 1};set calls {};set result [lsort -command cmp  [list \"1\" \"2\" \"1\" \"3\" \"2\"]];list $result $calls",
    "{2 3 1 2 1} {{1 2} {1 3} {2 3} {2 1} {3 2}}", "", false, "custom-order-1317",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return -2147483648};set calls {};set result [lsort -command cmp  [list \"1\" \"2\" \"1\" \"3\" \"2\"]];list $result $calls",
    "{1 2 1 3 2} {{1 2} {1 3} {1 1} {2 1} {1 2} {2 2} {1 2} {3 2}}", "", false, "custom-order-1318",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];expr {[string length $a]-[string length $b]}};set calls {};set result [lsort -command cmp  [list \"1\" \"2\" \"1\" \"3\" \"2\"]];list $result $calls",
    "{1 2 1 3 2} {{1 2} {1 3} {1 1} {2 1} {1 2} {2 2} {1 2} {3 2}}", "", false, "custom-order-1319",
  )
}

///|
test "Tcl sort cases 1321 through 1360" {
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return 0};set calls {};set result [lsort -command cmp -unique [list \"1\" \"2\" \"1\" \"3\" \"2\"]];list $result $calls",
    "2 {{1 2} {1 3} {2 3} {3 2}}", "", false, "custom-order-1320",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return -1};set calls {};set result [lsort -command cmp -unique [list \"1\" \"2\" \"1\" \"3\" \"2\"]];list $result $calls",
    "{1 2 1 3 2} {{1 2} {1 3} {1 1} {2 1} {1 2} {2 2} {1 2} {3 2}}", "", false, "custom-order-1321",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return 1};set calls {};set result [lsort -command cmp -unique [list \"1\" \"2\" \"1\" \"3\" \"2\"]];list $result $calls",
    "{2 3 1 2 1} {{1 2} {1 3} {2 3} {2 1} {3 2}}", "", false, "custom-order-1322",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return -2147483648};set calls {};set result [lsort -command cmp -unique [list \"1\" \"2\" \"1\" \"3\" \"2\"]];list $result $calls",
    "{1 2 1 3 2} {{1 2} {1 3} {1 1} {2 1} {1 2} {2 2} {1 2} {3 2}}", "", false, "custom-order-1323",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];expr {[string length $a]-[string length $b]}};set calls {};set result [lsort -command cmp -unique [list \"1\" \"2\" \"1\" \"3\" \"2\"]];list $result $calls",
    "2 {{1 2} {1 3} {2 3} {3 2}}", "", false, "custom-order-1324",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return 0};set calls {};set result [lsort -command cmp -nocase [list \"1\" \"2\" \"1\" \"3\" \"2\"]];list $result $calls",
    "{1 2 1 3 2} {{1 2} {1 3} {1 1} {2 1} {1 2} {2 2} {1 2} {3 2}}", "", false, "custom-order-1325",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return -1};set calls {};set result [lsort -command cmp -nocase [list \"1\" \"2\" \"1\" \"3\" \"2\"]];list $result $calls",
    "{1 2 1 3 2} {{1 2} {1 3} {1 1} {2 1} {1 2} {2 2} {1 2} {3 2}}", "", false, "custom-order-1326",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return 1};set calls {};set result [lsort -command cmp -nocase [list \"1\" \"2\" \"1\" \"3\" \"2\"]];list $result $calls",
    "{2 3 1 2 1} {{1 2} {1 3} {2 3} {2 1} {3 2}}", "", false, "custom-order-1327",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return -2147483648};set calls {};set result [lsort -command cmp -nocase [list \"1\" \"2\" \"1\" \"3\" \"2\"]];list $result $calls",
    "{1 2 1 3 2} {{1 2} {1 3} {1 1} {2 1} {1 2} {2 2} {1 2} {3 2}}", "", false, "custom-order-1328",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];expr {[string length $a]-[string length $b]}};set calls {};set result [lsort -command cmp -nocase [list \"1\" \"2\" \"1\" \"3\" \"2\"]];list $result $calls",
    "{1 2 1 3 2} {{1 2} {1 3} {1 1} {2 1} {1 2} {2 2} {1 2} {3 2}}", "", false, "custom-order-1329",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return 0};set calls {};set result [lsort -command cmp -indices [list \"1\" \"2\" \"1\" \"3\" \"2\"]];list $result $calls",
    "{0 1 2 3 4} {{1 2} {1 3} {1 1} {2 1} {1 2} {2 2} {1 2} {3 2}}", "", false, "custom-order-1330",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return -1};set calls {};set result [lsort -command cmp -indices [list \"1\" \"2\" \"1\" \"3\" \"2\"]];list $result $calls",
    "{0 1 2 3 4} {{1 2} {1 3} {1 1} {2 1} {1 2} {2 2} {1 2} {3 2}}", "", false, "custom-order-1331",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return 1};set calls {};set result [lsort -command cmp -indices [list \"1\" \"2\" \"1\" \"3\" \"2\"]];list $result $calls",
    "{4 3 2 1 0} {{1 2} {1 3} {2 3} {2 1} {3 2}}", "", false, "custom-order-1332",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return -2147483648};set calls {};set result [lsort -command cmp -indices [list \"1\" \"2\" \"1\" \"3\" \"2\"]];list $result $calls",
    "{0 1 2 3 4} {{1 2} {1 3} {1 1} {2 1} {1 2} {2 2} {1 2} {3 2}}", "", false, "custom-order-1333",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];expr {[string length $a]-[string length $b]}};set calls {};set result [lsort -command cmp -indices [list \"1\" \"2\" \"1\" \"3\" \"2\"]];list $result $calls",
    "{0 1 2 3 4} {{1 2} {1 3} {1 1} {2 1} {1 2} {2 2} {1 2} {3 2}}", "", false, "custom-order-1334",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return 0};set calls {};set result [lsort -command cmp -decreasing -unique -indices [list \"1\" \"2\" \"1\" \"3\" \"2\"]];list $result $calls",
    "4 {{1 2} {1 3} {2 3} {3 2}}", "", false, "custom-order-1335",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return -1};set calls {};set result [lsort -command cmp -decreasing -unique -indices [list \"1\" \"2\" \"1\" \"3\" \"2\"]];list $result $calls",
    "{4 3 2 1 0} {{1 2} {1 3} {2 3} {2 1} {3 2}}", "", false, "custom-order-1336",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return 1};set calls {};set result [lsort -command cmp -decreasing -unique -indices [list \"1\" \"2\" \"1\" \"3\" \"2\"]];list $result $calls",
    "{0 1 2 3 4} {{1 2} {1 3} {1 1} {2 1} {1 2} {2 2} {1 2} {3 2}}", "", false, "custom-order-1337",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];return -2147483648};set calls {};set result [lsort -command cmp -decreasing -unique -indices [list \"1\" \"2\" \"1\" \"3\" \"2\"]];list $result $calls",
    "{0 1 2 3 4} {{1 2} {1 3} {1 1} {2 1} {1 2} {2 2} {1 2} {3 2}}", "", false, "custom-order-1338",
  )
  check_sort_case(
    "proc cmp {a b} {lappend ::calls [list $a $b];expr {[string length $a]-[string length $b]}};set calls {};set result [lsort -command cmp -decreasing -unique -indices [list \"1\" \"2\" \"1\" \"3\" \"2\"]];list $result $calls",
    "4 {{1 2} {1 3} {2 3} {3 2}}", "", false, "custom-order-1339",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {return \\\"0\\\"};lsort -command cmp  {b a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {b a} 0 {}", "", false, "comparison-result-1340",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {return \\\"0\\\"};lsort -command cmp -decreasing {b a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {b a} 0 {}", "", false, "comparison-result-1341",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {return \\\"0\\\"};lsort -command cmp -unique {b a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 a 0 {}", "", false, "comparison-result-1342",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {return \\\"-1\\\"};lsort -command cmp  {b a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {b a} 0 {}", "", false, "comparison-result-1343",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {return \\\"-1\\\"};lsort -command cmp -decreasing {b a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {a b} 0 {}", "", false, "comparison-result-1344",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {return \\\"-1\\\"};lsort -command cmp -unique {b a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {b a} 0 {}", "", false, "comparison-result-1345",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {return \\\"1\\\"};lsort -command cmp  {b a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {a b} 0 {}", "", false, "comparison-result-1346",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {return \\\"1\\\"};lsort -command cmp -decreasing {b a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {b a} 0 {}", "", false, "comparison-result-1347",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {return \\\"1\\\"};lsort -command cmp -unique {b a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {a b} 0 {}", "", false, "comparison-result-1348",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {return \\\"2147483647\\\"};lsort -command cmp  {b a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {a b} 0 {}", "", false, "comparison-result-1349",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {return \\\"2147483647\\\"};lsort -command cmp -decreasing {b a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {b a} 0 {}", "", false, "comparison-result-1350",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {return \\\"2147483647\\\"};lsort -command cmp -unique {b a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {a b} 0 {}", "", false, "comparison-result-1351",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {return \\\"2147483648\\\"};lsort -command cmp  {b a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {b a} 0 {}", "", false, "comparison-result-1352",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {return \\\"2147483648\\\"};lsort -command cmp -decreasing {b a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {b a} 0 {}", "", false, "comparison-result-1353",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {return \\\"2147483648\\\"};lsort -command cmp -unique {b a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {b a} 0 {}", "", false, "comparison-result-1354",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {return \\\"4294967295\\\"};lsort -command cmp  {b a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {b a} 0 {}", "", false, "comparison-result-1355",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {return \\\"4294967295\\\"};lsort -command cmp -decreasing {b a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {a b} 0 {}", "", false, "comparison-result-1356",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {return \\\"4294967295\\\"};lsort -command cmp -unique {b a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {b a} 0 {}", "", false, "comparison-result-1357",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {return \\\"4294967296\\\"};lsort -command cmp  {b a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {-compare command returned non-integer result} 0 {TCL OPERATION LSORT COMPARISONFAILED}",
    "", false, "comparison-result-1358",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {return \\\"4294967296\\\"};lsort -command cmp -decreasing {b a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {-compare command returned non-integer result} 0 {TCL OPERATION LSORT COMPARISONFAILED}",
    "", false, "comparison-result-1359",
  )
}

///|
test "Tcl sort cases 1361 through 1400" {
  check_sort_case(
    "set code [catch \"proc cmp {a b} {return \\\"4294967296\\\"};lsort -command cmp -unique {b a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {-compare command returned non-integer result} 0 {TCL OPERATION LSORT COMPARISONFAILED}",
    "", false, "comparison-result-1360",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {return \\\"-4294967295\\\"};lsort -command cmp  {b a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {a b} 0 {}", "", false, "comparison-result-1361",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {return \\\"-4294967295\\\"};lsort -command cmp -decreasing {b a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {b a} 0 {}", "", false, "comparison-result-1362",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {return \\\"-4294967295\\\"};lsort -command cmp -unique {b a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {a b} 0 {}", "", false, "comparison-result-1363",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {return \\\"-4294967296\\\"};lsort -command cmp  {b a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {-compare command returned non-integer result} 0 {TCL OPERATION LSORT COMPARISONFAILED}",
    "", false, "comparison-result-1364",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {return \\\"-4294967296\\\"};lsort -command cmp -decreasing {b a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {-compare command returned non-integer result} 0 {TCL OPERATION LSORT COMPARISONFAILED}",
    "", false, "comparison-result-1365",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {return \\\"-4294967296\\\"};lsort -command cmp -unique {b a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {-compare command returned non-integer result} 0 {TCL OPERATION LSORT COMPARISONFAILED}",
    "", false, "comparison-result-1366",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {return \\\"1.0\\\"};lsort -command cmp  {b a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {-compare command returned non-integer result} 0 {TCL OPERATION LSORT COMPARISONFAILED}",
    "", false, "comparison-result-1367",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {return \\\"1.0\\\"};lsort -command cmp -decreasing {b a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {-compare command returned non-integer result} 0 {TCL OPERATION LSORT COMPARISONFAILED}",
    "", false, "comparison-result-1368",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {return \\\"1.0\\\"};lsort -command cmp -unique {b a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {-compare command returned non-integer result} 0 {TCL OPERATION LSORT COMPARISONFAILED}",
    "", false, "comparison-result-1369",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {return \\\"NaN\\\"};lsort -command cmp  {b a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {-compare command returned non-integer result} 0 {TCL OPERATION LSORT COMPARISONFAILED}",
    "", false, "comparison-result-1370",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {return \\\"NaN\\\"};lsort -command cmp -decreasing {b a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {-compare command returned non-integer result} 0 {TCL OPERATION LSORT COMPARISONFAILED}",
    "", false, "comparison-result-1371",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {return \\\"NaN\\\"};lsort -command cmp -unique {b a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {-compare command returned non-integer result} 0 {TCL OPERATION LSORT COMPARISONFAILED}",
    "", false, "comparison-result-1372",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {return \\\"bad\\\"};lsort -command cmp  {b a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {-compare command returned non-integer result} 0 {TCL OPERATION LSORT COMPARISONFAILED}",
    "", false, "comparison-result-1373",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {return \\\"bad\\\"};lsort -command cmp -decreasing {b a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {-compare command returned non-integer result} 0 {TCL OPERATION LSORT COMPARISONFAILED}",
    "", false, "comparison-result-1374",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {return \\\"bad\\\"};lsort -command cmp -unique {b a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {-compare command returned non-integer result} 0 {TCL OPERATION LSORT COMPARISONFAILED}",
    "", false, "comparison-result-1375",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {return \\\" 1 \\\"};lsort -command cmp  {b a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {a b} 0 {}", "", false, "comparison-result-1376",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {return \\\" 1 \\\"};lsort -command cmp -decreasing {b a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {b a} 0 {}", "", false, "comparison-result-1377",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {return \\\" 1 \\\"};lsort -command cmp -unique {b a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {a b} 0 {}", "", false, "comparison-result-1378",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {return \\\"0x1\\\"};lsort -command cmp  {b a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {a b} 0 {}", "", false, "comparison-result-1379",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {return \\\"0x1\\\"};lsort -command cmp -decreasing {b a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {b a} 0 {}", "", false, "comparison-result-1380",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {return \\\"0x1\\\"};lsort -command cmp -unique {b a}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {a b} 0 {}", "", false, "comparison-result-1381",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;error FIRST};set calls 0;lsort -command cmp  {a b}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 FIRST 0 1 NONE", "", false, "comparison-completion-1382",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;error FIRST};set calls 0;lsort -command cmp -index 1 {a b}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {element 1 missing from sublist \"a\"} 0 0 {TCL OPERATION LSORT INDEXFAILED}",
    "", false, "comparison-completion-1383",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;error FIRST};set calls 0;lsort -command cmp  {a b c d e}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 FIRST 0 1 NONE", "", false, "comparison-completion-1384",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;error FIRST};set calls 0;lsort -command cmp -index 1 {a b c d e}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {element 1 missing from sublist \"a\"} 0 0 {TCL OPERATION LSORT INDEXFAILED}",
    "", false, "comparison-completion-1385",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;error FIRST};set calls 0;lsort -command cmp  {{a x} {b y} z}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 FIRST 0 1 NONE", "", false, "comparison-completion-1386",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;error FIRST};set calls 0;lsort -command cmp -index 1 {{a x} {b y} z}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {element 1 missing from sublist \"z\"} 0 1 {TCL OPERATION LSORT INDEXFAILED}",
    "", false, "comparison-completion-1387",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;error FIRST};set calls 0;lsort -command cmp  {{a x} {b y} {c z} q}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 FIRST 0 1 NONE", "", false, "comparison-completion-1388",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;error FIRST};set calls 0;lsort -command cmp -index 1 {{a x} {b y} {c z} q}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 FIRST 0 1 NONE", "", false, "comparison-completion-1389",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;error FIRST};set calls 0;lsort -command cmp  {{a x} {b y} {c z} {d q} r}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 FIRST 0 1 NONE", "", false, "comparison-completion-1390",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;error FIRST};set calls 0;lsort -command cmp -index 1 {{a x} {b y} {c z} {d q} r}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 FIRST 0 1 NONE", "", false, "comparison-completion-1391",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -code break FIRST};set calls 0;lsort -command cmp  {a b}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "3 FIRST 0 1 NONE", "", false, "comparison-completion-1392",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -code break FIRST};set calls 0;lsort -command cmp -index 1 {a b}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {element 1 missing from sublist \"a\"} 0 0 {TCL OPERATION LSORT INDEXFAILED}",
    "", false, "comparison-completion-1393",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -code break FIRST};set calls 0;lsort -command cmp  {a b c d e}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "3 FIRST 0 1 NONE", "", false, "comparison-completion-1394",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -code break FIRST};set calls 0;lsort -command cmp -index 1 {a b c d e}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {element 1 missing from sublist \"a\"} 0 0 {TCL OPERATION LSORT INDEXFAILED}",
    "", false, "comparison-completion-1395",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -code break FIRST};set calls 0;lsort -command cmp  {{a x} {b y} z}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "3 FIRST 0 1 NONE", "", false, "comparison-completion-1396",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -code break FIRST};set calls 0;lsort -command cmp -index 1 {{a x} {b y} z}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {element 1 missing from sublist \"z\"} 0 1 {TCL OPERATION LSORT INDEXFAILED}",
    "", false, "comparison-completion-1397",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -code break FIRST};set calls 0;lsort -command cmp  {{a x} {b y} {c z} q}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "3 FIRST 0 1 NONE", "", false, "comparison-completion-1398",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -code break FIRST};set calls 0;lsort -command cmp -index 1 {{a x} {b y} {c z} q}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "3 FIRST 0 1 NONE", "", false, "comparison-completion-1399",
  )
}

///|
test "Tcl sort cases 1401 through 1440" {
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -code break FIRST};set calls 0;lsort -command cmp  {{a x} {b y} {c z} {d q} r}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "3 FIRST 0 1 NONE", "", false, "comparison-completion-1400",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -code break FIRST};set calls 0;lsort -command cmp -index 1 {{a x} {b y} {c z} {d q} r}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "3 FIRST 0 1 NONE", "", false, "comparison-completion-1401",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -code continue FIRST};set calls 0;lsort -command cmp  {a b}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "4 FIRST 0 1 NONE", "", false, "comparison-completion-1402",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -code continue FIRST};set calls 0;lsort -command cmp -index 1 {a b}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {element 1 missing from sublist \"a\"} 0 0 {TCL OPERATION LSORT INDEXFAILED}",
    "", false, "comparison-completion-1403",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -code continue FIRST};set calls 0;lsort -command cmp  {a b c d e}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "4 FIRST 0 1 NONE", "", false, "comparison-completion-1404",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -code continue FIRST};set calls 0;lsort -command cmp -index 1 {a b c d e}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {element 1 missing from sublist \"a\"} 0 0 {TCL OPERATION LSORT INDEXFAILED}",
    "", false, "comparison-completion-1405",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -code continue FIRST};set calls 0;lsort -command cmp  {{a x} {b y} z}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "4 FIRST 0 1 NONE", "", false, "comparison-completion-1406",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -code continue FIRST};set calls 0;lsort -command cmp -index 1 {{a x} {b y} z}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {element 1 missing from sublist \"z\"} 0 1 {TCL OPERATION LSORT INDEXFAILED}",
    "", false, "comparison-completion-1407",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -code continue FIRST};set calls 0;lsort -command cmp  {{a x} {b y} {c z} q}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "4 FIRST 0 1 NONE", "", false, "comparison-completion-1408",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -code continue FIRST};set calls 0;lsort -command cmp -index 1 {{a x} {b y} {c z} q}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "4 FIRST 0 1 NONE", "", false, "comparison-completion-1409",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -code continue FIRST};set calls 0;lsort -command cmp  {{a x} {b y} {c z} {d q} r}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "4 FIRST 0 1 NONE", "", false, "comparison-completion-1410",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -code continue FIRST};set calls 0;lsort -command cmp -index 1 {{a x} {b y} {c z} {d q} r}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "4 FIRST 0 1 NONE", "", false, "comparison-completion-1411",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -code 8 FIRST};set calls 0;lsort -command cmp  {a b}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "8 FIRST 0 1 NONE", "", false, "comparison-completion-1412",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -code 8 FIRST};set calls 0;lsort -command cmp -index 1 {a b}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {element 1 missing from sublist \"a\"} 0 0 {TCL OPERATION LSORT INDEXFAILED}",
    "", false, "comparison-completion-1413",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -code 8 FIRST};set calls 0;lsort -command cmp  {a b c d e}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "8 FIRST 0 1 NONE", "", false, "comparison-completion-1414",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -code 8 FIRST};set calls 0;lsort -command cmp -index 1 {a b c d e}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {element 1 missing from sublist \"a\"} 0 0 {TCL OPERATION LSORT INDEXFAILED}",
    "", false, "comparison-completion-1415",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -code 8 FIRST};set calls 0;lsort -command cmp  {{a x} {b y} z}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "8 FIRST 0 1 NONE", "", false, "comparison-completion-1416",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -code 8 FIRST};set calls 0;lsort -command cmp -index 1 {{a x} {b y} z}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {element 1 missing from sublist \"z\"} 0 1 {TCL OPERATION LSORT INDEXFAILED}",
    "", false, "comparison-completion-1417",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -code 8 FIRST};set calls 0;lsort -command cmp  {{a x} {b y} {c z} q}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "8 FIRST 0 1 NONE", "", false, "comparison-completion-1418",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -code 8 FIRST};set calls 0;lsort -command cmp -index 1 {{a x} {b y} {c z} q}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "8 FIRST 0 1 NONE", "", false, "comparison-completion-1419",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -code 8 FIRST};set calls 0;lsort -command cmp  {{a x} {b y} {c z} {d q} r}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "8 FIRST 0 1 NONE", "", false, "comparison-completion-1420",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -code 8 FIRST};set calls 0;lsort -command cmp -index 1 {{a x} {b y} {c z} {d q} r}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "8 FIRST 0 1 NONE", "", false, "comparison-completion-1421",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -level 2 FIRST};set calls 0;lsort -command cmp  {a b}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "2 FIRST 1 1 NONE", "", false, "comparison-completion-1422",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -level 2 FIRST};set calls 0;lsort -command cmp -index 1 {a b}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {element 1 missing from sublist \"a\"} 0 0 {TCL OPERATION LSORT INDEXFAILED}",
    "", false, "comparison-completion-1423",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -level 2 FIRST};set calls 0;lsort -command cmp  {a b c d e}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "2 FIRST 1 1 NONE", "", false, "comparison-completion-1424",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -level 2 FIRST};set calls 0;lsort -command cmp -index 1 {a b c d e}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {element 1 missing from sublist \"a\"} 0 0 {TCL OPERATION LSORT INDEXFAILED}",
    "", false, "comparison-completion-1425",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -level 2 FIRST};set calls 0;lsort -command cmp  {{a x} {b y} z}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "2 FIRST 1 1 NONE", "", false, "comparison-completion-1426",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -level 2 FIRST};set calls 0;lsort -command cmp -index 1 {{a x} {b y} z}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {element 1 missing from sublist \"z\"} 0 1 {TCL OPERATION LSORT INDEXFAILED}",
    "", false, "comparison-completion-1427",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -level 2 FIRST};set calls 0;lsort -command cmp  {{a x} {b y} {c z} q}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "2 FIRST 1 1 NONE", "", false, "comparison-completion-1428",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -level 2 FIRST};set calls 0;lsort -command cmp -index 1 {{a x} {b y} {c z} q}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "2 FIRST 1 1 NONE", "", false, "comparison-completion-1429",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -level 2 FIRST};set calls 0;lsort -command cmp  {{a x} {b y} {c z} {d q} r}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "2 FIRST 1 1 NONE", "", false, "comparison-completion-1430",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -level 2 FIRST};set calls 0;lsort -command cmp -index 1 {{a x} {b y} {c z} {d q} r}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "2 FIRST 1 1 NONE", "", false, "comparison-completion-1431",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return bad};set calls 0;lsort -command cmp  {a b}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {-compare command returned non-integer result} 0 1 {TCL OPERATION LSORT COMPARISONFAILED}",
    "", false, "comparison-completion-1432",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return bad};set calls 0;lsort -command cmp -index 1 {a b}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {element 1 missing from sublist \"a\"} 0 0 {TCL OPERATION LSORT INDEXFAILED}",
    "", false, "comparison-completion-1433",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return bad};set calls 0;lsort -command cmp  {a b c d e}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {-compare command returned non-integer result} 0 1 {TCL OPERATION LSORT COMPARISONFAILED}",
    "", false, "comparison-completion-1434",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return bad};set calls 0;lsort -command cmp -index 1 {a b c d e}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {element 1 missing from sublist \"a\"} 0 0 {TCL OPERATION LSORT INDEXFAILED}",
    "", false, "comparison-completion-1435",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return bad};set calls 0;lsort -command cmp  {{a x} {b y} z}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {-compare command returned non-integer result} 0 1 {TCL OPERATION LSORT COMPARISONFAILED}",
    "", false, "comparison-completion-1436",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return bad};set calls 0;lsort -command cmp -index 1 {{a x} {b y} z}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {element 1 missing from sublist \"z\"} 0 1 {TCL OPERATION LSORT INDEXFAILED}",
    "", false, "comparison-completion-1437",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return bad};set calls 0;lsort -command cmp  {{a x} {b y} {c z} q}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {-compare command returned non-integer result} 0 1 {TCL OPERATION LSORT COMPARISONFAILED}",
    "", false, "comparison-completion-1438",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return bad};set calls 0;lsort -command cmp -index 1 {{a x} {b y} {c z} q}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {-compare command returned non-integer result} 0 1 {TCL OPERATION LSORT COMPARISONFAILED}",
    "", false, "comparison-completion-1439",
  )
}

///|
test "Tcl sort cases 1441 through 1480" {
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return bad};set calls 0;lsort -command cmp  {{a x} {b y} {c z} {d q} r}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {-compare command returned non-integer result} 0 1 {TCL OPERATION LSORT COMPARISONFAILED}",
    "", false, "comparison-completion-1440",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return bad};set calls 0;lsort -command cmp -index 1 {{a x} {b y} {c z} {d q} r}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {-compare command returned non-integer result} 0 1 {TCL OPERATION LSORT COMPARISONFAILED}",
    "", false, "comparison-completion-1441",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -code error -errorcode {CUSTOM FAIL} FIRST};set calls 0;lsort -command cmp  {a b}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 FIRST 0 1 {CUSTOM FAIL}", "", false, "comparison-completion-1442",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -code error -errorcode {CUSTOM FAIL} FIRST};set calls 0;lsort -command cmp -index 1 {a b}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {element 1 missing from sublist \"a\"} 0 0 {TCL OPERATION LSORT INDEXFAILED}",
    "", false, "comparison-completion-1443",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -code error -errorcode {CUSTOM FAIL} FIRST};set calls 0;lsort -command cmp  {a b c d e}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 FIRST 0 1 {CUSTOM FAIL}", "", false, "comparison-completion-1444",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -code error -errorcode {CUSTOM FAIL} FIRST};set calls 0;lsort -command cmp -index 1 {a b c d e}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {element 1 missing from sublist \"a\"} 0 0 {TCL OPERATION LSORT INDEXFAILED}",
    "", false, "comparison-completion-1445",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -code error -errorcode {CUSTOM FAIL} FIRST};set calls 0;lsort -command cmp  {{a x} {b y} z}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 FIRST 0 1 {CUSTOM FAIL}", "", false, "comparison-completion-1446",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -code error -errorcode {CUSTOM FAIL} FIRST};set calls 0;lsort -command cmp -index 1 {{a x} {b y} z}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {element 1 missing from sublist \"z\"} 0 1 {TCL OPERATION LSORT INDEXFAILED}",
    "", false, "comparison-completion-1447",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -code error -errorcode {CUSTOM FAIL} FIRST};set calls 0;lsort -command cmp  {{a x} {b y} {c z} q}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 FIRST 0 1 {CUSTOM FAIL}", "", false, "comparison-completion-1448",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -code error -errorcode {CUSTOM FAIL} FIRST};set calls 0;lsort -command cmp -index 1 {{a x} {b y} {c z} q}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 FIRST 0 1 {CUSTOM FAIL}", "", false, "comparison-completion-1449",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -code error -errorcode {CUSTOM FAIL} FIRST};set calls 0;lsort -command cmp  {{a x} {b y} {c z} {d q} r}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 FIRST 0 1 {CUSTOM FAIL}", "", false, "comparison-completion-1450",
  )
  check_sort_case(
    "set code [catch \"proc cmp {a b} {incr ::calls;return -code error -errorcode {CUSTOM FAIL} FIRST};set calls 0;lsort -command cmp -index 1 {{a x} {b y} {c z} {d q} r}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}];list $code $r [dict get $o -level] $calls [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 FIRST 0 1 {CUSTOM FAIL}", "", false, "comparison-completion-1451",
  )
  check_sort_case(
    "namespace eval n {variable calls 0;proc cmp {a b} {variable calls;incr calls;string compare $a $b};proc run {} {lsort -command cmp {c a b}}};list [n::run] $n::calls",
    "{a b c} 3", "", false, "reentrancy-scope-1452",
  )
  check_sort_case(
    "proc cmp {prefix a b} {lappend ::calls [list $prefix $a $b];string compare $a $b};set calls {};list [lsort -command {cmp MARK} {c a b}] $calls",
    "{a b c} {{MARK c a} {MARK a b} {MARK c b}}", "", false, "reentrancy-scope-1453",
  )
  check_sort_case(
    "proc cmp {a b} {set ::v changed;string compare $a $b};set v {c a b};list [lsort -command cmp $v] $v",
    "{a b c} changed", "", false, "reentrancy-scope-1454",
  )
  check_sort_case(
    "proc cmp {a b} {set ::prefix bad;string compare $a $b};set prefix cmp;list [lsort -command $prefix {c a b}] $prefix",
    "{a b c} bad", "", false, "reentrancy-scope-1455",
  )
  check_sort_case(
    "proc cmp {a b} {set inner [lsort -integer {3 1 2}];string compare $a $b};lsort -command cmp {c a b}",
    "a b c", "", false, "reentrancy-scope-1456",
  )
  check_sort_case(
    "proc cmp {a b} {rename cmp {};proc cmp {a b} {expr {-[string compare $a $b]}};string compare $a $b};lsort -command cmp {d c b a}",
    "c d b a", "", false, "reentrancy-scope-1457",
  )
  check_sort_case(
    "rename lsort order;order -str 2 -ind 1 -int -indic {x 3 y 1 z 2}", "ambiguous option \"-ind\": must be -ascii, -command, -decreasing, -dictionary, -increasing, -index, -indices, -integer, -nocase, -real, -stride, or -unique",
    "", true, "reentrancy-scope-1458",
  )
  check_sort_case(
    "proc cmp {a b} {puts [list $a $b];string compare $a $b};lsort -command cmp {c b a}",
    "a b c", "c b\nb a\n", false, "reentrancy-scope-1459",
  )
  check_sort_case(
    "set v 2;catch {lsort -ascii [list $v]} r;list $r [format %.17g $v]", "2 2",
    "", false, "representations-1460",
  )
  check_sort_case(
    "set v 2;catch {lsort -ascii $v} r;list $r [format %.17g $v]", "2 2", "", false,
    "representations-1461",
  )
  check_sort_case(
    "set v 2;catch {lsort -ascii [list $v 0]} r;list $r [format %.17g $v]", "{0 2} 2",
    "", false, "representations-1462",
  )
  check_sort_case(
    "set v 2;catch {lsort -nocase [list $v]} r;list $r [format %.17g $v]", "2 2",
    "", false, "representations-1463",
  )
  check_sort_case(
    "set v 2;catch {lsort -nocase $v} r;list $r [format %.17g $v]", "2 2", "", false,
    "representations-1464",
  )
  check_sort_case(
    "set v 2;catch {lsort -nocase [list $v 0]} r;list $r [format %.17g $v]", "{0 2} 2",
    "", false, "representations-1465",
  )
  check_sort_case(
    "set v 2;catch {lsort -dictionary [list $v]} r;list $r [format %.17g $v]", "2 2",
    "", false, "representations-1466",
  )
  check_sort_case(
    "set v 2;catch {lsort -dictionary $v} r;list $r [format %.17g $v]", "2 2", "",
    false, "representations-1467",
  )
  check_sort_case(
    "set v 2;catch {lsort -dictionary [list $v 0]} r;list $r [format %.17g $v]",
    "{0 2} 2", "", false, "representations-1468",
  )
  check_sort_case(
    "set v 2;catch {lsort -integer [list $v]} r;list $r [format %.17g $v]", "2 2",
    "", false, "representations-1469",
  )
  check_sort_case(
    "set v 2;catch {lsort -integer $v} r;list $r [format %.17g $v]", "2 2", "", false,
    "representations-1470",
  )
  check_sort_case(
    "set v 2;catch {lsort -integer [list $v 0]} r;list $r [format %.17g $v]", "{0 2} 2",
    "", false, "representations-1471",
  )
  check_sort_case(
    "set v 2;catch {lsort -real [list $v]} r;list $r [format %.17g $v]", "2 2", "",
    false, "representations-1472",
  )
  check_sort_case(
    "set v 2;catch {lsort -real $v} r;list $r [format %.17g $v]", "2 2", "", false,
    "representations-1473",
  )
  check_sort_case(
    "set v 2;catch {lsort -real [list $v 0]} r;list $r [format %.17g $v]", "{0 2} 2",
    "", false, "representations-1474",
  )
  check_sort_case(
    "set v 2;catch {lsort -command {string compare} [list $v]} r;list $r [format %.17g $v]",
    "2 2", "", false, "representations-1475",
  )
  check_sort_case(
    "set v 2;catch {lsort -command {string compare} $v} r;list $r [format %.17g $v]",
    "2 2", "", false, "representations-1476",
  )
  check_sort_case(
    "set v 2;catch {lsort -command {string compare} [list $v 0]} r;list $r [format %.17g $v]",
    "{0 2} 2", "", false, "representations-1477",
  )
  check_sort_case(
    "set v 2;catch {lsort -indices -real [list $v]} r;list $r [format %.17g $v]",
    "0 2", "", false, "representations-1478",
  )
  check_sort_case(
    "set v 2;catch {lsort -indices -real $v} r;list $r [format %.17g $v]", "0 2",
    "", false, "representations-1479",
  )
}

///|
test "Tcl sort cases 1481 through 1520" {
  check_sort_case(
    "set v 2;catch {lsort -indices -real [list $v 0]} r;list $r [format %.17g $v]",
    "{1 0} 2", "", false, "representations-1480",
  )
  check_sort_case(
    "set v [expr {2.0}];catch {lsort -ascii [list $v]} r;list $r [format %.17g $v]",
    "2.0 2", "", false, "representations-1481",
  )
  check_sort_case(
    "set v [expr {2.0}];catch {lsort -ascii $v} r;list $r [format %.17g $v]", "2.0 2",
    "", false, "representations-1482",
  )
  check_sort_case(
    "set v [expr {2.0}];catch {lsort -ascii [list $v 0]} r;list $r [format %.17g $v]",
    "{0 2.0} 2", "", false, "representations-1483",
  )
  check_sort_case(
    "set v [expr {2.0}];catch {lsort -nocase [list $v]} r;list $r [format %.17g $v]",
    "2.0 2", "", false, "representations-1484",
  )
  check_sort_case(
    "set v [expr {2.0}];catch {lsort -nocase $v} r;list $r [format %.17g $v]", "2.0 2",
    "", false, "representations-1485",
  )
  check_sort_case(
    "set v [expr {2.0}];catch {lsort -nocase [list $v 0]} r;list $r [format %.17g $v]",
    "{0 2.0} 2", "", false, "representations-1486",
  )
  check_sort_case(
    "set v [expr {2.0}];catch {lsort -dictionary [list $v]} r;list $r [format %.17g $v]",
    "2.0 2", "", false, "representations-1487",
  )
  check_sort_case(
    "set v [expr {2.0}];catch {lsort -dictionary $v} r;list $r [format %.17g $v]",
    "2.0 2", "", false, "representations-1488",
  )
  check_sort_case(
    "set v [expr {2.0}];catch {lsort -dictionary [list $v 0]} r;list $r [format %.17g $v]",
    "{0 2.0} 2", "", false, "representations-1489",
  )
  check_sort_case(
    "set v [expr {2.0}];catch {lsort -integer [list $v]} r;list $r [format %.17g $v]",
    "{expected integer but got \"2.0\"} 2", "", false, "representations-1490",
  )
  check_sort_case(
    "set v [expr {2.0}];catch {lsort -integer $v} r;list $r [format %.17g $v]", "{expected integer but got \"2.0\"} 2",
    "", false, "representations-1491",
  )
  check_sort_case(
    "set v [expr {2.0}];catch {lsort -integer [list $v 0]} r;list $r [format %.17g $v]",
    "{expected integer but got \"2.0\"} 2", "", false, "representations-1492",
  )
  check_sort_case(
    "set v [expr {2.0}];catch {lsort -real [list $v]} r;list $r [format %.17g $v]",
    "2.0 2", "", false, "representations-1493",
  )
  check_sort_case(
    "set v [expr {2.0}];catch {lsort -real $v} r;list $r [format %.17g $v]", "2.0 2",
    "", false, "representations-1494",
  )
  check_sort_case(
    "set v [expr {2.0}];catch {lsort -real [list $v 0]} r;list $r [format %.17g $v]",
    "{0 2.0} 2", "", false, "representations-1495",
  )
  check_sort_case(
    "set v [expr {2.0}];catch {lsort -command {string compare} [list $v]} r;list $r [format %.17g $v]",
    "2.0 2", "", false, "representations-1496",
  )
  check_sort_case(
    "set v [expr {2.0}];catch {lsort -command {string compare} $v} r;list $r [format %.17g $v]",
    "2.0 2", "", false, "representations-1497",
  )
  check_sort_case(
    "set v [expr {2.0}];catch {lsort -command {string compare} [list $v 0]} r;list $r [format %.17g $v]",
    "{0 2.0} 2", "", false, "representations-1498",
  )
  check_sort_case(
    "set v [expr {2.0}];catch {lsort -indices -real [list $v]} r;list $r [format %.17g $v]",
    "0 2", "", false, "representations-1499",
  )
  check_sort_case(
    "set v [expr {2.0}];catch {lsort -indices -real $v} r;list $r [format %.17g $v]",
    "0 2", "", false, "representations-1500",
  )
  check_sort_case(
    "set v [expr {2.0}];catch {lsort -indices -real [list $v 0]} r;list $r [format %.17g $v]",
    "{1 0} 2", "", false, "representations-1501",
  )
  check_sort_case(
    "scan 18446744073709551616 %f v;catch {lsort -ascii [list $v]} r;list $r [format %.17g $v]",
    "1.844674407370955e+19 1.8446744073709552e+19", "", false, "representations-1502",
  )
  check_sort_case(
    "scan 18446744073709551616 %f v;catch {lsort -ascii $v} r;list $r [format %.17g $v]",
    "1.844674407370955e+19 1.844674407370955e+19", "", false, "representations-1503",
  )
  check_sort_case(
    "scan 18446744073709551616 %f v;catch {lsort -ascii [list $v 0]} r;list $r [format %.17g $v]",
    "{0 1.844674407370955e+19} 1.8446744073709552e+19", "", false, "representations-1504",
  )
  check_sort_case(
    "scan 18446744073709551616 %f v;catch {lsort -nocase [list $v]} r;list $r [format %.17g $v]",
    "1.844674407370955e+19 1.8446744073709552e+19", "", false, "representations-1505",
  )
  check_sort_case(
    "scan 18446744073709551616 %f v;catch {lsort -nocase $v} r;list $r [format %.17g $v]",
    "1.844674407370955e+19 1.844674407370955e+19", "", false, "representations-1506",
  )
  check_sort_case(
    "scan 18446744073709551616 %f v;catch {lsort -nocase [list $v 0]} r;list $r [format %.17g $v]",
    "{0 1.844674407370955e+19} 1.8446744073709552e+19", "", false, "representations-1507",
  )
  check_sort_case(
    "scan 18446744073709551616 %f v;catch {lsort -dictionary [list $v]} r;list $r [format %.17g $v]",
    "1.844674407370955e+19 1.8446744073709552e+19", "", false, "representations-1508",
  )
  check_sort_case(
    "scan 18446744073709551616 %f v;catch {lsort -dictionary $v} r;list $r [format %.17g $v]",
    "1.844674407370955e+19 1.844674407370955e+19", "", false, "representations-1509",
  )
  check_sort_case(
    "scan 18446744073709551616 %f v;catch {lsort -dictionary [list $v 0]} r;list $r [format %.17g $v]",
    "{0 1.844674407370955e+19} 1.8446744073709552e+19", "", false, "representations-1510",
  )
  check_sort_case(
    "scan 18446744073709551616 %f v;catch {lsort -integer [list $v]} r;list $r [format %.17g $v]",
    "{expected integer but got \"1.844674407370955e+19\"} 1.8446744073709552e+19",
    "", false, "representations-1511",
  )
  check_sort_case(
    "scan 18446744073709551616 %f v;catch {lsort -integer $v} r;list $r [format %.17g $v]",
    "{expected integer but got \"1.844674407370955e+19\"} 1.844674407370955e+19",
    "", false, "representations-1512",
  )
  check_sort_case(
    "scan 18446744073709551616 %f v;catch {lsort -integer [list $v 0]} r;list $r [format %.17g $v]",
    "{expected integer but got \"1.844674407370955e+19\"} 1.8446744073709552e+19",
    "", false, "representations-1513",
  )
  check_sort_case(
    "scan 18446744073709551616 %f v;catch {lsort -real [list $v]} r;list $r [format %.17g $v]",
    "1.844674407370955e+19 1.8446744073709552e+19", "", false, "representations-1514",
  )
  check_sort_case(
    "scan 18446744073709551616 %f v;catch {lsort -real $v} r;list $r [format %.17g $v]",
    "1.844674407370955e+19 1.844674407370955e+19", "", false, "representations-1515",
  )
  check_sort_case(
    "scan 18446744073709551616 %f v;catch {lsort -real [list $v 0]} r;list $r [format %.17g $v]",
    "{0 1.844674407370955e+19} 1.8446744073709552e+19", "", false, "representations-1516",
  )
  check_sort_case(
    "scan 18446744073709551616 %f v;catch {lsort -command {string compare} [list $v]} r;list $r [format %.17g $v]",
    "1.844674407370955e+19 1.8446744073709552e+19", "", false, "representations-1517",
  )
  check_sort_case(
    "scan 18446744073709551616 %f v;catch {lsort -command {string compare} $v} r;list $r [format %.17g $v]",
    "1.844674407370955e+19 1.844674407370955e+19", "", false, "representations-1518",
  )
  check_sort_case(
    "scan 18446744073709551616 %f v;catch {lsort -command {string compare} [list $v 0]} r;list $r [format %.17g $v]",
    "{0 1.844674407370955e+19} 1.8446744073709552e+19", "", false, "representations-1519",
  )
}

///|
test "Tcl sort cases 1521 through 1560" {
  check_sort_case(
    "scan 18446744073709551616 %f v;catch {lsort -indices -real [list $v]} r;list $r [format %.17g $v]",
    "0 1.8446744073709552e+19", "", false, "representations-1520",
  )
  check_sort_case(
    "scan 18446744073709551616 %f v;catch {lsort -indices -real $v} r;list $r [format %.17g $v]",
    "0 1.844674407370955e+19", "", false, "representations-1521",
  )
  check_sort_case(
    "scan 18446744073709551616 %f v;catch {lsort -indices -real [list $v 0]} r;list $r [format %.17g $v]",
    "{1 0} 1.8446744073709552e+19", "", false, "representations-1522",
  )
  check_sort_case(
    "set v [expr {18446744073709551615}];catch {lsort -ascii [list $v]} r;list $r [format %.17g $v]",
    "18446744073709551615 1.8446744073709552e+19", "", false, "representations-1523",
  )
  check_sort_case(
    "set v [expr {18446744073709551615}];catch {lsort -ascii $v} r;list $r [format %.17g $v]",
    "18446744073709551615 1.8446744073709552e+19", "", false, "representations-1524",
  )
  check_sort_case(
    "set v [expr {18446744073709551615}];catch {lsort -ascii [list $v 0]} r;list $r [format %.17g $v]",
    "{0 18446744073709551615} 1.8446744073709552e+19", "", false, "representations-1525",
  )
  check_sort_case(
    "set v [expr {18446744073709551615}];catch {lsort -nocase [list $v]} r;list $r [format %.17g $v]",
    "18446744073709551615 1.8446744073709552e+19", "", false, "representations-1526",
  )
  check_sort_case(
    "set v [expr {18446744073709551615}];catch {lsort -nocase $v} r;list $r [format %.17g $v]",
    "18446744073709551615 1.8446744073709552e+19", "", false, "representations-1527",
  )
  check_sort_case(
    "set v [expr {18446744073709551615}];catch {lsort -nocase [list $v 0]} r;list $r [format %.17g $v]",
    "{0 18446744073709551615} 1.8446744073709552e+19", "", false, "representations-1528",
  )
  check_sort_case(
    "set v [expr {18446744073709551615}];catch {lsort -dictionary [list $v]} r;list $r [format %.17g $v]",
    "18446744073709551615 1.8446744073709552e+19", "", false, "representations-1529",
  )
  check_sort_case(
    "set v [expr {18446744073709551615}];catch {lsort -dictionary $v} r;list $r [format %.17g $v]",
    "18446744073709551615 1.8446744073709552e+19", "", false, "representations-1530",
  )
  check_sort_case(
    "set v [expr {18446744073709551615}];catch {lsort -dictionary [list $v 0]} r;list $r [format %.17g $v]",
    "{0 18446744073709551615} 1.8446744073709552e+19", "", false, "representations-1531",
  )
  check_sort_case(
    "set v [expr {18446744073709551615}];catch {lsort -integer [list $v]} r;list $r [format %.17g $v]",
    "18446744073709551615 1.8446744073709552e+19", "", false, "representations-1532",
  )
  check_sort_case(
    "set v [expr {18446744073709551615}];catch {lsort -integer $v} r;list $r [format %.17g $v]",
    "18446744073709551615 1.8446744073709552e+19", "", false, "representations-1533",
  )
  check_sort_case(
    "set v [expr {18446744073709551615}];catch {lsort -integer [list $v 0]} r;list $r [format %.17g $v]",
    "{18446744073709551615 0} 1.8446744073709552e+19", "", false, "representations-1534",
  )
  check_sort_case(
    "set v [expr {18446744073709551615}];catch {lsort -real [list $v]} r;list $r [format %.17g $v]",
    "18446744073709551615 1.8446744073709552e+19", "", false, "representations-1535",
  )
  check_sort_case(
    "set v [expr {18446744073709551615}];catch {lsort -real $v} r;list $r [format %.17g $v]",
    "18446744073709551615 1.8446744073709552e+19", "", false, "representations-1536",
  )
  check_sort_case(
    "set v [expr {18446744073709551615}];catch {lsort -real [list $v 0]} r;list $r [format %.17g $v]",
    "{0 18446744073709551615} 1.8446744073709552e+19", "", false, "representations-1537",
  )
  check_sort_case(
    "set v [expr {18446744073709551615}];catch {lsort -command {string compare} [list $v]} r;list $r [format %.17g $v]",
    "18446744073709551615 1.8446744073709552e+19", "", false, "representations-1538",
  )
  check_sort_case(
    "set v [expr {18446744073709551615}];catch {lsort -command {string compare} $v} r;list $r [format %.17g $v]",
    "18446744073709551615 1.8446744073709552e+19", "", false, "representations-1539",
  )
  check_sort_case(
    "set v [expr {18446744073709551615}];catch {lsort -command {string compare} [list $v 0]} r;list $r [format %.17g $v]",
    "{0 18446744073709551615} 1.8446744073709552e+19", "", false, "representations-1540",
  )
  check_sort_case(
    "set v [expr {18446744073709551615}];catch {lsort -indices -real [list $v]} r;list $r [format %.17g $v]",
    "0 1.8446744073709552e+19", "", false, "representations-1541",
  )
  check_sort_case(
    "set v [expr {18446744073709551615}];catch {lsort -indices -real $v} r;list $r [format %.17g $v]",
    "0 1.8446744073709552e+19", "", false, "representations-1542",
  )
  check_sort_case(
    "set v [expr {18446744073709551615}];catch {lsort -indices -real [list $v 0]} r;list $r [format %.17g $v]",
    "{1 0} 1.8446744073709552e+19", "", false, "representations-1543",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-8\" \"0\" \"11\" \"9\" \"10\" \"-11\" \"-2\" \"-12\" \"-4\" \"-5\" \"7\" \"2\" \"11\" \"5\" \"7\" \"-3\" \"5\" \"4\"]",
    "7 5 0 9 8 15 6 1 11 17 16 14 3 4 12", "", false, "seeded-sort-1544",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-8\" \"0\" \"11\" \"9\" \"10\" \"-11\" \"-2\" \"-12\" \"-4\" \"-5\" \"7\" \"2\" \"11\" \"5\" \"7\" \"-3\" \"5\" \"4\"]",
    "11 11 10 9 7 7 5 5 4 2 0 -2 -3 -4 -5 -8 -11 -12", "", false, "seeded-sort-1545",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-8\" \"0\" \"11\" \"9\" \"10\" \"-11\" \"-2\" \"-12\" \"-4\" \"-5\" \"7\" \"2\" \"11\" \"5\" \"7\" \"-3\" \"5\" \"4\"]",
    "5 7 6 15 8 9 0 1 4 2 12 11 17 13 16 10 14 3", "", false, "seeded-sort-1546",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"12\" \"7\" \"-2\" \"8\" \"-8\" \"11\" \"-6\" \"-4\" \"3\" \"4\" \"-4\" \"10\" \"8\" \"-7\" \"9\" \"-4\" \"2\" \"-5\" \"-3\" \"-8\" \"-5\"]",
    "19 13 6 20 15 18 2 16 8 9 1 12 14 11 5 0", "", false, "seeded-sort-1547",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"12\" \"7\" \"-2\" \"8\" \"-8\" \"11\" \"-6\" \"-4\" \"3\" \"4\" \"-4\" \"10\" \"8\" \"-7\" \"9\" \"-4\" \"2\" \"-5\" \"-3\" \"-8\" \"-5\"]",
    "12 11 10 9 8 8 7 4 3 2 -2 -3 -4 -4 -4 -5 -5 -6 -7 -8 -8", "", false, "seeded-sort-1548",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"12\" \"7\" \"-2\" \"8\" \"-8\" \"11\" \"-6\" \"-4\" \"3\" \"4\" \"-4\" \"10\" \"8\" \"-7\" \"9\" \"-4\" \"2\" \"-5\" \"-3\" \"-8\" \"-5\"]",
    "2 18 7 10 15 17 20 6 13 4 19 11 5 0 16 8 9 1 3 12 14", "", false, "seeded-sort-1549",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"10\" \"12\" \"5\" \"11\" \"-4\" \"10\" \"1\" \"-8\" \"2\"]",
    "7 4 6 8 2 5 3 1", "", false, "seeded-sort-1550",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"10\" \"12\" \"5\" \"11\" \"-4\" \"10\" \"1\" \"-8\" \"2\"]",
    "12 11 10 10 5 2 1 -4 -8", "", false, "seeded-sort-1551",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"10\" \"12\" \"5\" \"11\" \"-4\" \"10\" \"1\" \"-8\" \"2\"]",
    "4 7 6 0 5 3 1 8 2", "", false, "seeded-sort-1552",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"11\" \"-2\" \"-8\" \"5\" \"12\" \"-7\" \"-8\" \"-7\"]",
    "6 7 1 3 0 4", "", false, "seeded-sort-1553",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"11\" \"-2\" \"-8\" \"5\" \"12\" \"-7\" \"-8\" \"-7\"]",
    "12 11 5 -2 -7 -7 -8 -8", "", false, "seeded-sort-1554",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"11\" \"-2\" \"-8\" \"5\" \"12\" \"-7\" \"-8\" \"-7\"]",
    "1 5 7 2 6 0 4 3", "", false, "seeded-sort-1555",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-2\" \"-1\" \"-1\" \"-1\" \"-9\" \"6\" \"3\" \"-5\" \"0\" \"-3\" \"9\" \"-10\" \"9\" \"-1\" \"8\" \"2\" \"9\"]",
    "11 4 7 9 0 13 8 15 6 5 14 16", "", false, "seeded-sort-1556",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-2\" \"-1\" \"-1\" \"-1\" \"-9\" \"6\" \"3\" \"-5\" \"0\" \"-3\" \"9\" \"-10\" \"9\" \"-1\" \"8\" \"2\" \"9\"]",
    "9 9 9 8 6 3 2 0 -1 -1 -1 -1 -2 -3 -5 -9 -10", "", false, "seeded-sort-1557",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-2\" \"-1\" \"-1\" \"-1\" \"-9\" \"6\" \"3\" \"-5\" \"0\" \"-3\" \"9\" \"-10\" \"9\" \"-1\" \"8\" \"2\" \"9\"]",
    "1 2 3 13 11 0 9 7 4 8 15 6 5 14 10 12 16", "", false, "seeded-sort-1558",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-5\" \"10\" \"3\" \"5\" \"-7\" \"9\" \"7\" \"3\" \"-6\" \"10\" \"-5\" \"2\" \"7\" \"-6\" \"-12\" \"-10\" \"-4\" \"-11\" \"12\" \"10\" \"10\" \"12\" \"4\" \"7\" \"3\"]",
    "14 17 15 4 13 10 16 11 24 22 3 23 5 20 21", "", false, "seeded-sort-1559",
  )
}

///|
test "Tcl sort cases 1561 through 1600" {
  check_sort_case(
    "lsort -integer -decreasing [list \"-5\" \"10\" \"3\" \"5\" \"-7\" \"9\" \"7\" \"3\" \"-6\" \"10\" \"-5\" \"2\" \"7\" \"-6\" \"-12\" \"-10\" \"-4\" \"-11\" \"12\" \"10\" \"10\" \"12\" \"4\" \"7\" \"3\"]",
    "12 12 10 10 10 10 9 7 7 7 5 4 3 3 3 2 -4 -5 -5 -6 -6 -7 -10 -11 -12", "", false,
    "seeded-sort-1560",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-5\" \"10\" \"3\" \"5\" \"-7\" \"9\" \"7\" \"3\" \"-6\" \"10\" \"-5\" \"2\" \"7\" \"-6\" \"-12\" \"-10\" \"-4\" \"-11\" \"12\" \"10\" \"10\" \"12\" \"4\" \"7\" \"3\"]",
    "15 17 14 16 0 10 8 13 4 1 9 19 20 18 21 11 2 7 24 22 3 6 12 23 5", "", false,
    "seeded-sort-1561",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-6\" \"0\" \"2\" \"8\" \"3\" \"-5\" \"-5\"]",
    "0 6 1 2 4 3", "", false, "seeded-sort-1562",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-6\" \"0\" \"2\" \"8\" \"3\" \"-5\" \"-5\"]",
    "8 3 2 0 -5 -5 -6", "", false, "seeded-sort-1563",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-6\" \"0\" \"2\" \"8\" \"3\" \"-5\" \"-5\"]",
    "5 6 0 1 2 4 3", "", false, "seeded-sort-1564",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"2\" \"3\" \"-4\" \"2\" \"12\" \"-8\" \"-5\" \"-5\" \"11\" \"2\" \"11\" \"10\" \"9\" \"-10\" \"7\" \"-5\" \"-9\" \"-2\" \"-7\" \"12\" \"-1\" \"-2\" \"9\" \"0\" \"4\" \"11\" \"-6\" \"-8\" \"3\" \"12\" \"-7\" \"-11\"]",
    "31 13 16 27 30 26 15 2 21 20 23 9 28 24 14 22 11 25 29", "", false, "seeded-sort-1565",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"2\" \"3\" \"-4\" \"2\" \"12\" \"-8\" \"-5\" \"-5\" \"11\" \"2\" \"11\" \"10\" \"9\" \"-10\" \"7\" \"-5\" \"-9\" \"-2\" \"-7\" \"12\" \"-1\" \"-2\" \"9\" \"0\" \"4\" \"11\" \"-6\" \"-8\" \"3\" \"12\" \"-7\" \"-11\"]",
    "12 12 12 11 11 11 10 9 9 7 4 3 3 2 2 2 0 -1 -2 -2 -4 -5 -5 -5 -6 -7 -7 -8 -8 -9 -10 -11",
    "", false, "seeded-sort-1566",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"2\" \"3\" \"-4\" \"2\" \"12\" \"-8\" \"-5\" \"-5\" \"11\" \"2\" \"11\" \"10\" \"9\" \"-10\" \"7\" \"-5\" \"-9\" \"-2\" \"-7\" \"12\" \"-1\" \"-2\" \"9\" \"0\" \"4\" \"11\" \"-6\" \"-8\" \"3\" \"12\" \"-7\" \"-11\"]",
    "20 13 31 17 21 2 6 7 15 26 18 30 5 27 16 23 11 8 10 25 4 19 29 0 3 9 1 28 24 14 12 22",
    "", false, "seeded-sort-1567",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"3\" \"2\" \"-6\" \"0\" \"0\" \"11\" \"6\" \"-10\" \"12\" \"-2\" \"-11\" \"3\" \"-2\" \"-10\" \"-7\" \"7\" \"-9\" \"8\" \"8\" \"0\" \"-12\" \"9\" \"-9\" \"-12\" \"6\" \"3\" \"4\" \"8\" \"9\" \"-5\" \"-10\" \"8\" \"11\" \"-9\" \"-9\" \"-9\" \"8\" \"-7\" \"5\"]",
    "23 10 30 35 37 2 29 12 19 1 25 26 38 24 15 36 28 32 8", "", false, "seeded-sort-1568",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"3\" \"2\" \"-6\" \"0\" \"0\" \"11\" \"6\" \"-10\" \"12\" \"-2\" \"-11\" \"3\" \"-2\" \"-10\" \"-7\" \"7\" \"-9\" \"8\" \"8\" \"0\" \"-12\" \"9\" \"-9\" \"-12\" \"6\" \"3\" \"4\" \"8\" \"9\" \"-5\" \"-10\" \"8\" \"11\" \"-9\" \"-9\" \"-9\" \"8\" \"-7\" \"5\"]",
    "12 11 11 9 9 8 8 8 8 8 7 6 6 5 4 3 3 3 2 0 0 0 -2 -2 -5 -6 -7 -7 -9 -9 -9 -9 -9 -10 -10 -10 -11 -12 -12",
    "", false, "seeded-sort-1569",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"3\" \"2\" \"-6\" \"0\" \"0\" \"11\" \"6\" \"-10\" \"12\" \"-2\" \"-11\" \"3\" \"-2\" \"-10\" \"-7\" \"7\" \"-9\" \"8\" \"8\" \"0\" \"-12\" \"9\" \"-9\" \"-12\" \"6\" \"3\" \"4\" \"8\" \"9\" \"-5\" \"-10\" \"8\" \"11\" \"-9\" \"-9\" \"-9\" \"8\" \"-7\" \"5\"]",
    "7 13 30 10 20 23 9 12 29 2 14 37 16 22 33 34 35 3 4 19 5 32 8 1 0 11 25 26 38 6 24 15 17 18 27 31 36 21 28",
    "", false, "seeded-sort-1570",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-8\" \"3\" \"-5\" \"-7\" \"7\" \"-6\" \"-11\" \"7\"]",
    "6 0 3 5 2 1 7", "", false, "seeded-sort-1571",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-8\" \"3\" \"-5\" \"-7\" \"7\" \"-6\" \"-11\" \"7\"]",
    "7 7 3 -5 -6 -7 -8 -11", "", false, "seeded-sort-1572",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-8\" \"3\" \"-5\" \"-7\" \"7\" \"-6\" \"-11\" \"7\"]",
    "6 2 5 3 0 1 4 7", "", false, "seeded-sort-1573",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-8\" \"-12\" \"1\" \"3\"]", "1 0 2 3",
    "", false, "seeded-sort-1574",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-8\" \"-12\" \"1\" \"3\"]", "3 1 -8 -12",
    "", false, "seeded-sort-1575",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-8\" \"-12\" \"1\" \"3\"]",
    "1 0 2 3", "", false, "seeded-sort-1576",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-6\" \"-7\" \"-8\" \"-3\" \"3\" \"11\" \"-2\" \"-8\" \"10\" \"11\" \"10\"]",
    "7 1 0 3 6 4 10 9", "", false, "seeded-sort-1577",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-6\" \"-7\" \"-8\" \"-3\" \"3\" \"11\" \"-2\" \"-8\" \"10\" \"11\" \"10\"]",
    "11 11 10 10 3 -2 -3 -6 -7 -8 -8", "", false, "seeded-sort-1578",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-6\" \"-7\" \"-8\" \"-3\" \"3\" \"11\" \"-2\" \"-8\" \"10\" \"11\" \"10\"]",
    "6 3 0 1 2 7 8 10 5 9 4", "", false, "seeded-sort-1579",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-12\" \"1\" \"5\" \"5\" \"7\" \"3\" \"1\" \"2\" \"11\" \"5\" \"5\" \"4\" \"-1\" \"6\" \"-11\" \"-3\" \"7\" \"8\" \"2\" \"-2\"]",
    "0 14 15 19 12 6 18 5 11 10 13 16 17 8", "", false, "seeded-sort-1580",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-12\" \"1\" \"5\" \"5\" \"7\" \"3\" \"1\" \"2\" \"11\" \"5\" \"5\" \"4\" \"-1\" \"6\" \"-11\" \"-3\" \"7\" \"8\" \"2\" \"-2\"]",
    "11 8 7 7 6 5 5 5 5 4 3 2 2 1 1 -1 -2 -3 -11 -12", "", false, "seeded-sort-1581",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-12\" \"1\" \"5\" \"5\" \"7\" \"3\" \"1\" \"2\" \"11\" \"5\" \"5\" \"4\" \"-1\" \"6\" \"-11\" \"-3\" \"7\" \"8\" \"2\" \"-2\"]",
    "12 14 0 19 15 1 6 8 7 18 5 11 2 3 9 10 13 4 16 17", "", false, "seeded-sort-1582",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"9\"]", "0", "", false, "seeded-sort-1583",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"9\"]", "9", "", false, "seeded-sort-1584",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"9\"]", "0", "", false, "seeded-sort-1585",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"11\" \"3\" \"5\" \"5\" \"11\" \"7\" \"-10\" \"10\" \"6\" \"-12\" \"5\" \"-4\" \"10\" \"-7\" \"8\" \"-7\" \"5\" \"-2\" \"5\" \"6\" \"-11\" \"1\" \"0\" \"-5\"]",
    "9 20 6 15 23 11 17 22 21 1 18 19 5 14 12 4", "", false, "seeded-sort-1586",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"11\" \"3\" \"5\" \"5\" \"11\" \"7\" \"-10\" \"10\" \"6\" \"-12\" \"5\" \"-4\" \"10\" \"-7\" \"8\" \"-7\" \"5\" \"-2\" \"5\" \"6\" \"-11\" \"1\" \"0\" \"-5\"]",
    "11 11 10 10 8 7 6 6 5 5 5 5 5 3 1 0 -2 -4 -5 -7 -7 -10 -11 -12", "", false,
    "seeded-sort-1587",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"11\" \"3\" \"5\" \"5\" \"11\" \"7\" \"-10\" \"10\" \"6\" \"-12\" \"5\" \"-4\" \"10\" \"-7\" \"8\" \"-7\" \"5\" \"-2\" \"5\" \"6\" \"-11\" \"1\" \"0\" \"-5\"]",
    "6 20 9 17 11 23 13 15 22 21 7 12 0 4 1 2 3 10 16 18 8 19 5 14", "", false, "seeded-sort-1588",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"8\" \"-10\" \"1\" \"-8\" \"-7\" \"9\" \"-6\" \"-9\" \"-8\" \"10\" \"-5\" \"-11\" \"9\" \"12\" \"-10\" \"0\" \"12\" \"1\" \"-1\" \"4\" \"-8\" \"3\"]",
    "11 14 7 20 4 6 10 18 15 17 21 19 0 12 9 16", "", false, "seeded-sort-1589",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"8\" \"-10\" \"1\" \"-8\" \"-7\" \"9\" \"-6\" \"-9\" \"-8\" \"10\" \"-5\" \"-11\" \"9\" \"12\" \"-10\" \"0\" \"12\" \"1\" \"-1\" \"4\" \"-8\" \"3\"]",
    "12 12 10 9 9 8 4 3 1 1 0 -1 -5 -6 -7 -8 -8 -8 -9 -10 -10 -11", "", false, "seeded-sort-1590",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"8\" \"-10\" \"1\" \"-8\" \"-7\" \"9\" \"-6\" \"-9\" \"-8\" \"10\" \"-5\" \"-11\" \"9\" \"12\" \"-10\" \"0\" \"12\" \"1\" \"-1\" \"4\" \"-8\" \"3\"]",
    "18 1 14 11 10 6 4 3 8 20 7 15 2 17 9 13 16 21 19 0 5 12", "", false, "seeded-sort-1591",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"4\" \"-9\" \"-11\" \"3\" \"-4\" \"6\" \"-10\" \"0\" \"5\" \"-7\" \"8\" \"-1\" \"-12\" \"8\" \"-2\" \"7\" \"5\" \"-8\" \"-12\" \"7\" \"5\" \"-5\" \"-8\" \"0\" \"9\" \"3\" \"4\" \"8\" \"11\" \"-9\" \"-12\" \"-1\" \"-10\"]",
    "30 2 32 29 22 9 21 4 14 31 23 25 26 20 5 19 27 24 28", "", false, "seeded-sort-1592",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"4\" \"-9\" \"-11\" \"3\" \"-4\" \"6\" \"-10\" \"0\" \"5\" \"-7\" \"8\" \"-1\" \"-12\" \"8\" \"-2\" \"7\" \"5\" \"-8\" \"-12\" \"7\" \"5\" \"-5\" \"-8\" \"0\" \"9\" \"3\" \"4\" \"8\" \"11\" \"-9\" \"-12\" \"-1\" \"-10\"]",
    "11 9 8 8 8 7 7 6 5 5 5 4 4 3 3 0 0 -1 -1 -2 -4 -5 -7 -8 -8 -9 -9 -10 -10 -11 -12 -12 -12",
    "", false, "seeded-sort-1593",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"4\" \"-9\" \"-11\" \"3\" \"-4\" \"6\" \"-10\" \"0\" \"5\" \"-7\" \"8\" \"-1\" \"-12\" \"8\" \"-2\" \"7\" \"5\" \"-8\" \"-12\" \"7\" \"5\" \"-5\" \"-8\" \"0\" \"9\" \"3\" \"4\" \"8\" \"11\" \"-9\" \"-12\" \"-1\" \"-10\"]",
    "11 31 6 32 2 12 18 30 14 4 21 9 17 22 1 29 7 23 28 3 25 0 26 8 16 20 5 15 19 10 13 27 24",
    "", false, "seeded-sort-1594",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"3\" \"-2\" \"-5\" \"-12\" \"3\" \"12\" \"10\" \"4\" \"-1\" \"-2\" \"6\" \"0\" \"11\" \"-9\" \"-5\" \"9\" \"-9\" \"-6\" \"-9\" \"-2\"]",
    "3 18 17 14 19 8 11 4 7 10 15 6 12 5", "", false, "seeded-sort-1595",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"3\" \"-2\" \"-5\" \"-12\" \"3\" \"12\" \"10\" \"4\" \"-1\" \"-2\" \"6\" \"0\" \"11\" \"-9\" \"-5\" \"9\" \"-9\" \"-6\" \"-9\" \"-2\"]",
    "12 11 10 9 6 4 3 3 0 -1 -2 -2 -2 -5 -5 -6 -9 -9 -9 -12", "", false, "seeded-sort-1596",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"3\" \"-2\" \"-5\" \"-12\" \"3\" \"12\" \"10\" \"4\" \"-1\" \"-2\" \"6\" \"0\" \"11\" \"-9\" \"-5\" \"9\" \"-9\" \"-6\" \"-9\" \"-2\"]",
    "8 3 1 9 19 2 14 17 13 16 18 11 6 12 5 0 4 7 10 15", "", false, "seeded-sort-1597",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"1\" \"7\" \"10\" \"9\" \"2\" \"-9\" \"11\" \"10\" \"1\" \"-9\" \"4\" \"-8\" \"-7\" \"2\" \"12\" \"-7\" \"-9\" \"-6\" \"-2\" \"7\" \"0\" \"-7\"]",
    "16 11 21 17 18 20 8 13 10 19 3 7 6 14", "", false, "seeded-sort-1598",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"1\" \"7\" \"10\" \"9\" \"2\" \"-9\" \"11\" \"10\" \"1\" \"-9\" \"4\" \"-8\" \"-7\" \"2\" \"12\" \"-7\" \"-9\" \"-6\" \"-2\" \"7\" \"0\" \"-7\"]",
    "12 11 10 10 9 7 7 4 2 2 1 1 0 -2 -6 -7 -7 -7 -8 -9 -9 -9", "", false, "seeded-sort-1599",
  )
}

///|
test "Tcl sort cases 1601 through 1640" {
  check_sort_case(
    "lsort -command {string compare} -indices [list \"1\" \"7\" \"10\" \"9\" \"2\" \"-9\" \"11\" \"10\" \"1\" \"-9\" \"4\" \"-8\" \"-7\" \"2\" \"12\" \"-7\" \"-9\" \"-6\" \"-2\" \"7\" \"0\" \"-7\"]",
    "18 17 12 15 21 11 5 9 16 20 0 8 2 7 6 14 4 13 10 1 19 3", "", false, "seeded-sort-1600",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-8\" \"-11\" \"3\" \"4\" \"-10\"]",
    "1 4 0 2 3", "", false, "seeded-sort-1601",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-8\" \"-11\" \"3\" \"4\" \"-10\"]", "4 3 -8 -10 -11",
    "", false, "seeded-sort-1602",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-8\" \"-11\" \"3\" \"4\" \"-10\"]",
    "4 1 0 2 3", "", false, "seeded-sort-1603",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"10\" \"10\" \"-9\" \"6\" \"4\" \"3\" \"-6\" \"11\" \"-4\" \"-2\" \"-12\" \"-3\" \"-9\" \"-11\" \"-10\" \"-4\" \"11\" \"12\" \"-10\" \"-8\" \"5\" \"0\" \"-6\" \"-7\" \"-6\" \"-10\" \"4\" \"10\" \"3\" \"-8\" \"6\" \"9\"]",
    "10 13 25 12 29 23 24 15 11 9 21 28 26 20 30 31 27 16 17", "", false, "seeded-sort-1604",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"10\" \"10\" \"-9\" \"6\" \"4\" \"3\" \"-6\" \"11\" \"-4\" \"-2\" \"-12\" \"-3\" \"-9\" \"-11\" \"-10\" \"-4\" \"11\" \"12\" \"-10\" \"-8\" \"5\" \"0\" \"-6\" \"-7\" \"-6\" \"-10\" \"4\" \"10\" \"3\" \"-8\" \"6\" \"9\"]",
    "12 11 11 10 10 10 9 6 6 5 4 4 3 3 0 -2 -3 -4 -4 -6 -6 -6 -7 -8 -8 -9 -9 -10 -10 -10 -11 -12",
    "", false, "seeded-sort-1605",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"10\" \"10\" \"-9\" \"6\" \"4\" \"3\" \"-6\" \"11\" \"-4\" \"-2\" \"-12\" \"-3\" \"-9\" \"-11\" \"-10\" \"-4\" \"11\" \"12\" \"-10\" \"-8\" \"5\" \"0\" \"-6\" \"-7\" \"-6\" \"-10\" \"4\" \"10\" \"3\" \"-8\" \"6\" \"9\"]",
    "14 18 25 13 10 9 11 8 15 6 22 24 23 19 29 2 12 21 0 1 27 7 16 17 5 28 4 26 20 3 30 31",
    "", false, "seeded-sort-1606",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"9\" \"-6\" \"11\" \"-4\" \"8\" \"9\" \"-12\" \"6\" \"9\" \"6\" \"-3\" \"8\" \"-8\" \"9\" \"8\" \"9\" \"-7\" \"3\" \"1\" \"7\" \"-10\" \"-10\" \"-2\" \"-11\" \"3\"]",
    "6 23 21 12 16 1 3 10 22 18 24 9 19 14 15 2", "", false, "seeded-sort-1607",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"9\" \"-6\" \"11\" \"-4\" \"8\" \"9\" \"-12\" \"6\" \"9\" \"6\" \"-3\" \"8\" \"-8\" \"9\" \"8\" \"9\" \"-7\" \"3\" \"1\" \"7\" \"-10\" \"-10\" \"-2\" \"-11\" \"3\"]",
    "11 9 9 9 9 9 8 8 8 7 6 6 3 3 1 -2 -3 -4 -6 -7 -8 -10 -10 -11 -12", "", false,
    "seeded-sort-1608",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"9\" \"-6\" \"11\" \"-4\" \"8\" \"9\" \"-12\" \"6\" \"9\" \"6\" \"-3\" \"8\" \"-8\" \"9\" \"8\" \"9\" \"-7\" \"3\" \"1\" \"7\" \"-10\" \"-10\" \"-2\" \"-11\" \"3\"]",
    "20 21 23 6 22 10 3 1 16 12 18 2 17 24 7 9 19 4 11 14 0 5 8 13 15", "", false,
    "seeded-sort-1609",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-5\" \"3\" \"-11\" \"5\" \"7\" \"-9\" \"-10\" \"-10\" \"4\" \"-11\" \"4\" \"12\" \"8\" \"-4\" \"8\" \"-6\" \"5\" \"-5\" \"4\" \"-8\" \"-1\" \"8\" \"-6\" \"-8\" \"-10\" \"0\" \"4\" \"-4\" \"-3\"]",
    "9 24 5 23 22 17 27 28 20 25 1 26 16 4 21 11", "", false, "seeded-sort-1610",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-5\" \"3\" \"-11\" \"5\" \"7\" \"-9\" \"-10\" \"-10\" \"4\" \"-11\" \"4\" \"12\" \"8\" \"-4\" \"8\" \"-6\" \"5\" \"-5\" \"4\" \"-8\" \"-1\" \"8\" \"-6\" \"-8\" \"-10\" \"0\" \"4\" \"-4\" \"-3\"]",
    "12 8 8 8 7 5 5 4 4 4 4 3 0 -1 -3 -4 -4 -5 -5 -6 -6 -8 -8 -9 -10 -10 -10 -11 -11",
    "", false, "seeded-sort-1611",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-5\" \"3\" \"-11\" \"5\" \"7\" \"-9\" \"-10\" \"-10\" \"4\" \"-11\" \"4\" \"12\" \"8\" \"-4\" \"8\" \"-6\" \"5\" \"-5\" \"4\" \"-8\" \"-1\" \"8\" \"-6\" \"-8\" \"-10\" \"0\" \"4\" \"-4\" \"-3\"]",
    "20 6 7 24 2 9 28 13 27 0 17 15 22 19 23 5 25 11 1 8 10 18 26 3 16 4 12 14 21",
    "", false, "seeded-sort-1612",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-4\" \"-8\" \"-1\" \"3\" \"0\" \"0\" \"-6\" \"-2\" \"-1\" \"-7\" \"2\" \"11\" \"11\" \"6\" \"-5\" \"8\" \"-12\"]",
    "16 1 9 6 14 0 7 8 5 10 3 13 15 12", "", false, "seeded-sort-1613",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-4\" \"-8\" \"-1\" \"3\" \"0\" \"0\" \"-6\" \"-2\" \"-1\" \"-7\" \"2\" \"11\" \"11\" \"6\" \"-5\" \"8\" \"-12\"]",
    "11 11 8 6 3 2 0 0 -1 -1 -2 -4 -5 -6 -7 -8 -12", "", false, "seeded-sort-1614",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-4\" \"-8\" \"-1\" \"3\" \"0\" \"0\" \"-6\" \"-2\" \"-1\" \"-7\" \"2\" \"11\" \"11\" \"6\" \"-5\" \"8\" \"-12\"]",
    "2 8 16 7 0 14 6 9 1 4 5 11 12 10 3 13 15", "", false, "seeded-sort-1615",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"12\" \"-4\" \"6\" \"-11\" \"-6\" \"0\" \"8\" \"-12\" \"5\" \"-2\" \"2\" \"-1\" \"1\" \"12\" \"-7\" \"-6\" \"-3\" \"11\" \"12\"]",
    "7 3 14 15 1 16 9 11 5 12 10 8 2 6 17 18", "", false, "seeded-sort-1616",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"12\" \"-4\" \"6\" \"-11\" \"-6\" \"0\" \"8\" \"-12\" \"5\" \"-2\" \"2\" \"-1\" \"1\" \"12\" \"-7\" \"-6\" \"-3\" \"11\" \"12\"]",
    "12 12 12 11 8 6 5 2 1 0 -1 -2 -3 -4 -6 -6 -7 -11 -12", "", false, "seeded-sort-1617",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"12\" \"-4\" \"6\" \"-11\" \"-6\" \"0\" \"8\" \"-12\" \"5\" \"-2\" \"2\" \"-1\" \"1\" \"12\" \"-7\" \"-6\" \"-3\" \"11\" \"12\"]",
    "11 3 7 9 16 1 4 15 14 5 12 17 0 13 18 10 8 2 6", "", false, "seeded-sort-1618",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-2\" \"3\" \"-6\" \"-12\" \"11\" \"-1\" \"-8\" \"-1\" \"1\" \"9\" \"-4\" \"-11\" \"10\" \"-12\" \"-5\" \"10\" \"12\" \"2\" \"0\" \"4\"]",
    "13 11 6 2 14 10 0 7 18 8 17 1 19 9 15 4 16", "", false, "seeded-sort-1619",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-2\" \"3\" \"-6\" \"-12\" \"11\" \"-1\" \"-8\" \"-1\" \"1\" \"9\" \"-4\" \"-11\" \"10\" \"-12\" \"-5\" \"10\" \"12\" \"2\" \"0\" \"4\"]",
    "12 11 10 10 9 4 3 2 1 0 -1 -1 -2 -4 -5 -6 -8 -11 -12 -12", "", false, "seeded-sort-1620",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-2\" \"3\" \"-6\" \"-12\" \"11\" \"-1\" \"-8\" \"-1\" \"1\" \"9\" \"-4\" \"-11\" \"10\" \"-12\" \"-5\" \"10\" \"12\" \"2\" \"0\" \"4\"]",
    "5 7 11 3 13 0 10 14 2 6 18 8 12 15 4 16 17 1 19 9", "", false, "seeded-sort-1621",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"0\" \"-12\" \"2\" \"-6\"]", "1 3 0 2",
    "", false, "seeded-sort-1622",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"0\" \"-12\" \"2\" \"-6\"]", "2 0 -6 -12",
    "", false, "seeded-sort-1623",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"0\" \"-12\" \"2\" \"-6\"]",
    "1 3 0 2", "", false, "seeded-sort-1624",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"7\" \"11\" \"6\" \"0\" \"2\" \"-6\" \"-1\" \"6\" \"3\" \"-7\" \"-1\" \"6\" \"5\" \"1\" \"12\" \"9\" \"-3\" \"-12\" \"-12\" \"-3\" \"9\" \"3\" \"0\" \"-12\"]",
    "23 9 5 19 10 22 13 4 21 12 11 0 20 1 14", "", false, "seeded-sort-1625",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"7\" \"11\" \"6\" \"0\" \"2\" \"-6\" \"-1\" \"6\" \"3\" \"-7\" \"-1\" \"6\" \"5\" \"1\" \"12\" \"9\" \"-3\" \"-12\" \"-12\" \"-3\" \"9\" \"3\" \"0\" \"-12\"]",
    "12 11 9 9 7 6 6 6 5 3 3 2 1 0 0 -1 -1 -3 -3 -6 -7 -12 -12 -12", "", false, "seeded-sort-1626",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"7\" \"11\" \"6\" \"0\" \"2\" \"-6\" \"-1\" \"6\" \"3\" \"-7\" \"-1\" \"6\" \"5\" \"1\" \"12\" \"9\" \"-3\" \"-12\" \"-12\" \"-3\" \"9\" \"3\" \"0\" \"-12\"]",
    "6 10 17 18 23 16 19 5 9 3 22 13 1 14 4 8 21 12 2 7 11 0 15 20", "", false, "seeded-sort-1627",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-11\" \"-4\" \"2\" \"-4\" \"-5\" \"-2\" \"8\" \"6\" \"6\" \"-11\" \"0\" \"-11\" \"-3\" \"8\" \"-5\" \"-10\" \"-1\" \"4\" \"4\" \"8\" \"11\" \"-1\" \"-2\" \"-1\" \"-1\" \"-7\" \"6\" \"2\" \"5\" \"-8\" \"-8\" \"6\" \"2\"]",
    "11 15 30 25 14 3 12 22 24 10 32 18 28 31 19 20", "", false, "seeded-sort-1628",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-11\" \"-4\" \"2\" \"-4\" \"-5\" \"-2\" \"8\" \"6\" \"6\" \"-11\" \"0\" \"-11\" \"-3\" \"8\" \"-5\" \"-10\" \"-1\" \"4\" \"4\" \"8\" \"11\" \"-1\" \"-2\" \"-1\" \"-1\" \"-7\" \"6\" \"2\" \"5\" \"-8\" \"-8\" \"6\" \"2\"]",
    "11 8 8 8 6 6 6 6 5 4 4 2 2 2 0 -1 -1 -1 -1 -2 -2 -3 -4 -4 -5 -5 -7 -8 -8 -10 -11 -11 -11",
    "", false, "seeded-sort-1629",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-11\" \"-4\" \"2\" \"-4\" \"-5\" \"-2\" \"8\" \"6\" \"6\" \"-11\" \"0\" \"-11\" \"-3\" \"8\" \"-5\" \"-10\" \"-1\" \"4\" \"4\" \"8\" \"11\" \"-1\" \"-2\" \"-1\" \"-1\" \"-7\" \"6\" \"2\" \"5\" \"-8\" \"-8\" \"6\" \"2\"]",
    "16 21 23 24 15 0 9 11 5 22 12 1 3 4 14 25 29 30 10 20 2 27 32 17 18 28 7 8 26 31 6 13 19",
    "", false, "seeded-sort-1630",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"8\" \"-7\" \"3\" \"1\" \"-4\" \"-8\" \"8\" \"-1\"]",
    "5 1 4 7 3 2 6", "", false, "seeded-sort-1631",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"8\" \"-7\" \"3\" \"1\" \"-4\" \"-8\" \"8\" \"-1\"]",
    "8 8 3 1 -1 -4 -7 -8", "", false, "seeded-sort-1632",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"8\" \"-7\" \"3\" \"1\" \"-4\" \"-8\" \"8\" \"-1\"]",
    "7 4 1 5 3 2 0 6", "", false, "seeded-sort-1633",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"1\" \"3\" \"-12\" \"-3\" \"4\" \"-5\" \"2\" \"4\" \"-7\" \"9\" \"-10\" \"7\" \"5\" \"1\" \"-11\" \"5\" \"12\" \"-12\" \"3\" \"12\" \"-5\" \"6\" \"-4\" \"-12\" \"-9\" \"9\" \"6\" \"6\" \"-12\" \"-4\" \"4\" \"1\"]",
    "28 14 10 24 8 20 29 3 31 6 18 30 15 27 11 25 19", "", false, "seeded-sort-1634",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"1\" \"3\" \"-12\" \"-3\" \"4\" \"-5\" \"2\" \"4\" \"-7\" \"9\" \"-10\" \"7\" \"5\" \"1\" \"-11\" \"5\" \"12\" \"-12\" \"3\" \"12\" \"-5\" \"6\" \"-4\" \"-12\" \"-9\" \"9\" \"6\" \"6\" \"-12\" \"-4\" \"4\" \"1\"]",
    "12 12 9 9 7 6 6 6 5 5 4 4 4 3 3 2 1 1 1 -3 -4 -4 -5 -5 -7 -9 -10 -11 -12 -12 -12 -12",
    "", false, "seeded-sort-1635",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"1\" \"3\" \"-12\" \"-3\" \"4\" \"-5\" \"2\" \"4\" \"-7\" \"9\" \"-10\" \"7\" \"5\" \"1\" \"-11\" \"5\" \"12\" \"-12\" \"3\" \"12\" \"-5\" \"6\" \"-4\" \"-12\" \"-9\" \"9\" \"6\" \"6\" \"-12\" \"-4\" \"4\" \"1\"]",
    "10 14 2 17 23 28 3 22 29 5 20 8 24 0 13 31 16 19 6 1 18 4 7 30 12 15 21 26 27 11 9 25",
    "", false, "seeded-sort-1636",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"1\" \"6\" \"-10\" \"11\" \"9\" \"-4\" \"-8\" \"12\" \"9\" \"8\" \"-4\" \"-3\" \"-8\" \"-10\" \"4\" \"12\" \"1\" \"5\" \"7\" \"10\" \"-6\" \"-8\" \"-6\" \"-11\" \"-11\" \"6\" \"-4\" \"5\" \"-7\" \"-3\"]",
    "24 13 21 28 22 26 29 16 14 27 25 18 9 8 19 3 15", "", false, "seeded-sort-1637",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"1\" \"6\" \"-10\" \"11\" \"9\" \"-4\" \"-8\" \"12\" \"9\" \"8\" \"-4\" \"-3\" \"-8\" \"-10\" \"4\" \"12\" \"1\" \"5\" \"7\" \"10\" \"-6\" \"-8\" \"-6\" \"-11\" \"-11\" \"6\" \"-4\" \"5\" \"-7\" \"-3\"]",
    "12 12 11 10 9 9 8 7 6 6 5 5 4 1 1 -3 -3 -4 -4 -4 -6 -6 -7 -8 -8 -8 -10 -10 -11 -11",
    "", false, "seeded-sort-1638",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"1\" \"6\" \"-10\" \"11\" \"9\" \"-4\" \"-8\" \"12\" \"9\" \"8\" \"-4\" \"-3\" \"-8\" \"-10\" \"4\" \"12\" \"1\" \"5\" \"7\" \"10\" \"-6\" \"-8\" \"-6\" \"-11\" \"-11\" \"6\" \"-4\" \"5\" \"-7\" \"-3\"]",
    "2 13 23 24 11 29 5 10 26 20 22 28 6 12 21 0 16 19 3 7 15 14 17 27 1 25 18 9 4 8",
    "", false, "seeded-sort-1639",
  )
}

///|
test "Tcl sort cases 1641 through 1680" {
  check_sort_case(
    "lsort -integer -unique -indices [list \"-10\" \"-8\" \"12\" \"0\" \"8\" \"-1\" \"7\" \"10\" \"7\" \"4\" \"10\" \"-6\" \"4\" \"5\" \"5\" \"8\" \"-12\" \"8\" \"11\" \"-5\" \"-1\" \"6\" \"-7\" \"4\" \"-12\" \"-11\" \"11\" \"-10\"]",
    "24 25 27 1 22 11 19 20 3 23 14 21 8 17 10 26 2", "", false, "seeded-sort-1640",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-10\" \"-8\" \"12\" \"0\" \"8\" \"-1\" \"7\" \"10\" \"7\" \"4\" \"10\" \"-6\" \"4\" \"5\" \"5\" \"8\" \"-12\" \"8\" \"11\" \"-5\" \"-1\" \"6\" \"-7\" \"4\" \"-12\" \"-11\" \"11\" \"-10\"]",
    "12 11 11 10 10 8 8 8 7 7 6 5 5 4 4 4 0 -1 -1 -5 -6 -7 -8 -10 -10 -11 -12 -12",
    "", false, "seeded-sort-1641",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-10\" \"-8\" \"12\" \"0\" \"8\" \"-1\" \"7\" \"10\" \"7\" \"4\" \"10\" \"-6\" \"4\" \"5\" \"5\" \"8\" \"-12\" \"8\" \"11\" \"-5\" \"-1\" \"6\" \"-7\" \"4\" \"-12\" \"-11\" \"11\" \"-10\"]",
    "5 20 0 27 25 16 24 19 11 22 1 3 7 10 18 26 2 9 12 23 13 14 21 6 8 4 15 17",
    "", false, "seeded-sort-1642",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-9\" \"-5\" \"-7\" \"11\" \"11\" \"11\" \"7\" \"-11\" \"-5\" \"5\" \"-8\" \"-7\" \"3\" \"-7\" \"-8\" \"-1\" \"-12\" \"-5\" \"10\" \"-2\" \"-6\" \"-2\" \"-2\" \"6\" \"3\" \"9\"]",
    "16 7 0 14 13 20 17 22 15 24 9 23 6 25 18 5", "", false, "seeded-sort-1643",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-9\" \"-5\" \"-7\" \"11\" \"11\" \"11\" \"7\" \"-11\" \"-5\" \"5\" \"-8\" \"-7\" \"3\" \"-7\" \"-8\" \"-1\" \"-12\" \"-5\" \"10\" \"-2\" \"-6\" \"-2\" \"-2\" \"6\" \"3\" \"9\"]",
    "11 11 11 10 9 7 6 5 3 3 -1 -2 -2 -2 -5 -5 -5 -6 -7 -7 -7 -8 -8 -9 -11 -12",
    "", false, "seeded-sort-1644",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-9\" \"-5\" \"-7\" \"11\" \"11\" \"11\" \"7\" \"-11\" \"-5\" \"5\" \"-8\" \"-7\" \"3\" \"-7\" \"-8\" \"-1\" \"-12\" \"-5\" \"10\" \"-2\" \"-6\" \"-2\" \"-2\" \"6\" \"3\" \"9\"]",
    "15 7 16 19 21 22 1 8 17 20 2 11 13 10 14 0 18 3 4 5 12 24 9 23 6 25", "", false,
    "seeded-sort-1645",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"9\" \"0\" \"5\"]", "1 2 0", "", false,
    "seeded-sort-1646",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"9\" \"0\" \"5\"]", "9 5 0", "", false, "seeded-sort-1647",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"9\" \"0\" \"5\"]", "1 2 0",
    "", false, "seeded-sort-1648",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"8\" \"7\" \"3\" \"4\" \"2\" \"2\" \"-11\" \"-4\" \"8\" \"-3\" \"2\" \"-5\" \"3\" \"-2\" \"6\"]",
    "6 11 7 9 13 10 12 3 14 1 8", "", false, "seeded-sort-1649",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"8\" \"7\" \"3\" \"4\" \"2\" \"2\" \"-11\" \"-4\" \"8\" \"-3\" \"2\" \"-5\" \"3\" \"-2\" \"6\"]",
    "8 8 7 6 4 3 3 2 2 2 -2 -3 -4 -5 -11", "", false, "seeded-sort-1650",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"8\" \"7\" \"3\" \"4\" \"2\" \"2\" \"-11\" \"-4\" \"8\" \"-3\" \"2\" \"-5\" \"3\" \"-2\" \"6\"]",
    "6 13 9 7 11 4 5 10 2 12 3 14 1 0 8", "", false, "seeded-sort-1651",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"1\" \"0\" \"10\" \"-5\" \"10\" \"5\" \"-12\" \"3\" \"-10\" \"7\" \"5\" \"10\" \"9\" \"11\" \"12\" \"-10\" \"6\" \"2\" \"8\" \"-11\" \"-8\" \"4\" \"2\" \"10\" \"-7\" \"-7\" \"6\" \"-1\" \"-3\" \"4\" \"-11\" \"-12\" \"6\" \"-5\" \"5\" \"-2\" \"-9\" \"-8\" \"-9\" \"-7\" \"-6\" \"-11\" \"-12\" \"6\"]",
    "42 41 15 38 37 39 40 33 28 35 27 1 0 22 7 29 34 43 9 18 12 23 13 14", "", false,
    "seeded-sort-1652",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"1\" \"0\" \"10\" \"-5\" \"10\" \"5\" \"-12\" \"3\" \"-10\" \"7\" \"5\" \"10\" \"9\" \"11\" \"12\" \"-10\" \"6\" \"2\" \"8\" \"-11\" \"-8\" \"4\" \"2\" \"10\" \"-7\" \"-7\" \"6\" \"-1\" \"-3\" \"4\" \"-11\" \"-12\" \"6\" \"-5\" \"5\" \"-2\" \"-9\" \"-8\" \"-9\" \"-7\" \"-6\" \"-11\" \"-12\" \"6\"]",
    "12 11 10 10 10 10 9 8 7 6 6 6 6 5 5 5 4 4 3 2 2 1 0 -1 -2 -3 -5 -5 -6 -7 -7 -7 -8 -8 -9 -9 -10 -10 -11 -11 -11 -12 -12 -12",
    "", false, "seeded-sort-1653",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"1\" \"0\" \"10\" \"-5\" \"10\" \"5\" \"-12\" \"3\" \"-10\" \"7\" \"5\" \"10\" \"9\" \"11\" \"12\" \"-10\" \"6\" \"2\" \"8\" \"-11\" \"-8\" \"4\" \"2\" \"10\" \"-7\" \"-7\" \"6\" \"-1\" \"-3\" \"4\" \"-11\" \"-12\" \"6\" \"-5\" \"5\" \"-2\" \"-9\" \"-8\" \"-9\" \"-7\" \"-6\" \"-11\" \"-12\" \"6\"]",
    "27 8 15 19 30 41 6 31 42 35 28 3 33 40 24 25 39 20 37 36 38 1 0 2 4 11 23 13 14 17 22 7 21 29 5 10 34 16 26 32 43 9 18 12",
    "", false, "seeded-sort-1654",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-3\" \"5\" \"10\" \"-4\" \"-2\" \"6\" \"-9\" \"6\" \"11\" \"-7\" \"2\" \"2\" \"7\" \"8\" \"11\" \"-1\" \"-4\" \"9\" \"8\" \"-2\" \"-7\"]",
    "6 20 16 0 19 15 11 1 7 12 18 17 2 14", "", false, "seeded-sort-1655",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-3\" \"5\" \"10\" \"-4\" \"-2\" \"6\" \"-9\" \"6\" \"11\" \"-7\" \"2\" \"2\" \"7\" \"8\" \"11\" \"-1\" \"-4\" \"9\" \"8\" \"-2\" \"-7\"]",
    "11 11 10 9 8 8 7 6 6 5 2 2 -1 -2 -2 -3 -4 -4 -7 -7 -9", "", false, "seeded-sort-1656",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-3\" \"5\" \"10\" \"-4\" \"-2\" \"6\" \"-9\" \"6\" \"11\" \"-7\" \"2\" \"2\" \"7\" \"8\" \"11\" \"-1\" \"-4\" \"9\" \"8\" \"-2\" \"-7\"]",
    "15 4 19 0 3 16 9 20 6 2 8 14 10 11 1 5 7 12 13 18 17", "", false, "seeded-sort-1657",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-6\" \"-11\" \"-8\" \"-7\"]", "1 2 3 0",
    "", false, "seeded-sort-1658",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-6\" \"-11\" \"-8\" \"-7\"]", "-6 -7 -8 -11",
    "", false, "seeded-sort-1659",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-6\" \"-11\" \"-8\" \"-7\"]",
    "1 0 3 2", "", false, "seeded-sort-1660",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-8\" \"9\" \"6\" \"12\" \"-12\" \"-2\" \"8\" \"5\" \"5\" \"-3\" \"-12\" \"-1\" \"2\" \"-12\" \"12\" \"2\" \"11\" \"-5\" \"3\" \"12\" \"8\" \"12\" \"-7\" \"11\" \"10\" \"1\" \"-5\" \"7\" \"10\" \"3\" \"0\" \"9\"]",
    "13 0 22 26 9 5 11 30 25 15 29 8 2 27 20 31 28 23 21", "", false, "seeded-sort-1661",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-8\" \"9\" \"6\" \"12\" \"-12\" \"-2\" \"8\" \"5\" \"5\" \"-3\" \"-12\" \"-1\" \"2\" \"-12\" \"12\" \"2\" \"11\" \"-5\" \"3\" \"12\" \"8\" \"12\" \"-7\" \"11\" \"10\" \"1\" \"-5\" \"7\" \"10\" \"3\" \"0\" \"9\"]",
    "12 12 12 12 11 11 10 10 9 9 8 8 7 6 5 5 3 3 2 2 1 0 -1 -2 -3 -5 -5 -7 -8 -12 -12 -12",
    "", false, "seeded-sort-1662",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-8\" \"9\" \"6\" \"12\" \"-12\" \"-2\" \"8\" \"5\" \"5\" \"-3\" \"-12\" \"-1\" \"2\" \"-12\" \"12\" \"2\" \"11\" \"-5\" \"3\" \"12\" \"8\" \"12\" \"-7\" \"11\" \"10\" \"1\" \"-5\" \"7\" \"10\" \"3\" \"0\" \"9\"]",
    "11 4 10 13 5 9 17 26 22 0 30 25 24 28 16 23 3 14 19 21 12 15 18 29 7 8 2 27 6 20 1 31",
    "", false, "seeded-sort-1663",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"3\" \"6\" \"-6\" \"10\" \"-6\" \"-9\" \"6\" \"-4\" \"8\" \"0\" \"-2\"]",
    "5 4 7 10 9 0 6 8 3", "", false, "seeded-sort-1664",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"3\" \"6\" \"-6\" \"10\" \"-6\" \"-9\" \"6\" \"-4\" \"8\" \"0\" \"-2\"]",
    "10 8 6 6 3 0 -2 -4 -6 -6 -9", "", false, "seeded-sort-1665",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"3\" \"6\" \"-6\" \"10\" \"-6\" \"-9\" \"6\" \"-4\" \"8\" \"0\" \"-2\"]",
    "10 7 2 4 5 9 3 0 1 6 8", "", false, "seeded-sort-1666",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-12\" \"0\" \"5\" \"10\" \"3\" \"-6\" \"-2\" \"11\" \"12\" \"-10\" \"-5\" \"1\" \"2\" \"-11\"]",
    "0 13 9 5 10 6 1 11 12 4 2 3 7 8", "", false, "seeded-sort-1667",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-12\" \"0\" \"5\" \"10\" \"3\" \"-6\" \"-2\" \"11\" \"12\" \"-10\" \"-5\" \"1\" \"2\" \"-11\"]",
    "12 11 10 5 3 2 1 0 -2 -5 -6 -10 -11 -12", "", false, "seeded-sort-1668",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-12\" \"0\" \"5\" \"10\" \"3\" \"-6\" \"-2\" \"11\" \"12\" \"-10\" \"-5\" \"1\" \"2\" \"-11\"]",
    "9 13 0 6 10 5 1 11 3 7 8 12 4 2", "", false, "seeded-sort-1669",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-3\" \"8\" \"4\" \"-9\" \"-12\" \"-12\" \"3\" \"-2\" \"-3\" \"3\" \"-7\" \"8\" \"11\" \"-10\" \"12\" \"-2\" \"6\" \"-7\" \"3\" \"-11\" \"-12\" \"9\" \"0\" \"7\" \"-9\" \"6\" \"-7\" \"8\" \"10\"]",
    "20 19 13 24 26 8 15 22 18 2 25 23 27 21 28 12 14", "", false, "seeded-sort-1670",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-3\" \"8\" \"4\" \"-9\" \"-12\" \"-12\" \"3\" \"-2\" \"-3\" \"3\" \"-7\" \"8\" \"11\" \"-10\" \"12\" \"-2\" \"6\" \"-7\" \"3\" \"-11\" \"-12\" \"9\" \"0\" \"7\" \"-9\" \"6\" \"-7\" \"8\" \"10\"]",
    "12 11 10 9 8 8 8 7 6 6 4 3 3 3 0 -2 -2 -3 -3 -7 -7 -7 -9 -9 -10 -11 -12 -12 -12",
    "", false, "seeded-sort-1671",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-3\" \"8\" \"4\" \"-9\" \"-12\" \"-12\" \"3\" \"-2\" \"-3\" \"3\" \"-7\" \"8\" \"11\" \"-10\" \"12\" \"-2\" \"6\" \"-7\" \"3\" \"-11\" \"-12\" \"9\" \"0\" \"7\" \"-9\" \"6\" \"-7\" \"8\" \"10\"]",
    "13 19 4 5 20 7 15 0 8 10 17 26 3 24 22 28 12 14 6 9 18 2 16 25 23 1 11 27 21",
    "", false, "seeded-sort-1672",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-5\" \"4\" \"9\" \"8\" \"-3\" \"9\" \"-3\" \"-11\" \"12\" \"2\" \"2\" \"-5\" \"5\" \"7\"]",
    "7 11 6 10 1 12 13 3 5 8", "", false, "seeded-sort-1673",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-5\" \"4\" \"9\" \"8\" \"-3\" \"9\" \"-3\" \"-11\" \"12\" \"2\" \"2\" \"-5\" \"5\" \"7\"]",
    "12 9 9 8 7 5 4 2 2 -3 -3 -5 -5 -11", "", false, "seeded-sort-1674",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-5\" \"4\" \"9\" \"8\" \"-3\" \"9\" \"-3\" \"-11\" \"12\" \"2\" \"2\" \"-5\" \"5\" \"7\"]",
    "7 4 6 0 11 8 9 10 1 12 13 3 2 5", "", false, "seeded-sort-1675",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-8\" \"-2\" \"-12\" \"10\" \"10\" \"12\" \"1\" \"8\"]",
    "2 0 1 6 7 4 5", "", false, "seeded-sort-1676",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-8\" \"-2\" \"-12\" \"10\" \"10\" \"12\" \"1\" \"8\"]",
    "12 10 10 8 1 -2 -8 -12", "", false, "seeded-sort-1677",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-8\" \"-2\" \"-12\" \"10\" \"10\" \"12\" \"1\" \"8\"]",
    "2 1 0 6 3 4 5 7", "", false, "seeded-sort-1678",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-5\"]", "0", "", false, "seeded-sort-1679",
  )
}

///|
test "Tcl sort cases 1681 through 1720" {
  check_sort_case(
    "lsort -integer -decreasing [list \"-5\"]", "-5", "", false, "seeded-sort-1680",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-5\"]", "0", "", false, "seeded-sort-1681",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-1\" \"-10\" \"7\" \"-5\" \"6\" \"5\" \"4\" \"9\" \"-5\" \"6\" \"-1\" \"9\" \"-6\" \"9\" \"0\" \"-4\" \"12\" \"-9\" \"-6\" \"11\" \"-6\" \"3\" \"-12\" \"5\" \"-4\"]",
    "22 1 17 20 8 24 10 14 21 6 23 9 2 13 19 16", "", false, "seeded-sort-1682",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-1\" \"-10\" \"7\" \"-5\" \"6\" \"5\" \"4\" \"9\" \"-5\" \"6\" \"-1\" \"9\" \"-6\" \"9\" \"0\" \"-4\" \"12\" \"-9\" \"-6\" \"11\" \"-6\" \"3\" \"-12\" \"5\" \"-4\"]",
    "12 11 9 9 9 7 6 6 5 5 4 3 0 -1 -1 -4 -4 -5 -5 -6 -6 -6 -9 -10 -12", "", false,
    "seeded-sort-1683",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-1\" \"-10\" \"7\" \"-5\" \"6\" \"5\" \"4\" \"9\" \"-5\" \"6\" \"-1\" \"9\" \"-6\" \"9\" \"0\" \"-4\" \"12\" \"-9\" \"-6\" \"11\" \"-6\" \"3\" \"-12\" \"5\" \"-4\"]",
    "0 10 1 22 15 24 3 8 12 18 20 17 14 19 16 21 6 5 23 4 9 2 7 11 13", "", false,
    "seeded-sort-1684",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"12\" \"-5\" \"-10\" \"10\" \"-1\" \"5\" \"-10\" \"11\" \"-12\" \"-5\" \"8\" \"9\" \"6\" \"-8\" \"-2\" \"-8\" \"-10\" \"12\" \"-3\" \"4\"]",
    "8 16 15 9 18 14 4 19 5 12 10 11 3 7 17", "", false, "seeded-sort-1685",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"12\" \"-5\" \"-10\" \"10\" \"-1\" \"5\" \"-10\" \"11\" \"-12\" \"-5\" \"8\" \"9\" \"6\" \"-8\" \"-2\" \"-8\" \"-10\" \"12\" \"-3\" \"4\"]",
    "12 12 11 10 9 8 6 5 4 -1 -2 -3 -5 -5 -8 -8 -10 -10 -10 -12", "", false, "seeded-sort-1686",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"12\" \"-5\" \"-10\" \"10\" \"-1\" \"5\" \"-10\" \"11\" \"-12\" \"-5\" \"8\" \"9\" \"6\" \"-8\" \"-2\" \"-8\" \"-10\" \"12\" \"-3\" \"4\"]",
    "4 2 6 16 8 14 18 1 9 13 15 3 7 0 17 19 5 12 10 11", "", false, "seeded-sort-1687",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"4\" \"6\" \"-2\" \"-4\" \"0\" \"-1\" \"-4\" \"10\" \"8\" \"-1\" \"-10\" \"3\"]",
    "10 6 2 9 4 11 0 1 8 7", "", false, "seeded-sort-1688",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"4\" \"6\" \"-2\" \"-4\" \"0\" \"-1\" \"-4\" \"10\" \"8\" \"-1\" \"-10\" \"3\"]",
    "10 8 6 4 3 0 -1 -1 -2 -4 -4 -10", "", false, "seeded-sort-1689",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"4\" \"6\" \"-2\" \"-4\" \"0\" \"-1\" \"-4\" \"10\" \"8\" \"-1\" \"-10\" \"3\"]",
    "5 9 10 2 3 6 4 7 11 0 1 8", "", false, "seeded-sort-1690",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-5\" \"-7\" \"1\" \"1\" \"-11\" \"-12\" \"-1\" \"4\" \"7\" \"-4\" \"-7\" \"-11\" \"-2\" \"-1\" \"-11\" \"-5\" \"-6\" \"9\" \"3\" \"5\" \"1\" \"8\" \"6\" \"-2\" \"-12\" \"7\" \"12\" \"6\" \"-11\" \"12\" \"-10\" \"-1\" \"10\"]",
    "24 28 30 10 16 15 9 23 31 20 18 7 19 27 25 21 17 32 29", "", false, "seeded-sort-1691",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-5\" \"-7\" \"1\" \"1\" \"-11\" \"-12\" \"-1\" \"4\" \"7\" \"-4\" \"-7\" \"-11\" \"-2\" \"-1\" \"-11\" \"-5\" \"-6\" \"9\" \"3\" \"5\" \"1\" \"8\" \"6\" \"-2\" \"-12\" \"7\" \"12\" \"6\" \"-11\" \"12\" \"-10\" \"-1\" \"10\"]",
    "12 12 10 9 8 7 7 6 6 5 4 3 1 1 1 -1 -1 -1 -2 -2 -4 -5 -5 -6 -7 -7 -10 -11 -11 -11 -11 -12 -12",
    "", false, "seeded-sort-1692",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-5\" \"-7\" \"1\" \"1\" \"-11\" \"-12\" \"-1\" \"4\" \"7\" \"-4\" \"-7\" \"-11\" \"-2\" \"-1\" \"-11\" \"-5\" \"-6\" \"9\" \"3\" \"5\" \"1\" \"8\" \"6\" \"-2\" \"-12\" \"7\" \"12\" \"6\" \"-11\" \"12\" \"-10\" \"-1\" \"10\"]",
    "6 13 31 30 4 11 14 28 5 24 12 23 9 0 15 16 1 10 2 3 20 32 26 29 18 7 19 22 27 8 25 21 17",
    "", false, "seeded-sort-1693",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-4\" \"-9\" \"-5\" \"12\" \"3\" \"-3\" \"-5\" \"-3\" \"10\" \"-11\" \"5\" \"1\" \"-9\" \"2\" \"-2\"]",
    "9 12 6 0 7 14 11 13 4 10 8 3", "", false, "seeded-sort-1694",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-4\" \"-9\" \"-5\" \"12\" \"3\" \"-3\" \"-5\" \"-3\" \"10\" \"-11\" \"5\" \"1\" \"-9\" \"2\" \"-2\"]",
    "12 10 5 3 2 1 -2 -3 -3 -4 -5 -5 -9 -9 -11", "", false, "seeded-sort-1695",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-4\" \"-9\" \"-5\" \"12\" \"3\" \"-3\" \"-5\" \"-3\" \"10\" \"-11\" \"5\" \"1\" \"-9\" \"2\" \"-2\"]",
    "9 14 5 7 0 2 6 1 12 11 8 3 13 4 10", "", false, "seeded-sort-1696",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"0\" \"4\" \"-11\" \"7\" \"1\" \"8\" \"9\" \"-6\" \"12\" \"8\" \"-8\" \"-1\" \"1\" \"-2\" \"5\" \"3\" \"-9\" \"1\" \"3\" \"-7\" \"3\" \"-10\" \"9\" \"-6\" \"-7\" \"-6\" \"-8\"]",
    "2 21 16 26 24 25 13 11 0 17 20 1 14 3 9 22 8", "", false, "seeded-sort-1697",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"0\" \"4\" \"-11\" \"7\" \"1\" \"8\" \"9\" \"-6\" \"12\" \"8\" \"-8\" \"-1\" \"1\" \"-2\" \"5\" \"3\" \"-9\" \"1\" \"3\" \"-7\" \"3\" \"-10\" \"9\" \"-6\" \"-7\" \"-6\" \"-8\"]",
    "12 9 9 8 8 7 5 4 3 3 3 1 1 1 0 -1 -2 -6 -6 -6 -7 -7 -8 -8 -9 -10 -11", "", false,
    "seeded-sort-1698",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"0\" \"4\" \"-11\" \"7\" \"1\" \"8\" \"9\" \"-6\" \"12\" \"8\" \"-8\" \"-1\" \"1\" \"-2\" \"5\" \"3\" \"-9\" \"1\" \"3\" \"-7\" \"3\" \"-10\" \"9\" \"-6\" \"-7\" \"-6\" \"-8\"]",
    "11 21 2 13 7 23 25 19 24 10 26 16 0 4 12 17 8 15 18 20 1 14 3 5 9 6 22", "",
    false, "seeded-sort-1699",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-2\" \"3\" \"-1\" \"11\" \"-5\" \"0\" \"-5\" \"3\" \"1\" \"11\" \"-11\" \"6\"]",
    "10 6 0 2 5 8 7 11 9", "", false, "seeded-sort-1700",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-2\" \"3\" \"-1\" \"11\" \"-5\" \"0\" \"-5\" \"3\" \"1\" \"11\" \"-11\" \"6\"]",
    "11 11 6 3 3 1 0 -1 -2 -5 -5 -11", "", false, "seeded-sort-1701",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-2\" \"3\" \"-1\" \"11\" \"-5\" \"0\" \"-5\" \"3\" \"1\" \"11\" \"-11\" \"6\"]",
    "2 10 0 4 6 5 8 3 9 1 7 11", "", false, "seeded-sort-1702",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-11\" \"-10\" \"-1\" \"0\" \"-10\" \"8\" \"-3\" \"6\" \"-6\" \"-1\" \"-8\" \"-2\" \"8\" \"-10\" \"12\" \"5\" \"4\" \"-4\" \"-11\" \"11\" \"6\" \"-4\" \"-1\" \"5\"]",
    "18 13 10 8 21 6 11 22 3 16 23 20 12 19 14", "", false, "seeded-sort-1703",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-11\" \"-10\" \"-1\" \"0\" \"-10\" \"8\" \"-3\" \"6\" \"-6\" \"-1\" \"-8\" \"-2\" \"8\" \"-10\" \"12\" \"5\" \"4\" \"-4\" \"-11\" \"11\" \"6\" \"-4\" \"-1\" \"5\"]",
    "12 11 8 8 6 6 5 5 4 0 -1 -1 -1 -2 -3 -4 -4 -6 -8 -10 -10 -10 -11 -11", "", false,
    "seeded-sort-1704",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-11\" \"-10\" \"-1\" \"0\" \"-10\" \"8\" \"-3\" \"6\" \"-6\" \"-1\" \"-8\" \"-2\" \"8\" \"-10\" \"12\" \"5\" \"4\" \"-4\" \"-11\" \"11\" \"6\" \"-4\" \"-1\" \"5\"]",
    "2 9 22 1 4 13 0 18 11 6 17 21 8 10 3 19 14 16 15 23 7 20 5 12", "", false, "seeded-sort-1705",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-1\" \"5\" \"-10\" \"3\" \"5\" \"0\" \"12\" \"4\" \"-11\" \"-12\" \"10\" \"5\" \"-12\" \"7\" \"-9\" \"-4\" \"-8\" \"-3\" \"-10\" \"-8\" \"-9\" \"12\" \"7\" \"8\"]",
    "12 8 18 20 19 15 17 0 5 3 7 11 22 23 10 21", "", false, "seeded-sort-1706",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-1\" \"5\" \"-10\" \"3\" \"5\" \"0\" \"12\" \"4\" \"-11\" \"-12\" \"10\" \"5\" \"-12\" \"7\" \"-9\" \"-4\" \"-8\" \"-3\" \"-10\" \"-8\" \"-9\" \"12\" \"7\" \"8\"]",
    "12 12 10 8 7 7 5 5 5 4 3 0 -1 -3 -4 -8 -8 -9 -9 -10 -10 -11 -12 -12", "", false,
    "seeded-sort-1707",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-1\" \"5\" \"-10\" \"3\" \"5\" \"0\" \"12\" \"4\" \"-11\" \"-12\" \"10\" \"5\" \"-12\" \"7\" \"-9\" \"-4\" \"-8\" \"-3\" \"-10\" \"-8\" \"-9\" \"12\" \"7\" \"8\"]",
    "0 2 18 8 9 12 17 15 16 19 14 20 5 10 6 21 3 7 1 4 11 13 22 23", "", false, "seeded-sort-1708",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"7\" \"11\" \"-10\" \"-1\" \"-5\" \"-6\" \"10\" \"-5\" \"-10\" \"2\" \"-12\" \"10\" \"-10\"]",
    "10 12 5 7 3 9 0 11 1", "", false, "seeded-sort-1709",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"7\" \"11\" \"-10\" \"-1\" \"-5\" \"-6\" \"10\" \"-5\" \"-10\" \"2\" \"-12\" \"10\" \"-10\"]",
    "11 10 10 7 2 -1 -5 -5 -6 -10 -10 -10 -12", "", false, "seeded-sort-1710",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"7\" \"11\" \"-10\" \"-1\" \"-5\" \"-6\" \"10\" \"-5\" \"-10\" \"2\" \"-12\" \"10\" \"-10\"]",
    "3 2 8 12 10 4 7 5 6 11 1 9 0", "", false, "seeded-sort-1711",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-11\" \"-1\"]", "0 1", "", false, "seeded-sort-1712",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-11\" \"-1\"]", "-1 -11", "", false, "seeded-sort-1713",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-11\" \"-1\"]", "1 0", "",
    false, "seeded-sort-1714",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-5\" \"2\" \"1\" \"8\" \"-5\" \"-11\" \"-5\" \"9\" \"7\" \"-9\" \"-8\" \"-5\" \"2\" \"-6\" \"-10\" \"7\" \"1\" \"9\" \"-2\" \"5\" \"-10\" \"5\" \"-6\" \"-1\" \"-7\" \"5\" \"-9\"]",
    "5 20 26 10 24 22 11 18 23 16 12 25 15 3 17", "", false, "seeded-sort-1715",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-5\" \"2\" \"1\" \"8\" \"-5\" \"-11\" \"-5\" \"9\" \"7\" \"-9\" \"-8\" \"-5\" \"2\" \"-6\" \"-10\" \"7\" \"1\" \"9\" \"-2\" \"5\" \"-10\" \"5\" \"-6\" \"-1\" \"-7\" \"5\" \"-9\"]",
    "9 9 8 7 7 5 5 5 2 2 1 1 -1 -2 -5 -5 -5 -5 -6 -6 -7 -8 -9 -9 -10 -10 -11", "",
    false, "seeded-sort-1716",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-5\" \"2\" \"1\" \"8\" \"-5\" \"-11\" \"-5\" \"9\" \"7\" \"-9\" \"-8\" \"-5\" \"2\" \"-6\" \"-10\" \"7\" \"1\" \"9\" \"-2\" \"5\" \"-10\" \"5\" \"-6\" \"-1\" \"-7\" \"5\" \"-9\"]",
    "23 14 20 5 18 0 4 6 11 13 22 24 10 9 26 2 16 1 12 19 21 25 8 15 3 7 17", "",
    false, "seeded-sort-1717",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"12\" \"9\" \"5\" \"-5\" \"1\" \"0\" \"-3\" \"12\" \"-1\" \"-12\" \"4\" \"5\" \"9\" \"6\" \"12\" \"6\" \"-3\" \"9\" \"-5\"]",
    "9 18 16 8 5 4 10 11 15 17 14", "", false, "seeded-sort-1718",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"12\" \"9\" \"5\" \"-5\" \"1\" \"0\" \"-3\" \"12\" \"-1\" \"-12\" \"4\" \"5\" \"9\" \"6\" \"12\" \"6\" \"-3\" \"9\" \"-5\"]",
    "12 12 12 9 9 9 6 6 5 5 4 1 0 -1 -3 -3 -5 -5 -12", "", false, "seeded-sort-1719",
  )
}

///|
test "Tcl sort cases 1721 through 1760" {
  check_sort_case(
    "lsort -command {string compare} -indices [list \"12\" \"9\" \"5\" \"-5\" \"1\" \"0\" \"-3\" \"12\" \"-1\" \"-12\" \"4\" \"5\" \"9\" \"6\" \"12\" \"6\" \"-3\" \"9\" \"-5\"]",
    "8 9 6 16 3 18 5 4 0 7 14 10 2 11 13 15 1 12 17", "", false, "seeded-sort-1720",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"12\" \"7\" \"-2\" \"-9\" \"4\" \"10\" \"-3\" \"-3\" \"8\" \"6\" \"12\" \"10\" \"7\"]",
    "3 7 2 4 9 12 8 11 10", "", false, "seeded-sort-1721",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"12\" \"7\" \"-2\" \"-9\" \"4\" \"10\" \"-3\" \"-3\" \"8\" \"6\" \"12\" \"10\" \"7\"]",
    "12 12 10 10 8 7 7 6 4 -2 -3 -3 -9", "", false, "seeded-sort-1722",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"12\" \"7\" \"-2\" \"-9\" \"4\" \"10\" \"-3\" \"-3\" \"8\" \"6\" \"12\" \"10\" \"7\"]",
    "2 6 7 3 5 11 0 10 4 9 1 12 8", "", false, "seeded-sort-1723",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-12\" \"12\" \"-10\" \"2\" \"-9\" \"-4\"]",
    "0 2 4 5 3 1", "", false, "seeded-sort-1724",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-12\" \"12\" \"-10\" \"2\" \"-9\" \"-4\"]",
    "12 2 -4 -9 -10 -12", "", false, "seeded-sort-1725",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-12\" \"12\" \"-10\" \"2\" \"-9\" \"-4\"]",
    "2 0 5 4 1 3", "", false, "seeded-sort-1726",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-4\" \"9\" \"-1\" \"-8\" \"0\" \"-12\" \"-10\" \"-7\" \"1\" \"7\" \"11\" \"9\" \"-6\" \"-5\" \"-2\"]",
    "5 6 3 7 12 13 0 14 2 4 8 9 11 10", "", false, "seeded-sort-1727",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-4\" \"9\" \"-1\" \"-8\" \"0\" \"-12\" \"-10\" \"-7\" \"1\" \"7\" \"11\" \"9\" \"-6\" \"-5\" \"-2\"]",
    "11 9 9 7 1 0 -1 -2 -4 -5 -6 -7 -8 -10 -12", "", false, "seeded-sort-1728",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-4\" \"9\" \"-1\" \"-8\" \"0\" \"-12\" \"-10\" \"-7\" \"1\" \"7\" \"11\" \"9\" \"-6\" \"-5\" \"-2\"]",
    "2 6 5 14 0 13 12 7 3 4 8 10 9 1 11", "", false, "seeded-sort-1729",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"9\" \"11\" \"-3\" \"-3\" \"-11\" \"11\" \"-1\" \"-1\" \"8\" \"0\" \"9\" \"-1\" \"-9\" \"-6\" \"9\" \"-11\" \"3\" \"-6\" \"7\" \"11\" \"5\" \"4\" \"-4\" \"5\" \"5\" \"-4\" \"-2\" \"10\" \"11\" \"2\"]",
    "15 12 17 25 3 26 11 9 29 16 21 24 18 8 14 27 28", "", false, "seeded-sort-1730",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"9\" \"11\" \"-3\" \"-3\" \"-11\" \"11\" \"-1\" \"-1\" \"8\" \"0\" \"9\" \"-1\" \"-9\" \"-6\" \"9\" \"-11\" \"3\" \"-6\" \"7\" \"11\" \"5\" \"4\" \"-4\" \"5\" \"5\" \"-4\" \"-2\" \"10\" \"11\" \"2\"]",
    "11 11 11 11 10 9 9 9 8 7 5 5 5 4 3 2 0 -1 -1 -1 -2 -3 -3 -4 -4 -6 -6 -9 -11 -11",
    "", false, "seeded-sort-1731",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"9\" \"11\" \"-3\" \"-3\" \"-11\" \"11\" \"-1\" \"-1\" \"8\" \"0\" \"9\" \"-1\" \"-9\" \"-6\" \"9\" \"-11\" \"3\" \"-6\" \"7\" \"11\" \"5\" \"4\" \"-4\" \"5\" \"5\" \"-4\" \"-2\" \"10\" \"11\" \"2\"]",
    "6 7 11 4 15 26 2 3 22 25 13 17 12 9 27 1 5 19 28 29 16 21 20 23 24 18 8 0 10 14",
    "", false, "seeded-sort-1732",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"2\" \"2\" \"-5\" \"12\" \"5\"]", "2 1 4 3",
    "", false, "seeded-sort-1733",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"2\" \"2\" \"-5\" \"12\" \"5\"]", "12 5 2 2 -5",
    "", false, "seeded-sort-1734",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"2\" \"2\" \"-5\" \"12\" \"5\"]",
    "2 3 0 1 4", "", false, "seeded-sort-1735",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-8\" \"2\" \"-2\" \"9\" \"5\" \"-7\" \"0\" \"12\" \"-2\" \"12\" \"12\" \"-3\" \"-1\" \"3\" \"-2\" \"10\" \"6\" \"-3\" \"8\" \"3\" \"0\" \"-6\" \"4\"]",
    "0 5 21 17 14 12 20 1 19 22 4 16 18 3 15 10", "", false, "seeded-sort-1736",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-8\" \"2\" \"-2\" \"9\" \"5\" \"-7\" \"0\" \"12\" \"-2\" \"12\" \"12\" \"-3\" \"-1\" \"3\" \"-2\" \"10\" \"6\" \"-3\" \"8\" \"3\" \"0\" \"-6\" \"4\"]",
    "12 12 12 10 9 8 6 5 4 3 3 2 0 0 -1 -2 -2 -2 -3 -3 -6 -7 -8", "", false, "seeded-sort-1737",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-8\" \"2\" \"-2\" \"9\" \"5\" \"-7\" \"0\" \"12\" \"-2\" \"12\" \"12\" \"-3\" \"-1\" \"3\" \"-2\" \"10\" \"6\" \"-3\" \"8\" \"3\" \"0\" \"-6\" \"4\"]",
    "12 2 8 14 11 17 21 5 0 6 20 15 7 9 10 1 13 19 22 4 16 18 3", "", false, "seeded-sort-1738",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"3\" \"-4\" \"2\" \"8\" \"-1\" \"-8\" \"0\" \"6\" \"10\" \"9\" \"-10\" \"-6\" \"4\" \"1\" \"9\" \"1\" \"6\" \"1\" \"-10\" \"-8\" \"-5\" \"-10\" \"9\" \"4\" \"10\" \"8\" \"4\"]",
    "21 19 11 20 1 4 6 17 2 0 26 16 25 22 24", "", false, "seeded-sort-1739",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"3\" \"-4\" \"2\" \"8\" \"-1\" \"-8\" \"0\" \"6\" \"10\" \"9\" \"-10\" \"-6\" \"4\" \"1\" \"9\" \"1\" \"6\" \"1\" \"-10\" \"-8\" \"-5\" \"-10\" \"9\" \"4\" \"10\" \"8\" \"4\"]",
    "10 10 9 9 9 8 8 6 6 4 4 4 3 2 1 1 1 0 -1 -4 -5 -6 -8 -8 -10 -10 -10", "", false,
    "seeded-sort-1740",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"3\" \"-4\" \"2\" \"8\" \"-1\" \"-8\" \"0\" \"6\" \"10\" \"9\" \"-10\" \"-6\" \"4\" \"1\" \"9\" \"1\" \"6\" \"1\" \"-10\" \"-8\" \"-5\" \"-10\" \"9\" \"4\" \"10\" \"8\" \"4\"]",
    "4 10 18 21 1 20 11 5 19 6 13 15 17 8 24 2 0 12 23 26 7 16 3 25 9 14 22", "",
    false, "seeded-sort-1741",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-8\" \"-1\" \"3\" \"9\" \"-11\" \"-2\" \"5\" \"11\" \"12\" \"11\" \"3\" \"6\" \"-1\" \"2\" \"-5\" \"-5\" \"8\" \"-10\" \"-9\" \"3\" \"2\" \"-5\"]",
    "4 17 18 0 21 5 12 20 19 6 11 16 3 9 8", "", false, "seeded-sort-1742",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-8\" \"-1\" \"3\" \"9\" \"-11\" \"-2\" \"5\" \"11\" \"12\" \"11\" \"3\" \"6\" \"-1\" \"2\" \"-5\" \"-5\" \"8\" \"-10\" \"-9\" \"3\" \"2\" \"-5\"]",
    "12 11 11 9 8 6 5 3 3 3 2 2 -1 -1 -2 -5 -5 -5 -8 -9 -10 -11", "", false, "seeded-sort-1743",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-8\" \"-1\" \"3\" \"9\" \"-11\" \"-2\" \"5\" \"11\" \"12\" \"11\" \"3\" \"6\" \"-1\" \"2\" \"-5\" \"-5\" \"8\" \"-10\" \"-9\" \"3\" \"2\" \"-5\"]",
    "1 12 17 4 5 14 15 21 0 18 7 9 8 13 20 2 10 19 6 11 16 3", "", false, "seeded-sort-1744",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"7\" \"-12\" \"5\" \"-12\" \"1\" \"2\" \"3\" \"-2\" \"10\" \"-8\" \"2\" \"2\" \"11\" \"-2\" \"0\" \"11\" \"8\" \"-6\"]",
    "3 9 17 13 14 4 11 6 2 0 16 8 15", "", false, "seeded-sort-1745",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"7\" \"-12\" \"5\" \"-12\" \"1\" \"2\" \"3\" \"-2\" \"10\" \"-8\" \"2\" \"2\" \"11\" \"-2\" \"0\" \"11\" \"8\" \"-6\"]",
    "11 11 10 8 7 5 3 2 2 2 1 0 -2 -2 -6 -8 -12 -12", "", false, "seeded-sort-1746",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"7\" \"-12\" \"5\" \"-12\" \"1\" \"2\" \"3\" \"-2\" \"10\" \"-8\" \"2\" \"2\" \"11\" \"-2\" \"0\" \"11\" \"8\" \"-6\"]",
    "1 3 7 13 17 9 14 4 8 12 15 5 10 11 6 2 0 16", "", false, "seeded-sort-1747",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"2\" \"11\"]", "0 1", "", false, "seeded-sort-1748",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"2\" \"11\"]", "11 2", "", false, "seeded-sort-1749",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"2\" \"11\"]", "1 0", "", false,
    "seeded-sort-1750",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-9\" \"-6\" \"12\" \"8\" \"-1\" \"2\" \"-12\" \"6\" \"6\" \"-7\" \"5\" \"-8\" \"9\" \"10\" \"9\" \"-8\" \"10\" \"9\" \"12\" \"1\"]",
    "6 0 15 9 1 4 19 5 10 8 3 17 16 18", "", false, "seeded-sort-1751",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-9\" \"-6\" \"12\" \"8\" \"-1\" \"2\" \"-12\" \"6\" \"6\" \"-7\" \"5\" \"-8\" \"9\" \"10\" \"9\" \"-8\" \"10\" \"9\" \"12\" \"1\"]",
    "12 12 10 10 9 9 9 8 6 6 5 2 1 -1 -6 -7 -8 -8 -9 -12", "", false, "seeded-sort-1752",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-9\" \"-6\" \"12\" \"8\" \"-1\" \"2\" \"-12\" \"6\" \"6\" \"-7\" \"5\" \"-8\" \"9\" \"10\" \"9\" \"-8\" \"10\" \"9\" \"12\" \"1\"]",
    "4 6 1 9 11 15 0 19 13 16 2 18 5 10 7 8 3 12 14 17", "", false, "seeded-sort-1753",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"11\" \"-7\" \"-5\" \"11\" \"-2\" \"-10\" \"3\" \"12\" \"-9\"]",
    "5 8 1 2 4 6 3 7", "", false, "seeded-sort-1754",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"11\" \"-7\" \"-5\" \"11\" \"-2\" \"-10\" \"3\" \"12\" \"-9\"]",
    "12 11 11 3 -2 -5 -7 -9 -10", "", false, "seeded-sort-1755",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"11\" \"-7\" \"-5\" \"11\" \"-2\" \"-10\" \"3\" \"12\" \"-9\"]",
    "5 4 2 1 8 0 3 7 6", "", false, "seeded-sort-1756",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"11\" \"10\"]", "1 0", "", false, "seeded-sort-1757",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"11\" \"10\"]", "11 10", "", false, "seeded-sort-1758",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"11\" \"10\"]", "1 0", "", false,
    "seeded-sort-1759",
  )
}

///|
test "Tcl sort cases 1761 through 1800" {
  check_sort_case(
    "lsort -integer -unique -indices [list ]", "", "", false, "seeded-sort-1760",
  )
  check_sort_case(
    "lsort -integer -decreasing [list ]", "", "", false, "seeded-sort-1761",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list ]", "", "", false, "seeded-sort-1762",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-3\" \"0\" \"-10\" \"-12\" \"12\" \"6\" \"-6\" \"10\" \"2\" \"-3\" \"3\" \"-5\"]",
    "3 2 6 11 9 1 8 10 5 7 4", "", false, "seeded-sort-1763",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-3\" \"0\" \"-10\" \"-12\" \"12\" \"6\" \"-6\" \"10\" \"2\" \"-3\" \"3\" \"-5\"]",
    "12 10 6 3 2 0 -3 -3 -5 -6 -10 -12", "", false, "seeded-sort-1764",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-3\" \"0\" \"-10\" \"-12\" \"12\" \"6\" \"-6\" \"10\" \"2\" \"-3\" \"3\" \"-5\"]",
    "2 3 0 9 11 6 1 7 4 8 10 5", "", false, "seeded-sort-1765",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"6\" \"-8\" \"-8\" \"2\" \"-5\" \"12\" \"11\" \"-8\" \"-8\" \"11\" \"-3\" \"-1\" \"-8\" \"12\" \"9\" \"10\" \"1\" \"10\" \"-6\" \"-6\" \"-12\" \"7\" \"6\" \"3\" \"4\"]",
    "20 12 19 4 10 11 16 3 23 24 22 21 14 17 9 13", "", false, "seeded-sort-1766",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"6\" \"-8\" \"-8\" \"2\" \"-5\" \"12\" \"11\" \"-8\" \"-8\" \"11\" \"-3\" \"-1\" \"-8\" \"12\" \"9\" \"10\" \"1\" \"10\" \"-6\" \"-6\" \"-12\" \"7\" \"6\" \"3\" \"4\"]",
    "12 12 11 11 10 10 9 7 6 6 4 3 2 1 -1 -3 -5 -6 -6 -8 -8 -8 -8 -8 -12", "", false,
    "seeded-sort-1767",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"6\" \"-8\" \"-8\" \"2\" \"-5\" \"12\" \"11\" \"-8\" \"-8\" \"11\" \"-3\" \"-1\" \"-8\" \"12\" \"9\" \"10\" \"1\" \"10\" \"-6\" \"-6\" \"-12\" \"7\" \"6\" \"3\" \"4\"]",
    "11 20 10 4 18 19 1 2 7 8 12 16 15 17 6 9 5 13 3 23 24 0 22 21 14", "", false,
    "seeded-sort-1768",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"0\" \"-12\" \"8\" \"-3\" \"2\" \"-6\" \"5\" \"-10\" \"0\" \"-12\" \"6\" \"7\" \"3\" \"3\" \"-6\" \"0\" \"10\" \"6\" \"-4\" \"-2\" \"6\" \"10\" \"-6\" \"-12\" \"-9\" \"-4\"]",
    "23 7 24 22 25 3 19 15 4 13 6 20 11 2 21", "", false, "seeded-sort-1769",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"0\" \"-12\" \"8\" \"-3\" \"2\" \"-6\" \"5\" \"-10\" \"0\" \"-12\" \"6\" \"7\" \"3\" \"3\" \"-6\" \"0\" \"10\" \"6\" \"-4\" \"-2\" \"6\" \"10\" \"-6\" \"-12\" \"-9\" \"-4\"]",
    "10 10 8 7 6 6 6 5 3 3 2 0 0 0 -2 -3 -4 -4 -6 -6 -6 -9 -10 -12 -12 -12", "",
    false, "seeded-sort-1770",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"0\" \"-12\" \"8\" \"-3\" \"2\" \"-6\" \"5\" \"-10\" \"0\" \"-12\" \"6\" \"7\" \"3\" \"3\" \"-6\" \"0\" \"10\" \"6\" \"-4\" \"-2\" \"6\" \"10\" \"-6\" \"-12\" \"-9\" \"-4\"]",
    "7 1 9 23 19 3 18 25 5 14 22 24 0 8 15 16 21 4 12 13 6 10 17 20 11 2", "", false,
    "seeded-sort-1771",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"12\" \"-11\" \"-6\" \"-8\" \"-4\" \"0\" \"-3\" \"5\" \"0\" \"-11\" \"-2\" \"-5\" \"-12\" \"9\" \"1\" \"-11\" \"3\" \"-8\" \"-3\" \"-12\" \"-8\" \"1\" \"-3\" \"-9\" \"-4\" \"-4\" \"8\" \"6\" \"3\" \"8\" \"-5\" \"-5\" \"-9\" \"-11\" \"2\" \"-3\"]",
    "19 33 32 20 2 31 25 35 10 8 21 34 28 7 27 29 13 0", "", false, "seeded-sort-1772",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"12\" \"-11\" \"-6\" \"-8\" \"-4\" \"0\" \"-3\" \"5\" \"0\" \"-11\" \"-2\" \"-5\" \"-12\" \"9\" \"1\" \"-11\" \"3\" \"-8\" \"-3\" \"-12\" \"-8\" \"1\" \"-3\" \"-9\" \"-4\" \"-4\" \"8\" \"6\" \"3\" \"8\" \"-5\" \"-5\" \"-9\" \"-11\" \"2\" \"-3\"]",
    "12 9 8 8 6 5 3 3 2 1 1 0 0 -2 -3 -3 -3 -3 -4 -4 -4 -5 -5 -5 -6 -8 -8 -8 -9 -9 -11 -11 -11 -11 -12 -12",
    "", false, "seeded-sort-1773",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"12\" \"-11\" \"-6\" \"-8\" \"-4\" \"0\" \"-3\" \"5\" \"0\" \"-11\" \"-2\" \"-5\" \"-12\" \"9\" \"1\" \"-11\" \"3\" \"-8\" \"-3\" \"-12\" \"-8\" \"1\" \"-3\" \"-9\" \"-4\" \"-4\" \"8\" \"6\" \"3\" \"8\" \"-5\" \"-5\" \"-9\" \"-11\" \"2\" \"-3\"]",
    "1 9 15 33 12 19 10 6 18 22 35 4 24 25 11 30 31 2 3 17 20 23 32 5 8 14 21 0 34 16 28 7 27 26 29 13",
    "", false, "seeded-sort-1774",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-7\" \"2\" \"-8\" \"11\" \"-4\" \"-4\" \"-6\" \"-5\" \"-8\" \"-2\" \"7\" \"-3\" \"-8\" \"6\" \"-2\" \"-9\"]",
    "15 12 0 6 7 5 11 14 1 13 10 3", "", false, "seeded-sort-1775",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-7\" \"2\" \"-8\" \"11\" \"-4\" \"-4\" \"-6\" \"-5\" \"-8\" \"-2\" \"7\" \"-3\" \"-8\" \"6\" \"-2\" \"-9\"]",
    "11 7 6 2 -2 -2 -3 -4 -4 -5 -6 -7 -8 -8 -8 -9", "", false, "seeded-sort-1776",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-7\" \"2\" \"-8\" \"11\" \"-4\" \"-4\" \"-6\" \"-5\" \"-8\" \"-2\" \"7\" \"-3\" \"-8\" \"6\" \"-2\" \"-9\"]",
    "9 14 11 4 5 7 6 0 2 8 12 15 3 1 13 10", "", false, "seeded-sort-1777",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"3\" \"-4\" \"5\" \"-7\" \"0\" \"12\"]",
    "3 1 4 0 2 5", "", false, "seeded-sort-1778",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"3\" \"-4\" \"5\" \"-7\" \"0\" \"12\"]", "12 5 3 0 -4 -7",
    "", false, "seeded-sort-1779",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"3\" \"-4\" \"5\" \"-7\" \"0\" \"12\"]",
    "1 3 4 5 0 2", "", false, "seeded-sort-1780",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"7\" \"2\"]", "1 0", "", false, "seeded-sort-1781",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"7\" \"2\"]", "7 2", "", false, "seeded-sort-1782",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"7\" \"2\"]", "1 0", "", false,
    "seeded-sort-1783",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"3\" \"-7\" \"3\" \"0\" \"-3\" \"11\" \"8\" \"-7\" \"6\" \"6\" \"2\" \"-8\" \"4\" \"-8\" \"-6\" \"-9\" \"5\" \"-3\" \"-11\" \"11\" \"-5\" \"-12\" \"-1\" \"-9\" \"-4\" \"6\" \"-4\" \"-7\" \"-12\" \"-11\" \"-8\" \"-7\" \"-7\" \"7\" \"-7\" \"3\" \"-12\" \"2\" \"-12\" \"11\" \"5\" \"9\" \"10\"]",
    "38 29 23 30 34 14 20 26 17 22 3 37 35 12 40 25 33 6 41 42 39", "", false, "seeded-sort-1784",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"3\" \"-7\" \"3\" \"0\" \"-3\" \"11\" \"8\" \"-7\" \"6\" \"6\" \"2\" \"-8\" \"4\" \"-8\" \"-6\" \"-9\" \"5\" \"-3\" \"-11\" \"11\" \"-5\" \"-12\" \"-1\" \"-9\" \"-4\" \"6\" \"-4\" \"-7\" \"-12\" \"-11\" \"-8\" \"-7\" \"-7\" \"7\" \"-7\" \"3\" \"-12\" \"2\" \"-12\" \"11\" \"5\" \"9\" \"10\"]",
    "11 11 11 10 9 8 7 6 6 6 5 5 4 3 3 3 2 2 0 -1 -3 -3 -4 -4 -5 -6 -7 -7 -7 -7 -7 -7 -8 -8 -8 -9 -9 -11 -11 -12 -12 -12 -12",
    "", false, "seeded-sort-1785",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"3\" \"-7\" \"3\" \"0\" \"-3\" \"11\" \"8\" \"-7\" \"6\" \"6\" \"2\" \"-8\" \"4\" \"-8\" \"-6\" \"-9\" \"5\" \"-3\" \"-11\" \"11\" \"-5\" \"-12\" \"-1\" \"-9\" \"-4\" \"6\" \"-4\" \"-7\" \"-12\" \"-11\" \"-8\" \"-7\" \"-7\" \"7\" \"-7\" \"3\" \"-12\" \"2\" \"-12\" \"11\" \"5\" \"9\" \"10\"]",
    "22 18 29 21 28 36 38 4 17 24 26 20 14 1 7 27 31 32 34 11 13 30 15 23 3 42 5 19 39 10 37 0 2 35 12 16 40 8 9 25 33 6 41",
    "", false, "seeded-sort-1786",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-12\" \"-9\" \"0\" \"1\" \"4\" \"-10\" \"2\" \"1\" \"6\" \"-1\" \"-12\" \"-4\" \"-3\" \"6\" \"12\" \"-12\" \"-11\" \"10\" \"-7\" \"-7\" \"-2\" \"8\" \"-8\" \"-1\" \"9\" \"-5\" \"-7\" \"11\" \"4\" \"-9\" \"-5\" \"3\" \"7\" \"3\" \"-4\" \"1\"]",
    "15 16 5 29 22 26 30 34 12 20 23 2 35 6 33 28 13 32 21 24 17 27 14", "", false,
    "seeded-sort-1787",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-12\" \"-9\" \"0\" \"1\" \"4\" \"-10\" \"2\" \"1\" \"6\" \"-1\" \"-12\" \"-4\" \"-3\" \"6\" \"12\" \"-12\" \"-11\" \"10\" \"-7\" \"-7\" \"-2\" \"8\" \"-8\" \"-1\" \"9\" \"-5\" \"-7\" \"11\" \"4\" \"-9\" \"-5\" \"3\" \"7\" \"3\" \"-4\" \"1\"]",
    "12 11 10 9 8 7 6 6 4 4 3 3 2 1 1 1 0 -1 -1 -2 -3 -4 -4 -5 -5 -7 -7 -7 -8 -9 -9 -10 -11 -12 -12 -12",
    "", false, "seeded-sort-1788",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-12\" \"-9\" \"0\" \"1\" \"4\" \"-10\" \"2\" \"1\" \"6\" \"-1\" \"-12\" \"-4\" \"-3\" \"6\" \"12\" \"-12\" \"-11\" \"10\" \"-7\" \"-7\" \"-2\" \"8\" \"-8\" \"-1\" \"9\" \"-5\" \"-7\" \"11\" \"4\" \"-9\" \"-5\" \"3\" \"7\" \"3\" \"-4\" \"1\"]",
    "9 23 5 16 0 10 15 20 12 11 34 25 30 18 19 26 22 1 29 2 3 7 35 17 27 14 6 31 33 4 28 8 13 32 21 24",
    "", false, "seeded-sort-1789",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-11\" \"-4\" \"3\" \"-1\" \"-9\" \"6\"]",
    "0 4 1 3 2 5", "", false, "seeded-sort-1790",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-11\" \"-4\" \"3\" \"-1\" \"-9\" \"6\"]",
    "6 3 -1 -4 -9 -11", "", false, "seeded-sort-1791",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-11\" \"-4\" \"3\" \"-1\" \"-9\" \"6\"]",
    "3 0 1 4 2 5", "", false, "seeded-sort-1792",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list ]", "", "", false, "seeded-sort-1793",
  )
  check_sort_case(
    "lsort -integer -decreasing [list ]", "", "", false, "seeded-sort-1794",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list ]", "", "", false, "seeded-sort-1795",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"3\" \"5\" \"-3\" \"11\" \"2\" \"11\" \"8\" \"-5\" \"7\"]",
    "7 2 4 0 1 8 6 5", "", false, "seeded-sort-1796",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"3\" \"5\" \"-3\" \"11\" \"2\" \"11\" \"8\" \"-5\" \"7\"]",
    "11 11 8 7 5 3 2 -3 -5", "", false, "seeded-sort-1797",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"3\" \"5\" \"-3\" \"11\" \"2\" \"11\" \"8\" \"-5\" \"7\"]",
    "2 7 3 5 4 0 1 8 6", "", false, "seeded-sort-1798",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-10\" \"9\" \"8\" \"6\" \"12\"]", "0 3 2 1 4",
    "", false, "seeded-sort-1799",
  )
}

///|
test "Tcl sort cases 1801 through 1840" {
  check_sort_case(
    "lsort -integer -decreasing [list \"-10\" \"9\" \"8\" \"6\" \"12\"]", "12 9 8 6 -10",
    "", false, "seeded-sort-1800",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-10\" \"9\" \"8\" \"6\" \"12\"]",
    "0 4 3 2 1", "", false, "seeded-sort-1801",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-12\" \"-3\" \"-7\" \"10\" \"-12\" \"-1\" \"3\" \"-2\" \"-6\" \"-12\" \"-11\" \"9\" \"-9\" \"-10\"]",
    "9 10 13 12 2 8 1 7 5 6 11 3", "", false, "seeded-sort-1802",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-12\" \"-3\" \"-7\" \"10\" \"-12\" \"-1\" \"3\" \"-2\" \"-6\" \"-12\" \"-11\" \"9\" \"-9\" \"-10\"]",
    "10 9 3 -1 -2 -3 -6 -7 -9 -10 -11 -12 -12 -12", "", false, "seeded-sort-1803",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-12\" \"-3\" \"-7\" \"10\" \"-12\" \"-1\" \"3\" \"-2\" \"-6\" \"-12\" \"-11\" \"9\" \"-9\" \"-10\"]",
    "5 13 10 0 4 9 7 1 8 2 12 3 6 11", "", false, "seeded-sort-1804",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-1\" \"-9\" \"4\" \"-12\" \"-7\" \"-11\" \"-11\" \"-2\" \"-1\" \"-12\" \"-9\" \"1\" \"0\" \"10\" \"9\" \"-5\" \"5\" \"-8\" \"-9\" \"-6\" \"0\" \"-10\" \"7\" \"-9\" \"-9\" \"-12\" \"5\" \"-3\" \"-4\" \"2\" \"2\" \"-11\" \"8\" \"10\"]",
    "25 31 21 24 17 4 19 15 28 27 7 8 20 11 30 2 26 22 32 14 33", "", false, "seeded-sort-1805",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-1\" \"-9\" \"4\" \"-12\" \"-7\" \"-11\" \"-11\" \"-2\" \"-1\" \"-12\" \"-9\" \"1\" \"0\" \"10\" \"9\" \"-5\" \"5\" \"-8\" \"-9\" \"-6\" \"0\" \"-10\" \"7\" \"-9\" \"-9\" \"-12\" \"5\" \"-3\" \"-4\" \"2\" \"2\" \"-11\" \"8\" \"10\"]",
    "10 10 9 8 7 5 5 4 2 2 1 0 0 -1 -1 -2 -3 -4 -5 -6 -7 -8 -9 -9 -9 -9 -9 -10 -11 -11 -11 -12 -12 -12",
    "", false, "seeded-sort-1806",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-1\" \"-9\" \"4\" \"-12\" \"-7\" \"-11\" \"-11\" \"-2\" \"-1\" \"-12\" \"-9\" \"1\" \"0\" \"10\" \"9\" \"-5\" \"5\" \"-8\" \"-9\" \"-6\" \"0\" \"-10\" \"7\" \"-9\" \"-9\" \"-12\" \"5\" \"-3\" \"-4\" \"2\" \"2\" \"-11\" \"8\" \"10\"]",
    "0 8 21 5 6 31 3 9 25 7 27 28 15 19 4 17 1 10 18 23 24 12 20 11 13 33 29 30 2 16 26 22 32 14",
    "", false, "seeded-sort-1807",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-1\" \"7\" \"1\" \"-2\" \"0\" \"3\" \"-5\" \"-11\" \"10\" \"7\" \"7\" \"5\"]",
    "7 6 3 0 4 2 5 11 10 8", "", false, "seeded-sort-1808",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-1\" \"7\" \"1\" \"-2\" \"0\" \"3\" \"-5\" \"-11\" \"10\" \"7\" \"7\" \"5\"]",
    "10 7 7 7 5 3 1 0 -1 -2 -5 -11", "", false, "seeded-sort-1809",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-1\" \"7\" \"1\" \"-2\" \"0\" \"3\" \"-5\" \"-11\" \"10\" \"7\" \"7\" \"5\"]",
    "0 7 3 6 4 2 8 5 11 1 9 10", "", false, "seeded-sort-1810",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"10\" \"-6\" \"-8\" \"-8\" \"7\" \"10\" \"4\"]",
    "3 1 6 4 5", "", false, "seeded-sort-1811",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"10\" \"-6\" \"-8\" \"-8\" \"7\" \"10\" \"4\"]",
    "10 10 7 4 -6 -8 -8", "", false, "seeded-sort-1812",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"10\" \"-6\" \"-8\" \"-8\" \"7\" \"10\" \"4\"]",
    "1 2 3 0 5 6 4", "", false, "seeded-sort-1813",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"1\" \"5\" \"-5\" \"4\" \"2\" \"5\" \"-5\" \"-10\" \"-6\" \"2\" \"4\" \"-10\" \"-9\" \"-11\" \"-12\" \"8\" \"-2\" \"4\" \"-7\" \"-6\" \"3\" \"-2\" \"1\" \"6\" \"2\" \"0\" \"-12\" \"-6\" \"4\" \"-9\"]",
    "26 13 11 29 18 27 6 21 25 22 24 20 28 5 23 15", "", false, "seeded-sort-1814",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"1\" \"5\" \"-5\" \"4\" \"2\" \"5\" \"-5\" \"-10\" \"-6\" \"2\" \"4\" \"-10\" \"-9\" \"-11\" \"-12\" \"8\" \"-2\" \"4\" \"-7\" \"-6\" \"3\" \"-2\" \"1\" \"6\" \"2\" \"0\" \"-12\" \"-6\" \"4\" \"-9\"]",
    "8 6 5 5 4 4 4 4 3 2 2 2 1 1 0 -2 -2 -5 -5 -6 -6 -6 -7 -9 -9 -10 -10 -11 -12 -12",
    "", false, "seeded-sort-1815",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"1\" \"5\" \"-5\" \"4\" \"2\" \"5\" \"-5\" \"-10\" \"-6\" \"2\" \"4\" \"-10\" \"-9\" \"-11\" \"-12\" \"8\" \"-2\" \"4\" \"-7\" \"-6\" \"3\" \"-2\" \"1\" \"6\" \"2\" \"0\" \"-12\" \"-6\" \"4\" \"-9\"]",
    "7 11 13 14 26 16 21 2 6 8 19 27 18 12 29 25 0 22 4 9 24 20 3 10 17 28 1 5 23 15",
    "", false, "seeded-sort-1816",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-9\" \"-3\" \"-12\" \"4\" \"-6\" \"8\" \"1\" \"-3\" \"-12\" \"10\" \"2\" \"-9\" \"-2\" \"-11\" \"-6\" \"-9\" \"7\" \"12\" \"-7\" \"10\" \"8\" \"4\" \"4\" \"-7\" \"9\" \"8\" \"-3\" \"6\" \"2\" \"3\" \"-11\" \"-11\" \"5\" \"-10\" \"-2\" \"-6\" \"3\" \"1\" \"8\" \"-12\" \"8\"]",
    "39 31 33 15 23 35 26 34 37 28 36 22 32 27 16 40 24 19 17", "", false, "seeded-sort-1817",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-9\" \"-3\" \"-12\" \"4\" \"-6\" \"8\" \"1\" \"-3\" \"-12\" \"10\" \"2\" \"-9\" \"-2\" \"-11\" \"-6\" \"-9\" \"7\" \"12\" \"-7\" \"10\" \"8\" \"4\" \"4\" \"-7\" \"9\" \"8\" \"-3\" \"6\" \"2\" \"3\" \"-11\" \"-11\" \"5\" \"-10\" \"-2\" \"-6\" \"3\" \"1\" \"8\" \"-12\" \"8\"]",
    "12 10 10 9 8 8 8 8 8 7 6 5 4 4 4 3 3 2 2 1 1 -2 -2 -3 -3 -3 -6 -6 -6 -7 -7 -9 -9 -9 -10 -11 -11 -11 -12 -12 -12",
    "", false, "seeded-sort-1818",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-9\" \"-3\" \"-12\" \"4\" \"-6\" \"8\" \"1\" \"-3\" \"-12\" \"10\" \"2\" \"-9\" \"-2\" \"-11\" \"-6\" \"-9\" \"7\" \"12\" \"-7\" \"10\" \"8\" \"4\" \"4\" \"-7\" \"9\" \"8\" \"-3\" \"6\" \"2\" \"3\" \"-11\" \"-11\" \"5\" \"-10\" \"-2\" \"-6\" \"3\" \"1\" \"8\" \"-12\" \"8\"]",
    "33 13 30 31 2 8 39 12 34 1 7 26 4 14 35 18 23 0 11 15 6 37 9 19 17 10 28 29 36 3 21 22 32 27 16 5 20 25 38 40 24",
    "", false, "seeded-sort-1819",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"5\" \"-6\" \"-4\" \"-4\" \"-7\" \"-7\" \"3\" \"9\" \"-2\" \"-12\" \"-7\" \"-3\" \"-3\"]",
    "9 10 1 3 12 8 6 0 7", "", false, "seeded-sort-1820",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"5\" \"-6\" \"-4\" \"-4\" \"-7\" \"-7\" \"3\" \"9\" \"-2\" \"-12\" \"-7\" \"-3\" \"-3\"]",
    "9 5 3 -2 -3 -3 -4 -4 -6 -7 -7 -7 -12", "", false, "seeded-sort-1821",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"5\" \"-6\" \"-4\" \"-4\" \"-7\" \"-7\" \"3\" \"9\" \"-2\" \"-12\" \"-7\" \"-3\" \"-3\"]",
    "9 8 11 12 2 3 1 4 5 10 6 0 7", "", false, "seeded-sort-1822",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"7\" \"-11\" \"-5\" \"6\" \"12\" \"6\" \"3\" \"8\" \"-4\" \"4\" \"-2\" \"-9\" \"0\" \"7\" \"-8\" \"3\" \"3\" \"0\" \"2\" \"0\" \"0\" \"1\" \"-3\" \"-10\" \"-5\" \"-10\" \"10\" \"-2\" \"3\" \"7\" \"-7\"]",
    "1 25 11 14 30 24 8 22 27 20 21 18 28 9 5 29 7 26 4", "", false, "seeded-sort-1823",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"7\" \"-11\" \"-5\" \"6\" \"12\" \"6\" \"3\" \"8\" \"-4\" \"4\" \"-2\" \"-9\" \"0\" \"7\" \"-8\" \"3\" \"3\" \"0\" \"2\" \"0\" \"0\" \"1\" \"-3\" \"-10\" \"-5\" \"-10\" \"10\" \"-2\" \"3\" \"7\" \"-7\"]",
    "12 10 8 7 7 7 6 6 4 3 3 3 3 2 1 0 0 0 0 -2 -2 -3 -4 -5 -5 -7 -8 -9 -10 -10 -11",
    "", false, "seeded-sort-1824",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"7\" \"-11\" \"-5\" \"6\" \"12\" \"6\" \"3\" \"8\" \"-4\" \"4\" \"-2\" \"-9\" \"0\" \"7\" \"-8\" \"3\" \"3\" \"0\" \"2\" \"0\" \"0\" \"1\" \"-3\" \"-10\" \"-5\" \"-10\" \"10\" \"-2\" \"3\" \"7\" \"-7\"]",
    "23 25 1 10 27 22 8 2 24 30 14 11 12 17 19 20 21 26 4 18 6 15 16 28 9 3 5 0 13 29 7",
    "", false, "seeded-sort-1825",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"9\" \"-6\" \"8\" \"1\" \"0\" \"0\" \"-7\" \"2\" \"3\" \"4\"]",
    "6 1 5 3 7 8 9 2 0", "", false, "seeded-sort-1826",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"9\" \"-6\" \"8\" \"1\" \"0\" \"0\" \"-7\" \"2\" \"3\" \"4\"]",
    "9 8 4 3 2 1 0 0 -6 -7", "", false, "seeded-sort-1827",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"9\" \"-6\" \"8\" \"1\" \"0\" \"0\" \"-7\" \"2\" \"3\" \"4\"]",
    "1 6 4 5 3 7 8 9 2 0", "", false, "seeded-sort-1828",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-10\" \"7\" \"12\" \"6\" \"-11\" \"-7\" \"-9\"]",
    "4 0 6 5 3 1 2", "", false, "seeded-sort-1829",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-10\" \"7\" \"12\" \"6\" \"-11\" \"-7\" \"-9\"]",
    "12 7 6 -7 -9 -10 -11", "", false, "seeded-sort-1830",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-10\" \"7\" \"12\" \"6\" \"-11\" \"-7\" \"-9\"]",
    "0 4 5 6 2 3 1", "", false, "seeded-sort-1831",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list ]", "", "", false, "seeded-sort-1832",
  )
  check_sort_case(
    "lsort -integer -decreasing [list ]", "", "", false, "seeded-sort-1833",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list ]", "", "", false, "seeded-sort-1834",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"8\" \"-4\" \"4\" \"-11\" \"2\" \"-1\" \"6\" \"1\" \"0\" \"-12\" \"1\" \"4\" \"-2\" \"5\" \"-12\" \"11\" \"-10\" \"2\" \"-11\" \"-10\"]",
    "14 18 19 1 12 5 8 10 17 11 13 6 0 15", "", false, "seeded-sort-1835",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"8\" \"-4\" \"4\" \"-11\" \"2\" \"-1\" \"6\" \"1\" \"0\" \"-12\" \"1\" \"4\" \"-2\" \"5\" \"-12\" \"11\" \"-10\" \"2\" \"-11\" \"-10\"]",
    "11 8 6 5 4 4 2 2 1 1 0 -1 -2 -4 -10 -10 -11 -11 -12 -12", "", false, "seeded-sort-1836",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"8\" \"-4\" \"4\" \"-11\" \"2\" \"-1\" \"6\" \"1\" \"0\" \"-12\" \"1\" \"4\" \"-2\" \"5\" \"-12\" \"11\" \"-10\" \"2\" \"-11\" \"-10\"]",
    "5 16 19 3 18 9 14 12 1 8 7 10 15 4 17 2 11 13 6 0", "", false, "seeded-sort-1837",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"12\" \"-5\" \"9\" \"3\" \"-7\" \"-5\" \"-4\" \"4\" \"8\" \"-12\" \"-9\" \"11\" \"-9\" \"1\" \"-5\" \"-7\" \"4\" \"1\"]",
    "9 12 15 14 6 17 3 16 8 2 11 0", "", false, "seeded-sort-1838",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"12\" \"-5\" \"9\" \"3\" \"-7\" \"-5\" \"-4\" \"4\" \"8\" \"-12\" \"-9\" \"11\" \"-9\" \"1\" \"-5\" \"-7\" \"4\" \"1\"]",
    "12 11 9 8 4 4 3 1 1 -4 -5 -5 -5 -7 -7 -9 -9 -12", "", false, "seeded-sort-1839",
  )
}

///|
test "Tcl sort cases 1841 through 1880" {
  check_sort_case(
    "lsort -command {string compare} -indices [list \"12\" \"-5\" \"9\" \"3\" \"-7\" \"-5\" \"-4\" \"4\" \"8\" \"-12\" \"-9\" \"11\" \"-9\" \"1\" \"-5\" \"-7\" \"4\" \"1\"]",
    "9 6 1 5 14 4 15 10 12 13 17 11 0 3 7 16 8 2", "", false, "seeded-sort-1840",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-7\" \"7\" \"2\" \"9\" \"5\" \"12\" \"3\" \"-1\" \"8\" \"-7\" \"12\" \"0\" \"-7\" \"-5\" \"-9\" \"-7\" \"8\" \"-2\" \"11\" \"11\" \"12\"]",
    "14 15 13 17 7 11 2 6 4 1 16 3 19 20", "", false, "seeded-sort-1841",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-7\" \"7\" \"2\" \"9\" \"5\" \"12\" \"3\" \"-1\" \"8\" \"-7\" \"12\" \"0\" \"-7\" \"-5\" \"-9\" \"-7\" \"8\" \"-2\" \"11\" \"11\" \"12\"]",
    "12 12 12 11 11 9 8 8 7 5 3 2 0 -1 -2 -5 -7 -7 -7 -7 -9", "", false, "seeded-sort-1842",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-7\" \"7\" \"2\" \"9\" \"5\" \"12\" \"3\" \"-1\" \"8\" \"-7\" \"12\" \"0\" \"-7\" \"-5\" \"-9\" \"-7\" \"8\" \"-2\" \"11\" \"11\" \"12\"]",
    "7 17 13 0 9 12 15 14 11 18 19 5 10 20 2 6 4 1 8 16 3", "", false, "seeded-sort-1843",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-6\" \"6\" \"8\" \"-12\" \"6\" \"11\" \"-12\" \"-9\" \"8\" \"5\" \"-4\" \"-12\" \"-7\" \"2\" \"0\" \"-4\" \"-7\" \"-6\" \"-2\" \"6\" \"12\" \"4\" \"-7\" \"-9\"]",
    "11 23 22 17 15 18 14 13 21 9 19 8 5 20", "", false, "seeded-sort-1844",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-6\" \"6\" \"8\" \"-12\" \"6\" \"11\" \"-12\" \"-9\" \"8\" \"5\" \"-4\" \"-12\" \"-7\" \"2\" \"0\" \"-4\" \"-7\" \"-6\" \"-2\" \"6\" \"12\" \"4\" \"-7\" \"-9\"]",
    "12 11 8 8 6 6 6 5 4 2 0 -2 -4 -4 -6 -6 -7 -7 -7 -9 -9 -12 -12 -12", "", false,
    "seeded-sort-1845",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-6\" \"6\" \"8\" \"-12\" \"6\" \"11\" \"-12\" \"-9\" \"8\" \"5\" \"-4\" \"-12\" \"-7\" \"2\" \"0\" \"-4\" \"-7\" \"-6\" \"-2\" \"6\" \"12\" \"4\" \"-7\" \"-9\"]",
    "3 6 11 18 10 15 0 17 12 16 22 7 23 14 5 20 13 21 9 1 4 19 2 8", "", false, "seeded-sort-1846",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-10\" \"-6\" \"0\" \"-10\" \"-10\" \"10\" \"-9\" \"-8\" \"1\" \"8\" \"4\" \"-11\" \"8\" \"11\" \"-2\" \"2\" \"-8\" \"4\" \"5\" \"0\" \"-12\" \"6\" \"6\" \"-10\" \"11\" \"0\" \"8\"]",
    "20 11 23 6 16 1 14 25 8 15 17 18 22 26 5 24", "", false, "seeded-sort-1847",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-10\" \"-6\" \"0\" \"-10\" \"-10\" \"10\" \"-9\" \"-8\" \"1\" \"8\" \"4\" \"-11\" \"8\" \"11\" \"-2\" \"2\" \"-8\" \"4\" \"5\" \"0\" \"-12\" \"6\" \"6\" \"-10\" \"11\" \"0\" \"8\"]",
    "11 11 10 8 8 8 6 6 5 4 4 2 1 0 0 0 -2 -6 -8 -8 -9 -10 -10 -10 -10 -11 -12",
    "", false, "seeded-sort-1848",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-10\" \"-6\" \"0\" \"-10\" \"-10\" \"10\" \"-9\" \"-8\" \"1\" \"8\" \"4\" \"-11\" \"8\" \"11\" \"-2\" \"2\" \"-8\" \"4\" \"5\" \"0\" \"-12\" \"6\" \"6\" \"-10\" \"11\" \"0\" \"8\"]",
    "0 3 4 23 11 20 14 1 7 16 6 2 19 25 8 5 13 24 15 10 17 18 21 22 9 12 26", "",
    false, "seeded-sort-1849",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-12\"]", "0", "", false, "seeded-sort-1850",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-12\"]", "-12", "", false, "seeded-sort-1851",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-12\"]", "0", "", false, "seeded-sort-1852",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-10\" \"-9\" \"0\" \"10\" \"12\" \"-2\" \"4\" \"-7\" \"-8\" \"9\" \"-4\"]",
    "0 1 8 7 10 5 2 6 9 3 4", "", false, "seeded-sort-1853",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-10\" \"-9\" \"0\" \"10\" \"12\" \"-2\" \"4\" \"-7\" \"-8\" \"9\" \"-4\"]",
    "12 10 9 4 0 -2 -4 -7 -8 -9 -10", "", false, "seeded-sort-1854",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-10\" \"-9\" \"0\" \"10\" \"12\" \"-2\" \"4\" \"-7\" \"-8\" \"9\" \"-4\"]",
    "0 5 10 7 8 1 2 3 4 6 9", "", false, "seeded-sort-1855",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"5\" \"-5\" \"-11\" \"-4\" \"-6\" \"-6\" \"-6\" \"-9\" \"3\" \"-1\" \"-8\" \"-12\" \"5\" \"5\" \"-2\" \"7\" \"-7\" \"-2\" \"9\" \"-7\" \"10\" \"-7\" \"6\" \"-6\" \"-2\" \"-4\" \"2\" \"-6\" \"4\" \"11\" \"3\" \"6\" \"-10\" \"-2\" \"-4\"]",
    "11 2 32 7 10 21 27 1 34 33 9 26 30 28 13 31 15 18 20 29", "", false, "seeded-sort-1856",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"5\" \"-5\" \"-11\" \"-4\" \"-6\" \"-6\" \"-6\" \"-9\" \"3\" \"-1\" \"-8\" \"-12\" \"5\" \"5\" \"-2\" \"7\" \"-7\" \"-2\" \"9\" \"-7\" \"10\" \"-7\" \"6\" \"-6\" \"-2\" \"-4\" \"2\" \"-6\" \"4\" \"11\" \"3\" \"6\" \"-10\" \"-2\" \"-4\"]",
    "11 10 9 7 6 6 5 5 5 4 3 3 2 -1 -2 -2 -2 -2 -4 -4 -4 -5 -6 -6 -6 -6 -6 -7 -7 -7 -8 -9 -10 -11 -12",
    "", false, "seeded-sort-1857",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"5\" \"-5\" \"-11\" \"-4\" \"-6\" \"-6\" \"-6\" \"-9\" \"3\" \"-1\" \"-8\" \"-12\" \"5\" \"5\" \"-2\" \"7\" \"-7\" \"-2\" \"9\" \"-7\" \"10\" \"-7\" \"6\" \"-6\" \"-2\" \"-4\" \"2\" \"-6\" \"4\" \"11\" \"3\" \"6\" \"-10\" \"-2\" \"-4\"]",
    "9 32 2 11 14 17 24 33 3 25 34 1 4 5 6 23 27 16 19 21 10 7 20 29 26 8 30 28 0 12 13 22 31 15 18",
    "", false, "seeded-sort-1858",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-6\" \"-3\" \"8\" \"9\" \"-3\" \"-9\" \"1\" \"-2\" \"10\" \"6\" \"5\" \"-12\" \"0\" \"-2\" \"0\" \"-7\" \"8\" \"-8\" \"-5\" \"3\" \"-1\" \"-12\" \"3\" \"1\" \"5\" \"-11\" \"-9\" \"-12\" \"3\" \"-12\" \"11\" \"7\" \"-3\" \"-7\" \"-7\" \"0\" \"-3\" \"-10\" \"-6\" \"-6\" \"7\" \"11\" \"8\" \"0\"]",
    "29 25 37 26 17 34 39 18 36 13 20 43 23 28 24 9 40 42 3 8 41", "", false, "seeded-sort-1859",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-6\" \"-3\" \"8\" \"9\" \"-3\" \"-9\" \"1\" \"-2\" \"10\" \"6\" \"5\" \"-12\" \"0\" \"-2\" \"0\" \"-7\" \"8\" \"-8\" \"-5\" \"3\" \"-1\" \"-12\" \"3\" \"1\" \"5\" \"-11\" \"-9\" \"-12\" \"3\" \"-12\" \"11\" \"7\" \"-3\" \"-7\" \"-7\" \"0\" \"-3\" \"-10\" \"-6\" \"-6\" \"7\" \"11\" \"8\" \"0\"]",
    "11 11 10 9 8 8 8 7 7 6 5 5 3 3 3 1 1 0 0 0 0 -1 -2 -2 -3 -3 -3 -3 -5 -6 -6 -6 -7 -7 -7 -8 -9 -9 -10 -11 -12 -12 -12 -12",
    "", false, "seeded-sort-1860",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-6\" \"-3\" \"8\" \"9\" \"-3\" \"-9\" \"1\" \"-2\" \"10\" \"6\" \"5\" \"-12\" \"0\" \"-2\" \"0\" \"-7\" \"8\" \"-8\" \"-5\" \"3\" \"-1\" \"-12\" \"3\" \"1\" \"5\" \"-11\" \"-9\" \"-12\" \"3\" \"-12\" \"11\" \"7\" \"-3\" \"-7\" \"-7\" \"0\" \"-3\" \"-10\" \"-6\" \"-6\" \"7\" \"11\" \"8\" \"0\"]",
    "20 37 25 11 21 27 29 7 13 1 4 32 36 18 0 38 39 15 33 34 17 5 26 12 14 35 43 6 23 8 30 41 19 22 28 10 24 9 31 40 2 16 42 3",
    "", false, "seeded-sort-1861",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"12\" \"9\" \"-11\" \"0\" \"-8\" \"9\" \"-7\" \"10\" \"5\" \"0\" \"2\" \"7\" \"4\"]",
    "2 4 6 9 10 12 8 11 5 7 0", "", false, "seeded-sort-1862",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"12\" \"9\" \"-11\" \"0\" \"-8\" \"9\" \"-7\" \"10\" \"5\" \"0\" \"2\" \"7\" \"4\"]",
    "12 10 9 9 7 5 4 2 0 0 -7 -8 -11", "", false, "seeded-sort-1863",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"12\" \"9\" \"-11\" \"0\" \"-8\" \"9\" \"-7\" \"10\" \"5\" \"0\" \"2\" \"7\" \"4\"]",
    "2 6 4 3 9 7 0 10 12 8 11 1 5", "", false, "seeded-sort-1864",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"2\" \"8\" \"-3\" \"-6\" \"4\" \"2\" \"-8\" \"5\" \"-2\" \"-9\" \"-5\" \"-2\" \"-10\" \"10\"]",
    "12 9 6 3 10 2 11 5 4 7 1 13", "", false, "seeded-sort-1865",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"2\" \"8\" \"-3\" \"-6\" \"4\" \"2\" \"-8\" \"5\" \"-2\" \"-9\" \"-5\" \"-2\" \"-10\" \"10\"]",
    "10 8 5 4 2 2 -2 -2 -3 -5 -6 -8 -9 -10", "", false, "seeded-sort-1866",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"2\" \"8\" \"-3\" \"-6\" \"4\" \"2\" \"-8\" \"5\" \"-2\" \"-9\" \"-5\" \"-2\" \"-10\" \"10\"]",
    "12 8 11 2 10 3 6 9 13 0 5 4 7 1", "", false, "seeded-sort-1867",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-5\" \"12\" \"7\" \"-9\" \"-2\" \"10\" \"3\" \"-9\" \"-6\" \"-5\" \"-12\" \"-5\" \"-10\" \"0\" \"6\" \"4\" \"0\" \"-4\" \"-7\" \"-12\" \"-11\" \"5\" \"5\" \"4\" \"-4\" \"2\" \"-7\" \"5\" \"7\" \"0\" \"6\" \"-9\" \"-10\" \"-5\" \"-3\" \"3\" \"-11\" \"7\" \"-4\"]",
    "19 36 32 31 26 8 33 38 34 4 29 25 35 23 27 30 37 5 1", "", false, "seeded-sort-1868",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-5\" \"12\" \"7\" \"-9\" \"-2\" \"10\" \"3\" \"-9\" \"-6\" \"-5\" \"-12\" \"-5\" \"-10\" \"0\" \"6\" \"4\" \"0\" \"-4\" \"-7\" \"-12\" \"-11\" \"5\" \"5\" \"4\" \"-4\" \"2\" \"-7\" \"5\" \"7\" \"0\" \"6\" \"-9\" \"-10\" \"-5\" \"-3\" \"3\" \"-11\" \"7\" \"-4\"]",
    "12 10 7 7 7 6 6 5 5 5 4 4 3 3 2 0 0 0 -2 -3 -4 -4 -4 -5 -5 -5 -5 -6 -7 -7 -9 -9 -9 -10 -10 -11 -11 -12 -12",
    "", false, "seeded-sort-1869",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-5\" \"12\" \"7\" \"-9\" \"-2\" \"10\" \"3\" \"-9\" \"-6\" \"-5\" \"-12\" \"-5\" \"-10\" \"0\" \"6\" \"4\" \"0\" \"-4\" \"-7\" \"-12\" \"-11\" \"5\" \"5\" \"4\" \"-4\" \"2\" \"-7\" \"5\" \"7\" \"0\" \"6\" \"-9\" \"-10\" \"-5\" \"-3\" \"3\" \"-11\" \"7\" \"-4\"]",
    "12 32 20 36 10 19 4 34 17 24 38 0 9 11 33 8 18 26 3 7 31 13 16 29 5 1 25 6 35 15 23 21 22 27 14 30 2 28 37",
    "", false, "seeded-sort-1870",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"7\" \"-11\" \"-1\" \"8\" \"6\" \"2\" \"12\" \"9\" \"-6\" \"-11\" \"-2\" \"10\" \"8\" \"-4\" \"12\" \"3\" \"8\" \"0\" \"11\" \"4\" \"11\" \"-5\" \"12\" \"-9\" \"-2\" \"-7\" \"5\" \"11\" \"-1\" \"-1\"]",
    "9 23 25 8 21 13 24 29 17 5 15 19 26 4 0 16 7 11 27 22", "", false, "seeded-sort-1871",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"7\" \"-11\" \"-1\" \"8\" \"6\" \"2\" \"12\" \"9\" \"-6\" \"-11\" \"-2\" \"10\" \"8\" \"-4\" \"12\" \"3\" \"8\" \"0\" \"11\" \"4\" \"11\" \"-5\" \"12\" \"-9\" \"-2\" \"-7\" \"5\" \"11\" \"-1\" \"-1\"]",
    "12 12 12 11 11 11 10 9 8 8 8 7 6 5 4 3 2 0 -1 -1 -1 -2 -2 -4 -5 -6 -7 -9 -11 -11",
    "", false, "seeded-sort-1872",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"7\" \"-11\" \"-1\" \"8\" \"6\" \"2\" \"12\" \"9\" \"-6\" \"-11\" \"-2\" \"10\" \"8\" \"-4\" \"12\" \"3\" \"8\" \"0\" \"11\" \"4\" \"11\" \"-5\" \"12\" \"-9\" \"-2\" \"-7\" \"5\" \"11\" \"-1\" \"-1\"]",
    "2 28 29 1 9 10 24 13 21 8 25 23 17 11 18 20 27 6 14 22 5 15 19 26 4 0 3 12 16 7",
    "", false, "seeded-sort-1873",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-3\" \"2\" \"4\" \"-3\" \"3\" \"9\" \"-1\" \"2\" \"-3\" \"8\" \"10\" \"-3\" \"-1\" \"-8\" \"-9\" \"8\" \"7\" \"-3\" \"0\" \"-2\" \"-3\" \"10\" \"-6\" \"11\" \"-7\" \"-8\" \"-1\" \"9\" \"-7\" \"-11\" \"9\" \"-8\" \"-5\" \"-8\" \"-7\" \"3\" \"1\" \"11\" \"-12\" \"2\"]",
    "38 29 14 33 34 22 32 20 19 26 18 36 39 35 2 16 15 30 21 37", "", false, "seeded-sort-1874",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-3\" \"2\" \"4\" \"-3\" \"3\" \"9\" \"-1\" \"2\" \"-3\" \"8\" \"10\" \"-3\" \"-1\" \"-8\" \"-9\" \"8\" \"7\" \"-3\" \"0\" \"-2\" \"-3\" \"10\" \"-6\" \"11\" \"-7\" \"-8\" \"-1\" \"9\" \"-7\" \"-11\" \"9\" \"-8\" \"-5\" \"-8\" \"-7\" \"3\" \"1\" \"11\" \"-12\" \"2\"]",
    "11 11 10 10 9 9 9 8 8 7 4 3 3 2 2 2 1 0 -1 -1 -1 -2 -3 -3 -3 -3 -3 -3 -5 -6 -7 -7 -7 -8 -8 -8 -8 -9 -11 -12",
    "", false, "seeded-sort-1875",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-3\" \"2\" \"4\" \"-3\" \"3\" \"9\" \"-1\" \"2\" \"-3\" \"8\" \"10\" \"-3\" \"-1\" \"-8\" \"-9\" \"8\" \"7\" \"-3\" \"0\" \"-2\" \"-3\" \"10\" \"-6\" \"11\" \"-7\" \"-8\" \"-1\" \"9\" \"-7\" \"-11\" \"9\" \"-8\" \"-5\" \"-8\" \"-7\" \"3\" \"1\" \"11\" \"-12\" \"2\"]",
    "6 12 26 29 38 19 0 3 8 11 17 20 32 22 24 28 34 13 25 31 33 14 18 36 10 21 23 37 1 7 39 4 35 2 16 9 15 5 27 30",
    "", false, "seeded-sort-1876",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-9\" \"-4\" \"-12\" \"6\" \"-2\" \"4\" \"-11\" \"-9\" \"-3\" \"4\" \"8\" \"6\" \"4\" \"9\" \"-4\" \"-1\" \"3\" \"3\" \"9\" \"-6\" \"-3\" \"-1\" \"10\" \"9\" \"0\" \"-7\" \"-11\" \"-11\" \"-11\" \"-1\" \"9\" \"-1\" \"11\" \"-7\" \"11\"]",
    "2 28 7 33 19 14 20 4 31 24 17 12 11 10 30 22 34", "", false, "seeded-sort-1877",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-9\" \"-4\" \"-12\" \"6\" \"-2\" \"4\" \"-11\" \"-9\" \"-3\" \"4\" \"8\" \"6\" \"4\" \"9\" \"-4\" \"-1\" \"3\" \"3\" \"9\" \"-6\" \"-3\" \"-1\" \"10\" \"9\" \"0\" \"-7\" \"-11\" \"-11\" \"-11\" \"-1\" \"9\" \"-1\" \"11\" \"-7\" \"11\"]",
    "11 11 10 9 9 9 9 8 6 6 4 4 4 3 3 0 -1 -1 -1 -1 -2 -3 -3 -4 -4 -6 -7 -7 -9 -9 -11 -11 -11 -11 -12",
    "", false, "seeded-sort-1878",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-9\" \"-4\" \"-12\" \"6\" \"-2\" \"4\" \"-11\" \"-9\" \"-3\" \"4\" \"8\" \"6\" \"4\" \"9\" \"-4\" \"-1\" \"3\" \"3\" \"9\" \"-6\" \"-3\" \"-1\" \"10\" \"9\" \"0\" \"-7\" \"-11\" \"-11\" \"-11\" \"-1\" \"9\" \"-1\" \"11\" \"-7\" \"11\"]",
    "15 21 29 31 6 26 27 28 2 4 8 20 1 14 19 25 33 0 7 24 22 32 34 16 17 5 9 12 3 11 10 13 18 23 30",
    "", false, "seeded-sort-1879",
  )
}

///|
test "Tcl sort cases 1881 through 1920" {
  check_sort_case(
    "lsort -integer -unique -indices [list \"-4\" \"-7\" \"-6\" \"-10\" \"6\" \"-11\" \"10\" \"1\" \"-2\" \"12\" \"9\" \"3\" \"-6\" \"12\" \"-6\" \"4\" \"-6\" \"-12\" \"-7\" \"11\" \"-4\" \"11\" \"-6\" \"10\" \"2\" \"9\"]",
    "17 5 3 18 22 20 8 7 24 11 15 4 25 23 21 13", "", false, "seeded-sort-1880",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-4\" \"-7\" \"-6\" \"-10\" \"6\" \"-11\" \"10\" \"1\" \"-2\" \"12\" \"9\" \"3\" \"-6\" \"12\" \"-6\" \"4\" \"-6\" \"-12\" \"-7\" \"11\" \"-4\" \"11\" \"-6\" \"10\" \"2\" \"9\"]",
    "12 12 11 11 10 10 9 9 6 4 3 2 1 -2 -4 -4 -6 -6 -6 -6 -6 -7 -7 -10 -11 -12",
    "", false, "seeded-sort-1881",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-4\" \"-7\" \"-6\" \"-10\" \"6\" \"-11\" \"10\" \"1\" \"-2\" \"12\" \"9\" \"3\" \"-6\" \"12\" \"-6\" \"4\" \"-6\" \"-12\" \"-7\" \"11\" \"-4\" \"11\" \"-6\" \"10\" \"2\" \"9\"]",
    "3 5 17 8 0 20 2 12 14 16 22 1 18 7 6 23 19 21 9 13 24 11 15 4 10 25", "", false,
    "seeded-sort-1882",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list ]", "", "", false, "seeded-sort-1883",
  )
  check_sort_case(
    "lsort -integer -decreasing [list ]", "", "", false, "seeded-sort-1884",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list ]", "", "", false, "seeded-sort-1885",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"2\" \"8\" \"-9\" \"8\" \"-6\" \"-3\" \"-4\" \"-12\" \"0\" \"-3\" \"-12\" \"-9\" \"6\" \"5\" \"-7\" \"-9\" \"-12\" \"-1\" \"-1\" \"0\" \"-5\" \"-11\" \"3\" \"3\" \"-7\" \"-3\" \"9\" \"-11\" \"-1\" \"11\" \"9\" \"-8\" \"4\" \"-7\" \"-8\" \"5\" \"2\" \"-3\" \"4\" \"9\"]",
    "16 27 15 34 33 4 20 6 37 28 19 36 23 38 35 12 3 39 29", "", false, "seeded-sort-1886",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"2\" \"8\" \"-9\" \"8\" \"-6\" \"-3\" \"-4\" \"-12\" \"0\" \"-3\" \"-12\" \"-9\" \"6\" \"5\" \"-7\" \"-9\" \"-12\" \"-1\" \"-1\" \"0\" \"-5\" \"-11\" \"3\" \"3\" \"-7\" \"-3\" \"9\" \"-11\" \"-1\" \"11\" \"9\" \"-8\" \"4\" \"-7\" \"-8\" \"5\" \"2\" \"-3\" \"4\" \"9\"]",
    "11 9 9 9 8 8 6 5 5 4 4 3 3 2 2 0 0 -1 -1 -1 -3 -3 -3 -3 -4 -5 -6 -7 -7 -7 -8 -8 -9 -9 -9 -11 -11 -12 -12 -12",
    "", false, "seeded-sort-1887",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"2\" \"8\" \"-9\" \"8\" \"-6\" \"-3\" \"-4\" \"-12\" \"0\" \"-3\" \"-12\" \"-9\" \"6\" \"5\" \"-7\" \"-9\" \"-12\" \"-1\" \"-1\" \"0\" \"-5\" \"-11\" \"3\" \"3\" \"-7\" \"-3\" \"9\" \"-11\" \"-1\" \"11\" \"9\" \"-8\" \"4\" \"-7\" \"-8\" \"5\" \"2\" \"-3\" \"4\" \"9\"]",
    "17 18 28 21 27 7 10 16 5 9 25 37 6 20 4 14 24 33 31 34 2 11 15 8 19 29 0 36 22 23 32 38 13 35 12 1 3 26 30 39",
    "", false, "seeded-sort-1888",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-5\" \"10\" \"6\" \"10\" \"-8\" \"-9\" \"11\" \"-10\" \"-11\" \"-3\" \"9\" \"7\"]",
    "8 7 5 4 0 9 2 11 10 3 6", "", false, "seeded-sort-1889",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-5\" \"10\" \"6\" \"10\" \"-8\" \"-9\" \"11\" \"-10\" \"-11\" \"-3\" \"9\" \"7\"]",
    "11 10 10 9 7 6 -3 -5 -8 -9 -10 -11", "", false, "seeded-sort-1890",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-5\" \"10\" \"6\" \"10\" \"-8\" \"-9\" \"11\" \"-10\" \"-11\" \"-3\" \"9\" \"7\"]",
    "7 8 9 0 4 5 1 3 6 2 11 10", "", false, "seeded-sort-1891",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"0\" \"8\" \"-6\" \"6\" \"-2\" \"-9\" \"8\" \"-12\" \"5\" \"7\" \"-10\" \"7\" \"-1\" \"-8\" \"10\" \"-1\" \"9\" \"-8\" \"-11\" \"-5\" \"-4\" \"0\" \"10\" \"9\" \"1\" \"0\"]",
    "7 18 10 5 17 2 19 20 4 15 25 24 8 3 11 6 23 22", "", false, "seeded-sort-1892",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"0\" \"8\" \"-6\" \"6\" \"-2\" \"-9\" \"8\" \"-12\" \"5\" \"7\" \"-10\" \"7\" \"-1\" \"-8\" \"10\" \"-1\" \"9\" \"-8\" \"-11\" \"-5\" \"-4\" \"0\" \"10\" \"9\" \"1\" \"0\"]",
    "10 10 9 9 8 8 7 7 6 5 1 0 0 0 -1 -1 -2 -4 -5 -6 -8 -8 -9 -10 -11 -12", "", false,
    "seeded-sort-1893",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"0\" \"8\" \"-6\" \"6\" \"-2\" \"-9\" \"8\" \"-12\" \"5\" \"7\" \"-10\" \"7\" \"-1\" \"-8\" \"10\" \"-1\" \"9\" \"-8\" \"-11\" \"-5\" \"-4\" \"0\" \"10\" \"9\" \"1\" \"0\"]",
    "12 15 10 18 7 4 20 19 2 13 17 5 0 21 25 24 14 22 8 3 9 11 1 6 16 23", "", false,
    "seeded-sort-1894",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-2\" \"3\" \"11\" \"11\" \"0\" \"-12\" \"-10\" \"9\" \"11\" \"12\" \"4\" \"11\" \"-2\" \"5\" \"-2\" \"-6\" \"-2\" \"5\" \"1\" \"-10\" \"-9\" \"-11\" \"11\" \"-4\" \"10\" \"-3\" \"-3\" \"-11\" \"8\" \"10\" \"-10\" \"11\" \"8\" \"-2\" \"-2\" \"4\"]",
    "5 27 30 20 15 23 26 34 4 18 1 35 17 32 7 29 31 9", "", false, "seeded-sort-1895",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-2\" \"3\" \"11\" \"11\" \"0\" \"-12\" \"-10\" \"9\" \"11\" \"12\" \"4\" \"11\" \"-2\" \"5\" \"-2\" \"-6\" \"-2\" \"5\" \"1\" \"-10\" \"-9\" \"-11\" \"11\" \"-4\" \"10\" \"-3\" \"-3\" \"-11\" \"8\" \"10\" \"-10\" \"11\" \"8\" \"-2\" \"-2\" \"4\"]",
    "12 11 11 11 11 11 11 10 10 9 8 8 5 5 4 4 3 1 0 -2 -2 -2 -2 -2 -2 -3 -3 -4 -6 -9 -10 -10 -10 -11 -11 -12",
    "", false, "seeded-sort-1896",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-2\" \"3\" \"11\" \"11\" \"0\" \"-12\" \"-10\" \"9\" \"11\" \"12\" \"4\" \"11\" \"-2\" \"5\" \"-2\" \"-6\" \"-2\" \"5\" \"1\" \"-10\" \"-9\" \"-11\" \"11\" \"-4\" \"10\" \"-3\" \"-3\" \"-11\" \"8\" \"10\" \"-10\" \"11\" \"8\" \"-2\" \"-2\" \"4\"]",
    "6 19 30 21 27 5 0 12 14 16 33 34 25 26 23 15 20 4 18 24 29 2 3 8 11 22 31 9 1 10 35 13 17 28 32 7",
    "", false, "seeded-sort-1897",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"-7\" \"11\" \"-4\" \"9\" \"-2\" \"3\" \"4\" \"11\" \"8\" \"-5\" \"-12\" \"5\" \"0\" \"-5\" \"0\" \"-11\" \"3\" \"7\" \"11\" \"-10\" \"5\" \"-9\" \"10\" \"4\" \"6\" \"-4\" \"-9\" \"4\" \"-12\" \"-7\" \"5\" \"0\" \"-12\" \"-3\"]",
    "32 15 19 26 29 13 25 33 4 31 16 27 30 24 17 8 3 22 18", "", false, "seeded-sort-1898",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"-7\" \"11\" \"-4\" \"9\" \"-2\" \"3\" \"4\" \"11\" \"8\" \"-5\" \"-12\" \"5\" \"0\" \"-5\" \"0\" \"-11\" \"3\" \"7\" \"11\" \"-10\" \"5\" \"-9\" \"10\" \"4\" \"6\" \"-4\" \"-9\" \"4\" \"-12\" \"-7\" \"5\" \"0\" \"-12\" \"-3\"]",
    "11 11 11 10 9 8 7 6 5 5 5 4 4 4 3 3 0 0 0 -2 -3 -4 -4 -5 -5 -7 -7 -9 -9 -10 -11 -12 -12 -12",
    "", false, "seeded-sort-1899",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"-7\" \"11\" \"-4\" \"9\" \"-2\" \"3\" \"4\" \"11\" \"8\" \"-5\" \"-12\" \"5\" \"0\" \"-5\" \"0\" \"-11\" \"3\" \"7\" \"11\" \"-10\" \"5\" \"-9\" \"10\" \"4\" \"6\" \"-4\" \"-9\" \"4\" \"-12\" \"-7\" \"5\" \"0\" \"-12\" \"-3\"]",
    "19 15 10 28 32 4 33 2 25 9 13 0 29 21 26 12 14 31 22 1 7 18 5 16 6 23 27 11 20 30 24 17 8 3",
    "", false, "seeded-sort-1900",
  )
  check_sort_case(
    "lsort -integer -unique -indices [list \"7\" \"-4\" \"11\" \"4\" \"-9\" \"1\" \"7\" \"-12\" \"-10\" \"3\" \"9\" \"10\" \"-2\" \"-10\" \"-3\" \"-2\" \"-12\" \"6\" \"2\" \"-12\" \"1\" \"-3\" \"11\" \"-1\" \"8\" \"-12\" \"3\" \"9\" \"-5\" \"-4\" \"1\" \"12\" \"-8\" \"2\" \"12\" \"-2\" \"8\" \"-7\" \"-11\"]",
    "25 38 13 4 32 37 28 29 21 35 23 30 33 26 3 17 6 36 27 11 22 34", "", false,
    "seeded-sort-1901",
  )
  check_sort_case(
    "lsort -integer -decreasing [list \"7\" \"-4\" \"11\" \"4\" \"-9\" \"1\" \"7\" \"-12\" \"-10\" \"3\" \"9\" \"10\" \"-2\" \"-10\" \"-3\" \"-2\" \"-12\" \"6\" \"2\" \"-12\" \"1\" \"-3\" \"11\" \"-1\" \"8\" \"-12\" \"3\" \"9\" \"-5\" \"-4\" \"1\" \"12\" \"-8\" \"2\" \"12\" \"-2\" \"8\" \"-7\" \"-11\"]",
    "12 12 11 11 10 9 9 8 8 7 7 6 4 3 3 2 2 1 1 1 -1 -2 -2 -2 -3 -3 -4 -4 -5 -7 -8 -9 -10 -10 -11 -12 -12 -12 -12",
    "", false, "seeded-sort-1902",
  )
  check_sort_case(
    "lsort -command {string compare} -indices [list \"7\" \"-4\" \"11\" \"4\" \"-9\" \"1\" \"7\" \"-12\" \"-10\" \"3\" \"9\" \"10\" \"-2\" \"-10\" \"-3\" \"-2\" \"-12\" \"6\" \"2\" \"-12\" \"1\" \"-3\" \"11\" \"-1\" \"8\" \"-12\" \"3\" \"9\" \"-5\" \"-4\" \"1\" \"12\" \"-8\" \"2\" \"12\" \"-2\" \"8\" \"-7\" \"-11\"]",
    "23 8 13 38 7 16 19 25 12 15 35 14 21 1 29 28 37 32 4 5 20 30 11 2 22 31 34 18 33 9 26 3 17 0 6 24 36 10 27",
    "", false, "seeded-sort-1903",
  )
  check_sort_case(
    "set code [catch \"lsort \\\"{\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unmatched open brace in list} 0 {TCL VALUE LIST BRACE}", "", false, "list-diagnostics-1904",
  )
  check_sort_case(
    "set code [catch \"lsort -command \\\"{\\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unmatched open brace in list} 0 {TCL VALUE LIST BRACE}", "", false, "list-diagnostics-1905",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"{\\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unmatched open brace in list} 0 {TCL VALUE LIST BRACE}", "", false, "list-diagnostics-1906",
  )
  check_sort_case(
    "set code [catch \"lsort \\\"\\\\\\\"\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unmatched open quote in list} 0 {TCL VALUE LIST QUOTE}", "", false, "list-diagnostics-1907",
  )
  check_sort_case(
    "set code [catch \"lsort -command \\\"\\\\\\\"\\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unmatched open quote in list} 0 {TCL VALUE LIST QUOTE}", "", false, "list-diagnostics-1908",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"\\\\\\\"\\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unmatched open quote in list} 0 {TCL VALUE LIST QUOTE}", "", false, "list-diagnostics-1909",
  )
  check_sort_case(
    "set code [catch \"lsort \\\"{a}x\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {list element in braces followed by \"x\" instead of space} 0 {TCL VALUE LIST JUNK}",
    "", false, "list-diagnostics-1910",
  )
  check_sort_case(
    "set code [catch \"lsort -command \\\"{a}x\\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {list element in braces followed by \"x\" instead of space} 0 {TCL VALUE LIST JUNK}",
    "", false, "list-diagnostics-1911",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"{a}x\\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {list element in braces followed by \"x\" instead of space} 0 {TCL VALUE LIST JUNK}",
    "", false, "list-diagnostics-1912",
  )
  check_sort_case(
    "set code [catch \"lsort \\\"\\\\\\\"a\\\\\\\"x\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {list element in quotes followed by \"x\" instead of space} 0 {TCL VALUE LIST JUNK}",
    "", false, "list-diagnostics-1913",
  )
  check_sort_case(
    "set code [catch \"lsort -command \\\"\\\\\\\"a\\\\\\\"x\\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {list element in quotes followed by \"x\" instead of space} 0 {TCL VALUE LIST JUNK}",
    "", false, "list-diagnostics-1914",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"\\\\\\\"a\\\\\\\"x\\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {list element in quotes followed by \"x\" instead of space} 0 {TCL VALUE LIST JUNK}",
    "", false, "list-diagnostics-1915",
  )
  check_sort_case(
    "set code [catch \"lsort \\\"{a}xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {list element in braces followed by \"xxxxxxxxxxxxxxxxxxxx\" instead of space} 0 {TCL VALUE LIST JUNK}",
    "", false, "list-diagnostics-1916",
  )
  check_sort_case(
    "set code [catch \"lsort -command \\\"{a}xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {list element in braces followed by \"xxxxxxxxxxxxxxxxxxxx\" instead of space} 0 {TCL VALUE LIST JUNK}",
    "", false, "list-diagnostics-1917",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"{a}xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {list element in braces followed by \"xxxxxxxxxxxxxxxxxxxx\" instead of space} 0 {TCL VALUE LIST JUNK}",
    "", false, "list-diagnostics-1918",
  )
  check_sort_case(
    "set code [catch \"lsort \\\"\\\\\\\"a\\\\\\\"汉字\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {list element in quotes followed by \"汉字\" instead of space} 0 {TCL VALUE LIST JUNK}",
    "", false, "list-diagnostics-1919",
  )
}

///|
test "Tcl sort cases 1921 through 1951" {
  check_sort_case(
    "set code [catch \"lsort -command \\\"\\\\\\\"a\\\\\\\"汉字\\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {list element in quotes followed by \"汉字\" instead of space} 0 {TCL VALUE LIST JUNK}",
    "", false, "list-diagnostics-1920",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"\\\\\\\"a\\\\\\\"汉字\\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {list element in quotes followed by \"汉字\" instead of space} 0 {TCL VALUE LIST JUNK}",
    "", false, "list-diagnostics-1921",
  )
  check_sort_case(
    "set code [catch \"lsort \\\"{a}aaaaaaaaaaaaaaaaa汉Z\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {list element in braces followed by \"aaaaaaaaaaaaaaaaa汉\" instead of space} 0 {TCL VALUE LIST JUNK}",
    "", false, "list-diagnostics-1922",
  )
  check_sort_case(
    "set code [catch \"lsort -command \\\"{a}aaaaaaaaaaaaaaaaa汉Z\\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {list element in braces followed by \"aaaaaaaaaaaaaaaaa汉\" instead of space} 0 {TCL VALUE LIST JUNK}",
    "", false, "list-diagnostics-1923",
  )
  check_sort_case(
    "set code [catch \"lsort -index \\\"{a}aaaaaaaaaaaaaaaaa汉Z\\\" {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {list element in braces followed by \"aaaaaaaaaaaaaaaaa汉\" instead of space} 0 {TCL VALUE LIST JUNK}",
    "", false, "list-diagnostics-1924",
  )
  check_sort_case(
    "catch {lsort \"{x}aaaaaaaaaaaaaaaaa汉Z\"} r o;list $r [dict get $o -errorcode]",
    "{list element in braces followed by \"aaaaaaaaaaaaaaaaa汉\" instead of space} {TCL VALUE LIST JUNK}",
    "", false, "byte-limited-diagnostic-1925",
  )
  check_sort_case(
    "catch {lsort \"{x}aaaaaaaaaaaaaaaaaa汉Z\"} r o;list $r [dict get $o -errorcode]",
    "{list element in braces followed by \"aaaaaaaaaaaaaaaaaa\" instead of space} {TCL VALUE LIST JUNK}",
    "", false, "byte-limited-diagnostic-1926",
  )
  check_sort_case(
    "catch {lsort \"{x}aaaaaaaaaaaaaaaaaaa汉Z\"} r o;list $r [dict get $o -errorcode]",
    "{list element in braces followed by \"aaaaaaaaaaaaaaaaaaa\" instead of space} {TCL VALUE LIST JUNK}",
    "", false, "byte-limited-diagnostic-1927",
  )
  check_sort_case(
    "catch {lsort \"{x}aaaaaaaaaaaaaaaaaaaa汉Z\"} r o;list $r [dict get $o -errorcode]",
    "{list element in braces followed by \"aaaaaaaaaaaaaaaaaaaa\" instead of space} {TCL VALUE LIST JUNK}",
    "", false, "byte-limited-diagnostic-1928",
  )
  check_sort_case(
    "catch {lsort \"{x}aaaaaaaaaaaaaaaaa😀Z\"} r o;list $r [dict get $o -errorcode]",
    "{list element in braces followed by \"aaaaaaaaaaaaaaaaa\" instead of space} {TCL VALUE LIST JUNK}",
    "", false, "Known difference local contract: byte-limited-diagnostic-1929",
  )
  check_sort_case(
    "catch {lsort \"{x}aaaaaaaaaaaaaaaaaa😀Z\"} r o;list $r [dict get $o -errorcode]",
    "{list element in braces followed by \"aaaaaaaaaaaaaaaaaa\" instead of space} {TCL VALUE LIST JUNK}",
    "", false, "Known difference local contract: byte-limited-diagnostic-1930",
  )
  check_sort_case(
    "catch {lsort \"{x}aaaaaaaaaaaaaaaaaaa😀Z\"} r o;list $r [dict get $o -errorcode]",
    "{list element in braces followed by \"aaaaaaaaaaaaaaaaaaa\" instead of space} {TCL VALUE LIST JUNK}",
    "", false, "byte-limited-diagnostic-1931",
  )
  check_sort_case(
    "catch {lsort \"{x}aaaaaaaaaaaaaaaaaaaa😀Z\"} r o;list $r [dict get $o -errorcode]",
    "{list element in braces followed by \"aaaaaaaaaaaaaaaaaaaa\" instead of space} {TCL VALUE LIST JUNK}",
    "", false, "byte-limited-diagnostic-1932",
  )
  check_sort_case(
    "catch {lsort \"{x}aaaaaaaaaaaaaaaaa\\x00Z\"} r o;list $r [dict get $o -errorcode]",
    "{list element in braces followed by \"aaaaaaaaaaaaaaaaa\u0000Z\" instead of space} {TCL VALUE LIST JUNK}",
    "", false, "byte-limited-diagnostic-1933",
  )
  check_sort_case(
    "catch {lsort \"{x}aaaaaaaaaaaaaaaaaa\\x00Z\"} r o;list $r [dict get $o -errorcode]",
    "{list element in braces followed by \"aaaaaaaaaaaaaaaaaa\u0000\" instead of space} {TCL VALUE LIST JUNK}",
    "", false, "byte-limited-diagnostic-1934",
  )
  check_sort_case(
    "catch {lsort \"{x}aaaaaaaaaaaaaaaaaaa\\x00Z\"} r o;list $r [dict get $o -errorcode]",
    "{list element in braces followed by \"aaaaaaaaaaaaaaaaaaa\" instead of space} {TCL VALUE LIST JUNK}",
    "", false, "byte-limited-diagnostic-1935",
  )
  check_sort_case(
    "catch {lsort \"{x}aaaaaaaaaaaaaaaaaaaa\\x00Z\"} r o;list $r [dict get $o -errorcode]",
    "{list element in braces followed by \"aaaaaaaaaaaaaaaaaaaa\" instead of space} {TCL VALUE LIST JUNK}",
    "", false, "byte-limited-diagnostic-1936",
  )
  check_sort_case(
    "catch {lsort \"{x}aaaaaaaaaaaaaaaaaéZ\"} r o;list $r [dict get $o -errorcode]",
    "{list element in braces followed by \"aaaaaaaaaaaaaaaaaéZ\" instead of space} {TCL VALUE LIST JUNK}",
    "", false, "byte-limited-diagnostic-1937",
  )
  check_sort_case(
    "catch {lsort \"{x}aaaaaaaaaaaaaaaaaaéZ\"} r o;list $r [dict get $o -errorcode]",
    "{list element in braces followed by \"aaaaaaaaaaaaaaaaaaé\" instead of space} {TCL VALUE LIST JUNK}",
    "", false, "byte-limited-diagnostic-1938",
  )
  check_sort_case(
    "catch {lsort \"{x}aaaaaaaaaaaaaaaaaaaéZ\"} r o;list $r [dict get $o -errorcode]",
    "{list element in braces followed by \"aaaaaaaaaaaaaaaaaaa\" instead of space} {TCL VALUE LIST JUNK}",
    "", false, "byte-limited-diagnostic-1939",
  )
  check_sort_case(
    "catch {lsort \"{x}aaaaaaaaaaaaaaaaaaaaéZ\"} r o;list $r [dict get $o -errorcode]",
    "{list element in braces followed by \"aaaaaaaaaaaaaaaaaaaa\" instead of space} {TCL VALUE LIST JUNK}",
    "", false, "byte-limited-diagnostic-1940",
  )
  check_sort_case(
    "proc cmp {a b} {return -code break x};catch {lsort -command cmp {b a}} r o;list $r [dict get $o -code] [dict get $o -level] [dict get $o -errorcode] [string match {*(-compare command)*} [dict get $o -errorinfo]] [dict get $o -errorline] [info exists ::errorInfo] [info exists ::errorCode]",
    "x 3 0 NONE 1 1 1 1", "", false, "completion-metadata-1941",
  )
  check_sort_case(
    "proc cmp {a b} {return -code break x};catch {lsort -command cmp {b a}} r o;string range [dict get $o -errorinfo] 0 5",
    "x\n    ", "", false, "completion-text-1942",
  )
  check_sort_case(
    "proc cmp {a b} {return -code continue x};catch {lsort -command cmp {b a}} r o;list $r [dict get $o -code] [dict get $o -level] [dict get $o -errorcode] [string match {*(-compare command)*} [dict get $o -errorinfo]] [dict get $o -errorline] [info exists ::errorInfo] [info exists ::errorCode]",
    "x 4 0 NONE 1 1 1 1", "", false, "completion-metadata-1943",
  )
  check_sort_case(
    "proc cmp {a b} {return -code continue x};catch {lsort -command cmp {b a}} r o;string range [dict get $o -errorinfo] 0 5",
    "x\n    ", "", false, "completion-text-1944",
  )
  check_sort_case(
    "proc cmp {a b} {return -code 8 -errorinfo CUSTOM -errorcode {A B} x};catch {lsort -command cmp {b a}} r o;list $r [dict get $o -code] [dict get $o -level] [dict get $o -errorcode] [string match {*(-compare command)*} [dict get $o -errorinfo]] [dict get $o -errorline] [info exists ::errorInfo] [info exists ::errorCode]",
    "x 8 0 NONE 1 1 1 1", "", false, "completion-metadata-1945",
  )
  check_sort_case(
    "proc cmp {a b} {return -code 8 -errorinfo CUSTOM -errorcode {A B} x};catch {lsort -command cmp {b a}} r o;string range [dict get $o -errorinfo] 0 5",
    "x\n    ", "", false, "completion-text-1946",
  )
  check_sort_case(
    "proc cmp {a b} {return -level 2 -errorinfo CUSTOM -errorcode {A B} x};catch {lsort -command cmp {b a}} r o;list $r [dict get $o -code] [dict get $o -level] [dict get $o -errorcode] [string match {*(-compare command)*} [dict get $o -errorinfo]] [dict get $o -errorline] [info exists ::errorInfo] [info exists ::errorCode]",
    "x 0 1 NONE 1 1 1 1", "", false, "completion-metadata-1947",
  )
  check_sort_case(
    "proc cmp {a b} {return -level 2 -errorinfo CUSTOM -errorcode {A B} x};catch {lsort -command cmp {b a}} r o;string range [dict get $o -errorinfo] 0 5",
    "x\n    ", "", false, "completion-text-1948",
  )
  check_sort_case(
    "proc cmp {a b} {return -code error -errorinfo CUSTOM -errorcode {A B} x};catch {lsort -command cmp {b a}} r o;list $r [dict get $o -code] [dict get $o -level] [dict get $o -errorcode] [string match {*(-compare command)*} [dict get $o -errorinfo]] [dict get $o -errorline] [info exists ::errorInfo] [info exists ::errorCode]",
    "x 1 0 {A B} 1 1 1 1", "", false, "completion-metadata-1949",
  )
  check_sort_case(
    "proc cmp {a b} {return -code error -errorinfo CUSTOM -errorcode {A B} x};catch {lsort -command cmp {b a}} r o;string range [dict get $o -errorinfo] 0 5",
    "CUSTOM", "", false, "completion-text-1950",
  )
}
