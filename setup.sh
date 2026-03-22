#!/bin/bash
set -euo pipefail

# Set the working directory to the absolute path of this script.
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

usage() {
    cat <<'EOF'
Usage:
  ./setup.sh                Start interactive step selection
  ./setup.sh all            Run every setup step
  ./setup.sh system applications shell appearance editor config   Run only selected steps

Available steps:
  system        System update and required packages
  applications  VS Code and Chrome
  shell         Zsh, Oh My Zsh, plugins, and theme
  appearance    D2Coding font and colorls
  editor        Vim and plugin bootstrap
  config        Managed dotfile content update
EOF
}

run_step() {
    local step="$1"

    case "$step" in
        system)
            ./scripts/01-system.sh
            ;;
        applications)
            ./scripts/02-applications.sh "$@"
            ;;
        shell)
            ./scripts/03-shell.sh
            ;;
        appearance)
            ./scripts/04-appearance.sh
            ;;
        editor)
            ./scripts/05-editor.sh
            ;;
        config)
            ./scripts/06-config.sh
            ;;
        *)
            echo "Unknown step: $step"
            usage
            exit 1
            ;;
    esac
}

prompt_step() {
    local step="$1"
    local description="$2"
    local answer

    read -r -p "Run ${step} (${description})? [y/N] " answer
    if [[ "$answer" =~ ^[Yy]$ ]]; then
        run_step "$step"
    else
        echo "Skipping ${step}."
    fi
}

if [[ $# -gt 0 && ( "$1" == "--help" || "$1" == "-h" ) ]]; then
    usage
    exit 0
fi

echo "Making all scripts executable..."
chmod +x scripts/*.sh

if [[ $# -eq 0 ]]; then
    echo "No steps were passed. Starting interactive selection."
    prompt_step "system" "system update and required packages"
    prompt_step "applications" "VS Code and Chrome"
    prompt_step "shell" "Zsh, Oh My Zsh, plugins, and theme"
    prompt_step "appearance" "D2Coding font and colorls"
    prompt_step "editor" "Vim and plugin bootstrap"
    prompt_step "config" "managed dotfile content update"
elif [[ "$1" == "all" ]]; then
    echo "Running all setup steps."
    run_step "system"
    run_step "applications" "all"
    run_step "shell"
    run_step "appearance"
    run_step "editor"
    run_step "config"
else
    echo "Running selected setup steps: $*"
    for step in "$@"; do
        run_step "$step"
    done
fi

echo "=========================================="
echo "Setup complete. Restart your terminal."
echo "=========================================="
