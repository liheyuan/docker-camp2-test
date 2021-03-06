# docker-camp2-test

## Build swarm env

### pre-request
 * virtualbox install 3 virtual machines (e.g. ubuntu 16.04)
 * rename vm to name vbox1~3
 * setup ssh key using key under keys folder
 * setup vm to sudo no need pass 
```
sudo sudoedit /etc/sudoer
# append bottom
username ALL = NOPASSWD : ALL
```

### create docker env with swarm
```
./mk_machines.sh
./init_swarm.sh
```

### init camp tool env
```
./init_tool.sh
```

### openvpn
 * after openvpn is setup, you can access docker container inner swarm network through your local network * setup & run
```
./config_openvpn_test.sh
./run_openvpn_test.sh
```
 * modify server config
```
sudo vim ./docker_data/openvpn/openvpn.conf
# comment this line
# push "block-outside-dns"
# add this line, x.x.x.x should be your dns server
push "dhcp-option DNS x.x.x.x"
```
 * get client config
'''
gen_openvpn_cert.sh username
'''
 * modify username.ovpn
```
# comment this line (will not use vpn default gw)
#redirect-gateway def1

# add this line, the swarm network route
route 10.7.0.0 255.255.0.0

# dns update
script-security 2
up /etc/openvpn/update-resolv-conf
down /etc/openvpn/update-resolv-conf

```
 * connect to server
 * remember openvpn client should not be your local computer, if you use virtulbox ,local pc will be gateway like 192.168.99.1
```
sudo openvpn --config ./username.ovpn
```
