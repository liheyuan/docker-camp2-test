#!/bin/bash

TOOL_NODE="node-10"
TOOL_IP=$(docker-machine ip $TOOL_NODE)
REST_URL="http://$TOOL_IP:9000/container/list"
NAME="sbmvt_dns"

# submit to swarm master node
eval $(docker-machine env $TOOL_NODE)
docker ps -q --filter "name=$NAME" | xargs -I {} docker rm -f {}
docker run \
    --name $NAME \
    -p 53:53/udp \
    --env RUN_MODE=rest \
    --env REST_URL=$REST_URL \
    --env IP_PREFIX=10. \
    --detach \
    --rm \
    coder4/rubydns:1.1
