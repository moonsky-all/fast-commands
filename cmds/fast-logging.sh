#
# 命令行输出日志
# $1 输出级别，默认 INFO
# $2 日志内容，(当存在 $3 时, 表示输出标签)
# $3 日志内容 (可选)
#
function __echo_logging_message() {
    local TYPE='INFO';

    if [[ $1 = 'warn' || $1 = 'warning' ]]; then
        TYPE="WARN";
    elif [[ $1 = 'success' ]]; then
        TYPE="SUCCESS";
    elif [[ $1 = 'danger' || $1 = 'error' ]]; then
        TYPE="ERROR";
    elif [[ $1 = 'fail' || $1 = 'failure' ]]; then
        TYPE="FAIL";
    elif [[ $1 = 'log' || $1 = 'debug' ]]; then
        TYPE="LOG";
    fi

    local TAG="$TYPE";
    local MSG="$2"
    if [ $# -gt 2 ]; then
        TAG="$2";
        MSG="$3";
    elif [ $# -lt 2 ]; then
        MSG="$1"
    fi

    if [[ $TYPE = "INFO" ]]; then
        echo "\033[1;44;37m[$TAG]\033[0m $MSG";
    elif [[ $TYPE = 'SUCCESS' ]]; then
        echo "\033[1;42;30m[$TAG]\033[0m $MSG";
    elif [[ $TYPE = 'WARN' ]]; then
        echo "\033[1;43;30m[$TAG]\033[0m $MSG";
    elif [[ $TYPE = 'ERROR' || $TYPE = 'FAIL' ]]; then
        echo "\033[1;41;37m[$TAG]\033[0m $MSG";
    else
        echo "[$TAG] $MSG";
    fi
}

alias echo_log="__echo_logging_message log"
alias echo_info="__echo_logging_message info"
alias echo_warn="__echo_logging_message warn"
alias echo_err="__echo_logging_message error"
alias echo_error="__echo_logging_message error"
alias echo_fail="__echo_logging_message fail"
alias echo_success="__echo_logging_message success"