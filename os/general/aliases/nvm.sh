#!/bin/bash
# NVM
alias nvm:-v='nvm --version'
alias nvm:?='nvm --help'
alias nvm:l='nvm ls'
alias nvm:r:l='nvm ls-remote --lts'
alias nvm:r:ls='nvm ls-remote --lts | grep Latest'
alias nvm:r:v='nvm version-remote --lts'
alias nvm:i='nvm install'
alias nvm:ui='nvm uninstall'
alias nvm:ri='nvm_reinstall'
alias nvm:u='nvm use'
alias nvm:a:d='nvm alias default'

# Function
function nvm_reinstall() {
  if [[ -n "$1" && -n "$2" ]]; then
    nvm install $1 --reintsall-packages-from=$2 --latest-npm &&
      nvm alias default $1 &&
      nvm use $1
  else
    error "please provide install version and reinstall package (nvm:ri 16.18.1 16.17.0)"
  fi
}
