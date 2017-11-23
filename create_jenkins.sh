#!/bin/bash

TOOL_NODE="node-10"
NAME="sbmvt_jenkins"
VOLUME="/home/coder4/docker_data/jenkins"

# make sure volume valid 
docker-machine ssh $TOOL_NODE "sudo mkdir -p $VOLUME && sudo chmod -R 777 $VOLUME"

# submit to swarm master node
eval $(docker-machine env $TOOL_NODE)
docker ps -q -a --filter "name=$NAME" | xargs -I {} docker rm -f {}
docker run \
    --name $NAME \
    -v $VOLUME:/var/jenkins_home \
    -p 9001:8080 \
    -p 50000:50000 \
    --detach \
    --restart always \
    jenkins/jenkins:2.76-alpine 
