"""Validate current Git blobs and working files against the milestone manifest."""
from pathlib import Path
import subprocess,hashlib,json,sys
root=Path(__file__).resolve().parents[1]
def git(*args):return subprocess.check_output(['git',*args],cwd=root)
manifest_name='performance-upgrade.json' if (root/'evidence/performance-upgrade.json').exists() else 'semantic-upgrade.json'
manifest=json.loads((root/'evidence'/manifest_name).read_text(encoding='utf-8'))
revision='' if '--index' in sys.argv else 'HEAD'
count=0
for group in ['sourceGitBlobSHA256','evidenceGitBlobSHA256']:
    for path,expected in manifest[group].items():
        content=git('show',revision+':'+path)
        actual=hashlib.sha256(content).hexdigest()
        if actual!=expected:raise SystemExit('Manifest mismatch: '+path)
        working=(root/path).read_bytes()
        # Historical text blobs may predate the LF attributes. Accept only
        # line-ending normalization; binary artifacts must match raw bytes.
        binary=git('check-attr','text','--',path).decode().strip().endswith(': unset')
        if working!=content and (binary or working.replace(b'\r\n',b'\n')!=content.replace(b'\r\n',b'\n')):
            raise SystemExit('Working-file drift: '+path)
        count+=1
print('Verified',count,'Git blobs and working files')
