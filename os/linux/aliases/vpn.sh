#!/bin/bash

// ExpressVPN
alias vpn:e:-v="expressvpn --version"
alias vpn:e:-h="expressvpn --help"
alias vpn:e:act="expressvpn activate"
alias vpn:e:list="expressvpn list"
alias vpn:e:list:a="expressvpn list all"
alias vpn:e:con="expressvpn connect"
alias vpn:e:con:s="expressvpn connect smart"
alias vpn:e:dis="expressvpn disconnect"
alias vpn:e:autocon="expressvpn_autoconnect"
alias vpn:e:track="expressvpn_block_track"
alias vpn:e:diagnostic="expressvpn_send_diagnostics"

// ExpressVPN functions
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
