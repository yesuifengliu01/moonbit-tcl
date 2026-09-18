# Keep each identifier and its record together while sorting grouped data.
set stock {rack10 {coffee 34} rack2 {tea 12} rack1 {tea 7}}
puts [lsort -stride 2 -index 0 -dictionary $stock]
puts [lsort -stride 2 -index {1 1} -integer -indices $stock]
set duplicates {first 1 middle 2 latest 1}
puts [lsort -stride 2 -index 1 -integer -unique $duplicates]
proc compareQuantity {a b} {
    expr {[lindex $a 1] - [lindex $b 1]}
}
lsort -command compareQuantity {{coffee 34} {tea 12} {juice 7}}
