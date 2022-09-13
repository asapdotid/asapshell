#!/bin/bash

# Test service
serviceName=docker

if { systemctl --all --type service || service --status-all; } 2>/dev/null |
  grep -q "$serviceName.service"; then
  echo "$serviceName exists."
else
  echo "$serviceName does NOT exist."
fi
