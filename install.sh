#!/bin/bash
set -e

# 현재 스크립트의 절대 경로를 작업 디렉토리로 설정
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

echo "모든 스크립트에 실행 권한을 부여합니다..."
chmod +x scripts/*.sh

echo "순차적으로 설치를 진행합니다."
./scripts/01-system.sh
./scripts/02-shell.sh
./scripts/03-appearance.sh
./scripts/04-stow.sh

echo "=========================================="
echo "설치 완료! 터미널을 재시작하세요."
echo "=========================================="
