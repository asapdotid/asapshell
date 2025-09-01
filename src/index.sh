#!/usr/bin/env bash

# Config
# shellcheck source=/dev/null
function include_aliases() {
  local __DIR=$1
  local __SOURCE_DIR="$__DIR/src"
  if [ -d "$__DIR" ] && [ -d "$__SOURCE_DIR" ]; then
    source "$__SOURCE_DIR/config/index.sh"
    source "$__SOURCE_DIR/helpers/index.sh"
    source "$__SOURCE_DIR/general/index.sh"
  else
    error "$__DIR does not exist."
    return 1
  fi
}

function publish_aliases() {
  local __DIR=$1
  local __SOURCE_DIR="$__DIR/src"
  if [ -d "$__DIR" ] && [ -d "$__SOURCE_DIR" ]; then
    load_config "$__SOURCE_DIR"
    load_environments "$__DIR"
    load_helpers "$__SOURCE_DIR"
    general_aliases "$__SOURCE_DIR"
    load_based_on_os "$__SOURCE_DIR"
  else
    error "$__DIR does not exist."
    return 1
  fi
}

function load_based_on_os() {
  local __myos
  local __SOURCE_DIR=$1
  __myos=$(uname -s)
  if [ -d "$__SOURCE_DIR" ]; then
    ### add alias as per os using $_myos ###
    case $__myos in
    Linux)
      source "$__SOURCE_DIR/linux/index.sh"
      linux_aliases "$__SOURCE_DIR"
      ;;
    Darwin)
      source "$__SOURCE_DIR/darwin/index.sh"
      darwin_aliases "$__SOURCE_DIR"
      ;;
    *) ;;
    esac
  else
    error "$__SOURCE_DIR does not exist."
    return 1
  fi
}
