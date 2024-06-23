#!/bin/bash

alias ze="zellij --layout welcome"
alias ze:-v="zellij --version"
alias ze:-h="zellij --help"
alias ze:as="zellij attach"
alias ze:ls="zellij list-sessions"
alias ze:ks="zellij kill-session"
alias ze:kas="zellij kill-all-session"
alias ze:r="zellij run --"
alias ze:e="zellij edit --"
alias ze:a="zellij action --"
alias ze:p="zellij plugin --"
alias ze:P="zellij pipe --"
alias ze:l="zellij --layout"
alias ze:dump:l="zellij_dump_layout"

# Functions
zellij_dump_layout() {
  local name=$1
  if [ -n "$name" ]; then
    zellij setup --dump-layout "$name" >"$HOME/.config/zellij/layouts/$name.kdl"
  else
    error "Please provide layout name!"
  fi
}
