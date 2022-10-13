#!/bin/bash

# Exa (https://github.com/ogham/exa)
# Aliases
alias ls='exa'                                                                          # ls
alias l='exa -lbF --header --git --icons'                                               # list, size, type, git
alias ll='exa -lbGF --header --git --icons'                                             # long list
alias lla='exa -labGF --header --git --icons'                                           # long list
alias llm='exa -lbGF --header --git --sort=modified --icons'                            # long list, modified date sort
alias llam='exa -labGF --header --git --sort=modified --icons'                          # long list, modified date sort
alias la='exa -lbhHigUmuSa --time-style=long-iso --header --git --color-scale --icons'  # all list
alias lx='exa -lbhHigUmuSa@ --time-style=long-iso --header --git --color-scale --icons' # all + extended list
# speciality views
alias lS='exa -1 --icons' # one column, just names
alias llt='exa_tree'
alias llat='exa_tree_dot'

## Functions
function exa_tree() {
  _level=${1:-1}
  exa -lhmB --git --icons --tree --level=$_level
}

function exa_tree_dot() {
  _level=${1:-1}
  exa -lahmB --git --icons --tree --level=$_level
}
