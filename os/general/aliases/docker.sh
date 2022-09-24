#!/bin/bash
# Docker
# Must be run first because images are attached to containers
alias dc='docker'
alias dc:i='docker info'
alias dc:r='docker rm -f'
alias dc:r:c='docker rm -f $(docker ls -aq)'
alias dc:cl='dc_cleanup'
# Delete every Docker image
alias dc:ri='docker rmi -f'
alias dc:ri:a='docker rmi -f $(docker images -q)'
alias dc:v='docker volume'
alias dc:s='docker system'
alias dc:n='docker network'
alias dc:c='docker container'
alias dc:l='docker ps'
alias dc:la='docker ps -a'
alias dc:prune='docker system prune'
alias dc:x='docker_din'
# Docker Compose
alias dcc='docker-compose'
alias dcc:v='docker-compose --version'
alias dcc:u='docker-compose up -d'
alias dcc:d='docker-compose down -v'
alias dcc:b='docker-compose up -d --build -f'

# Docker CLeanup
function dc_cleanup() {
  docker rm -v $(docker ps --filter status=exited -q 2>/dev/null) 2>/dev/null
  docker rmi $(docker images --filter dangling=true -q 2>/dev/null) 2>/dev/null
}

# Easy container access via din .bashrc/.zshrc helper
function docker_din() {
  filter=$1

  user=""
  if [[ -n "$2" ]]; then
    user="--user $2"
  fi

  shell="bash"
  if [[ -n "$3" ]]; then
    shell=$3
  fi

  prefix=""
  if [[ "$(expr substr $(uname -s) 1 5)" == "MINGW" ]]; then
    prefix="winpty"
  fi
  ${prefix} docker exec -it ${user} $(docker ps --filter name=${filter} -q | head -1) ${shell}
}
