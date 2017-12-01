#!/bin/bash

INFRA_NODE="node-1"
NAME="sbmvt-redis-test"
VOLUME="/home/coder4/docker_data/redis"
PASSWORD="hehehe"
EXTRA_CMD="redis-server --appendonly yes --requirepass $PASSWORD"

# make sure volume valid 
docker-machine ssh $INFRA_NODE "sudo mkdir -p $VOLUME && sudo chmod -R 777 $VOLUME"

# submit to swarm master node
eval $(docker-machine env $INFRA_NODE)
docker ps -q -a --filter "name=$NAME" | xargs -I {} docker rm -f {}
docker run \
    --network camp \
    --hostname $NAME \
    --name $NAME \
    --volume "$VOLUME":/data \
    --detach \
    --restart always \
    redis:4-alpine \
    $EXTRA_CMD
