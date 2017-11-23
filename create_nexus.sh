#!/bin/bash

TOOL_NODE="node-10"
NAME="sbmvt_nexus"
VOLUME="/home/coder4/docker_data/nexus"

# make sure volume valid 
docker-machine ssh $TOOL_NODE "sudo mkdir -p $VOLUME && sudo chmod -R 777 $VOLUME"

# submit to swarm master node
eval $(docker-machine env $TOOL_NODE)
docker ps -q -a --filter "name=$NAME" | xargs -I {} docker rm -f {}
docker run \
    --name $NAME \
    -p 9004:8081 \
    --volume "$VOLUME":/sonatype-work \
    --restart always \
    -d sonatype/nexus
