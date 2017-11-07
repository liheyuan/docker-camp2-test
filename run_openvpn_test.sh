#!/bin/bash

# submit to tool node
NODE="node-1"
NODE_DNS="node-1"
VOLUME="/home/coder4/docker_data/openvpn"
#dns_ip=$(docker-machine ip $NODE_DNS)
dns_ip="8.8.8.8"
eval $(docker-machine env $NODE)
# run server (should call init_open_vpn_test.sh before) 
docker run \
    --network camp \
    -d \
    -v $VOLUME:/etc/openvpn \
    -p 1194:1194/udp \
    --cap-add=NET_ADMIN \
    -e DEBUG=1 \
    kylemanna/openvpn
