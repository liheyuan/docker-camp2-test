#!/bin/bash

TOOL_NODE="node-10"
NAME="docker_registry"
VOLUME="/home/coder4/docker_data/docker_registry"
VOLUME_REGISTRY="$VOLUME/registry"
VOLUME_AUTH="$VOLUME/auth"

# sync config
docker-machine ssh $TOOL_NODE "sudo mkdir -p $VOLUME_REGISTRY && sudo chmod -R 777 $VOLUME_REGISTRY"

# submit to swarm master node
eval $(docker-machine env $TOOL_NODE)
docker ps -q -a --filter "name=$NAME" | xargs -I {} docker rm -f {}
docker run \
    --name $NAME \
    -p 5000:5000 \
    -v $VOLUME_AUTH:/auth \
    -v $VOLUME_REGISTRY:/var/lib/registry \
    --env REGISTRY_STORAGE_DELETE_ENABLED=true \
    --detach \
    --restart always \
    registry:2.6.2
