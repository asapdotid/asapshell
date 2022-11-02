#!/bin/bash

alias pkg:i="package_install"
alias pkg:ui="package_uninstall"
alias pkg:s="package_search"
alias pkg:u="package_update"

# Aliases for ArchLinux AUR (as binaries in community)
alias yay:u='yay -Syyu'
alias yay:i='yay -S'
alias yay:ui='yay -Rscn'
alias yay:s='yay -Ss'
alias yay:clean='yay -Scc'

# Function
# Package install with os package manager
function package_install() {
  if helper_os_package pacman; then
    sudo pacman -S $1
  elif helper_os_package apt-get; then
    sudo apt install $1
  elif helper_os_package yum; then
    sudo yum install $1
  elif helper_os_package emerge; then
    sudo emerge --ask --verbose $1
  elif helper_os_package zypper; then
    sudo zypper install $1
  else
    error 'No package manager found!'
  fi
}

# Package uninstall with os package manager
function package_uninstall() {
  if helper_os_package pacman; then
    sudo pacman -Rscn $1
  elif helper_os_package apt-get; then
    sudo apt --purge remove $1
  elif helper_os_package yum; then
    sudo yum remove $1
  elif helper_os_package emerge; then
    sudo emerge --ask --verbose --depclean $1
  elif helper_os_package zypper; then
    sudo zypper remove $1
  else
    error 'No package manager found!'
  fi
}

# Package search with os package manager
function package_search() {
  if helper_os_package pacman; then
    sudo pacman -Ss $1
  elif helper_os_package apt-get; then
    sudo apt search $1
  elif helper_os_package yum; then
    sudo yum search $1
  elif helper_os_package emerge; then
    sudo emerge --search $1
  elif helper_os_package zypper; then
    sudo zypper search $1
  else
    error 'No package manager found!'
  fi
}

# Package update with os package manager
function package_update() {
  if helper_os_package pacman; then
    sudo pacman -Syu $1
  elif helper_os_package apt-get; then
    sudo apt update && sudo apt upgrade
  elif helper_os_package yum; then
    sudo yum update && sudo yum upgrade
  elif helper_os_package emerge; then
    sudo emerge --ask --verbose --update --deep --newuse @world
  elif helper_os_package zypper; then
    sudo zypper update && sudo zypper dist-upgrade
  else
    error 'No package manager found!'
  fi
}
