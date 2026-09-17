# MoonBit Tcl

Tcl 8.6 脚本解释器，0.4.0。本地独立实现，仍在追平成熟项目的完整行为。

## 本轮可用能力

- 延迟求值的表达式树：&&、||、?: 短路，整数/浮点运算、位运算、幂、比较、eq/ne、in/ni 和常用数学函数。整数最大 16384 位；整数与浮点比较保留大整数精度；浮点转整数直接还原 IEEE 754 数值。
- proc 默认/可变参数、递归、命名空间内过程解析、namespace eval/inscope/code、global/variable/upvar/uplevel；数组及元素别名、删除后重建。
- array set/get/names/size/exists/unset；dict 构造、嵌套路径、修改、迭代、过滤、update/with 写回。
- 常用 string 查询/转换/匹配/映射，以及 lset/linsert/lreplace/lsearch/lsort/lmap；if/then/elseif/else、for/foreach/while 和基本异常控制。
- 持久会话工作台：连续运行保留变量和过程，返回值与标准输出分栏；支持脚本导入/下载、清空会话、取消和 5 秒超时。普通脚本错误保留此前修改，取消/超时会清空整个会话。

## 使用

```powershell
./start-review.ps1
node tools/cli.mjs --file sample.txt --eval-json
node tools/cli.mjs --input 'expr {2**80}' --eval-json
./verify.ps1 -MoonPath C:/path/to/moon/bin/moon.exe
```

不指定输入源时从 UTF-8 stdin 读取。原有 --json 与文本模式保持兼容；--eval-json 分开返回 result、output、error。--session 从 stdin 逐行读取 JSON，在同一个解释器中执行：

```json
{"source":"set x 4"}
{"source":"incr x"}
{"reset":true}
{"source":"info exists x"}
```

每行输出一条 JSON。脚本失败后继续处理后续请求，进程最终退出码为 2；输入协议或宿主错误为 1，全部成功为 0。网页状态只存于 Worker 内存，不保存至磁盘。命令行 --file 是读取脚本文本，尚不提供 Tcl source/open 等文件命令。

## 独立证据

原有 248 项系统 Tcl 列表/过程/控制对照之外，本轮新增 726 项原始程序，由本机 Tcl 8.6.15 计算预期值。成功场景逐字比较返回值与 stdout，预期失败场景比较是否拒绝，不宣称错误消息兼容。预期值同时生成 MoonBit 公共 API 测试，在 JS 与 WasmGC 上运行。

```powershell
python tools/generate_list_oracle.py
python tools/generate-semantic-oracle.py
moon fmt
./verify.ps1
```

语义 oracle 再生严格要求 Python tkinter 链接 Tcl 8.6.15。仓库保存预期值，普通 verify 不依赖 tkinter；其它 Tcl 补丁版本不会静默覆盖本轮语义基准。CI 使用已提交预期值，远端 CI 未运行。

## 边界

仍缺 namespace import/export/path、包加载、regexp/regsub、switch、format/scan、trace、source/open/file/exec/socket、事件循环、完整 catch/return/error 选项等。string 字符类别目前主要覆盖 ASCII；非 BMP 字符在全部命令上的 Tcl 8.x UTF-16 行为未完成。字典和变量保持字符串表示，尚无 Tcl 对象缓存、字节码或成熟性能证明。不能将有限场景通过等同于完整 Tcl 兼容。

脚本最多 100000 UTF-16 单元；解析/执行嵌套 64 层；命令及替换共享预算，API 最大 1000000，网页/新会话接口使用 100000。字符串、变量值、列表结果及单次输出限 1000000 单元；整数 16384 位；数组 10000 元素；glob 动态规划最多 1000000 单元。网页 Worker 另有 5 秒终止机制。持久会话的累计内存尚无统一配额，因此不适合作为不可信多租户沙箱。

根据 [Tcl expr](https://www.tcl-lang.org/man/tcl8.6/TclCmd/expr.htm)、[namespace](https://www.tcl-lang.org/man/tcl8.6/TclCmd/namespace.htm)、[dict](https://www.tcl-lang.org/man/tcl8.6/TclCmd/dict.htm) 文档和系统解释器行为原创实现，没有复制上游源码。MIT 许可。详见 FEATURES.md、TESTING.md 与 evidence/semantic-upgrade.json。独立 Git 仓库，无 remote，未上传、发布或提交比赛。
