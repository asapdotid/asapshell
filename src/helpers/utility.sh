#!/usr/bin/env bash

# Print currently active shell
get_shell() {
  ps -p $$ | tail -1 | awk '{print $NF}'
}
