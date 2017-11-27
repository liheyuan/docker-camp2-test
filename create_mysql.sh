#!/bin/bash

INFRA_NODE="node-1"
NAME="sbmvt-mysql"
VOLUME="/home/coder4/docker_data/mysql"
MYSQL_ROOT_PASS="hehehe"

# make sure volume valid 
docker-machine ssh $INFRA_NODE "sudo mkdir -p $VOLUME && sudo chmod -R 777 $VOLUME"

# submit to swarm master node
eval $(docker-machine env $INFRA_NODE)
docker ps -q -a --filter "name=$NAME" | xargs -I {} docker rm -f {}
docker run \
    --network camp \
    --hostname $NAME \
    --name $NAME \
    --volume "$VOLUME":/var/lib/mysql \
    --env MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASS \
    --detach \
    --restart always \
    mysql:5.7
