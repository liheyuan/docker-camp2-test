#!/bin/bash

TOOL_NODE="node-10"
TOOL_IP=$(docker-machine ip $TOOL_NODE)
REST_URL="http://$TOOL_IP:9000/container/list"
NAME="sbmvt_dns"
CONFIG_DIR="./dns_conf"
VOLUME="/home/coder4/docker_data/dns"

# sync config
docker-machine ssh $TOOL_NODE sudo rm -rf $VOLUME
docker-machine ssh $TOOL_NODE sudo mkdir -p $VOLUME
docker-machine ssh $TOOL_NODE sudo chmod -R 777 $VOLUME
docker-machine scp -r $CONFIG_DIR/* $TOOL_NODE:$VOLUME

# submit to swarm master node
eval $(docker-machine env $TOOL_NODE)
docker ps -q -a --filter "name=$NAME" | xargs -I {} docker rm -f {}
docker run \
    --name $NAME \
    -p 53:53/udp \
    --volume $VOLUME:/etc/rubydns \
    --env HOSTS=/etc/rubydns/hosts \
    --env UPSTREAM=8.8.8.8 \
    --env REST_URL=$REST_URL \
    --env IP_PREFIX=10. \
    --detach \
    --restart always \
    coder4/rubydns:1.2
