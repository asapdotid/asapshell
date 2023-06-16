#!/bin/bash

__UTILFILES=(
  "$ASAPSHELL_DIR/config/config.sh"
)

for i in "${__UTILFILES[@]}"; do
  if [ -f "$i" ]; then
    source "$i"
  else
    error "$i does not exist."
  fi
done
