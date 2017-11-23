#!/bin/bash

# submit to tool node
NODE_TOOL="node-10"
NODE_DNS="node-10"
NAME="sbmvt_openvpn"
VOLUME="/home/coder4/docker_data/openvpn"
dns_ip=$(docker-machine ip $NODE_DNS)

# stop & run server (should call init_open_vpn_test.sh before) 
eval $(docker-machine env $NODE_TOOL)
docker ps -q -a --filter "name=$NAME" | xargs -I {} docker rm -f {}
docker run \
    --name $NAME \
    --network camp \
    --dns $dns_ip \
    -d \
    -v $VOLUME:/etc/openvpn \
    -p 1194:1194/udp \
    --cap-add=NET_ADMIN \
    --restart always \
    kylemanna/openvpn
