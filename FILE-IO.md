# 文件与包的常用流程 · 0.17

Node 宿主新增真实文件会话，MoonBit 继续负责 Tcl 解析、作用域、返回/异常与包加载。无需修改脚本来模拟文件内容。

```powershell
node tools/cli.mjs --fs-root ./examples --input 'set f [open report.txt w]; puts $f hello; close $f' --eval-json
```

也可导入 `tools/file-session.mjs` 的 `FileSession(root)`，调用 `eval(source)` 并在结束时 `close()`。CLI 的 `--session --fs-root PATH` 在多条 JSON 请求间保留解释器和打开的文件；reset/结束时关闭本会话拥有的文件。根目录由调用方明确指定。

支持 `open` 的 r/r+/w/w+/a/a+、`close`、`read`、`gets`、文件 `puts`、`seek/tell/eof/flush`、常用 `fconfigure`，以及路径/存在性/文件大小、mkdir/copy/rename/delete、pwd/cd。UTF-8、Latin-1/二进制及常见换行转换可用；限制 128 个文件通道、单次读写和 source 文件 8 MiB。文件访问检查根目录和符号链接；不是恶意并发目录替换的隔离承诺。

`source` 在调用者作用域执行，处理嵌套调用、`return -level`、异常和 `info script` 恢复。核心 `Interpreter::set_io` 接受宿主回调，使其他后端也能注入文件实现；普通浏览器会话未连接操作系统文件。

`package provide/require/present/ifneeded/names/versions/forget/vcompare/vsatisfies` 支持常见已发布数字版本、选取符合条件的最高版本、精确版本、全局作用域加载和循环检测。可用 `package ifneeded demo 1.0 {source demo.tcl}` 注册包。不含自动扫描 pkgIndex/auto_path、二进制扩展、alpha/beta 版本及完整版本区间语法。

验证：41 个场景与本机未修改 Tcl 8.6.15 独立比较，包括实际磁盘、全部 256 个字节往返、加载作用域/返回和包工作流；另有 6 项宿主/CLI 检查。原有 JS/Wasm-GC 各 11211 项通过，新增 3 项核心宿主契约测试也分别通过；29 项持久会话及原 CLI 检查通过。

仍不含网络/进程/事件通道、非阻塞文件、完整编码集/通道配置、全部 file 子命令和 Tcl 自动加载生态。路径工具目前按宿主路径规则规范化，未承诺所有 Tcl 路径字符串边界相同。证据：`evidence/file-io-comparison.json`、`file-io-tests.txt`、`file-io-new-tests.txt`；当前提交指纹：`file-io-upgrade.json`。
