# docker-camp2-test

## Usage 

### config on client side (for http insecure docker registry)
```
sudo vim /etc/docker/daemon.json
{"insecure-registries" : ["docker.coder4.com:5000"]}

sudo service docker restart
```

### config & run
 * before run, config user/pass 
```
./config_docker_registry.sh
```
 * run server
```
./create_docker_registry.sh
```

### puh to local registry
```
#!/bin/bash
DR_USER="test"
DR_PASS="pass"
DR_DOMAIN="docker.coder4.com:5000"
docker login -u $DR_USER -p $DR_PASS $DP_DOMAIN 
docker build -t alpine_test .
docker tag alpine_test $DR_DOMAIN/alpine_test:test_1.0
docker push $DR_DOMAIN/alpine_test
```

### query from registry
```
#!/bin/bash
DR_HTTP="http://docker.coder4.com:5000"

curl $DR_HTTP/v2/_catalog
curl $DR_HTTP/v2/alpine_test/tags/list
```

### pull from registry
