#!/bin/bash

__LSYSTEM="$ASAPSHELL_DIR/os/linux/aliases/system.sh"
__LPACKAGE="$ASAPSHELL_DIR/os/linux/aliases/package.sh"
__LSERVICE="$ASAPSHELL_DIR/os/linux/aliases/service.sh"
__LVPN="$ASAPSHELL_DIR/os/linux/aliases/vpn.sh"
__LINUXFILES=($__LSYSTEM $__LPACKAGE $__LSERVICE $__LVPN)

for i in "${__LINUXFILES[@]}"; do
  if [ -f "$i" ]; then
    source "$i"
  else
    error "$i does not exist."
  fi
done
