#!/bin/bash

# Leave all swarm nodes
for node in $(ls nodes);do
    eval $(docker-machine env $node)
    docker swarm leave --force
done

# Const
SWARM_MANAGER_NODE="node-1"
SWARM_MANAGER_IP=$(docker-machine ip $SWARM_MANAGER_NODE)
SWARM_SECOND_MANAGER_NODE="node-2"
SWARM_TOOL_NODE="node-10"

# Set node-1 as manager
eval $(docker-machine env $SWARM_MANAGER_NODE)
docker swarm init \
    --advertise-addr $(docker-machine ip $SWARM_MANAGER_NODE)

# Get token
SWARM_MANAGER_TOKEN=$(docker swarm join-token -q manager)
SWARM_WORKER_TOKEN=$(docker swarm join-token -q worker)

# Join other node
for node in `ls nodes`;do

    if [ x"$node" == x"$SWARM_MANAGER_NODE" ];then
        continue
    fi

    # Join node as worker 
    eval $(docker-machine env $node)
    SWARM_TOKEN=""
    if [ x"$node" == x"$SWARM_SECOND_MANAGER_NODE" ];then
        SWARM_TOKEN=$SWARM_MANAGER_TOKEN
    else
        SWARM_TOKEN=$SWARM_WORKER_TOKEN
    fi
    docker swarm join \
        --token $SWARM_TOKEN \
        --advertise-addr $(docker-machine ip $node) \
        $SWARM_MANAGER_IP:2377
done

echo ">> The swarm cluster is up and running"

# tool label
eval $(docker-machine env $SWARM_MANAGER_NODE)
SWARM_NODE_ID_TOOL=docker node ls -f name=$SWARM_TOOL_NODE --format="{{.ID}}"
docker node update --label-add tool

# overlay network
eval $(docker-machine env $SWARM_MANAGER_NODE)
docker network remove camp
docker network create --driver overlay --attachable camp 
