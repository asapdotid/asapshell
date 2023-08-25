#!/bin/bash
# Docker
# Must be run first because images are attached to containers
alias dc='docker'
alias dc:-i='docker info'
alias dc:-v='docker --version'
alias dc:-h='docker --help'
alias dc:login='docker login'
alias dc:logout='docker logout'
alias dc:config='docker config'
alias dc:image='docker image'
alias dc:images='docker images'
alias dc:exec='docker exec -i -t'
alias dc:logs='docker logs'
alias dc:top='docker top'
alias dc:build='docker build'
alias dc:run='docker run'
alias dc:vol='docker volume'
alias dc:sys='docker system'
alias dc:ps='docker ps'
alias dc:ps:a='docker ps -a'
alias dc:rm:c='docker rm -f -v'
alias dc:rm:i='docker rmi -f'
alias dc:clean='docker_cleanup'
alias dc:prune='docker system prune -a --volumes -f'
alias dc:in='docker_in_docker'
# Docker network
alias dc:net='docker network'
alias dc:net:-h='docker network --help'
# Docker image
alias dc:img='docker image'
alias dc:img:-h='docker image --help'
alias dc:img:ls='docker image ls'
alias dc:img:pull='docker image pull'
alias dc:img:push='docker image push'
alias dc:img:rm='docker image rm -f'
alias dc:img:inspect='docker image inspect -f'
alias dc:img:prune='docker image prune -f'
# Docker container
alias dc:con='docker container'
alias dc:con:-h='docker container --help'
alias dc:con:ls='docker container ls -a'
alias dc:con:rm='docker container rm -f'
alias dc:con:logs='docker container logs'
alias dc:con:exec='docker container exec'
alias dc:con:top='docker container top'
alias dc:con:prune='docker container prune -f'
# Docker swarm
alias dc:swarm='docker swarm'
# Docker Compose 2.x
alias dc:com='docker compose'
alias dc:com:-h='docker compose --help'
alias dc:com:-v='docker compose version'
alias dc:com:c='docker compose config'
alias dc:com:u='docker compose up -d'
alias dc:com:d='docker compose down --remove-orphans -v'
alias dc:com:st='docker compose start'
alias dc:com:sp='docker compose stop'
alias dc:com:run='docker compose run'
alias dc:com:pause='docker compose pause'
alias dc:com:top='docker compose top'
alias dc:com:exec='docker compose exec'
# Docker Compose 1.x
alias dc-com='docker-compose'
alias dc-com:-h='docker-compose --help'
alias dc-com:-v='docker-compose --version'
alias dc-com:u='docker-compose up -d'
alias dc-com:d='docker-compose down --remove-orphans -v'
alias dc-com:build='docker-compose up -d --build -f'
alias dc-com:logs='docker-compose logs'

# Functions
# Docker CLeanup
docker_cleanup() {
  docker rm -v -f $(docker ps --filter status=exited -q 2>/dev/null) 2>/dev/null
  docker rmi -f $(docker images --filter dangling=true -q 2>/dev/null) 2>/dev/null
}

# Easy container access via din .bashrc/.zshrc helper
docker_in_docker() {
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
