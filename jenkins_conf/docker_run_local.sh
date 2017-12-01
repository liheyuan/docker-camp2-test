#!/bin/bash
set -e

if [ x"$#" != x"2" ];then
    echo "Usage: $0 <project_name> <version>"
    exit -1
fi

PRIVATE_DOCKER_HUB="docker.coder4.com:5000"
DOCKER_IMAGE_NAME="$1"
PROJECT_VERSION="$2"
DOCKER_IMAGE_VERSION="build_$PROJECT_VERSION"
DOCKER_IMAGE_FULL_VERSION="$DOCKER_IMAGE_NAME:$DOCKER_IMAGE_VERSION"

EXPOSE_PARAM=""
if [ x"$EXPOSE_PORT" != x"" ];then
    EXPOSE_PARAM="-p $EXPOSE_PORT:$EXPOSE_PORT"
fi

# remove and run
docker ps -q -a --filter "name=$DOCKER_IMAGE_NAME" | xargs -I {} docker rm -f {}
docker run \
    --network camp \
    --name $DOCKER_IMAGE_NAME \
    --hostname $DOCKER_IMAGE_NAME \
    --detach \
    docker.coder4.com:5000/$DOCKER_IMAGE_FULL_VERSION
