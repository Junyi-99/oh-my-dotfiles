#!/bin/zsh

# Just the Environment Variables...

# check if current shell is zsh, if not, prompt to change
if [ -z "$ZSH_VERSION" ]; then
    echo "Please change your shell to Zsh by running: chsh -s $(which zsh)"
    return 1
fi

# . $ZDOTDIR/zshrc
. ${HOME}/.oh-my-dotfiles/etc/zsh/zshrc
