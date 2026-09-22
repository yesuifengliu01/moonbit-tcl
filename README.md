# Tcl 列表脚本与文件/包兼容层

**本项目仓库：[https://github.com/yesuifengliu01/moonbit-tcl](https://github.com/yesuifengliu01/moonbit-tcl)**

模块 `yesuifengliu01/tcl`，本地版本 **0.17.0**，MIT。当前评审状态：**条件复审**。本文件是当前入口，旧轮次说明与详细用法保存在 [历史/完整使用说明](README-BEFORE-VALUE-REWORK.md)。

## 解决什么任务

执行明确受支持的 Tcl8.6 列表处理、source 和 package ifneeded 脚本，让 MoonBit 应用可承接这类脚本语义。团队使用中发现过 oracle 生成器的跨环境问题，这证明维护需求，但不能据此宣称已有 EDA 用户。

只有 Tcl 脚本兼容需求能支撑选择；含空格列表、source 和 package 是具体语义，不等于任意嵌入场景都需要 Tcl。

## 直接复现

安装 MoonBit 和 Node.js 24，在本仓库根目录运行：

```sh
moon build --target js
node -e "require('node:fs').copyFileSync('_build/js/debug/build/cmd/web/web.js','web/engine.mjs')"
node examples/run-use-case.mjs
```

流程：**按 Tcl 列表语义处理含空格文件清单**。运行器创建新的系统临时目录，保留每一步的 stdout/stderr、产物及 `report.json`，打印实际目录；重复运行不会覆盖之前产物。它只执行仓库内的本地样例，不连接公网或发送消息。`report.json` 的 `expected` 是应观察的结果，实际结果在各步输出中；成功退出不替代内容核对。

输入性质：原创 Tcl 脚本；解释器的选择依据限 Tcl 兼容，不假设现存 EDA 用户。

应观察：结果包含 2 个 .mbt 路径，src/main file.mbt 保持为一个列表元素。

具体命令和输入路径见 [使用任务](USE-CASE.md) 与 [机器可读流程](examples/use-case.json)。只把这个脚本当复现入口，不把通用运行器计作核心技术贡献。

## 实现与已有项目的关系

MoonBit 实现 Tcl 解析、值、作用域、异常/返回与包加载；Node FileSession 提供限定根目录的文件 I/O。

本轮未找到直接同范围 Tcl 包，但已有多种解释器。选 Tcl 的依据只能是 Tcl 脚本兼容；不能把可嵌入本身包装成所有脚本场景的必要选择。没有已确认厂商脚本或 EDA 命令集。

同类项目和检索边界见 [DUPLICATION](DUPLICATION.md)。查重用于避免错误的首创表述；关键词零结果不能证明生态空白，Node 宿主能力也不计为 MoonBit 原生 I/O。

库使用从 [公共 API](pkg.generated.mbti) 和根包源码开始；可在本 checkout 的消费包中导入 `"yesuifengliu01/tcl"`。源码中的网络/文件宿主入口及完整参数仍见 [完整使用说明](README-BEFORE-VALUE-REWORK.md)。是否已发布到 Mooncakes 需另核实，本文不把 `moon add` 的下载成功作为已完成事项。

## 验证与边界

前一轮工程验证 41 个场景与本机 Tcl8.6.15 实时比较一致，6 个宿主检查通过。已修复 NUL/BEL 经过 tkinter 导致跨环境 golden 不稳定的池输入；这不表示 Tcl 自身不支持控制字符。

[上一轮工程验证](evidence/innovation-review-20260922/results.json) 与 [本轮最小任务回执](evidence/value-rework-20260922/use-case.json) 分开。历史参考版本、golden 重放、本机 peer、真实第三方服务端和本次样例是不同证据，不能合并成“全部生产验证”。

常规核心检查可运行 `moon check --target js`、`moon test --target js`、`moon test --target wasm-gc`。专项命令：

```sh
node tools/test-file-io.mjs
```

专项所需的参考环境和历史版本见原使用说明及 TESTING 文档；本轮回执只记录实际执行项，不声称上面所有参考服务在任意环境即装即跑。

无任意 EDA/厂商扩展；没有网络/进程/事件通道、完整 auto_path 自动加载或所有编码。不要让潜在用途超出已验证脚本。

## 复审材料状态

团队报告过 oracle 维护问题，但没有确认的厂商/EDA 脚本；仍存在与 Forth 相同的必要性审查风险。

2026-09-22 匿名新克隆成功；默认分支 `main`，核验公开提交 `cfc178dddf7c11cf7879ccfcbec9e0b1ff4325f5`。本轮源码修订仅在本地，尚未推送；此记录不证明当时报名表中的地址正确，也不证明新修订已上线。

[申报草稿](PROPOSAL.md) 已压缩为 30 行以内，并单独标明本项目仓库；[复核说明](REVIEW-RESPONSE.md) 区分材料错误、功能变化及尚未解决的问题。没有编造用户、设备接入、生产部署或评审认可。
