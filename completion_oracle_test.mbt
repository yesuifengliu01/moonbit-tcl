// Original programs, expected results evaluated by Tcl 8.6.15. Do not hand-edit.

///|
test "Tcl completion return-ok-0-nest-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -code ok -level 0 -tag custom value;set reached after}",
      budget=100000,
    ),
    "0 after {-code 0 -level 0 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-ok-0-nest-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code ok -level 0 -tag custom value;set reached after};p;set outer after}",
      budget=100000,
    ),
    "0 after {-code 0 -level 0 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-ok-0-nest-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code ok -level 0 -tag custom value;set reached after};proc q {} {p;set inner after};q;set outer after}",
      budget=100000,
    ),
    "0 after {-code 0 -level 0 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-ok-1-nest-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -code ok -level 1 -tag custom value;set reached after}",
      budget=100000,
    ),
    "2 value {-code 0 -level 1 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-ok-1-nest-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code ok -level 1 -tag custom value;set reached after};p;set outer after}",
      budget=100000,
    ),
    "0 after {-code 0 -level 0 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-ok-1-nest-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code ok -level 1 -tag custom value;set reached after};proc q {} {p;set inner after};q;set outer after}",
      budget=100000,
    ),
    "0 after {-code 0 -level 0 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-ok-2-nest-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -code ok -level 2 -tag custom value;set reached after}",
      budget=100000,
    ),
    "2 value {-code 0 -level 2 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-ok-2-nest-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code ok -level 2 -tag custom value;set reached after};p;set outer after}",
      budget=100000,
    ),
    "2 value {-code 0 -level 1 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-ok-2-nest-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code ok -level 2 -tag custom value;set reached after};proc q {} {p;set inner after};q;set outer after}",
      budget=100000,
    ),
    "0 after {-code 0 -level 0 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-ok-3-nest-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -code ok -level 3 -tag custom value;set reached after}",
      budget=100000,
    ),
    "2 value {-code 0 -level 3 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-ok-3-nest-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code ok -level 3 -tag custom value;set reached after};p;set outer after}",
      budget=100000,
    ),
    "2 value {-code 0 -level 2 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-ok-3-nest-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code ok -level 3 -tag custom value;set reached after};proc q {} {p;set inner after};q;set outer after}",
      budget=100000,
    ),
    "2 value {-code 0 -level 1 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-ok-4-nest-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -code ok -level 4 -tag custom value;set reached after}",
      budget=100000,
    ),
    "2 value {-code 0 -level 4 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-ok-4-nest-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code ok -level 4 -tag custom value;set reached after};p;set outer after}",
      budget=100000,
    ),
    "2 value {-code 0 -level 3 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-ok-4-nest-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code ok -level 4 -tag custom value;set reached after};proc q {} {p;set inner after};q;set outer after}",
      budget=100000,
    ),
    "2 value {-code 0 -level 2 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-error-0-nest-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -code error -level 0 -tag custom value;set reached after}",
      budget=100000,
    ),
    "1 <error> {-code 1 -errorcode NONE -level 0 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-error-0-nest-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code error -level 0 -tag custom value;set reached after};p;set outer after}",
      budget=100000,
    ),
    "1 <error> {-code 1 -errorcode NONE -level 0 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-error-0-nest-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code error -level 0 -tag custom value;set reached after};proc q {} {p;set inner after};q;set outer after}",
      budget=100000,
    ),
    "1 <error> {-code 1 -errorcode NONE -level 0 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-error-1-nest-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -code error -level 1 -tag custom value;set reached after}",
      budget=100000,
    ),
    "2 value {-code 1 -errorcode NONE -level 1 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-error-1-nest-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code error -level 1 -tag custom value;set reached after};p;set outer after}",
      budget=100000,
    ),
    "1 <error> {-code 1 -errorcode NONE -level 0 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-error-1-nest-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code error -level 1 -tag custom value;set reached after};proc q {} {p;set inner after};q;set outer after}",
      budget=100000,
    ),
    "1 <error> {-code 1 -errorcode NONE -level 0 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-error-2-nest-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -code error -level 2 -tag custom value;set reached after}",
      budget=100000,
    ),
    "2 value {-code 1 -errorcode NONE -level 2 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-error-2-nest-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code error -level 2 -tag custom value;set reached after};p;set outer after}",
      budget=100000,
    ),
    "2 value {-code 1 -errorcode NONE -level 1 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-error-2-nest-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code error -level 2 -tag custom value;set reached after};proc q {} {p;set inner after};q;set outer after}",
      budget=100000,
    ),
    "1 <error> {-code 1 -errorcode NONE -level 0 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-error-3-nest-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -code error -level 3 -tag custom value;set reached after}",
      budget=100000,
    ),
    "2 value {-code 1 -errorcode NONE -level 3 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-error-3-nest-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code error -level 3 -tag custom value;set reached after};p;set outer after}",
      budget=100000,
    ),
    "2 value {-code 1 -errorcode NONE -level 2 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-error-3-nest-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code error -level 3 -tag custom value;set reached after};proc q {} {p;set inner after};q;set outer after}",
      budget=100000,
    ),
    "2 value {-code 1 -errorcode NONE -level 1 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-error-4-nest-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -code error -level 4 -tag custom value;set reached after}",
      budget=100000,
    ),
    "2 value {-code 1 -errorcode NONE -level 4 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-error-4-nest-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code error -level 4 -tag custom value;set reached after};p;set outer after}",
      budget=100000,
    ),
    "2 value {-code 1 -errorcode NONE -level 3 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-error-4-nest-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code error -level 4 -tag custom value;set reached after};proc q {} {p;set inner after};q;set outer after}",
      budget=100000,
    ),
    "2 value {-code 1 -errorcode NONE -level 2 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-return-0-nest-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -code return -level 0 -tag custom value;set reached after}",
      budget=100000,
    ),
    "2 value {-code 0 -level 1 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-return-0-nest-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code return -level 0 -tag custom value;set reached after};p;set outer after}",
      budget=100000,
    ),
    "0 after {-code 0 -level 0 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-return-0-nest-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code return -level 0 -tag custom value;set reached after};proc q {} {p;set inner after};q;set outer after}",
      budget=100000,
    ),
    "0 after {-code 0 -level 0 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-return-1-nest-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -code return -level 1 -tag custom value;set reached after}",
      budget=100000,
    ),
    "2 value {-code 0 -level 2 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-return-1-nest-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code return -level 1 -tag custom value;set reached after};p;set outer after}",
      budget=100000,
    ),
    "2 value {-code 0 -level 1 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-return-1-nest-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code return -level 1 -tag custom value;set reached after};proc q {} {p;set inner after};q;set outer after}",
      budget=100000,
    ),
    "0 after {-code 0 -level 0 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-return-2-nest-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -code return -level 2 -tag custom value;set reached after}",
      budget=100000,
    ),
    "2 value {-code 0 -level 3 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-return-2-nest-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code return -level 2 -tag custom value;set reached after};p;set outer after}",
      budget=100000,
    ),
    "2 value {-code 0 -level 2 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-return-2-nest-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code return -level 2 -tag custom value;set reached after};proc q {} {p;set inner after};q;set outer after}",
      budget=100000,
    ),
    "2 value {-code 0 -level 1 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-return-3-nest-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -code return -level 3 -tag custom value;set reached after}",
      budget=100000,
    ),
    "2 value {-code 0 -level 4 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-return-3-nest-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code return -level 3 -tag custom value;set reached after};p;set outer after}",
      budget=100000,
    ),
    "2 value {-code 0 -level 3 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-return-3-nest-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code return -level 3 -tag custom value;set reached after};proc q {} {p;set inner after};q;set outer after}",
      budget=100000,
    ),
    "2 value {-code 0 -level 2 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-return-4-nest-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -code return -level 4 -tag custom value;set reached after}",
      budget=100000,
    ),
    "2 value {-code 0 -level 5 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-return-4-nest-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code return -level 4 -tag custom value;set reached after};p;set outer after}",
      budget=100000,
    ),
    "2 value {-code 0 -level 4 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-return-4-nest-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code return -level 4 -tag custom value;set reached after};proc q {} {p;set inner after};q;set outer after}",
      budget=100000,
    ),
    "2 value {-code 0 -level 3 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-break-0-nest-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -code break -level 0 -tag custom value;set reached after}",
      budget=100000,
    ),
    "3 value {-code 3 -level 0 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-break-0-nest-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code break -level 0 -tag custom value;set reached after};p;set outer after}",
      budget=100000,
    ),
    "1 <error> {-code 1 -errorcode {TCL RESULT UNEXPECTED} -level 0 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-break-0-nest-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code break -level 0 -tag custom value;set reached after};proc q {} {p;set inner after};q;set outer after}",
      budget=100000,
    ),
    "1 <error> {-code 1 -errorcode {TCL RESULT UNEXPECTED} -level 0 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-break-1-nest-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -code break -level 1 -tag custom value;set reached after}",
      budget=100000,
    ),
    "2 value {-code 3 -level 1 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-break-1-nest-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code break -level 1 -tag custom value;set reached after};p;set outer after}",
      budget=100000,
    ),
    "3 value {-code 3 -level 0 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-break-1-nest-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code break -level 1 -tag custom value;set reached after};proc q {} {p;set inner after};q;set outer after}",
      budget=100000,
    ),
    "1 <error> {-code 1 -errorcode {TCL RESULT UNEXPECTED} -level 0 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-break-2-nest-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -code break -level 2 -tag custom value;set reached after}",
      budget=100000,
    ),
    "2 value {-code 3 -level 2 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-break-2-nest-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code break -level 2 -tag custom value;set reached after};p;set outer after}",
      budget=100000,
    ),
    "2 value {-code 3 -level 1 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-break-2-nest-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code break -level 2 -tag custom value;set reached after};proc q {} {p;set inner after};q;set outer after}",
      budget=100000,
    ),
    "3 value {-code 3 -level 0 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-break-3-nest-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -code break -level 3 -tag custom value;set reached after}",
      budget=100000,
    ),
    "2 value {-code 3 -level 3 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-break-3-nest-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code break -level 3 -tag custom value;set reached after};p;set outer after}",
      budget=100000,
    ),
    "2 value {-code 3 -level 2 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-break-3-nest-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code break -level 3 -tag custom value;set reached after};proc q {} {p;set inner after};q;set outer after}",
      budget=100000,
    ),
    "2 value {-code 3 -level 1 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-break-4-nest-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -code break -level 4 -tag custom value;set reached after}",
      budget=100000,
    ),
    "2 value {-code 3 -level 4 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-break-4-nest-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code break -level 4 -tag custom value;set reached after};p;set outer after}",
      budget=100000,
    ),
    "2 value {-code 3 -level 3 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-break-4-nest-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code break -level 4 -tag custom value;set reached after};proc q {} {p;set inner after};q;set outer after}",
      budget=100000,
    ),
    "2 value {-code 3 -level 2 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-continue-0-nest-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -code continue -level 0 -tag custom value;set reached after}",
      budget=100000,
    ),
    "4 value {-code 4 -level 0 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-continue-0-nest-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code continue -level 0 -tag custom value;set reached after};p;set outer after}",
      budget=100000,
    ),
    "1 <error> {-code 1 -errorcode {TCL RESULT UNEXPECTED} -level 0 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-continue-0-nest-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code continue -level 0 -tag custom value;set reached after};proc q {} {p;set inner after};q;set outer after}",
      budget=100000,
    ),
    "1 <error> {-code 1 -errorcode {TCL RESULT UNEXPECTED} -level 0 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-continue-1-nest-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -code continue -level 1 -tag custom value;set reached after}",
      budget=100000,
    ),
    "2 value {-code 4 -level 1 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-continue-1-nest-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code continue -level 1 -tag custom value;set reached after};p;set outer after}",
      budget=100000,
    ),
    "4 value {-code 4 -level 0 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-continue-1-nest-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code continue -level 1 -tag custom value;set reached after};proc q {} {p;set inner after};q;set outer after}",
      budget=100000,
    ),
    "1 <error> {-code 1 -errorcode {TCL RESULT UNEXPECTED} -level 0 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-continue-2-nest-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -code continue -level 2 -tag custom value;set reached after}",
      budget=100000,
    ),
    "2 value {-code 4 -level 2 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-continue-2-nest-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code continue -level 2 -tag custom value;set reached after};p;set outer after}",
      budget=100000,
    ),
    "2 value {-code 4 -level 1 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-continue-2-nest-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code continue -level 2 -tag custom value;set reached after};proc q {} {p;set inner after};q;set outer after}",
      budget=100000,
    ),
    "4 value {-code 4 -level 0 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-continue-3-nest-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -code continue -level 3 -tag custom value;set reached after}",
      budget=100000,
    ),
    "2 value {-code 4 -level 3 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-continue-3-nest-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code continue -level 3 -tag custom value;set reached after};p;set outer after}",
      budget=100000,
    ),
    "2 value {-code 4 -level 2 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-continue-3-nest-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code continue -level 3 -tag custom value;set reached after};proc q {} {p;set inner after};q;set outer after}",
      budget=100000,
    ),
    "2 value {-code 4 -level 1 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-continue-4-nest-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -code continue -level 4 -tag custom value;set reached after}",
      budget=100000,
    ),
    "2 value {-code 4 -level 4 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-continue-4-nest-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code continue -level 4 -tag custom value;set reached after};p;set outer after}",
      budget=100000,
    ),
    "2 value {-code 4 -level 3 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-continue-4-nest-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code continue -level 4 -tag custom value;set reached after};proc q {} {p;set inner after};q;set outer after}",
      budget=100000,
    ),
    "2 value {-code 4 -level 2 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-7-0-nest-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -code 7 -level 0 -tag custom value;set reached after}",
      budget=100000,
    ),
    "7 value {-code 7 -level 0 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-7-0-nest-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code 7 -level 0 -tag custom value;set reached after};p;set outer after}",
      budget=100000,
    ),
    "7 value {-code 7 -level 0 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-7-0-nest-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code 7 -level 0 -tag custom value;set reached after};proc q {} {p;set inner after};q;set outer after}",
      budget=100000,
    ),
    "7 value {-code 7 -level 0 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-7-1-nest-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -code 7 -level 1 -tag custom value;set reached after}",
      budget=100000,
    ),
    "2 value {-code 7 -level 1 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-7-1-nest-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code 7 -level 1 -tag custom value;set reached after};p;set outer after}",
      budget=100000,
    ),
    "7 value {-code 7 -level 0 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-7-1-nest-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code 7 -level 1 -tag custom value;set reached after};proc q {} {p;set inner after};q;set outer after}",
      budget=100000,
    ),
    "7 value {-code 7 -level 0 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-7-2-nest-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -code 7 -level 2 -tag custom value;set reached after}",
      budget=100000,
    ),
    "2 value {-code 7 -level 2 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-7-2-nest-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code 7 -level 2 -tag custom value;set reached after};p;set outer after}",
      budget=100000,
    ),
    "2 value {-code 7 -level 1 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-7-2-nest-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code 7 -level 2 -tag custom value;set reached after};proc q {} {p;set inner after};q;set outer after}",
      budget=100000,
    ),
    "7 value {-code 7 -level 0 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-7-3-nest-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -code 7 -level 3 -tag custom value;set reached after}",
      budget=100000,
    ),
    "2 value {-code 7 -level 3 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-7-3-nest-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code 7 -level 3 -tag custom value;set reached after};p;set outer after}",
      budget=100000,
    ),
    "2 value {-code 7 -level 2 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-7-3-nest-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code 7 -level 3 -tag custom value;set reached after};proc q {} {p;set inner after};q;set outer after}",
      budget=100000,
    ),
    "2 value {-code 7 -level 1 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-7-4-nest-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -code 7 -level 4 -tag custom value;set reached after}",
      budget=100000,
    ),
    "2 value {-code 7 -level 4 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-7-4-nest-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code 7 -level 4 -tag custom value;set reached after};p;set outer after}",
      budget=100000,
    ),
    "2 value {-code 7 -level 3 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-7-4-nest-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code 7 -level 4 -tag custom value;set reached after};proc q {} {p;set inner after};q;set outer after}",
      budget=100000,
    ),
    "2 value {-code 7 -level 2 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return--1-0-nest-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -code -1 -level 0 -tag custom value;set reached after}",
      budget=100000,
    ),
    "-1 value {-code -1 -level 0 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return--1-0-nest-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code -1 -level 0 -tag custom value;set reached after};p;set outer after}",
      budget=100000,
    ),
    "-1 value {-code -1 -level 0 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return--1-0-nest-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code -1 -level 0 -tag custom value;set reached after};proc q {} {p;set inner after};q;set outer after}",
      budget=100000,
    ),
    "-1 value {-code -1 -level 0 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return--1-1-nest-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -code -1 -level 1 -tag custom value;set reached after}",
      budget=100000,
    ),
    "2 value {-code -1 -level 1 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return--1-1-nest-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code -1 -level 1 -tag custom value;set reached after};p;set outer after}",
      budget=100000,
    ),
    "-1 value {-code -1 -level 0 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return--1-1-nest-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code -1 -level 1 -tag custom value;set reached after};proc q {} {p;set inner after};q;set outer after}",
      budget=100000,
    ),
    "-1 value {-code -1 -level 0 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return--1-2-nest-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -code -1 -level 2 -tag custom value;set reached after}",
      budget=100000,
    ),
    "2 value {-code -1 -level 2 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return--1-2-nest-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code -1 -level 2 -tag custom value;set reached after};p;set outer after}",
      budget=100000,
    ),
    "2 value {-code -1 -level 1 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return--1-2-nest-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code -1 -level 2 -tag custom value;set reached after};proc q {} {p;set inner after};q;set outer after}",
      budget=100000,
    ),
    "-1 value {-code -1 -level 0 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return--1-3-nest-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -code -1 -level 3 -tag custom value;set reached after}",
      budget=100000,
    ),
    "2 value {-code -1 -level 3 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return--1-3-nest-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code -1 -level 3 -tag custom value;set reached after};p;set outer after}",
      budget=100000,
    ),
    "2 value {-code -1 -level 2 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return--1-3-nest-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code -1 -level 3 -tag custom value;set reached after};proc q {} {p;set inner after};q;set outer after}",
      budget=100000,
    ),
    "2 value {-code -1 -level 1 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return--1-4-nest-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -code -1 -level 4 -tag custom value;set reached after}",
      budget=100000,
    ),
    "2 value {-code -1 -level 4 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return--1-4-nest-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code -1 -level 4 -tag custom value;set reached after};p;set outer after}",
      budget=100000,
    ),
    "2 value {-code -1 -level 3 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return--1-4-nest-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -code -1 -level 4 -tag custom value;set reached after};proc q {} {p;set inner after};q;set outer after}",
      budget=100000,
    ),
    "2 value {-code -1 -level 2 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion plain-return" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return result}",
      budget=100000,
    ),
    "2 result {-code 0 -level 1}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion plain-empty-return" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return}",
      budget=100000,
    ),
    "2 {} {-code 0 -level 1}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion pairs-without-result" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -tag payload}",
      budget=100000,
    ),
    "2 {} {-code 0 -level 1 -tag payload}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion arbitrary-option-name" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return foo bar value}",
      budget=100000,
    ),
    "2 value {-code 0 -level 1 foo bar}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion double-dash-option" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -- value}",
      budget=100000,
    ),
    "2 {} {-- value -code 0 -level 1}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion abbreviation-is-custom" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -c error result}",
      budget=100000,
    ),
    "2 result {-c error -code 0 -level 1}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion sticky-success-options" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -level 0 -tag value first;set next second}",
      budget=100000,
    ),
    "0 second {-code 0 -level 0 -tag value}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion nested-return-options" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -options {-options {-code error -level 0 -errorcode {APP FAIL}} -tag A} bad}",
      budget=100000,
    ),
    "1 <error> {-code 1 -errorcode {APP FAIL} -level 0 -tag A}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion options-order" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -code error -options {-code 7 -level 0 -tag a} -code ok x}",
      budget=100000,
    ),
    "0 x {-code 0 -level 0 -tag a}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion multiple-options" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -options {-code error -tag old} -options {-level 0 -tag new} bad}",
      budget=100000,
    ),
    "1 <error> {-code 1 -errorcode NONE -level 0 -tag new}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion duplicate-options" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -tag old -tag new -level 0 x}",
      budget=100000,
    ),
    "0 x {-code 0 -level 0 -tag new}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion unused-error-options" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -code ok -level 0 -errorcode {APP OK} -errorinfo custom x}",
      budget=100000,
    ),
    "0 x {-code 0 -errorcode {APP OK} -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion error-default" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {error bad}",
      budget=100000,
    ),
    "1 <error> {-code 1 -errorcode NONE -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion error-explicit" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {error bad custom {APP FAIL}}",
      budget=100000,
    ),
    "1 <error> {-code 1 -errorcode {APP FAIL} -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion throw-explicit" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {throw {APP FAIL detail} bad}",
      budget=100000,
    ),
    "1 <error> {-code 1 -errorcode {APP FAIL detail} -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion error-clears-options" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -level 0 -tag X value;error bad}",
      budget=100000,
    ),
    "1 <error> {-code 1 -errorcode NONE -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion catch-clears-options" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -level 0 -tag X value;catch {set x 2};set x}",
      budget=100000,
    ),
    "0 2 {-code 0 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion catch-empty-clears" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {return -level 0 -tag X value;catch {};set x 2}",
      budget=100000,
    ),
    "0 2 {-code 0 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion catch-result-options-same" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {catch {return -level 0 -tag X value} x x;normalized $x}",
      budget=100000,
    ),
    "0 {-code 0 -level 0 -tag X} {-code 0 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion catch-result-array" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {array set a {};catch {return -code 7 X} a(result) a(options);list $a(result) [normalized $a(options)]}",
      budget=100000,
    ),
    "0 {X {-code 7 -level 1}} {-code 0 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion rethrow-error" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {catch {throw {APP FAIL} bad} value options;return -options $options $value}",
      budget=100000,
    ),
    "1 <error> {-code 1 -errorcode {APP FAIL} -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion rethrow-custom" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {catch {return -level 0 -code 8 -tag custom result} value options;return -options $options $value}",
      budget=100000,
    ),
    "8 result {-code 8 -level 0 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion rethrow-return" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {catch {return -level 2 -tag custom result} value options;return -options $options $value}",
      budget=100000,
    ),
    "2 result {-code 0 -level 2 -tag custom}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion rethrow-as-success" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {catch {throw APP bad} value options;dict set options -code 0;return -options $options recovered}",
      budget=100000,
    ),
    "0 recovered {-code 0 -errorcode APP -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion if-options" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {if 1 {return -level 0 -tag X value}}",
      budget=100000,
    ),
    "0 value {-code 0 -level 0 -tag X}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion eval-options" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {eval {return -level 0 -tag X value}}",
      budget=100000,
    ),
    "0 value {-code 0 -level 0 -tag X}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion namespace-options" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {namespace eval n {return -level 0 -tag X value}}",
      budget=100000,
    ),
    "0 value {-code 0 -level 0 -tag X}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion substitution-options" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {list [return -level 0 -tag X value]}",
      budget=100000,
    ),
    "0 value {-code 0 -level 0 -tag X}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion expression-options" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {expr {[return -level 0 -tag X 4]+1}}",
      budget=100000,
    ),
    "0 5 {-code 0 -level 0 -tag X}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion while-options" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {set i 0;while {[incr i]<2} {return -level 0 -tag X value}}",
      budget=100000,
    ),
    "0 {} {-code 0 -level 0 -tag X}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion for-options" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {for {set i 0} {$i<1} {incr i} {return -level 0 -tag X value}}",
      budget=100000,
    ),
    "0 {} {-code 0 -level 0 -tag X}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion foreach-options" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {foreach x {1} {return -level 0 -tag X value}}",
      budget=100000,
    ),
    "0 {} {-code 0 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion lmap-options" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {lmap x {1 2} {return -level 0 -tag X $x}}",
      budget=100000,
    ),
    "0 {1 2} {-code 0 -level 0 -tag X}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion procedure-options" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {return -tag X value};p}",
      budget=100000,
    ),
    "0 value {-code 0 -level 0 -tag X}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion try-ok" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {set x 3}}",
      budget=100000,
    ),
    "0 3 {-code 0 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion try-error" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {error bad}}",
      budget=100000,
    ),
    "1 <error> {-code 1 -errorcode NONE -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion try-on-ok" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {set x 3} on ok {value options} {list $value [normalized $options]}}",
      budget=100000,
    ),
    "0 {3 {-code 0 -level 0}} {-code 0 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion try-trap" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {throw {APP FAIL detail} bad} trap {APP FAIL} {value options} {list $value [dict get $options -errorcode]}}",
      budget=100000,
    ),
    "0 {bad {APP FAIL detail}} {-code 0 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion try-trap-whitespace" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {throw { APP   FAIL detail } bad} trap { APP FAIL } {value} {return -level 0 recovered}}",
      budget=100000,
    ),
    "0 recovered {-code 0 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion try-trap-not-glob" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {throw {APP FAIL} bad} trap {APP *} {} {set result wrong}}",
      budget=100000,
    ),
    "1 <error> {-code 1 -errorcode {APP FAIL} -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion try-trap-empty" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {error bad} trap {} {value} {list matched $value}}",
      budget=100000,
    ),
    "0 {matched bad} {-code 0 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion try-first-wins" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {throw {APP FAIL} bad} on error {} {set result first} trap {APP} {} {set result second}}",
      budget=100000,
    ),
    "0 first {-code 0 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion try-fallthrough" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {error bad} on error {a} - on ok {b c ignored} {list [info exists a] $b [dict get $c -code]}}",
      budget=100000,
    ),
    "0 {0 bad 1} {-code 0 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion try-multiple-fallthrough" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {return value} on return {a} - on ok {} - on error {x y} {list $x [dict get $y -level]}}",
      budget=100000,
    ),
    "0 {value 1} {-code 0 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion try-empty-variable-names" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {set value untouched;try {error bad} on error {{} options} {list $value [dict get $options -code]}}",
      budget=100000,
    ),
    "0 {untouched 1} {-code 0 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion try-handler-rethrow" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {throw {APP FAIL} bad} on error {value options} {return -options $options $value}}",
      budget=100000,
    ),
    "1 <error> {-code 1 -during {-code 1 -errorcode {APP FAIL} -level 0} -errorcode {APP FAIL} -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion try-handler-return" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {error first} on error {} {return -code error second}}",
      budget=100000,
    ),
    "2 second {-code 1 -errorcode NONE -level 1}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion try-handler-error" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {error first} on error {} {error second}}",
      budget=100000,
    ),
    "1 <error> {-code 1 -during {-code 1 -errorcode NONE -level 0} -errorcode NONE -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion try-handler-failure-finally" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {set cleaned 0;catch {try {error first} on error {} {error second} finally {set cleaned 1}};set cleaned}",
      budget=100000,
    ),
    "0 1 {-code 0 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion try-finally-success-options" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {return -level 0 -tag original value} finally {return -level 0 -tag cleanup discarded}}",
      budget=100000,
    ),
    "0 value {-code 0 -level 0 -tag original}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion try-finally-custom-options" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {set x 3} finally {return -level 0 -tag cleanup discarded}}",
      budget=100000,
    ),
    "0 3 {-code 0 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion try-nested-during" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {try {error A} on error {} {error B}} finally {error C}}",
      budget=100000,
    ),
    "1 <error> {-code 1 -during {-code 1 -during {-code 1 -errorcode NONE -level 0} -errorcode NONE -level 0} -errorcode NONE -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion try-error-global" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {catch {try {error A} on error {} {error B} finally {error C}} value options;list $value $::errorCode [dict get $options -during -errorcode]}",
      budget=100000,
    ),
    "0 {C NONE NONE} {-code 0 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion dict-update-return" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {set d {x 1};proc p {} {global d;dict update d x value {set value 9;return done}};list [p] $d}",
      budget=100000,
    ),
    "0 {done {x 9}} {-code 0 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion dict-with-error" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {set d {x 1};catch {dict with d {set x 7;throw APP bad}} value options;list $d $value [dict get $options -errorcode]}",
      budget=100000,
    ),
    "0 {{x 7} bad APP} {-code 0 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion dict-map-continue" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {dict map {k v} {a 1 b 2 c 3} {if {$v==2} {return -level 0 -code continue};expr {$v*2}}}",
      budget=100000,
    ),
    "0 {a 2 c 6} {-code 0 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion dict-for-break" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {set seen {};dict for {k v} {a 1 b 2 c 3} {lappend seen $k;if {$v==2} {return -level 0 -code break}};set seen}",
      budget=100000,
    ),
    "0 {a b} {-code 0 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion dict-filter-continue" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {dict filter {a 1 b 2 c 3} script {k v} {if {$v==2} {return -level 0 -code continue};expr {1}}}",
      budget=100000,
    ),
    "0 {a 1 c 3} {-code 0 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion lmap-break" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {lmap x {1 2 3} {if {$x==3} {return -level 0 -code break};expr {$x*2}}}",
      budget=100000,
    ),
    "0 {2 4} {-code 0 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion lmap-continue" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {lmap x {1 2 3} {if {$x==2} {return -level 0 -code continue};expr {$x*2}}}",
      budget=100000,
    ),
    "0 {2 6} {-code 0 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion proc-break-loop" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc stop {} {return -code break};set seen {};foreach x {1 2 3} {lappend seen $x;stop};set seen}",
      budget=100000,
    ),
    "0 1 {-code 0 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion proc-continue-loop" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc skip {} {return -code continue};set seen {};foreach x {1 2} {lappend seen $x;skip;lappend seen wrong};set seen}",
      budget=100000,
    ),
    "0 {1 2} {-code 0 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion try-finally-break-loop" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {set seen {};foreach x {1 2 3} {try {if {$x==2} {break};lappend seen $x} finally {lappend seen F}};set seen}",
      budget=100000,
    ),
    "0 {1 F F} {-code 0 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion try-finally-return-proc" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {set seen {};proc p {} {global seen;try {return done} finally {lappend seen clean}};list [p] $seen}",
      budget=100000,
    ),
    "0 {done clean} {-code 0 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion uplevel-return" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc inner {} {uplevel 1 {return -level 1 done}};proc outer {} {inner;return after};outer}",
      budget=100000,
    ),
    "0 after {-code 0 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion namespace-return" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {proc p {} {namespace eval n {return done};return after};p}",
      budget=100000,
    ),
    "0 done {-code 0 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion ensemble-return" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {namespace eval a {proc p {} {return -code 7 custom};namespace export p;namespace ensemble create};a p}",
      budget=100000,
    ),
    "7 custom {-code 7 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion finally-ok-ok" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {set result body} finally {set result final}}",
      budget=100000,
    ),
    "0 body {-code 0 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion finally-ok-error" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {set result body} finally {error final}}",
      budget=100000,
    ),
    "1 <error> {-code 1 -during {-code 0 -level 0} -errorcode NONE -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion finally-ok-return" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {set result body} finally {return final}}",
      budget=100000,
    ),
    "2 final {-code 0 -level 1}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion finally-ok-break" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {set result body} finally {break}}",
      budget=100000,
    ),
    "3 {} {-code 3 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion finally-ok-continue" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {set result body} finally {continue}}",
      budget=100000,
    ),
    "4 {} {-code 4 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion finally-ok-custom" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {set result body} finally {return -level 0 -code 7 final}}",
      budget=100000,
    ),
    "7 final {-code 7 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion handler-ok-ok" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {set result body} on ok {value options} {list handled $value [normalized $options]}}",
      budget=100000,
    ),
    "0 {handled body {-code 0 -level 0}} {-code 0 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion handler-ok-error" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {set result body} on error {value options} {list handled $value [normalized $options]}}",
      budget=100000,
    ),
    "0 body {-code 0 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion handler-ok-return" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {set result body} on return {value options} {list handled $value [normalized $options]}}",
      budget=100000,
    ),
    "0 body {-code 0 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion handler-ok-break" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {set result body} on break {value options} {list handled $value [normalized $options]}}",
      budget=100000,
    ),
    "0 body {-code 0 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion handler-ok-continue" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {set result body} on continue {value options} {list handled $value [normalized $options]}}",
      budget=100000,
    ),
    "0 body {-code 0 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion handler-ok-7" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {set result body} on 7 {value options} {list handled $value [normalized $options]}}",
      budget=100000,
    ),
    "0 body {-code 0 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion finally-error-ok" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {error body} finally {set result final}}",
      budget=100000,
    ),
    "1 <error> {-code 1 -errorcode NONE -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion finally-error-error" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {error body} finally {error final}}",
      budget=100000,
    ),
    "1 <error> {-code 1 -during {-code 1 -errorcode NONE -level 0} -errorcode NONE -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion finally-error-return" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {error body} finally {return final}}",
      budget=100000,
    ),
    "2 final {-code 0 -level 1}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion finally-error-break" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {error body} finally {break}}",
      budget=100000,
    ),
    "3 {} {-code 3 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion finally-error-continue" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {error body} finally {continue}}",
      budget=100000,
    ),
    "4 {} {-code 4 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion finally-error-custom" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {error body} finally {return -level 0 -code 7 final}}",
      budget=100000,
    ),
    "7 final {-code 7 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion handler-error-ok" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {error body} on ok {value options} {list handled $value [normalized $options]}}",
      budget=100000,
    ),
    "1 <error> {-code 1 -errorcode NONE -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion handler-error-error" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {error body} on error {value options} {list handled $value [normalized $options]}}",
      budget=100000,
    ),
    "0 {handled body {-code 1 -errorcode NONE -level 0}} {-code 0 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion handler-error-return" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {error body} on return {value options} {list handled $value [normalized $options]}}",
      budget=100000,
    ),
    "1 <error> {-code 1 -errorcode NONE -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion handler-error-break" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {error body} on break {value options} {list handled $value [normalized $options]}}",
      budget=100000,
    ),
    "1 <error> {-code 1 -errorcode NONE -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion handler-error-continue" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {error body} on continue {value options} {list handled $value [normalized $options]}}",
      budget=100000,
    ),
    "1 <error> {-code 1 -errorcode NONE -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion handler-error-7" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {error body} on 7 {value options} {list handled $value [normalized $options]}}",
      budget=100000,
    ),
    "1 <error> {-code 1 -errorcode NONE -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion finally-return-ok" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {return body} finally {set result final}}",
      budget=100000,
    ),
    "2 body {-code 0 -level 1}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion finally-return-error" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {return body} finally {error final}}",
      budget=100000,
    ),
    "1 <error> {-code 1 -during {-code 0 -level 1} -errorcode NONE -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion finally-return-return" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {return body} finally {return final}}",
      budget=100000,
    ),
    "2 final {-code 0 -level 1}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion finally-return-break" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {return body} finally {break}}",
      budget=100000,
    ),
    "3 {} {-code 3 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion finally-return-continue" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {return body} finally {continue}}",
      budget=100000,
    ),
    "4 {} {-code 4 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion finally-return-custom" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {return body} finally {return -level 0 -code 7 final}}",
      budget=100000,
    ),
    "7 final {-code 7 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion handler-return-ok" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {return body} on ok {value options} {list handled $value [normalized $options]}}",
      budget=100000,
    ),
    "2 body {-code 0 -level 1}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion handler-return-error" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {return body} on error {value options} {list handled $value [normalized $options]}}",
      budget=100000,
    ),
    "2 body {-code 0 -level 1}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion handler-return-return" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {return body} on return {value options} {list handled $value [normalized $options]}}",
      budget=100000,
    ),
    "0 {handled body {-code 0 -level 1}} {-code 0 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion handler-return-break" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {return body} on break {value options} {list handled $value [normalized $options]}}",
      budget=100000,
    ),
    "2 body {-code 0 -level 1}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion handler-return-continue" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {return body} on continue {value options} {list handled $value [normalized $options]}}",
      budget=100000,
    ),
    "2 body {-code 0 -level 1}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion handler-return-7" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {return body} on 7 {value options} {list handled $value [normalized $options]}}",
      budget=100000,
    ),
    "2 body {-code 0 -level 1}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion finally-break-ok" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {break} finally {set result final}}",
      budget=100000,
    ),
    "3 {} {-code 3 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion finally-break-error" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {break} finally {error final}}",
      budget=100000,
    ),
    "1 <error> {-code 1 -during {-code 3 -level 0} -errorcode NONE -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion finally-break-return" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {break} finally {return final}}",
      budget=100000,
    ),
    "2 final {-code 0 -level 1}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion finally-break-break" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {break} finally {break}}",
      budget=100000,
    ),
    "3 {} {-code 3 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion finally-break-continue" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {break} finally {continue}}",
      budget=100000,
    ),
    "4 {} {-code 4 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion finally-break-custom" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {break} finally {return -level 0 -code 7 final}}",
      budget=100000,
    ),
    "7 final {-code 7 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion handler-break-ok" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {break} on ok {value options} {list handled $value [normalized $options]}}",
      budget=100000,
    ),
    "3 {} {-code 3 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion handler-break-error" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {break} on error {value options} {list handled $value [normalized $options]}}",
      budget=100000,
    ),
    "3 {} {-code 3 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion handler-break-return" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {break} on return {value options} {list handled $value [normalized $options]}}",
      budget=100000,
    ),
    "3 {} {-code 3 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion handler-break-break" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {break} on break {value options} {list handled $value [normalized $options]}}",
      budget=100000,
    ),
    "0 {handled {} {-code 3 -level 0}} {-code 0 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion handler-break-continue" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {break} on continue {value options} {list handled $value [normalized $options]}}",
      budget=100000,
    ),
    "3 {} {-code 3 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion handler-break-7" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {break} on 7 {value options} {list handled $value [normalized $options]}}",
      budget=100000,
    ),
    "3 {} {-code 3 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion finally-continue-ok" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {continue} finally {set result final}}",
      budget=100000,
    ),
    "4 {} {-code 4 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion finally-continue-error" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {continue} finally {error final}}",
      budget=100000,
    ),
    "1 <error> {-code 1 -during {-code 4 -level 0} -errorcode NONE -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion finally-continue-return" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {continue} finally {return final}}",
      budget=100000,
    ),
    "2 final {-code 0 -level 1}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion finally-continue-break" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {continue} finally {break}}",
      budget=100000,
    ),
    "3 {} {-code 3 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion finally-continue-continue" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {continue} finally {continue}}",
      budget=100000,
    ),
    "4 {} {-code 4 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion finally-continue-custom" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {continue} finally {return -level 0 -code 7 final}}",
      budget=100000,
    ),
    "7 final {-code 7 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion handler-continue-ok" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {continue} on ok {value options} {list handled $value [normalized $options]}}",
      budget=100000,
    ),
    "4 {} {-code 4 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion handler-continue-error" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {continue} on error {value options} {list handled $value [normalized $options]}}",
      budget=100000,
    ),
    "4 {} {-code 4 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion handler-continue-return" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {continue} on return {value options} {list handled $value [normalized $options]}}",
      budget=100000,
    ),
    "4 {} {-code 4 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion handler-continue-break" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {continue} on break {value options} {list handled $value [normalized $options]}}",
      budget=100000,
    ),
    "4 {} {-code 4 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion handler-continue-continue" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {continue} on continue {value options} {list handled $value [normalized $options]}}",
      budget=100000,
    ),
    "0 {handled {} {-code 4 -level 0}} {-code 0 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion handler-continue-7" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {continue} on 7 {value options} {list handled $value [normalized $options]}}",
      budget=100000,
    ),
    "4 {} {-code 4 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion finally-custom-ok" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {return -level 0 -code 7 body} finally {set result final}}",
      budget=100000,
    ),
    "7 body {-code 7 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion finally-custom-error" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {return -level 0 -code 7 body} finally {error final}}",
      budget=100000,
    ),
    "1 <error> {-code 1 -during {-code 7 -level 0} -errorcode NONE -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion finally-custom-return" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {return -level 0 -code 7 body} finally {return final}}",
      budget=100000,
    ),
    "2 final {-code 0 -level 1}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion finally-custom-break" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {return -level 0 -code 7 body} finally {break}}",
      budget=100000,
    ),
    "3 {} {-code 3 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion finally-custom-continue" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {return -level 0 -code 7 body} finally {continue}}",
      budget=100000,
    ),
    "4 {} {-code 4 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion finally-custom-custom" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {return -level 0 -code 7 body} finally {return -level 0 -code 7 final}}",
      budget=100000,
    ),
    "7 final {-code 7 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion handler-custom-ok" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {return -level 0 -code 7 body} on ok {value options} {list handled $value [normalized $options]}}",
      budget=100000,
    ),
    "7 body {-code 7 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion handler-custom-error" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {return -level 0 -code 7 body} on error {value options} {list handled $value [normalized $options]}}",
      budget=100000,
    ),
    "7 body {-code 7 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion handler-custom-return" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {return -level 0 -code 7 body} on return {value options} {list handled $value [normalized $options]}}",
      budget=100000,
    ),
    "7 body {-code 7 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion handler-custom-break" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {return -level 0 -code 7 body} on break {value options} {list handled $value [normalized $options]}}",
      budget=100000,
    ),
    "7 body {-code 7 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion handler-custom-continue" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {return -level 0 -code 7 body} on continue {value options} {list handled $value [normalized $options]}}",
      budget=100000,
    ),
    "7 body {-code 7 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion handler-custom-7" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "\nproc normalized {options} {\n set out {}\n foreach key [lsort [dict keys $options]] {\n  if {$key in {-errorinfo -errorline -errorstack}} {continue}\n  set value [dict get $options $key]\n  if {$key eq \"-during\"} {set value [normalized $value]}\n  lappend out $key $value\n }\n return $out\n}\nproc observed {script} {\n set code [catch {uplevel 1 $script} value options]\n if {$code == 1} {set value <error>}\n list $code $value [normalized $options]\n}\nobserved {try {return -level 0 -code 7 body} on 7 {value options} {list handled $value [normalized $options]}}",
      budget=100000,
    ),
    "0 {handled body {-code 7 -level 0}} {-code 0 -level 0}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion explicit-info" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "catch {error bad custom {APP FAIL}} value options;list $value [dict get $options -errorinfo] [dict get $options -errorcode] [dict get $options -errorstack] $::errorInfo $::errorCode",
      budget=100000,
    ),
    "bad custom {APP FAIL} {} custom {APP FAIL}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion explicit-stack" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "catch {return -level 0 -code error -errorinfo custom -errorstack {INNER here} bad} value options;list [dict get $options -errorinfo] [dict get $options -errorstack] [info errorstack]",
      budget=100000,
    ),
    "custom {INNER here} {INNER here}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion return-proc-explicit-info" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc p {} {return -code error -errorinfo custom -errorstack {INNER here} -errorcode APP bad};catch {p} value options;list [dict get $options -errorinfo] [dict get $options -errorstack] [dict get $options -errorline]",
      budget=100000,
    ),
    "{custom\n    invoked from within\n\"p\"} {INNER here} 1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion simple-error-info" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "catch {error bad} value options;dict get $options -errorinfo",
      budget=100000,
    ),
    "bad\n    while executing\n\"error bad\"",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion line-number" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "catch {\nset x 1\nerror bad\n} value options;dict get $options -errorline",
      budget=100000,
    ),
    "3",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion line-semicolon" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "catch {set x 1; error bad} value options;dict get $options -errorline",
      budget=100000,
    ),
    "1",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion line-comments" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "catch {# comment\n\n  error bad} value options;dict get $options -errorline",
      budget=100000,
    ),
    "3",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion line-outer" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "proc p {} {\nerror bad\n};catch {\n\np} value options;dict get $options -errorline",
      budget=100000,
    ),
    "3",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion cached-error-position" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set source {\nset x 1\nerror bad};set out {};foreach i {1 2} {catch $source value options;lappend out [dict get $options -errorline]};set out",
      budget=100000,
    ),
    "3 3",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion repeated-error-globals" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "catch {error A infoA CODE_A};set first [list $::errorInfo $::errorCode];catch {error B infoB CODE_B};list $first $::errorInfo $::errorCode",
      budget=100000,
    ),
    "{infoA CODE_A} infoB CODE_B",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion validation-on bad {} {}" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;set code [catch {try {incr x} on bad {} {}}];list $code $x",
      budget=100000,
    ),
    "1 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion validation-trap \\{ {} {}" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;set code [catch {try {incr x} trap \\{ {} {}}];list $code $x",
      budget=100000,
    ),
    "1 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion validation-on error \\{ {}" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;set code [catch {try {incr x} on error \\{ {}}];list $code $x",
      budget=100000,
    ),
    "1 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion validation-on error {} -" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;set code [catch {try {incr x} on error {} -}];list $code $x",
      budget=100000,
    ),
    "1 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion validation-finally {} extra" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;set code [catch {try {incr x} finally {} extra}];list $code $x",
      budget=100000,
    ),
    "1 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion validation-finally" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;set code [catch {try {incr x} finally}];list $code $x",
      budget=100000,
    ),
    "1 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion validation-bad value" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;set code [catch {try {incr x} bad value}];list $code $x",
      budget=100000,
    ),
    "1 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion validation-on error" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;set code [catch {try {incr x} on error}];list $code $x",
      budget=100000,
    ),
    "1 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion catch-result-write-failure" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval("array set a {};list [catch {catch {set x 9} a}] $x", budget=100000),
    "1 9",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion catch-options-write-failure" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "array set a {};list [catch {catch {set x 9} result a}] $result $x",
      budget=100000,
    ),
    "1 9 9",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion handler-variable-write-finally" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "array set a {};set cleaned 0;set code [catch {try {error bad} on error {a} {set reached 1} finally {set cleaned 1}}];list $code $cleaned [info exists reached]",
      budget=100000,
    ),
    "1 1 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion bad-finally-validates-first" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "set x 0;set code [catch {try {incr x} finally {incr x} on ok {} {incr x}}];list $code $x",
      budget=100000,
    ),
    "1 0",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion invalid-0" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("catch", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl completion invalid-1" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("catch a b c d", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl completion invalid-2" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("error", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl completion invalid-3" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("error a b c d", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl completion invalid-4" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("throw {} bad", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl completion invalid-5" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("throw APP", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl completion invalid-6" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("return -code bad X", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl completion invalid-7" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("return -level -1 X", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl completion invalid-8" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("return -level 1.5 X", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl completion invalid-9" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("return -options odd X", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl completion invalid-10" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("return -errorcode \\{ X", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl completion invalid-11" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("return -errorstack odd X", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl completion invalid-12" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("return -errorstack \\{ X", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl completion invalid-13" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("return -level 2147483648 X", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl completion invalid-14" {
  let t = @tcl.Interpreter::new()
  assert_true(
    try {
      ignore(t.eval("try", budget=100000))
      false
    } catch {
      _ => true
    },
  )
}

///|
test "Tcl completion lexical-z-aa" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "list [string compare {z} {aa}] [expr {{z} < {aa}}] [lsort [list {z} {aa}]]",
      budget=100000,
    ),
    "1 0 {aa z}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion lexical-long-x" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "list [string compare {long} {x}] [expr {{long} < {x}}] [lsort [list {long} {x}]]",
      budget=100000,
    ),
    "-1 1 {long x}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion lexical--tag--code" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "list [string compare {-tag} {-code}] [expr {{-tag} < {-code}}] [lsort [list {-tag} {-code}]]",
      budget=100000,
    ),
    "1 0 {-code -tag}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion lexical-ab-abc" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "list [string compare {ab} {abc}] [expr {{ab} < {abc}}] [lsort [list {ab} {abc}]]",
      budget=100000,
    ),
    "-1 1 {ab abc}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion lexical--a" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "list [string compare {} {a}] [expr {{} < {a}}] [lsort [list {} {a}]]",
      budget=100000,
    ),
    "-1 1 {{} a}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion lexical-中-中文" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "list [string compare {中} {中文}] [expr {{中} < {中文}}] [lsort [list {中} {中文}]]",
      budget=100000,
    ),
    "-1 1 {中 中文}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion lexical-😀-中" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "list [string compare {😀} {中}] [expr {{😀} < {中}}] [lsort [list {😀} {中}]]",
      budget=100000,
    ),
    "1 0 {中 😀}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion native-error-0" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "catch {missing_command x} value options;list $value [dict get $options -errorcode]",
      budget=100000,
    ),
    "{invalid command name \"missing_command\"} {TCL LOOKUP COMMAND missing_command}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion native-error-1" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "catch {{two words} x} value options;list $value [dict get $options -errorcode]",
      budget=100000,
    ),
    "{invalid command name \"two words\"} {TCL LOOKUP COMMAND {two words}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion native-error-2" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "catch {set absent} value options;list $value [dict get $options -errorcode]",
      budget=100000,
    ),
    "{can't read \"absent\": no such variable} {TCL LOOKUP VARNAME absent}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion native-error-3" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "catch {set a(x)} value options;list $value [dict get $options -errorcode]",
      budget=100000,
    ),
    "{can't read \"a(x)\": no such variable} {TCL LOOKUP VARNAME a}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion native-error-4" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "catch {set a 1;set a(x)} value options;list $value [dict get $options -errorcode]",
      budget=100000,
    ),
    "{can't read \"a(x)\": variable isn't array} {TCL LOOKUP VARNAME a}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion native-error-5" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "catch {array set a {};set a} value options;list $value [dict get $options -errorcode]",
      budget=100000,
    ),
    "{can't read \"a\": variable is array} {TCL READ VARNAME}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion native-error-6" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "catch {array set a {};set a(x)} value options;list $value [dict get $options -errorcode]",
      budget=100000,
    ),
    "{can't read \"a(x)\": no such element in array} {TCL READ VARNAME}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion native-error-7" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "catch {set x 1;unset x;set x} value options;list $value [dict get $options -errorcode]",
      budget=100000,
    ),
    "{can't read \"x\": no such variable} {TCL LOOKUP VARNAME x}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion native-error-8" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "catch {namespace eval n {set missing}} value options;list $value [dict get $options -errorcode]",
      budget=100000,
    ),
    "{can't read \"missing\": no such variable} {TCL LOOKUP VARNAME missing}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion native-error-9" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "catch {variable x;set x} value options;list $value [dict get $options -errorcode]",
      budget=100000,
    ),
    "{can't read \"x\": no such variable} {TCL READ VARNAME}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion native-error-10" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "catch {proc p {} {variable x;set x};p} value options;list $value [dict get $options -errorcode]",
      budget=100000,
    ),
    "{can't read \"x\": no such variable} {TCL READ VARNAME}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion native-error-11" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "catch {variable x;set x(a)} value options;list $value [dict get $options -errorcode]",
      budget=100000,
    ),
    "{can't read \"x(a)\": no such variable} {TCL LOOKUP VARNAME x}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion native-error-12" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "catch {proc p {} {upvar #0 absent alias;set alias(z)};p} value options;list $value [dict get $options -errorcode]",
      budget=100000,
    ),
    "{can't read \"alias(z)\": no such variable} {TCL LOOKUP VARNAME}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion native-error-13" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "catch {set x 1;proc p {} {upvar #0 x alias;set alias(z)};p} value options;list $value [dict get $options -errorcode]",
      budget=100000,
    ),
    "{can't read \"alias(z)\": variable isn't array} {TCL LOOKUP VARNAME}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion native-error-14" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "catch {proc p {} {upvar #0 absent(x) alias;set alias};p} value options;list $value [dict get $options -errorcode]",
      budget=100000,
    ),
    "{can't read \"alias\": no such variable} {TCL READ VARNAME}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion native-error-15" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "catch {array set a {};proc p {} {upvar #0 a(x) alias;set alias};p} value options;list $value [dict get $options -errorcode]",
      budget=100000,
    ),
    "{can't read \"alias\": no such variable} {TCL READ VARNAME}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion native-error-16" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "catch {proc p {} {upvar #0 missing alias;set alias};p} value options;list $value [dict get $options -errorcode]",
      budget=100000,
    ),
    "{can't read \"alias\": no such variable} {TCL READ VARNAME}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion native-error-17" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "catch {expr {1/0}} value options;list $value [dict get $options -errorcode]",
      budget=100000,
    ),
    "{divide by zero} {ARITH DIVZERO {divide by zero}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion native-error-18" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "catch {expr {100000000000000000000/0}} value options;list $value [dict get $options -errorcode]",
      budget=100000,
    ),
    "{divide by zero} {ARITH DIVZERO {divide by zero}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion native-error-19" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "catch {expr {1%0}} value options;list $value [dict get $options -errorcode]",
      budget=100000,
    ),
    "{divide by zero} {ARITH DIVZERO {divide by zero}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion native-error-20" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "catch {expr {0**-1}} value options;list $value [dict get $options -errorcode]",
      budget=100000,
    ),
    "{exponentiation of zero by negative power} {ARITH DOMAIN {exponentiation of zero by negative power}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion native-error-21" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "catch {expr {sqrt(-1)}} value options;list $value [dict get $options -errorcode]",
      budget=100000,
    ),
    "{domain error: argument not in valid range} {ARITH DOMAIN {domain error: argument not in valid range}}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion native-error-22" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "catch {throw {} X} value options;list $value [dict get $options -errorcode]",
      budget=100000,
    ),
    "{type must be non-empty list} {TCL OPERATION THROW BADEXCEPTION}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion native-error-23" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "catch {return -code BAD X} value options;list $value [dict get $options -errorcode]",
      budget=100000,
    ),
    "{bad completion code \"BAD\": must be ok, error, return, break, continue, or an integer} {TCL RESULT ILLEGAL_CODE}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion native-error-24" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "catch {try {} on BAD {} {}} value options;list $value [dict get $options -errorcode]",
      budget=100000,
    ),
    "{bad completion code \"BAD\": must be ok, error, return, break, continue, or an integer} {TCL RESULT ILLEGAL_CODE}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion native-error-25" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "catch {return -level -1 X} value options;list $value [dict get $options -errorcode]",
      budget=100000,
    ),
    "{bad -level value: expected non-negative integer but got \"-1\"} {TCL RESULT ILLEGAL_LEVEL}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion native-error-26" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "catch {return -level abc X} value options;list $value [dict get $options -errorcode]",
      budget=100000,
    ),
    "{bad -level value: expected non-negative integer but got \"abc\"} {TCL RESULT ILLEGAL_LEVEL}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion native-error-27" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "catch {return -level 1.5 X} value options;list $value [dict get $options -errorcode]",
      budget=100000,
    ),
    "{bad -level value: expected non-negative integer but got \"1.5\"} {TCL RESULT ILLEGAL_LEVEL}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion native-error-28" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "catch {return -level 2147483648 X} value options;list $value [dict get $options -errorcode]",
      budget=100000,
    ),
    "{bad -level value: expected non-negative integer but got \"2147483648\"} {TCL RESULT ILLEGAL_LEVEL}",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion trap-variable" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "try {set absent} trap {TCL LOOKUP VARNAME} {value options} {dict get $options -errorcode}",
      budget=100000,
    ),
    "TCL LOOKUP VARNAME absent",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion trap-command" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "try {missing_command} trap {TCL LOOKUP COMMAND} {} {set recovered yes}",
      budget=100000,
    ),
    "yes",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion trap-arithmetic" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "try {expr {1/0}} trap {ARITH DIVZERO} {} {set recovered yes}",
      budget=100000,
    ),
    "yes",
  )
  assert_eq(t.output_text(), "")
}

///|
test "Tcl completion trap-read" {
  let t = @tcl.Interpreter::new()
  assert_eq(
    t.eval(
      "array set a {};try {set a(missing)} trap {TCL READ VARNAME} {} {set recovered yes}",
      budget=100000,
    ),
    "yes",
  )
  assert_eq(t.output_text(), "")
}
