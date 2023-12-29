function load_fast_commands_all {
  source "$1/cmds/fast-logging.sh"

  source "$1/cmds/aliases.sh"
  source "$1/fns/string.sh"
  source "$1/cmds/version.sh"
  source "$1/cmds/fast-git.sh"
  source "$1/cmds/fast-directory.sh"
  source "$1/cmds/fast-pnpm.sh"
  source "$1/cmds/fast-npm.sh"
  source "$1/cmds/fast-yarn.sh"
  source "$1/cmds/fast-maven.sh"
  source "$1/cmds/fast-rust.sh"
  source "$1/cmds/fast-gradle.sh"
  source "$1/cmds/fast-ohpm.sh"
  source "$1/cmds/fast-gh.sh"

  local LOCALE_INDEX="$1/local/index.sh"
  if [ -f "$LOCALE_INDEX" ]; then
      source "$LOCALE_INDEX";
  fi
}
