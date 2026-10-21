# 已披露的技术底子与可用的类比赛道

用户已明确：相对熟悉 UE + C++，**其他语言基本零基础**（JS/TS 当新知识讲）。

这条决定了所有解释的入口必须选 C++ 侧。已验证有效的四条类比：

| DSH 概念 | 已采用的 C++ 类比 | 出处 |
|---|---|---|
| 插件行（entry） | 配置文件里的一条加载指令，`name` 是 DLL 路径，`config` 是启动参数结构体 | 第一课第一节 |
| `apply` | `IModuleInterface::StartupModule()` | 术语表 |
| `inject` | `Build.cs` 的 `PublicDependencyModuleNames`，但由运行时保证顺序 | 术语表 |
| `ctx` | 服务定位器（service locator），不是基类 | 术语表 |
| `waterfall` | 责任链 + 中间件，不是观察者 | 术语表 |

## Implications

- 讲 JS 语法时不要假设 `const`/`=>`/解构/模板串是已知的，首次出现要就地拆
- 但可以放心使用"模块""符号""链接""接口""回调"这类词
- 每次引入新的 JS 语法点，优先找 C++ 里语义最近的东西（如 `=>` ↔ lambda、`const` ↔ `const` 指针的只读意图）

## Evidence

出自会话指令中的用户底子说明；第一课正文中的 C++ 类比框架已按此写就。

## 相关

- [[0001-mission-anchored-to-dialog-box]]
