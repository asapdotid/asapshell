#!/usr/bin/env bash

# Using this Function
# for COMMAND in "awk" "sed" "grep" "tar" "gzip" "which" "openssl" "curl"; do
#     command_exists "${COMMAND}"
# done
command_exists() {
  # check if command exists and fail otherwise
  command -v "$1" >/dev/null 2>&1
  if [[ $? -ne 0 ]]; then
    error "I require $1 but it's not installed. Abort."
  fi
}

command_exist() {
  # check if command exists and fail otherwise
  command -v "$1" >/dev/null 2>&1
  if [[ $? -ne 0 ]]; then
    echo false
  else
    echo true
  fi
}
