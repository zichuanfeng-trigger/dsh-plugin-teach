# DSH 插件开发 · 教学课件

从架构学起的 DeepSeek Harness 插件开发课程。每一课都是一个自包含的 HTML 页面，配一个可亲手验证的动作，读完能在命令行或界面上看见结果。

课程的目标不是"了解 DSH"，而是让一个真实的插件项目能够开工。

## 从哪开始

打开 `index.html` 看课程总览，或者直接从第一课开始：

```
lessons/0001-a-tree-not-a-program.html
```

用浏览器直接打开即可，不需要服务器、不需要构建。

## 目录结构

```
index.html                  课程总览：七章路线图
lessons/                    课时，一课一个 HTML，编号递增
  0001-a-tree-not-a-program.html
reference/                  可反复查阅的压缩材料
  glossary.html             术语表（每课都遵守这套叫法）
assets/                     跨课复用的组件
  course.css                共享样式表（含打印样式）
  quiz.js                   自测题交互脚本
learning-records/           学习者已掌握的记录，用于决定下一课讲多深
MISSION.md                  为什么学这个，以及成功的标准
RESOURCES.md                一手资料清单，每课引用前先查这里
NOTES.md                    教学偏好与本机环境事实
scratch/                    实验脚本与实验文件（产物不入库）
```

## 七章

| 章 | 主题 | 状态 |
|---|---|---|
| 01 | 一棵树，不是一份程序 | 已就绪 |
| 02 | 一个 53 行的插件长什么样 | 待写 |
| 03 | 注册即效果 | 待写 |
| 04 | 层、行、以及「后来者赢」 | 待写 |
| 05 | 两半：Host 与 Client | 待写 |
| 06 | 事件与拦截 | 待写 |
| 07 | 打包、安装、看见它 | 待写 |

## 环境

课件面向本机桌面版 DSH 编写，实测于 `0.2.1-rc.2`（Windows）。课件本身与平台无关，但 `scratch/` 里的脚本假定了 Windows + PowerShell。

### 命令行垫片

这台机器没有把 `dsh` 装进 PATH，桌面版的 CLI 藏在 `app.asar` 里，需要 Electron 的「当作 Node 来跑」开关才能调用。`scratch/dsh.ps1` 是这层垫片，参数原样透传：

```powershell
pwsh -NoProfile -File .\scratch\dsh.ps1 --version
pwsh -NoProfile -File .\scratch\dsh.ps1 --profile web --dump-config
```

`--dump-config` 只做配置计算、不加载任何代码、不写任何文件，可以放心反复跑。

### 提取官方文档原文

`scratch/asar-extract.ps1` 从安装包的 `app.asar` 中按需取出若干文件（只读，不改动安装目录）。提取结果不入库，因为那是 DeepSeek 的版权材料；脚本本身入库，任何人可复跑。

```powershell
pwsh -NoProfile -File .\scratch\asar-extract.ps1
```

## 设计取向

- **每课一个可见结果**：不写纯理论课。概念讲完立刻有一个能在命令行或界面上验证的动作。
- **理论来源标等级**：课里的每条结论都标 `[官方文档]` / `[本机实测]` / `[源码实读]` / `[设计提案]`，读的人能判断该信到什么程度。
- **可打印**：`assets/course.css` 含打印样式，A4 下自动收窄栏宽、展开折叠内容、隐藏交互控件。
- **术语唯一**：同一个词在整门课里只有一个意思，`reference/glossary.html` 是唯一依据。

## 许可

课件文本与代码为教学材料。`scratch/` 中被排除的官方文档提取物版权归 DeepSeek 所有，不在本仓库分发范围内。
