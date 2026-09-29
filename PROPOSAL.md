# MoonBit Tcl 8.6 脚本子集：列表、过程与受限文件会话

项目仓库：https://github.com/yesuifengliu01/moonbit-tcl。模块 `yesuifengliu01/tcl@0.17.1`；MIT AND Unicode-3.0。本次撤回容易被理解为完整兼容的旧标题，按实际命令子域申请复审。

## 适用任务与实现

需要在 MoonBit 应用中执行既有 Tcl 列表、过程、集合或文本处理片段时，可以复用本库的脚本语义，并由宿主提供明确允许的文件入口。普通新脚本任务无需选择 Tcl；适用前提是输入确实依赖已支持的 Tcl 语义，而非仅因为“可以写一个解释器”。

MoonBit 实现词法/求值、变量、过程、控制流，以及列表和 array/dict/string 等命令的已列子集。初始内置 65 个命令名，选项和兼容范围逐项列在 [COMPATIBILITY-BOUNDARY](COMPATIBILITY-BOUNDARY.md)，名称数量不充当兼容率。Node FileSession 在指定根目录内提供受限 source、文件通道与数字版本 package 流程。

## 可直接运行的任务

按 README 构建后，`node examples/run-use-case.mjs` 处理含空格文件名的文本；`node tools/cli.mjs --input 'list [lsort {b a}] [lsearch {a b} b]' --eval-json` 返回 `{a b} 1`。文件/包 41 个场景与独立 Tcl 8.6.15 对比，宿主约束及其余列表/过程等历史证据分别在 TESTING 和 FEATURES 标注，未声称通过完整 Tcl 官方测试集。

原有 oracle 的 NUL 跨环境问题已在隔离 Ubuntu 24.04、Python 3.12.3/Tcl 8.6.14 复现并验证修复；生成 248 条夹具与 Windows 相同，格式化后逐字节吻合提交文件，见 [ORACLE-NOBLE](ORACLE-NOBLE.md)。这一工程改进保证被声明的生成检查可复现，不扩张语言支持范围。

## 已有工作与明确边界

[Tcl](https://www.tcl-lang.org/) 已有成熟解释器，本项目不发明 Tcl 或声称 MoonBit 此前没有脚本语言。交付价值是可嵌入 MoonBit 的明确子集、确定输入输出与受限宿主契约；AI 生成脚本也需按同一边界核对，不能以生成成功代替执行正确。

不提供 exec/socket/trace、事件循环、全部编码、完整 auto_path/pkgIndex、二进制扩展或完整错误体系；不是恶意脚本沙箱。当前无确认的 EDA/厂商脚本使用方，不将潜在兼容场景写成已有采用。完整交付包括核心、文件适配、可运行例子、兼容表、测试与来源许可，复审以这些可检查内容为依据。

**公开状态（2026-09-29 核对）**：GitHub [公开仓库](https://github.com/yesuifengliu01/moonbit-tcl)、[Mooncakes 0.17.1](https://mooncakes.io/docs/yesuifengliu01/tcl@0.17.1) 已可访问；[CI 成功记录](https://github.com/yesuifengliu01/moonbit-tcl/actions/runs/36436197901) 对应 `02e7c535d393`。本次材料更新尚未推送；该远端 CI 对应所列公开提交。报名表一致性及赛事审核结果尚未核实。
