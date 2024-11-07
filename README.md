# Oh My Dotfiles

> [!TIP]
> There isn’t a one-size-fits-all configuration file. You should explore dotfiles shared by others and continuously build your own personalized dotfile.

<img width="1005" alt="image" src="https://github.com/user-attachments/assets/36147a29-6c22-40e1-85b4-875cfa773b63">

<img width="1098" alt="image" src="https://github.com/user-attachments/assets/30b98735-9bf8-475d-acff-6f7716a3c16f">

## Features
- **out-of-the-box**
- **no side effects**
  - all operations happen in `~/.oh-my-dotfiles`
  - deleting `~/.oh-my-dotfiles` will restore your environment.
  - third-party binaries will be downloaded into `~/.oh-my-dotfiles/bin` or `~/.oh-my-dotfiles/deps` (See [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/latest/index.html))
- neovim
  - AI assistant ([copilot](https://github.com/github/copilot.vim))
  - lsp + lsp-manager ([manson](https://github.com/williamboman/mason.nvim))
  - plugin-manager ([lazy-nvim](https://github.com/folke/lazy.nvim))
  - notification-manager ([nvim-notify](https://github.com/rcarriga/nvim-notify))
  - code highlighting ([nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter))
  - shortcut key hint ([which-key](https://github.com/folke/which-key.nvim))
- [batcat](https://github.com/sharkdp/bat)
- [tmux](https://github.com/tmux/tmux)
  - 256color
  - <kbd>CTRL + A</kbd> Prefix
  - Mouse Enabled
- [fzf](https://github.com/junegunn/fzf)
- [zoxide](https://github.com/ajeetdsouza/zoxide)
- [zsh](https://www.zsh.org/) + [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) + [zsh-autosuggestion](https://github.com/zsh-users/zsh-autosuggestions)

## Get Started

1. Delete your `.zshrc` (Optional)
```sh
rm -f ~/.zshrc
```

2. Clone the latest repository
```sh
rm -rf ~/.oh-my-dotfiles
git clone https://github.com/Junyi-99/oh-my-dotfiles.git ~/.oh-my-dotfiles
echo "source ~/.oh-my-dotfiles/init.sh" >> ~/.zshrc
```

3. Setting up SSH configs
```sh
echo "Include ~/.oh-my-dotfiles/etc/ssh/*.local" >> ~/.ssh/config
```

4. Activate!
```sh
source ~/.zshrc
```
