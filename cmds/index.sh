function load_fast_commands_all {
  local _CURR_FAST_COMMANDS_PATH=$1
  source "$_CURR_FAST_COMMANDS_PATH/cmds/fast-logging.sh"
  source "$_CURR_FAST_COMMANDS_PATH/cmds/aliases.sh"
  source "$_CURR_FAST_COMMANDS_PATH/fns/string.sh"
  source "$_CURR_FAST_COMMANDS_PATH/cmds/version.sh"
  source "$_CURR_FAST_COMMANDS_PATH/cmds/fast-git.sh"
  source "$_CURR_FAST_COMMANDS_PATH/cmds/fast-directory.sh"
  source "$_CURR_FAST_COMMANDS_PATH/cmds/fast-pnpm.sh"
  source "$_CURR_FAST_COMMANDS_PATH/cmds/fast-npm.sh"
  source "$_CURR_FAST_COMMANDS_PATH/cmds/fast-yarn.sh"
  source "$_CURR_FAST_COMMANDS_PATH/cmds/fast-maven.sh"
  source "$_CURR_FAST_COMMANDS_PATH/cmds/fast-rust.sh"
  source "$_CURR_FAST_COMMANDS_PATH/cmds/fast-gradle.sh"
  source "$_CURR_FAST_COMMANDS_PATH/cmds/fast-ohpm.sh"
  source "$_CURR_FAST_COMMANDS_PATH/cmds/fast-gh.sh"
}
