"""Independent current-system Tcl timings; includes interpreter creation."""
from pathlib import Path
import tkinter,time,json,statistics,hashlib,_tkinter
root=Path(__file__).resolve().parents[1]
assert tkinter.Tcl().eval('info patchlevel')=='8.6.15','Benchmark reference requires Tcl 8.6.15'
workloads=[
 ('dictionary-100','set d {}; for {set i 0} {$i < 100} {incr i} {dict set d $i [expr {$i*$i}]}; dict get $d 99'),
 ('array-300','array set a {}; for {set i 0} {$i < 300} {incr i} {set a($i) [expr {$i*3}]}; list [array size a] $a(299)'),
 ('bigint-150','set x 1; for {set i 0} {$i < 150} {incr i} {set x [expr {$x * 3 + 1}]}; set x'),
 ('alias-200','proc bump {name} {upvar 1 $name x; incr x}; set x 0; for {set i 0} {$i < 200} {incr i} {bump x}; set x'),
 ('sort-200','set xs {}; for {set i 200} {$i > 0} {incr i -1} {lappend xs $i}; lindex [lsort -integer $xs] end'),
]
rows=[]
for name,source in workloads:
 samples=[]
 for i in range(25):
  start=time.perf_counter_ns();t=tkinter.Tcl();result=t.eval(source)
  elapsed=(time.perf_counter_ns()-start)/1e6
  if i>=5:samples.append(elapsed)
 samples.sort()
 hot=[];session=tkinter.Tcl()
 for i in range(25):
  start=time.perf_counter_ns();session.eval(source);elapsed=(time.perf_counter_ns()-start)/1e6
  if i>=5:hot.append(elapsed)
 hot.sort()
 rows.append(dict(name=name,source=source,result=result,medianMs=statistics.median(samples),p95Ms=samples[18],sessionMedianMs=statistics.median(hot),sessionP95Ms=hot[18]))
t=tkinter.Tcl();library=Path(t.eval('info library'))
runtime=Path(_tkinter.__file__).resolve()
files=[runtime,library/'init.tcl',library.parent.parent/'DLLs/tcl86t.dll']
proof=[dict(path=str(f),sha256=hashlib.sha256(f.read_bytes()).hexdigest()) for f in files if f.is_file()]
record=dict(reference='System Tcl '+t.eval('info patchlevel'),warmups=5,measurements=20,scope='Includes fresh interpreter creation. Python/Tcl and Node/MoonBit have different host overheads; local comparisons are not cross-platform performance parity.',provenance=proof,rows=rows)
(root/'evidence/semantic-benchmark-reference.json').write_text(json.dumps(record,indent=2)+'\n',encoding='utf-8',newline='\n')
print('Measured',len(rows),'system Tcl workloads')
