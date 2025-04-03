# 通用函数：检查命令是否存在
function command_exists() {
    command -v "$1" &>/dev/null
}

if [ -f ${HOME}/spack/share/spack/setup-env.sh ]; then
    . ${HOME}/spack/share/spack/setup-env.sh
    echo "\033[32m\033[0;39m  spack activated"
else
    echo "\033[31m\033[0;39m  spack not found"
fi

if command_exists fzf; then
    source <(fzf --zsh)
    echo "\033[32m\033[0;39m  fzf was found and activated"
else
    echo "\033[31m\033[0;39m  fzf not found"
    brew install fzf
fi

if command_exists bat; then
    alias cat="bat -p --theme=ansi"
    echo "\033[32m\033[0;39m  bat activated"
else
    if command_exists batcat; then
        alias cat="batcat -p --theme=ansi"
        echo "\033[32m\033[0;39m  batcat activated"
    else
        echo "\033[31m\033[0;39m  batcat not found"
        brew install bat
    fi
fi


if command_exists duf; then
    alias df="duf"
    echo "\033[32m\033[0;39m  duf activated"
else
    echo "\033[31m\033[0;39m  duf not found"
    brew install duf
fi


if command_exists nvim; then
    alias vim="nvim"
    echo "\033[32m\033[0;39m  neovim activated"
else
    echo "\033[31m\033[0;39m  neovim not found"
fi

if command_exists node; then
    echo "\033[32m\033[0;39m  node.js found"
else
    echo "\033[31m\033[0;39m  node.js not found"
    brew install node
fi

# Zoxide must be placed at the end of the zshrc
if command_exists zoxide; then
    eval "$(zoxide init zsh)"
    alias cd="z"
    echo "\033[32m\033[0;39m  zoxide activated"
else
    echo "\033[31m\033[0;39m  zoxide not found"
    brew install zoxide
fi