
function fast-run {
  COMMAND=$1
  echo "Run: $COMMAND"
  echo "------------------------------------"
  eval "$COMMAND"
  echo ""
}
