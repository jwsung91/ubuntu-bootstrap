# My Ubuntu Setup Scripts

This repository contains automation scripts for quickly bootstrapping an Ubuntu Desktop 22.04 / 24.04 `amd64` environment. It covers system packages, shell setup, fonts, and developer tooling in one run.

## Project Structure

```text
.
├── setup.sh                # Main entry point for interactive or selective setup
├── scripts/                # Step-by-step setup scripts
│   ├── 01-system.sh        # System update and required package installation
│   ├── 02-applications.sh  # Selective VS Code and Chrome installation
│   ├── 03-shell.sh         # Zsh, Oh My Zsh, plugin, and theme installation
│   ├── 04-appearance.sh    # D2Coding font and colorls installation
│   ├── 05-editor.sh        # Vim and plugin bootstrap
│   └── 06-config.sh        # Managed dotfile content update and config merge
└── dotfiles/               # Managed configuration file templates
    ├── zsh/                # Zsh configuration such as .zshrc
    ├── git/                # Git configuration such as .gitconfig
    └── vim/                # Vim configuration such as .vimrc
```

## Included Features

1. **System packages**: runs `apt update && apt upgrade` and installs required packages such as `curl`, `wget`, `git`, and `build-essential`
2. **Applications**: lets you choose VS Code and Google Chrome individually
3. **Terminal setup**: installs Zsh, Oh My Zsh, the `zsh-autosuggestions` and `zsh-syntax-highlighting` plugins, and the `powerlevel10k` theme
4. **CLI appearance**: installs the D2Coding font and `colorls`
5. **Editor bootstrap**: installs Vim, bootstraps Vundle, and runs a non-interactive Vim plugin sync
6. **Dotfile management**: backs up existing config files, installs managed config fragments, and adds include or source blocks without duplication

## Supported Environment

- Ubuntu Desktop `22.04` or `24.04`
- `amd64` (`x86_64`) architecture

ARM-based Ubuntu is not supported because the Chrome package used by the script is `amd64` only.

## Installation

Run one of the following commands from inside the `my-setup-ubuntu` repository:

```bash
# Start interactive step selection
./setup.sh

# Start interactive step selection explicitly
./setup.sh select

# Run the full setup in order
./setup.sh full

# Run only selected steps
./setup.sh run system applications shell appearance editor config

# Run only the applications step and choose interactively
./scripts/02-applications.sh

# Install only VS Code
./scripts/02-applications.sh vscode
```

> Note: `sudo` privileges are required during execution. Each script uses `set -euo pipefail` and exits early on unsupported Ubuntu versions or architectures.

## Behavior

- `./setup.sh select` lets you choose steps one by one.
- `./setup.sh full` runs the full setup in the default order.
- `./setup.sh run ...` runs only the steps you specify.
- `setup.sh` supports both interactive selection and explicit step arguments.
- Several steps are written to be re-runnable and will reuse already installed components when possible.
- The default full setup order is `system -> applications -> shell -> appearance -> editor -> config`.
- For Zsh, Git, and Vim, the script keeps managed files such as `~/.zshrc.my-setup-ubuntu` and updates the main config files by appending include or source blocks only when those blocks are not already present.
- If an existing config file must be changed, the script creates a timestamped backup before writing the updated file.
- When `chsh` changes the default shell to `zsh`, the change applies on the next login.

## Additional Configuration

- **Zsh settings**: add any extra environment variables you need in `dotfiles/zsh/.zshrc`.
- **Aliases**: when `colorls` is installed, the `ls`, `l`, `la`, and `ll` aliases are applied automatically.

## Restarting the Terminal

After setup completes, restart the terminal or run `source ~/.zshrc` to apply the shell changes.
