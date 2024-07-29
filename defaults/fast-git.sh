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
# 创建并切换到指定分支
#
# 如:
# fbc feature/user-module 基于当前分支创建分支 'feature/user-module', 然后切换到新分支
#
function fbc() {
  local BRANCH_NAME=$1

  if [ -z "$BRANCH_NAME" ]; then
    echo "Unknown new branch name, please use: fbc <new-branch-name>"
    return
  fi

  eval "git branch $BRANCH_NAME"
  eval "git checkout $BRANCH_NAME"
}

alias gbc='fbc'
# omz 移除了 gup, 改为 gpr, 但 gup 用习惯了

function __do_git_pull_rebase_repo() {
  eval "cd $1"

  GS="$(git status)"
  if [[ "$GS" =~ "Changes to be committed:" || "$GS" =~ "Changes not staged for commit:" ]]; then
    echo_warn "-------------------------------------------------------------------------------------------------------"
    echo_warn "CWD: $1"
    git status
  else
    echo_info "-------------------------------------------------------------------------------------------------------"
    echo_info "CWD: $1"
    git pull --rebase
  fi
}

function __do_git_pull_rebase_depth() {
  if [ -d "$1/.git" ]; then
    __do_git_pull_rebase_repo "$1"
  elif [ -f "$1" ]; then
    echo_warn "Target '$1' is not a directory."
  elif [ -d "$1" ]; then
    if [[ "$(ls "$1")" = "" ]]; then
      echo_warn "Target '$1' is an empty directory."
    else
      for name in $1/*; do
        __do_git_pull_rebase_depth "$name"
      done
    fi
  fi
}

#
# TODO: 这个命令 cwd 会停在最后一个拉取的目录，而不是命令开始的目录
#
function fup() {
  local PWD="$(pwd)"
  if [[ "$1" = "-d" || "$1" = '-deep' || "$1" = '-depth' || "$1" = '--deep' || "$1" = '--depth' ]]; then
    __do_git_pull_rebase_depth "$PWD"
    echo_success "$PWD"
    eval "cd $PWD"
  elif [ -d "$PWD/.git" ]; then
    __do_git_pull_rebase_repo "$PWD"
    echo_success "$PWD"
    eval "cd $PWD"
  else
    echo_warn "'$PWD' not a git repository"
  fi
}

#
# 创建 git tag 标签，可以自定义 tag 信息或生成默认信息
#
# gtg v1.0.0 创建本地标签并使用默认标签信息
# gtg v1.1.0 "Release: v1.0.0" 创建本地标签并使用自定义标签信息
#
function gtg() {
  local TAG_NAME=$1
  local TAG_MESSAGE=$2

  if [ $# -lt 2 ]; then
    local DATETIME=$(date +%Y-%m-%d%p%H:%M:%S)
    TAG_MESSAGE="[Release] <$TAG_NAME> at '$DATETIME'"
    echo_info Auto "use tag message with: \`$TAG_MESSAGE\`."
    echo_log "You can custom tag message of: ftag <tag_name> <tag_message>"
  fi

  eval "git tag $TAG_NAME -m '$TAG_MESSAGE'"
}

#
# 创建 git tag 标签，同时将该标签推送至远程仓库，可以自定义 tag 信息或生成默认信息
#
# ftg v1.0.0 使用默认标签信息创建标签并推送至默认远程仓库
# ftg v1.1.0 "Release: v1.0.0" 使用自定义标签信息创建标签并推送至默认远程仓库
# ftg origin v1.1.1 "Release: v1.1.1" 使用自定义标签信息创建标签并推送至指定远程仓库
# ftg origin v1.1.2 . 使用默认标签信息创建标签并推送至指定远程仓库
#
function ftg() {
  local ORIGIN='origin'
  local TAG_NAME=$1
  local TAG_MESSAGE=$2

  if [ $# -gt 2 ]; then
    ORIGIN=$1
    TAG_NAME=$2

    if [ "$3" = "." ]; then
      local DATETIME=$(date +%Y-%m-%d%p%H:%M:%S)
      TAG_MESSAGE="[Release] <$TAG_NAME> at '$DATETIME'"
      echo_info Auto "use tag message with: \`$TAG_MESSAGE\`."
      echo_log "You can custom tag message of: ftag <tag_name> <tag_message>"
    else
      TAG_MESSAGE=$3
    fi
  elif [ $# -lt 2 ]; then
    local DATETIME=$(date +%Y-%m-%d%p%H:%M:%S)
    TAG_MESSAGE="[Release] <$TAG_NAME> at '$DATETIME'"
    echo_info Auto "use tag message with: \`$TAG_MESSAGE\`."
    echo_log "You can custom tag message of: ftag <tag_name> <tag_message>"
  fi

  eval "git tag $TAG_NAME -m '$TAG_MESSAGE'"
  echo ""
  eval "git push $ORIGIN $TAG_NAME"
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
    CMD="save"
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
