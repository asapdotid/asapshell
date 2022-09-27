#!/bin/bash

__GEXA="$ASAPSHELL_DIR/os/general/aliases/exa.sh"
__GPATH="$ASAPSHELL_DIR/os/general/aliases/path.sh"
__GSYSTEM="$ASAPSHELL_DIR/os/general/aliases/system.sh"
__GDOCKER="$ASAPSHELL_DIR/os/general/aliases/docker.sh"
__GANSIBLE="$ASAPSHELL_DIR/os/general/aliases/ansible.sh"
__GGIT="$ASAPSHELL_DIR/os/general/aliases/git.sh"
__GGIT_FLOW="$ASAPSHELL_DIR/os/general/aliases/git-flow.sh"
__GNVM="$ASAPSHELL_DIR/os/general/aliases/nvm.sh"
__GNPM="$ASAPSHELL_DIR/os/general/aliases/npm.sh"
__GSSH="$ASAPSHELL_DIR/os/general/aliases/ssh.sh"
__GTMUX="$ASAPSHELL_DIR/os/general/aliases/tmux.sh"
__GTMUXINATOR="$ASAPSHELL_DIR/os/general/aliases/tmuxinator.sh"
__GVAGRANT="$ASAPSHELL_DIR/os/general/aliases/vagrant.sh"
__GCOMPOSER="$ASAPSHELL_DIR/os/general/aliases/composer.sh"
__GCUSTOM="$ASAPSHELL_DIR/os/general/aliases/custom.sh"
__GSPOTIFY_TUI="$ASAPSHELL_DIR/os/general/aliases/spotify-tui.sh"
__GENERALFILES=($__GEXA $__GPATH $__GSYSTEM $__GDOCKER $__GANSIBLE $__GGIT $__GGIT_FLOW $__GNVM $__GNPM $__GSSH $__GTMUX $__GTMUXINATOR $__GVAGRANT $__GCOMPOSER $__GCUSTOM $__GSPOTIFY_TUI)

for i in "${__GENERALFILES[@]}"; do
  if [ -f "$i" ]; then
    source "$i"
  else
    error "$i does not exist."
  fi
done
