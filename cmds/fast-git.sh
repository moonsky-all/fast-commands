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
function fre() {
    local MERGE_COUNT=$1

    if [ -z "$MERGE_COUNT" ]; then
        MERGE_COUNT=3
    fi

    fast-run "git rebase -i HEAD~$MERGE_COUNT"
}


#
# 快速提交本地修改并推送至远端仓库
function fast() {
    fcm "$1"
    git push
}


#
# git 临时存储区域命令
#
# fst 等价于 git stash save, 或 git stash --all
# tsf 等价于 git stash pop
# fst ls 等价于 git stash list
# fst ll 等价于 git stash list
function git_stash_commands {
    local CMD=$1

    if [ -z "$CMD" ]; then
        CMD="--all"
    fi

    if [ "$CMD" = "ls" ]; then
        CMD="list"
    fi

    if [ "$CMD" = "ll" ]; then
        CMD="list"
    fi

    fast_run "git stash $CMD"
}

alias fst="git_stash_commands"
alias tsf="git stash pop"
