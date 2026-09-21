# MoonBit Tcl 8.6 脚本解释器 · 项目申报书

## 一、项目名称

MoonBit Tcl 8.6 脚本解释器

## 二、项目说明

当前公开模块 0.17.0 实现 Tcl 命令/变量替换、集合、过程、命名空间及受限文件/source/package 工作流。MoonBit 负责语义核心，Node 负责宿主；不能保证任意 EDA 工具脚本直接运行。

## 三、方向与通用性

编程语言与开发者工具。适合受支持子集的嵌入脚本、行为对照和解释器研究；不包括 EDA 厂商私有命令、二进制扩展及完整 Tcl 事件生态。

## 四、应用场景

在 MoonBit 应用调用会话 API，CLI 执行自有脚本；网页 Worker 观察集合和作用域行为；迁移存量脚本前先核对命令清单与资源限制。

## 五、功能与验证边界

历史双后端与原生 Tcl 对照分版本保留，明确差异不计一致。本次发现 CI 的 list oracle NUL 环境依赖，已有本地修复、248 项 oracle/控制字符回归及双宿主生成一致证据；远端失败尚未由新 run 关闭，不宣称当前 CI 全绿。

## 六、原创性与参考材料

原创核心 MIT。Tcl（BSD 风格 Tcl 许可证，https://www.tcl-lang.org/）作为行为基准，未复制 C 解释器实现；UnicodeData 16.0.0 为实际数据来源，按 vendor/ucd-16.0.0/LICENSE.txt 的 Unicode 许可保留来源、SHA256 和声明，不属于全部原创数据。

## 七、仓库链接

https://github.com/yesuifengliu01/moonbit-tcl
