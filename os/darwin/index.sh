#!/bin/bash

__DARWINFILES=(
  "$ASAPSHELL_DIR/os/darwin/aliases/system.sh"
)

for i in "${__DARWINFILES[@]}"; do
  if [ -f "$i" ]; then
    source "$i"
  else
    error "$i does not exist."
  fi
done
