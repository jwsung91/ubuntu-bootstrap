#!/bin/bash
set -euo pipefail

check_command() {
    local label="$1"
    shift

    if "$@" >/dev/null 2>&1; then
        echo "[OK] $label"
    else
        echo "[WARN] $label"
    fi
}

echo "--- Verifying installed tooling ---"
check_command "git available" git --version
check_command "zsh available" zsh --version
check_command "vim available" vim --version
check_command "gpg available" gpg --version
check_command "gpg-agent configuration valid" gpg-agent --gpgconf-test
check_command "code available" code --version
check_command "google-chrome available" google-chrome --version
check_command "colorls available" colorls --version
check_command "ssh available" ssh -V

if [[ -f "$HOME/.ssh/id_ed25519.pub" ]]; then
    echo "[OK] SSH public key present: $HOME/.ssh/id_ed25519.pub"
else
    echo "[WARN] SSH public key missing: $HOME/.ssh/id_ed25519.pub"
fi
