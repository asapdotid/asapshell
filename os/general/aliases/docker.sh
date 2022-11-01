#!/bin/bash
# Docker
# Must be run first because images are attached to containers
alias dc='docker'
alias dc:-i='docker info'
alias dc:-v='docker --version'
alias dc:b='docker build'
alias dc:r='docker run'
alias dc:vol='docker volume'
alias dc:sys='docker system'
alias dc:sys:prune='docker system prune -a --volumes'
alias dc:net='docker network'
alias dc:con='docker container'
alias dc:ps='docker ps'
alias dc:ps:a='docker ps -a'
alias dc:rm:c='docker rm -f'
alias dc:rm:i='docker rmi -f'
alias dc:clean='dc_cleanup'
alias dc:x='docker_din'
# Docker Compose 2.x
alias dc:c='docker compose'
alias dc:c:c='docker compose config'
alias dc:c:u='docker compose up'
alias dc:c:d='docker compose down'
alias dc:c:st='docker compose start'
alias dc:c:sp='docker compose stop'
alias dc:c:t='docker compose top'
alias dc:c:x='docker compose exec'
# Docker Compose 1.x
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
