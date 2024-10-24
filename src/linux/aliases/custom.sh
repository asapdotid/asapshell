#!/bin/bash

alias ch:sh='change_shell'

# Functions
change_shell() {
  info "Change shell (currently using: $(get_shell))"
  input "Shell name (zsh, bash or fish)"
  read -r i_shell
  input "Target user"
  read -r i_user
  if [ -z "$i_shell" ]; then
    error "Please provide shell name"
    return 1
  fi
  if [ -z "$i_user" ]; then
    error "Please provide target user"
    return 1
  fi
  if [ "$i_user" == "root" ]; then
    sudo bash -c 'chsh -s "$(which $i_shell)" "$i_user"'
  else
    chsh -s "$(which $i_shell)" "$i_user"
  fi
}
