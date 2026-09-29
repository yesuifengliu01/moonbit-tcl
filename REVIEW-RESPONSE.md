# Tcl 初审意见回复 · 2026-09-30

原题名“实现 Tcl 8.6 解释器”超出了已验证范围，现统一为“MoonBit Tcl 脚本子集：直接重用既有 Tcllib 数据处理代码”。申请范围与 [申报书](PROPOSAL.md)、[README](README.md) 和模块元数据一致。

## 对兼容边界的修正

[兼容边界表](COMPATIBILITY-BOUNDARY.md) 列出 65 个初始命令名及各命令组选项范围。命令数量不是兼容率；未实现的 exec/socket/trace、事件循环、完整包索引、二进制扩展和完整编码仍逐项列出。Node FileSession 的根目录与资源预算是宿主约束，不是恶意 Tcl 脚本隔离保证。

## 已实现的使用依据

0.18.0 直接加载固定提交的 Tcllib csv 0.10 原始源码，读取含逗号、双引号和跨行字段的文件，按第三列筛选后调用原 csv::joinlist 导出。MoonBit 负责脚本执行、作用域、列表及数字版本包选择，Node 负责文件；CSV 算法归属 Tcllib。源文件、SHA-256、许可及复现命令见 [TCLLIB-CSV](TCLLIB-CSV.md)。

该消费者的 17 项行为与 Windows Tcl 8.6.15、Ubuntu Tcl 8.6.17 对照一致；实际文件流程在两平台运行，核心 JS/Wasm-GC 各 11217 项通过，回执见 [tcllib-csv.json](evidence/tcllib-csv.json)。只验证 csv::split/join/joinlist/iscomplete，不扩大为全部 Tcllib、matrix/queue 或厂商 EDA 脚本兼容，也不声称上游采用。

## 确定性与当前交付

原 tkinter/NUL 问题的修复独立保留：Ubuntu 24.04/Python 3.12.3/Tcl 8.6.14 中已复现旧问题，修复后 248 条夹具与 Windows 及仓内格式化结果逐字节一致，见 [ORACLE-NOBLE](ORACLE-NOBLE.md)。较早的 41 个文件/包场景、已知正则/排序差异及超时记录仍按日期保存在 TESTING/FEATURES 中。

最后核对的公开包为 0.17.1；本地候选 0.18.0 尚未推送或发布，新增消费者没有已观察到的同版公开 CI。复申需同步当前题名、完整仓库链接、代码和证据；现有材料支持明确子集的工程评估，最终审核由组委会决定。
