alias dir="open ."

# 从当前目录开始递归删除匹配名称的目录/文件
# 如:
# 递归删除 node_modules 目录, 这对前端开发比较有用, 尤其是 monorepo 多子项目管理时
# dirrm node_modules
# dirrm dist
function fast_cmd_rm_fr_dir {
  local NAME=$1
  local CURRENT_DIR=$2

  if [ -z "$NAME" ]; then
      return
  fi

  if [ -z "$CURRENT_DIR" ]; then
      CURRENT_DIR="$(pwd)"
      echo "CWD: $CURRENT_DIR"
  fi

  local TARGET="$CURRENT_DIR/$NAME"

  for ITEM_NAME in $CURRENT_DIR/*
  do

    if [ -d "$ITEM_NAME" ]; then

      if [ "$TARGET" = "$ITEM_NAME" ]; then
        eval "rm -fr $TARGET"
        echo "[DELETED] $TARGET"
      else
        eval "fast_cmd_rm_fr_dir $NAME $ITEM_NAME"
      fi

    fi

  done
}

alias dirrm='fast_cmd_rm_fr_dir'
alias distrm='fast_cmd_rm_fr_dir dist'
alias noderm='fast_cmd_rm_fr_dir node_modules'
alias nodeclear='fast_cmd_rm_fr_dir node_modules'
alias nodeclean='fast_cmd_rm_fr_dir node_modules'
