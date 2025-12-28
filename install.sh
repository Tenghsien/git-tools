#!/bin/bash

# Git 仓库地址（已更新）
REPO_URL="https://github.com/Tenghsien/git-tools.git"
EXCLUDE_FILE=".git/info/exclude"

echo "🚀 Git Tools 安装程序启动..."

# 安装函数
install_tool() {
    local tool="$1"
    echo "🔧 开始安装：$tool"

    # 如果目录不存在则 clone，否则 pull 更新
    if [ ! -d "$tool" ]; then
        git clone "$REPO_URL" "$tool" || { echo "❌ 克隆 $tool 失败"; return; }
    else
        echo "✨ $tool 已存在，执行更新..."
        cd "$tool" && git pull && cd ..
    fi

    # 写入 .git/info/exclude 防止提交
    if ! grep -qxF "$tool/" "$EXCLUDE_FILE" 2>/dev/null; then
        echo "$tool/" >> "$EXCLUDE_FILE"
        echo "🙈 已加入 .git/info/exclude"
    fi
}

# ---------------- 模式①：命令行参数模式 ----------------
if [ $# -gt 0 ]; then  
    echo "📌 参数模式：安装指定脚本 --> $*"
    for arg in "$@"; do
        install_tool "$arg"
    done
    echo "🎉 安装完成"
    exit 0
fi

# ---------------- 模式②：无参数 → 交互选择 ----------------
# 扫描当前目录所有文件夹（排除 install.sh、README.md）
TOOLS_DIRS=()
for dir in */; do
    name="${dir%/}"
    if [[ "$name" != "install.sh" && "$name" != "README.md" ]]; then
        TOOLS_DIRS+=("$name")
    fi
done

if [ ${#TOOLS_DIRS[@]} -eq 0 ]; then
    echo "❌ 当前目录未检测到任何可安装脚本目录"
    exit 1
fi

echo "📦 检测到可安装工具包："
for i in "${!TOOLS_DIRS[@]}"; do
    echo " $((i+1))) ${TOOLS_DIRS[$i]}"
done

echo ""
read -p "请输入要安装的编号（可多选，用空格分隔，例如：1 3）： " input

for num in $input; do
    index=$((num-1))
    tool="${TOOLS_DIRS[$index]}"
    [ -n "$tool" ] && install_tool "$tool"
done

echo "🎉 安装完成"
