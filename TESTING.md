# Validation contract

Run verify.ps1 with MoonBit and Node 24 on PATH (or pass -MoonPath). It formats, generates the public API, checks without warnings, tests WasmGC and JS, rebuilds the shipped engine, then runs demo, CLI, semantic differential, session, malformed-input and benchmark checks. Expected counts and current results are recorded in evidence/semantic-upgrade.json.

The 726 original semantic fixtures are in tools/semantic-cases.py. tools/generate-semantic-oracle.py creates a fresh system Tcl 8.6.15 interpreter per program. Only puts is adapted to collect stdout. Expected results are written to evidence/semantic-reference.json and semantic_oracle_test.mbt. Successful programs compare exact result and output strings; expected errors compare rejection, not wording. The separate legacy generator retains its 248 list/procedure/control cases. Ordinary verification consumes checked-in expected values; regeneration requires the pinned reference version.

New session checks run the real exported module, JSON-lines CLI child processes, and the actual web Worker module through a Node message adapter. Browser acceptance is a separate live CUA run: example, continued state, output before errors, recovery, reset, cancellation, timeout, import/download and mobile layout. Node Worker checks do not stand in for browser acceptance.

The malformed-input corpus remains 307 seeded bounded inputs. Resource experiments and performance measurements are separate evidence; neither is proof of arbitrary hostile-input isolation. The persistent interpreter has no global memory quota.

After the final changes: run the full verifier; regenerate/format/info/build twice and compare source/artifact hashes; bind the evidence manifest to Git blob SHA256s. Reports from older dates are historical. No remote CI, upload, external service, or publication is performed.
