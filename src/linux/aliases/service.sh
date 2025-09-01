#!/usr/bin/env bash
# Service
# Handling Service (start, stop, restart) ROOT
alias sv:r:st='service_setup root start'
alias sv:r:rt='service_setup root restart'
alias sv:r:ss='service_setup root status'
alias sv:r:sp='service_setup root stop'
alias sv:r:dr='sudo systemctl daemon-reload'
alias sv:r:l='sudo systemctl list-units --type=service'
alias sv:r:la='sudo systemctl list-units --type=service --state=active'
alias sv:r:lr='sudo systemctl list-units --type=service --state=running'
alias sv:r:le='sudo systemctl list-units --type=service --state=enabled'
# Handling Service (start, stop, restart) USER
alias sv:u:st='service_setup user start'
alias sv:u:rt='service_setup user restart'
alias sv:u:ss='service_setup user status'
alias sv:u:sp='service_setup user stop'
alias sv:u:dr='systemctl --user daemon-reload'
alias sv:u:l='systemctl --user list-units --type=service'
alias sv:u:la='systemctl --user list-units --type=service --state=active'
alias sv:u:lr='systemctl --user list-units --type=service --state=running'
alias sv:u:le='systemctl --user list-units --type=service --state=enabled'

# Functions
service_setup() {
  if [[ "$1" == "root" && -n "$2" && -n "$3" ]]; then
    if helper_os_package systemctl; then
      sudo systemctl "$2" "$3".service
    else
      info "Please check service name!"
    fi
  elif [[ "$1" == "user" && -n "$2" && -n "$3" ]]; then
    if helper_os_package systemctl; then
      systemctl --user "$2" "$3".service
    else
      info "Please check service name!"
    fi
  else
    error "Please run this as root or with sudo"
  fi
}
