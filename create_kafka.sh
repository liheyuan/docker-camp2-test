#!/bin/bash

SWARM_MANAGER_NODE="node-1"
STACK_FILE="./kafka_compose.yaml"
SERVICE_NAME="kafka"

# sync config
docker-machine scp -r $STACK_FILE  $SWARM_MANAGER_NODE:~/

# submit to swarm master node
eval $(docker-machine env $SWARM_MANAGER_NODE)
docker stack deploy -c $STACK_FILE $SERVICE_NAME
