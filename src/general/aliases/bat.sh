#!/usr/bin/env bash

export MANPAGER="sh -c 'col -bx | bat -l man -p'"

alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

# Git Diff using bat-extras (https://github.com/sharkdp/bat && https://github.com/eth-p/bat-extras)
alias diff='batdiff --delta --color --staged'

alias bat:build='bat cache --build'
alias bat:clean='bat cache --clean'
