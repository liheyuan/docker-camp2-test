#!/bin/bash

TOOL_NODE="node-10"
NAME="sbmvt_nginx"
CONFIG_DIR="nginx_confd"
VOLUME="/home/coder4/docker_data/nginx"

# sync config
docker-machine ssh $TOOL_NODE sudo rm -rf $VOLUME/$CONFIG_DIR
docker-machine ssh $TOOL_NODE sudo mkdir -p $VOLUME/$CONFIG_DIR
docker-machine ssh $TOOL_NODE sudo chmod -R 777 $VOLUME
docker-machine scp -r $CONFIG_DIR $TOOL_NODE:$VOLUME

# submit to swarm master node
eval $(docker-machine env $TOOL_NODE)
docker ps -q --filter "name=$NAME" | xargs -I {} docker rm -f {}
docker run \
    --name $NAME \
    -v $VOLUME/$CONFIG_DIR:/etc/nginx/conf.d/:ro \
    -p 80:80/tcp \
    --detach \
    --restart always \
    nginx:1.12-alpine
