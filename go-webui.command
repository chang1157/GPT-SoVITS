#!/bin/bash

# 检查Xcode命令行工具是否安装
if ! xcode-select -p &>/dev/null; then
    echo "安装Xcode Command Line Tools..."
    xcode-select --install
fi

# 检查Homebrew是否安装
if ! command -v brew &>/dev/null; then
    echo "安装Homebrew..."
    /bin/zsh -c "$(curl -fsSL https://gitee.com/cunkai/HomebrewCN/raw/master/Homebrew.sh)"
fi

# 检查 ffmpeg 是否已安装
if command -v ffmpeg >/dev/null 2>&1; then
    echo "ffmpeg 已安装."
else
    echo "ffmpeg 未安装."
    echo "安装 ffmpeg..."
    brew install ffmpeg  
fi

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

cd "$SCRIPT_DIR"

if [ -e "./runtime/bin/python3" ]; then
    :
else
    CommandlineToolPath=$(xcode-select -p)
    PYTHON1="${CommandlineToolPath}/Library/Frameworks/Python3.framework/Versions/3.9/Python3"
    PYTHON2="${CommandlineToolPath}/Library/Frameworks/Python3.framework/Versions/3.9/Resources/Python.app/Contents/MacOS/Python"

    ln -sfn $PYTHON1 ./runtime/.Python
    ln -sfn $PYTHON2 ./runtime/bin/python
    ln -sfn $PYTHON2 ./runtime/bin/python3
    ln -sfn $PYTHON2 ./runtime/bin/python3.9
fi

if [ -e "./runtime/bin/python3" ]; then
    :
else
    echo "No Such File: $PYTHON2"
    echo "CommandlineToolPath Error"
    exit 1
fi


source "./runtime/bin/activate"

"./runtime/bin/python3" webui.py zh_CN

