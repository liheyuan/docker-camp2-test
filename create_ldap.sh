#!/bin/bash

TOOL_NODE="node-10"
NAME="sbmvt_ldap"
VOLUME="/home/coder4/docker_data/ldap"
VOLUME_DATA="$VOLUME/data"
VOLUME_CONFIG="$VOLUME/config"
DOMAIN="coder4.com"

# make sure volume valid 
docker-machine ssh $TOOL_NODE "sudo mkdir -p $VOLUME_DATA && sudo chmod -R 777 $VOLUME_DATA"
docker-machine ssh $TOOL_NODE "sudo mkdir -p $VOLUME_CONFIG && sudo chmod -R 777 $VOLUME_CONFIG"

# submit to swarm master node
eval $(docker-machine env $TOOL_NODE)
docker ps -q --filter "name=$NAME" | xargs -I {} docker rm -f {}
docker run \
    --name $NAME \
    -p 389:389 \
    -p 636:636 \
    --volume "$VOLUME_DATA":/var/lib/ldap \
    --volume "$VOLUME_CONFIG":/etc/ldap/slapd.d \
    --env LDAP_TLS=false \
    --env LDAP_DOMAIN=$DOMAIN \
    --detach \
    --rm \
    osixia/openldap:1.1.9
