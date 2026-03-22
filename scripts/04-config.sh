#!/bin/bash
set -euo pipefail

echo "--- Applying managed dotfile content ---"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR/../dotfiles"
BACKUP_PATH=""

ZSH_SOURCE="$DOTFILES_DIR/zsh/.zshrc"
ZSH_MANAGED_TARGET="$HOME/.zshrc.my-setup-ubuntu"
ZSH_USER_TARGET="$HOME/.zshrc"
ZSH_MARKER_START="# >>> my-setup-ubuntu zshrc >>>"
ZSH_MARKER_END="# <<< my-setup-ubuntu zshrc <<<"

GIT_SOURCE="$DOTFILES_DIR/git/.gitconfig"
GIT_MANAGED_TARGET="$HOME/.gitconfig.my-setup-ubuntu"
GIT_USER_TARGET="$HOME/.gitconfig"
GIT_MARKER_START="# >>> my-setup-ubuntu gitconfig >>>"
GIT_MARKER_END="# <<< my-setup-ubuntu gitconfig <<<"

VIM_SOURCE="$DOTFILES_DIR/vim/.vimrc"
VIM_MANAGED_TARGET="$HOME/.vimrc.my-setup-ubuntu"
VIM_USER_TARGET="$HOME/.vimrc"
VIM_MARKER_START="\" >>> my-setup-ubuntu vimrc >>>"
VIM_MARKER_END="\" <<< my-setup-ubuntu vimrc <<<"

if [[ ! -d "$DOTFILES_DIR" ]]; then
    echo "dotfiles directory not found: $DOTFILES_DIR"
    exit 1
fi

backup_file() {
    local file_path="$1"
    local backup_path

    backup_path="${file_path}.bak.$(date +%Y%m%d%H%M%S)"
    mv "$file_path" "$backup_path"
    BACKUP_PATH="$backup_path"
    echo "Backed up ${file_path} to ${backup_path}"
}

install_managed_file() {
    local source_path="$1"
    local target_path="$2"

    if [[ ! -f "$source_path" ]]; then
        echo "Managed file source not found: $source_path"
        exit 1
    fi

    if [[ -e "$target_path" && ! -L "$target_path" ]] && cmp -s "$source_path" "$target_path"; then
        echo "Managed file already up to date: $target_path"
        return
    fi

    if [[ -e "$target_path" || -L "$target_path" ]]; then
        backup_file "$target_path"
    fi

    install -m 0644 "$source_path" "$target_path"
    echo "Installed managed file: $target_path"
}

ensure_block_in_file() {
    local user_target="$1"
    local marker_start="$2"
    local marker_end="$3"
    local duplicate_probe="$4"
    local managed_line_1="$5"
    local managed_line_2="$6"
    local block
    local backup_path

    block="$(cat <<EOF
$marker_start
$managed_line_1
$managed_line_2
$marker_end
EOF
)"

    if [[ -L "$user_target" ]]; then
        backup_file "$user_target"
    fi

    if [[ -f "$user_target" ]]; then
        if grep -Fq "$marker_start" "$user_target"; then
            echo "Managed block already exists in $user_target"
            return
        fi

        if grep -Fq "$duplicate_probe" "$user_target"; then
            echo "Managed include/source line already exists in $user_target"
            return
        fi

        backup_file "$user_target"
        backup_path="$BACKUP_PATH"
        cp "$backup_path" "$user_target"
        printf "\n%s\n" "$block" >> "$user_target"
        echo "Appended managed block to $user_target"
        return
    fi

    printf "%s\n" "$block" > "$user_target"
    echo "Created $user_target with managed block"
}

install_managed_file "$ZSH_SOURCE" "$ZSH_MANAGED_TARGET"
ensure_block_in_file \
    "$ZSH_USER_TARGET" \
    "$ZSH_MARKER_START" \
    "$ZSH_MARKER_END" \
    "source \"$ZSH_MANAGED_TARGET\"" \
    "if [ -f \"$ZSH_MANAGED_TARGET\" ]; then" \
    "    source \"$ZSH_MANAGED_TARGET\""$'\n''fi'

install_managed_file "$GIT_SOURCE" "$GIT_MANAGED_TARGET"
ensure_block_in_file \
    "$GIT_USER_TARGET" \
    "$GIT_MARKER_START" \
    "$GIT_MARKER_END" \
    "path = $GIT_MANAGED_TARGET" \
    "[include]" \
    "    path = $GIT_MANAGED_TARGET"

install_managed_file "$VIM_SOURCE" "$VIM_MANAGED_TARGET"
ensure_block_in_file \
    "$VIM_USER_TARGET" \
    "$VIM_MARKER_START" \
    "$VIM_MARKER_END" \
    "source $VIM_MANAGED_TARGET" \
    "if filereadable(expand('$VIM_MANAGED_TARGET'))" \
    "    source $VIM_MANAGED_TARGET"$'\n''endif'
