# MoonBit Tcl 8.6 脚本子集：列表、过程与受限文件 · 复审草稿

本项目仓库：https://github.com/yesuifengliu01/moonbit-tcl
模块 / 本地版本：`yesuifengliu01/tcl` / `0.17.1`；许可证：MIT AND Unicode-3.0。仅本地修改，尚未推送或重交表单。

## 修正标题与范围
原标题“实现 Tcl 8.6 解释器”容易被理解为完整兼容，现明确定位为 **Tcl 8.6 脚本子集**。初始内置 65 个命令名，但选项与边界只按 [COMPATIBILITY-BOUNDARY.md](COMPATIBILITY-BOUNDARY.md) 的表格支持；内置名称数不能充当完整兼容率。
实现脚本/变量/过程及常见控制命令；列表包括 `list/llength/lindex/lappend/lrange/lset/lsearch/lsort/lmap` 等；集合与文本包括 `array/dict/string/namespace/regexp/regsub/format/scan` 的已列子集。Node FileSession 在显式根目录内提供 `source`、常用文件通道和数字版本 package 流程。

## 可运行任务及证据
按 README 构建后，`node examples/run-use-case.mjs` 处理含空格文件名；`node tools/cli.mjs --input 'list [lsort {b a}] [lsearch {a b} b]' --eval-json` 返回 `{a b} 1`。`catch {exec foo}` 明确报告命令不存在。文件/包 41 个场景与 Tcl 8.6.15 独立比较，6 个宿主检查；原列表/过程/数组等兼容证据按 TESTING 与 FEATURES 的历史日期保留，不称整套官方测试通过。

## 明确不支持
不提供 `exec/socket/trace`、事件循环、完整 auto_path/pkgIndex、二进制扩展、全部编码/文件子命令、完整错误码或 Tcl 对象/字节码系统。正则、排序及转换仍有已记录差异；文件会话有资源和根目录约束，不是恶意脚本沙箱。没有确认的 EDA/厂商脚本用户，不能把潜在厂商兼容说成现有成果。
需求仅限已有 Tcl 脚本需要在 MoonBit 中执行明确子集；普通脚本任务不必选择 Tcl。初审结论仍由组委会决定，申报人同步源码后再核对表单标题及链接。

2026-09-27后续核验：在隔离Ubuntu24.04/Python3.12.3/Tcl8.6.14复现了原含NUL列表返回空串；现有修复版生成248条夹具，原始hash与此前Windows一致，格式化后逐字节等于当前Git提交。证据见 [ORACLE-NOBLE](ORACLE-NOBLE.md)。这不是远端GitHub CI成功声明。

**验收复现与交付状态（2026-09-28 本地）**：以 moonc 0.10.14+7d59c7ec9 通过 `--deny-warn` 检查、JS/Wasm-GC 测试和构建、最小样例和离线 `moon package`；同一代码在 Ubuntu-D 26.04 WSL2 全新解包后通过格式、接口生成、严格双后端检查及 Node 24.21.0 最小宿主入口；公开 Git HEAD 当日可匿名读取，Mooncakes 在线版 `0.17.0` 落后于本地 `0.17.1`；新版推送、远端 CI 和发布待核对。命令与能力边界见 [README](README.md)，自动检查见 [CI](.github/workflows/ci.yml)；本地通过不代表赛事审核通过。
