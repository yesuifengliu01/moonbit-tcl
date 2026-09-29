# Application-owned adapter: opt in to the tested Tcl 8.6 language profile.
# This is not a claim that the interpreter supports every Tcl 8.6 command.
package provide Tcl 8.6
source csv.tcl
set input [open input.csv r]
set records {}
set record {}
while {[gets $input line] >= 0} {
    if {$record ne {}} {append record \n}
    append record $line
    if {![::csv::iscomplete $record]} {continue}
    set fields [::csv::split $record]
    if {[llength $fields] != 3} {error "expected three CSV fields"}
    if {[lindex $fields 2] eq "keep"} {lappend records $fields}
    set record {}
}
close $input
if {$record ne {}} {error "incomplete CSV record"}
set output [open output.csv w]
fconfigure $output -translation lf
puts -nonewline $output [::csv::joinlist $records]
close $output
llength $records
