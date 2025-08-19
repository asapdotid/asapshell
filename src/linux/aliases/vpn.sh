#!/bin/bash

# Express VPN
alias vpn:e:-v="expressvpn --version"
alias vpn:e:-h="expressvpn --help"
alias vpn:e:act="expressvpn activate"
alias vpn:e:list="expressvpn list"
alias vpn:e:list:a="expressvpn list all"
alias vpn:e:con="expressvpn connect"
alias vpn:e:con:s="expressvpn connect smart"
alias vpn:e:dis="expressvpn disconnect"
alias vpn:e:refresh="expressvpn resfresh"
alias vpn:e:logout="expressvpn logout"
alias vpn:e:status="expressvpn status"
alias vpn:e:protocol="expressvpn protocol"
alias vpn:e:autocon="expressvpn_autoconnect"
alias vpn:e:track="expressvpn_block_track"
alias vpn:e:diagnostic="expressvpn_send_diagnostics"

# SurfShark VPN
alias vpn:s:-v="sudo surfshark-vpn version"
alias vpn:s:-h="sudo surfshark-vpn help"
alias vpn:s:con="sudo surfshark-vpn"
alias vpn:s:con:a="sudo surfshark-vpn attack"
alias vpn:s:con:m="sudo surfshark-vpn multi"
alias vpn:s:dis="sudo surfshark-vpn down"
alias vpn:s:status="sudo surfshark-vpn status"
alias vpn:s:logout="sudo surfshark-vpn forgot"

# Functions
# ExpressVPN functions
expressvpn_autoconnect() {
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

expressvpn_block_track() {
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

expressvpn_send_diagnostics() {
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
