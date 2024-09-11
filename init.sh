#!/bin/zsh

# check if current shell is zsh, if not, prompt to change
if [ -z "$ZSH_VERSION" ]; then
    echo "Please change your shell to Zsh by running: chsh -s $(which zsh)"
    return 1
fi

# THE MOST IMPORTANT ENV
export USER_CONFIG_HOME="${HOME}/.oh-my-dotfiles"

. ${USER_CONFIG_HOME}/.xdg.sh    # The universal config folder re-location
. ${USER_CONFIG_HOME}/.funcs.sh  # 载入自定义的函数

# Check dependencies
pushd $USER_CONFIG_HOME > /dev/null
check_dependencies
popd > /dev/null 2>&1

chmod -R +x $USER_BIN_HOME

export FORTUNE_FILE="${XDG_CONFIG_HOME}/fortunes/ubuntu-server-tips"
print_greetings

source $ZDOTDIR/.zshrc
