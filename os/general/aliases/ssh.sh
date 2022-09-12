#!/bin/bash

alias ssh:gen='ssh_keygen'

function ssh_keygen() {
  if [ -z "$1" ]; then
    case $i in
    rsa) ssh-keygen -t rsa -b 4096 -C "$(hostname)-$(date +'%d-%m-%Y')" ;;
    ed) ssh-keygen -o -a 256 -t ed25519 -C "$(hostname)-$(date +'%d-%m-%Y')" ;;
    *) ;;
    esac
  fi
}
