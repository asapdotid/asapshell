#!/bin/bash

alias edit='$EDITOR'
alias sozsh='source $HOME/.zshrc'
alias sobash='source $HOME/.bashrc'
alias e:zsh='$EDITOR $HOME/.zshrc'
alias e:bash='$EDITOR $HOME/.bashrc'
alias e:hosts='sudo $EDITOR /etc/hosts'
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
alias cp='cp -v'
alias cp:i='cp -iv'
alias cp:r='cp -rv'
alias cmx='cmatrix'
alias asq='asciiquarium -t'
alias mail='neomutt'
alias lg='lazygit'

# Code Editor
alias code='system_code_editor'

# Noevim
alias v='nvim'
alias vim='nvim'

# Get IP
alias ip:l='get_local_ip'
alias ip:p='get_public_ip'

# default browser
alias browser:get='xdg-settings get default-web-browser'
alias browser:query='xdg-mime query default x-scheme-handler/https'
alias browser:set='set_default_browser'

# list hosts /etc/hosts
# Using BAT utility like CAT
alias myhost='bat /etc/hosts'

# Functions
# Get Local IP
get_local_ip() {
  local device=$1
  if [[ -z "$device" ]]; then
    local_ip=$(ip route | grep src | awk -F 'src' '{print $NF; exit}' | awk '{print $1}')
  else
    local_ip=$(ip addr show dev "$device")
  fi
  info "My Local IP address: ${YELLOW}${local_ip}${RESET}"
}

# Using DIG Utility (Arch linux pacman -Ss bind)
# Get Public IP
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

# Set default browser
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

# Code editor
system_code_editor() {
  local code_editor=${VSCODE:-'code'}
  if command_exists "$code_editor"; then
    case "$code_editor" in
    "vim")
      vim "$@"
      ;;
    "nvim")
      nvim "$@"
      ;;
    "code")
      code "$@"
      ;;
    "vscodium")
      vscodium "$@"
      ;;
    "sublime")
      subl "$@"
      ;;
    *)
      vi "$@"
      ;;
    esac
  else
    error "Your system does not have $code_editor editor app"
  fi
}
