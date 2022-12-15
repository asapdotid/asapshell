#!/bin/bash
# Docker
# Must be run first because images are attached to containers
alias dk='docker'
alias dk:-i='docker info'
alias dk:-v='docker --version'
alias dk:login='docker login'
alias dk:logout='docker logout'
alias dk:config='docker config'
alias dk:image='docker image'
alias dk:images='docker images'
alias dk:exec='docker exec -i -t'
alias dk:logs='docker logs'
alias dk:top='docker top'
alias dk:build='docker build'
alias dk:run='docker run'
alias dk:vol='docker volume'
alias dk:sys='docker system'
alias dk:sys:prune='docker system prune -a --volumes'
alias dk:net='docker network'
alias dk:ps='docker ps'
alias dk:ps:a='docker ps -a'
alias dk:rm:c='docker rm -f -v'
alias dk:rm:i='docker rmi -f'
alias dk:clean='docker_cleanup'
alias dk:in='docker_in_docker'
# Docker container
alias dk:con='docker container'
alias dk:con:exec='docker container exec'
alias dk:con:ls='docker container ls -a'
alias dk:con:rm='docker container rm -f'
alias dk:con:logs='docker container logs'
alias dk:con:prune='docker container prune -f'
# Docker swarm
alias dk:swarm='docker swarm'
# Docker Compose 2.x
alias dk:com='docker compose'
alias dk:com:-v='docker compose version'
alias dk:com:c='docker compose config'
alias dk:com:u='docker compose up'
alias dk:com:d='docker compose down'
alias dk:com:st='docker compose start'
alias dk:com:sp='docker compose stop'
alias dk:com:t='docker compose top'
alias dk:com:x='docker compose exec'
# Docker Compose 1.x
alias dk-com='docker-compose'
alias dk-com:-v='docker-compose --version'
alias dk-com:up='docker-compose up -d'
alias dk-com:down='docker-compose down -v'
alias dk-com:build='docker-compose up -d --build -f'
alias dk-com:logs='docker-compose logs'

# Docker CLeanup
function docker_cleanup() {
  docker rm -v -f $(docker ps --filter status=exited -q 2>/dev/null) 2>/dev/null
  docker rmi -f $(docker images --filter dangling=true -q 2>/dev/null) 2>/dev/null
}

# Easy container access via din .bashrc/.zshrc helper
function docker_in_docker() {
  local filter=$1
  local user=""
  if [[ -n "$2" ]]; then
    user="--user $2"
  fi

  local shell="bash"
  if [[ -n "$3" ]]; then
    shell=$3
  fi

  local prefix=""
  if [[ "$(expr substr $(uname -s) 1 5)" == "MINGW" ]]; then
    prefix="winpty"
  fi
  ${prefix} docker exec -it ${user} $(docker ps --filter name=${filter} -q | head -1) ${shell}
}
