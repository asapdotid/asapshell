#!/bin/bash
# NVM
alias nvm:v='nvm --version'
alias nvm:l='nvm ls'
alias nvm:l:r='nvm ls-remote --lts'
alias nvm:v:r="nvm version-remote --lts"
alias nvm:i='nvm install'
alias nvm:i:lts="nvm install '\''lts/*'\'' --reintsall-packages-from=default --latest-npm"
alias nvm:u='nvm uninstall'
alias nvm:s='nvm use'
alias nvm:d='nvm alias default'
