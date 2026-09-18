"""Independent bounded native references for signed-start overflow regressions."""
from pathlib import Path
import runpy,json
root=Path(__file__).resolve().parents[1]
sources=['regexp -all -start 2147483647 -inline -indices {} abc','regexp -all -start 2147483647 -inline -indices {a*} abc','regexp -all -start 2147483646 -inline -indices {} abc','regexp -all -start 2147483647 -inline -indices {$} abc']
rows,limits=runpy.run_path(str(root/'tools/switch-reference.py'))['generate']([dict(name='signed-start-'+str(i),source=s) for i,s in enumerate(sources)])
assert not limits and len(rows)==4 and not any(r['error'] for r in rows)
report=dict(reference='Windows Tcl 8.6.15, two-second bounded worker',rows=rows,excluded=limits,scope='Four independent edge references, also asserted by regexp_test.mbt on JS and WasmGC. Separate from the 6299-program matrix.')
(root/'evidence/regexp-start-reference.json').write_text(json.dumps(report,indent=2)+'\n',encoding='utf-8',newline='\n')
print('Generated four signed-start references')
