#!/bin/bash

# Aliases
alias c='clear'
alias cd:='change_dir'
alias cd.='change_dir 1'
alias cd..='change_dir 2'
alias cd...='change_dir 3'
alias cd:doc='cd ~/Documents'
alias cd:des='cd ~/Desktop'
alias cd:dl='cd ~/Downloads'
alias cd:pic='cd ~/Pictures'
alias cd:mus='cd ~/Music'
alias cd:vid='cd ~/Videos'
alias cd:conf='cd ~/.config'
alias cd:ssh='cd ~/.ssh'
alias df="df -h"
alias du="du -sh"
alias rm:f='rm -rf'
alias s:rm:f='sudo rm -rf'
alias cp:r='cp -rv'
alias s:cp:r='sudo cp -rv'
alias cp:sync='rsync -azP'
alias find:f="find_file"
alias find:ext="find_ext"
alias history='history | grep'
alias mkcd='mk_cd'

# Functions
# Change directory
cd_home_dot() {
  if [[ -n "$1" && -d "$HOME/.$1" ]]; then
    cd "$HOME/.$1" || return
  else
    error "Please check your directory destination first!"
  fi
}

# Make directory and change directory
mk_cd() {
  if [[ -n "$1" ]]; then
    mkdir -p -- "$1" && cd -P -- "$1" || return
  else
    error "Please check your directory destination first!"
  fi
}

# Search for a specific file
# Use: "find_file example"
# Results: prints any files that begin with "example", is not case-sensitive, picks up any file type (ex. result: ExampleTest.docx)
find_file() {
  file=( "$@" )
  file+=( "*" )
  find . -iname "${file[@]}" 2>&1 | grep -v "Operation not permitted"
}

# Search for all files with a specific extension
# Use: "find_ext swift"
# Results: prints all .swift files
find_ext() {
  ext="*."
  ext+=( "$@" )
  find . -iname "${ext[@]}" 2>&1 | grep -v "Operation not permitted"
}

change_dir() {
  local cd_dir=""
  if [[ -n $1 ]] && [[ "$1" =~ ^[0-9]+$ ]]; then
    for ((i = 1; i <= $1; i++)); do
      cd_dir+="../"
    done
    cd $cd_dir || return
  else
    error "Whoops!, please check destination"
  fi
}
