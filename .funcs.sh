#!/bin/bash

# 通用函数：打印带时间戳的日志消息
log_message() {
    local message="$1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $message"
}

# 通用函数：检查命令是否存在
function command_exists() {
    command -v "$1" &>/dev/null
}

# 通用函数：下载和解压文件
download_and_extract() {
    local url="$1"
    local dest="$2"
    local tmp_file="tmp/$(basename $url)"
    mkdir -p tmp
    wget "$url" -O "$tmp_file"
    tar -xvf "$tmp_file" -C "$dest" --strip-components 1
    rm "$tmp_file"
}

# 解压文件的函数
extract() {
    local file="$1"
    if [[ -f $file ]]; then
        case $file in
        *.tar.bz2) tar xjvf "$file" ;;
        *.tar.gz) tar xzvf "$file" ;;
        *.bz2) bunzip2 "$file" ;;
        *.rar) rar x "$file" ;;
        *.gz) gunzip "$file" ;;
        *.tar) tar xvf "$file" ;;
        *.tbz2) tar xjvf "$file" ;;
        *.tgz) tar xzvf "$file" ;;
        *.zip) unzip "$file" ;;
        *.Z) uncompress "$file" ;;
        *) log_message "'$file' cannot be extracted via extract()" ;;
        esac
    else
        log_message "'$file' is not a valid file"
    fi
}

function update_junyi() {
    # update the config
    pushd $USER_CONFIG_HOME || exit
    log_message "Updating the config ..."
    git checkout .
    git pull
    log_message "Finished updating the config"
    popd || exit
}

function print_greetings() {
    if command -v fortune &>/dev/null; then
        if command -v cowsay &>/dev/null; then
            if command -v lolcat &>/dev/null; then
                # fortune | cowsay | lolcat
                cowsay -t "$(fortune)" | lolcat
            else
                cowsay -t "$(fortune)"
            fi
        else
            : # pass
        fi
    else
        echo "Hi there!"
    fi
}

function check_dependencies() {
    log_message "Checking dependencies ..."
    mkdir -p ${USER_CONFIG_HOME}/tmp
    export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
    export ZSH="${USER_CONFIG_HOME}/dep/oh-my-zsh"
    export ZSH_CUSTOM="${ZSH}/custom"
    export FZF="${USER_CONFIG_HOME}/dep/fzf"
    export ZOXIDE="${HOME}/.local/bin/zoxide"
    export NVIM="${USER_CONFIG_HOME}/bin/nvim"
    export NODEJS="${USER_CONFIG_HOME}/bin/node"
    export BATCAT="${USER_CONFIG_HOME}/bin/bat"
    export DUF="${USER_CONFIG_HOME}/bin/duf"

    if [ ! -d $ZSH ]; then
        log_message "oh-my-zsh not found, installing ..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc --unattended
        log_message "Finished installing oh-my-zsh"
    fi

    if [ ! -d $FZF ]; then
        log_message "fzf not found, installing ..."
        git clone --depth 1 https://github.com/junegunn/fzf.git ${FZF}
        ${FZF}/install --all
        log_message "Finished installing fzf"
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

    if [ ! -f $ZOXIDE ]; then
        log_message "zoxide not found, installing ..."
        curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
        # It will be install at ~/.local/bin
        log_message "Finished installing zoxide"
    fi

    if [ ! -f $NVIM ] && ! command_exists nvim; then
        # Check system type
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz -O tmp/nvim.tar.gz
            tar -xf tmp/nvim.tar.gz -C tmp/
            cp -r tmp/nvim-linux64/* ./
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            brew install neovim
        else
            log_message "🚼 nvim not found, please install it"
        fi
    fi

    if [ ! -f $NODEJS ] && ! command_exists npm; then
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            wget https://nodejs.org/dist/v22.2.0/node-v22.2.0-linux-x64.tar.xz -O tmp/node.tar.xz
            tar -xf tmp/node.tar.xz -C tmp/
            cp -r tmp/node-v22.2.0-linux-x64/* ./
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            brew install node
        else
            log_message "🚼 Node.JS not found, please install it"
        fi
    fi

    if [ ! -f $BATCAT ] && ! command_exists bat && ! command_exists batcat; then
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            wget https://github.com/sharkdp/bat/releases/download/v0.24.0/bat-v0.24.0-x86_64-unknown-linux-musl.tar.gz -O tmp/bat.tar.gz
            mkdir -p tmp/bat
            tar -xf tmp/bat.tar.gz --strip-components 1 -C ./tmp/bat/
            mv tmp/bat/bat bin/
            chmod +x bin/bat
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            brew install bat
        else
            log_message "🚼 bat not found, please install it"
        fi
    fi

    if [ ! -f $DUF ] && ! command_exists duf; then
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            wget https://github.com/muesli/duf/releases/download/v0.8.1/duf_0.8.1_linux_x86_64.tar.gz -O tmp/duf.tar.gz
            mkdir -p tmp/duf
            tar -xvf tmp/duf.tar.gz -C tmp/duf/
            mv tmp/duf/duf bin/
            chmod +x bin/duf
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            brew install duf
        else
            log_message "🚼 duf not found, please install it"
        fi
    fi
}

function clicolors() {
    i=1
    for color in {000..255}; do;
        c=$c"$FG[$color]$color✔$reset_color  ";
        if [ `expr $i % 8` -eq 0 ]; then
            c=$c"\n"
        fi
        i=`expr $i + 1`
    done;
    echo $c | sed 's/%//g' | sed 's/{//g' | sed 's/}//g' | sed '$s/..$//';
    c=''
}
