#!/bin/bash

alias gpg:enc='gpg --symmetric --cipher-algo AES256'
alias gpg:dec='gpg_decryption'

# Function
function gpg_decryption() {
  local __source=$1
  local __output=$2
  local __passphrase=$3
  if [[ -n "$__source" && -n "$__output" && -n "$__passphrase" ]]; then
    gpg --quiet --batch --yes --decrypt --passphrase="$__passphrase" --output "$__output" "$__source"
  else
    error "Please provide source pgp file, output and passphrase."
  fi
}
