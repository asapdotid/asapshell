#!/bin/bash

function linux_aliases() {
  local __SOURCE_DIR=$1
  if [ -d "$__SOURCE_DIR" ]; then
    local __LINUXFILES=(
      "$__SOURCE_DIR/linux/aliases/system.sh"
      "$__SOURCE_DIR/linux/aliases/package.sh"
      "$__SOURCE_DIR/linux/aliases/service.sh"
      "$__SOURCE_DIR/linux/aliases/vpn.sh"
      "$__SOURCE_DIR/linux/aliases/custom.sh"
    )

    for i in "${__LINUXFILES[@]}"; do
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
