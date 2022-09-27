#!/usr/bin/env bash

{ # this ensures the entire script is downloaded #

  asapshell_has() {
    type "$1" >/dev/null 2>&1
  }

  asapshell_echo() {
    command printf %s\\n "$*" 2>/dev/null
  }

  if [ -z "${BASH_VERSION}" ] || [ -n "${ZSH_VERSION}" ]; then
    # shellcheck disable=SC2016
    asapshell_echo >&2 'Error: the install instructions explicitly say to pipe the install script to `bash`; please follow them'
    exit 1
  fi

  asapshell_try_profile() {
    if [ -z "${1-}" ] || [ ! -f "${1}" ]; then
      return 1
    fi
    asapshell_echo "${1}"
  }

  asapshell_grep() {
    GREP_OPTIONS='' command grep "$@"
  }

  asapshell_default_install_dir() {
    [ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.asapshell" || printf %s "${XDG_CONFIG_HOME}/asapshell"
  }

  asapshell_install_dir() {
    if [ -n "$ASAPSHELL_DIR" ]; then
      printf %s "${ASAPSHELL_DIR}"
    else
      asapshell_default_install_dir
    fi
  }

  asapshell_profile_is_bash_or_zsh() {
    local TEST_PROFILE
    TEST_PROFILE="${1-}"
    case "${TEST_PROFILE-}" in
    *"/.bashrc" | *"/.bash_profile" | *"/.zshrc")
      return
      ;;
    *)
      return 1
      ;;
    esac
  }

  #
  # Detect profile file if not specified as environment variable
  # (eg: PROFILE=~/.myprofile)
  # The echo'ed path is guaranteed to be an existing file
  # Otherwise, an empty string is returned
  #
  asapshell_detect_profile() {
    if [ "${PROFILE-}" = '/dev/null' ]; then
      # the user has specifically requested NOT to have asapshell touch their profile
      return
    fi

    if [ -n "${PROFILE}" ] && [ -f "${PROFILE}" ]; then
      asapshell_echo "${PROFILE}"
      return
    fi

    local DETECTED_PROFILE
    DETECTED_PROFILE=''

    if [ "${SHELL#*bash}" != "$SHELL" ]; then
      if [ -f "$HOME/.bashrc" ]; then
        DETECTED_PROFILE="$HOME/.bashrc"
      elif [ -f "$HOME/.bash_profile" ]; then
        DETECTED_PROFILE="$HOME/.bash_profile"
      fi
    elif [ "${SHELL#*zsh}" != "$SHELL" ]; then
      if [ -f "$HOME/.zshrc" ]; then
        DETECTED_PROFILE="$HOME/.zshrc"
      fi
    fi

    if [ -z "$DETECTED_PROFILE" ]; then
      for EACH_PROFILE in ".profile" ".bashrc" ".bash_profile" ".zshrc"; do
        if DETECTED_PROFILE="$(asapshell_try_profile "${HOME}/${EACH_PROFILE}")"; then
          break
        fi
      done
    fi

    if [ -n "$DETECTED_PROFILE" ]; then
      asapshell_echo "$DETECTED_PROFILE"
    fi
  }

  asapshell_latest_version() {
    asapshell_echo "main"
  }

  install_asapshell_from_git() {
    local INSTALL_DIR
    INSTALL_DIR="$(asapshell_install_dir)"
    local ASAPSHELL_VERSION
    ASAPSHELL_VERSION="${ASAPSHELL_INSTALL_VERSION:-$(asapshell_latest_version)}"
    local ASAPSHELL_SOURCE_URL
    ASAPSHELL_SOURCE_URL="https://raw.githubusercontent.com/asapdotid/asapshell/${ASAPSHELL_VERSION}/install.sh"
    if [ -n "${ASAPSHELL_INSTALL_VERSION:-}" ]; then
      # Check if version is an existing ref
      if command git ls-remote "$ASAPSHELL_SOURCE_URL" "$ASAPSHELL_VERSION" | asapshell_grep -q "$ASAPSHELL_VERSION"; then
        :
      # Check if version is an existing changeset
      elif ! asapshell_download -o /dev/null "$ASAPSHELL_SOURCE_URL"; then
        asapshell_echo >&2 "Failed to find '$ASAPSHELL_VERSION' version."
        exit 1
      fi
    fi

    local fetch_error
    if [ -d "$INSTALL_DIR/.git" ]; then
      # Updating repo
      asapshell_echo "=> asapshell is already installed in $INSTALL_DIR, trying to update using git"
      command printf '\r=> '
      fetch_error="Failed to update asapshell with $ASAPSHELL_VERSION, run 'git fetch' in $INSTALL_DIR yourself."
    else
      fetch_error="Failed to fetch origin with $ASAPSHELL_VERSION. Please report this!"
      asapshell_echo "=> Downloading asapshell from git to '$INSTALL_DIR'"
      command printf '\r=> '
      mkdir -p "${INSTALL_DIR}"
      if [ "$(ls -A "${INSTALL_DIR}")" ]; then
        # Initializing repo
        command git init "${INSTALL_DIR}" || {
          asapshell_echo >&2 'Failed to initialize asapshell repo. Please report this!'
          exit 2
        }
        command git --git-dir="${INSTALL_DIR}/.git" remote add origin "$ASAPSHELL_SOURCE_URL" 2>/dev/null ||
          command git --git-dir="${INSTALL_DIR}/.git" remote set-url origin "$ASAPSHELL_SOURCE_URL" || {
          asapshell_echo >&2 'Failed to add remote "origin" (or set the URL). Please report this!'
          exit 2
        }
      else
        # Cloning repo
        command git clone "$ASAPSHELL_SOURCE_URL" --depth=1 "${INSTALL_DIR}" || {
          asapshell_echo >&2 'Failed to clone asapsahell repo. Please report this!'
          exit 2
        }
      fi
    fi
    # Try to fetch tag
    if command git --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" fetch origin tag "$ASAPSHELL_VERSION" --depth=1 2>/dev/null; then
      :
    # Fetch given version
    elif ! command git --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" fetch origin "$ASAPSHELL_VERSION" --depth=1; then
      asapshell_echo >&2 "$fetch_error"
      exit 1
    fi
    command git -c advice.detachedHead=false --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" checkout -f --quiet FETCH_HEAD || {
      asapshell_echo >&2 "Failed to checkout the given version $ASAPSHELL_VERSION. Please report this!"
      exit 2
    }
    if [ -n "$(command git --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" show-ref refs/heads/main)" ]; then
      if command git --no-pager --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" branch --quiet 2>/dev/null; then
        command git --no-pager --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" branch --quiet -D main >/dev/null 2>&1
      else
        asapshell_echo >&2 "Your version of git is out of date. Please update it!"
        command git --no-pager --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" branch -D main >/dev/null 2>&1
      fi
    fi

    asapshell_echo "=> Compressing and cleaning up git repository"
    if ! command git --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" reflog expire --expire=now --all; then
      asapshell_echo >&2 "Your version of git is out of date. Please update it!"
    fi
    if ! command git --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" gc --auto --aggressive --prune=now; then
      asapshell_echo >&2 "Your version of git is out of date. Please update it!"
    fi
    return
  }

  asapshell_do_install() {
    if [ -n "${ASAPSHELL_DIR-}" ] && ! [ -d "${ASAPSHELL_DIR}" ]; then
      if [ -e "${ASAPSHELL_DIR}" ]; then
        asapshell_echo >&2 "File \"${ASAPSHELL_DIR}\" has the same name as installation directory."
        exit 1
      fi

      if [ "${ASAPSHELL_DIR}" = "$(asapshell_default_install_dir)" ]; then
        mkdir "${ASAPSHELL_DIR}"
      else
        asapshell_echo >&2 "You have \$ASAPSHELL_DIR set to \"${ASAPSHELL_DIR}\", but that directory does not exist. Check your profile files and environment."
        exit 1
      fi
    fi

    if ! asapshell_has git; then
      asapshell_echo >&2 "You need git to install asapshell"
      exit 1
    fi
    install_asapshell_from_git

    asapshell_echo

    local ASAPSHELL_PROFILE
    ASAPSHELL_PROFILE="$(asapshell_detect_profile)"
    local PROFILE_INSTALL_DIR
    PROFILE_INSTALL_DIR="$(asapshell_install_dir | command sed "s:^$HOME:\$HOME:")"

    SOURCE_STR="\\nexport ASAPSHELL_DIR=\"${PROFILE_INSTALL_DIR}\"\\n[ -s \"\$ASAPSHELL_DIR/aliases\" ] && \\. \"\$ASAPSHELL_DIR/aliases\"  # This loads asapshell\\n"

    # shellcheck disable=SC2016
    COMPLETION_STR='[ -s "$ASAPSHELL_DIR/bash_completion" ] && \. "$ASAPSHELL_DIR/bash_completion"  # This loads aliases bash_completion\n'
    BASH_OR_ZSH=false

    if [ -z "${ASAPSHELL_PROFILE-}" ]; then
      local TRIED_PROFILE
      if [ -n "${PROFILE}" ]; then
        TRIED_PROFILE="${ASAPSHELL_PROFILE} (as defined in \$PROFILE), "
      fi
      asapshell_echo "=> Profile not found. Tried ${TRIED_PROFILE-}~/.bashrc, ~/.bash_profile, ~/.zshrc, and ~/.profile."
      asapshell_echo "=> Create one of them and run this script again"
      asapshell_echo "   OR"
      asapshell_echo "=> Append the following lines to the correct file yourself:"
      command printf "${SOURCE_STR}"
      asapshell_echo
    else
      if asapshell_profile_is_bash_or_zsh "${ASAPSHELL_PROFILE-}"; then
        BASH_OR_ZSH=true
      fi
      if ! command grep -qc '/aliases' "$ASAPSHELL_PROFILE"; then
        asapshell_echo "=> Appending asapshell source string to $ASAPSHELL_PROFILE"
        command printf "${SOURCE_STR}" >>"$ASAPSHELL_PROFILE"
      else
        asapshell_echo "=> asapshell source string already in ${ASAPSHELL_PROFILE}"
      fi
      # shellcheck disable=SC2016
      if ${BASH_OR_ZSH} && ! command grep -qc '$ASAPSHELL_DIR/bash_completion' "$ASAPSHELL_PROFILE"; then
        asapshell_echo "=> Appending bash_completion source string to $ASAPSHELL_PROFILE"
        command printf "$COMPLETION_STR" >>"$ASAPSHELL_PROFILE"
      else
        asapshell_echo "=> bash_completion source string already in ${ASAPSHELL_PROFILE}"
      fi
    fi
    if ${BASH_OR_ZSH} && [ -z "${ASAPSHELLPROFILE-}" ]; then
      asapshell_echo "=> Please also append the following lines to the if you are using bash/zsh shell:"
      command printf "${COMPLETION_STR}"
    fi

  }

  asapshell_reset() {
    unset -f asapshell_has asapshell_install_dir asapshell_latest_version asapshell_profile_is_bash_or_zsh \
      asapshell_download install_asapshell_from_git \
      asapshell_try_profile asapshell_detect_profile \
      asapshell_do_install asapshell_reset asapshell_default_install_dir asapshell_grep
  }

  [ "_$ASAPSHELL_ENV" = "_testing" ] || asapshell_do_install

} # this ensures the entire script is downloaded #
