#!/bin/bash
# Docker
# Must be run first because images are attached to containers
alias dc='docker'
alias dc:-v='docker --version'
alias dc:-h='docker --help'
alias dc:i='docker info'
alias dc:lin='docker login'
alias dc:lout='docker logout'
alias dc:conf='docker config'
alias dc:pl='docker pull'
alias dc:ps='docker push'
alias dc:img='docker image'
alias dc:imgs='docker images'
alias dc:exec='docker exec -i -t'
alias dc:logs='docker logs'
alias dc:top='docker top'
alias dc:build='docker build'
alias dc:run='docker run'
alias dc:vol='docker volume'
alias dc:sys='docker system'
alias dc:ps='docker ps'
alias dc:ps:a='docker ps -a'
alias dc:is='docker inspect'
alias dc:rm:c='docker rm -f -v'
alias dc:rm:i='docker rmi -f'
alias dc:clean='docker_cleanup'
alias dc:prune='docker system prune -a --volumes -f'
alias dc:in='docker_in_docker'

# Docker network
alias dc:net:-h='docker network --help'
alias dc:net='docker network'
alias dc:net:l='docker network ls'
alias dc:net:c='docker network create'
alias dc:net:con='docker network connetc'
alias dc:net:dis='docker network disconnect'
alias dc:net:is='docker network inspect'
alias dc:net:p='docker network prune'
alias dc:net:l='docker network ls'
alias dc:net:r='docker network rm'

# Docker node
alias dc:node='docker node'
alias dc:node:l='docker node ls'
alias dc:node:r='docker node rm'
alias dc:node:p='docker node prune'
alias dc:node:u='docker node update'
alias dc:node:is='docker node inspect'
alias dc:node:ps='docker node ps'
alias dc:node:pr='docker node promote'
alias dc:node:dm='docker node demode'

# Docker service
alias dc:svc='docker service'
alias dc:svc:-h='docker service --help'
alias dc:svc:l='docker service ls'
alias dc:svc:r='docker service rm'
alias dc:svc:p='docker service prune'
alias dc:svc:is='docker service inspect'
alias dc:svc:ps='docker service ps'
alias dc:svc:c='docker service create'
alias dc:svc:rb='docker service rollback'
alias dc:svc:s='docker service scale'
alias dc:svc:u='docker service update'

# Docker secret
alias dc:sec='docker secret'
alias dc:sec:-h='docker secret --help'
alias dc:sec:l='docker secret ls'
alias dc:sec:r='docker secret rm'
alias dc:sec:c='docker secret create'
alias dc:sec:is='docker secret inspect'

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

# Docker Compose 2.x
alias dcc='docker compose'
alias dcc:-h='docker compose --help'
alias dcc:-v='docker compose version'
alias dcc:c='docker compose config'
alias dcc:u='docker compose up -d'
alias dcc:d='docker compose down --remove-orphans -v'
alias dcc:st='docker compose start'
alias dcc:sp='docker compose stop'
alias dcc:run='docker compose run'
alias dcc:pause='docker compose pause'
alias dcc:top='docker compose top'
alias dcc:exec='docker compose exec'

# Docker swarm
alias dc:sw='docker swarm'
alias dc:sw:-h='docker swarm --help'
alias dc:sw:i='docker swarm init'
alias dc:sw:ca='docker swarm ca'
alias dc:sw:u='docker swarm update'
alias dc:sw:l='docker swarm leave'
alias dc:sw:j='docker swarm join'
alias dc:sw:jt='docker swarm join-token'
alias dc:sw:ul='docker swarm unlock'
alias dc:sw:ulk='docker swarm unlock-key'

# Docker context
alias dc:ctx='docker context'
alias dc:ctx:-h='docker context --help'
alias dc:ctx:l='docker context ls'
alias dc:ctx:r='docker context rm'
alias dc:ctx:u='docker context update'
alias dc:ctx:use='docker context use'
alias dc:ctx:s='docker context show'
alias dc:ctx:c='docker context create'
alias dc:ctx:e='docker context export'
alias dc:ctx:i='docker context import'
alias dc:ctx:is='docker context inspect'

# Functions
# Docker CLeanup
docker_cleanup() {
  docker rm -v -f "$(docker ps --filter status=exited -q 2>/dev/null)" 2>/dev/null
  docker rmi -f "$(docker images --filter dangling=true -q 2>/dev/null)" 2>/dev/null
}

# Easy container access via din .bashrc/.zshrc helper
docker_in_docker() {
  local filter=$1
  local user=""
  local kernel
  local ex
  if [[ -n "$2" ]]; then
    user="--user $2"
  fi

  local shell="bash"
  if [[ -n "$3" ]]; then
    shell=$3
  fi

  local prefix=""
  kernel=$(uname -s)
  if [[ "${kernel#####*}" == "MINGW" ]]; then
    prefix="winpty"
  fi
  ex=$(docker ps --filter name="$filter" -q | head -1)
  ${prefix} docker exec -it "$user" "$ex" "$shell"
}

docker_swarm_init() {
  local advertise_addr
  local listen_addr
  advertise_addr=${1:-0.0.0.0}
  listen_addr=${2:-0.0.0.0}
  docker swarm init --advertise-addr "$advertise_addr" --listen-addr "$listen_addr"
}
