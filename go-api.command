#!/bin/bash

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

source "./runtime/bin/activate"

"./runtime/bin/python3" api.py

