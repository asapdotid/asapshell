#!/bin/bash
# NVM
alias nvm:-v='nvm --version'
alias nvm:-h='nvm --help'
alias nvm:l='nvm ls'
alias nvm:r:l='nvm ls-remote --lts'
alias nvm:r:ls='nvm ls-remote --lts | grep Latest'
alias nvm:r:v='nvm version-remote --lts'
alias nvm:i='nvm install'
alias nvm:ui='nvm uninstall'
alias nvm:up='nvm_upgrade_version'
alias nvm:use='nvm use'
alias nvm:default='nvm alias default'

# Function
function nvm_upgrade_version() {
  local _vfrom=${1:-current}
  local _vto=${2:-stable}
  if [[ -n "$_vfrom" && -n "$_vto" ]]; then
    nvm install $_vto --reintsall-packages-from=$_vfrom --latest-npm &&
      nvm alias default $_vto &&
      nvm use $_vto
  else
    error "please provide install version (nvm:up 14.0.0 16.0.0)"
  fi
}
