# Oh My Zsh 설정
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# Gemini API Key 주석
# export GEMINI_API_KEY="여기에_키를_넣으세요"

# Colorls Alias
if [ -x "$(command -v colorls)" ]; then
    alias ls='colorls'
    alias l='colorls -l'
    alias la='colorls -a'
    alias ll='colorls -la'
fi
