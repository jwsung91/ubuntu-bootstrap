#!/bin/bash
set -e

echo "--- Dotfiles 심볼릭 링크 생성 (Stow) ---"
# 스크립트 위치 기준으로 dotfiles 폴더로 이동
cd "$(dirname "$0")/../dotfiles"
stow zsh git vim
cd -
