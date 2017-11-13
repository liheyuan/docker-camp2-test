#!/bin/bash

# submit to tool node
NODE="node-1"
NODE_TOOL="node-10"
SERVICE_NAME="sbmvt-test"
dns_ip=$(docker-machine ip $NODE_TOOL)
eval $(docker-machine env $NODE)
docker service rm $SERVICE_NAME 
docker service create \
    --dns $dns_ip \
    --constraint "node.hostname != $NODE_TOOL" \
    --network camp \
    --replicas 4 \
    --name $SERVICE_NAME \
    --hostname="{{.Service.Name}}-{{.Task.Slot}}-test" \
    --entrypoint="sleep 3600" \
    alpine 
