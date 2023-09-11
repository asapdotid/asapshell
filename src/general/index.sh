#!/bin/bash

__GENERALFILES=(
  "$_SOURCE_FILE/general/aliases/exa.sh"
  "$_SOURCE_FILE/general/aliases/path.sh"
  "$_SOURCE_FILE/general/aliases/system.sh"
  "$_SOURCE_FILE/general/aliases/docker.sh"
  "$_SOURCE_FILE/general/aliases/ansible.sh"
  "$_SOURCE_FILE/general/aliases/git.sh"
  "$_SOURCE_FILE/general/aliases/git-flow.sh"
  "$_SOURCE_FILE/general/aliases/nvm.sh"
  "$_SOURCE_FILE/general/aliases/npm.sh"
  "$_SOURCE_FILE/general/aliases/ssh.sh"
  "$_SOURCE_FILE/general/aliases/tmux.sh"
  "$_SOURCE_FILE/general/aliases/tmuxinator.sh"
  "$_SOURCE_FILE/general/aliases/vagrant.sh"
  "$_SOURCE_FILE/general/aliases/terraform.sh"
  "$_SOURCE_FILE/general/aliases/terragrunt.sh"
  "$_SOURCE_FILE/general/aliases/molecule.sh"
  "$_SOURCE_FILE/general/aliases/composer.sh"
  "$_SOURCE_FILE/general/aliases/custom.sh"
  "$_SOURCE_FILE/general/aliases/spotify-tui.sh"
  "$_SOURCE_FILE/general/aliases/gpg.sh"
  "$_SOURCE_FILE/general/aliases/google-cli.sh"
  "$_SOURCE_FILE/general/aliases/utility.sh"
  "$_SOURCE_FILE/general/aliases/bun.sh"
)

for i in "${__GENERALFILES[@]}"; do
  if [ -f "$i" ]; then
    source "$i"
  else
    error "$i does not exist."
  fi
done
