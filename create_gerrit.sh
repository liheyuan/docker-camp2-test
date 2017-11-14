#!/bin/bash

TOOL_NODE="node-10"
NAME="sbmvt_gerrit"
VOLUME="/home/coder4/docker_data/gerrit"
# config
WEB_URL='http://gerrit.coder4.com'
# ldap config
LDAP_IP=$(docker-machine ip $TOOL_NODE)
LDAP_ACCOUNT_DN="dc=coder4,dc=com"
LDAP_ACCOUNT_PATTERN='(cn=${username})'
LDAP_SSHUSER_PATTERN='${cn}'
LDAP_FULLNAME_PATTERN='${sn}'
LDAP_QUERY_USERNAME='cn=admin,dc=coder4,dc=com'
LDAP_QUERY_PASSWORD='admin'

# make sure volume valid 
docker-machine ssh $TOOL_NODE "sudo mkdir -p $VOLUME && sudo chmod -R 777 $VOLUME"

# submit to swarm master node
eval $(docker-machine env $TOOL_NODE)
docker ps -q --filter "name=$NAME" | xargs -I {} docker rm -f {}
docker run \
    --name $NAME \
    -v "$VOLUME":/var/gerrit/review_site \
    -p 9002:8080 \
    -p 29418:29418 \
    -e AUTH_TYPE=LDAP \
    -e LDAP_SERVER=ldap://$LDAP_IP \
    -e LDAP_ACCOUNTBASE=$LDAP_ACCOUNT_DN \
    -e LDAP_ACCOUNTPATTERN=$LDAP_ACCOUNT_PATTERN \
    -e LDAP_ACCOUNTSSHUSERNAME=$LDAP_SSHUSER_PATTERN \
    -e LDAP_ACCOUNTFULLNAME=$LDAP_FULLNAME_PATTERN \
    -e LDAP_USERNAME=$LDAP_QUERY_USERNAME \
    -e LDAP_PASSWORD=$LDAP_QUERY_PASSWORD \
    -e WEBURL=$WEB_URL \
    --detach \
    --rm \
    -d openfrontier/gerrit:2.14.5.1
