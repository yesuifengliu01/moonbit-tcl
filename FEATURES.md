# Tcl 兼容矩阵（0.6.0）

| 能力 | 本轮实现 | 仍需追平 |
|---|---|---|
| expr | BigInt/Double、算术/位运算/比较、eq/ne/in/ni、惰性 &&/||/?:、常用数学函数 | 完整函数分派、任意规模整数、全部浮点/错误细节 |
| 脚本解析 | 分组、变量/数组索引替换、命令替换、{*} 展开、按命令执行保留先前副作用 | 全部增量解析、info complete、极端嵌套替换副作用顺序 |
| 过程与作用域 | 默认参数/args、namespace eval/inscope、变量声明、global/upvar/uplevel、内置/过程重命名 | trace、别名全部边界、运行中 namespace 延迟销毁和根删除 |
| 命名空间库 | import/export/forget/origin、path/upvar/unknown、导入引用/循环检测、auto_import 回调 | Tcl 自带自动加载库、完整生态与上游全量 |
| ensemble | create/configure/exists、map/subcommands/parameters/prefixes/unknown、动态导出、转发帧与安全参数 | 全部重入/删除/错误堆栈边界、上游全量 |
| array | set/get/names/size/exists/unset、元素变量和别名 | 搜索游标、regexp、统计接口 |
| dict | 构造、get/set/unset、incr/append/lappend、for/map/filter/update/with | 全部写回异常边界、嵌套/数组对象缓存和代表性性能 |
| string | length/index/range、比较/查找、大小写、trim、repeat/reverse/replace、match/map/is 子集 | Unicode 完整分类及 UTF-16 一致性、failindex、全部选项 |
| list | 原有十命令 + lset/linsert/lreplace/lsearch/lsort/lmap | 字典排序、regexp/sorted 搜索、索引/stride 完整选项 |
| 控制与异常 | if/then/elseif/else、for/foreach/while、break/continue、catch/return/error 基本形式 | options 字典、return -level/-code、try/finally、switch |
| 工具和会话 | JSON 行 CLI、独立模块会话、真实 Worker 网页、导入/下载/清空/取消/超时 | Tcl 文件/网络/进程/事件 I/O、包/扩展生态、累计内存治理 |
| 性能与缓存 | 有界脚本/表达式缓存、普通整数快速路径、标量列表/字典延迟序列化 | 完整对象系统、字节码、嵌套/数组对象与累计内存治理；0.5.0 七组热会话仍慢约 4.0–6.9 倍（历史测量） |
| 证据 | 312 命名空间 + 340 缓存 + 726 语义 + 248 原有系统 Tcl 场景，两个编译后端，真实宿主验证 | 全量上游测试、跨操作系统、代表性性能和应用迁移 |

上述实现是可执行子集，不是全量上游通过声明；20 项追平目标继续保持活动状态。
