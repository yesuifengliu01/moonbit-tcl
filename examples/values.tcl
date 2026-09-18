# Tcl 8.6 can display a rounded decimal while retaining a different exact double.
scan 18446744073709551616 %f amount
set display [format %s $amount]
puts "display: $display"
puts "stored:  [format %.17g $amount]"
puts "parsed:  [format %.17g $display]"

proc identity value { return $value }
dict set original nested amount [identity $amount]
set changed $original
dict set changed nested amount 0
puts "original: [format %.17g [dict get $original nested amount]]"
puts "changed:  [dict get $changed nested amount]"

catch {return -amount $amount saved} result options
format %.17g [dict get $options -amount]
