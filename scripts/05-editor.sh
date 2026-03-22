#!/bin/bash
set -euo pipefail

VIM_BUNDLE_DIR="$HOME/.vim/bundle"

install_vim() {
    echo "--- Installing Vim ---"
    sudo apt install -y vim
}

install_plugin() {
    local repo_url="$1"
    local plugin_dir="$2"

    if [[ ! -d "$plugin_dir" ]]; then
        git clone "$repo_url" "$plugin_dir"
    else
        echo "Plugin already installed: $plugin_dir"
    fi
}

install_vim_plugins() {
    echo "--- Installing Vim plugin manager and plugins ---"
    mkdir -p "$VIM_BUNDLE_DIR"

    install_plugin "https://github.com/VundleVim/Vundle.vim.git" "$VIM_BUNDLE_DIR/Vundle.vim"
    install_plugin "https://github.com/tpope/vim-fugitive.git" "$VIM_BUNDLE_DIR/vim-fugitive"
    install_plugin "https://github.com/preservim/nerdtree.git" "$VIM_BUNDLE_DIR/nerdtree"
    install_plugin "https://github.com/preservim/nerdcommenter.git" "$VIM_BUNDLE_DIR/nerdcommenter"
    install_plugin "https://github.com/Raimondi/delimitMate.git" "$VIM_BUNDLE_DIR/delimitMate"
    install_plugin "https://github.com/vim-airline/vim-airline.git" "$VIM_BUNDLE_DIR/vim-airline"
    install_plugin "https://github.com/vim-airline/vim-airline-themes.git" "$VIM_BUNDLE_DIR/vim-airline-themes"
    install_plugin "https://github.com/joshdick/onedark.vim.git" "$VIM_BUNDLE_DIR/onedark.vim"
}

install_vim
install_vim_plugins
