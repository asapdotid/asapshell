#!/usr/bin/env bash

# ZIP
alias zip:e='extract_zip'
alias zip:c='compress_zip'
alias zip:c:a='compress_zip_all'
alias zip:e:a='extract_zip_all'

# TAR (tar.gz)
alias tar:c='compress_tar'
alias tar:e='extract_tar'

# Functions
# Zip and unzip
function extract_zip() {
  if [ -f "$1" ]; then
    unzip "$1"
  else
    echo "'$1' is not a valid file"
  fi
}

function compress_zip() {
  if [ -f "$1" ]; then
    zip -r "$1".zip "$1"
  else
    echo "'$1' is not a valid file"
  fi
}

function compress_zip_all() {
  if [ -f "$1" ]; then
    zip -r "$1".zip *
  else
    echo "'$1' is not a valid file"
  fi
}

function extract_zip_all() {
  if [ -f "$1" ]; then
    unzip -a "$1"
  else
    echo "'$1' is not a valid file"
  fi
}

function extract_tar() {
  if [ -f "$1" ]; then
    tar -xvzf "$1"
  else
    echo "'$1' is not a valid file"
  fi
}

function compress_tar() {
  if [ -f "$1" ]; then
    tar -cvzf "$1".tar.gz "$1"
  else
    echo "'$1' is not a valid file"
  fi
}
