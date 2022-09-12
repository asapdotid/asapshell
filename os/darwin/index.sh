#!/bin/bash

__DSYSTEM="$ASAPSHELL_DIR/os/darwin/aliases/system.sh"
__DARWINFILES=($__DSYSTEM)

for i in "${__DARWINFILES[@]}"; do
  if [ -f "$i" ]; then
    source "$i"
  else
    error "$i does not exist."
  fi
done
