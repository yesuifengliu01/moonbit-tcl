set files [list {src/main file.mbt} src/lib.mbt README.md]
set sourceFiles {}
foreach name $files {
  if {[string match *.mbt $name]} { lappend sourceFiles $name }
}
list [llength $sourceFiles] $sourceFiles
