#!/bin/bash

# Aliases
alias lab='lab_path'
alias lab:app='lab_path apps'
alias lab:a='lab_path ansible'
alias lab:c='lab_path config'
alias lab:d='lab_path docker'
alias lab:i='lab_path infra'
alias proj='project_path'
alias home='home_path'
alias home:dl='home_path Downloads'
alias home:doc='home_path Documents'

# Function

#Change home directory
function home_path() {
  if [ -z "$1" ]; then
    cd $HOME && exa -labGF --header --git --icons $HOME
  else
    if [ -d "$HOME/$1" ]; then
      cd "$HOME/$1" && exa -labGF --header --git --icons "$HOME/$1"
    else
      error "Directory doest not exist in the Home"
    fi
  fi
}

#Change to Labs directory
function lab_path() {
  if [ -z "$1" ]; then
    cd $LAB_LOCATION && exa -labGF --header --git --icons $LAB_LOCATION
  else
    if [ -d "$LAB_LOCATION/$1" ]; then
      cd "$LAB_LOCATION/$1" && exa -labGF --header --git --icons "$LAB_LOCATION/$1"
    else
      error "Directory doest not exist in the Labs"
    fi
  fi
}

#Change to Projects directory
function project_path() {
  if [ -z "$1" ]; then
    cd $PROJECT_LOCATION && exa -labGF --header --git --icons $PROJECT_LOCATION
  else
    if [ -d "$LAB_LOCATION/$1" ]; then
      cd "$PROJECT_LOCATION/$1" && exa -labGF --header --git --icons "$PROJECT_LOCATION/$1"
    else
      error "Directory doest not exist in the Projects"
    fi
  fi
}