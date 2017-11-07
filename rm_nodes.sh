#!/usr/bin/env bash

for node in `ls nodes`;do
    docker-machine rm $node 
done


