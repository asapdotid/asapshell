#!/bin/bash
# spotify-tui
alias spot="launchspt"

# Spotify-tui & spotifyd-fpull
function launchspt() {
    if [[ ! $(pgrep "spotifyd") ]]
    then
        spotifyd
    fi

    spt
}
