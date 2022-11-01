#!/bin/bash

# Aliases
alias c='clear'
alias cd='change_dir'
alias cd.='change_dir 1'
alias cd..='change_dir 2'
alias cd...='change_dir 3'
alias df="df -h"
alias mkcd='mk_cd'
alias rm:f='rm -rf'
alias s:rm:f='sudo rm -rf'
alias cp:v='rsync -ah --info=progress2'
alias f:file="find_file"
alias f:ext="find_ext"
alias history='history | grep'

# Function

#Change directory
function cd_home_dot() {
  if [[ -n "$1" && -d "$HOME/.$1" ]]; then
    cd "$HOME/.$1"
  else
    error "Please check your directory destination first!"
  fi
}

#Make directory and change directory
function mk_cd() {
  mkdir -p "$1"
  cd "$1"
}

#Search for a specific file
#Use: "find_file example"
#Results: prints any files that begin with "example", is not case-sensitive, picks up any file type (ex. result: ExampleTest.docx)
function find_file() {
  file = "$@"
  file += "*"
  find . -iname $file 2>&1 | grep -v "Operation not permitted"
}

#Search for all files with a specific extension
#Use: "find_ext swift"
#Results: prints all .swift files
function find_ext() {
  ext = "*."
  ext += "$@"
  find . -iname $ext 2>&1 | grep -v "Operation not permitted"
}

function change_dir() {
  local cd_dir=""
  if [[ -n $1 ]] && [[ "$1" =~ ^[0-9]+$ ]]; then
    for ((i = 1; i <= $1; i++)); do
      cd_dir+="../"
    done
    cd $cd_dir
  else
    error "Whoops!, please check destination"
  fi
}
