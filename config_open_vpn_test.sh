#!/bin/bash
TOOL_NODE="node-10"
DNS_NODE="node-1"
VOLUME="/home/coder4/docker_data/openvpn"
dns_ip=$(docker-machine ip $DNS_NODE)
vpn_ip="vpn.coder4.com"
eval $(docker-machine env $TOOL_NODE)
# init for first time only
docker-machine ssh $TOOL_NODE rm -rf $VOLUME
docker-machine ssh $TOOL_NODE mkdir -p $VOLUME 
docker run -v $VOLUME:/etc/openvpn --rm kylemanna/openvpn ovpn_genconfig -u udp://$vpn_ip
docker run -v $VOLUME:/etc/openvpn --rm -it kylemanna/openvpn ovpn_initpki 
