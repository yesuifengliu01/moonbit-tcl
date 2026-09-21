> 0.17：已补真实文件会话、source 与常用 package 工作流，详见 [使用方法与范围](FILE-IO.md)。下文旧版本验证保留原日期。

## 获取与验证入口

公开源码：[github.com/yesuifengliu01/moonbit-tcl](https://github.com/yesuifengliu01/moonbit-tcl)；MoonBit 模块名为 `yesuifengliu01/tcl`。

从源码运行：`git clone https://github.com/yesuifengliu01/moonbit-tcl.git` 后进入该目录，按下文和 [TESTING.md](TESTING.md) 安装所需工具。仓库公开不等于已在 Mooncakes 发布，不承诺 `moon add` 当前可用。

查看 [GitHub Actions](https://github.com/yesuifengliu01/moonbit-tcl/actions) 时请核对 run 的 commit SHA；历史 evidence、旧 ZIP 与本地测试不能替代当前提交的 CI 结果。下文保留各版本的验证范围和兼容性限制。

# MoonBit Tcl

> 2026-09-21 本地构建修复：命令包 import 已同步到当前 moon.mod 模块名；moon info/check、JS 构建、MoonBit 示例和 Node 引擎示例通过。算法未改，本轮未重跑历史全部行为/性能套件。当前提交指纹见 evidence/module-import-fix.json。

Tcl 8.6 脚本解释器，0.16.0。本地独立实现，仍在追平成熟项目的完整行为。

## 0.16.0 数组游标、哈希统计与变量生命周期

实现 array 的 11 个子命令及唯一缩写：anymore、donesearch、exists、get、names、nextelement、set、size、startsearch、statistics、unset。游标可以跨会话调用保留，anymore 不消耗条目，空键与耗尽结果分开处理；标识按当前存活搜索编号分配，可回收编号。新增/删除哈希条目使已有搜索失效，覆盖现有值保持游标。

采用 Tcl 8.6.15 的 modified UTF-8 字符串哈希与四倍扩容规则，保留桶链遍历次序；names/get 和 statistics 使用真实表结构。统计包含被元素别名保留但未定义的条目；size 只计算已定义元素。搜索标识的数值解析固定到 Windows Tcl 的 32 位 unsigned long 行为。

元素别名绑定原数组对象。删除并重建同名数组后，旧别名不能写进新数组；过程退出释放别名引用与局部数组。通过元素别名 unset 与直接删除条目的游标行为分别对齐原生，重绑/清理未定义条目会更新游标位置。修复孤立 UTF-16 数组索引的内部截取，保留内部数值精度。

938 个独立原生探针中 937 个完成且一致：935 个成功结果/stdout 逐字匹配、2 个预期拒绝；指定诊断通过 catch 包装后逐字比较。1 个补充平面大写转换探针超过原生 2 秒期限，记录在 array-reference-limits.json，不计为通过。没有新已知语义差异或未解释差异；原有 regexp 8 个字节码差异、conversion 1 个和 sort 2 个原始字节差异，以及 switch 35 个原生超时继续保留。

完整 verify 的 JS/WasmGC 各 11211 项通过（新增 24 组原生向量和 9 个公共 API 回归）。56 个模块/CLI/Worker 检查、20 个实际浏览器检查及独立示例一致。例：node tools/cli.mjs --file examples/arrays.tcl --eval-json。网页证据来自本轮同一引擎的已保存实测，没有在打包检查中冒充重跑。公共函数/方法签名未改，生成接口新增一个不公开内部字段的 ArrayObject 类型条目。

四组固定五进程活动对比提交版 0.15.0，共 24 项既有负载，每进程 20 次预热、30 次新旧交替测量并保留全部轮次。短字典中位耗时比约 1.227（回退约 22.7%），其他 23 项约为 0.943–1.040；这些单机短热会话结果没有统计显著性、完整应用或峰值内存结论。

| 既有负载 | 耗时 / 0.15.0 | 五进程范围 |
|---|---:|---:|
| dictionary-100 | 1.227 | 1.106–1.384 |
| array-300 | 0.970 | 0.926–1.063 |
| bigint-150 | 1.015 | 0.933–1.062 |
| alias-200 | 0.983 | 0.973–1.118 |
| sort-200 | 0.996 | 0.950–1.084 |
| dictionary-1000 | 1.025 | 0.922–1.066 |
| sort-1000 | 0.979 | 0.960–1.039 |
| format-receipt-100 | 0.986 | 0.931–1.046 |
| scan-record-100 | 0.977 | 0.930–1.046 |
| format-exact-100 | 1.028 | 0.940–1.084 |
| search-exact-500 | 1.036 | 0.868–1.107 |
| search-glob-300 | 0.967 | 0.939–1.127 |
| sort-ascii-200 | 1.033 | 0.943–1.045 |
| search-sorted-500 | 0.976 | 0.953–1.054 |
| search-regexp-100 | 0.966 | 0.888–1.246 |
| array-regexp-100 | 1.007 | 0.964–1.035 |
| sort-dictionary-200 | 1.001 | 0.974–1.016 |
| search-nested-100 | 0.992 | 0.938–1.089 |
| sort-integer-1000 | 0.989 | 0.980–1.020 |
| sort-stride-200 | 0.994 | 0.960–1.017 |
| sort-indices-500 | 0.950 | 0.941–0.997 |
| sort-nested-100 | 0.943 | 0.907–0.967 |
| sort-command-100 | 1.040 | 1.033–1.120 |
| sort-unique-200 | 1.020 | 1.002–1.083 |

六项新数组负载与原生分别计时，结果逐字核对一致，耗时仍约为原生的 2.49–5.89 倍。

| 数组负载 | 耗时 / 原生 Tcl |
|---|---:|
| array-populate-1000 | 3.47 |
| array-cursor-500 | 3.81 |
| array-statistics-500 | 3.55 |
| array-retained-100 | 5.89 |
| array-glob-500 | 3.52 |
| array-mutate-200 | 2.49 |

每个数组最多 10000 个哈希条目（包括别名保留的未定义条目）和 10000 个活动搜索。未提供 trace、统一累计内存配额、完整对象/原始字节表示、字节码、非指数正则、I/O/包/事件或全套上游/跨平台验收。两轮再生与当前源码/证据指纹见 evidence/array-upgrade.json，性能回退仍列入后续工作。

## 0.15.0 分组、索引与比较命令排序（历史版本）

实现 lsort 的 12 个选项及唯一前缀：分组 -stride、原始位置 -indices、嵌套 -index、升降序、内容类型、-command、-nocase 和 -unique。分组中的首个索引选字段，其余索引继续向内选择；去重保留最后一组及其原始位置。按固定合并顺序边读取键边排序，保留比较命令的调用顺序、大小写、所在作用域、重入及对输入变量的修改。

整数键使用固定 Windows 64 位比较；比较命令返回值使用 32 位范围和回绕，包括最小负数取反的原生边界。空列表、单元素和数值转换按原生顺序验证。比较命令的非正常完成保留代码、返回层级和诊断；下一条嵌套索引错误可能覆盖前一个比较失败。集合列表解析补充指定错误消息和错误码，公共 parse_list 的既有接口保持不变。

1951 个独立原生程序中，1949 一致（1813 个成功结果/输出逐字比较、136 个预期拒绝），两个明确的原始 UTF-8 诊断截片差异，零未解释差异、零原生超时。两个差异中，原生诊断保留 emoji 的不完整字节前缀，而当前文本对象只保留完整字符；本地约定断言不算兼容通过。原有 regexp 的八个字节码前缀差异、转换的一项字节差异和 switch 的 35 项原生超时仍保留。

完整 verify 的 JS/WasmGC 各 11178 项通过，新增 49 组原生测试及八个公共 API 回归。48 项模块/CLI/Worker、20 项实际网页检查和独立示例的原生/CLI 对照通过。示例：`node tools/cli.mjs --file examples/sort.tcl --eval-json`。两轮生成与 Git blob 证明见 evidence/sort-upgrade.json；公开 API 签名不变。

三组固定五进程活动比较 0.14.0 的 18 项既有负载，每进程 20 次预热、30 次新旧交替测量，保留全部轮次。短字典耗时回退约 28.1%，短整数排序约 15.9%；其余 16 项中位比值约 0.917–1.049。字典排序约为旧版 0.937 倍，但这不抵消其他负载的回退，性能仍未追平。

| 固定负载 | 耗时 / 0.14.0 | 五进程范围 |
|---|---:|---:|
| dictionary-100 | 1.281 | 1.200–1.376 |
| array-300 | 0.975 | 0.944–1.054 |
| bigint-150 | 0.929 | 0.861–1.184 |
| alias-200 | 0.988 | 0.985–1.105 |
| sort-200 | 1.159 | 1.120–1.262 |
| dictionary-1000 | 0.983 | 0.979–1.060 |
| sort-1000 | 1.044 | 1.002–1.062 |
| format-receipt-100 | 1.027 | 0.976–1.127 |
| scan-record-100 | 1.028 | 1.005–1.081 |
| format-exact-100 | 0.917 | 0.866–1.036 |
| search-exact-500 | 1.049 | 0.903–1.188 |
| search-glob-300 | 1.028 | 0.872–1.092 |
| sort-ascii-200 | 1.015 | 0.975–1.146 |
| search-sorted-500 | 1.038 | 0.924–1.088 |
| search-regexp-100 | 1.002 | 0.982–1.088 |
| array-regexp-100 | 1.018 | 1.010–1.186 |
| sort-dictionary-200 | 0.937 | 0.889–0.974 |
| search-nested-100 | 1.025 | 0.867–1.121 |

六项排序负载另与原生分别计时，仍慢约 3.6–7.9 倍。

| 排序负载 | 耗时 / 原生 Tcl |
|---|---:|
| sort-integer-1000 | 4.41 |
| sort-stride-200 | 4.07 |
| sort-indices-500 | 3.56 |
| sort-nested-100 | 4.69 |
| sort-command-100 | 7.86 |
| sort-unique-200 | 4.71 |

同机短热会话不能证明完整应用、统计显著性、峰值内存或跨平台性能。旧集合负载也已重测，结果保存在 sort-search-workloads.json；线性搜索仍存在较大原生差距。排序逐键和逐次比较消耗执行预算，列表与诊断继续受既有限额约束，没有累计内存配额。

仍缺原始字节/完整对象表示、完整排序诊断和上游边界、array 游标/统计/完整缩写、字节码、非指数正则、I/O/包/事件、累计内存、性能及上游/跨平台验收。20 项完整追平目标继续进行。

## 0.14.0 集合搜索与字典排序（历史版本）

实现 lsearch 的 exact/glob/regexp/sorted 模式和 Tcl 8.6.15 的 18 个选项，包括内容类型、唯一前缀、-start、嵌套 -index、-subindices、-bisect、升降序及结果组合。二分搜索仅转换实际访问的元素；整数内容按固定 Windows 64 位语义比较。array names 支持 -regexp 和模式缩写，缺失/空数组保留延迟正则编译顺序。

新增 lsort -dictionary，按数字段、前导零和大小写次序比较；-unique 在合并时去重，保留原生等价字符的可观察行为。集合 glob 识别完整补充平面字符；ASCII 排序按编码顺序，nocase 保留原生 UTF-16 比较。lsearch 的简单正则快路径保留数值/列表对象，通用正则按需转成文本。

3307 个独立原生程序全部一致（3235 个成功结果和标准输出逐字比较，72 个预期拒绝；指定诊断通过 catch 程序逐字比较），无已知差异、未解释差异或原生超时。新增 83 组后端原生测试和七个公共 API 回归；完整 verify 的 JS/WasmGC 各 11121 项通过，44 个模块/CLI/Worker 检查通过。原有八个 regexp 字节码前缀差异、一个转换字节差异及 switch 的 35 个原生超时仍保留，不能计为原生一致。公开 API 签名不变。

示例：`node tools/cli.mjs --file examples/search.tcl --eval-json`。实际网页、两轮重新生成及源码/证据 Git blob 核验记录在 evidence/search-upgrade.json。当前网页保留原有文本提取示例；集合搜索示例另存为独立脚本。

三组固定五进程活动对比 0.13.0，每进程 20 次预热、30 次新旧交替测量，保留全部轮次。短字典中位耗时回退约 16.5%，线性 exact/glob 搜索约 12.8%/13.4%；其余十项约为旧版 0.958–1.045 倍。新增能力不代表性能追平。

| 固定负载 | 耗时 / 0.13.0 | 五进程范围 |
|---|---:|---:|
| dictionary-100 | 1.165 | 1.099–1.244 |
| array-300 | 0.965 | 0.904–1.111 |
| bigint-150 | 0.958 | 0.892–1.053 |
| alias-200 | 1.045 | 0.993–1.067 |
| sort-200 | 1.001 | 0.968–1.049 |
| dictionary-1000 | 0.976 | 0.891–1.007 |
| sort-1000 | 0.977 | 0.926–1.008 |
| format-receipt-100 | 0.988 | 0.925–1.017 |
| scan-record-100 | 0.995 | 0.958–1.089 |
| format-exact-100 | 1.006 | 0.940–1.042 |
| search-exact-500 | 1.128 | 0.967–1.192 |
| search-glob-300 | 1.134 | 0.988–1.297 |
| sort-ascii-200 | 1.042 | 0.916–1.058 |

八项集合负载另与原生分别计时；包含三项既有能力。最慢两项为线性 exact/glob 搜索，仍慢约 79/74 倍。

| 集合负载 | 耗时 / 原生 Tcl |
|---|---:|
| search-exact-500 | 78.88 |
| search-glob-300 | 74.18 |
| sort-ascii-200 | 5.87 |
| search-sorted-500 | 4.84 |
| search-regexp-100 | 23.12 |
| array-regexp-100 | 5.42 |
| sort-dictionary-200 | 3.80 |
| search-nested-100 | 19.26 |

这些是同机短热会话；原生与 Node 适配器不同，没有显著性、完整应用、峰值内存或跨平台结论。正则快路径继承 glob 工作量限制；通用路径仍可能枚举大量候选，现有预算不是全局内存配额。

仍缺 lsort 的完整嵌套索引、stride/indices 与诊断选项、array 搜索游标/统计/完整缩写、完整对象/原始字节、编译/诊断、I/O/包/事件、非指数正则算法、上游全量与跨平台验收。20 项完整追平目标继续进行。

## 0.13.0 regexp 与 regsub（历史版本）

新增独立 regexp / regsub 命令，支持捕获变量、-all、-inline、-indices、-start、大小写/行/展开模式以及替换中的 & 和反向引用。保留末次匹配的变量、未匹配时的旧值、变量写入顺序、空匹配的前进规则、UTF-16 索引和数值对象表示转换。regsub 的纯字面量全局替换遵循固定 Tcl 8.6.15 的独立快路径，包括空模式不在末尾追加替换、-expanded 仍保留字面空格的行为。

regexp -about 返回捕获数量和编译属性。解析器记录实际语法标记；有限关系分析检查字符类别、锚点、交替/重复、捕获和反向引用的正则近似。前瞻按编译属性中的不透明断言处理。分析共享量词节点，并用字符区间代替逐码点扫描；它不是对任意正则可满足性的完整证明。

6299 个独立原生程序中，6291 一致（6287 个成功结果/输出逐字比较、4 个预期拒绝），8 个明确差异，0 未解释差异。八项都属于同一缺口：Tcl 编译器在特定静态调用中接受 -nocase 的前缀，而普通运行时命令拒绝缩写；当前解释器保留严格运行时规则，没有复刻该字节码优化。原有转换矩阵另保留一项原始 UTF-8 截片差异。新矩阵无原生超时；原有 switch 的 35 项超时仍单独排除，不能计为通过。

完整 verify 通过，JS/WasmGC 各 11031 项，包括新增 158 组原生案例和 8 个公共 API 回归；其中八个前缀差异断言及原有字节差异断言只验证本地约定，不算原生一致。48 个模块/CLI/Worker 检查通过。实际网页、两轮生成与 Git blob 证明记录在 evidence/regexp-upgrade.json，公开 API 签名不变。示例：node tools/cli.mjs --file examples/regexp.tcl --eval-json。

资源限制继续包含编译正则模式 4096 UTF-16 单元、64 捕获/解析层、128 执行层、每个候选状态数组 16384 项；内联列表最多 100000 项，替换输出最多 1000000 单元。纯字面量快路径不编译正则，受已有字符串上限和执行预算约束。元数据分析和字面量扫描也消耗执行预算。另有四个独立原生边界检查验证最大有符号 -start 下标：先判断终止，再前进一步，避免整数溢出。失败保留已有变量副作用，下一次调用可恢复；这些限额不等于全局内存治理。

两组固定五进程活动比较十项既有负载，每进程 20 次预热、30 次新旧交替测量，保留所有轮次。短字典较 0.12.0 中位耗时高约 24.0%，其余九项约为旧版 0.969–1.031 倍。六项新负载与原生分别计时，前五项慢约 1.5–4.6 倍，-about 仍慢约 24.7 倍。没有显著性、完整应用、峰值内存或跨平台结论，性能仍未追平。

| 固定负载 | 耗时 / 0.12.0 | 五进程范围 |
|---|---:|---:|
| dictionary-100 | 1.240 | 1.027–1.448 |
| array-300 | 1.007 | 0.927–1.101 |
| bigint-150 | 0.981 | 0.902–1.055 |
| alias-200 | 0.969 | 0.904–1.056 |
| sort-200 | 0.988 | 0.943–1.010 |
| dictionary-1000 | 1.018 | 0.943–1.067 |
| sort-1000 | 0.985 | 0.976–1.014 |
| format-receipt-100 | 1.002 | 0.986–1.046 |
| scan-record-100 | 1.016 | 0.950–1.068 |
| format-exact-100 | 1.031 | 0.990–1.072 |

| 新负载 | 耗时 / 原生 Tcl |
|---|---:|
| regexp-capture-50 | 3.85 |
| regexp-all-50 | 1.94 |
| regexp-start-50 | 4.59 |
| regsub-literal-200 | 4.62 |
| regsub-capture-50 | 1.55 |
| regexp-about-20 | 24.73 |

按区间计算前的四个测量文件保留在 evidence/regexp-before-interval-*.json，具有单独引擎指纹；其中 -about 负载曾慢约 4332 倍。它们不是最终构建数据。修复最大起点前的另一组完整测量保留在 evidence/before-start-regexp-*.json；其引擎指纹与最终构建不同。

尚缺 array/lsearch 正则选项、完整语法/编译/诊断、避免候选路径爆炸的匹配算法、原始字节/完整对象、I/O/包/事件、整体内存和上游/跨平台验收。20 项完整追平目标继续进行。

## 0.12.0 switch 与分支正则（历史版本）

实现 switch 的精确、glob 和 regexp 匹配，支持 -nocase、唯一选项缩写、--、列表或展开的分支参数、末尾 default 和 - 贯穿。匹配按分支顺序进行，跳过的正则不编译；分支体在调用者作用域执行，保留 return/break/continue、自定义完成码、数值对象和错误前副作用。-indexvar 先于 -matchvar 写入；不匹配时保留已有变量，进入 default 时写入空列表。

新增原生 MoonBit 正则解析和有界匹配器，JS/WasmGC 共用实现。覆盖字符/Unicode 类别、命名字符、分组与交替、贪婪/非贪婪重复、前瞻、反向引用、行/词边界、嵌入选项、ARE/ERE/BRE 和字面量模式。按最早起点与最长/最短偏好选择结果；重复只保留最后一轮参与的捕获。UTF-16 索引、空匹配和模式对象表示转换遵循固定 Tcl 8.6.15 对照。

5863 个独立原生探针中，5828 个可完成案例全部一致：5650 个成功案例逐字比较返回值/输出，178 个直接错误案例比较拒绝；部分诊断码另通过 catch 程序逐字比较。35 个原生超时探针单独记录，不计为通过或兼容。它们涉及可空重复组的反向引用；参考工作进程逐项限时 2 秒并在超时后重启。

完整 verify 通过，JS/WasmGC 各 10865 项；新增七个公共 API 回归和 34 项模块/CLI/Worker 检查，实际网页 13 项与 examples/switch.tcl 的 CLI/原生对照通过。5828 个案例分组为 146 个后端测试，每个独立案例仍执行断言并保留名称，避免编译器生成测试驱动的文本段行数上限。原有转换矩阵维持 4969 一致、1 项已知原始 UTF-8 截片差异。

量词前缀共享原有语法节点，避免编译深层重复时复制整棵子树；新增 48 层量词的有界失败和会话恢复回归。正则模式限 4096 UTF-16 单元、64 个捕获、64 层解析、128 层执行和单个状态数组 16384 项，并消耗现有执行预算。当前算法会枚举候选路径，复杂重复的运行时间和内存仍是缺口；这些限制不等同于原生完整正则能力。独立 regexp/regsub 命令、array/lsearch 的 regexp 选项、完整诊断与上游全量正则验收仍未实现。

两组固定五进程活动比较十项既有负载，每进程 20 次预热、30 次新旧交替测量，保留全部轮次。短字典负载中位耗时回退约 20.5%；其余九组为旧版约 0.96–1.07 倍。完整性能仍未追平，也没有显著性或跨平台结论。

| 固定负载 | 耗时 / 0.11.1 | 五进程比值范围 |
|---|---:|---:|
| dictionary-100 | 1.205 | 1.086–1.298 |
| array-300 | 1.028 | 0.894–1.087 |
| bigint-150 | 0.981 | 0.885–1.027 |
| alias-200 | 0.997 | 0.956–1.036 |
| sort-200 | 1.001 | 0.910–1.011 |
| dictionary-1000 | 0.989 | 0.938–1.030 |
| sort-1000 | 0.968 | 0.947–1.009 |
| format-receipt-100 | 1.071 | 0.962–1.095 |
| scan-record-100 | 0.964 | 0.912–1.042 |
| format-exact-100 | 0.992 | 0.988–1.022 |

五项新增 switch 短负载分别测量原生 Tcl 和 Node，每项 10 次预热、30 次测量；当前仍慢约 1.7–15.9 倍。新旧版本计时和这组原生计时口径不同，不应混合成整体性能结论。

| switch 负载 | 耗时 / 原生 Tcl |
|---|---:|
| switch-exact-200 | 10.17 |
| switch-glob-200 | 10.16 |
| switch-regexp-capture-50 | 3.73 |
| switch-regexp-backref-50 | 1.68 |
| switch-regexp-nested-50 | 15.94 |

共享节点改造前的两组五进程计时与新负载测量保留在 evidence/switch-before-sharing-*.json，标注各自引擎指纹；它们不是最终构建的测量。

当前证据清单为 evidence/switch-upgrade.json；对照与超时记录为 switch-comparison.json 和 switch-reference-limits.json，两轮重新生成报告为 generation-switch.json。完整语言/生态、正则算法性能、对象/内存、I/O 和上游/跨平台应用验收仍有缺口；20 项完整追平继续进行。

## 0.11.1 命令分派性能（历史测量）

去掉命令分派和控制流中重复的参数文本数组，过程调用只在需要错误上下文时建立文本参数。原生命令名称已规范时直接使用参数；限定名或重命名仍复制后调整，保留调用者的列表脚本。逐条执行缓存脚本时直接调用单命令执行器，避免临时单元素数组，并按需创建空结果值。公开 API、数值对象身份、集合写入隔离及现有执行限额保持原有约定。

四组固定计时活动分别用五个独立 Node 进程，每进程 20 次预热、30 次新旧交替测量；所有轮次保留。下表为各进程中位耗时比的中位数，越小越快。与 0.11.0 比较，十组负载下降约 3%–15%；数组和小票在个别轮次仍有回退。与改造前 0.10.1 直接比较，数组/扫描/高精度仍高约 2.5%/2.4%/1.1%。未做显著性检验，这些本机短负载不代表完整应用或跨平台性能。

| 固定负载 | 耗时 / 0.11.0 | 耗时 / 0.10.1 | 耗时 / 原生 Tcl |
|---|---:|---:|---:|
| dictionary-100 | 0.912 | 0.833 | 5.82 |
| array-300 | 0.953 | 1.025 | 6.20 |
| bigint-150 | 0.888 | 0.646 | 5.56 |
| alias-200 | 0.874 | 0.957 | 6.57 |
| sort-200 | 0.883 | 0.883 | 4.89 |
| dictionary-1000 | 0.906 | 0.869 | 4.10 |
| sort-1000 | 0.896 | 0.873 | 2.46 |
| format-receipt-100 | 0.968 | 0.893 | 7.60 |
| scan-record-100 | 0.906 | 1.024 | 6.85 |
| format-exact-100 | 0.851 | 1.011 | 8.83 |

完整 verify 通过，JS/WasmGC 各 10712 项；855 值传递对照全部一致，4970 转换程序维持 4969 一致、1 项已知原始 UTF-8 截片差异、0 未解释差异。其余原生矩阵、模块/CLI/Worker/HTTP、资源和异常输入检查通过。实际网页 11 项检查和 values.tcl 的 CLI/原生对照通过；没有为本次纯性能重构增加重复实现的单元测试。

当前证据清单为 evidence/dispatch-upgrade.json。五轮计时见 evidence/dispatch-{general,conversion}-performance.json；与 0.10.1 的直接对照见 evidence/dispatch-prevalue-{general,conversion}-performance.json。CPU 采样保留在 evidence/value-runtime-profile-{baseline,current}.json，仅用于定位热点，不是分配计数或无开销计时。当前与原生仍有约 2.5–8.8 倍耗时差距，20 项完整追平继续进行。

## 0.11.0 内部值与数值身份（历史版本）

变量、命令参数/返回、表达式、列表和字典元素现在传递内部值，保留数值与显示文本各自的含义。修复 scan 得到精确浮点数后，经过 set、过程、集合或异常传递再 format 时重新解析短文本而丢失精度的问题。相同显示文本的两个独立对象不会共享数值；负零、大整数和中间算术结果也保留内部数值。

支持数组、默认/可变参数、别名、列表脚本 eval/catch/循环、命名空间和 ensemble 前缀、return 自定义选项及 try 的 -during。列表/字典修改创建独立容器，复制后修改不会改变原集合。与原生对照一致，指定字符串操作会转换共享对象的内部表示；单纯读取显示文本不会自动丢弃数值。新增 string cat。公开函数签名和 eval/eval_catch 的字符串结果接口不变；生成接口增加两个不透明内部类型名。

855/855 个新增原生 Tcl 8.6.15 程序一致，另有六个公共 API 回归。JS/WasmGC 各 10712 项、30 项新增宿主及既有 HTTP/资源/异常输入检查通过。原有 4970 项转换矩阵现为 4969 一致、1 项已知原始 UTF-8 截片差异、0 未解释差异；已移除修复后的数值对象差异标记。10712 项中仍有一项只验证该字节差异的本地约定，不算原生一致。

五个独立 Node 进程各做 20 次预热/30 次新旧交替测量，全部轮次保留：七组通用负载耗时为 0.10.1 的 0.704–1.128 倍；大整数约快 30%，数组/别名约慢 11%/13%。小票格式化、扫描和 80 位精度格式化分别为旧版约 0.904、1.160、1.197 倍。当前七组通用负载仍慢于原生约 3.8–7.7 倍，三组转换约 7.8–10.4 倍。这是本机短负载，没有显著性检验，不能称为性能全面改善。

源码/证据指纹见 evidence/value-upgrade.json；原生对照见 evidence/value-comparison.json，五轮计时见 evidence/value-general-performance.json 和 evidence/value-conversion-performance.json。实际网页 10 项检查、examples/values.tcl 的 CLI/原生对照通过。仍缺完整原始字节/全部对象表示与上游边界、累计内存治理、完整语言/生态和跨平台应用验收；20 项完整追平目标继续进行。

## 0.10.1 数字解析性能（历史测量）

数字转换现在先做保守的整数候选识别，避免把每个浮点数交给大整数解析器后再抛出异常；完整整数语法、进制、5000 字符/16384 位限额仍由原有解析路径验证。十六进制 e/E 继续作为整数数字处理。已清理重复的首尾空白处理，精确十进制舍入与公开 API 保持不变。

V8 采样显示，0.10.0 两组格式化负载中大整数解析占约 83%–87% 的采样时间。五轮独立 Node 进程、每轮 20 次预热/30 次新旧交替测量全部保留：小票格式化和 80 位小数格式化耗时约为旧版 9.96% 和 9.90%，约快 10 倍；记录扫描约为旧版 99.82%。七组既有负载的中位耗时比为 0.984–1.045，大整数组约慢 4.5%，五轮比值范围为 0.987–1.080。没有做显著性检验，不能称为全部负载均无回退。

三组转换负载仍约比系统 Tcl 慢 7.4、6.2、6.8 倍；七组通用负载仍慢约 3.2–7.0 倍。JS/WasmGC 各 9851 项、既有全部宿主/HTTP/资源检查通过，转换对照仍为 4968 一致、2 明确差异、0 未解释差异。两个已知差异的本地约定测试包含在 9851 项内，不算原生一致。真实网页八项数值/精度/异常恢复/重置检查和示例 CLI 对照通过。

当前指纹见 evidence/number-dispatch-upgrade.json，完整五轮计时见 evidence/number-dispatch-conversion-performance.json 和 evidence/number-dispatch-general-performance.json。两项对象/原始字节差异与完整生态、性能、内存及跨平台验收仍未追平。

## 0.10.0 format 与 scan（历史测量）

format 支持整数、浮点、字符与字符串转换、位置参数、动态宽度/精度、符号/进制前缀/填充。整数采用固定 Windows Tcl 8.6.15 的 32 位默认值、h 16 位、l 64 位和 ll 大整数配置；浮点由 binary64 精确分数计算十进制舍入，包括 ties-to-even、负零、次正规数和高精度输出。

scan 支持整数/浮点、字符/字符串、字符集合、%n 字节偏移、宽度、跳过赋值与位置参数。先验证完整格式，再扫描，最后按变量槽位顺序写入；保留匹配失败和写变量失败的已有副作用。format 的整数截断与 scan 的溢出钳制按原生分别实现。宽度/精度和单次格式化输出最多 1000000 UTF-16 单元，扫描最多 100000 个结果槽；大整数仍受 16384 位/5000 字符上限约束。

4970 个新增原生程序中 4968 个一致、2 个明确差异，未解释差异为 0。程序包括所有 2098 个有限 binary64 正二次幂、300 个负二次幂、500 个随机有限浮点值的短文本批次，以及精度/标志/溢出/扫描状态矩阵。新增七个公共 API 回归；后端测试中两个标为 Known difference 的用例只验证本地约定，不算原生一致。

两项差异保留在 conversion-reference.json 和 conversion-comparison.json：四字节 emoji 的 %1s 在原生参考中截出无效 UTF-8，而本实现保留 UTF-16 单元；原生浮点对象保留内部精度，本实现的普通标量仍存字符串，少数二次幂在显示后再次转换会损失精度。两项都尚未追平，也不构成全量 format/scan 兼容证明。错误用例仅比较拒绝，不比较完整错误正文。有效 CESU-8 代理三字节序列仅在 Python 参考传输层还原，任意无效 UTF-8 不归一化。

完整验证：JS/WasmGC 各 9851 项检查通过（含两个已知差异的本地约定），36 项新增宿主、14 项真实网页及原有检查通过。七组既有负载耗时为 0.9.0 的约 0.96–1.07 倍，仍比系统 Tcl 慢约 3.9–7.2 倍。三组新负载为小票格式化、记录扫描和 80 位小数格式化，分别约慢 87、8、108 倍；精确格式化性能仍是明确缺口。

示例见 examples/conversion.tcl，复现与验收范围见 TESTING.md。当前源码/证据指纹改由 evidence/conversion-upgrade.json 记录；旧版本记录继续保留为历史证据。

## 0.9.0 Unicode 与字符串边界（历史测量）

基于固定的 Unicode 16.0.0 数据补齐 13 类字符判定与 BMP 简单大小写映射。string is 支持 -strict、-failindex 与唯一缩写；字符类别失败位置按码位计数，列表失败位置按 UTF-16 偏移计数，数字溢出记为 -1。成功判定不修改失败变量。补齐数字前缀、整数正负范围、Inf/NaN 形式；entier 仍受既有 16384 位/5000 字符限额约束。

index/range/replace/map/限定长度比较及 glob 使用 UTF-16 单元，允许拆分并重新合并代理对；reverse 保留完整代理对，trim 按完整字符匹配。大小写不做多字符展开（例如 ß 不变为 SS），转换保留 Tcl 8.6 的 UTF-8 字节数不增长规则和 Georgian title 特例；忽略大小写比较使用完整简单映射。修复 lsearch -exact -nocase 的编码长度前置条件和 Unicode 反斜杠转义边界。

**名称语法澄清：** Tcl 8.6 的 $name 本来只接受 ASCII 字母/数字/下划线及命名空间分隔符；Unicode 名称使用 ${名称}，数组索引可以含 Unicode。现有解析器的这部分无需放宽；此前追平记录将它误列为缺口，本轮已有原生回归证明。

1866 个新增原生 Tcl 8.6.15 程序包括 107 批分类边界、75 批全部简单映射、840 个类别矩阵、284 个数字失败位置，以及选项、trim、glob 和代理单元回归。另有 5 个公共 API 回归。JS/WasmGC 各 4875 项、30 项新增宿主和原有检查全部通过；真实网页 13 项检查及新示例 CLI 对照通过。独立数据审计覆盖全部 65536 BMP 码位的 13 类属性和 3 种转换，共 1048576 项属性/转换检查，不替代编译后端测试。

固定 Windows Tcl 8.6.15 参考会在三个补充平面大小写案例中崩溃，另两个 trim 案例返回截断 UTF-8。它们记录于 evidence/unicode-reference-limits.json，未计入 1866 个通过案例。本实现对补充平面大小写保证 UTF-16 保留和有界处理；这是本地 API 保证，不是原生逐字一致的证明。原始 Tcl 字节表示、这些参考边界、完整 string 子命令和完整 Unicode/解析行为仍未追平。

七组既有同进程交替计时中新版耗时为 0.8.0 的约 0.95–1.03 倍，仍比系统 Tcl 慢约 3.8–8.4 倍，仅代表本机小负载。示例见 examples/unicode.tcl；当前源码/证据指纹见 evidence/unicode-upgrade.json，性能见 evidence/unicode-performance.json。

## 0.8.0 脚本替换与完整性判断（历史测量）

subst 支持 -nobackslashes/-nocommands/-novariables 及唯一缩写，并保留嵌套变量索引/命令内部需要的替换。break 返回此前已替换文本，continue 丢弃整个命令或变量替换，return/自定义完成码使用其结果作为替换值。普通错误继续传播；未完成语法前已执行的替换保留副作用。变量 token 先完整解析，命令替换逐条解析执行；这两类顺序不同，不能共享一个简单的整串预解析路径。

新增 info complete 和公开 is_complete(source) API，判断引号、花括号、方括号、数组索引及换行续接是否完整，不执行脚本。完整但非法的语法可返回真；这不是脚本有效性或安全性检查。修复分组词后反斜杠换行，以及注释中连续反斜杠的奇偶规则。输入与输出上限为 1000000 UTF-16 单元，仍遵守解析深度/命令参数等现有限额。

1019 个新增系统 Tcl 8.6.15 对照覆盖所有 8 种替换开关组合、异常与跨种类替换、语法错误前副作用、400 个确定性生成的完整性输入和具体解析回归；错误正文在替换矩阵中归一化，未声称完整诊断兼容。另有 6 个公开 API 回归验证缓存后的副作用、无执行完整性检查、预算/输出/深度限额与多行片段。示例见 examples/substitution.tcl；当前源码与验证指纹见 evidence/syntax-upgrade.json。

完整本地验证：JS/WasmGC 各 3004 项通过，24 项新增宿主检查及原有宿主/HTTP/资源/异常输入检查通过。七组同进程交替计时中新版耗时为 0.7.0 的约 0.98–1.02 倍，仍比系统 Tcl 慢约 3.6–7.0 倍；不代表全量应用性能追平（evidence/syntax-performance.json）。

## 0.7.0 异常与清理语义（历史测量）

实现 catch 的结果/选项变量、return 的 -code/-level/-options 和自定义选项、error 的显式诊断、throw，以及 try 的 on/trap/finally。返回层级在过程边界逐层消耗；循环识别 break/continue；清理块在正常、异常和返回路径执行，清理失败通过 -during 保留原异常选项。trap 按错误类型列表前缀匹配，支持处理器贯穿。修复 string compare、lsort 和表达式非数值比较的 UTF-16 字典序。

公开 API 新增 eval_catch(source, budget?)，返回 Evaluation { code, result, options }，相当于直接 catch 脚本，不消耗顶层 return 层级；eval 保留原有字符串/错误接口并消耗一层。无效预算仍抛出 API 错误。选项是 Tcl 字典文本，可用 parse_list 读取。新增 Signal(Completion) 错误变体供内部传播，已有 eval 调用仍将脚本错误转为 Invalid；对 TclError 做穷尽匹配的调用方需要兼容新增变体。

新增 321 个系统 Tcl 8.6.15 对照程序及 7 个公开 API 回归。矩阵验证返回层级、错误类型、自定义选项、循环、处理器及清理副作用；生成诊断在矩阵中被剔除，错误正文被归一化，另有明确的诊断/位置/常见错误正文逐字检查。自动错误堆栈采用命令与过程帧表示，不是 Tcl 字节码堆栈的完整复刻；写变量等许多错误码仍未覆盖。示例见 examples/completions.tcl，当前验证、性能和指纹见 evidence/completion-upgrade.json。

完整本地验证：JS/WasmGC 各 1979 项通过，34 项新增宿主、20 项命名空间宿主、29 项会话、11 项 HTTP、17 项资源与 307 个异常输入检查通过。七组同进程交替测量中新版耗时为 0.6.0 的约 0.98–1.06 倍，仍比系统 Tcl 慢约 4.1–6.7 倍；仅代表本机小负载（evidence/completion-performance.json）。

## 0.6.0 命名空间与库命令（历史测量）

新增 namespace export/import/forget/origin/path/upvar/unknown，以及 ensemble create/configure/exists。命令表统一管理内置命令、过程、导入和 ensemble：重命名保留导入引用，重定义更新已有导入，删除连带清理多级导入；强制导入检测环。搜索路径按当前命名空间、路径、全局顺序查询，路径目标删除后不会因同名重建而自动恢复。

Ensemble 支持动态导出列表、显式 subcommands、map 命令前缀、唯一缩写、parameters、unknown 回退和运行时配置；转发参数不重新进行脚本替换，也不增加过程调用帧。inscope 的附加参数按列表元素传递。提供 auto_import 回调接入点，但尚未提供 Tcl 自带自动加载库或包/文件加载机制。

独立系统 Tcl 8.6.15 的 312 个新增程序包括 96 条各 12 步状态变更轨迹；另有五个公开 API 回归，验证跨调用缓存、导入环、递归限额、命令数上限和配置失败后的恢复。示例见 examples/namespaces.tcl。完整结果和源码指纹见 evidence/namespace-upgrade.json。 JS/WasmGC 各 1651 项、20 项新宿主检查通过。七组与 0.5.0 交替测量的热会话耗时约为旧版的 0.70–1.04 倍；当前仍比系统 Tcl 慢约 2.9–7.4 倍，仅代表本机小负载（evidence/namespace-performance.json）。

## 0.5.0 性能与语义改进（历史测量）

脚本和表达式解析结果现在按会话缓存。脚本逐条解析，缓存保留解析错误发生的位置；运行时仍重新读取变量和查找命令，因此重定义、重命名、递归和命名空间切换不复用过期值。两类缓存各最多 256 项，总源文本额度 393216 UTF-16 单元，超过额度即淘汰；缓存命中不减少执行预算。

常用十进制整数走精确快速路径，其余形式仍使用完整整数解析。标量变量中的列表和字典保留解析结果与延迟文本表示，在 for/foreach/while 等忽略结果的循环里，修改集合不再每次重建整串文本。别名仍共享变量，普通赋值仍复制值；数组元素和嵌套集合保留通用路径。

七组同机、交替执行的旧版/新版热会话测量显示约 4.3–89.0 倍提速；与系统 Tcl 相比仍慢约 4.0–6.9 倍。1000 项字典更新约从 274.1ms 降至 3.08ms，1000 项列表构造/排序约从 100.7ms 降至 2.04ms。这是固定小负载证据，不代表全量应用性能追平。详见 evidence/performance-comparison.json。

公开 API 新增 cache_stats() 和 clear_cache()。清空解析缓存不会删除变量、过程或输出；命中计数是累计值。缓存源文本额度不等于整个会话的内存配额。

## 当前可用能力

- 延迟求值的表达式树：&&、||、?: 短路，整数/浮点运算、位运算、幂、比较、eq/ne、in/ni 和常用数学函数。整数最大 16384 位；整数与浮点比较保留大整数精度；浮点转整数直接还原 IEEE 754 数值。
- proc 默认/可变参数、递归、命名空间内过程解析、namespace eval/inscope/code、global/variable/upvar/uplevel；数组及元素别名、删除后重建。
- array 全部 11 个子命令及缩写、持久搜索游标、真实哈希统计、数组对象/元素别名生命周期；dict 构造、嵌套路径、修改、迭代、过滤、update/with 写回。
- 常用 string 查询/转换/匹配/映射，以及 lset/linsert/lreplace/lsearch/lsort/lmap；if/then/elseif/else、for/foreach/while 和结构化异常控制。
- 持久会话工作台：连续运行保留变量和过程，返回值与标准输出分栏；支持脚本导入/下载、清空会话、取消和 5 秒超时。普通脚本错误保留此前修改，取消/超时会清空整个会话。

## 使用

```powershell
./start-review.ps1
node tools/cli.mjs --file sample.txt --eval-json
node tools/cli.mjs --input 'expr {2**80}' --eval-json
./verify.ps1 -MoonPath C:/path/to/moon/bin/moon.exe
```

不指定输入源时从 UTF-8 stdin 读取。原有 --json 与文本模式保持兼容；--eval-json 分开返回 result、output、error。--session 从 stdin 逐行读取 JSON，在同一个解释器中执行：

```json
{"source":"set x 4"}
{"source":"incr x"}
{"reset":true}
{"source":"info exists x"}
```

每行输出一条 JSON。脚本失败后继续处理后续请求，进程最终退出码为 2；输入协议或宿主错误为 1，全部成功为 0。网页状态只存于 Worker 内存，不保存至磁盘。命令行 --file 是读取脚本文本，尚不提供 Tcl source/open 等文件命令。

## 独立证据

保留 248 项列表/过程/控制和 726 项语义场景，另有 340 项缓存/集合/小整数原始程序及 312 项命名空间程序，由本机 Tcl 8.6.15 计算预期值。成功场景逐字比较返回值与 stdout，预期失败场景比较是否拒绝，不宣称错误消息兼容。预期值同时生成 MoonBit 公共 API 测试，在 JS 与 WasmGC 上运行。

```powershell
python tools/generate_list_oracle.py
python tools/generate-semantic-oracle.py
python tools/generate-semantic-oracle.py cache
python tools/generate-semantic-oracle.py namespace
python tools/generate-semantic-oracle.py completion
python tools/generate-semantic-oracle.py syntax
python tools/generate-unicode.py
python tools/generate-semantic-oracle.py unicode
python tools/generate-semantic-oracle.py conversion
python tools/audit-unicode.py
moon fmt
./verify.ps1
```

> 历史开发记录（以下发布/归档状态不代表当前仓库；当前入口见文首）：语义 oracle 再生严格要求 Python tkinter 链接 Tcl 8.6.15。仓库保存预期值，普通 verify 不依赖 tkinter；其它 Tcl 补丁版本不会静默覆盖本轮语义基准。CI 使用已提交预期值，远端 CI 未运行。

## 边界

仍缺运行中命名空间删除的完整延迟销毁语义、全局命名空间删除、Tcl 自带自动加载库、包/扩展、trace、source/open/file/exec/socket、事件循环、全量错误码/诊断堆栈与全部解析边界。regexp/regsub、switch、format/scan 和 BMP Unicode 类别已实现上述范围，仍有明确原始字节/字节码差异、补充平面参考限制和非指数算法缺口。已有对象值传递与解析缓存，尚缺完整 Tcl 对象系统、字节码、累计内存与成熟性能证明；有限场景通过不等于完整 Tcl 兼容。

脚本最多 100000 UTF-16 单元；解析/执行嵌套 64 层；命令及替换共享预算，API 最大 1000000，网页/新会话接口使用 100000。字符串、变量值、列表结果及单次输出限 1000000 单元；整数 16384 位；命令表最多 10000 项（含内置命令）；数组 10000 哈希条目及 10000 活动游标；glob 动态规划最多 1000000 单元。网页 Worker 另有 5 秒终止机制。持久会话的累计内存尚无统一配额，因此不适合作为不可信多租户沙箱。

> 历史开发记录（以下发布/归档状态不代表当前仓库；当前入口见文首）：根据 [Tcl subst](https://www.tcl-lang.org/man/tcl8.6/TclCmd/subst.htm)、[info](https://www.tcl-lang.org/man/tcl8.6/TclCmd/info.htm)、[return](https://www.tcl-lang.org/man/tcl8.6/TclCmd/return.htm)、[try](https://www.tcl-lang.org/man/tcl8.6/TclCmd/try.htm)、[catch](https://www.tcl-lang.org/man/tcl8.6/TclCmd/catch.htm)、[expr](https://www.tcl-lang.org/man/tcl8.6/TclCmd/expr.htm)、[namespace](https://www.tcl-lang.org/man/tcl8.6/TclCmd/namespace.htm)、[dict](https://www.tcl-lang.org/man/tcl8.6/TclCmd/dict.htm) 文档和系统解释器行为原创实现，没有复制 Tcl 上游实现代码；原创实现采用 MIT 许可。Unicode 属性/映射来自官方 UnicodeData 16.0.0，按 vendor/ucd-16.0.0/LICENSE.txt 的 Unicode 许可分发；原始来源与 SHA256 见同目录 SOURCE.json，生成器为 tools/generate-unicode.py。详见 FEATURES.md、TESTING.md 与 evidence/unicode-upgrade.json。独立 Git 仓库，无 remote，未上传、发布或提交比赛。
