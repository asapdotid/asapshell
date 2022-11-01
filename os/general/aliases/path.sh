#!/bin/bash

# Aliases
alias h='home_path'
alias home='home_path'
alias home:dl='home_path Downloads'
alias home:doc='home_path Documents'
alias home:pic='home_path Pictures'
alias home:mus='home_path Music'
alias home:vid='home_path Videos'
alias home:des='home_path Desktop'
alias lab='lab_path'
alias pro='project_path'

# Function

#Change home directory
function home_path() {
  if [ -z "$1" ]; then
    cd $HOME && exa -labGF --header --git --icons $HOME
  elif [[ ! -z "$1" && -d "$HOME/$1" ]]; then
    cd "$HOME/$1" && exa -labGF --header --git --icons "$HOME/$1"
  else
    error "Directory doest not exist in the Home"
  fi
}

#Change to Labs directory
function lab_path() {
  if [ -z "$1" ]; then
    cd $LAB_LOCATION && exa -labGF --header --git --icons $LAB_LOCATION
  elif [[ ! -z "$1" && -d "$LAB_LOCATION/$1" ]]; then
    cd "$LAB_LOCATION/$1" && exa -labGF --header --git --icons "$LAB_LOCATION/$1"
  else
    error "Directory doest not exist in the Labs"
  fi
}

#Change to Projects directory
function project_path() {
  if [ -z "$1" ]; then
    cd $PROJECT_LOCATION && exa -labGF --header --git --icons $PROJECT_LOCATION
  elif [[ ! -z "$1" && -d "$PROJECT_LOCATION/$1" ]]; then
    cd "$PROJECT_LOCATION/$1" && exa -labGF --header --git --icons "$PROJECT_LOCATION/$1"
  else
    error "Directory doest not exist in the Projects"
  fi
}
