#!/bin/bash

__HLOG="$ASAPSHELL_DIR/helpers/loging.sh"
__HCOMMAND="$ASAPSHELL_DIR/helpers/command.sh"
__HOPERATORS="$ASAPSHELL_DIR/helpers/operators.sh"
__HELPERFILES=($__HLOG $__HCOMMAND $__HOPERATORS)

for i in "${__HELPERFILES[@]}"; do
  if [ -f "$i" ]; then
    source "$i"
  else
    error "$i does not exist."
  fi
done
