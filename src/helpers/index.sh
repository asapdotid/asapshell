#!/usr/bin/env bash

function load_helpers() {
  local __SOURCE_DIR=$1
    if [ -d "$__SOURCE_DIR" ]; then
      local __HELPERFILES=(
        "$__SOURCE_DIR/helpers/loging.sh"
        "$__SOURCE_DIR/helpers/command.sh"
        "$__SOURCE_DIR/helpers/operators.sh"
        "$__SOURCE_DIR/helpers/utility.sh"
      )

      for i in "${__HELPERFILES[@]}"; do
        if [ -f "$i" ]; then
          # shellcheck source=/dev/null
          source "$i"
        else
          error "$i does not exist."
        fi
      done
    else
      error "$__SOURCE_DIR does not exist."
      return 1
    fi
}
