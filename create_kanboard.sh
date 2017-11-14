#!/bin/bash

TOOL_NODE="node-10"
NAME="sbmvt_kanboard"
VOLUME="/home/coder4/docker_data/kanboard"
VOLUME_DATA="$VOLUME/data"
VOLUME_PLUGIN="$VOLUME/plugin"

# make sure volume valid 
docker-machine ssh $TOOL_NODE "sudo mkdir -p $VOLUME_DATA && sudo chmod -R 777 $VOLUME_DATA"
docker-machine ssh $TOOL_NODE "sudo mkdir -p $VOLUME_PLUGIN && sudo chmod -R 777 $VOLUME_PLUGIN"

# submit to swarm master node
eval $(docker-machine env $TOOL_NODE)
docker ps -q --filter "name=$NAME" | xargs -I {} docker rm -f {}
docker run \
    --name $NAME \
    --volume "$VOLUME_DATA":/var/www/app/data \
    --volume "$VOLUME_PLUGIN":/var/www/app/plugins \
    -p 9003:80 \
    --detach \
    --rm \
    kanboard/kanboard:v1.0.48
