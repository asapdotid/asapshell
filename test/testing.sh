#!/bin/bash

# Initial environment
# export ASAPSHELL_DIR="${ASAPSHELL_DIR:-$(asapshell_default_install_dir)}"

# Helpers
# source "$ASAPSHELL_DIR/helpers/index.sh"

# Test service
# serviceName=docker

# if { systemctl --all --type service || service --status-all; } 2>/dev/null |
#   grep -q "$serviceName.service"; then
#   echo "$serviceName exists."
# else
#   echo "$serviceName does NOT exist."
# fi

# expr substr $(uname -s) 1 5
# x=$(uname -s)
# version="${x#####*}"
# echo "$version"

function helper_string_array() {
  local files=$1
  local arrayString="${files[*]}"
  # Convert string to array
  read -ra arr <<<"$arrayString"
  # Access array elements using ${arr[@]} syntax
  for element in "${arr[@]}"; do
    echo "$element"
  done
}

loop_custom_delimited() {
  for v in $(tr ',' '\n' <<<"$1"); do echo "$v"; done
}

#the string
echo "Add files"
read -r r_files

loop_custom_delimited "$r_files"
