#!/bin/bash

alias vg='vagrant'
alias vg:-v='vagrant version'
alias vg:-h='vagrant --help'
alias vg:i='vagrant init'
alias vg:up='vagrant up'
alias vg:ds='vagrant destroy -f'
alias vg:ssh='vagrant ssh'
alias vg:sshc='vagrant ssh-config'
alias vg:rdp='vagrant rdp'
alias vg:h='vagrant halt'
alias vg:sp='vagrant suspend'
alias vg:s='vagrant status'
alias vg:re='vagrant resume'
alias vg:gs='vagrant global-status'
alias vg:pr='vagrant provisioning'
alias vg:r='vagrant reload'
alias vg:r:pr='vagrant reload --provisioning'
alias vg:ps='vagrant push'
alias vg:sh='vagrant share'
alias vg:b='vagrant box'
alias vg:b:a='vagrant_box_add'
alias vg:b:r='vagrant_box_remove'
alias vg:b:ra='vagrant_box_remove_all'
alias vg:b:l='vagrant box list'
alias vg:b:o='vagrant box outdated --global'
alias vg:b:u='vagrant_box_update'
alias vg:b:ua='vagrant box update --box --all'
alias vg:b:prune='vagrant box prune'
alias vg:p='vagrant plugin'
alias vg:p:i='vagrant plugin install'
alias vg:p:ui='vagrant plugin uninstall'
alias vg:p:l='vagrant plugin list'
alias vg:p:u='vagrant plugin update'
alias vg:port='vagrant port'

# Vagrant default provider
[[ -s "$VAGRANT_DEFAULT_PROVIDER" ]] && export VAGRANT_DEFAULT_PROVIDER

# Functions
function vagrant_box_add() {
  local _box=$1
  local _ver=$2
  if [[ -z "$_box" ]]; then
    info "Please, provide box name!"
  else
    if [[ -z "$_ver" ]]; then
      vagrant box add "$_box"
    else
      vagrant box add "$_box" --box-version "$_ver"
    fi
  fi
}

function vagrant_box_update() {
  local _box=$1
  local _ver=$2
  if [[ -z "$_box" ]]; then
    info "Please, provide box name!"
  else
    if [[ -z "$_ver" ]]; then
      vagrant box update --box "$_box"
    else
      vagrant box update --box "$_box" --box-version "$_ver"
    fi
  fi
}

function vagrant_box_remove() {
  local _box=$1
  local _ver=$2
  if [[ -z "$_box" ]]; then
    info "Please, provide box name!"
  else
    if [[ -z "$_ver" ]]; then
      vagrant box remove "$_box"
    else
      vagrant box remove "$_box" --box-version "$_ver"
    fi
  fi
}

function vagrant_box_remove_all() {
  vagrant box list | cut -f 1 -d ' ' | xargs -L 1 vagrant box remove -f
}
