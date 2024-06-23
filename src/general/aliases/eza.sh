#!/bin/bash

# Eza (https://github.com/eza-community/eza)
# Aliases
alias l='eza'                                                                                            # ls
alias l:-h='eza --help'                                                                                  # help
alias ls='eza -lbF --header --git --icons --color=always'                                                # list, size, type, git
alias lsa='eza -labF --header --git --icons --color=always'                                              # long list
alias ll='eza -lbGF --header --git --icons --color=always'                                               # long list
alias lla='eza -labGF --header --git --icons --color=always'                                             # long list
alias llm='eza -lbGF --header --git --sort=modified --icons --color=always'                              # long list, modified date sort
alias llam='eza -labGF --header --git --sort=modified --icons --color=always'                            # long list, modified date sort
alias llal='eza -lbhHigUmuSa --time-style=long-iso --header --git --color-scale --icons --color=always'  # all list
alias llxl='eza -lbhHigUmuSa@ --time-style=long-iso --header --git --color-scale --icons --color=always' # all + extended list
# speciality views
alias ls:col='eza -1 --icons --color=always' # one column, just names
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
