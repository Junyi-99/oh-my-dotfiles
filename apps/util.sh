# 通用函数：检查命令是否存在
function command_exists() {
    command -v "$1" &>/dev/null
}