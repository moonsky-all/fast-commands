function load_fast_commands_all {
  local _CURR_FAST_COMMANDS_PATH=$1
  source "$_CURR_FAST_COMMANDS_PATH/cmds/fast-git.sh"
  source "$_CURR_FAST_COMMANDS_PATH/cmds/fast-directory.sh"
  source "$_CURR_FAST_COMMANDS_PATH/cmds/fast-pnpm.sh"
}
