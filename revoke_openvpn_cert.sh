#!/bin/bash

if [ x"$#" != x"1" ];then
    echo "Usage: $0 <username>"
    exit -1
fi

USERNAME="$1"

TOOL_NODE="node-10"
VOLUME="/home/coder4/docker_data/openvpn"
eval $(docker-machine env $TOOL_NODE)

# revoke client cert by username
docker run -v $VOLUME:/etc/openvpn --rm -it kylemanna/openvpn ovpn_revokeclient $USERNAME remove

