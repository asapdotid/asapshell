#!/bin/bash
# Service
# Handling Service (start, stop, restart) ROOT
alias s:l='sudo systemctl list-units --type=service'
alias s:l:a='sudo systemctl list-units --type=service --state=active'
alias s:l:r='sudo systemctl list-units --type=service --state=running'
alias s:l:e='sudo systemctl list-units --type=service --state=enabled'
alias s:set='sudo_set_systemctl'
alias s:dr='sudo systemctl daemon-reload'
# Handling Service (start, stop, restart) USER
alias su:l='systemctl --user list-units --type=service'
alias su:l:a='systemctl --user list-units --type=service --state=active'
alias su:l:r='systemctl --user list-units --type=service --state=running'
alias su:l:e='systemctl --user list-units --type=service --state=enabled'
alias su:set='user_set_systemctl'
alias su:dr='systemctl --user daemon-reload'

# Function
function sudo_set_systemctl() {
  if [ ! -z "$1" && ! -z "$2" ]; then
    sudo systemctl $1 $2.service
  else
    info "Please check correct command!"
  fi
}

function user_set_systemctl() {
  if [ ! -z "$1" && ! -z "$2" ]; then
    systemctl --user $1 $2.service
  else
    info "Please check correct command!"
  fi
}

function get_service() {
  local serviceName="$1.service"
  local _svc=""
  if { systemctl --all --type service; } 2>/dev/null | grep -q "$serviceName"; then
    eval $_svc="systemctl"
  elif { service --status-all; } 2>/dev/null | grep -q "$serviceName"; then
    eval $_svc="service"
  else
    eval $_svc="false"
  fi
}
