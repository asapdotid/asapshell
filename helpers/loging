#!/bin/bash

log() {
  echo -e "${NAMI_DEBUG:+${CYAN}${MODULE} ${MAGENTA}$(date "+%T.%2N ")}${RESET}${@}" >&2
}

info() {
  log "${GREEN}INFO ${RESET} ==> ${@}"
}

warn() {
  log "${YELLOW}WARN ${RESET} ==> ${@}"
}

error() {
  log "${RED}ERROR${RESET} ==> ${@}"
}

input() {
  echo -n "${GREEN}=>${RESET}${YELLOW} $1${RESET}${RED}:${RESET} "
}

print_welcome_page() {
  if [[ "$WELCOME_MESSAGE" = true ]]; then
    if [ -n "$APP_NAME" ]; then
      print_image_welcome_page
    fi
  fi
}

# Prints the welcome page for this Bitnami Docker image
print_image_welcome_page() {
  log ""
  log "${BOLD}${RED}|>|>|>${RESET} ${GREEN}Welcome to the ${BOLD}${GREEN}${APP_NAME}${RESET}${GREEN} aliases command utility${RESET} ${BOLD}${RED}<|<|<|${RESET}"
  log ""
}

print_welcome_page
