function fast_current_directory {
  cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd
}

_CUR_FAST_CMDS_DIR_PATH="$(fast_current_directory)/.."

source "$_CUR_FAST_CMDS_DIR_PATH/cmds/index.sh"
load_fast_commands_all "$_CUR_FAST_CMDS_DIR_PATH"
