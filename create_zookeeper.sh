#!/bin/bash

INFRA_NODE="node-1"
NAME="sbmvt-zk-test"

# submit to swarm master node
eval $(docker-machine env $INFRA_NODE)
docker ps -q -a --filter "name=$NAME" | xargs -I {} docker rm -f {}
docker run \
    --network camp \
    --hostname $NAME \
    --name $NAME \
    --detach \
    --restart always \
    zookeeper:3.5
