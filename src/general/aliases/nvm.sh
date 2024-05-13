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
alias nvm:set='nvm_set_version'

# Functions
nvm_upgrade_version() {
  local _vfrom=${1:-'default'}
  local _vto=${2:-'lts/*'}
  local _vset=$3
  if [[ -n "$_vfrom" && -n "$_vto" ]]; then
    if [[ -n "$_vset" && "--set" == "$_vset" ]]; then
      nvm install --reintsall-packages-from="$_vfrom" --latest-npm "$_vto" &&
        nvm alias default "$_vto" &&
        nvm use "$_vto"
    else
      nvm install --reintsall-packages-from="$_vfrom" --latest-npm "$_vto"
    fi
  else
    error "please provide install version (nvm:up 14.0.0 16.0.0 --set)"
  fi
}

nvm_set_version() {
  local _vto=${1}
  if [[ -n "$_vto" ]]; then
    nvm alias default "$_vto" && nvm use "$_vto"
  else
    error "please provide version (nvm:set 14.0.0)"
  fi
}
