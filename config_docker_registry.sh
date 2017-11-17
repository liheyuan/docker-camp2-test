#!/bin/bash

NAME="docker_registry"
TOOL_NODE="node-10"
USERNAME="test"
PASSWORD="pass"
VOLUME="/home/coder4/docker_data/docker_registry"
VOLUME_AUTH="$VOLUME/auth"
AUTH_FILE=""htpasswd

# config dir
docker-machine ssh $TOOL_NODE "sudo mkdir -p $VOLUME_AUTH && sudo chmod -R 777 $VOLUME_AUTH"

# gen user/pass
htpasswd -Bbn $USERNAME $PASSWORD > $AUTH_FILE 
docker-machine scp $AUTH_FILE $TOOL_NODE:$VOLUME_AUTH
rm -rf $AUTH_FILE
