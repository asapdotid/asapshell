#!/usr/bin/env bash

# Check package manager
# if helper_havePackage apt-get; then
#   sudo apt-get install git
# fi
function helper_os_package() {
  [ -x "$(which $1)" ]
}

# Using this Function
# for COMMAND in "awk" "sed" "grep" "tar" "gzip" "which" "openssl" "curl"; do
#     command_exists "${COMMAND}"
# done
function helper_command_exists() {
  # check if command exists and fail otherwise
  command -v "$1" >/dev/null 2>&1
  if [[ $? -ne 0 ]]; then
    error "I require $1 but it's not installed. Abort."
  fi
}

function helper_command_exist() {
  # check if command exists and fail otherwise
  command -v "$1" >/dev/null 2>&1
  if [[ $? -ne 0 ]]; then
    echo false
  else
    echo true
  fi
}
