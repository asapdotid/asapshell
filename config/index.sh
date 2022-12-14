#!/bin/bash

__UCONFIG="$ASAPSHELL_DIR/config/config.sh"
__UTILFILES=($__UCONFIG)

for i in "${__UTILFILES[@]}"; do
  if [ -f "$i" ]; then
    source "$i"
  else
    error "$i does not exist."
  fi
done
