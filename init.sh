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


# Homebrew related environment variables ====== BEGIN ======
export HOMEBREW_PREFIX="$USER_DEP_HOME/homebrew"
export HOMEBREW_REPOSITORY="$USER_DEP_HOME/homebrew"
export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar"
export HOMEBREW_NO_ANALYTICS=1

export PATH="$HOMEBREW_PREFIX/bin:$PATH"
export PATH="$HOMEBREW_PREFIX/sbin:$PATH"
export MANPATH="$HOMEBREW_PREFIX/share/man:$MANPATH"
export INFOPATH="$HOMEBREW_PREFIX/share/info:$INFOPATH"

if command_exists brew; then
    echo "\033[32m\033[0;39m  homebrew installed"
else
    log_message "Homebrew not found, please install it first"
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        mkdir -p $HOMEBREW_PREFIX >/dev/null 2>&1
        curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C $HOMEBREW_PREFIX
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        log_message "🚼 homebrew not found, please install it"
    fi
fi
# Homebrew related environment variables ====== END ========

# Check dependencies

check_dependencies


print_greetings

source $ZDOTDIR/zshrc
