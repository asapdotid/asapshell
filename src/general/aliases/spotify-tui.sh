#!/bin/bash
# spotify-tui
alias spot="launchspt"

# Functions
# Spotify-tui & spotifyd-fpull
launchspt() {
  if [[ ! $(pgrep "spotifyd") ]]; then
    spotifyd --no-daemon
  fi
  spt
}
