# MoonBit Tcl

Tcl 8.6 脚本解释器，0.3.0。本地独立候选，目标继续追平成熟项目，当前尚非完整 Tcl 替代。

## 已实现的实际脚本路径

- 变量与命令替换、花括号/引号分组、整数表达式、set/incr/puts/if。
- proc 局部作用域、递归、默认参数、args 可变参数、return；可替换已有命令。
- list、llength、lindex（嵌套和 end 索引）、lappend、join、split、concat、lrange、lreverse、lrepeat。
- while/for/foreach，foreach 支持多组变量和列表、末组补空；break/continue；catch 和 error 的基本形式。
- parse_list/format_list 公开 API；列表不执行变量或命令替换，列表解析使用追加缓冲处理长元素。

## 运行和验证

```powershell
./start-review.ps1
node tools/cli.mjs --file sample.txt --json
./verify.ps1
# 编译器不在 PATH 时
./verify.ps1 -MoonPath C:/path/to/moon/bin/moon.exe
```

网页调用真实编译的 MoonBit 引擎，sample.txt 是默认参数、foreach 和列表的可直接运行示例。构建需 MoonBit，命令行需 Node.js，审查网页需 Python 3。公开 API 见 pkg.generated.mbti；[可执行文档](README.mbt.md)随测试运行。

## 独立 Tcl 对照

```powershell
python tools/generate_list_oracle.py
moon fmt
moon test --target wasm-gc
moon test --target js
```

Python 须含 tkinter（Linux 通常安装 python3-tk），oracle 要求 Tcl 8.6。本机为 8.6.15，使用 Tcl 解释器而非 Tk GUI，不需要图形窗口。新增 248 个原始场景由系统 Tcl 计算预期值，覆盖规范列表引用、嵌套列表、转义、错误、循环、默认/可变参数及重复形参行为。已有整数表达式对照用例仍保留。

对照揭示并修正了 concat 内部空白保留、零参数 lappend 的字符串表示、脚本与列表花括号的反斜杠换行差异等行为。它不是整个 Tcl 测试集通过的证明。

## 当前差距与限制

未实现命名空间、数组变量、global/upvar、dict/完整字符串命令、文件/进程/网络 I/O、完整 expr 运算与 Tcl 大整数；整数仍为 32 位。if 尚未支持完整 elseif/then 形式；catch/error/return 的高级选项不全。Unicode 的非 BMP 原始字符和转义在全部命令上的 Tcl 8.x UTF-16 一致性仍需系统验证，不能声称完全兼容。

脚本上限 100000 个 UTF-16 单元，嵌套 64 层，命令预算可配置（最大 1000000）；列表输入/结果限 1000000 单元、元素数 100000；变量/命令替换结果与累计打印输出同样限 1000000 单元，过程调用共享打印额度。列表数据中的脚本元字符保持数据语义。长列表与预算耗尽有回归用例。

## 来源与仓库

根据 [Tcl list](https://www.tcl-lang.org/man/tcl8.6/TclCmd/list.htm)、[proc](https://www.tcl-lang.org/man/tcl8.6/TclCmd/proc.htm)、[foreach](https://www.tcl-lang.org/man/tcl8.6/TclCmd/foreach.htm) 文档和系统 Tcl 的独立行为重新实现，没有复制上游代码。原创代码 MIT。完整边界见 FEATURES.md，测试流程见 TESTING.md，历史查重见 DUPLICATION.md。

独立 Git 仓库和构建目录，没有 remote，未上传或发布。CI 文件包含列表 oracle 再生，但远端 CI 未运行。本地最新证据见 evidence/current-validation.json；旧日期证据仅为历史快照。
