#!/bin/bash

alias test:cors='test_cors'
alias test:cors:v='test_cors --verbose'

# Functions
usage() {
  info "usage: [-v] $0 url"
  info "  -v | --verbose: show curl result"
}

test_cors() {
  local url=$1
  local verbose=$2
  if [[ -z "$url" ]]; then
    usage
  else
    # Commandline option
    while [ "$1" != "" ]; do
      url=$1
      shift

      # Optionally show usage
      case $url in
      -v | --verbose)
        verbose=true
        ;;
      esac
    done

    if [ "$verbose" = "true" ]; then
      curl -s -X GET "$url" -H 'Cache-Control: no-cache' --head
    fi
    origin=$(curl -s -X GET "$url" -H 'Cache-Control: no-cache' --head | grep -i access-control)

    if [ -n "$origin" ]; then
      info "$url $origin"
    else
      error "$url does not support CORS"
      info_blue "You might want to visit https://enable-cors.org/ to find out how to enable CORS"
    fi
  fi
}
