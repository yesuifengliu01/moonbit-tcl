# A reusable ledger exposed both as an ensemble and imported commands.
namespace eval ledger {
    variable totals {}
    namespace export add total
    proc add {item amount} {
        variable totals
        dict incr totals $item $amount
    }
    proc total {item} {
        variable totals
        dict get $totals $item
    }
    namespace ensemble create
}
namespace import ledger::add
add tea 12
ledger add tea 8
ledger add coffee 24
puts "tea: [ledger total tea]"
puts "coffee: [ledger total coffee]"
namespace origin add
