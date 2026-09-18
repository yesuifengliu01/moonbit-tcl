# Format a small receipt, then scan a structured status record.
set rows {{apple 3 1.375} {tea 2 4.125}}
puts [format {%-10s %4s %8s} Item Qty Total]
foreach row $rows {
    foreach {item qty price} $row {
        puts [format {%-10s %4d %8.2f} $item $qty [expr {$qty*$price}]]
    }
}
scan {order=23;status=ready} {order=%d;status=%s} order status
format {Order %04d: %s} $order $status
