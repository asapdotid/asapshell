#!/bin/bash

alias edit='$EDITOR'
alias sozsh='source $HOME/.zshrc'
alias sobash='source $HOME/.bashrc'
alias edit:zsh='$EDITOR $HOME/.zshrc'
alias edit:bash='$EDITOR $HOME/.bashrc'
alias edit:hosts='sudo $EDITOR /etc/hosts'

# Code Editor
alias code="$VSCODE"

# Noevim
alias nv='nvim'

# Get IP
alias ip:p='get_public_ip'
alias ip:l='get_local_ip'

# Get default browser
alias bowser:g:d='xdg-settings get default-web-browser'

# list hosts /etc/hosts
# Using BAT utility like CAT
alias myhost='bat /etc/hosts'

# Functions
# Using DIG Utility (Arch linux pacman -Ss bind)
function get_public_ip() {
  local myip="$(dig +short myip.opendns.com @resolver1.opendns.com)"
  if [[ -z "$myip" ]]; then
    public_ip=$(curl --silent icanhazip.com)
  else
    public_ip=$myip
  fi
  info "My WAN/Public IP address: ${YELLOW}${public_ip}${RESET}"
}

function get_local_ip() {
  local device=$1
  if [[ -z "$device" ]]; then
    local_ip="ip addr"
  else
    local_ip="ip addr show dev $device"
  fi
  bash -c $local_ip
}

function set_default_browser() {
  local browser=$1
  echo "export BROSER"
  xdg-mime default $browser x-scheme-handler/http x-scheme-handler/https
}