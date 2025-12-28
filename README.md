# Git Tools - Diff 管理工具

一个用于管理和应用 Phabricator Diff 的命令行工具。

## ✨ 特性

- 🔍 **检查 Diff 状态** - 快速检查哪些 diff 已合入当前分支
- 🔧 **自动 Patch** - 批量应用未合入的 diff
- 🔄 **远程同步** - 强制同步远程分支代码
- 📝 **清晰输出** - 彩色输出，状态一目了然

## 📦 安装

### 方法一：一键在线安装 ⚡️（推荐）

```bash
curl -fsSL https://raw.githubusercontent.com/你的用户名/git-tools-for-WeRide/main/install-online.sh | bash
```

或使用 wget：

```bash
wget -qO- https://raw.githubusercontent.com/你的用户名/git-tools-for-WeRide/main/install-online.sh | bash
```

> **注意**：请将 `你的用户名` 替换为你的 GitHub 用户名，如果主分支是 `master` 请将 `main` 改为 `master`

### 方法二：克隆安装

```bash
# 克隆仓库
git clone https://github.com/你的用户名/git-tools-for-WeRide.git
cd git-tools-for-WeRide

# 运行安装脚本
./install.sh
```

### 方法三：手动安装

```bash
# 复制文件到安装目录
mkdir -p ~/.local/share/git-tools/lib
cp git-tools.sh ~/.local/share/git-tools/
cp lib/*.sh ~/.local/share/git-tools/lib/

# 创建符号链接
mkdir -p ~/.local/bin
ln -s ~/.local/share/git-tools/git-tools.sh ~/.local/bin/git-tools

# 添加到 PATH（如果还没有）
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

## 🚀 使用方法

### 1. 配置 Diff 列表

在你的项目根目录下创建 `tengxian_xu_tools/diff_list.txt` 文件：

```bash
mkdir -p tengxian_xu_tools
vim tengxian_xu_tools/diff_list.txt
```

文件内容示例：

```text
# 这是我的 Diff 列表
D12345
D12346
D12347

# 可以添加注释
D12348
```

### 2. 运行命令

#### 检查 Diff 状态

检查哪些 diff 已经合入当前分支：

```bash
git-tools check
```

输出示例：

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  开始检查 diff 状态
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

正在检查 D12345...
  ✅ D12345 已合入

正在检查 D12346...
  ❌ D12346 未合入该分支

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
检查完成！共检查 2 个 diff
有 1 个 diff 未合入
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

#### 应用未合入的 Diff

自动 patch 所有未合入的 diff：

```bash
git-tools patch
```

#### 强制同步远程代码

放弃所有本地更改，强制同步远程分支：

```bash
git-tools reset
```

**⚠️ 警告：此操作会丢失所有本地修改，请谨慎使用！**

## 📁 文件结构

```
git-tools-for-WeRide/
├── git-tools.sh          # 主脚本
├── lib/                  # 库文件目录
│   ├── common.sh         # 通用函数库
│   ├── diff_utils.sh     # Diff 处理工具
│   └── git_ops.sh        # Git 操作工具
├── install.sh            # 安装脚本
├── uninstall.sh          # 卸载脚本
└── README.md             # 说明文档
```

## 🔧 依赖要求

- `git` - Git 版本控制工具
- `arc` - Phabricator Arcanist 命令行工具

## ❓ 常见问题

### Q: 命令找不到？

A: 确保 `~/.local/bin` 在你的 PATH 中：

```bash
echo $PATH | grep -q "$HOME/.local/bin" || echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### Q: Diff patch 失败怎么办？

A: Patch 失败通常是因为代码冲突。你可以：

1. 手动解决冲突后重新运行 `git-tools patch`
2. 使用 `git-tools reset` 重新开始

### Q: 如何更新工具？

A: 重新运行安装脚本即可：

```bash
cd git-tools-for-WeRide
git pull
./install.sh
```

## 🗑️ 卸载

```bash
cd git-tools-for-WeRide
./uninstall.sh
```

或手动删除：

```bash
rm ~/.local/bin/git-tools
rm -rf ~/.local/share/git-tools
```

## 📝 配置说明

### Diff 列表文件格式

- 每行一个 Diff ID (格式: `D12345`)
- 支持 `#` 开头的注释行
- 空行会被忽略
- 默认位置: `./tengxian_xu_tools/diff_list.txt`

### 自定义配置

如果需要修改默认配置，可以编辑 `~/.local/share/git-tools/git-tools.sh` 中的 `FILE_PATH` 变量。

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📄 许可证

MIT License

## 👥 作者

Tengxian Xu

---

**提示**: 使用前请确保你在正确的 git 分支上，并且已经配置好 Phabricator Arcanist。
