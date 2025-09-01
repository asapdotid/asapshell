#!/usr/bin/env bash

# Aliases
alias p:h='home_path'
alias p:home='home_path'
alias p:dow='home_path Downloads'
alias p:doc='home_path Documents'
alias p:pic='home_path Pictures'
alias p:mus='home_path Music'
alias p:vid='home_path Videos'
alias p:des='home_path Desktop'
alias p:con='home_path .config'
alias p:loc='home_path .local'
alias p:ssh='home_path .ssh'
alias p:lab='lab_path'
alias p:pro='project_path'

# Function
# Change home directory
home_path() {
  if [ -z "$1" ]; then
    cd "$HOME" || return
    eza -labGF --header --git --icons "$HOME"
  elif [[ -n "$1" && -d "$HOME/$1" ]]; then
    cd "$HOME/$1" || return
    eza -labGF --header --git --icons "$HOME/$1"
  else
    error "Directory doest not exist in the Home"
  fi
}

# Change to Labs directory
lab_path() {
  if [ -z "$1" ]; then
    cd "$LAB_LOCATION" || return
    eza -labGF --header --git --icons "$LAB_LOCATION"
  elif [[ -n "$1" && -d "$LAB_LOCATION/$1" ]]; then
    cd "$LAB_LOCATION/$1" || return
    eza -labGF --header --git --icons "$LAB_LOCATION/$1"
  else
    error "Directory doest not exist in the Labs"
  fi
}

# Change to Projects directory
project_path() {
  if [ -z "$1" ]; then
    cd "$PROJECT_LOCATION" || return
    eza -labGF --header --git --icons "$PROJECT_LOCATION"
  elif [[ -n "$1" && -d "$PROJECT_LOCATION/$1" ]]; then
    cd "$PROJECT_LOCATION/$1" || return
    eza -labGF --header --git --icons "$PROJECT_LOCATION/$1"
  else
    error "Directory doest not exist in the Projects"
  fi
}
