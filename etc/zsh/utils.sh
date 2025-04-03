# 通用函数：检查命令是否存在
function command_exists() {
    command -v "$1" &>/dev/null
}

if [ -f /home/junyi/spack/share/spack/setup-env.sh ]; then
    . /home/junyi/spack/share/spack/setup-env.sh
    echo "\033[32m\033[0;39m  spack activated"
else
    echo "\033[31m\033[0;39m  spack not found"
fi

if command_exists fzf; then
    source <(fzf --zsh)
    echo "\033[32m\033[0;39m  fzf was found and activated"
else
    echo "\033[31m\033[0;39m  fzf not found"
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
    fi
fi


if command_exists duf; then
    alias df="duf"
    echo "\033[32m\033[0;39m  duf activated"
else
    echo "\033[31m\033[0;39m  duf not found"
fi


if command_exists nvim; then
    alias vim="nvim"
    echo "\033[32m\033[0;39m  neovim activated"
else
    echo "\033[31m\033[0;39m  neovim not found"
fi

# Zoxide must be placed at the end of the zshrc
if [ -f ~/.local/bin/zoxide ]; then
    eval "$(zoxide init zsh)"
    alias cd="z"
    echo "\033[32m\033[0;39m  zoxide activated"
else
    echo "\033[31m\033[0;39m  zoxide not found"
fi
