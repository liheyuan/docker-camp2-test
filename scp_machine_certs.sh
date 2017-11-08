#!/usr/bin/env bash

DST_NODE="node-1"
DST_HOME="/home/coder4/"

for node in `ls nodes`; do
    docker-machine ssh $DST_NODE mkdir -p $HOME/machines/$node
    docker-machine scp $HOME/.docker/machine/machines/$node/cert.pem $DST_NODE:~/machines/$node/ 
    docker-machine scp $HOME/.docker/machine/machines/$node/key.pem $DST_NODE:~/machines/$node/ 
done
