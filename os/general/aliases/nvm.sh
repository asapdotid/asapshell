#!/bin/bash
# NVM
alias nvm:-v='nvm --version'
alias nvm:l='nvm ls'
alias nvm:l:r='nvm ls-remote --lts'
alias nvm:v:r="nvm version-remote --lts"
alias nvm:i='nvm install'
alias nvm:i:lts="nvm install '\''lts/*'\'' --reintsall-packages-from=default --latest-npm"
alias nvm:ui='nvm uninstall'
alias nvm:u='nvm use'
alias nvm:a:d='nvm alias default'
