#!/bin/bash

# Config
# shellcheck source=/dev/null

function load_config() {
  local __SOURCE_DIR=$1
  if [ -d "$__SOURCE_DIR" ]; then
    local __CONFIGFILES=(
      "$__SOURCE_DIR/config/environment.sh"
      "$__SOURCE_DIR/config/welcome.sh"
    )

    for i in "${__CONFIGFILES[@]}"; do
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
