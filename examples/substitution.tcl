set name MoonBit
set count 0
set template {Hello $name, request [incr count].}
puts [subst $template]
puts [subst $template]
puts [subst -nocommands {literal [incr count], current $count}]
puts [subst {before[continue]after[return VALUE]}]
puts [subst {stop:[break]never[error unreachable]}]
set pending "foreach n {1 2 3} {\n"
puts "complete before append: [info complete $pending]"
append pending "incr count \$n\n}\nset count"
puts "complete after append: [info complete $pending]"
eval $pending
