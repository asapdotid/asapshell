#!/bin/bash

alias gpg:enc='gpg --symmetric --cipher-algo AES256'
alias gpg:dec='gpg_decryption'

# Function
function gpg_decryption() {
  local __output=$2
  local __source=$1
  gpg --quiet --batch --yes --decrypt --passphrase="$LARGE_SECRET_PASSPHRASE" --output "$__output" "$__source"
}
