#!/usr/bin/env bash

# Eza (https://github.com/eza-community/eza)
# Aliases
alias l='eza'
alias l:-h='eza --help'
alias ls='eza -lbF --header --git --icons --color=always --group-directories-first'
alias lsa='eza -labF --header --git --icons --color=always --group-directories-first'
alias lsm='eza -lbF --header --git --sort=modified --icons --color=always --group-directories-first'
alias lsam='eza -labF --header --git --sort=modified --icons --color=always --group-directories-first'
alias lsal='eza -lbhHigUmuSa --time-style=long-iso --header --git --color-scale --icons --color=always --group-directories-first'
alias lsxl='eza -lbhHigUmuSa@ --time-style=long-iso --header --git --color-scale --icons --color=always --group-directories-first'
alias ll='eza -lbGF --header --git --icons --color=always --group-directories-first'
alias lla='eza -labGF --header --git --icons --color=always --group-directories-first'
alias llm='eza -lbGF --header --git --sort=modified --icons --color=always --group-directories-first'
alias llam='eza -labGF --header --git --sort=modified --icons --color=always --group-directories-first'
alias llal='eza -lbhHigUmuSaG --time-style=long-iso --header --git --color-scale --icons --color=always --group-directories-first'
alias llxl='eza -lbhHigUmuSa@ --time-style=long-iso --header --git --color-scale --icons --color=always --group-directories-first'
# speciality views
alias ls:col='eza -1 --icons --color=always --group-directories-first'
alias ls:t='eza_tree'
alias ll:t='eza_tree'
alias ls:t:a='eza_tree_dot'
alias ll:t:a='eza_tree_dot'

# Functions
eza_tree() {
  local _level=${1:-1}
  local _dir=${2:-.}
  eza -lhmB --header --git --icons --tree --level="$_level" "$_dir" --color=always --group-directories-first
}

eza_tree_dot() {
  local _level=${1:-1}
  local _dir=${2:-.}
  eza -lahmB --header --git --icons --tree --level="$_level" "$_dir" --color=always --group-directories-first
}
