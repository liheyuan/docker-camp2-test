#!/bin/bash

INFRA_NODE="node-1"
NAME="sbmvt-rabbitmq"
VOLUME="/home/coder4/docker_data/rabbitmq"
RABBIT_VHOST="sbmvt"
RABBIT_USER="sbmvt"
RABBIT_PASS="hehehe"

# make sure volume valid 
docker-machine ssh $INFRA_NODE "sudo mkdir -p $VOLUME && sudo chmod -R 777 $VOLUME"

# submit to swarm master node
eval $(docker-machine env $INFRA_NODE)
docker ps -q -a --filter "name=$NAME" | xargs -I {} docker rm -f {}
docker run \
    --network camp \
    --hostname $NAME \
    --name $NAME \
    --volume "$VOLUME_DATA":/var/lib/rabbitmq \
    --env RABBITMQ_DEFAULT_VHOST=$RABBIT_VHOST \
    --env RABBITMQ_DEFAULT_USER=$RABBIT_USER \
    --env RABBITMQ_DEFAULT_PASS=$RABBIT_PASS \
    --detach \
    --restart always \
    rabbitmq:3-management-alpine
