#!/bin/bash

INFRA_NODE="node-1"
NAME="sbmvt-memcached-test"
MEMORY_LIMIT="256"
EXTRA_CMD="memcached -m $MEMORY_LIMIT"

# submit to swarm master node
eval $(docker-machine env $INFRA_NODE)
docker ps -q -a --filter "name=$NAME" | xargs -I {} docker rm -f {}
docker run \
    --network camp \
    --hostname $NAME \
    --name $NAME \
    --detach \
    --restart always \
    -d memcached:1.5-alpine \
    $EXTRA_CMD
