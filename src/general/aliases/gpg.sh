#!/bin/bash

# GPG
alias gpg:gen='gpg --full-gen-key'
alias gpg:ls='--list-keys'
alias gpg:s:ls='gpg --list-secret-keys --keyid-format LONG'
alias gpg:p:e='gpg_public_key_export'
alias gpg:en='gpg_encryption'
alias gpg:de='gpg_decryption'
# verify signature for isos
alias gpg:k:ch="gpg2 --keyserver-options auto-key-retrieve --verify"
# receive the key of a developer
alias gpg:k:re="gpg2 --keyserver-options auto-key-retrieve --receive-keys"

# Functions
gpg_public_key_export() {
  local __key_id=$1
  local __output=$2
  if [ -n "$__key_id" ] && [ -n "$__output" ]; then
    gpg --export --armor --output "${__output}.asc" "$__key_id"
  else
    error "Please provide key id and output destination."
  fi
}
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
  if [[ -n "$__source" && -n "$__output" ]]; then
    gpg --output "$__output" --decrypt "$__source"
  else
    error "Please provide source pgp file, output and passphrase."
  fi
}
