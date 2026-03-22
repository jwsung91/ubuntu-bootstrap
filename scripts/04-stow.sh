#!/bin/bash
set -euo pipefail

echo "--- Creating dotfile symlinks with Stow ---"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR/../dotfiles"

if [[ ! -d "$DOTFILES_DIR" ]]; then
    echo "dotfiles directory not found: $DOTFILES_DIR"
    exit 1
fi

if ! stow --dir="$DOTFILES_DIR" --target="$HOME" --simulate --restow zsh git vim; then
    echo "Stow cannot proceed because existing files conflict with the target paths. Resolve the conflicts and run the script again."
    exit 1
fi

stow --dir="$DOTFILES_DIR" --target="$HOME" --restow zsh git vim
