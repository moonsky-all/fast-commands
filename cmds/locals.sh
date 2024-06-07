function __load_local_commands {
  for name in $1/*; do
    if [ -f "$name" ]; then
      source "$name"
    elif [ -d "$name" ]; then
      __load_local_commands "$name"
    fi
  done
}

__load_local_commands "$1/local"

echo_info "Locale shells load successfully!"


