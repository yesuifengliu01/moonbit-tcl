# Extract records and redact email addresses without losing the session.
set text {Tea:12 Coffee:24 Tea:8}
set totals {}
foreach {whole name amount} [regexp -all -inline {([[:alpha:]]+):([0-9]+)} $text] {
    dict incr totals [string tolower $name] $amount
}
puts $totals
set message {Contact alice@example.com or bob@example.org}
set count [regsub -all {([[:alnum:]_.]+)@([[:alnum:].]+)} $message {<hidden>@\2} redacted]
puts $redacted
regexp -indices {Coffee:([0-9]+)} $text record amount
list $count [dict get $totals tea] $record $amount
