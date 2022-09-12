#!/bin/bash

__GEXA="$ASAPSHELL_DIR/os/general/aliases/exa.sh"
__GPATH="$ASAPSHELL_DIR/os/general/aliases/path.sh"
__GSYSTEM="$ASAPSHELL_DIR/os/general/aliases/system.sh"
__GENERALFILES=($__GEXA $__GPATH $__GSYSTEM)

for i in "${__GENERALFILES[@]}"; do
  if [ -f "$i" ]; then
    source "$i"
  else
    error "$i does not exist."
  fi
done
