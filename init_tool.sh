#!/bin/bash
# dns related
./create_swarmdict.sh
./create_dns.sh
# vpn
./create_openvpn_test.sh
# ldap
./create_ldap.sh
# jenkins
./create_jenkins.sh
# gerrit 
./create_gerrit.sh
# kanboard
./create_kanboard.sh
# nginx
./create_nginx.sh
