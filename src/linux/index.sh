#!/bin/bash

__LINUXFILES=(
  "$_SOURCE_FILE/linux/aliases/system.sh"
  "$_SOURCE_FILE/linux/aliases/package.sh"
  "$_SOURCE_FILE/linux/aliases/service.sh"
  "$_SOURCE_FILE/linux/aliases/vpn.sh"
  "$_SOURCE_FILE/linux/aliases/custom.sh"
)

for i in "${__LINUXFILES[@]}"; do
  if [ -f "$i" ]; then
    # shellcheck source=/dev/null
    source "$i"
  else
    error "$i does not exist."
  fi
done
