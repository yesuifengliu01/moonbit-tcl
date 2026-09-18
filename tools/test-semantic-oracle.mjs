import fs from 'node:fs';
import {createHash} from 'node:crypto';
import {evaluate} from '../web/engine.mjs';
const suite=process.argv[2]||'semantic';
if(!['semantic','cache','namespace','completion','syntax','unicode','conversion','value','switch'].includes(suite))throw new Error('suite must be semantic, cache, namespace, completion, syntax, unicode, conversion, value or switch');
const reference=JSON.parse(fs.readFileSync(new URL('../evidence/'+suite+'-reference.json',import.meta.url),'utf8'));
const rows=reference.rows.map(row=>{
 const actual=JSON.parse(evaluate(row.source));
 const matched=row.error?!actual.ok:actual.ok&&row.result===actual.result&&row.output===actual.output;
 const knownDifference=!!row.knownDifference&&!matched&&!row.error&&actual.ok&&actual.output===''&&actual.result===row.knownDifference.localResult&&row.result===row.knownDifference.referenceResult;
 const unexpected=(!matched&&!knownDifference)||(matched&&!!row.knownDifference);
 const result={...row,actual,matched,...(row.knownDifference?{knownDifferenceExpected:knownDifference}:{}),unexpected};if(unexpected)console.error(JSON.stringify(result));return result;
});
const report={reference:reference.reference,cases:rows.length,matched:rows.filter(r=>r.matched).length,
 engineSHA256:createHash('sha256').update(fs.readFileSync(new URL('../web/engine.mjs',import.meta.url))).digest('hex'),
 completionScope:reference.completionScope,syntaxScope:reference.syntaxScope,conversionScope:reference.conversionScope,
 knownDifferences:rows.filter(r=>r.knownDifferenceExpected).length,unexpectedDifferences:rows.filter(r=>r.unexpected).length,
 comparison:'Exact result and standard-output strings on success; rejection only on expected errors.',rows};
fs.writeFileSync(new URL('../evidence/'+suite+'-comparison.json',import.meta.url),JSON.stringify(report,null,2)+'\n');
console.log(JSON.stringify({cases:report.cases,matched:report.matched,knownDifferences:report.knownDifferences,unexpectedDifferences:report.unexpectedDifferences}));
process.exitCode=report.unexpectedDifferences===0?0:1;
