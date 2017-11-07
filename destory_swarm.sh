#!/usr/bin/env bash

for node in `ls nodes`; do
    eval $(docker-machine env $node)
    docker swarm leave --force
done


