#!/bin/bash

__GENERALFILES=(
  "$ASAPSHELL_DIR/os/general/aliases/exa.sh"
  "$ASAPSHELL_DIR/os/general/aliases/path.sh"
  "$ASAPSHELL_DIR/os/general/aliases/system.sh"
  "$ASAPSHELL_DIR/os/general/aliases/docker.sh"
  "$ASAPSHELL_DIR/os/general/aliases/ansible.sh"
  "$ASAPSHELL_DIR/os/general/aliases/git.sh"
  "$ASAPSHELL_DIR/os/general/aliases/git-flow.sh"
  "$ASAPSHELL_DIR/os/general/aliases/nvm.sh"
  "$ASAPSHELL_DIR/os/general/aliases/npm.sh"
  "$ASAPSHELL_DIR/os/general/aliases/ssh.sh"
  "$ASAPSHELL_DIR/os/general/aliases/tmux.sh"
  "$ASAPSHELL_DIR/os/general/aliases/tmuxinator.sh"
  "$ASAPSHELL_DIR/os/general/aliases/vagrant.sh"
  "$ASAPSHELL_DIR/os/general/aliases/terraform.sh"
  "$ASAPSHELL_DIR/os/general/aliases/terragrunt.sh"
  "$ASAPSHELL_DIR/os/general/aliases/molecule.sh"
  "$ASAPSHELL_DIR/os/general/aliases/composer.sh"
  "$ASAPSHELL_DIR/os/general/aliases/custom.sh"
  "$ASAPSHELL_DIR/os/general/aliases/spotify-tui.sh"
  "$ASAPSHELL_DIR/os/general/aliases/gpg.sh"
  "$ASAPSHELL_DIR/os/general/aliases/google-cli.sh"
  "$ASAPSHELL_DIR/os/general/aliases/utility.sh"
)

for i in "${__GENERALFILES[@]}"; do
  if [ -f "$i" ]; then
    source "$i"
  else
    error "$i does not exist."
  fi
done
