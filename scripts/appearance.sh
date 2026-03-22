#!/bin/bash
set -euo pipefail

FONT_DIR="$HOME/.local/share/fonts"
TEMP_DIR="$(mktemp -d)"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/lib/proxy.sh"
load_proxy_settings

cleanup() {
    rm -rf "$TEMP_DIR"
}

trap cleanup EXIT

echo "--- Installing the D2Coding font ---"
mkdir -p "$FONT_DIR"
apt_with_proxy install -y unzip ruby-full

if ! fc-list | grep -qi "D2Coding"; then
    cd "$TEMP_DIR"
    wget https://github.com/naver/d2codingfont/releases/download/VER1.3.2/D2Coding-Ver1.3.2-20180524.zip
    unzip D2Coding-Ver1.3.2-20180524.zip
    cp D2Coding/*.ttf "$FONT_DIR/"
    fc-cache -f
else
    echo "D2Coding font is already installed."
fi

echo "--- Installing colorls (Ruby gem) ---"
if ! command -v colorls >/dev/null 2>&1; then
    gem_with_proxy install colorls
else
    echo "colorls is already installed."
fi
