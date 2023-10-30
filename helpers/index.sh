#!/bin/bash

__HELPERFILES=(
  "$ASAPSHELL_DIR/helpers/loging.sh"
  "$ASAPSHELL_DIR/helpers/command.sh"
  "$ASAPSHELL_DIR/helpers/operators.sh"
  "$ASAPSHELL_DIR/helpers/utility.sh"
)

for i in "${__HELPERFILES[@]}"; do
  if [ -f "$i" ]; then
    # shellcheck source=/dev/null
    source "$i"
  else
    error "$i does not exist."
  fi
done
