proc classify {line} {
    switch -regexp -nocase -matchvar parts -- $line {
        {^add[[:space:]]+([[:alpha:]]+)[[:space:]]+([0-9]+)$} {
            return [list add [lindex $parts 1] [lindex $parts 2]]
        }
        {^list$} -
        {^show$} {
            return [list show]
        }
        default {
            return [list invalid $line]
        }
    }
}
set totals {}
foreach line {{ADD tea 12} {add coffee 24} {add tea 8} show unknown} {
    set command [classify $line]
    switch [lindex $command 0] {
        add {dict incr totals [lindex $command 1] [lindex $command 2]}
        show {puts $totals}
        invalid {puts "ignored: [lindex $command 1]"}
    }
}
switch -glob -nocase [lindex [classify {ADD tea 1}] 0] {
    a* {dict get $totals tea}
    default {error "unexpected classification"}
}
