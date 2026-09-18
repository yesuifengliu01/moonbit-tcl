# Simple case mappings do not expand sharp-s into SS.
set greeting "İßǳ 中文"
puts [string tolower $greeting]
puts [string toupper $greeting]
puts [string totitle ǳABC]

# Classification reports the first failing character without overwriting
# the variable on success. Braced variable names can contain Unicode.
set 检查 untouched
set valid [string is alpha -failindex 检查 {中文1}]
puts "valid=$valid index=${检查}"

# Tcl 8.6 string indices and glob question marks use UTF-16 units.
set symbol 😀
set first [string index $symbol 0]
set second [string index $symbol 1]
puts [list [string length $symbol] [string match ? $symbol] [string match ?? $symbol]]
string equal $first$second $symbol
