#!/bin/bash

__UTILFILES=(
  "$ASAPSHELL_DIR/config/config.sh"
)

for i in "${__UTILFILES[@]}"; do
  if [ -f "$i" ]; then
    # shellcheck source=/dev/null
    source "$i"
  else
    error "$i does not exist."
  fi
done
