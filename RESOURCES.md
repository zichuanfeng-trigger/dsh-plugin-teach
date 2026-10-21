# DSH 插件开发 Resources

## Knowledge（一手资料，按可信度排序）

### 官方文档（deepseek-ai/deepseek-harness）

- [架构总览 docs/architecture.md](https://github.com/deepseek-ai/deepseek-harness/blob/master/docs/architecture.md)
  整条教学主线的一手依据。用 for：讲"层 / profile / bundle / 补丁"时的权威出处；每次课引用其中一段。
- [Cordis 入门 docs/cordis-primer.md](https://github.com/deepseek-ai/deepseek-harness/blob/master/docs/cordis-primer.md)
  五条核心概念（插件、上下文、inject、事件、可撤销效果）加五种派发模式对照表。用 for：第 1–3 课的概念定义，术语以它为准。
- [第一个插件 docs/user/develop/basic/index.zh.md](https://github.com/deepseek-ai/deepseek-harness/blob/master/docs/user/develop/basic/index.zh.md)
  中文，从零写最小插件并挂进 Web UI。用 for：第 2 课"最小合法插件"的官方标准答案。
- [Cordis 教程 docs/cordis-tutorial/index.zh.md](https://github.com/deepseek-ai/deepseek-harness/blob/master/docs/cordis-tutorial/index.zh.md)
  七章动手教程（插件、生命周期、服务、事件、配置、组合与 HMR、进入 harness）。用 for：需要更深一层时的章节索引。
- [事件生产消费表 docs/event-producer-consumer.md](https://github.com/deepseek-ai/deepseek-harness/blob/master/docs/event-producer-consumer.md)
  每个事件谁发谁收。用 for：第 6 课讲事件拦截时查表。

### 本机已有的原文（比在线文档更贴近你这台机器）

路径：DSH 安装目录下的 `resources\app.asar`（需用 `scratch/asar-extract.ps1` 提取）

- `@deepseek-ai/dsh-client-ui-plugin-manager/README.zh.md`
  插件管理器的完整行为说明。用 for：装/启用/卸载的每一步会发生什么，以及 `meta.title`、`icon` 这些展示字段被谁读。
- `@deepseek-ai/dsh-client-ui-conversation/README.zh.md`
  会话界面（含输入框）的组件与槽位说明。用 for：第 5 课确定槽位名，以及 `dialog-box` 的落点。
- `@deepseek-ai/dsh-client-ui-slots/package.json` 与包内 README
  Slot 注册表的四种 kind（single/list/keyed/chain）。用 for：判断一个槽位能塞几个东西。
- `@deepseek-ai/dsh-web-app/package.json`
  官方 bundle 长什么样。用 for：写自己的 `dsh.bundle` 时对照。
- `@deepseek-ai/dsh-app-boot/README.zh.md`
  四层加载顺序与 `engines.dsh` 强制检查的权威出处（已提取到 `dialog-box/evidence/asar/`）。

### 内置的插件开发技能（藏在 dsh 自己身上）

- `@deepseek-ai/dsh-agent-preset/skills/cordis-plugin-development/`
  官方给 Agent 用的插件开发技能，含 `SKILL.md` 与五个 references、两套模板（UI 装饰 / MCP）。用 for：第 2、5、7 课的模板来源。**这是这台机器上最完整的一份"怎么写"文档**。
- 同目录 `cordis-composition-reference/references/packages.md`（41 KB）
  可安装插件包与 loader patch 方言的清单。用 for：第 4 课查 patch 语法。

### 活样本（本机已安装，可直接读源码）

- `~/.dsh/profiles/desktop/node_modules/@deepseek-ai/dsh-skill-badge/`（53 行）
  最短的官方插件。用 for：第 1 课讲骨架、第 2 课讲 `inject` 与 `apply` 的标本。
- `~/.dsh/profiles/desktop/node_modules/dsh-whale-widget/`
  带 UI 的第三方插件，`dsh.bundle` 最干净。用 for：第 5、7 课的对照样本。
- `~/.dsh/profiles/desktop/node_modules/dsh-skill-mcp-panel/`
  Host + Client 双侧插件的完整形态（`exports` 的 `./client`、`dsh.client.inject`）。用 for：第 5 课"两半"的实证。
- 同目录下其它 9 个插件可用于横向对照。

### 本项目已有的调研（可信但有明确依据等级标注）

这些材料在外部的私研究仓库 `dialog-box` 中（与本仓库同级），不在本仓库分发。

- `docs/06-DSH输入框实测.md`
  输入框的真实结构（Lexical、CSS 变量、9 个槽位、`captureInsertion`/`insertText`）。用 for：第 5 课之后讲"落到哪个槽位"时。
- `docs/03-仓库形态与构建方式.md`
  三条链（安装/挂载/元数据）、patch 语法、层顺序、安装通道、`engines.dsh` 门禁。用 for：第 4、7 课的技术底色。
- `docs/02-插件设计.md`
  `dialog-box` 各功能的技术方案与 V0–V6 切片。用 for：课程最终要接上的工程目标。

## Wisdom（社区 / 真人反馈）

- [deepseek-ai/deepseek-harness · Discussions](https://github.com/deepseek-ai/deepseek-harness/discussions)
  官方讨论区，架构类问题有人答。用 for：官方文档没写清、只能在实现里看出来的问题。
- [GitHub topic: dsh-plugin](https://github.com/topics/dsh-plugin)
  两万余个第三方插件仓库。用 for：找同类插件读源码；想验证"别人怎么做的"时。
- [awesome-dsh-plugin](https://github.com/awesome-dsh-plugin/awesome-dsh-plugin)
  社区维护的插件清单。用 for：按类别找样本，尤其中文插件。
- `~/.dsh/profiles/desktop/node_modules/` 下已安装的 9 个第三方插件
  **最诚实的社区来源**：它们的 `package.json` 与 `cordis.patch.yml` 是真实上架形态，比任何教程都准。用 for：每次写自己的清单前，先横向比这三五个。

## Gaps

- **Web Client 侧槽位与渲染器的官方文档不全**：`SlotMap` 的具体 slot 名、props 注入规则，官方没有一份集中清单，只能从 `dsh-client-ui-conversation` 的 README 与已安装插件源码里反推。讲第 5 课时必须说明这是"读出来的"而非"文档写明的"。
- **没有中文的 Cordis 事件模型深入材料**：primer 只有对照表，waterfall 的语义细节要靠官方英文文档与源码。
- **`dialog-box` 项目自身尚无社区**：它还没发布，暂无外部反馈渠道。
