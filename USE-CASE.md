# 按 Tcl 列表语义处理含空格文件清单

执行明确受支持的 Tcl8.6 列表处理、source 和 package ifneeded 脚本，让 MoonBit 应用可承接这类脚本语义。团队使用中发现过 oracle 生成器的跨环境问题，这证明维护需求，但不能据此宣称已有 EDA 用户。

## 输入、操作、输出

原创 Tcl 脚本；解释器的选择依据限 Tcl 兼容，不假设现存 EDA 用户。

最简运行：先按 README 构建，然后 `node examples/run-use-case.mjs`。它自动创建输出目录并执行下面命令。下列 `{out}` 是运行器替换的实际目录，不是直接输入 shell 的变量；stdin 文件由运行器传递，以避免 Windows 与 POSIX 重定向差异。

```text
node tools/cli.mjs --file examples/use-case/manifest.tcl --eval-json
```

观察：结果包含 2 个 .mbt 路径，src/main file.mbt 保持为一个列表元素。

每一步输出见实际目录下 `step-N.stdout.txt` / `step-N.stderr.txt`；本轮已保存回执见 `evidence/value-rework-20260922/use-case.json`。

## 为什么保留这个实现

只有 Tcl 脚本兼容需求能支撑选择；含空格列表、source 和 package 是具体语义，不等于任意嵌入场景都需要 Tcl。

本轮未找到直接同范围 Tcl 包，但已有多种解释器。选 Tcl 的依据只能是 Tcl 脚本兼容；不能把可嵌入本身包装成所有脚本场景的必要选择。没有已确认厂商脚本或 EDA 命令集。

## 不能由样例推出的结论

无任意 EDA/厂商扩展；没有网络/进程/事件通道、完整 auto_path 自动加载或所有编码。不要让潜在用途超出已验证脚本。

该样例是可修改的使用入口，不能证明存在真实用户、全部兼容或性能领先。继续投入的依据应是明确的输入或接入需求；若对接任务用既有成熟库即可完成，应优先复用而不是为保留参赛数量扩张本项目。
