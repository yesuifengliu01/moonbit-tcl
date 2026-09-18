set records {{rack2 tea 12} {rack10 coffee 34} {rack1 tea 7}}
set ordered [lsort -dictionary -index 0 $records]
puts $ordered
puts [lsearch -all -inline -index 1 -regexp $ordered {^tea$}]
puts [lsearch -all -index 1 -subindices $ordered tea]
array set stock {rack1 7 rack2 12 rack10 34 shelf3 8}
puts [lsort -dictionary [array names stock -regexp {^rack[0-9]+$}]]
list [lsearch -sorted -integer {7 12 34} 12] [lsearch -bisect -integer {7 12 34} 20]
