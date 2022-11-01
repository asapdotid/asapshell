#!/bin/bash
# Service
# Handling Service (start, stop, restart) ROOT
alias s:s:st='service_setup sudo start'
alias s:s:ss='service_setup sudo status'
alias s:s:sp='service_setup sudo stop'
alias s:s:dr='sudo systemctl daemon-reload'
alias s:s:l='sudo systemctl list-units --type=service'
alias s:s:la='sudo systemctl list-units --type=service --state=active'
alias s:s:lr='sudo systemctl list-units --type=service --state=running'
alias s:s:le='sudo systemctl list-units --type=service --state=enabled'
# Handling Service (start, stop, restart) USER
alias s:u:st='service_setup user start'
alias s:u:ss='service_setup user status'
alias s:u:sp='service_setup user stop'
alias s:u:dr='systemctl --user daemon-reload'
alias s:u:l='systemctl --user list-units --type=service'
alias s:u:la='systemctl --user list-units --type=service --state=active'
alias s:u:lr='systemctl --user list-units --type=service --state=running'
alias s:u:le='systemctl --user list-units --type=service --state=enabled'

# Function
function service_setup() {
  if [[ "$1" -eq "root" && -n "$2" && -n "$3" ]]; then
    if helper_os_package systemctl; then
      sudo systemctl $2 $3.service
    else
      info "Please check service name!"
    fi
  elif [[ "$1" -eq "user" && -n "$2" && -n "$3" ]]; then
    if helper_os_package systemctl; then
      systemctl --user $2 $3.service
    else
      info "Please check service name!"
    fi
  else
    error "Please run this as root or with sudo"
  fi
}
