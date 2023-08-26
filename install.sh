#!/bin/bash

FAST_CMDS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "source $FAST_CMDS_DIR/cmds/index_bash.sh" >> ~/.bashrc
echo "source $FAST_CMDS_DIR/cmds/index_zsh.sh" >> ~/.zshrc

echo "$FAST_CMDS_DIR"
echo "Install done. (Updated ~/.bashrc, ~/.zshrc)"
