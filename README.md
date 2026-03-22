# My Ubuntu Setup Scripts 🚀

Ubuntu 환경을 빠르고 간편하게 초기 설정하기 위한 자동화 스크립트 모음입니다. 시스템 패키지 설치부터 쉘 설정, 폰트 및 개발 도구 구성을 한 번에 완료할 수 있습니다.

## 📂 프로젝트 구조

```text
.
├── install.sh              # 메인 실행 파일 (전체 프로세스 관리)
├── scripts/                # 단계별 설치 스크립트
│   ├── 01-system.sh        # 시스템 업데이트, VS Code, Chrome 설치
│   ├── 02-shell.sh         # Zsh, Oh My Zsh, 플러그인 설치
│   ├── 03-appearance.sh    # D2Coding 폰트, ColorLS 설치
│   └── 04-stow.sh          # GNU Stow를 이용한 설정 파일 링크
└── dotfiles/               # 관리할 설정 파일들 (Stow 대상)
    ├── zsh/                # .zshrc 등 Zsh 설정
    ├── git/                # .gitconfig 등 Git 설정
    └── vim/                # .vimrc 등 Vim 설정
```

## 🛠 포함된 주요 기능

1.  **시스템 최적화**: `apt update & upgrade`, 필수 패키지(`curl`, `wget`, `git`, `stow`, `build-essential`) 설치
2.  **개발 환경**: VS Code 공식 PPA 등록 및 설치, Google Chrome 설치
3.  **터미널 강화**: Zsh 기반 환경, Oh My Zsh, 플러그인(`autosuggestions`, `syntax-highlighting`)
4.  **디자인**: D2Coding Nerd Font 설치, `colorls`를 통한 미려한 파일 목록 출력
5.  **설정 관리**: GNU Stow를 사용하여 `dotfiles/` 안의 설정들을 홈 디렉토리로 자동 연결

## 🚀 설치 방법

`my-setup-ubuntu` 저장소 내에서 다음 명령어를 실행하세요:

```bash
# 실행 권한 부여 및 설치 시작
./install.sh
```

> **주의**: 스크립트 실행 중 `sudo` 권한(비밀번호 입력)이 필요할 수 있습니다. 각 스크립트 상단에 `set -e`가 포함되어 있어, 설치 중 에러 발생 시 즉시 중단되므로 안전합니다.

## 📝 추가 설정

- **Zsh 설정**: `dotfiles/zsh/.zshrc` 파일에서 `GEMINI_API_KEY` 등을 주석 해제하여 설정할 수 있습니다.
- **Alias**: `ls` 명령어가 자동으로 `colorls`로 매핑되어 있습니다.

## 🔄 터미널 재시작

모든 설치가 완료되면 터미널을 종료 후 다시 시작하거나, `source ~/.zshrc`를 실행하여 변경 사항을 적용하세요.
