#!/bin/bash

__DARWINFILES=(
  "$_SOURCE_FILE/darwin/aliases/system.sh"
)

for i in "${__DARWINFILES[@]}"; do
  if [ -f "$i" ]; then
    # shellcheck source=/dev/null
    source "$i"
  else
    error "$i does not exist."
  fi
done
