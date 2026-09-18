// Original programs, expected results evaluated by Tcl 8.6.15. Do not hand-edit.

///|
fn check_array_case(
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
test "Tcl array cases 1 through 40" {
  check_array_case(
    "array set a {};for {set i 0} {$i<0} {incr i} {set a($i) $i};list [array names a] [array get a] [array statistics a]",
    "{} {} {0 entries in table, 4 buckets\nnumber of buckets with 0 entries: 4\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 0.0}",
    "", false, "hash-order-0",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<0} {incr i} {set a($i) $i};for {set i 0} {$i<0} {incr i 2} {unset a($i)};list [array names a] [array statistics a]",
    "{} {0 entries in table, 4 buckets\nnumber of buckets with 0 entries: 4\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 0.0}",
    "", false, "hash-delete-1",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<0} {incr i} {set a($i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{} 0 {} {}", "", false, "cursor-order-2",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<0} {incr i} {set a(k$i) $i};list [array names a] [array get a] [array statistics a]",
    "{} {} {0 entries in table, 4 buckets\nnumber of buckets with 0 entries: 4\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 0.0}",
    "", false, "hash-order-3",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<0} {incr i} {set a(k$i) $i};for {set i 0} {$i<0} {incr i 2} {unset a(k$i)};list [array names a] [array statistics a]",
    "{} {0 entries in table, 4 buckets\nnumber of buckets with 0 entries: 4\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 0.0}",
    "", false, "hash-delete-4",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<0} {incr i} {set a(k$i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{} 0 {} {}", "", false, "cursor-order-5",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<0} {incr i} {set a(same$i) $i};list [array names a] [array get a] [array statistics a]",
    "{} {} {0 entries in table, 4 buckets\nnumber of buckets with 0 entries: 4\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 0.0}",
    "", false, "hash-order-6",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<0} {incr i} {set a(same$i) $i};for {set i 0} {$i<0} {incr i 2} {unset a(same$i)};list [array names a] [array statistics a]",
    "{} {0 entries in table, 4 buckets\nnumber of buckets with 0 entries: 4\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 0.0}",
    "", false, "hash-delete-7",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<0} {incr i} {set a(same$i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{} 0 {} {}", "", false, "cursor-order-8",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<1} {incr i} {set a($i) $i};list [array names a] [array get a] [array statistics a]",
    "0 {0 0} {1 entries in table, 4 buckets\nnumber of buckets with 0 entries: 3\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "hash-order-9",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<1} {incr i} {set a($i) $i};for {set i 0} {$i<1} {incr i 2} {unset a($i)};list [array names a] [array statistics a]",
    "{} {0 entries in table, 4 buckets\nnumber of buckets with 0 entries: 4\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 0.0}",
    "", false, "hash-delete-10",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<1} {incr i} {set a($i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "0 0 {} {}", "", false, "cursor-order-11",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<1} {incr i} {set a(k$i) $i};list [array names a] [array get a] [array statistics a]",
    "k0 {k0 0} {1 entries in table, 4 buckets\nnumber of buckets with 0 entries: 3\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "hash-order-12",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<1} {incr i} {set a(k$i) $i};for {set i 0} {$i<1} {incr i 2} {unset a(k$i)};list [array names a] [array statistics a]",
    "{} {0 entries in table, 4 buckets\nnumber of buckets with 0 entries: 4\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 0.0}",
    "", false, "hash-delete-13",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<1} {incr i} {set a(k$i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "k0 0 {} {}", "", false, "cursor-order-14",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<1} {incr i} {set a(same$i) $i};list [array names a] [array get a] [array statistics a]",
    "same0 {same0 0} {1 entries in table, 4 buckets\nnumber of buckets with 0 entries: 3\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "hash-order-15",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<1} {incr i} {set a(same$i) $i};for {set i 0} {$i<1} {incr i 2} {unset a(same$i)};list [array names a] [array statistics a]",
    "{} {0 entries in table, 4 buckets\nnumber of buckets with 0 entries: 4\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 0.0}",
    "", false, "hash-delete-16",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<1} {incr i} {set a(same$i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "same0 0 {} {}", "", false, "cursor-order-17",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<3} {incr i} {set a($i) $i};list [array names a] [array get a] [array statistics a]",
    "{0 1 2} {0 0 1 1 2 2} {3 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 3\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "hash-order-18",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<3} {incr i} {set a($i) $i};for {set i 0} {$i<3} {incr i 2} {unset a($i)};list [array names a] [array statistics a]",
    "1 {1 entries in table, 4 buckets\nnumber of buckets with 0 entries: 3\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "hash-delete-19",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<3} {incr i} {set a($i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{0 1 2} 0 {} {}", "", false, "cursor-order-20",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<3} {incr i} {set a(k$i) $i};list [array names a] [array get a] [array statistics a]",
    "{k1 k2 k0} {k1 1 k2 2 k0 0} {3 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 3\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "hash-order-21",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<3} {incr i} {set a(k$i) $i};for {set i 0} {$i<3} {incr i 2} {unset a(k$i)};list [array names a] [array statistics a]",
    "k1 {1 entries in table, 4 buckets\nnumber of buckets with 0 entries: 3\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "hash-delete-22",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<3} {incr i} {set a(k$i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{k1 k2 k0} 0 {} {}", "", false, "cursor-order-23",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<3} {incr i} {set a(same$i) $i};list [array names a] [array get a] [array statistics a]",
    "{same2 same0 same1} {same2 2 same0 0 same1 1} {3 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 3\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "hash-order-24",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<3} {incr i} {set a(same$i) $i};for {set i 0} {$i<3} {incr i 2} {unset a(same$i)};list [array names a] [array statistics a]",
    "same1 {1 entries in table, 4 buckets\nnumber of buckets with 0 entries: 3\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "hash-delete-25",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<3} {incr i} {set a(same$i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{same2 same0 same1} 0 {} {}", "", false, "cursor-order-26",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<4} {incr i} {set a($i) $i};list [array names a] [array get a] [array statistics a]",
    "{0 1 2 3} {0 0 1 1 2 2 3 3} {4 entries in table, 4 buckets\nnumber of buckets with 0 entries: 0\nnumber of buckets with 1 entries: 4\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "hash-order-27",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<4} {incr i} {set a($i) $i};for {set i 0} {$i<4} {incr i 2} {unset a($i)};list [array names a] [array statistics a]",
    "{1 3} {2 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 2\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "hash-delete-28",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<4} {incr i} {set a($i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{0 1 2 3} 0 {} {}", "", false, "cursor-order-29",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<4} {incr i} {set a(k$i) $i};list [array names a] [array get a] [array statistics a]",
    "{k1 k2 k3 k0} {k1 1 k2 2 k3 3 k0 0} {4 entries in table, 4 buckets\nnumber of buckets with 0 entries: 0\nnumber of buckets with 1 entries: 4\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "hash-order-30",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<4} {incr i} {set a(k$i) $i};for {set i 0} {$i<4} {incr i 2} {unset a(k$i)};list [array names a] [array statistics a]",
    "{k1 k3} {2 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 2\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "hash-delete-31",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<4} {incr i} {set a(k$i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{k1 k2 k3 k0} 0 {} {}", "", false, "cursor-order-32",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<4} {incr i} {set a(same$i) $i};list [array names a] [array get a] [array statistics a]",
    "{same2 same3 same0 same1} {same2 2 same3 3 same0 0 same1 1} {4 entries in table, 4 buckets\nnumber of buckets with 0 entries: 0\nnumber of buckets with 1 entries: 4\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "hash-order-33",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<4} {incr i} {set a(same$i) $i};for {set i 0} {$i<4} {incr i 2} {unset a(same$i)};list [array names a] [array statistics a]",
    "{same3 same1} {2 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 2\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "hash-delete-34",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<4} {incr i} {set a(same$i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{same2 same3 same0 same1} 0 {} {}", "", false, "cursor-order-35",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<10} {incr i} {set a($i) $i};list [array names a] [array get a] [array statistics a]",
    "{8 4 0 9 5 1 6 2 7 3} {8 8 4 4 0 0 9 9 5 5 1 1 6 6 2 2 7 7 3 3} {10 entries in table, 4 buckets\nnumber of buckets with 0 entries: 0\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 2\nnumber of buckets with 3 entries: 2\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.8}",
    "", false, "hash-order-36",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<10} {incr i} {set a($i) $i};for {set i 0} {$i<10} {incr i 2} {unset a($i)};list [array names a] [array statistics a]",
    "{9 5 1 7 3} {5 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 1\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.8}",
    "", false, "hash-delete-37",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<10} {incr i} {set a($i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{8 4 0 9 5 1 6 2 7 3} 0 {} {}", "", false, "cursor-order-38",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<10} {incr i} {set a(k$i) $i};list [array names a] [array get a] [array statistics a]",
    "{k9 k5 k1 k6 k2 k7 k3 k8 k4 k0} {k9 9 k5 5 k1 1 k6 6 k2 2 k7 7 k3 3 k8 8 k4 4 k0 0} {10 entries in table, 4 buckets\nnumber of buckets with 0 entries: 0\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 2\nnumber of buckets with 3 entries: 2\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.8}",
    "", false, "hash-order-39",
  )
}

///|
test "Tcl array cases 41 through 80" {
  check_array_case(
    "array set a {};for {set i 0} {$i<10} {incr i} {set a(k$i) $i};for {set i 0} {$i<10} {incr i 2} {unset a(k$i)};list [array names a] [array statistics a]",
    "{k9 k5 k1 k7 k3} {5 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 1\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.8}",
    "", false, "hash-delete-40",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<10} {incr i} {set a(k$i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{k9 k5 k1 k6 k2 k7 k3 k8 k4 k0} 0 {} {}", "", false, "cursor-order-41",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<10} {incr i} {set a(same$i) $i};list [array names a] [array get a] [array statistics a]",
    "{same6 same2 same7 same3 same8 same4 same0 same9 same5 same1} {same6 6 same2 2 same7 7 same3 3 same8 8 same4 4 same0 0 same9 9 same5 5 same1 1} {10 entries in table, 4 buckets\nnumber of buckets with 0 entries: 0\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 2\nnumber of buckets with 3 entries: 2\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.8}",
    "", false, "hash-order-42",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<10} {incr i} {set a(same$i) $i};for {set i 0} {$i<10} {incr i 2} {unset a(same$i)};list [array names a] [array statistics a]",
    "{same7 same3 same9 same5 same1} {5 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 1\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.8}",
    "", false, "hash-delete-43",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<10} {incr i} {set a(same$i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{same6 same2 same7 same3 same8 same4 same0 same9 same5 same1} 0 {} {}", "",
    false, "cursor-order-44",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<11} {incr i} {set a($i) $i};list [array names a] [array get a] [array statistics a]",
    "{8 4 0 10 9 5 1 6 2 7 3} {8 8 4 4 0 0 10 10 9 9 5 5 1 1 6 6 2 2 7 7 3 3} {11 entries in table, 4 buckets\nnumber of buckets with 0 entries: 0\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 2\nnumber of buckets with 3 entries: 1\nnumber of buckets with 4 entries: 1\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 2.0}",
    "", false, "hash-order-45",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<11} {incr i} {set a($i) $i};for {set i 0} {$i<11} {incr i 2} {unset a($i)};list [array names a] [array statistics a]",
    "{9 5 1 7 3} {5 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 1\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.8}",
    "", false, "hash-delete-46",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<11} {incr i} {set a($i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{8 4 0 10 9 5 1 6 2 7 3} 0 {} {}", "", false, "cursor-order-47",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<11} {incr i} {set a(k$i) $i};list [array names a] [array get a] [array statistics a]",
    "{k10 k9 k5 k1 k6 k2 k7 k3 k8 k4 k0} {k10 10 k9 9 k5 5 k1 1 k6 6 k2 2 k7 7 k3 3 k8 8 k4 4 k0 0} {11 entries in table, 4 buckets\nnumber of buckets with 0 entries: 0\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 2\nnumber of buckets with 3 entries: 1\nnumber of buckets with 4 entries: 1\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 2.0}",
    "", false, "hash-order-48",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<11} {incr i} {set a(k$i) $i};for {set i 0} {$i<11} {incr i 2} {unset a(k$i)};list [array names a] [array statistics a]",
    "{k9 k5 k1 k7 k3} {5 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 1\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.8}",
    "", false, "hash-delete-49",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<11} {incr i} {set a(k$i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{k10 k9 k5 k1 k6 k2 k7 k3 k8 k4 k0} 0 {} {}", "", false, "cursor-order-50",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<11} {incr i} {set a(same$i) $i};list [array names a] [array get a] [array statistics a]",
    "{same6 same2 same7 same3 same8 same4 same0 same10 same9 same5 same1} {same6 6 same2 2 same7 7 same3 3 same8 8 same4 4 same0 0 same10 10 same9 9 same5 5 same1 1} {11 entries in table, 4 buckets\nnumber of buckets with 0 entries: 0\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 2\nnumber of buckets with 3 entries: 1\nnumber of buckets with 4 entries: 1\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 2.0}",
    "", false, "hash-order-51",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<11} {incr i} {set a(same$i) $i};for {set i 0} {$i<11} {incr i 2} {unset a(same$i)};list [array names a] [array statistics a]",
    "{same7 same3 same9 same5 same1} {5 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 1\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.8}",
    "", false, "hash-delete-52",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<11} {incr i} {set a(same$i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{same6 same2 same7 same3 same8 same4 same0 same10 same9 same5 same1} 0 {} {}",
    "", false, "cursor-order-53",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<12} {incr i} {set a($i) $i};list [array names a] [array get a] [array statistics a]",
    "{0 1 2 3 4 5 6 7 8 9 10 11} {0 0 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 11 11} {12 entries in table, 16 buckets\nnumber of buckets with 0 entries: 5\nnumber of buckets with 1 entries: 10\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.1}",
    "", false, "hash-order-54",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<12} {incr i} {set a($i) $i};for {set i 0} {$i<12} {incr i 2} {unset a($i)};list [array names a] [array statistics a]",
    "{1 3 5 7 9 11} {6 entries in table, 16 buckets\nnumber of buckets with 0 entries: 10\nnumber of buckets with 1 entries: 6\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "hash-delete-55",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<12} {incr i} {set a($i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{0 1 2 3 4 5 6 7 8 9 10 11} 0 {} {}", "", false, "cursor-order-56",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<12} {incr i} {set a(k$i) $i};list [array names a] [array get a] [array statistics a]",
    "{k0 k1 k10 k2 k11 k3 k4 k5 k6 k7 k8 k9} {k0 0 k1 1 k10 10 k2 2 k11 11 k3 3 k4 4 k5 5 k6 6 k7 7 k8 8 k9 9} {12 entries in table, 16 buckets\nnumber of buckets with 0 entries: 6\nnumber of buckets with 1 entries: 8\nnumber of buckets with 2 entries: 2\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.2}",
    "", false, "hash-order-57",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<12} {incr i} {set a(k$i) $i};for {set i 0} {$i<12} {incr i 2} {unset a(k$i)};list [array names a] [array statistics a]",
    "{k1 k11 k3 k5 k7 k9} {6 entries in table, 16 buckets\nnumber of buckets with 0 entries: 10\nnumber of buckets with 1 entries: 6\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "hash-delete-58",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<12} {incr i} {set a(k$i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{k0 k1 k10 k2 k11 k3 k4 k5 k6 k7 k8 k9} 0 {} {}", "", false, "cursor-order-59",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<12} {incr i} {set a(same$i) $i};list [array names a] [array get a] [array statistics a]",
    "{same11 same0 same1 same2 same3 same4 same5 same6 same7 same8 same9 same10} {same11 11 same0 0 same1 1 same2 2 same3 3 same4 4 same5 5 same6 6 same7 7 same8 8 same9 9 same10 10} {12 entries in table, 16 buckets\nnumber of buckets with 0 entries: 5\nnumber of buckets with 1 entries: 10\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.1}",
    "", false, "hash-order-60",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<12} {incr i} {set a(same$i) $i};for {set i 0} {$i<12} {incr i 2} {unset a(same$i)};list [array names a] [array statistics a]",
    "{same11 same1 same3 same5 same7 same9} {6 entries in table, 16 buckets\nnumber of buckets with 0 entries: 10\nnumber of buckets with 1 entries: 6\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "hash-delete-61",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<12} {incr i} {set a(same$i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{same11 same0 same1 same2 same3 same4 same5 same6 same7 same8 same9 same10} 0 {} {}",
    "", false, "cursor-order-62",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<13} {incr i} {set a($i) $i};list [array names a] [array get a] [array statistics a]",
    "{0 1 2 3 4 5 6 7 8 9 10 11 12} {0 0 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 11 11 12 12} {13 entries in table, 16 buckets\nnumber of buckets with 0 entries: 4\nnumber of buckets with 1 entries: 11\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.1}",
    "", false, "hash-order-63",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<13} {incr i} {set a($i) $i};for {set i 0} {$i<13} {incr i 2} {unset a($i)};list [array names a] [array statistics a]",
    "{1 3 5 7 9 11} {6 entries in table, 16 buckets\nnumber of buckets with 0 entries: 10\nnumber of buckets with 1 entries: 6\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "hash-delete-64",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<13} {incr i} {set a($i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{0 1 2 3 4 5 6 7 8 9 10 11 12} 0 {} {}", "", false, "cursor-order-65",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<13} {incr i} {set a(k$i) $i};list [array names a] [array get a] [array statistics a]",
    "{k0 k1 k10 k2 k11 k12 k3 k4 k5 k6 k7 k8 k9} {k0 0 k1 1 k10 10 k2 2 k11 11 k12 12 k3 3 k4 4 k5 5 k6 6 k7 7 k8 8 k9 9} {13 entries in table, 16 buckets\nnumber of buckets with 0 entries: 6\nnumber of buckets with 1 entries: 7\nnumber of buckets with 2 entries: 3\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.2}",
    "", false, "hash-order-66",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<13} {incr i} {set a(k$i) $i};for {set i 0} {$i<13} {incr i 2} {unset a(k$i)};list [array names a] [array statistics a]",
    "{k1 k11 k3 k5 k7 k9} {6 entries in table, 16 buckets\nnumber of buckets with 0 entries: 10\nnumber of buckets with 1 entries: 6\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "hash-delete-67",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<13} {incr i} {set a(k$i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{k0 k1 k10 k2 k11 k12 k3 k4 k5 k6 k7 k8 k9} 0 {} {}", "", false, "cursor-order-68",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<13} {incr i} {set a(same$i) $i};list [array names a] [array get a] [array statistics a]",
    "{same11 same12 same0 same1 same2 same3 same4 same5 same6 same7 same8 same9 same10} {same11 11 same12 12 same0 0 same1 1 same2 2 same3 3 same4 4 same5 5 same6 6 same7 7 same8 8 same9 9 same10 10} {13 entries in table, 16 buckets\nnumber of buckets with 0 entries: 4\nnumber of buckets with 1 entries: 11\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.1}",
    "", false, "hash-order-69",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<13} {incr i} {set a(same$i) $i};for {set i 0} {$i<13} {incr i 2} {unset a(same$i)};list [array names a] [array statistics a]",
    "{same11 same1 same3 same5 same7 same9} {6 entries in table, 16 buckets\nnumber of buckets with 0 entries: 10\nnumber of buckets with 1 entries: 6\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "hash-delete-70",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<13} {incr i} {set a(same$i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{same11 same12 same0 same1 same2 same3 same4 same5 same6 same7 same8 same9 same10} 0 {} {}",
    "", false, "cursor-order-71",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<47} {incr i} {set a($i) $i};list [array names a] [array get a] [array statistics a]",
    "{35 17 0 36 18 1 37 20 19 2 38 21 3 40 39 22 4 41 23 5 42 24 6 43 25 7 44 26 8 45 27 9 10 46 28 11 30 29 12 31 13 32 14 33 15 34 16} {35 35 17 17 0 0 36 36 18 18 1 1 37 37 20 20 19 19 2 2 38 38 21 21 3 3 40 40 39 39 22 22 4 4 41 41 23 23 5 5 42 42 24 24 6 6 43 43 25 25 7 7 44 44 26 26 8 8 45 45 27 27 9 9 10 10 46 46 28 28 11 11 30 30 29 29 12 12 31 31 13 13 32 32 14 14 33 33 15 15 34 34 16 16} {47 entries in table, 16 buckets\nnumber of buckets with 0 entries: 0\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 4\nnumber of buckets with 3 entries: 9\nnumber of buckets with 4 entries: 3\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 2.0}",
    "", false, "hash-order-72",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<47} {incr i} {set a($i) $i};for {set i 0} {$i<47} {incr i 2} {unset a($i)};list [array names a] [array statistics a]",
    "{35 17 1 37 19 21 3 39 41 23 5 43 25 7 45 27 9 11 29 31 13 33 15} {23 entries in table, 16 buckets\nnumber of buckets with 0 entries: 4\nnumber of buckets with 1 entries: 4\nnumber of buckets with 2 entries: 5\nnumber of buckets with 3 entries: 3\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.6}",
    "", false, "hash-delete-73",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<47} {incr i} {set a($i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{35 17 0 36 18 1 37 20 19 2 38 21 3 40 39 22 4 41 23 5 42 24 6 43 25 7 44 26 8 45 27 9 10 46 28 11 30 29 12 31 13 32 14 33 15 34 16} 0 {} {}",
    "", false, "cursor-order-74",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<47} {incr i} {set a(k$i) $i};list [array names a] [array get a] [array statistics a]",
    "{k41 k23 k42 k24 k43 k25 k44 k26 k0 k45 k27 k1 k10 k46 k28 k2 k11 k30 k29 k12 k3 k31 k13 k4 k32 k14 k5 k33 k15 k6 k34 k16 k7 k35 k17 k8 k36 k18 k9 k37 k20 k19 k38 k21 k40 k39 k22} {k41 41 k23 23 k42 42 k24 24 k43 43 k25 25 k44 44 k26 26 k0 0 k45 45 k27 27 k1 1 k10 10 k46 46 k28 28 k2 2 k11 11 k30 30 k29 29 k12 12 k3 3 k31 31 k13 13 k4 4 k32 32 k14 14 k5 5 k33 33 k15 15 k6 6 k34 34 k16 16 k7 7 k35 35 k17 17 k8 8 k36 36 k18 18 k9 9 k37 37 k20 20 k19 19 k38 38 k21 21 k40 40 k39 39 k22 22} {47 entries in table, 16 buckets\nnumber of buckets with 0 entries: 0\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 4\nnumber of buckets with 3 entries: 9\nnumber of buckets with 4 entries: 3\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 2.0}",
    "", false, "hash-order-75",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<47} {incr i} {set a(k$i) $i};for {set i 0} {$i<47} {incr i 2} {unset a(k$i)};list [array names a] [array statistics a]",
    "{k41 k23 k43 k25 k45 k27 k1 k11 k29 k3 k31 k13 k5 k33 k15 k7 k35 k17 k9 k37 k19 k21 k39} {23 entries in table, 16 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 6\nnumber of buckets with 2 entries: 7\nnumber of buckets with 3 entries: 1\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.4}",
    "", false, "hash-delete-76",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<47} {incr i} {set a(k$i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{k41 k23 k42 k24 k43 k25 k44 k26 k0 k45 k27 k1 k10 k46 k28 k2 k11 k30 k29 k12 k3 k31 k13 k4 k32 k14 k5 k33 k15 k6 k34 k16 k7 k35 k17 k8 k36 k18 k9 k37 k20 k19 k38 k21 k40 k39 k22} 0 {} {}",
    "", false, "cursor-order-77",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<47} {incr i} {set a(same$i) $i};list [array names a] [array get a] [array statistics a]",
    "{same46 same28 same11 same30 same29 same12 same31 same13 same32 same14 same33 same15 same34 same16 same35 same17 same0 same36 same18 same1 same37 same20 same19 same2 same38 same21 same3 same40 same39 same22 same4 same41 same23 same5 same42 same24 same6 same43 same25 same7 same44 same26 same8 same45 same27 same9 same10} {same46 46 same28 28 same11 11 same30 30 same29 29 same12 12 same31 31 same13 13 same32 32 same14 14 same33 33 same15 15 same34 34 same16 16 same35 35 same17 17 same0 0 same36 36 same18 18 same1 1 same37 37 same20 20 same19 19 same2 2 same38 38 same21 21 same3 3 same40 40 same39 39 same22 22 same4 4 same41 41 same23 23 same5 5 same42 42 same24 24 same6 6 same43 43 same25 25 same7 7 same44 44 same26 26 same8 8 same45 45 same27 27 same9 9 same10 10} {47 entries in table, 16 buckets\nnumber of buckets with 0 entries: 0\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 4\nnumber of buckets with 3 entries: 9\nnumber of buckets with 4 entries: 3\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 2.0}",
    "", false, "hash-order-78",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<47} {incr i} {set a(same$i) $i};for {set i 0} {$i<47} {incr i 2} {unset a(same$i)};list [array names a] [array statistics a]",
    "{same11 same29 same31 same13 same33 same15 same35 same17 same1 same37 same19 same21 same3 same39 same41 same23 same5 same43 same25 same7 same45 same27 same9} {23 entries in table, 16 buckets\nnumber of buckets with 0 entries: 4\nnumber of buckets with 1 entries: 4\nnumber of buckets with 2 entries: 5\nnumber of buckets with 3 entries: 3\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.6}",
    "", false, "hash-delete-79",
  )
}

///|
test "Tcl array cases 81 through 120" {
  check_array_case(
    "array set a {};for {set i 0} {$i<47} {incr i} {set a(same$i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{same46 same28 same11 same30 same29 same12 same31 same13 same32 same14 same33 same15 same34 same16 same35 same17 same0 same36 same18 same1 same37 same20 same19 same2 same38 same21 same3 same40 same39 same22 same4 same41 same23 same5 same42 same24 same6 same43 same25 same7 same44 same26 same8 same45 same27 same9 same10} 0 {} {}",
    "", false, "cursor-order-80",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<48} {incr i} {set a($i) $i};list [array names a] [array get a] [array statistics a]",
    "{35 36 37 38 39 40 41 42 43 44 45 46 47 10 11 12 13 14 15 16 0 17 1 18 2 19 20 3 21 4 22 5 23 6 24 7 25 8 26 9 27 28 29 30 31 32 33 34} {35 35 36 36 37 37 38 38 39 39 40 40 41 41 42 42 43 43 44 44 45 45 46 46 47 47 10 10 11 11 12 12 13 13 14 14 15 15 16 16 0 0 17 17 1 1 18 18 2 2 19 19 20 20 3 3 21 21 4 4 22 22 5 5 23 23 6 6 24 24 7 7 25 25 8 8 26 26 9 9 27 27 28 28 29 29 30 30 31 31 32 32 33 33 34 34} {48 entries in table, 64 buckets\nnumber of buckets with 0 entries: 29\nnumber of buckets with 1 entries: 23\nnumber of buckets with 2 entries: 11\nnumber of buckets with 3 entries: 1\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.3}",
    "", false, "hash-order-81",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<48} {incr i} {set a($i) $i};for {set i 0} {$i<48} {incr i 2} {unset a($i)};list [array names a] [array statistics a]",
    "{35 37 39 41 43 45 47 11 13 15 17 1 19 3 21 5 23 7 25 9 27 29 31 33} {24 entries in table, 64 buckets\nnumber of buckets with 0 entries: 44\nnumber of buckets with 1 entries: 16\nnumber of buckets with 2 entries: 4\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.2}",
    "", false, "hash-delete-82",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<48} {incr i} {set a($i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{35 36 37 38 39 40 41 42 43 44 45 46 47 10 11 12 13 14 15 16 0 17 1 18 2 19 20 3 21 4 22 5 23 6 24 7 25 8 26 9 27 28 29 30 31 32 33 34} 0 {} {}",
    "", false, "cursor-order-83",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<48} {incr i} {set a(k$i) $i};list [array names a] [array get a] [array statistics a]",
    "{k10 k11 k12 k13 k14 k15 k16 k17 k18 k19 k20 k21 k22 k23 k24 k25 k26 k27 k28 k29 k30 k31 k32 k33 k34 k35 k36 k37 k38 k39 k40 k41 k42 k43 k44 k45 k46 k47 k0 k1 k2 k3 k4 k5 k6 k7 k8 k9} {k10 10 k11 11 k12 12 k13 13 k14 14 k15 15 k16 16 k17 17 k18 18 k19 19 k20 20 k21 21 k22 22 k23 23 k24 24 k25 25 k26 26 k27 27 k28 28 k29 29 k30 30 k31 31 k32 32 k33 33 k34 34 k35 35 k36 36 k37 37 k38 38 k39 39 k40 40 k41 41 k42 42 k43 43 k44 44 k45 45 k46 46 k47 47 k0 0 k1 1 k2 2 k3 3 k4 4 k5 5 k6 6 k7 7 k8 8 k9 9} {48 entries in table, 64 buckets\nnumber of buckets with 0 entries: 19\nnumber of buckets with 1 entries: 42\nnumber of buckets with 2 entries: 3\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.1}",
    "", false, "hash-order-84",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<48} {incr i} {set a(k$i) $i};for {set i 0} {$i<48} {incr i 2} {unset a(k$i)};list [array names a] [array statistics a]",
    "{k11 k13 k15 k17 k19 k21 k23 k25 k27 k29 k31 k33 k35 k37 k39 k41 k43 k45 k47 k1 k3 k5 k7 k9} {24 entries in table, 64 buckets\nnumber of buckets with 0 entries: 40\nnumber of buckets with 1 entries: 24\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "hash-delete-85",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<48} {incr i} {set a(k$i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{k10 k11 k12 k13 k14 k15 k16 k17 k18 k19 k20 k21 k22 k23 k24 k25 k26 k27 k28 k29 k30 k31 k32 k33 k34 k35 k36 k37 k38 k39 k40 k41 k42 k43 k44 k45 k46 k47 k0 k1 k2 k3 k4 k5 k6 k7 k8 k9} 0 {} {}",
    "", false, "cursor-order-86",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<48} {incr i} {set a(same$i) $i};list [array names a] [array get a] [array statistics a]",
    "{same28 same29 same30 same31 same32 same33 same34 same0 same35 same1 same36 same2 same37 same3 same38 same4 same39 same40 same5 same41 same6 same42 same7 same43 same8 same44 same9 same45 same46 same47 same10 same11 same12 same13 same14 same15 same16 same17 same18 same19 same20 same21 same22 same23 same24 same25 same26 same27} {same28 28 same29 29 same30 30 same31 31 same32 32 same33 33 same34 34 same0 0 same35 35 same1 1 same36 36 same2 2 same37 37 same3 3 same38 38 same4 4 same39 39 same40 40 same5 5 same41 41 same6 6 same42 42 same7 7 same43 43 same8 8 same44 44 same9 9 same45 45 same46 46 same47 47 same10 10 same11 11 same12 12 same13 13 same14 14 same15 15 same16 16 same17 17 same18 18 same19 19 same20 20 same21 21 same22 22 same23 23 same24 24 same25 25 same26 26 same27 27} {48 entries in table, 64 buckets\nnumber of buckets with 0 entries: 29\nnumber of buckets with 1 entries: 23\nnumber of buckets with 2 entries: 11\nnumber of buckets with 3 entries: 1\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.3}",
    "", false, "hash-order-87",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<48} {incr i} {set a(same$i) $i};for {set i 0} {$i<48} {incr i 2} {unset a(same$i)};list [array names a] [array statistics a]",
    "{same29 same31 same33 same35 same1 same37 same3 same39 same5 same41 same7 same43 same9 same45 same47 same11 same13 same15 same17 same19 same21 same23 same25 same27} {24 entries in table, 64 buckets\nnumber of buckets with 0 entries: 43\nnumber of buckets with 1 entries: 18\nnumber of buckets with 2 entries: 3\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.1}",
    "", false, "hash-delete-88",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<48} {incr i} {set a(same$i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{same28 same29 same30 same31 same32 same33 same34 same0 same35 same1 same36 same2 same37 same3 same38 same4 same39 same40 same5 same41 same6 same42 same7 same43 same8 same44 same9 same45 same46 same47 same10 same11 same12 same13 same14 same15 same16 same17 same18 same19 same20 same21 same22 same23 same24 same25 same26 same27} 0 {} {}",
    "", false, "cursor-order-89",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<49} {incr i} {set a($i) $i};list [array names a] [array get a] [array statistics a]",
    "{35 36 37 38 39 40 41 42 43 44 45 46 47 48 10 11 12 13 14 15 16 0 17 1 18 2 19 20 3 21 4 22 5 23 6 24 7 25 8 26 9 27 28 29 30 31 32 33 34} {35 35 36 36 37 37 38 38 39 39 40 40 41 41 42 42 43 43 44 44 45 45 46 46 47 47 48 48 10 10 11 11 12 12 13 13 14 14 15 15 16 16 0 0 17 17 1 1 18 18 2 2 19 19 20 20 3 3 21 21 4 4 22 22 5 5 23 23 6 6 24 24 7 7 25 25 8 8 26 26 9 9 27 27 28 28 29 29 30 30 31 31 32 32 33 33 34 34} {49 entries in table, 64 buckets\nnumber of buckets with 0 entries: 28\nnumber of buckets with 1 entries: 24\nnumber of buckets with 2 entries: 11\nnumber of buckets with 3 entries: 1\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.3}",
    "", false, "hash-order-90",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<49} {incr i} {set a($i) $i};for {set i 0} {$i<49} {incr i 2} {unset a($i)};list [array names a] [array statistics a]",
    "{35 37 39 41 43 45 47 11 13 15 17 1 19 3 21 5 23 7 25 9 27 29 31 33} {24 entries in table, 64 buckets\nnumber of buckets with 0 entries: 44\nnumber of buckets with 1 entries: 16\nnumber of buckets with 2 entries: 4\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.2}",
    "", false, "hash-delete-91",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<49} {incr i} {set a($i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{35 36 37 38 39 40 41 42 43 44 45 46 47 48 10 11 12 13 14 15 16 0 17 1 18 2 19 20 3 21 4 22 5 23 6 24 7 25 8 26 9 27 28 29 30 31 32 33 34} 0 {} {}",
    "", false, "cursor-order-92",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<49} {incr i} {set a(k$i) $i};list [array names a] [array get a] [array statistics a]",
    "{k10 k11 k12 k13 k14 k15 k16 k17 k18 k19 k20 k21 k22 k23 k24 k25 k26 k27 k28 k29 k30 k31 k32 k33 k34 k35 k36 k37 k38 k39 k40 k41 k42 k43 k44 k45 k46 k47 k48 k0 k1 k2 k3 k4 k5 k6 k7 k8 k9} {k10 10 k11 11 k12 12 k13 13 k14 14 k15 15 k16 16 k17 17 k18 18 k19 19 k20 20 k21 21 k22 22 k23 23 k24 24 k25 25 k26 26 k27 27 k28 28 k29 29 k30 30 k31 31 k32 32 k33 33 k34 34 k35 35 k36 36 k37 37 k38 38 k39 39 k40 40 k41 41 k42 42 k43 43 k44 44 k45 45 k46 46 k47 47 k48 48 k0 0 k1 1 k2 2 k3 3 k4 4 k5 5 k6 6 k7 7 k8 8 k9 9} {49 entries in table, 64 buckets\nnumber of buckets with 0 entries: 18\nnumber of buckets with 1 entries: 43\nnumber of buckets with 2 entries: 3\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.1}",
    "", false, "hash-order-93",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<49} {incr i} {set a(k$i) $i};for {set i 0} {$i<49} {incr i 2} {unset a(k$i)};list [array names a] [array statistics a]",
    "{k11 k13 k15 k17 k19 k21 k23 k25 k27 k29 k31 k33 k35 k37 k39 k41 k43 k45 k47 k1 k3 k5 k7 k9} {24 entries in table, 64 buckets\nnumber of buckets with 0 entries: 40\nnumber of buckets with 1 entries: 24\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "hash-delete-94",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<49} {incr i} {set a(k$i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{k10 k11 k12 k13 k14 k15 k16 k17 k18 k19 k20 k21 k22 k23 k24 k25 k26 k27 k28 k29 k30 k31 k32 k33 k34 k35 k36 k37 k38 k39 k40 k41 k42 k43 k44 k45 k46 k47 k48 k0 k1 k2 k3 k4 k5 k6 k7 k8 k9} 0 {} {}",
    "", false, "cursor-order-95",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<49} {incr i} {set a(same$i) $i};list [array names a] [array get a] [array statistics a]",
    "{same28 same29 same30 same31 same32 same33 same34 same0 same35 same1 same36 same2 same37 same3 same38 same4 same39 same40 same5 same41 same6 same42 same7 same43 same8 same44 same9 same45 same46 same47 same48 same10 same11 same12 same13 same14 same15 same16 same17 same18 same19 same20 same21 same22 same23 same24 same25 same26 same27} {same28 28 same29 29 same30 30 same31 31 same32 32 same33 33 same34 34 same0 0 same35 35 same1 1 same36 36 same2 2 same37 37 same3 3 same38 38 same4 4 same39 39 same40 40 same5 5 same41 41 same6 6 same42 42 same7 7 same43 43 same8 8 same44 44 same9 9 same45 45 same46 46 same47 47 same48 48 same10 10 same11 11 same12 12 same13 13 same14 14 same15 15 same16 16 same17 17 same18 18 same19 19 same20 20 same21 21 same22 22 same23 23 same24 24 same25 25 same26 26 same27 27} {49 entries in table, 64 buckets\nnumber of buckets with 0 entries: 28\nnumber of buckets with 1 entries: 24\nnumber of buckets with 2 entries: 11\nnumber of buckets with 3 entries: 1\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.3}",
    "", false, "hash-order-96",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<49} {incr i} {set a(same$i) $i};for {set i 0} {$i<49} {incr i 2} {unset a(same$i)};list [array names a] [array statistics a]",
    "{same29 same31 same33 same35 same1 same37 same3 same39 same5 same41 same7 same43 same9 same45 same47 same11 same13 same15 same17 same19 same21 same23 same25 same27} {24 entries in table, 64 buckets\nnumber of buckets with 0 entries: 43\nnumber of buckets with 1 entries: 18\nnumber of buckets with 2 entries: 3\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.1}",
    "", false, "hash-delete-97",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<49} {incr i} {set a(same$i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{same28 same29 same30 same31 same32 same33 same34 same0 same35 same1 same36 same2 same37 same3 same38 same4 same39 same40 same5 same41 same6 same42 same7 same43 same8 same44 same9 same45 same46 same47 same48 same10 same11 same12 same13 same14 same15 same16 same17 same18 same19 same20 same21 same22 same23 same24 same25 same26 same27} 0 {} {}",
    "", false, "cursor-order-98",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<191} {incr i} {set a($i) $i};list [array names a] [array get a] [array statistics a]",
    "{134 35 135 36 136 37 137 38 138 39 40 140 139 41 141 42 142 43 143 44 144 45 145 46 146 47 147 48 148 50 49 150 149 51 151 52 152 53 153 54 154 55 155 56 156 57 157 58 158 60 59 160 159 61 161 62 162 63 163 64 164 65 165 66 166 67 167 68 168 70 69 170 169 71 171 100 72 172 101 73 173 102 74 174 103 75 175 104 76 176 105 77 177 106 78 178 107 80 79 180 179 108 81 10 181 110 109 82 11 182 111 83 12 183 112 84 13 184 113 85 14 185 114 86 15 186 115 87 16 187 116 88 0 17 188 117 90 89 1 18 190 189 118 91 2 19 20 120 119 92 3 21 121 93 4 22 122 94 5 23 123 95 6 24 124 96 7 25 125 97 8 26 126 98 9 27 127 99 28 128 29 30 130 129 31 131 32 132 33 133 34} {134 134 35 35 135 135 36 36 136 136 37 37 137 137 38 38 138 138 39 39 40 40 140 140 139 139 41 41 141 141 42 42 142 142 43 43 143 143 44 44 144 144 45 45 145 145 46 46 146 146 47 47 147 147 48 48 148 148 50 50 49 49 150 150 149 149 51 51 151 151 52 52 152 152 53 53 153 153 54 54 154 154 55 55 155 155 56 56 156 156 57 57 157 157 58 58 158 158 60 60 59 59 160 160 159 159 61 61 161 161 62 62 162 162 63 63 163 163 64 64 164 164 65 65 165 165 66 66 166 166 67 67 167 167 68 68 168 168 70 70 69 69 170 170 169 169 71 71 171 171 100 100 72 72 172 172 101 101 73 73 173 173 102 102 74 74 174 174 103 103 75 75 175 175 104 104 76 76 176 176 105 105 77 77 177 177 106 106 78 78 178 178 107 107 80 80 79 79 180 180 179 179 108 108 81 81 10 10 181 181 110 110 109 109 82 82 11 11 182 182 111 111 83 83 12 12 183 183 112 112 84 84 13 13 184 184 113 113 85 85 14 14 185 185 114 114 86 86 15 15 186 186 115 115 87 87 16 16 187 187 116 116 88 88 0 0 17 17 188 188 117 117 90 90 89 89 1 1 18 18 190 190 189 189 118 118 91 91 2 2 19 19 20 20 120 120 119 119 92 92 3 3 21 21 121 121 93 93 4 4 22 22 122 122 94 94 5 5 23 23 123 123 95 95 6 6 24 24 124 124 96 96 7 7 25 25 125 125 97 97 8 8 26 26 126 126 98 98 9 9 27 27 127 127 99 99 28 28 128 128 29 29 30 30 130 130 129 129 31 31 131 131 32 32 132 132 33 33 133 133 34 34} {191 entries in table, 64 buckets\nnumber of buckets with 0 entries: 0\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 28\nnumber of buckets with 3 entries: 18\nnumber of buckets with 4 entries: 12\nnumber of buckets with 5 entries: 4\nnumber of buckets with 6 entries: 1\nnumber of buckets with 7 entries: 1\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 2.2}",
    "", false, "hash-order-99",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<191} {incr i} {set a($i) $i};for {set i 0} {$i<191} {incr i 2} {unset a($i)};list [array names a] [array statistics a]",
    "{35 135 37 137 39 139 41 141 43 143 45 145 47 147 49 149 51 151 53 153 55 155 57 157 59 159 61 161 63 163 65 165 67 167 69 169 71 171 101 73 173 103 75 175 105 77 177 107 79 179 81 181 109 11 111 83 183 13 113 85 185 15 115 87 187 17 117 89 1 189 91 19 119 3 21 121 93 5 23 123 95 7 25 125 97 9 27 127 99 29 129 31 131 33 133} {95 entries in table, 64 buckets\nnumber of buckets with 0 entries: 0\nnumber of buckets with 1 entries: 37\nnumber of buckets with 2 entries: 23\nnumber of buckets with 3 entries: 4\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.4}",
    "", false, "hash-delete-100",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<191} {incr i} {set a($i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{134 35 135 36 136 37 137 38 138 39 40 140 139 41 141 42 142 43 143 44 144 45 145 46 146 47 147 48 148 50 49 150 149 51 151 52 152 53 153 54 154 55 155 56 156 57 157 58 158 60 59 160 159 61 161 62 162 63 163 64 164 65 165 66 166 67 167 68 168 70 69 170 169 71 171 100 72 172 101 73 173 102 74 174 103 75 175 104 76 176 105 77 177 106 78 178 107 80 79 180 179 108 81 10 181 110 109 82 11 182 111 83 12 183 112 84 13 184 113 85 14 185 114 86 15 186 115 87 16 187 116 88 0 17 188 117 90 89 1 18 190 189 118 91 2 19 20 120 119 92 3 21 121 93 4 22 122 94 5 23 123 95 6 24 124 96 7 25 125 97 8 26 126 98 9 27 127 99 28 128 29 30 130 129 31 131 32 132 33 133 34} 0 {} {}",
    "", false, "cursor-order-101",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<191} {incr i} {set a(k$i) $i};list [array names a] [array get a] [array statistics a]",
    "{k148 k76 k150 k149 k77 k151 k78 k152 k80 k79 k153 k81 k10 k154 k82 k11 k155 k83 k12 k156 k84 k13 k157 k85 k14 k158 k86 k15 k160 k159 k87 k16 k161 k88 k17 k162 k90 k89 k18 k163 k91 k19 k20 k164 k92 k21 k165 k93 k22 k166 k94 k23 k167 k95 k24 k168 k96 k25 k170 k169 k97 k26 k171 k100 k98 k27 k172 k101 k99 k28 k173 k102 k29 k30 k174 k103 k31 k175 k104 k32 k176 k105 k33 k177 k106 k34 k178 k107 k35 k180 k179 k108 k36 k181 k110 k109 k37 k182 k111 k38 k183 k112 k39 k40 k184 k113 k41 k185 k114 k42 k186 k115 k43 k187 k116 k44 k188 k117 k45 k190 k189 k118 k46 k120 k119 k47 k121 k48 k122 k50 k49 k123 k51 k124 k52 k125 k53 k126 k54 k127 k55 k128 k56 k130 k129 k57 k131 k58 k132 k60 k59 k133 k61 k134 k62 k0 k135 k63 k1 k136 k64 k2 k137 k65 k3 k138 k66 k4 k140 k139 k67 k5 k141 k68 k6 k142 k70 k69 k7 k143 k71 k8 k144 k72 k9 k145 k73 k146 k74 k147 k75} {k148 148 k76 76 k150 150 k149 149 k77 77 k151 151 k78 78 k152 152 k80 80 k79 79 k153 153 k81 81 k10 10 k154 154 k82 82 k11 11 k155 155 k83 83 k12 12 k156 156 k84 84 k13 13 k157 157 k85 85 k14 14 k158 158 k86 86 k15 15 k160 160 k159 159 k87 87 k16 16 k161 161 k88 88 k17 17 k162 162 k90 90 k89 89 k18 18 k163 163 k91 91 k19 19 k20 20 k164 164 k92 92 k21 21 k165 165 k93 93 k22 22 k166 166 k94 94 k23 23 k167 167 k95 95 k24 24 k168 168 k96 96 k25 25 k170 170 k169 169 k97 97 k26 26 k171 171 k100 100 k98 98 k27 27 k172 172 k101 101 k99 99 k28 28 k173 173 k102 102 k29 29 k30 30 k174 174 k103 103 k31 31 k175 175 k104 104 k32 32 k176 176 k105 105 k33 33 k177 177 k106 106 k34 34 k178 178 k107 107 k35 35 k180 180 k179 179 k108 108 k36 36 k181 181 k110 110 k109 109 k37 37 k182 182 k111 111 k38 38 k183 183 k112 112 k39 39 k40 40 k184 184 k113 113 k41 41 k185 185 k114 114 k42 42 k186 186 k115 115 k43 43 k187 187 k116 116 k44 44 k188 188 k117 117 k45 45 k190 190 k189 189 k118 118 k46 46 k120 120 k119 119 k47 47 k121 121 k48 48 k122 122 k50 50 k49 49 k123 123 k51 51 k124 124 k52 52 k125 125 k53 53 k126 126 k54 54 k127 127 k55 55 k128 128 k56 56 k130 130 k129 129 k57 57 k131 131 k58 58 k132 132 k60 60 k59 59 k133 133 k61 61 k134 134 k62 62 k0 0 k135 135 k63 63 k1 1 k136 136 k64 64 k2 2 k137 137 k65 65 k3 3 k138 138 k66 66 k4 4 k140 140 k139 139 k67 67 k5 5 k141 141 k68 68 k6 6 k142 142 k70 70 k69 69 k7 7 k143 143 k71 71 k8 8 k144 144 k72 72 k9 9 k145 145 k73 73 k146 146 k74 74 k147 147 k75 75} {191 entries in table, 64 buckets\nnumber of buckets with 0 entries: 0\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 14\nnumber of buckets with 3 entries: 37\nnumber of buckets with 4 entries: 13\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 2.1}",
    "", false, "hash-order-102",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<191} {incr i} {set a(k$i) $i};for {set i 0} {$i<191} {incr i 2} {unset a(k$i)};list [array names a] [array statistics a]",
    "{k149 k77 k151 k79 k153 k81 k11 k155 k83 k13 k157 k85 k15 k159 k87 k161 k17 k89 k163 k91 k19 k21 k165 k93 k23 k167 k95 k25 k169 k97 k171 k27 k101 k99 k173 k29 k103 k31 k175 k105 k33 k177 k107 k35 k179 k181 k109 k37 k111 k183 k39 k113 k41 k185 k115 k43 k187 k117 k45 k189 k119 k47 k121 k49 k123 k51 k125 k53 k127 k55 k129 k57 k131 k59 k133 k61 k135 k63 k1 k137 k65 k3 k139 k67 k5 k141 k69 k7 k143 k71 k9 k145 k73 k147 k75} {95 entries in table, 64 buckets\nnumber of buckets with 0 entries: 8\nnumber of buckets with 1 entries: 22\nnumber of buckets with 2 entries: 29\nnumber of buckets with 3 entries: 5\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.5}",
    "", false, "hash-delete-103",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<191} {incr i} {set a(k$i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{k148 k76 k150 k149 k77 k151 k78 k152 k80 k79 k153 k81 k10 k154 k82 k11 k155 k83 k12 k156 k84 k13 k157 k85 k14 k158 k86 k15 k160 k159 k87 k16 k161 k88 k17 k162 k90 k89 k18 k163 k91 k19 k20 k164 k92 k21 k165 k93 k22 k166 k94 k23 k167 k95 k24 k168 k96 k25 k170 k169 k97 k26 k171 k100 k98 k27 k172 k101 k99 k28 k173 k102 k29 k30 k174 k103 k31 k175 k104 k32 k176 k105 k33 k177 k106 k34 k178 k107 k35 k180 k179 k108 k36 k181 k110 k109 k37 k182 k111 k38 k183 k112 k39 k40 k184 k113 k41 k185 k114 k42 k186 k115 k43 k187 k116 k44 k188 k117 k45 k190 k189 k118 k46 k120 k119 k47 k121 k48 k122 k50 k49 k123 k51 k124 k52 k125 k53 k126 k54 k127 k55 k128 k56 k130 k129 k57 k131 k58 k132 k60 k59 k133 k61 k134 k62 k0 k135 k63 k1 k136 k64 k2 k137 k65 k3 k138 k66 k4 k140 k139 k67 k5 k141 k68 k6 k142 k70 k69 k7 k143 k71 k8 k144 k72 k9 k145 k73 k146 k74 k147 k75} 0 {} {}",
    "", false, "cursor-order-104",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<191} {incr i} {set a(same$i) $i};list [array names a] [array get a] [array statistics a]",
    "{same145 same99 same28 same146 same29 same30 same147 same31 same148 same32 same150 same149 same33 same151 same34 same152 same0 same35 same153 same1 same36 same154 same2 same37 same155 same3 same38 same156 same4 same39 same40 same157 same5 same41 same158 same6 same42 same160 same159 same7 same43 same161 same8 same44 same162 same9 same45 same163 same46 same164 same47 same165 same48 same166 same50 same49 same167 same51 same168 same52 same170 same169 same53 same171 same100 same54 same172 same101 same55 same173 same102 same56 same174 same103 same57 same175 same104 same58 same176 same105 same60 same59 same177 same106 same61 same178 same107 same62 same180 same179 same108 same63 same181 same110 same109 same64 same182 same111 same65 same183 same112 same66 same184 same113 same67 same185 same114 same68 same186 same115 same70 same69 same187 same116 same71 same188 same117 same72 same190 same189 same118 same73 same120 same119 same74 same121 same75 same122 same76 same123 same77 same124 same78 same125 same80 same79 same126 same81 same10 same127 same82 same11 same128 same83 same12 same130 same129 same84 same13 same131 same85 same14 same132 same86 same15 same133 same87 same16 same134 same88 same17 same135 same90 same89 same18 same136 same91 same19 same20 same137 same92 same21 same138 same93 same22 same140 same139 same94 same23 same141 same95 same24 same142 same96 same25 same143 same97 same26 same144 same98 same27} {same145 145 same99 99 same28 28 same146 146 same29 29 same30 30 same147 147 same31 31 same148 148 same32 32 same150 150 same149 149 same33 33 same151 151 same34 34 same152 152 same0 0 same35 35 same153 153 same1 1 same36 36 same154 154 same2 2 same37 37 same155 155 same3 3 same38 38 same156 156 same4 4 same39 39 same40 40 same157 157 same5 5 same41 41 same158 158 same6 6 same42 42 same160 160 same159 159 same7 7 same43 43 same161 161 same8 8 same44 44 same162 162 same9 9 same45 45 same163 163 same46 46 same164 164 same47 47 same165 165 same48 48 same166 166 same50 50 same49 49 same167 167 same51 51 same168 168 same52 52 same170 170 same169 169 same53 53 same171 171 same100 100 same54 54 same172 172 same101 101 same55 55 same173 173 same102 102 same56 56 same174 174 same103 103 same57 57 same175 175 same104 104 same58 58 same176 176 same105 105 same60 60 same59 59 same177 177 same106 106 same61 61 same178 178 same107 107 same62 62 same180 180 same179 179 same108 108 same63 63 same181 181 same110 110 same109 109 same64 64 same182 182 same111 111 same65 65 same183 183 same112 112 same66 66 same184 184 same113 113 same67 67 same185 185 same114 114 same68 68 same186 186 same115 115 same70 70 same69 69 same187 187 same116 116 same71 71 same188 188 same117 117 same72 72 same190 190 same189 189 same118 118 same73 73 same120 120 same119 119 same74 74 same121 121 same75 75 same122 122 same76 76 same123 123 same77 77 same124 124 same78 78 same125 125 same80 80 same79 79 same126 126 same81 81 same10 10 same127 127 same82 82 same11 11 same128 128 same83 83 same12 12 same130 130 same129 129 same84 84 same13 13 same131 131 same85 85 same14 14 same132 132 same86 86 same15 15 same133 133 same87 87 same16 16 same134 134 same88 88 same17 17 same135 135 same90 90 same89 89 same18 18 same136 136 same91 91 same19 19 same20 20 same137 137 same92 92 same21 21 same138 138 same93 93 same22 22 same140 140 same139 139 same94 94 same23 23 same141 141 same95 95 same24 24 same142 142 same96 96 same25 25 same143 143 same97 97 same26 26 same144 144 same98 98 same27 27} {191 entries in table, 64 buckets\nnumber of buckets with 0 entries: 0\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 12\nnumber of buckets with 3 entries: 41\nnumber of buckets with 4 entries: 11\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 2.1}",
    "", false, "hash-order-105",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<191} {incr i} {set a(same$i) $i};for {set i 0} {$i<191} {incr i 2} {unset a(same$i)};list [array names a] [array statistics a]",
    "{same145 same99 same29 same147 same31 same149 same33 same151 same35 same153 same1 same37 same155 same3 same39 same157 same5 same41 same159 same7 same43 same161 same9 same45 same163 same47 same165 same49 same167 same51 same169 same53 same171 same101 same55 same173 same103 same57 same175 same105 same59 same177 same61 same107 same179 same63 same181 same109 same111 same65 same183 same113 same67 same185 same115 same69 same187 same71 same117 same189 same73 same119 same121 same75 same123 same77 same125 same79 same81 same127 same11 same83 same129 same13 same131 same85 same15 same133 same87 same17 same135 same89 same91 same19 same137 same21 same93 same139 same23 same141 same95 same25 same143 same97 same27} {95 entries in table, 64 buckets\nnumber of buckets with 0 entries: 5\nnumber of buckets with 1 entries: 25\nnumber of buckets with 2 entries: 32\nnumber of buckets with 3 entries: 2\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.4}",
    "", false, "hash-delete-106",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<191} {incr i} {set a(same$i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{same145 same99 same28 same146 same29 same30 same147 same31 same148 same32 same150 same149 same33 same151 same34 same152 same0 same35 same153 same1 same36 same154 same2 same37 same155 same3 same38 same156 same4 same39 same40 same157 same5 same41 same158 same6 same42 same160 same159 same7 same43 same161 same8 same44 same162 same9 same45 same163 same46 same164 same47 same165 same48 same166 same50 same49 same167 same51 same168 same52 same170 same169 same53 same171 same100 same54 same172 same101 same55 same173 same102 same56 same174 same103 same57 same175 same104 same58 same176 same105 same60 same59 same177 same106 same61 same178 same107 same62 same180 same179 same108 same63 same181 same110 same109 same64 same182 same111 same65 same183 same112 same66 same184 same113 same67 same185 same114 same68 same186 same115 same70 same69 same187 same116 same71 same188 same117 same72 same190 same189 same118 same73 same120 same119 same74 same121 same75 same122 same76 same123 same77 same124 same78 same125 same80 same79 same126 same81 same10 same127 same82 same11 same128 same83 same12 same130 same129 same84 same13 same131 same85 same14 same132 same86 same15 same133 same87 same16 same134 same88 same17 same135 same90 same89 same18 same136 same91 same19 same20 same137 same92 same21 same138 same93 same22 same140 same139 same94 same23 same141 same95 same24 same142 same96 same25 same143 same97 same26 same144 same98 same27} 0 {} {}",
    "", false, "cursor-order-107",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<192} {incr i} {set a($i) $i};list [array names a] [array get a] [array statistics a]",
    "{35 36 37 38 40 39 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 0 88 1 89 90 2 91 3 92 4 93 5 94 6 95 7 96 8 97 9 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 10 11 12 13 14 15 16 17 18 20 19 21 22 23 24 25 26 27 28 30 29 31 32 33 34} {35 35 36 36 37 37 38 38 40 40 39 39 41 41 42 42 43 43 44 44 45 45 46 46 47 47 48 48 49 49 50 50 51 51 52 52 53 53 54 54 55 55 56 56 57 57 58 58 59 59 60 60 61 61 62 62 63 63 64 64 65 65 66 66 67 67 68 68 69 69 70 70 71 71 72 72 73 73 74 74 75 75 76 76 77 77 78 78 79 79 80 80 81 81 82 82 83 83 84 84 85 85 86 86 87 87 0 0 88 88 1 1 89 89 90 90 2 2 91 91 3 3 92 92 4 4 93 93 5 5 94 94 6 6 95 95 7 7 96 96 8 8 97 97 9 9 98 98 99 99 100 100 101 101 102 102 103 103 104 104 105 105 106 106 107 107 108 108 109 109 110 110 111 111 112 112 113 113 114 114 115 115 116 116 117 117 118 118 119 119 120 120 121 121 122 122 123 123 124 124 125 125 126 126 127 127 128 128 129 129 130 130 131 131 132 132 133 133 134 134 135 135 136 136 137 137 138 138 139 139 140 140 141 141 142 142 143 143 144 144 145 145 146 146 147 147 148 148 149 149 150 150 151 151 152 152 153 153 154 154 155 155 156 156 157 157 158 158 159 159 160 160 161 161 162 162 163 163 164 164 165 165 166 166 167 167 168 168 169 169 170 170 171 171 172 172 173 173 174 174 175 175 176 176 177 177 178 178 179 179 180 180 181 181 182 182 183 183 184 184 185 185 186 186 187 187 188 188 189 189 190 190 191 191 10 10 11 11 12 12 13 13 14 14 15 15 16 16 17 17 18 18 20 20 19 19 21 21 22 22 23 23 24 24 25 25 26 26 27 27 28 28 30 30 29 29 31 31 32 32 33 33 34 34} {192 entries in table, 256 buckets\nnumber of buckets with 0 entries: 91\nnumber of buckets with 1 entries: 139\nnumber of buckets with 2 entries: 25\nnumber of buckets with 3 entries: 1\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.1}",
    "", false, "hash-order-108",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<192} {incr i} {set a($i) $i};for {set i 0} {$i<192} {incr i 2} {unset a($i)};list [array names a] [array statistics a]",
    "{35 37 39 41 43 45 47 49 51 53 55 57 59 61 63 65 67 69 71 73 75 77 79 81 83 85 87 1 89 91 3 93 5 95 7 97 9 99 101 103 105 107 109 111 113 115 117 119 121 123 125 127 129 131 133 135 137 139 141 143 145 147 149 151 153 155 157 159 161 163 165 167 169 171 173 175 177 179 181 183 185 187 189 191 11 13 15 17 19 21 23 25 27 29 31 33} {96 entries in table, 256 buckets\nnumber of buckets with 0 entries: 161\nnumber of buckets with 1 entries: 94\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "hash-delete-109",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<192} {incr i} {set a($i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{35 36 37 38 40 39 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 0 88 1 89 90 2 91 3 92 4 93 5 94 6 95 7 96 8 97 9 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 10 11 12 13 14 15 16 17 18 20 19 21 22 23 24 25 26 27 28 30 29 31 32 33 34} 0 {} {}",
    "", false, "cursor-order-110",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<192} {incr i} {set a(k$i) $i};list [array names a] [array get a] [array statistics a]",
    "{k76 k77 k78 k79 k80 k81 k82 k83 k84 k85 k86 k87 k88 k89 k90 k91 k92 k93 k94 k95 k96 k97 k98 k100 k99 k101 k102 k103 k104 k105 k106 k107 k108 k109 k110 k111 k112 k113 k114 k115 k116 k117 k118 k119 k120 k121 k122 k123 k124 k125 k126 k127 k128 k129 k130 k131 k132 k133 k134 k135 k136 k137 k138 k139 k140 k141 k142 k143 k144 k145 k146 k147 k148 k149 k150 k151 k152 k153 k154 k155 k156 k157 k158 k159 k160 k161 k162 k163 k164 k165 k166 k167 k168 k169 k170 k171 k172 k173 k174 k175 k176 k177 k178 k179 k180 k181 k182 k183 k184 k185 k186 k187 k188 k189 k190 k191 k10 k11 k12 k13 k14 k15 k16 k17 k18 k20 k19 k21 k22 k23 k24 k25 k26 k27 k28 k30 k29 k31 k32 k33 k34 k35 k36 k37 k38 k40 k39 k41 k42 k43 k44 k45 k46 k47 k48 k49 k50 k51 k52 k53 k54 k55 k56 k57 k58 k59 k60 k61 k0 k62 k1 k63 k2 k64 k3 k65 k4 k66 k5 k67 k6 k68 k7 k69 k70 k8 k71 k9 k72 k73 k74 k75} {k76 76 k77 77 k78 78 k79 79 k80 80 k81 81 k82 82 k83 83 k84 84 k85 85 k86 86 k87 87 k88 88 k89 89 k90 90 k91 91 k92 92 k93 93 k94 94 k95 95 k96 96 k97 97 k98 98 k100 100 k99 99 k101 101 k102 102 k103 103 k104 104 k105 105 k106 106 k107 107 k108 108 k109 109 k110 110 k111 111 k112 112 k113 113 k114 114 k115 115 k116 116 k117 117 k118 118 k119 119 k120 120 k121 121 k122 122 k123 123 k124 124 k125 125 k126 126 k127 127 k128 128 k129 129 k130 130 k131 131 k132 132 k133 133 k134 134 k135 135 k136 136 k137 137 k138 138 k139 139 k140 140 k141 141 k142 142 k143 143 k144 144 k145 145 k146 146 k147 147 k148 148 k149 149 k150 150 k151 151 k152 152 k153 153 k154 154 k155 155 k156 156 k157 157 k158 158 k159 159 k160 160 k161 161 k162 162 k163 163 k164 164 k165 165 k166 166 k167 167 k168 168 k169 169 k170 170 k171 171 k172 172 k173 173 k174 174 k175 175 k176 176 k177 177 k178 178 k179 179 k180 180 k181 181 k182 182 k183 183 k184 184 k185 185 k186 186 k187 187 k188 188 k189 189 k190 190 k191 191 k10 10 k11 11 k12 12 k13 13 k14 14 k15 15 k16 16 k17 17 k18 18 k20 20 k19 19 k21 21 k22 22 k23 23 k24 24 k25 25 k26 26 k27 27 k28 28 k30 30 k29 29 k31 31 k32 32 k33 33 k34 34 k35 35 k36 36 k37 37 k38 38 k40 40 k39 39 k41 41 k42 42 k43 43 k44 44 k45 45 k46 46 k47 47 k48 48 k49 49 k50 50 k51 51 k52 52 k53 53 k54 54 k55 55 k56 56 k57 57 k58 58 k59 59 k60 60 k61 61 k0 0 k62 62 k1 1 k63 63 k2 2 k64 64 k3 3 k65 65 k4 4 k66 66 k5 5 k67 67 k6 6 k68 68 k7 7 k69 69 k70 70 k8 8 k71 71 k9 9 k72 72 k73 73 k74 74 k75 75} {192 entries in table, 256 buckets\nnumber of buckets with 0 entries: 93\nnumber of buckets with 1 entries: 135\nnumber of buckets with 2 entries: 27\nnumber of buckets with 3 entries: 1\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.2}",
    "", false, "hash-order-111",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<192} {incr i} {set a(k$i) $i};for {set i 0} {$i<192} {incr i 2} {unset a(k$i)};list [array names a] [array statistics a]",
    "{k77 k79 k81 k83 k85 k87 k89 k91 k93 k95 k97 k99 k101 k103 k105 k107 k109 k111 k113 k115 k117 k119 k121 k123 k125 k127 k129 k131 k133 k135 k137 k139 k141 k143 k145 k147 k149 k151 k153 k155 k157 k159 k161 k163 k165 k167 k169 k171 k173 k175 k177 k179 k181 k183 k185 k187 k189 k191 k11 k13 k15 k17 k19 k21 k23 k25 k27 k29 k31 k33 k35 k37 k39 k41 k43 k45 k47 k49 k51 k53 k55 k57 k59 k61 k1 k63 k3 k65 k5 k67 k7 k69 k71 k9 k73 k75} {96 entries in table, 256 buckets\nnumber of buckets with 0 entries: 165\nnumber of buckets with 1 entries: 86\nnumber of buckets with 2 entries: 5\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.1}",
    "", false, "hash-delete-112",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<192} {incr i} {set a(k$i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{k76 k77 k78 k79 k80 k81 k82 k83 k84 k85 k86 k87 k88 k89 k90 k91 k92 k93 k94 k95 k96 k97 k98 k100 k99 k101 k102 k103 k104 k105 k106 k107 k108 k109 k110 k111 k112 k113 k114 k115 k116 k117 k118 k119 k120 k121 k122 k123 k124 k125 k126 k127 k128 k129 k130 k131 k132 k133 k134 k135 k136 k137 k138 k139 k140 k141 k142 k143 k144 k145 k146 k147 k148 k149 k150 k151 k152 k153 k154 k155 k156 k157 k158 k159 k160 k161 k162 k163 k164 k165 k166 k167 k168 k169 k170 k171 k172 k173 k174 k175 k176 k177 k178 k179 k180 k181 k182 k183 k184 k185 k186 k187 k188 k189 k190 k191 k10 k11 k12 k13 k14 k15 k16 k17 k18 k20 k19 k21 k22 k23 k24 k25 k26 k27 k28 k30 k29 k31 k32 k33 k34 k35 k36 k37 k38 k40 k39 k41 k42 k43 k44 k45 k46 k47 k48 k49 k50 k51 k52 k53 k54 k55 k56 k57 k58 k59 k60 k61 k0 k62 k1 k63 k2 k64 k3 k65 k4 k66 k5 k67 k6 k68 k7 k69 k70 k8 k71 k9 k72 k73 k74 k75} 0 {} {}",
    "", false, "cursor-order-113",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<192} {incr i} {set a(same$i) $i};list [array names a] [array get a] [array statistics a]",
    "{same145 same146 same147 same148 same149 same150 same151 same152 same153 same154 same155 same156 same157 same158 same159 same160 same161 same162 same163 same164 same165 same166 same167 same168 same169 same170 same171 same172 same173 same174 same175 same176 same177 same178 same179 same180 same181 same182 same183 same184 same185 same186 same187 same188 same189 same190 same191 same10 same11 same12 same13 same14 same15 same16 same17 same18 same20 same19 same21 same22 same23 same24 same25 same26 same27 same28 same30 same29 same31 same32 same33 same34 same35 same36 same37 same38 same40 same39 same41 same42 same43 same44 same45 same46 same47 same48 same49 same50 same51 same52 same53 same54 same55 same56 same57 same58 same59 same60 same61 same62 same63 same64 same65 same66 same67 same68 same69 same70 same71 same72 same73 same74 same75 same76 same77 same78 same79 same80 same81 same82 same83 same84 same85 same86 same87 same88 same89 same90 same91 same92 same93 same94 same95 same96 same97 same98 same99 same0 same1 same2 same3 same4 same5 same6 same7 same8 same9 same100 same101 same102 same103 same104 same105 same106 same107 same108 same109 same110 same111 same112 same113 same114 same115 same116 same117 same118 same119 same120 same121 same122 same123 same124 same125 same126 same127 same128 same129 same130 same131 same132 same133 same134 same135 same136 same137 same138 same139 same140 same141 same142 same143 same144} {same145 145 same146 146 same147 147 same148 148 same149 149 same150 150 same151 151 same152 152 same153 153 same154 154 same155 155 same156 156 same157 157 same158 158 same159 159 same160 160 same161 161 same162 162 same163 163 same164 164 same165 165 same166 166 same167 167 same168 168 same169 169 same170 170 same171 171 same172 172 same173 173 same174 174 same175 175 same176 176 same177 177 same178 178 same179 179 same180 180 same181 181 same182 182 same183 183 same184 184 same185 185 same186 186 same187 187 same188 188 same189 189 same190 190 same191 191 same10 10 same11 11 same12 12 same13 13 same14 14 same15 15 same16 16 same17 17 same18 18 same20 20 same19 19 same21 21 same22 22 same23 23 same24 24 same25 25 same26 26 same27 27 same28 28 same30 30 same29 29 same31 31 same32 32 same33 33 same34 34 same35 35 same36 36 same37 37 same38 38 same40 40 same39 39 same41 41 same42 42 same43 43 same44 44 same45 45 same46 46 same47 47 same48 48 same49 49 same50 50 same51 51 same52 52 same53 53 same54 54 same55 55 same56 56 same57 57 same58 58 same59 59 same60 60 same61 61 same62 62 same63 63 same64 64 same65 65 same66 66 same67 67 same68 68 same69 69 same70 70 same71 71 same72 72 same73 73 same74 74 same75 75 same76 76 same77 77 same78 78 same79 79 same80 80 same81 81 same82 82 same83 83 same84 84 same85 85 same86 86 same87 87 same88 88 same89 89 same90 90 same91 91 same92 92 same93 93 same94 94 same95 95 same96 96 same97 97 same98 98 same99 99 same0 0 same1 1 same2 2 same3 3 same4 4 same5 5 same6 6 same7 7 same8 8 same9 9 same100 100 same101 101 same102 102 same103 103 same104 104 same105 105 same106 106 same107 107 same108 108 same109 109 same110 110 same111 111 same112 112 same113 113 same114 114 same115 115 same116 116 same117 117 same118 118 same119 119 same120 120 same121 121 same122 122 same123 123 same124 124 same125 125 same126 126 same127 127 same128 128 same129 129 same130 130 same131 131 same132 132 same133 133 same134 134 same135 135 same136 136 same137 137 same138 138 same139 139 same140 140 same141 141 same142 142 same143 143 same144 144} {192 entries in table, 256 buckets\nnumber of buckets with 0 entries: 81\nnumber of buckets with 1 entries: 158\nnumber of buckets with 2 entries: 17\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.1}",
    "", false, "hash-order-114",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<192} {incr i} {set a(same$i) $i};for {set i 0} {$i<192} {incr i 2} {unset a(same$i)};list [array names a] [array statistics a]",
    "{same145 same147 same149 same151 same153 same155 same157 same159 same161 same163 same165 same167 same169 same171 same173 same175 same177 same179 same181 same183 same185 same187 same189 same191 same11 same13 same15 same17 same19 same21 same23 same25 same27 same29 same31 same33 same35 same37 same39 same41 same43 same45 same47 same49 same51 same53 same55 same57 same59 same61 same63 same65 same67 same69 same71 same73 same75 same77 same79 same81 same83 same85 same87 same89 same91 same93 same95 same97 same99 same1 same3 same5 same7 same9 same101 same103 same105 same107 same109 same111 same113 same115 same117 same119 same121 same123 same125 same127 same129 same131 same133 same135 same137 same139 same141 same143} {96 entries in table, 256 buckets\nnumber of buckets with 0 entries: 160\nnumber of buckets with 1 entries: 96\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "hash-delete-115",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<192} {incr i} {set a(same$i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{same145 same146 same147 same148 same149 same150 same151 same152 same153 same154 same155 same156 same157 same158 same159 same160 same161 same162 same163 same164 same165 same166 same167 same168 same169 same170 same171 same172 same173 same174 same175 same176 same177 same178 same179 same180 same181 same182 same183 same184 same185 same186 same187 same188 same189 same190 same191 same10 same11 same12 same13 same14 same15 same16 same17 same18 same20 same19 same21 same22 same23 same24 same25 same26 same27 same28 same30 same29 same31 same32 same33 same34 same35 same36 same37 same38 same40 same39 same41 same42 same43 same44 same45 same46 same47 same48 same49 same50 same51 same52 same53 same54 same55 same56 same57 same58 same59 same60 same61 same62 same63 same64 same65 same66 same67 same68 same69 same70 same71 same72 same73 same74 same75 same76 same77 same78 same79 same80 same81 same82 same83 same84 same85 same86 same87 same88 same89 same90 same91 same92 same93 same94 same95 same96 same97 same98 same99 same0 same1 same2 same3 same4 same5 same6 same7 same8 same9 same100 same101 same102 same103 same104 same105 same106 same107 same108 same109 same110 same111 same112 same113 same114 same115 same116 same117 same118 same119 same120 same121 same122 same123 same124 same125 same126 same127 same128 same129 same130 same131 same132 same133 same134 same135 same136 same137 same138 same139 same140 same141 same142 same143 same144} 0 {} {}",
    "", false, "cursor-order-116",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<193} {incr i} {set a($i) $i};list [array names a] [array get a] [array statistics a]",
    "{35 36 37 38 40 39 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 0 88 1 89 90 2 91 3 92 4 93 5 94 6 95 7 96 8 97 9 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 10 11 12 13 14 15 16 17 18 20 19 21 22 23 24 25 26 27 28 30 29 31 32 33 34} {35 35 36 36 37 37 38 38 40 40 39 39 41 41 42 42 43 43 44 44 45 45 46 46 47 47 48 48 49 49 50 50 51 51 52 52 53 53 54 54 55 55 56 56 57 57 58 58 59 59 60 60 61 61 62 62 63 63 64 64 65 65 66 66 67 67 68 68 69 69 70 70 71 71 72 72 73 73 74 74 75 75 76 76 77 77 78 78 79 79 80 80 81 81 82 82 83 83 84 84 85 85 86 86 87 87 0 0 88 88 1 1 89 89 90 90 2 2 91 91 3 3 92 92 4 4 93 93 5 5 94 94 6 6 95 95 7 7 96 96 8 8 97 97 9 9 98 98 99 99 100 100 101 101 102 102 103 103 104 104 105 105 106 106 107 107 108 108 109 109 110 110 111 111 112 112 113 113 114 114 115 115 116 116 117 117 118 118 119 119 120 120 121 121 122 122 123 123 124 124 125 125 126 126 127 127 128 128 129 129 130 130 131 131 132 132 133 133 134 134 135 135 136 136 137 137 138 138 139 139 140 140 141 141 142 142 143 143 144 144 145 145 146 146 147 147 148 148 149 149 150 150 151 151 152 152 153 153 154 154 155 155 156 156 157 157 158 158 159 159 160 160 161 161 162 162 163 163 164 164 165 165 166 166 167 167 168 168 169 169 170 170 171 171 172 172 173 173 174 174 175 175 176 176 177 177 178 178 179 179 180 180 181 181 182 182 183 183 184 184 185 185 186 186 187 187 188 188 189 189 190 190 191 191 192 192 10 10 11 11 12 12 13 13 14 14 15 15 16 16 17 17 18 18 20 20 19 19 21 21 22 22 23 23 24 24 25 25 26 26 27 27 28 28 30 30 29 29 31 31 32 32 33 33 34 34} {193 entries in table, 256 buckets\nnumber of buckets with 0 entries: 90\nnumber of buckets with 1 entries: 140\nnumber of buckets with 2 entries: 25\nnumber of buckets with 3 entries: 1\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.1}",
    "", false, "hash-order-117",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<193} {incr i} {set a($i) $i};for {set i 0} {$i<193} {incr i 2} {unset a($i)};list [array names a] [array statistics a]",
    "{35 37 39 41 43 45 47 49 51 53 55 57 59 61 63 65 67 69 71 73 75 77 79 81 83 85 87 1 89 91 3 93 5 95 7 97 9 99 101 103 105 107 109 111 113 115 117 119 121 123 125 127 129 131 133 135 137 139 141 143 145 147 149 151 153 155 157 159 161 163 165 167 169 171 173 175 177 179 181 183 185 187 189 191 11 13 15 17 19 21 23 25 27 29 31 33} {96 entries in table, 256 buckets\nnumber of buckets with 0 entries: 161\nnumber of buckets with 1 entries: 94\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "hash-delete-118",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<193} {incr i} {set a($i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{35 36 37 38 40 39 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 0 88 1 89 90 2 91 3 92 4 93 5 94 6 95 7 96 8 97 9 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 10 11 12 13 14 15 16 17 18 20 19 21 22 23 24 25 26 27 28 30 29 31 32 33 34} 0 {} {}",
    "", false, "cursor-order-119",
  )
}

///|
test "Tcl array cases 121 through 160" {
  check_array_case(
    "array set a {};for {set i 0} {$i<193} {incr i} {set a(k$i) $i};list [array names a] [array get a] [array statistics a]",
    "{k76 k77 k78 k79 k80 k81 k82 k83 k84 k85 k86 k87 k88 k89 k90 k91 k92 k93 k94 k95 k96 k97 k98 k100 k99 k101 k102 k103 k104 k105 k106 k107 k108 k109 k110 k111 k112 k113 k114 k115 k116 k117 k118 k119 k120 k121 k122 k123 k124 k125 k126 k127 k128 k129 k130 k131 k132 k133 k134 k135 k136 k137 k138 k139 k140 k141 k142 k143 k144 k145 k146 k147 k148 k149 k150 k151 k152 k153 k154 k155 k156 k157 k158 k159 k160 k161 k162 k163 k164 k165 k166 k167 k168 k169 k170 k171 k172 k173 k174 k175 k176 k177 k178 k179 k180 k181 k182 k183 k184 k185 k186 k187 k188 k189 k190 k191 k192 k10 k11 k12 k13 k14 k15 k16 k17 k18 k20 k19 k21 k22 k23 k24 k25 k26 k27 k28 k30 k29 k31 k32 k33 k34 k35 k36 k37 k38 k40 k39 k41 k42 k43 k44 k45 k46 k47 k48 k49 k50 k51 k52 k53 k54 k55 k56 k57 k58 k59 k60 k61 k0 k62 k1 k63 k2 k64 k3 k65 k4 k66 k5 k67 k6 k68 k7 k69 k70 k8 k71 k9 k72 k73 k74 k75} {k76 76 k77 77 k78 78 k79 79 k80 80 k81 81 k82 82 k83 83 k84 84 k85 85 k86 86 k87 87 k88 88 k89 89 k90 90 k91 91 k92 92 k93 93 k94 94 k95 95 k96 96 k97 97 k98 98 k100 100 k99 99 k101 101 k102 102 k103 103 k104 104 k105 105 k106 106 k107 107 k108 108 k109 109 k110 110 k111 111 k112 112 k113 113 k114 114 k115 115 k116 116 k117 117 k118 118 k119 119 k120 120 k121 121 k122 122 k123 123 k124 124 k125 125 k126 126 k127 127 k128 128 k129 129 k130 130 k131 131 k132 132 k133 133 k134 134 k135 135 k136 136 k137 137 k138 138 k139 139 k140 140 k141 141 k142 142 k143 143 k144 144 k145 145 k146 146 k147 147 k148 148 k149 149 k150 150 k151 151 k152 152 k153 153 k154 154 k155 155 k156 156 k157 157 k158 158 k159 159 k160 160 k161 161 k162 162 k163 163 k164 164 k165 165 k166 166 k167 167 k168 168 k169 169 k170 170 k171 171 k172 172 k173 173 k174 174 k175 175 k176 176 k177 177 k178 178 k179 179 k180 180 k181 181 k182 182 k183 183 k184 184 k185 185 k186 186 k187 187 k188 188 k189 189 k190 190 k191 191 k192 192 k10 10 k11 11 k12 12 k13 13 k14 14 k15 15 k16 16 k17 17 k18 18 k20 20 k19 19 k21 21 k22 22 k23 23 k24 24 k25 25 k26 26 k27 27 k28 28 k30 30 k29 29 k31 31 k32 32 k33 33 k34 34 k35 35 k36 36 k37 37 k38 38 k40 40 k39 39 k41 41 k42 42 k43 43 k44 44 k45 45 k46 46 k47 47 k48 48 k49 49 k50 50 k51 51 k52 52 k53 53 k54 54 k55 55 k56 56 k57 57 k58 58 k59 59 k60 60 k61 61 k0 0 k62 62 k1 1 k63 63 k2 2 k64 64 k3 3 k65 65 k4 4 k66 66 k5 5 k67 67 k6 6 k68 68 k7 7 k69 69 k70 70 k8 8 k71 71 k9 9 k72 72 k73 73 k74 74 k75 75} {193 entries in table, 256 buckets\nnumber of buckets with 0 entries: 92\nnumber of buckets with 1 entries: 136\nnumber of buckets with 2 entries: 27\nnumber of buckets with 3 entries: 1\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.2}",
    "", false, "hash-order-120",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<193} {incr i} {set a(k$i) $i};for {set i 0} {$i<193} {incr i 2} {unset a(k$i)};list [array names a] [array statistics a]",
    "{k77 k79 k81 k83 k85 k87 k89 k91 k93 k95 k97 k99 k101 k103 k105 k107 k109 k111 k113 k115 k117 k119 k121 k123 k125 k127 k129 k131 k133 k135 k137 k139 k141 k143 k145 k147 k149 k151 k153 k155 k157 k159 k161 k163 k165 k167 k169 k171 k173 k175 k177 k179 k181 k183 k185 k187 k189 k191 k11 k13 k15 k17 k19 k21 k23 k25 k27 k29 k31 k33 k35 k37 k39 k41 k43 k45 k47 k49 k51 k53 k55 k57 k59 k61 k1 k63 k3 k65 k5 k67 k7 k69 k71 k9 k73 k75} {96 entries in table, 256 buckets\nnumber of buckets with 0 entries: 165\nnumber of buckets with 1 entries: 86\nnumber of buckets with 2 entries: 5\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.1}",
    "", false, "hash-delete-121",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<193} {incr i} {set a(k$i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{k76 k77 k78 k79 k80 k81 k82 k83 k84 k85 k86 k87 k88 k89 k90 k91 k92 k93 k94 k95 k96 k97 k98 k100 k99 k101 k102 k103 k104 k105 k106 k107 k108 k109 k110 k111 k112 k113 k114 k115 k116 k117 k118 k119 k120 k121 k122 k123 k124 k125 k126 k127 k128 k129 k130 k131 k132 k133 k134 k135 k136 k137 k138 k139 k140 k141 k142 k143 k144 k145 k146 k147 k148 k149 k150 k151 k152 k153 k154 k155 k156 k157 k158 k159 k160 k161 k162 k163 k164 k165 k166 k167 k168 k169 k170 k171 k172 k173 k174 k175 k176 k177 k178 k179 k180 k181 k182 k183 k184 k185 k186 k187 k188 k189 k190 k191 k192 k10 k11 k12 k13 k14 k15 k16 k17 k18 k20 k19 k21 k22 k23 k24 k25 k26 k27 k28 k30 k29 k31 k32 k33 k34 k35 k36 k37 k38 k40 k39 k41 k42 k43 k44 k45 k46 k47 k48 k49 k50 k51 k52 k53 k54 k55 k56 k57 k58 k59 k60 k61 k0 k62 k1 k63 k2 k64 k3 k65 k4 k66 k5 k67 k6 k68 k7 k69 k70 k8 k71 k9 k72 k73 k74 k75} 0 {} {}",
    "", false, "cursor-order-122",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<193} {incr i} {set a(same$i) $i};list [array names a] [array get a] [array statistics a]",
    "{same145 same146 same147 same148 same149 same150 same151 same152 same153 same154 same155 same156 same157 same158 same159 same160 same161 same162 same163 same164 same165 same166 same167 same168 same169 same170 same171 same172 same173 same174 same175 same176 same177 same178 same179 same180 same181 same182 same183 same184 same185 same186 same187 same188 same189 same190 same191 same192 same10 same11 same12 same13 same14 same15 same16 same17 same18 same20 same19 same21 same22 same23 same24 same25 same26 same27 same28 same30 same29 same31 same32 same33 same34 same35 same36 same37 same38 same40 same39 same41 same42 same43 same44 same45 same46 same47 same48 same49 same50 same51 same52 same53 same54 same55 same56 same57 same58 same59 same60 same61 same62 same63 same64 same65 same66 same67 same68 same69 same70 same71 same72 same73 same74 same75 same76 same77 same78 same79 same80 same81 same82 same83 same84 same85 same86 same87 same88 same89 same90 same91 same92 same93 same94 same95 same96 same97 same98 same99 same0 same1 same2 same3 same4 same5 same6 same7 same8 same9 same100 same101 same102 same103 same104 same105 same106 same107 same108 same109 same110 same111 same112 same113 same114 same115 same116 same117 same118 same119 same120 same121 same122 same123 same124 same125 same126 same127 same128 same129 same130 same131 same132 same133 same134 same135 same136 same137 same138 same139 same140 same141 same142 same143 same144} {same145 145 same146 146 same147 147 same148 148 same149 149 same150 150 same151 151 same152 152 same153 153 same154 154 same155 155 same156 156 same157 157 same158 158 same159 159 same160 160 same161 161 same162 162 same163 163 same164 164 same165 165 same166 166 same167 167 same168 168 same169 169 same170 170 same171 171 same172 172 same173 173 same174 174 same175 175 same176 176 same177 177 same178 178 same179 179 same180 180 same181 181 same182 182 same183 183 same184 184 same185 185 same186 186 same187 187 same188 188 same189 189 same190 190 same191 191 same192 192 same10 10 same11 11 same12 12 same13 13 same14 14 same15 15 same16 16 same17 17 same18 18 same20 20 same19 19 same21 21 same22 22 same23 23 same24 24 same25 25 same26 26 same27 27 same28 28 same30 30 same29 29 same31 31 same32 32 same33 33 same34 34 same35 35 same36 36 same37 37 same38 38 same40 40 same39 39 same41 41 same42 42 same43 43 same44 44 same45 45 same46 46 same47 47 same48 48 same49 49 same50 50 same51 51 same52 52 same53 53 same54 54 same55 55 same56 56 same57 57 same58 58 same59 59 same60 60 same61 61 same62 62 same63 63 same64 64 same65 65 same66 66 same67 67 same68 68 same69 69 same70 70 same71 71 same72 72 same73 73 same74 74 same75 75 same76 76 same77 77 same78 78 same79 79 same80 80 same81 81 same82 82 same83 83 same84 84 same85 85 same86 86 same87 87 same88 88 same89 89 same90 90 same91 91 same92 92 same93 93 same94 94 same95 95 same96 96 same97 97 same98 98 same99 99 same0 0 same1 1 same2 2 same3 3 same4 4 same5 5 same6 6 same7 7 same8 8 same9 9 same100 100 same101 101 same102 102 same103 103 same104 104 same105 105 same106 106 same107 107 same108 108 same109 109 same110 110 same111 111 same112 112 same113 113 same114 114 same115 115 same116 116 same117 117 same118 118 same119 119 same120 120 same121 121 same122 122 same123 123 same124 124 same125 125 same126 126 same127 127 same128 128 same129 129 same130 130 same131 131 same132 132 same133 133 same134 134 same135 135 same136 136 same137 137 same138 138 same139 139 same140 140 same141 141 same142 142 same143 143 same144 144} {193 entries in table, 256 buckets\nnumber of buckets with 0 entries: 80\nnumber of buckets with 1 entries: 159\nnumber of buckets with 2 entries: 17\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.1}",
    "", false, "hash-order-123",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<193} {incr i} {set a(same$i) $i};for {set i 0} {$i<193} {incr i 2} {unset a(same$i)};list [array names a] [array statistics a]",
    "{same145 same147 same149 same151 same153 same155 same157 same159 same161 same163 same165 same167 same169 same171 same173 same175 same177 same179 same181 same183 same185 same187 same189 same191 same11 same13 same15 same17 same19 same21 same23 same25 same27 same29 same31 same33 same35 same37 same39 same41 same43 same45 same47 same49 same51 same53 same55 same57 same59 same61 same63 same65 same67 same69 same71 same73 same75 same77 same79 same81 same83 same85 same87 same89 same91 same93 same95 same97 same99 same1 same3 same5 same7 same9 same101 same103 same105 same107 same109 same111 same113 same115 same117 same119 same121 same123 same125 same127 same129 same131 same133 same135 same137 same139 same141 same143} {96 entries in table, 256 buckets\nnumber of buckets with 0 entries: 160\nnumber of buckets with 1 entries: 96\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "hash-delete-124",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<193} {incr i} {set a(same$i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{same145 same146 same147 same148 same149 same150 same151 same152 same153 same154 same155 same156 same157 same158 same159 same160 same161 same162 same163 same164 same165 same166 same167 same168 same169 same170 same171 same172 same173 same174 same175 same176 same177 same178 same179 same180 same181 same182 same183 same184 same185 same186 same187 same188 same189 same190 same191 same192 same10 same11 same12 same13 same14 same15 same16 same17 same18 same20 same19 same21 same22 same23 same24 same25 same26 same27 same28 same30 same29 same31 same32 same33 same34 same35 same36 same37 same38 same40 same39 same41 same42 same43 same44 same45 same46 same47 same48 same49 same50 same51 same52 same53 same54 same55 same56 same57 same58 same59 same60 same61 same62 same63 same64 same65 same66 same67 same68 same69 same70 same71 same72 same73 same74 same75 same76 same77 same78 same79 same80 same81 same82 same83 same84 same85 same86 same87 same88 same89 same90 same91 same92 same93 same94 same95 same96 same97 same98 same99 same0 same1 same2 same3 same4 same5 same6 same7 same8 same9 same100 same101 same102 same103 same104 same105 same106 same107 same108 same109 same110 same111 same112 same113 same114 same115 same116 same117 same118 same119 same120 same121 same122 same123 same124 same125 same126 same127 same128 same129 same130 same131 same132 same133 same134 same135 same136 same137 same138 same139 same140 same141 same142 same143 same144} 0 {} {}",
    "", false, "cursor-order-125",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<767} {incr i} {set a($i) $i};list [array names a] [array get a] [array statistics a]",
    "{611 286 35 612 287 36 613 288 37 614 300 290 289 38 615 301 291 40 39 616 302 292 41 617 303 293 42 618 304 294 43 620 619 305 295 44 621 306 296 45 622 307 297 46 623 308 298 47 624 310 309 299 48 625 311 49 50 626 312 51 627 313 52 628 314 53 630 629 315 54 631 316 55 632 317 56 633 318 57 634 320 319 58 635 321 59 60 636 322 61 637 323 62 638 324 63 640 639 325 64 641 326 65 642 327 66 643 328 67 644 330 329 68 645 331 69 70 646 332 71 647 333 72 648 334 73 650 649 335 74 651 336 75 652 337 76 653 338 77 654 340 339 78 655 341 79 80 656 342 81 657 343 82 658 344 83 660 659 345 84 661 346 85 662 347 86 663 348 87 664 350 349 0 88 665 351 1 89 90 666 352 2 91 667 353 3 92 668 354 4 93 670 669 355 5 94 671 356 6 95 672 357 7 96 673 358 8 97 674 360 359 9 98 675 361 99 676 362 677 363 678 364 680 679 365 681 366 682 367 683 368 684 370 369 685 371 686 372 687 373 688 374 700 690 689 375 701 691 376 702 692 377 703 693 378 704 694 380 379 705 695 381 706 696 382 707 697 383 708 698 384 710 709 699 385 711 386 712 387 713 388 714 400 390 389 715 401 391 716 402 392 717 403 393 718 404 394 720 719 405 395 721 406 396 722 407 397 723 408 398 724 410 409 399 725 411 726 412 727 413 728 414 100 730 729 415 101 731 416 102 732 417 103 733 418 104 734 420 419 105 735 421 106 736 422 107 737 423 108 738 424 109 110 740 739 425 111 741 426 112 742 427 113 743 428 114 744 430 429 115 745 431 116 746 432 117 747 433 118 748 434 119 120 750 749 435 121 751 436 122 752 437 123 753 438 124 754 440 439 125 755 441 126 756 442 127 757 443 128 758 444 129 130 760 759 445 131 761 446 132 762 447 133 763 448 134 764 450 449 135 765 451 136 766 452 137 453 138 454 139 140 455 141 456 142 457 143 458 144 460 459 145 461 146 462 147 463 148 464 149 150 465 151 466 152 467 153 468 154 470 469 155 471 156 472 157 473 158 474 159 160 475 161 476 162 477 163 478 164 480 479 165 481 166 482 167 483 168 484 169 170 485 171 486 172 487 173 488 174 500 490 489 175 501 491 176 502 492 177 503 493 178 504 494 179 180 505 495 181 506 496 182 507 497 183 508 498 184 510 509 499 185 511 186 512 187 513 188 514 200 189 190 515 201 191 516 202 192 517 203 193 518 204 194 520 519 205 195 521 206 196 522 207 197 523 208 198 524 210 209 199 525 211 526 212 527 213 528 214 530 529 215 531 216 532 217 533 218 534 220 219 535 221 536 222 537 223 538 224 540 539 225 541 226 542 227 543 228 544 230 229 545 231 546 232 547 233 548 234 550 549 235 551 236 552 237 553 238 554 240 239 555 241 556 242 557 243 558 244 560 559 245 561 246 562 247 563 248 564 250 249 565 251 566 252 567 253 568 254 570 569 255 571 256 572 257 573 258 574 260 259 575 261 10 576 262 11 577 263 12 578 264 13 580 579 265 14 581 266 15 582 267 16 583 268 17 584 270 269 18 585 271 20 19 586 272 21 587 273 22 588 274 23 600 590 589 275 24 601 591 276 25 602 592 277 26 603 593 278 27 604 594 280 279 28 605 595 281 30 29 606 596 282 31 607 597 283 32 608 598 284 33 610 609 599 285 34} {611 611 286 286 35 35 612 612 287 287 36 36 613 613 288 288 37 37 614 614 300 300 290 290 289 289 38 38 615 615 301 301 291 291 40 40 39 39 616 616 302 302 292 292 41 41 617 617 303 303 293 293 42 42 618 618 304 304 294 294 43 43 620 620 619 619 305 305 295 295 44 44 621 621 306 306 296 296 45 45 622 622 307 307 297 297 46 46 623 623 308 308 298 298 47 47 624 624 310 310 309 309 299 299 48 48 625 625 311 311 49 49 50 50 626 626 312 312 51 51 627 627 313 313 52 52 628 628 314 314 53 53 630 630 629 629 315 315 54 54 631 631 316 316 55 55 632 632 317 317 56 56 633 633 318 318 57 57 634 634 320 320 319 319 58 58 635 635 321 321 59 59 60 60 636 636 322 322 61 61 637 637 323 323 62 62 638 638 324 324 63 63 640 640 639 639 325 325 64 64 641 641 326 326 65 65 642 642 327 327 66 66 643 643 328 328 67 67 644 644 330 330 329 329 68 68 645 645 331 331 69 69 70 70 646 646 332 332 71 71 647 647 333 333 72 72 648 648 334 334 73 73 650 650 649 649 335 335 74 74 651 651 336 336 75 75 652 652 337 337 76 76 653 653 338 338 77 77 654 654 340 340 339 339 78 78 655 655 341 341 79 79 80 80 656 656 342 342 81 81 657 657 343 343 82 82 658 658 344 344 83 83 660 660 659 659 345 345 84 84 661 661 346 346 85 85 662 662 347 347 86 86 663 663 348 348 87 87 664 664 350 350 349 349 0 0 88 88 665 665 351 351 1 1 89 89 90 90 666 666 352 352 2 2 91 91 667 667 353 353 3 3 92 92 668 668 354 354 4 4 93 93 670 670 669 669 355 355 5 5 94 94 671 671 356 356 6 6 95 95 672 672 357 357 7 7 96 96 673 673 358 358 8 8 97 97 674 674 360 360 359 359 9 9 98 98 675 675 361 361 99 99 676 676 362 362 677 677 363 363 678 678 364 364 680 680 679 679 365 365 681 681 366 366 682 682 367 367 683 683 368 368 684 684 370 370 369 369 685 685 371 371 686 686 372 372 687 687 373 373 688 688 374 374 700 700 690 690 689 689 375 375 701 701 691 691 376 376 702 702 692 692 377 377 703 703 693 693 378 378 704 704 694 694 380 380 379 379 705 705 695 695 381 381 706 706 696 696 382 382 707 707 697 697 383 383 708 708 698 698 384 384 710 710 709 709 699 699 385 385 711 711 386 386 712 712 387 387 713 713 388 388 714 714 400 400 390 390 389 389 715 715 401 401 391 391 716 716 402 402 392 392 717 717 403 403 393 393 718 718 404 404 394 394 720 720 719 719 405 405 395 395 721 721 406 406 396 396 722 722 407 407 397 397 723 723 408 408 398 398 724 724 410 410 409 409 399 399 725 725 411 411 726 726 412 412 727 727 413 413 728 728 414 414 100 100 730 730 729 729 415 415 101 101 731 731 416 416 102 102 732 732 417 417 103 103 733 733 418 418 104 104 734 734 420 420 419 419 105 105 735 735 421 421 106 106 736 736 422 422 107 107 737 737 423 423 108 108 738 738 424 424 109 109 110 110 740 740 739 739 425 425 111 111 741 741 426 426 112 112 742 742 427 427 113 113 743 743 428 428 114 114 744 744 430 430 429 429 115 115 745 745 431 431 116 116 746 746 432 432 117 117 747 747 433 433 118 118 748 748 434 434 119 119 120 120 750 750 749 749 435 435 121 121 751 751 436 436 122 122 752 752 437 437 123 123 753 753 438 438 124 124 754 754 440 440 439 439 125 125 755 755 441 441 126 126 756 756 442 442 127 127 757 757 443 443 128 128 758 758 444 444 129 129 130 130 760 760 759 759 445 445 131 131 761 761 446 446 132 132 762 762 447 447 133 133 763 763 448 448 134 134 764 764 450 450 449 449 135 135 765 765 451 451 136 136 766 766 452 452 137 137 453 453 138 138 454 454 139 139 140 140 455 455 141 141 456 456 142 142 457 457 143 143 458 458 144 144 460 460 459 459 145 145 461 461 146 146 462 462 147 147 463 463 148 148 464 464 149 149 150 150 465 465 151 151 466 466 152 152 467 467 153 153 468 468 154 154 470 470 469 469 155 155 471 471 156 156 472 472 157 157 473 473 158 158 474 474 159 159 160 160 475 475 161 161 476 476 162 162 477 477 163 163 478 478 164 164 480 480 479 479 165 165 481 481 166 166 482 482 167 167 483 483 168 168 484 484 169 169 170 170 485 485 171 171 486 486 172 172 487 487 173 173 488 488 174 174 500 500 490 490 489 489 175 175 501 501 491 491 176 176 502 502 492 492 177 177 503 503 493 493 178 178 504 504 494 494 179 179 180 180 505 505 495 495 181 181 506 506 496 496 182 182 507 507 497 497 183 183 508 508 498 498 184 184 510 510 509 509 499 499 185 185 511 511 186 186 512 512 187 187 513 513 188 188 514 514 200 200 189 189 190 190 515 515 201 201 191 191 516 516 202 202 192 192 517 517 203 203 193 193 518 518 204 204 194 194 520 520 519 519 205 205 195 195 521 521 206 206 196 196 522 522 207 207 197 197 523 523 208 208 198 198 524 524 210 210 209 209 199 199 525 525 211 211 526 526 212 212 527 527 213 213 528 528 214 214 530 530 529 529 215 215 531 531 216 216 532 532 217 217 533 533 218 218 534 534 220 220 219 219 535 535 221 221 536 536 222 222 537 537 223 223 538 538 224 224 540 540 539 539 225 225 541 541 226 226 542 542 227 227 543 543 228 228 544 544 230 230 229 229 545 545 231 231 546 546 232 232 547 547 233 233 548 548 234 234 550 550 549 549 235 235 551 551 236 236 552 552 237 237 553 553 238 238 554 554 240 240 239 239 555 555 241 241 556 556 242 242 557 557 243 243 558 558 244 244 560 560 559 559 245 245 561 561 246 246 562 562 247 247 563 563 248 248 564 564 250 250 249 249 565 565 251 251 566 566 252 252 567 567 253 253 568 568 254 254 570 570 569 569 255 255 571 571 256 256 572 572 257 257 573 573 258 258 574 574 260 260 259 259 575 575 261 261 10 10 576 576 262 262 11 11 577 577 263 263 12 12 578 578 264 264 13 13 580 580 579 579 265 265 14 14 581 581 266 266 15 15 582 582 267 267 16 16 583 583 268 268 17 17 584 584 270 270 269 269 18 18 585 585 271 271 20 20 19 19 586 586 272 272 21 21 587 587 273 273 22 22 588 588 274 274 23 23 600 600 590 590 589 589 275 275 24 24 601 601 591 591 276 276 25 25 602 602 592 592 277 277 26 26 603 603 593 593 278 278 27 27 604 604 594 594 280 280 279 279 28 28 605 605 595 595 281 281 30 30 29 29 606 606 596 596 282 282 31 31 607 607 597 597 283 283 32 32 608 608 598 598 284 284 33 33 610 610 609 609 599 599 285 285 34 34} {767 entries in table, 256 buckets\nnumber of buckets with 0 entries: 0\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 80\nnumber of buckets with 3 entries: 109\nnumber of buckets with 4 entries: 55\nnumber of buckets with 5 entries: 12\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 2.1}",
    "", false, "hash-order-126",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<767} {incr i} {set a($i) $i};for {set i 0} {$i<767} {incr i 2} {unset a($i)};list [array names a] [array statistics a]",
    "{611 35 287 613 37 289 615 301 291 39 41 617 303 293 43 619 305 295 621 45 307 297 623 47 309 299 625 311 49 51 627 313 53 629 315 631 55 317 633 57 319 635 321 59 61 637 323 63 639 325 641 65 327 643 67 329 645 331 69 71 647 333 73 649 335 651 75 337 653 77 339 655 341 79 81 657 343 83 659 345 661 85 347 663 87 349 665 351 1 89 91 667 353 3 93 669 355 5 671 95 357 7 673 97 359 9 675 361 99 677 363 679 365 681 367 683 369 685 371 687 373 689 375 701 691 377 703 693 379 705 695 381 707 697 383 709 699 385 711 387 713 389 715 401 391 717 403 393 719 405 395 721 407 397 723 409 399 725 411 727 413 729 415 101 731 417 103 733 419 105 735 421 107 737 423 109 739 425 111 741 427 113 743 429 115 745 431 117 747 433 119 749 435 121 751 437 123 753 439 125 755 441 127 757 443 129 759 445 131 761 447 133 763 449 135 765 451 137 453 139 455 141 457 143 459 145 461 147 463 149 465 151 467 153 469 155 471 157 473 159 475 161 477 163 479 165 481 167 483 169 485 171 487 173 489 175 501 491 177 503 493 179 505 495 181 507 497 183 509 499 185 511 187 513 189 515 201 191 517 203 193 519 205 195 521 207 197 523 209 199 525 211 527 213 529 215 531 217 533 219 535 221 537 223 539 225 541 227 543 229 545 231 547 233 549 235 551 237 553 239 555 241 557 243 559 245 561 247 563 249 565 251 567 253 569 255 571 257 573 259 575 261 11 577 263 13 579 265 581 15 267 583 17 269 585 271 19 21 587 273 23 589 275 601 591 25 277 603 593 27 279 605 595 281 29 31 607 597 283 33 609 599 285} {383 entries in table, 256 buckets\nnumber of buckets with 0 entries: 32\nnumber of buckets with 1 entries: 101\nnumber of buckets with 2 entries: 90\nnumber of buckets with 3 entries: 30\nnumber of buckets with 4 entries: 3\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.5}",
    "", false, "hash-delete-127",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<767} {incr i} {set a($i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{611 286 35 612 287 36 613 288 37 614 300 290 289 38 615 301 291 40 39 616 302 292 41 617 303 293 42 618 304 294 43 620 619 305 295 44 621 306 296 45 622 307 297 46 623 308 298 47 624 310 309 299 48 625 311 49 50 626 312 51 627 313 52 628 314 53 630 629 315 54 631 316 55 632 317 56 633 318 57 634 320 319 58 635 321 59 60 636 322 61 637 323 62 638 324 63 640 639 325 64 641 326 65 642 327 66 643 328 67 644 330 329 68 645 331 69 70 646 332 71 647 333 72 648 334 73 650 649 335 74 651 336 75 652 337 76 653 338 77 654 340 339 78 655 341 79 80 656 342 81 657 343 82 658 344 83 660 659 345 84 661 346 85 662 347 86 663 348 87 664 350 349 0 88 665 351 1 89 90 666 352 2 91 667 353 3 92 668 354 4 93 670 669 355 5 94 671 356 6 95 672 357 7 96 673 358 8 97 674 360 359 9 98 675 361 99 676 362 677 363 678 364 680 679 365 681 366 682 367 683 368 684 370 369 685 371 686 372 687 373 688 374 700 690 689 375 701 691 376 702 692 377 703 693 378 704 694 380 379 705 695 381 706 696 382 707 697 383 708 698 384 710 709 699 385 711 386 712 387 713 388 714 400 390 389 715 401 391 716 402 392 717 403 393 718 404 394 720 719 405 395 721 406 396 722 407 397 723 408 398 724 410 409 399 725 411 726 412 727 413 728 414 100 730 729 415 101 731 416 102 732 417 103 733 418 104 734 420 419 105 735 421 106 736 422 107 737 423 108 738 424 109 110 740 739 425 111 741 426 112 742 427 113 743 428 114 744 430 429 115 745 431 116 746 432 117 747 433 118 748 434 119 120 750 749 435 121 751 436 122 752 437 123 753 438 124 754 440 439 125 755 441 126 756 442 127 757 443 128 758 444 129 130 760 759 445 131 761 446 132 762 447 133 763 448 134 764 450 449 135 765 451 136 766 452 137 453 138 454 139 140 455 141 456 142 457 143 458 144 460 459 145 461 146 462 147 463 148 464 149 150 465 151 466 152 467 153 468 154 470 469 155 471 156 472 157 473 158 474 159 160 475 161 476 162 477 163 478 164 480 479 165 481 166 482 167 483 168 484 169 170 485 171 486 172 487 173 488 174 500 490 489 175 501 491 176 502 492 177 503 493 178 504 494 179 180 505 495 181 506 496 182 507 497 183 508 498 184 510 509 499 185 511 186 512 187 513 188 514 200 189 190 515 201 191 516 202 192 517 203 193 518 204 194 520 519 205 195 521 206 196 522 207 197 523 208 198 524 210 209 199 525 211 526 212 527 213 528 214 530 529 215 531 216 532 217 533 218 534 220 219 535 221 536 222 537 223 538 224 540 539 225 541 226 542 227 543 228 544 230 229 545 231 546 232 547 233 548 234 550 549 235 551 236 552 237 553 238 554 240 239 555 241 556 242 557 243 558 244 560 559 245 561 246 562 247 563 248 564 250 249 565 251 566 252 567 253 568 254 570 569 255 571 256 572 257 573 258 574 260 259 575 261 10 576 262 11 577 263 12 578 264 13 580 579 265 14 581 266 15 582 267 16 583 268 17 584 270 269 18 585 271 20 19 586 272 21 587 273 22 588 274 23 600 590 589 275 24 601 591 276 25 602 592 277 26 603 593 278 27 604 594 280 279 28 605 595 281 30 29 606 596 282 31 607 597 283 32 608 598 284 33 610 609 599 285 34} 0 {} {}",
    "", false, "cursor-order-128",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<767} {incr i} {set a(k$i) $i};list [array names a] [array get a] [array statistics a]",
    "{k706 k696 k382 k76 k707 k697 k383 k77 k708 k698 k384 k78 k710 k709 k699 k385 k79 k80 k711 k386 k81 k712 k387 k82 k713 k388 k83 k714 k400 k390 k389 k84 k715 k401 k391 k85 k716 k402 k392 k86 k717 k403 k393 k87 k718 k404 k394 k88 k720 k719 k405 k395 k89 k90 k721 k406 k396 k91 k722 k407 k397 k92 k723 k408 k398 k93 k724 k410 k409 k399 k94 k725 k411 k95 k726 k412 k96 k727 k413 k97 k728 k414 k98 k100 k730 k729 k415 k99 k101 k731 k416 k102 k732 k417 k103 k733 k418 k104 k734 k420 k419 k105 k735 k421 k106 k736 k422 k107 k737 k423 k108 k738 k424 k109 k110 k740 k739 k425 k111 k741 k426 k112 k742 k427 k113 k743 k428 k114 k744 k430 k429 k115 k745 k431 k116 k746 k432 k117 k747 k433 k118 k748 k434 k119 k120 k750 k749 k435 k121 k751 k436 k122 k752 k437 k123 k753 k438 k124 k754 k440 k439 k125 k755 k441 k126 k756 k442 k127 k757 k443 k128 k758 k444 k129 k130 k760 k759 k445 k131 k761 k446 k132 k762 k447 k133 k763 k448 k134 k764 k450 k449 k135 k765 k451 k136 k766 k452 k137 k453 k138 k454 k139 k140 k455 k141 k456 k142 k457 k143 k458 k144 k460 k459 k145 k461 k146 k462 k147 k463 k148 k464 k149 k150 k465 k151 k466 k152 k467 k153 k468 k154 k470 k469 k155 k471 k156 k472 k157 k473 k158 k474 k159 k160 k475 k161 k476 k162 k477 k163 k478 k164 k480 k479 k165 k481 k166 k482 k167 k483 k168 k484 k169 k170 k485 k171 k486 k172 k487 k173 k488 k174 k500 k490 k489 k175 k501 k491 k176 k502 k492 k177 k503 k493 k178 k504 k494 k179 k180 k505 k495 k181 k506 k496 k182 k507 k497 k183 k508 k498 k184 k510 k509 k499 k185 k511 k186 k512 k187 k513 k188 k514 k200 k189 k190 k515 k201 k191 k516 k202 k192 k517 k203 k193 k518 k204 k194 k520 k519 k205 k195 k521 k206 k196 k522 k207 k197 k523 k208 k198 k524 k210 k209 k199 k525 k211 k526 k212 k527 k213 k528 k214 k530 k529 k215 k531 k216 k532 k217 k533 k218 k534 k220 k219 k535 k221 k536 k222 k537 k223 k538 k224 k540 k539 k225 k541 k226 k542 k227 k543 k228 k544 k230 k229 k545 k231 k546 k232 k547 k233 k548 k234 k550 k549 k235 k551 k236 k552 k237 k553 k238 k554 k240 k239 k555 k241 k556 k242 k557 k243 k558 k244 k560 k559 k245 k561 k246 k562 k247 k563 k248 k564 k250 k249 k565 k251 k566 k252 k567 k253 k568 k254 k570 k569 k255 k571 k256 k572 k257 k573 k258 k574 k260 k259 k575 k261 k576 k262 k577 k263 k578 k264 k580 k579 k265 k581 k266 k582 k267 k583 k268 k584 k270 k269 k585 k271 k586 k272 k587 k273 k588 k274 k600 k590 k589 k275 k601 k591 k276 k602 k592 k277 k603 k593 k278 k604 k594 k280 k279 k605 k595 k281 k606 k596 k282 k607 k597 k283 k608 k598 k284 k610 k609 k599 k285 k611 k286 k612 k287 k613 k288 k614 k300 k290 k289 k615 k301 k291 k616 k302 k292 k617 k303 k293 k618 k304 k294 k620 k619 k305 k295 k621 k306 k296 k622 k307 k297 k623 k308 k298 k624 k310 k309 k299 k625 k311 k626 k312 k627 k313 k628 k314 k630 k629 k315 k10 k631 k316 k11 k632 k317 k12 k633 k318 k13 k634 k320 k319 k14 k635 k321 k15 k636 k322 k16 k637 k323 k17 k638 k324 k18 k640 k639 k325 k20 k19 k641 k326 k21 k642 k327 k22 k643 k328 k23 k644 k330 k329 k24 k645 k331 k25 k646 k332 k26 k647 k333 k27 k648 k334 k28 k650 k649 k335 k30 k29 k651 k336 k31 k652 k337 k32 k653 k338 k33 k654 k340 k339 k34 k655 k341 k35 k656 k342 k36 k657 k343 k37 k658 k344 k38 k660 k659 k345 k40 k39 k661 k346 k41 k662 k347 k42 k663 k348 k43 k664 k350 k349 k44 k665 k351 k45 k666 k352 k46 k667 k353 k47 k668 k354 k48 k670 k669 k355 k49 k50 k671 k356 k51 k672 k357 k52 k673 k358 k53 k674 k360 k359 k54 k675 k361 k55 k676 k362 k56 k677 k363 k57 k678 k364 k58 k680 k679 k365 k59 k60 k681 k366 k61 k682 k367 k0 k62 k683 k368 k1 k63 k684 k370 k369 k2 k64 k685 k371 k3 k65 k686 k372 k4 k66 k687 k373 k5 k67 k688 k374 k6 k68 k700 k690 k689 k375 k7 k69 k70 k701 k691 k376 k8 k71 k702 k692 k377 k9 k72 k703 k693 k378 k73 k704 k694 k380 k379 k74 k705 k695 k381 k75} {k706 706 k696 696 k382 382 k76 76 k707 707 k697 697 k383 383 k77 77 k708 708 k698 698 k384 384 k78 78 k710 710 k709 709 k699 699 k385 385 k79 79 k80 80 k711 711 k386 386 k81 81 k712 712 k387 387 k82 82 k713 713 k388 388 k83 83 k714 714 k400 400 k390 390 k389 389 k84 84 k715 715 k401 401 k391 391 k85 85 k716 716 k402 402 k392 392 k86 86 k717 717 k403 403 k393 393 k87 87 k718 718 k404 404 k394 394 k88 88 k720 720 k719 719 k405 405 k395 395 k89 89 k90 90 k721 721 k406 406 k396 396 k91 91 k722 722 k407 407 k397 397 k92 92 k723 723 k408 408 k398 398 k93 93 k724 724 k410 410 k409 409 k399 399 k94 94 k725 725 k411 411 k95 95 k726 726 k412 412 k96 96 k727 727 k413 413 k97 97 k728 728 k414 414 k98 98 k100 100 k730 730 k729 729 k415 415 k99 99 k101 101 k731 731 k416 416 k102 102 k732 732 k417 417 k103 103 k733 733 k418 418 k104 104 k734 734 k420 420 k419 419 k105 105 k735 735 k421 421 k106 106 k736 736 k422 422 k107 107 k737 737 k423 423 k108 108 k738 738 k424 424 k109 109 k110 110 k740 740 k739 739 k425 425 k111 111 k741 741 k426 426 k112 112 k742 742 k427 427 k113 113 k743 743 k428 428 k114 114 k744 744 k430 430 k429 429 k115 115 k745 745 k431 431 k116 116 k746 746 k432 432 k117 117 k747 747 k433 433 k118 118 k748 748 k434 434 k119 119 k120 120 k750 750 k749 749 k435 435 k121 121 k751 751 k436 436 k122 122 k752 752 k437 437 k123 123 k753 753 k438 438 k124 124 k754 754 k440 440 k439 439 k125 125 k755 755 k441 441 k126 126 k756 756 k442 442 k127 127 k757 757 k443 443 k128 128 k758 758 k444 444 k129 129 k130 130 k760 760 k759 759 k445 445 k131 131 k761 761 k446 446 k132 132 k762 762 k447 447 k133 133 k763 763 k448 448 k134 134 k764 764 k450 450 k449 449 k135 135 k765 765 k451 451 k136 136 k766 766 k452 452 k137 137 k453 453 k138 138 k454 454 k139 139 k140 140 k455 455 k141 141 k456 456 k142 142 k457 457 k143 143 k458 458 k144 144 k460 460 k459 459 k145 145 k461 461 k146 146 k462 462 k147 147 k463 463 k148 148 k464 464 k149 149 k150 150 k465 465 k151 151 k466 466 k152 152 k467 467 k153 153 k468 468 k154 154 k470 470 k469 469 k155 155 k471 471 k156 156 k472 472 k157 157 k473 473 k158 158 k474 474 k159 159 k160 160 k475 475 k161 161 k476 476 k162 162 k477 477 k163 163 k478 478 k164 164 k480 480 k479 479 k165 165 k481 481 k166 166 k482 482 k167 167 k483 483 k168 168 k484 484 k169 169 k170 170 k485 485 k171 171 k486 486 k172 172 k487 487 k173 173 k488 488 k174 174 k500 500 k490 490 k489 489 k175 175 k501 501 k491 491 k176 176 k502 502 k492 492 k177 177 k503 503 k493 493 k178 178 k504 504 k494 494 k179 179 k180 180 k505 505 k495 495 k181 181 k506 506 k496 496 k182 182 k507 507 k497 497 k183 183 k508 508 k498 498 k184 184 k510 510 k509 509 k499 499 k185 185 k511 511 k186 186 k512 512 k187 187 k513 513 k188 188 k514 514 k200 200 k189 189 k190 190 k515 515 k201 201 k191 191 k516 516 k202 202 k192 192 k517 517 k203 203 k193 193 k518 518 k204 204 k194 194 k520 520 k519 519 k205 205 k195 195 k521 521 k206 206 k196 196 k522 522 k207 207 k197 197 k523 523 k208 208 k198 198 k524 524 k210 210 k209 209 k199 199 k525 525 k211 211 k526 526 k212 212 k527 527 k213 213 k528 528 k214 214 k530 530 k529 529 k215 215 k531 531 k216 216 k532 532 k217 217 k533 533 k218 218 k534 534 k220 220 k219 219 k535 535 k221 221 k536 536 k222 222 k537 537 k223 223 k538 538 k224 224 k540 540 k539 539 k225 225 k541 541 k226 226 k542 542 k227 227 k543 543 k228 228 k544 544 k230 230 k229 229 k545 545 k231 231 k546 546 k232 232 k547 547 k233 233 k548 548 k234 234 k550 550 k549 549 k235 235 k551 551 k236 236 k552 552 k237 237 k553 553 k238 238 k554 554 k240 240 k239 239 k555 555 k241 241 k556 556 k242 242 k557 557 k243 243 k558 558 k244 244 k560 560 k559 559 k245 245 k561 561 k246 246 k562 562 k247 247 k563 563 k248 248 k564 564 k250 250 k249 249 k565 565 k251 251 k566 566 k252 252 k567 567 k253 253 k568 568 k254 254 k570 570 k569 569 k255 255 k571 571 k256 256 k572 572 k257 257 k573 573 k258 258 k574 574 k260 260 k259 259 k575 575 k261 261 k576 576 k262 262 k577 577 k263 263 k578 578 k264 264 k580 580 k579 579 k265 265 k581 581 k266 266 k582 582 k267 267 k583 583 k268 268 k584 584 k270 270 k269 269 k585 585 k271 271 k586 586 k272 272 k587 587 k273 273 k588 588 k274 274 k600 600 k590 590 k589 589 k275 275 k601 601 k591 591 k276 276 k602 602 k592 592 k277 277 k603 603 k593 593 k278 278 k604 604 k594 594 k280 280 k279 279 k605 605 k595 595 k281 281 k606 606 k596 596 k282 282 k607 607 k597 597 k283 283 k608 608 k598 598 k284 284 k610 610 k609 609 k599 599 k285 285 k611 611 k286 286 k612 612 k287 287 k613 613 k288 288 k614 614 k300 300 k290 290 k289 289 k615 615 k301 301 k291 291 k616 616 k302 302 k292 292 k617 617 k303 303 k293 293 k618 618 k304 304 k294 294 k620 620 k619 619 k305 305 k295 295 k621 621 k306 306 k296 296 k622 622 k307 307 k297 297 k623 623 k308 308 k298 298 k624 624 k310 310 k309 309 k299 299 k625 625 k311 311 k626 626 k312 312 k627 627 k313 313 k628 628 k314 314 k630 630 k629 629 k315 315 k10 10 k631 631 k316 316 k11 11 k632 632 k317 317 k12 12 k633 633 k318 318 k13 13 k634 634 k320 320 k319 319 k14 14 k635 635 k321 321 k15 15 k636 636 k322 322 k16 16 k637 637 k323 323 k17 17 k638 638 k324 324 k18 18 k640 640 k639 639 k325 325 k20 20 k19 19 k641 641 k326 326 k21 21 k642 642 k327 327 k22 22 k643 643 k328 328 k23 23 k644 644 k330 330 k329 329 k24 24 k645 645 k331 331 k25 25 k646 646 k332 332 k26 26 k647 647 k333 333 k27 27 k648 648 k334 334 k28 28 k650 650 k649 649 k335 335 k30 30 k29 29 k651 651 k336 336 k31 31 k652 652 k337 337 k32 32 k653 653 k338 338 k33 33 k654 654 k340 340 k339 339 k34 34 k655 655 k341 341 k35 35 k656 656 k342 342 k36 36 k657 657 k343 343 k37 37 k658 658 k344 344 k38 38 k660 660 k659 659 k345 345 k40 40 k39 39 k661 661 k346 346 k41 41 k662 662 k347 347 k42 42 k663 663 k348 348 k43 43 k664 664 k350 350 k349 349 k44 44 k665 665 k351 351 k45 45 k666 666 k352 352 k46 46 k667 667 k353 353 k47 47 k668 668 k354 354 k48 48 k670 670 k669 669 k355 355 k49 49 k50 50 k671 671 k356 356 k51 51 k672 672 k357 357 k52 52 k673 673 k358 358 k53 53 k674 674 k360 360 k359 359 k54 54 k675 675 k361 361 k55 55 k676 676 k362 362 k56 56 k677 677 k363 363 k57 57 k678 678 k364 364 k58 58 k680 680 k679 679 k365 365 k59 59 k60 60 k681 681 k366 366 k61 61 k682 682 k367 367 k0 0 k62 62 k683 683 k368 368 k1 1 k63 63 k684 684 k370 370 k369 369 k2 2 k64 64 k685 685 k371 371 k3 3 k65 65 k686 686 k372 372 k4 4 k66 66 k687 687 k373 373 k5 5 k67 67 k688 688 k374 374 k6 6 k68 68 k700 700 k690 690 k689 689 k375 375 k7 7 k69 69 k70 70 k701 701 k691 691 k376 376 k8 8 k71 71 k702 702 k692 692 k377 377 k9 9 k72 72 k703 703 k693 693 k378 378 k73 73 k704 704 k694 694 k380 380 k379 379 k74 74 k705 705 k695 695 k381 381 k75 75} {767 entries in table, 256 buckets\nnumber of buckets with 0 entries: 0\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 82\nnumber of buckets with 3 entries: 112\nnumber of buckets with 4 entries: 47\nnumber of buckets with 5 entries: 12\nnumber of buckets with 6 entries: 2\nnumber of buckets with 7 entries: 1\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 2.1}",
    "", false, "hash-order-129",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<767} {incr i} {set a(k$i) $i};for {set i 0} {$i<767} {incr i 2} {unset a(k$i)};list [array names a] [array statistics a]",
    "{k707 k697 k383 k77 k709 k699 k385 k79 k711 k81 k387 k713 k83 k389 k715 k401 k391 k85 k717 k403 k393 k87 k719 k405 k395 k89 k721 k91 k407 k397 k723 k93 k409 k399 k725 k411 k95 k727 k413 k97 k729 k415 k99 k101 k731 k417 k103 k733 k419 k105 k735 k421 k107 k737 k423 k109 k739 k425 k111 k741 k427 k113 k743 k429 k115 k745 k431 k117 k747 k433 k119 k749 k435 k121 k751 k437 k123 k753 k439 k125 k755 k441 k127 k757 k443 k129 k759 k445 k131 k761 k447 k133 k763 k449 k135 k765 k451 k137 k453 k139 k455 k141 k457 k143 k459 k145 k461 k147 k463 k149 k465 k151 k467 k153 k469 k155 k471 k157 k473 k159 k475 k161 k477 k163 k479 k165 k481 k167 k483 k169 k485 k171 k487 k173 k489 k175 k501 k491 k177 k503 k493 k179 k505 k495 k181 k507 k497 k183 k509 k499 k185 k511 k187 k513 k189 k515 k201 k191 k517 k203 k193 k519 k205 k195 k521 k207 k197 k523 k209 k199 k525 k211 k527 k213 k529 k215 k531 k217 k533 k219 k535 k221 k537 k223 k539 k225 k541 k227 k543 k229 k545 k231 k547 k233 k549 k235 k551 k237 k553 k239 k555 k241 k557 k243 k559 k245 k561 k247 k563 k249 k565 k251 k567 k253 k569 k255 k571 k257 k573 k259 k575 k261 k577 k263 k579 k265 k581 k267 k583 k269 k585 k271 k587 k273 k589 k275 k601 k591 k277 k603 k593 k279 k605 k595 k281 k607 k597 k283 k609 k599 k285 k611 k287 k613 k289 k615 k301 k291 k617 k303 k293 k619 k305 k295 k621 k307 k297 k623 k309 k299 k625 k311 k627 k313 k629 k315 k631 k11 k317 k633 k13 k319 k635 k321 k15 k637 k323 k17 k639 k325 k19 k641 k21 k327 k643 k23 k329 k645 k331 k25 k647 k333 k27 k649 k335 k29 k651 k31 k337 k653 k33 k339 k655 k341 k35 k657 k343 k37 k659 k345 k39 k661 k41 k347 k663 k43 k349 k665 k351 k45 k667 k353 k47 k669 k355 k49 k671 k51 k357 k673 k53 k359 k675 k361 k55 k677 k363 k57 k679 k365 k59 k681 k61 k367 k683 k1 k63 k369 k685 k371 k3 k65 k687 k373 k5 k67 k689 k375 k7 k69 k701 k691 k71 k377 k9 k703 k693 k73 k379 k705 k695 k381 k75} {383 entries in table, 256 buckets\nnumber of buckets with 0 entries: 50\nnumber of buckets with 1 entries: 84\nnumber of buckets with 2 entries: 77\nnumber of buckets with 3 entries: 35\nnumber of buckets with 4 entries: 10\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.6}",
    "", false, "hash-delete-130",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<767} {incr i} {set a(k$i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{k706 k696 k382 k76 k707 k697 k383 k77 k708 k698 k384 k78 k710 k709 k699 k385 k79 k80 k711 k386 k81 k712 k387 k82 k713 k388 k83 k714 k400 k390 k389 k84 k715 k401 k391 k85 k716 k402 k392 k86 k717 k403 k393 k87 k718 k404 k394 k88 k720 k719 k405 k395 k89 k90 k721 k406 k396 k91 k722 k407 k397 k92 k723 k408 k398 k93 k724 k410 k409 k399 k94 k725 k411 k95 k726 k412 k96 k727 k413 k97 k728 k414 k98 k100 k730 k729 k415 k99 k101 k731 k416 k102 k732 k417 k103 k733 k418 k104 k734 k420 k419 k105 k735 k421 k106 k736 k422 k107 k737 k423 k108 k738 k424 k109 k110 k740 k739 k425 k111 k741 k426 k112 k742 k427 k113 k743 k428 k114 k744 k430 k429 k115 k745 k431 k116 k746 k432 k117 k747 k433 k118 k748 k434 k119 k120 k750 k749 k435 k121 k751 k436 k122 k752 k437 k123 k753 k438 k124 k754 k440 k439 k125 k755 k441 k126 k756 k442 k127 k757 k443 k128 k758 k444 k129 k130 k760 k759 k445 k131 k761 k446 k132 k762 k447 k133 k763 k448 k134 k764 k450 k449 k135 k765 k451 k136 k766 k452 k137 k453 k138 k454 k139 k140 k455 k141 k456 k142 k457 k143 k458 k144 k460 k459 k145 k461 k146 k462 k147 k463 k148 k464 k149 k150 k465 k151 k466 k152 k467 k153 k468 k154 k470 k469 k155 k471 k156 k472 k157 k473 k158 k474 k159 k160 k475 k161 k476 k162 k477 k163 k478 k164 k480 k479 k165 k481 k166 k482 k167 k483 k168 k484 k169 k170 k485 k171 k486 k172 k487 k173 k488 k174 k500 k490 k489 k175 k501 k491 k176 k502 k492 k177 k503 k493 k178 k504 k494 k179 k180 k505 k495 k181 k506 k496 k182 k507 k497 k183 k508 k498 k184 k510 k509 k499 k185 k511 k186 k512 k187 k513 k188 k514 k200 k189 k190 k515 k201 k191 k516 k202 k192 k517 k203 k193 k518 k204 k194 k520 k519 k205 k195 k521 k206 k196 k522 k207 k197 k523 k208 k198 k524 k210 k209 k199 k525 k211 k526 k212 k527 k213 k528 k214 k530 k529 k215 k531 k216 k532 k217 k533 k218 k534 k220 k219 k535 k221 k536 k222 k537 k223 k538 k224 k540 k539 k225 k541 k226 k542 k227 k543 k228 k544 k230 k229 k545 k231 k546 k232 k547 k233 k548 k234 k550 k549 k235 k551 k236 k552 k237 k553 k238 k554 k240 k239 k555 k241 k556 k242 k557 k243 k558 k244 k560 k559 k245 k561 k246 k562 k247 k563 k248 k564 k250 k249 k565 k251 k566 k252 k567 k253 k568 k254 k570 k569 k255 k571 k256 k572 k257 k573 k258 k574 k260 k259 k575 k261 k576 k262 k577 k263 k578 k264 k580 k579 k265 k581 k266 k582 k267 k583 k268 k584 k270 k269 k585 k271 k586 k272 k587 k273 k588 k274 k600 k590 k589 k275 k601 k591 k276 k602 k592 k277 k603 k593 k278 k604 k594 k280 k279 k605 k595 k281 k606 k596 k282 k607 k597 k283 k608 k598 k284 k610 k609 k599 k285 k611 k286 k612 k287 k613 k288 k614 k300 k290 k289 k615 k301 k291 k616 k302 k292 k617 k303 k293 k618 k304 k294 k620 k619 k305 k295 k621 k306 k296 k622 k307 k297 k623 k308 k298 k624 k310 k309 k299 k625 k311 k626 k312 k627 k313 k628 k314 k630 k629 k315 k10 k631 k316 k11 k632 k317 k12 k633 k318 k13 k634 k320 k319 k14 k635 k321 k15 k636 k322 k16 k637 k323 k17 k638 k324 k18 k640 k639 k325 k20 k19 k641 k326 k21 k642 k327 k22 k643 k328 k23 k644 k330 k329 k24 k645 k331 k25 k646 k332 k26 k647 k333 k27 k648 k334 k28 k650 k649 k335 k30 k29 k651 k336 k31 k652 k337 k32 k653 k338 k33 k654 k340 k339 k34 k655 k341 k35 k656 k342 k36 k657 k343 k37 k658 k344 k38 k660 k659 k345 k40 k39 k661 k346 k41 k662 k347 k42 k663 k348 k43 k664 k350 k349 k44 k665 k351 k45 k666 k352 k46 k667 k353 k47 k668 k354 k48 k670 k669 k355 k49 k50 k671 k356 k51 k672 k357 k52 k673 k358 k53 k674 k360 k359 k54 k675 k361 k55 k676 k362 k56 k677 k363 k57 k678 k364 k58 k680 k679 k365 k59 k60 k681 k366 k61 k682 k367 k0 k62 k683 k368 k1 k63 k684 k370 k369 k2 k64 k685 k371 k3 k65 k686 k372 k4 k66 k687 k373 k5 k67 k688 k374 k6 k68 k700 k690 k689 k375 k7 k69 k70 k701 k691 k376 k8 k71 k702 k692 k377 k9 k72 k703 k693 k378 k73 k704 k694 k380 k379 k74 k705 k695 k381 k75} 0 {} {}",
    "", false, "cursor-order-131",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<767} {incr i} {set a(same$i) $i};list [array names a] [array get a] [array statistics a]",
    "{same460 same459 same145 same461 same146 same462 same147 same463 same148 same464 same149 same150 same465 same151 same466 same152 same467 same153 same468 same154 same470 same469 same155 same471 same156 same472 same157 same473 same158 same474 same159 same160 same475 same161 same476 same162 same477 same163 same478 same164 same480 same479 same165 same481 same166 same482 same167 same483 same168 same484 same169 same170 same485 same171 same486 same172 same487 same173 same488 same174 same500 same490 same489 same175 same501 same491 same176 same502 same492 same177 same503 same493 same178 same504 same494 same179 same180 same505 same495 same181 same506 same496 same182 same507 same497 same183 same508 same498 same184 same510 same509 same499 same185 same511 same186 same512 same187 same513 same188 same514 same200 same189 same190 same515 same201 same191 same516 same202 same192 same517 same203 same193 same518 same204 same194 same520 same519 same205 same195 same521 same206 same196 same522 same207 same197 same10 same523 same208 same198 same11 same524 same210 same209 same199 same12 same525 same211 same13 same526 same212 same14 same527 same213 same15 same528 same214 same16 same530 same529 same215 same17 same531 same216 same18 same532 same217 same20 same19 same533 same218 same21 same534 same220 same219 same22 same535 same221 same23 same536 same222 same24 same537 same223 same25 same538 same224 same26 same540 same539 same225 same27 same541 same226 same28 same542 same227 same30 same29 same543 same228 same31 same544 same230 same229 same32 same545 same231 same33 same546 same232 same34 same547 same233 same35 same548 same234 same36 same550 same549 same235 same37 same551 same236 same38 same552 same237 same40 same39 same553 same238 same41 same554 same240 same239 same42 same555 same241 same43 same556 same242 same44 same557 same243 same45 same558 same244 same46 same560 same559 same245 same47 same561 same246 same48 same562 same247 same49 same50 same563 same248 same51 same564 same250 same249 same52 same565 same251 same53 same566 same252 same54 same567 same253 same55 same568 same254 same56 same570 same569 same255 same57 same571 same256 same58 same572 same257 same59 same60 same573 same258 same61 same574 same260 same259 same62 same575 same261 same63 same576 same262 same64 same577 same263 same65 same578 same264 same66 same580 same579 same265 same67 same581 same266 same68 same582 same267 same69 same70 same583 same268 same71 same584 same270 same269 same72 same585 same271 same73 same586 same272 same74 same587 same273 same75 same588 same274 same76 same600 same590 same589 same275 same77 same601 same591 same276 same78 same602 same592 same277 same79 same80 same603 same593 same278 same81 same604 same594 same280 same279 same82 same605 same595 same281 same83 same606 same596 same282 same84 same607 same597 same283 same85 same608 same598 same284 same86 same610 same609 same599 same285 same87 same611 same286 same88 same612 same287 same89 same90 same613 same288 same91 same614 same300 same290 same289 same92 same615 same301 same291 same93 same616 same302 same292 same94 same617 same303 same293 same95 same618 same304 same294 same96 same620 same619 same305 same295 same97 same621 same306 same296 same98 same622 same307 same297 same99 same623 same308 same298 same624 same310 same309 same299 same625 same311 same626 same312 same627 same313 same628 same314 same630 same629 same315 same631 same316 same632 same317 same633 same318 same634 same320 same319 same635 same321 same636 same322 same637 same323 same638 same324 same640 same639 same325 same641 same326 same642 same327 same643 same328 same644 same330 same329 same645 same331 same646 same332 same647 same333 same648 same334 same650 same649 same335 same651 same336 same652 same337 same653 same338 same654 same340 same339 same655 same341 same656 same342 same657 same343 same658 same344 same660 same659 same345 same661 same346 same662 same347 same663 same348 same664 same350 same349 same665 same351 same666 same352 same667 same353 same668 same354 same670 same669 same355 same671 same356 same672 same357 same673 same358 same674 same360 same359 same675 same361 same676 same362 same677 same363 same678 same364 same680 same679 same365 same681 same366 same682 same367 same683 same368 same684 same370 same369 same685 same371 same686 same372 same687 same373 same688 same374 same700 same690 same689 same375 same701 same691 same376 same702 same692 same377 same703 same693 same378 same704 same694 same380 same379 same705 same695 same381 same706 same696 same382 same707 same697 same383 same708 same698 same384 same710 same709 same699 same385 same0 same711 same386 same1 same712 same387 same2 same713 same388 same3 same714 same400 same390 same389 same4 same715 same401 same391 same5 same716 same402 same392 same6 same717 same403 same393 same7 same718 same404 same394 same8 same720 same719 same405 same395 same9 same721 same406 same396 same722 same407 same397 same723 same408 same398 same724 same410 same409 same399 same725 same411 same726 same412 same727 same413 same728 same414 same100 same730 same729 same415 same101 same731 same416 same102 same732 same417 same103 same733 same418 same104 same734 same420 same419 same105 same735 same421 same106 same736 same422 same107 same737 same423 same108 same738 same424 same109 same110 same740 same739 same425 same111 same741 same426 same112 same742 same427 same113 same743 same428 same114 same744 same430 same429 same115 same745 same431 same116 same746 same432 same117 same747 same433 same118 same748 same434 same119 same120 same750 same749 same435 same121 same751 same436 same122 same752 same437 same123 same753 same438 same124 same754 same440 same439 same125 same755 same441 same126 same756 same442 same127 same757 same443 same128 same758 same444 same129 same130 same760 same759 same445 same131 same761 same446 same132 same762 same447 same133 same763 same448 same134 same764 same450 same449 same135 same765 same451 same136 same766 same452 same137 same453 same138 same454 same139 same140 same455 same141 same456 same142 same457 same143 same458 same144} {same460 460 same459 459 same145 145 same461 461 same146 146 same462 462 same147 147 same463 463 same148 148 same464 464 same149 149 same150 150 same465 465 same151 151 same466 466 same152 152 same467 467 same153 153 same468 468 same154 154 same470 470 same469 469 same155 155 same471 471 same156 156 same472 472 same157 157 same473 473 same158 158 same474 474 same159 159 same160 160 same475 475 same161 161 same476 476 same162 162 same477 477 same163 163 same478 478 same164 164 same480 480 same479 479 same165 165 same481 481 same166 166 same482 482 same167 167 same483 483 same168 168 same484 484 same169 169 same170 170 same485 485 same171 171 same486 486 same172 172 same487 487 same173 173 same488 488 same174 174 same500 500 same490 490 same489 489 same175 175 same501 501 same491 491 same176 176 same502 502 same492 492 same177 177 same503 503 same493 493 same178 178 same504 504 same494 494 same179 179 same180 180 same505 505 same495 495 same181 181 same506 506 same496 496 same182 182 same507 507 same497 497 same183 183 same508 508 same498 498 same184 184 same510 510 same509 509 same499 499 same185 185 same511 511 same186 186 same512 512 same187 187 same513 513 same188 188 same514 514 same200 200 same189 189 same190 190 same515 515 same201 201 same191 191 same516 516 same202 202 same192 192 same517 517 same203 203 same193 193 same518 518 same204 204 same194 194 same520 520 same519 519 same205 205 same195 195 same521 521 same206 206 same196 196 same522 522 same207 207 same197 197 same10 10 same523 523 same208 208 same198 198 same11 11 same524 524 same210 210 same209 209 same199 199 same12 12 same525 525 same211 211 same13 13 same526 526 same212 212 same14 14 same527 527 same213 213 same15 15 same528 528 same214 214 same16 16 same530 530 same529 529 same215 215 same17 17 same531 531 same216 216 same18 18 same532 532 same217 217 same20 20 same19 19 same533 533 same218 218 same21 21 same534 534 same220 220 same219 219 same22 22 same535 535 same221 221 same23 23 same536 536 same222 222 same24 24 same537 537 same223 223 same25 25 same538 538 same224 224 same26 26 same540 540 same539 539 same225 225 same27 27 same541 541 same226 226 same28 28 same542 542 same227 227 same30 30 same29 29 same543 543 same228 228 same31 31 same544 544 same230 230 same229 229 same32 32 same545 545 same231 231 same33 33 same546 546 same232 232 same34 34 same547 547 same233 233 same35 35 same548 548 same234 234 same36 36 same550 550 same549 549 same235 235 same37 37 same551 551 same236 236 same38 38 same552 552 same237 237 same40 40 same39 39 same553 553 same238 238 same41 41 same554 554 same240 240 same239 239 same42 42 same555 555 same241 241 same43 43 same556 556 same242 242 same44 44 same557 557 same243 243 same45 45 same558 558 same244 244 same46 46 same560 560 same559 559 same245 245 same47 47 same561 561 same246 246 same48 48 same562 562 same247 247 same49 49 same50 50 same563 563 same248 248 same51 51 same564 564 same250 250 same249 249 same52 52 same565 565 same251 251 same53 53 same566 566 same252 252 same54 54 same567 567 same253 253 same55 55 same568 568 same254 254 same56 56 same570 570 same569 569 same255 255 same57 57 same571 571 same256 256 same58 58 same572 572 same257 257 same59 59 same60 60 same573 573 same258 258 same61 61 same574 574 same260 260 same259 259 same62 62 same575 575 same261 261 same63 63 same576 576 same262 262 same64 64 same577 577 same263 263 same65 65 same578 578 same264 264 same66 66 same580 580 same579 579 same265 265 same67 67 same581 581 same266 266 same68 68 same582 582 same267 267 same69 69 same70 70 same583 583 same268 268 same71 71 same584 584 same270 270 same269 269 same72 72 same585 585 same271 271 same73 73 same586 586 same272 272 same74 74 same587 587 same273 273 same75 75 same588 588 same274 274 same76 76 same600 600 same590 590 same589 589 same275 275 same77 77 same601 601 same591 591 same276 276 same78 78 same602 602 same592 592 same277 277 same79 79 same80 80 same603 603 same593 593 same278 278 same81 81 same604 604 same594 594 same280 280 same279 279 same82 82 same605 605 same595 595 same281 281 same83 83 same606 606 same596 596 same282 282 same84 84 same607 607 same597 597 same283 283 same85 85 same608 608 same598 598 same284 284 same86 86 same610 610 same609 609 same599 599 same285 285 same87 87 same611 611 same286 286 same88 88 same612 612 same287 287 same89 89 same90 90 same613 613 same288 288 same91 91 same614 614 same300 300 same290 290 same289 289 same92 92 same615 615 same301 301 same291 291 same93 93 same616 616 same302 302 same292 292 same94 94 same617 617 same303 303 same293 293 same95 95 same618 618 same304 304 same294 294 same96 96 same620 620 same619 619 same305 305 same295 295 same97 97 same621 621 same306 306 same296 296 same98 98 same622 622 same307 307 same297 297 same99 99 same623 623 same308 308 same298 298 same624 624 same310 310 same309 309 same299 299 same625 625 same311 311 same626 626 same312 312 same627 627 same313 313 same628 628 same314 314 same630 630 same629 629 same315 315 same631 631 same316 316 same632 632 same317 317 same633 633 same318 318 same634 634 same320 320 same319 319 same635 635 same321 321 same636 636 same322 322 same637 637 same323 323 same638 638 same324 324 same640 640 same639 639 same325 325 same641 641 same326 326 same642 642 same327 327 same643 643 same328 328 same644 644 same330 330 same329 329 same645 645 same331 331 same646 646 same332 332 same647 647 same333 333 same648 648 same334 334 same650 650 same649 649 same335 335 same651 651 same336 336 same652 652 same337 337 same653 653 same338 338 same654 654 same340 340 same339 339 same655 655 same341 341 same656 656 same342 342 same657 657 same343 343 same658 658 same344 344 same660 660 same659 659 same345 345 same661 661 same346 346 same662 662 same347 347 same663 663 same348 348 same664 664 same350 350 same349 349 same665 665 same351 351 same666 666 same352 352 same667 667 same353 353 same668 668 same354 354 same670 670 same669 669 same355 355 same671 671 same356 356 same672 672 same357 357 same673 673 same358 358 same674 674 same360 360 same359 359 same675 675 same361 361 same676 676 same362 362 same677 677 same363 363 same678 678 same364 364 same680 680 same679 679 same365 365 same681 681 same366 366 same682 682 same367 367 same683 683 same368 368 same684 684 same370 370 same369 369 same685 685 same371 371 same686 686 same372 372 same687 687 same373 373 same688 688 same374 374 same700 700 same690 690 same689 689 same375 375 same701 701 same691 691 same376 376 same702 702 same692 692 same377 377 same703 703 same693 693 same378 378 same704 704 same694 694 same380 380 same379 379 same705 705 same695 695 same381 381 same706 706 same696 696 same382 382 same707 707 same697 697 same383 383 same708 708 same698 698 same384 384 same710 710 same709 709 same699 699 same385 385 same0 0 same711 711 same386 386 same1 1 same712 712 same387 387 same2 2 same713 713 same388 388 same3 3 same714 714 same400 400 same390 390 same389 389 same4 4 same715 715 same401 401 same391 391 same5 5 same716 716 same402 402 same392 392 same6 6 same717 717 same403 403 same393 393 same7 7 same718 718 same404 404 same394 394 same8 8 same720 720 same719 719 same405 405 same395 395 same9 9 same721 721 same406 406 same396 396 same722 722 same407 407 same397 397 same723 723 same408 408 same398 398 same724 724 same410 410 same409 409 same399 399 same725 725 same411 411 same726 726 same412 412 same727 727 same413 413 same728 728 same414 414 same100 100 same730 730 same729 729 same415 415 same101 101 same731 731 same416 416 same102 102 same732 732 same417 417 same103 103 same733 733 same418 418 same104 104 same734 734 same420 420 same419 419 same105 105 same735 735 same421 421 same106 106 same736 736 same422 422 same107 107 same737 737 same423 423 same108 108 same738 738 same424 424 same109 109 same110 110 same740 740 same739 739 same425 425 same111 111 same741 741 same426 426 same112 112 same742 742 same427 427 same113 113 same743 743 same428 428 same114 114 same744 744 same430 430 same429 429 same115 115 same745 745 same431 431 same116 116 same746 746 same432 432 same117 117 same747 747 same433 433 same118 118 same748 748 same434 434 same119 119 same120 120 same750 750 same749 749 same435 435 same121 121 same751 751 same436 436 same122 122 same752 752 same437 437 same123 123 same753 753 same438 438 same124 124 same754 754 same440 440 same439 439 same125 125 same755 755 same441 441 same126 126 same756 756 same442 442 same127 127 same757 757 same443 443 same128 128 same758 758 same444 444 same129 129 same130 130 same760 760 same759 759 same445 445 same131 131 same761 761 same446 446 same132 132 same762 762 same447 447 same133 133 same763 763 same448 448 same134 134 same764 764 same450 450 same449 449 same135 135 same765 765 same451 451 same136 136 same766 766 same452 452 same137 137 same453 453 same138 138 same454 454 same139 139 same140 140 same455 455 same141 141 same456 456 same142 142 same457 457 same143 143 same458 458 same144 144} {767 entries in table, 256 buckets\nnumber of buckets with 0 entries: 0\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 78\nnumber of buckets with 3 entries: 111\nnumber of buckets with 4 entries: 57\nnumber of buckets with 5 entries: 10\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 2.1}",
    "", false, "hash-order-132",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<767} {incr i} {set a(same$i) $i};for {set i 0} {$i<767} {incr i 2} {unset a(same$i)};list [array names a] [array statistics a]",
    "{same459 same145 same461 same147 same463 same149 same465 same151 same467 same153 same469 same155 same471 same157 same473 same159 same475 same161 same477 same163 same479 same165 same481 same167 same483 same169 same485 same171 same487 same173 same489 same175 same501 same491 same177 same503 same493 same179 same505 same495 same181 same507 same497 same183 same509 same499 same185 same511 same187 same513 same189 same515 same201 same191 same517 same203 same193 same519 same205 same195 same521 same207 same197 same523 same11 same209 same199 same525 same211 same13 same527 same213 same15 same529 same215 same17 same531 same217 same19 same533 same21 same219 same535 same221 same23 same537 same223 same25 same539 same225 same27 same541 same227 same29 same543 same31 same229 same545 same231 same33 same547 same233 same35 same549 same235 same37 same551 same237 same39 same553 same41 same239 same555 same241 same43 same557 same243 same45 same559 same245 same47 same561 same247 same49 same563 same51 same249 same565 same251 same53 same567 same253 same55 same569 same255 same57 same571 same257 same59 same573 same61 same259 same575 same261 same63 same577 same263 same65 same579 same265 same67 same581 same267 same69 same583 same71 same269 same585 same271 same73 same587 same273 same75 same589 same275 same77 same601 same591 same277 same79 same603 same593 same81 same279 same605 same595 same281 same83 same607 same597 same283 same85 same609 same599 same285 same87 same611 same287 same89 same613 same91 same289 same615 same301 same291 same93 same617 same303 same293 same95 same619 same305 same295 same97 same621 same307 same297 same99 same623 same309 same299 same625 same311 same627 same313 same629 same315 same631 same317 same633 same319 same635 same321 same637 same323 same639 same325 same641 same327 same643 same329 same645 same331 same647 same333 same649 same335 same651 same337 same653 same339 same655 same341 same657 same343 same659 same345 same661 same347 same663 same349 same665 same351 same667 same353 same669 same355 same671 same357 same673 same359 same675 same361 same677 same363 same679 same365 same681 same367 same683 same369 same685 same371 same687 same373 same689 same375 same701 same691 same377 same703 same693 same379 same705 same695 same381 same707 same697 same383 same709 same699 same385 same711 same1 same387 same713 same3 same389 same715 same401 same391 same5 same717 same403 same393 same7 same719 same405 same395 same9 same721 same407 same397 same723 same409 same399 same725 same411 same727 same413 same729 same415 same101 same731 same417 same103 same733 same419 same105 same735 same421 same107 same737 same423 same109 same739 same425 same111 same741 same427 same113 same743 same429 same115 same745 same431 same117 same747 same433 same119 same749 same435 same121 same751 same437 same123 same753 same439 same125 same755 same441 same127 same757 same443 same129 same759 same445 same131 same761 same447 same133 same763 same449 same135 same765 same451 same137 same453 same139 same455 same141 same457 same143} {383 entries in table, 256 buckets\nnumber of buckets with 0 entries: 50\nnumber of buckets with 1 entries: 83\nnumber of buckets with 2 entries: 78\nnumber of buckets with 3 entries: 36\nnumber of buckets with 4 entries: 9\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.6}",
    "", false, "hash-delete-133",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<767} {incr i} {set a(same$i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{same460 same459 same145 same461 same146 same462 same147 same463 same148 same464 same149 same150 same465 same151 same466 same152 same467 same153 same468 same154 same470 same469 same155 same471 same156 same472 same157 same473 same158 same474 same159 same160 same475 same161 same476 same162 same477 same163 same478 same164 same480 same479 same165 same481 same166 same482 same167 same483 same168 same484 same169 same170 same485 same171 same486 same172 same487 same173 same488 same174 same500 same490 same489 same175 same501 same491 same176 same502 same492 same177 same503 same493 same178 same504 same494 same179 same180 same505 same495 same181 same506 same496 same182 same507 same497 same183 same508 same498 same184 same510 same509 same499 same185 same511 same186 same512 same187 same513 same188 same514 same200 same189 same190 same515 same201 same191 same516 same202 same192 same517 same203 same193 same518 same204 same194 same520 same519 same205 same195 same521 same206 same196 same522 same207 same197 same10 same523 same208 same198 same11 same524 same210 same209 same199 same12 same525 same211 same13 same526 same212 same14 same527 same213 same15 same528 same214 same16 same530 same529 same215 same17 same531 same216 same18 same532 same217 same20 same19 same533 same218 same21 same534 same220 same219 same22 same535 same221 same23 same536 same222 same24 same537 same223 same25 same538 same224 same26 same540 same539 same225 same27 same541 same226 same28 same542 same227 same30 same29 same543 same228 same31 same544 same230 same229 same32 same545 same231 same33 same546 same232 same34 same547 same233 same35 same548 same234 same36 same550 same549 same235 same37 same551 same236 same38 same552 same237 same40 same39 same553 same238 same41 same554 same240 same239 same42 same555 same241 same43 same556 same242 same44 same557 same243 same45 same558 same244 same46 same560 same559 same245 same47 same561 same246 same48 same562 same247 same49 same50 same563 same248 same51 same564 same250 same249 same52 same565 same251 same53 same566 same252 same54 same567 same253 same55 same568 same254 same56 same570 same569 same255 same57 same571 same256 same58 same572 same257 same59 same60 same573 same258 same61 same574 same260 same259 same62 same575 same261 same63 same576 same262 same64 same577 same263 same65 same578 same264 same66 same580 same579 same265 same67 same581 same266 same68 same582 same267 same69 same70 same583 same268 same71 same584 same270 same269 same72 same585 same271 same73 same586 same272 same74 same587 same273 same75 same588 same274 same76 same600 same590 same589 same275 same77 same601 same591 same276 same78 same602 same592 same277 same79 same80 same603 same593 same278 same81 same604 same594 same280 same279 same82 same605 same595 same281 same83 same606 same596 same282 same84 same607 same597 same283 same85 same608 same598 same284 same86 same610 same609 same599 same285 same87 same611 same286 same88 same612 same287 same89 same90 same613 same288 same91 same614 same300 same290 same289 same92 same615 same301 same291 same93 same616 same302 same292 same94 same617 same303 same293 same95 same618 same304 same294 same96 same620 same619 same305 same295 same97 same621 same306 same296 same98 same622 same307 same297 same99 same623 same308 same298 same624 same310 same309 same299 same625 same311 same626 same312 same627 same313 same628 same314 same630 same629 same315 same631 same316 same632 same317 same633 same318 same634 same320 same319 same635 same321 same636 same322 same637 same323 same638 same324 same640 same639 same325 same641 same326 same642 same327 same643 same328 same644 same330 same329 same645 same331 same646 same332 same647 same333 same648 same334 same650 same649 same335 same651 same336 same652 same337 same653 same338 same654 same340 same339 same655 same341 same656 same342 same657 same343 same658 same344 same660 same659 same345 same661 same346 same662 same347 same663 same348 same664 same350 same349 same665 same351 same666 same352 same667 same353 same668 same354 same670 same669 same355 same671 same356 same672 same357 same673 same358 same674 same360 same359 same675 same361 same676 same362 same677 same363 same678 same364 same680 same679 same365 same681 same366 same682 same367 same683 same368 same684 same370 same369 same685 same371 same686 same372 same687 same373 same688 same374 same700 same690 same689 same375 same701 same691 same376 same702 same692 same377 same703 same693 same378 same704 same694 same380 same379 same705 same695 same381 same706 same696 same382 same707 same697 same383 same708 same698 same384 same710 same709 same699 same385 same0 same711 same386 same1 same712 same387 same2 same713 same388 same3 same714 same400 same390 same389 same4 same715 same401 same391 same5 same716 same402 same392 same6 same717 same403 same393 same7 same718 same404 same394 same8 same720 same719 same405 same395 same9 same721 same406 same396 same722 same407 same397 same723 same408 same398 same724 same410 same409 same399 same725 same411 same726 same412 same727 same413 same728 same414 same100 same730 same729 same415 same101 same731 same416 same102 same732 same417 same103 same733 same418 same104 same734 same420 same419 same105 same735 same421 same106 same736 same422 same107 same737 same423 same108 same738 same424 same109 same110 same740 same739 same425 same111 same741 same426 same112 same742 same427 same113 same743 same428 same114 same744 same430 same429 same115 same745 same431 same116 same746 same432 same117 same747 same433 same118 same748 same434 same119 same120 same750 same749 same435 same121 same751 same436 same122 same752 same437 same123 same753 same438 same124 same754 same440 same439 same125 same755 same441 same126 same756 same442 same127 same757 same443 same128 same758 same444 same129 same130 same760 same759 same445 same131 same761 same446 same132 same762 same447 same133 same763 same448 same134 same764 same450 same449 same135 same765 same451 same136 same766 same452 same137 same453 same138 same454 same139 same140 same455 same141 same456 same142 same457 same143 same458 same144} 0 {} {}",
    "", false, "cursor-order-134",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<768} {incr i} {set a($i) $i};list [array names a] [array get a] [array statistics a]",
    "{0 1 2 3 4 5 6 7 8 9 100 101 102 103 104 105 106 107 108 110 109 111 112 113 114 115 116 117 118 120 119 121 122 123 124 125 126 127 128 130 129 131 132 133 134 135 136 137 138 140 139 141 142 143 144 145 146 147 148 150 149 151 152 153 154 155 156 157 158 160 159 161 162 163 164 165 166 167 168 170 169 171 172 173 174 175 176 177 178 180 179 181 182 183 184 185 186 187 188 190 189 200 191 201 192 202 193 203 194 204 195 205 196 206 197 207 198 208 199 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255 256 257 258 259 260 10 261 11 262 12 263 13 264 14 265 15 266 16 267 17 268 18 269 270 19 20 271 21 272 22 273 23 274 24 275 25 276 26 277 27 278 28 279 280 29 30 281 31 282 32 283 33 284 34 285 35 286 36 287 37 288 38 289 290 300 39 40 291 301 41 292 302 42 293 303 43 294 304 44 295 305 45 296 306 46 297 307 47 298 308 48 299 309 310 50 49 311 51 312 52 313 53 314 54 315 55 316 56 317 57 318 58 319 320 60 59 321 61 322 62 323 63 324 64 325 65 326 66 327 67 328 68 329 330 70 69 331 71 332 72 333 73 334 74 335 75 336 76 337 77 338 78 339 340 80 79 341 81 342 82 343 83 344 84 345 85 346 86 347 87 348 88 349 350 90 89 351 91 352 92 353 93 354 94 355 95 356 96 357 97 358 98 359 360 99 361 362 363 364 365 366 367 368 369 370 371 372 373 374 375 376 377 378 379 380 381 382 383 384 385 386 387 388 389 390 400 391 401 392 402 393 403 394 404 395 405 396 406 397 407 398 408 399 409 410 411 412 413 414 415 416 417 418 419 420 421 422 423 424 425 426 427 428 429 430 431 432 433 434 435 436 437 438 439 440 441 442 443 444 445 446 447 448 449 450 451 452 453 454 455 456 457 458 459 460 461 462 463 464 465 466 467 468 469 470 471 472 473 474 475 476 477 478 479 480 481 482 483 484 485 486 487 488 489 490 500 491 501 492 502 493 503 494 504 495 505 496 506 497 507 498 508 499 509 510 511 512 513 514 515 516 517 518 519 520 521 522 523 524 525 526 527 528 529 530 531 532 533 534 535 536 537 538 539 540 541 542 543 544 545 546 547 548 549 550 551 552 553 554 555 556 557 558 559 560 561 562 563 564 565 566 567 568 569 570 571 572 573 574 575 576 577 578 579 580 581 582 583 584 585 586 587 588 589 590 600 591 601 592 602 593 603 594 604 595 605 596 606 597 607 598 608 599 609 610 611 612 613 614 615 616 617 618 619 620 621 622 623 624 625 626 627 628 629 630 631 632 633 634 635 636 637 638 639 640 641 642 643 644 645 646 647 648 649 650 651 652 653 654 655 656 657 658 659 660 661 662 663 664 665 666 667 668 669 670 671 672 673 674 675 676 677 678 679 680 681 682 683 684 685 686 687 688 689 690 700 691 701 692 702 693 703 694 704 695 705 696 706 697 707 698 708 699 709 710 711 712 713 714 715 716 717 718 719 720 721 722 723 724 725 726 727 728 729 730 731 732 733 734 735 736 737 738 739 740 741 742 743 744 745 746 747 748 749 750 751 752 753 754 755 756 757 758 759 760 761 762 763 764 765 766 767} {0 0 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 100 100 101 101 102 102 103 103 104 104 105 105 106 106 107 107 108 108 110 110 109 109 111 111 112 112 113 113 114 114 115 115 116 116 117 117 118 118 120 120 119 119 121 121 122 122 123 123 124 124 125 125 126 126 127 127 128 128 130 130 129 129 131 131 132 132 133 133 134 134 135 135 136 136 137 137 138 138 140 140 139 139 141 141 142 142 143 143 144 144 145 145 146 146 147 147 148 148 150 150 149 149 151 151 152 152 153 153 154 154 155 155 156 156 157 157 158 158 160 160 159 159 161 161 162 162 163 163 164 164 165 165 166 166 167 167 168 168 170 170 169 169 171 171 172 172 173 173 174 174 175 175 176 176 177 177 178 178 180 180 179 179 181 181 182 182 183 183 184 184 185 185 186 186 187 187 188 188 190 190 189 189 200 200 191 191 201 201 192 192 202 202 193 193 203 203 194 194 204 204 195 195 205 205 196 196 206 206 197 197 207 207 198 198 208 208 199 199 209 209 210 210 211 211 212 212 213 213 214 214 215 215 216 216 217 217 218 218 219 219 220 220 221 221 222 222 223 223 224 224 225 225 226 226 227 227 228 228 229 229 230 230 231 231 232 232 233 233 234 234 235 235 236 236 237 237 238 238 239 239 240 240 241 241 242 242 243 243 244 244 245 245 246 246 247 247 248 248 249 249 250 250 251 251 252 252 253 253 254 254 255 255 256 256 257 257 258 258 259 259 260 260 10 10 261 261 11 11 262 262 12 12 263 263 13 13 264 264 14 14 265 265 15 15 266 266 16 16 267 267 17 17 268 268 18 18 269 269 270 270 19 19 20 20 271 271 21 21 272 272 22 22 273 273 23 23 274 274 24 24 275 275 25 25 276 276 26 26 277 277 27 27 278 278 28 28 279 279 280 280 29 29 30 30 281 281 31 31 282 282 32 32 283 283 33 33 284 284 34 34 285 285 35 35 286 286 36 36 287 287 37 37 288 288 38 38 289 289 290 290 300 300 39 39 40 40 291 291 301 301 41 41 292 292 302 302 42 42 293 293 303 303 43 43 294 294 304 304 44 44 295 295 305 305 45 45 296 296 306 306 46 46 297 297 307 307 47 47 298 298 308 308 48 48 299 299 309 309 310 310 50 50 49 49 311 311 51 51 312 312 52 52 313 313 53 53 314 314 54 54 315 315 55 55 316 316 56 56 317 317 57 57 318 318 58 58 319 319 320 320 60 60 59 59 321 321 61 61 322 322 62 62 323 323 63 63 324 324 64 64 325 325 65 65 326 326 66 66 327 327 67 67 328 328 68 68 329 329 330 330 70 70 69 69 331 331 71 71 332 332 72 72 333 333 73 73 334 334 74 74 335 335 75 75 336 336 76 76 337 337 77 77 338 338 78 78 339 339 340 340 80 80 79 79 341 341 81 81 342 342 82 82 343 343 83 83 344 344 84 84 345 345 85 85 346 346 86 86 347 347 87 87 348 348 88 88 349 349 350 350 90 90 89 89 351 351 91 91 352 352 92 92 353 353 93 93 354 354 94 94 355 355 95 95 356 356 96 96 357 357 97 97 358 358 98 98 359 359 360 360 99 99 361 361 362 362 363 363 364 364 365 365 366 366 367 367 368 368 369 369 370 370 371 371 372 372 373 373 374 374 375 375 376 376 377 377 378 378 379 379 380 380 381 381 382 382 383 383 384 384 385 385 386 386 387 387 388 388 389 389 390 390 400 400 391 391 401 401 392 392 402 402 393 393 403 403 394 394 404 404 395 395 405 405 396 396 406 406 397 397 407 407 398 398 408 408 399 399 409 409 410 410 411 411 412 412 413 413 414 414 415 415 416 416 417 417 418 418 419 419 420 420 421 421 422 422 423 423 424 424 425 425 426 426 427 427 428 428 429 429 430 430 431 431 432 432 433 433 434 434 435 435 436 436 437 437 438 438 439 439 440 440 441 441 442 442 443 443 444 444 445 445 446 446 447 447 448 448 449 449 450 450 451 451 452 452 453 453 454 454 455 455 456 456 457 457 458 458 459 459 460 460 461 461 462 462 463 463 464 464 465 465 466 466 467 467 468 468 469 469 470 470 471 471 472 472 473 473 474 474 475 475 476 476 477 477 478 478 479 479 480 480 481 481 482 482 483 483 484 484 485 485 486 486 487 487 488 488 489 489 490 490 500 500 491 491 501 501 492 492 502 502 493 493 503 503 494 494 504 504 495 495 505 505 496 496 506 506 497 497 507 507 498 498 508 508 499 499 509 509 510 510 511 511 512 512 513 513 514 514 515 515 516 516 517 517 518 518 519 519 520 520 521 521 522 522 523 523 524 524 525 525 526 526 527 527 528 528 529 529 530 530 531 531 532 532 533 533 534 534 535 535 536 536 537 537 538 538 539 539 540 540 541 541 542 542 543 543 544 544 545 545 546 546 547 547 548 548 549 549 550 550 551 551 552 552 553 553 554 554 555 555 556 556 557 557 558 558 559 559 560 560 561 561 562 562 563 563 564 564 565 565 566 566 567 567 568 568 569 569 570 570 571 571 572 572 573 573 574 574 575 575 576 576 577 577 578 578 579 579 580 580 581 581 582 582 583 583 584 584 585 585 586 586 587 587 588 588 589 589 590 590 600 600 591 591 601 601 592 592 602 602 593 593 603 603 594 594 604 604 595 595 605 605 596 596 606 606 597 597 607 607 598 598 608 608 599 599 609 609 610 610 611 611 612 612 613 613 614 614 615 615 616 616 617 617 618 618 619 619 620 620 621 621 622 622 623 623 624 624 625 625 626 626 627 627 628 628 629 629 630 630 631 631 632 632 633 633 634 634 635 635 636 636 637 637 638 638 639 639 640 640 641 641 642 642 643 643 644 644 645 645 646 646 647 647 648 648 649 649 650 650 651 651 652 652 653 653 654 654 655 655 656 656 657 657 658 658 659 659 660 660 661 661 662 662 663 663 664 664 665 665 666 666 667 667 668 668 669 669 670 670 671 671 672 672 673 673 674 674 675 675 676 676 677 677 678 678 679 679 680 680 681 681 682 682 683 683 684 684 685 685 686 686 687 687 688 688 689 689 690 690 700 700 691 691 701 701 692 692 702 702 693 693 703 703 694 694 704 704 695 695 705 705 696 696 706 706 697 697 707 707 698 698 708 708 699 699 709 709 710 710 711 711 712 712 713 713 714 714 715 715 716 716 717 717 718 718 719 719 720 720 721 721 722 722 723 723 724 724 725 725 726 726 727 727 728 728 729 729 730 730 731 731 732 732 733 733 734 734 735 735 736 736 737 737 738 738 739 739 740 740 741 741 742 742 743 743 744 744 745 745 746 746 747 747 748 748 749 749 750 750 751 751 752 752 753 753 754 754 755 755 756 756 757 757 758 758 759 759 760 760 761 761 762 762 763 763 764 764 765 765 766 766 767 767} {768 entries in table, 1024 buckets\nnumber of buckets with 0 entries: 466\nnumber of buckets with 1 entries: 385\nnumber of buckets with 2 entries: 139\nnumber of buckets with 3 entries: 31\nnumber of buckets with 4 entries: 3\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.3}",
    "", false, "hash-order-135",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<768} {incr i} {set a($i) $i};for {set i 0} {$i<768} {incr i 2} {unset a($i)};list [array names a] [array statistics a]",
    "{1 3 5 7 9 101 103 105 107 109 111 113 115 117 119 121 123 125 127 129 131 133 135 137 139 141 143 145 147 149 151 153 155 157 159 161 163 165 167 169 171 173 175 177 179 181 183 185 187 189 191 201 193 203 195 205 197 207 199 209 211 213 215 217 219 221 223 225 227 229 231 233 235 237 239 241 243 245 247 249 251 253 255 257 259 261 11 263 13 265 15 267 17 269 19 271 21 273 23 275 25 277 27 279 29 281 31 283 33 285 35 287 37 289 39 291 301 41 293 303 43 295 305 45 297 307 47 299 309 49 311 51 313 53 315 55 317 57 319 59 321 61 323 63 325 65 327 67 329 69 331 71 333 73 335 75 337 77 339 79 341 81 343 83 345 85 347 87 349 89 351 91 353 93 355 95 357 97 359 99 361 363 365 367 369 371 373 375 377 379 381 383 385 387 389 391 401 393 403 395 405 397 407 399 409 411 413 415 417 419 421 423 425 427 429 431 433 435 437 439 441 443 445 447 449 451 453 455 457 459 461 463 465 467 469 471 473 475 477 479 481 483 485 487 489 491 501 493 503 495 505 497 507 499 509 511 513 515 517 519 521 523 525 527 529 531 533 535 537 539 541 543 545 547 549 551 553 555 557 559 561 563 565 567 569 571 573 575 577 579 581 583 585 587 589 591 601 593 603 595 605 597 607 599 609 611 613 615 617 619 621 623 625 627 629 631 633 635 637 639 641 643 645 647 649 651 653 655 657 659 661 663 665 667 669 671 673 675 677 679 681 683 685 687 689 691 701 693 703 695 705 697 707 699 709 711 713 715 717 719 721 723 725 727 729 731 733 735 737 739 741 743 745 747 749 751 753 755 757 759 761 763 765 767} {384 entries in table, 1024 buckets\nnumber of buckets with 0 entries: 679\nnumber of buckets with 1 entries: 307\nnumber of buckets with 2 entries: 37\nnumber of buckets with 3 entries: 1\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.1}",
    "", false, "hash-delete-136",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<768} {incr i} {set a($i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{0 1 2 3 4 5 6 7 8 9 100 101 102 103 104 105 106 107 108 110 109 111 112 113 114 115 116 117 118 120 119 121 122 123 124 125 126 127 128 130 129 131 132 133 134 135 136 137 138 140 139 141 142 143 144 145 146 147 148 150 149 151 152 153 154 155 156 157 158 160 159 161 162 163 164 165 166 167 168 170 169 171 172 173 174 175 176 177 178 180 179 181 182 183 184 185 186 187 188 190 189 200 191 201 192 202 193 203 194 204 195 205 196 206 197 207 198 208 199 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255 256 257 258 259 260 10 261 11 262 12 263 13 264 14 265 15 266 16 267 17 268 18 269 270 19 20 271 21 272 22 273 23 274 24 275 25 276 26 277 27 278 28 279 280 29 30 281 31 282 32 283 33 284 34 285 35 286 36 287 37 288 38 289 290 300 39 40 291 301 41 292 302 42 293 303 43 294 304 44 295 305 45 296 306 46 297 307 47 298 308 48 299 309 310 50 49 311 51 312 52 313 53 314 54 315 55 316 56 317 57 318 58 319 320 60 59 321 61 322 62 323 63 324 64 325 65 326 66 327 67 328 68 329 330 70 69 331 71 332 72 333 73 334 74 335 75 336 76 337 77 338 78 339 340 80 79 341 81 342 82 343 83 344 84 345 85 346 86 347 87 348 88 349 350 90 89 351 91 352 92 353 93 354 94 355 95 356 96 357 97 358 98 359 360 99 361 362 363 364 365 366 367 368 369 370 371 372 373 374 375 376 377 378 379 380 381 382 383 384 385 386 387 388 389 390 400 391 401 392 402 393 403 394 404 395 405 396 406 397 407 398 408 399 409 410 411 412 413 414 415 416 417 418 419 420 421 422 423 424 425 426 427 428 429 430 431 432 433 434 435 436 437 438 439 440 441 442 443 444 445 446 447 448 449 450 451 452 453 454 455 456 457 458 459 460 461 462 463 464 465 466 467 468 469 470 471 472 473 474 475 476 477 478 479 480 481 482 483 484 485 486 487 488 489 490 500 491 501 492 502 493 503 494 504 495 505 496 506 497 507 498 508 499 509 510 511 512 513 514 515 516 517 518 519 520 521 522 523 524 525 526 527 528 529 530 531 532 533 534 535 536 537 538 539 540 541 542 543 544 545 546 547 548 549 550 551 552 553 554 555 556 557 558 559 560 561 562 563 564 565 566 567 568 569 570 571 572 573 574 575 576 577 578 579 580 581 582 583 584 585 586 587 588 589 590 600 591 601 592 602 593 603 594 604 595 605 596 606 597 607 598 608 599 609 610 611 612 613 614 615 616 617 618 619 620 621 622 623 624 625 626 627 628 629 630 631 632 633 634 635 636 637 638 639 640 641 642 643 644 645 646 647 648 649 650 651 652 653 654 655 656 657 658 659 660 661 662 663 664 665 666 667 668 669 670 671 672 673 674 675 676 677 678 679 680 681 682 683 684 685 686 687 688 689 690 700 691 701 692 702 693 703 694 704 695 705 696 706 697 707 698 708 699 709 710 711 712 713 714 715 716 717 718 719 720 721 722 723 724 725 726 727 728 729 730 731 732 733 734 735 736 737 738 739 740 741 742 743 744 745 746 747 748 749 750 751 752 753 754 755 756 757 758 759 760 761 762 763 764 765 766 767} 0 {} {}",
    "", false, "cursor-order-137",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<768} {incr i} {set a(k$i) $i};list [array names a] [array get a] [array statistics a]",
    "{k76 k696 k706 k77 k697 k707 k78 k698 k708 k80 k79 k699 k709 k710 k81 k711 k82 k712 k83 k713 k84 k714 k85 k715 k86 k716 k87 k717 k88 k718 k90 k89 k719 k720 k91 k721 k92 k722 k93 k723 k94 k724 k95 k725 k96 k726 k97 k727 k98 k728 k99 k729 k730 k731 k732 k733 k734 k735 k736 k737 k738 k739 k740 k741 k742 k743 k744 k745 k746 k747 k748 k749 k750 k751 k752 k753 k754 k755 k756 k757 k758 k759 k760 k761 k762 k763 k764 k765 k766 k767 k100 k101 k102 k103 k104 k105 k106 k107 k108 k110 k109 k111 k112 k113 k114 k115 k116 k117 k118 k120 k119 k121 k122 k123 k124 k125 k126 k127 k128 k130 k129 k131 k132 k133 k134 k135 k136 k137 k138 k140 k139 k141 k142 k143 k144 k145 k146 k147 k148 k150 k149 k151 k152 k153 k154 k155 k156 k157 k158 k160 k159 k161 k162 k163 k164 k165 k166 k167 k168 k170 k169 k171 k172 k173 k174 k175 k176 k177 k178 k180 k179 k181 k182 k183 k184 k185 k186 k187 k188 k190 k189 k200 k191 k201 k192 k202 k193 k203 k194 k204 k195 k205 k196 k206 k197 k207 k198 k208 k199 k209 k210 k211 k212 k213 k214 k215 k216 k217 k218 k219 k220 k221 k222 k223 k224 k225 k226 k227 k228 k229 k230 k231 k232 k233 k234 k235 k236 k237 k238 k239 k240 k241 k242 k243 k244 k245 k246 k247 k248 k249 k250 k251 k252 k253 k254 k255 k256 k257 k258 k259 k260 k261 k262 k263 k264 k265 k266 k267 k268 k269 k270 k271 k272 k273 k274 k275 k276 k277 k278 k279 k280 k281 k282 k283 k284 k285 k286 k287 k288 k289 k290 k300 k291 k301 k292 k302 k293 k303 k294 k304 k295 k305 k296 k306 k297 k307 k298 k308 k299 k309 k310 k311 k312 k313 k314 k315 k316 k317 k318 k319 k320 k321 k322 k323 k324 k325 k326 k327 k328 k329 k330 k331 k332 k333 k334 k335 k336 k337 k338 k339 k340 k341 k342 k343 k344 k345 k346 k347 k348 k349 k350 k351 k352 k353 k354 k355 k356 k357 k358 k359 k360 k361 k362 k363 k364 k365 k366 k367 k368 k369 k370 k371 k372 k373 k374 k375 k376 k377 k378 k379 k380 k381 k382 k383 k384 k385 k386 k387 k388 k389 k390 k400 k391 k401 k392 k402 k393 k403 k394 k404 k395 k405 k396 k406 k397 k407 k398 k408 k399 k409 k410 k411 k412 k413 k414 k415 k416 k417 k418 k419 k420 k421 k422 k423 k424 k425 k426 k427 k428 k429 k430 k431 k432 k433 k434 k435 k436 k437 k438 k439 k440 k441 k442 k443 k444 k445 k446 k447 k448 k449 k450 k451 k452 k453 k454 k455 k456 k457 k458 k459 k460 k461 k462 k463 k464 k465 k466 k467 k468 k469 k470 k471 k472 k473 k474 k475 k476 k477 k478 k479 k480 k481 k482 k483 k484 k485 k486 k487 k488 k489 k490 k500 k491 k501 k492 k502 k493 k503 k494 k504 k495 k505 k496 k506 k497 k507 k498 k508 k499 k509 k510 k511 k512 k513 k514 k515 k516 k517 k518 k519 k520 k521 k522 k523 k524 k525 k526 k527 k528 k529 k530 k531 k532 k533 k534 k535 k536 k537 k538 k539 k540 k541 k542 k543 k544 k545 k546 k547 k548 k549 k550 k551 k552 k553 k554 k555 k556 k557 k558 k559 k560 k561 k562 k563 k564 k565 k566 k567 k568 k569 k570 k571 k572 k573 k574 k575 k576 k577 k578 k579 k580 k581 k582 k583 k584 k585 k586 k587 k588 k589 k590 k600 k591 k601 k592 k602 k593 k603 k594 k604 k595 k605 k596 k606 k597 k607 k598 k608 k599 k609 k610 k611 k612 k613 k614 k615 k616 k617 k618 k619 k620 k621 k622 k623 k624 k625 k626 k627 k628 k10 k629 k630 k11 k631 k12 k632 k13 k633 k14 k634 k15 k635 k16 k636 k17 k637 k18 k638 k19 k20 k639 k640 k21 k641 k22 k642 k23 k643 k24 k644 k25 k645 k26 k646 k27 k647 k28 k648 k29 k30 k649 k650 k31 k651 k32 k652 k33 k653 k34 k654 k35 k655 k36 k656 k37 k657 k38 k658 k39 k40 k659 k660 k41 k661 k42 k662 k43 k663 k44 k664 k45 k665 k46 k666 k47 k667 k48 k668 k50 k49 k669 k670 k51 k671 k52 k672 k53 k673 k54 k674 k55 k675 k56 k676 k57 k677 k58 k678 k60 k59 k679 k680 k61 k681 k62 k0 k682 k63 k1 k683 k64 k2 k684 k65 k3 k685 k66 k4 k686 k67 k5 k687 k68 k6 k688 k70 k69 k7 k689 k690 k700 k71 k8 k691 k701 k72 k9 k692 k702 k73 k693 k703 k74 k694 k704 k75 k695 k705} {k76 76 k696 696 k706 706 k77 77 k697 697 k707 707 k78 78 k698 698 k708 708 k80 80 k79 79 k699 699 k709 709 k710 710 k81 81 k711 711 k82 82 k712 712 k83 83 k713 713 k84 84 k714 714 k85 85 k715 715 k86 86 k716 716 k87 87 k717 717 k88 88 k718 718 k90 90 k89 89 k719 719 k720 720 k91 91 k721 721 k92 92 k722 722 k93 93 k723 723 k94 94 k724 724 k95 95 k725 725 k96 96 k726 726 k97 97 k727 727 k98 98 k728 728 k99 99 k729 729 k730 730 k731 731 k732 732 k733 733 k734 734 k735 735 k736 736 k737 737 k738 738 k739 739 k740 740 k741 741 k742 742 k743 743 k744 744 k745 745 k746 746 k747 747 k748 748 k749 749 k750 750 k751 751 k752 752 k753 753 k754 754 k755 755 k756 756 k757 757 k758 758 k759 759 k760 760 k761 761 k762 762 k763 763 k764 764 k765 765 k766 766 k767 767 k100 100 k101 101 k102 102 k103 103 k104 104 k105 105 k106 106 k107 107 k108 108 k110 110 k109 109 k111 111 k112 112 k113 113 k114 114 k115 115 k116 116 k117 117 k118 118 k120 120 k119 119 k121 121 k122 122 k123 123 k124 124 k125 125 k126 126 k127 127 k128 128 k130 130 k129 129 k131 131 k132 132 k133 133 k134 134 k135 135 k136 136 k137 137 k138 138 k140 140 k139 139 k141 141 k142 142 k143 143 k144 144 k145 145 k146 146 k147 147 k148 148 k150 150 k149 149 k151 151 k152 152 k153 153 k154 154 k155 155 k156 156 k157 157 k158 158 k160 160 k159 159 k161 161 k162 162 k163 163 k164 164 k165 165 k166 166 k167 167 k168 168 k170 170 k169 169 k171 171 k172 172 k173 173 k174 174 k175 175 k176 176 k177 177 k178 178 k180 180 k179 179 k181 181 k182 182 k183 183 k184 184 k185 185 k186 186 k187 187 k188 188 k190 190 k189 189 k200 200 k191 191 k201 201 k192 192 k202 202 k193 193 k203 203 k194 194 k204 204 k195 195 k205 205 k196 196 k206 206 k197 197 k207 207 k198 198 k208 208 k199 199 k209 209 k210 210 k211 211 k212 212 k213 213 k214 214 k215 215 k216 216 k217 217 k218 218 k219 219 k220 220 k221 221 k222 222 k223 223 k224 224 k225 225 k226 226 k227 227 k228 228 k229 229 k230 230 k231 231 k232 232 k233 233 k234 234 k235 235 k236 236 k237 237 k238 238 k239 239 k240 240 k241 241 k242 242 k243 243 k244 244 k245 245 k246 246 k247 247 k248 248 k249 249 k250 250 k251 251 k252 252 k253 253 k254 254 k255 255 k256 256 k257 257 k258 258 k259 259 k260 260 k261 261 k262 262 k263 263 k264 264 k265 265 k266 266 k267 267 k268 268 k269 269 k270 270 k271 271 k272 272 k273 273 k274 274 k275 275 k276 276 k277 277 k278 278 k279 279 k280 280 k281 281 k282 282 k283 283 k284 284 k285 285 k286 286 k287 287 k288 288 k289 289 k290 290 k300 300 k291 291 k301 301 k292 292 k302 302 k293 293 k303 303 k294 294 k304 304 k295 295 k305 305 k296 296 k306 306 k297 297 k307 307 k298 298 k308 308 k299 299 k309 309 k310 310 k311 311 k312 312 k313 313 k314 314 k315 315 k316 316 k317 317 k318 318 k319 319 k320 320 k321 321 k322 322 k323 323 k324 324 k325 325 k326 326 k327 327 k328 328 k329 329 k330 330 k331 331 k332 332 k333 333 k334 334 k335 335 k336 336 k337 337 k338 338 k339 339 k340 340 k341 341 k342 342 k343 343 k344 344 k345 345 k346 346 k347 347 k348 348 k349 349 k350 350 k351 351 k352 352 k353 353 k354 354 k355 355 k356 356 k357 357 k358 358 k359 359 k360 360 k361 361 k362 362 k363 363 k364 364 k365 365 k366 366 k367 367 k368 368 k369 369 k370 370 k371 371 k372 372 k373 373 k374 374 k375 375 k376 376 k377 377 k378 378 k379 379 k380 380 k381 381 k382 382 k383 383 k384 384 k385 385 k386 386 k387 387 k388 388 k389 389 k390 390 k400 400 k391 391 k401 401 k392 392 k402 402 k393 393 k403 403 k394 394 k404 404 k395 395 k405 405 k396 396 k406 406 k397 397 k407 407 k398 398 k408 408 k399 399 k409 409 k410 410 k411 411 k412 412 k413 413 k414 414 k415 415 k416 416 k417 417 k418 418 k419 419 k420 420 k421 421 k422 422 k423 423 k424 424 k425 425 k426 426 k427 427 k428 428 k429 429 k430 430 k431 431 k432 432 k433 433 k434 434 k435 435 k436 436 k437 437 k438 438 k439 439 k440 440 k441 441 k442 442 k443 443 k444 444 k445 445 k446 446 k447 447 k448 448 k449 449 k450 450 k451 451 k452 452 k453 453 k454 454 k455 455 k456 456 k457 457 k458 458 k459 459 k460 460 k461 461 k462 462 k463 463 k464 464 k465 465 k466 466 k467 467 k468 468 k469 469 k470 470 k471 471 k472 472 k473 473 k474 474 k475 475 k476 476 k477 477 k478 478 k479 479 k480 480 k481 481 k482 482 k483 483 k484 484 k485 485 k486 486 k487 487 k488 488 k489 489 k490 490 k500 500 k491 491 k501 501 k492 492 k502 502 k493 493 k503 503 k494 494 k504 504 k495 495 k505 505 k496 496 k506 506 k497 497 k507 507 k498 498 k508 508 k499 499 k509 509 k510 510 k511 511 k512 512 k513 513 k514 514 k515 515 k516 516 k517 517 k518 518 k519 519 k520 520 k521 521 k522 522 k523 523 k524 524 k525 525 k526 526 k527 527 k528 528 k529 529 k530 530 k531 531 k532 532 k533 533 k534 534 k535 535 k536 536 k537 537 k538 538 k539 539 k540 540 k541 541 k542 542 k543 543 k544 544 k545 545 k546 546 k547 547 k548 548 k549 549 k550 550 k551 551 k552 552 k553 553 k554 554 k555 555 k556 556 k557 557 k558 558 k559 559 k560 560 k561 561 k562 562 k563 563 k564 564 k565 565 k566 566 k567 567 k568 568 k569 569 k570 570 k571 571 k572 572 k573 573 k574 574 k575 575 k576 576 k577 577 k578 578 k579 579 k580 580 k581 581 k582 582 k583 583 k584 584 k585 585 k586 586 k587 587 k588 588 k589 589 k590 590 k600 600 k591 591 k601 601 k592 592 k602 602 k593 593 k603 603 k594 594 k604 604 k595 595 k605 605 k596 596 k606 606 k597 597 k607 607 k598 598 k608 608 k599 599 k609 609 k610 610 k611 611 k612 612 k613 613 k614 614 k615 615 k616 616 k617 617 k618 618 k619 619 k620 620 k621 621 k622 622 k623 623 k624 624 k625 625 k626 626 k627 627 k628 628 k10 10 k629 629 k630 630 k11 11 k631 631 k12 12 k632 632 k13 13 k633 633 k14 14 k634 634 k15 15 k635 635 k16 16 k636 636 k17 17 k637 637 k18 18 k638 638 k19 19 k20 20 k639 639 k640 640 k21 21 k641 641 k22 22 k642 642 k23 23 k643 643 k24 24 k644 644 k25 25 k645 645 k26 26 k646 646 k27 27 k647 647 k28 28 k648 648 k29 29 k30 30 k649 649 k650 650 k31 31 k651 651 k32 32 k652 652 k33 33 k653 653 k34 34 k654 654 k35 35 k655 655 k36 36 k656 656 k37 37 k657 657 k38 38 k658 658 k39 39 k40 40 k659 659 k660 660 k41 41 k661 661 k42 42 k662 662 k43 43 k663 663 k44 44 k664 664 k45 45 k665 665 k46 46 k666 666 k47 47 k667 667 k48 48 k668 668 k50 50 k49 49 k669 669 k670 670 k51 51 k671 671 k52 52 k672 672 k53 53 k673 673 k54 54 k674 674 k55 55 k675 675 k56 56 k676 676 k57 57 k677 677 k58 58 k678 678 k60 60 k59 59 k679 679 k680 680 k61 61 k681 681 k62 62 k0 0 k682 682 k63 63 k1 1 k683 683 k64 64 k2 2 k684 684 k65 65 k3 3 k685 685 k66 66 k4 4 k686 686 k67 67 k5 5 k687 687 k68 68 k6 6 k688 688 k70 70 k69 69 k7 7 k689 689 k690 690 k700 700 k71 71 k8 8 k691 691 k701 701 k72 72 k9 9 k692 692 k702 702 k73 73 k693 693 k703 703 k74 74 k694 694 k704 704 k75 75 k695 695 k705 705} {768 entries in table, 1024 buckets\nnumber of buckets with 0 entries: 476\nnumber of buckets with 1 entries: 376\nnumber of buckets with 2 entries: 137\nnumber of buckets with 3 entries: 25\nnumber of buckets with 4 entries: 8\nnumber of buckets with 5 entries: 1\nnumber of buckets with 6 entries: 1\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.4}",
    "", false, "hash-order-138",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<768} {incr i} {set a(k$i) $i};for {set i 0} {$i<768} {incr i 2} {unset a(k$i)};list [array names a] [array statistics a]",
    "{k77 k697 k707 k79 k699 k709 k81 k711 k83 k713 k85 k715 k87 k717 k89 k719 k91 k721 k93 k723 k95 k725 k97 k727 k99 k729 k731 k733 k735 k737 k739 k741 k743 k745 k747 k749 k751 k753 k755 k757 k759 k761 k763 k765 k767 k101 k103 k105 k107 k109 k111 k113 k115 k117 k119 k121 k123 k125 k127 k129 k131 k133 k135 k137 k139 k141 k143 k145 k147 k149 k151 k153 k155 k157 k159 k161 k163 k165 k167 k169 k171 k173 k175 k177 k179 k181 k183 k185 k187 k189 k191 k201 k193 k203 k195 k205 k197 k207 k199 k209 k211 k213 k215 k217 k219 k221 k223 k225 k227 k229 k231 k233 k235 k237 k239 k241 k243 k245 k247 k249 k251 k253 k255 k257 k259 k261 k263 k265 k267 k269 k271 k273 k275 k277 k279 k281 k283 k285 k287 k289 k291 k301 k293 k303 k295 k305 k297 k307 k299 k309 k311 k313 k315 k317 k319 k321 k323 k325 k327 k329 k331 k333 k335 k337 k339 k341 k343 k345 k347 k349 k351 k353 k355 k357 k359 k361 k363 k365 k367 k369 k371 k373 k375 k377 k379 k381 k383 k385 k387 k389 k391 k401 k393 k403 k395 k405 k397 k407 k399 k409 k411 k413 k415 k417 k419 k421 k423 k425 k427 k429 k431 k433 k435 k437 k439 k441 k443 k445 k447 k449 k451 k453 k455 k457 k459 k461 k463 k465 k467 k469 k471 k473 k475 k477 k479 k481 k483 k485 k487 k489 k491 k501 k493 k503 k495 k505 k497 k507 k499 k509 k511 k513 k515 k517 k519 k521 k523 k525 k527 k529 k531 k533 k535 k537 k539 k541 k543 k545 k547 k549 k551 k553 k555 k557 k559 k561 k563 k565 k567 k569 k571 k573 k575 k577 k579 k581 k583 k585 k587 k589 k591 k601 k593 k603 k595 k605 k597 k607 k599 k609 k611 k613 k615 k617 k619 k621 k623 k625 k627 k629 k11 k631 k13 k633 k15 k635 k17 k637 k19 k639 k21 k641 k23 k643 k25 k645 k27 k647 k29 k649 k31 k651 k33 k653 k35 k655 k37 k657 k39 k659 k41 k661 k43 k663 k45 k665 k47 k667 k49 k669 k51 k671 k53 k673 k55 k675 k57 k677 k59 k679 k61 k681 k63 k1 k683 k65 k3 k685 k67 k5 k687 k69 k7 k689 k71 k691 k701 k9 k73 k693 k703 k75 k695 k705} {384 entries in table, 1024 buckets\nnumber of buckets with 0 entries: 719\nnumber of buckets with 1 entries: 235\nnumber of buckets with 2 entries: 61\nnumber of buckets with 3 entries: 9\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.2}",
    "", false, "hash-delete-139",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<768} {incr i} {set a(k$i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{k76 k696 k706 k77 k697 k707 k78 k698 k708 k80 k79 k699 k709 k710 k81 k711 k82 k712 k83 k713 k84 k714 k85 k715 k86 k716 k87 k717 k88 k718 k90 k89 k719 k720 k91 k721 k92 k722 k93 k723 k94 k724 k95 k725 k96 k726 k97 k727 k98 k728 k99 k729 k730 k731 k732 k733 k734 k735 k736 k737 k738 k739 k740 k741 k742 k743 k744 k745 k746 k747 k748 k749 k750 k751 k752 k753 k754 k755 k756 k757 k758 k759 k760 k761 k762 k763 k764 k765 k766 k767 k100 k101 k102 k103 k104 k105 k106 k107 k108 k110 k109 k111 k112 k113 k114 k115 k116 k117 k118 k120 k119 k121 k122 k123 k124 k125 k126 k127 k128 k130 k129 k131 k132 k133 k134 k135 k136 k137 k138 k140 k139 k141 k142 k143 k144 k145 k146 k147 k148 k150 k149 k151 k152 k153 k154 k155 k156 k157 k158 k160 k159 k161 k162 k163 k164 k165 k166 k167 k168 k170 k169 k171 k172 k173 k174 k175 k176 k177 k178 k180 k179 k181 k182 k183 k184 k185 k186 k187 k188 k190 k189 k200 k191 k201 k192 k202 k193 k203 k194 k204 k195 k205 k196 k206 k197 k207 k198 k208 k199 k209 k210 k211 k212 k213 k214 k215 k216 k217 k218 k219 k220 k221 k222 k223 k224 k225 k226 k227 k228 k229 k230 k231 k232 k233 k234 k235 k236 k237 k238 k239 k240 k241 k242 k243 k244 k245 k246 k247 k248 k249 k250 k251 k252 k253 k254 k255 k256 k257 k258 k259 k260 k261 k262 k263 k264 k265 k266 k267 k268 k269 k270 k271 k272 k273 k274 k275 k276 k277 k278 k279 k280 k281 k282 k283 k284 k285 k286 k287 k288 k289 k290 k300 k291 k301 k292 k302 k293 k303 k294 k304 k295 k305 k296 k306 k297 k307 k298 k308 k299 k309 k310 k311 k312 k313 k314 k315 k316 k317 k318 k319 k320 k321 k322 k323 k324 k325 k326 k327 k328 k329 k330 k331 k332 k333 k334 k335 k336 k337 k338 k339 k340 k341 k342 k343 k344 k345 k346 k347 k348 k349 k350 k351 k352 k353 k354 k355 k356 k357 k358 k359 k360 k361 k362 k363 k364 k365 k366 k367 k368 k369 k370 k371 k372 k373 k374 k375 k376 k377 k378 k379 k380 k381 k382 k383 k384 k385 k386 k387 k388 k389 k390 k400 k391 k401 k392 k402 k393 k403 k394 k404 k395 k405 k396 k406 k397 k407 k398 k408 k399 k409 k410 k411 k412 k413 k414 k415 k416 k417 k418 k419 k420 k421 k422 k423 k424 k425 k426 k427 k428 k429 k430 k431 k432 k433 k434 k435 k436 k437 k438 k439 k440 k441 k442 k443 k444 k445 k446 k447 k448 k449 k450 k451 k452 k453 k454 k455 k456 k457 k458 k459 k460 k461 k462 k463 k464 k465 k466 k467 k468 k469 k470 k471 k472 k473 k474 k475 k476 k477 k478 k479 k480 k481 k482 k483 k484 k485 k486 k487 k488 k489 k490 k500 k491 k501 k492 k502 k493 k503 k494 k504 k495 k505 k496 k506 k497 k507 k498 k508 k499 k509 k510 k511 k512 k513 k514 k515 k516 k517 k518 k519 k520 k521 k522 k523 k524 k525 k526 k527 k528 k529 k530 k531 k532 k533 k534 k535 k536 k537 k538 k539 k540 k541 k542 k543 k544 k545 k546 k547 k548 k549 k550 k551 k552 k553 k554 k555 k556 k557 k558 k559 k560 k561 k562 k563 k564 k565 k566 k567 k568 k569 k570 k571 k572 k573 k574 k575 k576 k577 k578 k579 k580 k581 k582 k583 k584 k585 k586 k587 k588 k589 k590 k600 k591 k601 k592 k602 k593 k603 k594 k604 k595 k605 k596 k606 k597 k607 k598 k608 k599 k609 k610 k611 k612 k613 k614 k615 k616 k617 k618 k619 k620 k621 k622 k623 k624 k625 k626 k627 k628 k10 k629 k630 k11 k631 k12 k632 k13 k633 k14 k634 k15 k635 k16 k636 k17 k637 k18 k638 k19 k20 k639 k640 k21 k641 k22 k642 k23 k643 k24 k644 k25 k645 k26 k646 k27 k647 k28 k648 k29 k30 k649 k650 k31 k651 k32 k652 k33 k653 k34 k654 k35 k655 k36 k656 k37 k657 k38 k658 k39 k40 k659 k660 k41 k661 k42 k662 k43 k663 k44 k664 k45 k665 k46 k666 k47 k667 k48 k668 k50 k49 k669 k670 k51 k671 k52 k672 k53 k673 k54 k674 k55 k675 k56 k676 k57 k677 k58 k678 k60 k59 k679 k680 k61 k681 k62 k0 k682 k63 k1 k683 k64 k2 k684 k65 k3 k685 k66 k4 k686 k67 k5 k687 k68 k6 k688 k70 k69 k7 k689 k690 k700 k71 k8 k691 k701 k72 k9 k692 k702 k73 k693 k703 k74 k694 k704 k75 k695 k705} 0 {} {}",
    "", false, "cursor-order-140",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<768} {incr i} {set a(same$i) $i};list [array names a] [array get a] [array statistics a]",
    "{same10 same11 same12 same13 same14 same15 same16 same17 same18 same19 same20 same21 same22 same23 same24 same25 same26 same27 same28 same29 same30 same31 same32 same33 same34 same35 same36 same37 same38 same39 same40 same41 same42 same43 same44 same45 same46 same47 same48 same50 same49 same51 same52 same53 same54 same55 same56 same57 same58 same60 same59 same61 same62 same63 same64 same65 same66 same67 same68 same70 same69 same71 same72 same73 same74 same75 same76 same77 same78 same80 same79 same81 same82 same83 same84 same85 same86 same87 same88 same90 same89 same91 same92 same93 same94 same95 same96 same97 same98 same99 same0 same1 same2 same3 same4 same5 same6 same7 same8 same9 same100 same101 same102 same103 same104 same105 same106 same107 same108 same110 same109 same111 same112 same113 same114 same115 same116 same117 same118 same120 same119 same121 same122 same123 same124 same125 same126 same127 same128 same130 same129 same131 same132 same133 same134 same135 same136 same137 same138 same140 same139 same141 same142 same143 same144 same145 same146 same147 same148 same150 same149 same151 same152 same153 same154 same155 same156 same157 same158 same160 same159 same161 same162 same163 same164 same165 same166 same167 same168 same170 same169 same171 same172 same173 same174 same175 same176 same177 same178 same180 same179 same181 same182 same183 same184 same185 same186 same187 same188 same190 same189 same200 same191 same201 same192 same202 same193 same203 same194 same204 same195 same205 same196 same206 same197 same207 same198 same208 same199 same209 same210 same211 same212 same213 same214 same215 same216 same217 same218 same219 same220 same221 same222 same223 same224 same225 same226 same227 same228 same229 same230 same231 same232 same233 same234 same235 same236 same237 same238 same239 same240 same241 same242 same243 same244 same245 same246 same247 same248 same249 same250 same251 same252 same253 same254 same255 same256 same257 same258 same259 same260 same261 same262 same263 same264 same265 same266 same267 same268 same269 same270 same271 same272 same273 same274 same275 same276 same277 same278 same279 same280 same281 same282 same283 same284 same285 same286 same287 same288 same289 same290 same300 same291 same301 same292 same302 same293 same303 same294 same304 same295 same305 same296 same306 same297 same307 same298 same308 same299 same309 same310 same311 same312 same313 same314 same315 same316 same317 same318 same319 same320 same321 same322 same323 same324 same325 same326 same327 same328 same329 same330 same331 same332 same333 same334 same335 same336 same337 same338 same339 same340 same341 same342 same343 same344 same345 same346 same347 same348 same349 same350 same351 same352 same353 same354 same355 same356 same357 same358 same359 same360 same361 same362 same363 same364 same365 same366 same367 same368 same369 same370 same371 same372 same373 same374 same375 same376 same377 same378 same379 same380 same381 same382 same383 same384 same385 same386 same387 same388 same389 same390 same400 same391 same401 same392 same402 same393 same403 same394 same404 same395 same405 same396 same406 same397 same407 same398 same408 same399 same409 same410 same411 same412 same413 same414 same415 same416 same417 same418 same419 same420 same421 same422 same423 same424 same425 same426 same427 same428 same429 same430 same431 same432 same433 same434 same435 same436 same437 same438 same439 same440 same441 same442 same443 same444 same445 same446 same447 same448 same449 same450 same451 same452 same453 same454 same455 same456 same457 same458 same459 same460 same461 same462 same463 same464 same465 same466 same467 same468 same469 same470 same471 same472 same473 same474 same475 same476 same477 same478 same479 same480 same481 same482 same483 same484 same485 same486 same487 same488 same489 same490 same500 same491 same501 same492 same502 same493 same503 same494 same504 same495 same505 same496 same506 same497 same507 same498 same508 same499 same509 same510 same511 same512 same513 same514 same515 same516 same517 same518 same519 same520 same521 same522 same523 same524 same525 same526 same527 same528 same529 same530 same531 same532 same533 same534 same535 same536 same537 same538 same539 same540 same541 same542 same543 same544 same545 same546 same547 same548 same549 same550 same551 same552 same553 same554 same555 same556 same557 same558 same559 same560 same561 same562 same563 same564 same565 same566 same567 same568 same569 same570 same571 same572 same573 same574 same575 same576 same577 same578 same579 same580 same581 same582 same583 same584 same585 same586 same587 same588 same589 same590 same600 same591 same601 same592 same602 same593 same603 same594 same604 same595 same605 same596 same606 same597 same607 same598 same608 same599 same609 same610 same611 same612 same613 same614 same615 same616 same617 same618 same619 same620 same621 same622 same623 same624 same625 same626 same627 same628 same629 same630 same631 same632 same633 same634 same635 same636 same637 same638 same639 same640 same641 same642 same643 same644 same645 same646 same647 same648 same649 same650 same651 same652 same653 same654 same655 same656 same657 same658 same659 same660 same661 same662 same663 same664 same665 same666 same667 same668 same669 same670 same671 same672 same673 same674 same675 same676 same677 same678 same679 same680 same681 same682 same683 same684 same685 same686 same687 same688 same689 same690 same700 same691 same701 same692 same702 same693 same703 same694 same704 same695 same705 same696 same706 same697 same707 same698 same708 same699 same709 same710 same711 same712 same713 same714 same715 same716 same717 same718 same719 same720 same721 same722 same723 same724 same725 same726 same727 same728 same729 same730 same731 same732 same733 same734 same735 same736 same737 same738 same739 same740 same741 same742 same743 same744 same745 same746 same747 same748 same749 same750 same751 same752 same753 same754 same755 same756 same757 same758 same759 same760 same761 same762 same763 same764 same765 same766 same767} {same10 10 same11 11 same12 12 same13 13 same14 14 same15 15 same16 16 same17 17 same18 18 same19 19 same20 20 same21 21 same22 22 same23 23 same24 24 same25 25 same26 26 same27 27 same28 28 same29 29 same30 30 same31 31 same32 32 same33 33 same34 34 same35 35 same36 36 same37 37 same38 38 same39 39 same40 40 same41 41 same42 42 same43 43 same44 44 same45 45 same46 46 same47 47 same48 48 same50 50 same49 49 same51 51 same52 52 same53 53 same54 54 same55 55 same56 56 same57 57 same58 58 same60 60 same59 59 same61 61 same62 62 same63 63 same64 64 same65 65 same66 66 same67 67 same68 68 same70 70 same69 69 same71 71 same72 72 same73 73 same74 74 same75 75 same76 76 same77 77 same78 78 same80 80 same79 79 same81 81 same82 82 same83 83 same84 84 same85 85 same86 86 same87 87 same88 88 same90 90 same89 89 same91 91 same92 92 same93 93 same94 94 same95 95 same96 96 same97 97 same98 98 same99 99 same0 0 same1 1 same2 2 same3 3 same4 4 same5 5 same6 6 same7 7 same8 8 same9 9 same100 100 same101 101 same102 102 same103 103 same104 104 same105 105 same106 106 same107 107 same108 108 same110 110 same109 109 same111 111 same112 112 same113 113 same114 114 same115 115 same116 116 same117 117 same118 118 same120 120 same119 119 same121 121 same122 122 same123 123 same124 124 same125 125 same126 126 same127 127 same128 128 same130 130 same129 129 same131 131 same132 132 same133 133 same134 134 same135 135 same136 136 same137 137 same138 138 same140 140 same139 139 same141 141 same142 142 same143 143 same144 144 same145 145 same146 146 same147 147 same148 148 same150 150 same149 149 same151 151 same152 152 same153 153 same154 154 same155 155 same156 156 same157 157 same158 158 same160 160 same159 159 same161 161 same162 162 same163 163 same164 164 same165 165 same166 166 same167 167 same168 168 same170 170 same169 169 same171 171 same172 172 same173 173 same174 174 same175 175 same176 176 same177 177 same178 178 same180 180 same179 179 same181 181 same182 182 same183 183 same184 184 same185 185 same186 186 same187 187 same188 188 same190 190 same189 189 same200 200 same191 191 same201 201 same192 192 same202 202 same193 193 same203 203 same194 194 same204 204 same195 195 same205 205 same196 196 same206 206 same197 197 same207 207 same198 198 same208 208 same199 199 same209 209 same210 210 same211 211 same212 212 same213 213 same214 214 same215 215 same216 216 same217 217 same218 218 same219 219 same220 220 same221 221 same222 222 same223 223 same224 224 same225 225 same226 226 same227 227 same228 228 same229 229 same230 230 same231 231 same232 232 same233 233 same234 234 same235 235 same236 236 same237 237 same238 238 same239 239 same240 240 same241 241 same242 242 same243 243 same244 244 same245 245 same246 246 same247 247 same248 248 same249 249 same250 250 same251 251 same252 252 same253 253 same254 254 same255 255 same256 256 same257 257 same258 258 same259 259 same260 260 same261 261 same262 262 same263 263 same264 264 same265 265 same266 266 same267 267 same268 268 same269 269 same270 270 same271 271 same272 272 same273 273 same274 274 same275 275 same276 276 same277 277 same278 278 same279 279 same280 280 same281 281 same282 282 same283 283 same284 284 same285 285 same286 286 same287 287 same288 288 same289 289 same290 290 same300 300 same291 291 same301 301 same292 292 same302 302 same293 293 same303 303 same294 294 same304 304 same295 295 same305 305 same296 296 same306 306 same297 297 same307 307 same298 298 same308 308 same299 299 same309 309 same310 310 same311 311 same312 312 same313 313 same314 314 same315 315 same316 316 same317 317 same318 318 same319 319 same320 320 same321 321 same322 322 same323 323 same324 324 same325 325 same326 326 same327 327 same328 328 same329 329 same330 330 same331 331 same332 332 same333 333 same334 334 same335 335 same336 336 same337 337 same338 338 same339 339 same340 340 same341 341 same342 342 same343 343 same344 344 same345 345 same346 346 same347 347 same348 348 same349 349 same350 350 same351 351 same352 352 same353 353 same354 354 same355 355 same356 356 same357 357 same358 358 same359 359 same360 360 same361 361 same362 362 same363 363 same364 364 same365 365 same366 366 same367 367 same368 368 same369 369 same370 370 same371 371 same372 372 same373 373 same374 374 same375 375 same376 376 same377 377 same378 378 same379 379 same380 380 same381 381 same382 382 same383 383 same384 384 same385 385 same386 386 same387 387 same388 388 same389 389 same390 390 same400 400 same391 391 same401 401 same392 392 same402 402 same393 393 same403 403 same394 394 same404 404 same395 395 same405 405 same396 396 same406 406 same397 397 same407 407 same398 398 same408 408 same399 399 same409 409 same410 410 same411 411 same412 412 same413 413 same414 414 same415 415 same416 416 same417 417 same418 418 same419 419 same420 420 same421 421 same422 422 same423 423 same424 424 same425 425 same426 426 same427 427 same428 428 same429 429 same430 430 same431 431 same432 432 same433 433 same434 434 same435 435 same436 436 same437 437 same438 438 same439 439 same440 440 same441 441 same442 442 same443 443 same444 444 same445 445 same446 446 same447 447 same448 448 same449 449 same450 450 same451 451 same452 452 same453 453 same454 454 same455 455 same456 456 same457 457 same458 458 same459 459 same460 460 same461 461 same462 462 same463 463 same464 464 same465 465 same466 466 same467 467 same468 468 same469 469 same470 470 same471 471 same472 472 same473 473 same474 474 same475 475 same476 476 same477 477 same478 478 same479 479 same480 480 same481 481 same482 482 same483 483 same484 484 same485 485 same486 486 same487 487 same488 488 same489 489 same490 490 same500 500 same491 491 same501 501 same492 492 same502 502 same493 493 same503 503 same494 494 same504 504 same495 495 same505 505 same496 496 same506 506 same497 497 same507 507 same498 498 same508 508 same499 499 same509 509 same510 510 same511 511 same512 512 same513 513 same514 514 same515 515 same516 516 same517 517 same518 518 same519 519 same520 520 same521 521 same522 522 same523 523 same524 524 same525 525 same526 526 same527 527 same528 528 same529 529 same530 530 same531 531 same532 532 same533 533 same534 534 same535 535 same536 536 same537 537 same538 538 same539 539 same540 540 same541 541 same542 542 same543 543 same544 544 same545 545 same546 546 same547 547 same548 548 same549 549 same550 550 same551 551 same552 552 same553 553 same554 554 same555 555 same556 556 same557 557 same558 558 same559 559 same560 560 same561 561 same562 562 same563 563 same564 564 same565 565 same566 566 same567 567 same568 568 same569 569 same570 570 same571 571 same572 572 same573 573 same574 574 same575 575 same576 576 same577 577 same578 578 same579 579 same580 580 same581 581 same582 582 same583 583 same584 584 same585 585 same586 586 same587 587 same588 588 same589 589 same590 590 same600 600 same591 591 same601 601 same592 592 same602 602 same593 593 same603 603 same594 594 same604 604 same595 595 same605 605 same596 596 same606 606 same597 597 same607 607 same598 598 same608 608 same599 599 same609 609 same610 610 same611 611 same612 612 same613 613 same614 614 same615 615 same616 616 same617 617 same618 618 same619 619 same620 620 same621 621 same622 622 same623 623 same624 624 same625 625 same626 626 same627 627 same628 628 same629 629 same630 630 same631 631 same632 632 same633 633 same634 634 same635 635 same636 636 same637 637 same638 638 same639 639 same640 640 same641 641 same642 642 same643 643 same644 644 same645 645 same646 646 same647 647 same648 648 same649 649 same650 650 same651 651 same652 652 same653 653 same654 654 same655 655 same656 656 same657 657 same658 658 same659 659 same660 660 same661 661 same662 662 same663 663 same664 664 same665 665 same666 666 same667 667 same668 668 same669 669 same670 670 same671 671 same672 672 same673 673 same674 674 same675 675 same676 676 same677 677 same678 678 same679 679 same680 680 same681 681 same682 682 same683 683 same684 684 same685 685 same686 686 same687 687 same688 688 same689 689 same690 690 same700 700 same691 691 same701 701 same692 692 same702 702 same693 693 same703 703 same694 694 same704 704 same695 695 same705 705 same696 696 same706 706 same697 697 same707 707 same698 698 same708 708 same699 699 same709 709 same710 710 same711 711 same712 712 same713 713 same714 714 same715 715 same716 716 same717 717 same718 718 same719 719 same720 720 same721 721 same722 722 same723 723 same724 724 same725 725 same726 726 same727 727 same728 728 same729 729 same730 730 same731 731 same732 732 same733 733 same734 734 same735 735 same736 736 same737 737 same738 738 same739 739 same740 740 same741 741 same742 742 same743 743 same744 744 same745 745 same746 746 same747 747 same748 748 same749 749 same750 750 same751 751 same752 752 same753 753 same754 754 same755 755 same756 756 same757 757 same758 758 same759 759 same760 760 same761 761 same762 762 same763 763 same764 764 same765 765 same766 766 same767 767} {768 entries in table, 1024 buckets\nnumber of buckets with 0 entries: 384\nnumber of buckets with 1 entries: 524\nnumber of buckets with 2 entries: 104\nnumber of buckets with 3 entries: 12\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.2}",
    "", false, "hash-order-141",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<768} {incr i} {set a(same$i) $i};for {set i 0} {$i<768} {incr i 2} {unset a(same$i)};list [array names a] [array statistics a]",
    "{same11 same13 same15 same17 same19 same21 same23 same25 same27 same29 same31 same33 same35 same37 same39 same41 same43 same45 same47 same49 same51 same53 same55 same57 same59 same61 same63 same65 same67 same69 same71 same73 same75 same77 same79 same81 same83 same85 same87 same89 same91 same93 same95 same97 same99 same1 same3 same5 same7 same9 same101 same103 same105 same107 same109 same111 same113 same115 same117 same119 same121 same123 same125 same127 same129 same131 same133 same135 same137 same139 same141 same143 same145 same147 same149 same151 same153 same155 same157 same159 same161 same163 same165 same167 same169 same171 same173 same175 same177 same179 same181 same183 same185 same187 same189 same191 same201 same193 same203 same195 same205 same197 same207 same199 same209 same211 same213 same215 same217 same219 same221 same223 same225 same227 same229 same231 same233 same235 same237 same239 same241 same243 same245 same247 same249 same251 same253 same255 same257 same259 same261 same263 same265 same267 same269 same271 same273 same275 same277 same279 same281 same283 same285 same287 same289 same291 same301 same293 same303 same295 same305 same297 same307 same299 same309 same311 same313 same315 same317 same319 same321 same323 same325 same327 same329 same331 same333 same335 same337 same339 same341 same343 same345 same347 same349 same351 same353 same355 same357 same359 same361 same363 same365 same367 same369 same371 same373 same375 same377 same379 same381 same383 same385 same387 same389 same391 same401 same393 same403 same395 same405 same397 same407 same399 same409 same411 same413 same415 same417 same419 same421 same423 same425 same427 same429 same431 same433 same435 same437 same439 same441 same443 same445 same447 same449 same451 same453 same455 same457 same459 same461 same463 same465 same467 same469 same471 same473 same475 same477 same479 same481 same483 same485 same487 same489 same491 same501 same493 same503 same495 same505 same497 same507 same499 same509 same511 same513 same515 same517 same519 same521 same523 same525 same527 same529 same531 same533 same535 same537 same539 same541 same543 same545 same547 same549 same551 same553 same555 same557 same559 same561 same563 same565 same567 same569 same571 same573 same575 same577 same579 same581 same583 same585 same587 same589 same591 same601 same593 same603 same595 same605 same597 same607 same599 same609 same611 same613 same615 same617 same619 same621 same623 same625 same627 same629 same631 same633 same635 same637 same639 same641 same643 same645 same647 same649 same651 same653 same655 same657 same659 same661 same663 same665 same667 same669 same671 same673 same675 same677 same679 same681 same683 same685 same687 same689 same691 same701 same693 same703 same695 same705 same697 same707 same699 same709 same711 same713 same715 same717 same719 same721 same723 same725 same727 same729 same731 same733 same735 same737 same739 same741 same743 same745 same747 same749 same751 same753 same755 same757 same759 same761 same763 same765 same767} {384 entries in table, 1024 buckets\nnumber of buckets with 0 entries: 670\nnumber of buckets with 1 entries: 324\nnumber of buckets with 2 entries: 30\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.1}",
    "", false, "hash-delete-142",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<768} {incr i} {set a(same$i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{same10 same11 same12 same13 same14 same15 same16 same17 same18 same19 same20 same21 same22 same23 same24 same25 same26 same27 same28 same29 same30 same31 same32 same33 same34 same35 same36 same37 same38 same39 same40 same41 same42 same43 same44 same45 same46 same47 same48 same50 same49 same51 same52 same53 same54 same55 same56 same57 same58 same60 same59 same61 same62 same63 same64 same65 same66 same67 same68 same70 same69 same71 same72 same73 same74 same75 same76 same77 same78 same80 same79 same81 same82 same83 same84 same85 same86 same87 same88 same90 same89 same91 same92 same93 same94 same95 same96 same97 same98 same99 same0 same1 same2 same3 same4 same5 same6 same7 same8 same9 same100 same101 same102 same103 same104 same105 same106 same107 same108 same110 same109 same111 same112 same113 same114 same115 same116 same117 same118 same120 same119 same121 same122 same123 same124 same125 same126 same127 same128 same130 same129 same131 same132 same133 same134 same135 same136 same137 same138 same140 same139 same141 same142 same143 same144 same145 same146 same147 same148 same150 same149 same151 same152 same153 same154 same155 same156 same157 same158 same160 same159 same161 same162 same163 same164 same165 same166 same167 same168 same170 same169 same171 same172 same173 same174 same175 same176 same177 same178 same180 same179 same181 same182 same183 same184 same185 same186 same187 same188 same190 same189 same200 same191 same201 same192 same202 same193 same203 same194 same204 same195 same205 same196 same206 same197 same207 same198 same208 same199 same209 same210 same211 same212 same213 same214 same215 same216 same217 same218 same219 same220 same221 same222 same223 same224 same225 same226 same227 same228 same229 same230 same231 same232 same233 same234 same235 same236 same237 same238 same239 same240 same241 same242 same243 same244 same245 same246 same247 same248 same249 same250 same251 same252 same253 same254 same255 same256 same257 same258 same259 same260 same261 same262 same263 same264 same265 same266 same267 same268 same269 same270 same271 same272 same273 same274 same275 same276 same277 same278 same279 same280 same281 same282 same283 same284 same285 same286 same287 same288 same289 same290 same300 same291 same301 same292 same302 same293 same303 same294 same304 same295 same305 same296 same306 same297 same307 same298 same308 same299 same309 same310 same311 same312 same313 same314 same315 same316 same317 same318 same319 same320 same321 same322 same323 same324 same325 same326 same327 same328 same329 same330 same331 same332 same333 same334 same335 same336 same337 same338 same339 same340 same341 same342 same343 same344 same345 same346 same347 same348 same349 same350 same351 same352 same353 same354 same355 same356 same357 same358 same359 same360 same361 same362 same363 same364 same365 same366 same367 same368 same369 same370 same371 same372 same373 same374 same375 same376 same377 same378 same379 same380 same381 same382 same383 same384 same385 same386 same387 same388 same389 same390 same400 same391 same401 same392 same402 same393 same403 same394 same404 same395 same405 same396 same406 same397 same407 same398 same408 same399 same409 same410 same411 same412 same413 same414 same415 same416 same417 same418 same419 same420 same421 same422 same423 same424 same425 same426 same427 same428 same429 same430 same431 same432 same433 same434 same435 same436 same437 same438 same439 same440 same441 same442 same443 same444 same445 same446 same447 same448 same449 same450 same451 same452 same453 same454 same455 same456 same457 same458 same459 same460 same461 same462 same463 same464 same465 same466 same467 same468 same469 same470 same471 same472 same473 same474 same475 same476 same477 same478 same479 same480 same481 same482 same483 same484 same485 same486 same487 same488 same489 same490 same500 same491 same501 same492 same502 same493 same503 same494 same504 same495 same505 same496 same506 same497 same507 same498 same508 same499 same509 same510 same511 same512 same513 same514 same515 same516 same517 same518 same519 same520 same521 same522 same523 same524 same525 same526 same527 same528 same529 same530 same531 same532 same533 same534 same535 same536 same537 same538 same539 same540 same541 same542 same543 same544 same545 same546 same547 same548 same549 same550 same551 same552 same553 same554 same555 same556 same557 same558 same559 same560 same561 same562 same563 same564 same565 same566 same567 same568 same569 same570 same571 same572 same573 same574 same575 same576 same577 same578 same579 same580 same581 same582 same583 same584 same585 same586 same587 same588 same589 same590 same600 same591 same601 same592 same602 same593 same603 same594 same604 same595 same605 same596 same606 same597 same607 same598 same608 same599 same609 same610 same611 same612 same613 same614 same615 same616 same617 same618 same619 same620 same621 same622 same623 same624 same625 same626 same627 same628 same629 same630 same631 same632 same633 same634 same635 same636 same637 same638 same639 same640 same641 same642 same643 same644 same645 same646 same647 same648 same649 same650 same651 same652 same653 same654 same655 same656 same657 same658 same659 same660 same661 same662 same663 same664 same665 same666 same667 same668 same669 same670 same671 same672 same673 same674 same675 same676 same677 same678 same679 same680 same681 same682 same683 same684 same685 same686 same687 same688 same689 same690 same700 same691 same701 same692 same702 same693 same703 same694 same704 same695 same705 same696 same706 same697 same707 same698 same708 same699 same709 same710 same711 same712 same713 same714 same715 same716 same717 same718 same719 same720 same721 same722 same723 same724 same725 same726 same727 same728 same729 same730 same731 same732 same733 same734 same735 same736 same737 same738 same739 same740 same741 same742 same743 same744 same745 same746 same747 same748 same749 same750 same751 same752 same753 same754 same755 same756 same757 same758 same759 same760 same761 same762 same763 same764 same765 same766 same767} 0 {} {}",
    "", false, "cursor-order-143",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<769} {incr i} {set a($i) $i};list [array names a] [array get a] [array statistics a]",
    "{0 1 2 3 4 5 6 7 8 9 100 101 102 103 104 105 106 107 108 110 109 111 112 113 114 115 116 117 118 120 119 121 122 123 124 125 126 127 128 130 129 131 132 133 134 135 136 137 138 140 139 141 142 143 144 145 146 147 148 150 149 151 152 153 154 155 156 157 158 160 159 161 162 163 164 165 166 167 168 170 169 171 172 173 174 175 176 177 178 180 179 181 182 183 184 185 186 187 188 190 189 200 191 201 192 202 193 203 194 204 195 205 196 206 197 207 198 208 199 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255 256 257 258 259 260 10 261 11 262 12 263 13 264 14 265 15 266 16 267 17 268 18 269 270 19 20 271 21 272 22 273 23 274 24 275 25 276 26 277 27 278 28 279 280 29 30 281 31 282 32 283 33 284 34 285 35 286 36 287 37 288 38 289 290 300 39 40 291 301 41 292 302 42 293 303 43 294 304 44 295 305 45 296 306 46 297 307 47 298 308 48 299 309 310 50 49 311 51 312 52 313 53 314 54 315 55 316 56 317 57 318 58 319 320 60 59 321 61 322 62 323 63 324 64 325 65 326 66 327 67 328 68 329 330 70 69 331 71 332 72 333 73 334 74 335 75 336 76 337 77 338 78 339 340 80 79 341 81 342 82 343 83 344 84 345 85 346 86 347 87 348 88 349 350 90 89 351 91 352 92 353 93 354 94 355 95 356 96 357 97 358 98 359 360 99 361 362 363 364 365 366 367 368 369 370 371 372 373 374 375 376 377 378 379 380 381 382 383 384 385 386 387 388 389 390 400 391 401 392 402 393 403 394 404 395 405 396 406 397 407 398 408 399 409 410 411 412 413 414 415 416 417 418 419 420 421 422 423 424 425 426 427 428 429 430 431 432 433 434 435 436 437 438 439 440 441 442 443 444 445 446 447 448 449 450 451 452 453 454 455 456 457 458 459 460 461 462 463 464 465 466 467 468 469 470 471 472 473 474 475 476 477 478 479 480 481 482 483 484 485 486 487 488 489 490 500 491 501 492 502 493 503 494 504 495 505 496 506 497 507 498 508 499 509 510 511 512 513 514 515 516 517 518 519 520 521 522 523 524 525 526 527 528 529 530 531 532 533 534 535 536 537 538 539 540 541 542 543 544 545 546 547 548 549 550 551 552 553 554 555 556 557 558 559 560 561 562 563 564 565 566 567 568 569 570 571 572 573 574 575 576 577 578 579 580 581 582 583 584 585 586 587 588 589 590 600 591 601 592 602 593 603 594 604 595 605 596 606 597 607 598 608 599 609 610 611 612 613 614 615 616 617 618 619 620 621 622 623 624 625 626 627 628 629 630 631 632 633 634 635 636 637 638 639 640 641 642 643 644 645 646 647 648 649 650 651 652 653 654 655 656 657 658 659 660 661 662 663 664 665 666 667 668 669 670 671 672 673 674 675 676 677 678 679 680 681 682 683 684 685 686 687 688 689 690 700 691 701 692 702 693 703 694 704 695 705 696 706 697 707 698 708 699 709 710 711 712 713 714 715 716 717 718 719 720 721 722 723 724 725 726 727 728 729 730 731 732 733 734 735 736 737 738 739 740 741 742 743 744 745 746 747 748 749 750 751 752 753 754 755 756 757 758 759 760 761 762 763 764 765 766 767 768} {0 0 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 100 100 101 101 102 102 103 103 104 104 105 105 106 106 107 107 108 108 110 110 109 109 111 111 112 112 113 113 114 114 115 115 116 116 117 117 118 118 120 120 119 119 121 121 122 122 123 123 124 124 125 125 126 126 127 127 128 128 130 130 129 129 131 131 132 132 133 133 134 134 135 135 136 136 137 137 138 138 140 140 139 139 141 141 142 142 143 143 144 144 145 145 146 146 147 147 148 148 150 150 149 149 151 151 152 152 153 153 154 154 155 155 156 156 157 157 158 158 160 160 159 159 161 161 162 162 163 163 164 164 165 165 166 166 167 167 168 168 170 170 169 169 171 171 172 172 173 173 174 174 175 175 176 176 177 177 178 178 180 180 179 179 181 181 182 182 183 183 184 184 185 185 186 186 187 187 188 188 190 190 189 189 200 200 191 191 201 201 192 192 202 202 193 193 203 203 194 194 204 204 195 195 205 205 196 196 206 206 197 197 207 207 198 198 208 208 199 199 209 209 210 210 211 211 212 212 213 213 214 214 215 215 216 216 217 217 218 218 219 219 220 220 221 221 222 222 223 223 224 224 225 225 226 226 227 227 228 228 229 229 230 230 231 231 232 232 233 233 234 234 235 235 236 236 237 237 238 238 239 239 240 240 241 241 242 242 243 243 244 244 245 245 246 246 247 247 248 248 249 249 250 250 251 251 252 252 253 253 254 254 255 255 256 256 257 257 258 258 259 259 260 260 10 10 261 261 11 11 262 262 12 12 263 263 13 13 264 264 14 14 265 265 15 15 266 266 16 16 267 267 17 17 268 268 18 18 269 269 270 270 19 19 20 20 271 271 21 21 272 272 22 22 273 273 23 23 274 274 24 24 275 275 25 25 276 276 26 26 277 277 27 27 278 278 28 28 279 279 280 280 29 29 30 30 281 281 31 31 282 282 32 32 283 283 33 33 284 284 34 34 285 285 35 35 286 286 36 36 287 287 37 37 288 288 38 38 289 289 290 290 300 300 39 39 40 40 291 291 301 301 41 41 292 292 302 302 42 42 293 293 303 303 43 43 294 294 304 304 44 44 295 295 305 305 45 45 296 296 306 306 46 46 297 297 307 307 47 47 298 298 308 308 48 48 299 299 309 309 310 310 50 50 49 49 311 311 51 51 312 312 52 52 313 313 53 53 314 314 54 54 315 315 55 55 316 316 56 56 317 317 57 57 318 318 58 58 319 319 320 320 60 60 59 59 321 321 61 61 322 322 62 62 323 323 63 63 324 324 64 64 325 325 65 65 326 326 66 66 327 327 67 67 328 328 68 68 329 329 330 330 70 70 69 69 331 331 71 71 332 332 72 72 333 333 73 73 334 334 74 74 335 335 75 75 336 336 76 76 337 337 77 77 338 338 78 78 339 339 340 340 80 80 79 79 341 341 81 81 342 342 82 82 343 343 83 83 344 344 84 84 345 345 85 85 346 346 86 86 347 347 87 87 348 348 88 88 349 349 350 350 90 90 89 89 351 351 91 91 352 352 92 92 353 353 93 93 354 354 94 94 355 355 95 95 356 356 96 96 357 357 97 97 358 358 98 98 359 359 360 360 99 99 361 361 362 362 363 363 364 364 365 365 366 366 367 367 368 368 369 369 370 370 371 371 372 372 373 373 374 374 375 375 376 376 377 377 378 378 379 379 380 380 381 381 382 382 383 383 384 384 385 385 386 386 387 387 388 388 389 389 390 390 400 400 391 391 401 401 392 392 402 402 393 393 403 403 394 394 404 404 395 395 405 405 396 396 406 406 397 397 407 407 398 398 408 408 399 399 409 409 410 410 411 411 412 412 413 413 414 414 415 415 416 416 417 417 418 418 419 419 420 420 421 421 422 422 423 423 424 424 425 425 426 426 427 427 428 428 429 429 430 430 431 431 432 432 433 433 434 434 435 435 436 436 437 437 438 438 439 439 440 440 441 441 442 442 443 443 444 444 445 445 446 446 447 447 448 448 449 449 450 450 451 451 452 452 453 453 454 454 455 455 456 456 457 457 458 458 459 459 460 460 461 461 462 462 463 463 464 464 465 465 466 466 467 467 468 468 469 469 470 470 471 471 472 472 473 473 474 474 475 475 476 476 477 477 478 478 479 479 480 480 481 481 482 482 483 483 484 484 485 485 486 486 487 487 488 488 489 489 490 490 500 500 491 491 501 501 492 492 502 502 493 493 503 503 494 494 504 504 495 495 505 505 496 496 506 506 497 497 507 507 498 498 508 508 499 499 509 509 510 510 511 511 512 512 513 513 514 514 515 515 516 516 517 517 518 518 519 519 520 520 521 521 522 522 523 523 524 524 525 525 526 526 527 527 528 528 529 529 530 530 531 531 532 532 533 533 534 534 535 535 536 536 537 537 538 538 539 539 540 540 541 541 542 542 543 543 544 544 545 545 546 546 547 547 548 548 549 549 550 550 551 551 552 552 553 553 554 554 555 555 556 556 557 557 558 558 559 559 560 560 561 561 562 562 563 563 564 564 565 565 566 566 567 567 568 568 569 569 570 570 571 571 572 572 573 573 574 574 575 575 576 576 577 577 578 578 579 579 580 580 581 581 582 582 583 583 584 584 585 585 586 586 587 587 588 588 589 589 590 590 600 600 591 591 601 601 592 592 602 602 593 593 603 603 594 594 604 604 595 595 605 605 596 596 606 606 597 597 607 607 598 598 608 608 599 599 609 609 610 610 611 611 612 612 613 613 614 614 615 615 616 616 617 617 618 618 619 619 620 620 621 621 622 622 623 623 624 624 625 625 626 626 627 627 628 628 629 629 630 630 631 631 632 632 633 633 634 634 635 635 636 636 637 637 638 638 639 639 640 640 641 641 642 642 643 643 644 644 645 645 646 646 647 647 648 648 649 649 650 650 651 651 652 652 653 653 654 654 655 655 656 656 657 657 658 658 659 659 660 660 661 661 662 662 663 663 664 664 665 665 666 666 667 667 668 668 669 669 670 670 671 671 672 672 673 673 674 674 675 675 676 676 677 677 678 678 679 679 680 680 681 681 682 682 683 683 684 684 685 685 686 686 687 687 688 688 689 689 690 690 700 700 691 691 701 701 692 692 702 702 693 693 703 703 694 694 704 704 695 695 705 705 696 696 706 706 697 697 707 707 698 698 708 708 699 699 709 709 710 710 711 711 712 712 713 713 714 714 715 715 716 716 717 717 718 718 719 719 720 720 721 721 722 722 723 723 724 724 725 725 726 726 727 727 728 728 729 729 730 730 731 731 732 732 733 733 734 734 735 735 736 736 737 737 738 738 739 739 740 740 741 741 742 742 743 743 744 744 745 745 746 746 747 747 748 748 749 749 750 750 751 751 752 752 753 753 754 754 755 755 756 756 757 757 758 758 759 759 760 760 761 761 762 762 763 763 764 764 765 765 766 766 767 767 768 768} {769 entries in table, 1024 buckets\nnumber of buckets with 0 entries: 465\nnumber of buckets with 1 entries: 386\nnumber of buckets with 2 entries: 139\nnumber of buckets with 3 entries: 31\nnumber of buckets with 4 entries: 3\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.3}",
    "", false, "hash-order-144",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<769} {incr i} {set a($i) $i};for {set i 0} {$i<769} {incr i 2} {unset a($i)};list [array names a] [array statistics a]",
    "{1 3 5 7 9 101 103 105 107 109 111 113 115 117 119 121 123 125 127 129 131 133 135 137 139 141 143 145 147 149 151 153 155 157 159 161 163 165 167 169 171 173 175 177 179 181 183 185 187 189 191 201 193 203 195 205 197 207 199 209 211 213 215 217 219 221 223 225 227 229 231 233 235 237 239 241 243 245 247 249 251 253 255 257 259 261 11 263 13 265 15 267 17 269 19 271 21 273 23 275 25 277 27 279 29 281 31 283 33 285 35 287 37 289 39 291 301 41 293 303 43 295 305 45 297 307 47 299 309 49 311 51 313 53 315 55 317 57 319 59 321 61 323 63 325 65 327 67 329 69 331 71 333 73 335 75 337 77 339 79 341 81 343 83 345 85 347 87 349 89 351 91 353 93 355 95 357 97 359 99 361 363 365 367 369 371 373 375 377 379 381 383 385 387 389 391 401 393 403 395 405 397 407 399 409 411 413 415 417 419 421 423 425 427 429 431 433 435 437 439 441 443 445 447 449 451 453 455 457 459 461 463 465 467 469 471 473 475 477 479 481 483 485 487 489 491 501 493 503 495 505 497 507 499 509 511 513 515 517 519 521 523 525 527 529 531 533 535 537 539 541 543 545 547 549 551 553 555 557 559 561 563 565 567 569 571 573 575 577 579 581 583 585 587 589 591 601 593 603 595 605 597 607 599 609 611 613 615 617 619 621 623 625 627 629 631 633 635 637 639 641 643 645 647 649 651 653 655 657 659 661 663 665 667 669 671 673 675 677 679 681 683 685 687 689 691 701 693 703 695 705 697 707 699 709 711 713 715 717 719 721 723 725 727 729 731 733 735 737 739 741 743 745 747 749 751 753 755 757 759 761 763 765 767} {384 entries in table, 1024 buckets\nnumber of buckets with 0 entries: 679\nnumber of buckets with 1 entries: 307\nnumber of buckets with 2 entries: 37\nnumber of buckets with 3 entries: 1\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.1}",
    "", false, "hash-delete-145",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<769} {incr i} {set a($i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{0 1 2 3 4 5 6 7 8 9 100 101 102 103 104 105 106 107 108 110 109 111 112 113 114 115 116 117 118 120 119 121 122 123 124 125 126 127 128 130 129 131 132 133 134 135 136 137 138 140 139 141 142 143 144 145 146 147 148 150 149 151 152 153 154 155 156 157 158 160 159 161 162 163 164 165 166 167 168 170 169 171 172 173 174 175 176 177 178 180 179 181 182 183 184 185 186 187 188 190 189 200 191 201 192 202 193 203 194 204 195 205 196 206 197 207 198 208 199 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255 256 257 258 259 260 10 261 11 262 12 263 13 264 14 265 15 266 16 267 17 268 18 269 270 19 20 271 21 272 22 273 23 274 24 275 25 276 26 277 27 278 28 279 280 29 30 281 31 282 32 283 33 284 34 285 35 286 36 287 37 288 38 289 290 300 39 40 291 301 41 292 302 42 293 303 43 294 304 44 295 305 45 296 306 46 297 307 47 298 308 48 299 309 310 50 49 311 51 312 52 313 53 314 54 315 55 316 56 317 57 318 58 319 320 60 59 321 61 322 62 323 63 324 64 325 65 326 66 327 67 328 68 329 330 70 69 331 71 332 72 333 73 334 74 335 75 336 76 337 77 338 78 339 340 80 79 341 81 342 82 343 83 344 84 345 85 346 86 347 87 348 88 349 350 90 89 351 91 352 92 353 93 354 94 355 95 356 96 357 97 358 98 359 360 99 361 362 363 364 365 366 367 368 369 370 371 372 373 374 375 376 377 378 379 380 381 382 383 384 385 386 387 388 389 390 400 391 401 392 402 393 403 394 404 395 405 396 406 397 407 398 408 399 409 410 411 412 413 414 415 416 417 418 419 420 421 422 423 424 425 426 427 428 429 430 431 432 433 434 435 436 437 438 439 440 441 442 443 444 445 446 447 448 449 450 451 452 453 454 455 456 457 458 459 460 461 462 463 464 465 466 467 468 469 470 471 472 473 474 475 476 477 478 479 480 481 482 483 484 485 486 487 488 489 490 500 491 501 492 502 493 503 494 504 495 505 496 506 497 507 498 508 499 509 510 511 512 513 514 515 516 517 518 519 520 521 522 523 524 525 526 527 528 529 530 531 532 533 534 535 536 537 538 539 540 541 542 543 544 545 546 547 548 549 550 551 552 553 554 555 556 557 558 559 560 561 562 563 564 565 566 567 568 569 570 571 572 573 574 575 576 577 578 579 580 581 582 583 584 585 586 587 588 589 590 600 591 601 592 602 593 603 594 604 595 605 596 606 597 607 598 608 599 609 610 611 612 613 614 615 616 617 618 619 620 621 622 623 624 625 626 627 628 629 630 631 632 633 634 635 636 637 638 639 640 641 642 643 644 645 646 647 648 649 650 651 652 653 654 655 656 657 658 659 660 661 662 663 664 665 666 667 668 669 670 671 672 673 674 675 676 677 678 679 680 681 682 683 684 685 686 687 688 689 690 700 691 701 692 702 693 703 694 704 695 705 696 706 697 707 698 708 699 709 710 711 712 713 714 715 716 717 718 719 720 721 722 723 724 725 726 727 728 729 730 731 732 733 734 735 736 737 738 739 740 741 742 743 744 745 746 747 748 749 750 751 752 753 754 755 756 757 758 759 760 761 762 763 764 765 766 767 768} 0 {} {}",
    "", false, "cursor-order-146",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<769} {incr i} {set a(k$i) $i};list [array names a] [array get a] [array statistics a]",
    "{k76 k696 k706 k77 k697 k707 k78 k698 k708 k80 k79 k699 k709 k710 k81 k711 k82 k712 k83 k713 k84 k714 k85 k715 k86 k716 k87 k717 k88 k718 k90 k89 k719 k720 k91 k721 k92 k722 k93 k723 k94 k724 k95 k725 k96 k726 k97 k727 k98 k728 k99 k729 k730 k731 k732 k733 k734 k735 k736 k737 k738 k739 k740 k741 k742 k743 k744 k745 k746 k747 k748 k749 k750 k751 k752 k753 k754 k755 k756 k757 k758 k759 k760 k761 k762 k763 k764 k765 k766 k767 k768 k100 k101 k102 k103 k104 k105 k106 k107 k108 k110 k109 k111 k112 k113 k114 k115 k116 k117 k118 k120 k119 k121 k122 k123 k124 k125 k126 k127 k128 k130 k129 k131 k132 k133 k134 k135 k136 k137 k138 k140 k139 k141 k142 k143 k144 k145 k146 k147 k148 k150 k149 k151 k152 k153 k154 k155 k156 k157 k158 k160 k159 k161 k162 k163 k164 k165 k166 k167 k168 k170 k169 k171 k172 k173 k174 k175 k176 k177 k178 k180 k179 k181 k182 k183 k184 k185 k186 k187 k188 k190 k189 k200 k191 k201 k192 k202 k193 k203 k194 k204 k195 k205 k196 k206 k197 k207 k198 k208 k199 k209 k210 k211 k212 k213 k214 k215 k216 k217 k218 k219 k220 k221 k222 k223 k224 k225 k226 k227 k228 k229 k230 k231 k232 k233 k234 k235 k236 k237 k238 k239 k240 k241 k242 k243 k244 k245 k246 k247 k248 k249 k250 k251 k252 k253 k254 k255 k256 k257 k258 k259 k260 k261 k262 k263 k264 k265 k266 k267 k268 k269 k270 k271 k272 k273 k274 k275 k276 k277 k278 k279 k280 k281 k282 k283 k284 k285 k286 k287 k288 k289 k290 k300 k291 k301 k292 k302 k293 k303 k294 k304 k295 k305 k296 k306 k297 k307 k298 k308 k299 k309 k310 k311 k312 k313 k314 k315 k316 k317 k318 k319 k320 k321 k322 k323 k324 k325 k326 k327 k328 k329 k330 k331 k332 k333 k334 k335 k336 k337 k338 k339 k340 k341 k342 k343 k344 k345 k346 k347 k348 k349 k350 k351 k352 k353 k354 k355 k356 k357 k358 k359 k360 k361 k362 k363 k364 k365 k366 k367 k368 k369 k370 k371 k372 k373 k374 k375 k376 k377 k378 k379 k380 k381 k382 k383 k384 k385 k386 k387 k388 k389 k390 k400 k391 k401 k392 k402 k393 k403 k394 k404 k395 k405 k396 k406 k397 k407 k398 k408 k399 k409 k410 k411 k412 k413 k414 k415 k416 k417 k418 k419 k420 k421 k422 k423 k424 k425 k426 k427 k428 k429 k430 k431 k432 k433 k434 k435 k436 k437 k438 k439 k440 k441 k442 k443 k444 k445 k446 k447 k448 k449 k450 k451 k452 k453 k454 k455 k456 k457 k458 k459 k460 k461 k462 k463 k464 k465 k466 k467 k468 k469 k470 k471 k472 k473 k474 k475 k476 k477 k478 k479 k480 k481 k482 k483 k484 k485 k486 k487 k488 k489 k490 k500 k491 k501 k492 k502 k493 k503 k494 k504 k495 k505 k496 k506 k497 k507 k498 k508 k499 k509 k510 k511 k512 k513 k514 k515 k516 k517 k518 k519 k520 k521 k522 k523 k524 k525 k526 k527 k528 k529 k530 k531 k532 k533 k534 k535 k536 k537 k538 k539 k540 k541 k542 k543 k544 k545 k546 k547 k548 k549 k550 k551 k552 k553 k554 k555 k556 k557 k558 k559 k560 k561 k562 k563 k564 k565 k566 k567 k568 k569 k570 k571 k572 k573 k574 k575 k576 k577 k578 k579 k580 k581 k582 k583 k584 k585 k586 k587 k588 k589 k590 k600 k591 k601 k592 k602 k593 k603 k594 k604 k595 k605 k596 k606 k597 k607 k598 k608 k599 k609 k610 k611 k612 k613 k614 k615 k616 k617 k618 k619 k620 k621 k622 k623 k624 k625 k626 k627 k628 k10 k629 k630 k11 k631 k12 k632 k13 k633 k14 k634 k15 k635 k16 k636 k17 k637 k18 k638 k19 k20 k639 k640 k21 k641 k22 k642 k23 k643 k24 k644 k25 k645 k26 k646 k27 k647 k28 k648 k29 k30 k649 k650 k31 k651 k32 k652 k33 k653 k34 k654 k35 k655 k36 k656 k37 k657 k38 k658 k39 k40 k659 k660 k41 k661 k42 k662 k43 k663 k44 k664 k45 k665 k46 k666 k47 k667 k48 k668 k50 k49 k669 k670 k51 k671 k52 k672 k53 k673 k54 k674 k55 k675 k56 k676 k57 k677 k58 k678 k60 k59 k679 k680 k61 k681 k62 k0 k682 k63 k1 k683 k64 k2 k684 k65 k3 k685 k66 k4 k686 k67 k5 k687 k68 k6 k688 k70 k69 k7 k689 k690 k700 k71 k8 k691 k701 k72 k9 k692 k702 k73 k693 k703 k74 k694 k704 k75 k695 k705} {k76 76 k696 696 k706 706 k77 77 k697 697 k707 707 k78 78 k698 698 k708 708 k80 80 k79 79 k699 699 k709 709 k710 710 k81 81 k711 711 k82 82 k712 712 k83 83 k713 713 k84 84 k714 714 k85 85 k715 715 k86 86 k716 716 k87 87 k717 717 k88 88 k718 718 k90 90 k89 89 k719 719 k720 720 k91 91 k721 721 k92 92 k722 722 k93 93 k723 723 k94 94 k724 724 k95 95 k725 725 k96 96 k726 726 k97 97 k727 727 k98 98 k728 728 k99 99 k729 729 k730 730 k731 731 k732 732 k733 733 k734 734 k735 735 k736 736 k737 737 k738 738 k739 739 k740 740 k741 741 k742 742 k743 743 k744 744 k745 745 k746 746 k747 747 k748 748 k749 749 k750 750 k751 751 k752 752 k753 753 k754 754 k755 755 k756 756 k757 757 k758 758 k759 759 k760 760 k761 761 k762 762 k763 763 k764 764 k765 765 k766 766 k767 767 k768 768 k100 100 k101 101 k102 102 k103 103 k104 104 k105 105 k106 106 k107 107 k108 108 k110 110 k109 109 k111 111 k112 112 k113 113 k114 114 k115 115 k116 116 k117 117 k118 118 k120 120 k119 119 k121 121 k122 122 k123 123 k124 124 k125 125 k126 126 k127 127 k128 128 k130 130 k129 129 k131 131 k132 132 k133 133 k134 134 k135 135 k136 136 k137 137 k138 138 k140 140 k139 139 k141 141 k142 142 k143 143 k144 144 k145 145 k146 146 k147 147 k148 148 k150 150 k149 149 k151 151 k152 152 k153 153 k154 154 k155 155 k156 156 k157 157 k158 158 k160 160 k159 159 k161 161 k162 162 k163 163 k164 164 k165 165 k166 166 k167 167 k168 168 k170 170 k169 169 k171 171 k172 172 k173 173 k174 174 k175 175 k176 176 k177 177 k178 178 k180 180 k179 179 k181 181 k182 182 k183 183 k184 184 k185 185 k186 186 k187 187 k188 188 k190 190 k189 189 k200 200 k191 191 k201 201 k192 192 k202 202 k193 193 k203 203 k194 194 k204 204 k195 195 k205 205 k196 196 k206 206 k197 197 k207 207 k198 198 k208 208 k199 199 k209 209 k210 210 k211 211 k212 212 k213 213 k214 214 k215 215 k216 216 k217 217 k218 218 k219 219 k220 220 k221 221 k222 222 k223 223 k224 224 k225 225 k226 226 k227 227 k228 228 k229 229 k230 230 k231 231 k232 232 k233 233 k234 234 k235 235 k236 236 k237 237 k238 238 k239 239 k240 240 k241 241 k242 242 k243 243 k244 244 k245 245 k246 246 k247 247 k248 248 k249 249 k250 250 k251 251 k252 252 k253 253 k254 254 k255 255 k256 256 k257 257 k258 258 k259 259 k260 260 k261 261 k262 262 k263 263 k264 264 k265 265 k266 266 k267 267 k268 268 k269 269 k270 270 k271 271 k272 272 k273 273 k274 274 k275 275 k276 276 k277 277 k278 278 k279 279 k280 280 k281 281 k282 282 k283 283 k284 284 k285 285 k286 286 k287 287 k288 288 k289 289 k290 290 k300 300 k291 291 k301 301 k292 292 k302 302 k293 293 k303 303 k294 294 k304 304 k295 295 k305 305 k296 296 k306 306 k297 297 k307 307 k298 298 k308 308 k299 299 k309 309 k310 310 k311 311 k312 312 k313 313 k314 314 k315 315 k316 316 k317 317 k318 318 k319 319 k320 320 k321 321 k322 322 k323 323 k324 324 k325 325 k326 326 k327 327 k328 328 k329 329 k330 330 k331 331 k332 332 k333 333 k334 334 k335 335 k336 336 k337 337 k338 338 k339 339 k340 340 k341 341 k342 342 k343 343 k344 344 k345 345 k346 346 k347 347 k348 348 k349 349 k350 350 k351 351 k352 352 k353 353 k354 354 k355 355 k356 356 k357 357 k358 358 k359 359 k360 360 k361 361 k362 362 k363 363 k364 364 k365 365 k366 366 k367 367 k368 368 k369 369 k370 370 k371 371 k372 372 k373 373 k374 374 k375 375 k376 376 k377 377 k378 378 k379 379 k380 380 k381 381 k382 382 k383 383 k384 384 k385 385 k386 386 k387 387 k388 388 k389 389 k390 390 k400 400 k391 391 k401 401 k392 392 k402 402 k393 393 k403 403 k394 394 k404 404 k395 395 k405 405 k396 396 k406 406 k397 397 k407 407 k398 398 k408 408 k399 399 k409 409 k410 410 k411 411 k412 412 k413 413 k414 414 k415 415 k416 416 k417 417 k418 418 k419 419 k420 420 k421 421 k422 422 k423 423 k424 424 k425 425 k426 426 k427 427 k428 428 k429 429 k430 430 k431 431 k432 432 k433 433 k434 434 k435 435 k436 436 k437 437 k438 438 k439 439 k440 440 k441 441 k442 442 k443 443 k444 444 k445 445 k446 446 k447 447 k448 448 k449 449 k450 450 k451 451 k452 452 k453 453 k454 454 k455 455 k456 456 k457 457 k458 458 k459 459 k460 460 k461 461 k462 462 k463 463 k464 464 k465 465 k466 466 k467 467 k468 468 k469 469 k470 470 k471 471 k472 472 k473 473 k474 474 k475 475 k476 476 k477 477 k478 478 k479 479 k480 480 k481 481 k482 482 k483 483 k484 484 k485 485 k486 486 k487 487 k488 488 k489 489 k490 490 k500 500 k491 491 k501 501 k492 492 k502 502 k493 493 k503 503 k494 494 k504 504 k495 495 k505 505 k496 496 k506 506 k497 497 k507 507 k498 498 k508 508 k499 499 k509 509 k510 510 k511 511 k512 512 k513 513 k514 514 k515 515 k516 516 k517 517 k518 518 k519 519 k520 520 k521 521 k522 522 k523 523 k524 524 k525 525 k526 526 k527 527 k528 528 k529 529 k530 530 k531 531 k532 532 k533 533 k534 534 k535 535 k536 536 k537 537 k538 538 k539 539 k540 540 k541 541 k542 542 k543 543 k544 544 k545 545 k546 546 k547 547 k548 548 k549 549 k550 550 k551 551 k552 552 k553 553 k554 554 k555 555 k556 556 k557 557 k558 558 k559 559 k560 560 k561 561 k562 562 k563 563 k564 564 k565 565 k566 566 k567 567 k568 568 k569 569 k570 570 k571 571 k572 572 k573 573 k574 574 k575 575 k576 576 k577 577 k578 578 k579 579 k580 580 k581 581 k582 582 k583 583 k584 584 k585 585 k586 586 k587 587 k588 588 k589 589 k590 590 k600 600 k591 591 k601 601 k592 592 k602 602 k593 593 k603 603 k594 594 k604 604 k595 595 k605 605 k596 596 k606 606 k597 597 k607 607 k598 598 k608 608 k599 599 k609 609 k610 610 k611 611 k612 612 k613 613 k614 614 k615 615 k616 616 k617 617 k618 618 k619 619 k620 620 k621 621 k622 622 k623 623 k624 624 k625 625 k626 626 k627 627 k628 628 k10 10 k629 629 k630 630 k11 11 k631 631 k12 12 k632 632 k13 13 k633 633 k14 14 k634 634 k15 15 k635 635 k16 16 k636 636 k17 17 k637 637 k18 18 k638 638 k19 19 k20 20 k639 639 k640 640 k21 21 k641 641 k22 22 k642 642 k23 23 k643 643 k24 24 k644 644 k25 25 k645 645 k26 26 k646 646 k27 27 k647 647 k28 28 k648 648 k29 29 k30 30 k649 649 k650 650 k31 31 k651 651 k32 32 k652 652 k33 33 k653 653 k34 34 k654 654 k35 35 k655 655 k36 36 k656 656 k37 37 k657 657 k38 38 k658 658 k39 39 k40 40 k659 659 k660 660 k41 41 k661 661 k42 42 k662 662 k43 43 k663 663 k44 44 k664 664 k45 45 k665 665 k46 46 k666 666 k47 47 k667 667 k48 48 k668 668 k50 50 k49 49 k669 669 k670 670 k51 51 k671 671 k52 52 k672 672 k53 53 k673 673 k54 54 k674 674 k55 55 k675 675 k56 56 k676 676 k57 57 k677 677 k58 58 k678 678 k60 60 k59 59 k679 679 k680 680 k61 61 k681 681 k62 62 k0 0 k682 682 k63 63 k1 1 k683 683 k64 64 k2 2 k684 684 k65 65 k3 3 k685 685 k66 66 k4 4 k686 686 k67 67 k5 5 k687 687 k68 68 k6 6 k688 688 k70 70 k69 69 k7 7 k689 689 k690 690 k700 700 k71 71 k8 8 k691 691 k701 701 k72 72 k9 9 k692 692 k702 702 k73 73 k693 693 k703 703 k74 74 k694 694 k704 704 k75 75 k695 695 k705 705} {769 entries in table, 1024 buckets\nnumber of buckets with 0 entries: 475\nnumber of buckets with 1 entries: 377\nnumber of buckets with 2 entries: 137\nnumber of buckets with 3 entries: 25\nnumber of buckets with 4 entries: 8\nnumber of buckets with 5 entries: 1\nnumber of buckets with 6 entries: 1\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.4}",
    "", false, "hash-order-147",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<769} {incr i} {set a(k$i) $i};for {set i 0} {$i<769} {incr i 2} {unset a(k$i)};list [array names a] [array statistics a]",
    "{k77 k697 k707 k79 k699 k709 k81 k711 k83 k713 k85 k715 k87 k717 k89 k719 k91 k721 k93 k723 k95 k725 k97 k727 k99 k729 k731 k733 k735 k737 k739 k741 k743 k745 k747 k749 k751 k753 k755 k757 k759 k761 k763 k765 k767 k101 k103 k105 k107 k109 k111 k113 k115 k117 k119 k121 k123 k125 k127 k129 k131 k133 k135 k137 k139 k141 k143 k145 k147 k149 k151 k153 k155 k157 k159 k161 k163 k165 k167 k169 k171 k173 k175 k177 k179 k181 k183 k185 k187 k189 k191 k201 k193 k203 k195 k205 k197 k207 k199 k209 k211 k213 k215 k217 k219 k221 k223 k225 k227 k229 k231 k233 k235 k237 k239 k241 k243 k245 k247 k249 k251 k253 k255 k257 k259 k261 k263 k265 k267 k269 k271 k273 k275 k277 k279 k281 k283 k285 k287 k289 k291 k301 k293 k303 k295 k305 k297 k307 k299 k309 k311 k313 k315 k317 k319 k321 k323 k325 k327 k329 k331 k333 k335 k337 k339 k341 k343 k345 k347 k349 k351 k353 k355 k357 k359 k361 k363 k365 k367 k369 k371 k373 k375 k377 k379 k381 k383 k385 k387 k389 k391 k401 k393 k403 k395 k405 k397 k407 k399 k409 k411 k413 k415 k417 k419 k421 k423 k425 k427 k429 k431 k433 k435 k437 k439 k441 k443 k445 k447 k449 k451 k453 k455 k457 k459 k461 k463 k465 k467 k469 k471 k473 k475 k477 k479 k481 k483 k485 k487 k489 k491 k501 k493 k503 k495 k505 k497 k507 k499 k509 k511 k513 k515 k517 k519 k521 k523 k525 k527 k529 k531 k533 k535 k537 k539 k541 k543 k545 k547 k549 k551 k553 k555 k557 k559 k561 k563 k565 k567 k569 k571 k573 k575 k577 k579 k581 k583 k585 k587 k589 k591 k601 k593 k603 k595 k605 k597 k607 k599 k609 k611 k613 k615 k617 k619 k621 k623 k625 k627 k629 k11 k631 k13 k633 k15 k635 k17 k637 k19 k639 k21 k641 k23 k643 k25 k645 k27 k647 k29 k649 k31 k651 k33 k653 k35 k655 k37 k657 k39 k659 k41 k661 k43 k663 k45 k665 k47 k667 k49 k669 k51 k671 k53 k673 k55 k675 k57 k677 k59 k679 k61 k681 k63 k1 k683 k65 k3 k685 k67 k5 k687 k69 k7 k689 k71 k691 k701 k9 k73 k693 k703 k75 k695 k705} {384 entries in table, 1024 buckets\nnumber of buckets with 0 entries: 719\nnumber of buckets with 1 entries: 235\nnumber of buckets with 2 entries: 61\nnumber of buckets with 3 entries: 9\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.2}",
    "", false, "hash-delete-148",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<769} {incr i} {set a(k$i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{k76 k696 k706 k77 k697 k707 k78 k698 k708 k80 k79 k699 k709 k710 k81 k711 k82 k712 k83 k713 k84 k714 k85 k715 k86 k716 k87 k717 k88 k718 k90 k89 k719 k720 k91 k721 k92 k722 k93 k723 k94 k724 k95 k725 k96 k726 k97 k727 k98 k728 k99 k729 k730 k731 k732 k733 k734 k735 k736 k737 k738 k739 k740 k741 k742 k743 k744 k745 k746 k747 k748 k749 k750 k751 k752 k753 k754 k755 k756 k757 k758 k759 k760 k761 k762 k763 k764 k765 k766 k767 k768 k100 k101 k102 k103 k104 k105 k106 k107 k108 k110 k109 k111 k112 k113 k114 k115 k116 k117 k118 k120 k119 k121 k122 k123 k124 k125 k126 k127 k128 k130 k129 k131 k132 k133 k134 k135 k136 k137 k138 k140 k139 k141 k142 k143 k144 k145 k146 k147 k148 k150 k149 k151 k152 k153 k154 k155 k156 k157 k158 k160 k159 k161 k162 k163 k164 k165 k166 k167 k168 k170 k169 k171 k172 k173 k174 k175 k176 k177 k178 k180 k179 k181 k182 k183 k184 k185 k186 k187 k188 k190 k189 k200 k191 k201 k192 k202 k193 k203 k194 k204 k195 k205 k196 k206 k197 k207 k198 k208 k199 k209 k210 k211 k212 k213 k214 k215 k216 k217 k218 k219 k220 k221 k222 k223 k224 k225 k226 k227 k228 k229 k230 k231 k232 k233 k234 k235 k236 k237 k238 k239 k240 k241 k242 k243 k244 k245 k246 k247 k248 k249 k250 k251 k252 k253 k254 k255 k256 k257 k258 k259 k260 k261 k262 k263 k264 k265 k266 k267 k268 k269 k270 k271 k272 k273 k274 k275 k276 k277 k278 k279 k280 k281 k282 k283 k284 k285 k286 k287 k288 k289 k290 k300 k291 k301 k292 k302 k293 k303 k294 k304 k295 k305 k296 k306 k297 k307 k298 k308 k299 k309 k310 k311 k312 k313 k314 k315 k316 k317 k318 k319 k320 k321 k322 k323 k324 k325 k326 k327 k328 k329 k330 k331 k332 k333 k334 k335 k336 k337 k338 k339 k340 k341 k342 k343 k344 k345 k346 k347 k348 k349 k350 k351 k352 k353 k354 k355 k356 k357 k358 k359 k360 k361 k362 k363 k364 k365 k366 k367 k368 k369 k370 k371 k372 k373 k374 k375 k376 k377 k378 k379 k380 k381 k382 k383 k384 k385 k386 k387 k388 k389 k390 k400 k391 k401 k392 k402 k393 k403 k394 k404 k395 k405 k396 k406 k397 k407 k398 k408 k399 k409 k410 k411 k412 k413 k414 k415 k416 k417 k418 k419 k420 k421 k422 k423 k424 k425 k426 k427 k428 k429 k430 k431 k432 k433 k434 k435 k436 k437 k438 k439 k440 k441 k442 k443 k444 k445 k446 k447 k448 k449 k450 k451 k452 k453 k454 k455 k456 k457 k458 k459 k460 k461 k462 k463 k464 k465 k466 k467 k468 k469 k470 k471 k472 k473 k474 k475 k476 k477 k478 k479 k480 k481 k482 k483 k484 k485 k486 k487 k488 k489 k490 k500 k491 k501 k492 k502 k493 k503 k494 k504 k495 k505 k496 k506 k497 k507 k498 k508 k499 k509 k510 k511 k512 k513 k514 k515 k516 k517 k518 k519 k520 k521 k522 k523 k524 k525 k526 k527 k528 k529 k530 k531 k532 k533 k534 k535 k536 k537 k538 k539 k540 k541 k542 k543 k544 k545 k546 k547 k548 k549 k550 k551 k552 k553 k554 k555 k556 k557 k558 k559 k560 k561 k562 k563 k564 k565 k566 k567 k568 k569 k570 k571 k572 k573 k574 k575 k576 k577 k578 k579 k580 k581 k582 k583 k584 k585 k586 k587 k588 k589 k590 k600 k591 k601 k592 k602 k593 k603 k594 k604 k595 k605 k596 k606 k597 k607 k598 k608 k599 k609 k610 k611 k612 k613 k614 k615 k616 k617 k618 k619 k620 k621 k622 k623 k624 k625 k626 k627 k628 k10 k629 k630 k11 k631 k12 k632 k13 k633 k14 k634 k15 k635 k16 k636 k17 k637 k18 k638 k19 k20 k639 k640 k21 k641 k22 k642 k23 k643 k24 k644 k25 k645 k26 k646 k27 k647 k28 k648 k29 k30 k649 k650 k31 k651 k32 k652 k33 k653 k34 k654 k35 k655 k36 k656 k37 k657 k38 k658 k39 k40 k659 k660 k41 k661 k42 k662 k43 k663 k44 k664 k45 k665 k46 k666 k47 k667 k48 k668 k50 k49 k669 k670 k51 k671 k52 k672 k53 k673 k54 k674 k55 k675 k56 k676 k57 k677 k58 k678 k60 k59 k679 k680 k61 k681 k62 k0 k682 k63 k1 k683 k64 k2 k684 k65 k3 k685 k66 k4 k686 k67 k5 k687 k68 k6 k688 k70 k69 k7 k689 k690 k700 k71 k8 k691 k701 k72 k9 k692 k702 k73 k693 k703 k74 k694 k704 k75 k695 k705} 0 {} {}",
    "", false, "cursor-order-149",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<769} {incr i} {set a(same$i) $i};list [array names a] [array get a] [array statistics a]",
    "{same10 same11 same12 same13 same14 same15 same16 same17 same18 same19 same20 same21 same22 same23 same24 same25 same26 same27 same28 same29 same30 same31 same32 same33 same34 same35 same36 same37 same38 same39 same40 same41 same42 same43 same44 same45 same46 same47 same48 same50 same49 same51 same52 same53 same54 same55 same56 same57 same58 same60 same59 same61 same62 same63 same64 same65 same66 same67 same68 same70 same69 same71 same72 same73 same74 same75 same76 same77 same78 same80 same79 same81 same82 same83 same84 same85 same86 same87 same88 same90 same89 same91 same92 same93 same94 same95 same96 same97 same98 same99 same0 same1 same2 same3 same4 same5 same6 same7 same8 same9 same100 same101 same102 same103 same104 same105 same106 same107 same108 same110 same109 same111 same112 same113 same114 same115 same116 same117 same118 same120 same119 same121 same122 same123 same124 same125 same126 same127 same128 same130 same129 same131 same132 same133 same134 same135 same136 same137 same138 same140 same139 same141 same142 same143 same144 same145 same146 same147 same148 same150 same149 same151 same152 same153 same154 same155 same156 same157 same158 same160 same159 same161 same162 same163 same164 same165 same166 same167 same168 same170 same169 same171 same172 same173 same174 same175 same176 same177 same178 same180 same179 same181 same182 same183 same184 same185 same186 same187 same188 same190 same189 same200 same191 same201 same192 same202 same193 same203 same194 same204 same195 same205 same196 same206 same197 same207 same198 same208 same199 same209 same210 same211 same212 same213 same214 same215 same216 same217 same218 same219 same220 same221 same222 same223 same224 same225 same226 same227 same228 same229 same230 same231 same232 same233 same234 same235 same236 same237 same238 same239 same240 same241 same242 same243 same244 same245 same246 same247 same248 same249 same250 same251 same252 same253 same254 same255 same256 same257 same258 same259 same260 same261 same262 same263 same264 same265 same266 same267 same268 same269 same270 same271 same272 same273 same274 same275 same276 same277 same278 same279 same280 same281 same282 same283 same284 same285 same286 same287 same288 same289 same290 same300 same291 same301 same292 same302 same293 same303 same294 same304 same295 same305 same296 same306 same297 same307 same298 same308 same299 same309 same310 same311 same312 same313 same314 same315 same316 same317 same318 same319 same320 same321 same322 same323 same324 same325 same326 same327 same328 same329 same330 same331 same332 same333 same334 same335 same336 same337 same338 same339 same340 same341 same342 same343 same344 same345 same346 same347 same348 same349 same350 same351 same352 same353 same354 same355 same356 same357 same358 same359 same360 same361 same362 same363 same364 same365 same366 same367 same368 same369 same370 same371 same372 same373 same374 same375 same376 same377 same378 same379 same380 same381 same382 same383 same384 same385 same386 same387 same388 same389 same390 same400 same391 same401 same392 same402 same393 same403 same394 same404 same395 same405 same396 same406 same397 same407 same398 same408 same399 same409 same410 same411 same412 same413 same414 same415 same416 same417 same418 same419 same420 same421 same422 same423 same424 same425 same426 same427 same428 same429 same430 same431 same432 same433 same434 same435 same436 same437 same438 same439 same440 same441 same442 same443 same444 same445 same446 same447 same448 same449 same450 same451 same452 same453 same454 same455 same456 same457 same458 same459 same460 same461 same462 same463 same464 same465 same466 same467 same468 same469 same470 same471 same472 same473 same474 same475 same476 same477 same478 same479 same480 same481 same482 same483 same484 same485 same486 same487 same488 same489 same490 same500 same491 same501 same492 same502 same493 same503 same494 same504 same495 same505 same496 same506 same497 same507 same498 same508 same499 same509 same510 same511 same512 same513 same514 same515 same516 same517 same518 same519 same520 same521 same522 same523 same524 same525 same526 same527 same528 same529 same530 same531 same532 same533 same534 same535 same536 same537 same538 same539 same540 same541 same542 same543 same544 same545 same546 same547 same548 same549 same550 same551 same552 same553 same554 same555 same556 same557 same558 same559 same560 same561 same562 same563 same564 same565 same566 same567 same568 same569 same570 same571 same572 same573 same574 same575 same576 same577 same578 same579 same580 same581 same582 same583 same584 same585 same586 same587 same588 same589 same590 same600 same591 same601 same592 same602 same593 same603 same594 same604 same595 same605 same596 same606 same597 same607 same598 same608 same599 same609 same610 same611 same612 same613 same614 same615 same616 same617 same618 same619 same620 same621 same622 same623 same624 same625 same626 same627 same628 same629 same630 same631 same632 same633 same634 same635 same636 same637 same638 same639 same640 same641 same642 same643 same644 same645 same646 same647 same648 same649 same650 same651 same652 same653 same654 same655 same656 same657 same658 same659 same660 same661 same662 same663 same664 same665 same666 same667 same668 same669 same670 same671 same672 same673 same674 same675 same676 same677 same678 same679 same680 same681 same682 same683 same684 same685 same686 same687 same688 same689 same690 same700 same691 same701 same692 same702 same693 same703 same694 same704 same695 same705 same696 same706 same697 same707 same698 same708 same699 same709 same710 same711 same712 same713 same714 same715 same716 same717 same718 same719 same720 same721 same722 same723 same724 same725 same726 same727 same728 same729 same730 same731 same732 same733 same734 same735 same736 same737 same738 same739 same740 same741 same742 same743 same744 same745 same746 same747 same748 same749 same750 same751 same752 same753 same754 same755 same756 same757 same758 same759 same760 same761 same762 same763 same764 same765 same766 same767 same768} {same10 10 same11 11 same12 12 same13 13 same14 14 same15 15 same16 16 same17 17 same18 18 same19 19 same20 20 same21 21 same22 22 same23 23 same24 24 same25 25 same26 26 same27 27 same28 28 same29 29 same30 30 same31 31 same32 32 same33 33 same34 34 same35 35 same36 36 same37 37 same38 38 same39 39 same40 40 same41 41 same42 42 same43 43 same44 44 same45 45 same46 46 same47 47 same48 48 same50 50 same49 49 same51 51 same52 52 same53 53 same54 54 same55 55 same56 56 same57 57 same58 58 same60 60 same59 59 same61 61 same62 62 same63 63 same64 64 same65 65 same66 66 same67 67 same68 68 same70 70 same69 69 same71 71 same72 72 same73 73 same74 74 same75 75 same76 76 same77 77 same78 78 same80 80 same79 79 same81 81 same82 82 same83 83 same84 84 same85 85 same86 86 same87 87 same88 88 same90 90 same89 89 same91 91 same92 92 same93 93 same94 94 same95 95 same96 96 same97 97 same98 98 same99 99 same0 0 same1 1 same2 2 same3 3 same4 4 same5 5 same6 6 same7 7 same8 8 same9 9 same100 100 same101 101 same102 102 same103 103 same104 104 same105 105 same106 106 same107 107 same108 108 same110 110 same109 109 same111 111 same112 112 same113 113 same114 114 same115 115 same116 116 same117 117 same118 118 same120 120 same119 119 same121 121 same122 122 same123 123 same124 124 same125 125 same126 126 same127 127 same128 128 same130 130 same129 129 same131 131 same132 132 same133 133 same134 134 same135 135 same136 136 same137 137 same138 138 same140 140 same139 139 same141 141 same142 142 same143 143 same144 144 same145 145 same146 146 same147 147 same148 148 same150 150 same149 149 same151 151 same152 152 same153 153 same154 154 same155 155 same156 156 same157 157 same158 158 same160 160 same159 159 same161 161 same162 162 same163 163 same164 164 same165 165 same166 166 same167 167 same168 168 same170 170 same169 169 same171 171 same172 172 same173 173 same174 174 same175 175 same176 176 same177 177 same178 178 same180 180 same179 179 same181 181 same182 182 same183 183 same184 184 same185 185 same186 186 same187 187 same188 188 same190 190 same189 189 same200 200 same191 191 same201 201 same192 192 same202 202 same193 193 same203 203 same194 194 same204 204 same195 195 same205 205 same196 196 same206 206 same197 197 same207 207 same198 198 same208 208 same199 199 same209 209 same210 210 same211 211 same212 212 same213 213 same214 214 same215 215 same216 216 same217 217 same218 218 same219 219 same220 220 same221 221 same222 222 same223 223 same224 224 same225 225 same226 226 same227 227 same228 228 same229 229 same230 230 same231 231 same232 232 same233 233 same234 234 same235 235 same236 236 same237 237 same238 238 same239 239 same240 240 same241 241 same242 242 same243 243 same244 244 same245 245 same246 246 same247 247 same248 248 same249 249 same250 250 same251 251 same252 252 same253 253 same254 254 same255 255 same256 256 same257 257 same258 258 same259 259 same260 260 same261 261 same262 262 same263 263 same264 264 same265 265 same266 266 same267 267 same268 268 same269 269 same270 270 same271 271 same272 272 same273 273 same274 274 same275 275 same276 276 same277 277 same278 278 same279 279 same280 280 same281 281 same282 282 same283 283 same284 284 same285 285 same286 286 same287 287 same288 288 same289 289 same290 290 same300 300 same291 291 same301 301 same292 292 same302 302 same293 293 same303 303 same294 294 same304 304 same295 295 same305 305 same296 296 same306 306 same297 297 same307 307 same298 298 same308 308 same299 299 same309 309 same310 310 same311 311 same312 312 same313 313 same314 314 same315 315 same316 316 same317 317 same318 318 same319 319 same320 320 same321 321 same322 322 same323 323 same324 324 same325 325 same326 326 same327 327 same328 328 same329 329 same330 330 same331 331 same332 332 same333 333 same334 334 same335 335 same336 336 same337 337 same338 338 same339 339 same340 340 same341 341 same342 342 same343 343 same344 344 same345 345 same346 346 same347 347 same348 348 same349 349 same350 350 same351 351 same352 352 same353 353 same354 354 same355 355 same356 356 same357 357 same358 358 same359 359 same360 360 same361 361 same362 362 same363 363 same364 364 same365 365 same366 366 same367 367 same368 368 same369 369 same370 370 same371 371 same372 372 same373 373 same374 374 same375 375 same376 376 same377 377 same378 378 same379 379 same380 380 same381 381 same382 382 same383 383 same384 384 same385 385 same386 386 same387 387 same388 388 same389 389 same390 390 same400 400 same391 391 same401 401 same392 392 same402 402 same393 393 same403 403 same394 394 same404 404 same395 395 same405 405 same396 396 same406 406 same397 397 same407 407 same398 398 same408 408 same399 399 same409 409 same410 410 same411 411 same412 412 same413 413 same414 414 same415 415 same416 416 same417 417 same418 418 same419 419 same420 420 same421 421 same422 422 same423 423 same424 424 same425 425 same426 426 same427 427 same428 428 same429 429 same430 430 same431 431 same432 432 same433 433 same434 434 same435 435 same436 436 same437 437 same438 438 same439 439 same440 440 same441 441 same442 442 same443 443 same444 444 same445 445 same446 446 same447 447 same448 448 same449 449 same450 450 same451 451 same452 452 same453 453 same454 454 same455 455 same456 456 same457 457 same458 458 same459 459 same460 460 same461 461 same462 462 same463 463 same464 464 same465 465 same466 466 same467 467 same468 468 same469 469 same470 470 same471 471 same472 472 same473 473 same474 474 same475 475 same476 476 same477 477 same478 478 same479 479 same480 480 same481 481 same482 482 same483 483 same484 484 same485 485 same486 486 same487 487 same488 488 same489 489 same490 490 same500 500 same491 491 same501 501 same492 492 same502 502 same493 493 same503 503 same494 494 same504 504 same495 495 same505 505 same496 496 same506 506 same497 497 same507 507 same498 498 same508 508 same499 499 same509 509 same510 510 same511 511 same512 512 same513 513 same514 514 same515 515 same516 516 same517 517 same518 518 same519 519 same520 520 same521 521 same522 522 same523 523 same524 524 same525 525 same526 526 same527 527 same528 528 same529 529 same530 530 same531 531 same532 532 same533 533 same534 534 same535 535 same536 536 same537 537 same538 538 same539 539 same540 540 same541 541 same542 542 same543 543 same544 544 same545 545 same546 546 same547 547 same548 548 same549 549 same550 550 same551 551 same552 552 same553 553 same554 554 same555 555 same556 556 same557 557 same558 558 same559 559 same560 560 same561 561 same562 562 same563 563 same564 564 same565 565 same566 566 same567 567 same568 568 same569 569 same570 570 same571 571 same572 572 same573 573 same574 574 same575 575 same576 576 same577 577 same578 578 same579 579 same580 580 same581 581 same582 582 same583 583 same584 584 same585 585 same586 586 same587 587 same588 588 same589 589 same590 590 same600 600 same591 591 same601 601 same592 592 same602 602 same593 593 same603 603 same594 594 same604 604 same595 595 same605 605 same596 596 same606 606 same597 597 same607 607 same598 598 same608 608 same599 599 same609 609 same610 610 same611 611 same612 612 same613 613 same614 614 same615 615 same616 616 same617 617 same618 618 same619 619 same620 620 same621 621 same622 622 same623 623 same624 624 same625 625 same626 626 same627 627 same628 628 same629 629 same630 630 same631 631 same632 632 same633 633 same634 634 same635 635 same636 636 same637 637 same638 638 same639 639 same640 640 same641 641 same642 642 same643 643 same644 644 same645 645 same646 646 same647 647 same648 648 same649 649 same650 650 same651 651 same652 652 same653 653 same654 654 same655 655 same656 656 same657 657 same658 658 same659 659 same660 660 same661 661 same662 662 same663 663 same664 664 same665 665 same666 666 same667 667 same668 668 same669 669 same670 670 same671 671 same672 672 same673 673 same674 674 same675 675 same676 676 same677 677 same678 678 same679 679 same680 680 same681 681 same682 682 same683 683 same684 684 same685 685 same686 686 same687 687 same688 688 same689 689 same690 690 same700 700 same691 691 same701 701 same692 692 same702 702 same693 693 same703 703 same694 694 same704 704 same695 695 same705 705 same696 696 same706 706 same697 697 same707 707 same698 698 same708 708 same699 699 same709 709 same710 710 same711 711 same712 712 same713 713 same714 714 same715 715 same716 716 same717 717 same718 718 same719 719 same720 720 same721 721 same722 722 same723 723 same724 724 same725 725 same726 726 same727 727 same728 728 same729 729 same730 730 same731 731 same732 732 same733 733 same734 734 same735 735 same736 736 same737 737 same738 738 same739 739 same740 740 same741 741 same742 742 same743 743 same744 744 same745 745 same746 746 same747 747 same748 748 same749 749 same750 750 same751 751 same752 752 same753 753 same754 754 same755 755 same756 756 same757 757 same758 758 same759 759 same760 760 same761 761 same762 762 same763 763 same764 764 same765 765 same766 766 same767 767 same768 768} {769 entries in table, 1024 buckets\nnumber of buckets with 0 entries: 383\nnumber of buckets with 1 entries: 525\nnumber of buckets with 2 entries: 104\nnumber of buckets with 3 entries: 12\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.2}",
    "", false, "hash-order-150",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<769} {incr i} {set a(same$i) $i};for {set i 0} {$i<769} {incr i 2} {unset a(same$i)};list [array names a] [array statistics a]",
    "{same11 same13 same15 same17 same19 same21 same23 same25 same27 same29 same31 same33 same35 same37 same39 same41 same43 same45 same47 same49 same51 same53 same55 same57 same59 same61 same63 same65 same67 same69 same71 same73 same75 same77 same79 same81 same83 same85 same87 same89 same91 same93 same95 same97 same99 same1 same3 same5 same7 same9 same101 same103 same105 same107 same109 same111 same113 same115 same117 same119 same121 same123 same125 same127 same129 same131 same133 same135 same137 same139 same141 same143 same145 same147 same149 same151 same153 same155 same157 same159 same161 same163 same165 same167 same169 same171 same173 same175 same177 same179 same181 same183 same185 same187 same189 same191 same201 same193 same203 same195 same205 same197 same207 same199 same209 same211 same213 same215 same217 same219 same221 same223 same225 same227 same229 same231 same233 same235 same237 same239 same241 same243 same245 same247 same249 same251 same253 same255 same257 same259 same261 same263 same265 same267 same269 same271 same273 same275 same277 same279 same281 same283 same285 same287 same289 same291 same301 same293 same303 same295 same305 same297 same307 same299 same309 same311 same313 same315 same317 same319 same321 same323 same325 same327 same329 same331 same333 same335 same337 same339 same341 same343 same345 same347 same349 same351 same353 same355 same357 same359 same361 same363 same365 same367 same369 same371 same373 same375 same377 same379 same381 same383 same385 same387 same389 same391 same401 same393 same403 same395 same405 same397 same407 same399 same409 same411 same413 same415 same417 same419 same421 same423 same425 same427 same429 same431 same433 same435 same437 same439 same441 same443 same445 same447 same449 same451 same453 same455 same457 same459 same461 same463 same465 same467 same469 same471 same473 same475 same477 same479 same481 same483 same485 same487 same489 same491 same501 same493 same503 same495 same505 same497 same507 same499 same509 same511 same513 same515 same517 same519 same521 same523 same525 same527 same529 same531 same533 same535 same537 same539 same541 same543 same545 same547 same549 same551 same553 same555 same557 same559 same561 same563 same565 same567 same569 same571 same573 same575 same577 same579 same581 same583 same585 same587 same589 same591 same601 same593 same603 same595 same605 same597 same607 same599 same609 same611 same613 same615 same617 same619 same621 same623 same625 same627 same629 same631 same633 same635 same637 same639 same641 same643 same645 same647 same649 same651 same653 same655 same657 same659 same661 same663 same665 same667 same669 same671 same673 same675 same677 same679 same681 same683 same685 same687 same689 same691 same701 same693 same703 same695 same705 same697 same707 same699 same709 same711 same713 same715 same717 same719 same721 same723 same725 same727 same729 same731 same733 same735 same737 same739 same741 same743 same745 same747 same749 same751 same753 same755 same757 same759 same761 same763 same765 same767} {384 entries in table, 1024 buckets\nnumber of buckets with 0 entries: 670\nnumber of buckets with 1 entries: 324\nnumber of buckets with 2 entries: 30\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.1}",
    "", false, "hash-delete-151",
  )
  check_array_case(
    "array set a {};for {set i 0} {$i<769} {incr i} {set a(same$i) $i};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};list $out [array anymore a $s] [array nextelement a $s] [array donesearch a $s]",
    "{same10 same11 same12 same13 same14 same15 same16 same17 same18 same19 same20 same21 same22 same23 same24 same25 same26 same27 same28 same29 same30 same31 same32 same33 same34 same35 same36 same37 same38 same39 same40 same41 same42 same43 same44 same45 same46 same47 same48 same50 same49 same51 same52 same53 same54 same55 same56 same57 same58 same60 same59 same61 same62 same63 same64 same65 same66 same67 same68 same70 same69 same71 same72 same73 same74 same75 same76 same77 same78 same80 same79 same81 same82 same83 same84 same85 same86 same87 same88 same90 same89 same91 same92 same93 same94 same95 same96 same97 same98 same99 same0 same1 same2 same3 same4 same5 same6 same7 same8 same9 same100 same101 same102 same103 same104 same105 same106 same107 same108 same110 same109 same111 same112 same113 same114 same115 same116 same117 same118 same120 same119 same121 same122 same123 same124 same125 same126 same127 same128 same130 same129 same131 same132 same133 same134 same135 same136 same137 same138 same140 same139 same141 same142 same143 same144 same145 same146 same147 same148 same150 same149 same151 same152 same153 same154 same155 same156 same157 same158 same160 same159 same161 same162 same163 same164 same165 same166 same167 same168 same170 same169 same171 same172 same173 same174 same175 same176 same177 same178 same180 same179 same181 same182 same183 same184 same185 same186 same187 same188 same190 same189 same200 same191 same201 same192 same202 same193 same203 same194 same204 same195 same205 same196 same206 same197 same207 same198 same208 same199 same209 same210 same211 same212 same213 same214 same215 same216 same217 same218 same219 same220 same221 same222 same223 same224 same225 same226 same227 same228 same229 same230 same231 same232 same233 same234 same235 same236 same237 same238 same239 same240 same241 same242 same243 same244 same245 same246 same247 same248 same249 same250 same251 same252 same253 same254 same255 same256 same257 same258 same259 same260 same261 same262 same263 same264 same265 same266 same267 same268 same269 same270 same271 same272 same273 same274 same275 same276 same277 same278 same279 same280 same281 same282 same283 same284 same285 same286 same287 same288 same289 same290 same300 same291 same301 same292 same302 same293 same303 same294 same304 same295 same305 same296 same306 same297 same307 same298 same308 same299 same309 same310 same311 same312 same313 same314 same315 same316 same317 same318 same319 same320 same321 same322 same323 same324 same325 same326 same327 same328 same329 same330 same331 same332 same333 same334 same335 same336 same337 same338 same339 same340 same341 same342 same343 same344 same345 same346 same347 same348 same349 same350 same351 same352 same353 same354 same355 same356 same357 same358 same359 same360 same361 same362 same363 same364 same365 same366 same367 same368 same369 same370 same371 same372 same373 same374 same375 same376 same377 same378 same379 same380 same381 same382 same383 same384 same385 same386 same387 same388 same389 same390 same400 same391 same401 same392 same402 same393 same403 same394 same404 same395 same405 same396 same406 same397 same407 same398 same408 same399 same409 same410 same411 same412 same413 same414 same415 same416 same417 same418 same419 same420 same421 same422 same423 same424 same425 same426 same427 same428 same429 same430 same431 same432 same433 same434 same435 same436 same437 same438 same439 same440 same441 same442 same443 same444 same445 same446 same447 same448 same449 same450 same451 same452 same453 same454 same455 same456 same457 same458 same459 same460 same461 same462 same463 same464 same465 same466 same467 same468 same469 same470 same471 same472 same473 same474 same475 same476 same477 same478 same479 same480 same481 same482 same483 same484 same485 same486 same487 same488 same489 same490 same500 same491 same501 same492 same502 same493 same503 same494 same504 same495 same505 same496 same506 same497 same507 same498 same508 same499 same509 same510 same511 same512 same513 same514 same515 same516 same517 same518 same519 same520 same521 same522 same523 same524 same525 same526 same527 same528 same529 same530 same531 same532 same533 same534 same535 same536 same537 same538 same539 same540 same541 same542 same543 same544 same545 same546 same547 same548 same549 same550 same551 same552 same553 same554 same555 same556 same557 same558 same559 same560 same561 same562 same563 same564 same565 same566 same567 same568 same569 same570 same571 same572 same573 same574 same575 same576 same577 same578 same579 same580 same581 same582 same583 same584 same585 same586 same587 same588 same589 same590 same600 same591 same601 same592 same602 same593 same603 same594 same604 same595 same605 same596 same606 same597 same607 same598 same608 same599 same609 same610 same611 same612 same613 same614 same615 same616 same617 same618 same619 same620 same621 same622 same623 same624 same625 same626 same627 same628 same629 same630 same631 same632 same633 same634 same635 same636 same637 same638 same639 same640 same641 same642 same643 same644 same645 same646 same647 same648 same649 same650 same651 same652 same653 same654 same655 same656 same657 same658 same659 same660 same661 same662 same663 same664 same665 same666 same667 same668 same669 same670 same671 same672 same673 same674 same675 same676 same677 same678 same679 same680 same681 same682 same683 same684 same685 same686 same687 same688 same689 same690 same700 same691 same701 same692 same702 same693 same703 same694 same704 same695 same705 same696 same706 same697 same707 same698 same708 same699 same709 same710 same711 same712 same713 same714 same715 same716 same717 same718 same719 same720 same721 same722 same723 same724 same725 same726 same727 same728 same729 same730 same731 same732 same733 same734 same735 same736 same737 same738 same739 same740 same741 same742 same743 same744 same745 same746 same747 same748 same749 same750 same751 same752 same753 same754 same755 same756 same757 same758 same759 same760 same761 same762 same763 same764 same765 same766 same767 same768} 0 {} {}",
    "", false, "cursor-order-152",
  )
  check_array_case(
    "array set a {};foreach k [list ] {set a($k) $k};list [array names a] [array get a] [array statistics a]",
    "{} {} {0 entries in table, 4 buckets\nnumber of buckets with 0 entries: 4\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 0.0}",
    "", false, "key-representations-153",
  )
  check_array_case(
    "array set a {};foreach k [list ] {set a($k) $k};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};set out",
    "", "", false, "key-cursor-154",
  )
  check_array_case(
    "array set a {};foreach k [list ] {set a($k) $k};foreach k [list ] {unset a($k);set a($k) newer};list [array names a] [array statistics a]",
    "{} {0 entries in table, 4 buckets\nnumber of buckets with 0 entries: 4\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 0.0}",
    "", false, "key-reinsert-155",
  )
  check_array_case(
    "array set a {};foreach k [list ] {set a($k) $k};list [array names a] [array get a] [array statistics a]",
    "{} {} {0 entries in table, 4 buckets\nnumber of buckets with 0 entries: 4\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 0.0}",
    "", false, "key-representations-156",
  )
  check_array_case(
    "array set a {};foreach k [list ] {set a($k) $k};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};set out",
    "", "", false, "key-cursor-157",
  )
  check_array_case(
    "array set a {};foreach k [list ] {set a($k) $k};foreach k [list ] {unset a($k);set a($k) newer};list [array names a] [array statistics a]",
    "{} {0 entries in table, 4 buckets\nnumber of buckets with 0 entries: 4\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 0.0}",
    "", false, "key-reinsert-158",
  )
  check_array_case(
    "array set a {};foreach k [list \"\"] {set a($k) $k};list [array names a] [array get a] [array statistics a]",
    "{{}} {{} {}} {1 entries in table, 4 buckets\nnumber of buckets with 0 entries: 3\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "key-representations-159",
  )
}

///|
test "Tcl array cases 161 through 200" {
  check_array_case(
    "array set a {};foreach k [list \"\"] {set a($k) $k};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};set out",
    "{}", "", false, "key-cursor-160",
  )
  check_array_case(
    "array set a {};foreach k [list \"\"] {set a($k) $k};foreach k [list \"\"] {unset a($k);set a($k) newer};list [array names a] [array statistics a]",
    "{{}} {1 entries in table, 4 buckets\nnumber of buckets with 0 entries: 3\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "key-reinsert-161",
  )
  check_array_case(
    "array set a {};foreach k [list \"\"] {set a($k) $k};list [array names a] [array get a] [array statistics a]",
    "{{}} {{} {}} {1 entries in table, 4 buckets\nnumber of buckets with 0 entries: 3\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "key-representations-162",
  )
  check_array_case(
    "array set a {};foreach k [list \"\"] {set a($k) $k};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};set out",
    "{}", "", false, "key-cursor-163",
  )
  check_array_case(
    "array set a {};foreach k [list \"\"] {set a($k) $k};foreach k [list \"\"] {unset a($k);set a($k) newer};list [array names a] [array statistics a]",
    "{{}} {1 entries in table, 4 buckets\nnumber of buckets with 0 entries: 3\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "key-reinsert-164",
  )
  check_array_case(
    "array set a {};foreach k [list \"a\" \"i\" \"q\" \"y\" \"aa\" \"ai\" \"aq\" \"ay\"] {set a($k) $k};list [array names a] [array get a] [array statistics a]",
    "{y q i a ay aq ai aa} {y y q q i i a a ay ay aq aq ai ai aa aa} {8 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 2\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 2.5}",
    "", false, "key-representations-165",
  )
  check_array_case(
    "array set a {};foreach k [list \"a\" \"i\" \"q\" \"y\" \"aa\" \"ai\" \"aq\" \"ay\"] {set a($k) $k};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};set out",
    "y q i a ay aq ai aa", "", false, "key-cursor-166",
  )
  check_array_case(
    "array set a {};foreach k [list \"a\" \"i\" \"q\" \"y\" \"aa\" \"ai\" \"aq\" \"ay\"] {set a($k) $k};foreach k [list \"a\" \"q\" \"aa\" \"aq\"] {unset a($k);set a($k) newer};list [array names a] [array statistics a]",
    "{q a y i aq aa ay ai} {8 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 2\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 2.5}",
    "", false, "key-reinsert-167",
  )
  check_array_case(
    "array set a {};foreach k [list \"ay\" \"aq\" \"ai\" \"aa\" \"y\" \"q\" \"i\" \"a\"] {set a($k) $k};list [array names a] [array get a] [array statistics a]",
    "{a i q y aa ai aq ay} {a a i i q q y y aa aa ai ai aq aq ay ay} {8 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 2\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 2.5}",
    "", false, "key-representations-168",
  )
  check_array_case(
    "array set a {};foreach k [list \"ay\" \"aq\" \"ai\" \"aa\" \"y\" \"q\" \"i\" \"a\"] {set a($k) $k};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};set out",
    "a i q y aa ai aq ay", "", false, "key-cursor-169",
  )
  check_array_case(
    "array set a {};foreach k [list \"ay\" \"aq\" \"ai\" \"aa\" \"y\" \"q\" \"i\" \"a\"] {set a($k) $k};foreach k [list \"ay\" \"ai\" \"y\" \"i\"] {unset a($k);set a($k) newer};list [array names a] [array statistics a]",
    "{i y a q ai ay aa aq} {8 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 2\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 2.5}",
    "", false, "key-reinsert-170",
  )
  check_array_case(
    "array set a {};foreach k [list \"é\" \"中\" \"😀\" \"\\x00\" \"a\\x00b\" \"a\"] {set a($k) $k};list [array names a] [array get a] [array statistics a]",
    "{\u0000 é a 中 a\u0000b 😀} {\u0000 \u0000 é é a a 中 中 a\u0000b a\u0000b 😀 😀} {6 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 3\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.5}",
    "", false, "key-representations-171",
  )
  check_array_case(
    "array set a {};foreach k [list \"é\" \"中\" \"😀\" \"\\x00\" \"a\\x00b\" \"a\"] {set a($k) $k};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};set out",
    "\u0000 é a 中 a\u0000b 😀", "", false, "key-cursor-172",
  )
  check_array_case(
    "array set a {};foreach k [list \"é\" \"中\" \"😀\" \"\\x00\" \"a\\x00b\" \"a\"] {set a($k) $k};foreach k [list \"é\" \"😀\" \"a\\x00b\"] {unset a($k);set a($k) newer};list [array names a] [array statistics a]",
    "{é \u0000 a 中 a\u0000b 😀} {6 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 3\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.5}",
    "", false, "key-reinsert-173",
  )
  check_array_case(
    "array set a {};foreach k [list \"a\" \"a\\x00b\" \"\\x00\" \"😀\" \"中\" \"é\"] {set a($k) $k};list [array names a] [array get a] [array statistics a]",
    "{é \u0000 中 a 😀 a\u0000b} {é é \u0000 \u0000 中 中 a a 😀 😀 a\u0000b a\u0000b} {6 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 3\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.5}",
    "", false, "key-representations-174",
  )
  check_array_case(
    "array set a {};foreach k [list \"a\" \"a\\x00b\" \"\\x00\" \"😀\" \"中\" \"é\"] {set a($k) $k};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};set out",
    "é \u0000 中 a 😀 a\u0000b", "", false, "key-cursor-175",
  )
  check_array_case(
    "array set a {};foreach k [list \"a\" \"a\\x00b\" \"\\x00\" \"😀\" \"中\" \"é\"] {set a($k) $k};foreach k [list \"a\" \"\\x00\" \"中\"] {unset a($k);set a($k) newer};list [array names a] [array statistics a]",
    "{\u0000 é 中 a 😀 a\u0000b} {6 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 3\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.5}",
    "", false, "key-reinsert-176",
  )
  check_array_case(
    "array set a {};foreach k [list \"𐀀\" \"￿\" \"x\"] {set a($k) $k};list [array names a] [array get a] [array statistics a]",
    "{x 𐀀 ￿} {x x 𐀀 𐀀 ￿ ￿} {3 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.3}",
    "", false, "key-representations-177",
  )
  check_array_case(
    "array set a {};foreach k [list \"𐀀\" \"￿\" \"x\"] {set a($k) $k};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};set out",
    "x 𐀀 ￿", "", false, "key-cursor-178",
  )
  check_array_case(
    "array set a {};foreach k [list \"𐀀\" \"￿\" \"x\"] {set a($k) $k};foreach k [list \"𐀀\" \"x\"] {unset a($k);set a($k) newer};list [array names a] [array statistics a]",
    "{x 𐀀 ￿} {3 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.3}",
    "", false, "key-reinsert-179",
  )
  check_array_case(
    "array set a {};foreach k [list \"x\" \"￿\" \"𐀀\"] {set a($k) $k};list [array names a] [array get a] [array statistics a]",
    "{𐀀 x ￿} {𐀀 𐀀 x x ￿ ￿} {3 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.3}",
    "", false, "key-representations-180",
  )
  check_array_case(
    "array set a {};foreach k [list \"x\" \"￿\" \"𐀀\"] {set a($k) $k};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};set out",
    "𐀀 x ￿", "", false, "key-cursor-181",
  )
  check_array_case(
    "array set a {};foreach k [list \"x\" \"￿\" \"𐀀\"] {set a($k) $k};foreach k [list \"x\" \"𐀀\"] {unset a($k);set a($k) newer};list [array names a] [array statistics a]",
    "{𐀀 x ￿} {3 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.3}",
    "", false, "key-reinsert-182",
  )
  check_array_case(
    "array set a {};foreach k [list \"a\" \"aa\" \"aaa\" \"aaaa\" \"aaaaa\" \"aaaaaa\" \"aaaaaaa\" \"aaaaaaaa\" \"aaaaaaaaa\" \"aaaaaaaaaa\" \"aaaaaaaaaaa\" \"aaaaaaaaaaaa\" \"aaaaaaaaaaaaa\" \"aaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\"] {set a($k) $k};list [array names a] [array get a] [array statistics a]",
    "{aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaa a aaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaa aaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaa aaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaa aa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaa aaa aaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaa aaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaa aaaaaaa} {aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaa a a aaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaa aaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaa aaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaa aaaa aaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaa aaaaa aaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaa aaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaa aaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaa aaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaa aaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaa aa aa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaa aaa aaa aaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaa aaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaa aaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaa aaaaaa aaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaa aaaaaaa aaaaaaa} {39 entries in table, 16 buckets\nnumber of buckets with 0 entries: 0\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 9\nnumber of buckets with 3 entries: 7\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.8}",
    "", false, "key-representations-183",
  )
  check_array_case(
    "array set a {};foreach k [list \"a\" \"aa\" \"aaa\" \"aaaa\" \"aaaaa\" \"aaaaaa\" \"aaaaaaa\" \"aaaaaaaa\" \"aaaaaaaaa\" \"aaaaaaaaaa\" \"aaaaaaaaaaa\" \"aaaaaaaaaaaa\" \"aaaaaaaaaaaaa\" \"aaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\"] {set a($k) $k};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};set out",
    "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaa a aaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaa aaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaa aaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaa aa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaa aaa aaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaa aaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaa aaaaaaa",
    "", false, "key-cursor-184",
  )
  check_array_case(
    "array set a {};foreach k [list \"a\" \"aa\" \"aaa\" \"aaaa\" \"aaaaa\" \"aaaaaa\" \"aaaaaaa\" \"aaaaaaaa\" \"aaaaaaaaa\" \"aaaaaaaaaa\" \"aaaaaaaaaaa\" \"aaaaaaaaaaaa\" \"aaaaaaaaaaaaa\" \"aaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\"] {set a($k) $k};foreach k [list \"a\" \"aaa\" \"aaaaa\" \"aaaaaaa\" \"aaaaaaaaa\" \"aaaaaaaaaaa\" \"aaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\"] {unset a($k);set a($k) newer};list [array names a] [array statistics a]",
    "{aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaa a aaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaa aaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaa aaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaa aa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaa aaa aaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaa aaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaa aaaaaaa} {39 entries in table, 16 buckets\nnumber of buckets with 0 entries: 0\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 9\nnumber of buckets with 3 entries: 7\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.8}",
    "", false, "key-reinsert-185",
  )
  check_array_case(
    "array set a {};foreach k [list \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaa\" \"aaaaaaaaaaaaa\" \"aaaaaaaaaaaa\" \"aaaaaaaaaaa\" \"aaaaaaaaaa\" \"aaaaaaaaa\" \"aaaaaaaa\" \"aaaaaaa\" \"aaaaaa\" \"aaaaa\" \"aaaa\" \"aaa\" \"aa\" \"a\"] {set a($k) $k};list [array names a] [array get a] [array statistics a]",
    "{aaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa a aaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaa aaaa aaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaa aaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaa aa aaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaa aaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaa aaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaa aaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa} {aaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa a a aaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaa aaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaa aaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaa aaaa aaaa aaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaa aaaaa aaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaa aaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaa aaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaa aaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaa aaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaa aa aa aaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaa aaa aaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaa aaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaa aaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaa aaaaaa aaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaa aaaaaaa aaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa} {39 entries in table, 16 buckets\nnumber of buckets with 0 entries: 0\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 9\nnumber of buckets with 3 entries: 7\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.8}",
    "", false, "key-representations-186",
  )
  check_array_case(
    "array set a {};foreach k [list \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaa\" \"aaaaaaaaaaaaa\" \"aaaaaaaaaaaa\" \"aaaaaaaaaaa\" \"aaaaaaaaaa\" \"aaaaaaaaa\" \"aaaaaaaa\" \"aaaaaaa\" \"aaaaaa\" \"aaaaa\" \"aaaa\" \"aaa\" \"aa\" \"a\"] {set a($k) $k};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};set out",
    "aaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa a aaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaa aaaa aaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaa aaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaa aa aaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaa aaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaa aaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaa aaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
    "", false, "key-cursor-187",
  )
  check_array_case(
    "array set a {};foreach k [list \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaa\" \"aaaaaaaaaaaaa\" \"aaaaaaaaaaaa\" \"aaaaaaaaaaa\" \"aaaaaaaaaa\" \"aaaaaaaaa\" \"aaaaaaaa\" \"aaaaaaa\" \"aaaaaa\" \"aaaaa\" \"aaaa\" \"aaa\" \"aa\" \"a\"] {set a($k) $k};foreach k [list \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaaaa\" \"aaaaaaaaaaaaa\" \"aaaaaaaaaaa\" \"aaaaaaaaa\" \"aaaaaaa\" \"aaaaa\" \"aaa\" \"a\"] {unset a($k);set a($k) newer};list [array names a] [array statistics a]",
    "{aaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa a aaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaa aaaa aaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaa aaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaa aa aaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaa aaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaa aaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaa aaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa} {39 entries in table, 16 buckets\nnumber of buckets with 0 entries: 0\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 9\nnumber of buckets with 3 entries: 7\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.8}",
    "", false, "key-reinsert-188",
  )
  check_array_case(
    "array set a {};foreach k [list \"a b\" \"a(b)\" \"\\$x\" \"{\" \"\\\\\" \"\\n\"] {set a($k) $k};list [array names a] [array get a] [array statistics a]",
    "{\\\\ {$x} a(b) {\n} \\{ {a b}} {\\\\ \\\\ {$x} {$x} a(b) a(b) {\n} {\n} \\{ \\{ {a b} {a b}} {6 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 1\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.7}",
    "", false, "key-representations-189",
  )
  check_array_case(
    "array set a {};foreach k [list \"a b\" \"a(b)\" \"\\$x\" \"{\" \"\\\\\" \"\\n\"] {set a($k) $k};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};set out",
    "\\\\ {$x} a(b) {\n} \\{ {a b}", "", false, "key-cursor-190",
  )
  check_array_case(
    "array set a {};foreach k [list \"a b\" \"a(b)\" \"\\$x\" \"{\" \"\\\\\" \"\\n\"] {set a($k) $k};foreach k [list \"a b\" \"\\$x\" \"\\\\\"] {unset a($k);set a($k) newer};list [array names a] [array statistics a]",
    "{\\\\ {$x} a(b) {\n} {a b} \\{} {6 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 1\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.7}",
    "", false, "key-reinsert-191",
  )
  check_array_case(
    "array set a {};foreach k [list \"\\n\" \"\\\\\" \"{\" \"\\$x\" \"a(b)\" \"a b\"] {set a($k) $k};list [array names a] [array get a] [array statistics a]",
    "{a(b) {$x} \\\\ {\n} {a b} \\{} {a(b) a(b) {$x} {$x} \\\\ \\\\ {\n} {\n} {a b} {a b} \\{ \\{} {6 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 1\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.7}",
    "", false, "key-representations-192",
  )
  check_array_case(
    "array set a {};foreach k [list \"\\n\" \"\\\\\" \"{\" \"\\$x\" \"a(b)\" \"a b\"] {set a($k) $k};set s [array startsearch a];set out {};while {[array anymore a $s]} {lappend out [array nextelement a $s]};set out",
    "a(b) {$x} \\\\ {\n} {a b} \\{", "", false, "key-cursor-193",
  )
  check_array_case(
    "array set a {};foreach k [list \"\\n\" \"\\\\\" \"{\" \"\\$x\" \"a(b)\" \"a b\"] {set a($k) $k};foreach k [list \"\\n\" \"{\" \"a(b)\"] {unset a($k);set a($k) newer};list [array names a] [array statistics a]",
    "{a(b) {$x} \\\\ {\n} \\{ {a b}} {6 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 1\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.7}",
    "", false, "key-reinsert-194",
  )
  check_array_case(
    "array set a {};set x [array startsearch a];set y [array startsearch a];array donesearch a $y;set z [array startsearch a];array donesearch a $x;array donesearch a $z;list $x $y $z [array startsearch a]",
    "s-1-a s-2-a s-2-a s-1-a", "", false, "lifecycle-195",
  )
  check_array_case(
    "array set a {x 1};set x [array startsearch a];set y [array startsearch a];list [array nextelement a $x] [array nextelement a $y] [array anymore a $x] [array anymore a $y]",
    "x x 0 0", "", false, "lifecycle-196",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];list [array anymore a $s] [array anymore a $s] [array nextelement a $s] [array anymore a $s] [array nextelement a $s] [array nextelement a $s]",
    "1 1 x 0 {} {}", "", false, "lifecycle-197",
  )
  check_array_case(
    "array set a {x 1};array set b {};list [array startsearch a] [array startsearch b]",
    "s-1-a s-1-b", "", false, "lifecycle-198",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];set a(x) 2;set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "0 1 0 s-2-a", "", false, "mutation-199",
  )
}

///|
test "Tcl array cases 201 through 240" {
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array anymore a $s;set a(x) 2;set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "0 1 0 s-2-a", "", false, "mutation-200",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array nextelement a $s;set a(x) 2;set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "0 0 0 s-2-a", "", false, "mutation-201",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array set a {x 3};set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "0 1 0 s-2-a", "", false, "mutation-202",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array anymore a $s;array set a {x 3};set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "0 1 0 s-2-a", "", false, "mutation-203",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array nextelement a $s;array set a {x 3};set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "0 0 0 s-2-a", "", false, "mutation-204",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];incr a(x);set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "0 1 0 s-2-a", "", false, "mutation-205",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array anymore a $s;incr a(x);set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "0 1 0 s-2-a", "", false, "mutation-206",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array nextelement a $s;incr a(x);set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "0 0 0 s-2-a", "", false, "mutation-207",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];append a(x) suffix;set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "0 1 0 s-2-a", "", false, "mutation-208",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array anymore a $s;append a(x) suffix;set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "0 1 0 s-2-a", "", false, "mutation-209",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array nextelement a $s;append a(x) suffix;set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "0 0 0 s-2-a", "", false, "mutation-210",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];lappend a(x) extra;set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "0 1 0 s-2-a", "", false, "mutation-211",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array anymore a $s;lappend a(x) extra;set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "0 1 0 s-2-a", "", false, "mutation-212",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array nextelement a $s;lappend a(x) extra;set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "0 0 0 s-2-a", "", false, "mutation-213",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array set a {};set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "0 1 0 s-2-a", "", false, "mutation-214",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array anymore a $s;array set a {};set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "0 1 0 s-2-a", "", false, "mutation-215",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array nextelement a $s;array set a {};set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "0 0 0 s-2-a", "", false, "mutation-216",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];set a(y) 2;set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "1 {couldn't find search \"s-1-a\"} 1 s-1-a", "", false, "mutation-217",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array anymore a $s;set a(y) 2;set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "1 {couldn't find search \"s-1-a\"} 1 s-1-a", "", false, "mutation-218",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array nextelement a $s;set a(y) 2;set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "1 {couldn't find search \"s-1-a\"} 1 s-1-a", "", false, "mutation-219",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];unset a(x);set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "1 {couldn't find search \"s-1-a\"} 1 s-1-a", "", false, "mutation-220",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array anymore a $s;unset a(x);set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "1 {couldn't find search \"s-1-a\"} 1 s-1-a", "", false, "mutation-221",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array nextelement a $s;unset a(x);set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "1 {couldn't find search \"s-1-a\"} 1 s-1-a", "", false, "mutation-222",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];unset -nocomplain a(no);set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "0 1 0 s-2-a", "", false, "mutation-223",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array anymore a $s;unset -nocomplain a(no);set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "0 1 0 s-2-a", "", false, "mutation-224",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array nextelement a $s;unset -nocomplain a(no);set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "0 0 0 s-2-a", "", false, "mutation-225",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array unset a no*;set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "0 1 0 s-2-a", "", false, "mutation-226",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array anymore a $s;array unset a no*;set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "0 1 0 s-2-a", "", false, "mutation-227",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array nextelement a $s;array unset a no*;set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "0 0 0 s-2-a", "", false, "mutation-228",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array unset a x;set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "1 {couldn't find search \"s-1-a\"} 1 s-1-a", "", false, "mutation-229",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array anymore a $s;array unset a x;set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "1 {couldn't find search \"s-1-a\"} 1 s-1-a", "", false, "mutation-230",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array nextelement a $s;array unset a x;set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "1 {couldn't find search \"s-1-a\"} 1 s-1-a", "", false, "mutation-231",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array unset a *;set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "1 {couldn't find search \"s-1-a\"} 1 s-1-a", "", false, "mutation-232",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array anymore a $s;array unset a *;set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "1 {couldn't find search \"s-1-a\"} 1 s-1-a", "", false, "mutation-233",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array nextelement a $s;array unset a *;set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "1 {couldn't find search \"s-1-a\"} 1 s-1-a", "", false, "mutation-234",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];unset a;array set a {x 2};set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "1 {couldn't find search \"s-1-a\"} 1 s-1-a", "", false, "mutation-235",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array anymore a $s;unset a;array set a {x 2};set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "1 {couldn't find search \"s-1-a\"} 1 s-1-a", "", false, "mutation-236",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array nextelement a $s;unset a;array set a {x 2};set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "1 {couldn't find search \"s-1-a\"} 1 s-1-a", "", false, "mutation-237",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array unset a;array set a {x 2};set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "1 {couldn't find search \"s-1-a\"} 1 s-1-a", "", false, "mutation-238",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array anymore a $s;array unset a;array set a {x 2};set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "1 {couldn't find search \"s-1-a\"} 1 s-1-a", "", false, "mutation-239",
  )
}

///|
test "Tcl array cases 241 through 280" {
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array nextelement a $s;array unset a;array set a {x 2};set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "1 {couldn't find search \"s-1-a\"} 1 s-1-a", "", false, "mutation-240",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array get a;set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "0 1 0 s-2-a", "", false, "mutation-241",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array anymore a $s;array get a;set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "0 1 0 s-2-a", "", false, "mutation-242",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array nextelement a $s;array get a;set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "0 0 0 s-2-a", "", false, "mutation-243",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array names a;set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "0 1 0 s-2-a", "", false, "mutation-244",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array anymore a $s;array names a;set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "0 1 0 s-2-a", "", false, "mutation-245",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array nextelement a $s;array names a;set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "0 0 0 s-2-a", "", false, "mutation-246",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array statistics a;set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "0 1 0 s-2-a", "", false, "mutation-247",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array anymore a $s;array statistics a;set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "0 1 0 s-2-a", "", false, "mutation-248",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];array nextelement a $s;array statistics a;set c [catch {array anymore a $s} r o];list $c $r [dict get $o -code] [array startsearch a]",
    "0 0 0 s-2-a", "", false, "mutation-249",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];upvar #0 a(x) b;set c [catch {array anymore a $s} r];list $c $r [array names a] [array statistics a]",
    "0 1 x {1 entries in table, 4 buckets\nnumber of buckets with 0 entries: 3\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "alias-mutation-250",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];upvar #0 a(x) b;set b 2;set c [catch {array anymore a $s} r];list $c $r [array names a] [array statistics a]",
    "0 1 x {1 entries in table, 4 buckets\nnumber of buckets with 0 entries: 3\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "alias-mutation-251",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];upvar #0 a(x) b;unset -nocomplain b;set c [catch {array anymore a $s} r];list $c $r [array names a] [array statistics a]",
    "0 0 {} {1 entries in table, 4 buckets\nnumber of buckets with 0 entries: 3\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "alias-mutation-252",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];upvar #0 a(x) b;unset -nocomplain a(x);set c [catch {array anymore a $s} r];list $c $r [array names a] [array statistics a]",
    "1 {couldn't find search \"s-1-a\"} {} {1 entries in table, 4 buckets\nnumber of buckets with 0 entries: 3\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "alias-mutation-253",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];proc p {} {upvar #0 a(x) b};p;set c [catch {array anymore a $s} r];list $c $r [array names a] [array statistics a]",
    "0 1 x {1 entries in table, 4 buckets\nnumber of buckets with 0 entries: 3\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "alias-mutation-254",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];upvar #0 a(z) b;set c [catch {array anymore a $s} r];list $c $r [array names a] [array statistics a]",
    "1 {couldn't find search \"s-1-a\"} x {2 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 2\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "alias-mutation-255",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];upvar #0 a(z) b;set b 2;set c [catch {array anymore a $s} r];list $c $r [array names a] [array statistics a]",
    "1 {couldn't find search \"s-1-a\"} {x z} {2 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 2\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "alias-mutation-256",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];upvar #0 a(z) b;unset -nocomplain b;set c [catch {array anymore a $s} r];list $c $r [array names a] [array statistics a]",
    "1 {couldn't find search \"s-1-a\"} x {2 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 2\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "alias-mutation-257",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];upvar #0 a(z) b;unset -nocomplain a(z);set c [catch {array anymore a $s} r];list $c $r [array names a] [array statistics a]",
    "1 {couldn't find search \"s-1-a\"} x {2 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 2\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "alias-mutation-258",
  )
  check_array_case(
    "array set a {x 1};set s [array startsearch a];proc p {} {upvar #0 a(z) b};p;set c [catch {array anymore a $s} r];list $c $r [array names a] [array statistics a]",
    "1 {couldn't find search \"s-1-a\"} x {1 entries in table, 4 buckets\nnumber of buckets with 0 entries: 3\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "alias-mutation-259",
  )
  check_array_case(
    "array set a {x 1};upvar #0 a b;set s [array startsearch a];set code [catch \"array anymore a \\$s\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 1 0 {}", "", false, "alias-spelling-260",
  )
  check_array_case(
    "array set a {x 1};upvar #0 a b;set s [array startsearch a];set code [catch \"array anymore ::a \\$s\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {search identifier \"s-1-a\" isn't for variable \"::a\"} 0 {TCL LOOKUP ARRAYSEARCH s-1-a}",
    "", false, "alias-spelling-261",
  )
  check_array_case(
    "array set a {x 1};upvar #0 a b;set s [array startsearch a];set code [catch \"array anymore b \\$s\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {search identifier \"s-1-a\" isn't for variable \"b\"} 0 {TCL LOOKUP ARRAYSEARCH s-1-a}",
    "", false, "alias-spelling-262",
  )
  check_array_case(
    "array set a {x 1};upvar #0 a b;set s [array startsearch a];set code [catch \"array anymore ::b \\$s\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {search identifier \"s-1-a\" isn't for variable \"::b\"} 0 {TCL LOOKUP ARRAYSEARCH s-1-a}",
    "", false, "alias-spelling-263",
  )
  check_array_case(
    "array set a {x 1};upvar #0 a b;set s [array startsearch ::a];set code [catch \"array anymore a \\$s\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {search identifier \"s-1-::a\" isn't for variable \"a\"} 0 {TCL LOOKUP ARRAYSEARCH s-1-::a}",
    "", false, "alias-spelling-264",
  )
  check_array_case(
    "array set a {x 1};upvar #0 a b;set s [array startsearch ::a];set code [catch \"array anymore ::a \\$s\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 1 0 {}", "", false, "alias-spelling-265",
  )
  check_array_case(
    "array set a {x 1};upvar #0 a b;set s [array startsearch ::a];set code [catch \"array anymore b \\$s\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {search identifier \"s-1-::a\" isn't for variable \"b\"} 0 {TCL LOOKUP ARRAYSEARCH s-1-::a}",
    "", false, "alias-spelling-266",
  )
  check_array_case(
    "array set a {x 1};upvar #0 a b;set s [array startsearch ::a];set code [catch \"array anymore ::b \\$s\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {search identifier \"s-1-::a\" isn't for variable \"::b\"} 0 {TCL LOOKUP ARRAYSEARCH s-1-::a}",
    "", false, "alias-spelling-267",
  )
  check_array_case(
    "array set a {x 1};upvar #0 a b;set s [array startsearch b];set code [catch \"array anymore a \\$s\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {search identifier \"s-1-b\" isn't for variable \"a\"} 0 {TCL LOOKUP ARRAYSEARCH s-1-b}",
    "", false, "alias-spelling-268",
  )
  check_array_case(
    "array set a {x 1};upvar #0 a b;set s [array startsearch b];set code [catch \"array anymore ::a \\$s\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {search identifier \"s-1-b\" isn't for variable \"::a\"} 0 {TCL LOOKUP ARRAYSEARCH s-1-b}",
    "", false, "alias-spelling-269",
  )
  check_array_case(
    "array set a {x 1};upvar #0 a b;set s [array startsearch b];set code [catch \"array anymore b \\$s\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 1 0 {}", "", false, "alias-spelling-270",
  )
  check_array_case(
    "array set a {x 1};upvar #0 a b;set s [array startsearch b];set code [catch \"array anymore ::b \\$s\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {search identifier \"s-1-b\" isn't for variable \"::b\"} 0 {TCL LOOKUP ARRAYSEARCH s-1-b}",
    "", false, "alias-spelling-271",
  )
  check_array_case(
    "array set a {x 1};upvar #0 a b;set s [array startsearch ::b];set code [catch \"array anymore a \\$s\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {search identifier \"s-1-::b\" isn't for variable \"a\"} 0 {TCL LOOKUP ARRAYSEARCH s-1-::b}",
    "", false, "alias-spelling-272",
  )
  check_array_case(
    "array set a {x 1};upvar #0 a b;set s [array startsearch ::b];set code [catch \"array anymore ::a \\$s\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {search identifier \"s-1-::b\" isn't for variable \"::a\"} 0 {TCL LOOKUP ARRAYSEARCH s-1-::b}",
    "", false, "alias-spelling-273",
  )
  check_array_case(
    "array set a {x 1};upvar #0 a b;set s [array startsearch ::b];set code [catch \"array anymore b \\$s\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {search identifier \"s-1-::b\" isn't for variable \"b\"} 0 {TCL LOOKUP ARRAYSEARCH s-1-::b}",
    "", false, "alias-spelling-274",
  )
  check_array_case(
    "array set a {x 1};upvar #0 a b;set s [array startsearch ::b];set code [catch \"array anymore ::b \\$s\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 1 0 {}", "", false, "alias-spelling-275",
  )
  check_array_case(
    "array set a {x 1};upvar #0 a b;array startsearch a;array anymore b s-1-b", "1",
    "", false, "alias-lifetime-276",
  )
  check_array_case(
    "array set a {};upvar #0 a(x) b;list [array names a] [array size a] [array statistics a]",
    "{} 0 {1 entries in table, 4 buckets\nnumber of buckets with 0 entries: 3\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "alias-lifetime-277",
  )
  check_array_case(
    "array set a {x 1};upvar #0 a(x) b;unset b;list [array names a] [array statistics a]",
    "{} {1 entries in table, 4 buckets\nnumber of buckets with 0 entries: 3\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "alias-lifetime-278",
  )
  check_array_case(
    "array set a {x 1};upvar #0 a(x) b;unset a;array set a {x 2};list [catch {set b} r] $r [catch {set b 3} r] $r $a(x)",
    "1 {can't read \"b\": no such variable} 1 {can't set \"b\": upvar refers to element in deleted array} 2",
    "", false, "alias-lifetime-279",
  )
}

///|
test "Tcl array cases 281 through 320" {
  check_array_case(
    "array set a {x 1};upvar #0 a(z) b;set s [array startsearch a];set b 2;list [array anymore a $s] [array names a]",
    "1 {x z}", "", false, "alias-lifetime-280",
  )
  check_array_case(
    "array set a {x 1};upvar #0 a(z) b;set s [array startsearch a];unset -nocomplain b;list [catch {array anymore a $s} r] $r",
    "0 1", "", false, "alias-lifetime-281",
  )
  check_array_case(
    "array set a {x 1};proc p {} {upvar #0 a(z) b;return done};list [p] [array statistics a]",
    "done {1 entries in table, 4 buckets\nnumber of buckets with 0 entries: 3\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "alias-lifetime-282",
  )
  check_array_case(
    "array set a {x 1};proc p {} {upvar #0 a(z) b;error fail};list [catch {p}] [array statistics a]",
    "1 {1 entries in table, 4 buckets\nnumber of buckets with 0 entries: 3\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "alias-lifetime-283",
  )
  check_array_case(
    "array set a {x 1};upvar #0 a(z) b;upvar #0 a(x) b;list $b [array statistics a]",
    "1 {1 entries in table, 4 buckets\nnumber of buckets with 0 entries: 3\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "alias-lifetime-284",
  )
  check_array_case(
    "array set a {};proc p {} {upvar #0 a(x) b;upvar #0 a(x) c;set b 2};p;list [array names a] [array get a] [array statistics a]",
    "x {x 2} {1 entries in table, 4 buckets\nnumber of buckets with 0 entries: 3\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "alias-lifetime-285",
  )
  check_array_case(
    "namespace eval n {array set a {x 1}};upvar #0 n::a b;set s [array startsearch b];namespace delete n;list [array exists b] [catch {array anymore b $s}]",
    "0 1", "", false, "alias-lifetime-286",
  )
  check_array_case(
    "array set a {x 1};namespace eval n {upvar #0 a(z) b};namespace delete n;array statistics a",
    "1 entries in table, 4 buckets\nnumber of buckets with 0 entries: 3\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0",
    "", false, "alias-lifetime-287",
  )
  check_array_case(
    "proc p {} {array set a {x 1};namespace eval n {upvar 1 a b}};p;array exists n::b",
    "bad variable name \"b\": can't create namespace variable that refers to procedure variable",
    "", true, "alias-lifetime-288",
  )
  check_array_case(
    "namespace eval n {variable a;array set a {x 1};proc p {} {variable a;set s [array startsearch a];list $s [array nextelement a $s]}};n::p",
    "s-1-a x", "", false, "alias-lifetime-289",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array anymore a \\\"\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {illegal search identifier \"\"} 0 {TCL LOOKUP ARRAYSEARCH {}}", "", false,
    "handle-290",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array nextelement a \\\"\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {illegal search identifier \"\"} 0 {TCL LOOKUP ARRAYSEARCH {}}", "", false,
    "handle-291",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array donesearch a \\\"\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {illegal search identifier \"\"} 0 {TCL LOOKUP ARRAYSEARCH {}}", "", false,
    "handle-292",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array anymore a \\\"s-\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {illegal search identifier \"s-\"} 0 {TCL LOOKUP ARRAYSEARCH s-}", "", false,
    "handle-293",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array nextelement a \\\"s-\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {illegal search identifier \"s-\"} 0 {TCL LOOKUP ARRAYSEARCH s-}", "", false,
    "handle-294",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array donesearch a \\\"s-\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {illegal search identifier \"s-\"} 0 {TCL LOOKUP ARRAYSEARCH s-}", "", false,
    "handle-295",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array anymore a \\\"s-0-a\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {couldn't find search \"s-0-a\"} 0 {TCL LOOKUP ARRAYSEARCH s-0-a}", "", false,
    "handle-296",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array nextelement a \\\"s-0-a\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {couldn't find search \"s-0-a\"} 0 {TCL LOOKUP ARRAYSEARCH s-0-a}", "", false,
    "handle-297",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array donesearch a \\\"s-0-a\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {couldn't find search \"s-0-a\"} 0 {TCL LOOKUP ARRAYSEARCH s-0-a}", "", false,
    "handle-298",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array anymore a \\\"s-1-a\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 1 0 {}", "", false, "handle-299",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array nextelement a \\\"s-1-a\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 x 0 {}", "", false, "handle-300",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array donesearch a \\\"s-1-a\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "handle-301",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array anymore a \\\"s-01-a\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 1 0 {}", "", false, "handle-302",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array nextelement a \\\"s-01-a\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 x 0 {}", "", false, "handle-303",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array donesearch a \\\"s-01-a\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "handle-304",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array anymore a \\\"s-+1-a\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 1 0 {}", "", false, "handle-305",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array nextelement a \\\"s-+1-a\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 x 0 {}", "", false, "handle-306",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array donesearch a \\\"s-+1-a\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "handle-307",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array anymore a \\\"s- 1-a\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 1 0 {}", "", false, "handle-308",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array nextelement a \\\"s- 1-a\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 x 0 {}", "", false, "handle-309",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array donesearch a \\\"s- 1-a\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "handle-310",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array anymore a \\\"s-\\\\t1-a\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 1 0 {}", "", false, "handle-311",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array nextelement a \\\"s-\\\\t1-a\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 x 0 {}", "", false, "handle-312",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array donesearch a \\\"s-\\\\t1-a\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "handle-313",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array anymore a \\\"s-0x1-a\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {illegal search identifier \"s-0x1-a\"} 0 {TCL LOOKUP ARRAYSEARCH s-0x1-a}",
    "", false, "handle-314",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array nextelement a \\\"s-0x1-a\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {illegal search identifier \"s-0x1-a\"} 0 {TCL LOOKUP ARRAYSEARCH s-0x1-a}",
    "", false, "handle-315",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array donesearch a \\\"s-0x1-a\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {illegal search identifier \"s-0x1-a\"} 0 {TCL LOOKUP ARRAYSEARCH s-0x1-a}",
    "", false, "handle-316",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array anymore a \\\"s--1-a\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {couldn't find search \"s--1-a\"} 0 {TCL LOOKUP ARRAYSEARCH s--1-a}", "",
    false, "handle-317",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array nextelement a \\\"s--1-a\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {couldn't find search \"s--1-a\"} 0 {TCL LOOKUP ARRAYSEARCH s--1-a}", "",
    false, "handle-318",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array donesearch a \\\"s--1-a\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {couldn't find search \"s--1-a\"} 0 {TCL LOOKUP ARRAYSEARCH s--1-a}", "",
    false, "handle-319",
  )
}

///|
test "Tcl array cases 321 through 360" {
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array anymore a \\\"s--4294967295-a\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 1 0 {}", "", false, "handle-320",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array nextelement a \\\"s--4294967295-a\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 x 0 {}", "", false, "handle-321",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array donesearch a \\\"s--4294967295-a\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "handle-322",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array anymore a \\\"s-4294967297-a\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {couldn't find search \"s-4294967297-a\"} 0 {TCL LOOKUP ARRAYSEARCH s-4294967297-a}",
    "", false, "handle-323",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array nextelement a \\\"s-4294967297-a\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {couldn't find search \"s-4294967297-a\"} 0 {TCL LOOKUP ARRAYSEARCH s-4294967297-a}",
    "", false, "handle-324",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array donesearch a \\\"s-4294967297-a\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {couldn't find search \"s-4294967297-a\"} 0 {TCL LOOKUP ARRAYSEARCH s-4294967297-a}",
    "", false, "handle-325",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array anymore a \\\"s-18446744073709551617-a\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {couldn't find search \"s-18446744073709551617-a\"} 0 {TCL LOOKUP ARRAYSEARCH s-18446744073709551617-a}",
    "", false, "handle-326",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array nextelement a \\\"s-18446744073709551617-a\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {couldn't find search \"s-18446744073709551617-a\"} 0 {TCL LOOKUP ARRAYSEARCH s-18446744073709551617-a}",
    "", false, "handle-327",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array donesearch a \\\"s-18446744073709551617-a\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {couldn't find search \"s-18446744073709551617-a\"} 0 {TCL LOOKUP ARRAYSEARCH s-18446744073709551617-a}",
    "", false, "handle-328",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array anymore a \\\"s-1-b\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {search identifier \"s-1-b\" isn't for variable \"a\"} 0 {TCL LOOKUP ARRAYSEARCH s-1-b}",
    "", false, "handle-329",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array nextelement a \\\"s-1-b\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {search identifier \"s-1-b\" isn't for variable \"a\"} 0 {TCL LOOKUP ARRAYSEARCH s-1-b}",
    "", false, "handle-330",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array donesearch a \\\"s-1-b\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {search identifier \"s-1-b\" isn't for variable \"a\"} 0 {TCL LOOKUP ARRAYSEARCH s-1-b}",
    "", false, "handle-331",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array anymore a \\\"bogus\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {illegal search identifier \"bogus\"} 0 {TCL LOOKUP ARRAYSEARCH bogus}", "",
    false, "handle-332",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array nextelement a \\\"bogus\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {illegal search identifier \"bogus\"} 0 {TCL LOOKUP ARRAYSEARCH bogus}", "",
    false, "handle-333",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array donesearch a \\\"bogus\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {illegal search identifier \"bogus\"} 0 {TCL LOOKUP ARRAYSEARCH bogus}", "",
    false, "handle-334",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array anymore a \\\"s-1-a\\\\x00junk\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {search identifier \"s-1-a\u0000junk\" isn't for variable \"a\"} 0 {TCL LOOKUP ARRAYSEARCH s-1-a\u0000junk}",
    "", false, "handle-335",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array nextelement a \\\"s-1-a\\\\x00junk\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {search identifier \"s-1-a\u0000junk\" isn't for variable \"a\"} 0 {TCL LOOKUP ARRAYSEARCH s-1-a\u0000junk}",
    "", false, "handle-336",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array donesearch a \\\"s-1-a\\\\x00junk\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {search identifier \"s-1-a\u0000junk\" isn't for variable \"a\"} 0 {TCL LOOKUP ARRAYSEARCH s-1-a\u0000junk}",
    "", false, "handle-337",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array anymore a \\\"s-1-a-extra\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {search identifier \"s-1-a-extra\" isn't for variable \"a\"} 0 {TCL LOOKUP ARRAYSEARCH s-1-a-extra}",
    "", false, "handle-338",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array nextelement a \\\"s-1-a-extra\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {search identifier \"s-1-a-extra\" isn't for variable \"a\"} 0 {TCL LOOKUP ARRAYSEARCH s-1-a-extra}",
    "", false, "handle-339",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array donesearch a \\\"s-1-a-extra\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {search identifier \"s-1-a-extra\" isn't for variable \"a\"} 0 {TCL LOOKUP ARRAYSEARCH s-1-a-extra}",
    "", false, "handle-340",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-341",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-342",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-343",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-344",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"a\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array anymore arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-345",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"a\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array anymore arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-346",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"a\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 1 0 {}", "", false, "prefix-arity-347",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"a\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array anymore arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-348",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"an\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array anymore arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-349",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"an\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array anymore arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-350",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"an\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 1 0 {}", "", false, "prefix-arity-351",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"an\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array anymore arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-352",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"any\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array anymore arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-353",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"any\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array anymore arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-354",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"any\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 1 0 {}", "", false, "prefix-arity-355",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"any\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array anymore arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-356",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"anym\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array anymore arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-357",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"anym\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array anymore arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-358",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"anym\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 1 0 {}", "", false, "prefix-arity-359",
  )
}

///|
test "Tcl array cases 361 through 400" {
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"anym\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array anymore arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-360",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"anymo\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array anymore arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-361",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"anymo\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array anymore arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-362",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"anymo\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 1 0 {}", "", false, "prefix-arity-363",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"anymo\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array anymore arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-364",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"anymor\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array anymore arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-365",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"anymor\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array anymore arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-366",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"anymor\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 1 0 {}", "", false, "prefix-arity-367",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"anymor\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array anymore arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-368",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"anymore\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array anymore arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-369",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"anymore\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array anymore arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-370",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"anymore\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 1 0 {}", "", false, "prefix-arity-371",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"anymore\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array anymore arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-372",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-373",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-374",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-375",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-376",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"d\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array donesearch arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-377",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"d\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array donesearch arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-378",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"d\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "prefix-arity-379",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"d\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array donesearch arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-380",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"do\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array donesearch arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-381",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"do\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array donesearch arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-382",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"do\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "prefix-arity-383",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"do\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array donesearch arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-384",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"don\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array donesearch arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-385",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"don\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array donesearch arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-386",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"don\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "prefix-arity-387",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"don\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array donesearch arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-388",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"done\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array donesearch arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-389",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"done\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array donesearch arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-390",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"done\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "prefix-arity-391",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"done\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array donesearch arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-392",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"dones\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array donesearch arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-393",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"dones\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array donesearch arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-394",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"dones\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "prefix-arity-395",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"dones\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array donesearch arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-396",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"donese\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array donesearch arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-397",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"donese\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array donesearch arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-398",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"donese\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "prefix-arity-399",
  )
}

///|
test "Tcl array cases 401 through 440" {
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"donese\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array donesearch arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-400",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"donesea\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array donesearch arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-401",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"donesea\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array donesearch arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-402",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"donesea\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "prefix-arity-403",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"donesea\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array donesearch arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-404",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"donesear\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array donesearch arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-405",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"donesear\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array donesearch arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-406",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"donesear\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "prefix-arity-407",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"donesear\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array donesearch arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-408",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"donesearc\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array donesearch arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-409",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"donesearc\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array donesearch arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-410",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"donesearc\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "prefix-arity-411",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"donesearc\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array donesearch arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-412",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"donesearch\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array donesearch arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-413",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"donesearch\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array donesearch arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-414",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"donesearch\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "prefix-arity-415",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"donesearch\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array donesearch arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-416",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-417",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-418",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-419",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-420",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"e\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array exists arrayName\"} 0 {TCL WRONGARGS}", "",
    false, "prefix-arity-421",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"e\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 1 0 {}", "", false, "prefix-arity-422",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"e\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array exists arrayName\"} 0 {TCL WRONGARGS}", "",
    false, "prefix-arity-423",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"e\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array exists arrayName\"} 0 {TCL WRONGARGS}", "",
    false, "prefix-arity-424",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"ex\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array exists arrayName\"} 0 {TCL WRONGARGS}", "",
    false, "prefix-arity-425",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"ex\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 1 0 {}", "", false, "prefix-arity-426",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"ex\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array exists arrayName\"} 0 {TCL WRONGARGS}", "",
    false, "prefix-arity-427",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"ex\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array exists arrayName\"} 0 {TCL WRONGARGS}", "",
    false, "prefix-arity-428",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"exi\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array exists arrayName\"} 0 {TCL WRONGARGS}", "",
    false, "prefix-arity-429",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"exi\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 1 0 {}", "", false, "prefix-arity-430",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"exi\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array exists arrayName\"} 0 {TCL WRONGARGS}", "",
    false, "prefix-arity-431",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"exi\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array exists arrayName\"} 0 {TCL WRONGARGS}", "",
    false, "prefix-arity-432",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"exis\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array exists arrayName\"} 0 {TCL WRONGARGS}", "",
    false, "prefix-arity-433",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"exis\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 1 0 {}", "", false, "prefix-arity-434",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"exis\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array exists arrayName\"} 0 {TCL WRONGARGS}", "",
    false, "prefix-arity-435",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"exis\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array exists arrayName\"} 0 {TCL WRONGARGS}", "",
    false, "prefix-arity-436",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"exist\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array exists arrayName\"} 0 {TCL WRONGARGS}", "",
    false, "prefix-arity-437",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"exist\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 1 0 {}", "", false, "prefix-arity-438",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"exist\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array exists arrayName\"} 0 {TCL WRONGARGS}", "",
    false, "prefix-arity-439",
  )
}

///|
test "Tcl array cases 441 through 480" {
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"exist\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array exists arrayName\"} 0 {TCL WRONGARGS}", "",
    false, "prefix-arity-440",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"exists\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array exists arrayName\"} 0 {TCL WRONGARGS}", "",
    false, "prefix-arity-441",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"exists\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 1 0 {}", "", false, "prefix-arity-442",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"exists\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array exists arrayName\"} 0 {TCL WRONGARGS}", "",
    false, "prefix-arity-443",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"exists\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array exists arrayName\"} 0 {TCL WRONGARGS}", "",
    false, "prefix-arity-444",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-445",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-446",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-447",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-448",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"g\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array get arrayName ?pattern?\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-449",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"g\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {x 1} 0 {}", "", false, "prefix-arity-450",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"g\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "prefix-arity-451",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"g\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array get arrayName ?pattern?\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-452",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"ge\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array get arrayName ?pattern?\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-453",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"ge\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {x 1} 0 {}", "", false, "prefix-arity-454",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"ge\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "prefix-arity-455",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"ge\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array get arrayName ?pattern?\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-456",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"get\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array get arrayName ?pattern?\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-457",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"get\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {x 1} 0 {}", "", false, "prefix-arity-458",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"get\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "prefix-arity-459",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"get\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array get arrayName ?pattern?\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-460",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-461",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-462",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-463",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-464",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"n\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"n\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND n}",
    "", false, "prefix-arity-465",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"n\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"n\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND n}",
    "", false, "prefix-arity-466",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"n\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"n\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND n}",
    "", false, "prefix-arity-467",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"n\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"n\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND n}",
    "", false, "prefix-arity-468",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"na\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array names arrayName ?mode? ?pattern?\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-469",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"na\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 x 0 {}", "", false, "prefix-arity-470",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"na\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "prefix-arity-471",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"na\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {bad option \"s-1-a\": must be -exact, -glob, or -regexp} 0 {TCL LOOKUP INDEX option s-1-a}",
    "", false, "prefix-arity-472",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"nam\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array names arrayName ?mode? ?pattern?\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-473",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"nam\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 x 0 {}", "", false, "prefix-arity-474",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"nam\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "prefix-arity-475",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"nam\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {bad option \"s-1-a\": must be -exact, -glob, or -regexp} 0 {TCL LOOKUP INDEX option s-1-a}",
    "", false, "prefix-arity-476",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"name\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array names arrayName ?mode? ?pattern?\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-477",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"name\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 x 0 {}", "", false, "prefix-arity-478",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"name\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "prefix-arity-479",
  )
}

///|
test "Tcl array cases 481 through 520" {
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"name\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {bad option \"s-1-a\": must be -exact, -glob, or -regexp} 0 {TCL LOOKUP INDEX option s-1-a}",
    "", false, "prefix-arity-480",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"names\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array names arrayName ?mode? ?pattern?\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-481",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"names\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 x 0 {}", "", false, "prefix-arity-482",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"names\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "prefix-arity-483",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"names\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {bad option \"s-1-a\": must be -exact, -glob, or -regexp} 0 {TCL LOOKUP INDEX option s-1-a}",
    "", false, "prefix-arity-484",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-485",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-486",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-487",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-488",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"n\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"n\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND n}",
    "", false, "prefix-arity-489",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"n\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"n\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND n}",
    "", false, "prefix-arity-490",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"n\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"n\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND n}",
    "", false, "prefix-arity-491",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"n\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"n\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND n}",
    "", false, "prefix-arity-492",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"ne\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array nextelement arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-493",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"ne\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array nextelement arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-494",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"ne\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 x 0 {}", "", false, "prefix-arity-495",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"ne\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array nextelement arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-496",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"nex\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array nextelement arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-497",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"nex\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array nextelement arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-498",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"nex\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 x 0 {}", "", false, "prefix-arity-499",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"nex\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array nextelement arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-500",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"next\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array nextelement arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-501",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"next\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array nextelement arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-502",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"next\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 x 0 {}", "", false, "prefix-arity-503",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"next\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array nextelement arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-504",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"nexte\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array nextelement arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-505",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"nexte\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array nextelement arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-506",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"nexte\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 x 0 {}", "", false, "prefix-arity-507",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"nexte\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array nextelement arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-508",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"nextel\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array nextelement arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-509",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"nextel\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array nextelement arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-510",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"nextel\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 x 0 {}", "", false, "prefix-arity-511",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"nextel\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array nextelement arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-512",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"nextele\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array nextelement arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-513",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"nextele\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array nextelement arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-514",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"nextele\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 x 0 {}", "", false, "prefix-arity-515",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"nextele\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array nextelement arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-516",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"nextelem\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array nextelement arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-517",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"nextelem\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array nextelement arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-518",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"nextelem\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 x 0 {}", "", false, "prefix-arity-519",
  )
}

///|
test "Tcl array cases 521 through 560" {
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"nextelem\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array nextelement arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-520",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"nexteleme\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array nextelement arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-521",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"nexteleme\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array nextelement arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-522",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"nexteleme\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 x 0 {}", "", false, "prefix-arity-523",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"nexteleme\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array nextelement arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-524",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"nextelemen\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array nextelement arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-525",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"nextelemen\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array nextelement arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-526",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"nextelemen\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 x 0 {}", "", false, "prefix-arity-527",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"nextelemen\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array nextelement arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-528",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"nextelement\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array nextelement arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-529",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"nextelement\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array nextelement arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-530",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"nextelement\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 x 0 {}", "", false, "prefix-arity-531",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"nextelement\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array nextelement arrayName searchId\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-532",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-533",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-534",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-535",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-536",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"s\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"s\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND s}",
    "", false, "prefix-arity-537",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"s\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"s\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND s}",
    "", false, "prefix-arity-538",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"s\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"s\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND s}",
    "", false, "prefix-arity-539",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"s\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"s\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND s}",
    "", false, "prefix-arity-540",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"se\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array set arrayName list\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-541",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"se\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array set arrayName list\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-542",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"se\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {list must have an even number of elements} 0 {TCL ARGUMENT FORMAT}", "",
    false, "prefix-arity-543",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"se\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array set arrayName list\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-544",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"set\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array set arrayName list\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-545",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"set\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array set arrayName list\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-546",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"set\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {list must have an even number of elements} 0 {TCL ARGUMENT FORMAT}", "",
    false, "prefix-arity-547",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"set\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array set arrayName list\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-548",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-549",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-550",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-551",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-552",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"s\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"s\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND s}",
    "", false, "prefix-arity-553",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"s\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"s\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND s}",
    "", false, "prefix-arity-554",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"s\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"s\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND s}",
    "", false, "prefix-arity-555",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"s\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"s\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND s}",
    "", false, "prefix-arity-556",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"si\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array size arrayName\"} 0 {TCL WRONGARGS}", "",
    false, "prefix-arity-557",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"si\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 1 0 {}", "", false, "prefix-arity-558",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"si\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array size arrayName\"} 0 {TCL WRONGARGS}", "",
    false, "prefix-arity-559",
  )
}

///|
test "Tcl array cases 561 through 600" {
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"si\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array size arrayName\"} 0 {TCL WRONGARGS}", "",
    false, "prefix-arity-560",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"siz\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array size arrayName\"} 0 {TCL WRONGARGS}", "",
    false, "prefix-arity-561",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"siz\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 1 0 {}", "", false, "prefix-arity-562",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"siz\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array size arrayName\"} 0 {TCL WRONGARGS}", "",
    false, "prefix-arity-563",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"siz\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array size arrayName\"} 0 {TCL WRONGARGS}", "",
    false, "prefix-arity-564",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"size\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array size arrayName\"} 0 {TCL WRONGARGS}", "",
    false, "prefix-arity-565",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"size\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 1 0 {}", "", false, "prefix-arity-566",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"size\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array size arrayName\"} 0 {TCL WRONGARGS}", "",
    false, "prefix-arity-567",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"size\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array size arrayName\"} 0 {TCL WRONGARGS}", "",
    false, "prefix-arity-568",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-569",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-570",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-571",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-572",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"s\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"s\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND s}",
    "", false, "prefix-arity-573",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"s\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"s\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND s}",
    "", false, "prefix-arity-574",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"s\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"s\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND s}",
    "", false, "prefix-arity-575",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"s\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"s\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND s}",
    "", false, "prefix-arity-576",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"st\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"st\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND st}",
    "", false, "prefix-arity-577",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"st\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"st\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND st}",
    "", false, "prefix-arity-578",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"st\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"st\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND st}",
    "", false, "prefix-arity-579",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"st\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"st\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND st}",
    "", false, "prefix-arity-580",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"sta\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"sta\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND sta}",
    "", false, "prefix-arity-581",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"sta\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"sta\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND sta}",
    "", false, "prefix-arity-582",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"sta\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"sta\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND sta}",
    "", false, "prefix-arity-583",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"sta\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"sta\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND sta}",
    "", false, "prefix-arity-584",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"star\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array startsearch arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-585",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"star\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 s-2-a 0 {}", "", false, "prefix-arity-586",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"star\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array startsearch arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-587",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"star\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array startsearch arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-588",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"start\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array startsearch arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-589",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"start\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 s-2-a 0 {}", "", false, "prefix-arity-590",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"start\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array startsearch arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-591",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"start\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array startsearch arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-592",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"starts\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array startsearch arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-593",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"starts\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 s-2-a 0 {}", "", false, "prefix-arity-594",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"starts\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array startsearch arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-595",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"starts\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array startsearch arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-596",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"startse\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array startsearch arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-597",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"startse\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 s-2-a 0 {}", "", false, "prefix-arity-598",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"startse\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array startsearch arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-599",
  )
}

///|
test "Tcl array cases 601 through 640" {
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"startse\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array startsearch arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-600",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"startsea\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array startsearch arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-601",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"startsea\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 s-2-a 0 {}", "", false, "prefix-arity-602",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"startsea\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array startsearch arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-603",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"startsea\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array startsearch arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-604",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"startsear\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array startsearch arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-605",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"startsear\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 s-2-a 0 {}", "", false, "prefix-arity-606",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"startsear\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array startsearch arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-607",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"startsear\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array startsearch arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-608",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"startsearc\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array startsearch arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-609",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"startsearc\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 s-2-a 0 {}", "", false, "prefix-arity-610",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"startsearc\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array startsearch arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-611",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"startsearc\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array startsearch arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-612",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"startsearch\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array startsearch arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-613",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"startsearch\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 s-2-a 0 {}", "", false, "prefix-arity-614",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"startsearch\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array startsearch arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-615",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"startsearch\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array startsearch arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-616",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-617",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-618",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-619",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-620",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"s\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"s\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND s}",
    "", false, "prefix-arity-621",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"s\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"s\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND s}",
    "", false, "prefix-arity-622",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"s\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"s\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND s}",
    "", false, "prefix-arity-623",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"s\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"s\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND s}",
    "", false, "prefix-arity-624",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"st\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"st\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND st}",
    "", false, "prefix-arity-625",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"st\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"st\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND st}",
    "", false, "prefix-arity-626",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"st\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"st\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND st}",
    "", false, "prefix-arity-627",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"st\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"st\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND st}",
    "", false, "prefix-arity-628",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"sta\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"sta\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND sta}",
    "", false, "prefix-arity-629",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"sta\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"sta\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND sta}",
    "", false, "prefix-arity-630",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"sta\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"sta\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND sta}",
    "", false, "prefix-arity-631",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"sta\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"sta\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND sta}",
    "", false, "prefix-arity-632",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"stat\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array statistics arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-633",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"stat\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {1 entries in table, 4 buckets\nnumber of buckets with 0 entries: 3\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0} 0 {}",
    "", false, "prefix-arity-634",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"stat\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array statistics arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-635",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"stat\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array statistics arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-636",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"stati\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array statistics arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-637",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"stati\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {1 entries in table, 4 buckets\nnumber of buckets with 0 entries: 3\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0} 0 {}",
    "", false, "prefix-arity-638",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"stati\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array statistics arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-639",
  )
}

///|
test "Tcl array cases 641 through 680" {
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"stati\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array statistics arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-640",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"statis\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array statistics arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-641",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"statis\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {1 entries in table, 4 buckets\nnumber of buckets with 0 entries: 3\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0} 0 {}",
    "", false, "prefix-arity-642",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"statis\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array statistics arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-643",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"statis\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array statistics arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-644",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"statist\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array statistics arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-645",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"statist\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {1 entries in table, 4 buckets\nnumber of buckets with 0 entries: 3\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0} 0 {}",
    "", false, "prefix-arity-646",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"statist\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array statistics arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-647",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"statist\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array statistics arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-648",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"statisti\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array statistics arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-649",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"statisti\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {1 entries in table, 4 buckets\nnumber of buckets with 0 entries: 3\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0} 0 {}",
    "", false, "prefix-arity-650",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"statisti\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array statistics arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-651",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"statisti\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array statistics arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-652",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"statistic\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array statistics arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-653",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"statistic\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {1 entries in table, 4 buckets\nnumber of buckets with 0 entries: 3\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0} 0 {}",
    "", false, "prefix-arity-654",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"statistic\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array statistics arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-655",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"statistic\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array statistics arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-656",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"statistics\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array statistics arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-657",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"statistics\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {1 entries in table, 4 buckets\nnumber of buckets with 0 entries: 3\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0} 0 {}",
    "", false, "prefix-arity-658",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"statistics\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array statistics arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-659",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"statistics\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array statistics arrayName\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-660",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-661",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-662",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-663",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND {}}",
    "", false, "prefix-arity-664",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"u\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array unset arrayName ?pattern?\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-665",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"u\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "prefix-arity-666",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"u\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "prefix-arity-667",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"u\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array unset arrayName ?pattern?\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-668",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"un\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array unset arrayName ?pattern?\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-669",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"un\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "prefix-arity-670",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"un\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "prefix-arity-671",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"un\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array unset arrayName ?pattern?\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-672",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"uns\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array unset arrayName ?pattern?\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-673",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"uns\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "prefix-arity-674",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"uns\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "prefix-arity-675",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"uns\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array unset arrayName ?pattern?\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-676",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"unse\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array unset arrayName ?pattern?\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-677",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"unse\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "prefix-arity-678",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"unse\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "prefix-arity-679",
  )
}

///|
test "Tcl array cases 681 through 720" {
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"unse\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array unset arrayName ?pattern?\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-680",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"unset\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array unset arrayName ?pattern?\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-681",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"unset\\\" a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "prefix-arity-682",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"unset\\\" a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "prefix-arity-683",
  )
  check_array_case(
    "array set a {x 1};array startsearch a;set code [catch \"array \\\"unset\\\" a s-1-a extra\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array unset arrayName ?pattern?\"} 0 {TCL WRONGARGS}",
    "", false, "prefix-arity-684",
  )
  check_array_case(
    ";set code [catch \"array\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array subcommand ?arg ...?\"} 0 {TCL WRONGARGS}",
    "", false, "diagnostics-685",
  )
  check_array_case(
    ";set code [catch \"array bad\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"bad\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND bad}",
    "", false, "diagnostics-686",
  )
  check_array_case(
    ";set code [catch \"array startsearch a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {\"a\" isn't an array} 0 {TCL LOOKUP ARRAY a}", "", false, "diagnostics-687",
  )
  check_array_case(
    ";set code [catch \"array statistics a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {\"a\" isn't an array} 0 {TCL LOOKUP ARRAY a}", "", false, "diagnostics-688",
  )
  check_array_case(
    ";set code [catch \"array anymore a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {\"a\" isn't an array} 0 {TCL LOOKUP ARRAY a}", "", false, "diagnostics-689",
  )
  check_array_case(
    ";set code [catch \"array nextelement a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {\"a\" isn't an array} 0 {TCL LOOKUP ARRAY a}", "", false, "diagnostics-690",
  )
  check_array_case(
    ";set code [catch \"array donesearch a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {\"a\" isn't an array} 0 {TCL LOOKUP ARRAY a}", "", false, "diagnostics-691",
  )
  check_array_case(
    ";set code [catch \"array set a {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "diagnostics-692",
  )
  check_array_case(
    ";set code [catch \"array set a {x 1}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "diagnostics-693",
  )
  check_array_case(
    ";set code [catch \"array set a {x}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {list must have an even number of elements} 0 {TCL ARGUMENT FORMAT}", "",
    false, "diagnostics-694",
  )
  check_array_case(
    ";set code [catch \"array set a \\\"{\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unmatched open brace in list} 0 {TCL VALUE LIST BRACE}", "", false, "diagnostics-695",
  )
  check_array_case(
    ";set code [catch \"array set a(x) {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {can't set \"a(x)\": variable isn't array} 0 {TCL LOOKUP VARNAME a(x)}", "",
    false, "diagnostics-696",
  )
  check_array_case(
    ";set code [catch \"array set a(x) {y 1}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {can't set \"a(x)\": variable isn't array} 0 {TCL LOOKUP VARNAME a(x)}", "",
    false, "diagnostics-697",
  )
  check_array_case(
    ";set code [catch \"array set ::missing::a {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {can't set \"::missing::a\": parent namespace doesn't exist} 0 {TCL LOOKUP VARNAME ::missing::a}",
    "", false, "diagnostics-698",
  )
  check_array_case(
    ";set code [catch \"array names a -bad x\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {bad option \"-bad\": must be -exact, -glob, or -regexp} 0 {TCL LOOKUP INDEX option -bad}",
    "", false, "diagnostics-699",
  )
  check_array_case(
    ";set code [catch \"array names a - x\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {ambiguous option \"-\": must be -exact, -glob, or -regexp} 0 {TCL LOOKUP INDEX option -}",
    "", false, "diagnostics-700",
  )
  check_array_case(
    "array set a {};set code [catch \"array\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array subcommand ?arg ...?\"} 0 {TCL WRONGARGS}",
    "", false, "diagnostics-701",
  )
  check_array_case(
    "array set a {};set code [catch \"array bad\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"bad\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND bad}",
    "", false, "diagnostics-702",
  )
  check_array_case(
    "array set a {};set code [catch \"array startsearch a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 s-1-a 0 {}", "", false, "diagnostics-703",
  )
  check_array_case(
    "array set a {};set code [catch \"array statistics a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {0 entries in table, 4 buckets\nnumber of buckets with 0 entries: 4\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 0.0} 0 {}",
    "", false, "diagnostics-704",
  )
  check_array_case(
    "array set a {};set code [catch \"array anymore a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {couldn't find search \"s-1-a\"} 0 {TCL LOOKUP ARRAYSEARCH s-1-a}", "", false,
    "diagnostics-705",
  )
  check_array_case(
    "array set a {};set code [catch \"array nextelement a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {couldn't find search \"s-1-a\"} 0 {TCL LOOKUP ARRAYSEARCH s-1-a}", "", false,
    "diagnostics-706",
  )
  check_array_case(
    "array set a {};set code [catch \"array donesearch a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {couldn't find search \"s-1-a\"} 0 {TCL LOOKUP ARRAYSEARCH s-1-a}", "", false,
    "diagnostics-707",
  )
  check_array_case(
    "array set a {};set code [catch \"array set a {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "diagnostics-708",
  )
  check_array_case(
    "array set a {};set code [catch \"array set a {x 1}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "diagnostics-709",
  )
  check_array_case(
    "array set a {};set code [catch \"array set a {x}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {list must have an even number of elements} 0 {TCL ARGUMENT FORMAT}", "",
    false, "diagnostics-710",
  )
  check_array_case(
    "array set a {};set code [catch \"array set a \\\"{\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unmatched open brace in list} 0 {TCL VALUE LIST BRACE}", "", false, "diagnostics-711",
  )
  check_array_case(
    "array set a {};set code [catch \"array set a(x) {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {can't set \"a(x)\": variable isn't array} 0 {TCL LOOKUP VARNAME a(x)}", "",
    false, "diagnostics-712",
  )
  check_array_case(
    "array set a {};set code [catch \"array set a(x) {y 1}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {can't set \"a(x)\": variable isn't array} 0 {TCL LOOKUP VARNAME a(x)}", "",
    false, "diagnostics-713",
  )
  check_array_case(
    "array set a {};set code [catch \"array set ::missing::a {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {can't set \"::missing::a\": parent namespace doesn't exist} 0 {TCL LOOKUP VARNAME ::missing::a}",
    "", false, "diagnostics-714",
  )
  check_array_case(
    "array set a {};set code [catch \"array names a -bad x\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {bad option \"-bad\": must be -exact, -glob, or -regexp} 0 {TCL LOOKUP INDEX option -bad}",
    "", false, "diagnostics-715",
  )
  check_array_case(
    "array set a {};set code [catch \"array names a - x\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {ambiguous option \"-\": must be -exact, -glob, or -regexp} 0 {TCL LOOKUP INDEX option -}",
    "", false, "diagnostics-716",
  )
  check_array_case(
    "array set a {x 1};set code [catch \"array\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array subcommand ?arg ...?\"} 0 {TCL WRONGARGS}",
    "", false, "diagnostics-717",
  )
  check_array_case(
    "array set a {x 1};set code [catch \"array bad\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"bad\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND bad}",
    "", false, "diagnostics-718",
  )
  check_array_case(
    "array set a {x 1};set code [catch \"array startsearch a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 s-1-a 0 {}", "", false, "diagnostics-719",
  )
}

///|
test "Tcl array cases 721 through 760" {
  check_array_case(
    "array set a {x 1};set code [catch \"array statistics a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {1 entries in table, 4 buckets\nnumber of buckets with 0 entries: 3\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0} 0 {}",
    "", false, "diagnostics-720",
  )
  check_array_case(
    "array set a {x 1};set code [catch \"array anymore a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {couldn't find search \"s-1-a\"} 0 {TCL LOOKUP ARRAYSEARCH s-1-a}", "", false,
    "diagnostics-721",
  )
  check_array_case(
    "array set a {x 1};set code [catch \"array nextelement a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {couldn't find search \"s-1-a\"} 0 {TCL LOOKUP ARRAYSEARCH s-1-a}", "", false,
    "diagnostics-722",
  )
  check_array_case(
    "array set a {x 1};set code [catch \"array donesearch a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {couldn't find search \"s-1-a\"} 0 {TCL LOOKUP ARRAYSEARCH s-1-a}", "", false,
    "diagnostics-723",
  )
  check_array_case(
    "array set a {x 1};set code [catch \"array set a {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "diagnostics-724",
  )
  check_array_case(
    "array set a {x 1};set code [catch \"array set a {x 1}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "diagnostics-725",
  )
  check_array_case(
    "array set a {x 1};set code [catch \"array set a {x}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {list must have an even number of elements} 0 {TCL ARGUMENT FORMAT}", "",
    false, "diagnostics-726",
  )
  check_array_case(
    "array set a {x 1};set code [catch \"array set a \\\"{\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unmatched open brace in list} 0 {TCL VALUE LIST BRACE}", "", false, "diagnostics-727",
  )
  check_array_case(
    "array set a {x 1};set code [catch \"array set a(x) {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {can't set \"a(x)\": variable isn't array} 0 {TCL LOOKUP VARNAME a(x)}", "",
    false, "diagnostics-728",
  )
  check_array_case(
    "array set a {x 1};set code [catch \"array set a(x) {y 1}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {can't set \"a(x)\": variable isn't array} 0 {TCL LOOKUP VARNAME a(x)}", "",
    false, "diagnostics-729",
  )
  check_array_case(
    "array set a {x 1};set code [catch \"array set ::missing::a {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {can't set \"::missing::a\": parent namespace doesn't exist} 0 {TCL LOOKUP VARNAME ::missing::a}",
    "", false, "diagnostics-730",
  )
  check_array_case(
    "array set a {x 1};set code [catch \"array names a -bad x\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {bad option \"-bad\": must be -exact, -glob, or -regexp} 0 {TCL LOOKUP INDEX option -bad}",
    "", false, "diagnostics-731",
  )
  check_array_case(
    "array set a {x 1};set code [catch \"array names a - x\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {ambiguous option \"-\": must be -exact, -glob, or -regexp} 0 {TCL LOOKUP INDEX option -}",
    "", false, "diagnostics-732",
  )
  check_array_case(
    "set a scalar;set code [catch \"array\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array subcommand ?arg ...?\"} 0 {TCL WRONGARGS}",
    "", false, "diagnostics-733",
  )
  check_array_case(
    "set a scalar;set code [catch \"array bad\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"bad\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND bad}",
    "", false, "diagnostics-734",
  )
  check_array_case(
    "set a scalar;set code [catch \"array startsearch a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {\"a\" isn't an array} 0 {TCL LOOKUP ARRAY a}", "", false, "diagnostics-735",
  )
  check_array_case(
    "set a scalar;set code [catch \"array statistics a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {\"a\" isn't an array} 0 {TCL LOOKUP ARRAY a}", "", false, "diagnostics-736",
  )
  check_array_case(
    "set a scalar;set code [catch \"array anymore a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {\"a\" isn't an array} 0 {TCL LOOKUP ARRAY a}", "", false, "diagnostics-737",
  )
  check_array_case(
    "set a scalar;set code [catch \"array nextelement a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {\"a\" isn't an array} 0 {TCL LOOKUP ARRAY a}", "", false, "diagnostics-738",
  )
  check_array_case(
    "set a scalar;set code [catch \"array donesearch a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {\"a\" isn't an array} 0 {TCL LOOKUP ARRAY a}", "", false, "diagnostics-739",
  )
  check_array_case(
    "set a scalar;set code [catch \"array set a {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {can't array set \"a\": variable isn't array} 0 {TCL WRITE ARRAY}", "", false,
    "diagnostics-740",
  )
  check_array_case(
    "set a scalar;set code [catch \"array set a {x 1}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {can't set \"a(x)\": variable isn't array} 0 {TCL LOOKUP VARNAME a}", "",
    false, "diagnostics-741",
  )
  check_array_case(
    "set a scalar;set code [catch \"array set a {x}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {list must have an even number of elements} 0 {TCL ARGUMENT FORMAT}", "",
    false, "diagnostics-742",
  )
  check_array_case(
    "set a scalar;set code [catch \"array set a \\\"{\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unmatched open brace in list} 0 {TCL VALUE LIST BRACE}", "", false, "diagnostics-743",
  )
  check_array_case(
    "set a scalar;set code [catch \"array set a(x) {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {can't set \"a(x)\": variable isn't array} 0 {TCL LOOKUP VARNAME a}", "",
    false, "diagnostics-744",
  )
  check_array_case(
    "set a scalar;set code [catch \"array set a(x) {y 1}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {can't set \"a(x)\": variable isn't array} 0 {TCL LOOKUP VARNAME a}", "",
    false, "diagnostics-745",
  )
  check_array_case(
    "set a scalar;set code [catch \"array set ::missing::a {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {can't set \"::missing::a\": parent namespace doesn't exist} 0 {TCL LOOKUP VARNAME ::missing::a}",
    "", false, "diagnostics-746",
  )
  check_array_case(
    "set a scalar;set code [catch \"array names a -bad x\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {bad option \"-bad\": must be -exact, -glob, or -regexp} 0 {TCL LOOKUP INDEX option -bad}",
    "", false, "diagnostics-747",
  )
  check_array_case(
    "set a scalar;set code [catch \"array names a - x\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {ambiguous option \"-\": must be -exact, -glob, or -regexp} 0 {TCL LOOKUP INDEX option -}",
    "", false, "diagnostics-748",
  )
  check_array_case(
    "array set a {};upvar #0 a(x) b;set code [catch \"array\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {wrong # args: should be \"array subcommand ?arg ...?\"} 0 {TCL WRONGARGS}",
    "", false, "diagnostics-749",
  )
  check_array_case(
    "array set a {};upvar #0 a(x) b;set code [catch \"array bad\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unknown or ambiguous subcommand \"bad\": must be anymore, donesearch, exists, get, names, nextelement, set, size, startsearch, statistics, or unset} 0 {TCL LOOKUP SUBCOMMAND bad}",
    "", false, "diagnostics-750",
  )
  check_array_case(
    "array set a {};upvar #0 a(x) b;set code [catch \"array startsearch a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 s-1-a 0 {}", "", false, "diagnostics-751",
  )
  check_array_case(
    "array set a {};upvar #0 a(x) b;set code [catch \"array statistics a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {1 entries in table, 4 buckets\nnumber of buckets with 0 entries: 3\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0} 0 {}",
    "", false, "diagnostics-752",
  )
  check_array_case(
    "array set a {};upvar #0 a(x) b;set code [catch \"array anymore a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {couldn't find search \"s-1-a\"} 0 {TCL LOOKUP ARRAYSEARCH s-1-a}", "", false,
    "diagnostics-753",
  )
  check_array_case(
    "array set a {};upvar #0 a(x) b;set code [catch \"array nextelement a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {couldn't find search \"s-1-a\"} 0 {TCL LOOKUP ARRAYSEARCH s-1-a}", "", false,
    "diagnostics-754",
  )
  check_array_case(
    "array set a {};upvar #0 a(x) b;set code [catch \"array donesearch a s-1-a\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {couldn't find search \"s-1-a\"} 0 {TCL LOOKUP ARRAYSEARCH s-1-a}", "", false,
    "diagnostics-755",
  )
  check_array_case(
    "array set a {};upvar #0 a(x) b;set code [catch \"array set a {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "diagnostics-756",
  )
  check_array_case(
    "array set a {};upvar #0 a(x) b;set code [catch \"array set a {x 1}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "diagnostics-757",
  )
  check_array_case(
    "array set a {};upvar #0 a(x) b;set code [catch \"array set a {x}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {list must have an even number of elements} 0 {TCL ARGUMENT FORMAT}", "",
    false, "diagnostics-758",
  )
  check_array_case(
    "array set a {};upvar #0 a(x) b;set code [catch \"array set a \\\"{\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {unmatched open brace in list} 0 {TCL VALUE LIST BRACE}", "", false, "diagnostics-759",
  )
}

///|
test "Tcl array cases 761 through 800" {
  check_array_case(
    "array set a {};upvar #0 a(x) b;set code [catch \"array set a(x) {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {can't set \"a(x)\": variable isn't array} 0 {TCL LOOKUP VARNAME a(x)}", "",
    false, "diagnostics-760",
  )
  check_array_case(
    "array set a {};upvar #0 a(x) b;set code [catch \"array set a(x) {y 1}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {can't set \"a(x)\": variable isn't array} 0 {TCL LOOKUP VARNAME a(x)}", "",
    false, "diagnostics-761",
  )
  check_array_case(
    "array set a {};upvar #0 a(x) b;set code [catch \"array set ::missing::a {}\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {can't set \"::missing::a\": parent namespace doesn't exist} 0 {TCL LOOKUP VARNAME ::missing::a}",
    "", false, "diagnostics-762",
  )
  check_array_case(
    "array set a {};upvar #0 a(x) b;set code [catch \"array names a -bad x\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {bad option \"-bad\": must be -exact, -glob, or -regexp} 0 {TCL LOOKUP INDEX option -bad}",
    "", false, "diagnostics-763",
  )
  check_array_case(
    "array set a {};upvar #0 a(x) b;set code [catch \"array names a - x\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {ambiguous option \"-\": must be -exact, -glob, or -regexp} 0 {TCL LOOKUP INDEX option -}",
    "", false, "diagnostics-764",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];set code [catch \"array names a  \\\"*\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {{} x0 x a\u0000b 😀} 0 {}", "", false, "names-pattern-765",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];set code [catch \"array names a  \\\"\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {{}} 0 {}", "", false, "names-pattern-766",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];set code [catch \"array names a  \\\"x*\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {x0 x} 0 {}", "", false, "names-pattern-767",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];set code [catch \"array names a  \\\"x\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 x 0 {}", "", false, "names-pattern-768",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];set code [catch \"array names a  \\\"^x\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "names-pattern-769",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];set code [catch \"array names a  \\\"\\\\\\[\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "names-pattern-770",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];set code [catch \"array names a  \\\".*\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "names-pattern-771",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];set code [catch \"array names a  \\\"😀\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 😀 0 {}", "", false, "names-pattern-772",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];set code [catch \"array names a  \\\"a\\\\x00b\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 a\u0000b 0 {}", "", false, "names-pattern-773",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];set code [catch \"array names a -exact \\\"*\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "names-pattern-774",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];set code [catch \"array names a -exact \\\"\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {{}} 0 {}", "", false, "names-pattern-775",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];set code [catch \"array names a -exact \\\"x*\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "names-pattern-776",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];set code [catch \"array names a -exact \\\"x\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 x 0 {}", "", false, "names-pattern-777",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];set code [catch \"array names a -exact \\\"^x\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "names-pattern-778",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];set code [catch \"array names a -exact \\\"\\\\\\[\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "names-pattern-779",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];set code [catch \"array names a -exact \\\".*\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "names-pattern-780",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];set code [catch \"array names a -exact \\\"😀\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 😀 0 {}", "", false, "names-pattern-781",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];set code [catch \"array names a -exact \\\"a\\\\x00b\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 a\u0000b 0 {}", "", false, "names-pattern-782",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];set code [catch \"array names a -glob \\\"*\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {{} x0 x a\u0000b 😀} 0 {}", "", false, "names-pattern-783",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];set code [catch \"array names a -glob \\\"\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {{}} 0 {}", "", false, "names-pattern-784",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];set code [catch \"array names a -glob \\\"x*\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {x0 x} 0 {}", "", false, "names-pattern-785",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];set code [catch \"array names a -glob \\\"x\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 x 0 {}", "", false, "names-pattern-786",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];set code [catch \"array names a -glob \\\"^x\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "names-pattern-787",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];set code [catch \"array names a -glob \\\"\\\\\\[\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "names-pattern-788",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];set code [catch \"array names a -glob \\\".*\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {} 0 {}", "", false, "names-pattern-789",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];set code [catch \"array names a -glob \\\"😀\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 😀 0 {}", "", false, "names-pattern-790",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];set code [catch \"array names a -glob \\\"a\\\\x00b\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 a\u0000b 0 {}", "", false, "names-pattern-791",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];set code [catch \"array names a -regexp \\\"*\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {couldn't compile regular expression pattern: quantifier operand invalid} 0 {REGEXP REG_BADRPT {quantifier operand invalid}}",
    "", false, "names-pattern-792",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];set code [catch \"array names a -regexp \\\"\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {{} x0 x a\u0000b 😀} 0 {}", "", false, "names-pattern-793",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];set code [catch \"array names a -regexp \\\"x*\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {{} x0 x a\u0000b 😀} 0 {}", "", false, "names-pattern-794",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];set code [catch \"array names a -regexp \\\"x\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {x0 x} 0 {}", "", false, "names-pattern-795",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];set code [catch \"array names a -regexp \\\"^x\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {x0 x} 0 {}", "", false, "names-pattern-796",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];set code [catch \"array names a -regexp \\\"\\\\\\[\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {couldn't compile regular expression pattern: brackets [] not balanced} 0 {REGEXP REG_EBRACK {brackets [] not balanced}}",
    "", false, "names-pattern-797",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];set code [catch \"array names a -regexp \\\".*\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {{} x0 x a\u0000b 😀} 0 {}", "", false, "names-pattern-798",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];set code [catch \"array names a -regexp \\\"😀\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 😀 0 {}", "", false, "names-pattern-799",
  )
}

///|
test "Tcl array cases 801 through 840" {
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];set code [catch \"array names a -regexp \\\"a\\\\x00b\\\"\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 a\u0000b 0 {}", "", false, "names-pattern-800",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];list [array get a \"*\"] [array get a] [array statistics a]",
    "{{} 3 x0 2 x 1 a\u0000b 5 😀 4} {{} 3 x0 2 x 1 a\u0000b 5 😀 4} {5 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 1\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.8}",
    "", false, "pattern-get-801",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];list [array get a \"x*\"] [array get a] [array statistics a]",
    "{x0 2 x 1} {{} 3 x0 2 x 1 a\u0000b 5 😀 4} {5 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 1\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.8}",
    "", false, "pattern-get-802",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];list [array get a \"x\"] [array get a] [array statistics a]",
    "{x 1} {{} 3 x0 2 x 1 a\u0000b 5 😀 4} {5 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 1\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.8}",
    "", false, "pattern-get-803",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];list [array get a \"\"] [array get a] [array statistics a]",
    "{{} 3} {{} 3 x0 2 x 1 a\u0000b 5 😀 4} {5 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 1\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.8}",
    "", false, "pattern-get-804",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];list [array get a \"?\"] [array get a] [array statistics a]",
    "{x 1 😀 4} {{} 3 x0 2 x 1 a\u0000b 5 😀 4} {5 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 1\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.8}",
    "", false, "pattern-get-805",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];list [array get a \"\\[xy\\]\"] [array get a] [array statistics a]",
    "{x 1} {{} 3 x0 2 x 1 a\u0000b 5 😀 4} {5 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 1\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.8}",
    "", false, "pattern-get-806",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];list [array get a \"a\\x00b\"] [array get a] [array statistics a]",
    "{a\u0000b 5} {{} 3 x0 2 x 1 a\u0000b 5 😀 4} {5 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 1\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.8}",
    "", false, "pattern-get-807",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];list [array get a \"😀\"] [array get a] [array statistics a]",
    "{😀 4} {{} 3 x0 2 x 1 a\u0000b 5 😀 4} {5 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 1\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.8}",
    "", false, "pattern-get-808",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];list [array unset a \"*\"] [array get a] [array statistics a]",
    "{} {} {0 entries in table, 4 buckets\nnumber of buckets with 0 entries: 4\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 0.0}",
    "", false, "pattern-unset-809",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];list [array unset a \"x*\"] [array get a] [array statistics a]",
    "{} {{} 3 a\u0000b 5 😀 4} {3 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.3}",
    "", false, "pattern-unset-810",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];list [array unset a \"x\"] [array get a] [array statistics a]",
    "{} {{} 3 x0 2 a\u0000b 5 😀 4} {4 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 2\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.5}",
    "", false, "pattern-unset-811",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];list [array unset a \"\"] [array get a] [array statistics a]",
    "{} {x0 2 x 1 a\u0000b 5 😀 4} {4 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 2\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.5}",
    "", false, "pattern-unset-812",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];list [array unset a \"?\"] [array get a] [array statistics a]",
    "{} {{} 3 x0 2 a\u0000b 5} {3 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.3}",
    "", false, "pattern-unset-813",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];list [array unset a \"\\[xy\\]\"] [array get a] [array statistics a]",
    "{} {{} 3 x0 2 a\u0000b 5 😀 4} {4 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 2\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.5}",
    "", false, "pattern-unset-814",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];list [array unset a \"a\\x00b\"] [array get a] [array statistics a]",
    "{} {{} 3 x0 2 x 1 😀 4} {4 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 1\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.8}",
    "", false, "pattern-unset-815",
  )
  check_array_case(
    "array set a [list \"x\" \"1\" \"x0\" \"2\" \"\" \"3\" \"😀\" \"4\" \"a\\x00b\" \"5\"];list [array unset a \"😀\"] [array get a] [array statistics a]",
    "{} {{} 3 x0 2 x 1 a\u0000b 5} {4 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 1\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.8}",
    "", false, "pattern-unset-816",
  )
  check_array_case(
    "array set a {};set k \"𐀀\";set a($k) 1;set a(x) 2;list [array names a] [array statistics a]",
    "{x 𐀀} {2 entries in table, 4 buckets\nnumber of buckets with 0 entries: 3\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.5}",
    "", false, "supplementary-representation-817",
  )
  check_array_case(
    "array set a {};set k [format %c 65536];set a($k) 1;set a(x) 2;list [array names a] [array statistics a]",
    "{x �} {2 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 2\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "supplementary-representation-819",
  )
  check_array_case(
    "array set a {};set k \"\\ud800\";set a($k) 1;list [array names a] [array statistics a]",
    String::from_array([
      (55296).unsafe_to_char(),
      (32).unsafe_to_char(),
      (123).unsafe_to_char(),
      (49).unsafe_to_char(),
      (32).unsafe_to_char(),
      (101).unsafe_to_char(),
      (110).unsafe_to_char(),
      (116).unsafe_to_char(),
      (114).unsafe_to_char(),
      (105).unsafe_to_char(),
      (101).unsafe_to_char(),
      (115).unsafe_to_char(),
      (32).unsafe_to_char(),
      (105).unsafe_to_char(),
      (110).unsafe_to_char(),
      (32).unsafe_to_char(),
      (116).unsafe_to_char(),
      (97).unsafe_to_char(),
      (98).unsafe_to_char(),
      (108).unsafe_to_char(),
      (101).unsafe_to_char(),
      (44).unsafe_to_char(),
      (32).unsafe_to_char(),
      (52).unsafe_to_char(),
      (32).unsafe_to_char(),
      (98).unsafe_to_char(),
      (117).unsafe_to_char(),
      (99).unsafe_to_char(),
      (107).unsafe_to_char(),
      (101).unsafe_to_char(),
      (116).unsafe_to_char(),
      (115).unsafe_to_char(),
      (10).unsafe_to_char(),
      (110).unsafe_to_char(),
      (117).unsafe_to_char(),
      (109).unsafe_to_char(),
      (98).unsafe_to_char(),
      (101).unsafe_to_char(),
      (114).unsafe_to_char(),
      (32).unsafe_to_char(),
      (111).unsafe_to_char(),
      (102).unsafe_to_char(),
      (32).unsafe_to_char(),
      (98).unsafe_to_char(),
      (117).unsafe_to_char(),
      (99).unsafe_to_char(),
      (107).unsafe_to_char(),
      (101).unsafe_to_char(),
      (116).unsafe_to_char(),
      (115).unsafe_to_char(),
      (32).unsafe_to_char(),
      (119).unsafe_to_char(),
      (105).unsafe_to_char(),
      (116).unsafe_to_char(),
      (104).unsafe_to_char(),
      (32).unsafe_to_char(),
      (48).unsafe_to_char(),
      (32).unsafe_to_char(),
      (101).unsafe_to_char(),
      (110).unsafe_to_char(),
      (116).unsafe_to_char(),
      (114).unsafe_to_char(),
      (105).unsafe_to_char(),
      (101).unsafe_to_char(),
      (115).unsafe_to_char(),
      (58).unsafe_to_char(),
      (32).unsafe_to_char(),
      (51).unsafe_to_char(),
      (10).unsafe_to_char(),
      (110).unsafe_to_char(),
      (117).unsafe_to_char(),
      (109).unsafe_to_char(),
      (98).unsafe_to_char(),
      (101).unsafe_to_char(),
      (114).unsafe_to_char(),
      (32).unsafe_to_char(),
      (111).unsafe_to_char(),
      (102).unsafe_to_char(),
      (32).unsafe_to_char(),
      (98).unsafe_to_char(),
      (117).unsafe_to_char(),
      (99).unsafe_to_char(),
      (107).unsafe_to_char(),
      (101).unsafe_to_char(),
      (116).unsafe_to_char(),
      (115).unsafe_to_char(),
      (32).unsafe_to_char(),
      (119).unsafe_to_char(),
      (105).unsafe_to_char(),
      (116).unsafe_to_char(),
      (104).unsafe_to_char(),
      (32).unsafe_to_char(),
      (49).unsafe_to_char(),
      (32).unsafe_to_char(),
      (101).unsafe_to_char(),
      (110).unsafe_to_char(),
      (116).unsafe_to_char(),
      (114).unsafe_to_char(),
      (105).unsafe_to_char(),
      (101).unsafe_to_char(),
      (115).unsafe_to_char(),
      (58).unsafe_to_char(),
      (32).unsafe_to_char(),
      (49).unsafe_to_char(),
      (10).unsafe_to_char(),
      (110).unsafe_to_char(),
      (117).unsafe_to_char(),
      (109).unsafe_to_char(),
      (98).unsafe_to_char(),
      (101).unsafe_to_char(),
      (114).unsafe_to_char(),
      (32).unsafe_to_char(),
      (111).unsafe_to_char(),
      (102).unsafe_to_char(),
      (32).unsafe_to_char(),
      (98).unsafe_to_char(),
      (117).unsafe_to_char(),
      (99).unsafe_to_char(),
      (107).unsafe_to_char(),
      (101).unsafe_to_char(),
      (116).unsafe_to_char(),
      (115).unsafe_to_char(),
      (32).unsafe_to_char(),
      (119).unsafe_to_char(),
      (105).unsafe_to_char(),
      (116).unsafe_to_char(),
      (104).unsafe_to_char(),
      (32).unsafe_to_char(),
      (50).unsafe_to_char(),
      (32).unsafe_to_char(),
      (101).unsafe_to_char(),
      (110).unsafe_to_char(),
      (116).unsafe_to_char(),
      (114).unsafe_to_char(),
      (105).unsafe_to_char(),
      (101).unsafe_to_char(),
      (115).unsafe_to_char(),
      (58).unsafe_to_char(),
      (32).unsafe_to_char(),
      (48).unsafe_to_char(),
      (10).unsafe_to_char(),
      (110).unsafe_to_char(),
      (117).unsafe_to_char(),
      (109).unsafe_to_char(),
      (98).unsafe_to_char(),
      (101).unsafe_to_char(),
      (114).unsafe_to_char(),
      (32).unsafe_to_char(),
      (111).unsafe_to_char(),
      (102).unsafe_to_char(),
      (32).unsafe_to_char(),
      (98).unsafe_to_char(),
      (117).unsafe_to_char(),
      (99).unsafe_to_char(),
      (107).unsafe_to_char(),
      (101).unsafe_to_char(),
      (116).unsafe_to_char(),
      (115).unsafe_to_char(),
      (32).unsafe_to_char(),
      (119).unsafe_to_char(),
      (105).unsafe_to_char(),
      (116).unsafe_to_char(),
      (104).unsafe_to_char(),
      (32).unsafe_to_char(),
      (51).unsafe_to_char(),
      (32).unsafe_to_char(),
      (101).unsafe_to_char(),
      (110).unsafe_to_char(),
      (116).unsafe_to_char(),
      (114).unsafe_to_char(),
      (105).unsafe_to_char(),
      (101).unsafe_to_char(),
      (115).unsafe_to_char(),
      (58).unsafe_to_char(),
      (32).unsafe_to_char(),
      (48).unsafe_to_char(),
      (10).unsafe_to_char(),
      (110).unsafe_to_char(),
      (117).unsafe_to_char(),
      (109).unsafe_to_char(),
      (98).unsafe_to_char(),
      (101).unsafe_to_char(),
      (114).unsafe_to_char(),
      (32).unsafe_to_char(),
      (111).unsafe_to_char(),
      (102).unsafe_to_char(),
      (32).unsafe_to_char(),
      (98).unsafe_to_char(),
      (117).unsafe_to_char(),
      (99).unsafe_to_char(),
      (107).unsafe_to_char(),
      (101).unsafe_to_char(),
      (116).unsafe_to_char(),
      (115).unsafe_to_char(),
      (32).unsafe_to_char(),
      (119).unsafe_to_char(),
      (105).unsafe_to_char(),
      (116).unsafe_to_char(),
      (104).unsafe_to_char(),
      (32).unsafe_to_char(),
      (52).unsafe_to_char(),
      (32).unsafe_to_char(),
      (101).unsafe_to_char(),
      (110).unsafe_to_char(),
      (116).unsafe_to_char(),
      (114).unsafe_to_char(),
      (105).unsafe_to_char(),
      (101).unsafe_to_char(),
      (115).unsafe_to_char(),
      (58).unsafe_to_char(),
      (32).unsafe_to_char(),
      (48).unsafe_to_char(),
      (10).unsafe_to_char(),
      (110).unsafe_to_char(),
      (117).unsafe_to_char(),
      (109).unsafe_to_char(),
      (98).unsafe_to_char(),
      (101).unsafe_to_char(),
      (114).unsafe_to_char(),
      (32).unsafe_to_char(),
      (111).unsafe_to_char(),
      (102).unsafe_to_char(),
      (32).unsafe_to_char(),
      (98).unsafe_to_char(),
      (117).unsafe_to_char(),
      (99).unsafe_to_char(),
      (107).unsafe_to_char(),
      (101).unsafe_to_char(),
      (116).unsafe_to_char(),
      (115).unsafe_to_char(),
      (32).unsafe_to_char(),
      (119).unsafe_to_char(),
      (105).unsafe_to_char(),
      (116).unsafe_to_char(),
      (104).unsafe_to_char(),
      (32).unsafe_to_char(),
      (53).unsafe_to_char(),
      (32).unsafe_to_char(),
      (101).unsafe_to_char(),
      (110).unsafe_to_char(),
      (116).unsafe_to_char(),
      (114).unsafe_to_char(),
      (105).unsafe_to_char(),
      (101).unsafe_to_char(),
      (115).unsafe_to_char(),
      (58).unsafe_to_char(),
      (32).unsafe_to_char(),
      (48).unsafe_to_char(),
      (10).unsafe_to_char(),
      (110).unsafe_to_char(),
      (117).unsafe_to_char(),
      (109).unsafe_to_char(),
      (98).unsafe_to_char(),
      (101).unsafe_to_char(),
      (114).unsafe_to_char(),
      (32).unsafe_to_char(),
      (111).unsafe_to_char(),
      (102).unsafe_to_char(),
      (32).unsafe_to_char(),
      (98).unsafe_to_char(),
      (117).unsafe_to_char(),
      (99).unsafe_to_char(),
      (107).unsafe_to_char(),
      (101).unsafe_to_char(),
      (116).unsafe_to_char(),
      (115).unsafe_to_char(),
      (32).unsafe_to_char(),
      (119).unsafe_to_char(),
      (105).unsafe_to_char(),
      (116).unsafe_to_char(),
      (104).unsafe_to_char(),
      (32).unsafe_to_char(),
      (54).unsafe_to_char(),
      (32).unsafe_to_char(),
      (101).unsafe_to_char(),
      (110).unsafe_to_char(),
      (116).unsafe_to_char(),
      (114).unsafe_to_char(),
      (105).unsafe_to_char(),
      (101).unsafe_to_char(),
      (115).unsafe_to_char(),
      (58).unsafe_to_char(),
      (32).unsafe_to_char(),
      (48).unsafe_to_char(),
      (10).unsafe_to_char(),
      (110).unsafe_to_char(),
      (117).unsafe_to_char(),
      (109).unsafe_to_char(),
      (98).unsafe_to_char(),
      (101).unsafe_to_char(),
      (114).unsafe_to_char(),
      (32).unsafe_to_char(),
      (111).unsafe_to_char(),
      (102).unsafe_to_char(),
      (32).unsafe_to_char(),
      (98).unsafe_to_char(),
      (117).unsafe_to_char(),
      (99).unsafe_to_char(),
      (107).unsafe_to_char(),
      (101).unsafe_to_char(),
      (116).unsafe_to_char(),
      (115).unsafe_to_char(),
      (32).unsafe_to_char(),
      (119).unsafe_to_char(),
      (105).unsafe_to_char(),
      (116).unsafe_to_char(),
      (104).unsafe_to_char(),
      (32).unsafe_to_char(),
      (55).unsafe_to_char(),
      (32).unsafe_to_char(),
      (101).unsafe_to_char(),
      (110).unsafe_to_char(),
      (116).unsafe_to_char(),
      (114).unsafe_to_char(),
      (105).unsafe_to_char(),
      (101).unsafe_to_char(),
      (115).unsafe_to_char(),
      (58).unsafe_to_char(),
      (32).unsafe_to_char(),
      (48).unsafe_to_char(),
      (10).unsafe_to_char(),
      (110).unsafe_to_char(),
      (117).unsafe_to_char(),
      (109).unsafe_to_char(),
      (98).unsafe_to_char(),
      (101).unsafe_to_char(),
      (114).unsafe_to_char(),
      (32).unsafe_to_char(),
      (111).unsafe_to_char(),
      (102).unsafe_to_char(),
      (32).unsafe_to_char(),
      (98).unsafe_to_char(),
      (117).unsafe_to_char(),
      (99).unsafe_to_char(),
      (107).unsafe_to_char(),
      (101).unsafe_to_char(),
      (116).unsafe_to_char(),
      (115).unsafe_to_char(),
      (32).unsafe_to_char(),
      (119).unsafe_to_char(),
      (105).unsafe_to_char(),
      (116).unsafe_to_char(),
      (104).unsafe_to_char(),
      (32).unsafe_to_char(),
      (56).unsafe_to_char(),
      (32).unsafe_to_char(),
      (101).unsafe_to_char(),
      (110).unsafe_to_char(),
      (116).unsafe_to_char(),
      (114).unsafe_to_char(),
      (105).unsafe_to_char(),
      (101).unsafe_to_char(),
      (115).unsafe_to_char(),
      (58).unsafe_to_char(),
      (32).unsafe_to_char(),
      (48).unsafe_to_char(),
      (10).unsafe_to_char(),
      (110).unsafe_to_char(),
      (117).unsafe_to_char(),
      (109).unsafe_to_char(),
      (98).unsafe_to_char(),
      (101).unsafe_to_char(),
      (114).unsafe_to_char(),
      (32).unsafe_to_char(),
      (111).unsafe_to_char(),
      (102).unsafe_to_char(),
      (32).unsafe_to_char(),
      (98).unsafe_to_char(),
      (117).unsafe_to_char(),
      (99).unsafe_to_char(),
      (107).unsafe_to_char(),
      (101).unsafe_to_char(),
      (116).unsafe_to_char(),
      (115).unsafe_to_char(),
      (32).unsafe_to_char(),
      (119).unsafe_to_char(),
      (105).unsafe_to_char(),
      (116).unsafe_to_char(),
      (104).unsafe_to_char(),
      (32).unsafe_to_char(),
      (57).unsafe_to_char(),
      (32).unsafe_to_char(),
      (101).unsafe_to_char(),
      (110).unsafe_to_char(),
      (116).unsafe_to_char(),
      (114).unsafe_to_char(),
      (105).unsafe_to_char(),
      (101).unsafe_to_char(),
      (115).unsafe_to_char(),
      (58).unsafe_to_char(),
      (32).unsafe_to_char(),
      (48).unsafe_to_char(),
      (10).unsafe_to_char(),
      (110).unsafe_to_char(),
      (117).unsafe_to_char(),
      (109).unsafe_to_char(),
      (98).unsafe_to_char(),
      (101).unsafe_to_char(),
      (114).unsafe_to_char(),
      (32).unsafe_to_char(),
      (111).unsafe_to_char(),
      (102).unsafe_to_char(),
      (32).unsafe_to_char(),
      (98).unsafe_to_char(),
      (117).unsafe_to_char(),
      (99).unsafe_to_char(),
      (107).unsafe_to_char(),
      (101).unsafe_to_char(),
      (116).unsafe_to_char(),
      (115).unsafe_to_char(),
      (32).unsafe_to_char(),
      (119).unsafe_to_char(),
      (105).unsafe_to_char(),
      (116).unsafe_to_char(),
      (104).unsafe_to_char(),
      (32).unsafe_to_char(),
      (49).unsafe_to_char(),
      (48).unsafe_to_char(),
      (32).unsafe_to_char(),
      (111).unsafe_to_char(),
      (114).unsafe_to_char(),
      (32).unsafe_to_char(),
      (109).unsafe_to_char(),
      (111).unsafe_to_char(),
      (114).unsafe_to_char(),
      (101).unsafe_to_char(),
      (32).unsafe_to_char(),
      (101).unsafe_to_char(),
      (110).unsafe_to_char(),
      (116).unsafe_to_char(),
      (114).unsafe_to_char(),
      (105).unsafe_to_char(),
      (101).unsafe_to_char(),
      (115).unsafe_to_char(),
      (58).unsafe_to_char(),
      (32).unsafe_to_char(),
      (48).unsafe_to_char(),
      (10).unsafe_to_char(),
      (97).unsafe_to_char(),
      (118).unsafe_to_char(),
      (101).unsafe_to_char(),
      (114).unsafe_to_char(),
      (97).unsafe_to_char(),
      (103).unsafe_to_char(),
      (101).unsafe_to_char(),
      (32).unsafe_to_char(),
      (115).unsafe_to_char(),
      (101).unsafe_to_char(),
      (97).unsafe_to_char(),
      (114).unsafe_to_char(),
      (99).unsafe_to_char(),
      (104).unsafe_to_char(),
      (32).unsafe_to_char(),
      (100).unsafe_to_char(),
      (105).unsafe_to_char(),
      (115).unsafe_to_char(),
      (116).unsafe_to_char(),
      (97).unsafe_to_char(),
      (110).unsafe_to_char(),
      (99).unsafe_to_char(),
      (101).unsafe_to_char(),
      (32).unsafe_to_char(),
      (102).unsafe_to_char(),
      (111).unsafe_to_char(),
      (114).unsafe_to_char(),
      (32).unsafe_to_char(),
      (101).unsafe_to_char(),
      (110).unsafe_to_char(),
      (116).unsafe_to_char(),
      (114).unsafe_to_char(),
      (121).unsafe_to_char(),
      (58).unsafe_to_char(),
      (32).unsafe_to_char(),
      (49).unsafe_to_char(),
      (46).unsafe_to_char(),
      (48).unsafe_to_char(),
      (125).unsafe_to_char(),
    ]),
    "",
    false,
    "isolated-unit-820",
  )
  check_array_case(
    "array set a {};set k \"\\udfff\";set a($k) 1;list [array names a] [array statistics a]",
    String::from_array([
      (57343).unsafe_to_char(),
      (32).unsafe_to_char(),
      (123).unsafe_to_char(),
      (49).unsafe_to_char(),
      (32).unsafe_to_char(),
      (101).unsafe_to_char(),
      (110).unsafe_to_char(),
      (116).unsafe_to_char(),
      (114).unsafe_to_char(),
      (105).unsafe_to_char(),
      (101).unsafe_to_char(),
      (115).unsafe_to_char(),
      (32).unsafe_to_char(),
      (105).unsafe_to_char(),
      (110).unsafe_to_char(),
      (32).unsafe_to_char(),
      (116).unsafe_to_char(),
      (97).unsafe_to_char(),
      (98).unsafe_to_char(),
      (108).unsafe_to_char(),
      (101).unsafe_to_char(),
      (44).unsafe_to_char(),
      (32).unsafe_to_char(),
      (52).unsafe_to_char(),
      (32).unsafe_to_char(),
      (98).unsafe_to_char(),
      (117).unsafe_to_char(),
      (99).unsafe_to_char(),
      (107).unsafe_to_char(),
      (101).unsafe_to_char(),
      (116).unsafe_to_char(),
      (115).unsafe_to_char(),
      (10).unsafe_to_char(),
      (110).unsafe_to_char(),
      (117).unsafe_to_char(),
      (109).unsafe_to_char(),
      (98).unsafe_to_char(),
      (101).unsafe_to_char(),
      (114).unsafe_to_char(),
      (32).unsafe_to_char(),
      (111).unsafe_to_char(),
      (102).unsafe_to_char(),
      (32).unsafe_to_char(),
      (98).unsafe_to_char(),
      (117).unsafe_to_char(),
      (99).unsafe_to_char(),
      (107).unsafe_to_char(),
      (101).unsafe_to_char(),
      (116).unsafe_to_char(),
      (115).unsafe_to_char(),
      (32).unsafe_to_char(),
      (119).unsafe_to_char(),
      (105).unsafe_to_char(),
      (116).unsafe_to_char(),
      (104).unsafe_to_char(),
      (32).unsafe_to_char(),
      (48).unsafe_to_char(),
      (32).unsafe_to_char(),
      (101).unsafe_to_char(),
      (110).unsafe_to_char(),
      (116).unsafe_to_char(),
      (114).unsafe_to_char(),
      (105).unsafe_to_char(),
      (101).unsafe_to_char(),
      (115).unsafe_to_char(),
      (58).unsafe_to_char(),
      (32).unsafe_to_char(),
      (51).unsafe_to_char(),
      (10).unsafe_to_char(),
      (110).unsafe_to_char(),
      (117).unsafe_to_char(),
      (109).unsafe_to_char(),
      (98).unsafe_to_char(),
      (101).unsafe_to_char(),
      (114).unsafe_to_char(),
      (32).unsafe_to_char(),
      (111).unsafe_to_char(),
      (102).unsafe_to_char(),
      (32).unsafe_to_char(),
      (98).unsafe_to_char(),
      (117).unsafe_to_char(),
      (99).unsafe_to_char(),
      (107).unsafe_to_char(),
      (101).unsafe_to_char(),
      (116).unsafe_to_char(),
      (115).unsafe_to_char(),
      (32).unsafe_to_char(),
      (119).unsafe_to_char(),
      (105).unsafe_to_char(),
      (116).unsafe_to_char(),
      (104).unsafe_to_char(),
      (32).unsafe_to_char(),
      (49).unsafe_to_char(),
      (32).unsafe_to_char(),
      (101).unsafe_to_char(),
      (110).unsafe_to_char(),
      (116).unsafe_to_char(),
      (114).unsafe_to_char(),
      (105).unsafe_to_char(),
      (101).unsafe_to_char(),
      (115).unsafe_to_char(),
      (58).unsafe_to_char(),
      (32).unsafe_to_char(),
      (49).unsafe_to_char(),
      (10).unsafe_to_char(),
      (110).unsafe_to_char(),
      (117).unsafe_to_char(),
      (109).unsafe_to_char(),
      (98).unsafe_to_char(),
      (101).unsafe_to_char(),
      (114).unsafe_to_char(),
      (32).unsafe_to_char(),
      (111).unsafe_to_char(),
      (102).unsafe_to_char(),
      (32).unsafe_to_char(),
      (98).unsafe_to_char(),
      (117).unsafe_to_char(),
      (99).unsafe_to_char(),
      (107).unsafe_to_char(),
      (101).unsafe_to_char(),
      (116).unsafe_to_char(),
      (115).unsafe_to_char(),
      (32).unsafe_to_char(),
      (119).unsafe_to_char(),
      (105).unsafe_to_char(),
      (116).unsafe_to_char(),
      (104).unsafe_to_char(),
      (32).unsafe_to_char(),
      (50).unsafe_to_char(),
      (32).unsafe_to_char(),
      (101).unsafe_to_char(),
      (110).unsafe_to_char(),
      (116).unsafe_to_char(),
      (114).unsafe_to_char(),
      (105).unsafe_to_char(),
      (101).unsafe_to_char(),
      (115).unsafe_to_char(),
      (58).unsafe_to_char(),
      (32).unsafe_to_char(),
      (48).unsafe_to_char(),
      (10).unsafe_to_char(),
      (110).unsafe_to_char(),
      (117).unsafe_to_char(),
      (109).unsafe_to_char(),
      (98).unsafe_to_char(),
      (101).unsafe_to_char(),
      (114).unsafe_to_char(),
      (32).unsafe_to_char(),
      (111).unsafe_to_char(),
      (102).unsafe_to_char(),
      (32).unsafe_to_char(),
      (98).unsafe_to_char(),
      (117).unsafe_to_char(),
      (99).unsafe_to_char(),
      (107).unsafe_to_char(),
      (101).unsafe_to_char(),
      (116).unsafe_to_char(),
      (115).unsafe_to_char(),
      (32).unsafe_to_char(),
      (119).unsafe_to_char(),
      (105).unsafe_to_char(),
      (116).unsafe_to_char(),
      (104).unsafe_to_char(),
      (32).unsafe_to_char(),
      (51).unsafe_to_char(),
      (32).unsafe_to_char(),
      (101).unsafe_to_char(),
      (110).unsafe_to_char(),
      (116).unsafe_to_char(),
      (114).unsafe_to_char(),
      (105).unsafe_to_char(),
      (101).unsafe_to_char(),
      (115).unsafe_to_char(),
      (58).unsafe_to_char(),
      (32).unsafe_to_char(),
      (48).unsafe_to_char(),
      (10).unsafe_to_char(),
      (110).unsafe_to_char(),
      (117).unsafe_to_char(),
      (109).unsafe_to_char(),
      (98).unsafe_to_char(),
      (101).unsafe_to_char(),
      (114).unsafe_to_char(),
      (32).unsafe_to_char(),
      (111).unsafe_to_char(),
      (102).unsafe_to_char(),
      (32).unsafe_to_char(),
      (98).unsafe_to_char(),
      (117).unsafe_to_char(),
      (99).unsafe_to_char(),
      (107).unsafe_to_char(),
      (101).unsafe_to_char(),
      (116).unsafe_to_char(),
      (115).unsafe_to_char(),
      (32).unsafe_to_char(),
      (119).unsafe_to_char(),
      (105).unsafe_to_char(),
      (116).unsafe_to_char(),
      (104).unsafe_to_char(),
      (32).unsafe_to_char(),
      (52).unsafe_to_char(),
      (32).unsafe_to_char(),
      (101).unsafe_to_char(),
      (110).unsafe_to_char(),
      (116).unsafe_to_char(),
      (114).unsafe_to_char(),
      (105).unsafe_to_char(),
      (101).unsafe_to_char(),
      (115).unsafe_to_char(),
      (58).unsafe_to_char(),
      (32).unsafe_to_char(),
      (48).unsafe_to_char(),
      (10).unsafe_to_char(),
      (110).unsafe_to_char(),
      (117).unsafe_to_char(),
      (109).unsafe_to_char(),
      (98).unsafe_to_char(),
      (101).unsafe_to_char(),
      (114).unsafe_to_char(),
      (32).unsafe_to_char(),
      (111).unsafe_to_char(),
      (102).unsafe_to_char(),
      (32).unsafe_to_char(),
      (98).unsafe_to_char(),
      (117).unsafe_to_char(),
      (99).unsafe_to_char(),
      (107).unsafe_to_char(),
      (101).unsafe_to_char(),
      (116).unsafe_to_char(),
      (115).unsafe_to_char(),
      (32).unsafe_to_char(),
      (119).unsafe_to_char(),
      (105).unsafe_to_char(),
      (116).unsafe_to_char(),
      (104).unsafe_to_char(),
      (32).unsafe_to_char(),
      (53).unsafe_to_char(),
      (32).unsafe_to_char(),
      (101).unsafe_to_char(),
      (110).unsafe_to_char(),
      (116).unsafe_to_char(),
      (114).unsafe_to_char(),
      (105).unsafe_to_char(),
      (101).unsafe_to_char(),
      (115).unsafe_to_char(),
      (58).unsafe_to_char(),
      (32).unsafe_to_char(),
      (48).unsafe_to_char(),
      (10).unsafe_to_char(),
      (110).unsafe_to_char(),
      (117).unsafe_to_char(),
      (109).unsafe_to_char(),
      (98).unsafe_to_char(),
      (101).unsafe_to_char(),
      (114).unsafe_to_char(),
      (32).unsafe_to_char(),
      (111).unsafe_to_char(),
      (102).unsafe_to_char(),
      (32).unsafe_to_char(),
      (98).unsafe_to_char(),
      (117).unsafe_to_char(),
      (99).unsafe_to_char(),
      (107).unsafe_to_char(),
      (101).unsafe_to_char(),
      (116).unsafe_to_char(),
      (115).unsafe_to_char(),
      (32).unsafe_to_char(),
      (119).unsafe_to_char(),
      (105).unsafe_to_char(),
      (116).unsafe_to_char(),
      (104).unsafe_to_char(),
      (32).unsafe_to_char(),
      (54).unsafe_to_char(),
      (32).unsafe_to_char(),
      (101).unsafe_to_char(),
      (110).unsafe_to_char(),
      (116).unsafe_to_char(),
      (114).unsafe_to_char(),
      (105).unsafe_to_char(),
      (101).unsafe_to_char(),
      (115).unsafe_to_char(),
      (58).unsafe_to_char(),
      (32).unsafe_to_char(),
      (48).unsafe_to_char(),
      (10).unsafe_to_char(),
      (110).unsafe_to_char(),
      (117).unsafe_to_char(),
      (109).unsafe_to_char(),
      (98).unsafe_to_char(),
      (101).unsafe_to_char(),
      (114).unsafe_to_char(),
      (32).unsafe_to_char(),
      (111).unsafe_to_char(),
      (102).unsafe_to_char(),
      (32).unsafe_to_char(),
      (98).unsafe_to_char(),
      (117).unsafe_to_char(),
      (99).unsafe_to_char(),
      (107).unsafe_to_char(),
      (101).unsafe_to_char(),
      (116).unsafe_to_char(),
      (115).unsafe_to_char(),
      (32).unsafe_to_char(),
      (119).unsafe_to_char(),
      (105).unsafe_to_char(),
      (116).unsafe_to_char(),
      (104).unsafe_to_char(),
      (32).unsafe_to_char(),
      (55).unsafe_to_char(),
      (32).unsafe_to_char(),
      (101).unsafe_to_char(),
      (110).unsafe_to_char(),
      (116).unsafe_to_char(),
      (114).unsafe_to_char(),
      (105).unsafe_to_char(),
      (101).unsafe_to_char(),
      (115).unsafe_to_char(),
      (58).unsafe_to_char(),
      (32).unsafe_to_char(),
      (48).unsafe_to_char(),
      (10).unsafe_to_char(),
      (110).unsafe_to_char(),
      (117).unsafe_to_char(),
      (109).unsafe_to_char(),
      (98).unsafe_to_char(),
      (101).unsafe_to_char(),
      (114).unsafe_to_char(),
      (32).unsafe_to_char(),
      (111).unsafe_to_char(),
      (102).unsafe_to_char(),
      (32).unsafe_to_char(),
      (98).unsafe_to_char(),
      (117).unsafe_to_char(),
      (99).unsafe_to_char(),
      (107).unsafe_to_char(),
      (101).unsafe_to_char(),
      (116).unsafe_to_char(),
      (115).unsafe_to_char(),
      (32).unsafe_to_char(),
      (119).unsafe_to_char(),
      (105).unsafe_to_char(),
      (116).unsafe_to_char(),
      (104).unsafe_to_char(),
      (32).unsafe_to_char(),
      (56).unsafe_to_char(),
      (32).unsafe_to_char(),
      (101).unsafe_to_char(),
      (110).unsafe_to_char(),
      (116).unsafe_to_char(),
      (114).unsafe_to_char(),
      (105).unsafe_to_char(),
      (101).unsafe_to_char(),
      (115).unsafe_to_char(),
      (58).unsafe_to_char(),
      (32).unsafe_to_char(),
      (48).unsafe_to_char(),
      (10).unsafe_to_char(),
      (110).unsafe_to_char(),
      (117).unsafe_to_char(),
      (109).unsafe_to_char(),
      (98).unsafe_to_char(),
      (101).unsafe_to_char(),
      (114).unsafe_to_char(),
      (32).unsafe_to_char(),
      (111).unsafe_to_char(),
      (102).unsafe_to_char(),
      (32).unsafe_to_char(),
      (98).unsafe_to_char(),
      (117).unsafe_to_char(),
      (99).unsafe_to_char(),
      (107).unsafe_to_char(),
      (101).unsafe_to_char(),
      (116).unsafe_to_char(),
      (115).unsafe_to_char(),
      (32).unsafe_to_char(),
      (119).unsafe_to_char(),
      (105).unsafe_to_char(),
      (116).unsafe_to_char(),
      (104).unsafe_to_char(),
      (32).unsafe_to_char(),
      (57).unsafe_to_char(),
      (32).unsafe_to_char(),
      (101).unsafe_to_char(),
      (110).unsafe_to_char(),
      (116).unsafe_to_char(),
      (114).unsafe_to_char(),
      (105).unsafe_to_char(),
      (101).unsafe_to_char(),
      (115).unsafe_to_char(),
      (58).unsafe_to_char(),
      (32).unsafe_to_char(),
      (48).unsafe_to_char(),
      (10).unsafe_to_char(),
      (110).unsafe_to_char(),
      (117).unsafe_to_char(),
      (109).unsafe_to_char(),
      (98).unsafe_to_char(),
      (101).unsafe_to_char(),
      (114).unsafe_to_char(),
      (32).unsafe_to_char(),
      (111).unsafe_to_char(),
      (102).unsafe_to_char(),
      (32).unsafe_to_char(),
      (98).unsafe_to_char(),
      (117).unsafe_to_char(),
      (99).unsafe_to_char(),
      (107).unsafe_to_char(),
      (101).unsafe_to_char(),
      (116).unsafe_to_char(),
      (115).unsafe_to_char(),
      (32).unsafe_to_char(),
      (119).unsafe_to_char(),
      (105).unsafe_to_char(),
      (116).unsafe_to_char(),
      (104).unsafe_to_char(),
      (32).unsafe_to_char(),
      (49).unsafe_to_char(),
      (48).unsafe_to_char(),
      (32).unsafe_to_char(),
      (111).unsafe_to_char(),
      (114).unsafe_to_char(),
      (32).unsafe_to_char(),
      (109).unsafe_to_char(),
      (111).unsafe_to_char(),
      (114).unsafe_to_char(),
      (101).unsafe_to_char(),
      (32).unsafe_to_char(),
      (101).unsafe_to_char(),
      (110).unsafe_to_char(),
      (116).unsafe_to_char(),
      (114).unsafe_to_char(),
      (105).unsafe_to_char(),
      (101).unsafe_to_char(),
      (115).unsafe_to_char(),
      (58).unsafe_to_char(),
      (32).unsafe_to_char(),
      (48).unsafe_to_char(),
      (10).unsafe_to_char(),
      (97).unsafe_to_char(),
      (118).unsafe_to_char(),
      (101).unsafe_to_char(),
      (114).unsafe_to_char(),
      (97).unsafe_to_char(),
      (103).unsafe_to_char(),
      (101).unsafe_to_char(),
      (32).unsafe_to_char(),
      (115).unsafe_to_char(),
      (101).unsafe_to_char(),
      (97).unsafe_to_char(),
      (114).unsafe_to_char(),
      (99).unsafe_to_char(),
      (104).unsafe_to_char(),
      (32).unsafe_to_char(),
      (100).unsafe_to_char(),
      (105).unsafe_to_char(),
      (115).unsafe_to_char(),
      (116).unsafe_to_char(),
      (97).unsafe_to_char(),
      (110).unsafe_to_char(),
      (99).unsafe_to_char(),
      (101).unsafe_to_char(),
      (32).unsafe_to_char(),
      (102).unsafe_to_char(),
      (111).unsafe_to_char(),
      (114).unsafe_to_char(),
      (32).unsafe_to_char(),
      (101).unsafe_to_char(),
      (110).unsafe_to_char(),
      (116).unsafe_to_char(),
      (114).unsafe_to_char(),
      (121).unsafe_to_char(),
      (58).unsafe_to_char(),
      (32).unsafe_to_char(),
      (49).unsafe_to_char(),
      (46).unsafe_to_char(),
      (48).unsafe_to_char(),
      (125).unsafe_to_char(),
    ]),
    "",
    false,
    "isolated-unit-821",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k2\\\"\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a b\\\"\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a\\\" \\\"89\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a b\\\"\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a\\\"\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"62\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 s-2-a} {0 {}} {0 {}} {0 {}} {0 {}} {1 {couldn't find search \"s-2-a\"}} {1 {couldn't find search \"s-2-a\"}} {1 {couldn't find search \"s-2-a\"}} {1 {couldn't find search \"s-2-a\"}} {1 {couldn't find search \"s-2-a\"}} {0 {}} {1 {couldn't find search \"s-2-a\"}} {0 s-2-a} {0 s-3-a} {0 {}} {0 {}} {1 {couldn't find search \"s-3-a\"}} {0 {}} {1 {couldn't find search \"s-3-a\"}} {0 s-1-a} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 s-2-a}} {{a b}} {{a b} 62} {1 entries in table, 4 buckets\nnumber of buckets with 0 entries: 3\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "state-trace-822",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k0) 35\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k1\\\" \\\"98\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set a(c) 67\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set a(k2) 90\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k0\\\"\" r];lappend events [list $c $r];set c [catch \"set a(c) 2\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k2\\\"\" r];lappend events [list $c $r];set c [catch \"set a() 89\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"39\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"\\\" \\\"86\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 0} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 35} {0 {}} {0 67} {0 s-1-a} {0 90} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 2} {0 s-1-a} {0 {}} {0 89} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a}} {{} k1 {a b} c} {{} 86 k1 98 {a b} 39 c 2} {4 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 2\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.5}",
    "", false, "state-trace-823",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array set a \\[list \\\"\\\" \\\"28\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k2\\\" \\\"18\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k1\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k0) 76\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"\\\" \\\"21\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"\\\" \\\"68\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k0\\\" \\\"97\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k1\\\" \\\"50\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k0\\\" \\\"67\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"50\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k1\\\"\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"b\\\"\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k2\\\" \\\"79\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {0 {}} {0 s-1-a} {0 {}} {0 1} {0 76} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 {}} {0 s-2-a} {0 1} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 s-1-a} {0 {}} {0 1}} {{} k2 k0} {{} 68 k2 79 k0 67} {3 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 3\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "state-trace-824",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"c\\\"\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"94\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set a(k1) 12\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set a() 14\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a\\\"\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 12} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 14} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 s-1-a} {0 s-2-a} {0 {}} {1 {couldn't find search \"s-2-a\"}} {0 s-2-a}} {{} k1 b} {{} 14 k1 12 b 94} {3 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.3}",
    "", false, "state-trace-825",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array unset a \\\"k1\\\"\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"c\\\"\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a() 27\" r];lappend events [list $c $r];set c [catch \"set a(k0) 39\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"\\\" \\\"65\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k0\\\"\" r];lappend events [list $c $r];set c [catch \"set a(b) 97\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"95\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k2\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"33\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k0) 60\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k1\\\"\" r];lappend events [list $c $r];set c [catch \"set a() 11\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k2\\\" \\\"4\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {0 {}} {0 0} {0 0} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 27} {0 39} {0 {}} {0 {}} {0 97} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 60} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 11} {0 {}} {1 {couldn't find search \"s-1-a\"}}} {{} k2 b k0 {a b}} {{} 11 k2 4 b 33 k0 60 {a b} 95} {5 entries in table, 4 buckets\nnumber of buckets with 0 entries: 0\nnumber of buckets with 1 entries: 3\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.2}",
    "", false, "state-trace-826",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"\\\" \\\"54\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a\\\" \\\"30\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"72\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a\\\" \\\"34\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(c) 64\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"c\\\"\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a b\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k1\\\" \\\"20\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set a(k2) 2\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"\\\" \\\"51\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 0} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 s-1-a} {0 {}} {0 1} {0 64} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 {}} {0 a} {0 {}} {0 {}} {0 2} {0 {}} {1 {couldn't find search \"s-1-a\"}}} {k1 {} k2 a b} {k1 20 {} 51 k2 2 a 34 b 72} {5 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 2\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.4}",
    "", false, "state-trace-827",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"set a() 11\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(b) 20\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"4\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a\\\"\" r];lappend events [list $c $r];set c [catch \"set a(c) 62\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k0\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k2\\\" \\\"43\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k1\\\"\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"c\\\"\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a b\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"\\\" \\\"67\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k1\\\" \\\"98\\\"\\]\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 11} {1 {couldn't find search \"s-1-a\"}} {0 20} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 62} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 1} {0 {}} {0 {}}} {k1 k2 b} {k1 98 k2 43 b 4} {3 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 3\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "state-trace-828",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k0\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k1\\\"\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k1\\\" \\\"69\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(b) 78\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"9\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 s-2-a} {0 s-3-a} {0 0} {0 {}} {0 0} {0 0} {0 0} {0 {}} {0 {}} {0 s-3-a} {0 {}} {0 0} {0 {}} {1 {couldn't find search \"s-3-a\"}} {1 {couldn't find search \"s-3-a\"}} {0 78} {1 {couldn't find search \"s-3-a\"}} {0 {}} {1 {couldn't find search \"s-3-a\"}} {1 {couldn't find search \"s-3-a\"}} {1 {couldn't find search \"s-3-a\"}} {1 {couldn't find search \"s-3-a\"}} {1 {couldn't find search \"s-3-a\"}} {1 {couldn't find search \"s-3-a\"}}} {k1 b} {k1 69 b 9} {2 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 2\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "state-trace-829",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array set a \\[list \\\"b\\\" \\\"35\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set a(b) 11\" r];lappend events [list $c $r];set c [catch \"set a(k2) 83\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set a(a) 66\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"b\\\"\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k0\\\" \\\"92\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set a(c) 61\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k2\\\"\" r];lappend events [list $c $r];set c [catch \"set a() 10\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"b\\\"\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k2\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"c\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k0) 43\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {0 11} {0 83} {0 s-1-a} {0 66} {0 s-1-a} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 61} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 {}} {0 10} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 43}} {{} a k0} {{} 10 a 66 k0 43} {3 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 3\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "state-trace-830",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a\\\" \\\"33\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(a) 97\" r];lappend events [list $c $r];set c [catch \"set a(k2) 27\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k1\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k2\\\" \\\"20\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set a(a) 77\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k2\\\" \\\"28\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"16\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"b\\\"\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 s-2-a} {0 {}} {0 {}} {0 {}} {1 {couldn't find search \"s-2-a\"}} {0 s-1-a} {0 a} {0 {}} {0 97} {0 27} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {0 77} {0 s-1-a} {0 k2} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}}} {k2 a} {k2 28 a 77} {2 entries in table, 4 buckets\nnumber of buckets with 0 entries: 3\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.5}",
    "", false, "state-trace-831",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"47\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"\\\" \\\"66\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"b\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"c\\\" \\\"55\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set a(k2) 38\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k1\\\" \\\"8\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"76\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set a(a) 20\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"b\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 s-2-a} {0 {}} {1 {couldn't find search \"s-2-a\"}} {0 {}} {1 {couldn't find search \"s-2-a\"}} {0 s-1-a} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {0 38} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 20} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}}} {k1 {} a k2 c {a b}} {k1 8 {} 66 a 20 k2 38 c 55 {a b} 76} {6 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 3\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.5}",
    "", false, "state-trace-832",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array unset a \\\"k2\\\"\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k2) 56\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k0) 5\" r];lappend events [list $c $r];set c [catch \"set a(a) 18\" r];lappend events [list $c $r];set c [catch \"set a(b) 91\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(b) 40\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"c\\\" \\\"96\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"c\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"85\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(a) 91\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a b\\\"\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 56} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 5} {0 18} {0 91} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 40} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 91} {0 {}} {0 s-1-a} {0 1}} {a k2 b k0} {a 91 k2 56 b 40 k0 5} {4 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 2\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.2}",
    "", false, "state-trace-833",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k1) 93\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k2) 29\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(c) 32\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"c\\\" \\\"27\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"\\\" \\\"8\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"\\\"\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {0 {}} {0 93} {0 s-1-a} {0 k1} {0 0} {0 29} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 s-2-a} {0 k1} {0 32} {1 {couldn't find search \"s-2-a\"}} {0 s-1-a} {0 k1} {0 {}} {0 {}} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 s-2-a}} {k1 k2 c} {k1 93 k2 29 c 27} {3 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 3\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "state-trace-834",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array set a \\[list \\\"k1\\\" \\\"11\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k0\\\" \\\"47\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set a() 48\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k2\\\"\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a\\\"\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"\\\"\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"c\\\" \\\"30\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k2\\\"\" r];lappend events [list $c $r];set c [catch \"set a(k1) 63\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"b\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"\\\" \\\"88\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"2\\\"\\]\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {0 s-1-a} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 48} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {0 {}} {0 63} {0 s-1-a} {0 s-2-a} {0 k1} {0 {}} {0 {}} {0 {}}} {{} k1 {a b} c k0} {{} 88 k1 63 {a b} 2 c 30 k0 47} {5 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 1\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.8}",
    "", false, "state-trace-835",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(b) 53\" r];lappend events [list $c $r];set c [catch \"set a(k1) 44\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a b\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"26\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"49\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(c) 58\" r];lappend events [list $c $r];set c [catch \"set a(k1) 51\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k0\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 53} {0 44} {0 {}} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 58} {0 51} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 1} {0 1} {0 {}} {0 1}} {k1 b c} {k1 51 b 49 c 58} {3 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 3\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "state-trace-836",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array unset a \\\"c\\\"\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"\\\"\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"\\\"\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k1\\\"\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a\\\" \\\"94\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a() 32\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set a() 89\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"81\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"4\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"\\\" \\\"18\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {0 {}} {0 s-2-a} {0 0} {0 0} {0 {}} {1 {couldn't find search \"s-2-a\"}} {0 {}} {0 {}} {0 s-2-a} {0 s-3-a} {0 {}} {1 {couldn't find search \"s-3-a\"}} {1 {couldn't find search \"s-3-a\"}} {0 32} {0 s-1-a} {0 1} {0 s-2-a} {0 89} {0 {}} {0 {}} {0 {}} {1 {couldn't find search \"s-2-a\"}} {1 {couldn't find search \"s-2-a\"}}} {{} a b {a b}} {{} 18 a 94 b 81 {a b} 4} {4 entries in table, 4 buckets\nnumber of buckets with 0 entries: 0\nnumber of buckets with 1 entries: 4\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "state-trace-837",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k1\\\" \\\"45\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k2\\\" \\\"11\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k2\\\" \\\"32\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"78\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(b) 75\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k1) 19\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 0} {0 {}} {0 0} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 s-1-a} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 75} {1 {couldn't find search \"s-1-a\"}} {0 19} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}}} {k1 k2 b {a b}} {k1 19 k2 32 b 75 {a b} 78} {4 entries in table, 4 buckets\nnumber of buckets with 0 entries: 0\nnumber of buckets with 1 entries: 4\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "state-trace-838",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a b\\\"\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set a(k1) 33\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(c) 11\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"40\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"\\\" \\\"80\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"c\\\" \\\"11\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k0\\\" \\\"16\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 33} {0 s-1-a} {0 {}} {0 11} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 1} {0 {}} {0 {}} {0 s-1-a} {0 s-2-a} {0 s-3-a} {0 1} {0 {}} {0 {}} {1 {couldn't find search \"s-3-a\"}} {0 {}} {1 {couldn't find search \"s-3-a\"}} {1 {couldn't find search \"s-3-a\"}}} {{} k1 b k0 c} {{} 80 k1 33 b 40 k0 16 c 11} {5 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 2\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.4}",
    "", false, "state-trace-839",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k2\\\" \\\"49\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k2\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a() 2\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"\\\"\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a b\\\"\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(a) 71\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a\\\" \\\"66\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set a(c) 81\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k1\\\"\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 2} {0 {}} {0 s-1-a} {0 s-2-a} {0 {}} {0 {}} {0 {}} {0 71} {1 {couldn't find search \"s-2-a\"}} {0 {}} {1 {couldn't find search \"s-2-a\"}} {1 {couldn't find search \"s-2-a\"}} {0 s-1-a} {0 a} {0 s-2-a} {0 s-3-a} {0 81} {0 {}}} {a c} {a 66 c 81} {2 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 2\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "state-trace-840",
  )
}

///|
test "Tcl array cases 841 through 880" {
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k0) 55\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"\\\"\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set a(b) 48\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a\\\"\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"98\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"89\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"c\\\"\" r];lappend events [list $c $r];set c [catch \"set a(a) 92\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"c\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a\\\" \\\"65\\\"\\]\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 55} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 48} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {0 {}} {0 92} {0 s-1-a} {0 a} {0 {}} {0 {}}} {a b {a b} k0} {a 65 b 48 {a b} 89 k0 55} {4 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 2\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.2}",
    "", false, "state-trace-841",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array set a \\[list \\\"k0\\\" \\\"5\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set a(k0) 80\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(c) 62\" r];lappend events [list $c $r];set c [catch \"set a(k1) 99\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"b\\\"\" r];lappend events [list $c $r];set c [catch \"set a(k1) 51\" r];lappend events [list $c $r];set c [catch \"set a(k0) 1\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"c\\\" \\\"67\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k2\\\" \\\"26\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a\\\"\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {0 80} {0 s-1-a} {0 k0} {0 62} {0 99} {0 {}} {0 51} {0 1} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 s-1-a} {0 1} {0 k1} {0 k2} {0 {}} {0 c}} {k1 k2 c k0} {k1 51 k2 26 c 67 k0 1} {4 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 2\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.2}",
    "", false, "state-trace-842",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"set a() 51\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"c\\\"\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a b\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k0) 15\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"29\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k0\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set a(a) 57\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k1\\\"\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k0) 1\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 51} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 15} {0 s-1-a} {0 {}} {0 k0} {0 0} {0 {}} {0 s-1-a} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 1} {0 {}} {0 s-1-a} {0 57} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 1} {1 {couldn't find search \"s-1-a\"}}} {{} a k0 {a b}} {{} 51 a 57 k0 1 {a b} 29} {4 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 2\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.2}",
    "", false, "state-trace-843",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"set a() 13\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a b\\\"\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"\\\"\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"b\\\"\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k0\\\"\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"\\\"\" r];lappend events [list $c $r];set c [catch \"set a(k1) 20\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k1\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(c) 97\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k2\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"85\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"c\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k2\\\" \\\"6\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"\\\" \\\"92\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k2\\\"\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 13} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 {}} {0 {}} {0 {}} {0 20} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 97} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}}} {{} {a b}} {{} 92 {a b} 85} {2 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 2\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "state-trace-844",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array unset a \\\"k2\\\"\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"\\\"\" r];lappend events [list $c $r];set c [catch \"set a(k1) 46\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k0\\\" \\\"59\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k2\\\" \\\"79\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k0\\\" \\\"80\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"c\\\"\" r];lappend events [list $c $r];set c [catch \"set a(a) 34\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set a(k0) 12\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k1\\\" \\\"11\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(c) 76\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {0 {}} {0 46} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {0 34} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 12} {0 {}} {0 1} {0 s-2-a} {0 1} {0 76} {1 {couldn't find search \"s-2-a\"}} {0 s-1-a} {0 s-2-a}} {k1 a k2 c k0} {k1 11 a 34 k2 79 c 76 k0 12} {5 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 2\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.4}",
    "", false, "state-trace-845",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"set a() 42\" r];lappend events [list $c $r];set c [catch \"set a(c) 1\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(c) 16\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a\\\" \\\"60\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k2\\\"\" r];lappend events [list $c $r];set c [catch \"set a(k1) 10\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k1) 36\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"27\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set a(k2) 29\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k1\\\" \\\"90\\\"\\]\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 42} {0 1} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 16} {0 s-1-a} {0 {}} {0 {}} {0 10} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 {}} {0 36} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 s-1-a} {0 s-2-a} {0 29} {0 {}}} {k1 {} k2 a {a b} c} {k1 90 {} 42 k2 29 a 60 {a b} 27 c 16} {6 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 3\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.5}",
    "", false, "state-trace-846",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array set a \\[list \\\"k0\\\" \\\"61\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"50\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k0\\\" \\\"46\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set a(a) 51\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a b\\\"\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k2) 56\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k1\\\" \\\"64\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(a) 61\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {0 {}} {0 {}} {0 51} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 s-1-a} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 56} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 61} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a}} {k1 k2 a b k0} {k1 64 k2 56 a 61 b 50 k0 46} {5 entries in table, 4 buckets\nnumber of buckets with 0 entries: 0\nnumber of buckets with 1 entries: 3\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.2}",
    "", false, "state-trace-847",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a\\\" \\\"86\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set a(k0) 17\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"\\\" \\\"86\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k2\\\"\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k0\\\"\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k1\\\"\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set a(k1) 30\" r];lappend events [list $c $r];set c [catch \"set a(c) 37\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k2\\\" \\\"27\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 0} {0 {}} {0 17} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 {}} {0 s-1-a} {0 {}} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 30} {0 37} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 {}} {1 {couldn't find search \"s-1-a\"}}} {k1 {} k2 a c} {k1 30 {} 86 k2 27 a 86 c 37} {5 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 2\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.4}",
    "", false, "state-trace-848",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array unset a \\\"c\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"\\\" \\\"97\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k2) 38\" r];lappend events [list $c $r];set c [catch \"set a(k2) 67\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"53\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a\\\"\" r];lappend events [list $c $r];set c [catch \"set a(k2) 44\" r];lappend events [list $c $r];set c [catch \"set a(a) 5\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"0\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set a(a) 73\" r];lappend events [list $c $r];set c [catch \"set a() 17\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k0) 72\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k2) 23\" r];lappend events [list $c $r];set c [catch \"set a(k0) 73\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 38} {0 67} {0 {}} {0 {}} {0 44} {0 5} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 s-1-a} {0 73} {0 17} {0 {}} {0 72} {1 {couldn't find search \"s-1-a\"}} {0 23} {0 73} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 1} {0 s-2-a}} {{} a k2 b k0 {a b}} {{} 17 a 73 k2 23 b 53 k0 73 {a b} 0} {6 entries in table, 4 buckets\nnumber of buckets with 0 entries: 0\nnumber of buckets with 1 entries: 2\nnumber of buckets with 2 entries: 2\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.3}",
    "", false, "state-trace-849",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array unset a \\\"k1\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"0\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k2) 94\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"c\\\"\" r];lappend events [list $c $r];set c [catch \"set a(k1) 47\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a b\\\"\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k1\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k0\\\" \\\"62\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {0 0} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 s-2-a} {0 1} {0 {}} {1 {couldn't find search \"s-2-a\"}} {0 94} {1 {couldn't find search \"s-2-a\"}} {0 s-1-a} {0 k2} {0 s-2-a} {0 {}} {0 47} {1 {couldn't find search \"s-2-a\"}} {1 {couldn't find search \"s-2-a\"}} {0 {}} {0 {}} {0 {}} {1 {couldn't find search \"s-2-a\"}}} {k2 k0} {k2 94 k0 62} {2 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 2\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "state-trace-850",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array set a \\[list \\\"a\\\" \\\"36\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"\\\" \\\"88\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set a(a) 82\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k0\\\" \\\"76\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(c) 23\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"98\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a\\\" \\\"57\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {0 s-1-a} {0 1} {0 {}} {0 82} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 23} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 s-2-a} {0 1} {0 {}} {1 {couldn't find search \"s-2-a\"}} {1 {couldn't find search \"s-2-a\"}} {0 {}} {1 {couldn't find search \"s-2-a\"}} {0 s-1-a} {0 {}} {0 s-2-a} {0 {}} {0 {}}} {{} a {a b} c k0} {{} 88 a 57 {a b} 98 c 23 k0 76} {5 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 2\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 1\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.6}",
    "", false, "state-trace-851",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"c\\\" \\\"5\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"93\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set a(k2) 16\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k1\\\"\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set a() 26\" r];lappend events [list $c $r];set c [catch \"set a(k1) 14\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 0} {0 {}} {0 s-1-a} {0 1} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 {}} {0 16} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 s-1-a} {0 {}} {0 26} {0 14} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a}} {k1 {} k2 {a b} c} {k1 14 {} 26 k2 16 {a b} 93 c 5} {5 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 2\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.4}",
    "", false, "state-trace-852",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a b\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"68\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a\\\"\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k2\\\"\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k1\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a() 59\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a b\\\"\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"c\\\"\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 0} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {0 s-1-a} {0 {}} {0 {a b}} {0 {}} {0 {}} {0 0} {0 {}} {0 0} {0 0} {0 0} {0 59} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}}} {{}} {{} 59} {1 entries in table, 4 buckets\nnumber of buckets with 0 entries: 3\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "state-trace-853",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(a) 91\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set a(k2) 90\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"b\\\"\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"c\\\"\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k2\\\"\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"c\\\"\" r];lappend events [list $c $r];set c [catch \"set a(a) 73\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"\\\" \\\"96\\\"\\]\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 s-2-a} {0 {}} {0 0} {0 0} {0 0} {0 91} {0 s-1-a} {0 90} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 {}} {0 73} {0 1} {0 s-2-a} {0 a} {0 {}}} {{} a} {{} 96 a 73} {2 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 2\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "state-trace-854",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k2\\\" \\\"65\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set a(k2) 86\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a() 49\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"\\\"\" r];lappend events [list $c $r];set c [catch \"set a(k0) 78\" r];lappend events [list $c $r];set c [catch \"set a() 70\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a b\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k2) 81\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a b\\\"\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(c) 21\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k1) 72\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a\\\" \\\"69\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"2\\\"\\]\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 86} {0 1} {0 1} {0 49} {0 {}} {0 78} {0 70} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 81} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 21} {1 {couldn't find search \"s-1-a\"}} {0 72} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}}} {k1 {} a k2 b c k0} {k1 72 {} 70 a 69 k2 81 b 2 c 21 k0 78} {7 entries in table, 4 buckets\nnumber of buckets with 0 entries: 0\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 3\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.4}",
    "", false, "state-trace-855",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set a(a) 57\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"86\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"6\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k0) 38\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"\\\" \\\"72\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"72\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a\\\"\" r];lappend events [list $c $r];set c [catch \"set a(k0) 75\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k2) 4\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a\\\" \\\"60\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(b) 4\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k0) 24\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {0 s-1-a} {0 57} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 38} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 75} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 4} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 4} {1 {couldn't find search \"s-1-a\"}} {0 24}} {{} a k2 b k0 {a b}} {{} 72 a 60 k2 4 b 4 k0 24 {a b} 72} {6 entries in table, 4 buckets\nnumber of buckets with 0 entries: 0\nnumber of buckets with 1 entries: 2\nnumber of buckets with 2 entries: 2\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.3}",
    "", false, "state-trace-856",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array unset a \\\"k2\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k1) 6\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"b\\\"\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"\\\"\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k1\\\"\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"c\\\"\" r];lappend events [list $c $r];set c [catch \"set a(c) 66\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"b\\\"\" r];lappend events [list $c $r];set c [catch \"set a(k2) 4\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"\\\" \\\"74\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"34\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"\\\" \\\"13\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k2\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"c\\\" \\\"6\\\"\\]\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {0 0} {0 6} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 s-1-a} {0 k1} {0 {}} {0 {}} {0 {}} {0 s-1-a} {0 0} {0 {}} {0 66} {0 {}} {0 4} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {0 {}} {0 {}} {0 s-1-a} {0 {}} {0 {}}} {{} b c} {{} 13 b 34 c 6} {3 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 3\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "state-trace-857",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array set a \\[list \\\"a\\\" \\\"54\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k1\\\"\" r];lappend events [list $c $r];set c [catch \"set a(k0) 91\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k2\\\" \\\"70\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k0\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a\\\" \\\"79\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"c\\\" \\\"38\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set a(c) 99\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 91} {0 s-1-a} {0 1} {0 1} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 1} {0 {}} {0 {}} {0 {}} {0 99} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 {}}} {k2 a c} {k2 70 a 79 c 99} {3 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.3}",
    "", false, "state-trace-858",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array unset a \\\"b\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k2\\\"\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k0\\\" \\\"73\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k2) 35\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k0\\\"\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"c\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k1\\\"\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {0 0} {0 {}} {0 {}} {0 {}} {0 0} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 35} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 1} {0 k2} {0 k0} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a}} k2 {k2 35} {1 entries in table, 4 buckets\nnumber of buckets with 0 entries: 3\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "state-trace-859",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"61\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set a() 25\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a b\\\"\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a b\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"84\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"c\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k2\\\" \\\"85\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set a(a) 97\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 {}} {0 s-1-a} {0 {}} {0 25} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {0 {}} {0 s-1-a} {0 97} {0 s-1-a} {0 1}} {{} a k2 b {a b}} {{} 25 a 97 k2 85 b 61 {a b} 84} {5 entries in table, 4 buckets\nnumber of buckets with 0 entries: 0\nnumber of buckets with 1 entries: 3\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.2}",
    "", false, "state-trace-860",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a() 17\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k2\\\" \\\"57\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"97\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"79\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"5\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"67\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"89\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a\\\"\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"c\\\"\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"c\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"\\\" \\\"24\\\"\\]\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 0} {0 0} {0 17} {0 {}} {0 {}} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 1} {0 {}} {0 1} {0 s-2-a} {0 {}} {0 {}} {0 {}} {0 s-3-a} {0 s-4-a} {0 s-5-a} {0 {}} {0 {}} {0 {}}} {{} k2 b {a b}} {{} 24 k2 57 b 89 {a b} 5} {4 entries in table, 4 buckets\nnumber of buckets with 0 entries: 0\nnumber of buckets with 1 entries: 4\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "state-trace-861",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"c\\\" \\\"71\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set a() 18\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k2\\\" \\\"40\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"c\\\" \\\"69\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a b\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"\\\"\" r];lappend events [list $c $r];set c [catch \"set a(k0) 22\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k0\\\"\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k1\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k1) 5\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {0 {}} {0 18} {0 {}} {0 s-1-a} {0 s-2-a} {0 {}} {0 {}} {0 k2} {0 1} {0 {}} {0 1} {0 {}} {0 22} {1 {couldn't find search \"s-2-a\"}} {1 {couldn't find search \"s-2-a\"}} {1 {couldn't find search \"s-2-a\"}} {1 {couldn't find search \"s-2-a\"}} {1 {couldn't find search \"s-2-a\"}} {0 {}} {0 {}} {1 {couldn't find search \"s-2-a\"}} {1 {couldn't find search \"s-2-a\"}} {0 5}} {k1 k2 c} {k1 5 k2 40 c 69} {3 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 3\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "state-trace-862",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"\\\"\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k0\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"55\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k1\\\" \\\"37\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set a() 98\" r];lappend events [list $c $r];set c [catch \"set a(b) 58\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"c\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a() 93\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"53\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"\\\" \\\"27\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {0 {}} {0 {}} {0 {}} {0 s-1-a} {0 s-2-a} {0 {}} {0 {}} {0 98} {0 58} {1 {couldn't find search \"s-2-a\"}} {1 {couldn't find search \"s-2-a\"}} {0 {}} {1 {couldn't find search \"s-2-a\"}} {0 93} {0 s-1-a} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 {}} {0 {}} {0 s-2-a}} {{} k1 b {a b}} {{} 27 k1 37 b 58 {a b} 53} {4 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 2\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.2}",
    "", false, "state-trace-863",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array set a \\[list \\\"a b\\\" \\\"26\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"1\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a\\\" \\\"70\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a b\\\"\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(c) 29\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a\\\" \\\"72\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k0\\\"\" r];lappend events [list $c $r];set c [catch \"set a(k2) 83\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a b\\\"\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k2\\\" \\\"50\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"c\\\"\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(a) 59\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 29} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 83} {0 {}} {0 s-1-a} {0 k2} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 59}} {k2 a} {k2 50 a 59} {2 entries in table, 4 buckets\nnumber of buckets with 0 entries: 3\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.5}",
    "", false, "state-trace-864",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"set a(a) 0\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"b\\\"\" r];lappend events [list $c $r];set c [catch \"set a(k0) 99\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a\\\"\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a b\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a\\\" \\\"48\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"b\\\"\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"c\\\"\" r];lappend events [list $c $r];set c [catch \"set a(k2) 85\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"79\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a\\\"\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k0\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"66\\\"\\]\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 0} {0 {}} {0 99} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 85} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}}} {k2 b} {k2 85 b 66} {2 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 2\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "state-trace-865",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"set a(c) 83\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k1\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"14\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set a(c) 10\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k2\\\" \\\"82\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(b) 17\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k0) 51\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"b\\\"\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"c\\\"\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(c) 13\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k1\\\" \\\"81\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set a(a) 71\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k1) 31\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"\\\"\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 83} {0 {}} {0 {}} {0 10} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 17} {0 s-1-a} {0 1} {0 1} {0 k2} {0 51} {0 s-1-a} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 13} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 71} {1 {couldn't find search \"s-1-a\"}} {0 31} {1 {couldn't find search \"s-1-a\"}} {0 {}}} {k1 a k2 c k0} {k1 31 a 71 k2 82 c 13 k0 51} {5 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 2\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.4}",
    "", false, "state-trace-866",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"15\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a\\\" \\\"64\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k1\\\" \\\"87\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a\\\"\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set a(k2) 71\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set a(k2) 6\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set a() 89\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set a(k1) 39\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 0} {0 0} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 {}} {0 s-1-a} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 s-2-a} {0 71} {0 s-1-a} {0 6} {0 k1} {0 89} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 39} {0 {}} {0 s-1-a} {0 {}}} {{} k1 k2 {a b}} {{} 89 k1 39 k2 6 {a b} 15} {4 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 2\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.2}",
    "", false, "state-trace-867",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array unset a \\\"k2\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set a(k2) 0\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"70\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"71\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"9\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k1\\\" \\\"72\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"b\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k0) 47\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"60\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {0 0} {0 0} {0 s-2-a} {0 0} {1 {couldn't find search \"s-2-a\"}} {1 {couldn't find search \"s-2-a\"}} {1 {couldn't find search \"s-2-a\"}} {0 s-1-a} {0 1} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 1} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 47} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 s-1-a}} {k1 k2 k0 {a b}} {k1 72 k2 0 k0 47 {a b} 60} {4 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 2\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.2}",
    "", false, "state-trace-868",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k2\\\" \\\"77\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k1\\\"\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"26\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"b\\\"\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set a(c) 23\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"c\\\" \\\"1\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 s-2-a} {0 {}} {0 {}} {0 s-1-a} {0 {}} {0 {}} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 1} {0 s-2-a} {0 23} {1 {couldn't find search \"s-2-a\"}} {1 {couldn't find search \"s-2-a\"}} {0 {}} {1 {couldn't find search \"s-2-a\"}} {1 {couldn't find search \"s-2-a\"}} {1 {couldn't find search \"s-2-a\"}} {0 s-1-a} {0 k2} {0 c} {0 {}}} {k2 c {a b}} {k2 77 c 1 {a b} 26} {3 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.3}",
    "", false, "state-trace-869",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k2\\\" \\\"77\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"90\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"46\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"21\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k0\\\" \\\"7\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"81\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"33\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"c\\\" \\\"17\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"b\\\"\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k2) 5\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"c\\\"\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 0} {0 {}} {0 {}} {0 s-1-a} {0 {}} {0 s-1-a} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {0 s-1-a} {0 k2} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 5} {0 {}}} {k2 k0 {a b}} {k2 5 k0 7 {a b} 33} {3 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.3}",
    "", false, "state-trace-870",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"39\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k1\\\" \\\"11\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a b\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k0\\\" \\\"21\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a b\\\"\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a\\\" \\\"11\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"\\\" \\\"63\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k0) 25\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"89\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 s-2-a} {0 {}} {0 {}} {1 {couldn't find search \"s-2-a\"}} {0 {}} {0 {}} {1 {couldn't find search \"s-2-a\"}} {1 {couldn't find search \"s-2-a\"}} {0 {}} {1 {couldn't find search \"s-2-a\"}} {1 {couldn't find search \"s-2-a\"}} {0 {}} {0 s-1-a} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 25} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 1} {0 {}} {0 {}}} {{} k1 a b k0} {{} 63 k1 11 a 11 b 89 k0 25} {5 entries in table, 4 buckets\nnumber of buckets with 0 entries: 0\nnumber of buckets with 1 entries: 3\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.2}",
    "", false, "state-trace-871",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array unset a \\\"k0\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k1\\\" \\\"20\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(c) 18\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a b\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"68\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k1\\\" \\\"9\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"c\\\" \\\"48\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k1\\\" \\\"78\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"41\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k1) 3\" r];lappend events [list $c $r];set c [catch \"set a(b) 84\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"45\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k0) 99\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 18} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {0 s-1-a} {0 {}} {0 s-2-a} {0 {}} {0 s-1-a} {0 k1} {0 1} {0 3} {0 84} {0 {}} {0 b} {0 {}} {0 99}} {k1 b k0 {a b} c} {k1 3 b 84 k0 99 {a b} 45 c 48} {5 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 2\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 1\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.6}",
    "", false, "state-trace-872",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array unset a \\\"k2\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k2\\\" \\\"29\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k1\\\"\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"3\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k1\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"\\\" \\\"11\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"11\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"b\\\"\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a b\\\"\" r];lappend events [list $c $r];set c [catch \"set a(b) 65\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"c\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"c\\\" \\\"0\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(a) 47\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 s-1-a} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 s-1-a} {0 {}} {0 65} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 47}} {{} a k2 b c} {{} 11 a 47 k2 29 b 65 c 0} {5 entries in table, 4 buckets\nnumber of buckets with 0 entries: 0\nnumber of buckets with 1 entries: 3\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.2}",
    "", false, "state-trace-873",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array unset a \\\"k2\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"\\\" \\\"43\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k0\\\" \\\"72\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a\\\"\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k0\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k2\\\" \\\"44\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k0\\\" \\\"54\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"c\\\" \\\"53\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {0 s-1-a} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {0 s-1-a} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 1} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 {}} {1 {couldn't find search \"s-1-a\"}}} {k2 c k0} {k2 44 c 53 k0 54} {3 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.3}",
    "", false, "state-trace-874",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"set a() 42\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"25\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k2) 81\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"c\\\"\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"c\\\"\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k2\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"\\\" \\\"65\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"28\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k1\\\"\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"12\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a\\\" \\\"93\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(b) 62\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k0) 77\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 42} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 81} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {0 {}} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 s-1-a} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 62} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 77} {0 s-1-a} {0 {}}} {{} a b k0 {a b}} {{} 65 a 93 b 62 k0 77 {a b} 28} {5 entries in table, 4 buckets\nnumber of buckets with 0 entries: 0\nnumber of buckets with 1 entries: 3\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.2}",
    "", false, "state-trace-875",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k1\\\" \\\"55\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set a(b) 54\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k2\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k0) 14\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"11\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a\\\"\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"b\\\"\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k1\\\"\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 54} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 14} {0 s-1-a} {0 s-2-a} {0 {}} {1 {couldn't find search \"s-2-a\"}} {1 {couldn't find search \"s-2-a\"}} {1 {couldn't find search \"s-2-a\"}} {0 {}} {0 {}} {0 {}} {0 s-1-a} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}}} {{a b} k0} {{a b} 11 k0 14} {2 entries in table, 4 buckets\nnumber of buckets with 0 entries: 3\nnumber of buckets with 1 entries: 0\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.5}",
    "", false, "state-trace-876",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array set a \\[list \\\"c\\\" \\\"12\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"\\\"\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"14\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"84\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k0) 83\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k2\\\" \\\"35\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a b\\\"\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a b\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a\\\" \\\"15\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k0\\\"\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {0 {}} {0 s-1-a} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 83} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 a} {0 k2} {0 {}}} {a k2 c} {a 15 k2 35 c 12} {3 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.3}",
    "", false, "state-trace-877",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array set a \\[list \\\"a b\\\" \\\"22\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k2\\\"\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k1\\\" \\\"15\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set a(b) 83\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"22\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"21\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k0) 9\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a\\\"\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 {}} {0 s-1-a} {0 k1} {0 {}} {0 s-1-a} {0 83} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 9} {0 s-1-a} {0 k1} {0 {}} {0 s-2-a} {0 k1}} {k1 b k0 {a b}} {k1 15 b 21 k0 9 {a b} 22} {4 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 2\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.2}",
    "", false, "state-trace-878",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"set a(a) 63\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a b\\\"\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a\\\"\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a\\\"\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"38\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"\\\" \\\"9\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"12\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k2\\\"\" r];lappend events [list $c $r];set c [catch \"set a(k0) 94\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 63} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 {}} {0 a} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 {}} {0 {}} {0 {}} {0 94} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a}} {{} b k0 {a b}} {{} 9 b 38 k0 94 {a b} 12} {4 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 2\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.2}",
    "", false, "state-trace-879",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set a(k1) 28\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k2) 9\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k2) 85\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set a(k0) 2\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(b) 58\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(b) 96\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 0} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 28} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 9} {1 {couldn't find search \"s-1-a\"}} {0 85} {0 s-1-a} {0 s-2-a} {0 2} {0 s-1-a} {0 {}} {0 58} {0 s-1-a} {0 1} {0 1} {0 k1} {0 96}} {k1 k2 b k0} {k1 28 k2 85 b 96 k0 2} {4 entries in table, 4 buckets\nnumber of buckets with 0 entries: 0\nnumber of buckets with 1 entries: 4\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "state-trace-880",
  )
}

///|
test "Tcl array cases 881 through 920" {
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(c) 21\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a b\\\"\" r];lappend events [list $c $r];set c [catch \"set a() 82\" r];lappend events [list $c $r];set c [catch \"set a(a) 32\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k0\\\"\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 21} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 1} {0 1} {0 c} {0 {}} {0 82} {0 32} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}}} {{} a c} {{} 82 a 32 c 21} {3 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 3\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "state-trace-881",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array unset a \\\"k1\\\"\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k1\\\"\" r];lappend events [list $c $r];set c [catch \"set a(k0) 48\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"14\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k1\\\"\" r];lappend events [list $c $r];set c [catch \"set a(k1) 3\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k2\\\" \\\"75\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(c) 64\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set a() 92\" r];lappend events [list $c $r];set c [catch \"set a(b) 54\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"c\\\" \\\"4\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set a(k1) 7\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k1\\\" \\\"3\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"\\\"\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a\\\"\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 48} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {0 3} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 64} {1 {couldn't find search \"s-1-a\"}} {0 92} {0 54} {0 {}} {0 7} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {0 s-1-a} {0 {}}} {k1 k2 b c k0} {k1 3 k2 75 b 54 c 4 k0 48} {5 entries in table, 4 buckets\nnumber of buckets with 0 entries: 0\nnumber of buckets with 1 entries: 3\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.2}",
    "", false, "state-trace-882",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array set a \\[list \\\"c\\\" \\\"9\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a b\\\"\" r];lappend events [list $c $r];set c [catch \"set a(a) 64\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"b\\\"\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(b) 25\" r];lappend events [list $c $r];set c [catch \"set a(k2) 69\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a b\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"c\\\" \\\"32\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k2\\\" \\\"49\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a b\\\"\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {0 {}} {0 64} {0 s-1-a} {0 1} {0 1} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 25} {0 69} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {0 s-1-a} {0 1} {0 1} {0 1}} {k2 a b c} {k2 49 a 64 b 25 c 32} {4 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 2\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.2}",
    "", false, "state-trace-883",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(c) 93\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k1) 45\" r];lappend events [list $c $r];set c [catch \"set a(k0) 61\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(a) 88\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"31\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set a(k2) 68\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k0) 19\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 0} {0 93} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 c} {0 {}} {0 45} {0 61} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 88} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {0 68} {0 s-1-a} {0 1} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 19}} {k1 k2 a {a b} k0 c} {k1 45 k2 68 a 88 {a b} 31 k0 19 c 93} {6 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 1\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.7}",
    "", false, "state-trace-884",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k1\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"40\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k2) 71\" r];lappend events [list $c $r];set c [catch \"set a(k1) 25\" r];lappend events [list $c $r];set c [catch \"set a(a) 11\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a\\\" \\\"98\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set a(k2) 28\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k0\\\" \\\"92\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"19\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set a(k1) 62\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k2\\\" \\\"86\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {0 {}} {0 0} {0 s-2-a} {0 {}} {1 {couldn't find search \"s-2-a\"}} {1 {couldn't find search \"s-2-a\"}} {0 s-1-a} {0 {}} {0 71} {0 25} {0 11} {0 {}} {0 28} {0 s-1-a} {0 s-2-a} {0 s-3-a} {0 {}} {1 {couldn't find search \"s-3-a\"}} {0 {}} {0 62} {0 {}} {0 s-1-a} {0 {}}} {k1 a k2 b k0 {a b}} {k1 62 a 98 k2 86 b 19 k0 92 {a b} 40} {6 entries in table, 4 buckets\nnumber of buckets with 0 entries: 0\nnumber of buckets with 1 entries: 2\nnumber of buckets with 2 entries: 2\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.3}",
    "", false, "state-trace-885",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a\\\" \\\"50\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set a(c) 99\" r];lappend events [list $c $r];set c [catch \"set a(k2) 21\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set a(c) 35\" r];lappend events [list $c $r];set c [catch \"set a(a) 90\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"41\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set a() 90\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k2\\\" \\\"64\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set a(k1) 33\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"\\\"\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k0\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"97\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"84\\\"\\]\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {0 {}} {0 s-2-a} {0 {}} {0 s-1-a} {0 99} {0 21} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 35} {0 90} {0 {}} {0 90} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 {}} {0 s-2-a} {0 33} {1 {couldn't find search \"s-2-a\"}} {0 {}} {0 {}} {0 {}} {0 {}}} {k1 k2 a {a b} c} {k1 33 k2 64 a 90 {a b} 84 c 35} {5 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 2\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.4}",
    "", false, "state-trace-886",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"\\\" \\\"45\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k2\\\"\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a\\\" \\\"33\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"c\\\" \\\"1\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"17\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(a) 11\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k0\\\" \\\"90\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"78\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k2\\\"\" r];lappend events [list $c $r];set c [catch \"set a(k1) 0\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"\\\"\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 s-1-a} {0 {}} {0 s-2-a} {0 {}} {0 {}} {0 {}} {1 {couldn't find search \"s-2-a\"}} {0 11} {0 {}} {0 {}} {1 {couldn't find search \"s-2-a\"}} {1 {couldn't find search \"s-2-a\"}} {1 {couldn't find search \"s-2-a\"}} {1 {couldn't find search \"s-2-a\"}} {1 {couldn't find search \"s-2-a\"}} {1 {couldn't find search \"s-2-a\"}} {0 {}} {0 0} {1 {couldn't find search \"s-2-a\"}} {0 {}} {1 {couldn't find search \"s-2-a\"}}} {k1 a b k0 c} {k1 0 a 11 b 78 k0 90 c 1} {5 entries in table, 4 buckets\nnumber of buckets with 0 entries: 0\nnumber of buckets with 1 entries: 3\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.2}",
    "", false, "state-trace-887",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k2\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"c\\\" \\\"23\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k1\\\"\" r];lappend events [list $c $r];set c [catch \"set a() 29\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"\\\"\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"77\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"b\\\"\" r];lappend events [list $c $r];set c [catch \"set a(a) 96\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"b\\\"\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a b\\\"\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k1) 54\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k1) 47\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k0\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"c\\\" \\\"90\\\"\\]\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {0 {}} {0 29} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 96} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 54} {1 {couldn't find search \"s-1-a\"}} {0 47} {0 {}} {0 {}}} {k1 a c} {k1 47 a 96 c 90} {3 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 3\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "state-trace-888",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k2\\\" \\\"90\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"\\\"\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"\\\" \\\"0\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"90\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(b) 90\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"c\\\" \\\"96\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(b) 3\" r];lappend events [list $c $r];set c [catch \"set a(c) 78\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"c\\\" \\\"29\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set a(k2) 70\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"c\\\" \\\"35\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"c\\\" \\\"57\\\"\\]\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 90} {0 {}} {0 s-1-a} {0 s-2-a} {0 1} {0 3} {0 78} {0 {}} {0 70} {0 {}} {0 {}} {0 {}}} {{} k2 b c} {{} 0 k2 70 b 3 c 57} {4 entries in table, 4 buckets\nnumber of buckets with 0 entries: 0\nnumber of buckets with 1 entries: 4\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "state-trace-889",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"b\\\"\" r];lappend events [list $c $r];set c [catch \"set a() 70\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"11\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k2\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"87\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"84\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 0} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 0} {0 {}} {0 70} {0 s-1-a} {0 {}} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 {}} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 {}}} {{} b {a b}} {{} 70 b 87 {a b} 84} {3 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 3\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "state-trace-890",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"8\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"c\\\"\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"52\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"82\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k1\\\" \\\"78\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"\\\" \\\"32\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set a(k1) 41\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"49\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"84\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k1\\\" \\\"32\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set a(a) 86\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {0 {}} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 s-2-a} {0 {}} {1 {couldn't find search \"s-2-a\"}} {0 s-1-a} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 41} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {0 86}} {{} k1 a b {a b}} {{} 32 k1 32 a 86 b 49 {a b} 84} {5 entries in table, 4 buckets\nnumber of buckets with 0 entries: 0\nnumber of buckets with 1 entries: 3\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.2}",
    "", false, "state-trace-891",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array unset a \\\"k1\\\"\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"\\\" \\\"80\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set a(k1) 11\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"24\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k0\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"77\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"18\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set a(k1) 93\" r];lappend events [list $c $r];set c [catch \"set a(k1) 22\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 {}} {0 {}} {0 11} {0 s-1-a} {0 k1} {0 1} {0 {}} {0 {}} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 {}} {0 93} {0 22}} {k1 {} {a b}} {k1 22 {} 80 {a b} 18} {3 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.3}",
    "", false, "state-trace-892",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array set a \\[list \\\"b\\\" \\\"40\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set a() 79\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set a() 84\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"c\\\" \\\"25\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"90\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"81\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k0\\\"\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set a() 15\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a b\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"c\\\" \\\"95\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set a() 65\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k0\\\"\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 79} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 84} {0 {}} {0 s-2-a} {0 1} {0 {}} {0 {}} {0 {}} {0 s-1-a} {0 {}} {0 s-2-a} {0 15} {0 {}} {0 s-3-a} {0 s-4-a} {0 {}} {0 {}} {0 65} {0 {}}} {{} b c} {{} 65 b 40 c 95} {3 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 3\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "state-trace-893",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array set a \\[list \\\"k1\\\" \\\"84\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"65\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"b\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k0\\\" \\\"85\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a b\\\"\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"c\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"61\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set a(k1) 96\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k2\\\" \\\"92\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"\\\"\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k0\\\"\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {0 s-1-a} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 k1} {0 {}} {0 {}} {0 {}} {0 s-1-a} {0 k1} {0 {}} {0 {}} {0 96} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}}} {k1 k2 b} {k1 96 k2 92 b 61} {3 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 3\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "state-trace-894",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"39\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(c) 8\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k0\\\" \\\"68\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k2\\\"\" r];lappend events [list $c $r];set c [catch \"set a(b) 67\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k2\\\" \\\"45\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set a(k2) 39\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 s-2-a} {0 {}} {0 {}} {0 {}} {1 {couldn't find search \"s-2-a\"}} {0 s-1-a} {0 1} {0 b} {0 8} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 1} {0 {}} {0 {}} {0 67} {0 {}} {0 s-1-a} {0 39} {0 k2} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a}} {k2 b k0 c} {k2 39 b 67 k0 68 c 8} {4 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 2\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.2}",
    "", false, "state-trace-895",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"c\\\"\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k2\\\"\" r];lappend events [list $c $r];set c [catch \"set a(k2) 46\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"\\\"\" r];lappend events [list $c $r];set c [catch \"set a(k2) 96\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k1) 94\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a\\\" \\\"91\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set a(k1) 43\" r];lappend events [list $c $r];set c [catch \"set a() 29\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set a() 37\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k1\\\" \\\"33\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k2\\\" \\\"25\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"8\\\"\\]\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 46} {0 {}} {0 96} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 94} {0 {}} {0 43} {0 29} {0 s-1-a} {0 {}} {0 37} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 s-2-a} {0 {}}} {{} k1 a k2 {a b}} {{} 37 k1 33 a 91 k2 25 {a b} 8} {5 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 2\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.4}",
    "", false, "state-trace-896",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array unset a \\\"k0\\\"\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k2\\\"\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(a) 68\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k1\\\"\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k0) 54\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"30\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k1\\\" \\\"8\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"\\\" \\\"93\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a b\\\"\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {0 {}} {0 {}} {0 s-2-a} {0 {}} {1 {couldn't find search \"s-2-a\"}} {0 68} {1 {couldn't find search \"s-2-a\"}} {1 {couldn't find search \"s-2-a\"}} {0 {}} {0 s-1-a} {0 a} {0 0} {0 54} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}}} {{} k1 a k0} {{} 93 k1 8 a 68 k0 54} {4 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 2\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.2}",
    "", false, "state-trace-897",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set a(k2) 70\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"c\\\" \\\"46\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k2) 58\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k0\\\"\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k0) 56\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"24\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"c\\\" \\\"65\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set a(k2) 70\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {0 0} {0 s-2-a} {0 70} {0 s-1-a} {0 1} {0 k2} {0 s-2-a} {0 {}} {0 s-1-a} {0 s-2-a} {0 k2} {0 c} {0 58} {0 {}} {0 {}} {0 56} {0 {}} {0 s-1-a} {0 k2} {0 {}} {0 s-2-a} {0 70} {0 {}}} {k2 {a b} k0 c} {k2 70 {a b} 24 k0 56 c 65} {4 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 1\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.8}",
    "", false, "state-trace-898",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k0\\\"\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k2\\\" \\\"20\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k0\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"\\\"\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a\\\" \\\"79\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k2\\\"\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k1) 79\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k0\\\" \\\"37\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"1\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"6\\\"\\]\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {0 {}} {0 s-1-a} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 s-1-a} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 79} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 s-1-a} {0 s-2-a} {0 {}} {1 {couldn't find search \"s-2-a\"}} {0 {}}} {k1 a {a b} k0} {k1 79 a 79 {a b} 6 k0 37} {4 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 2\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.2}",
    "", false, "state-trace-899",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"92\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"c\\\" \\\"82\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a() 57\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k0\\\" \\\"10\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set a(c) 61\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k1\\\" \\\"50\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"k0\\\"\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k0\\\" \\\"79\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"59\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set a(c) 80\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 57} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 61} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 s-1-a} {0 {}} {0 s-1-a} {0 {}} {0 s-1-a} {0 {}} {0 80} {1 {couldn't find search \"s-1-a\"}} {1 {couldn't find search \"s-1-a\"}}} {k1 {} b {a b} k0 c} {k1 50 {} 57 b 92 {a b} 59 k0 79 c 80} {6 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 1\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.7}",
    "", false, "state-trace-900",
  )
  check_array_case(
    "array set a {};set events {};set s [array startsearch a];set c [catch \"array set a \\[list \\\"k0\\\" \\\"90\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a b\\\"\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"c\\\" \\\"23\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"b\\\" \\\"41\\\"\\]\" r];lappend events [list $c $r];set c [catch \"set a(b) 41\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(k0) 37\" r];lappend events [list $c $r];set c [catch \"array anymore a \\$s\" r];lappend events [list $c $r];set c [catch \"set a(b) 88\" r];lappend events [list $c $r];set c [catch \"array donesearch a \\$s\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"a b\\\" \\\"9\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array set a \\[list \\\"k1\\\" \\\"16\\\"\\]\" r];lappend events [list $c $r];set c [catch \"array unset a \\\"a b\\\"\" r];lappend events [list $c $r];set c [catch \"set s \\[array startsearch a\\]\" r];lappend events [list $c $r];set c [catch \"array nextelement a \\$s\" r];lappend events [list $c $r];list $events [array names a] [array get a] [array statistics a]",
    "{{0 {}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 {}} {0 s-1-a} {0 1} {0 {}} {0 {}} {1 {couldn't find search \"s-1-a\"}} {0 s-1-a} {0 c} {0 k0} {0 {}} {0 41} {1 {couldn't find search \"s-1-a\"}} {0 37} {1 {couldn't find search \"s-1-a\"}} {0 88} {1 {couldn't find search \"s-1-a\"}} {0 {}} {0 {}} {0 {}} {0 s-1-a} {0 k1}} {k1 b c k0} {k1 16 b 88 c 23 k0 37} {4 entries in table, 4 buckets\nnumber of buckets with 0 entries: 1\nnumber of buckets with 1 entries: 2\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.2}",
    "", false, "state-trace-901",
  )
  check_array_case(
    "array set a {visible 1};upvar #0 a(k0) b0;list [array size a] [array names a] [array statistics a]",
    "1 visible {2 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 2\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "undefined-buckets-902",
  )
  check_array_case(
    "array set a {visible 1};proc p {} {upvar #0 a(k0) b0;return [array statistics ::a]};list [p] [array names a] [array statistics a]",
    "{2 entries in table, 4 buckets\nnumber of buckets with 0 entries: 2\nnumber of buckets with 1 entries: 2\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0} visible {1 entries in table, 4 buckets\nnumber of buckets with 0 entries: 3\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "scope-cleanup-903",
  )
  check_array_case(
    "array set a {visible 1};upvar #0 a(k0) b0;upvar #0 a(k1) b1;upvar #0 a(k2) b2;upvar #0 a(k3) b3;upvar #0 a(k4) b4;upvar #0 a(k5) b5;upvar #0 a(k6) b6;upvar #0 a(k7) b7;upvar #0 a(k8) b8;upvar #0 a(k9) b9;upvar #0 a(k10) b10;list [array size a] [array names a] [array statistics a]",
    "1 visible {12 entries in table, 16 buckets\nnumber of buckets with 0 entries: 5\nnumber of buckets with 1 entries: 10\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.1}",
    "", false, "undefined-buckets-904",
  )
  check_array_case(
    "array set a {visible 1};proc p {} {upvar #0 a(k0) b0;upvar #0 a(k1) b1;upvar #0 a(k2) b2;upvar #0 a(k3) b3;upvar #0 a(k4) b4;upvar #0 a(k5) b5;upvar #0 a(k6) b6;upvar #0 a(k7) b7;upvar #0 a(k8) b8;upvar #0 a(k9) b9;upvar #0 a(k10) b10;return [array statistics ::a]};list [p] [array names a] [array statistics a]",
    "{12 entries in table, 16 buckets\nnumber of buckets with 0 entries: 5\nnumber of buckets with 1 entries: 10\nnumber of buckets with 2 entries: 1\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.1} visible {1 entries in table, 16 buckets\nnumber of buckets with 0 entries: 15\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "scope-cleanup-905",
  )
  check_array_case(
    "array set a {visible 1};upvar #0 a(k0) b0;upvar #0 a(k1) b1;upvar #0 a(k2) b2;upvar #0 a(k3) b3;upvar #0 a(k4) b4;upvar #0 a(k5) b5;upvar #0 a(k6) b6;upvar #0 a(k7) b7;upvar #0 a(k8) b8;upvar #0 a(k9) b9;upvar #0 a(k10) b10;upvar #0 a(k11) b11;list [array size a] [array names a] [array statistics a]",
    "1 visible {13 entries in table, 16 buckets\nnumber of buckets with 0 entries: 5\nnumber of buckets with 1 entries: 9\nnumber of buckets with 2 entries: 2\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.2}",
    "", false, "undefined-buckets-906",
  )
  check_array_case(
    "array set a {visible 1};proc p {} {upvar #0 a(k0) b0;upvar #0 a(k1) b1;upvar #0 a(k2) b2;upvar #0 a(k3) b3;upvar #0 a(k4) b4;upvar #0 a(k5) b5;upvar #0 a(k6) b6;upvar #0 a(k7) b7;upvar #0 a(k8) b8;upvar #0 a(k9) b9;upvar #0 a(k10) b10;upvar #0 a(k11) b11;return [array statistics ::a]};list [p] [array names a] [array statistics a]",
    "{13 entries in table, 16 buckets\nnumber of buckets with 0 entries: 5\nnumber of buckets with 1 entries: 9\nnumber of buckets with 2 entries: 2\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.2} visible {1 entries in table, 16 buckets\nnumber of buckets with 0 entries: 15\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "scope-cleanup-907",
  )
  check_array_case(
    "array set a {visible 1};upvar #0 a(k0) b0;upvar #0 a(k1) b1;upvar #0 a(k2) b2;upvar #0 a(k3) b3;upvar #0 a(k4) b4;upvar #0 a(k5) b5;upvar #0 a(k6) b6;upvar #0 a(k7) b7;upvar #0 a(k8) b8;upvar #0 a(k9) b9;upvar #0 a(k10) b10;upvar #0 a(k11) b11;upvar #0 a(k12) b12;list [array size a] [array names a] [array statistics a]",
    "1 visible {14 entries in table, 16 buckets\nnumber of buckets with 0 entries: 5\nnumber of buckets with 1 entries: 8\nnumber of buckets with 2 entries: 3\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.2}",
    "", false, "undefined-buckets-908",
  )
  check_array_case(
    "array set a {visible 1};proc p {} {upvar #0 a(k0) b0;upvar #0 a(k1) b1;upvar #0 a(k2) b2;upvar #0 a(k3) b3;upvar #0 a(k4) b4;upvar #0 a(k5) b5;upvar #0 a(k6) b6;upvar #0 a(k7) b7;upvar #0 a(k8) b8;upvar #0 a(k9) b9;upvar #0 a(k10) b10;upvar #0 a(k11) b11;upvar #0 a(k12) b12;return [array statistics ::a]};list [p] [array names a] [array statistics a]",
    "{14 entries in table, 16 buckets\nnumber of buckets with 0 entries: 5\nnumber of buckets with 1 entries: 8\nnumber of buckets with 2 entries: 3\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.2} visible {1 entries in table, 16 buckets\nnumber of buckets with 0 entries: 15\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "scope-cleanup-909",
  )
  check_array_case(
    "array set a {visible 1};upvar #0 a(k0) b0;upvar #0 a(k1) b1;upvar #0 a(k2) b2;upvar #0 a(k3) b3;upvar #0 a(k4) b4;upvar #0 a(k5) b5;upvar #0 a(k6) b6;upvar #0 a(k7) b7;upvar #0 a(k8) b8;upvar #0 a(k9) b9;upvar #0 a(k10) b10;upvar #0 a(k11) b11;upvar #0 a(k12) b12;upvar #0 a(k13) b13;upvar #0 a(k14) b14;upvar #0 a(k15) b15;upvar #0 a(k16) b16;upvar #0 a(k17) b17;upvar #0 a(k18) b18;upvar #0 a(k19) b19;upvar #0 a(k20) b20;upvar #0 a(k21) b21;upvar #0 a(k22) b22;upvar #0 a(k23) b23;upvar #0 a(k24) b24;upvar #0 a(k25) b25;upvar #0 a(k26) b26;upvar #0 a(k27) b27;upvar #0 a(k28) b28;upvar #0 a(k29) b29;upvar #0 a(k30) b30;upvar #0 a(k31) b31;upvar #0 a(k32) b32;upvar #0 a(k33) b33;upvar #0 a(k34) b34;upvar #0 a(k35) b35;upvar #0 a(k36) b36;upvar #0 a(k37) b37;upvar #0 a(k38) b38;upvar #0 a(k39) b39;upvar #0 a(k40) b40;upvar #0 a(k41) b41;upvar #0 a(k42) b42;upvar #0 a(k43) b43;upvar #0 a(k44) b44;upvar #0 a(k45) b45;upvar #0 a(k46) b46;list [array size a] [array names a] [array statistics a]",
    "1 visible {48 entries in table, 64 buckets\nnumber of buckets with 0 entries: 19\nnumber of buckets with 1 entries: 42\nnumber of buckets with 2 entries: 3\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.1}",
    "", false, "undefined-buckets-910",
  )
  check_array_case(
    "array set a {visible 1};proc p {} {upvar #0 a(k0) b0;upvar #0 a(k1) b1;upvar #0 a(k2) b2;upvar #0 a(k3) b3;upvar #0 a(k4) b4;upvar #0 a(k5) b5;upvar #0 a(k6) b6;upvar #0 a(k7) b7;upvar #0 a(k8) b8;upvar #0 a(k9) b9;upvar #0 a(k10) b10;upvar #0 a(k11) b11;upvar #0 a(k12) b12;upvar #0 a(k13) b13;upvar #0 a(k14) b14;upvar #0 a(k15) b15;upvar #0 a(k16) b16;upvar #0 a(k17) b17;upvar #0 a(k18) b18;upvar #0 a(k19) b19;upvar #0 a(k20) b20;upvar #0 a(k21) b21;upvar #0 a(k22) b22;upvar #0 a(k23) b23;upvar #0 a(k24) b24;upvar #0 a(k25) b25;upvar #0 a(k26) b26;upvar #0 a(k27) b27;upvar #0 a(k28) b28;upvar #0 a(k29) b29;upvar #0 a(k30) b30;upvar #0 a(k31) b31;upvar #0 a(k32) b32;upvar #0 a(k33) b33;upvar #0 a(k34) b34;upvar #0 a(k35) b35;upvar #0 a(k36) b36;upvar #0 a(k37) b37;upvar #0 a(k38) b38;upvar #0 a(k39) b39;upvar #0 a(k40) b40;upvar #0 a(k41) b41;upvar #0 a(k42) b42;upvar #0 a(k43) b43;upvar #0 a(k44) b44;upvar #0 a(k45) b45;upvar #0 a(k46) b46;return [array statistics ::a]};list [p] [array names a] [array statistics a]",
    "{48 entries in table, 64 buckets\nnumber of buckets with 0 entries: 19\nnumber of buckets with 1 entries: 42\nnumber of buckets with 2 entries: 3\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.1} visible {1 entries in table, 64 buckets\nnumber of buckets with 0 entries: 63\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "scope-cleanup-911",
  )
  check_array_case(
    "array set a {visible 1};upvar #0 a(k0) b0;upvar #0 a(k1) b1;upvar #0 a(k2) b2;upvar #0 a(k3) b3;upvar #0 a(k4) b4;upvar #0 a(k5) b5;upvar #0 a(k6) b6;upvar #0 a(k7) b7;upvar #0 a(k8) b8;upvar #0 a(k9) b9;upvar #0 a(k10) b10;upvar #0 a(k11) b11;upvar #0 a(k12) b12;upvar #0 a(k13) b13;upvar #0 a(k14) b14;upvar #0 a(k15) b15;upvar #0 a(k16) b16;upvar #0 a(k17) b17;upvar #0 a(k18) b18;upvar #0 a(k19) b19;upvar #0 a(k20) b20;upvar #0 a(k21) b21;upvar #0 a(k22) b22;upvar #0 a(k23) b23;upvar #0 a(k24) b24;upvar #0 a(k25) b25;upvar #0 a(k26) b26;upvar #0 a(k27) b27;upvar #0 a(k28) b28;upvar #0 a(k29) b29;upvar #0 a(k30) b30;upvar #0 a(k31) b31;upvar #0 a(k32) b32;upvar #0 a(k33) b33;upvar #0 a(k34) b34;upvar #0 a(k35) b35;upvar #0 a(k36) b36;upvar #0 a(k37) b37;upvar #0 a(k38) b38;upvar #0 a(k39) b39;upvar #0 a(k40) b40;upvar #0 a(k41) b41;upvar #0 a(k42) b42;upvar #0 a(k43) b43;upvar #0 a(k44) b44;upvar #0 a(k45) b45;upvar #0 a(k46) b46;upvar #0 a(k47) b47;list [array size a] [array names a] [array statistics a]",
    "1 visible {49 entries in table, 64 buckets\nnumber of buckets with 0 entries: 18\nnumber of buckets with 1 entries: 43\nnumber of buckets with 2 entries: 3\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.1}",
    "", false, "undefined-buckets-912",
  )
  check_array_case(
    "array set a {visible 1};proc p {} {upvar #0 a(k0) b0;upvar #0 a(k1) b1;upvar #0 a(k2) b2;upvar #0 a(k3) b3;upvar #0 a(k4) b4;upvar #0 a(k5) b5;upvar #0 a(k6) b6;upvar #0 a(k7) b7;upvar #0 a(k8) b8;upvar #0 a(k9) b9;upvar #0 a(k10) b10;upvar #0 a(k11) b11;upvar #0 a(k12) b12;upvar #0 a(k13) b13;upvar #0 a(k14) b14;upvar #0 a(k15) b15;upvar #0 a(k16) b16;upvar #0 a(k17) b17;upvar #0 a(k18) b18;upvar #0 a(k19) b19;upvar #0 a(k20) b20;upvar #0 a(k21) b21;upvar #0 a(k22) b22;upvar #0 a(k23) b23;upvar #0 a(k24) b24;upvar #0 a(k25) b25;upvar #0 a(k26) b26;upvar #0 a(k27) b27;upvar #0 a(k28) b28;upvar #0 a(k29) b29;upvar #0 a(k30) b30;upvar #0 a(k31) b31;upvar #0 a(k32) b32;upvar #0 a(k33) b33;upvar #0 a(k34) b34;upvar #0 a(k35) b35;upvar #0 a(k36) b36;upvar #0 a(k37) b37;upvar #0 a(k38) b38;upvar #0 a(k39) b39;upvar #0 a(k40) b40;upvar #0 a(k41) b41;upvar #0 a(k42) b42;upvar #0 a(k43) b43;upvar #0 a(k44) b44;upvar #0 a(k45) b45;upvar #0 a(k46) b46;upvar #0 a(k47) b47;return [array statistics ::a]};list [p] [array names a] [array statistics a]",
    "{49 entries in table, 64 buckets\nnumber of buckets with 0 entries: 18\nnumber of buckets with 1 entries: 43\nnumber of buckets with 2 entries: 3\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.1} visible {1 entries in table, 64 buckets\nnumber of buckets with 0 entries: 63\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "scope-cleanup-913",
  )
  check_array_case(
    "array set a {visible 1};upvar #0 a(k0) b0;upvar #0 a(k1) b1;upvar #0 a(k2) b2;upvar #0 a(k3) b3;upvar #0 a(k4) b4;upvar #0 a(k5) b5;upvar #0 a(k6) b6;upvar #0 a(k7) b7;upvar #0 a(k8) b8;upvar #0 a(k9) b9;upvar #0 a(k10) b10;upvar #0 a(k11) b11;upvar #0 a(k12) b12;upvar #0 a(k13) b13;upvar #0 a(k14) b14;upvar #0 a(k15) b15;upvar #0 a(k16) b16;upvar #0 a(k17) b17;upvar #0 a(k18) b18;upvar #0 a(k19) b19;upvar #0 a(k20) b20;upvar #0 a(k21) b21;upvar #0 a(k22) b22;upvar #0 a(k23) b23;upvar #0 a(k24) b24;upvar #0 a(k25) b25;upvar #0 a(k26) b26;upvar #0 a(k27) b27;upvar #0 a(k28) b28;upvar #0 a(k29) b29;upvar #0 a(k30) b30;upvar #0 a(k31) b31;upvar #0 a(k32) b32;upvar #0 a(k33) b33;upvar #0 a(k34) b34;upvar #0 a(k35) b35;upvar #0 a(k36) b36;upvar #0 a(k37) b37;upvar #0 a(k38) b38;upvar #0 a(k39) b39;upvar #0 a(k40) b40;upvar #0 a(k41) b41;upvar #0 a(k42) b42;upvar #0 a(k43) b43;upvar #0 a(k44) b44;upvar #0 a(k45) b45;upvar #0 a(k46) b46;upvar #0 a(k47) b47;upvar #0 a(k48) b48;list [array size a] [array names a] [array statistics a]",
    "1 visible {50 entries in table, 64 buckets\nnumber of buckets with 0 entries: 17\nnumber of buckets with 1 entries: 44\nnumber of buckets with 2 entries: 3\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.1}",
    "", false, "undefined-buckets-914",
  )
  check_array_case(
    "array set a {visible 1};proc p {} {upvar #0 a(k0) b0;upvar #0 a(k1) b1;upvar #0 a(k2) b2;upvar #0 a(k3) b3;upvar #0 a(k4) b4;upvar #0 a(k5) b5;upvar #0 a(k6) b6;upvar #0 a(k7) b7;upvar #0 a(k8) b8;upvar #0 a(k9) b9;upvar #0 a(k10) b10;upvar #0 a(k11) b11;upvar #0 a(k12) b12;upvar #0 a(k13) b13;upvar #0 a(k14) b14;upvar #0 a(k15) b15;upvar #0 a(k16) b16;upvar #0 a(k17) b17;upvar #0 a(k18) b18;upvar #0 a(k19) b19;upvar #0 a(k20) b20;upvar #0 a(k21) b21;upvar #0 a(k22) b22;upvar #0 a(k23) b23;upvar #0 a(k24) b24;upvar #0 a(k25) b25;upvar #0 a(k26) b26;upvar #0 a(k27) b27;upvar #0 a(k28) b28;upvar #0 a(k29) b29;upvar #0 a(k30) b30;upvar #0 a(k31) b31;upvar #0 a(k32) b32;upvar #0 a(k33) b33;upvar #0 a(k34) b34;upvar #0 a(k35) b35;upvar #0 a(k36) b36;upvar #0 a(k37) b37;upvar #0 a(k38) b38;upvar #0 a(k39) b39;upvar #0 a(k40) b40;upvar #0 a(k41) b41;upvar #0 a(k42) b42;upvar #0 a(k43) b43;upvar #0 a(k44) b44;upvar #0 a(k45) b45;upvar #0 a(k46) b46;upvar #0 a(k47) b47;upvar #0 a(k48) b48;return [array statistics ::a]};list [p] [array names a] [array statistics a]",
    "{50 entries in table, 64 buckets\nnumber of buckets with 0 entries: 17\nnumber of buckets with 1 entries: 44\nnumber of buckets with 2 entries: 3\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.1} visible {1 entries in table, 64 buckets\nnumber of buckets with 0 entries: 63\nnumber of buckets with 1 entries: 1\nnumber of buckets with 2 entries: 0\nnumber of buckets with 3 entries: 0\nnumber of buckets with 4 entries: 0\nnumber of buckets with 5 entries: 0\nnumber of buckets with 6 entries: 0\nnumber of buckets with 7 entries: 0\nnumber of buckets with 8 entries: 0\nnumber of buckets with 9 entries: 0\nnumber of buckets with 10 or more entries: 0\naverage search distance for entry: 1.0}",
    "", false, "scope-cleanup-915",
  )
  check_array_case(
    "array set a {x 1};upvar #0 a(z) b;set s [array startsearch a];catch {set b 2};set code [catch \"list \\[array anymore a \\$s\\] \\[array nextelement a \\$s\\] \\[array anymore a \\$s\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {1 x 1} 0 {}", "", false, "retained-cursor-916",
  )
  check_array_case(
    "array set a {x 1};upvar #0 a(z) b;set s [array startsearch a];array anymore a $s;catch {set b 2};set code [catch \"list \\[array anymore a \\$s\\] \\[array nextelement a \\$s\\] \\[array anymore a \\$s\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {1 x 1} 0 {}", "", false, "retained-cursor-917",
  )
  check_array_case(
    "array set a {x 1};upvar #0 a(z) b;set s [array startsearch a];array nextelement a $s;catch {set b 2};set code [catch \"list \\[array anymore a \\$s\\] \\[array nextelement a \\$s\\] \\[array anymore a \\$s\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {1 z 0} 0 {}", "", false, "retained-cursor-918",
  )
  check_array_case(
    "array set a {x 1};upvar #0 a(z) b;set s [array startsearch a];catch {unset b};set code [catch \"list \\[array anymore a \\$s\\] \\[array nextelement a \\$s\\] \\[array anymore a \\$s\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {1 x 0} 0 {}", "", false, "retained-cursor-919",
  )
  check_array_case(
    "array set a {x 1};upvar #0 a(z) b;set s [array startsearch a];array anymore a $s;catch {unset b};set code [catch \"list \\[array anymore a \\$s\\] \\[array nextelement a \\$s\\] \\[array anymore a \\$s\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {1 x 0} 0 {}", "", false, "retained-cursor-920",
  )
}

///|
test "Tcl array cases 921 through 937" {
  check_array_case(
    "array set a {x 1};upvar #0 a(z) b;set s [array startsearch a];array nextelement a $s;catch {unset b};set code [catch \"list \\[array anymore a \\$s\\] \\[array nextelement a \\$s\\] \\[array anymore a \\$s\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {0 {} 0} 0 {}", "", false, "retained-cursor-921",
  )
  check_array_case(
    "array set a {x 1};upvar #0 a(z) b;set s [array startsearch a];catch {unset -nocomplain b};set code [catch \"list \\[array anymore a \\$s\\] \\[array nextelement a \\$s\\] \\[array anymore a \\$s\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {1 x 0} 0 {}", "", false, "retained-cursor-922",
  )
  check_array_case(
    "array set a {x 1};upvar #0 a(z) b;set s [array startsearch a];array anymore a $s;catch {unset -nocomplain b};set code [catch \"list \\[array anymore a \\$s\\] \\[array nextelement a \\$s\\] \\[array anymore a \\$s\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {1 x 0} 0 {}", "", false, "retained-cursor-923",
  )
  check_array_case(
    "array set a {x 1};upvar #0 a(z) b;set s [array startsearch a];array nextelement a $s;catch {unset -nocomplain b};set code [catch \"list \\[array anymore a \\$s\\] \\[array nextelement a \\$s\\] \\[array anymore a \\$s\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {0 {} 0} 0 {}", "", false, "retained-cursor-924",
  )
  check_array_case(
    "array set a {x 1};upvar #0 a(z) b;set s [array startsearch a];catch {set a(z) 2};set code [catch \"list \\[array anymore a \\$s\\] \\[array nextelement a \\$s\\] \\[array anymore a \\$s\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {1 x 1} 0 {}", "", false, "retained-cursor-925",
  )
  check_array_case(
    "array set a {x 1};upvar #0 a(z) b;set s [array startsearch a];array anymore a $s;catch {set a(z) 2};set code [catch \"list \\[array anymore a \\$s\\] \\[array nextelement a \\$s\\] \\[array anymore a \\$s\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {1 x 1} 0 {}", "", false, "retained-cursor-926",
  )
  check_array_case(
    "array set a {x 1};upvar #0 a(z) b;set s [array startsearch a];array nextelement a $s;catch {set a(z) 2};set code [catch \"list \\[array anymore a \\$s\\] \\[array nextelement a \\$s\\] \\[array anymore a \\$s\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "0 {1 z 0} 0 {}", "", false, "retained-cursor-927",
  )
  check_array_case(
    "array set a {x 1};upvar #0 a(z) b;set s [array startsearch a];catch {unset -nocomplain a(z)};set code [catch \"list \\[array anymore a \\$s\\] \\[array nextelement a \\$s\\] \\[array anymore a \\$s\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {couldn't find search \"s-1-a\"} 0 {TCL LOOKUP ARRAYSEARCH s-1-a}", "", false,
    "retained-cursor-928",
  )
  check_array_case(
    "array set a {x 1};upvar #0 a(z) b;set s [array startsearch a];array anymore a $s;catch {unset -nocomplain a(z)};set code [catch \"list \\[array anymore a \\$s\\] \\[array nextelement a \\$s\\] \\[array anymore a \\$s\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {couldn't find search \"s-1-a\"} 0 {TCL LOOKUP ARRAYSEARCH s-1-a}", "", false,
    "retained-cursor-929",
  )
  check_array_case(
    "array set a {x 1};upvar #0 a(z) b;set s [array startsearch a];array nextelement a $s;catch {unset -nocomplain a(z)};set code [catch \"list \\[array anymore a \\$s\\] \\[array nextelement a \\$s\\] \\[array anymore a \\$s\\]\" r o];list $code $r [dict get $o -level] [expr {[dict exists $o -errorcode] ? [dict get $o -errorcode] : {}}]",
    "1 {couldn't find search \"s-1-a\"} 0 {TCL LOOKUP ARRAYSEARCH s-1-a}", "", false,
    "retained-cursor-930",
  )
  check_array_case(
    "array set \"a b\" {x 1};set s [array startsearch \"a b\"];list $s [array anymore \"a b\" $s] [array nextelement \"a b\" $s]",
    "{s-1-a b} 1 x", "", false, "array-name-931",
  )
  check_array_case(
    "array set \"a-b\" {x 1};set s [array startsearch \"a-b\"];list $s [array anymore \"a-b\" $s] [array nextelement \"a-b\" $s]",
    "s-1-a-b 1 x", "", false, "array-name-932",
  )
  check_array_case(
    "array set \"\" {x 1};set s [array startsearch \"\"];list $s [array anymore \"\" $s] [array nextelement \"\" $s]",
    "s-1- 1 x", "", false, "array-name-933",
  )
  check_array_case(
    "array set \"中\" {x 1};set s [array startsearch \"中\"];list $s [array anymore \"中\" $s] [array nextelement \"中\" $s]",
    "s-1-中 1 x", "", false, "array-name-934",
  )
  check_array_case(
    "array set \"::a\" {x 1};set s [array startsearch \"::a\"];list $s [array anymore \"::a\" $s] [array nextelement \"::a\" $s]",
    "s-1-::a 1 x", "", false, "array-name-935",
  )
  check_array_case(
    "array set \"a\\x00b\" {x 1};set s [array startsearch \"a\\x00b\"];list $s [array anymore \"a\\x00b\" $s] [array nextelement \"a\\x00b\" $s]",
    "s-1-a\u0000b 1 x", "", false, "array-name-936",
  )
  check_array_case(
    "set a(x) 1;upvar #0 a(x) y;unset a;set y 7;set a(x)", "can't set \"y\": upvar refers to element in deleted array",
    "", true, "deleted-array-alias-write-937",
  )
}
