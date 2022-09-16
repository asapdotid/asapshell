#!/bin/bash

alias ssh='TERM=xterm ssh'
alias ssh:gen='ssh_keygen'

# Function

#Generate SSH Key
function ssh_keygen() {
  if [ -z "$1" ]; then
    case $i in
    rsa) ssh-keygen -t rsa -b 4096 -C "$(hostname)-$(date +'%d-%m-%Y')" ;;
    ed) ssh-keygen -o -a 256 -t ed25519 -C "$(hostname)-$(date +'%d-%m-%Y')" ;;
    *) ;;
    esac
  fi
}

#SSH directory and files permission
function ssh_fix_permission() {
  _ssh_user="/home/$USER/.ssh"
  if [ -d "$_ssh_user" ]; then
    #Make the .ssh directory unreadable for other users and groups
    chmod 700 "$_ssh_user"
    #Make public key readble
    chmod 600 "$_ssh_user/*.pub"
    #Make the private SSH key read only
    chmod 400 "$_ssh_user/id"

  else
    info "Cannot set permission, due to .ssh directory not found."
  fi
}
