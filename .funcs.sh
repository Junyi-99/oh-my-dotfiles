#!/bin/bash

function log_message() {
    local message="$1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $message"
}

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
    export FORTUNE_FILE="${XDG_CONFIG_HOME}/fortunes/ubuntu-server-tips"
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

    # log_message "Checking dependencies ..."
    mkdir -p "${USER_CONFIG_HOME}/tmp" >/dev/null
    
    export NVIM="${USER_CONFIG_HOME}/bin/nvim"
    export NODEJS="${USER_CONFIG_HOME}/bin/node"

    if [ ! -f $NVIM ] && ! command_exists nvim; then
        # Check system type
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz -O ${USER_CONFIG_HOME}/tmp/nvim.tar.gz
            tar -xf ${USER_CONFIG_HOME}/tmp/nvim.tar.gz -C ${USER_CONFIG_HOME}/tmp
            cp -r ${USER_CONFIG_HOME}/tmp/nvim-linux-x86_64/* ${USER_CONFIG_HOME}
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            brew install neovim
        else
            log_message "🚼 nvim not found, please install it"
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
