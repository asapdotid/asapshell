#!/usr/bin/env bash

function darwin_aliases() {
  local __SOURCE_DIR=$1
  if [ -d "$__SOURCE_DIR" ]; then
    local __DARWINFILES=(
      "$__SOURCE_DIR/darwin/aliases/system.sh"
    )

    for i in "${__DARWINFILES[@]}"; do
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
