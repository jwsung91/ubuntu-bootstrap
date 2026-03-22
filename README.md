# My Ubuntu Setup Scripts

This repository contains automation scripts for quickly bootstrapping an Ubuntu Desktop 22.04 / 24.04 `amd64` environment. It covers system packages, shell setup, fonts, and developer tooling in one run.

## Project Structure

```text
.
├── install.sh              # Main entry point that runs the full setup
├── scripts/                # Step-by-step setup scripts
│   ├── 01-system.sh        # System update, VS Code, and Chrome installation
│   ├── 02-shell.sh         # Zsh, Oh My Zsh, and plugin installation
│   ├── 03-appearance.sh    # D2Coding font and colorls installation
│   └── 04-stow.sh          # Dotfile symlink setup via GNU Stow
└── dotfiles/               # Managed configuration files for Stow
    ├── zsh/                # Zsh configuration such as .zshrc
    ├── git/                # Git configuration such as .gitconfig
    └── vim/                # Vim configuration such as .vimrc
```

## Included Features

1. **System packages**: runs `apt update && apt upgrade` and installs required packages such as `curl`, `wget`, `git`, `stow`, and `build-essential`
2. **Developer tools**: registers the official VS Code repository and installs Google Chrome
3. **Terminal setup**: installs Zsh, Oh My Zsh, and the `zsh-autosuggestions` and `zsh-syntax-highlighting` plugins
4. **CLI appearance**: installs the D2Coding font and `colorls`
5. **Dotfile management**: links files from `dotfiles/` into the home directory with GNU Stow

## Supported Environment

- Ubuntu Desktop `22.04` or `24.04`
- `amd64` (`x86_64`) architecture

ARM-based Ubuntu is not supported because the Chrome package used by the script is `amd64` only.

## Installation

Run the following command from inside the `my-setup-ubuntu` repository:

```bash
# Start the full setup
./install.sh
```

> Note: `sudo` privileges are required during execution. Each script uses `set -euo pipefail` and exits early on unsupported Ubuntu versions or architectures.

## Behavior

- Several steps are written to be re-runnable and will reuse already installed components when possible.
- Before applying `stow`, the script checks for conflicts. If files with the same target names already exist in your home directory, the process stops until you resolve them.
- When `chsh` changes the default shell to `zsh`, the change applies on the next login.

## Additional Configuration

- **Zsh settings**: add any extra environment variables you need in `dotfiles/zsh/.zshrc`.
- **Aliases**: when `colorls` is installed, the `ls`, `l`, `la`, and `ll` aliases are applied automatically.

## Restarting the Terminal

After setup completes, restart the terminal or run `source ~/.zshrc` to apply the shell changes.
