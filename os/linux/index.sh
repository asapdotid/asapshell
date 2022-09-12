#!/bin/bash

__LSYSTEM="$ASAPSHELL_DIR/os/linux/aliases/system.sh"
__LINUXFILES=($__LSYSTEM)

for i in "${__LINUXFILES[@]}"; do
  if [ -f "$i" ]; then
    source "$i"
  else
    error "$i does not exist."
  fi
done
