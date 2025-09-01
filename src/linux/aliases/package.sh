#!/usr/bin/env bash

alias pkg:i="package_install"
alias pkg:ui="package_uninstall"
alias pkg:s="package_search"
alias pkg:u="package_update"
alias pkg:clean="package_clean"

# ArchLinux Pacman repository mirror
alias pacman:mirror='pacman_mirror'
alias pacman:unlock='sudo rm -rf /var/lib/pacman/db.lck'
alias pacman:orphan='sudo pacman -Rns $(pacman -Qdtq)'
alias pacman:up:fix='pacman_glibc_locales'

# Aliases for ArchLinux AUR (as binaries in community)
alias yay:u='yay -Syyu'
alias yay:i='yay -S'
alias yay:ui='yay -Rscn'
alias yay:s='yay -Ss'
alias yay:clean='yay -Scc'

# Aliases for Ubuntu Nala
alias nala:f='sudo nala fetch'
alias nala:l='sudo nala list'
alias nala:l:ug='sudo nala list --upgradeable'
alias nala:s='sudo nala search'
alias nala:sh='sudo nala show'
alias nala:u='sudo nala update'
alias nala:ug='sudo nala upgrade'
alias nala:ug:f='sudo nala upgrade --full'
alias nala:i='sudo nala install'
alias nala:ui='sudo nala remove'
alias nala:ui:p='sudo nala remove --purge'
alias nala:h='sudo nala history'
alias nala:h:c='sudo nala history clear'
alias nala:h:ca='sudo nala history clear --all'
alias nala:clean='sudo nala autoremove --purge'
alias nala:fetch='sudo nala fetch'

# Aliases for Flatpak
alias flat='flatpak'
alias flat:i='flatpak install'
alias flat:i:s='flatpak install --system'
alias flat:ui='flatpak uninstall --delete-data'
alias flat:ui:s='flatpak uninstall --delete-data --system'
alias flat:u='flatpak update'
alias flat:s='flatpak search'
alias flat:sh='flatpak show'
alias flat:clean='flatpak uninstall --unused'
alias flat:clean:all='flatpak uninstall --unused --delete-data --all'
alias flat:run='flatpak run'

# Functions
# Package install with os package manager
package_install() {
  if helper_os_package pacman; then
    sudo pacman -S "$1"
  elif helper_os_package apt; then
    sudo apt install "$1"
  elif helper_os_package yum; then
    sudo yum install "$1"
  elif helper_os_package dnf; then
    sudo dnf install "$1"
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
  elif helper_os_package apt; then
    sudo apt --purge remove "$1"
  elif helper_os_package yum; then
    sudo yum remove "$1"
  elif helper_os_package dnf; then
    sudo dnf remove "$1"
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
  elif helper_os_package apt; then
    sudo apt search "$1"
  elif helper_os_package yum; then
    sudo yum search "$1"
  elif helper_os_package dnf; then
    sudo dnf search "$1"
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
    sudo pacman -Syyu
  elif helper_os_package apt; then
    sudo apt update && sudo apt upgrade
  elif helper_os_package yum; then
    sudo yum update && sudo yum upgrade
  elif helper_os_package dnf; then
    sudo dnf upgrade --refresh
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
  elif helper_os_package apt; then
    sudo apt celan --dry-run && sudo apt autoremove --purge
  elif helper_os_package yum; then
    sudo yum clean all
  elif helper_os_package dnf; then
    sudo dnf clean dbcache
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
