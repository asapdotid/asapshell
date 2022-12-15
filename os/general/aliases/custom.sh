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
alias myip='get_my_ip'

# list hosts /etc/hosts
# Using BAT utility like CAT
alias myhost='bat /etc/hosts'

# Functions
# Using DIG Utility (Arch linux pacman -Ss bind)
function get_my_ip() {
    local myip="$(dig +short myip.opendns.com @resolver1.opendns.com)"
    info "My WAN/Public IP address: ${myip}"
}
