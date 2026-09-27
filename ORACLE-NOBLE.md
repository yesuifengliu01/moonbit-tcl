# Ubuntu24.04上的列表oracle复核

本次已复现团队报告的NUL传输问题。隔离Ubuntu24.04.5、Python3.12.3和系统Tcl8.6.14中，将 `NUL, a"b, a#b, a\, 空串` 依次经tkinter.setvar送入Tcl，再eval list，返回空字符串；splitlist结果是空数组，未保留原5个元素。实际环境、原始输入/输出在 [environment.json](evidence/noble-20260927/environment.json)。这证明该特定Python/Tcl路径的行为差异，不表示Tcl语言本身不允许NUL，也没有证明BEL同样损坏。

现有修复版生成器的随机传输池已排除NUL/BEL，并在写文件前逐条执行splitlist往返核对。本次在同一Ubuntu24.04环境生成全部248条夹具，原始文件SHA-256为 `ac3889827ad77cd5d202fb560fbbbaa2bb4c5a6ae80b72267922519f26fe4d04`，与先前Windows Tcl8.6.15/Ubuntu26.04 Tcl8.6.17记录一致。再由固定MoonBit工具格式化，SHA-256为 `168199356ce8c859db955b32f91735f62540c782b00098370436be548770c113`，与当前提交的list_oracle_test.mbt逐字节一致。

生成器、MoonBit运行时及现有NUL/BEL直接测试没有修改；没有无必要重跑全部历史解释器套件。修正了TESTING里手工抄写的63位hash，机器回执原本的64位hash正确。

## 复现要点

使用Ubuntu24.04及发行版python3-tk，在临时源目录执行：

```sh
python3 tools/probe-list-transport.py
python3 tools/generate_list_oracle.py
moon fmt
git diff --exit-code -- list_oracle_test.mbt
```

probe专用于Linux发行版环境信息，会报告/etc/os-release和dpkg包版本；运行库不依赖它。生成步骤会写夹具，应在干净临时checkout执行。此版本系统Tcl的原始NUL探针应返回roundTrip=false，而修复后的生成器应生成248条并保留已提交夹具。

实际采用官方Docker Hub Ubuntu24.04 linux/amd64 manifest `sha256:496754492fb28b4d3049432f2ca787449331e23fb14f0dd3fffea86bf5a93eb4`。Docker直接拉取超时后，通过官方registry API取得相同manifest、校验配置/压缩层/解压层后导入本地Docker；运行文件系统层hash再次核对一致。镜像来源见 [IMAGE-SOURCE](evidence/noble-20260927/IMAGE-SOURCE.json)，系统包版本和apt日志随回执保留。初次后处理误把Docker导入后的image ID与OCI config digest相比，已改为验证实际RootFS层hash；无需重跑已经成功完成的生成器。

**边界：这不是GitHub托管runner实跑。** 本次在WSL2内的隔离Ubuntu24.04用户态运行Python/Tcl，最终格式化使用已固定的Windows MoonBit；可证明这些生成字节与提交版一致，不能据此把公开CI标为成功。
