#!/bin/bash

alias edit='$EDITOR'
alias sozsh='source $HOME/.zshrc'
alias sobash='source $HOME/.bashrc'
alias e:zsh='$EDITOR $HOME/.zshrc'
alias e:bash='$EDITOR $HOME/.bashrc'
alias e:hosts='sudo $EDITOR /etc/hosts'
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
alias cmx='cmatrix'
alias aquarium='asciiquarium -t'

# Code Editor
alias code='echo $VSCODE'

# Noevim
alias v='nvim'
alias vim='nvim'

# Get IP
alias ip:p='get_public_ip'
alias ip:l='get_local_ip'

# default browser
alias browser:get='xdg-settings get default-web-browser'
alias browser:query='xdg-mime query default x-scheme-handler/https'
alias browser:set='set_default_browser'

# list hosts /etc/hosts
# Using BAT utility like CAT
alias myhost='bat /etc/hosts'

# Functions
# Using DIG Utility (Arch linux pacman -Ss bind)
get_public_ip() {
  local myip
  myip=$(dig +short myip.opendns.com @resolver1.opendns.com)
  if [[ -z "$myip" ]]; then
    public_ip=$(curl --silent icanhazip.com)
  else
    public_ip=$myip
  fi
  info "My WAN/Public IP address: ${YELLOW}${public_ip}${RESET}"
}

get_local_ip() {
  local device=$1
  if [[ -z "$device" ]]; then
    local_ip=$(ip route | grep src | awk -F 'src' '{print $NF; exit}' | awk '{print $1}')
  else
    local_ip=$(ip addr show dev "$device")
  fi
  info "My Local IP address: ${YELLOW}${local_ip}${RESET}"
}

set_default_browser() {
  local browser=$1
  if command_exists "$browser"; then
    xdg-mime default "$browser".desktop x-scheme-handler/https
    xdg-mime default "$browser".desktop x-scheme-handler/http
    info "Make $browser your default browser"
  else
    error "Your system does not have $browser browser app"
  fi
}