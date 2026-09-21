"""Original list/procedure/control scenarios evaluated by system Tcl 8.6.
Python must include tkinter. No expected result is computed by MoonBit.
"""
from pathlib import Path
import tkinter,random,json
root=Path(__file__).resolve().parents[1];tcl=tkinter.Tcl();assert tcl.eval('info patchlevel').startswith('8.6.')
rng=random.Random(20260910)
def lit(s):return json.dumps(s,ensure_ascii=False)
lines=['// Original scenarios; independent oracle: Tcl 8.6.']
# tkinter's Tcl bridge truncates strings containing NUL/BEL on some hosts.
# Keep those controls in direct MoonBit regressions; do not claim Tcl itself
# rejects them.
pool=['','simple','a b','a{b','a}b','a{b}c','{a}','a\\{b','a\\','a\\\nb','a\nb','a"b','"a"','a[b','a]b','$x',';x','#name','a#b','汉字🚀','a\t b','a\u00a0b','a\\ b','a\rb']
for i in range(180):
 values=[rng.choice(pool) for _ in range(rng.randrange(8))]
 # setvar avoids treating original values as script fragments.
 for j,value in enumerate(values):tcl.setvar('v'+str(j),value)
 result=tcl.eval('list '+' '.join('$v'+str(j) for j in range(len(values))))
 parsed=list(tcl.splitlist(result))
 if parsed != values:
  raise RuntimeError(f'fixture {i} Tcl list round-trip mismatch: {values!r} != {parsed!r}')
 array='['+','.join(lit(v) for v in values)+']'
 lines+=['///|',f'test "Tcl canonical list fixture {i}" {{',f' let values={array}',f' assert_eq(@tcl.format_list(values),{lit(result)})',f' assert_eq(@tcl.parse_list({lit(result)}),values)','}']
inputs=['{a\\\n b}','"a\\\n b"','a\\\n b','a\\',r'\x41 \u20ac \U0001f680 \777 \400',r'{a\{b} "quoted word" simple',r'{} "" { {nested} }',r'a"b a{b',r'{unterminated',r'"unterminated',r'{a}b',r'"a"b']
for i,text in enumerate(inputs):
 lines+=['///|',f'test "Tcl list parser fixture {i}" {{']
 try:
  values=tcl.splitlist(text);array='['+','.join(lit(v) for v in values)+']'
  lines+=[f' assert_eq(@tcl.parse_list({lit(text)}),{array})']
 except tkinter.TclError:lines+=[f' assert_true(try{{ignore(@tcl.parse_list({lit(text)}));false}}catch{{_=>true}})']
 lines+=['}']
scripts=[
 'list a b {c d} {  f {g h}}',
 'llength {a {b c} {}}',
 'lindex {{a b} {c d}} 1 0',
 'lindex {{a b} {c d}} {1 0}',
 'lindex {a b c} end-1',
 'lindex {a b c} end+1',
 'lindex {a b c} -1',
 'lindex { a   b } {}',
 'set x {a b}; lappend x {c d} {}; set x',
 'lappend missing',
 'split {a,,b,} ,',
 'split {} ,',
 'split {a b} {}',
 'join {a {b c} {}} ,',
 'concat {a b} {{c d} e}',
 'lrange {a b c d} 1 end-1',
 'lrange {a b c} -5 9',
 'lreverse {a {b c} {}}',
 'lrepeat 3 x {y z}',
 'lrepeat 0 x',
 'set out {}; foreach x {1 2 3 4} {lappend out [expr {$x * $x}]}; set out',
 'set out {}; foreach {i j} {a b c d e} {lappend out $j $i}; set out',
 'set out {}; foreach i {a b c} j {d e f g} {lappend out $i $j}; set out',
 'set out {}; foreach i {a b c} {j k} {d e f g} {lappend out $i $j $k}; set out',
 'set out {}; foreach x {1 2 3 4 5} {if {$x == 2} {continue}; if {$x == 4} {break}; lappend out $x}; set out',
 'set out {}; for {set i 0} {$i < 6} {incr i} {if {$i == 2} {continue}; if {$i == 5} {break}; lappend out $i}; set out',
 'set i 0; while {$i < 5} {incr i; if {$i == 2} {continue}; if {$i == 4} {break}}; set i',
 'proc p {a {b 2} args} {list $a $b $args}; p 1',
 'proc p {a {b 2} args} {list $a $b $args}; p 1 3 x {y z}',
 'proc p {a {b {x y}}} {list $a $b}; p hello',
 'proc p {{a x} b} {list $a $b}; p 1 2',
 'proc p {a a} {set a}; p 1 2',
 'proc p args {llength $args}; p a {b c} d',
 'proc p {{args x}} {set args}; p 1 2',
 'proc set {x} {return $x}; set ok',
 'proc p {} {foreach x {1 2 3} {if {$x == 2} {return yes}}; return no}; p',
 'list [catch {set x ok} v] $v [catch {error broken} v] $v',
 'list [catch {return result} v] $v [catch {break}] [catch {continue}]',
 'catch {for {set i 0} {$i < 1} {continue} {incr i}}',
 'catch {for {set i 0} {$i < 1} {break} {incr i}}',
 r'list \a \b \f \n \r \t \v \x41 \u20ac \U0001f680 \777 \400',
 'set x {a\\\n   b}; set x',
 'set x a\\\n   b; set x',
 'proc p {{a x} b} {}; p 1',
 'proc p {{a b c}} {}',
 'foreach {} {1 2} {}',
 'break',
 'continue',
 'proc p {} {break}; while {1} {p}',
 'lrepeat -1 x',
 'llength {a} extra',
 'set x { a   b }; lappend x',
 'concat { a   b } { "quoted word"  x }',
 'concat { } {} {x}',
 'lrange {a b c} 0 end+2147483647',
 'lrange {a b c} end-2147483647 end',
]
for i,script in enumerate(scripts):
 oracle=tkinter.Tcl()
 lines+=['///|',f'test "Tcl list control procedure script {i}" {{', ' let t=@tcl.Interpreter::new()']
 try:expected=oracle.eval(script);lines+=[f' assert_eq(t.eval({lit(script)}),{lit(expected)})']
 except tkinter.TclError:lines+=[f' assert_true(try{{ignore(t.eval({lit(script)}));false}}catch{{_=>true}})']
 lines+=['}']
(root/'list_oracle_test.mbt').write_text('\n'.join(lines)+'\n',encoding='utf-8',newline='\n')
print('Generated',180+len(inputs)+len(scripts),'independent Tcl cases')
