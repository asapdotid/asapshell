#!/bin/bash

# Initial environment
export ASAPSHELL_DIR="${ASAPSHELL_DIR:-$(asapshell_default_install_dir)}"

# Helpers
source "$ASAPSHELL_DIR/helpers/index.sh"

# Test service
# serviceName=docker

# if { systemctl --all --type service || service --status-all; } 2>/dev/null |
#   grep -q "$serviceName.service"; then
#   echo "$serviceName exists."
# else
#   echo "$serviceName does NOT exist."
# fi
