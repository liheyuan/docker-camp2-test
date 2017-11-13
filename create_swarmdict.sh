#!/bin/bash

# Manager node
TOOL_NODE="node-10"
MANAGER_NODE="node-1"
MANAGER_IP=$(docker-machine ip $MANAGER_NODE)

# submit to swarm master node
eval $(docker-machine env $TOOL_NODE)
docker run \
  -p8080:8080 \
  --env NODE_SWARM_MANAGER=$MANAGER_NODE \
  --env IP_SWARM_MANAGER=$MANAGER_IP \
  --volume /home/coder4/machines:/etc/dsd/machines \
  --detach \
  coder4/swarmdict:1.1

