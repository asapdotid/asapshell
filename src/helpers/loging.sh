#!/bin/bash

log() {
  echo -e "${NAMI_DEBUG:+${CYAN}${MODULE} ${MAGENTA}$(date "+%T.%2N ")}${RESET}${*}" >&2
}

info() {
  log "${GREEN}INFO ${RESET} ==> ${*}"
}

info_blue() {
  log "${BLUE}INFO ${RESET} ==> ${*}"
}

warn() {
  log "${YELLOW}WARN ${RESET} ==> ${*}"
}

error() {
  log "${RED}ERROR${RESET} ==> ${*}"
}

input() {
  echo -n "${GREEN}=>${RESET}${YELLOW} $1${RESET}${RED}:${RESET} "
}
