#!/bin/bash

if [ x"$#" != x"1" ];then
    echo "Usage: $0 <username>"
    exit -1
fi

USERNAME="$1"
OVPN_FILE="$USERNAME.ovpn"
CIPHER="AES-128-CBC"
SWARM_ROUTE_CMD="route 10.7.0.0 255.255.0.0"

TOOL_NODE="node-10"
VOLUME="/home/coder4/docker_data/openvpn"
eval $(docker-machine env $TOOL_NODE)
# generate client cert for username 
docker run -v $VOLUME:/etc/openvpn --rm -it kylemanna/openvpn easyrsa build-client-full $USERNAME nopass
docker run -v $VOLUME:/etc/openvpn --rm kylemanna/openvpn ovpn_getclient $USERNAME > $OVPN_FILE

# post process
sed -i 's/redirect-gateway.*$//' $OVPN_FILE

cat >> $OVPN_FILE <<EOF

# add this line, the swarm network route
$SWARM_ROUTE_CMD

# dns update
script-security 2
up /etc/openvpn/update-resolv-conf
down /etc/openvpn/update-resolv-conf

# security
cipher $CIPHER 

EOF
