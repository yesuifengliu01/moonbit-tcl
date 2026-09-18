"""Fixed five-process timing campaign; retain every run, not the best run."""
from pathlib import Path
import subprocess,sys,json,statistics,re
root=Path(__file__).resolve().parents[1]
if len(sys.argv)!=5:raise SystemExit('Usage: baseline.mjs commit output.json reference.json')
baseline,commit,output,reference=sys.argv[1:]
if not re.fullmatch(r'[a-z0-9-]+\.json',output):raise SystemExit('Output must be an evidence JSON basename')
rounds=[]
for i in range(5):
    subprocess.run(['node','tools/compare-performance.mjs',baseline,commit,output,reference],cwd=root,check=True,stdout=subprocess.DEVNULL)
    rounds.append(json.loads((root/'evidence'/output).read_text(encoding='utf-8')))
first=rounds[0]
for run in rounds:
    for key in ['baselineCommit','baselineEngineSHA256','currentEngineSHA256','referenceSHA256','warmups','measurements']:
        assert run[key]==first[key],key
    assert [r['name'] for r in run['rows']]==[r['name'] for r in first['rows']]
rows=[]
for i,row in enumerate(first['rows']):
    parts=[run['rows'][i] for run in rounds]
    ratios=[r['currentMedianMs']/r['baselineMedianMs'] for r in parts]
    rows.append(dict(name=row['name'],currentOverBaselineMedian=statistics.median(ratios),currentOverBaselineRange=[min(ratios),max(ratios)],baselineMedianMs=statistics.median(r['baselineMedianMs'] for r in parts),currentMedianMs=statistics.median(r['currentMedianMs'] for r in parts),systemTclRatio=statistics.median(r['systemTclRatio'] for r in parts),allResultsMatched=all(r['resultMatched'] for r in parts)))
report={k:v for k,v in first.items() if k not in ['rows','scope']}
report.update(independentProcesses=5,rows=rows,rounds=rounds,scope='Five preselected sequential fresh Node processes, each with 20 warmups and 30 interleaved measurements per workload. Every run retained. Aggregate medians and min/max of run ratios; no significance test, application or cross-platform claim.')
(root/'evidence'/output).write_text(json.dumps(report,indent=2)+'\n',encoding='utf-8',newline='\n')
print(json.dumps(rows))
