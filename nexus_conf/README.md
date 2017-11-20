# docker-nexus-test

## How to run

### first time
```
./create_vm.sh
./run_nexus_docker.sh
```

### after reboot vm
```
./run_nexus_docker.sh
```

### access
http://ip/nexus

## Usage

### default admin
 * admin/admin123

### ldap config
* Configure the ldap connection
 ![step 1](/1.png)
* Configure the user role
 ![step 2](/2.png)
* Configure the realm auth type  
 ![step 3](/3.png)
