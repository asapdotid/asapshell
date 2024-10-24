#!/bin/bash
# spotify-tui
alias spot="launchspt"

# Functions
# Spotify-tui & spotifyd
launchspt() {
  local SERVICE="spotifyd"
  if [ ! $(pgrep -x "$SERVICE") ]
  then
    spotifyd
  fi
  spt
}
