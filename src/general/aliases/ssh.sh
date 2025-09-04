#!/usr/bin/env bash

alias ssh='TERM=xterm ssh'
alias ssh:-v='ssh -V'
alias ssh:gen='ssh_generate_keys'
alias ssh:fix='ssh_fix_permission'

# Functions
#SSH directory and files permission
ssh_fix_permission() {
 local ssh_dir="$HOME/.ssh"

    if [ ! -d "$ssh_dir" ]; then
        echo "No ~/.ssh directory found."
        return 1
    fi

    echo "Fixing SSH permissions in $ssh_dir ..."

    # Correct ownership (user and primary group)
    chown -R "$(whoami)":"$(id -gn)" "$ssh_dir"

    # SSH directory itself
    chmod 700 "$ssh_dir"

    # Directories inside ~/.ssh (rare, but lock them down)
    find "$ssh_dir" -type d -exec chmod 700 {} \;

    # Private keys (id_rsa, id_ecdsa, etc.)
    find "$ssh_dir" -type f -name "id_*" -name "asap_*" -name "vps_*" ! -name "*.pub" -exec chmod 600 {} \;

    # Public keys (*.pub)
    find "$ssh_dir" -type f -name "*.pub" -exec chmod 644 {} \;

    # authorized_keys file
    [ -f "$ssh_dir/authorized_keys" ] && chmod 600 "$ssh_dir/authorized_keys"

    # config file
    [ -f "$ssh_dir/config" ] && chmod 600 "$ssh_dir/config"

    # known_hosts
    [ -f "$ssh_dir/known_hosts" ] && chmod 644 "$ssh_dir/known_hosts"

    # config.d fix permission
    find "$ssh_dir/config.d" -type d -exec chmod 700 {} \;
    find "$ssh_dir/config.d" -type f -name "id_*" -name "*.config" ! -name "*.pub" -exec chmod 600 {} \;
    find "$ssh_dir/config.d" -type f -name "*.pub" -exec chmod 644 {} \;

    echo "Permissions fixed:"
    ls -ld "$ssh_dir"
    ls -l "$ssh_dir"
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
