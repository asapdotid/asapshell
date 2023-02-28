#!/bin/bash

# Test service
# serviceName=docker

# if { systemctl --all --type service || service --status-all; } 2>/dev/null |
#   grep -q "$serviceName.service"; then
#   echo "$serviceName exists."
# else
#   echo "$serviceName does NOT exist."
# fi

# echo "Exit command test"
# exit 0

while true; do
  read -p "Are you sure (Yy/Nn)? " yn
  case $yn in
  [Yy]*)
    echo "helo"
    echo "test"
    break
    ;;
  [Nn]*) exit ;;
  *) echo "Please answer yes or no." ;;
  esac
done
