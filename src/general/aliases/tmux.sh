#!/usr/bin/env bash
# Tmux
alias tx='tmux'
alias tx:i='tmux info'
alias tx:a='tmux attach -t'
alias tx:n='tmux new -s'
alias tx:n:a='tmux new-session -A -s'
alias tx:ls='tmux list-sessions'
alias tx:ks='tmux_kill_session_by_name'
alias tx:ks:c='tmux_kill_session_all_but_current'
alias tx:ks:a='tmux_kill_all_session'
alias tx:K='tmux_kill_server'

# Functions
tmux_kill_session_by_name() {
  tmux kill-session -t "$1"
}

tmux_kill_session_all_but_current() {
  tmux kill-session -a -t "$1"
}

tmux_kill_all_session() {
  # install moreutils
  tmux list-sessions | awk 'BEGIN{FS=":"}{print $1}' | ifne xargs -n 1 tmux kill-session -t
}

tmux_kill_server() {
  pkill -f tmux
}
