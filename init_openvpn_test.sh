#!/bin/bash
NODE="node-1"
NODE_DNS="node-1"
VOLUME="/home/coder4/docker_data/openvpn"
dns_ip=$(docker-machine ip $NODE_DNS)
vpn_ip="vpn.coder4.com"
eval $(docker-machine env $NODE)
# init for first time only
docker-machine ssh $NODE rm -rf $VOLUME
docker-machine ssh $NODE mkdir -p $VOLUME 
docker run -v $VOLUME:/etc/openvpn --rm kylemanna/openvpn ovpn_genconfig -u udp://$vpn_ip
docker run -v $VOLUME:/etc/openvpn --rm -it kylemanna/openvpn ovpn_initpki
