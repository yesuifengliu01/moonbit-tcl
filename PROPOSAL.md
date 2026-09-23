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
需求仅限已有 Tcl 脚本需要在 MoonBit 中执行明确子集；普通脚本任务不必选择 Tcl。初审结论仍由组委会决定，团队同步源码后再核对表单标题及链接。
