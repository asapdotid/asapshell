#!/bin/bash

alias gpg:enc='gpg_encryption'
alias gpg:dec='gpg_decryption'

# Functions
gpg_encryption() {
  local __source=$1
  local __output=$2
  if [[ -n "$__source" ]]; then
    if [[ -n "$__output" ]]; then
      gpg --output "${__output}.gpg" --symmetric --cipher-algo AES256 "$__source"
    else
      gpg --output "${__source}.gpg" --symmetric --cipher-algo AES256 "$__source"
    fi
  else
    error "Please provide source file to encrypt."
  fi
}

gpg_decryption() {
  local __source=$1
  local __output=$2
  local __passphrase=$3
  if [[ -n "$__source" && -n "$__output" && -n "$__passphrase" ]]; then
    gpg --quiet --batch --yes --decrypt --passphrase="$__passphrase" --output "$__output" "$__source"
  else
    error "Please provide source pgp file, output and passphrase."
  fi
}
