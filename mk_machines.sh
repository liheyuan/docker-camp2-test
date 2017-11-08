#!/bin/bash

# create machines from existing virtual box machine

for node in `ls nodes`;do
    # get ip
    ip=$(cat nodes/$node/ip)
    if [ x"$ip" == x'' ];then
        echo "skip invalid ip for $node"
        continue 
    fi

    # create machines
    docker-machine create -d generic \
    --generic-ip-address $ip \
    --generic-ssh-user coder4 \
    --generic-ssh-key keys/id_rsa \
    $node
done

# copy cert
./scp_machine_certs.sh

# docker mirror
for node in `ls nodes`;do
    docker-machine scp ./daemon.json $node:/tmp/
    docker-machine ssh $node sudo cp -r /tmp/daemon.json /etc/docker/
done

# restart 
./restart_nodes.sh
