#!/usr/bin/env bash

# Check package manager
# if helper_havePackage apt-get; then
#   sudo apt-get install git
# fi
function helper_os_package() {
  [ -x "$(command -v "$1")" ]
}

# Using this Function
# for COMMAND in "awk" "sed" "grep" "tar" "gzip" "which" "openssl" "curl"; do
#     command_exists "${COMMAND}"
# done
function helper_command_exists() {
  # check if command exists and fail otherwise
  if ! command -v "$1" >/dev/null 2>&1; then
    error "I require $1 but it's not installed. Abort."
  fi
}

function helper_command_exist() {
  # check if command exists and fail otherwise
  if ! command -v "$1" >/dev/null 2>&1; then
    echo false
  else
    echo true
  fi
}

# Check application exist
command_exists() {
  if [[ -n "$1" ]]; then
    type -p "$1" &>/dev/null
  fi
}
