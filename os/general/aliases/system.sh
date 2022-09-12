#!/bin/bash

# Aliases
alias c='clear'
alias cd~='cd $HOME'
alias cd.='cd ..'
alias cd..='cd ../../'
alias cd...='cd ../../../'
alias cd:='cd_home_dot'
alias gh='history | grep'
alias mkcd='mk_cd'
alias rm:f='rm -rf'
alias s:rm:f='sudo rm -rf'
alias cpv='rsync -ah --info=progress2'
alias f:file="find_file"
alias f:ext="find_ext"
alias df="df -h"
alias lt='du -sh * | sort -h'

# Function

#Change directory
function cd_home_dot() {
  if [ -z "$1" && -d "$1" ]; then
    cd $HOME/.$1
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
