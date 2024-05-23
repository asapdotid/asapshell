#!/bin/bash

function general_aliases() {
  local __SOURCE_DIR=$1
  if [ -d "$__SOURCE_DIR" ]; then
    local __GENERALFILES=(
      "$__SOURCE_DIR/general/aliases/eza.sh"
      "$__SOURCE_DIR/general/aliases/path.sh"
      "$__SOURCE_DIR/general/aliases/system.sh"
      "$__SOURCE_DIR/general/aliases/docker.sh"
      "$__SOURCE_DIR/general/aliases/ansible.sh"
      "$__SOURCE_DIR/general/aliases/git.sh"
      "$__SOURCE_DIR/general/aliases/git-flow.sh"
      "$__SOURCE_DIR/general/aliases/nvm.sh"
      "$__SOURCE_DIR/general/aliases/npm.sh"
      "$__SOURCE_DIR/general/aliases/ssh.sh"
      "$__SOURCE_DIR/general/aliases/tmux.sh"
      "$__SOURCE_DIR/general/aliases/tmuxinator.sh"
      "$__SOURCE_DIR/general/aliases/vagrant.sh"
      "$__SOURCE_DIR/general/aliases/terraform.sh"
      "$__SOURCE_DIR/general/aliases/terragrunt.sh"
      "$__SOURCE_DIR/general/aliases/molecule.sh"
      "$__SOURCE_DIR/general/aliases/composer.sh"
      "$__SOURCE_DIR/general/aliases/custom.sh"
      "$__SOURCE_DIR/general/aliases/spotify-tui.sh"
      "$__SOURCE_DIR/general/aliases/gpg.sh"
      "$__SOURCE_DIR/general/aliases/google-cli.sh"
      "$__SOURCE_DIR/general/aliases/utility.sh"
      "$__SOURCE_DIR/general/aliases/bun.sh"
      "$__SOURCE_DIR/general/aliases/laravel.sh"
    )

    for i in "${__GENERALFILES[@]}"; do
      if [ -f "$i" ]; then
        # shellcheck source=/dev/null
        source "$i"
      else
        error "$i does not exist."
      fi
    done
  else
    error "$__SOURCE_DIR does not exist."
    return 1
  fi
}
