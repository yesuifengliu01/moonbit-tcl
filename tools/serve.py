"""Loopback-only static reviewer with deterministic MIME types on Windows."""
from http.server import ThreadingHTTPServer, SimpleHTTPRequestHandler
from pathlib import Path
from functools import partial
import argparse
from urllib.parse import parse_qs

class Handler(SimpleHTTPRequestHandler):
    extensions_map = {**SimpleHTTPRequestHandler.extensions_map,
                      '.mjs': 'text/javascript', '.js': 'text/javascript',
                      '.css': 'text/css', '.html': 'text/html',
                      '.json': 'application/json', '.md': 'text/plain; charset=utf-8',
                      '.mbt': 'text/plain; charset=utf-8', '.mbti': 'text/plain; charset=utf-8'}

    def send_head(self):
        path = Path(self.translate_path(self.path))
        root = Path(self.directory).resolve()
        if any(part in {'.git', '_build', 'target', '.mooncakes'} for part in path.parts) or not path.resolve().is_relative_to(root):
            self.send_error(404)
            return None
        return super().send_head()

    def list_directory(self, path):
        self.send_error(404)
        return None

    def do_POST(self):
        if self.path != '/download.tcl':
            self.send_error(404)
            return
        try:
            length = int(self.headers.get('Content-Length', '0'))
            if not 0 < length <= 2097152:
                self.send_error(413)
                return
            if self.headers.get('Content-Type','').split(';')[0] != 'application/x-www-form-urlencoded':
                self.send_error(415)
                return
            fields = parse_qs(self.rfile.read(length).decode('utf-8'), keep_blank_values=True, strict_parsing=True, max_num_fields=1)
            if set(fields) != {'source'} or len(fields['source']) != 1:
                raise ValueError('source required')
            data = fields['source'][0].encode('utf-8')
            if len(data) > 400000:
                self.send_error(413)
                return
        except (ValueError, UnicodeError):
            self.send_error(400)
            return
        self.send_response(200)
        self.send_header('Content-Type', 'application/octet-stream')
        self.send_header('Content-Disposition', 'attachment; filename="script.tcl"')
        self.send_header('Content-Length', str(len(data)))
        self.end_headers()
        self.wfile.write(data)

    def end_headers(self):
        self.send_header('Cache-Control', 'no-store')
        super().end_headers()

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--port', type=int, default=8769)
    args = parser.parse_args()
    root = Path(__file__).resolve().parents[1]
    server = ThreadingHTTPServer(('127.0.0.1', args.port), partial(Handler, directory=str(root)))
    print(f'Local review: http://127.0.0.1:{args.port}/web/', flush=True)
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        pass
    finally:
        server.server_close()
