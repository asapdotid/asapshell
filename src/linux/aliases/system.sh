#!/bin/bash
# Aliases
alias dns:flush='sudo systemd-resolve --flush-caches'
alias dns:flush:all='sudo systemd-resolve --flush-dns'

alias ps:top='top_proccess'

# Functions
top_proccess() {
  local num=${1:-10}
  ps -eo pid,ppid,user,cmd,comm,%mem,%cpu --sort=-%mem | head -n "$num"
}
