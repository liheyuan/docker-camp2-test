#!/bin/bash

# submit to tool node
NODE="node-1"
NODE_TOOL="node-1"
dns_ip=$(docker-machine ip $NODE_TOOL)
eval $(docker-machine env $NODE)
docker service create \
    --dns $dns_ip \
    --network camp \
    --replicas 3 \
    --name sbmvt-test \
    --hostname="{{.Service.Name}}-{{.Task.Slot}}-test" \
    --entrypoint="sleep 3600" \
    alpine 
