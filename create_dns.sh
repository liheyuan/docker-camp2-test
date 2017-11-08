#!/bin/bash

TOOL_NODE="node-1"
TOOL_IP=$(docker-machine ip $TOOL_NODE)
REST_URL="http://$TOOL_IP:8080/container/list"

# submit to swarm master node
eval $(docker-machine env $TOOL_NODE)
docker run \
    -p 53:53/udp \
    --env RUN_MODE=rest \
    --env REST_URL=$REST_URL \
    --env IP_PREFIX=10. \
    --detach \
    coder4/rubydns:1.1
