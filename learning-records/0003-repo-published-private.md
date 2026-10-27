# 仓库已建立并发布为私有仓库

`dsh-plugin-teach` 是独立的 git 仓库，默认分支 `main`，远程指向 `https://github.com/zichuanfeng-trigger/dsh-plugin-teach.git`，**已验证为私有**（匿名访问 API 返回 403，匿名读 raw 返回 404）。

> 2026-10-27 更新：仓库原名 `teach`，已通过 GitHub API 改名为 `dsh-plugin-teach`，本地远程地址同步更新。

## 环境事实（2026-10-21 实测）

- git 2.45.2，来自 UGit 自带的 git（`AppData\Local\UGit\...\git.exe`），不在 `C:\Program Files` 下
- **没有 `gh` CLI**，创建仓库走 GitHub REST API（`POST /user/repos`）完成
- GitHub 账号：`zichuanfeng-trigger`（id `105549102`），凭据由 Windows 凭据管理器 + `credential.helper=manager` 提供，token 权限为 `gist, repo, workflow`
- 全局 `user.email` 是 `Administrator@HYZ`，无法关联 GitHub 账号；**本仓库设了独立身份** `huafeng <zichuanfeng-trigger@users.noreply.github.com>`，全局配置未改动
- 本机 `core.autocrlf=true` 且 `init.defaultBranch=master`，所以 `git init` 显式指定了 `-b main`，并加了 `.gitattributes` 强制 LF，防止 HTML 课件在检出时被改成 CRLF

## 刻意排除的内容

| 排除项 | 原因 |
|---|---|
| `scratch/dump-*.txt`（5 个，约 230 KB） | `--dump-config` 输出，随时可重跑，属可重新生成的产物 |
| `scratch/asar/`（8 个，约 100 KB） | 从 DSH 安装包提取的官方文件，是 DeepSeek 的版权材料，不由本仓库再分发；提取脚本已入库，任何人可复跑 |

## Implications

- 后续每次加课：写文件 → `git add -A` → 用 UGit 的 commit 模板格式提交 → `git push`
- 本仓库是两个待决策项之外的第三个仓库；`dialog-box` 仍是独立的私研究仓库，两者不合并
- 发布前要过一遍「本机绝对路径」检查：`.md` 与 `.html` 里不该出现盘符路径，`.ps1` 里允许作为回退默认值

## Evidence

三次提交均已推送成功，远端 `refs/heads/main` 与本地 HEAD 一致（`970a395`）。远端文件树 21 个文件，`git status` 干净。

## 相关

- [[0001-mission-anchored-to-dialog-box]]
