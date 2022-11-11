#!/bin/bash
# NVM
alias nvm:-v='nvm --version'
alias nvm:l='nvm ls'
alias nvm:r:l='nvm ls-remote --lts'
alias nvm:r:ls='nvm ls-remote --lts | grep Latest'
alias nvm:r:v="nvm version-remote --lts"
alias nvm:i='nvm install'
alias nvm:ui='nvm uninstall'
alias nvm:r='nvm_reinstall'
alias nvm:u='nvm use'
alias nvm:a:d='nvm alias default'

# Function
function nvm_reinstall() {
  local to_version=${1:=lts}
  local from_version=${2:=default}
  if [[ "$to_version" -eq 'lts' && "$from_version" -eq 'default' ]]; then
    nvm install lts/* --reintsall-packages-from=default --latest-npm
  else
    nvm install $to_version --reintsall-packages-from=$from_version --latest-npm
  fi
}
