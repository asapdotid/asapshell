#!/bin/bash

alias pkg:i="package_install"
alias pkg:ui="package_uninstall"
alias pkg:s="package_search"
alias pkg:u="package_update"
alias pkg:clean="package_clean"

# ArchLinux Pacman repository mirror
alias pacman:mirror='pacman_mirror'
alias pacman:fix:glib='pacman_glibc_locales'

# Aliases for ArchLinux AUR (as binaries in community)
alias yay:u='yay -Syyu'
alias yay:i='yay -S'
alias yay:ui='yay -Rscn'
alias yay:s='yay -Ss'
alias yay:clean='yay -Scc'

# Functions
# Package install with os package manager
package_install() {
  if helper_os_package pacman; then
    sudo pacman -S "$1"
  elif helper_os_package apt-get; then
    sudo apt-get install "$1"
  elif helper_os_package yum; then
    sudo yum install "$1"
  elif helper_os_package emerge; then
    sudo emerge --ask --verbose "$1"
  elif helper_os_package zypper; then
    sudo zypper install "$1"
  else
    error 'No package manager found!'
  fi
}

# Package uninstall with os package manager
package_uninstall() {
  if helper_os_package pacman; then
    sudo pacman -Rscn "$1"
  elif helper_os_package apt-get; then
    sudo apt-get --purge remove "$1"
  elif helper_os_package yum; then
    sudo yum remove "$1"
  elif helper_os_package emerge; then
    sudo emerge --ask --verbose --depclean "$1"
  elif helper_os_package zypper; then
    sudo zypper remove "$1"
  else
    error 'No package manager found!'
  fi
}

# Package search with os package manager
package_search() {
  if helper_os_package pacman; then
    sudo pacman -Ss "$1"
  elif helper_os_package apt-get; then
    sudo apt-get search "$1"
  elif helper_os_package yum; then
    sudo yum search "$1"
  elif helper_os_package emerge; then
    sudo emerge --search "$1"
  elif helper_os_package zypper; then
    sudo zypper search "$1"
  else
    error 'No package manager found!'
  fi
}

# Package update with os package manager
package_update() {
  if helper_os_package pacman; then
    sudo pacman -Syu "$1"
  elif helper_os_package apt-get; then
    sudo apt-get update && sudo apt-get upgrade
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

# Package cleaning cache with os package manager
package_clean() {
  if helper_os_package pacman; then
    sudo pacman -Scc
  elif helper_os_package apt-get; then
    sudo apt-get celan --dry-run && sudo apt-get autoremove --purge
  elif helper_os_package yum; then
    sudo yum clean all
  elif helper_os_package emerge; then
    sudo emerge --depclean --verbose
  elif helper_os_package zypper; then
    sudo zypper clean -a
  else
    error 'No package manager found!'
  fi
}

# ArchLinux package Pacman repository mirror
pacman_mirror() {
  local country=${1:=all}
  local protocol=${2:=all}
  sudo pacman-mirrors --country "$country" --api --protocols "$protocol" --set-branch stable
}

# ArchLinux Pacman fi
pacman_glibc_locales() {
  sudo pacman -Syu glibc-locales --overwrite /usr/lib/locale/\*/\*
}
