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

### clean registry
 * make sure allow delete
```
# by config
/etc/docker/registry/config.yml

delete:
    enabled: true

# or docker env
--env REGISTRY_STORAGE_DELETE_ENABLED=true

```
 * use project https://github.com/burnettk/delete-docker-registry-image
```
sudo apt-get install python python-pip
sudo pip install requests
curl https://raw.githubusercontent.com/burnettk/delete-docker-registry-image/master/delete_docker_registry_image.py | sudo tee /usr/local/bin/delete_docker_registry_image >/dev/null
sudo chmod a+x /usr/local/bin/delete_docker_registry_image
curl https://raw.githubusercontent.com/burnettk/delete-docker-registry-image/master/clean_old_versions.py | sudo tee /usr/local/bin/clean_old_versions >/dev/null
sudo chmod a+x /usr/local/bin/clean_old_versions
```
 * delete
```
export REGISTRY_DATA_DIR=/home/coder4/docker_data/docker_registry/registry/docker/registry/v2

# dryRun delete tag
delete_docker_registry_image --image eureka-server:build_7 --dry-run
# need shutdown registry
delete_docker_registry_image --image eureka-server:build_7

# dryRun delete whole image
delete_docker_registry_image --image eureka-server --dry-run
# need shutdown registry
delete_docker_registry_image --image eureka-server
```
 * clean old, keep latest
```
# clean all image , keep last 3
clean_old_versions. --image '^.*' -l 3 --registry-url http://docker.coder4.com:5000/
```

