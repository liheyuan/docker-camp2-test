#!/bin/bash
set -x

if [ x"$#" != x"4" ];then
    echo "Usage: $0 <project_name> <version> <jar_filename> <expose_port>"
    exit -1
fi

PRIVATE_DOCKER_HUB="docker.coder4.com:5000"
DOCKER_IMAGE_NAME="$1"
PROJECT_VERSION="$2"
JAR_FILE="$3"
EXPOSE_PORT="$4"
DOCKER_IMAGE_VERSION="build_$PROJECT_VERSION"
DOCKER_IMAGE_FULL_VERSION="$DOCKER_IMAGE_NAME:$DOCKER_IMAGE_VERSION"

EXPOSE_CMD=""
if [ x"$EXPOSE_PORT" != x"" ];then
    EXPOSE_CMD="EXPOSE $EXPOSE_PORT"
fi

# Make Docker file
cat > Dockerfile <<EOF
FROM java:8-jdk-alpine

VOLUME /tmp /app
WORKDIR /app
COPY ${JAR_FILE} /app
$EXPOSE_CMD
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app/${JAR_FILE}"]
EOF

# docker build
docker build -t $DOCKER_IMAGE_NAME .
docker tag $DOCKER_IMAGE_NAME $PRIVATE_DOCKER_HUB/$DOCKER_IMAGE_FULL_VERSION
docker push $PRIVATE_DOCKER_HUB/$DOCKER_IMAGE_FULL_VERSION


