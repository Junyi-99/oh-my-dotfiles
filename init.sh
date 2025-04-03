#!/bin/zsh

# Just the Environment Variables...

# check if current shell is zsh, if not, prompt to change
if [ -z "$ZSH_VERSION" ]; then
    echo "Please change your shell to Zsh by running: chsh -s $(which zsh)"
    return 1
fi

export USER_CONFIG_HOME="${HOME}/.oh-my-dotfiles"
. ${USER_CONFIG_HOME}/.xdg.sh    # The universal config folder re-location
. ${USER_CONFIG_HOME}/.funcs.sh  # 载入自定义的函数


# ZSH related environment variables ========= BEGIN =======
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export ZSH="${USER_DEP_HOME}/oh-my-zsh"
export ZSH_CUSTOM="${ZSH}/custom"

if [ ! -d $ZSH ]; then
    log_message "oh-my-zsh not found, installing ..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc --unattended
    log_message "Finished installing oh-my-zsh"
fi

if [ ! -d $ZSH_CUSTOM/plugins/zsh-syntax-highlighting ]; then
    log_message "zsh-syntax-highlighting not found, installing ..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
    log_message "Finished installing zsh-syntax-highlighting"
fi

if [ ! -d $ZSH_CUSTOM/plugins/zsh-autosuggestions ]; then
    log_message "zsh-autosuggestions not found, installing ..."
    git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
    log_message "Finished installing zsh-autosuggestions"
fi
# ZSH related environment variables ======== END ========

# Check dependencies
pushd $USER_CONFIG_HOME > /dev/null
check_dependencies
popd > /dev/null 2>&1

print_greetings

source $ZDOTDIR/zshrc
