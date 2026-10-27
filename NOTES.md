# 教学偏好与工作笔记

## 用户偏好（小枫）

- 自称"我"，称助理"昼"
- 技术底子：UE + C++ 熟，JS/TS 零基础。**类比赛道优先用 UE/C++**：插件 ≈ 模块、`ctx` ≈ 服务定位器、`inject` ≈ 模块依赖、`apply` ≈ `IModuleInterface::StartupModule()`
- 要"先总览分章、再逐章展开"，每章先给"读完能回答"
- 抽象概念先落到界面上的具体形态，再解释是什么
- 代码示例贴真实源码，标出处、带中文注释、明确输入输出
- 不预设任何库函数/引擎 API 是已知的
- 不要 emoji

## 教学策略

- 每课一个可验证的可见结果（命令行输出或界面变化），不写纯理论
- 一次只推进一个概念，宁可少讲
- 测验题每个选项**字数相同**，正确项位置打散
- 引用一律标来源：`[官方文档]` / `[本机实测]` / `[源码实读]` / `[dialog-box 调研]` / `[设计提案]`
- 用户提到的 `dialog-box` 项目是课程的最终落点，章节末尾尽量拉回它

## 环境事实（2026-10-18 实测，勿再猜）

- DSH 运行时版本：`0.2.1-rc.2`（`dsh --version` 实测）；Desktop 包 `2.0.19-next`，MIT
- 没有 `dsh` on PATH，也没有 `pnpm` on PATH。用 `scratch/dsh.ps1` 这层垫片调用，它读 `DSH_EXE` 环境变量，缺省回退到本机安装位置
- 当前 profile：`desktop`（`$env:DSH_PROFILE`），目录 `~/.dsh/profiles/desktop`
- 该 profile 有 15 个 bundle，`~/.dsh/profiles/desktop/cordis.yml` 内容只有注释 + `[]`
- `web` profile 是干净的官方模板（2 个 bundle），适合做实验，改它不影响桌面的日常使用
- `--dump-config` **不写任何文件**（已核对 profile 目录 mtime 未变）

## 已验证的实验（可直接复用的教学动作）

1. `--patch` 插入一行 → 在 dump-config 底部出现 `# == <patch 绝对路径>` 层，含那一行（实测通过）
2. 按 id 覆盖已存在的行 → 该行 `config` **整体替换**，不是深合并（实测：`session-title` 三个键只剩一个）
3. 覆盖时可省略 `name`，dump 里仍显示原 `name`（实测通过）
4. `--dump-config` 不加载代码，所以 `name` 指向不存在的模块也能 dump（可用于纯配置实验）

## 已知风险

- 用户机器有 9 个第三方插件，其中一个（`dsh-skill-mcp-panel`）会往 `cordis.patch.yml` 里写 MCP 区块，改 profile patch 时要避开该区块
- 桌面版重启会重载 profile，教学时应优先用 `web` profile 做实验，避免污染日常工作树

## 仓库工作流（2026-10-21 建立）

- 远程：`https://github.com/zichuanfeng-trigger/dsh-plugin-teach.git`，私有，默认分支 `main`（原名 `teach`，2026-10-27 改名）
- 本仓库独立身份：`huafeng <zichuanfeng-trigger@users.noreply.github.com>`（全局 email 是 `Administrator@HYZ`，关联不上 GitHub，所以只在本地覆盖）
- 没有 `gh` CLI；建仓库用 GitHub REST API，token 从凭据管理器取
- 提交信息按 UGit 模板（`[类型]: 简要` + 具体改动 + 测试验证）
- **提交信息必须无 BOM**：用 PowerShell 写临时消息文件时，`Out-File -Encoding utf8` 在 PowerShell 5 会带 BOM，`git commit -F` 会把它吃进 subject。
  正确写法：`[System.IO.File]::WriteAllText($path, $msg, (New-Object System.Text.UTF8Encoding($false)))`
  验证写法：`git cat-file -p <sha>` 看空行后首字符是否 U+FEFF
- 每次提交前跑两项检查：本机绝对路径（`.md`/`.html` 里不该有）、HTML 标签平衡
- 不加课就不要提交；`scratch/dump-*.txt` 与 `scratch/asar/` 永远不入库
