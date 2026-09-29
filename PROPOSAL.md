# MoonBit Tcl 脚本子集：直接重用既有 Tcllib 数据处理代码

项目仓库：https://github.com/yesuifengliu01/moonbit-tcl；模块 `yesuifengliu01/tcl`，本地 0.18.0，MIT AND Unicode-3.0；个人项目。第三方 Tcllib 样例另保留原许可与署名。

## 选题依据

需要重用既有 Tcl 脚本时，逐行翻译到另一门语言可能改变列表、引用、命名空间或文件行为。本项目把明确范围的 Tcl 执行带入 MoonBit，保留脚本源文件，使用系统 Tcl 作独立参考。范围限可复現脚本子集，不再申报“完整 Tcl 8.6 解释器”，也不假设 EDA 厂商扩展可运行。

## 可见的使用任务

仓库固定并保留 Tcllib csv 0.10 的未经改写源码、提交与 SHA-256。可运行文件示例直接 source 该脚本，读取 CSV，按第三列筛选记录，再用原始 csv::joinlist 导出；包含带逗号、双引号及跨行字段。CSV 算法来自 Tcllib；这里的价值是 MoonBit 运行时重用这份现有脚本，而非重写一个 CSV 库或虚构客户需求。

## 本次实现

MoonBit 核心提供脚本解析、列表、变量与过程作用域、命名空间、返回/异常传播及有预算的执行。由实际脚本发现并补齐数字版本的多候选 package require/present：按候选逻辑选择最高兼容版本，不重复加载，非法后续要求仍拒绝。公开版本比较仍限已发布数字版本，不扩大到 alpha/beta、版本区间或完整自动加载。

应用适配显式声明“已验证的 Tcl 8.6 profile”后加载 csv.tcl；默认解释器不自动声称支持整个 Tcl 8.6。Node FileSession 承担文件 I/O 与根目录约束，解释和 CSV 脚本执行在 MoonBit 内完成。资源预算和路径限制不是恶意代码隔离保证。

## 证据与独立关系

2026-09-29，17 项 csv/版本选择用例与 Windows Tcl 8.6.15、Ubuntu Tcl 8.6.17 实时对照一致，文件消费例两平台通过；核心 JS/Wasm-GC 各 11217 项通过。测试读取原始脚本并先验 SHA，结果不是自行生成的 golden。源码、许可与复现见 TCLLIB-CSV.md，回执见 evidence/tcllib-csv.json。

Tcl/Tcllib 已有成熟实现，本项目不主张语言、CSV 算法或“生态首个脚本语言”原创。AI 辅助翻译不能替代既有脚本的执行语义检查；保留源码、明确失败和独立对照能减少手工移植中不易发现的差异。尚无确认的外部采用方。

## 交付边界

65 个初始命令名不代表全部选项兼容；验证覆盖 csv::split/join/joinlist/iscomplete，不包含 matrix/queue API、所有 Tcllib 包或完整 Tcl 8.6。无任意 EDA 命令、网络进程/事件循环、完整包索引。原 NUL oracle 确定性修复与文件根目录保护保留。0.17.1 已公开；新增 0.18.0 仅本地，未推送或发布，旧 CI 不能为新代码背书。
