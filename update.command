#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

cd "$SCRIPT_DIR"

git stash

git stash drop

git pull

source "./runtime/bin/activate"

pip3 install -r "./requirements.txt" -i https://pypi.tuna.tsinghua.edu.cn/simple -U

