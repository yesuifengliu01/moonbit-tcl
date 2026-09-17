import fs from 'node:fs';
import {createHash} from 'node:crypto';
import {evaluate} from '../web/engine.mjs';
const suite=process.argv[2]||'semantic';
if(!['semantic','cache','namespace'].includes(suite))throw new Error('suite must be semantic, cache or namespace');
const reference=JSON.parse(fs.readFileSync(new URL('../evidence/'+suite+'-reference.json',import.meta.url),'utf8'));
const rows=reference.rows.map(row=>{
 const actual=JSON.parse(evaluate(row.source));
 const matched=row.error?!actual.ok:actual.ok&&row.result===actual.result&&row.output===actual.output;
 const result={...row,actual,matched};if(!matched)console.error(JSON.stringify(result));return result;
});
const report={reference:reference.reference,cases:rows.length,matched:rows.filter(r=>r.matched).length,
 engineSHA256:createHash('sha256').update(fs.readFileSync(new URL('../web/engine.mjs',import.meta.url))).digest('hex'),
 comparison:'Exact result and standard-output strings on success; rejection only on expected errors.',rows};
fs.writeFileSync(new URL('../evidence/'+suite+'-comparison.json',import.meta.url),JSON.stringify(report,null,2)+'\n');
console.log(JSON.stringify({cases:report.cases,matched:report.matched}));
process.exitCode=report.matched===report.cases?0:1;
