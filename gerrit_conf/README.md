# docker-gerrit-test

## First Time Usage
```
./create_vm.sh
./run_gerrit_docker.sh
# then first login ldap user will be admin
```

## Second Time Usage 
```
./start_vm.sh
./run_gerrit_docker.sh
```

## How to get access to gerrit
```

# gen ssh-keygen
ssh-keygen

# modify ~/.ssh/config
Host gerrit.coder4.com
    User lihy
    IdentityFile ~/.ssh/id_rsa
    Hostname gerrit.coder4.com
    Port 29418

# upload your key to gerrit User -> Settings -> SSH Public Keys

# Test
ssh -p 29418 lihy@gerrit.coder4.com
# If showing 'you have successfully connected over SSH' means success

# Clone project demo2
git clone ssh://lihy@gerrit.coder4.com:29418/demo2.git

# Init Gerrit
./initGerrit.sh

# Push review (after commit some change)
git push review

```

## Basic setting in gerrit
* Not Allow For Anonymous Users : Projects -> All Projects -> Access -> Read -> Block Anonymous Users
* Install Core Plugin
```
ssh -p 29418 lihy@gerrit.coder4.com gerrit plugin install 'jar:file:/var/gerrit/review_site/bin/gerrit.war!/WEB-INF/plugins/commit-message-length-validator.jar'
ssh -p 29418 lihy@gerrit.coder4.com gerrit plugin install 'jar:file:/var/gerrit/review_site/bin/gerrit.war!/WEB-INF/plugins/download-commands.jar'
ssh -p 29418 lihy@gerrit.coder4.com gerrit plugin install 'jar:file:/var/gerrit/review_site/bin/gerrit.war!/WEB-INF/plugins/replication.jar'
```
