#!/bin/bash

alias vpn:-v="expressvpn --version"
alias vpn:-h="expressvpn --help"
alias vpn:act="expressvpn activate"
alias vpn:list="expressvpn list"
alias vpn:list:a="expressvpn list all"
alias vpn:con="expressvpn connect"
alias vpn:con:s="expressvpn connect smart"
alias vpn:dis="expressvpn disconnect"
alias vpn:autocon="expressvpn_autoconnect"
alias vpn:track="expressvpn_block_track"
alias vpn:diagnostic="expressvpn_send_diagnostics"

function expressvpn_autoconnect() {
  if [ -z "$1" ]; then
    error "Please provide true or false"
  else
    if [ "$1" ]; then
      expressvpn autoconnect true
    else
      expressvpn autoconnect false
    fi
  fi
}

function expressvpn_block_track() {
  if [ -z "$1" ]; then
    error "Please provide true or false"
  else
    if [ "$1" ]; then
      expressvpn preferences set block_trackers true
    else
      expressvpn preferences set block_trackers false
    fi
  fi
}

function expressvpn_send_diagnostics() {
  if [ -z "$1" ]; then
    error "Please provide true or false"
  else
    if [ "$1" ]; then
      expressvpn preferences set send_diagnostics true
    else
      expressvpn preferences set send_diagnostics false
    fi
  fi
}
