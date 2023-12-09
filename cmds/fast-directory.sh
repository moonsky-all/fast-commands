alias dir="open ."

# 从当前目录开始递归删除匹配名称的目录/文件
# 如:
# 递归删除 node_modules 目录, 这对前端开发比较有用, 尤其是 monorepo 多子项目管理时
# dirrm node_modules
# dirrm dist
#
# 参数 --root 或 -r 表示仅删除当前根目录的匹配目录
# dirrm --root dist
function fast_deep_rm_dir_name_of {
  local ROOT_ONLY=0
  if [[ $1 = "--root" || $1 = "-r" ]]; then
      ROOT_ONLY=1
  fi

  local NAME=$1
  local CURRENT_DIR=$2

  if [ $ROOT_ONLY -eq 1 ]; then
      NAME=$2
      CURRENT_DIR=$3
  fi

  if [ -z "$NAME" ]; then
      return
  elif [ "${NAME:0:1}" = "/" ]; then
      echo "NAME: ${NAME:0:1}, $NAME"
      local COUNT=$((${#NAME} - 1))
      NAME=${NAME#/}
  fi

  if [ -z "$CURRENT_DIR" ]; then
      CURRENT_DIR="$(pwd)"
      echo "CWD: $CURRENT_DIR"
  fi

  local TARGET="$CURRENT_DIR/$NAME"

  for ITEM_NAME in "$CURRENT_DIR"/*
  do

    if [ -d "$ITEM_NAME" ]; then

      if [ "$TARGET" = "$ITEM_NAME" ]; then
        eval "rm -fr $TARGET"
        echo "\e[1;42m[DELETED]\e[0m $TARGET"
      elif [ $ROOT_ONLY -eq 0 ]; then
        eval "fast_deep_rm_dir_name_of $NAME $ITEM_NAME"
      fi

    fi

  done
}

alias dirrm='fast_deep_rm_dir_name_of'
alias distrm='fast_deep_rm_dir_name_of dist'
alias noderm='fast_deep_rm_dir_name_of node_modules'
alias nodeclear='fast_deep_rm_dir_name_of node_modules'
alias nodeclean='fast_deep_rm_dir_name_of node_modules'

alias cdw='cd ~/Workspaces'
alias cw='cd ~/Workspaces'
alias ww='cd ~/Workspaces'
alias cm='cd ~/Workspaces/moon'
alias mm='cd ~/Workspaces/moon'
