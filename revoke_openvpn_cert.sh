#!/bin/bash

if [ x"$#" != x"1" ];then
    echo "Usage: $0 <username>"
    exit -1
fi

USERNAME="$1"
CA_ROOT="/etc/openvpn/pki"

TOOL_NODE="node-10"
VOLUME="/home/coder4/docker_data/openvpn"
eval $(docker-machine env $TOOL_NODE)

# revoke client cert for username 
docker run -v $VOLUME:/etc/openvpn --rm -it kylemanna/openvpn easyrsa revoke $USERNAME

# need delete file
FILE1="$CA_ROOT/issued/${USERNAME}.crt"
FILE2="$CA_ROOT/private/${USERNAME}.key"
FILE3="$CA_ROOT/reqs/${USERNAME}.req"
docker run -v $VOLUME:/etc/openvpn --rm -it kylemanna/openvpn rm -rf $FILE1 $FILE2 $FILE3
