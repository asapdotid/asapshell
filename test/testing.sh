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

read -p "Continue (y/n)?" choice
case "$choice" in
y | Y)
  echo "yes"
  echo "ok"
  ;;
n | N)
  echo "no"
  echo "not"
  ;;
*) echo "invalid" ;;
esac
