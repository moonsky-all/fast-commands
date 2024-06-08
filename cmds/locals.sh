#
# 递归遍历并加载指定目录所有 .sh 脚本（自动忽略隐藏文件）
#
function __load_local_commands {
  local MISSING="Locale shells load successfully! (No local scripts.)"

  if [ -d "$1" ]; then
    if [ -z "$(ls -A "$1")" ]; then
      echo_info "$MISSING"
      return;
    fi

    for name in $1/*; do
      if [ -f "$name" ]; then
        if [[ "$name" =~ \.sh$ ]]; then
          source "$name"
        else
          echo "Not script: $name"
        fi
      elif [ -d "$name" ]; then
        __load_local_commands "$name"
      fi
    done

    echo_info "Locale shells load successfully!"
  else
    echo_info "$MISSING"
  fi
}

__load_local_commands "$1/local"


