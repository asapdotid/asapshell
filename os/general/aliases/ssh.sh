#!/bin/bash

alias ssh='TERM=xterm ssh'
alias ssh:-v='ssh -V'
alias ssh:gen='ssh_generate_keys'
alias ssh:permission='ssh_fix_permission'

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
  local _ssh_user="/home/$USER/.ssh"
  if [ -d "$_ssh_user" ]; then
    #Make the .ssh directory unreadable for other users and groups
    chmod 700 "$_ssh_user"
    #Make the private SSH key read only
    chmod 400 "$_ssh_user/{config,id_rsa,id_ed25519}"
    #Make public key readable
    chmod 600 "$_ssh_user/{*.pub,authorized_key,known_hosts}"
    info "Set SSH directory and files permission, done."
  else
    info "Cannot set permission, due to .ssh directory not found."
  fi
}

#SSH generate keys
function ssh_generate_keys() {
  PS3='Generate the SSH keys: '
  ssh_type_keys=("RSA" "ECDSA")
  select gen_key in "${ssh_type_keys[@]}"; do
    case $gen_key in
    "RSA")
      input "Email address for ssh key: " read r_email_add
      if [[ -z "$r_email_add" ]]; then
        ssh-keygen -t rsa -b 4096 -C "$(hostname)-$(date +'%d-%m-%Y')"
      else
        ssh-keygen -t rsa -b 4096 -C "$r_email_add"
      fi
      info "Done."
      exit 0
      ;;
    "ECDSA")
      input "Email address for ssh key: " read r_email_add
      if [[ -z "$r_email_add" ]]; then
        ssh-keygen -o -a 256 -t ed25519 -C "$(hostname)-$(date +'%d-%m-%Y')"
      else
        ssh-keygen -o -a 256 -t ed25519 -C "$r_email_add"
      fi
      info "Done."
      exit 0
      ;;
    *)
      error "invalid option"
      exit 0
      ;;
    esac
  done
}
