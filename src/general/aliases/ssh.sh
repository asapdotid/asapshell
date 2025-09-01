#!/usr/bin/env bash

alias ssh='TERM=xterm ssh'
alias ssh:-v='ssh -V'
alias ssh:gen='ssh_generate_keys'
alias ssh:fix:df='ssh_fix_permission'

# Functions
#SSH directory and files permission
ssh_fix_permission() {
  local __ssh_user="/home/$USER/.ssh"
  if [ -d "$__ssh_user" ]; then
    #Make the .ssh directory unreadable for other users and groups
    chmod 700 "$__ssh_user" >/dev/null 2>&1
    #Make the private SSH key read only
    chmod 600 "$__ssh_user"/* >/dev/null 2>&1
    #Make public key readable
    chmod 644 "$__ssh_user"/{*.pub,authorized_key,known_hosts} >/dev/null 2>&1
    info "Set SSH directory and files permission, done."
  else
    info "Cannot set permission, due to .ssh directory not found."
  fi
}

#SSH generate keys
ssh_generate_keys() {
  local __ssh_user="/home/$USER/.ssh"
  PS3='Generate the SSH keys: '
  select gen_key in "RSA" "ECDSA" "Quit"; do
    case $gen_key in
    "RSA")
      input "The name for your SSH RSA key file"
      read -r r_file_name_key
      input "Flag to create a new SSH RSA key pair"
      read -r r_flag_key_pair
      input "Target directory for SSH RSA key pair default ${__ssh_user} (optional)"
      read -r r_target_key_dir
      if [ -z "$r_file_name_key" ] && [ -z "$r_flag_key_pair" ]; then
        if [ -z "$r_target_key_dir" ]; then
          __ssh_rsa_file_key=${__ssh_user}/id_rsa
        else
          __ssh_rsa_file_key=${r_target_key_dir}/id_rsa
        fi
        __ssh_rsa_flag_key=$(hostname)-$(date +'%d-%m-%Y')
      else
        if [ -z "$r_target_key_dir" ]; then
          __ssh_rsa_file_key=${__ssh_user}/${r_file_name_key}_rsa
        else
          __ssh_rsa_file_key=${r_target_key_dir}/${r_file_name_key}_rsa
        fi
        __ssh_rsa_flag_key=${r_flag_key_pair}-$(date +'%d-%m-%Y')
      fi
      ssh-keygen -t rsa -b 4096 -f "${__ssh_rsa_file_key}" -C "${__ssh_rsa_flag_key}"
      info "Done, create RSA key name ${__ssh_rsa_file_key}."
      break
      ;;
    "ECDSA")
      input "The name for your SSH ECDSA key file"
      read -r r_file_name_key
      input "Flag to create a new SSH ECDSA key pair"
      read -r r_flag_key_pair
      input "Target directory for SSH RSA key pair default ${__ssh_user} (optional)"
      read -r r_target_key_dir
      if [ -z "$r_file_name_key" ] && [ -z "$r_flag_key_pair" ]; then
        if [ -z "$r_target_key_dir" ]; then
          __ssh_ecdsa_file_key=${__ssh_user}/id_ed25519
        else
          __ssh_ecdsa_file_key=${r_target_key_dir}/id_ed25519
        fi
        __ssh_ecdsa_flag_key=$(hostname)-$(date +'%d-%m-%Y')
      else
        if [ -z "$r_target_key_dir" ]; then
          __ssh_ecdsa_file_key=${__ssh_user}/${r_file_name_key}_ed25519
        else
          __ssh_ecdsa_file_key=${r_target_key_dir}/${r_file_name_key}_ed25519
        fi
        __ssh_ecdsa_flag_key=${r_flag_key_pair}-$(date +'%d-%m-%Y')
      fi
      ssh-keygen -o -a 256 -t ed25519 -f "${__ssh_ecdsa_file_key}" -C "${__ssh_ecdsa_flag_key}"
      info "Done, create ECDSA key name ${__ssh_ecdsa_file_key}."
      break
      ;;
    "Quit")
      break
      ;;
    *)
      error "Invalid option, select RSA or ECDSA"
      break
      ;;
    esac
  done
}
