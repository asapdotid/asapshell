#!/bin/bash

# Load welcome message
function print_welcome_message() {
  local __WELCOME_MESSAGE=${1:-true}
  local __APP_NAME=${2:-"ASAPSHELL"}
  if [ "$__WELCOME_MESSAGE" = true ] && [ -n "$__APP_NAME" ]; then
    print_image_welcome_page "$__APP_NAME"
  fi
}

# Prints the welcome page for this Bitnami Docker image
# TODO Update welcome message
function print_image_welcome_page() {
  local __APP_NAME=$1
  log ""
  log "${BOLD}${RED}|>|>|>${RESET} ${GREEN}Welcome to the ${BOLD}${GREEN}${__APP_NAME}${RESET}${GREEN} aliases command utility${RESET} ${BOLD}${RED}<|<|<|${RESET}"
  log ""
}
