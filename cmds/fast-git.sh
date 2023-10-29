#
# 快速提交本地修改
# 等价于 git add . && git commit -am <Auto or custom message>
#
# 如:
# fcm
# fcm "refactor: 重构项目结构"
function fcm() {
    local MESSAGE=$1

    if [ -z "$MESSAGE" ]; then
        DATETIME=$(date +%Y-%m-%d%p%H:%M:%S)
        MESSAGE="[Auto] $DATETIME"
    fi

    git add .
    git commit -am "$MESSAGE"
}

#
# 修改最近一次的提交信息
# 如:
# fcm "refactor: 重构项目结构"
alias fcmm='git commit --amend'

#
# 合并最近 N 次 git commit
# 默认合并最近 3 次
# 具体参考 git rebase 用法
#
# 如:
# fre
# fre 3
# fre <Commit ID>
function fre() {
    if [ -z "$1" ]; then
        eval "git rebase -i HEAD~3"
    elif [[ "$1" =~ ^[0-9]{1,3}$ ]]; then
        if [[ $1 -gt 1 ]]; then
            eval "git rebase -i HEAD~$1"
        else
            eval "git rebase -i HEAD~3"
        fi
    else
        eval "git rebase -i $1"
    fi
}


#
# 快速提交本地修改并推送至远端仓库
# e.g,
# fast # git add . && git commit -m $1 && git push
# fast -f
# fast --force
function fast() {
    local MSG=$1
    local FORCE=0

    if [[ $MSG = '-f' || $MSG = '--force' ]]; then
        FORCE=1
        MSG=$2
    elif [[ $2 = '-f' || $2 = '--force' ]]; then
        FORCE=1
    fi

    fcm "$MSG"
    if [ $FORCE -eq 1 ]; then
        git push --force
    else
        git push
    fi
}


#
# git 临时存储区域命令
#
# fst 等价于 git stash save, 或 git stash --all
# tsf 等价于 git stash pop, 应用并删除最近一次暂存区内容
# fst ls 等价于 git stash list, 列表显示所有暂存区内容
# fst ll 等价于 git stash list, 列表显示所有暂存区内容
# fst clear 等价于 git stash clear, 清空所有暂存区内容
function __git_stash_commands {
    local CMD=$1
    local TYPE=0

    if [ -z "$CMD" ]; then
        CMD="--all"
        TYPE=1
    fi

    if [ "$CMD" = "ls" ]; then
        CMD="list"
        TYPE=1
    fi

    if [ "$CMD" = "ll" ]; then
        CMD="list"
        TYPE=1
    fi

    if [ $TYPE -eq 0 ]; then
        eval "git stash save $CMD"
    else
        eval "git stash $CMD"
    fi
}

alias fst="__git_stash_commands"
alias tsf="git stash pop"
