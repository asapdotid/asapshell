#!/bin/bash

__LINUXFILES=(
  "$ASAPSHELL_DIR/os/linux/aliases/system.sh"
  "$ASAPSHELL_DIR/os/linux/aliases/package.sh"
  "$ASAPSHELL_DIR/os/linux/aliases/service.sh"
  "$ASAPSHELL_DIR/os/linux/aliases/vpn.sh"
)

for i in "${__LINUXFILES[@]}"; do
  if [ -f "$i" ]; then
    source "$i"
  else
    error "$i does not exist."
  fi
done
