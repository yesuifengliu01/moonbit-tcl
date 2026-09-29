# 直接消费 Tcllib csv

源文件 `examples/tcllib-csv/csv.tcl` 来自 [Tcllib](https://github.com/tcltk/tcllib/blob/29bce268ae8d21a688d1a1efb256acc0e030a6a6/modules/csv/csv.tcl)，未经改写。固定提交、SHA-256 和完整 `license.terms` 保存在同目录；原版权属于 Jeffrey Hobbs、Andreas Kupries 等上游作者。本项目不将该算法记作原创贡献。

按 README 构建并刷新 JS engine，然后执行 `node tools/test-tcllib-csv.mjs`；需要 Python 的 tkinter/Tcl，Ubuntu 可安装 python3-tk。测试先校验源文件哈希，在新的解释器中加载相同原脚本，再将 17 项结果与独立 Tcl 对照。参考执行不调用 MoonBit 生成期望值。

文件消费例在新临时目录复制原脚本和输入，运行 `filter.tcl`，保留第三列为 keep 的记录；输入覆盖含逗号、引号和跨行字段，输出应有 2 条记录。若要保留输出，可把 `examples/tcllib-csv` 复制到新目录后运行：

```sh
node tools/cli.mjs --input "source filter.tcl" --fs-root /path/to/copied-tcllib-csv --eval-json
```

成功产生 output.csv；示例会覆盖同名输出，应使用新目录。filter.tcl 是本项目的适配示例，未经改动的可重用逻辑是 csv.tcl。没有声称某个 Tcllib 使用者采用了 MoonBit 解释器。

上游声明 `package require Tcl 8.5 9`。本次补齐已发布数字版本的多候选匹配。适配器先显式 `package provide Tcl 8.6`，表示调用者只在这个已验证场景中启用目标语言 profile；默认解释器不作全版本能力声明。不能把该声明用于跳过其他未知脚本的兼容验证。版本区间、alpha/beta、完整 package unknown/auto_path 仍不在支持范围内。

覆盖 split/join/joinlist/iscomplete、默认/自定义分隔符、转义引号、Unicode、跨行字段、无效参数与包选择。未验证 matrix/queue 接口或整个 Tcllib。宿主根目录约束不是敌对脚本的安全沙箱。

2026-09-29：Windows Tcl 8.6.15 与 Ubuntu Tcl 8.6.17 的 17 项结果一致，文件消费路径均通过；核心 JS/Wasm-GC 各 11217 项通过。回执：[Windows](evidence/tcllib-csv.json)、[Linux](evidence/tcllib-csv-linux.json)。新增 CI 步骤实时比较参考 Tcl，旧 CI 成功记录不覆盖此更新。
