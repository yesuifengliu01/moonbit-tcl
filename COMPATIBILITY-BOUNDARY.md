# Tcl 8.6 子集的可核对边界 · 0.17.1

本仓库实现的是 Tcl 8.6 **脚本子集**，不是完整 Tcl 8.6 解释器。`runtime.mbt` 的 `builtin_names()` 注册 65 个命令名；一个名字存在不意味着其全部选项或上游边界都实现。动态过程、重命名和命名空间导入会让 `info commands` 的运行结果随脚本变化，所以下表描述的是初始内置范围。

| 类别 | 初始内置命令 | 限定范围 |
|---|---|---|
| 脚本/变量/过程 | `set unset incr append expr puts if proc return eval subst rename global variable upvar uplevel` | 过程参数、替换和常见作用域；不含完整对象系统、trace 或 Tcl 字节码 |
| 列表 | `list llength lindex lappend join split concat lrange lreverse lrepeat lset linsert lreplace lsearch lsort lmap` | `lsearch`、`lsort` 的已实现选项见 [完整矩阵](FEATURES.md)；错误原始字节、全部重入和诊断边界未追平 |
| 控制/异常 | `while for foreach break continue catch error try throw switch` | 常见完成码/选项；完整诊断堆栈仍有差异 |
| 集合/文本 | `array dict string info format scan regexp regsub namespace` | `array` 11 子命令；`dict/string/namespace` 是表中已列子集；正则有预算、已知字节码差异和复杂输入性能缺口 |
| 受限文件/包 | `source open close read gets seek tell eof flush fconfigure file pwd cd package` | 仅通过调用方配置的 Node `FileSession(root)` 提供真实磁盘 I/O；文件模式、通道、路径检查和数字版本 package 范围见 [FILE-IO](FILE-IO.md) |

明确缺失：`exec`、`socket`、事件循环/进程/网络通道、`trace`、完整 `auto_path/pkgIndex` 自动加载、二进制扩展、全部 `file`/`fconfigure` 选项及编码、全量错误码和 Tcl 对象/字节码行为。浏览器会话没有操作系统文件宿主。`FileSession` 有 128 通道、单次读写及 source 文件 8 MiB 等限制，并非恶意脚本沙箱。

复现：构建 JS 引擎后执行 `node tools/cli.mjs --input 'list [lsort {b a}] [lsearch {a b} b]' --eval-json`；返回列表包含排序结果 `a b` 与索引 `1`。`node tools/cli.mjs --input 'catch {exec foo} message; set message' --eval-json` 应返回找不到 `exec` 命令。实际文件/包任务见 [FILE-IO](FILE-IO.md) 与 `node tools/test-file-io.mjs`。

历史兼容证据是各日期固定的 Tcl 8.6.15 独立探针，不是 Tcl 官方全套测试。当前 0.17.1 的文件宿主另验证 41 个独立文件场景、6 个宿主流程；Windows 根目录大小写和失效链接保护见 [ROOT-PROTECTION](ROOT-PROTECTION.md)。列表 oracle 去掉 tkinter 中跨环境不稳定的 NUL/BEL 池输入，不表示 Tcl 不支持这些字符。来源及完整既有差异见 [FEATURES](FEATURES.md) 和 [TESTING](TESTING.md)。
