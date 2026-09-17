set events {}
proc request {} {
 global events
 try {
  throw {APP RETRY unavailable} {service unavailable}
 } trap {APP RETRY} {message options} {
  lappend events [dict get $options -errorcode]
  return recovered
 } finally {
  lappend events cleaned
 }
}
puts [request]
puts $events
catch {try {throw FIRST original} finally {throw FINAL cleanup}} message options
list $message [dict get $options -errorcode] [dict get $options -during -errorcode]
