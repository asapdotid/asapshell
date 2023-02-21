#!/bin/bash

# Exa (https://github.com/ogham/exa)
# Aliases
alias l='exa'                                                                             # ls
alias l:-h='exa --help'                                                                   # help
alias ls='exa -lbF --header --git --icons'                                                # list, size, type, git
alias lsa='exa -labGF --header --git --icons'                                             # long list
alias ll='exa -lbGF --header --git --icons'                                               # long list
alias lla='exa -labGF --header --git --icons'                                             # long list
alias llm='exa -lbGF --header --git --sort=modified --icons'                              # long list, modified date sort
alias llam='exa -labGF --header --git --sort=modified --icons'                            # long list, modified date sort
alias llal='exa -lbhHigUmuSa --time-style=long-iso --header --git --color-scale --icons'  # all list
alias llxl='exa -lbhHigUmuSa@ --time-style=long-iso --header --git --color-scale --icons' # all + extended list
# speciality views
alias ls:col='exa -1 --icons' # one column, just names
alias ll:t='exa_tree'
alias ll:t.='exa_tree_dot'

## Functions
function exa_tree() {
  local _level=${1:-1}
  exa -lhmB --git --icons --tree --level=$_level
}

function exa_tree_dot() {
  local _level=${1:-1}
  exa -lahmB --git --icons --tree --level=$_level
}
