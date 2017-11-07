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

#for i in 1 2 3 10; do
#    docker-machine create -d generic \
#    --generic-ip-address 1024 \
#    --generic-ssh-key 4096 \
#    --virtualbox-hostonly-nicpromisc allow-all \
#    node-$i
#done

# copy certs to node-10
#./scp_machine_certs.sh

# docker mirror
#for i in 1 2 3 10;do
#    docker-machine scp ./daemon.json node-$i:/tmp/
#    docker-machine ssh node-$i sudo cp -r /tmp/daemon.json /etc/docker/
#done

# stop & start
#./stop_nodes.sh
#./start_nodes.sh
