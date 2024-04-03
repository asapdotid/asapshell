#!/bin/bash

function load_environments() {
  local __DIR=$1
  if [ -f "$__DIR/.env" ]; then
    while IFS='=' read -r key temp || [ -n "$key" ]; do
      isComment='^[[:space:]]*#'
      isBlank='^[[:space:]]*$'
      [[ $key =~ $isComment ]] && continue
      [[ $key =~ $isBlank ]] && continue
      value=$(eval echo "$temp")
      eval export "$key='$value'"
    done <"$__DIR/.env"
  else
    error "No .env file found, copy .env.example to .env"
  fi
}
