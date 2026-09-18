array set stock {tea 12 coffee 8 juice 4}
set cursor [array startsearch stock]
set rows {}
while {[array anymore stock $cursor]} {
    set product [array nextelement stock $cursor]
    lappend rows [list $product $stock($product)]
}
array donesearch stock $cursor
puts [lsort -index 0 $rows]

set cursor [array startsearch stock]
incr stock(tea)
puts [array anymore stock $cursor]
set stock(water) 20
catch {array anymore stock $cursor} message
puts $message

proc reserve_slot {} {
    upvar #0 stock(reserved) slot
    return [array size ::stock]
}
puts [reserve_slot]
puts [lindex [split [array statistics stock] \n] 0]
lsort [array names stock]
