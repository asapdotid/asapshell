#!/bin/bash

# Eza (https://github.com/eza-community/eza)
# Aliases
alias l='eza'
alias l:-h='eza --help'
alias ls='eza -lbF --header --git --icons --color=always --group-directories-first'
alias lsa='eza -labF --header --git --icons --color=always --group-directories-first'
alias ll='eza -lbGF --header --git --icons --color=always --group-directories-first'
alias lla='eza -labGF --header --git --icons --color=always --group-directories-first'
alias llm='eza -lbGF --header --git --sort=modified --icons --color=always --group-directories-first'
alias llam='eza -labGF --header --git --sort=modified --icons --color=always --group-directories-first'
alias llal='eza -lbhHigUmuSa --time-style=long-iso --header --git --color-scale --icons --color=always --group-directories-first'
alias llxl='eza -lbhHigUmuSa@ --time-style=long-iso --header --git --color-scale --icons --color=always --group-directories-first'
# speciality views
alias ls:col='eza -1 --icons --color=always --group-directories-first'
alias ll:t='eza_tree'
alias lla:t='eza_tree_dot'

# Functions
eza_tree() {
  local _level=${1:-1}
  local _dir=${2:-.}
  eza -lhmB --git --icons --tree --level="$_level" "$_dir" --color=always
}

eza_tree_dot() {
  local _level=${1:-1}
  local _dir=${2:-.}
  eza -lahmB --git --icons --tree --level="$_level" "$_dir" --color=always
}
