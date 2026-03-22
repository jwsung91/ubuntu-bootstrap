#!/bin/bash
set -euo pipefail

echo "--- Installing Zsh and setting it as the default shell ---"
sudo apt install -y zsh
ZSH_PATH="$(command -v zsh)"
CURRENT_SHELL="$(getent passwd "$USER" | cut -d: -f7)"

if [[ "$CURRENT_SHELL" != "$ZSH_PATH" ]]; then
    chsh -s "$ZSH_PATH"
    echo "Default shell changed to zsh. It will apply on the next login."
else
    echo "Default shell is already set to zsh."
fi

echo "--- Installing Oh My Zsh ---"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

echo "--- Installing Zsh plugins ---"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
[ ! -d "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" ] && git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"
[ ! -d "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting" ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"
