#!/bin/bash
set -euo pipefail

# Set the working directory to the absolute path of this script.
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

echo "Making all scripts executable..."
chmod +x scripts/*.sh

echo "Running setup steps in order."
./scripts/01-system.sh
./scripts/02-shell.sh
./scripts/03-appearance.sh
./scripts/04-stow.sh

echo "=========================================="
echo "Setup complete. Restart your terminal."
echo "=========================================="
